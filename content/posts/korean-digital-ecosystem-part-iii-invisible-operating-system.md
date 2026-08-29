---
title: "Welcome to the Galápagos - Korean Digital Ecosystem, Part II"
date: 2026-08-30T06:24:00+08:00
draft: true
tags: 
  - Tech
  - Korea
---

# The Invisible Korean Operating System — Korean Digital Ecosystem, Part II.2

At the end of the previous instalment I called foreigners an **integration test** for the Korean digital ecosystem. I wasn't entirely joking.

Any sufficiently mature system accumulates assumptions. Some are documented, some are buried deep in implementation, and some are so fundamental that nobody involved even thinks of them as assumptions anymore — they are simply how the world works. Then somebody turns up with a 25-character surname, or a name which appears in two government databases in a slightly different order, or a perfectly valid Korean residence card but no mobile phone subscription in their own name, and suddenly all sorts of interesting things start falling over.

This isn't particularly Korean, obviously. Anyone who ever attempted to put a Portuguese name into an American form which insists that a human being consists of `First Name`, `Middle Initial` and `Last Name` will recognise the genre (at this point I _must_ refer you to an excellent seminal paper [Falsehoods Programmers Believe About Names](https://www.kalzumeus.com/2010/06/17/falsehoods-programmers-believe-about-names/) - go and read it instead if you haven't already).

What *is* particularly Korean though is just how much of the country's digital ecosystem eventually came to depend on a remarkably coherent underlying identity infrastructure. Once you have been in Korea for a while, you barely notice it: your bank knows who you are, your mobile operator knows who you are, websites can verify who you are, government services know who you are, and all of these things generally agree with each other, and you can generally pass RNV (more below) in your sleep. This is fantastically convenient when it works.

To understand what happens when it doesn't, however, we need to go back considerably further than the Internet.

# Everyone Gets A Number

