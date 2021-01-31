adduser brotherscanner --disabled-password --force-badname --gecos ""

#mkdir -p /scans
#chmod 777 /scans

chmod -R 777 /home/brotherscanner *
env > /opt/brother/scanner/env.txt
su - brotherscanner -c "brsaneconfig4 -a name=$NAME model=$MODEL ip=$IPADDRESS"
sleep 1000
su - brotherscanner -c "brscan-skey -t"
sleep 1000
su - brotherscanner -c "brscan-skey"
sleep 1000
su - brotherscanner -c "brscan-skey -l"
while true;
do
  sleep 1000
done
exit 0
