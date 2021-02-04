### Networking with Linux

1. Create virtual machines connection according to figure 1:

```
	+-----------------+                      
	|    INTERNET     |                      
	|                 |                      
	+-----------------+                      
			|                               
			|                               
	 +------|-----+                         
	 |    HOST    |                         
	 +------------+                         
		   |                                
		   |  +-------+           +--------+
		   |  |  VM1  |           | VM2    |
		   |  +-------+           +--------+
		   |  /    |                    |   
		NAT| /     |                    |   
		   +/      |       INTERNAL     |   
				   +--------------------+  
```

> To configure static ip on interface use `netplan` utility, settings file is `/etc/netplan/00-installer-config.yaml` (*in my case, prefix number can differ)
> Configure IP address, gateway and nameserver IP:  
``` 
# This is the network config written by 'subiquity'
network:
  ethernets:
    enp0s3:
      dhcp4: false
      addresses: [192.168.0.2/24]
      gateway4: 192.168.0.1
      nameservers:
        addresses: [8.8.8.8,8.8.4.4]
  version: 2
```

2. VM2 has one interface (internal), VM1 has 2 interfaces (NAT and internal). 
Configure  all network interfaces in order to make VM2 has an access to the Internet (iptables, forward, masquerade).

  * in _/etc/sysctl.conf_ uncomment or write:  
  `net.ipv4.ip_forward=1`  
  `net.ipv6.conf.all.forwarding=1`
  
  And reload with `sudo sysctl -p`
  
  * use _iptables_ to allow masquerading - forward all traffic from network 192.168.0.0/24 to interface _enp0s3_

  `sudo iptables -t nat -A POSTROUTING -s 192.168.0.0/24 -o enp0s3 -j MASQUERADE`
  
3. Check the route from VM2 to Host.

VM can not see host directly.

```
jita@ubuntuy:~$ traceroute 192.168.75.2
traceroute to 192.168.75.2 (192.168.75.2), 30 hops max, 60 byte packets
 1  _gateway (192.168.0.1)  0.324 ms  0.518 ms  0.483 ms
 2  10.0.2.2 (10.0.2.2)  0.731 ms  0.700 ms  0.678 ms
 3  10.0.2.2 (10.0.2.2)  3.026 ms  2.995 ms  2.718 ms
```

4.Check the access to the Internet, (just ping, for example, 8.8.8.8).

```
jita@ubuntuy:~$ping 8.8.8.8
PING 8.8.8.8 (8.8.8.8) 56(84) bytes of data.
64 bytes from 8.8.8.8: icmp_seq=1 ttl=117 time=29.5 ms
64 bytes from 8.8.8.8: icmp_seq=2 ttl=117 time=36.4 ms
^C
--- 8.8.8.8 ping statistics ---
2 packets transmitted, 2 received, 0% packet loss, time 1001ms
rtt min/avg/max/mdev = 29.474/32.950/36.427/3.476 ms
```

5. Determine, which  resource has an IP address 8.8.8.8.

It is Google DNS server IP

```
jita@ubuntuy:~$ dig -x 8.8.8.8

; <<>> DiG 9.16.1-Ubuntu <<>> -x 8.8.8.8
...
;; QUESTION SECTION:
;8.8.8.8.in-addr.arpa.          IN      PTR

;; ANSWER SECTION:
8.8.8.8.in-addr.arpa.   18970   IN      PTR     dns.google.
...
```

6. Determine, which  IP address belongs to resource epam.com.

```
jita@ubuntuy:~$dig epam.com

; <<>> DiG 9.16.1-Ubuntu <<>> epam.com
...
;; QUESTION SECTION:
;epam.com.                      IN      A

;; ANSWER SECTION:
epam.com.               2609    IN      A       3.214.134.159
...
```

7. Determine the default gateway for your HOST and display routing table.

VM1:

```
jita@ubuntux:~$ ip route
default via 10.0.2.2 dev enp0s3 proto dhcp src 10.0.2.15 metric 100
10.0.2.0/24 dev enp0s3 proto kernel scope link src 10.0.2.15
10.0.2.2 dev enp0s3 proto dhcp scope link src 10.0.2.15 metric 100
192.168.0.0/24 dev enp0s8 proto kernel scope link src 192.168.0.1
```

VM2:

```
jita@ubuntuy:~$ ip route
default via 192.168.0.1 dev enp0s3 proto static
192.168.0.0/24 dev enp0s3 proto kernel scope link src 192.168.0.2
```

8. Trace the route to google.com.

> `traceroute` uses _UDP_ which has troubles with _VirtualBox_, `-I` option makes it use _ICMP_

```
jita@ubuntuy:~$ traceroute -I google.com
traceroute to google.com (172.217.19.110), 30 hops max, 60 byte packets
 1  _gateway (192.168.0.1)  0.409 ms  0.468 ms  0.453 ms
 2  10.0.2.2 (10.0.2.2)  1.082 ms * *
 3  * * *
 4  100.102.0.1 (100.102.0.1)  4.480 ms  4.466 ms  6.019 ms
 5  77.88.248.45 (77.88.248.45)  12.207 ms  12.939 ms *
 6  88.81.244.62 (88.81.244.62)  24.890 ms  18.000 ms  17.974 ms
 7  88.81.240.138 (88.81.240.138)  16.950 ms  39.523 ms  42.635 ms
 8  108.170.248.130 (108.170.248.130)  74.512 ms  84.546 ms  92.104 ms
 9  108.170.234.207 (108.170.234.207)  98.463 ms  101.359 ms  101.997 ms
10  142.250.228.84 (142.250.228.84)  101.985 ms  122.142 ms  122.130 ms
11  74.125.242.241 (74.125.242.241)  101.893 ms  101.881 ms  44.674 ms
12  216.239.35.183 (216.239.35.183)  44.576 ms  44.492 ms  43.646 ms
13  muc03s07-in-f110.1e100.net (172.217.19.110)  40.565 ms  43.601 ms  30.141 ms
```