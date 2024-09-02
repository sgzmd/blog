---
title: "Android Safety UX: Introducing Safety Centre"
date: 2024-09-02T09:14:16+01:00
draft: false
---

Welcome to the series of posts on the foundations of safety UX in Android.

> This is the 6th post in the series. Among other things, previously we discussed [what is Safety UX](https://blog.kirillov.cc/posts/android-safety-ux-what-about/), how [package verification works](https://blog.kirillov.cc/posts/android-safety-ux-package-verification/) in Android, [how we built Google Play Protect](https://blog.kirillov.cc/posts/android-safety-ux-google-play-protect/) and why [we decided we need to keep going](https://blog.kirillov.cc/posts/android-safety-ux-now-what/).

If you remember, we finished the [last post](https://blog.kirillov.cc/posts/android-safety-ux-now-what/) by saying that solving the problem of unifying Safety UX in Android required not only non-trivial amount of technical work, but also imposed some _very_ substantial organizational challenges - both within and outside the company.

![Single space for safety](/static/asux-pv/single-space.png)

It was very clear that the problem is too big to chew - in one bite at the very least. From the very beginning we had our eyes set on _safety_ - which encompasses both Security _and_ Privacy (besides, very often in the eyes of users these things are very hard if at all possible to distinguish!). That, however, complicated things greatly - and the reason for that were the blurred lines of what is, and what isn't OK for users.

Let me illustrate this with an example. One of the great features on Android is Google Find My Device (which by the way was also built in London by our team - but this is perhaps a topic for a _whole_ new series of posts!). It is extremely handy to be able to find your phone - or your headphones, or your watch - quickly, and I personally use this feature all the time. On the other hand, for some users this can be seen as tracking - and if a hostile party has access to your account (or one of the accounts on your device), they can see where you are. 

There are multiple steps taken to mitigate this problem, make it more transparent for the user and reduce the probability of abuse, but fundamentally it is an intrinsic aspect of the feature. This is just one example - and there are lots more, such as cloud backup (great convenience feature, but also a vector of an attack - depending on which entities are the part of the threat landscape, ad personalization and don't even get me started on the whole end-to-end messaging encryption story).

As the result, there were lots of internal debates, and in the end we decided that for the initial version we'll start only with security - after all, it was a bit more clear-cut (not by a lot though - things like biometrics often have same inherent challenges as described above). 

This was the critical time for Android as alongside Android 12 we were launching Google Pixel 6 - first Android device made completely by Google, from SoC to all the hardware to the software - and security was one of the biggest highlights of this device.

![Pixel Security Hub](/static/asux-pv/security-hub.png)

In Android 12 we launched Pixel Security Hub, which unified all the security features provided by Android - from Google Play Protect, to Platform security settings, to Google Account Security Advisor. From Google Play Protect, we inherited the concept of traffic light signals - arguably the most important visual concept in the new model. For the first time ever, users were able to answer the question “am I safe” with zero effort. To achieve this, for the first time we had to formally define of what it means to be fully “safe” on Android - and integrate with various first-party security features previously scattered all across the OS.

![Android Police](/static/asux-pv/review.png)

Pixel Security Hub was very well received by the users and press. One article I really enjoyed was [from Android Police](https://www.androidcentral.com/googles-security-hub-android-12-feature-needs-be-every-device) - they really got the gist of the feature, stating that while everything that Security Hub offered was possible in previous versions of Android, for the first time, it’s available in the same place, and is easy to understand and easy to resolve any outstanding issues. They said that this feature needs to be on every Android device as it was Pixel only for the moment. Needless to say, we saw this coming.

Overall, Pixel Security Hub was a big achievement for the team and Android - but the story didn't end there: we left a lot of scope to squeeze this into Android 12; now it was time to square all the corners. While we got our proof of concept, this required us going back to the drawing board - but this will be the topic of the next post. 