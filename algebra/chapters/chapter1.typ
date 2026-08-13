#import "../components.typ": *

= The Whole Numbers

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
  image("../figures/1-1.pdf"),
)

=== Tables

*Tables* are often used to organize and display facts that contain numbers.

#table(
  columns: (1fr, 1fr, 1fr),
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

#grid(
  columns: (auto, auto, auto, auto, auto),
  column-gutter: 0.5em,
  row-gutter: 1.5em,
  align: center,
  $2$, $+$, $4$, $=$, $6$,
  [#scale(y: 200%)[↑]], [], [#scale(y: 200%)[↑]], [], [#scale(y: 200%)[↑]],
  [addend], [], [addend], [], [sum],
)

To add whole numbers, we add the digits in the ones place, then the tens place,
then the hundreds place, and so on.


= Integers and Solving Equations

= Solving Equations and Problem Solving

= Fractions and Mixed Numbers

= Decimals

= Ratio, Proportion, and Triangle Applications

= Percent

= Graphing and Introduction to Statistics and Probability

= Geometry and Measurement

= Exponents and Polynomials
