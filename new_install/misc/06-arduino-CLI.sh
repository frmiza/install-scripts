#!/bin/bash
#pip install pyserial
#curl --create-dirs -O --output-dir ~/Programs/Arduino-CLI https://raw.githubusercontent.com/arduino/arduino-cli/master/install.sh 

arduino_cli_path='Programs/Arduino-CLI'

sudo chmod +x ~/$arduino_cli_path/install.sh

pushd ~/$arduino_cli_path/
  sh ~/$arduino_cli_path/install.sh
popd

sudo cp ~/.local/bin/poetry /bin 

##install my boards
#cp ~/.config/arduino-esp-templates/arduino-cli.yaml ~/.arduino15/
pushd ~/$arduino_cli_path/
  ./bin/arduino-cli core update-index --config-file ~/.arduino15/arduino-cli.yaml
  ./bin/arduino-cli core install arduino:avr
  ./bin/arduino-cli core install esp32:esp32
popd
