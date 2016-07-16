#!/bin/sh

work_dir=`dirname $0`
work_dir=`cd $work_dir;pwd`

if [ $# -ne 1 ]
then
	echo "[ERROR]: please input listen port"
	exit -1
fi
port=$1

# check the target port used or not
info=`netstat -ln | grep "$port" | awk '{print $4}' | grep "$port" | awk -F':' '{print $NF}' | grep "^$port$"`
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
# The web root directory is that excute this command, NOT the $work_dir
python -m SimpleHTTPServer $port >/dev/null 2>&1 &

host_name=`hostname`
echo "[INFO]: start http server successfully"
echo "[INFO]: http://$host_name:$port"
