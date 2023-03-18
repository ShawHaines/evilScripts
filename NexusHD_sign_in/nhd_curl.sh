#!/bin/sh
# nhd_curl.sh
# Automatically helps you sign in to NexusHD with your given username and password
# usage: nhd_curl.sh username password
username=$1
password=$2
cookies="${username}_cookies.txt"
# Login with username and password, sets auto jump, stores cookies in cookies file.
curl -d "username=${username}&password=${password}&logout=yes" -L -c $cookies http://www.nexushd.org/takelogin.php -e http://www.nexushd.org/login.php
# send message [em176][em52] to sign in.
curl -b $cookies --data-urlencode "action=post" --data-urlencode "content=[em176][em52]" http://www.nexushd.org/signin.php

# Use this address instead for ipv6 accessing.
# curl -d "username=${username}&password=${password}&logout=yes" -L -c $cookies https://v6.nexushd.org/takelogin.php -e https://v6.nexushd.org/login.php
# curl -b $cookies --data-urlencode "action=post" --data-urlencode "content=[em176][em52]" https://v6.nexushd.org/signin.php

# log
echo "NHD signed in for ${username} at" $(date "+%Y-%m-%d %H:%M:%S") >> log.txt