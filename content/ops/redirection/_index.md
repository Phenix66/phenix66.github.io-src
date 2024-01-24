+++
Title = "Redirection"
weight = 5
+++

## Basics

### Redirectors vs SSH tunnels

* Advantages
    * Smaller executable size
    * Can easily be deployed to systems that do not have SSH available
* Disadvantages
    * Limited functionality
    * No multiplexing
    * Noiser
    * Rewrites addressing info on packets instead re-encapsulating

### Applications

||fpipe|socat|portproxy|iptables|
|----|----|----|----|----|
|Redirect TCP|X|X|X|X|
|Redirect UDP||X||X|
|Convert TCP <> UDP||X|||
|Redirect IPv4|X|X|X|X|
|Redirect IPv6||X|X|* with ip6tables|
|Convert IPv4 <> IPv6||X|X||
|Masks source IP address|X|X|X||
|No open socket on redirector||||X|
|Requires admin privileges|||X|X|


#### Socat

Supports TCP, UDP, ICMP, and RAW IP traffic

```
socat TCP-LISTEN:8080 TCP-CONNECT:<ip>:80
```

##### UDP forwarder over TCP tunnel

```
socat udp-listen:137 tcp-connect:127.0.0.1:1337
socat tcp-listen:1337 udp-connect:198.18.30.12:137
```

##### Generate SSL cert for HTTPS

```
openssl req -new -x509 -days 365 -nodes -out cert.pem -keyout cert.key
socat OPENSSL-LISTEN:443,cert=/cert.pem -
```

#### fpipe

```
fpipe -l <lport> -r <rport> <ip>
```

#### portproxy

Native option on Windows (you do not need to bring it)

Only supports TCP

```
netsh interface portproxy show all
netsh interface portproxy set v4tov4 listenaddress=<ip> listenport=<port> connectaddress=<ip> connectport=<port>
netsh interface portproxy reset
```

#### IPtables

Native option on Linux (you do not need to bring it)

Network forwarding must be enabled

```
echo “1” > /proc/sys/net/ipv4/ip_forward
```

Changes destination from redirector to target 2

```
iptables -t nat -A PREROUTING -p tcp --dport <port> -d <redirector-ip> -s <tgt1-ip> -j DNAT --to-destination <tgt2-ip>:<port>
```

Changes source of the packet to the redirector's ip, masking the true source

```
iptables -t nat -A POSTROUTING -p tcp --dport <port> -d <tgt2-ip> -s <tgt1-ip> -j SNAT --to-source <redirector-ip>
```

Redirect to SSH reverse tunnel listening on localhost (handy when ‘GatewayPorts’ is disabled in sshd_config)
By default, IP forwarding will not forward traffic to localhost

```
echo “1” > /proc/sys/net/ipv4/conf/all/route_localnet
iptables -t nat -A PREROUTING -p tcp --dport <port> -d <redirector-ip> -s <tgt1-ip> -j DNAT --to-destination 127.0.0.1:<SSH -R port>
```

## Troubleshooting

### No packet is forwarded to destination

Problem: The iptables filter functionality must allow the redirected traffic
Diagnosis: Check iptables filter statistics for a blocking rule/policy incrementing
Solution: Add iptables filter rules allowing traffic

Problem: The redirector must be configured to route IP packets
Diagnosis: No iptables filter statistics will increment, check kernel parameters
Solution: Update kernel parameters to allow routing

### Connection to destination is initiated, but no SYN-ACK is received

Problem: Destination must be configured to route traffic to source traffic to source back through redirector, with no filtering in the path
Solution: Add a SNAT rule in the POSTROUTING chain to change the source address from the originator to the redirector

### Connection to destination is initiated, but SYN-ACK is not forwarded to source

Problem: Redirector must have conntrack kernel module installed
Solution: Add SNAT rule that undoes the DNAT rule for traffic returning to the source
