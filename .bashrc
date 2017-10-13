# .bashrc

# User specific aliases and functions

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias vi='vim'
alias vim='/usr/local/bin/vim'
alias setproxy='export http_proxy="http://127.0.0.1:8123";export https_proxy="http://127.0.0.1:8123"'
alias unsetproxy='unset http_proxy;unset https_proxy'
#alias scprobot=`scp /root/im/server/robot/bin/robot 172:~ && ssh 172:"sh scp_robot122.sh"`

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi
export LD_LIBRARY_PATH=/usr/local/lib:/usr/local/lib64/:$LD_LIBRARY_PATH
export C_INCLUDE_PATH=/usr/local/include/:$C_INCLUDE_PATH
export CPLUS_INCLUDE_PATH=/usr/local/include/:$CPLUS_INCLUDE_PATH

export JAVA_HOME=/usr/local/jdk1.8.0_144
export PATH=$PATH:$JAVA_HOME/bin 
export CLASSPATH=.:$JAVA_HOME/lib/tools.jar:$JAVA_HOME/lib/dt.jar:$CLASSPATH

export GOROOT=/usr/local/go
export GOPATH=~/WorkSpace/gopath
export PATH=$PATH:$GOROOT/bin:/$GOPATH/bin

