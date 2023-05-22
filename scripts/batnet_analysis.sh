#!/usr/bin/env bash
# Runs BatNET-Lite
#set -x
source /etc/batnet/batnet.conf
# Document this run's batnet.conf settings
# Make a temporary file to compare the current batnet.conf with
# the batnet.conf as it was the last time this script was called
my_dir=$HOME/BatNET-Pi/scripts
if [ -z ${THIS_RUN} ];then THIS_RUN=$my_dir/thisrun.txt;fi
[ -f ${THIS_RUN} ] || touch ${THIS_RUN} && chmod g+w ${THIS_RUN}
if [ -z ${LAST_RUN} ];then LAST_RUN=$my_dir/lastrun.txt;fi
[ -z ${LATITUDE} ] && echo "LATITUDE not set, exiting 1" && exit 1
[ -z ${LONGITUDE} ] && echo "LONGITUDE not set, exiting 1" && exit 1
make_thisrun() {
  sleep .4
  awk '!/#/ && !/^$/ {print}' /etc/batnet/batnet.conf \
    > >(tee "${THIS_RUN}")
  sleep .5
}
make_thisrun &> /dev/null
if ! diff ${LAST_RUN} ${THIS_RUN};then
  echo "The batnet.conf file has changed"
  if grep REC <(diff $LAST_RUN $THIS_RUN);then
    echo "Recording element changed -- restarting 'batnet_recording.service'"
    sudo systemctl stop batnet_recording.service
    sudo rm -rf ${RECS_DIR}/$(date +%B-%Y/%d-%A)/*
    sudo systemctl start batnet_recording.service
  fi
  cat ${THIS_RUN} > ${LAST_RUN}
fi

INCLUDE_LIST="$HOME/BatNET-Pi/include_species_list.txt"
EXCLUDE_LIST="$HOME/BatNET-Pi/exclude_species_list.txt"
if [ ! -f ${INCLUDE_LIST} ];then
  touch ${INCLUDE_LIST} &&
    chmod g+rw ${INCLUDE_LIST}
fi
if [ ! -f ${EXCLUDE_LIST} ];then
  touch ${EXCLUDE_LIST} &&
    chmod g+rw ${EXCLUDE_LIST}
fi
if [ "$(du ${INCLUDE_LIST} | awk '{print $1}')" -lt 4 ];then
	INCLUDE_LIST=null
fi
if [ "$(du ${EXCLUDE_LIST} | awk '{print $1}')" -lt 4 ];then
	EXCLUDE_LIST=null
fi

# Create an array of the audio files
# Takes one argument:
#   - {DIRECTORY}
get_files() {
  files=($( find ${1} -maxdepth 1 -name '*wav' ! -size 0\
  | sort --version-sort \
  | head -n 5 \
  | awk -F "/" '{print $NF}' ))
  [ -n "${files[1]}" ] && echo "Files loaded"
  echo "$files"
}

# Move all files that have been analyzed already into newly created "Analyzed"
# directory
# Takes one argument:
#   - {DIRECTORY}
move_analyzed() {
  # daily_result contains wave file if both conditions are met
  # 1) bat detected in wav file
  # 2) identification conf above threshold
  # otherwise the file will be delete by server.py
  for i in "${files[@]}";do
    if [ -f "${1}/${i}" ];then
      if grep -q ${i} "${1}/daily_result.csv";then #if name of wav file is in daily result
        if [ ! -d "${1}-Analyzed" ];then
          mkdir -p "${1}-Analyzed" && echo "'Analyzed' directory created"
        fi
        mv "${1}/${i}" "${1}-Analyzed/" #move wav file to Analyzed directory
        echo "moving ${i}"
      fi
    fi
  done
}

# Run BatNET-Lite on the WAVE files from get_files()
# Uses one argument:
#   - {DIRECTORY}
run_analysis() {
  PYTHON_VIRTUAL_ENV="$HOME/BatNET-Pi/batnet/bin/python3"
  DIR="$HOME/BatNET-Pi/scripts"
  sleep .5
  
  # building limit running process
  max_processes=1
  semaphore=$(mktemp -u)

  mkfifo "$semaphore"
  exec 3<>"$semaphore"

  rm "$semaphore"

  for((i=1;i<=max_processes;i++));do
    echo >&3
  done


  ### TESTING NEW WEEK CALCULATION
  WEEK_OF_YEAR="$(echo "($(date +%m)-1) * 4" | bc -l)"
  DAY_OF_MONTH="$(date +%d)"
  if [ ${DAY_OF_MONTH} -le 7 ];then
    WEEK="$(echo "${WEEK_OF_YEAR} + 1" |bc -l)"
  elif [ ${DAY_OF_MONTH} -le 14 ];then
    WEEK="$(echo "${WEEK_OF_YEAR} + 2" |bc -l)"
  elif [ ${DAY_OF_MONTH} -le 21 ];then
    WEEK="$(echo "${WEEK_OF_YEAR} + 3" |bc -l)"
  elif [ ${DAY_OF_MONTH} -ge 22 ];then
    WEEK="$(echo "${WEEK_OF_YEAR} + 4" |bc -l)"
  fi

  for i in "${files[@]}";do
    [ ! -f ${1}/${i} ] && continue
    echo "${1}/${i}" > $HOME/BatNET-Pi/analyzing_now.txt
    [ -z ${RECORDING_LENGTH} ] && RECORDING_LENGTH=5
    echo "RECORDING_LENGTH set to ${RECORDING_LENGTH}"
    until [ -z "$(lsof -t ${1}/${i})" ];do
      sleep 2
    done

    if ! grep 5050 <(netstat -tulpn 2>&1) &> /dev/null 2>&1;then
      echo "Waiting for socket"
      until grep 5050 <(netstat -tulpn 2>&1) &> /dev/null 2>&1;do
        sleep 1
      done
    fi
    # prepare optional parameters for analyze.py
    if [ -f ${INCLUDE_LIST} ]; then
      INCLUDEPARAM="--include_list ${INCLUDE_LIST}"
    else
      INCLUDEPARAM=""
    fi
    if [ -f ${EXCLUDE_LIST} ]; then
      EXCLUDEPARAM="--exclude_list ${EXCLUDE_LIST}"
    else
      EXCLUDEPARAM=""
    fi
    if [ ! -z $BATWEATHER_ID ]; then
      BATWEATHER_ID_PARAM="--batweather_id ${BATWEATHER_ID}"
      BATWEATHER_ID_LOG="--batweather_id \"IN_USE\""
    else
      BATWEATHER_ID_PARAM=""
      BATWEATHER_ID_LOG=""
    fi
    echo $PYTHON_VIRTUAL_ENV "$DIR/analyze.py" \
--i "${1}/${i}" \
--o "${1}/${i}.csv" \
--lat $(echo "${LATITUDE}" | awk '{print int($1+0.5)}').XX \
--lon $(echo "${LONGITUDE}" | awk '{print int($1+0.5)}').XX \
--week "${WEEK}" \
--overlap "${OVERLAP}" \
--sensitivity "${SENSITIVITY}" \
--min_conf "${CONFIDENCE}" \
--nbr_thread "${max_processes}" \
${INCLUDEPARAM} \
${EXCLUDEPARAM} \
${BATWEATHER_ID_LOG}

    read -u 3

    $PYTHON_VIRTUAL_ENV $DIR/analyze.py \
      --i "${1}/${i}" \
      --o "${1}/${i}.csv" \
      --lat "${LATITUDE}" \
      --lon "${LONGITUDE}" \
      --week "${WEEK}" \
      --overlap "${OVERLAP}" \
      --sensitivity "${SENSITIVITY}" \
      --min_conf "${CONFIDENCE}" \
      --nbr_thread "${max_processes}" \
      ${INCLUDEPARAM} \
      ${EXCLUDEPARAM} \
      ${BATWEATHER_ID_PARAM}
    echo >&3
    if [ ! -z $HEARTBEAT_URL ]; then
      echo "Performing Heartbeat"
      IP=`curl -s ${HEARTBEAT_URL}`
      echo "Heartbeat: $IP"
    fi
  done
}

# The three main functions
# Takes one argument:
#   - {DIRECTORY}
run_batnet() {
  get_files "${1}"
  move_analyzed "${1}"
  run_analysis "${1}"
}

until grep 5050 <(netstat -tulpn 2>&1) &> /dev/null 2>&1;do
  sleep 1
done

if [ $(find ${RECS_DIR}/StreamData -maxdepth 1 -name '*wav' 2>/dev/null| wc -l) -gt 0 ];then
  find $RECS_DIR -maxdepth 1 -name '*wav' -type f -size 0 -delete
  run_batnet "${RECS_DIR}/StreamData"
fi

YESTERDAY="$RECS_DIR/$(date --date="yesterday" "+%B-%Y/%d-%A")"
TODAY="$RECS_DIR/$(date "+%B-%Y/%d-%A")"
if [ $(find ${YESTERDAY} -name '*wav' 2>/dev/null | wc -l) -gt 0 ];then
  find $YESTERDAY -name '*wav' -type f -size 0 -delete
  run_batnet "${YESTERDAY}"
elif [ $(find ${TODAY} -name '*wav' | wc -l) -gt 0 ];then
  find $TODAY -name '*wav' -type f -size 0 -delete
  run_batnet "${TODAY}"
fi
