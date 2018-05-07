#!/bin/bash

# --------------------  variable define of the script  --------------------

# get system bit
systemBits=`getconf LONG_BIT`
if [ $systemBits == 64 ];
then 
	systemArch="amd64"; 
else
	systemArch="386"; 
fi

githubURL=https://raw.githubusercontent.com/kangqf/config/ubuntu/

# flags to select the packages
basicPkg="git zsh vim tmux tree wget curl vnstat rar unrar p7zip-full zip unzip build-essential chromium-browser"

# variables relate to packages source  
VERSION="bionic"
COMP="main restricted universe multiverse"
MIRROR="https://mirrors.tuna.tsinghua.edu.cn/ubuntu/"
addDebSrc="N"

# variables to identify the use the packages or configs
useOhMyZsh="Y"
useSS="Y"
useKcp="Y"
useSshServer="Y"
useMstc="Y"
useJupyter="Y"
useVimConfig="Y"
useTmuxConfig="Y"

# shadowsocks config information
configSS="D"
SSServerIp="128.199.130.32"
SSMethod="rc4-md5"
SSRemotePort="443"
SSLocalPort="1080"
SSKey="111111"

# kcptun config information
configKcptun="D"
KcpVersion="20170329"
# https://github.com/xtaci/kcptun/releases/download/v20170329/kcptun-linux-386-20170329.tar.gz
KcpDownloadUrl="https://github.com/xtaci/kcptun/releases/download/v$KcpVersion/kcptun-linux-$systemArch-$KcpVersion.tar.gz"
KcptunRemotePort="4443"
KcptunLocalPort="443"
KcptunKey="111111"
KcpCrypt="cast5"
KcpMode="fast"

# --------------------  function define of the script  --------------------

# print the start information
function printStartInfo()
{
	echo -e "\e[0m----------------------------------------------------------------------------------------------------"
	echo -e "You are using the \e[1;34mkangqf's Dev Env Init Scripts\e[0m, Any question you can refer to \e[1;31mi@kangqingfei.cn \e[0m"
	echo "----------------------------------------------------------------------------------------------------"
}

# set the pkg source
function setPkgSource()
{
	echo -e "\n----------------------------------------------------------------------------------------------------"
	echo "First, You need to set you Ubuntu version and package source URL"
	echo -e "\e[1;42m"
	read -p  "Set Ubuntu Version(precise trusty bionic->default ...):" var
	if [[ -n $var ]];
	then 
		VERSION=$var;
	fi
	
	read -p  "Set Ubuntu Packages URL(Enter to use https://mirrors.tuna.tsinghua.edu.cn/ubuntu/):" var
	if [[ -n $var ]];
	then 
		MIRROR=$var;
	fi
	
	read -p  "AddDebSrc(Y/N Default:N):" var
	if [[ -n $var ]];
	then 
		addDebSrc=$var;
	fi
	echo -e "\e[0m"
	# echo -e "\e[0m$VERSION $MIRROR $addDebSrc"
}

# update source
function updateSources()
{
	# backup sources.list 
	echo -e "\e[1;44mBackup your sources.list to sources.list."`date +%F-%R:%S`
	echo -e "\e[0m"
	sudo mv /etc/apt/sources.list /etc/apt/sources.list.`date +%F-%R:%S`
	local tmp=$(mktemp)
	echo "deb $MIRROR $VERSION $COMP" >> $tmp
	echo "deb $MIRROR $VERSION-updates $COMP" >> $tmp
	echo "deb $MIRROR $VERSION-backports $COMP" >> $tmp 
	echo "deb $MIRROR $VERSION-security $COMP" >> $tmp
	# not use the Pre-Release resource
	#echo "deb $MIRROR $VERSION-proposed $COMP" >> $tmp
	
	if [ $addDebSrc == "Y" ] || [ $addDebSrc == "y" ];
	then
		echo "deb-src $MIRROR $VERSION $COMP" >> $tmp 
		echo "deb-src $MIRROR $VERSION-updates $COMP" >> $tmp 
		echo "deb-src $MIRROR $VERSION-backports $COMP" >> $tmp 
		echo "deb-src $MIRROR $VERSION-security $COMP" >> $tmp 
		#echo "deb-src $MIRROR $VERSION-proposed $COMP" >> $tmp
	fi

	sudo mv "$tmp" /etc/apt/sources.list
	echo -e "Your sources has been updated.\n";
	
}

