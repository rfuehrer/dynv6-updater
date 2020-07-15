#!/bin/sh -e
# based on https://gist.github.com/corny/7a07f5ac901844bd20c9

hostname=$1
device=$2

v4_file=$HOME/.${hostname}.dynv6.addr4

[ -e $v4_file ] && old=`cat $v4_file`

if [ -z "$hostname" -o -z "$token" ]; then
  echo "Usage: token=<your-authentication-token> $0 your-name.dynv6.net [device]"
  exit 1
fi

if [ -n "$device" ]; then
  device="dev $device"
fi

#v4_address=$(ip -4 addr list $device | grep "global" | sed -n 's/.*inet \([0-9.]\+\).*/\1/p' | head -n 1);
v4_address=$(curl -sS http://my.ip.fi);

if [ -e /usr/bin/curl ]; then
  bin="curl -fsS -o /dev/null"
elif [ -e /usr/bin/wget ]; then
  bin="wget -qO-"
else
  echo "neither curl nor wget found"
  exit 1
fi

if [ -z "$v4_address" ]; then
  echo "no IPv4 address found"
  exit 1
fi

current=$v4_address
echo "detected address ${current}, validating..."

if [ "$old" = "$current" ]; then
  # when running via cron we do not need that kind of verbosity.
  #echo "IPv4 address unchanged"
  exit
fi

echo "new ipv4 address detected ${v4_address}, updating"

# send addresses to dynv6
$bin "http://ipv4.dynv6.com/api/update?hostname=$hostname&ipv4=$v4_address&token=$token"

# save current address
echo $current > $v4_file