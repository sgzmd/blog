---
title: "Audioengine speakers in Linux"
date: 2023-05-21T10:17:25+01:00
draft: false
---

I have been using Audioengine HD3 speakers for a while now, and I am very happy
whenever I'm using them on Mac or Windows. However, whenever I am about to do
some hacking and boot into Linux (Ubuntu 22.04 for me, but seems to be it's
exactly the same across the board), they just refuse to work.

Well, not exactly refuse to work - if you happen to have a `.wav` file
'formatted' at 48kHz, it works just fine, but that's not exactly what I call
"working" as for everything else they just produce a burst of sound and then
shut up.

Today I accidentally stumbled upon this wondderful [blog
post](https://jfreeman.dev/blog/2021/07/13/how-i-debugged-my-audioengine-hd3-speakers-in-linux/)
which explains in some details _why_ they do not work (TL;DR default PulseAudio
sample rate is set to 44kHz which works just fine for most of the speakers, but
not for these ones). I'm just leaving the solution here for when I forget how to
fix it next time:

1. Edit `/etc/pulse/daemon.conf` and:
```
default-sample-rate = 48000
alternate-sample-rate = 48000
```
2. Restart PulseAudio: `pulseaudio -k`
3. Enjoy the music!

I am amazed that it was really as simple as that. Hopefully folks at Audioengine
include this into their support pages (since fixing PulseAudio is not exactly
their job).

