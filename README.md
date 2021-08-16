# Evaluating Routing In Fat Trees (RIFT) on SR Linux

![plot](./images/RIFT.PNG)

Juniper Networks came up with their own version of a routing protocol, called Routing In Fat Trees (RIFT). It is [available for evaluation here](https://support.juniper.net/support/downloads/?p=rifteval) (restricted to registered Juniper customers). An open source version based on Python is [in the works](https://github.com/brunorijsman/rift-python).

As it turns out, the open source Python implementation runs unmodified on SR Linux. However, IPv4 multicast has some limitations - this project proposes a subnet broadcast feature to overcome that

# Installation instructions
```
git clone --recurse-submodules https://github.com/jbemmel/srl-openrift.git
cd srl-openrift
make build
sudo containerlab deploy -t ./srl-leafspine.lab --reconfigure
```

# Testing RIFT using subnet broadcast
```
ssh linuxadmin@clab-openrift-lab-node1
cd /opt/rift-python/
ip netns exec srbase-default python3 rift --interactive topology/srl-`hostname -f`.yaml
```
![plot](images/RIFT_with_broadcast.png)

[Pull request]( https://github.com/brunorijsman/rift-python/pull/110 ) submitted
