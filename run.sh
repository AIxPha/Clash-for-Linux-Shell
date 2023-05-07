#!/bin/bash

if [ -d "/root/clash-for-linux" ]; then
    clear
else
    clear
    cd ~
    rm -rf /root/clash-for-linux
    echo -e "\e[1;32m  开始克隆所需文件至本地\e[0m"
    if git clone https://github.com/wanhebin/clash-for-linux.git /root/clash-for-linux; then
echo "alias V='bash <(curl -sL https://raw.githubusercontent.com/AIxPha/Clash-For-Linux-Shell/main/run.sh)'" >> ~/.bashrc
    else
        echo -e "\e[1;31m  克隆失败\e[0m"
        echo -e "\e[1;32m  请科学上网 VPN 代理 魔法\e[0m"
        echo -e "\e[1;33m  反正就是能连上GitHub就行\e[0m"
        exit
    fi
fi

clear
echo "          Clash-For-Linux"
echo "github.com/wanhebin/clash-for-linux"
echo " —————————"
echo -e "   \033[32m1\033[0m.开启代理服务"
echo -e "   \033[32m2\033[0m.关闭代理服务"
echo -e "   \033[32m3\033[0m.重启代理服务"
echo " —————————"
echo -e "   \033[32m4\033[0m.设置订阅链接"
echo " —————————"
echo -e "   \033[32m5\033[0m.检查服务端口"
echo -e "   \033[32m6\033[0m.检查环境变量"
echo " —————————"
echo -e "   \033[32m9\033[0m.删除本地仓库"
echo " —————————"

read -p "请输入对应数字编号：" choice

case $choice in
    1)
    clear
    echo -e "\e[1;36m  少女祈祷中..\e[0m"
    bash /root/clash-for-linux/start.sh
    exit
    ;;

    2)
    clear
    echo -e "\e[1;36m  少女祈祷中..\e[0m"
    bash /root/clash-for-linux/shutdown.sh
    exit
    ;;

    3)
    clear
    echo -e "\e[1;36m  少女祈祷中..\e[0m"
    bash /root/clash-for-linux/restart.sh
    exit
    ;;

    4)
clear
# 先获取 CLASH_URL 的当前值
current_value=$(grep "export CLASH_URL=" /root/clash-for-linux/.env | cut -d "'" -f 2)

echo -e "\e[1;33m  当前订阅链接内容为\e[0m"
echo "$current_value"

echo -e "\e[1;32m  请输入 订阅链接（或直接回车不修改）：\e[0m"
read input

if [ ! -z "$input" ] && [ "$input" != "$current_value" ]; then
  # 如果输入不为空，并且和当前值不一样，则修改 CLASH_URL 的值
  sed -i "s~export CLASH_URL='$current_value'~export CLASH_URL='$input'~" /root/clash-for-linux/.env

  # 判断是否修改成功
  if grep -q "export CLASH_URL='$input'" /root/clash-for-linux/.env; then
    echo -e "\e[1;32m  订阅链接已设置为↓\e[0m"
    echo "$input"
  else
    echo -e "\e[1;33m 设置失败，请检查配置文件\e[0m"
  fi
else
  echo -e "\e[1;36m  已取消设置\e[0m"
fi
exit
    ;;

    5)
    clear
    echo -e "\e[1;31m  如果什么都没显示！\e[0m"
    echo -e "\e[1;33m  那就是你没有开启代理服务\e[0m"
    netstat -tln | grep -E '9090|789.'
    exit
    ;;

    6)
    clear
    echo -e "\e[1;31m  如果什么都没显示！\e[0m"
    echo -e "\e[1;33m  那就是你没有加载环境变量并开启系统代理\e[0m"
    cd /root/clash-for-linux
    env | grep -E 'http_proxy|https_proxy'
    exit
    ;;

    9)
    clear
    sed -i '/alias V/d' ~/.bashrc
    echo -e "\e[1;36m  少女祈祷中..\e[0m"
    bash /root/clash-for-linux/shutdown.sh
    rm -rf /root/clash-for-linux
    exit
    ;;

esac
exit