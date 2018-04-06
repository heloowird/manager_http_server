#!/bin/sh

work_dir=`dirname $0`
work_dir=`cd $work_dir;pwd`

source $work_dir/util.sh

if [ $# -ne 1 ]
then
	echo "[ERROR]: please input listen port"
	exit -1
fi

# check python version, and choose following command argument
#	python 2.x.x -> python -m SimpleHTTPServer
#	python 3.x.x -> python -m http.server
server_name=$(get_python_server_name)
if [ -z $server_name ]
then
	echo "[Bad Python Version]: please check the version is 2.x.x or 3.x.x."
	exit -1
fi

port=$1
# check the target port used or not
info=`netstat -an | grep "$port" | awk '{print $4}' | grep "$port" | awk -F'.' '{print $NF}' | grep "^$port$"`
if [ -n "$info" ]
then
	if [ $port -eq $info ]
	then
		echo "[ERROR]: the port [$port] used"
		exit -1
	fi
fi

# In Linux , python is installed in default.
# To use this command can start a http server, you can share your file
# or display you html demo.
# The web root directory is where you run the command, NOT the $work_dir
python -m $server_name $port >/dev/null 2>&1 &

host_name=`hostname`
echo "[INFO]: start http server successfully"
echo "[INFO]: http://$host_name:$port"

exit 0
