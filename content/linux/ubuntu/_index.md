+++
title = "Ubuntu - Grow Partition"
weight = 1
+++

Update drive name and partition number as appropriate.

```
growpart /dev/sda 3
pvresize /dev/sda3
lvresize -l +100%FREE --resizefs ubuntu-vg/ubuntu-lv
```
