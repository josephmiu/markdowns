### 1. Install sshfs
<pre><code> sudo apt-get install sshfs </code></pre>
### 2. Create a folder to mount the remote directory
<pre><code>mkdir <font color="#fd4340">remote_disk</font></code></pre>
### 3. Execute mount
<pre><code>sshfs <font color="#aa57fc">username</font>@<font color="#449df9">host</font>:<font color="#F7A004">/folder/path</font> <font color="#fd4340">remote_disk</font></code></pre>
<font color="#aa57fc">username</font>: destination user's name 
<font color="#449df9">host</font>: destination user's host or IP
<font color="#F7A004">/folder/path</font>: target directory/folder path 
<font color="#fd4340">remote_disk</font>:  local mounting point

Note: 
Use comment ==*mount*== to check if it mounted successfully.
To debug: can use 

<pre><code>sshfs -o debug <font color="#aa57fc">username</font>@<font color="#449df9">host</font>:<font color="#F7A004">/folder/path</font> <font color="#fd4340">remote_disk</font></code></pre>
### 4. To Un-mount 
<pre><code>fusermount -u /remote_disk  # Linux
umount /remote_disk         # macOS </code></pre>

- - -
