---
title: "Ultimate rsync one-liner for full VPS migration"
date: 2026-01-19T11:27:25Z
draft: false
---

I am mostly leaving this note to myself for future reference - but maybe someone else will find it useful too. 

When MassiveGrid decided that right about now is a jolly good time to raise their prices from ~$25 for my VPS to just under $100, I felt that the grand VPS migration I've been contemplating for a little while now is actually overdue.

To spare you my soul searchings, I went with Hetzner Cloud - they have locations I want (kinda), prices I'm happy with, and much, much newer hardware. _Apparently_, and this is sarcasm for those who missed it, by moving from 24-vCPU VPS built on top of 11 year old Haswell, to only a 4 vCPU, but running atop state-of-the-art AMD EPYC chip, means not losing much if at all in the overall performance, where multi-core is concerned (conversely, 300% win for single-threaded applications, which is nice).

But I digress. The thing which made my write this post, was: how _ridiculously_ easy was that to migrate from one VPS to the other, with all the Docker containers and custom configs, and all, with one well targeted `rsync` command. I will leave it with some basic documentation here, for future generations to learn:

```bash
rsync -avzHSX \
  # Use numeric IDs; prevents permission mess by ignoring
  # user names during transfer.
  --numeric-ids \
  # Enhanced progress output; cleaner than the old style.
  --info=progress2 \
  # Runs rsync as sudo on remote; allows root-level access
  # without needing to SSH directly as root.
  --rsync-path="sudo rsync" \
  # EXCLUSIONS: Prevent overwriting hardware-specific files.
  --exclude='/dev/*' \       # Skip device nodes
  --exclude='/proc/*' \      # Skip process info
  --exclude='/sys/*' \       # Skip hardware info
  --exclude='/tmp/*' \       # Skip temp files
  --exclude='/run/*' \       # Skip runtime state
  --exclude='/mnt/*' \       # Skip external mounts
  --exclude='/media/*' \     # Skip removable media
  --exclude='/lost+found' \  # Skip recovery fragments
  --exclude='/etc/fstab' \   # KEEP target mount rules
  --exclude='/etc/mtab' \    # Skip mount table
  --exclude='/boot/*' \      # KEEP target kernel/grub
  --exclude='/etc/modules' \ # KEEP target drivers
  --exclude='/etc/network/*' \ # KEEP network (Debian)
  --exclude='/etc/netplan/*' \ # KEEP network (Ubuntu)
  # TRANSPORT: Secure shell tunnel.
  -e ssh \
  # SOURCE: Remote root directory contents.
  myusername@myvps:/ \
  # DESTINATION: Local root directory.
  /
```

The one bit of config it required (well, two actually) were:

- Creating `~/.ssh/config` entry for `myvps` - its running on a non-standard port (as it should be)
- Copying my private key to access VPS, because password login was disabled (again, as it should be).

This was literally it. `rsync` copied ~35G in something like 15 minutes, I rebooted the target system et voila - after pointing Cloudflare's DNS to the new IP address, literally _everything_ started working again (or at the very least, I didn't discover _yet_ things that are broken). 
