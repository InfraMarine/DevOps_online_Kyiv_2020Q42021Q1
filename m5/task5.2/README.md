### Module 5

### Task2 

1. Analyze the structure of the _/etc/passwd_ and _/etc/group_ file, what fields are present in it, what users exist on the system?
Specify several pseudo-users, how to define them?

* _/etc/passwd_

```
root:x:0:0:root:/root:/bin/bash
daemon:x:1:1:daemon:/usr/sbin:/usr/sbin/nologin
bin:x:2:2:bin:/bin:/usr/sbin/nologin
sys:x:3:3:sys:/dev:/usr/sbin/nologin
...
jita:x:1000:1000:Ruh,1,,:/home/jita:/bin/bash
lxd:x:998:100::/var/snap/lxd/common/lxd:/bin/false
roma:x:1001:1001::/home/jita:/bin/sh
mysql:x:112:118:MySQL Server,,,:/nonexistent:/bin/false
```

Fields are:
  * Username
  * x means password is stored in /etc/shadow
  * User ID
  * Group ID
  * User info
  * Home directory
  * Shell

There always is admin **root** user, regular users and system users, such as _sys_, _mysql (usually with _nologin_ shell) 

* _/etc/group_

> Here _jita_ is a user with sudo priveleges

```
root:x:0:
daemon:x:1:
bin:x:2:
sys:x:3:
adm:x:4:syslog,jita
tty:x:5:
...
sudo:x:27:jita
...
jita:x:1000:
roma:x:1001:
vboxsf:x:117:
mysql:x:118:
```

Fields are:
  * Group name
  * Password
  * Group ID (GID)
  * List of users who are members of the group

Pseudo (system) users can be created with `useradd -r <username>`

2. What are the uid ranges? What is UID? How to define it?
3. What is GID? How to define it?
4. How to determine belonging of user to the specific group? 
GID is a group unique id.
There are reserved UID (User identifier - unique number) range for system users from 1 to 999 (0 is root), and range from 1000 are available to regular login users

`id` command shows info about current user such as UID, groups it belongs and their GID 

```
jita@ubuntu:~$ id
uid=1000(jita) gid=1000(jita) groups=1000(jita),4(adm),24(cdrom),27(sudo),30(dip),46(plugdev),116(lxd)
```

5. What are the commands for adding a user to the system? What are the basic parameters required to create a user?

There are primitive `useradd` where you need to specify all parameters.  
And `adduser` - more advanced and interactive way to create a user, basically a perl script that uses `useradd` underneath.

Basic parameters are username, homedir, shell. Just username is sufficient when creating a user.

6. How do I change the name (account name) of an existing user?

`usermod -l login-name old-name`

7. What is skell_dir? What is its structure?

The /etc/skel directory contains files and directories that are automatically copied over to a new user’s when it is created from `useradd` command.

Default structure: 

```
jita@ubuntu:~$ ls -a /etc/skel
.  ..  .bash_logout  .bashrc  .profile
```

8. How to remove a user from the system (including his mailbox)?

`userdel -r` - removes user along with his homedir and mailbox

9. What commands and keys should be used to lock and unlock a user account?

`passwd –l <username>`  
`passwd –u <username>`

10. How to remove a user's password and provide him with a password-free login for subsequent password change?

`passwd` `-e` force expire the password for the named account

11. Display the extended format of information about the directory, tell about the information columns displayed on the terminal.

```
root@ubuntu:~# ls -l
total 4
drwxr-xr-x 3 root root 4096 Dec 20 19:57 snap
```

Info are: file type (d means directory), acess rights, user, group, size, last mod date, name

12. What access rights exist and for whom (i. e., describe the main roles)? Briefly describe the acronym for access rights.

Acess rights are for user, group and other.  
rwx – read write execute

13. What is the sequence of defining the relationship between the file and the user?

If user is file owner then user gets user acess rights,  
else if user belongs to file group it get corresponding acess rights,
if user is not owner and not in file group user has acess rights as _others_ 

14. What commands are used to change the owner of a file (directory), as well as the mode of access to the file? Give examples, demonstrate on the terminal.

  * `chown`  - changes owner of a file
  
  ```
  root@ubuntu:~# chown roma /home/jita/test/hard_lnk
  root@ubuntu:~# ls -l /home/jita/test/
  total 4
  -rw------- 1 roma jita 6 Jan 16 20:02 hard_lnk
  lrwxrwxrwx 1 jita jita 4 Jan 16 20:01 soft_lnk -> hard
  ```
  
  * `chmod` - changes acess rights

Addec execute right to user (u):

```  
jita@ubuntu1:~$ ls -l init.sql
-rw-rw-r-- 1 jita jita  653 Jan  3 17:02 init.sql
jita@ubuntu1:~$ chmod u+x init.sql
jita@ubuntu1:~$ ls -l init.sql
-rwxrw-r-- 1 jita jita  653 Jan  3 17:02 init.sql
```
  
15. What is an example of octal representation of access rights? Describe the umask command.

rwx -> 4 + 2 + 1, all rights - 7, no rights = 0

r = 4, w = 2, x = 1

Example:  
rwxrw-r-- = 764

`umask` displays or sets special mask which will be applied to file access rights on creation, thus it is default file access rights

umask is subtractive, so it can only remove access right. If executed command creates file without some permission, mask can not add it.

```
jita@ubuntu1:~$ umask -S
u=rwx,g=rwx,o=rx
```

16. Give definitions of sticky bits and mechanism of identifier substitution. Give an example of files and directories with these attributes.

Special permission are presented by additional digit in octal representation  

Special permissions are:

  * Set user ID  (SUID) - allows to run file with effective UID as file owner - 4 in octal
`chmod u+s`
  * Set group Id (SGUID) - same for group - 2 in octal
`chmod g+s`
  * Sticky bit - Sticky bit means that only file owner or root can delete it - 1 in octal
`chmod +t`


```
jita@ubuntu1:~$ ls -lh init.sql
-rwxrw-r-T 1 jita jita 653 Jan  3 17:02 init.sql
```
Uppercase **T** means that execute right (x) is not set for others (o)

`tmp` directory has sticky bit on it  
```
jita@ubuntu1:~$ ls -ld /tmp
drwxrwxrwt 8 root root 4096 Jan 21 21:24 /tmp
```


17. What file attributes should be present in the command script?

File should have read and execute rights. So it shoud be _r-x_ at least at role file is expected to be executed.