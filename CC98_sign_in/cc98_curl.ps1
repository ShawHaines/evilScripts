# cc98_curl.ps1
# Automatically helps you sign in to CC98 with your given username and password
# usage: .\cc98_curl.ps1 username password

$Username = $args[0]
$Password = $args[1]

# Login with username and password, extracts and stores token in a variable.
$Token = curl https://openid.cc98.org/connect/token -d "client_id=9a1fd200-8687-44b1-4c20-08d50a96e5cd&client_secret=8b53f727-08e2-4509-8857-e34bf92b27f2&grant_type=password" --data-urlencode "username=$Username" --data-urlencode "password=$Password" | Select-String -Pattern 'access_token":"(.+?)"' | Foreach-Object { "Bearer $($_.Matches.Groups[1].Value)" }

# post message to sign in api.
# pre-flight
# Invoke-WebRequest -Uri "https://api.cc98.org/me/signin" -Method OPTIONS -Headers @{ "Access-Control-Request-Headers" = "authorization,content-type"; "Access-Control-Request-Method" = "POST" }

$Coins = curl -X POST --header "content-length:0" --header "content-type:application/json" --header "authorization:$Token" https://api.cc98.org/me/signin

# log
Add-Content -Path "log.txt" -Value "CC98 signed in for $Username at $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss'), and got `$${Coins.Content}."
