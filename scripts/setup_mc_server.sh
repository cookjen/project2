#!/bin/bash

sudo yum install -y java-21-amazon-corretto-headless
sudo adduser minecraft
sudo mkdir /opt/minecraft/
sudo mkdir /opt/minecraft/server/
cd /opt/minecraft/server
sudo wget https://piston-data.mojang.com/v1/objects/e6ec2f64e6080b9b5d9b471b291c33cc7f509733/server.jar
sudo java -Xmx1300M -Xms1300M -jar server.jar nogui
sleep 40
sudo sed -i 's/false/TRUE/g' eula.txt
sudo chown -R minecraft:minecraft /opt/minecraft/
