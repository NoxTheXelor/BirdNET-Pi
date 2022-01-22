#!/usr/bin/env bash
# Simple new installer
HOME=/home/pi
USER=pi
branch=forms
sudo apt update
if ! which git &> /dev/null;then
  sudo apt -y install git
fi
git clone -b ${branch} https://github.com/mcguirepr89/BirdNET-Pi.git ${HOME}/BirdNET-Pi
cp ${HOME}/BirdNET-Pi/birdnet.conf-defaults ${HOME}/BirdNET-Pi/birdnet.conf
sudo -u ${USER} ${HOME}/BirdNET-Pi/scripts/install_birdnet.sh
