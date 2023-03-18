# nhd_autosign.ps1
# Reads username and password from a list
# and sign in for NexusHD.
# required password file format:
# in each line, username:password (separated by colon and nothing else)

$pwfile = "nhd_password.txt"
Get-Content $pwfile | ForEach-Object {
    $username,$password = $_ -split ":"
    ./nhd_curl.ps1 $username $password
}