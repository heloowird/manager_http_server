# manager_http_server
The scrip aims to manager SimpleHTTPServer nested in Python, running on Linux shell

In work or study, we need share/show our demos with/to the team members, especially which are writen by html script. Sometines, we need tansfer files in the Linux machine that installed ftp server. Under the circumstances, we could install a light web server to share our demo or files. 

Usually, The Linux system installs Python in default. In Python, you can run a web server easily by using below command:

	python -m SimpleHTTPServer [port]

The directory that you run this command is the web root, which means all files and sub-directories in this directory are accessed via http.

The shell scripts can help you manager many http server in different directories. In Linux, using `alias` in *.bashrc* can improve availability.

	...
	alias start_http="sh [shell_dir]/start_http.sh"
	alias list_http="sh [shell_dir]/list_http.sh"
	alias stop_http="sh [shell_dir]/stop_http.sh"
	...

Then in Linux shell, you can use three commands to start http server in any directory, to list all http server in any directory, and to stop all or specified http server(s):

	start_http [port]
	list_http
	stop_http [all | id]

