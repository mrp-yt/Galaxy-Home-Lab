keepalived setup for Galaxy Cluster

Install
```
apt update && apt install -y keepalived
```

Edit file (on each node)
```
nano /etc/keepalived/keepalived.conf
```

Master
```
vrrp_instance VI_1 {
    state MASTER
    interface vmbr0  # Change this if using a different network interface
    virtual_router_id 51 # Between 1 and 255
    priority 200
    advert_int 1 # VRRP Advertisements send every 1sec
    authentication {
        auth_type PASS
        auth_pass mysecurepassword
    }
    virtual_ipaddress {
        192.168.178.222/24
    }
}
```

Backup_1
```
vrrp_instance VI_1 {
    state BACKUP
    interface vmbr0
    virtual_router_id 51
    priority 150
    advert_int 1
    authentication {
        auth_type PASS
        auth_pass mysecurepassword
    }
    virtual_ipaddress {
        192.168.178.222/24 # virtual IP address 
    }
}
```

Backup_2
```
vrrp_instance VI_1 {
    state BACKUP
    interface vmbr0
    virtual_router_id 51
    priority 100
    advert_int 1
    authentication {
        auth_type PASS
        auth_pass mysecurepassword
    }
    virtual_ipaddress {
        192.168.178.222/24
    }
}
```

Restart keepalived service and enable it to auto-start after ndoe restart.
```
systemctl restart keepalived
systemctl enable keepalived
```
