#import "../library.typ": *

= The Whole Numbers

#chapter-outline()

== Place Value, Names for Numbers, and Tables

The *whole numbers* are $0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, dots$.

The *natural numbers* are $1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, dots$.

=== Finding the Place Value of a Digit in a Whole Number

The position of each digit in a number determines its *place value*.

#table(
  columns: 12,
  align: bottom,
  stroke: 1pt,
  rows: (auto, auto, 160pt),
  inset: 10pt,

  table.cell(
    fill: luma(95%),
    colspan: 12,
    align: center + horizon,
    [
      #set text(weight: "bold")
      Periods
    ],
  ),

  table.cell(
    fill: luma(90%),
    colspan: 3,
    align: center + horizon,
    [
      #set text(weight: "bold")
      Billions
    ],
  ),

  table.cell(
    fill: luma(80%),
    colspan: 3,
    align: center + horizon,
    [
      #set text(weight: "bold")
      Millions
    ],
  ),

  table.cell(
    fill: luma(90%),
    colspan: 3,
    align: center + horizon,
    [
      #set text(weight: "bold")
      Thousands
    ],
  ),

  table.cell(
    fill: luma(80%),
    colspan: 3,
    align: center + horizon,
    [
      #set text(weight: "bold")
      Ones
    ],
  ),

  table.cell(
    fill: luma(90%),
    inset: (bottom: 15pt),
    rotate(-90deg)[
      Hundred\u{2011}billions
    ],
  ),
  table.cell(
    fill: luma(90%),
    inset: (bottom: 15pt),
    rotate(-90deg)[
      Ten\u{2011}billions
    ],
  ),
  table.cell(
    fill: luma(90%),
    inset: (bottom: 15pt),
    rotate(-90deg)[
      #set text(weight: "bold")
      Billion
    ],
  ),

  table.cell(
    fill: luma(70%),
    inset: (bottom: 15pt),
    rotate(-90deg)[
      Hundred\u{2011}millions
    ],
  ),
  table.cell(
    fill: luma(70%),
    inset: (bottom: 15pt),
    rotate(-90deg)[
      Ten\u{2011}millions
    ],
  ),
  table.cell(
    fill: luma(70%),
    inset: (bottom: 15pt),
    rotate(-90deg)[
      #set text(weight: "bold")
      Millions
    ],
  ),

  table.cell(
    fill: luma(90%),
    inset: (bottom: 15pt),
    rotate(-90deg)[
      Hundred\u{2011}thousands
    ],
  ),
  table.cell(
    fill: luma(90%),
    inset: (bottom: 15pt),
    rotate(-90deg)[
      Ten\u{2011}thousands
    ],
  ),
  table.cell(
    fill: luma(90%),
    inset: (bottom: 15pt),
    rotate(-90deg)[
      #set text(weight: "bold")
      Thousands
    ],
  ),

  table.cell(
    fill: luma(80%),
    inset: (bottom: 15pt),
    rotate(-90deg)[
      Hundreds
    ],
  ),
  table.cell(
    fill: luma(80%),
    inset: (bottom: 15pt),
    rotate(-90deg)[
      Tens
    ],
  ),
  table.cell(
    fill: luma(80%),
    inset: (bottom: 15pt),
    rotate(-90deg)[
      #set text(weight: "bold")
      Ones
    ],
  ),
)

=== Writing a Whole Number in Words and in Standard Form

A whole number such as 1,083,664,500 is written in *standard form*. Commas
separate the digits into groups of three, starting from the right. Each group of three
digits is called a *period*.

#note(title: "Writing a Whole Number in Words")[
  To write a whole number in words, write the number in each period followed by
  the name of the period. This same procedure can be used to read a whole number.
]

#example()[
  $9,265$ is read as “nine thousand, two hundred sixty five.”

  We write $1,083,664,500$ as "one billion, eighty-three million,
  six hundred sixty-four thousand, five hundred".
]

