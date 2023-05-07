printf 'Processor: '; cat /proc/cpuinfo|grep processor|wc -l
cat /proc/cpuinfo|grep 'model name'|head -1
cat /proc/meminfo|head; uname -a
echo; df -hT; echo; sudo dmesg -T|head; echo; swapon -v; echo

remove() {
	echo "::Delete '$@'"
	sudo rm -rf $@
}


echo
df -Th
echo
sudo apt update &>/dev/null
sudo apt install smartmontools -y
echo
echo
sudo smartctl -a `findmnt /|awk '/dev/{print$2}'` -T permissive || true
echo
echo
sudo smartctl -a `findmnt /mnt|awk '/dev/{print$2}'` -T permissive || true
echo
ls -l `findmnt /|awk '/dev/{print$2}'`
ls -l `findmnt /mnt|awk '/dev/{print$2}'`
echo


run() {
	echo "::Run '$@':"
	$@
	echo
}

case $(lsb_release --id) in *Ubuntu*)
	remove /usr/share/swift
	remove /usr/share/miniconda
	remove /usr/share/dotnet
	remove /usr/local
	remove /opt/hostedtoolcache
	run df -Th
	run lsb_release -a
;;
esac
lsb_release --id
