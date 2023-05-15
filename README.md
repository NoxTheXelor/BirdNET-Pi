<h1 align="center"><a href="https://github.com/mcguirepr89/BatNET-Pi/blob/main/LICENSE">Review the license!!</a></h1>
<h1 align="center">You may not use BatNET-Pi to develop a commercial product!!!!</h1>
<h1 align="center">
  BatNET-Pi
</h1>
<p align="center">
A realtime acoustic bat classification system for the Raspberry Pi 4B, 3B+, and 0W2
</p>
<p align="center">
  <img src="https://user-images.githubusercontent.com/60325264/140656397-bf76bad4-f110-467c-897d-992ff0f96476.png" />
</p>
<p align="center">
Icon made by <a href="https://www.freepik.com" title="Freepik">Freepik</a> from <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a>
</p>

## Introduction
BatNET-Pi is built on the [TFLite version of BatNET](https://github.com/kahst/BatNET-Lite) by [**@kahst**](https://github.com/kahst) <a href="https://creativecommons.org/licenses/by-nc-sa/4.0/"><img src="https://img.shields.io/badge/License-CC%20BY--NC--SA%204.0-lightgrey.svg"></a> using [pre-built TFLite binaries](https://github.com/PINTO0309/TensorflowLite-bin) by [**@PINTO0309**](https://github.com/PINTO0309) . It is able to recognize bat sounds from a USB microphone or sound card in realtime and share its data with the rest of the world.

Check out bats from around the world
- [BatWeather](https://app.batweather.com)<br>
- [Johannesburg, South Africa](https://joburg.batnetpi.com)<br>
- [Öringe, Tyresö, Sweden](https://tyreso.batnetpi.com)<br>
- [Murrysville, Pennsylvania, United States](https://murrysvillepa.batnetpi.com)
- [Berowra, New South Wales, Australia](https://berowra.batnetpi.com)
- [Fairview, Tennessee, United States](https://fairviewtennessee.batnetpi.com)
- [Dundas, Ontario, Canada](https://dundasontario.batnetpi.com)
- [Bungendore, New South Wales, Australia](https://bungendorensw.batnetpi.com)
- [Rivers Bend, Ohio, United States](https://riversbendoh.batnetpi.com)
- [Vienna, Virginia, United States](https://viennava.batnetpi.com)
- [Grevenbroich, Elsen, Germany](https://grevenbroich-elsen.batnetpi.com)
- [Occoquan, Virginia, United States](https://occoquanva.batnetpi.com)
- [Westmoreland, Pennsylvania, United States](https://westmorelandbnc.batnetpi.com)
- [Latrobe, Pennsylvania, United States](https://stvincentcollege.batnetpi.com)
- [Cambridge, Massachusetts, United States](https://cambridgema.batnetpi.com)

[Share your installation!!](https://github.com/mcguirepr89/BatNET-Pi/wiki/Sharing-Your-BatNET-Pi)
Have a public installation not in the list above? Let me know!! I'd be happy to add it.

Currently listening in these countries . . . that I know of . . .
- The United States
- Germany
- South Africa
- France
- Austria
- Sweden
- Scotland
- Norway
- England
- Italy
- Finland
- Australia
- Canada
- Switzerland
- Romania
- Spain
- New Zealand
- Russia
- Croatia
- Belgium
- Israel
- Ireland
- Denmark
- Costa Rica
- The Philippines
- Hungary

## Features
* 24/7 recording and BatNET-Lite analysis
* Automatic extraction of detected data (creating audio clips of detected bat sounds)
* Spectrograms available for all extractions
* Live audio stream & spectrogram
* [BatWeather](https://app.batweather.com) integration -- you can request a BatWeather ID from BatNET-Pi's "Tools" > "Settings" page
* Web interface access to all data and logs provided by [Caddy](https://caddyserver.com)
* [GoTTY](https://github.com/yudai/gotty) Web Terminal
* [Tiny File Manager](https://tinyfilemanager.github.io/)
* FTP server included
* SQLite3 Database
* [Adminer](https://www.adminer.org/) database maintenance
* [phpSysInfo](https://github.com/phpsysinfo/phpsysinfo)
* [Apprise Notifications](https://github.com/caronc/apprise) supporting 70+ notification platforms
* Localization supported

## Requirements
* A Raspberry Pi 4B, Raspberry Pi 3B+, or Raspberry Pi 0W2 (The 3B+ and 0W2 must run on RaspiOS-ARM64-**Lite**)
* An SD Card with the **_64-bit version of RaspiOS_** installed (please use Bullseye) -- Lite is recommended, but the installation works on RaspiOS-ARM64-Full as well. Downloads available within the [Raspberry Pi Imager](https://www.raspberrypi.com/software/).
* A USB Microphone or Sound Card

## Installation
**IMPORTANT:** Not yet tested on [the newest RaspiOS image](https://downloads.raspberrypi.org/raspios_lite_arm64/images/raspios_lite_arm64-2022-09-07/) 

[A comprehensive installation guide is available here](https://github.com/mcguirepr89/BatNET-Pi/wiki/Installation-Guide).

Please note that installing BatNET-Pi on top of other servers is not supported. If this is something that you require, please open a discussion for your idea and inquire about how to contribute to development.

[Raspberry Pi 3B[+] and 0W2 installation guide available here](https://github.com/mcguirepr89/BatNET-Pi/wiki/RPi0W2-Installation-Guide)

The system can be installed with:
```
curl -s https://raw.githubusercontent.com/mcguirepr89/BatNET-Pi/main/newinstaller.sh | bash
```
The installer takes care of any and all necessary updates, so you can run that as the very first command upon the first boot, if you'd like.

The installation creates a log in `$HOME/installation-$(date "+%F").txt`.
## Access
The BatNET-Pi can be accessed from any web browser on the same network:
- http://batnetpi.local
- Default Basic Authentication Username: batnet
- Password is empty by default. Set this in "Tools" > "Settings" > "Advanced Settings"

Please take a look at the [wiki](https://github.com/mcguirepr89/BatNET-Pi/wiki) and [discussions](https://github.com/mcguirepr89/BatNET-Pi/discussions) for information on
- [making your installation public](https://github.com/mcguirepr89/BatNET-Pi/wiki/Sharing-Your-BatNET-Pi)
- [backing up and restoring your database](https://github.com/mcguirepr89/BatNET-Pi/wiki/Backup-and-Restore-the-Database)
- [adjusting your sound card settings](https://github.com/mcguirepr89/BatNET-Pi/wiki/Adjusting-your-sound-card)
- [suggested USB microphones](https://github.com/mcguirepr89/BatNET-Pi/discussions/39)
- [building your own microphone](https://github.com/DD4WH/SASS/wiki/Stereo--(Mono)-recording-low-noise-low-cost-system)
- [privacy concerns and options](https://github.com/mcguirepr89/BatNET-Pi/discussions/166)
- [beta testing](https://github.com/mcguirepr89/BatNET-Pi/discussions/11)
- [and more!](https://github.com/mcguirepr89/BatNET-Pi/discussions)


## Updating 

Use the web interface and go to "Tools" > "System Controls" > "Update." If you encounter any issues with that, or suspect that the update did not work for some reason, please save its output and post it in an issue where we can help.

## Uninstallation
```
/usr/local/bin/uninstall.sh && cd ~ && rm -drf BatNET-Pi
```

## Troubleshooting and Ideas
*Hint: A lot of weird problems can be solved by simply restarting the core services. Do this from the web interface "Tools" > "Services" > "Restart Core Services"
Having trouble or have an idea? *Submit an issue for trouble* and a *discussion for ideas*. Please do *not* submit an issue as a discussion -- the issue tracker solicits information that is needed for anyone to help -- discussions are *not for issues*.

## Sharing
Please join a Discussion!! and please join [BatWeather!!](https://app.batweather.com)
I hope that if you find BatNET-Pi has been worth your time, you will share your setup, results, customizations, etc. [HERE](https://github.com/mcguirepr89/BatNET-Pi/discussions/69) and will consider [making your installation public](https://github.com/mcguirepr89/BatNET-Pi/wiki/Sharing-Your-BatNET-Pi).

## Cool Links

- [Marie Lelouche's <i>Out of Spaces</i>](https://www.lestanneries.fr/exposition/marie-lelouche-out-of-spaces/) using BatNET-Pi in post-sculpture VR! [Press Kit](https://github.com/mcguirepr89/BatNET-Pi-assets/blob/main/dp_out_of_spaces_marie_lelouche_digital_05_01_22.pdf)
- [Research on noded BatNET-Pi networks for farming](https://github.com/mcguirepr89/BatNET-Pi-assets/blob/main/G23_Report_ModelBasedSysEngineering_FarmMarkBatDetector_V1__Copy_.pdf)
- [PixCams Build Guide](https://pixcams.com/building-a-batnet-pi-real-time-acoustic-bat-id-station/)
- <ins>[Core-Electronics](https://core-electronics.com.au/projects/bat-calls-raspberry-pi)</ins> Build Article
- [RaspberryPi.com Blog Post](https://www.raspberrypi.com/news/classify-bats-acoustically-with-batnet-pi/)
- [MagPi Issue 119 Showcase Article](https://magpi.raspberrypi.com/issues/119/pdf)


### Internationalization:
The bat names are in English by default, but other localized versions are available thanks to the wonderful efforts of [@patlevin](https://github.com/patlevin). Use the web interface's "Tools" > "Settings" and select your "Database Language" to have the detections in your language.

Current database languages include the list below:
| Language | Missing Species out of 6,362 | Missing labels (%) |
| -------- | ------- | ------ |
| Afrikaans | 5774 | 90.76% |
| Catalan | 544 | 8.55% |
| Chinese | 264 | 4.15% |
| Croatian | 370 | 5.82% |
| Czech | 683 | 10.74% |
| Danish | 460 | 7.23% |
| Dutch | 264 | 4.15% |
| Estonian | 3171 | 49.84% |
| Finnish | 518 | 8.14% |
| French | 264 | 4.15% |
| German | 264 | 4.15% |
| Hungarian | 2688 | 42.25% |
| Icelandic | 5588 | 87.83% |
| Indonesian | 5550 | 87.24% |
| Italian | 524 | 8.24% |
| Japanese | 640 | 10.06% |
| Latvian | 4821 | 75.78% |
| Lithuanian | 597 | 9.38% |
| Norwegian | 325 | 5.11% |
| Polish | 265 | 4.17% |
| Portuguese | 2742 | 43.10% |
| Russian | 808 | 12.70% |
| Slovak | 264 | 4.15% |
| Slovenian | 5532 | 86.95% |
| Spanish | 348 | 5.47% |
| Swedish | 264 | 4.15% |
| Thai | 5580 | 87.71% |
| Ukrainian | 646 | 10.15% |

## :thinking:
Are you a lucky ducky with an extra Raspberry Pi 4B lying around? [Here's an idea!](https://foldingathome.org/alternative-downloads)
