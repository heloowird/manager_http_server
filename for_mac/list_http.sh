#!/bin/sh

work_dir=`dirname $0`
work_dir=`cd $work_dir;pwd`

source $work_dir/util.sh

server_name=$(get_python_server_name)
if [ -z $server_name ]
then
	echo "[Bad Python Version]: please check the version is 2.x.x or 3.x.x."
	exit -1
fi

echo "id\tpid\tport\tweb_root"

# check whethe at least one http server running or not.
info=`ps -ef | grep -F "$server_name" | wc -l`
if [ $info -lt 2 ]
then
	echo "no http server"
	exit 0
else
	count=1
	# get all pid of http server
	process_id=`ps -ef | grep -F "$server_name" | grep -v "grep -F $server_name" | awk '{print $2}'`
	for idx in $process_id
	do
		# get the web root of the http server
		proc_info=`ps eww $idx | awk 'NR==2{for(i=1;i<=NF;i++)if($i ~ /^PWD/) print $i}' | awk -F'=' '{print $NF}'`
		# get the listen port of http server
		port_info=`ps eww $idx | awk -v svr_name="$server_name" 'NR==2{for(i=1;i<=NF;i++)if($i == svr_name)print $(i+1)}'`

		# print the info of the http server
		echo "$count\t$idx\t$port_info\t$proc_info"
		
		((count++))
	done
fi

exit 0
