## Module 2 Virtualization and Cloud Basic

### TASK 2.2

* Create and attach a Disk_D (EBS)to your instance to add more storage space. Create and save some file on Disk_D.

  * Instance with volume attached:

  ![disc attached](screens/t2.png)
  
  * mounting and file creation:
  
 ``` 
[centos@ip-172-31-32-80 ~]$ lsblk
NAME    MAJ:MIN RM SIZE RO TYPE MOUNTPOINT
xvda    202:0    0   8G  0 disk
└─xvda1 202:1    0   8G  0 part /
xvdf    202:80   0   1G  0 disk
[centos@ip-172-31-32-80 ~]$ sudo mkfs -t xfs /dev/xvdf
meta-data=/dev/xvdf              isize=512    agcount=4, agsize=65536 blks 
		 =                       sectsz=512   attr=2, projid32bit=1
		 =                       crc=1        finobt=0, sparse=0
data     =                       bsize=4096   blocks=262144, imaxpct=25
		 =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=4096   ascii-ci=0 ftype=1
log      =internal log           bsize=4096   blocks=2560, version=2
		 =                       sectsz=512   sunit=0 blks, lazy-count=1
realtime =none                   extsz=4096   blocks=0, rtextents=0
[centos@ip-172-31-32-80 ~]$ sudo mkdir /media/d 
[centos@ip-172-31-32-80 ~]$ sudo mount /dev/xvdf /media/d
[centos@ip-172-31-32-80 ~]$ sudo chmod 777 /media/d
[centos@ip-172-31-32-80 ~]$ echo "Hi" > /media/d/somefile                                                   
[centos@ip-172-31-32-80 ~]$ cat /media/d/somefile  
Hi
```
