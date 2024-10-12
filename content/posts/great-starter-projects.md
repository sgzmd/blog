---
title: "Great Starter Projects"
date: 2024-10-12T13:07:42+01:00
draft: false
---

Those of you who've been reading me for a while already know that I've joined Meta after 14 years at Google; what's more, I've switched from a senior managerial position (basically, managing managers and sometimes managing *managers of managers*) back to the IC role. To be perfectly honest, I knew that I would enjoy it \- but I didn't know I'd enjoy it quite so much (of course, I'm slap bang in the beginning of the honeymoon period \- things may and will change, but let me enjoy it while it lasts\!). But I digress.

As I am ramping up at Meta in Integrity team, in the time blessed way I had to undertake a starter project (or as it later turned out, several starter projects). To define my own destiny, I had a number of interesting discussions with the senior engineers on the team, which I found very insightful and valuable; to that extent, I will try to summarise them for you.

# What is the goal of the start project?

Why are we doing them anyway? It's commonly accepted that when a new joiner ramps up on the team, they do a starter project \- but why? What's the point of it and what are we trying to achieve with it? While the answer is generally well understood, I feel it's worth outlining this explicitly. It is commonly accepted, that starter projects help to:

- Familiarise new joiner with the codebase \- what lives where, and interacts with what  
- Learn technologies/frameworks/tools which are being used on the team / project  
- Understand the intricacies of the engineering process (VCS flow, code review, push, release, …)

More broadly, the starter project aims to set up new engineers on a good path of continuous learning which will help them to become fully productive on the team and the project. This may take a while \- at Meta, much like at Google, it's not unexpected that for the first X months new engineers may have negative or at best break-even productivity \- i.e. they take time off other team members (situation is somewhat different for engineers who join the team from within the company, but it depends on complexity of the tech stack and how different it was from the one used on the previous team). 

Once again I'd like to emphasise that the primary goal of a starter project is not to actively teach engineers in a formal way \- although it does serve as a structured framework for learning (especially if there's a lot of domain knowledge involved), engineers are expected to take ownership of their learning journey  \- and even more so at more senior levels.  Note, that this might be different at other companies \- but at Google and Meta the role of teaching engineer anything is explicitly reserved to Bootcamp and multitude of internal training courses and codelabs \- if you want to learn something, there are all the opportunities one may need

# Typical starter projects at Google and Meta

In my days as an TL and line manager I've authored quite a few starter projects; even more of those I reviewed when managers reporting to me were onboarding new team members. Typically, when an engineer was joining the team, we were providing them with 2-3 starter projects:

First one was usually just a taster \- to get a feel of what engineering feels like at the company and the team. These were often projects like fixing a small typo in UI, writing a small unit test for some well-compartmentalised piece of code or something of a similar scale. Obviously something like this would never be even nearly enough \- but it serves a bunch of very useful purposes:

1. Explains what the engineering process looks like. How to get to the code? How to run tests? How to get your code reviewed and what happens after that?  
2. Understanding the team's workflow and expectations \- each team has subtle differences in how code review works, what are the expectations of the engineer, who are the people to ask questions and so on. This stage prepares new engineers for bigger beasts to slay\!  
3. Builds confidence and gives a sense of achievement. Joining a new company (in particular, joining a Big Tech company) is an overwhelming experience \- when in a few weeks after joining you still have a feeling that you *don't understand absolutely anything, allowing* the engineer to land a piece of code gives this wonderful feeling of “I am not completely worthless after all”. 

Interestingly enough, at Meta these first tasks are baked into the Bootcamp process \- as a part of Bootcamp, engineers must finish 3 tasks, usually of increasing level (to be honest, it might have changed at Google as well by now too). Which is why the second starter project is the real project in a sense that it involves some degree of variability of how it can be done, and oftentimes it's not immediately obvious what has to be done (depending on new joiner's seniority).

Examples of these projects could be something like:

- Add logging to module ABC, and measure metrics X, Y and Z using the DataBoo pipeline. This type of project is often popular not only because it has some sense of end-to-endness, but also because it serves actual practical purpose, and allows the investigation of multiple systems and data flows.  
- Refactor / modularize something, preferably not breaking anything in the process. This also often involves understanding what is and what isn't covered by tests, adding them and only then executing the refactoring. Needless to say, to refactor the code, one must understand reasonably well how it works right now \- which often involves talking to people and figuring out *why* it was built the way it was built.   
- Migrating a subsystem / API call from the old way of doing things (i.e. deprecated) to a new one (typically not fully ready for general usage yet). This one is often controversial and in my own ramp up I made the case against it on the grounds that understanding old ways of doing things which are no longer of use, has limited value to the new engineer.

Interestingly enough, I ended up doing migration (of a sorts) as my second starter project \- the rationale was that the old way wasn't actually deprecated, just no longer fit for the purpose; on top of that it wasn't exactly clear what and how should be migrated to the new way (which of course in the typical Big Tech fashion didn't support that functionality just yet).

Finally, the third project was often acting as a segway into the real big thing the engineer will be working on in the next few months \- usually it was a limited use case in what is a much bigger problem. The exit from the third project was sometimes framed as “you've done X \- but now we also need to do Y and Z, which are under-specified, go speak to people and figure out what needs to be done”. 

# What makes a great starter project?

Now that we've discussed at length what a starter project is, what they are used for, and what they could be let's talk a bit about what actually makes a great starter project? 

A great starter project, in my experience, revolves around three key things: practicality, scalability and engagement. 

1. **Practicality**: the project needs to have a real, tangible impact (or as my current director calls them, a no-regret project). No one enjoys working on anything that will never see the light of day \- which means the project has to walk a fine line between being approachable  (especially for a junior new starter) and yet real in a sense that it delivers some value to the users. Asking engineers to build a throw-away prototype as a starter project while appearing lucrative, in my experience never worked well.  
2. **Scalability**: by this I don't mean the traditional sense of vertical/horizontal system scaling, but rather the ability for the project to scale in complexity as the new engineer progresses. What starts as a relatively simple task (implement small feature / migrate API call) should be designed to uncover deeper, more nuanced aspects of the codebase as the engineer dives deeper.   
3. **Engagement**: perhaps most importantly, a great starter project is the one that hooks up engineers and keeps them engaged, provoking curiosity \- not just about the code, but also how things work in general, *why* they work that way, and how the domain area is organised. A project that requires collaboration \- whether through pairing with a more senior engineer, or needing to gather context from other team members \- helps the new joiner to integrate into the team socially and intellectually. 

In retrospect, the best starter projects at both Google and Meta were not just about accomplishing a set goal, but about setting the tone for an engineer's journey within the company. These projects teach you how to navigate the codebase, understand team dynamics, and most importantly, give the new joiner the confidence to tackle more complex challenges down the line. 

With all of that in mind, I can't emphasise enough the importance of **deliberate approach** to starter projects. If you are a manager, TL or a mentor for a new joiner, remember that your approach to selecting starter projects can make or break them. Good choice of starter projects will set your new joiner on a steady career path within the company and help them to thrive many years after joining. Take your time, be thoughtful, discuss it with *your* mentors \- it will all pay off in the end.

