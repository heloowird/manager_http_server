#!/bin/sh

work_dir=`dirname $0`
work_dir=`cd $work_dir;pwd`

source $work_dir/util.sh

# get server name that depends on the python's version
server_name=$(get_python_server_name)
if [ -z $server_name ]
then
	echo "[Bad Python Version]: please check the version is 2.x.x or 3.x.x."
	exit -1
fi

echo -e "id\tpid\tport\tweb_root"

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
		proc_info=`ls -l /proc/$idx | grep "cwd ->" | awk -F' ' '{print $NF}'`
		# get the listen port of http server
		port_info=`ps -ef | grep -F "$server_name" | awk -v port_num="$idx" '$2==port_num {print $0}' | awk '{print $NF}'`

		# print the info of the http server
		echo -e "$count\t$idx\t$port_info\t$proc_info"
		
		((count++))
	done
fi
exit 0
