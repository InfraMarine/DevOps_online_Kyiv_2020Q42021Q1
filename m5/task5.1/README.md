##### Task1. Part1

1. Log in to the system as root.
2. Use the passwd command to change the password. Examine the basic parameters of the command. What system file does it change *?

  It changes _/etc/passwd_ file.
  
3. Determine the users registered in the system, as well as what commands they execute. What additional information can be gleaned from the command execution?

Registeredd users are in /etc/passwd:

	```
	root@ubuntu:~# less /etc/passwd
	...
	landscape:x:109:115::/var/lib/landscape:/usr/sbin/nologin
	pollinate:x:110:1::/var/cache/pollinate:/bin/false
	sshd:x:111:65534::/run/sshd:/usr/sbin/nologin
	systemd-coredump:x:999:999:systemd Core Dumper:/:/usr/sbin/nologin
	jita:x:1000:1000:Ruh:/home/jita:/bin/bash
	lxd:x:998:100::/var/snap/lxd/common/lxd:/bin/false
	roma:x:1001:1001::/home/roma:/bin/sh
	mysql:x:112:118:MySQL Server,,,:/nonexistent:/bin/false
	(END)
	```

  Also list users (logged in) and command they exucute can be obtained with `w` command:

	```
	root@ubuntu:~# w
	 16:06:22 up  3:56,  2 users,  load average: 0.06, 0.02, 0.00
	USER     TTY      FROM             LOGIN@   IDLE   JCPU   PCPU WHAT
	root     pts/0    10.0.2.2         12:23    4.00s  0.06s  0.00s w
	jita     pts/1    10.0.2.2         16:06   12.00s  0.09s  0.03s vim
	```
  
4. Change personal information about yourself.

	```
	jita@ubuntu:~$ chfn
	Password:
	Changing the user information for jita
	Enter the new value, or press ENTER for the default
			Full Name: Ruh
			Room Number []: 1
			Work Phone []:
			Home Phone []:
	```

5. Become familiar with the Linux help system and the man and info commands.
Get help on the previously discussed commands, define and describe any two keys for these commands. Give examples.

* passwd

  * -S - display account status information (-a for all accounts)
  
  ```
	jita@ubuntu:~$ passwd -S
	jita P 12/20/2020 0 99999 7 -1
  ```
  
  * -l, --lock                    lock the password of the named account
  `passwd -l roma` 
  
* w
  
  * -h	do not print header

  
  * -s, --short         short format

```  
	jita@ubuntu:~$ w -sh
	root     pts/0    10.0.2.2         20:44  -bash
	jita     pts/1    10.0.2.2          2.00s w -sh
```
  
6. Explore the more and less commands using the help system. View the contents of files .bash* using commands.

> Enter `:n` to navigate to next file, `:p` - previous

7. * Describe in plans that you are working on laboratory work 1. _Tip: You should read the documentation for the `finger` command_.

```
jita@ubuntu:~$ echo "Gota go fast (no)" > .plan
jita@ubuntu:~$ finger jita
Login: jita                             Name: Ruh
Directory: /home/jita                   Shell: /bin/bash
Office: 1
On since Sat Jan 16 16:06 (UTC) on pts/1 from 10.0.2.2
   2 seconds idle
No mail.
Plan:
Gota go fast (no)
```

8. * List the contents of the home directory using the ls command, define its files and directories. Hint: Use the help system to familiarize yourself with the ls command.

```
jita@ubuntu:~$ ls -a
.           .bash_history  .cache    .mysql_history  .sudo_as_admin_successful
..          .bash_logout   dir1      .profile        .viminfo
backup.sql  .bashrc        init.sql  .ssh            .Xauthority		
```
  
#### Task1.Part2

1. Examine the tree command. Master the technique of applying a template, for example, display all files that contain a character _c_, or files that contain a specific sequence of characters.

```
jita@ubuntu:~$ tree -P *ss* --prune /etc/
/etc/
├── alternatives
│   ├── lzless -> /usr/bin/xzless
│   └── lzless.1.gz -> /usr/share/man/man1/xzless.1.gz
├── apparmor.d
│   └── abstractions
│       ├── dbus-accessibility
│       ├── dbus-accessibility-strict
│       ├── dbus-session
│       ├── dbus-session-strict
```

List subdirectories of the root directory up to and including the second nesting level.

```
jita@ubuntu:~$ tree -dL 2 /
/
├── bin -> usr/bin
├── boot
│   └── grub
├── cdrom
├── dev
│   ├── block
│   ├── bsg
│   ├── bus
│   ├── char
│   ├── disk
│   ├── dri
│   ├── fd -> /proc/self/fd
```

2. What command can be used to determine the type of file (for example, text or binary)? Give an example.

> `ls -l`:
_
- : regular file.
d : directory.
c : character device file.
b : block device file.
l : symbolic link
_

```
jita@ubuntu:~$ ls -l /dev/
total 0
crw-r--r-- 1 root root     10, 235 Jan 16 12:10 autofs
drwxr-xr-x 2 root root         280 Jan 16 12:09 block
drwxr-xr-x 2 root root          80 Jan 16 12:09 bsg
crw-rw---- 1 root disk     10, 234 Jan 16 12:10 btrfs-control
drwxr-xr-x 3 root root          60 Jan 16 12:10 bus
lrwxrwxrwx 1 root root           3 Jan 16 12:10 cdrom -> sr0
...
brw-rw---- 1 root disk      8,   2 Jan 16 12:10 sda2
...
```

3. Master the skills of navigating the file system using relative and absolute paths.
How can you go back to your home directory from anywhere in the filesystem?

> `cd ~`

4. Become familiar with the various options for the ls command.
Give examples of listing directories using different keys. Explain the information displayed on the terminal using the -l and -a switches.

