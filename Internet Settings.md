### 1.
<pre><code>sudo sh -c "echo 1 > /proc/sys/net/ipv4/ip_forward"

sudo iptables -A FORWARD -o eth0 -i eth1 -s 192.168.0.0/24 -m conntrack --ctstate NEW -j ACCEPT

sudo iptables -A FORWARD -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

sudo iptables -t nat -F POSTROUTING

sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE</code></pre>

Note: 
<font color="#aa57fc">eth0</font> is the internet provider's port.
<font color="#aa57fc">eth1</font> is the internet receiver's port.

### 2. 

Check provider's DNS
<pre><code>resolvectl status</code></pre>

Edit namespace in:
<pre><code>sudo vim /etc/resolv.conf</code></pre>

Replace DNS with provider's DNS

- - -
### Extra
[[SSH Settings]]
[[NFS]]
[[RSYNC - local & remote cp files]]
