[root@localhost ~]# lsof -i:22
COMMAND  PID USER   FD   TYPE DEVICE SIZE/OFF NODE NAME
sshd    1051 root    3u  IPv4  16298      0t0  TCP *:ssh (LISTEN)
sshd    1051 root    4u  IPv6  16307      0t0  TCP *:ssh (LISTEN)
sshd    1373 root    3u  IPv4  18388      0t0  TCP 10.2.0.3:ssh->10.2.0.100:65470 (ESTABLISHED)
sshd    1437 root    3u  IPv4  22530      0t0  TCP localhost.localdomain:ssh->10.2.0.100:49406 (ESTABLISHED)
sshd    9585 root    3u  IPv4  36790      0t0  TCP localhost.localdomain:ssh->10.2.0.100:58973 (ESTABLISHED)
sshd    9712 root    3u  IPv4  43281      0t0  TCP localhost.localdomain:ssh->10.2.0.100:60562 (ESTABLISHED)


iptables -vL
iptables -t nat -L -n -v

ip -4 addr show scope global

# In the FORWARD chain, we will accept new connections destined for port 80 that are coming from our public interface and travelling to our private interface. New connections are identified by the conntrack extension and will specifically be represented by a TCP SYN packet:
sudo iptables -A FORWARD -i enp0s25 -o enp0s25 -p tcp --syn --dport 8000 -m conntrack --ctstate NEW -j ACCEPT

sudo iptables -A FORWARD -i enp0s25 -o enp0s25 -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

iptables -A FORWARD -i eth0 -o eth1 -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD -i eth1 -o eth0 -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

sudo iptables -P FORWARD DROP

sudo iptables -t nat -A PREROUTING -i enp0s25 -p tcp --dport 8000 -j DNAT --to-destination 192.168.200.40

 sudo iptables -t nat -A PREROUTING -p tcp --dport 8000 -j DNAT --to-destination 192.168.200.40:8000
 sudo iptables -t nat -A POSTROUTING -p tcp -d 192.168.200.40 --dport 8000 -j SNAT 
 sudo iptables -t nat -A POSTROUTING -p tcp -d 192.168.202.105 --dport 80 -j SNAT --to-source 192.168.202.103
 sudo iptables -t nat -L -n

iptables -t nat -A PREROUTING -p tcp --dport 8000 -j DNAT --to 192.168.200.40:8000
iptables -A FORWARD -d 192.168.200.40 -p tcp --dport 8000 -j ACCEPT


iptables -F
iptables -t nat -F
iptables -X

iptables -t nat -A PREROUTING -p tcp --dport 8000 -j DNAT --to-destination 192.168.200.40:8000
iptables -t nat -A POSTROUTING -p tcp -d 192.168.200.40 --dport 8000 -j SNAT --to-source 10.2.0.101


iptables -F
iptables -t nat -F
iptables -X

iptables -t nat -A PREROUTING -p tcp --dport 8000 -j DNAT --to-destination 192.168.200.40:8000
iptables -t nat -A POSTROUTING -j MASQUERADE
#  tell IPTables to rewrite the origin of connections to the new server’s port 80 to appear to come from the old server.
iptables -t nat -A POSTROUTING -p tcp -d 192.168.200.40 --dport 8000 -j MASQUERADE

iptables -t nat -A PREROUTING -s 192.168.1.1 -p tcp --dport 1111 -j DNAT --to-destination 2.2.2.2:1111


iptables -F
iptables -t nat -F
iptables -X

iptables -A FORWARD -d 192.168.200.40 -i enp0s25 -p tcp -m tcp --dport 8000 -j ACCEPT
iptables -t nat -A PREROUTING -d 192.168.200.146 -p tcp -m tcp --dport 8000 -j DNAT --to-destination 192.168.200.40
iptables -t nat -A POSTROUTING -o enp0s25 -j MASQUERADE

iptables -A PREROUTING -t nat -i enp0s25 -p tcp --dport 8000 -j DNAT --to 192.168.200.40:8000
iptables -A FORWARD -p tcp -d 192.168.200.40 --dport 8000 -j ACCEPT

firewall-cmd --get-active-zones
firewall-cmd --get-default-zone

firewall-cmd --permanent --zone=dmz --add-service={http,https,ldap,ldaps,kerberos,dns,kpasswd,ntp,ftp}
firewall-cmd --reload

echo "net.ipv4.ip_forward=1" > /etc/sysctl.d/ip_forward.conf
sysctl -w net.ipv4.ip_forward=1

firewall-cmd --permanent --zone=public --add-masquerade
firewall-cmd --reload

firewall-cmd --permanent --zone=public --add-forward-port='port=2271:proto=tcp:toport=22:toaddr=192.168.200.40'
firewall-cmd --permanent --zone=public --add-rich-rule='rule service name=ssh log prefix="SSH_" level="debug" limit value=1/m reject'
firewall-cmd --reload

firewall-cmd --add-forward-port=port=80:proto=tcp:toaddr=192.168.200.40:toport=80
firewall-cmd --zone=public --permanent --add-masquerade
firewall-cmd --reload

sudo /sbin/iptables -t nat -D OUTPUT -o lo -p tcp --dport 80 -j REDIRECT --to-port 22
sudo /sbin/iptables -t nat -D PREROUTING -p tcp --dport 80 -j REDIRECT --to-port 22
sudo /sbin/iptables -t nat -I PREROUTING -p tcp --dport 80 -j REDIRECT --to-port 22
sudo /sbin/iptables -t nat -I OUTPUT -o lo -p tcp --dport 80 -j REDIRECT --to-port 22
sudo firewall-cmd --runtime-to-permanent

sudo /sbin/iptables -t nat -D OUTPUT -o lo -p tcp --dport 80 -j REDIRECT --to-port 22
sudo /sbin/iptables -t nat -D PREROUTING -p tcp --dport 80 -j REDIRECT --to-port 22

sudo /sbin/iptables -t nat -I PREROUTING -p tcp --dport 80 -j REDIRECT --to-port 8000 
sudo /sbin/iptables -t nat -I OUTPUT -o lo -p tcp --dport 80 -j REDIRECT --to-port 8000 
sudo service iptables save


sudo iptables -t nat -A PREROUTING -p tcp --dport 27016 -j DNAT --to-destination 10.0.0.104:27016

iptables -A INPUT -p tcp -m tcp --dport 8000 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 2222 -j ACCEPT

iptables -t nat -A PREROUTING -p tcp --dport 8000 -j DNAT --to-destination 192.168.200.40:8000 -i enp0s25
iptables -t nat -A POSTROUTING -j MASQUERADE -o enp0s25

 iptables -t nat -I PREROUTING 1 -s 0.0.0.0/0 -d 192.168.200.146 -p tcp -m tcp --dport 80 -j REDIRECT --to-ports 22

 sudo iptables -A PREROUTING -t nat -i enp0s25 -p tcp --dport 80 -j REDIRECT --to-port 22

iptables -t nat -A PREROUTING -i enp0s25 -p tcp --dport 2222 -j REDIRECT --to-port 22
iptables -t nat -I PREROUTING --src 0/0 --dst 192.168.200.146 -p tcp --dport 80 -j REDIRECT --to-ports 22

iptables -t nat -I OUTPUT --src 0/0 --dst 192.168.200.146 -p tcp --dport 80 -j REDIRECT --to-ports 22
iptables -t nat -I OUTPUT --src 0/0 --dst 192.168.200.40 -p tcp --dport 81 -j REDIRECT --to-ports 8000

iptables -t nat -L -n -v