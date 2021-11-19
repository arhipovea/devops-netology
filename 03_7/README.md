1

![Linux](https://github.com/arhipovea/devops-netology/blob/main/03_7/pic1.png)
![Windows](https://github.com/arhipovea/devops-netology/blob/main/03_7/pic2.png)

2

	LLDP

	Пакет: lldpd
	Команда: lldpctl

3

	VLAN

	Есть пакет vlan, утилита vconfig. С её помощью создаём vlan, и вешаем на него ip.

	Конфиг на примере примере конфига netplan:
	network:
	  version: 2
	  renderer: networkd
	  ethernets:
	    enp0s8:
	      addresses:
	      - 192.168.222.111/24
	    enp0s9:
	      {}

	  vlans:
	    vlan20:
	      id: 20
	      link: enp0s9
	      addresses: [192.168.55.55/24]

	
4
	
	Типы: balance-rr, active-backup, balance-xor, broadcast, 802.3ad, balance-tlb, balance-alb

    bonds:
        bond0:
            interfaces: [eno4]
            mtu: 1500
            addresses: [10.208.154.104/24,]
            nameservers:
                addresses: [10.10.100.8, 10.10.100.2]
            routes:
                 - to: 10.10.0.0/16
                   via: 10.208.154.250
        bond1:
            interfaces: [eno1]
            mtu: 1500
            addresses: [89.208.154.120/24,]
            gateway4: 89.208.154.1
            parameters:
                mode: 802.3ad
                mii-monitor-interval: 1
        
        bond2:
            interfaces: [ens1f0, ens1f1]
            mtu: 9000
            addresses: [172.16.0.6/30, 172.16.0.10/30]
            parameters:
                mode: balance-rr
                mii-monitor-interval: 1

5
	
	В сети с маской /29 8 ip адресов, из них один под номер сети и один под широковещательный адрес, итого можно использовать 6.
	32 сетки.

	Netmask:   255.255.255.248 = 29 
	Network:   10.10.10.0/29        
	HostMin:   10.10.10.1           
	HostMax:   10.10.10.6           
	Broadcast: 10.10.10.7           

	Netmask:   255.255.255.248 = 29 
	Network:   10.10.10.8/29        
	HostMin:   10.10.10.9           
	HostMax:   10.10.10.14          
	Broadcast: 10.10.10.15          

	Netmask:   255.255.255.248 = 29 
	Network:   10.10.10.16/29       
	HostMin:   10.10.10.17          
	HostMax:   10.10.10.22          
	Broadcast: 10.10.10.23 

6

	Из сети 100.64.0.0/10

	Netmask:   255.255.255.192 = 26 
	Network:   100.64.0.0/26        
	HostMin:   100.64.0.1           
	HostMax:   100.64.0.62          
	Broadcast: 100.64.0.63          
	Hosts/Net: 62                    Class A

7

	Просмотр:
		Linux: 
			ip neigh
			arp -a

		Windows:
			arp -a

	Очистка полная:
		Linux: 
			ip neigh flush all
			arp -d

		Windows:
			arp -d
	
	Очистка ip:
		Linux: 
			ip neigh del dev wlp2s0 192.168.10.10
			arp -d 192.168.10.10

		Windows:
			arp -d 192.168.10.10