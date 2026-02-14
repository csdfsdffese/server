#!/bin/bash

# 颜色
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'

soga_setup() {
    read -p "节点ID: " node_id
    read -p "授权码: " soga_key
    read -p "域名: " webapi_domain
    read -p "webapi_key: " webapi_key
    read -p "redis地址: " redis_addr
    read -p "redis密码: " redis_password
    bash <(curl -Ls https://raw.githubusercontent.com/vaxilu/soga/master/install.sh) || return 1
    cat > /etc/soga/soga.conf <<EOF
type=xboard
server_type=vless
node_id=${node_id}
soga_key=${soga_key}
api=webapi
webapi_url=https://${webapi_domain}
webapi_key=${webapi_key}
proxy_protocol=false
user_conn_limit=0
user_speed_limit=0
user_tcp_limit=0
node_speed_limit=0
check_interval=60
submit_interval=60
forbidden_bit_torrent=true
log_level=info
auto_update=true
force_close_ssl=true
block_list_url=https://h5ai.huanying706.com/soga/blockList
EOF
    soga restart
}

show_menu() {
    clear
    echo "1. 对接 soga"
    echo "0. 退出"
}

# ===== 主逻辑 =====
main() {
    while true; do
        show_menu
        read -p "选择 [0-8]: " choice
        case $choice in
            1) soga_setup ;;
            0) exit 0 ;;
        esac
        read -p "按回车继续..."
    done
}

main
