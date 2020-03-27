#!/bin/bash

blue(){
    echo -e "\033[34m\033[01m$1\033[0m"
}
green(){
    echo -e "\033[32m\033[01m$1\033[0m"
}
yellow(){
    echo -e "\033[33m\033[01m$1\033[0m"
}
red(){
    echo -e "\033[31m\033[01m$1\033[0m"
}

if [[ -f /etc/redhat-release ]]; then
    release="centos"
    systemPackage="yum"
    systempwd="/usr/lib/systemd/system/"
elif cat /etc/issue | grep -Eqi "debian"; then
    release="debian"
    systemPackage="apt-get"
    systempwd="/lib/systemd/system/"
elif cat /etc/issue | grep -Eqi "ubuntu"; then
    release="ubuntu"
    systemPackage="apt-get"
    systempwd="/lib/systemd/system/"
elif cat /etc/issue | grep -Eqi "centos|red hat|redhat"; then
    release="centos"
    systemPackage="yum"
    systempwd="/usr/lib/systemd/system/"
elif cat /proc/version | grep -Eqi "debian"; then
    release="debian"
    systemPackage="apt-get"
    systempwd="/lib/systemd/system/"
elif cat /proc/version | grep -Eqi "ubuntu"; then
    release="ubuntu"
    systemPackage="apt-get"
    systempwd="/lib/systemd/system/"
elif cat /proc/version | grep -Eqi "centos|red hat|redhat"; then
    release="centos"
    systemPackage="yum"
    systempwd="/usr/lib/systemd/system/"
fi

google_ssh(){
sudo -i
$systemPackage install -y expect
green "================================="
 blue "  请设置SSH登录密码，弱密码容易被攻击"
green "================================="
read your_passwd
/usr/bin/expect << EOF
spawn passwd
expect "password" {send "$your_passwd\r"}
EOF
if cat /etc/issue | grep -Eqi "ubuntu"; then
	sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
	sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
else	
	sed -i 's/PermitRootLogin no/PermitRootLogin yes/g' /etc/ssh/sshd_config
	sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
fi
green "================================="
green "  设置完毕，准备重启VPS并保存设置"
green "================================="
read -s -n1 -p "请按任意键重启VPS ... "
reboot
}
start_menu(){
    clear
	green "=========================================================="
   yellow "本脚本仅仅支持：Debian9+ / Ubuntu16.04+"
	 blue "网站：www.v2rayssr.com （已开启禁止国内访问）"
	 blue "YouTube频道：波仔分享"
	green "=========================================================="
   yellow "简介：一键设置Google SSH工具登录 2020-03-27"
   yellow "教程: https://www.v2rayssr.com/googlessh.html"
	green "=========================================================="
     blue "1. 一键设置Google SSH工具登录"
   yellow "0. 退出脚本"
    echo
    read -p "请输入数字:" num
    case "$num" in
    	1)
		google_ssh
		;;
		0)
		exit 0
		;;
		*)
	clear
	echo "请输入正确数字"
	sleep 2s
	start_menu
	;;
    esac
}
start_menu
