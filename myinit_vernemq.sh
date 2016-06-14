#!/bin/bash

ipaddr=`ifconfig |grep -oh "172.30.40.\w"`
sed -i "s/tpl_nodename/verne@$ipaddr/g" /etc/vernemq/vernemq.conf
sed -i "s/tpl_ip/$ipaddr/g" /etc/vernemq/vernemq.conf
vernemq start


