#import "components.typ": *
#set document(title: [Algebra])

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
  margin: (
    top: 1.75cm,
    bottom: 1cm,
    left: 1cm,
    right: 1cm,
  ),
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
            stroke: (bottom: 1pt),
            inset: (bottom: 10pt),

            align(left)[
              #text(size: base-size * 0.8)[
                #header-content
              ]
            ],

            align(right)[
              #text(size: base-size * 0.8)[
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
  #image("prealgebra-cover.pdf")
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

#page()[
  #align(center)[
    #text(size: 24pt, weight: "bold")[Contents]
  ]
  #outline(depth: 2, title: none)
]

#counter(page).update(1)

// #set page(
//   header-ascent: 20pt,
//   header: context {
//     let current-page = here().page()
//     let all-headings = query(selector(heading))

//     let on-page = all-headings.filter(
//       h => h.location().page() == current-page,
//     )

//     // Chapter heading on this page?
//     let chapters-on-page = on-page.filter(h => h.level == 1)

//     let chapter-on-page = if chapters-on-page.len() > 0 {
//       chapters-on-page.first()
//     } else {
//       none
//     }

//     let page-number = align(right)[
//       #counter(page).display()
//     ]

//     if chapter-on-page != none {
//       // Chapter opening page.
//       text(size: 12pt)[
//         #page-number
//       ]
//     } else {
//       // Find the current chapter.
//       let chapters = all-headings.filter(
//         h => h.level == 1 and h.location().page() <= current-page,
//       )

//       let chapter = if chapters.len() > 0 {
//         chapters.last()
//       } else {
//         none
//       }

//       // Find sections belonging to the current chapter.
//       let sections = if chapter != none {
//         all-headings.filter(
//           h => (
//             h.level == 2 and h.location().page() >= chapter.location().page() and h.location().page() <= current-page
//           ),
//         )
//       } else {
//         ()
//       }

//       // Sections appearing on this page.
//       let sections-on-page = sections.filter(
//         h => h.location().page() == current-page,
//       )

//       // Prefer the last section on this page.
//       let section = if sections-on-page.len() > 0 {
//         sections-on-page.last()
//       } else if sections.len() > 0 {
//         sections.last()
//       } else {
//         none
//       }

//       let header-text = if calc.odd(counter(page).get().first()) {
//         if section != none {
//           // section.body
//           let n = counter(heading).at(section.location())
//           [#numbering(section.numbering, ..n) #section.body]
//         } else {
//           // chapter.body
//           let n = counter(heading).at(chapter.location())
//           [Chapter #numbering(chapter.numbering, ..n) #chapter.body]
//         }
//       } else {
//         if chapter != none {
//           // chapter.body
//           let n = counter(heading).at(chapter.location())
//           [Chapter #numbering(chapter.numbering, ..n) #chapter.body]
//         } else {
//           none
//         }
//       }
//       text(size: 12pt)[
//         #grid(
//           columns: (auto, 1fr, auto),
//           stroke: (bottom: 1pt),
//           inset: (bottom: 7pt),
//           align(left)[#upper[#header-text]], [], page-number,
//         )
//       ]
//     }
//   },
// )

#include "chapters/chapter1.typ"
