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

Unfortunately, this example currently fails; UDP multicast packets are lost between being received on e1-1, and being forwarded on subinterface e1-1.0.
The /acl cpm-filter ipv4-filters are opened (allow all UDP), but there seems to be something else dropping the packets.

'native' SR Linux protocols like OSPF (IP protocol 89) work correctly of course:
```
enter candidate
/network-instance default
protocols {
        ospf {
            instance 0 {
                admin-state enable
                version ospf-v2
                router-id 1.1.1.1
                area 0.0.0.0 {
                    interface ethernet-1/1.0 {
                    }
                    interface lo0.0 {
                        passive true
                    }
                }
            }
        }
    }
commit now
```
(edit the router-id for node2 to be 1.1.1.2). So the question is: What would one need to do to enable multicast for third party protocols? To be continued...
