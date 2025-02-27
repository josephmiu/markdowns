
### The structure should looks like:

/home
- /d300
	- /sensing-ws
	 **build.sh should build here in the sdc-shell** [[Build.sh]]
		- src -> /home/sdc/sdc2/ros/src/sensing 
- /sdc
	- sdc2 - main code from git repo
	- deployment - main code of nixos from git repo

#### Check if link is correct

```
/etc/nixos/configuration.nix -> <black-panther> or <black-widow>.nix 
```

#### Run git pull

```
git-as <username> pull 
```


