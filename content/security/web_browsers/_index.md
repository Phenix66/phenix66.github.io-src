+++
title = "Web Browser Security"
+++

## Internationalized Domain Names (IDNs)

What is it: Domain names can use international characters that look like other English characters. Used commonly on phishing
  sites to further trick a user into thinking they are on a legitimate site. Displaying all domains in their "punycode" equivalents
  however prevents this entirely.

In-depth reads:
https://krebsonsecurity.com/2018/03/look-alike-domains-and-visual-confusion/

Browsers that show punycode by default:
Chrome
Safari
Internet Explorer
Edge

Mozilla Firefox:
1) Navigate to "about:config"
2) Set "network.IDN_show_punycode" to "true"


## Pastejacking

What is it: Allows a website to copy custom text/code to the clipboard when the user copies something else from the site.
   Commonly used when the content being copied is intended to be pasted into a command window or text editor such as VIM
   that would support commands/macros.

Good PoC website:
https://securelayer7.net/lab/pastejacking.html

More in-depth read:
https://nakedsecurity.sophos.com/2016/05/26/why-you-cant-trust-things-you-cut-and-paste-from-web-pages/

"But I already use a script blocker?"
Doesn't seem to make a difference in my experience. Pastejacking relies on "Clipboard events" that can run without Javascript
  being enabled if it was placed in the CSS code. Please note, you SHOULD be running a script blocker, some pastejacking does
  occur in Javascript and therefore would not be prevented via these methods.


Firefox:
1) Navigate to "about:config"
2) Set "dom.event.clipboardevents.enabled" to "false"

IE:
-Tested with IE 11.1066.14393.0 on Windows 10 and it inherently blocked the attempt. Way to go MS for actually getting something right!

Chrome:
-Requires extension, no known method of disabling clipboard events.
-Right-to-Copy extension allows you copy ONLY what is selected, but requires you to right-click -> Copy instead of using Ctrl+C shortcut


## WebRTC Leaks

What it is: WebRTC can leak your true IP address even when utilizing a VPN

Firefox:
1) Navigate to "about:config"
2) Set "media.peerconnection.enabled" to "false"

## Adding CA Certificates

### NSSDB

The following commands can be used to add certificates to the store used by Chrome and
other chromium derivitives, such as VSCode.

```
mkdir -p $HOME/.pki/nssdb
certutil -d $HOME/.pki/nssdb -N --empty-password
certutil -d $HOME/.pki/nssdb -A -t TC -n "Descriptive comment" -i /path/to/cert
```