Korea had already operated a resident-registration system since the early 1960s, but after the January 21, 1968 Blue House raid — when a group of North Korean commandos infiltrated Seoul in an attempt to assassinate President Park Chung-hee — the government [strengthened it into the modern national identification system](https://theme.archives.go.kr/next/koreaOfRecord/identityCard.do). The new system included identity cards and a unique Resident Registration Number intended to make it substantially easier to distinguish legitimate residents from infiltrators.

So we already have a pattern which should be familiar from the previous instalment: something gets introduced in response to an entirely real security problem, works well enough, and eventually becomes infrastructure.

The Resident Registration Number — usually abbreviated **RRN** — was exceptionally useful infrastructure.

A unique identifier solves a boring but surprisingly difficult problem: how do you know that the person standing in Bank A is the same person whose tax record sits in Government Database B and whose telephone subscription is being created by Telecom Operator C? Names are terrible identifiers — they are duplicated, transliterated, changed, misspelt and generally behave nothing like database engineers would like names to behave (besides, [20% of the country proudly shares the last name of Kim, and another 15% are Lee](https://www.koreatimes.co.kr/southkorea/20160917/kim-lee-park-remain-three-most-common-surnames?utm_source=chatgpt.com) - this almost certainly has something to do with it). A permanent unique number is indeed much easier.

Naturally, once you have one, everybody wants it.

Banks used RRNs. Telecom operators used them. Government agencies used them. Employers used them. And once the Korean Internet appeared, websites discovered that the country had already solved their identity problem for them too.

By the early 2000s, handing over your RRN when registering for a Korean website had become entirely routine. A 2003 National Human Rights Commission survey found that the [vast majority of Korean websites required users to provide an RRN when registering](https://www.humanrights.go.kr/eng/board/read?boardManagementNo=7003&boardNo=7000397), while 75% of the surveyed users identified the RRN as the personal information they were most reluctant to provide online.

From a product point of view this was extremely convenient. Want to stop one person creating fifty accounts? RRN. Need age verification? RRN. Want to associate an online account with an actual human being? RRN. Want to stop spam? Well, you catch the drift. 

From a privacy point of view, putting the same immutable identifier into thousands of unrelated databases is... less obviously brilliant.

The particularly unpleasant property of a persistent identifier is that it is, well, persistent. If ten databases contain the same value, joining records across those databases becomes easy. If the number leaks, you cannot solve the problem by clicking “Change password”. Until relatively recently, changing an RRN was extraordinarily difficult even after a serious leak; Korea only [introduced a formal mechanism allowing people to change compromised RRNs in 2017](https://www.mois.go.kr/frt/bbs/type010/commonSelectBoardArticle.do?bbsId=BBSMSTR_000000000008&nttId=58509), almost half a century after the numbering system was introduced.

And Korea had some *very* large personal-data leaks. Ahem. More on those later.

For now, what matters is that Korea had created something quite powerful: a near-universal identity key which existed long before mass-market online services arrived. Once those services did arrive, building on top of it was the obvious thing to do.

# The Internet Would Like To See Your Papers

Korea then went one step further.

It did not merely have a national identity number which companies happened to use. For a period, Korean Internet regulation explicitly required large online services to verify the real-world identity behind users posting content (how would you like an idea of verifying your name and papers before posting a Reddit comment?).

The so-called Internet real-name system went through several iterations, but by the late 2000s large websites could be required to perform identity verification before allowing a user to post on an Internet bulletin board. The regime was eventually expanded to [sites receiving at least 100,000 users per day](https://www.ccourt.go.kr/site/kor/ex/bbs/View.do?bcIdx=941619&cbIdx=1106). The purpose was primarily to deal with defamation, harassment and other abusive behaviour online — again, not an imaginary problem.

This produced one of my favourite collisions between the global Internet and Korean regulation.

In 2009, Google decided that it did not want to introduce Korea's identity-verification requirement on YouTube. Instead, it disabled uploading and commenting for users of the Korean-localised version of the service. Watching videos continued to work; uploading them did not. Of course, users quickly discovered that changing the country setting was sufficient to get around the restriction, which rather neatly illustrated some of the practical limitations of regulating identity on a globally distributed website. The episode later became part of the [legal history of the Korean real-name system](https://law.go.kr/detcInfoP.do?detcSeq=18462).

Google, as it turned out, picked the winning side of that argument. Three years later, Korea’s Constitutional Court struck the identity-verification requirement down as unconstitutional, and disproportionatelly restricting free speech, and YouTube promptly restored uploading and commenting to its Korean service. Very neat.

And that could have been the end of the Korean real-identity story. Except, of course, it wasn't.

As we saw with [ActiveX in the previous post](http://localhost:1313/posts/korean-digital-ecosystem-part-ii-welcome-to-galapagos/), abolishing a regulatory requirement and removing an infrastructure are two rather different operations.

By this point Korea already had banks, telecom companies, identity-verification providers, websites and government systems which had spent years becoming exceptionally good at answering one question:

> **Is this online person actually Roman Kirillov?**

There remained plenty of perfectly legitimate reasons to ask that question even after anonymous Internet comments stopped requiring an answer. Banks need to know their customers. Certain products require age verification. An account-recovery system may want considerably stronger evidence than access to an email inbox. Government services quite reasonably need to know whether the person submitting a tax form is actually the taxpayer concerned.

So Korea did not get rid of online identity verification. It got rid of the idea that every random website should do it by collecting your Resident Registration Number.

Which is quite a different thing.

# We Got Rid of the Resident Number. Mostly.

The modern Korean system is, from a security-engineering perspective, considerably more interesting than simply typing an RRN into a website.

KISA — the Korea Internet & Security Agency — now describes several recognised methods for [performing online identity verification without the service itself receiving the user's raw RRN](https://identity.kisa.or.kr/). These include mobile-phone verification, i-PIN, credit-card verification and certificates.

Conceptually, this makes a great deal of sense.

Instead of every website becoming an identity provider — and, more importantly, another database containing millions of RRNs — the website delegates the job to somebody who already has a trusted relationship with the user. The identity provider verifies the person and tells the website, in effect, *yes, this is the human you think it is*.

This is hardly unique to Korea. Federated identity is a perfectly normal idea.

What makes the Korean version particularly interesting is who some of the most important identity providers turned out to be: mobile phone operators.

If you've spent any amount of time dealing with Korean websites, you have almost certainly seen the standard phone-verification flow: enter your name, date of birth, mobile operator and number, perhaps specify whether you are a Korean or foreign national, and then approve the request through SMS or the PASS app.

On the surface, this looks very similar to SMS authentication anywhere else.

There is an important difference.

Normally, when a website sends me an SMS code, the thing being proven is essentially:

> Whoever is sitting here currently controls +82-10-XXXX-XXXX.

Korean mobile identity verification can prove something stronger:

> +82-10-XXXX-XXXX is a subscription registered to **this particular legal person**, and the person authenticating matches that identity.

KISA's own documentation makes this fairly explicit: the mobile-verification flow assumes a [mobile phone subscription registered in the user's own name](https://identity.kisa.or.kr/web/main/bbs/edu_user/49), with the carrier participating in verification of the subscriber's identity.

This is actually a very useful primitive.

Age verification becomes straightforward. Fake-account creation becomes more expensive. Account recovery gets a strong additional signal. Financial services and government websites can rely on an identity relationship which already exists rather than individually trying to establish who you are.

From the perspective of a Korean citizen with a normal Korean mobile subscription, the whole thing is almost invisible. You type a few details, press the PASS button, quick fingerprint, and you're done.

The interesting design decision is that over time _having a mobile subscription in your own name became one of the standard ways of possessing a usable online identity_.

The distinction sounds academic until you encounter someone who has an entirely legitimate identity but does not have a mobile subscription represented in exactly the way the verification system expects.

We will get to that. First, however, we need to introduce one more piece of the plumbing.

# Meet CI, The Number You Didn't Know You Had

Removing RRNs from individual websites creates another problem.

Suppose Coupang verifies me today using my mobile phone. Tomorrow I use some other identity-verification mechanism. Perhaps another service owned by the same company also needs to know whether I am the same person. The raw RRN is no longer supposed to be passed around, which is good — but the system still needs some stable way of saying *yes, that's Roman again*.

Korea's answer is something called **CI**, or Connecting Information — 연계정보.

KISA defines CI as a derived identifier produced during identity verification which allows participating services to [link the same person across systems without passing the raw RRN around](https://identity.kisa.or.kr/web/main/contents/M010-05).

There is a related identifier called **DI**, or Duplication Information. DI solves a narrower problem: it lets a service determine whether the same person has already registered while incorporating a service-specific identifier, so [different sites need not receive the same value](https://identity.kisa.or.kr/web/main/contents/M010-05).

From an engineering perspective, there is quite a lot to like here. The raw national identifier no longer needs to be sprayed across the Internet; a service that merely wants to prevent duplicate registrations can receive a service-specific pseudonymous identifier; and services with a legitimate reason to connect identities can use CI.

But step back for a moment and look at what this means architecturally.

Underneath a large part of Korean digital life now sits a fairly coherent identity graph:

**government identity → telecom subscription / identity provider → CI or DI → online service**

Banks and other regulated industries attach their own identity relationships to the same person. Government services do likewise. Your mobile subscription is not simply a communications service; it participates in identity. Your identity-verification transaction is not simply authentication; it can produce stable identifiers which allow services to recognise you over time.

That is what I mean by the **invisible Korean operating system**.

There isn't literally one gigantic government database sitting underneath Kakao, Naver, Coupang and every Korean bank. The reality is much more decentralised and considerably less sinister than that.

But there *is* a common set of assumptions, identifiers and verification mechanisms which acts rather like a platform API. If you fit the expected model, everybody can talk to everybody else and the plumbing disappears.

Which is normally the sign of good infrastructure.

Until you don't fit the model.

# And Then A Foreigner Walks Into The API

This is where foreigners become useful.

Not because Korean systems have some uniquely pathological dislike of foreign users, but because foreigners are much more likely to violate assumptions which are invisible for the majority population.

A Korean citizen will normally have a Resident Registration Number. A foreign resident historically had a different registration number. Names which are utterly mundane in Russian, English, Spanish or Arabic may be surprisingly long by Korean database standards, may contain spaces, or may be represented in different orders by immigration, banks and telecom operators. A mobile subscription may not be registered using precisely the same representation of the name as the residence record.

None of these things makes the person difficult to identify in any meaningful real-world sense. They may be standing there holding a government-issued residence card and a passport.

But computers are famously unimpressed by this sort of argument.

And this is not simply folklore from foreigner Facebook groups. Korea's National Human Rights Commission was [documenting failures of online identity verification for foreigners](https://www.humanrights.go.kr/eng/board/read?boardManagementNo=7003&boardNo=7001092) more than fifteen years ago, including cases where systems built around Korean resident-registration data did not offer an equivalent verification path for people holding foreign registration documents.

This is why I think *integration test* is the right mental model.

The problem was rarely that Korea had no idea who the foreign resident was. Immigration knew who they were perfectly well. They had identity documents. They had an entry in a government database.

The problem was that **the path between “this person has a valid identity” and “this website can verify that identity” contained assumptions about how Korean identities normally look and how they normally propagate through the ecosystem**.

Put differently, the question isn't always:

> Can you prove who you are?

It is sometimes:

> Can you prove who you are through one of the identity paths this service knows how to consume?

That is a much more interesting problem.

And, importantly, Korea has been changing this too.

In **January 2025**, the Ministry of Justice [began issuing mobile residence cards to registered foreign residents](https://www.immigration.go.kr/bbs/immigration/220/591020/artclView.do), giving the mobile credential the same legal validity as the physical residence card and explicitly presenting it as part of an effort to reduce the digital gap experienced by foreigners.

This is exactly the sort of direction you would hope the system would move in: a proper government-backed digital credential, rather than every private service inventing yet another way of proving that the person holding a foreign residence card is, in fact, the person named on the foreign residence card.

There is, however, a small detail which I find almost too perfect.

To obtain the mobile residence card, the user needs a smartphone **registered in their own name**.

In other words, Korea has built a shiny modern mobile identity credential partly intended to make life easier for people who historically struggled with the existing identity ecosystem — and one of the prerequisites for entering it is already being correctly represented inside the Korean mobile identity ecosystem.

This isn't as ridiculous as it sounds. There are good security reasons to bind a high-value digital identity credential to an identified subscriber and device.

But it illustrates rather beautifully how technological transitions actually happen.

The new system does not replace the old one overnight. It lands on top of it.

The mobile credential is new.

The dependency graph underneath it is considerably older.