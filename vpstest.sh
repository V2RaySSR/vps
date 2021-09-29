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

$systemPackage -y install wget curl

vps_superspeed(){
	bash <(curl -Lso- https://git.io/superspeed)
}

vps_zbench(){
	wget -N --no-check-certificate https://raw.githubusercontent.com/FunctionClub/ZBench/master/ZBench-CN.sh && bash ZBench-CN.sh
}

vps_testrace(){
	wget -N --no-check-certificate https://raw.githubusercontent.com/V2RaySSR/vps/master/goback.sh && bash goback.sh
}
vps_LemonBenchIntl(){
        curl -fsL https://ilemonra.in/LemonBenchIntl | bash -s fast
}

start_menu(){
    clear
	green "=========================================================="
     blue " 本脚本支持：CentOS7+ / Debian9+ / Ubuntu16.04+"
	 blue " 网站：www.v2rayssr.com （已开启禁止国内访问）"
	 blue " YouTube频道：波仔分享"
     blue " 此脚本源于网络，波仔只是汇聚脚本功能，方便大家使用而已！"
	green "=========================================================="
   yellow " 简介：VPS综合性能测试脚本 （包含性能、速度、回程路由）"
   yellow " 首发: https://www.v2rayssr.com/vpstest.html"
	green "=========================================================="
      red " 脚本测速会大量消耗 VPS 流量，请悉知！"
    green "=========================================================="
     blue " 1. VPS 三网纯测速    （各取部分节点 - 中文显示）"
     blue " 2. VPS 综合性能测试  （包含测速 - 英文显示）"
	 blue " 3. VPS 回程路由     （四网测试 - 英文显示）"
	 blue " 4. VPS 快速全方位测速（包含性能、回程、速度 - 英文显示）"
   yellow " 0. 退出脚本"
    echo
    read -p "请输入数字:" num
    case "$num" in
    	1)
		vps_superspeed
		;;
		2)
		vps_zbench
		;;
		3)
		vps_testrace
		;;
		4)
		vps_LemonBenchIntl
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
