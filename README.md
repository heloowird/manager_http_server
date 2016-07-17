# manager_http_server
The scrip aims to manager SimpleHTTPServer nested in Python, running on Linux.

In work or study, we need share/show our demos with/to the team members, especially which are writen by html script. Sometimes, we need transfer files in the Linux machine that is not installed with ftp server. Under the circumstances, we could install a light web server to share our demo or files. 

Usually, The Linux system installs Python in default. In Python, you can run a web server easily by using the below command:

	```Bash
	python -m SimpleHTTPServer [port]

The directory that you run this command is the web root, which means all files and sub-directories in this directory are accessed via http.

The shell scripts can help you manager many http server in different directories. In Linux, using `alias` in **~/.bashrc_profile** can improve availability.

	```Bash
	...
	alias start_http="sh [shell_dir]/start_http.sh"
	alias list_http="sh [shell_dir]/list_http.sh"
	alias stop_http="sh [shell_dir]/stop_http.sh"
	...

Then in Linux shell, you can use three commands to start http server in any directory, to list all http servers running on the machine, and to stop all or specified http server(s):

	```Bash
	start_http [port]
	list_http
	stop_http [all | id]

For example:

	```Bash
	localhost:for_mac zhang$ start_http 8090
	[INFO]: start http server successfully
	[INFO]: http://localhost:8090
	localhost:for_mac zhang$ start_http 8090
	[ERROR]: the port [8090] used
	localhost:for_mac zhang$ start_http 8091
	[INFO]: start http server successfully
	[INFO]: http://localhost:8091
	localhost:for_mac zhang$ 
	localhost:for_mac zhang$ 
	localhost:for_mac zhang$ 
	localhost:for_mac zhang$ list_http 
	id	pid	port	web_root
	1	48638	8090	/Users/zhang/zjq/manager_http_server/for_mac
	2	48660	8091	/Users/zhang/zjq/manager_http_server/for_mac
	localhost:for_mac zhang$ cd ~/ && start_http 8088 && cd -
	[INFO]: start http server successfully
	[INFO]: http://localhost:8088
	localhost:for_mac zhang$ list_http 
	id	pid	port	web_root
	1	48638	8090	/Users/zhang/zjq/manager_http_server/for_mac
	2	48660	8091	/Users/zhang/zjq/manager_http_server/for_mac
	3	48696	8088	/Users/zhang
	localhost:for_mac zhang$ 
	localhost:for_mac zhang$ 
	localhost:for_mac zhang$ 
	localhost:for_mac zhang$ stop_http 2
	[INFO]: stop pid.48660 http server succesfully
	id	pid	port	web_root
	1	48638	8090	/Users/zhang/zjq/manager_http_server/for_mac
	2	48696	8088	/Users/zhang
	localhost:for_mac zhang$ list_http 
	id	pid	port	web_root
	1	48638	8090	/Users/zhang/zjq/manager_http_server/for_mac
	2	48696	8088	/Users/zhang
	localhost:for_mac zhang$ stop_http all
	[INFO]: stop all http server
	localhost:for_mac zhang$ list_http 
	id	pid	port	web_root
	no http server
	localhost:for_mac zhang$