# set the basic package
function setBasicPkg()
{
	echo -e "\n----------------------------------------------------------------------------------------------------"
	echo "Second, You need to select the packages that you want to install and config"
	echo -e "The default basic package include:\e[1;34m $basicPkg\e[0m, and you can add new packages to it.\e[1;42m"
	read -p  "Add Your Basic Packages(Enter to skip):" var
	basicPkg=$basicPkg$var
	echo -e "\e[0mThe basic packages will install include:\e[1;34m$basicPkg\e[0m"
}

# generate shadowsocks config to file shadowsocks.json
function generateSSConfig()
{
	local tmp=$(mktemp)
	echo -e "{" >> $tmp
	if [ $useKcp == "Y" ];
	then
		echo -e "\"server\":\"127.0.0.1\"," >> $tmp
	else
		echo -e "\"server\":\"$SSServerIp\"," >> $tmp
	fi
	echo -e "\"server_port\":$SSRemotePort," >> $tmp
	echo -e "\"local_address\": \"127.0.0.1\"," >> $tmp
	echo -e "\"local_port\":$SSLocalPort,"  >> $tmp
	echo -e "\"password\":\"$SSKey\"," >> $tmp
	echo -e "\"timeout\":300," >> $tmp
	echo -e "\"method\":\"$SSMethod\","  >> $tmp
	echo -e "\"fast_open\": false" >> $tmp
	echo -e "}" >> $tmp
	mv "$tmp" ~/.kqf/shadowsocks.json
	echo -e "\e[1;44mYour shadowsocks.json has been generated.\n\e[1;42m";
}

# generate kcptun config to file kcptun.json 
function generateKcptunConfig()
{
	local tmp=$(mktemp)
	echo -e "{" >> $tmp
	echo -e "\"localaddr\":\"127.0.0.1:$KcptunLocalPort\"," >> $tmp
	echo -e "\"remoteaddr\":\"$SSServerIp:$KcptunRemotePort\"," >> $tmp
	echo -e "\"key\": \"$KcptunKey\"," >> $tmp
	echo -e "\"crypt\":\"$KcpCrypt\","  >> $tmp
	echo -e "\"mode\":\"$KcpMode\"" >> $tmp
	echo -e "}" >> $tmp
	mv "$tmp" ~/.kqf/kcptun.json
	echo -e "\e[1;44mYour kcptun.json has been generated.\n\e[1;42m";
}

# get shadowsocks config
function getSSConfig()
{
	read -p  "Config Shadowsocks?(Y/N/D Default:D):" var;
	if [[ -n $var ]];
	then 
		echo "configSS:$configSS";
		configSS=$var;
		echo "var:$var";
		echo "configSS:$configSS";
	fi
	
	# use the default config
	if [ $configSS == "D" ];
	then
		generateSSConfig;
	# use self define config
	elif [ $configSS == "Y" ];
	then
		read -p  "ShadowSocks Server IP?(Default:128.199.130.32):" var;
		if [[ -n $var ]];
		then 
			SSServerIp=$var;
		fi
		
		read -p  "ShadowSocks Crypt Methods?(Default:rc4-md5):" var;
		if [[ -n $var ]];
		then 
			SSMethod=$var;
		fi
		
		read -p  "ShadowSocks Remote Port?(Default:443):" var;
		if [[ -n $var ]];
		then 
			SSRemotePort=$var;
		fi
		
		read -p  "ShadowSocks Local Port?(Default:1080):" var;
		if [[ -n $var ]];
		then 
			SSLocalPort=$var;
		fi
		
		read -p  "ShadowSocks Password?(Default:******):" var;
		if [[ -n $var ]];
		then 
			SSKey=$var;
		fi
		generateSSConfig;		
	fi
}

