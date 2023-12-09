---
title: "Kindle Scribe: writing directly on the page and margins for sideloaded books"
date: 2023-12-09T11:43:25Z
draft: false
---

I am one of those people who are constantly torn between their desire to take
physical notes right on the page of the book - and the desire to keep their
books pristine and unmarked. Naturally Kindle Scribe (and other e-notes) are
pretty much God-sent for me.

However, I am also one of those people who are not particularly fond of renting
books from Amazon - I'm sure you are aware, that when you buy a book from
Amazon, you do not, in fact own it - but instead just get a license to read it,
until Amazon decides to revoke it. This is why I prefer to buy my books directly
from publishers' websites as DRM-free epub - so I can actually keep them should
something happen to the said publisher.

This creates a bit of a problem, as Kindle Scribe is finely tuned to work only
with Books bought from Amazon. More to that, not every book from Kindle store
can be written upon - and even if it can, since it's a reformattable, you can
only add "sticky notes" to it rather than write directly on the page (which for
me personally just doesn't quite have the same feel to it).

As per sideloading, you have a number of options here:

* You can use [Calibre](https://calibre-ebook.com/) to convert your epub to Mobi
  / azw3 and send it to your Kindle via USB - this is the most straightforward
  and fastest way for me, given I already using Calibre for everything - but
  unfortunately, this will not allow you to add sticky notes to the book,
  neither you'll be able to write on the page.

* You can take a epub and send it to Kindle using, well, [Send to
  Kindle](htts://www.amazon.co.uk/sendtokindle) feature - rather aptly named,
  isn't it? This will convert your epub to azw3 and send it to your Kindle; this
  way you _will_ get an ability to add sticky notes to the book (unfortunately
  it will be classified as a "Document", not a "Book", but honestly I don't
  think of this as a big deal). However, you will not be able to write directly
  on the page.

* Finally, the thorniest path of all - converting ePub to PDF using Calibre, and
  sending that one to Kindle. 

Now, convert something to PDF and send to Kindle - it doesn't sound very complex
does it? Unfortunately with Amazon, it really really does.

The crux of the problem lies in the fact that Amazon wants to be smart - it
wants to make your PDF readable on your (regular) Kindle, which has a small
screen, which means it has to crop it - and it does so by default. More than
that, it does it rather smartly - it only crops the white space, leaving the
text intact. This is great for reading (although even that is arguable because
on Scribe you end up with gigantic fonts) - but it's absolutely terrible for
note taking since you have no space to write on.

It took me a little while (like half of the morning) to figure out how to get
things working just the way I want. Here's what you need to do:

0. Ensure that you have Calibre installed and you have configured Send to Kindle
   function using an email. This is a strictly optional thing but it makes
  everything much smoother. There're lots of manuals online, you know how to use
  Google (presumably I don't need to remind you to use DRM free files for that, too).

1. Configure Calibre to convert your epub to PDF. This is done in two steps.
   First you go to Preferences -> Conversion -> Common Options > Look & Feel and
   on Fonts page select minimum line hieght of 130% and line height of 5.0pt.
   You can adjust these as you see fit - I've chosen the values which are
   appealing personally for me.

2. Now go to Preferences -> Output Options -> PDF output and set the page size
   to B5. This is an ISO size somewhere between A4 and A5 - empirically it was
   proven that it works the best. On the same page ensure that you've changed
   Serif font to something that that is actually Serif (i.e. not the default
   Tahoma) - I've choosen Bookerly, which is Kindle's default font, you can
   easily download the ttf online. Make sure you choose the regular Bookerly,
   not a bold or a Display variations. Set the default font size to 18pt - and
   take it from there.

3. Now the critical step, which will prevent Amazon from cropping your PDF.
   Scroll further down and in Header template/Footer template insert the
   following snippets, respectively:

```html
<header style="margin-top: 5pt; margin-bottom: 24pt; justify-content: center;">
  <p>&#183;</p>
</header>

<footer><div style="margin-bottom: 5pt; margin-top: 24pt; justify-content: center;">
  <p>&#183;</p>
</footer>
```

Calibre suggests that you can insert page number or title - don't bother, as
everything will be cropped anyway and you'll end up with the text which sits
right on the border of the screen, which will not look good.

Right, now right-click file, select Convert Books -> Convert Individually and
choose PDF as the output format. After conversion finishes, open the book folder
(just press `O` on the keyboard when having the book selected). If you did
everything right, you'll see the page like that:

![PDF page](/static/scribe/pdf-page.png)

The little dots on the top and bottom of the page are the ones we've inserted in
header and footer - they will prevent Amazon from cropping the page. Now you can
send the book to your Kindle using Send to Kindle function - I've set up my
Kindle address in "Send to email" function of Calibre, so I can simply select
Connect/Share -> Email to `my-kindle-email@kindle.com`.

![Send to Kindle](/static/scribe/send-to-kindle.png)

alternatively just go to amazon.com/sendtokindle and take it from there (make
sure to send PDF file!).

If everything worked out well, you'll see the book on your Kindle like that:

![Page](/static/scribe/page.png)

And if Amazon-style page stickers is what you are after - well, then you won't
need to do most of it - just configure Send to Email feature to use Epub rather
than PDF, don't don any conversion and simply send it to Kindle straight away -
that'll do it.

Happy reading (and annotating)!



