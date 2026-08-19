#let base-size = 11pt
#let template(body) = {
  set page(
    "a4",
    header: context {
      let current-page = here().page()

      let chapters = query(selector(heading.where(level: 1)))
      let sections = query(selector(heading.where(level: 2)))

      let first-chapter = chapters.first()

      if first-chapter != none {
        let first-chapter-page = first-chapter.location().page()

        if current-page >= first-chapter-page {
          // Find the current chapter.
          let chapter = none

          for ch in chapters {
            if ch.location().page() <= current-page {
              chapter = ch
            }
          }

          if chapter != none {
            let chapter-page = chapter.location().page()

            // Find the current section.
            let section = none

            for sec in sections {
              if (
                sec.location().page() <= current-page and sec.location().page() >= chapter-page
              ) {
                section = sec
              }
            }

            // Alternate relative to the chapter's first page.
            let show-section = (
              section != none and current-page > chapter-page and calc.rem(current-page - chapter-page, 2) == 1
            )

            let header-content = if show-section {
              let n = counter(heading).at(section.location())
              numbering(section.numbering, ..n)
              [ ]
              section.body
            } else {
              let n = counter(heading).at(chapter.location())
              [Chapter ]
              numbering(chapter.numbering, ..n)
              [ ]
              chapter.body
            }

            grid(
              columns: (1fr, auto),
              // stroke: (bottom: 1pt),
              // inset: (bottom: 10pt),

              align(left)[
                #text(size: 0.9em, fill: luma(30%))[
                  #header-content
                ]
              ],

              align(right)[
                #text(size: 0.9em, fill: luma(30))[
                  #current-page
                ]
              ],
            )
          }
        }
      }
    },
  )

  set text(
    font: ("Noto Sans", "Noto Color Emoji"),
    size: 11pt,
    hyphenate: false,
  )

  show math.equation: set text(font: "Noto Sans Math")

  show raw: set text(font: "Noto Sans Mono")

  show raw.where(block: true): block.with(
    fill: luma(90%),
    inset: 8pt,
    stroke: 0.5pt + luma(80%),
    radius: 3pt,
  )

  set par(
    justify: true,
  )

  set figure(placement: none)

  show figure: it => {
    show image: box.with(
      inset: 5pt,
      stroke: 1pt + luma(70%),
      radius: 5pt,
    )
    it
  }

  set heading(numbering: "1.")

  show heading: it => block({
    if it.numbering != none {
      let nums = counter(heading).at(it.location())

      let fmt = numbering("1.1", ..nums)

      box(width: 0pt, align(right, box(width: 0em, {
        text(size: 1em, fill: blue)[#fmt]
        h(0.5em)
      })))
    }

    it.body
  })

  show heading: set text(fill: navy)

  show heading.where(level: 1): it => {
    let chapters = query(heading.where(level: 1))
    if chapters.first().location() != it.location() {
      pagebreak()
    }
    // pagebreak()
    v(1em)
    it
    v(1em)
  }

  show heading.where(level: 2): it => {
    v(1em)
    it
    v(1em)
  }

  show heading.where(level: 3): it => {
    v(1em)
    it
    v(1em)
  }

  show heading.where(level: 4): it => {
    v(1em)
    it
    v(1em)
  }

  show heading.where(level: 5): it => {
    v(1em)
    it
    v(1em)
  }

  show heading.where(level: 6): it => {
    v(1em)
    it
    v(1em)
  }

  show title: it => {
    align(
      center,
      block(
        inset: (top: 7cm),
        text(size: 70pt, it),
      ),
    )
  }
  body
}

#let chapter-outline() = context {
  let candidates = heading.where(level: 2)
  let parents = heading.where(level: 1)

  outline(
    title: none,
    target: candidates.after(here()).before(parents.after(here())),
    indent: 0pt,
    depth: 2,
  )
}

#let note(title: none, body) = block(
  fill: yellow.lighten(80%),
  stroke: (
    left: 3pt + yellow.darken(30%),
  ),
  inset: 10pt,
  breakable: true,
  width: 100%,
  radius: 3pt,
)[
  #if title == none {
    body
  } else {
    stack(
      spacing: 1em,
      text(weight: "bold", fill: yellow.darken(70%))[#title],
      body,
    )
  }
]

#let example(body) = block(
  fill: purple.lighten(90%),
  stroke: (
    left: 3pt + purple.darken(30%),
  ),
  inset: 10pt,
  breakable: true,
  width: 100%,
  radius: 3pt,
)[
  #box()[
    #text(weight: "bold", fill: purple.darken(50%))[Example]
  ]
  #h(6pt)
  #body
  // #align(right)[#sym.qed]
]
