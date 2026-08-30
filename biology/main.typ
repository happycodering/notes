#import "components.typ": *
#set document(title: [Biology])


///////////////////////////////////////////////////////////////////////////////

#show: template

#page(
  margin: (x: 0cm, y: 0cm),
)[
  #image("biology-cover.pdf")
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
