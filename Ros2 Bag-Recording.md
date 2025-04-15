
#### Remap a bag provider:

`ros2 bag play --loop /path/of/the/bag --remap /original/topic:=/new-topic`

Sample:

`ros2 bag play --loop ~/mcap/os1-128u-ax-rev7-mcap/ --remap /lidar/ouster/noname:=/justfortest`

#### Record:

normal:
`ros2 bag record -s mcap /chatter /foo /lidar/ouster/noname /test1 /test2`

`-o` to specify the output file name 

`--storage-preset-profile` to choose specific writing strategy

Ex.
`ros2 bag record -s mcap -o with_fast --storage-preset-profile fastwrite /chatter /foo /lidar/ouster/noname /test1 /test2`