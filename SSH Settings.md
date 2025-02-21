### 1. Install ssh 
<pre><code>sudo apt update 
sudo apt install openssh-server -y
</code></pre>

Check version: 
<pre><code>ssh -V</code></pre>
### 2. Activate ssh
<pre><code>sudo systemctl enable ssh
sudo systemctl start ssh
</code></pre>
Check if **ssh** is running:
<pre><code>sudo systemctl status ssh
</code></pre>

### 3. Get destination IP address
<pre><code>hostname -I</code></pre>
or 
<pre><code>ip a</code></pre>
### 4. Connect to the target device on source device
<pre><code>ssh <font color="#aa57fc">username</font>@<font color="#449df9">ip</font></code></pre>
<font color="#aa57fc">username</font> is the username of destination device
<font color="#449df9">ip</font> is the IP address of destination device

Ex: 
<pre><code>ssh <font color="#aa57fc">joseph</font>@<font color="#449df9">192.168.0.2</font></code></pre>
### 5. Login without password(Option)

#### 1. Generate key on source device
<pre><code>ssh-keygen</code></pre>
<font color="#449df9">-t</font> to specify the type of key

#### 2. Get Authorize on the target device
<pre><code>ssh-copy-id <font color="#aa57fc">username</font>@<font color="#449df9">ip</font></code></pre>

- - -
### Related
[[SSHFS - Mount Remote Disk]]
