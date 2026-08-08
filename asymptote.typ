#set document(title: [Asymptote])
#set text(
  font: ("Noto Sans", "Noto Color Emoji"),
  size: 15pt,
)
#show math.equation: set text(font: "Noto Sans Math")

#show raw: set text(
  font: "Noto Sans Mono",
)
#set page(
  paper: "a4",
  margin: (left: 1cm, right: 1cm, top: 2cm, bottom: 1cm),
)
#set par(
  justify: true,
  leading: 1em,
)
#set heading(
  numbering: "1.1",
)
#show heading.where(level: 1): it => {
  v(2cm)
  text(size: 24pt, weight: "bold")[#it]
  v(1.5cm)
}
#show raw.where(block: true): block.with(
  fill: luma(95%),
  inset: 8pt,
  stroke: 0.5pt + luma(80%),
  radius: 3pt,
)
#set figure(placement: none)

#show figure: it => {
  show image: box.with(
    inset: 5pt,
    stroke: 1pt + luma(70%),
    radius: 4pt,
  )
  it
}
#set line(length: 100%, stroke: 2pt + luma(70%))
///////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////
#page()[
  #v(8cm)
  #align(center)[
    #text(size: 40pt, weight: "bold")[
      #title()
    ]
  ]
]
#align(center)[
  #text(size: 24pt, weight: "bold")[Contents]
]
#outline(title: none)
#pagebreak()
#set page(
  header-ascent: 20pt,
  header: context {
    let current-page = here().page()
    let all-headings = query(selector(heading))

    let on-page = all-headings.filter(
      h => h.location().page() == current-page,
    )

    // Chapter heading on this page?
    let chapters-on-page = on-page.filter(h => h.level == 1)

    let chapter-on-page = if chapters-on-page.len() > 0 {
      chapters-on-page.first()
    } else {
      none
    }

    let page-number = align(right)[
      #counter(page).display()
    ]

    if chapter-on-page != none {
      // Chapter opening page.
      text(size: 12pt)[
        #page-number
      ]
    } else {
      // Find the current chapter.
      let chapters = all-headings.filter(
        h => h.level == 1 and h.location().page() <= current-page,
      )

      let chapter = if chapters.len() > 0 {
        chapters.last()
      } else {
        none
      }

      // Find sections belonging to the current chapter.
      let sections = if chapter != none {
        all-headings.filter(
          h => (
            h.level == 2 and h.location().page() >= chapter.location().page() and h.location().page() <= current-page
          ),
        )
      } else {
        ()
      }

      // Sections appearing on this page.
      let sections-on-page = sections.filter(
        h => h.location().page() == current-page,
      )

      // Prefer the last section on this page.
      let section = if sections-on-page.len() > 0 {
        sections-on-page.last()
      } else if sections.len() > 0 {
        sections.last()
      } else {
        none
      }

      let header-text = if calc.odd(counter(page).get().first()) {
        if section != none {
          section.body
        } else {
          chapter.body
        }
      } else {
        if chapter != none {
          chapter.body
        } else {
          none
        }
      }
      block(
        width: 100%,
        inset: (top: 0em, bottom: 0em),
      )[
        #text(size: 12pt)[
          #stack(
            spacing: 1em,
            grid(
              columns: (1fr, 1fr),
              align(left)[#header-text], page-number,
            ),
            line(length: 100%, stroke: 1pt + black),
          )
        ]
      ]
    }
  },
)

= Generalities
```asymptote
unitsize(2cm);

pair A, B, C, D;
A=(0,0);
B=(2,0);
C=(4,0);
D=(4,2);
draw(A--B);
draw(C--D);
```
#figure(
  image("figures/asy-1.pdf"),
)
#line()
```asymptote
size(5cm,0);
pair A, B, C, D;
A=(0,0);
B=(2,0);
C=(4,0);
D=(4,2);
draw(A--B);
draw(C--D);
```
#figure(
  image("figures/asy.2.pdf"),
)
#line()
```asymptote
size(10cm,0);
pair A, B, C, D;
A=(0,0);
B=(2,0);
C=(4,0);
D=(4,2);
draw(A--B);
draw(C--D);
```
#figure(
  image("figures/asy.3.pdf"),
)
#line()
```asymptote
size(5cm, 3cm);
pair A, B, C, D;
A=(0,0);
B=(2,0);
C=(4,0);
D=(4,2);
draw(A--B);
draw(C--D);
```
#figure(
  image("figures/asy-4.pdf"),
)
#line()
```asymptote
size(10cm,2.5cm);
pair A, B, C, D;
A=(0,0);
B=(2,0);
C=(4,0);
D=(4,2);
draw(A--B);
draw(C--D);
```
#figure(
  image("figures/asy-5.pdf")
)
#line()
