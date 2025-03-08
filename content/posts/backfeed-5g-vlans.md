---
title: "Backfeeding 5G: Beating Bad Internet with VLANs"
date: 2025-03-08T11:36:09Z
draft: false
---

It's been a while since I [last wrote](https://blog.kirillov.cc/posts/failover-on-usg/) about anything [vaguely network-related](https://blog.kirillov.cc/posts/policy-based-routing-usg/) - well, that's because everything's been working fine. Until now, that is. Virgin Media decided that randomly going down for a couple of hours is a fine way to spice up their users' otherwise boring lives. And when it's up? Why not crank up latency to 500ms a few times an hour, just for laughs? Yeah, not great. Very, very annoying.

Normally, that wouldn't be a huge problem since, back in the day, I had two ISPs (Internet Service Providers) running to my house - my regular Virgin Media and the wonderful [Andrews & Arnold](https://www.aa.net.uk/) - _the_ geeky ISP, built by geeks for geeks, which I used as a backup. I would gladly use it as my main ISP, but I'm not in a full-fibre coverage area, so at best, I'd get 75 Mbps, which is kinda... meh by today's standards. But since I switched to an office-based job, I figured paying for two ISPs probably wasn’t worth it - until now.

The catch? I didn’t want to pay for a full-fat ISP contract. So, naturally, I started looking into mobile broadband as an option. Turns out, it _is_ an option - just with a bunch of caveats.

### Mobile Coverage

Overall, I have decent mobile coverage where I live:

<a href="https://www.speedtest.net/result/a/10742909366"><img src="https://www.speedtest.net/result/a/10742909366.png"/></a>

Not the highest 5G speeds out there, but pretty damn good - better downloads than Virgin (547 Mbps down / 30 Mbps up, with ~13ms ping). But this only happens when I’m standing by the window facing the 5G mast (not _exactly_ in line of sight, but pretty close). The situation changes dramatically once I go to the closet where most of my networking gear is stashed:

<a href="https://www.speedtest.net/result/a/10742914240"><img src="https://www.speedtest.net/result/a/10742914240.png"/></a>

Yeah... not even funny anymore. Download speed dropped by a factor of 36x. So, I needed to put my 5G router somewhere close to that sweet spot by the window. Luckily, I have a cupboard there, with an Ethernet socket, and even when the cupboard is closed, things aren’t _that_ bad - 395 Mbps down, 16 Mbps up, with ping in the high 30s. Unluckily, that cupboard also houses a few other things - switches, a mini-PC running my Blue Iris setup (which records my security cameras), plus a PoE (Power over Ethernet) switch for outdoor cameras.

### The Problem

I had to use _one_ Ethernet wire to connect all these devices to my main router - and that same wire had to carry the backup internet connection. Surely, there had to be a way to make this work, right? After consulting ChatGPT, I realized there _was_ a way: using managed switches and VLANs (Virtual Local Area Networks) to separate traffic.

Unfortunately, this is where I hit the limits of my networking knowledge, and things got messy.

### Troubleshooting VLANs

After misconfiguring everything a bunch of times, I got to a setup that _should have_ worked. But instead, I ran into [STP (Spanning Tree Protocol) loops](https://help.ui.com/hc/en-us/articles/24292724428311-Understand-and-Mitigate-Network-Loops-STP), which basically shut down my entire network. Luckily, the wonderful folks at the Unifi forums [came to the rescue](https://community.ui.com/questions/Backfeed-4G-connectivity-via-2-switches-to-UCG/54f8a4fb-b058-4fda-82ba-b0d9a4952cf3) and pointed me to a [video](https://www.youtube.com/watch?v=B7g09QJzP4o) of a guy doing pretty much the same thing with Comcast and Starlink.

After watching it a couple of times, I realized I _almost_ had everything set up correctly. Of course, the fact that I _thought_ I was using Port 1 on my main switch when I was actually using Port 2 didn’t help. Took me another half-hour to figure that out. But in the end, I got it working, so I figured I'd document it here for anyone who wants to replicate this setup but prefers a written guide over YouTube videos (seriously, give me a text manual any day - why is everything a video these days??).

But I digress.

### The Setup

<div style="width: 640px; height: 480px; margin: 10px; position: relative;"><iframe allowfullscreen frameborder="0" style="width:640px; height:480px" src="https://lucid.app/documents/embedded/e888a0fc-57db-4c15-b51b-053701a5fe19" id="a~pZYjkn9xwA"></iframe></div>

Above is a very simplified version of my home network (it only includes the two switches and leaves out WiFi, since it's not relevant). The key idea was:

#### **Step 1 - Create a New VLAN in Unifi**

First, I created a VLAN in Unifi Network settings. The key here is to create it as a 3P VLAN (Third-Party VLAN), meaning Unifi assumes it exists and some other router is "powering" it:

![](/static/vlan/20250308112354.png)

Here, I used VLAN ID 17 - but it can be anything, as long as it doesn’t clash with other VLAN IDs.

![](/static/vlan/20250308112438.png)

#### **Step 2 - Assign VLANs to the Right Ports**

Now, we need to make sure the VLAN is correctly assigned to the involved ports.

**Rule of thumb:**  
- Ports that should carry _only_ this VLAN → Set as **Native VLAN** and block all others.  
- Ports that must pass through this VLAN → Set as **Tagged VLAN**.  

Start with the switch where the 5G router is connected:

![](/static/vlan/20250308112741.png)

Here, Port 5 is set to VLAN 17 as native, and all other VLANs are blocked. On the main switch, things look slightly different:

![](/static/vlan/20250308112843.png)

- Port 6 (which connects to the second switch) has VLAN 17 as **tagged** - so it passes the VLAN through.  
- Port 2 (which connects to the Unifi router’s WAN2 port) has VLAN 17 as **native** and blocks all other VLANs.

From there, Unifi makes it pretty straightforward to set up a distributed or failover profile for WAN2:

![](/static/vlan/20250308113056.png)

### **Bottom Line**

Everything works now! And once you dig a bit deeper into how native vs. tagged VLANs work, it actually makes sense. Hopefully, this setup holds up for a while - at least until I come up with another crazy networking idea. 😁

