---
title: "Android Safety UX: Perception is Reality or Hidden Challenges in Cybersecurity"
date: 2024-08-05T13:30:42+01:00
draft: false
tags: 
  - Android
  - Android Safety UX
  - Tech
---

<small>This post is intended to be the first of the series Android Safety UX series, talking about Google's journey and findings in the space of keeping Android users safe. So, without further ado...   </small>

## Part I - Perception is Reality or Hidden Challenges in Cybersecurity

I wanted to write this post for a very long time - but only realistically found some time to do so when I was in between jobs - after I left Google, but haven't quite joined Meta. Either way, there's nothing confidential I will be talking about (in fact, this will be more or less expanded version of the talk I delivered at [GSMA Fraud and Security Group](https://www.gsma.com/get-involved/working-groups/fraud-security-group) earlier this year), so let's get rolling.

Let's start with a teaser: what is _really_ the hardest problem in cybersecurity? Those of you in the field know, that by far the [weakest link in the chain](https://www.isaca.org/resources/isaca-journal/issues/2022/volume-1/humans-and-cybersecurity-the-weakest-link-or-the-best-defense) are users themselves - and there are [numerous studies](https://link.springer.com/article/10.1007/s10111-021-00683-y) confirming that. When I joined Android Security team something like 8 years ago, we already had a broad understanding, that this is the case - however, we didn't anticipate, exactly how much influence users themselves - and their perception of their own safety - has on the overall security of their device and data.

Android's efforts to improve user security began long before that - but for a very long time we assumed, that security is not something users simply need to worry about - after all, as long as users follow our recommendations (e.g. do not install apps from shady websites), they will be pretty safe. Unfortunately, reality turned out to be a lot more nuanced than that.

Android was and remains an open ecosystem - and as everywhere, not everyone means well, and there are people and companies who are willing to walk an extra mile (or ten) to exploit Android users for their gain. One particular trend we were seeing more and more often back then, was that hostile actors were exploiting users fear, uncertainty and doubts (which [are not limited](https://userlab.utk.edu/publications/bitaab2020scam) to users digital security!) about their own safety, to trick them into installing "security" apps which were asking for some excessive permissions ... et voila - _now_ users actually have a problem.

So the problem, as it turned out, was at the very least two-pronged: we had to
improve factual user safety, as well as address users' _perception_ of their
safety at the same time. We had to _keep_ users safe, and keep them informed
about that - without being too much into their face. Needless to say, this was a
new thing to do for Android (or, frankly, for the industry at large). In the
next post I'll talk about [Google Play
Protect](https://developers.google.com/android/play-protect/client-protections)
- our first step in that direction, and what followed it.

*Update:* second post in the series is now available - [Part II - Safety UX: what's that all about?](https://blog.kirillov.cc/posts/android-safety-ux-what-about/). 