# get Kcptun config
function getKcptunConfig()
{
	read -p  "Config Kcptun?(Y/N/D Default:D):" var
	if [[ -n $var ]];
	then 
		configKcptun=$var;
	fi
	
	# use the default config
	if [ $configKcptun == "D" ];
	then
		generateKcptunConfig;
	# use self define config
	elif [ $configKcptun == "Y" ];
	then
		read -p  "Kcptun Version?(Default:20170329):" var
		if [[ -n $var ]];
		then 
			KcpVersion=$var;
			# make the kcptun download url
			KcpDownloadUrl="https://github.com/xtaci/kcptun/releases/download/v$KcpVersion/kcptun-linux-$systemArch-$KcpVersion.tar.gz"
		fi
		
		read -p  "Kcptun Crypt Methods?(Default:cast5):" var
		if [[ -n $var ]];
		then 
			KcpCrypt=$var;
		fi
		
		read -p  "Kcptun Crypt Mode?(Default:fast):" var
		if [[ -n $var ]];
		then 
			KcpMode=$var;
		fi
		
		read -p  "Kcptun Remote Port?(Default:4443):" var
		if [[ -n $var ]];
		then 
			KcptunRemotePort=$var;
		fi
		
		read -p  "Kcptun Local Port?(Default:443):" var
		if [[ -n $var ]];
		then 
			KcptunLocalPort=$var;
		fi
		
		read -p  "Kcptun Password?(Default:******):" var
		if [[ -n $var ]];
		then 
			KcptunKey=$var;
		fi
		generateKcptunConfig;
	fi
}

# set the variable to identify install some package
function setIdentifyVar()
{
	echo -e "\e[1;42m"
	read -p  "Use Oh-My-Zsh config?(Y/N Default:Y):" var
	if [[ -n $var ]];
	then 
		useOhMyZsh=$var;
	fi
	
	read -p  "Use Shadowsocks?(Y/N Default:Y):" var
	if [[ -n $var ]];
	then 
		useSS=$var;
	fi
	
	read -p  "Use Kcptun?(Y/N Default:Y):" var
	if [[ -n $var ]];
	then 
		useKcp=$var;
	fi
	
	if [ $useSS == "Y" ] && [ $useKcp == "Y" ];
	then
		getSSConfig
		getKcptunConfig
	elif [ $useSS == "Y" ];
	then
		getSSConfig
	fi
	
	read -p  "Use SSH Service?(Y/N Default:Y):" var
	if [[ -n $var ]];
	then 
		useSshServer=$var;
	fi
	
	read -p  "Use Remote Access?(Y/N Default:Y):" var
	if [[ -n $var ]];
	then 
		useMstc=$var;
	fi
	
	read -p  "Use Jupyter?(Y/N Default:Y):" var
	if [[ -n $var ]];
	then 
		useJupyter=$var;
	fi
	
	read -p  "Use kangqf's Vim config?(Y/N Default:Y):" var
	if [[ -n $var ]];
	then 
		useVimConfig=$var;
	fi
	
	read -p  "Use kangqf's Tmux config?(Y/N Default:Y):" var
	if [[ -n $var ]];
	then 
		useTmuxConfig=$var;
	fi
	
	echo -e "\e[0m"
	echo -e "$useOhMyZsh $useSS $useKcp $useSshServer $useMstc $useJupyter $useVimConfig $useTmuxConfig"
}

# Oh-My-Zsh config
function configOhMyZsh()
{
	echo -e "\n----------------------------------------------------------------------------------------------------"
	if [ -d ~/.oh-my-zsh ]; 
	then 
		echo -e "\e[1;33mOh-My-Zsh has been installed.\e[0m"; 
	else
		sudo mv ~/.zshrc ~/.zshrc.`date +%F-%R:%S`;
		echo -e "\e[1;44mBackup your .zshrc to .zshrc."`date +%F-%R:%S`
		echo -e "\e[0m"
		sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
		sed -i 's/plugins=(*)/plugins=(git vim ubuntu docker)/g' ~/.zshrc
		chsh -s /bin/zsh
	fi
	echo -e "Config Oh-My-Zsh successsed"
}

