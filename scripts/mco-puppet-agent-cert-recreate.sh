#!/bin/bash

for host in `cat /root/hosts.txt`
do

host1=`/bin/echo $host | tr '[:upper:]' '[:lower:]'`
echo $host
echo $host1
sslpath="/var/lib/puppet/ssl"

#mco service -I $host puppet restart | grep "errors" && exit 1
sleep 3 && mco service -I $host puppet stop

echo "$sslpath/certs/ca.pem"
mco rpc filemgr remove file=$sslpath/certs/ca.pem -I $host
echo "$sslpath/certs/$host.pem"
mco rpc filemgr remove file=$sslpath/certs/$host1.pem -I $host
echo "$sslpath/certificate_requiests/$host.pem"
mco rpc filemgr remove file=$sslpath/certificate_requests/$host1.pem -I $host
echo "$sslpath/crl.pem"
mco rpc filemgr remove file=$sslpath/crl.pem -I $host
echo "$sslpath/private_keys/$host.pem"
mco rpc filemgr remove file=$sslpath/private_keys/$host1.pem -I $host
echo "$sslpath/public_keys/$host.pem"
mco rpc filemgr remove file=$sslpath/public_keys/$host1.pem -I $host

mco service -I $host puppet start

done
