# Blog contributor guide

This repository contains the source for Roman's Hugo blog. This guide is for
both human contributors and coding agents: it explains where things live, how
posts are formatted, and how to check changes before publishing.

## Repository structure

- `config.yaml` contains the site title, public URL, menus, taxonomies, output
  formats, and Hugo Markdown settings.
- `content/posts/` contains published and draft blog posts as Markdown files.
- `content/static/` contains article images and other files that are served from
  `/static/`. Keep related images together in a descriptive subdirectory.
- `assets/scss/styles.scss` is the active site stylesheet. It defines the colour
  tokens, typography, article layout, responsive rules, and editorial components.
- `layouts/` contains the active Hugo templates and overrides. Files here take
  precedence over equivalent files in the bundled theme.
- `layouts/shortcodes/` contains reusable Markdown components such as annotated
  images, side notes, and phrase-level emphasis.
- `archetypes/default.md` is the front-matter template used for new content.
- `themes/hacked-maverick/` is the bundled base theme. Prefer making local
  overrides in `layouts/` and `assets/` instead of editing this directory.
- `public/` and Hugo resource caches are generated output, not authoring sources.

## Creating and previewing posts

Create posts under `content/posts/`. A typical front matter block is:

```yaml
---
title: "A concise article title"
subtitle: "An optional sentence describing this article's particular angle."
series: "Optional Series Name"
part: "Part II"
date: 2026-08-30T09:00:00+09:00
draft: true
tags:
  - Tech
  - Korea
---
```

`title` should be the concise visible headline. `series`, `part`, and `subtitle`
are optional. When present, the series and part appear above the title, while the
subtitle appears below it. The browser title combines the article title with its
series and part. Existing posts need none of these optional fields.

Run `hugo server` from the repository root for a local preview. Run `hugo` before
finishing a change to confirm that the full site builds successfully.

## Markdown and editorial formatting

- The front-matter title supplies the page's only level-one heading. Start major
  sections in the body with `##`, then use `###` for subsections. Do not add a
  second `#` heading inside a post.
- Separate paragraphs and list blocks with blank lines. Prefer ordinary Markdown
  over raw HTML unless a component genuinely requires HTML.
- Use `**bold**` for normal emphasis and `_italics_` for titles, asides, or a
  change of voice. Do not use bold as a substitute for headings.
- Use descriptive link text instead of pasted URLs or vague wording such as
  "click here".
- Write descriptive image alt text. A normal image uses
  `![Description](/static/path/image.jpg)`.
- Keep the author's conversational voice. The site locale is British English, so
  prefer spellings such as "organisation" and "instalment" unless quoting a
  source or using an established proper name.
- Avoid manual line breaks for visual layout. The theme controls wrapping and
  spacing responsively.

### Picture captions

Use `captioned-image` when a photograph or screenshot needs a caption, source,
or licence note. Caption content supports ordinary Markdown:

```md
{{< captioned-image
  src="/static/korea/example.jpg"
  alt="A descriptive alternative text for the image"
>}}
Caption text. [Source: Example](https://example.com), licensed under CC BY 2.0.
{{< /captioned-image >}}
```

Do not add a separate italic paragraph below an image to imitate a caption.
Keep attribution and licence links inside the shortcode.

### Annotated images

Use an annotated image when numbered callouts materially help explain details in
an image:

```md
{{< annotated-image
  src="/static/korea/example.webp"
  alt="Description of the complete diagram"
  caption="What the diagram shows."
  pins="18,28;50,51;82,72"
>}}
1. **First point** explains the first pin.
2. **Second point** explains the second pin.
3. **Third point** explains the third pin.
{{< /annotated-image >}}
```

Each pin is an `x,y` percentage measured from the image's top-left corner. Pins
are separated by semicolons and must appear in the same order as the numbered
notes. Figures are numbered automatically within each article.

### Side notes

Place a side note immediately before the paragraph it accompanies:

```md
{{% sidenote title="Historical context" %}}
The note may contain ordinary Markdown, including links and emphasis.
{{% /sidenote %}}

The related paragraph begins here.
```

The title is optional and defaults to "Side note". Notes appear in the margin on
wide screens and as inset blocks on narrower screens.

### Important phrases

Use the `mark` shortcode inline and sparingly for a phrase that deserves stronger
editorial emphasis:

```md
The key point is that {{< mark >}}these were often sensible solutions{{< /mark >}} at the time.
```

An inline mark receives a compact underline. When the shortcode is placed on its
own line between paragraphs, it becomes a key-statement block with a rust side
rule and normal paragraph spacing. Do not mark whole sections or several phrases
in quick succession.

## Theme and code changes

- Preserve the warm-paper light theme, charcoal dark theme, serif body type, and
  rust accent unless a task explicitly changes the design direction.
- Use the existing CSS custom properties rather than duplicating colours or font
  stacks.
- Keep article treatments readable in both colour schemes and test responsive
  behavior at desktop and phone widths.
- Maintain semantic HTML and useful alternative text. Decorative elements should
  be hidden from assistive technology.
- Preserve unrelated working-tree changes. Posts and images may be edited while
  theme work is in progress.
- Validate template or stylesheet changes with a complete Hugo build.
