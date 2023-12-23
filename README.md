# Configuration OpenVPN using SSH port Forwarding

> [!TIP]
> ###### Video : لینک ویدیو یوتیوب
```

```
###### خرید سرور از دیجیتال اوشن : 
```
https://m.do.co/c/0fb522deafa4
```
###### خرید سرور از سایت ایرانی : 
```
https://dashboard.azaronline.com/order/?aff=790&p=vps
```
###### خرید دامنه از نیم چیپ: 
```
https://namecheap.pxf.io/BX7m6W
```
###### خرید دامنه سایت ایرانی: 
```
https://dashboard.azaronline.com/order/?aff=790&p=domain
```
**If you think this project is helpful to you, you may wish to give a** 🌟

**Feel Free To Donation :** ❤️

>TRC20: ```TGTyqv2MH7dZztMvaP5PKuS9Bma8RY5Pk8```

>ETH: ```0x5b5202a54e5ce4fb25f0d886254eeb07bb088614```
### Change SSH-Port

##### Find the SSH-Port on Ubuntu
```
netstat -tunlp | grep ssh
```

##### Edit ssh config file, I changed it to 3210
```
nano /etc/ssh/sshd_config
``` 
##### Check Firewall status
```
ufw status
```
##### If your firewall is active you shoud use the following command to allow port, port can selected between 1025-65535
```
ufw allow PORT-NUMBER/protcol  ufw allow 3210/tcp
```
#### Restart systemctl to apply the change
```
systemctl restart sshd.service
```

### EU-Server
#### Update & upgrade Server
```
apt update -y && apt upgrade -y
```
#### Add Docker
```
nano install-docker.sh
```
* past the commands of the [install-docker.sh](https://github.com/pouramin/openvpntunnel/blob/main/install-docker.sh) to the nano install-docker.sh file, and save it using Ctrl+x

#### Enter the following command and press Enter
```
sudo bash install-docker.sh
```
#### Create Dir and Enter to it
```
mkdir openvpn && cd openvpn
```

#### Add new service
```
nano docker-compose.yml
```

#### Past the following commands
```
version: '2'
services:
  openvpn:
    cap_add:
     - NET_ADMIN
    image: kylemanna/openvpn
    container_name: openvpn
    ports:
     - "20834:20834/tcp"
    restart: always
    volumes:
     - ./openvpn-data/conf:/etc/openvpn
```

#### Add config file (change the domain according to your domain)
```
docker-compose run --rm openvpn ovpn_genconfig -u tcp://abr.viraweb.it
```

#### Check the config file, if needed change the port
```
nano openvpn-data/conf/openvpn.conf
```
#### Generat certificate for OpenVPN, and create your VPN's master Pass
```
docker-compose run --rm openvpn ovpn_initpki
```

#### Add User Permission
```
sudo chown -R $(whoami): ./openvpn-data
```

#### Start OpenVPN
```
docker-compose up -d openvpn
```
#### Add User
```
export CLIENTNAME="vira"
docker-compose run --rm openvpn easyrsa build-client-full $CLIENTNAME
```

#### Generate.Ovpn file
```
docker-compose run --rm openvpn ovpn_getclient $CLIENTNAME > $CLIENTNAME.ovpn
```

### IR-Server

#### Update & upgrade Server
```
apt update -y && apt upgrade -y
```

#### Create a service for Port forwarding
```
sudo nano /etc/systemd/system/ssh-tunnel.service
```
#### Paste the following command and save the file using Ctrl+X
```
[Unit]
Description=SSH Tunnel to abr.viraweb.it
After=network.target

[Service]
ExecStart=/usr/bin/ssh -p3210 -f -N -L *:4444:localhost:20834 root@abr.viraweb.it
Restart=always

[Install]
WantedBy=multi-user.target
```

#### Reload the systemd manager to pick up the changes:
```
sudo systemctl daemon-reload
```

#### Enable startup
```
sudo systemctl enable ssh-tunnel.service
```

#### start Service
```
sudo systemctl start ssh-tunnel.service
```
