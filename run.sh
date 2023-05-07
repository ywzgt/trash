printf 'Processor: '; cat /proc/cpuinfo|grep processor|wc -l
cat /proc/cpuinfo|grep 'model name'|head -1
cat /proc/meminfo|head; uname -a
echo; df -hT; echo; sudo dmesg -T|head; echo; swapon -v; echo

remove() {
	echo "::Delete '$@'"
	sudo rm -rf $@
}


remove /usr/share/swift
remove /usr/share/miniconda
remove /usr/share/dotnet
remove /usr/local
remove /opt/hostedtoolcache


echo
df -Th
echo
sudo apt update &>/dev/null
sudo apt install smartmontools -y
echo
echo
sudo smartctl -a `findmnt /|awk '/dev/{print$2}'`
echo
echo
sudo smartctl -a `findmnt /mnt|awk '/dev/{print$2}'`
echo
ls -l `findmnt /|awk '/dev/{print$2}'`
ls -l `findmnt /mnt|awk '/dev/{print$2}'`
echo

git config --global user.name 'github-actions'
git config --global user.email 'noreply@github.com'
git add .
git commit -m "Action $(date -u)"
git push origin main
