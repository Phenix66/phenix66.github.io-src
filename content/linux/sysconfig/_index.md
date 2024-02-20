+++
title = "My System Config"
weight = 1
+++

## Disabling the builtin Bluetooth adapter

Almost every gaming motherboard comes with built in WiFi and BT now. The BT
adapter almost always sucks too.

1. Find the vender and model ID with `lsusb`

```
$ lsusb
<... lines omitted ...>
Bus 001 Device 004: ID 0e8d:0616 MediaTek Inc. Wireless_Device
<... lines omitted ...>
```

2. Add a new file to `/etc/udev/rules.d/`

```
SUBSYSTEM=="usb", ATTRS{idVendor}=="0e8d", ATTRS{idProduct}=="0616", ATTR{authorized}="0"
```

## Remove snapd

Flatpak is way better.

1. Remove all existing snaps. The order is important as you cannot remove a snap
that is a dependency of another installed snap. You also cannot remove multiple
snaps in one command apparently.

```
snap list
snap remove --purge gnome-42-2204
snap remove --purge firefox
snap remove --purge gtk-common-theme
snap remove --purge core22
snap remove --purge bare
snap remove --purge snapd
```

2. Remove snapd

```
sudo apt remove --autoremove snapd
```

3. Add the following to `/etc/apt/preferences.d/nosnap.pref` to ensure snap
doesn't get revived by apt.

```
Package: snapd
Pin: release a=*
Pin-Priority: -10
```

4. Install flatpak and profit

## Fix Flatpak Firefox fonts

Add the following to `~/.var/app/org.mozilla.firefox/config/fontconfig/fonts.conf`

```
<?xml version='1.0'?>
<!DOCTYPE fontconfig SYSTEM 'fonts.dtd'>
<fontconfig>     <!-- Disable bitmap fonts. -->
    <selectfont>
        <rejectfont>
            <pattern>
                <patelt name="scalable">
                    <bool>false</bool>
                </patelt>
            </pattern>
        </rejectfont>
    </selectfont>
</fontconfig>
```