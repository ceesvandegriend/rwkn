# Install

Install packages on Raspberry OS.

```shell
$ sudo apt -y install wget gnupg2 gnupg-agent dirmngr cryptsetup scdaemon pcscd secure-delete hopenpgp-tools yubikey-personalization
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
dirmngr is already the newest version (2.2.27-2+deb11u2).
dirmngr set to manually installed.
gnupg2 is already the newest version (2.2.27-2+deb11u2).
wget is already the newest version (1.21-1+deb11u1).
wget set to manually installed.
The following additional packages will be installed:
  cryptsetup-bin cryptsetup-initramfs cryptsetup-run libccid libykpers-1-1
  libyubikey-udev libyubikey0
Suggested packages:
  pcmciautils
The following NEW packages will be installed:
  cryptsetup cryptsetup-bin cryptsetup-initramfs cryptsetup-run gnupg-agent
  hopenpgp-tools libccid libykpers-1-1 libyubikey-udev libyubikey0 pcscd
  scdaemon secure-delete yubikey-personalization
0 upgraded, 14 newly installed, 0 to remove and 0 not upgraded.
Need to get 21.9 MB of archives.
After this operation, 149 MB of additional disk space will be used.
Get:1 http://deb.debian.org/debian bullseye/main arm64 libccid arm64 1.4.34-1 [331 kB]
Get:2 http://deb.debian.org/debian bullseye/main arm64 pcscd arm64 1.9.1-1 [93.6 kB]
Get:3 http://deb.debian.org/debian bullseye/main arm64 cryptsetup-bin arm64 2:2.3.7-1+deb11u1 [407 kB]
Get:4 http://deb.debian.org/debian bullseye/main arm64 cryptsetup arm64 2:2.3.7-1+deb11u1 [228 kB]
Get:5 http://deb.debian.org/debian bullseye/main arm64 cryptsetup-initramfs all 2:2.3.7-1+deb11u1 [72.5 kB]
Get:6 http://deb.debian.org/debian bullseye/main arm64 cryptsetup-run all 2:2.3.7-1+deb11u1 [54.4 kB]
Get:7 http://deb.debian.org/debian bullseye/main arm64 gnupg-agent all 2.2.27-2+deb11u2 [434 kB]
Get:8 http://deb.debian.org/debian bullseye/main arm64 hopenpgp-tools arm64 0.23.6-1 [19.5 MB]
Get:9 http://deb.debian.org/debian bullseye/main arm64 libyubikey0 arm64 1.13-6 [12.5 kB]
Get:10 http://deb.debian.org/debian bullseye/main arm64 libykpers-1-1 arm64 1.20.0-3 [64.7 kB]
Get:11 http://deb.debian.org/debian bullseye/main arm64 libyubikey-udev all 1.20.0-3 [41.7 kB]
Get:12 http://deb.debian.org/debian bullseye/main arm64 scdaemon arm64 2.2.27-2+deb11u2 [605 kB]
Get:13 http://deb.debian.org/debian bullseye/main arm64 secure-delete arm64 3.1-6+b1 [65.5 kB]
Get:14 http://deb.debian.org/debian bullseye/main arm64 yubikey-personalization arm64 1.20.0-3 [77.2 kB]
Fetched 21.9 MB in 3s (8,197 kB/s)
Preconfiguring packages ...
Selecting previously unselected package libccid.
(Reading database ... 45914 files and directories currently installed.)
Preparing to unpack .../00-libccid_1.4.34-1_arm64.deb ...
Unpacking libccid (1.4.34-1) ...
Selecting previously unselected package pcscd.
Preparing to unpack .../01-pcscd_1.9.1-1_arm64.deb ...
Unpacking pcscd (1.9.1-1) ...
Selecting previously unselected package cryptsetup-bin.
Preparing to unpack .../02-cryptsetup-bin_2%3a2.3.7-1+deb11u1_arm64.deb ...
Unpacking cryptsetup-bin (2:2.3.7-1+deb11u1) ...
Selecting previously unselected package cryptsetup.
Preparing to unpack .../03-cryptsetup_2%3a2.3.7-1+deb11u1_arm64.deb ...
Unpacking cryptsetup (2:2.3.7-1+deb11u1) ...
Selecting previously unselected package cryptsetup-initramfs.
Preparing to unpack .../04-cryptsetup-initramfs_2%3a2.3.7-1+deb11u1_all.deb ...
Unpacking cryptsetup-initramfs (2:2.3.7-1+deb11u1) ...
Selecting previously unselected package cryptsetup-run.
Preparing to unpack .../05-cryptsetup-run_2%3a2.3.7-1+deb11u1_all.deb ...
Unpacking cryptsetup-run (2:2.3.7-1+deb11u1) ...
Selecting previously unselected package gnupg-agent.
Preparing to unpack .../06-gnupg-agent_2.2.27-2+deb11u2_all.deb ...
Unpacking gnupg-agent (2.2.27-2+deb11u2) ...
Selecting previously unselected package hopenpgp-tools.
Preparing to unpack .../07-hopenpgp-tools_0.23.6-1_arm64.deb ...
Unpacking hopenpgp-tools (0.23.6-1) ...
Selecting previously unselected package libyubikey0.
Preparing to unpack .../08-libyubikey0_1.13-6_arm64.deb ...
Unpacking libyubikey0 (1.13-6) ...
Selecting previously unselected package libykpers-1-1:arm64.
Preparing to unpack .../09-libykpers-1-1_1.20.0-3_arm64.deb ...
Unpacking libykpers-1-1:arm64 (1.20.0-3) ...
Selecting previously unselected package libyubikey-udev.
Preparing to unpack .../10-libyubikey-udev_1.20.0-3_all.deb ...
Unpacking libyubikey-udev (1.20.0-3) ...
Selecting previously unselected package scdaemon.
Preparing to unpack .../11-scdaemon_2.2.27-2+deb11u2_arm64.deb ...
Unpacking scdaemon (2.2.27-2+deb11u2) ...
Selecting previously unselected package secure-delete.
Preparing to unpack .../12-secure-delete_3.1-6+b1_arm64.deb ...
Unpacking secure-delete (3.1-6+b1) ...
Selecting previously unselected package yubikey-personalization.
Preparing to unpack .../13-yubikey-personalization_1.20.0-3_arm64.deb ...
Unpacking yubikey-personalization (1.20.0-3) ...
Setting up cryptsetup-bin (2:2.3.7-1+deb11u1) ...
Setting up libyubikey-udev (1.20.0-3) ...
Setting up cryptsetup (2:2.3.7-1+deb11u1) ...
Setting up libccid (1.4.34-1) ...
Setting up scdaemon (2.2.27-2+deb11u2) ...
Setting up pcscd (1.9.1-1) ...
Created symlink /etc/systemd/system/sockets.target.wants/pcscd.socket → /lib/systemd/system/pcscd.socket.
pcscd.service is a disabled or a static unit, not starting it.
Setting up cryptsetup-run (2:2.3.7-1+deb11u1) ...
Setting up gnupg-agent (2.2.27-2+deb11u2) ...
Setting up hopenpgp-tools (0.23.6-1) ...
Setting up secure-delete (3.1-6+b1) ...
Setting up cryptsetup-initramfs (2:2.3.7-1+deb11u1) ...
update-initramfs: deferring update (trigger activated)
Setting up libyubikey0 (1.13-6) ...
Setting up libykpers-1-1:arm64 (1.20.0-3) ...
Setting up yubikey-personalization (1.20.0-3) ...
Processing triggers for libc-bin (2.31-13+rpt2+rpi1+deb11u3) ...
Processing triggers for man-db (2.9.4-2) ...
Processing triggers for initramfs-tools (0.140) ...
```

