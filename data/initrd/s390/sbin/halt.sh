for i in /sbin/halt /sbin/reboot /sbin/shutdown
do
	mv $i $i.sh
	mv $i.bin $i
done
if ps -C init >/dev/null
then
	echo "Init is running, calling $command $*"
	exec $0 "$@"
fi
echo "Syncing all buffers..."
sync ; sync
sleep 1
echo "Sending KILL signal to linuxrc for shutdown..."
LXRC_PID=`cat /var/run/linuxrc.pid`
kill -9 $LXRC_PID
