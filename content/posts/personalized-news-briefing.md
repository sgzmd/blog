---
title: "RSS, Embeddings, and Coffee: My Personal News Briefing Setup"
date: 2025-10-23T20:06:39+01:00
draft: false
---

Some of us like to read news. Then again, some of us have to read news for work – specifically, to stay in the loop of what's going on in the industry. For some industries – like cybersecurity – this means sifting through a goddamn ton of news websites and discarding 99% of what you've read. Such is my life.

RSS comes to the rescue – somewhat. A carefully curated collection of RSS feeds means you spend less time jumping between websites and more time actually reading what matters – but there's still plenty of noise.

Now, some RSS readers have a bit of smartness built in – like Inoreader. It's great, honestly. As a pure RSS reader, it's like Google Reader (do you still remember that?) on steroids. But still, its smartness is fairly limited and mostly keyword-based. And honestly, nobody’s got time for keyword matching these days.

What I really wanted was simple:

1. Get all the news from my feeds over the last 24 hours  
2. Filter out everything that’s irrelevant to me  
3. Sort what’s left by relevance  
4. Generate quick summaries using the ["What? So What? Now What?" model](https://reflection.ed.ac.uk/reflectors-toolkit/reflecting-on-experience/what-so-what-now-what)

Finally, send it all to Roman so he can read it over his first coffee and at least know what kind of day it’s going to be.

Easy, right? Not quite. That exact thing didn’t exist – so I decided to make it exist.

Coders and crackers, without further ado, meet the most lamely named project ever: [**RSS Morning**](https://github.com/sgzmd/rss-morning)! Yeah, I know, the name is terrible. I suck at naming things and I’m not even trying to hide it. But this thing, in essence, does exactly what I wanted.  

It starts with a collection of feeds in OPML format, pulls articles, runs them through Readability, then through embeddings, using cosine similarity to score them against pre-computed embeddings of the queries I actually care about. Everything below a threshold (experimentally defined at 0.5) gets tossed out. The rest goes to Gemini Flash Lite for summarization.

And then I get a neat little collection of snippets like this:

![RSS morning snippet](/static/rss-morning.png)

Cool, right? It doesn’t replace my RSS reader *per se* – that still gives me breadth and new ideas I hadn’t considered – but it does ensure I don’t miss the stuff I absolutely *shouldn’t*. And it does that in a nice, keyword-less (or rather, keywords-on-steroids in n-dimensional embedding space) way.

Happy briefing!