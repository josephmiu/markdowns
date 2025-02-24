### 1. Prepare bootable USB - Nix

### 2. Setting of BIOS

[[BIOS Settings]]

 **Reboot by Selecting Nixos 24.05**
### 4. Disk Partition
1. ```sudo gparted```
2. Check the selected Drive
3. Create table by Type: ```gpt```
4. Partition by the following sections:
   **Size | name&label | type** 
	* size: 1000, nix-boot, fat32
	* size: 100000, nix-root, ext4
	* size: reserve 15000 for the rest part, <font color="#F7A004">linux-shared</font>, ext4
	* size: 15000, swap, swap-linux
	
5. Confirm partition changes
6. manage <font color="#F7A004">nix-boot</font> flag by selecting ```boot```&```esp```

### 5. Create RAID1 on 2 SSDs:
<pre><code>sudo mdadm --create --verbose /dev/md0 --level=1 --raid-devices=2 /dev/sda /dev/sdb</code></pre>
Notes:
Command for check the name:
<pre><code>lsblk, lsblk-f</code></pre>

To check the status:
```
cat/proc/mdstat
```

### 6. Create File system
```
sudo mkfs.ext4 -L data /dev/md0
```

### 7. Mount Partitions
<pre><code>cd /mnt
sudo mkdir /mnt/boot
sudo mount /dev/disk/by-label/nix-root /mnt
sudo mount /dev/disk/by-label/NIX-BOOT /mnt/boot</code></pre>

### 8. Clone Deployment
<pre><code>cd ~
tar -xf /run/media/nixos/vtoy-extra/deployment.tar
mv deployment /mnt

cd /mnt/deployment
git pull

cd nixos/machine
cp -r mastertrans-1 /(new_v_name)</code></pre>
If **vpn** needed:
[[VPN - fortivpn]]

### 9. Create symbolic link
<pre><code>cd
sudo cp -r deployment/ /mnt
cd /mnt
mkdir -p /mnt/etc/nixos
ln -s ../../deployment/nixos/machines/(new_v_name)/(b-w or b-p.nix) configuration.nix
cd /mnt/deployment
git status
git push</code></pre>

Notes:
If no permission:
<pre><code>sudo chown -R nixos:nixos deployment/
sudo rm -rf deployment/</code></pre>
### 10. Sockets
1. *(window + left + right)* to open another window
<pre><code>ip a | grep ‘state UP’, watch -n 1 “ip a | grep ‘state UP’, ip a | grep ‘state UP’ -A 1
ip a
watch ip a
</code></pre>
1. check & copy the corresponding socket to the ip: Ex: eth00 = ip
2. If extra br needed, add in br section and command/delete the section eth00

### 11. Nix install:
```
nixos-install --root /mnt
```
Set the ```root``` password, and reboot.

### 12. Push the updated configuration to git repo

### 13. Setup User Home & Password
1. (CTRL-ALT-F1) go to the terminal in the login page.
	- Log in by username: ```root```
	- ```passwd d300``` - Set up the user password to **d300**. 
2. create home: 
	<pre><code>mkdir /home/d300
	cd home
	chown d300:d300 d300
	ls l
	</code></pre>
3. login as d300
### 14. systemctl:

Use ```systemctl``` to check if anythings' wrong.
```
systemctl status
systemctl list-units
```
---
#### Check sdc
<pre><code>sudo journalctl -u mnt-black\\x2d...sdc.mount
cat /etc/fstab</code></pre>

### Nix Channels
<pre><code>sudo nix-channel --list
nix-channel --update
cd /root
ls -al
cat nix-channels</code></pre>

### Change GPU
Edit nv-gpu-service.nix & machines/rac-1/bp.nix 
<pre><code>sudo nixos-rebuild test
</code></pre>

### Notes:
<pre><code>cd /deployment
git status
nix-shell --packages openfortivpn
rm -rf /deployment
cd vtoy-extra
tar -xf deployment -C /home/nixos</code></pre>