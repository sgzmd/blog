---
title: "kbsw - multi-language keyboard switcher"
date: 2026-05-28T19:25:51+09:00
draft: false
---

In 2026, we made a Really Seriously Big Decision to relocate to Seoul, South Korea (let's see how it goes, but it will be for a couple of years at least). Naturally, having moved to a different country, we resolved to learn the local language (boy, is it hard!) — so being able to type in it is essential. 

Also, for those who know me, it's hardly a secret that we are bilingual: we speak Russian at home and English just about everywhere else.

And herein lies the problem. If you have ever tried to type in two languages on any modern operating system, you will know that the layout switcher is just a toggle. It works beautifully when there are only two languages, but completely falls apart when you add a third (heaven forbid you ever need more). Tired of messing around with the Mac keyboard switcher, I realized the model I *really* want is a single-key switcher: you assign a specific key to each language and just press it. That is how the idea for `kbsw` was born.

It's a tiny Swift app that sits in your menu bar with no UI, configured via a `yaml` file, and reacts to the F-keys on your keyboard. This is what the config looks like:

```yaml
# kbsw configuration
# Map F-keys to macOS input source IDs.
# Run `kbsw --list` or see keyboard-layouts.txt for available IDs.
shortcuts:
  F1: com.apple.keylayout.ABC
  F2: com.apple.keylayout.RussianWin
  F3: com.apple.inputmethod.Korean.2SetKorean
```

Really, this is all there is. It's on my github, go [check it out](https://github.com/sgzmd/kbsw).
