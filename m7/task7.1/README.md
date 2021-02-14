### Linux administration with bash. Home task

#### A. Create a script that uses the following keys:

1. When starting without parameters, it will display a list of possible keys and their description.
2. The --all key displays the IP addresses and symbolic names of all hosts in the current subnet
3. The --target key displays a list of open system TCP ports.  
The code that performs the functionality of each of the subtasks must be placed in a separate function

[script 1](script1.sh)

Script output:

```
jita@ubuntux:~$ ./script1 --all --target
Hosts in current network:
_gateway (10.0.2.2)

Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State
tcp        0      0 127.0.0.53:53           0.0.0.0:*               LISTEN
tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN
tcp        0      0 0.0.0.0:23              0.0.0.0:*               LISTEN
tcp        0      0 127.0.0.1:6010          0.0.0.0:*               LISTEN
tcp6       0      0 :::22                   :::*                    LISTEN
tcp6       0      0 ::1:6010                :::*                    LISTEN

jita@ubuntux:~$ ./script1
Usage: script1
  [ --all displays the IP addresses and symbolic names of all hosts in the current subnet]
  [ --target displays a list of open system TCP port]
jita@ubuntux:~$ ./script1 --all
Hosts in current network:
_gateway (10.0.2.2)

```

Code:

```
#!/bin/bash
usage()
{
  echo "Usage: script1
  [ --all displays the IP addresses and symbolic names of all hosts in the current subnet]
  [ --target displays a list of open system TCP port]"
}
show_tcp_ports()
{
  netstat -tln
}
show_hosts()
{
  echo "Hosts in current network:"
  arp -a | cut -d" " -f1-2
}
parsed=$(getopt -qau -o "" -l all,target -- "$@" )
if [[ $? -ne 0 || "$parsed" = " --" ]]; then
	usage
	exit 2
fi
while [[ $# -gt 0 ]]; do
	case "$1" in
		--all)
			shift
         	show_hosts
			echo
			;;
	    --target)
			shift
			show_tcp_ports
			echo
			;;
		*)
			break
			;;
	esac
done
```

#### B. Using Apache log example create a script to answer the following questions:

1. From which ip were the most requests?

`awk '{print $1}' example_log.log | sort | uniq -c | sort -r | head -1`

2. What is the most requested page?

`awk '{print $7}' example_log.log | grep .html | uniq -c | sort -r | head -1`

3. How many requests were there from each ip?

`awk '{print $1}' example_log.log | sort | uniq -c | sort`

4. What non-existent pages were clients referred to?

`awk '{print $7" "$9}' example_log.log | grep 404 | grep .html| awk '{ print $1}' | uniq`

5. What time did site get the most requests?

`grep "25/Apr" example_log.log | cut -d[ -f2 | cut -d] -f1 | awk -F: '{print $2":00"}' | sort -n | uniq -c | sort -rn | head -1`

6. What search bots have accessed the site? (UA + IP)

`cat example_log.log | cut -f12- -d" " | grep bot | sort | uniq -c | sort -n`

Final script is similar to task A by structure and uses oneliners from above as functions called with specific option.

[script 2](analize.sh)

Output:
  
```
jita@ubuntux:~$ ./analize
Options:
  -i show how many requests from each ip
  -I show ip with most requests
  -p show the most requested page
  -e show non-existent pages were clients referred to
  -t time site got the most requests
  -b what search bots have accessed the site

jita@ubuntux:~$ ./analize -t
    253 11:00
jita@ubuntux:~$ ./analize -I
      9 93.170.253.156
jita@ubuntux:~$
```

#### C. Create a data backup script that takes the following data as parameters:

1. Path to the syncing  directory.

2. The path to the directory where the copies of the files will be stored.

In case of adding new or deleting old files, the script must add a corresponding entry to the log file indicating the time, 
type of operation and file name. [The command to run the script must be added to crontab with a run frequency of one minute]

[script 3](script3.sh)

Used `rsync` as core for script:

`rsync -rui  --delete --exclude=bkup --out-format="%t %i %f" --backup-dir=bkup $1 $2 >> ~/sync.log`

  * -r needed to traverse recursively through directories 
  * -u with --delete syncs source and target - if file is deleted from source so it is from target
  * --backup-dir makes files to be stored in backup-dir instead of deleting (also exluded this dir because it backups itself somehow)

```
jita@ubuntux:~$ ls source
file1  file2  file3
jita@ubuntux:~$ ./script3.sh source/ target/
jita@ubuntux:~$ ls target/
file1  file2  file3
jita@ubuntux:~$ rm source/file3
```

After some time folders are again synced :

```
jita@ubuntux:~$ ls -R target/
target/:
bkup  file1  file2

target/bkup:
file3
```

Output from rsync is stored in log file at users home directory.

[log file](sync.log)

```
jita@ubuntux:~$ cat sync.log
2021/02/14 16:12:47 cd+++++++++ source/.
2021/02/14 16:12:47 >f+++++++++ source/file1
2021/02/14 16:12:47 >f+++++++++ source/file2
2021/02/14 16:12:47 >f+++++++++ source/file3
2021/02/14 16:14:01 *deleting   file3
```

After scripts start user has to reload cron service: `sudo service cron reload`.  
Task is successully added to crontab tasks. (Can be deleted with `crontab -e`)

```
jita@ubuntux:~$ crontab -l
* * * * * rsync -rui  --delete --exclude=bkup --out-format="\%t \%i \%f" --backup-dir=bkup source/ target/ >> ~/sync.log
```
