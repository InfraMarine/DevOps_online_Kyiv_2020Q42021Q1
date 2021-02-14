#/bin/bash

if [ $# -lt 2 ]; then
        echo "Usage script3 <source dir> <target dir>"
	exit 2
fi

[ ! -d "$1" ] && echo "Directory /path/to/dir DOES NOT exists."

rsync -rui  --delete --exclude=bkup --out-format="%t %i %f" --backup-dir=bkup $1 $2 >> ~/sync.log


(crontab -l ; echo "* * * * * rsync -rui  --delete --exclude=bkup --out-format=\"\%t \%i \%f\" --backup-dir=bkup $1 $2 >> ~/sync.log ") | crontab -

