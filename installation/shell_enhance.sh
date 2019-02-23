#!/bin/bash

SHELL_ENHANCE='ohmybash'


if [ -n $1 ]; then
	SHELL_ENHANCE=$1
fi

if [ "$SHELL_ENHANCE" == 'fish' ]; then
	echo "Using fish as default shell enhancement"
	#echo "fish" >> ~/.profile
	FISH_PROC=`which fish`
	curl -L http://get.oh-my.fish > installomf
	fish installomf --noninteractive
	rm -rf installomf
	echo "omf install cbjohnson" | fish
	chsh -s $FISH_PROC
	fish
elif [ "$SHELL_ENHANCE" == 'bashit' ]; then

	echo "Using bash-it as default shell enhancement"
	git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it
	~/.bash_it/install.sh --silent
	BASH_PROC=`which bash`
	chsh -s $BASH_PROC
	bash

elif [ "$SHELL_ENHANCE" == 'ohmybash' ]; then

	echo "Using oh-my-bash as default shell enhancement"
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"
	BASH_PROC=`which bash`
        chsh -s $BASH_PROC
        bash

else
	echo "Using oh-my-bash as default shell enhancement"
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"
	BASH_PROC=`which bash`
        chsh -s $BASH_PROC
        bash
fi
