echo "first thx v2ray白话文教程 address is  https://toutyrater.github.io/ \n\n\n"
echo "type server using port, must less than 65535 and more than 1080"
read answer
server_port=$answer
if [ $server_port -gt 65535 ]
then 
	echo "input error, port can't more than 65535"
	exit
elif [ $server_port -lt 1080 ]
then
	echo "input error, port can't less than 1080"
	exit
fi

echo "server time is `date +%Y-%m-%d' '%H:%M:%S` timezone is `date +%z`"
echo "check the time is right"
echo "timezone can be inconsistent with client"

echo "is the time right? y/n"
read answer
if [ $answer == 'n' ]
then
	echo "you can change time by yourself"
	echo "you may need bellow command"
	echo "sudo date --set='2017-01-22 16:16:23'"
	echo "if you can't modify server time, you can contact you server provider"
	exit
fi

if [ -x "/usr/bin/wget"  ]
then
	had_wget=1
elif [ -x "/usr/local/bin/wget" ]
then
	had_wget=1
else
	had_wget=0
fi

if [ $had_wget==0 ]
then
	linux_distributions=`cat /etc/os-release | grep -w ID`
	echo "you linux server is $linux_distributions"
	linux_distributions_name=${linux_distributions#*=}

