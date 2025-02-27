### Should run in the <mark>**sdc-shell**</mark>

##### For clean build:

```
rm -rf build/ install/ log/
```

##### If media failed for the compile version:

Modify the command in the build.sh by the following arguments:

```
-DCMAKE_CUDA_ARCHITECTURE=75
```


##### If **build.sh** can't find by bash

Locate bash by changing the first line:
```
#!/usr/bin/env bash
```