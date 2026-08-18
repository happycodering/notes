#import "components.typ": *
#set document(title: [Algebra])
#let base-size = 11pt
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
  "a4",
  // margin: (
  //   top: 1.75cm,
  //   bottom: 1cm,
  //   left: 1cm,
  //   right: 1cm,
  // ),
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
              #text(size: 11pt * 0.8)[
                #header-content
              ]
            ],

            align(right)[
              #text(size: 11pt * 0.8)[
                #current-page
              ]
            ],
          )
        }
      }
    }
  },
)

// #set page(
//   "a4",
//   margin: (top: 1.75cm, bottom: 1cm, left: 1cm, right: 1cm),
//   header: context {
//     let current-page = here().page()

//     let chapters = query(selector(heading.where(level: 1)))

//     // Find the first chapter.
//     let first-chapter = chapters.first()

//     if first-chapter != none {
//       let first-chapter-page = first-chapter.location().page()

//       if current-page >= first-chapter-page {
//         // Find the current chapter.
//         let chapter = none

//         for ch in chapters {
//           if ch.location().page() <= current-page {
//             chapter = ch
//           }
//         }

//         if chapter != none {
//           grid(
//             columns: (1fr, auto),
//             stroke: (bottom: 1pt),
//             inset: (bottom: 10pt),

//             align(left)[
//               #text(size: base-size * 0.8)[
//                 #let n = counter(heading).at(chapter.location())
//                 Chapter #numbering(chapter.numbering, ..n) #chapter.body
//               ]
//             ],

//             align(right)[
//               #text(size: base-size * 0.8)[
//                 #current-page
//               ]
//             ],
//           )
//         }
//       }
//     }
//   },
// )

#set par(
  justify: true,
  // leading: 1em,
)

#set heading(numbering: "1.")

#show heading: set text(fill: navy)

#show heading.where(level: 1): it => {
  v(3em)
  it
  v(1em)
}

#show heading.where(level: 2): it => {
  v(1em)
  align(center, it)
  v(1em)
}

#show heading.where(level: 3): it => {
  v(1em)
  it
  v(1em)
}

#show heading.where(level: 4): it => {
  v(1em)
  it
  v(1em)
}

#show heading.where(level: 5): it => {
  v(1em)
  it
  v(1em)
}

#show heading.where(level: 6): it => {
  v(1em)
  it
  v(1em)
}

#show title: it => {
  align(
    center,
    block(
      inset: (top: 7cm),
      text(size: 80pt, it),
    ),
  )
}

// #set heading(numbering: (..nums) => {
//   let level = nums.pos().len()
//   if level >= 3 {
//     none
//   } else {
//     numbering("1.1", ..nums)
//   }
// })

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

///////////////////////////////////////////////////////////////////////////////

#page(
  margin: (x: 0cm, y: 0cm),
)[
  #image("prealgebra-cover.pdf")
]

#page(
  title(),
)

#page()[
  #align(center)[
    #text(size: 15.4pt, weight: "bold", fill: navy)[Contents]
  ]
  #outline(title: none)
]

#include "chapters/chapter1.typ"
