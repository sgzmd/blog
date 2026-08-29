---
title: "Welcome to the Galápagos - Korean Digital Ecosystem, Part II"
date: 2026-08-29T17:24:00+08:00
draft: false
tags: 
  - Tech
  - Korea
---

In the [previous post](/posts/korean-digital-ecosystem-part-i/), I promised that the next instalment would be about the "Korean Banking Byzantine Nightmare". Guess what? I made a tactical mistake.

Instead of just writing down all the weird, wonderful, and wonderfully weird things that happened while I was trying to get a Korean bank account and move money around, I started researching **why** Korean banking works this way. 

This turned out to be a rabbit hole. Then the rabbit hole turned out to have its own metro system, several government agencies, a certificate authority and, for reasons we will get to shortly, a Windows kernel driver.

As it stands, the banking story connects _also_ directly to Korean online identity. Which connects to the Resident Registration Number. Which connects to mobile phone authentication. Which connects to how Korean privacy regulation evolved. Which connects to ActiveX and Internet Explorer. Which connects to a particularly Korean approach to security regulation. Which connects to why Korean corporate computers are full of software that I will later argue deserves to be called mandatory spyware.

And then there are Naver, Kakao, maps, domestic standards, WIPI, WiBro and the slightly awkward fact that quite a few of the things I was planning to complain about have actually improved dramatically in the last ten years (imagine what it was like in 2016!)

ANYWAYS.

It turns out that "why is the Korean digital ecosystem so weird?" is a significantly bigger question than I anticipated, so Part II will itself have to become a little series.

## The Hit List, Part II Edition

At least for now, I’m planning to break the story into three reasonably-sized chunks, rather than subjecting everyone to a 10,000-word monstrosity in one go:

1. **How the Galapagos was made** — Korea's early digital success, unusually prescriptive technology regulation, Internet Explorer, digital certificates and the magnificent world of mandatory Korean banking ~~spyware~~ security software. This is the post you are reading now.
2. **The invisible Korean operating system** — real-name identity, mobile phone authentication, why foreigners are an excellent integration test, and why Naver/Kakao are a completely different kind of “Galapagos” from ActiveX.
3. **Escaping the Galapagos** — what actually changed between roughly 2015 and 2026: the death of the accredited-certificate monopoly, disappearance of most ActiveX, Open Banking, MyData, Apple Pay, mobile ID, network-separation reform, T-money on iPhone and, finally, Google Maps. And, more importantly, what *didn't* change.

Roughly 2,500–3,500 words each feels about right. Famous last words.

Before we get to banks, however, we need to answer a more fundamental question.

# Wait, Isn't Korea Supposed to Be Really Good at Technology?

Why, yes, of course, it is - and it's actually _one of the best_ in more aspects than one. This is the first thing that makes the whole story interesting.

If Korea were simply technologically backwards, none of this would warrant several thousand words. Countries have legacy systems. Governments run ancient software. Banks have terrible websites. Somewhere in the world, right now, there is undoubtedly a business-critical Windows XP machine which everyone is afraid to reboot. Sky is blue, rain is wet.

Korea, though, is different. Korea is one of the most digitally advanced societies on Earth.

