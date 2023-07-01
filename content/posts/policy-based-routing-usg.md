---
title: "Policy Based Routing using Unifi USG3"
date: 2023-07-01T14:02:11+01:00
draft: false
---

I [did mention](/posts/failover-on-usg) before that I'm using dual ISP
configuration, with one of them being fast (Virgin, 350/35) and the other is
reliable (Andrews & Arnold, 80/20, 24x7, and generally much lower latency all around). 
I found that sometimes I want some
device just to use a specific ISP, and not the other. For example, I want my
MacBook to use the reliable (and low-latency) connection for work.

USG3, being a limited device it is, provides only very basic dual-WAN
configuration: it's either failover, or load-balancing. There's no way to tell
it to use one WAN for some traffic, and the other for the rest. However, it is
still possible to configure this using the command line. Specifically:

```bash
configure

# Here we create a new routing table, and add a default route to it, which always 
# points to the secondary WAN interface - pppoe1 in my case.
set protocols static table 1 interface-route 0.0.0.0/0 next-hop-interface pppoe1

# Just a handy description
set firewall modify SOURCE_ROUTE2 rule 10 description "This IP to WAN2"

# This is the actual rule, which matches the source IP address.
set firewall modify SOURCE_ROUTE2 rule 10 source address 192.168.xx.xxx

# Adds the rule to routing table 1
set firewall modify SOURCE_ROUTE2 rule 10 modify table 1

# Adds the rule to the WAN interface
set interfaces ethernet eth1 firewall in modify SOURCE_ROUTE2

# Commits the changes
commit; save; exit
```

This is it. Now, the device with the IP address `192.168.xx.xxx` will always use
the secondary WAN interface.

One last thing to do is to persist these changes - by default, everything you do
using `configure` command will get deleted upon the next re-provisioning (or
reboot) of the USG. Luckily, there are lots of guides on how to do this, and
[this
guide](https://blog.vyos.io/customizing-ubiquiti-usg-configuration-with-json-just-got-easier)
even provides a script to make this easier. Have fun, and happy hacking!

