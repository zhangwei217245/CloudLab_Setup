#!/bin/bash

SHELL_ENHANCE='bash'


if [ -n $1 ]; then
	SHELL_ENHANCE=$1
fi

if [ "$SHELL_ENHANCE" == 'fish' ]; then
	echo "Using fish as default shell enhancement"
	curl -L http://get.oh-my.fish > installomf
	fish installomf --noninteractive
	rm -rf installomf
	echo "omf install cbjohnson" | fish
	sudo chsh -s $(which fish) $(whoami)
	fish
elif [ "$SHELL_ENHANCE" == 'bashit' ]; then

	echo "Using bash-it as default shell enhancement"
	git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it
	~/.bash_it/install.sh --silent
	sudo chsh -s $(which bash) $(whoami)
	bash

elif [ "$SHELL_ENHANCE" == 'bash' ]; then

	echo "Using oh-my-bash as default shell enhancement"
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"
	sudo chsh -s $(which bash) $(whoami)
        bash
elif [ "$SHELL_ENHANCE" == 'zsh' ]; then
	echo "Using oh-my-zsh as default shell enhancement"
	sudo chsh -s $(which zsh) $(whoami)
	zsh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

else
	echo "Using oh-my-bash as default shell enhancement"
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"
	sudo chsh -s $(which bash) $(whoami)
        bash
fi