-a - display hidden files

```
jita@ubuntu:~$ ls -la
total 76
drwxr-xr-x 5 jita jita 4096 Jan 16 18:20 .
drwxr-xr-x 3 root root 4096 Dec 20 19:57 ..
-rw-rw-r-- 1 jita jita 4127 Jan  3 19:45 backup.sql
-rw------- 1 jita jita 1776 Jan 13 21:58 .bash_history
```
> Fields are: first letter is a file type, permissions, number of hard links, owner, group, size(b), date of last modification, name

5. Perform the following sequence of operations:
  - create a subdirectory in the home directory;
  - in this subdirectory create a file containing information about directories located in the root directory (using I/O redirection operations);
  - view the created file;
  - copy the created file to your home directory using relative and absolute addressing.
  - delete the previously created subdirectory with the file requesting removal;
  - delete the file copied to the home directory.

```
jita@ubuntu:~$ ls / > subd/info
jita@ubuntu:~$ cat subd/info
bin
boot
cdrom
dev
etc
home
lib
...
jita@ubuntu:~$ cp /home/jita/subd/info .
jita@ubuntu:~$ ls
backup.sql  dir1  info  init.sql  subd
jita@ubuntu:~$ rm -r subd/
jita@ubuntu:~$ rm info
jita@ubuntu:~$ ls
backup.sql  dir1  init.sql
```

6. Perform the following sequence of operations:
  
  - create a subdirectory test in the home directory;
  - copy the .bash_history file to this directory while changing its name to labwork2;
  - create a hard and soft link to the labwork2 file in the test subdirectory;
  - how to define soft and hard link, what do these concepts mean;
```  
jita@ubuntu:~/test$ ln labwork2 hard
jita@ubuntu:~/test$ ln -s hard soft
jita@ubuntu:~/test$ ls -l
total 8
-rw------- 2 jita jita 1776 Jan 16 19:56 hard
-rw------- 2 jita jita 1776 Jan 16 19:56 labwork2
lrwxrwxrwx 1 jita jita    4 Jan 16 20:01 soft -> hard
```
  - change the data by opening a symbolic link. What changes will happen and why
  
  source file will be changed
  
  - rename the hard link file to hard_lnk_labwork2;
  
  Soft link breaks when hard link name changes
  
  - rename the soft link file to symb_lnk_labwork2 file;
  - then delete the labwork2. What changes have occurred and why?
  
  File content is still acessible via hard link. File content on disk (referred by inode) will live untill hard links to him exist.
  
7. Using the locate utility, find all files that contain the squid and traceroute sequence.

```
jita@ubuntu:~$ sudo locate squid traceroute
/etc/alternatives/traceroute6
/etc/alternatives/traceroute6.8.gz
/usr/bin/traceroute6
/usr/bin/traceroute6.iputils
/usr/lib/modules/5.4.0-58-generic/kernel/drivers/tty/n_tracerouter.ko
/usr/lib/modules/5.4.0-60-generic/kernel/drivers/tty/n_tracerouter.ko
/usr/share/man/man8/traceroute6.8.gz
/usr/share/man/man8/traceroute6.iputils.8.gz
/usr/share/sosreport/sos/plugins/__pycache__/squid.cpython-38.pyc
/usr/share/sosreport/sos/plugins/squid.py
/usr/share/vim/vim81/syntax/squid.vim
/var/lib/dpkg/alternatives/traceroute6
```

8. Determine which partitions are mounted in the system, as well as the types of these partitions.

```
jita@ubuntu:~$ lsblk
NAME   MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
loop0    7:0    0 55.4M  1 loop /snap/core18/1944
loop1    7:1    0   55M  1 loop /snap/core18/1880
loop2    7:2    0 71.3M  1 loop /snap/lxd/16099
loop3    7:3    0 67.8M  1 loop /snap/lxd/18150
loop4    7:4    0 31.1M  1 loop /snap/snapd/10492
loop5    7:5    0 31.1M  1 loop /snap/snapd/10707
sda      8:0    0    4G  0 disk
├─sda1   8:1    0    1M  0 part
└─sda2   8:2    0    4G  0 part /
sr0     11:0    1 1024M  0 rom
```

9. Count the number of lines containing a given sequence of characters in a given file.

```
jita@ubuntu:~$ cat .bash_history | grep -c 'ls'
27
```

10. Using the findcommand, find all files in the /etc directory containing the **host** character sequence.

```
jita@ubuntu:~$ find /etc -name *host*
/etc/hosts.allow
/etc/cloud/templates/hosts.suse.tmpl
/etc/cloud/templates/hosts.freebsd.tmpl
/etc/cloud/templates/hosts.redhat.tmpl
/etc/cloud/templates/hosts.debian.tmpl
/etc/hostname
...
```

11. List all objects in /etc that contain the *ss* character sequence. How can I duplicate a similar command using a bunch of grep?

`find /etc -name *ss*`

`ls -R /etc/ | grep ss`

12. Organize a screen-by-screen print of the contents of the /etc directory. Hint: You must use stream redirection operations.

`ls /etc | less`

13. What are the types of devices and how to determine the type of device? Give examples.

With `ls -l /dev` output first letter (for a device):

  * c - character (transfer of data char by char)
  
  `crw-r--r-- 1 root root     10, 235 Jan 16 12:10 autofs`

  * b - block
  
  `brw-rw---- 1 root disk      8,   0 Jan 16 12:10 sda`
	
14. How to determine the type of file in the system, what types of files are there?

With `ls -l` command. There are regular files, directories, soft links, sockets. See 2. 

15. List the first 5 directory files that were recently accessed in the /etc directory.

```
jita@ubuntu:~$ ls -t /etc | head -n 5
alternatives
cron.daily
passwd
passwd-
shadow
```