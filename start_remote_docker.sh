#!/bin/bash

# Paramètres
remoteUser="Lionel"    
remoteServer="192.168.0.47"  
remoteFilePath="C:\\Users\\Public\\docker_service\\LayoutMlgit" 
localFilePath="auto_launch.ps1"
scriptname="auto_launch.ps1"

# Commande pour copier le fichier vers le serveur distant
scp $localFilePath "$remoteUser@$remoteServer:$remoteFilePath"
 
# Commande pour exécuter le script sur le serveur distant
ssh Lionel@192.168.0.47 "cd C:\\Users\\Public\\docker_service\\LayoutMlgit && powershell -ExecutionPolicy RemoteSigned -File auto_launch.ps1"

