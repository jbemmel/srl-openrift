# Evaluating Juniper's RIFT protocol on SR Linux

![plot](./images/RIFT.PNG)

Juniper Networks came up with their own version of a routing protocol, called Routing In Fat Trees (RIFT). It is [available for evaluation here](https://support.juniper.net/support/downloads/?p=rifteval). An open source version based on Python is [in the works](https://github.com/brunorijsman/rift-python).

Unfortunately, as I discovered (on 2021-08-10) access to the RIFT evaluation software is restricted to registered Juniper customers. Therefore, the open source prototype will have to do for now - and OMMV.

# Installation instructions
```
make build
sudo containerlab deploy -t ./srl-leafspine.lab --reconfigure
```

# Testing RIFT
```
ssh linuxadmin@clab-openrift-lab-node1
cd /opt/python-rift/
ip netns exec srbase-default python3 rift --interactive topology/srl-openrift-topology.yaml
```
