#let base-size = 13pt
#let h1-scale = 1.6
#let h2-scale = 1.2
#let h3-scale = 1.1

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
  #align(right)[#sym.qed]
]

#let main-content(body) = {
  set page(
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
            // section.body
            let n = counter(heading).at(section.location())
            [#numbering(section.numbering, ..n) #section.body]
          } else {
            // chapter.body
            let n = counter(heading).at(chapter.location())
            [Chapter #numbering(chapter.numbering, ..n) #chapter.body]
          }
        } else {
          if chapter != none {
            // chapter.body
            let n = counter(heading).at(chapter.location())
            [Chapter #numbering(chapter.numbering, ..n) #chapter.body]
          } else {
            none
          }
        }
        text(size: 12pt)[
          #grid(
            columns: (auto, 1fr, auto),
            stroke: (bottom: 1pt),
            inset: (bottom: 7pt),
            align(left)[#upper[#header-text]], [], page-number,
          )
        ]
      }
    },
  )
  body
}
