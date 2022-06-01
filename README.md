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
sudo ip netns exec srbase-default python3 rift --interactive topology/srl-`hostname -f`.yaml
```
![plot](images/RIFT_with_broadcast.png)

[Pull request]( https://github.com/brunorijsman/rift-python/pull/110 ) submitted

# 6/1/2022 Update: Subnet broadcast option added to IETF draft

See [version 15 section 4.2.2](https://datatracker.ietf.org/doc/html/draft-ietf-rift-rift-15#section-4.2.2):
```
A simplified version on platforms with limited multicast support MAY
   implement optional sending and reception of LIE frames on IPv4 subnet
   broadcast addresses and IPv6 all routers multicast address though
   such technique is less optimal and presents a wider attack surface
   from security perspective.
```
