#!/bin/bash

ipaddr=`ifconfig |grep -oh "172.30.40.\w"`
sed -i "s/tpl_nodename/verne@$ipaddr/g" /etc/vernemq/vernemq.conf
id=`ifconfig |grep -oh "172.30.40.\w"|cut -d '.' -f 4`
sed -i "s/tpl_graphite_prefix/verne$id/g" /etc/vernemq/vernemq.conf
sed -i "s/tpl_ip/$ipaddr/g" /etc/vernemq/vernemq.conf
vernemq start
vmq-admin plugin enable -n vmq_graphite

