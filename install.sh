#!/usr/bin/env bash

work_dir=`dirname $0`
work_dir=`cd $work_dir;pwd`

tmp_file=$work_dir/.tmp_info_are_u_serious

function install()
{
	if [ $# -ne 1 ]
	then
		print_help
		exit 1
	fi
	target_dir=$1
	if [ ! -d $target_dir ]
	then
		mkdir -p $target_dir
		echo "$target_dir not exists, mkdir success"
	fi 
	target_dir=`cd $target_dir;pwd`
	echo "the scipts will be installed in $target_dir"

    shell_dir='${work_dir}/for_linux'
    if [ "$(uname)" == "Darwin" ]
    then
        shell_dir='${work_dir}/for_mac'
    else if [ "$(uname -s)" == "Linux" ]
    then
        shell_dir='${work_dir}/for_linux'
    else
        echo "Unknow OS"
        exit 1
    fi

	if [ "$target_dir" != "$shell_dir" ]
	then
		for ele in `ls ${shell_dir}/*.sh`
		do
			if [ -f $target_dir/$ele ] 
			then
                mv $target_dir/$ele $target_dir/$ele.bak.$(date +%s)
				echo "$target_dir/$ele exists, bakup it as $target_dir/$ele.bak_by_install_maneger_http_server"
			fi
			cp $shell_dir/$ele $target_dir
			if [ $? -eq 0 ]
			then
				echo "copy $shell_dir/$ele to $target_dir done"
			else
                echo "copy $shell_dir/$ele to $target_dir failed, please check file or directory permission"
				exit 1
			fi
		done
	else
		echo "$target_dir is same as work_dir, and it does not need to copy files"
	fi

	echo "#added by manager_http_server" >> $tmp_file
	for ele in `ls *_http.sh`
	do
		cmd_name=${ele%.*}
		echo "alias $cmd_name='sh $target_dir/$ele'" >> $tmp_file
	done
	cp ~/.bashrc ~/.bashrc.bak_by_maneger_http_server
	cat $tmp_file >> ~/.bashrc
	if [ $? -eq 0 ]
	then
		echo "install manager_http_server SUCCESS"
		echo "restart shell to make it work, but if still not work, please source ~/.bashrc mannually"
	else
		echo "install manager_http_server failed, please check ~/.bashrc write permission"
	fi
	rm -f $tmp_file
}

function print_help()
{
	echo "Usage: sh install.sh [-i|-h]"
	echo "For example:"
	echo "       sh install.sh -i(nstall) target_dir: install into specified directory"
	echo "       sh install.sh -h: print help info"
}

if [ $# -eq 0 ]
then
	print_help
	exit 1
fi

while getopts "i:h" arg
do
	case $arg in
		i)
			install $OPTARG
			;;
		h)
			print_help
			;;
		*)  
			print_help
			;; 
	esac
done
