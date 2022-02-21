#!/bin/bash
stty erase ^H

red='\e[91m'
green='\e[92m'
yellow='\e[94m'
magenta='\e[95m'
cyan='\e[96m'
none='\e[0m'
_red() { echo -e ${red}$*${none}; }
_green() { echo -e ${green}$*${none}; }
_yellow() { echo -e ${yellow}$*${none}; }
_magenta() { echo -e ${magenta}$*${none}; }
_cyan() { echo -e ${cyan}$*${none}; }

# Root
[[ $(id -u) != 0 ]] && echo -e "\n 请使用 ${red}root ${none}用户运行 ${yellow}~(^_^) ${none}\n" && exit 1

cmd="apt-get"

sys_bit=$(uname -m)

case $sys_bit in
'amd64' | x86_64) ;;
*)
    echo -e " 
	 这个 ${red}安装脚本${none} 不支持你的系统。 ${yellow}(-_-) ${none}

	备注: 仅支持 Ubuntu 16+ / Debian 8+ / CentOS 7+ 系统
	" && exit 1
    ;;
esac

if [[ $(command -v apt-get) || $(command -v yum) ]] && [[ $(command -v systemctl) ]]; then

    if [[ $(command -v yum) ]]; then

        cmd="yum"

    fi

else

    echo -e " 
	 这个 ${red}安装脚本${none} 不支持你的系统。 ${yellow}(-_-) ${none}

	备注: 仅支持 Ubuntu 16+ / Debian 8+ / CentOS 7+ 系统
	" && exit 1

fi

install_download() {
	installPath="/usr/local/feitianproxy"
    cd /usr/local/
    if [[ $cmd == "apt-get" ]]; then
        $cmd install -y supervisor
        service supervisor restart
    else
        $cmd install -y epel-release
        $cmd install -y supervisor
        systemctl enable supervisord
        service supervisord restart
    fi
    [ -d ./feitianproxy ] && rm -rf ./feitianproxy
     echo -e " 正在自行安装 Git: ${green}$cmd install -y git"
    $cmd install -y git
    git clone https://github.com/morestones/feitianproxy.git
}


start_write_config() {
    echo
    echo "下载完成，开启守护"
    echo
    chmod a+x $installPath/linux/feitian-proxy
    if [ -d "/etc/supervisord.d/" ]; then
        rm /etc/supervisord.d/feitian-6666.ini -f
        echo "[program:feitian-6666]" >>/etc/supervisord.d/feitian-6666.ini
        echo "command=${installPath}/linux/feitian-proxy" >>/etc/supervisord.d/feitian-6666.ini
        echo "directory=${installPath}/linux" >>/etc/supervisord.d/feitian-6666.ini
        echo "autostart=true" >>/etc/supervisord.d/feitian-6666.ini
        echo "autorestart=true" >>/etc/supervisord.d/feitian-6666.ini
    else
        echo
        echo "----------------------------------------------------------------"
        echo
        echo " Supervisor安装目录没了，安装失败"
        echo
        exit 1
    fi
    
    
    
    if [[ $cmd == "apt-get" ]]; then
        ufw allow 6666
        ufw allow 8080
    else
        firewall-cmd --zone=public --add-port=6666/tcp --permanent
        firewall-cmd --zone=public --add-port=8080/tcp --permanent
    fi    
    if [[ $cmd == "apt-get" ]]; then
        ufw reload
    else
        systemctl restart firewalld
    fi
    
    
    changeLimit="n"
    if [ $(grep -c "root soft nofile" /etc/security/limits.conf) -eq '0' ]; then
        echo "root soft nofile 60000" >>/etc/security/limits.conf
        changeLimit="y"
    fi
    if [ $(grep -c "root hard nofile" /etc/security/limits.conf) -eq '0' ]; then
        echo "root hard nofile 60000" >>/etc/security/limits.conf
        changeLimit="y"
    fi

    clear
    echo
    echo "----------------------------------------------------------------"
    echo
	if [[ "$changeLimit" = "y" ]]; then
	  echo "${red} 系统连接数限制已经改了，如果第一次运行本程序需要重启${none}"
	  echo
	fi
    supervisorctl reload
    echo "本机防火墙端口6666已经开放，如果还无法连接，请到云服务商控制台操作安全组，放行对应的端口"
    echo "请以访问本机IP:6666"
    echo
    echo "安装完成...守护模式无日志，需要日志的请以 nohup ./feitian-proxy &  方式运行"
		echo
		echo "以下配置文件：/usr/local/feitianproxy/linux/config.json，网页端可修改登录密码和端口号"
    echo
    echo "[*---------]"
    sleep  1
    echo "[**--------]"
    sleep  1
    echo "[***-------]"
    sleep  1
    echo "[****------]"
    sleep  1
    echo "[*****-----]"
    sleep  1
    echo "[******----]"
    cat /usr/local/feitianproxy/linux/config.json
    echo
    echo "----------------------------------------------------------------"
    
    
    
}



uninstall() {
    clear
    if [ -f "/etc/supervisord.d/feitian-6666.ini" ]; then
        rm /etc/supervisord.d/feitian-6666.ini -f
    fi
    supervisorctl update
    echo -e "$yellow 已关闭自启动${none}"
}

clear
while :; do
    echo
    echo "#### 飞天Proxy一键安装脚本####"
    echo
    echo " 1. 启动服务"
    echo
    echo " 2. 停止服务"
    echo
    read -p "$(echo -e "请选择 [${magenta}1-2$none]:")" choose
    case $choose in
    1)
        install_download
        start_write_config
        break
        ;;
    2)
    
        uninstall
        break
        ;;
    *)
        error
        ;;
    esac
done

