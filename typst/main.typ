#import "components.typ": *
#set document(title: [Typst])


///////////////////////////////////////////////////////////////////////////////

#show: template

#cetz.canvas(stroke: 1pt + gray, padding: 10pt, {
  import cetz.draw: *
  circle((0, 0), fill: gradient.linear(..color.map.flare), stroke: none)
  line((0, 0), (1, 0))
})

#list(
  [one],
  [two],
  [three],
  [four],
  [
    finve
  ],
)