Install Python packages on Raspberry OS.

```shell
sudo apt -y install python3-pip python3-pyscard
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
python3-pip is already the newest version (20.3.4-4+rpt1+deb11u1).
Suggested packages:
  python3-wxgtk4.0
The following NEW packages will be installed:
  python3-pyscard
0 upgraded, 1 newly installed, 0 to remove and 0 not upgraded.
Need to get 86.1 kB of archives.
After this operation, 655 kB of additional disk space will be used.
Get:1 http://deb.debian.org/debian bullseye/main arm64 python3-pyscard arm64 2.0.0-1+b2 [86.1 kB]
Fetched 86.1 kB in 0s (1,318 kB/s)
Selecting previously unselected package python3-pyscard.
(Reading database ... 46191 files and directories currently installed.)
Preparing to unpack .../python3-pyscard_2.0.0-1+b2_arm64.deb ...
Unpacking python3-pyscard (2.0.0-1+b2) ...
Setting up python3-pyscard (2.0.0-1+b2) ...
```

Install Python modules.

```shell
$ pip3 install PyOpenSSL
Looking in indexes: https://pypi.org/simple, https://www.piwheels.org/simple
Collecting PyOpenSSL
  Downloading https://www.piwheels.org/simple/pyopenssl/pyOpenSSL-22.0.0-py2.py3-none-any.whl (55 kB)
     |████████████████████████████████| 55 kB 758 kB/s
Collecting cryptography>=35.0
  Downloading cryptography-37.0.4-cp36-abi3-manylinux_2_17_aarch64.manylinux2014_aarch64.manylinux_2_24_aarch64.whl (3.7 MB)
     |████████████████████████████████| 3.7 MB 4.3 kB/s
Collecting cffi>=1.12
  Downloading cffi-1.15.1-cp39-cp39-manylinux_2_17_aarch64.manylinux2014_aarch64.whl (448 kB)
     |████████████████████████████████| 448 kB 3.2 MB/s
Collecting pycparser
  Downloading https://www.piwheels.org/simple/pycparser/pycparser-2.21-py2.py3-none-any.whl (119 kB)
     |████████████████████████████████| 119 kB 1.9 MB/s
Installing collected packages: pycparser, cffi, cryptography, PyOpenSSL
Successfully installed PyOpenSSL-22.0.0 cffi-1.15.1 cryptography-37.0.4 pycparser-2.21
```

