---
title: "Smart failover on Unifi Security Gateway"
date: 2023-04-06T12:16:18+01:00
draft: false
---

Since I started working from home more or less full time, a stable broadband
connection rapidly transformed from "I would really rather have it" to "I can't
function without it". And while Virgin Media has been mostly reliable for me for
many years, every now and then hiccups happen (like yesterday, and today for
that matter). 

For a piece of mind, I decided that 40 pounds a month for a second line from
excellent [Andrews and Arnold](https://www.aa.net.uk) is a money well spent, all
things considred. Yes, I don't have fancy gigabit fiber so it's only a
"superfast" 70mbps broadband (note, that quotes around "superfast" are coming
straight from their website - nope, they do not believe it either) - but
generally speaking, it is more than enough for me and my better half to work
from home without any of us noticing any slowdowns.

Being a Unifi user, after the second line was installed, I simply plugged in the
second Ethernet cable into USG, configured LAN2 as a WAN2, set it to Failover
mode and thought I was done. Well, I wasn't.

As it turns out, often when Virgin experiences problems, they are kinda sorta
functioning, but not really. What it means in practical terms is that `ping
ping.ubnt.com` which USG is using to check if the connection is alive is working
just fine, whereas half of the websites do not open, and latency is through the
roof on the second half. After much digging I admitted that I cannot just easily
change this host to something else - let alone use multiple hosts!

Luckily, some people more network savvy than me, spotted that USG supports same
syntax as EdgeRouter (admittedly more professional version thereof) and allows
to use a custom script for load balancing. I found some examples of scripts
being used, but they didn't really fit my specific case (they were checking only
if a host can be reached, not if latency is too high), and they were written in
Shell on top of it (which I am admittedly not a big fan of for anything more
than 5-10 lines). Now what?

Another piece of luck - under the hood USG is just a Linux box, running
admittedly ancient Kernel on mips64 CPU:

```bash
root@USG-3P:/config/scripts# uname -a
Linux USG-3P 3.10.107-UBNT #1 SMP Thu Jan 12 08:28:15 UTC 2023 mips64 GNU/Linux
```

This was screaming at me - just write a program in a normal programming
language, and cross-compile it to mips64. Which naturally drove me to Go (as
everything does). One thing led to another, and that's how
[github.com/sgzmd/network-status](https://github.com/sgzmd/network-status) came
into existence. I will not bore you with the details of how to build or
configure it (just head to the github link above, for a chance the `README.md`
is pretty comprehensive there), but if you are in the same situation as I - give
it a go, and let me know how it works for you.