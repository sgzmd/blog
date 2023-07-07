---
title: "Far Manager for Linux and MacOS"
date: 2023-07-07T18:55:23+01:00
draft: false
---

Do you remember 2003? I do, and quite vividly at that. I was in my early 20s,
studying at uni, working my first "real" software engineering jobs, and using
Windows - hey, mostly everyone used Windows those days! Actually, I'm so old
that I used DOS - starting from version 5.0, and I remember how thrilled I was
when I got my hands on Windows 3.1.

But I digress. Where DOS was concerned, Norton Commander was an absolute must -
and so were its numerous
clones. It was an unquestionable requirement on any computer, no exceptions.

![Norton Commander](/static/far/nc.png)

Using Norton on Windows, however, was a peculiar experience. It wasn't
originally designed for that purpose - for instance, it would truncate long file
names to the classic *8.3* format, and to be honest, it was somewhat
cumbersome to use. Fortunately, after a few years, a whole host of clones
emerged.

Yet, one of them left a lasting impression on me - [Far
Manager](https://www.farmanager.com/). A gift from [Eugene
Roshal](https://en.wikipedia.org/wiki/Eugene_Roshal) to the world (the same
individual behind RAR) it was and still remains a de-facto standard two-panel manager
for Windows. It's fast, it's powerful, it's extensible, and it's free.

![Far Manager on Windows](/static/far/far_win.png)

I used it for years, employing it everywhere I could. I practically lived in it.
Even Total Commander, a darling among power users on Windows, couldn't persuade
me to switch.

However, approximately 15 years ago, I made the switch to Mac as my primary home
computer. Soon after, I joined Google, where I exclusively used either Mac or
Linux - a pattern that persisted for a considerable amount of time. I did suffer
without two-panel file manager, but kinda got used to the console and Finder - after all, 
`ls -lh` and `less` were doing it most of the time. 

Recently, while working on a personal machine learning project on my Linux home
computer, I found myself needing to quickly sift through numerous small files,
locating them within a vast directory tree, and making minor edits here and
there. I sorely missed the versatility that Far Manager provided. I attempted to
use Midnight Commander, but it simply didn't compare. It emulated Norton
Commander quite closely, which was a problem because the world had moved on, and
Norton Commander was a product of its time. 

And then I discovered [Far Manager for Linux and
MacOS](https://github.com/elfmz/far2l) or simply `far2l`. It's a port of Far
Manager, complete with some of the most important plugins (oh *how* I missed thou,
Colorer!). And it works - I tried it on Mac, and I tried it on Linux, and it
works mostly identically. It is not _really_ a console app - in fact, they are
using WxWidgets to emulate the "old" Far look and feel - but for purists (or, I
don't know, those SSH-ing into machine, `far2l --tty` brings forth a version which
to my untrained eye looks nearly identical, but works in the proper console). 
It just does everything Far used to - obviously, modulo
some Windows-specific functionality (such as, `Alt-F1/F2` won't show you a list
of physical disks - but rather a list of mounted file systems).

![Far Manager on Linux](/static/far/far_alt_f2.png)

Far2L is marked as Beta, and prospective users are cautioned that their homes
may catch fire, their dogs might flee, and their spouses may depart - but ~~none of that has befallen me~~ it's been working just fine for me for the
last couqle of months, and getting better with every new build. I suppose it's
not mere nostalgia if it really *does* work, don't you think? 