---
title: "Android Safety UX: What's that all about?"
date: 2024-08-06T13:01:25+01:00
draft: false
---

> This is the second post in Android Safety UX series - you can find the first
> one [right here](https://blog.kirillov.cc/posts/android-safety-ux-cybersecurity-ux-challenges/).

## Part II - Safety UX: what's that all about?

Previous post was but a teaser for things to come. Here, we will
start talking about our journey towards building Android's safety UX - how we
came to the realisation that the work is needed, and what we did to address it.

Let me start with a cool picture though.

![You have a virus!](/static/asux-pv/virus.png)

Back in 2016 my mum messaged me - the dedicated family tech support guy - with a screenshot not unlike the one here and called immediately thereafter, in panicked voice explaining that something was wrong with her phone, and she has viruses. It took me a considerable effort to convince her that she, in fact, didn’t have any viruses and should she just walk away from this website and forget about it, nothing terrible would happen. 

That, however, made me start thinking - we are doing a lot to protect the user,
but are we doing enough to educate them?

Even in 2016 security space on Android was already very complicated. Problem of malware on Android was at its highest. Users were confused - many of them clearly understood that something isn’t right, but usually lacked the judgment - and, frankly, information on what the “right” is and how to achieve it.

Confused users make irrational decisions - in attempts to protect themselves,
they were installing various 3P “security” solutions - and I’m deliberately
using quotes here, because while there are reputable security companies, many
bad guys were looking to capitalize on this situation, to their own benefit.
Would my mum not have someone to talk to about that “virus”, it’s highly likely
that she would proceed with the install - and then she would have a problem.

![Angry User](/static/asux-pv/angry-user.jpg)

It became apparent that something needed to be done on Google side. One obvious
direction which Google has pursued is dramatically increasing the investment
into Android malware detection - and it did had a desired effect, as the sheer
number of malware we stop has increased by multiple orders (possibly, several
orders of magnitude) in these 5 years. But the weakest link of any security
system still remained users,  and it was clear they need help.

Orthogonal to that, the lanscape of users' preferences started changing.
Security became a selling point - and it was clear that users were starting to
consider security as a feature, on par with battery life or camera quality.
There were multiple
[studies](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0173284)
confirming that, some of them conducted by the industry, and some by Google itself.

![Angry User](/static/asux-pv/security-important.jpg)

In the end, all of this combined led to realisation that we should start taking
a holistic view of end-user safety, and start building a comprehensive story
around it. To re-iterate what I already mentioned in the [first post](https://blog.kirillov.cc/posts/android-safety-ux-cybersecurity-ux-challenges/) of the
series, it became clear that in addition to improving factual
user security, we also have to address users' perception of their safety at the
same time.

However, as Peter Drucker eloquently put it, one cannot improve what one cannot
measure. We can, with some caveats, measure objective user safety - by using
various proxy signals such as malware detection rates, or user feedback. But how
can we measure user's perception of their own safety? 

We started with a foundational study - literally going to the users, and asking
them very open-ended questions about their safety, and what they think about it.
This was one of those studies, where not only we didn't really know the right
answers, but we weren't even sure about the right questions to ask. In the end,
after hundreds of hours of interviews, it all boiled down to a few facts:

- Users don't know if their device is safe or not;
- By and large, users are not aware of _anything_ Google is doing to keep them
  safe;
- Users are expecting clear guidance from _someone_ on what to do to stay safe
  (and not getting this guidance most of the time).

This was something we could work with. We _still_ didn't have all of the answers
(or even questions) but we had a direction. We knew that we had to start by
telling user out right, if they are safe or not - this is how Google Play
Protect was born.

**To summarise what we've discussed today:**

> - We realised that users often lack the knowledge to make informed security
>  decisions, leading to vulnerabilities despite our efforts to enhance malware
>  detection.
>
> - As security became a key user concern, it became clear that we needed to
>  address both actual security and users' perceptions of safety.
>
> - Through user studies, we discovered that people are unsure about their
>  device's safety and unaware of Google's protective measures, leading us to
>  develop Google Play Protect to provide clear safety information directly to
>  users.

In the next post we'll be talking about the first iteration of Google Play Protect,
how we built it and what were the challenges we faced. Stay tuned! 
 