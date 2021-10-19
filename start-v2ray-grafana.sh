#!/bin/bash
# 安装v2ray-exporter
wget -O /tmp/v2ray-exporter https://github.com/wi1dcard/v2ray-exporter/releases/latest/download/v2ray-exporter_linux_amd64
mv /tmp/v2ray-exporter /usr/local/bin/v2ray-exporter
chmod +x /usr/local/bin/v2ray-exporter
# 安装promethus
wget -O /tmp/prometheus.tar.gz https://github.com/prometheus/prometheus/releases/download/v2.30.3/prometheus-2.30.3.linux-amd64.tar.gz
tar -xvzf prometheus.tar.gz
mv /tmp/prometheus-2.30.3.linux-amd64/prometheus /usr/local/bin/promethus
chmod +x /usr/local/bin/promethus
echo "安装程序完成"
# 安装必要配置
mkdir -p /etc/prometheus
rm -f /etc/prometheus/prometheus.yml
wget -O /etc/prometheus/prometheus.yml https://raw.githubusercontent.com/masachi/v2ray-exporter/master/prometheus.yml
echo "安装配置完成"
# 启动服务
nohup v2ray-exporter --v2ray-endpoint "127.0.0.1:10080" > /var/log/v2ray-exporter.log 2>&1 &
nohup prometheus --config.file /etc/prometheus/prometheus.yml --web.external-url=/v2ray > /var/log/prometheus.log 2>&1 &
echo "启动服务结束"
