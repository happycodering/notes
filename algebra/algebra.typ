#import "components.typ": *
#set document(title: [Algebra])

#let base-size = 15pt
#let h1-scale = 1.6
#let h2-scale = 1.2
#let h3-scale = 1.1

#set text(
  font: ("Noto Sans", "Noto Color Emoji"),
  size: base-size,
  hyphenate: false,
)

#show math.equation: set text(font: "Noto Sans Math")

#show raw: set text(
  font: "Noto Sans Mono",
)
#set page(
  paper: "a4",
  margin: (left: 1cm, right: 1cm, top: 1.75cm, bottom: 1cm),
)

#set par(
  justify: true,
  // leading: 1em,
)

#show heading.where(level: 1): it => {
  v(2cm)
  set text(size: base-size * h1-scale, fill: blue)
  set block(below: 2em)
  it
}

#show heading.where(level: 2): it => {
  set text(size: base-size * h2-scale, fill: blue)
  set block(above: 1.25em, below: 1.25em)
  it
}

#show heading.where(level: 3): it => {
  set text(size: base-size * h3-scale, fill: blue)
  set block(above: 1.25em, below: 1.25em)
  set heading(hanging-indent: 0pt)
  block(it.body)
}

#set heading(numbering: (..nums) => {
  let level = nums.pos().len()
  if level >= 3 {
    none
  } else {
    numbering("1.1", ..nums)
  }
})

#show raw.where(block: true): block.with(
  fill: luma(90%),
  inset: 8pt,
  stroke: 0.5pt + luma(80%),
  radius: 3pt,
)

#set figure(placement: none)

#show figure: it => {
  show image: box.with(
    inset: 5pt,
    stroke: 1pt + luma(70%),
    radius: 5pt,
  )
  it
}


///////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////

#page(
  margin: (x: 0cm, y: 0cm),
)[
  #image("algebra-cover.pdf")
]

#page()[
  #v(6cm)
  #align(center)[
    #text(size: 50pt, weight: "bold")[
      #title()
    ]
    #v(13cm)
    #text(size: 20pt)[
      AMIRREZA ADHAM
    ]
  ]
]

#align(center)[
  #text(size: 24pt, weight: "bold")[Contents]
]
#outline(depth: 2, title: none)
#pagebreak()

#counter(page).update(1)

#main-content()[
  #include "chapters/chapter1.typ"
]
