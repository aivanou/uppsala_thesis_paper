#!/bin/bash

#FDS-Team: Pipelight Project
#Tomasz Zackiewicz, Pipelight.sh

 
#update the checksum of Unity3D Web Player
sudo pipelight-plugin --update

#for Firefox, clear the plugin cache
sudo pipelight-plugin --create-mozilla-plugins

#enabling Unity3D Web Player
sudo pipelight-plugin --enable unity3d