The OECD ranks Korea **first** in its [2023 Digital Government Index](https://d110erj175o600.cloudfront.net/wp-content/uploads/2024/02/02135401/DGI.pdf). This isn't some narrowly defined "our government has a website" award — the index evaluates things such as digital-by-design government, data use, government platforms and proactive digital services. Korea tops the overall list.

And this isn't even new.

The [Korean government](https://www.mois.go.kr/eng/sub/a03/digitalGovernmentHistory/screen.do) was already drawing up a Five-Year Basic Plan for Administrative Computerisation in 1978 - _nineteen-bloody-seventy-eight_, when "personal computer" was still a fairly adventurous concept, In 1987 it launched national information networks covering public administration, finance, education and research, defence and public security. The Korea Information Infrastructure project followed in 1995, explicitly intended to build high-speed networks across the country.

Then broadband happened - and in February 2001, Korea passed 10 broadband subscriptions per 100 inhabitants. That doesn't sound terribly exciting today, until you realise that it was more than [twice the penetration of the next-best OECD country](https://www.oecd.org/en/publications/the-development-of-broadband-access-in-the-oecd-countries_233822327671.html) at the time (which just happens to be Canada - no surprise I always liked it so much!) By the middle of the year Korea was at 13.9 broadband subscriptions per 100 inhabitants, and the OECD essentially wrote that everyone else should expect to be measured against Korea for the next few years. Later revisions of the OECD data put Korea above 20 fixed-broadband subscriptions per 100 people during 2001, still dramatically ahead of almost everyone else. 

In other words, Korea did not spend the late 1990s desperately trying to catch up with the Internet. As a matter of fact, _Korea got there first._

And I think this is the most important bit to understand about the whole Korean [digital Galapagos](https://vivaexpeditions.com/blog/the-weirdest-wildlife-on-the-galapagos-islands). A surprisingly large number of things which look ridiculous in 2026 were not ridiculous when they were introduced.

**They were solutions. Often pretty good solutions.**

The problem is that a solution has a lifecycle, while infrastructure has a half-life somewhere around enriched uranium.

# The Early-Adopter Trap, Again

If you remember the previous post, this was essentially [my explanation for T-money](https://blog.kirillov.cc/posts/korean-digital-ecosystem-part-i/).

Korea built a very good contactless transit payment system extremely early. Because it worked, the infrastructure spread everywhere. Readers, cards, backends, operational processes, contracts and user behaviour accumulated around it.

Then the rest of the world eventually developed increasingly standardised open-loop contactless payments. At that point London could gradually bolt contactless bank cards onto Oyster infrastructure.

Korea already had millions of people perfectly happily using T-money - and this distinction matters. There is a huge difference between:

> "Nobody has solved this problem yet, what should we build?""

and:

> "We already have a solution which works for 50 million people; shall we toss the entire thing and rebuild anew, because ~~there's new shiny framework~~ some new global standard is architecturally nicer?""

The second question is somehow much harder to answer. But there is another ingredient in Korea which made this early-adopter trap substantially stronger.

The government did not merely encourage digitalisation.

Historically, Korean regulators were quite willing to tell companies exactly _how to implement it_. And as a security engineer, this is where I start developing a nervous twitch.

# Thou Shalt Be Secure - Specifically Like This

There are broadly two ways to regulate technology. The first is to specify the outcome.

For example, Article 32 of GDPR says ~~don't be idiots; secure it appropriately or else~~ that organisations processing personal data must implement technical and organisational measures appropriate to the risk, taking into account things such as the state of the art, implementation cost, context and severity of potential harm. It gives examples — encryption being one — but fundamentally leaves the architecture to the organisation. 

In security-engineering language:

> Here is the property we need you to achieve. Show us how you are achieving it and why the residual risk _(read: whatever is simply infeasible to cover)_ is acceptable.

This can occasionally be maddening because "appropriate" is doing A LOT of work in that sentence, but it has one huge advantage: the regulation can survive technology changing underneath it.

The second approach is:

> Here is the property we need you to achieve. Also, here is the checklist.

Korea has historically had a lot more of the latter.

One modern example is ISMS-P — the Information Security and Personal Information Management System certification framework operated under Korea's security/privacy regime.

_(now, a clarification before someone sends me a 47-message LinkedIn essay: GDPR and ISMS-P aren't equivalent things. GDPR is legislation governing personal-data processing; ISMS-P is a security and privacy management-system certification framework. ISMS-P also absolutely contains risk-management requirements — it isn't just a pile of random configuration settings)_

The difference in philosophy becomes obvious once you get into the implementation guidance. The official 2023 ISMS-P guide, for example, still lists hiding the SSID and MAC-address authentication among top-notch must-have wireless-network security measures — controls that [modern platform guidance explicitly treats as ineffective or even counterproductive](https://support.apple.com/en-us/102766).

It is a tiny example, but a revealing one: once a control becomes something an auditor can tick, its relationship with actual security can become surprisingly optional. 

**Prescriptive security regulation has an expiry date. Compliance infrastructure does not.**

# When Regulation Becomes Architecture

Let's imagine that instead of saying:

> Financial institutions must adequately protect users 
> against credential-stealing malware.

you say:

> Financial institutions must deploy controls against keylogging 
> on the customer's computer.

The first requirement survives changes in operating systems, browser isolation, authentication technology, hardware-backed credentials and whatever comes next. You can change the architecture of your overall solution, and still be compliant. The second requirement though _is_ the architecture. As the result:

- Somebody now has to build the anti-keylogger.
- Somebody has to certify it.
- Banks have to integrate it.
- Security teams have to test it.
- Procurement has to buy it.
- Auditors have to check it.

And you, the customer has to install it.

A small industry appears whose continued existence depends on this entire arrangement continuing to exist. And even if the regulation eventually changes, all of those other things do not magically evaporate at midnight.

Korean digital certificates are perhaps another canonical example.

## A Perfectly Sensible Certificate, Followed by Everything Else

Korea enacted its Digital Signature Act in 1999 (way, way before the rest of the world), introducing what became known as the authorised — later usually translated as *accredited* — certificate system. In 2002, use of these certificates became mandatory for electronic financial transactions. The stated purpose was perfectly sensible: improve the stability and reliability of electronic commerce. So far so good.

There were only a few tiny problems.

Actually, there were several tiny problems, which over time joined together into one enormous problem wearing an Internet Explorer logo.

One of them actually predates the certificate system itself. In the late 1990s, US cryptography export controls meant that browsers shipped outside the United States did not offer the strong encryption Korea wanted for online commerce. Korea developed its own 128-bit cipher, SEED, and browser plug-ins became a practical way of deploying it. The certificate infrastructure then brought its own need for client-side cryptographic operations and access to locally stored keys.

ActiveX turned out to be extremely convenient for both.

*(If the mere mention of ActiveX made you shudder, congratulations: your security instincts are functioning normally. For everyone lucky enough not to remember it, ActiveX was Microsoft's mechanism for letting websites run native Windows components with privileges far beyond what we would now consider remotely sane for web content. Which, naturally, made it extremely useful for exactly this sort of thing. But I digress.)*

Then additional security mechanisms accumulated around the transaction:

- certificate managers;
- encryption software;
- anti-keylogging software;
- personal firewalls;
- anti-malware components;
- transaction-protection software.

This architecture worked. And because it worked, it spread (and consequently was codified in regulations - see above for why). Which brings us neatly to my attempt to use Korean Internet banking in 2026.

# Please Install Our Mandatory Spyware

Here is a sentence that, after quite a lot of research, I am comfortable writing:

**Korean banks may require you to install spyware on your computer to use their websites.**

There. I said it. Now, before somebody from a bank's legal department gets unnecessarily excited, let me define what I mean by "spyware".

I am **not** claiming that Korean banks are secretly uploading my Signal messages to a bunker underneath Seoul City Hall. I am using the term from an endpoint-security/threat-modelling perspective.

If a third party tells me that in order to use an ordinary web service I must install closed-source native software which can see deeply into my operating system, inspect processes and network configuration, intercept keyboard input and bridge security boundaries which the browser explicitly exists to enforce — then, absent an ability to independently audit and establish exactly what it does, _I treat that software as potentially hostile_.

You can call it "endpoint protection" if you like, but personally I'm going with mandatory spyware. And the capabilities involved are not hypothetical.

A [rather entertaining paper presented at USENIX Security 2025](https://www.usenix.org/conference/usenixsecurity25/presentation/yun) analysed the modern generation of what the researchers call Korea Security Applications, or KSA 2.0. These are the descendants of the old ActiveX security components — now usually native applications installed separately on the computer.

Depending on the particular product, these applications perform functions including secure keyboard input, antivirus scanning and transaction protection.

The interesting part, as always, is *how*.

Some anti-keylogging components intercept keyboard input at a level below the browser. Other components inspect processes and system state. Some gather information which can be used to fingerprint the device. They run native code outside the browser sandbox — which is, fundamentally, the entire point.

And this creates a wonderfully backwards security architecture.

A modern browser spends an extraordinary amount of engineering effort ensuring that `mybank.example.com` _cannot_ arbitrarily inspect what is happening elsewhere on my computer.

A website cannot just decide:

> Hmm, I wonder which other processes Roman has running?

It cannot normally hook the system keyboard.

It cannot casually inspect arbitrary machine configuration.

It cannot install a root certificate authority.

It cannot execute privileged native code simply because I opened a banking tab.

These are features, not bugs. The browser is a giant security boundary separating an untrusted Internet from my endpoint - which, in my opinion, is the cornerstone of people having any modicum of (perhaps, often misplaced) trust in their online experience safety.

The Korean banking solution, historically, has effectively been:

> Excellent. Please download this executable so we can go around it.

This has gone about as well as you might expect.

The USENIX researchers found **19 vulnerabilities** across the KSA ecosystem they examined. The resulting attack classes included keylogging, man-in-the-middle attacks, private-key leakage, remote code execution and device fingerprinting - you know, all the good stuff. The vulnerabilities were disclosed and subsequently patched, but that's almost beside the point.

The point actually is - _software introduced to protect users against endpoint compromise had itself become privileged endpoint attack surface_. And this stuff is everywhere.

In the researchers' survey of 400 Korean participants, 97% of users of banking services had installed KSA software. Fifty-nine percent said they did not understand what those applications actually did (personally, I'm not entirely convinced the remaining 41% could explain what it did either).

The researchers also examined 48 real PCs. Average number of KSA installations per machine?

**Nine. On average.**

Many were old versions dating from 2022 or earlier.

This is one of those statistics which makes perfect sense once you've used enough Korean websites.

* You visit Bank A: install three security programs.
* You visit Government Service B: install another.
* Brokerage C would very much like its own keyboard-protection component.

Now something called `TouchEn nxKey` lives on your machine. You have absolutely no recollection of installing it. Presumably it is protecting something.

## But Is It Actually Mandatory?

Here things get interesting again.

Historically, specific security components were much more directly connected to regulatory requirements. That regulatory environment changed.

Korea started removing technology-specific electronic-finance requirements during the mid-2010s. The privileged status of the old accredited-certificate regime was eventually abolished in 2020. ActiveX itself is essentially dead (good riddance).

And yet the security applications survived. The USENIX researchers found that users continued to experience installation as effectively mandatory when using financial services. 

_(Yours truly spent 40 minutes trying to install this malware in a VM on my MacBook Air when setting up my Woori Bank account - in the end, ~~spyware~~ security software DID get installed, but I failed miserably at the stage of transferring my certificates from point A to point B, at which point I abandoned it completely and relied exclusively on online banking ever since)_.

This is important because it means the modern problem is no longer adequately explained by saying:

> The Korean government requires banks to install this

That is too simple. The more interesting explanation is:

> The Korean government created an environment in which this architecture made sense as it allowed them to claim indemnity - to an extent - if a client breach happened. Banks, vendors, compliance teams and users then built an ecosystem around it; and removing the original requirement did not remove the ecosystem.

ActiveX eventually disappeared, but the architecture it created did not disappear with it. The regulation changed, browsers changed, and the original technical justification weakened — yet the surrounding ecosystem of vendors, integrations, compliance processes and security software remained.

That, more than any single weird technology, is the recurring story of the Korean digital Galapagos: a solution is introduced early to solve a real problem, regulation and industry standardise around it, companies build products and processes on top, and by the time the global technology stack has moved elsewhere, replacing the old architecture has become far more expensive than keeping it alive.

So twenty years later, someone looks at your shiny modern Chromium-based browser and says:

> Please download `Security_Installer_FINAL_v3.exe` to continue.

In the next instalment I want to go one layer deeper, because banking applications are only part of the story.

Behind an enormous amount of Korean digital life sits something even more consequential: a remarkably interconnected national identity system — Resident Registration Numbers, mobile phone authentication, real-name verification, certificates, CI identifiers and, increasingly, mobile digital ID. For most Koreans this infrastructure is practically invisible. It just works.

If, however, you arrive from another country (or dare to use a name which isn't spelt in Hangul, or indeed have a name longer than N characters) and attempt to bootstrap yourself into the ecosystem from zero, you become something much more useful:

**an integration test.**

And boy does it uncover some interesting bugs.