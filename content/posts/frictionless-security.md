---
title: "Frictionless Security - Part I"
date: 2023-10-07T18:55:23+01:00
draft: true
tags:
    - security
    - ux
    - account-security
    - friction
    - user-experience
---

# Frictionless Security - Part I

In the classic model of account security, you employ a multi-layered defence during the sign-in process: a strong password, optional - or perhaps not-so-optional - two-factor authentication (2FA); and more recently, Passkeys have become the go-to technology to keep accounts protected.

The idea is to protect the front door as much as possible and keep it strong. This idea isn’t new. Until relatively recently, mandating regular password rotation was considered a must (even though few understood _why_ or _if_ this was a good idea, especially if there were [no signs the password had been compromised](https://blog.1password.com/nist-password-guidelines-update/)).

More recently, we’ve begun to realise that side access - i.e. account recovery - needs just as much, if not more, protection. After all, more and more account takeovers happen through recovery. Since there’s more than one way to recover an account, we started risk-profiling recoveries - which is also a good thing - because it brings us to the point of this post: user friction.

What if I told you that instead of protecting front and side doors as much as possible, you needed to keep friction to an absolute bare minimum? Like, _near-zero sort of minimum_ - the lower the friction, the better, ideally no friction at all. Any seasoned security professional would laugh in my face, but hear me out: this is a challenge many companies are facing.

## The problem with friction

Imagine your business earns money _if and only if_ the user is signed in. This is typical of many social media platforms - but not limited to them. Most ad-supported platforms are like that: if the user isn’t signed in, they can’t interact with the platform; you don’t know anything about them (or know very little); you can’t show them relevant ads - or at least the _most_ relevant ads - and you can’t make money (or you’re leaving a lot of money on the table).

However, it’s not only about ads. Many platforms follow a "freemium" model, where users can use the platform for free, but only if they’re signed in. If they’re not signed in, they can’t use the platform at all or have very limited access. This is typical of many SaaS platforms - you can’t upsell users to premium plans if they’re not signed in, so you’re not making any money.

Then there are marketplaces  -  like eBay, Etsy, Amazon, etc. - where users can only buy or sell if they’re signed in. If they’re not, they can’t buy or sell, so you’re not making any money either.

You see where this is going, right? If the user isn’t signed in, you’re not making money - any extra friction means user churn, which means lost revenue.

On the other hand, if you reduce friction too much, you risk account takeovers - which also means lost revenue - and sometimes direct damage to GMV in the form of revenue leakage (for ad-supported platforms) or fraud (for marketplaces), or both. To make this even more complicated, if you handle money, or user PII, or both (which basically covers any business), you’re also at risk of regulatory fines, which can become very expensive, very quickly.

Finally, there’s the problem of user trust. As I covered extensively in my [Android Security UX](https://blog.kirillov.cc/posts/android-safety-ux-cybersecurity-ux-challenges/) series, users who trust the platform are more likely to use it and to spend money on it; the opposite is also true.

## Finding the balance

Initially, I wanted to write a tweet about this, but it turned out to be a bit more complicated than that, so I decided to write a blog post instead. Then I realised this topic deserves more than one post, so I decided to make it a series. There are a few things I’ll cover:

- The key principles and trade-offs we need to agree on _before_ designing the system and making any decisions about friction vs. security.
- The shift in the philosophy of account security  -  how we’re moving from an all-or-nothing approach to a risk-based approach - and what that means for friction.
- What the actual layers in the system are, and how they interact with each other.
- What the key levers are that we can employ.

There will probably be more topics as I go along, but this should be a good start. Stay tuned.