+++
Title = "Tunneling"
weight = 4
+++

## SSH Tunnels

![Image depicting SSH tunnels](/images/tunnel.png)

* Disabling SSH DNS lookup on redirector boxes can greatly speed up the response time and speed through the chain

```
ssh user@hop1 -NfL lport1:hop2:hop2port
```

From SSH sessions:
```
~C # Drops into SSH command line
 -L[bind addr]:<port>:<forward addr>:<port> # Add a forward tunnel
 -KL:<port> # Remove a forward tunnel
 -R<port>:<forward addr>:<port> # Add a reverse tunnel
 -KR:<port> # Remove a reverse tunnel
~# # List forwarded connections
```

### SSH Proxy Tunnel

```
ssh user@127.0.0.1 -p tunnel_port -NfD proxy_port
```

### Forward SSH Tunnels

1. Create first tunnel

```
ssh <user>@<firsthop> -NfL <lport1>:<nexthop>:<rport>
```

2. Tunnel through previous, continue to chain to add more hops to the route

```
ssh <user>@localhost -p <lport1> -NfL <lport2>:<nexthop>:<rport2>
```

### Reverse SSH Tunnels

By default reverse tunnels listen globally on all interfaces
Configuring a reverse tunnel does NOT start a listener on the local machine

Sends all traffic received on remote host's rport to your localhost's lport

```
ssh <user>@<target> -NfR <rport>:localhost:<lport>
```

### SSH control sockets

1. Create the socket

```
ssh -M -S /tmp/<name> <user>@<ip>
```

2. Use a socket

```
ssh -S /tmp/<name> thispartisignoredbutrequired@127
scp -o ControlPath=/tmp/<name> thispartisignoredbutrequired@127:<file> <dest>
```
