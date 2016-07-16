#!/bin/sh

work_dir="dirname $0"
work_dir="cd $work_dir;pwd"

echo -e "id\tpid\tport\tweb_root"

# check whethe at least one http server running or not.
info=`ps -ef | grep "SimpleHTTPServer" | wc -l`
if [ $info -lt 2 ]
then
	echo "no http server"
	exit 0
else
	# get all pid of http server
	process_id=`ps -ef | grep "SimpleHTTPServer" | grep -v "grep SimpleHTTPServer" | awk '{print $2}'`
	count=1
	for idx in $process_id
	do
		# get the web root of the http server
		proc_info=`ls -l /proc/$idx | grep "cwd ->" | awk -F' ' '{print $NF}'`
		# get the listen port of http server
		port_info=`ps -ef | grep "SimpleHTTPServer" | awk -v port_num="$idx" '$2==port_num {print $0}' | awk '{print $NF}'`

		# print the info of the http server
		echo -e "$count\t$idx\t$port_info\t$proc_info"
		((count++))
	done
fi
exit 0
