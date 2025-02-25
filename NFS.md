## 1. Server Side

#### 1. Install NFS-server
<pre><code>sudo apt install nfs-kernel-server -y</pre></code>

#### 2. Create the directory to share
<pre><code>sudo mkdir -p <font color="#d6cb6a">target_folder</font></pre></code>

#### 3. Change the permission to access file
<pre><code>sudo chmod 777 <font color="#d6cb6a">target_folder</font></pre></code>

#### 4. Modify NFS Setting file
<pre><code>sudo vim /etc/exports</pre></code>
Add and save: 
<pre><code><font color="#d6cb6a">target_folder</font> <font color="#aa57fc">ip</font>(rw,sync,no_root_squash,no_subtree_check)</pre></code>
Explanation: 
- <font color="#aa57fc">ip</font>: Client IP/host that allow to access the shared folder
- <span style="background-color:#4b4b4b">*rw*</span>: Read & write
- <span style="background-color:#4b4b4b">*sync*</span>: Make sure to write the data at the same time
- <span style="background-color:#4b4b4b">*no_root_squash*</span>: Allow remote root has the same authorities as the local root
- <span style="background-color:#4b4b4b">*no_subtree_check*</span>: Disables a security verification that subdirectories a client attempts to mount for an exported filesystem are ones they’re permitted to do so. Sometime could improve the performance.

If you want to replace <font color="#aa57fc">ip</font> with <font color="#e8842b">hostname</font>, check [[Hostname Mapping]]
#### 5. Restart the NFS Server
<pre><code>sudo exportfs -a
sudo systemctl restart nfs-kernel-server</pre></code>
Check if NFS-sharing working successfully or not by the command:
<pre><code>sudo exportfs -v</pre></code>
## 2. NFS Client 

#### 1. Install NFS-Client
<pre><code>sudo apt install nfs-common -y</pre></code>
#### 2. Mount the shared NFS folder
1. Create the local mounting point
<pre><code>sudo mkdir -p <font color="#7ad546">local_mounting_point</font></pre></code>
1. Mount the remote server's folder
<pre><code>sudo mount <font color="#aa57fc">ip</font>:<font color="#d6cb6a">target_folder</font> <font color="#7ad546">local_mounting_point</font></pre></code>
<font color="#aa57fc">ip</font>: Destination ip/host address 
<font color="#d6cb6a">target_folder</font>: target path to mount: /mnt/gen in this case
<font color="#7ad546">local_mounting_point</font>: local mounting point: /mnt/gen 
#### 3. Check if mounting success
<pre><code>mount</pre></code>
Success if see ip/hostname:target_folder local_mounting_point...

#### 4. Automatically mount when booting

Modify fstab:
<pre><code>sudo vim /etc/fstab</pre></code>
Add: 
<font color="#aa57fc">ip</font>/<font color="#e8842b">hostname</font>:<font color="#d6cb6a">target_folder</font> <font color="#7ad546">local_mounting_point</font> nfs defaults 0 0

Notes:
The last two digits means:
1. First arg - dump settings
	- 0 (default): doesn't need dump back-up
	- 1 : activate dump back-up
	
2. Second arg - fsck settings
	Enable or disable file system check when booting: 
	- 0 (default): Disable fsck checking
	- 1 (Highest priority): Check root (/) file system when booting( Only     available on local disk) 
	- 2 (Lower priority): Other local file systems will be check (/home, /var, ,etc) after the root

NFS should use 0, 0 by default.

Use command below to check there's no error:
<pre><code>sudo mount -a</pre></code>
#### 5. To un-mount
On client:
<pre><code>sudo umount <font color="#7ad546">local_mounting_point</font></pre></code>