```shell
pip3 install yubikey-manager
Looking in indexes: https://pypi.org/simple, https://www.piwheels.org/simple
Collecting yubikey-manager
  Downloading https://www.piwheels.org/simple/yubikey-manager/yubikey_manager-4.0.9-py3-none-any.whl (147 kB)
     |████████████████████████████████| 147 kB 2.5 MB/s
Collecting fido2<2.0,>=0.9
  Downloading https://www.piwheels.org/simple/fido2/fido2-1.0.0-py3-none-any.whl (198 kB)
     |████████████████████████████████| 198 kB 2.7 MB/s
Requirement already satisfied: cryptography<39,>=2.1 in /home/cees/.local/lib/python3.9/site-packages (from yubikey-manager) (37.0.4)
Requirement already satisfied: pyscard<3.0,>=1.9 in /usr/lib/python3/dist-packages (from yubikey-manager) (2.0.0)
Collecting click<9.0,>=7.0
  Downloading https://www.piwheels.org/simple/click/click-8.1.3-py3-none-any.whl (96 kB)
     |████████████████████████████████| 96 kB 73 kB/s
Requirement already satisfied: pyOpenSSL>=0.15.1 in /home/cees/.local/lib/python3.9/site-packages (from yubikey-manager) (22.0.0)
Requirement already satisfied: cffi>=1.12 in /home/cees/.local/lib/python3.9/site-packages (from cryptography<39,>=2.1->yubikey-manager) (1.15.1)
Requirement already satisfied: pycparser in /home/cees/.local/lib/python3.9/site-packages (from cffi>=1.12->cryptography<39,>=2.1->yubikey-manager) (2.21)
Installing collected packages: fido2, click, yubikey-manager
  WARNING: The script ykman is installed in '/home/cees/.local/bin' which is not on PATH.
  Consider adding this directory to PATH or, if you prefer to suppress this warning, use --no-warn-script-location.
Successfully installed click-8.1.3 fido2-1.0.0 yubikey-manager-4.0.9
```

Restart pcscd service.

```shell
$ sudo systemctl start pcscd.service
$ sudo systemctl status pcscd.service
● pcscd.service - PC/SC Smart Card Daemon
     Loaded: loaded (/lib/systemd/system/pcscd.service; indirect; vendor preset>
     Active: active (running) since Thu 2022-07-28 18:47:31 CEST; 8s ago
TriggeredBy: ● pcscd.socket
       Docs: man:pcscd(8)
   Main PID: 113262 (pcscd)
      Tasks: 3 (limit: 779)
        CPU: 22ms
     CGroup: /system.slice/pcscd.service
             └─113262 /usr/sbin/pcscd --foreground --auto-exit

Jul 28 18:47:31 rp05.kade3.dev systemd[1]: Started PC/SC Smart Card Daemon.
```