#note(title: "Writing a Whole Number in Standard Form")[
  To write a whole number in standard form, write the number in each period,
  followed by a comma.
]

=== Writing a Whole Number in Expanded Form

The place value of a digit can be used to write a number in expanded form. The
*expanded form* of a number shows each digit of the number with its place value.

#example()[
  $5672$ is written in expanded form as
  $
    5672=#text(fill: red)[5]000+#text(fill: red)[6]00+
    #text(fill: red)[7]0+#text(fill: red)[2]
  $
]

We can visualize whole numbers by points on a line. The line below is called a
*number line*. This number line has equally spaced marks for each whole number.
The arrow to the right means that the whole numbers continue indefinitely.

#figure(
  cetz.canvas({
    import cetz.draw: *

    // Number line
    line((0, 0), (7.7, 0), mark: (end: ">", fill: black), name: "line")
    content("line.mid", anchor: "south", padding: (bottom: 20pt), [Number Line])
    // Tick marks and numbers
    for x in range(8) {
      line((x, -0.1), (x, 0.1))
      content((x, -0.25), str(x), anchor: "north")
    }

    // Title
  }),
)

=== Tables

*Tables* are often used to organize and display facts that contain numbers.

#table(
  columns: 3,
  align: (center, center, right),
  stroke: 1pt + luma(50%),
  inset: 8pt,

  table.header([*Number of notebooks*], [*Cost per notebook*], [*Total cost*]),

  [1], [\$3], [\$3],
  [2], [\$3], [\$6],
  [3], [\$3], [\$9],
  [4], [\$3], [\$12],
  [5], [\$3], [\$15],
)

== Adding and Subtracting Whole Numbers, and Perimeter

=== Adding Whole Numbers

The *sum* of two numbers is their *total*.
The numbers being added are called *addends*,
and the process of finding their sum is called *addition*.

#align(center)[
  #block(
    breakable: false,
  )[
    #table(
      columns: 5,
      align: center,
      inset: (x: 2pt, y: 0pt),
      stroke: 0pt,
      $2$, $+$, $4$, $=$, $6$,
      table.cell(inset: (y: 13pt))[#scale(y: 150%)[#text(fill: blue)[#sym.arrow.t]]],
      [],
      table.cell(inset: (y: 13pt))[#scale(y: 150%)[#text(fill: blue)[#sym.arrow.t]]],
      [],
      table.cell(inset: (y: 13pt))[#scale(y: 150%)[#text(fill: blue)[#sym.arrow.t]]],

      [#text(fill: blue)[addend]], [], [#text(fill: blue)[addend]], [], [#text(fill: blue)[sum]],
    )
  ]
]

To add whole numbers, we add the digits in the ones place, then the tens place,
then the hundreds place, and so on.

#example()[
  Line up numbers vertically so that the place values correspond. Then
  add digits in corresponding place values, starting with the ones place.

  #align(center)[
    #block(breakable: false)[
      #table(
        columns: 5,
        align: center,
        stroke: none,
        table.hline(stroke: 0.5pt, start: 0, y: 2),
        [], [$2$], [$2$], [$3$], [$6$],
        [$+$], [], [$1$], [$6$], [$0$],
        [], [$1$], [$3$], [$9$], [$6$],
      )
    ]
  ]
]


When the sum of digits in corresponding place values is more than 9, *carrying* is
necessary.

