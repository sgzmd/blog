---
title: "Meta vs Google: first take on eng culture"
date: 2024-10-05T11:04:27+01:00
draft: false
tags: 
  - Meta
  - Onboarding at Meta
  - Tech
---

Before I joined Meta, I had a few expectations about the engineering culture here. The most notable being:

- **Move fast and break things** (though the "break things" part has been retired for some time now)
- Meta uses a **monorepo** (just like Google). But, as is the case with Google, there are actually several monorepos - so yes, it's technically a misnomer, but that’s just how it works.
- They use **PHP** (or more precisely, [Hack](https://hacklang.org/), an evolved version of PHP with static typing and other improvements).

Now that I’m 3 weeks in, freshly out of Bootcamp, I’ve had some time to form a few early thoughts. I’m mostly writing this for myself as a mental note while I still maintain that outsider’s perspective - because I know that in a few months, once I’ve got a few projects under my belt, that perspective will fade.

### Monolithic at First Glance

The first thing to note: it’s not just a monorepo. It’s a monorepo that powers a **monolithic** product. That’s right - the majority of the Facebook codebase (living in the so-called `www` repo) is deployed as a single _massive_ PHP project. At first, this was mind-boggling: in a time when microservices and serverless infrastructure are the norm, Meta is still proudly deploying this _huge_ monolith.

But then, once you start thinking about it, it gets more interesting. Yes, it’s monolithic - but in practice, it’s continuously deployed, bit by bit (or, more precisely, diff by diff - Facebook's lingo for what is called PRs or - at Google - a CL). To reiterate: it’s a monolith, sort of, but it’s deployed incrementally. On average, it takes about 6 hours from when a diff lands in `www` until it shows up in production, powering Facebook.com and its other services.

When you dig into it, you realize it’s not quite monolithic in the traditional sense  -  since it’s not deployed all at once. But is it a good approach? I’m still figuring that out. There are definitely benefits. For example, when you need to refactor files across multiple systems, in a "classic" microservices world, that would mean coordinating multiple releases to ensure that service A, which depends on service B, which depends on service C, are all backward- and forward-compatible. Another benefit is the lack of RPC latency  -  something that comes with microservices architecture (and from what I've seen at Google, can _really_ start piling up once you are several layers in) but doesn’t exist here.

### The Trade-offs

Of course, there are trade-offs. The biggest one stems from the fact that Hack is still just an evolution of PHP. I’ve already encountered cases where developers use internal APIs of another system, even though those APIs weren’t meant to be exposed  -  simply because it’s convenient at the time (of course, it’s less convenient when those internal APIs change without anyone expecting external usage causing a massive outage - or SEV, short for Site EVent as those are called at Meta). 

Another significant trade-off is **scaling** - this is probably more difficult, though it’s well-concealed from developers. But a bigger issue is that **automated testing** becomes a challenge. Even small changes can trigger "let’s-retest-the-world" scenarios, and isolating and testing systems hermetically can be a major pain. Finally, this model of development encourages **tight coupling** between systems, which makes it much harder for a newbie (like me) to understand how everything fits together. Not impossible to work around, but it requires a lot of engineering discipline.

### Conclusion: Is Agility Enough?

Ultimately, the key point is that this approach has allowed Facebook to move fast - really fast. According to people who’ve been here for years, without this level of agility, Facebook might not have survived. But as the saying goes, "what got you here won’t get you there." So, what do you think? Is there a point in a company’s lifecycle when it needs to shift toward more rigorous engineering practices, or can the start-up mentality be sustained indefinitely?
