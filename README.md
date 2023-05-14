# manager_http_server

### 0. 中文说明

[使用Shell 脚本管理Python 内置的HTTPServer 服务](http://heloowird.com/2016/07/21/manager_python_http_server/)

### 1. Introduction

The tool aims to manager HTTP Server nested in Python, running on Linux or Mac.

In work or study, we need share our demos or data with the team, especially which are writen by html script. Sometimes, we need transfer files into local or other remote machine that without ftp/sftp server. Under the circumstances, we could install a light web server to share our demo or files. 

Usually, The Linux system installs Python in default. For Python, you can run a web server easily by using the below command:
```Bash
# for python 2
python -m SimpleHTTPServer [port]
# for python 3
python -m http.server [port]
```

**The directory that you run above command is the web root**/, which means all files and sub-directories in the directory are accessed via http.

### 2. Installation

you can just run below commands to install the tool:
```Bash
# step1. clone the repo
git clone https://github.com/heloowird/manager_http_server.git

# step2. navigator to the repo directory
cd manager_http_server

# install the script into specified directory
sh install.sh -i [the_target_directory_installed]
```

### 3. Usage

then in Linux shell, you can use below commands to manager http servers:
```Bash
# start http server in any directory you share
start_http [port]

# list all http servers running on the machine
list_http

# stop all or specified http server(s)
stop_http [all | id]
```

#### 3.1 Example:

```Bash
$ start_http 8090
[INFO]: start http server successfully
[INFO]: http://localhost:8090
$ start_http 8090
[ERROR]: the port [8090] used
$ start_http 8091
[INFO]: start http server successfully
[INFO]: http://localhost:8091
 


$ list_http 
id	pid	port	web_root
1	48638	8090	/Users/zhang/zjq/manager_http_server/for_mac
2	48660	8091	/Users/zhang/zjq/manager_http_server/for_mac
$ cd ~/ && start_http 8088 && cd -
[INFO]: start http server successfully
[INFO]: http://localhost:8088
$ list_http 
id	pid	port	web_root
1	48638	8090	/Users/zhang/zjq/manager_http_server/for_mac
2	48660	8091	/Users/zhang/zjq/manager_http_server/for_mac
3	48696	8088	/Users/zhang



$ stop_http 2
[INFO]: stop pid.48660 http server succesfully
id	pid	port	web_root
1	48638	8090	/Users/zhang/zjq/manager_http_server/for_mac
2	48696	8088	/Users/zhang
$ list_http 
id	pid	port	web_root
1	48638	8090	/Users/zhang/zjq/manager_http_server/for_mac
2	48696	8088	/Users/zhang
$ stop_http all
[INFO]: stop all http server
$ list_http 
id	pid	port	web_root
no http server
```

### 4. Change Logs
+ 2018/04/05: update to automatically be compatible with python3
				and	add installing script
+ 2019/05/11: update installing script