#example()[
  To add $365$ + $89$, add the ones-place digits first.

  #block(breakable: false)[
    #table(
      columns: 5,
      align: left,
      stroke: none,
      table.hline(stroke: 0.5pt, start: 0, end: 4, y: 3),
      [], [], [#text(fill: blue)[$1$]], [], [],
      [], [$3$], [$6$], [$5$], [],
      [$+$], [], [$8$], [$9$],
      [#text(size: 11pt * 80%)[$5$ ones $+$ $9$ ones $=$ $14$ ones or
        $1$ ten $+$ $4$ ones]],
      [], [], [], [#text(fill: blue)[$4$]],
      [#text(size: 11pt * 80%)[Write the $4$ ones in the ones place and
        carry the $1$ ten to the tens place.]],
    )
  ]

  Next, add the tens-place digits.

  #block(breakable: false)[
    #table(
      columns: 5,
      align: left,
      stroke: none,
      table.hline(stroke: 0.5pt, start: 0, end: 4, y: 3),
      [], [#text(fill: blue)[$1$]], [#text(fill: blue)[$1$]], [], [],
      [], [$3$], [$6$], [$5$], [],
      [$+$],
      [],
      [$8$],
      [$9$],
      [#text(size: 11pt * 80%)[ $1$ ten $+$ $6$ tens $+$
        $8$ tens $=$ $15$ tens or $1$ hundred $+$ $5$ tens]],
      [],
      [],
      [#text(fill: blue)[$5$]],
      [$4$],
      [#text(size: 11pt * 80%)[Write the $5$ tens in the tens place and
        carry the $1$ hundred to the hundreds place.]],
    )
  ]

  Next, add the hundreds-place digits.

  #block(breakable: false)[
    #table(
      columns: 5,
      align: left,
      stroke: none,
      table.hline(stroke: 0.5pt, start: 0, end: 4, y: 3),
      [], [#text(fill: blue)[$1$]], [#text(fill: blue)[$1$]], [], [],
      [], [$3$], [$6$], [$5$], [],
      [$+$],
      [],
      [$8$],
      [$9$],
      [#text(size: 11pt * 80%)[$1$ hundred $+$ $3$ hundreds $=$ $4$ hundreds]],
      [],
      [#text(fill: blue)[$4$]],
      [$5$],
      [$4$],
      [#text(size: 11pt * 80%)[Write the $4$ hundreds in the hundreds place.]],
    )
  ]
]

#note(title: [Addition Property of $0$])[
  The sum of $0$ and any number is that number. For example,
  $
    7+0=7\
    0+7=7
  $
]

#note(title: [Commutative Property of Addition])[
  Changing the *order* of two addends does not change their sum. For example,
  $
    2+3=5 quad "and" quad 3+2=5
  $
]

#note(title: [Associative Property of Addition])[
  Changing the *grouping* of addends does not change their sum. For example,
  $
    3+(5+7)=3+12=15 quad "and" quad (3+5)+7=8+7=15
  $
]

When adding several numbers, it is often helpful to look for two or three
numbers whose sum is $10$, $20$, and so on.

=== Subtracting Whole Numbers

*Subtraction* is finding the *difference* of two numbers.

#align(center)[
  #block(
    breakable: false,
    inset: 0pt,
  )[
    #table(
      columns: 5,
      align: center,
      inset: (x: 2pt, y: 0pt),
      stroke: 0pt,
      $8$, $-$, $5$, $=$, $3$,
      table.cell(inset: (y: 13pt))[#scale(y: 150%)[#text(fill: blue)[#sym.arrow.t]]],
      [],
      table.cell(inset: (y: 13pt))[#scale(y: 150%)[#text(fill: blue)[#sym.arrow.t]]],
      [],
      table.cell(inset: (y: 13pt))[#scale(y: 150%)[#text(fill: blue)[#sym.arrow.t]]],

      [#text(fill: blue)[minuend]], [], [#text(fill: blue)[subtrahend]], [], [#text(fill: blue)[difference]],
    )
  ]
]

Subtraction is defined in terms of addition.

$
  8 - 3 = 5 quad "because" quad 5 + 3 = 8
$

= Integers and Solving Equations

= Solving Equations and Problem Solving

= Fractions and Mixed Numbers

= Decimals

= Ratio, Proportion, and Triangle Applications

= Percent

= Graphing and Introduction to Statistics and Probability

= Geometry and Measurement

= Exponents and Polynomials
