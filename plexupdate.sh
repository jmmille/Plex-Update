#!/bin/bash

UPVER=$(curl https://plex.tv/downloads?channel=plexpass 2>&1 | grep -oPm 1 "(?<=Version )[0-9\.]+[-\w]+(?=)")
DIRECTORY='/root/plexupdate'
FILE='PlexMediaServer-'$UPVER'-freebsd-amd64.tar.bz2'

echo 'New Version = ' $UPVER

if [ ! -d "$DIRECTORY" ]; then
  # Control will enter here if $DIRECTORY doesn't exist.
  mkdir $DIRECTORY
fi


if [ -d "$DIRECTORY" ]; then
  # Control will enter here if $DIRECTORY exists.
  cd $DIRECTORY

  if [ ! -f "$FILE" ]; then
    wget 'http://downloads.plexapp.com/plex-media-server/'$UPVER'/PlexMediaServer-'$UPVER'-freebsd-amd64.tar.bz2'
  fi

  echo 'Extracting '$FILE
  tar xjf 'PlexMediaServer-'$UPVER'-freebsd-amd64.tar.bz2'
  echo 'Finished Extracting '$FILE

  if [ -d "PlexMediaServer-"$UPVER ]; then
    echo 'Installing Plex Media Server'
    cd 'PlexMediaServer-'$UPVER

    echo ''
    echo 'Stopping Plex Media Server'
    service plexmediaserver stop

    if [ ! -d '/usr/local/share/plexmediaserver/' ]; then
      mkdir -p /usr/local/share/plexmediaserver/
    fi

    echo 'Copying new version over old version'
    cp -R * /usr/local/share/plexmediaserver/

    echo 'Restarting Plex Media Server'
    service plexmediaserver start

    echo ''
    echo 'Installation finished.'

    echo ''
    echo 'Cleaning up files and directories'
    rm -R $DIRECTORY
    echo 'Done.'
  fi
fi

