#import "library.typ": *
#set document(title: [Algebra])


///////////////////////////////////////////////////////////////////////////////

#show: template

#cetz.canvas(stroke: 1pt + gray, padding: 10pt, {
  import cetz.draw: *
  circle((0, 0), fill: gradient.linear(..color.map.flare), stroke: none)
  line((0, 0), (1, 0))
})


#(decimal(10 / 3) * decimal(3))

#(10 / 3 * 3)
