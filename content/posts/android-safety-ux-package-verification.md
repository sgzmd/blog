---
title: "Android Safety UX: Package Verification in the Android OS"
date: 2024-08-06T13:30:42+01:00
draft: false
---

This is the second post in Android Safety UX series - you can find the first one [right here](https://blog.kirillov.cc/posts/android-safety-ux-cybersecurity-ux-challenges/).

In the previous post, we mentioned that Google Play Protect was our first step in the direction of building Android's safety UX. Let's dive straight in - but before that, I feel like we need a crash course in how Android's anti-malware protections work - I figured this might be useful since I couldn't find a comprehensive view of this available anywhere in the open (even though most of it isn't really a secret in any sense of the word).

This section will be fairly technical since it lays the foundation and provides some answers to why things were built the way they were built.

## Android Package Verification (or PAM)

The mechanism of package verification is a really old concept and goes back at
least Android 2.3 Gingerbread. Despite the fact that it was designed and
initially built 13 years ago (at the very least, the oldest fossils I found in
AOSP codebase can be dated to that period), it is still very much one of the
cornerstones of Android security.

![Package Verification - Simplified Sequence Diagram](/static/asux-pv/pv-seqdiag.png)

The picture above is a ridiculously over-simplified version of how it works. In
a nutshell, any app that wants to install an APK, (indirectly) calls
`PackageManager`, asking it to install the app:

```java
Uri apkUri = Uri.fromFile(new File("/path/to/your/app.apk"));
Intent intent = new Intent(Intent.ACTION_VIEW);
intent.setDataAndType(apkUri, "application/vnd.android.package-archive");
intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
startActivity(intent);
```

Obviously this omits many details, such as checking if the app has `REQUEST_INSTALL_PACKAGES
permission, signature and integrity checking, as well as additional security measures introduced in the latest versions of the OS - here I am focussing strictly on the anti-malware component (PAM == Platform Anti-Malware).

What happens after that is, `PackageManager` parses the APK, and hands it off to the `PackageVerifier`. This [blog post](https://irq5.io/2014/12/01/android-internals-package-verifiers/) explains in some details what is the package verifier from the OS standpoint and how does it work - while it's quite old and likely predates all our work on Google Play Protect, fundamentals haven't really changed that much. If you are interested in how it all really works, [PackageManagerService.java](https://cs.android.com/android/platform/superproject/+/android14-qpr3-release:frameworks/base/services/core/java/com/android/server/pm/PackageManagerService.java;l=2639) is a fascinating read - after all, it contains gems such as `getRequiredButNotReallyRequiredVerifiersLPr` methods - but I leave this as an exercise for the keen reader.

The sequence diagram above illustrates the "happy" path - i.e. when we don't have any incriminating evidence against the app. When we did find something noteworthy, users were presented with a warning dialogue:

![Package Verification - PAM warning](/static/asux-pv/pam-warning.png)

<small>(note, that I don't have actual screenshot of the warning from older versions of the OS - what you see here is a version of the dialogue before the last redesign that I found online).</small>

The only thing remaining to mention is that in addition to install-time verification, we periodically rescan installed apps (yes, even system and preloaded apps!) - it is entirely possible that our verdict for some app has changed since the last rescan.

You might've noticed that we've glossed over the `PackageVerifier` - what is that? Well, the answer to that question is complicated. I will once again refer you to the [Android internals](https://irq5.io/2014/12/01/android-internals-package-verifiers/) blog post that goes into the guts of package verification, but these are the key points to know:

- Any Android device must have at least one `PackageVerifier` marked package.
- Android devices may have more than one package verifier - but only one is mandatory and must always be present.
- On [Android GMS](https://www.android.com/intl/en_uk/gms/) devices (or, in other words, devices with preinstalled Google Play Store and a suite of Google's apps) mandatory package verifier is set to `com.android.vending` - which is Google Play Store (or Phonesky in internal lingo).

With me so far? To summarise what we've just discussed:

1. Every single app installed on Android goes through the process called package verification.
2. This is facilitated by a component called Package Manager, which is the part of the Android OS.
3. During installation it makes callouts to the package verifier.
4. Package verifier takes care of deciding if the app is OK to install - we can mostly see it as a black box for now
5. If package verifier says it's OK, the install will proceed - otherwise it will warn the user and give them a chance to abort the installation. It will then return the final verdict (scan results + user's choice if any) to the package manager, which either proceeds with the installation or aborts it.
6. On GMS Android package verifier (by and large) is bundled to the Play Store - for the most part, for historical reasons.

In the next post we'll be finally talking about the UX - what did it look like, which evolutions it went through and what is it looking like right now.
