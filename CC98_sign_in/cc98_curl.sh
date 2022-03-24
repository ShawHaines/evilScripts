# cc98_curl.sh
# Automatically helps you sign in to CC98 with your given username and password
# usage: cc98_curl.sh username password
username=$1
password=$2
# Login with username and password, extracts and stores token in a variable.
token=$(curl https://openid.cc98.org/connect/token -d "client_id=9a1fd200-8687-44b1-4c20-08d50a96e5cd&client_secret=8b53f727-08e2-4509-8857-e34bf92b27f2&grant_type=password" --data-urlencode "username=${username}" --data-urlencode "password=${password}" | sed 's/.*"access_token":"\([^"]*\)".*/Bearer \1/')
# post message to sign in api.
# pre-flight
# curl -X OPTIONS --header "access-control-request-headers: authorization,content-type" --header "access-control-request-method: POST" -v # Not necessary
coins=$(curl -X POST --header "content-length:0" --header "content-type:application/json" --header "authorization:$token" https://api.cc98.org/me/signin)
# log
echo "CC98 signed in for ${username} at" $(date "+%Y-%m-%d %H:%M:%S")", and got \$${coins}". >> log.txt