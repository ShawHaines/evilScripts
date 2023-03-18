# cc98_autosign.ps1
# Reads username and password from a list
# and sign in for CC98.
# required password file format:
# in each line, username:password (separated by colon and nothing else)

$pwfile = "cc98_password.txt"
Get-Content $pwfile | ForEach-Object {
    $username,$password = $_ -split ":"
    ./cc98_curl.ps1 $username $password
}
