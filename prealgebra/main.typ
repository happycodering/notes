#import "components.typ": *
#set document(title: [Prealgebra])


///////////////////////////////////////////////////////////////////////////////

#show: template

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

#include "text/chapter1.typ"
