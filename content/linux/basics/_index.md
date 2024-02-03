+++
title = "Basics"
weight = 1
+++

## Boot Process

1. POST
2. Bootloader
    1. GRUB:
        1. Stage 1 # Loads stage 1.5
        2. Stage 1.5 # Provides filesystem support, loads stage 2
        3. Stage 2 # Contains the bulk of the bootloader, allows users to select kernel and kernel boot options. Loads kernel into RAM
    2. Solaris (pre-10 1/06)
        1. mboot
        2. pboot
        3. bootblk
3. Kernel Init
    1. initrd or initramfs
        1. Provides temp filesystem required to load kernel modules and drivers
4. User Space Init
    1. SysV
        1. Serial, starts processes one after the other
        2. When first booting up, kill scripts will generally not be ran
        3. init (PID 1) # Ancestor of all other processes
        4. /etc/inittab
            1. Defines default run level
            2. Tells the system what to do when rebooted or run level is changed
        5. Red Hat:
            1. /etc/rc.d/
                * Startup scripts
            2. /etc/rc.d/init.d/
                * Contains actual service control scripts
            3. /etc/rc.d/rc.sysinit
                * Config to be run before other services. Time zone, hostname, etc
            4. /etc/rc.d/rc.local
                * Config to be run after services are up. Typically system specific such as VPNs
        6. Debian:
            1. /etc/rc<#>.d/
            2. /etc/init.d/rcS
                * equivalent to rc.sysinit
    2. upstart
        1. Can run steps in parallel
        2. Init reads .conf files in /etc/init
        3. One of those scripts runs /etc/rc.d/rc script for desired runlevel. This provides the SysV backwards compatibility
    3. systemd
        1. Can run steps in parallel
        2. /usr/lib/systemd/systemd (PID 1) # May also be /sbin/init (symbolic link to systemd)
        3. Units
            * Service # Daemons
            * Socket # IPC and network
            * Target # Similar to runlevel, groups units together during boot up
            * Located in /etc/systemd/system and /usr/lib/systemd/system
            * Units in /etc take precedence
        4. States
            * Load
                * Did it successfully read the unit's configuration file?
            * Active
                * Is it running?
            * Sub
                * Low-level unit activation state
        5. /etc/systemd/system/default.target
            * Symbolic link to default target
    4. SMF # Solaris 10+
        1. Can run steps in parallel
        2. Milestones
            * Replaces runlevels
        3. /etc/svc/repository.db
            * Config database

## Shells
### Types

https://phoenixnap.com/kb/linux-shells

https://www.freecodecamp.org/news/linux-shells-explained/

### Profile Loading

https://youngstone89.medium.com/unix-introduction-bash-startup-files-loading-order-562543ac12e9

https://access.redhat.com/solutions/452073

![Shell profile related files](/images/shell_profiles.png)

## Login

![Image showing the Linux login flow](/images/console_login_flow.png)

## Directories

![Image detailing important directories in Linux](/images/important_dirs.png)

## Filesystem Links

![Image depicting differences between hard and soft links](/images/hard_and_soft_links.png)

## IPTables

![Flowchart depicting the packet process flow of iptables](/images/iptables_flowchart.jpg)
