source ~/.zshrc
rename=""
reserver=""
echo "type rerun server 1:report 2:zhishi-mini"
read answer
reserver=$answer
if [ $answer == 1 ]
then
    rename="java -jar report-api.jar"
elif [ $answer == 2 ]
then
    rename="java -jar zhishi-api.jar"
else
    echo "input error"
    exit
fi

branch=""
echo "type git branch 1:master 2:dev 3:test 4:input"
read answer
if [ $answer == 1 ]
then
    branch="master"
elif [ $answer == 2 ]
then
    branch="dev"
elif [ $answer == 3 ]
then
    branch="test"
elif [ $answer == 4 ]
then
    echo "type branch"
    read answer
    branch=$answer
fi

echo "process name is $rename"
pid=`ps -ef | grep "$rename" | grep -v grep | awk '{print $2}'`                                                                                                
echo "process is $pid"
kill -9 $pid

if [ $reserver == 1 ]
then
    cd /home/zhihuo_dev/code_source/report
elif [ $reserver == 2 ]
then
    cd /home/zhihuo_dev/code_source/zhishi-mini
else
    exit
fi

echo "check out to $branch"

git checkout origin/$branch
git checkout $branch

mvn clean install -DskipTests

if [ $reserver == 1 ]
then
    rm ~/report-api.jar
    mv report-api/target/report-api.jar ~/report-api.jar
	cd ~
    nohup java -jar report-api.jar &
elif [ $reserver == 2 ]
then
    rm ~/zhishi-api.jar
    mv zhishi-api/target/zhishi-api.jar ~/zhishi-api.jar
	cd ~
    nohup java -jar zhishi-api.jar &
else
	exit
fi