# ShadowSocks config
function configShadowsocks()
{
	echo -e "\n----------------------------------------------------------------------------------------------------"
	sudo apt-get install python-pip proxychains
	sudo pip install -i https://pypi.tuna.tsinghua.edu.cn/simple shadowsocks
	
	echo -e "alias ss=\"nohup sslocal -c ~/.kqf/shadowsocks.json &\""  >> ~/.zshrc
	sudo sed -i 's/socks4 	127.0.0.1 9050/socks5 	127.0.0.1 1080/g' /etc/proxychains.conf
	
	if [ $useKcp == "Y" ];
	then
		cd ~/.kqf
		sslocal -s $SSServerIp -p $SSRemotePort -k $SSKey -m $SSMethod &
		sleep 1s
		proxychains wget $KcpDownloadUrl
		tar -xvf kcptun-linux-$systemArch-$KcpVersion.tar.gz
		rm server_linux_$systemArch
		rm kcptun-linux-$systemArch-$KcpVersion.tar.gz
		# cd kcptun-linux-$systemArch-$KcpVersion
		#mv client_linux_$systemArch ../
		#cd ..
		#sudo rm kcptun-linux-$systemArch-$KcpVersion -R
		echo -e "alias kcptun=\"nohup sudo ~/.kqf/client_linux_$systemArch -c ~/.kqf/kcptun.json &\"" >> ~/.zshrc
	fi
	

	# zsh
	echo -e "Config ShadowSocks successsed.You can use\e[1;44m ss kcptun proxychains\e[0m Now"
}

# config ssh server
function configSshServer()
{
	sudo apt-get install openssh-server 
	ssh-keygen
	cat id_rsa.pub >> ~/.ssh/authorized_keys
}

# --------------------  start of the script  --------------------

#
#alias aria="nohup aria2c --conf-path=/etc/aria2/aria2.conf &"

# change the dir
mkdir ~/.kqf
cd ~/.kqf

printStartInfo;

setPkgSource;
updateSources

setBasicPkg;

sudo apt-get update
sudo apt-get install $basicPkg

setIdentifyVar;

if [ $useOhMyZsh == "Y" ];
then
	configOhMyZsh
	#echo -e "config Oh-My-Zsh"
fi

if [ $useSS == "Y" ];
then
	configShadowsocks
	#echo -e "config ShadowSocks"
fi

if [ $useSshServer == "Y" ];
then
	configSshServer
	# echo -e "config ssh server"
fi

if [ $useMstc == "Y" ];
then
	#config Mstc
	sudo apt-get install dconf-editor
	echo -e "open the dconf-editor and find org->gnome->desktop->remote-access then disable requre-encryption option"
	echo -e "config Mstc"
fi

if [ $useJupyter == "Y" ];
then
	sudo apt-get install ipython ipython-notebook
	sudo pip install -i https://pypi.tuna.tsinghua.edu.cn/simple jupyter
	wget https://raw.githubusercontent.com/kangqf/config/ubuntu/jupyter_notebook_config.py
	wget https://raw.githubusercontent.com/kangqf/config/ubuntu/mycert.pem
	cp jupyter_notebook_config.py mycert.pem ~/.jupyter
	sed -i "s/kqf/$USER/g" ~/.jupyter/jupyter_notebook_config.py
	echo -e "alias jpy=\"nohup jupyter notebook &\""  >> ~/.zshrc
	echo -e "You can use\e[1;44mjpy\e[0m Now"
	echo -e "config Jupyter success"
fi

if [ $useTmuxConfig == "Y" ];
then
	wget $githubURLtmux.conf
	wget https://raw.githubusercontent.com/kangqf/config/ubuntu/tmux.conf
	sudo mv /etc/tmux.conf /etc/tmux.conf.`date +%F-%R:%S`
	sudo mv tmux.conf /etc/
fi

if [ $useVimConfig == "Y" ];
then
	sudo apt-get install cmake wmctrl clang python3-dev ctags 
	sudo mv /etc/vim/vimrc /etc/vim/vimrc.`date +%F-%R:%S`
	sudo mkdir /etc/vim/bundle
	sudo git clone https://github.com/gmarik/Vundle.vim.git /etc/vim/bundle/Vundle.vim
	wget https://raw.githubusercontent.com/kangqf/config/ubuntu/vimrcNoYCM
	sudo mv vimrcNoYCM /etc/vim/vimrc
	
	echo -e "you need run sudo proxychains vim +PluginInstall"
fi


echo -e "\n----------------------------------------------------------------------------------------------------"
echo -e "End of the script"
