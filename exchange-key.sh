read -p "Hostname:" hostname

read -p "Host IP Address:" ipAddress

read -p "Password:" passwd

echo "Transferring key..."

sshpass -p $passwd scp ~/.ssh/id_ed25519.pub $hostname@$ipAddress:~/.ssh/administrators_authorized_keys

if [ $? -ne 0 ]; then
    echo "Error in transferring key"
    exit 1
fi
echo "Key transferred successfully"

echo "Transferring move-file.bat..."

sshpass -p $passwd scp ~/.ssh/move-file.bat $hostname@$ipAddress:~/.ssh/move-file.bat

if [ $? -ne 0 ]; then
    echo "Error in transferring move-file.bat"
    exit 1
fi
echo "Transferred bat file successfully"

echo "Establishing connection with server..."
sshpass -p $passwd ssh $hostname@$ipAddress "cd %HOME%\.ssh && cmd.exe /c move-file.bat && del move-file.bat"

if [ $? -ne 0 ]; then
    echo "Error in moving key file. [Host side]"
    exit 1
fi

echo Connected to $hostname and moved auth_key to correct location

