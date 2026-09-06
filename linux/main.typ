#set document(title: "Linux")
#set page(
  "a4",
  margin: (x: 1.5cm, y: 1.5cm),
  numbering: "1",
)
#set text(
  font: ("lexend", "Noto Color Emoji"),
  size: 11pt,
)

#set par(
  leading: 0.8em,
  spacing: 1.3em,
)

#show raw: set text(font: "jetbrains mono", size: 11pt)

#set heading(numbering: "1.")

#show heading: set text(fill: navy)

#show heading: it => {
  block(
    breakable: false,
    inset: (top: 1em, bottom: 1em),
    it,
  )
}

#show raw.where(block: true): block.with(
  fill: luma(90%),
  inset: 5pt,
)

#show outline: set text(size: 11pt)

#align(center, upper(title()))

#set figure(placement: none)

#outline(depth: 2)

= tmux

== What tmux actually does

Think of tmux as a terminal workspace manager:

#figure(
  image("figures/tmux-model.svg"),
)

The three concepts to learn are:

#list(
  [Session → your whole workspace, e.g. geometry],
  [Window → like a terminal tab],
  [Pane → a split terminal inside a window],
)

The big advantage is that you can detach from a session and everything keeps running. This is particularly useful over SSH, but it's equally useful locally.

== Install tmux

On Ubuntu:

```bash
sudo apt install tmux
```

Check:

```bash
tmux -V
```

Then start one:

```bash
tmux
```

You'll see your normal shell, but now you're inside tmux.

== prefix key: `Ctrl-b`

tmux has a *prefix key*. By default it is `Ctrl-b`. You press it before a tmux command.
