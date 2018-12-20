#!/bin/bash 
arg_one=$1
msg_content=\"CommandRan\";
echo "alias dgui=\"bash ~/DGUI-bash-testing/dgui.sh\"" >> ~/.bashrc
source ~/.bashrc
#I will eventually need to move this to a systemctl that we can use in conjunction with service  
if [ $arg_one = "pull" ]; then 
	echo "pulling new version from github";
	cd ~
	echo "removing old version of DGUI Server"; 
	rm -rf ./Server
	git clone https://github.com/A-Team-IOT/Server
	cd ./Server
	if [[ $(npm -v) ]]; then
		npm install ./ 
		npm install lt
		msg_content=$(echo \"Clean version of DGUI installed\");	
	else 
		echo "NPM is not installed on this system - please run npm-install";	
		msg_content=$(echo \"Clean version failed to install: npm not installed on system \");
	fi
fi
if [ $arg_one = "update" ]; then 
	echo "Updating version from github.";
	msg_content=$(echo \"Updating DGUI Server for this host\");
	cd ~
	cd ./Server
	echo "Updating version";
	git pull  
fi

if [ $arg_one = "start" ]; then 
	echo "Starting.."; 
	msg_content=$(echo \"Starting DGUI for this host\");   
fi
if [ $arg_one = "stop" ]; then 
	echo "Stoping...";
	msg_content=$(echo \"Stopping DGUI for this host\");    
fi
if [ $arg_one = "restart" ]; then 
	echo "Restarting DGUI Server...";
	msg_content=$(echo \"Restarting DGUI for this host\");  
fi
if [ $arg_one = "remove" ]; then 
	echo "Restarting DGUI Server...";
	msg_content=$(echo \"Removing DGUI from this host\");    
fi
if [ $arg_one = "npm-install" ]; then 
	echo "Installing Node and NPM...";
	msg_content=$(echo \"Installing Node and NPM\");   
	if [[ $(npm -v) ]]; then
		printf "Npm Version Installed:";
		node -v; 
	else
		if [[ $(node -v) ]]; then
			printf "Node Installed - Moving to Install npm";
			sudo apt-get install npm; 
		else 
			sudo apt-get install nodejs; 
			sudo apt-get install nodejs-legacy; 
			sudo apt-get install npm; 
		fi
	fi
fi
if [ $arg_one = "npm-remove" ]; then
	echo "Uninstalling npm";
	if [[ $(npm -v) ]]; then 
		sudo apt-get remove npm;
	else 
		echo "Npm not present";
	fi 
fi 
if [ $arg_one = "node-remove" ]; then 
	echo "Removing Node and NPM...";
	if [[ $(node -v) ]]; then
		sudo apt-get purge nodejs;
		sudo apt-get purge --auto-remove nodejs; 
	else
		echo "Node is not present on this system";
	fi 
fi

if [ $arg_one = "node-install" ]; then 
	echo "Installing Node and NPM...";
	if [[ $(node -v) ]]; then
		printf "Node Version Installed:";
		node -v; 
	else
		echo "Node Version:";
		sudo apt-get install nodejs;
		sudo apt-get install nodejs-legacy;
	fi 
fi
if [ $arg_one = "node-remove" ]; then 
	echo "Removing Node and NPM...";
	if [[ $(node -v) ]]; then
		sudo apt-get purge nodejs;
		sudo apt-get purge --auto-remove nodejs; 
	else
		echo "Node is not present on this system";
	fi 
fi
if [ $arg_one = "nmlt" ]; then
	echo "Nodemon being installed"; 
	sudo npm install -g nodemon; 
	echo "localtunnel being installed"; 	
	msg_content=$(echo \"Node mon and local tunnel being installed.\");    
url='https://discordapp.com/api/webhooks/525350871387865088/NlACprjejFMj4Ix97N5piDUb7Wj2MugJZW577WZNFEIfJq056gB1Erohkggl1GTtyMWc'
curl -H "COntent-Type: application/json" -X POST -d  "{\"content\": $msg_content}" $url
exit 0
