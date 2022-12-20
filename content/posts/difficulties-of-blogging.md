---
title: "Difficulties of Blogging"
date: 2022-12-20T19:26:47Z
draft: false
---

Blogging is hard. To anyone who tells you it's easy, feel free to punch them in
the liver, they are lying to you.

I mean, back in the days, when LiveJournal was a thing (or at least a better
thing that it is now anyway), blogging was easy and fun - you create a
LiveJournal page, and start posting there, making friends, and one day someone
will comment your post. Right?

Well, not so easy now.

A couple of years back I had a (truly terrible) Wordpress-based blog. I do
remember it wasn't particularly hard to install Wordpress, nor configure it. A
bunch of commands, `mysql> create database ...` - all that jazz. These days
Wordpress is an absolute behemoth, which has exactly one prescribed way of doing
things, else everything breaks. Do you have your blogpost in Google Docs and
want to copy it to Wordpress? Good luck. It ain't no Wordpress blocks, it ain't
gonna work. Markdown? Yeah, there are plugins, but .. forget about it. 

On the other hand, there's a growing recognition that blogging is not something
that inherently requires PHP, MySQL, NodeJS, Laravel, AJAX, Vue, XML-RPC and
RTFM. Actually wait, it does requires a bit of RTFM, but it gets easier.

Blog consists of pages where you offload your infinite wisdom onto your readers,
all 3 of them. Pages are, essentially, static (and if you don't want comments -
even more static). And this is where [Hugo](https://gohugo.io/) comes in. 

First of all, it's written in Go. This is already a great thing, and this alone
can be a reason to have another look. Second, it's not even a flat-file CMS:
it's not a CMS at all, it's just a static site generator. You write your words
in Markdown, you run `$ hugo` command ... and you are done.

![blogging.png](/static/blogging.png)

Really nothing more to it. You then copy files from `./public` to your hosting,
et voila - your blog has been updated. But it's not fun that way.

It's a lot more fun, however, to do things The Proper (TM), Software-Engineering
way - that is, to use Git, actions and automatic pipelines. And then use
Cloudflare Pages, which in a layman terms means that one of the biggest CDNs in
the world is hosting your blog, for you, for free. Better still, Hugo is
supported as a first-class citizen at Cloudflare, and wonderful Cloudflare folks
put together this [friendly
guide](https://developers.cloudflare.com/pages/framework-guides/deploy-a-hugo-site/)
explainig how to get things working. So, once you finish your post, it's just
...

```

$ git commit -m "Yet another blogpost"  -a
$ git push
$ logout #KTHXBYE.

```

