+++
Title = "Reconnaissance"
weight = 1
+++

## Proxychains

Greatly speeds up scanning

https://www.hackwhackandsmack.com/?p=1021


```
seq 128 255 | xargs -P 50 -I{} proxychains nmap -p 22 -sT -Pn --open -n -T4 --min-rate 1 --oG proxy_nmap --append-output 10.20.101.{}
```
