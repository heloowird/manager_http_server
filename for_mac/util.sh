#/bin/sh

function check_pid_is_running()
{
	pid_num=$1
	if [ -n $pid_num ]
	then
		# check the pid is really exist in shell
		pid_running_num=`ps -ef | grep "SimpleHTTPServer" | awk -v pid_no="$pid_num" '$2==pid_no {print $0}' | wc -l`
		ret=`expr 1 - $pid_running_num`
		return $ret
	else
		return 3
	fi
	return 4
}
