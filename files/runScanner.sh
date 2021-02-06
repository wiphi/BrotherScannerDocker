SCRIPT_DIR=/opt/brother/scanner/brscan-skey/script
SCRIPT_TMP_DIR=/tmp/script
echo add brotherscanner user
# restore scripts, don't overwrite existing (-n)
#cp -v -n $SCRIPT_TMP_DIR/* $SCRIPT_DIR

adduser brotherscanner --disabled-password --force-badname --gecos ""

chmod -R 777 /home/brotherscanner
echo save environment
env > /opt/brother/scanner/env.txt
echo change user and start scanner app
echo config scanner
su - brotherscanner -c "brsaneconfig4 -a name=$NAME model=$MODEL ip=$IPADDRESS"
echo start scanner
su - brotherscanner -c "brscan-skey -t"
su - brotherscanner -c "brscan-skey"
echo skey is running...
su - brotherscanner -c "brscan-skey -l"
echo waiting for  your docs...
while true;
do
  sleep 1000
done
exit 0
