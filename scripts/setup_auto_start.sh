#!/bin/bash

cd /etc/systemd/system/
echo -e "[Unit]\nDescription=Minecraft Server on start up\nAfter=network.target\n\n[Service]\nUser=minecraft\nWorkingDirectory=/opt/minecraft/server\nExecStart=/usr/bin/java -Xmx1300M -Xms1300M -jar server.jar nogui\nRestart=on-failure\n\n[Install]\nWantedBy=multi-user.target" >> minecraft.service
sudo systemctl daemon-reload
sudo systemctl enable minecraft.service
sudo systemctl start minecraft.service
