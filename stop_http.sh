#!/bin/sh

work_dir=`dirname $0`
work_dir=`cd $work_dir;pwd`

if [ $# -ne 1 ]
then
	echo "[ERROR]: please select [all | id]"
	echo "[INFO]: [all] means stop all http server"
	echo "[INFO]: [id]  means the id in http server list"
	sh $work_dir/list_http.sh
	exit -1
fi

id=$1

# check whethe at least one http server is running
info=`ps -ef | grep "SimpleHTTPServer" | wc -l`
if [ $info -lt 2 ]
then
	echo "[INFO]: find none http server"
	exit 0
fi

if [ $id == "all" ]
then
	# get pids of all running http server
	process_id=`ps -ef | grep "SimpleHTTPServer" | grep -v "grep SimpleHTTPServer" | awk '{print $2}'`
	for idx in $process_id
	do
		kill -9 $idx
	done
	echo "[INFO]: stop all http server"
else
	# get the pid of the target id.
	# if the input id is illegal, the pid_num will be empty
	pid_num=`sh $work_dir/list_http.sh | awk -F'\t' -v id_no="$id" '$1==id_no {print $2}'`
	if [ -n $pid_num ]
	then
		# check the pid is really exist in shell
		pid_exist=`ps -ef | grep "SimpleHTTPServer" | awk -v pid_no="$pid_num" '$2==pid_no {print $0}' | wc -l`
		if [ $pid_exist -eq 1 ]
		then
			kill -9 $pid_num
			if [ $? -eq 0 ]
			then
				echo "[INFO]: stop no.${id} http server succesfully"	
			else
				echo "[ERROR]: stop no.${id} http server failed"
			fi
		else
			echo "[ERROR]: wrong http server id"
		fi
	fi
fi

# list the left http server
sh $work_dir/list_http.sh

exit 0
