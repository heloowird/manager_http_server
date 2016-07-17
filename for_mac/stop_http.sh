#!/bin/sh

work_dir=`dirname $0`
work_dir=`cd $work_dir;pwd`

source $work_dir/util.sh

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
info=`sh $work_dir/list_http.sh | wc -l`
if [ $info -lt 2 ]
then
	echo "[INFO]: find none http server"
	exit 0
fi

if [ $id == "all" ]
then
	# get pids of all running http server
	process_id=`sh $work_dir/list_http.sh | awk -F'\t' 'NR>1 {print $2}'`
	for idx in $process_id
	do
		check_pid_is_running $idx
		ret=$?
		if [ $ret -eq 0 ]
		then
			kill -9 $idx
		fi
	done
	echo "[INFO]: stop all http server"
else
	# get the pid of the target id.
	# if the input id is illegal, the pid_num will be empty
	pid_num=`sh $work_dir/list_http.sh | awk -F'\t' -v id_no="$id" '$1==id_no {print $2}'`
	check_pid_is_running $pid_num
	ret=$?
	if [ $ret -eq 0 ]
	then
		kill -9 $pid_num
		if [ $? -eq 0 ]
		then
			echo "[INFO]: stop pid.${pid_num} http server succesfully"	
		else
			echo "[ERROR]: stop pid.${pid_num} http server failed"
		fi
	else
		echo "[ERROR]: wrong http server id"
	fi

	# list the left http server
	sh $work_dir/list_http.sh
fi

exit 0
