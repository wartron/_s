#!/bin/bash
echo "forking _s"
echo "new name: $1"
echo "path to wp themes: $2"


#TODO: make sure gets atleast 1 argument (the name)
#TODO: if just 1 argument, use enviorment path for Path argument

SFORK_PATH="$2/$1"
SFORK_RESPONSE=



#check if a wp-content/themes/ exists and select that dir so the base can be the root wp install
if [ -d "$2/wp-content/themes" ]; then
	echo -n "Place new theme in $2/wp-content/themes/$1 (y/n) > "
	read SFORK_RESPONSE
	if [ "$SFORK_RESPONSE" == "y" ]; then
		SFORK_PATH="$2/wp-content/themes/$1"
	fi
fi


if [ -d $SFORK_PATH ]; then
	echo -n "Output folder exists. Overwrite? (y/n) > "
	read SFORK_RESPONSE
	if [ "$SFORK_RESPONSE" != "y" ]; then
		echo "Exiting"
		exit 1
	fi
else
	echo "making: $SFORK_PATH"
	mkdir $SFORK_PATH
fi


echo "copying _S to $SFORK_PATH"
cp -rf ./_s/* $SFORK_PATH/


echo "replacing _s to $1_s in all files"
#replace _s_ with $1_s_ in all files
#there is probably a more bash-foo way of doing this, but it works.
sed -i "s/: _s/: $1_s/g" $SFORK_PATH/style.css #for theme name

sed -i "s/_s_/$1_s_/g" $SFORK_PATH/*.php #for function calls
sed -i "s/'_s'/'$1_s'/g" $SFORK_PATH/*.php #for __( strings


sed -i "s/_s_/$1_s_/g" $SFORK_PATH/inc/*.php
sed -i "s/'_s'/'$1_s'/g" $SFORK_PATH/inc/*.php


sed -i "s/_s_/$1_s_/g" $SFORK_PATH/inc/theme-options/*.php
sed -i "s/'_s'/'$1_s'/g" $SFORK_PATH/inc/theme-options/*.php

echo "done!"
