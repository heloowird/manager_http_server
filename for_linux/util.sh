#!/bin/sh

function check_pid_is_running()
{
	pid_num=$1
	server_name=$2
	if [ -n $pid_num ]
	then
		# check the pid is really exist in shell
		pid_running_num=`ps -ef | grep -F "$server_name" | awk -v pid_no="$pid_num" '$2==pid_no {print $0}' | wc -l`
		ret=`expr 1 - $pid_running_num`
		return $ret
	else
		return 1
	fi
	return 1
}

function get_python_server_name()
{
	# check python version, and choose following command argument
	#	python 2.x.x -> python -m SimpleHTTPServer
	#	python 3.x.x -> python -m http.server
	version=`python --version 2>&1 | awk '{print $2}' | awk -F. '{print $1}'`
	server_name=""
	if [ $version -eq 2 ]
	then
		server_name="SimpleHTTPServer"
	elif [ $version -eq 3 ]
	then
		server_name="http.server"
	else
		server_name=""
	fi
	echo $server_name
}
