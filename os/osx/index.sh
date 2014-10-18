#!/usr/bin/env bash

set -e

# modules
source "$lib/symlink/index.sh"
source "$lib/is-osx/index.sh"

# Only run if on a Mac
if [ 0 -eq `osx` ]; then
  exit 0
fi

# exit 1
# paths
osx="$os/osx"

echo ""
echo "Setting your computer name (as done via System Preferences â†’ Sharing)"
echo "What would you like it to be?"
read COMPUTER_NAME
sudo scutil --set ComputerName $COMPUTER_NAME
sudo scutil --set HostName $COMPUTER_NAME
sudo scutil --set LocalHostName $COMPUTER_NAME
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string $COMPUTER_NAME

# Run each program
sh "$osx/defaults.sh"
sh "$osx/binaries.sh"
sh "$osx/apps.sh"

# Symlink the profile?

  read -p "Install .bash_profile?" profile
  case $profile in
    "" | "y" | "yes" )
      replace_profile
      ;;  
  esac

function replace_profile(){
	if [[ ! -e "$HOME/.bash_profile" ]]; then
	  echo "symlinking: $osx/profile.sh => $HOME/.bash_profile"
	  symlink "$osx/profile.sh" "$HOME/.bash_profile"
	  source $HOME/.bash_profile
	else
	  echo "$HOME/.bash_profile already exists. remove and run again."
	fi 

