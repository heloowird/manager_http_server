#!/bin/sh

work_dir="dirname $0"
work_dir="cd $work_dir;pwd"

echo "id\tpid\tport\tweb_root"

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
		proc_info=`ps eww $idx | awk 'NR==2{for(i=1;i<=NF;i++)if($i ~ /^PWD/) print $i}' | awk -F'=' '{print $NF}'`
		# get the listen port of http server
		port_info=`ps eww $idx | awk 'NR==2{for(i=1;i<=NF;i++)if($i == "SimpleHTTPServer")print $(i+1)}'`

		# print the info of the http server
		echo "$count\t$idx\t$port_info\t$proc_info"
		
		((count++))
	done
fi
exit 0
