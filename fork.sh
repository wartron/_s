#!/bin/bash
echo "forking _s"
echo "new name: $1"
echo "path: $2"
SFORK_PATH="$2/$1"
echo "making: $SFORK_PATH"
mkdir $SFORK_PATH
cp -rf ./_s/* $SFORK_PATH/


#replace _s_ with $1_s_ in all files
#there is probably a more bash-foo way of doing this, but it works.
sed -i "s/_s_/$1_s_/g" $SFORK_PATH/*.php
sed -i "s/: _s/: $1_s/g" $SFORK_PATH/style.css
sed -i "s/_s_/$1_s_/g" $SFORK_PATH/inc/*.php
sed -i "s/_s_/$1_s_/g" $SFORK_PATH/inc/theme-options/*.php
