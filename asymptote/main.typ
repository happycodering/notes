#import "components.typ": *
#set document(title: [Asymptote])
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
  paper: "a4",
  margin: (left: 1cm, right: 1cm, top: 1.75cm, bottom: 1cm),
)
#set par(
  justify: true,
  leading: 1em,
)
#set heading(
  numbering: "1.1",
)

// #show heading.where(level: 1): it => {
//   v(2cm)
//   context {
//     let n = counter(heading).get().first()
//     text(size: base-size * h1-scale, weight: "bold")[Chapter #n. #it.body]
//   }
//   // text(size: 24pt, weight: "bold")[#it]
//   v(1.5cm)
// }

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

#show outline.entry: it => link(
  it.element.location(),
  it.indented(
    if it.element.func() == heading and it.element.level == 1 {
      [Chapter #it.prefix()]
    } else {
      it.prefix()
    },
    it.inner(),
  ),
)

#show raw.where(block: true): it => block(
  fill: luma(95%),
  inset: 10pt,
  stroke: (left: 2pt + luma(50%)),
  width: 100%,
  it,
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
#set line(length: 100%, stroke: 2pt + luma(70%))
#set raw(
  syntaxes: (
    "asy.sublime-syntax",
  ),
)
///////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////

#page(
  margin: (x: 0cm, y: 0cm),
)[
  #image("asymptote-cover.pdf")
]
#pagebreak()
#page()[
  #v(8cm)
  #align(center)[
    #text(size: 40pt, weight: "bold")[
      #title()
    ]
  ]
]
#align(center)[
  #text(size: 24pt, weight: "bold")[Contents]
]
#outline(title: none)
#pagebreak()

#set page(
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

#counter(page).update(1)

///////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////

= Generalities
```asymptote
settings.tex = "lualatex";
settings.outformat = "pdf";
settings.prc = false;
texpreamble("\usepackage{fontspec}");
texpreamble("\usepackage{amsmath}");
texpreamble("\usepackage{amsthm}");
texpreamble("\usepackage{xcolor}");
texpreamble("\usepackage{unicode-math}");
texpreamble("\setmainfont{Noto Sans}");
texpreamble("\setsansfont{Noto Sans}");
texpreamble("\setmathfont[Path=../fonts/,Extension=.ttf,]
  {NotoSansMath-Regular}");
import x11colors;

unitsize(2cm);
pair A, B, C, D;
A=(0,0);
B=(2,0);
C=(4,0);
D=(4,2);
draw(A--B);
draw(C--D);
```
#figure(
  image("figures/asy-1.pdf"),
  caption: [asy-1],
)
#line()
#pagebreak()
```asymptote
size(5cm,0);
pair A, B, C, D;
A=(0,0);
B=(2,0);
C=(4,0);
D=(4,2);
draw(A--B);
draw(C--D);
```
#figure(
  image("figures/asy.2.pdf"),
  caption: [asy-2],
)
#line()
#pagebreak()
```asymptote
size(10cm,0);
pair A, B, C, D;
A=(0,0);
B=(2,0);
C=(4,0);
D=(4,2);
draw(A--B);
draw(C--D);
```
#figure(
  image("figures/asy.3.pdf"),
  caption: [asy-3],
)
#line()
#pagebreak()
```asymptote
size(5cm, 3cm);
pair A, B, C, D;
A=(0,0);
B=(2,0);
C=(4,0);
D=(4,2);
draw(A--B);
draw(C--D);
```
#figure(
  image("figures/asy-4.pdf"),
  caption: [asy-4],
)
#line()
#pagebreak()
```asymptote
size(10cm,2.5cm);
pair A, B, C, D;
A=(0,0);
B=(2,0);
C=(4,0);
D=(4,2);
draw(A--B);
draw(C--D);
```
#figure(
  image("figures/asy-5.pdf"),
  caption: [asy-5],
)
#line()
#pagebreak()
```asymptote
size(10cm, 2.5cm, false); // width, height, and whether to preserve
// aspect ratio
pair A, B, C, D;
A=(0,0);
B=(2,0);
C=(4,0);
D=(4,2);
draw(A--B);
draw(C--D);
```
#figure(
  image("figures/asy-6.pdf"),
  caption: [asy-6],
)
#line()
#pagebreak()
```asymptote
size(3cm, 10cm, false);
pair A, B, C, D;
A=(0,0);
B=(2,0);
C=(4,0);
D=(4,2);
draw(A--B);
draw(C--D);
```
#figure(
  image("figures/asy-7.pdf"),
  caption: [asy-7],
)
#line()
#pagebreak()
```asymptote
pair A, B, C, D;
A=(0,0);
B=(3cm,0);
C=(6cm,0);
D=(6cm,4cm);
draw(A--B);
draw(C--D);
```
#figure(
  image("figures/asy-8.pdf"),
  caption: [asy-8],
)
#line()
#pagebreak()
```asymptote
unitsize(1cm);
pair A, B, C, D;
A=(0,0);
B=(3,0);
C=(6,0);
D=(6,4);
draw(A--B);
draw(C--D);
```
#figure(
  image("figures/asy-9.pdf"),
  caption: [asy-9],
)
#line()
#pagebreak()
```asymptote
unitsize(x=2cm, y=1cm);
pair A, B, C, D;
A=(0,0);
B=(3,0);
C=(6,0);
D=(6,4);
draw(A--B);
draw(C--D);
```
#figure(
  image("figures/asy-10.pdf"),
  caption: [asy-10],
)
#line()
#pagebreak()
```asymptote
size(10cm,0);
draw(scale(4)*unitcircle);
dot((0, 0));
dot((4, 0));
fixedscaling((-8,-8),(6,6));
shipout(bbox(Fill(lightgrey)));
```
#figure(
  image("figures/asy-11.pdf"),
  caption: [asy-11],
)
#line()
#pagebreak()
```asymptote
size(10cm,0);
path p=(0,0)--(1,0);
frame object;
draw(object, scale(8cm)*p);
add(object);
add(object, (0,-40));
```
#figure(
  image("figures/asy-12.pdf"),
  caption: [asy-12],
)
#line()
#pagebreak()
```asymptote
size(10cm,0);
path p=(0,0)--(1,0);
picture object;
draw(object,scale(8cm)*p);
add(object);
add(object,(0,-40)); // Adds truesize object to currentpicture
```
#figure(
  image("figures/asy-13.pdf"),
  caption: [asy-13],
)
#line()
#pagebreak()
```asymptote
size(6cm,6cm);
pair A=(0,0), B=(1,0), C=(0,1);
draw (A--B--C);
```
#figure(
  image("figures/asy-14.pdf"),
  caption: [asy-14],
)
#line()
#pagebreak()
```asymptote
size(6cm, 6cm);
pair A=(0,0), B=(1,0), C=(0,1);
draw (A--B--C--cycle);
```
#figure(
  image("figures/asy-15.pdf"),
  caption: [asy-15],
)
#line()
#pagebreak()
```asymptote
size(6cm, 6cm);
pair [] A;
A[0]=(-1, -1);
A[1]=( 1, -1);
A[2]=( 1,  1);
A[3]=(-1,  1);
draw (A[0]--A[1]--A[2]--A[3]--cycle);
draw (A[0]--A[2]);
draw (A[1]--A[3]);
```
#figure(
  image("figures/asy-16.pdf"),
  caption: [asy-16],
)
#line()
#pagebreak()
```asymptote
size(6cm,6cm);
draw(unitsquare);
dot((0,0)--(1,1)--(0,1)--(1,0));
draw((0,0)--(1,1));
draw((1,0)--(0,1));
```
#figure(
  image("figures/asy-17.pdf"),
  caption: [asy-17],
)
#line()
#pagebreak()
```asymptote
size(6cm,3cm,false);
draw(unitsquare);
dot((0,0)--(1,1)--(0,1)--(1,0));
draw((0,0)--(1,1));
draw((1,0)--(0,1));
```
#figure(
  image("figures/asy-18.pdf"),
  caption: [asy-18],
)
#line()
#pagebreak()
```asymptote
size(8cm,0);
pair A,B,C;
A=(0,0);B=(1,0);C=(2,0);
draw(A,8bp+black);
draw(B,8bp+blue);
draw(C,linewidth(8bp));
```
#figure(
  image("figures/asy-19.pdf"),
  caption: [asy-19],
)
#line()
#pagebreak()
```asymptote
unitsize(3cm);
pair A=(0,0), B=(1,0), C=(0,1);
path trig;
trig=A--B--C--cycle;
draw(trig);
dot(trig,linewidth(8bp));
dot(shift(3,0)*trig,red+8bp);
```
#figure(
  image("figures/asy-20.pdf"),
  caption: [asy-20],
)
#line()
#pagebreak()
```asymptote
size(6cm,6cm);
pair A, B, C;
A=(0,0); B=(1,0); C=(0,1);
draw(A--B--C--cycle);
draw (midpoint(A--B) -- C);
draw (B+0.5*(C-B) -- A);
draw (interp(A,C,0.5) -- B);
```
#figure(
  image("figures/asy-21.pdf"),
  caption: [asy-21],
)
#line()
#pagebreak()
```asymptote
size(6cm,6cm);
pair A, B, C;
A=(0,0); B=(1,0); C=(0,1);
draw(A--B--C--cycle);
draw (midpoint(A--B) -- C);
draw (B+0.5*(C-B) -- A);
draw (interp(A,C,0.5) -- B);
dot(A/3 + B/3 + C/3);
```
#figure(
  image("figures/asy-22.pdf"),
  caption: [asy-22],
)
#line()
#pagebreak()
```asymptote
size(6cm,0);
pair A=(0,0), B=(1,0), C=(0,1);
draw(A--B--C--cycle);
draw(A--B,linewidth(4bp));
```
#figure(
  image("figures/asy-23.pdf"),
  caption: [asy-23],
)
#line()
#pagebreak()
```asymptote
size(6cm,0);
pair A=(0,0), B=(1,0), C=(0,1);
draw(A--B--C--cycle);
draw(A--B,(red+green));
```
#figure(
  image("figures/asy-24.pdf"),
  caption: [asy-24],
)
#line()
#pagebreak()
```asymptote
size(6cm,0);
pair A=(0,0), B=(1,0), C=(0,1);
draw(A--B, 0.8white+6bp);
draw(A--C, 0.6white+6bp);
draw(B--C, 0.4white+6bp);
draw(A--B--C--cycle, yellow);
```
#figure(
  image("figures/asy-25.pdf"),
  caption: [asy-25],
)
#line()
#pagebreak()
```asymptote
size(8cm,0);
path p1=(0,0)--(1,1);
path p2=(2,0)--(3,1);
draw(p1,linewidth(8mm));
draw(p2,linewidth(8mm));
draw(p1--p2, 4mm+0.8green);
draw(reverse(p1)--p2, 2mm+.8red);
```
#figure(
  image("figures/asy-26.pdf"),
  caption: [asy-26],
)
#line()
#pagebreak()
```asymptote
size(8cm,0);
pair A=(0,0), B=(1,0);
dot("$A$",A,N);
dot("$B$",B,N);
draw(interp(A,B,-0.5)--interp(A,B,1.25));
```
#figure(
  image("figures/asy-27.pdf"),
  caption: [asy-27],
)
#line()
#pagebreak()
```asymptote
unitsize(cm);
path line=(0,0)--(6,0);
draw(line,solid);
draw(shift(0,-1)*line,dotted);
draw(shift(0,-2)*line,dashed);
draw(shift(0,-3)*line,longdashed);
draw(shift(0,-4)*line,dashdotted);
draw(shift(0,-5)*line,longdashdotted);
```
#figure(
  image("figures/asy-28.pdf"),
  caption: [asy-28],
)
#line()
#pagebreak()
```asymptote
unitsize(1cm);
path line=(0,0)--(6,0);
pen my_pen=linetype("24 8 8 8");
draw(line,linetype("24 8 8 8"));
draw(shift(0,-1)*line,my_pen+0.8red);
draw(shift(0,-2)*line,my_pen+0.7green+4bp);
draw(shift(0,-3)*line,linetype("24 8 8 8",false)+0.7blue+4bp);
draw(shift(0,-4)*line,linetype("24 8 8 8",true,false)+4bp);
draw(shift(0,-5)*line,linetype("24 8 8 8",false,false)+0.5red+blue+4bp);
```
#figure(
  image("figures/asy-29.pdf"),
  caption: [asy-29],
)
#line()
#pagebreak()
```asymptote
size(8cm,0);
transform T=shift(0,-0.125);
path g=(0,0)--(1,0);
int i=-1;
draw(T^(++i)*g, Arrows());
draw(T^(++i)*g, 0.8*green, Arrows(SimpleHead));
draw(T^(++i)*g, 0.8*red, Arrows(SimpleHead,size=5mm));
draw(T^(++i)*g, Arrows(HookHead));
draw(T^(++i)*g, 0.8*green, Arrows(HookHead,size=5mm));
draw(T^(++i)*g, 0.8*red, Arrows(HookHead(barb=20),size=5mm));
draw(T^(++i)*g, 2mm+0.8*blue, Arrows(HookHead(dir=60),size=5mm, Fill));
draw(T^(++i)*g, 0.8*yellow, Arrows(HookHead(barb=-10,dir=40),size=5mm));
draw(T^(++i)*g, Arrows(TeXHead));
draw(T^(++i)*g, 0.8*green, Arrows(TeXHead,size=5bp));
draw(T^(++i)*g, 5bp+0.8*red, Arrows(TeXHead));
```
#figure(
  image("figures/asy-30.pdf"),
  caption: [asy-30],
)
#line()
#pagebreak()
```asymptote
path line=(0,0)--(5cm,0);
draw(line,Arrow);
draw(shift(0,-1cm)*line, BeginArrow);
draw(shift(0,-2cm)*line, MidArrow);
draw(shift(0,-3cm)*line, Arrows);
draw(shift(0,-4cm)*line, linewidth(3bp), Arrow(20bp));
draw(shift(0,-5cm)*line, linewidth(3bp), BeginArrow(20bp));
draw(shift(0,-6cm)*line, linewidth(3bp), MidArrow(20bp));
draw(shift(0,-7cm)*line, linewidth(3bp), Arrows(20bp));
```
#figure(
  image("figures/asy-31.pdf"),
  caption: [asy-31],
)
#line()
#pagebreak()
```asymptote
path line=(0,0)--(5cm,0);
DefaultHead=HookHead;
draw(shift(6cm,0)*line,Arrow());
draw(shift(6cm,-1cm)*line, BeginArrow());
draw(shift(6cm,-2cm)*line, MidArrow());
draw(shift(6cm,-3cm)*line, Arrows());
draw(shift(6cm,-4cm)*line, linewidth(3bp), Arrow(20bp));
draw(shift(6cm,-5cm)*line, linewidth(3bp), BeginArrow(20bp));
draw(shift(6cm,-6cm)*line, linewidth(3bp), MidArrow(20bp));
draw(shift(6cm,-7cm)*line, linewidth(3bp), Arrows(20bp));
```
#figure(
  image("figures/asy-32.pdf"),
  caption: [asy-32],
)
#line()
#pagebreak()
```asymptote
path line=(0,0)--(5cm,0);
DefaultHead=SimpleHead;
draw(shift(6cm,0)*line,Arrow());
draw(shift(6cm,-1cm)*line, BeginArrow());
draw(shift(6cm,-2cm)*line, MidArrow());
draw(shift(6cm,-3cm)*line, Arrows());
draw(shift(6cm,-4cm)*line, linewidth(3bp), Arrow(20bp));
draw(shift(6cm,-5cm)*line, linewidth(3bp), BeginArrow(20bp));
draw(shift(6cm,-6cm)*line, linewidth(3bp), MidArrow(20bp));
draw(shift(6cm,-7cm)*line, linewidth(3bp), Arrows(20bp));
```
#figure(
  image("figures/asy-33.pdf"),
  caption: [asy-33],
)
#line()
#pagebreak()
```asymptote
path line=(0,0)--(5cm,0);
DefaultHead=TeXHead;
draw(shift(6cm,0)*line,Arrow());
draw(shift(6cm,-1cm)*line, BeginArrow());
draw(shift(6cm,-2cm)*line, MidArrow());
draw(shift(6cm,-3cm)*line, Arrows());
draw(shift(6cm,-4cm)*line, linewidth(bp), Arrow());
draw(shift(6cm,-5cm)*line, linewidth(2bp), BeginArrow(5bp));
draw(shift(6cm,-6cm)*line, linewidth(2bp), MidArrow(5bp));
draw(shift(6cm,-7cm)*line, linewidth(2bp), Arrows(5bp));
```
#figure(
  image("figures/asy-34.pdf"),
  caption: [asy-34],
)
#line()
#pagebreak()
```asymptote
path line=(0,0)..(2.5cm,2.5cm)..(5cm,0);
draw(line,ArcArrow);
draw(shift(0,-2cm)*line,BeginArcArrow);
draw(shift(0,-4cm)*line,MidArcArrow);
draw(shift(0,-6cm)*line,ArcArrows);
draw(shift(6cm,0)*line,3bp+0.8red,ArcArrow(20bp));
draw(shift(6cm,-2cm)*line,3bp+0.8red,BeginArcArrow(20bp));
draw(shift(6cm,-4cm)*line,3bp+0.8red,MidArcArrow(20bp));
draw(shift(6cm,-6cm)*line,3bp+0.8red,ArcArrows(20bp));
```
#figure(
  image("figures/asy-35.pdf"),
  caption: [asy-35],
)
#line()
#pagebreak()
```asymptote
DefaultHead=HookHead;
path line=(0,0)..(2.5cm,2.5cm)..(5cm,0);
draw(line,ArcArrow());
draw(shift(0,-2cm)*line,BeginArcArrow());
draw(shift(0,-4cm)*line,MidArcArrow());
draw(shift(0,-6cm)*line,ArcArrows());
draw(shift(6cm,0)*line,3bp+0.8red,ArcArrow(20bp));
draw(shift(6cm,-2cm)*line,3bp+0.8red,BeginArcArrow(20bp));
draw(shift(6cm,-4cm)*line,3bp+0.8red,MidArcArrow(20bp));
draw(shift(6cm,-6cm)*line,3bp+0.8red,ArcArrows(20bp));
```
#figure(
  image("figures/asy-36.pdf"),
  caption: [asy-36],
)
#line()
#pagebreak()
```asymptote
DefaultHead=SimpleHead;
path line=(0,0)..(2.5cm,2.5cm)..(5cm,0);
draw(line,ArcArrow());
draw(shift(0,-2cm)*line,BeginArcArrow());
draw(shift(0,-4cm)*line,MidArcArrow());
draw(shift(0,-6cm)*line,ArcArrows());
draw(shift(6cm,0)*line,3bp+0.8red,ArcArrow(20bp));
draw(shift(6cm,-2cm)*line,3bp+0.8red,BeginArcArrow(20bp));
draw(shift(6cm,-4cm)*line,3bp+0.8red,MidArcArrow(20bp));
draw(shift(6cm,-6cm)*line,3bp+0.8red,ArcArrows(20bp));
```
#figure(
  image("figures/asy-37.pdf"),
  caption: [asy-37],
)
#line()
#pagebreak()
```asymptote
DefaultHead=TeXHead;
path line=(0,0)..(2.5cm,2.5cm)..(5cm,0);
draw(line,Arrow());
draw(shift(0,-2cm)*line,BeginArrow());
draw(shift(0,-4cm)*line,MidArrow());
draw(shift(0,-6cm)*line,Arrows());
draw(shift(6cm,0)*line,3bp+0.8red,Arrow(5bp));
draw(shift(6cm,-2cm)*line,3bp+0.8red,BeginArrow(5bp));
draw(shift(6cm,-4cm)*line,3bp+0.8red,MidArrow(5bp));
draw(shift(6cm,-6cm)*line,3bp+0.8red,Arrows(5bp));
```
#figure(
  image("figures/asy-38.pdf"),
  caption: [asy-38],
)
#line()
#pagebreak()
```asymptote
path line=(0,0)--(5cm,0);
draw(line,Arrow(20bp,filltype=NoFill));
draw(shift(0,-1cm)*line,Arrow(20bp,filltype=FillDraw(0.8red)));
draw(shift(0,-2cm)*line,Arrow(20bp,filltype=Fill(0.8red)));
draw(shift(0,-3cm)*line,Arrows(filltype=FillDraw(-10,10,0.8red)));
```
#figure(
  image("figures/asy-39.pdf"),
  caption: [asy-39],
)
#line()
#pagebreak()
```asymptote
DefaultHead=HookHead;
path line=(0,0)--(5cm,0);
draw(line,Arrow(20bp,filltype=NoFill));
draw(shift(0,-1cm)*line,Arrow(20bp,filltype=FillDraw(0.8red)));
draw(shift(0,-2cm)*line,Arrow(20bp,filltype=Fill(0.8red)));
draw(shift(0,-3cm)*line,Arrows(filltype=FillDraw(-10,10,.8red)));
```
#figure(image("figures/asy-40.pdf"), caption: [asy-40])
#line()
#pagebreak()
```asymptote
DefaultHead=TeXHead;
path line=(0,0)--(5cm,0);
draw(line,Arrow(10bp,filltype=NoFill));
draw(shift(0,-2cm)*line,Arrow(10bp,filltype=FillDraw(0.8red)));
draw(shift(0,-4cm)*line,Arrow(10bp,filltype=Fill(0.8red)));
draw(shift(0,-6cm)*line,Arrows(filltype=FillDraw(-10,10,0.8red)));
```
#figure(image("figures/asy-41.pdf"), caption: [asy-41])
#line()
#pagebreak()
```asymptote
path line=(0,0)--(5cm,0);
draw(line,linewidth(5bp),Arrow);
draw(shift(0,-2cm)*line,linewidth(5bp),Arrow(30bp,10));
draw(shift(0,-5cm)*line,linewidth(30bp),Arrow(20bp,50));
draw(shift(0,-8cm)*line,linewidth(10bp),Arrow(20bp,50,filltype=NoFill));
```
#figure(image("figures/asy-42.pdf"), caption: [asy-42])
#line()
#pagebreak()
```asymptote
size(5cm,0);
path line=(0,0)--(5,0);
draw(line,Arrow(20bp,position=0.75));
draw(shift(0,-2)*line,Arrow(20bp,40,0.75,filltype=NoFill));
position pos=BeginPoint;
pos.position=0.75;
draw(shift(0,-4)*line,BeginArrow(20bp,pos));
draw(shift(0,-6)*line,BeginArrow(20bp,40,pos,filltype=NoFill));
```
#figure(image("figures/asy-43.pdf"), caption: [asy-43])
#line()
#pagebreak()
```asymptote
unitsize(8cm);
path g=(0,0)--(1,0);
draw(g,Arrow(Relative(0.45)));
add(arrow(g,Relative(0.55)));
```
#figure(image("figures/asy-44.pdf"), caption: [asy-44])
#line()
#pagebreak()
```asymptote
size(8cm,0);
path g = (0,0)--(1,0);
draw(g,Arrow(Relative(0.75)));
add(arrow(reverse(g), invisible, FillDraw(green,red), Relative(0.75)));
```
#figure(image("figures/asy-45.pdf"), caption: [asy-45])
#line()
#pagebreak()
```asymptote
size(5cm,0);
path line=(0,0)--(5,0);
transform T=shift(0,-1);
draw(line, Bar);
draw(T*line, BeginBar);
draw(T^2*line, Bars);
draw(T^3*line, Arrow, BeginBar);
```
#figure(image("figures/asy-46.pdf"), caption: [asy-46])
#line()
#pagebreak()
```asymptote
path line=(0,0)--(5cm,0);
transform T=shift(0,-1cm);
draw(line,linewidth(1mm),Bars);
draw(T^2*line,Bars(5mm));
draw(T^3*line,linewidth(1mm),Bars(5mm));
draw(T^4*line,dotted+red,Bars);
```
#figure(image("figures/asy-47.pdf"), caption: [asy-47])
#line()
#pagebreak()
```asymptote
size(6cm,0);
draw((-0.5,0)--(1,0));
draw((0,-0.5)--(0,1));
draw((0,0)--(0.75,0),linewidth(1mm),Arrow(3mm));
draw((0,0)--(0,0.75),linewidth(1mm),Arrow(3mm));
```
#figure(image("figures/asy-48.pdf"), caption: [asy-48])
#line()
#pagebreak()
```asymptote
fill((0,0)--(0,6cm)--(6cm,0)--cycle, gray);
```
#figure(image("figures/asy-49.pdf"), caption: [asy-49])
#line()
#pagebreak()
```asymptote
filldraw((0,0)--(0,6cm)--(6cm,0)--cycle,gray);
```
#figure(image("figures/asy-50.pdf"), caption: [asy-50])
#line()
#pagebreak()
```asymptote
filldraw((0,0)--(0,6cm)--(6cm,0)--cycle,
    fillpen=gray, drawpen=linewidth(1mm) + 0.8 * red);
```
#figure(image("figures/asy-51.pdf"), caption: [asy-51])
#line()
#pagebreak()
```asymptote
pen[][] p={{rgb(black)}, {rgb(.8red)}};
latticeshade((0,0)--(0,6cm)--(6cm,0)--cycle, p);
```
#figure(image("figures/asy-52.pdf"), caption: [asy-52])
#line()
#pagebreak()
```asymptote
pen[][] p={{rgb(black),rgb(black)}, {rgb(red),rgb(green)}};
latticeshade((0,0)--(0,6cm)--(6cm,0)--cycle,p);
```
#figure(image("figures/asy-53.pdf"), caption: [asy-53])
#line()
#pagebreak()
```asymptote
size(8cm,0);
pen[][] p={{rgb(white),rgb(grey),rgb(black)},
    {red,green,blue},
    {cyan,magenta,yellow}};
latticeshade(unitsquare,p);
```
#figure(image("figures/asy-54.pdf"), caption: [asy-54])
#line()
#pagebreak()
```asymptote
size(8cm,0);
import palette;
real[][] v={{1,2},{3,4}};
pen[] Palette=Rainbow();
latticeshade(box((0,0),(1,1)),palette(v,Palette));
```
#figure(image("figures/asy-55.pdf"), caption: [asy-55])
#line()
#pagebreak()
```asymptote
size(8cm,0);
pair A=(0.35,0.35), B=(0.6,0.6);
radialshade(unitsquare,black,A,0.15,lightgrey,B,0.6);
dot(A,0.8red+8pt);
dot(B,yellow+8pt);
draw(shift(A)*scale(0.15)*unitcircle,dashed+red+1.5pt);
draw(shift(B)*scale(0.6)*unitcircle,dashed+blue+1.5pt);
clip(unitsquare);
```
#figure(image("figures/asy-56.pdf"), caption: [asy-56])
#line()
#pagebreak()
```asymptote
size(8cm,0);
transform t=xscale(1.25);
pen p1=blue, p2=yellow;
pair pa=t*dir(135), pb=t*dir(-45);
axialshade(t*unitcircle,p1,pa,p2,pb);
draw(pa--pb, dashed);
```
#figure(image("figures/asy-57.pdf"), caption: [asy-57])
#line()
#pagebreak()
```asymptote
size(10cm,0);
real r=1;
real R=3.8;
int step=30;
path p=arc(0,r,0,step);
path P=arc(0,R,step,0);
for(int h=0; h < 360; h += step) {
  transform t=rotate(90-h);
  tensorshade(t*p--t*P--cycle,
              new pen[] {white,white,hsv(h-step,1,1),hsv(h,1,1)});
}
for(int h=0; h < 360; h += 30) {
  pair v=R*dir(90-h);
  draw(Label(string(h)+"$^\circ$",EndPoint),(v--1.05v));
}
draw(circle(0,r));
draw(circle(0,R));
```
#figure(image("figures/asy-58.pdf"), caption: [asy-58])
#line()
#pagebreak()
```asymptote
size(16cm,0);
path[] P=texpath("$\displaystyle\int_{-\infty}^{+\infty}
  e^{-\alpha x^2}\,dx=\sqrt{\frac{\pi}{\alpha}}$");
pair m=min(P), M=max(P);
axialshade(P,yellow,m,red,(m.x,M.y));
draw(P,0.5*blue);
shipout(bbox(3mm,Fill));
```
#figure(image("figures/asy-59.pdf"), caption: [asy-59])
#line()
#pagebreak()
```asymptote
size(8cm,0);
pair A, B, C, D;
A=(0,0); B=(1,0);
C=(1,1); D=(0,1);
fill(A--C--B--D--cycle,grey);
```
#figure(image("figures/asy-60.pdf"), caption: [asy-60])
#line()
#pagebreak()
```asymptote
size(8cm,0);
pair A, B, C, D;
A=(0,0); B=(1,0);
C=(1,1); D=(0,1);
filldraw(A--C--B--D--cycle,grey);
```
#figure(image("figures/asy-61.pdf"), caption: [asy-61])
#line()
#pagebreak()
```asymptote
size(10cm, 0);
path cle=unitcircle;
draw((-1.5, 0)--(2.5, 0), linewidth(10mm));
filldraw(cle, red+opacity(0.5));
filldraw(shift((1, 0))*cle, blue+opacity(0.5));
```
#figure(image("figures/asy-62.pdf"), caption: [asy-62])
#line()
#pagebreak()
```asymptote
pair O=0;
dot("N",O,N);
dot("S",O,S);
dot("E",O,E);
dot("W",O,W);
```
#figure(image("figures/asy-63.pdf"), caption: [asy-63])
#line()
#pagebreak()
```asymptote
pair O=0;
labelmargin=2;
dot("N",O,N);
dot("S",O,S);
dot("E",O,E);
dot("W",O,W);
```
#figure(image("figures/asy-64.pdf"), caption: [asy-64])
#line()
#pagebreak()
```asymptote
size(10cm,0);
pair O=0;
dot("N",O,10N);
draw("S",O,10S);
draw("E",O,10E);
draw("W",O,10W);
draw("NE",O,5NE);
draw("SE",O,5SE);
draw("NW",O,5NW);
draw("SW",O,5SW);
```
#figure(image("figures/asy-65.pdf"), caption: [asy-65])
#line()
#pagebreak()
```asymptote
pair O=0;
draw(scale(2)*Label("N",0.8red),O,10*N,linewidth(3mm));
draw(scale(2)*Label("S",0.8red),O,10*S);
draw(scale(2)*Label("E",0.8red),O,10*E);
draw(scale(2)*Label("W",0.8red),O,10*W);
draw(rotate(45)*Label("NE"),O,5NE);
draw(rotate(-45)*Label("SE"),O,5SE);
draw(rotate(-45)*Label("NW"),O,5NW);
draw(rotate(45)*Label("SW"),O,5SW);
```
#figure(image("figures/asy-66.pdf"), caption: [asy-66])
#line()
#pagebreak()
```asymptote
pair O=0;
dot(O, red + 8bp);
label(scale(5) * "$\frac{\pi^2}{2}$", O);
```
#figure(image("figures/asy-67.pdf"), caption: [asy-67])
#line()
#pagebreak()
```asymptote
dot(Label(scale(5) * "$\frac{\pi^2}{2}$", (0,0), align=E, blue),
  red + 10bp);
```
#figure(image("figures/asy-68.pdf"), caption: [asy-68])
#line()
#pagebreak()
```asymptote
label(scale(15)*Label("$\pi$"), (0,0));
```
#figure(image("figures/asy-69.pdf"), caption: [asy-69])
#line()
#pagebreak()
```asymptote
texpreamble("\usepackage{manfnt}");
label(scale(6)*Label("\textdbend"), (0,0));
```
#figure(image("figures/asy-70.pdf"), caption: [asy-70])
#line()
#pagebreak()
```asymptote
dot(Label("$A$", red), (0,0), S, blue+5pt);
```
#figure(image("figures/asy-71.pdf"), caption: [asy-71])
#line()
#pagebreak()
```asymptote
size(6cm, 6cm);
dot(Label("$A$"),(0,0),S);
draw(E--W,invisible);
draw(N--S,invisible);
shipout(bbox());
```
#figure(image("figures/asy-72.pdf"), caption: [asy-72])
#line()
#pagebreak()
```asymptote
dot(Label("$A$", fontsize(26pt) + red), (0,0), NE, blue+10bp);
```
#figure(image("figures/asy-73.pdf"), caption: [asy-73])
#line()
#pagebreak()
```asymptote
defaultpen(fontsize(26pt));
dot(Label("$A$"),(0,0),NE, red+10bp);
dot(Label("$B$"),(2cm,0),NE+N, blue+10pt);
```
#figure(image("figures/asy-74.pdf"), caption: [asy-74])
#line()
#pagebreak()
```asymptote
label(rotate(45) * scale(5) * "\textbf{Hello}");
```
#figure(image("figures/asy-75.pdf"), caption: [asy-75])
#line()
#pagebreak()
```asymptote
frame f;
label(f,"\textbf{Hello}",yellow,Fill(black));
add(scale(5)*rotate(45)*f);
```
#figure(image("figures/asy-76.pdf"), caption: [asy-76])
#line()
#pagebreak()
```asymptote
frame f;
filldraw(scale(5cm)*unitsquare, black);
label(f,"Hello", 0.8*red, Fill(white));
add(rotate(45) * scale(5) * f, (2.5cm,2.5cm));
```
#figure(image("figures/asy-77.pdf"), caption: [asy-77])
#line()
#pagebreak()
```asymptote
label(scale(5)*"\textbf{Cancel}");
pair a = min(currentpicture);
pair b = max(currentpicture);
draw((a.x,0)--(b.x,0), 6bp + red * 0.8);
```
#figure(image("figures/asy-78.pdf"), caption: [asy-78])
#line()
#pagebreak()
```asymptote
label(scale(6)*"\textbf{Cancel}");
layer();
pair a=min(currentpicture);
pair b=max(currentpicture);
draw((a.x,0)--(b.x,0), 6bp + blue * 0.8);
```
#figure(image("figures/asy-79.pdf"), caption: [asy-79])
#line()
#pagebreak()
```asymptote
pen dottedGreen = 4pt + ForestGreen + linetype(new real[] {0,2});
size(6cm,0);
path line1=(0,0)--(1,0);
path line2=(0,0)--(1,1);
pair bissec=dir(line1,line2);
draw(line1, 2pt+red);
draw(line2, 2pt+blue);
dot(bissec, 10bp+Tomato);
draw(-0.5bissec--bissec, dottedGreen);
dot(scale(2)*"$A$",(0,0),-bissec, 8pt+purple);
```
#figure(image("figures/asy-80.pdf"), caption: [asy-80])
#line()
#pagebreak()
```asymptote
size(6cm,0);
pair A=0, B=(1,0), C=(2,2);
draw(A--B--C--cycle, 3pt+red);
dot(scale(2)*"$A$",A,dir(C--A,B--A), 8pt+blue);
dot(scale(2)*"$B$",B,dir(C--B,A--B), 8pt+blue);
dot(scale(2)*"$C$",C,dir(A--C,B--C), 8pt+blue);
```
#figure(image("figures/asy-81.pdf"), caption: [asy-81])
#line()
#pagebreak()
```asymptote
size(0,0);
path line=(0,0)--(6cm,0);
transform T=shift(0,-1cm);
draw("$A$",line, 2pt+red);
draw("$B$",T*line,dir(0), 2pt+blue);
draw("$C$",T^2*line,N, 2pt+ForestGreen);
draw(Label("$D$",fontsize(18pt)+Purple),T^3*line, 2pt+Teal);
```
#figure(image("figures/asy-82.pdf"), caption: [asy-82])
#line()
#pagebreak()
```asymptote
size(0,0);
path line=(0,0)--(6cm,0);
transform T=shift(0,-1cm);
draw(scale(2)*Label("A",align=Center,filltype=UnFill),
  line, 2bp+red);
draw(scale(2)*Label("B",UnFill), T*line, Center,
  2pt+ForestGreen);
draw(scale(2)*Label("C",align=Center,position=Relative(0.75),UnFill),
  T^2*line, 4pt+Navy);
draw(scale(2)*Label("D",position=Relative(0.25),UnFill),
  align=Center, T^3*line, 3pt+Purple);
```
#figure(image("figures/asy-83.pdf"), caption: [asy-83])
#line()
#pagebreak()
```asymptote
pair c=0;
label("abc xyz ijk",c,Align,basealign);
label("abc xyz ijk",c,Align, red);
draw(c--(c+(2cm,0))); // This is the baseline.
shipout((scale(4)*currentpicture.fit()));
```
#figure(image("figures/asy-84.pdf"), caption: [asy-84])
#line()
#pagebreak()
```asymptote
size(6cm,0);
pair A=0, B=(1,0), C=(1,1);
draw(scale(2)*"$1$",A--B, 4bp+red);
draw(scale(2)*"$1$",B--C, 4bp+blue);
draw(scale(2)*"$\sqrt{2}$",C--A, 4bp+ForestGreen);
```
#figure(image("figures/asy-85.pdf"), caption: [asy-85])
#line()
#pagebreak()
```asymptote
size(6cm,0);
pair A=0, B=(1,0), C=(1,1);
draw(scale(2)*"$1$",A--B, 4pt+red);
draw(scale(2)*"$1$",B--C, 4pt+blue);
draw(scale(2)*Label("$\sqrt{2}$",
  Rotate(-dir(C--A))),C--A, 4pt+ForestGreen);
```
#figure(image("figures/asy-86.pdf"), caption: [asy-86])
#line()
#pagebreak()
```asymptote
size(6cm,0);
path g=(1,1)--(3,2);
draw(scale(2)*Label("a text", blue, Rotate(dir(g))), g, 4bp+red);
draw(scale(2)*Label("a text", Purple,
  Rotate(-dir(g)),align=I*dir(g)), g);
```
#figure(image("figures/asy-87.pdf"), caption: [asy-87])
#line()
#pagebreak()
```asymptote
size(0,0);
pair A=(0,0), B=(6cm,0);
path line=A--B;
transform TD=shift(0,-1cm);
defaultpen(linewidth(3bp));
draw("$AB$",line, 0.8red, Arrows(3mm));
draw("$A$", A, N);
draw("$B$", B, N);
draw("$AB$", TD*line, 0.8ForestGreen, Arrows(3mm), PenMargins);
draw("$A$", TD*A, N);
draw("$B$", TD*B, N);
draw("$AB$", TD^2*line, 0.8blue, Arrows(3mm), DotMargins);
dot("$A$", TD^2*A, dotfactor*NW, Purple);
dot("$B$", TD^2*B, dotfactor*NE, Teal);
margin BigMargins=Margin(2,2);
draw("$AB$", TD^3*line, 0.8red, Arrows(3mm), BigMargins);
draw("$A$", TD^3*A, N);
draw("$B$", TD^3*B, N);
```
#figure(image("figures/asy-88.pdf"), caption: [asy-88])
#line()
#pagebreak()
```asymptote
size(6cm, 0);
void distance(picture pic=currentpicture, pair A, pair B,
  Label L="", real n=0, pen p=currentpen) {
  real d=3mm;
  guide g=A--B;
  transform T=shift(-n*d*unit(B-A)*I);
  pic.add(new void(frame f, transform t) {
    picture opic;
    guide G=T*t*g;
    draw(opic, G, p, Arrows(NoFill), Bars, PenMargins);
    label(opic, L, midpoint(G), UnFill(1));
    add(f, opic.fit());
  });
  pic.addBox(min(g), max(g), T*min(p), T*max(p));
}
pair A=(0, 0), B=(3, 3);
dot(A, 8pt+red);
dot(B, 8pt+blue);
distance(A, B, Label("$\ell$", Rotate(dir(A--B))), 1.5);
```
#figure(image("figures/asy-89.pdf"), caption: [asy-89])
#line()
#pagebreak()
```asymptote
size(0, 4cm);
real margin=2mm;
pair z1=(0,1);
pair z0=(0,0);
object label1=draw(Label(scale(1.5)*"small box", red),
  box, z1, margin, 3bp+red);
object label0=draw(Label(scale(1.5)*"LARGE ELLIPSE", blue),
  ellipse, z0, margin, 3bp+blue);
add(new void(frame f, transform t) {
    draw(f,point(label1,S,t)--point(label0,N,t),
      4pt+ForestGreen);
  });
```
#figure(image("figures/asy-90.pdf"), caption: [asy-90])
#line()
#pagebreak()
```asymptote
size(0,0);
defaultpen(1bp+blue);
pair A=0;
dot(A, 5pt+red);
arrow("1",A,NE, 3cm);
arrow("2",A,SE, 2cm);
arrow("3",A,SW, 2.5cm, Margin(3,2));
arrow("4",A,NW, 2.5cm,N);
```
#figure(image("figures/asy-91.pdf"), caption: [asy-91])
#line()
#pagebreak()
```asymptote
size(6cm,0);
draw(E--N--W--S--cycle, red+1mm);
draw(E..N..W..S..cycle, 2bp+ForestGreen);
dot(E..N..W..S..cycle, 8bp+blue);
```
#figure(image("figures/asy-92.pdf"), caption: [asy-92])
#line()
#pagebreak()
```asymptote
size(0,0);
pair O=0;
draw(circle(O,4cm), 3bp+blue);
dot(circle(O,4cm), 8bp+red);
```
#figure(image("figures/asy-93.pdf"), caption: [asy-93])
#line()
#pagebreak()
```asymptote
size(6cm);
draw(unitcircle, 2bp+blue, dot(10pt+red));
dotfactor*=3;
draw(shift(-0.5,-0.5)*unitsquare, 4bp+ForestGreen,
  dot(blue,Fill(red)));
```
#figure(image("figures/asy-94.pdf"), caption: [asy-94])
#line()
#pagebreak()
```asymptote
size(0,0);
real R=3cm;
draw(scale(R)*unitcircle, 4bp+blue);
dot((0,0), 10bp+Teal);
dot((R*cos(pi/6),R*sin(pi/6)), 12bp+red);
```
#figure(image("figures/asy-95.pdf"), caption: [asy-95])
#line()
#pagebreak()
```asymptote
size(5cm,0);
import graph;
path PerfectCircle=Circle((0,0),1);
draw(PerfectCircle, linewidth(4mm));
dot(PerfectCircle, red);
```
#figure(image("figures/asy-96.pdf"), caption: [asy-96])
#line()
#pagebreak()
```asymptote
size(4cm,0);
//Return Circle AB diameter
path circle(pair A, pair B) {
  return shift(midpoint(A--B))*scale(abs(A-B)/2)*unitcircle;
}
pair A=(0,0), B=(1,0);
draw(circle(A,B), 3pt+blue);
dot(A--B, 8pt+red);
```
#figure(image("figures/asy-97.pdf"), caption: [asy-97])
#line()
#pagebreak()
```asymptote
size(5cm,0);
//Return Circle AB diameter
path circle(pair A, pair B) {
  return shift(midpoint(A--B))*scale(abs(A-B)/2)*unitcircle;
}
pair A=(0,0), B=(3,0), C=(2,1);
draw(A--B, 5bp+0.8blue);
draw(A--C, 5bp+0.8red);
draw(B--C, 5bp+0.8green);
draw(circle(A,B), 3pt+0.8blue);
draw(circle(A,C), 3pt+0.8red);
draw(circle(B,C), 3pt+0.8green);
```
#figure(image("figures/asy-98.pdf"), caption: [asy-98])
#line()
#pagebreak()
```asymptote
size(6cm,0);
//Return Circle AB diameter
path circle(pair A, pair B) {
  return shift(midpoint(A--B))*scale(abs(A-B)/2)*unitcircle;
}
pair A=(0,0), B=(1,0), C=(2,0);
path cleAB=circle(A,B);
path cleAC=circle(A,C);
for(real t=0; t<length(cleAB); t+=0.075)
  draw(circle(point(cleAB,t),point(cleAC,t)));
```
#figure(image("figures/asy-99.pdf"), caption: [asy-99])
#line()
#pagebreak()
```asymptote
size(4cm,0);
pair O=0;
defaultpen(linewidth(2mm));
draw(arc(O,4,0,60), 0.8red, BeginPenMargin);
draw(arc(O,4,60,120), 0.7green, PenMargins);
draw(arc(O,-4,0,120), 0.7blue);
```
#figure(image("figures/asy-100.pdf"), caption: [asy-100])
#line()
#pagebreak()
```asymptote
size(5cm,0);
picture pic;
pen [] P={2bp+red, 2bp+green, 2bp+blue, 2bp+orange};
fill(scale(10)*unitcircle, black);
for (int i = 0; i <= 3; ++i)
  draw(pic, arc((0,0), 10, i*90, (i+1)*90), P[i]);
for (real i = 1; i <= 10; i+=0.075)
  add(rotate(90*i)*scale(1/i)*pic);
```
#figure(image("figures/asy-101.pdf"), caption: [asy-101])
#line()
#pagebreak()
```asymptote
size(4cm,0);
real a=360/6;
for (int i = -1; i < 5; ++i)
  fill(arc((0,0), 1, i*a, (i+1)*a)--cycle, blue);
```
#figure(image("figures/asy-102.pdf"), caption: [asy-102])
#line()
#pagebreak()
```asymptote
size(4cm,0);
real n=7, a=360/n;
for (int i = 0; i < n; ++i)
  filldraw((0,0)--arc((0,0), 1, i*a, (i+1)*a)--cycle,
  i/n*blue+(1-i/n)*green+grey, 4bp+DarkOrange);
```
#figure(image("figures/asy-103.pdf"), caption: [asy-103])
#line()
#pagebreak()
```asymptote
size(5cm,0);
real a=360/6;
for (int i = -1; i < 5; ++i)
  draw(scale(1.5)*Label(format("%i", i+1), red),
    arc((0,0), 10, i*a, (i+1)*a)--cycle, 2bp+blue);
```
#figure(image("figures/asy-104.pdf"), caption: [asy-104])
#line()
#pagebreak()
```asymptote
size(0,0);

pair x=0;
pair y=(-7.5cm,0);

label(format(6.66666), x, E);
label("format(6.66666)", y, E);

x+=(0,-1cm);y+=(0,-1cm);
label(format("$x=%f$", 6.66666), x, E);
label("format(\"\$x=\%f\$\", 6.66666)", y, E);

x+=(0,-1cm);y+=(0,-1cm);
label(format("$x=%.1f$", 6.66666), x, E);
label("format(\"\$x=\%.1f\$\", 6.66666)", y, E);

x+=(0,-1cm);y+=(0,-1cm);
label(format("$x=%.2f$", 6.66666), x, E);
label("format(\"\$x=\%.2f\$\", 6.66666)", y, E);

x+=(0,-1cm);y+=(0,-1cm);
label(format("$x=%.0f$", 6.66666), x, E);
label("format(\"\$x=\%.0f\$\", 6.6666)", y, E);

x+=(0,-1cm);y+=(0,-1cm);
label(format("$x=%07.3f$", 6.66666), x, E);
label("format(\"\$x=\%07.3f\$\", 6.6666)", y, E);

x+=(0,-1cm);y+=(0,-1cm);
label(format("$x=%7.3f$", 6.66666), x, E);
label("format(\"\$x=\% 7.3f\$\", 6.6666)", y, E);

x+=(0,-1cm);y+=(0,-1cm);
label(format("$x=%g$", 66.666), x, E);
label("format(\"\$x=\%g\$\", 66.66666)", y, E);

x+=(0,-1cm);y+=(0,-1cm);
label(format("$x=%g$", 666666.666), x, E);
label("format(\"\$x=\%g\$\", 666666.666)", y, E);

x+=(0,-1cm);y+=(0,-1cm);
label(format("$x=%g$", 666666666.666), x, E);
label("format(\"\$x=\%g\$\", 666666666.666)", y, E);

x+=(0,-1cm);y+=(0,-1cm);
label(format("$x=%e$", 666666.666), x, E);
label("format(\"\$x=\%e\$\", 666666.666)", y, E);

x+=(0,-1cm);y+=(0,-1cm);
label(format("$x=%.2e$", 666666.666), x, E);
label("format(\"\$x=\%.2e\$\", 666666.666)", y, E);

x+=(0,-1cm);y+=(0,-1cm);
label(format("$x=%i$", 6), x, E);
label("format(\"\$x=\%i\$\", 6)", y, E);

x+=(0,-1cm);y+=(0,-1cm);
label(format("$x=%f$", 6.0), x, E);
label("format(\"\$x=\%f\$\", 6.0)", y, E);

x+=(0,-1cm);y+=(0,-1cm);
label(format("$x=%+.2f$", 6.66666), x, E);
label("format(\"\$x=\%+.2f\$\", 6.66666)", y, E);

x+=(0,-1cm);y+=(0,-1cm);
label(format("$x=%+.2f$", -6.66666), x, E);
label("format(\"\$x=\%+.2f\$\", -6.66666)", y, E);

x+=(0,-1cm);y+=(0,-1cm);
label(format("$x=% .2f$", 6.666666), x, E);
label("format(\"\$x=\% .2f\$\", 6.666666)", y, E);
```
#figure(image("figures/asy-105.pdf"), caption: [asy-105])
#line()
#pagebreak()
```asymptote
size(0,0);

int pgcd(int a, int b)
{
  int a_=abs(a), b_=abs(b), r=a_;
  if (b_>a_) {a_=b_; b_=r; r=a_;}
  while (r>0)
    {
      r=a_%b_;
      a_=b_;
      b_=r;
    }
  return a_;
}

string texfrac(int p, int q,
               string factor="",
               bool signin=false,
               bool factorin=true,
               bool displaystyle=true,
               bool zero=true)
{
  if (p==0) return (zero ? "$0$" : "");
  string disp= displaystyle ? "$\displaystyle " : "$";
  int pgcd=pgcd(p,q);
  int num= round(p/pgcd), den= round(q/pgcd);
  string nums;
  if (num==1)
    if (factor=="" || (!factorin && (den !=1)))
      nums="1";
    else
      nums="";
  else
    if (num==-1)
      if (factor=="" || (!factorin && (den !=1)))
        nums="-1";
      else
        nums="-";
    else
      nums= (string) num;
  if (den==1)
    return "$" + nums + factor + "$";
  else
    {
      string dens= (den==1) ? "" : (string) den;
      if (signin || num>0)
        if (factorin)
          return disp + "\frac{" + nums + factor +
            "}{" + (string) dens + "}$";
        else
          return disp + "\frac{" + nums +
            "}{" + (string) dens + "}"+ factor + "$";
      else
        {
          if (num==-1)
            if (factor=="" || !factorin)
              nums="1";
            else
              nums="";
          else nums=(string)(abs(num));
        if (factorin)
          return disp + "-\frac{" + nums + factor +
            "}{" + (string) dens + "}$";
        else
          return disp + "-\frac{" + nums +
            "}{" + (string) dens + "}"+ factor + "$";
        }
    }
}

for (int i=-4; i<=4; ++i)
  {
    label(texfrac(i,4), (i*cm,0));
    label(texfrac(i,4,signin=true), (i*cm,-1.5cm));
    label(texfrac(i,4,factor="\pi"), (i*cm,-3cm));
    label(texfrac(i,4,factor="\pi",factorin=false),
      (i*cm,-4.5cm));
    label(texfrac(i,4,factor="\pi",signin=true,factorin=true),
      (i*cm,-6cm));
    label(texfrac(i,4,factor="\pi",signin=true,factorin=false,
      displaystyle=true,zero=false), (i*cm,-7.5cm));
  }

```
#figure(image("figures/asy-106.pdf"), caption: [asy-106])
#line()
#pagebreak()
```asymptote
size(5cm,0);

pair A=0, B=(1,0), C=(0.7,1);

void fillangle(
    picture pic=currentpicture,
    pair O=0, pair A, pair B,
    real radius=10,
    pen p=blue)
{
  picture tpic;
  real a1=degrees(shift(-O)*A,false);
  real a2=degrees(shift(-O)*B,false);
  fill(tpic, (0,0)--arc((0,0), -radius,
    max(a1,a2), min(a1,a2), true)--cycle, p=p);
  add(pic, tpic, O);
}

real r1=18, r2=20;
fillangle(A, B, C, r1, red);
fillangle(A, B, C, -r2);
fillangle(B, A, C, r1, red);
fillangle(B, A, C, -r2);
fillangle(C, B, A, r1, red);
fillangle(C, B, A, -r2);

draw(A--B--C--cycle, 2bp+ForestGreen);
```
#figure(image("figures/asy-107.pdf"), caption: [asy-107])
#line()
#pagebreak()
```asymptote
size(0,0);
pair A, B, C;
A=(0,0); B=(4cm,0); C=(0,4cm);

draw(A--B--C--cycle, 2bp+blue);
filldraw(shift(A)*scale(6)*unitcircle, red);
filldraw(shift(B)*scale(6)*unitcircle, red);
filldraw(shift(C)*scale(6)*unitcircle, red);
```
#figure(image("figures/asy-108.pdf"), caption: [asy-108])
#line()
#pagebreak()
```asymptote
size(8cm,0);
pair A=(0,0), B=(0,1), C=(1,0), D=(1,1);

draw(A..B..C..D, 2bp+blue);
dot(A, 8bp+red);
dot(B, 8bp+red);
dot(C, 8bp+red);
dot(D, 8bp+red);
```
#figure(image("figures/asy-109.pdf"), caption: [asy-109])
#line()
#pagebreak()
```asymptote
size(6cm,0);
import roundedpath;

pair A=(0,0), B=(0,1), C=(1,0), D=(1,1);

draw(roundedpath(A--B--C--D, 0.5), 2bp+blue);
dot(A--B--C--D, 8bp+red);
```
#figure(image("figures/asy-110.pdf"), caption: [asy-110])
#line()
#pagebreak()
```asymptote
size(6cm,0);
pair A=(0,0), B=(0,1), C=(1,0), D=(1,1);

draw(A--B..C..D);
dot(A--B--C--D);
```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote
size(6cm,0);
pair A=(0,0), B=(0,1), C=(1,0), D=(1,1);

draw(A..B..C..D--cycle);
dot(A);dot(B);dot(C);dot(D);
```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote
size(6cm,0);
pair A=(0,0), B=(0,1), C=(1,0), D=(1,1);

draw(A---B..C..D);
dot(A);dot(B);dot(C);dot(D);
```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote
size(6cm,0);
import roundedpath;

draw(roundedpath(unitsquare,.4));
dot(roundedpath(unitsquare,.4),red);
draw(unitsquare);
dot(unitsquare);
```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote
size(0,0);

pair A=0, B=(6cm,0);

draw(A{N}..B);
dot(A{N}..B);
```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote
size(0,0);

pair A=0, B=(6cm,0);

draw(A{N}..B{E});
dot(A{N}..B{E});
```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote
size(0,0);

pair A=0, B=(6cm,0);

draw(A{dir(90)}..B{dir(0)});
dot(A{dir(90)}..B{dir(0)});
```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote
size(0,0);

pair A=0, B=(6cm,0);

draw(A{dir(90)}..B{dir(180)});
dot(A{dir(90)}..B{dir(180)});
```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote
size(0,0);

pair A=0, B=(6cm,0);

draw(A{N}..B{N});
dot(A{N}..B{N});
```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote
size(0,0);

pair A=0, B=(6cm,0);

draw(A{N}..B{N}..cycle);
dot(A{N}..B{N}..cycle);
```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote
//From documentation of Asymptote
size(0,6cm);
guide center = (0,1){W}..tension 0.8..(0,0){(1,-.5)}..tension 0.8..{W}(0,-1);

draw((0,1)..(-1,0)..(0,-1));
filldraw(center{E}..{N}(1,0)..{W}cycle);
unfill(circle((0,0.5),0.125));
fill(circle((0,-0.5),0.125));
```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote
size(8cm);
draw(unitcircle, linewidth(bp));
pen p;
for (int t=-88; t <= 88; t += 2) {
  if(t%5 == 0) {
    p=linewidth(bp);
    draw((0,1){dir (t-90)}..{dir (270-t)}(0,-1), linewidth(bp));
  } else p=currentpen;
  draw((Cos(t),Sin(t)){dir(180+t)}..{dir(180-t)}(-Cos(t),Sin(t)), p);
}
```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote
size(0,0);

pair A=0, B=(3cm,3cm), C=(6cm,0);

draw(A..B..C);
draw(A{curl 0}..B..{curl 0}C,red);
dot(A--B--C);
```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote
size(0,0);

pair A=0, B=(3cm, 3cm), C=(6cm, 0);

draw(A..B..C,linewidth(3mm));
draw(A{curl 1}..B..{curl 1}C,2mm+.8red);
dot(A--B--C);
```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote
size(0,0);

pair A=0, B=(3cm,4cm), C=(6cm,0);

draw(A..B..C);
draw(A{curl 0}..B..{curl 0}C,1mm+red+grey);
draw(A{curl 5}..B..{curl 0}C,1mm+green+grey);
draw(A{curl 10}..B..{curl 0}C,1mm+blue+grey);
draw(A{curl 10}..B..{curl 10}C,1mm+yellow+grey);
dot(A--B--C);
```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote
size(0,0);

pair A=0, B=(3cm,0.5cm), C=(6cm,0);

draw(A{N}..B{E}..C{S});
draw(A{N}::B{E}::C{S},red);
dot(A--B--C);
```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote
size(0,0);

pair A=0, B=(3cm,5cm), C=(6cm,0);
defaultpen(1mm);

draw(A..B..C);
draw(A.. tension .75 ..B.. tension .75 ..C,grey);
draw(A.. tension 1.5 ..B.. tension 1.5 ..C,.8red);
draw(A.. tension 2 ..B.. tension 2 ..C,green+grey);
draw(A.. tension 10 ..B.. tension 10 ..C,blue+grey);
dot(A--B--C,linewidth(6bp));
```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote
size(0,0);

pair A=0, B=(3cm,5cm), C=(6cm,0);
defaultpen(1mm);

draw(A..B..C);
draw(A.. tension 10 and 1 ..B.. tension 1 and 10 ..C,grey);
draw(A.. tension 1 and 10 ..B.. tension 10 and 1 ..C,.8red);
draw(A.. tension 2 and 1 ..B.. tension 1 and 2 ..C,blue+grey);
dot(A--B--C,linewidth(6bp));
```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote
size(0,0);

pair A=0, B=(3cm,5cm), C=(6cm,0);
defaultpen(1mm);

draw(A..B..C);
draw(A.. tension 5 and 3 ..B.. tension 1 and 5 ..C,grey);
draw(A.. tension 5 and 1 ..B.. tension 3 and 5 ..C,.8red);
dot(A--B--C,linewidth(6bp));
```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote
size(0,0);

pair A=0, B=(3cm,5cm), C=(6cm,0);

pair ctrl_rgt_A, ctrl_lft_B, ctrl_rgt_B, ctrl_lft_C;
ctrl_rgt_A=A+2cm*E;
ctrl_lft_B=B+3cm*W;
ctrl_rgt_B=B+3cm*E;
ctrl_lft_C=C+2cm*W;

draw(A..B..C);
draw(A.. controls ctrl_rgt_A and ctrl_lft_B ..B.. controls ctrl_rgt_B and ctrl_lft_C ..C,1mm+grey);
dot(A--B--C,linewidth(6bp));
draw((A--ctrl_rgt_A),Arrow, p=grey);
draw((B--ctrl_rgt_B),Arrow, p=grey);
draw((B--ctrl_lft_B),Arrow, p=grey);
draw((C--ctrl_lft_C),Arrow, p=grey);
```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote
size(0,0);

pair A=0, B=(3cm,5cm), C=(6cm,0);

pair ctrl_rgt_A, ctrl_lft_B, ctrl_rgt_B, ctrl_lft_C;
ctrl_rgt_A=A+2cm*NE;
ctrl_lft_B=B+5cm*SW;
ctrl_rgt_B=B+2cm*SE;
ctrl_lft_C=C+5cm*NW;

draw(A..B..C);
draw(A.. controls ctrl_rgt_A and ctrl_lft_B ..B.. controls ctrl_rgt_B and ctrl_lft_C ..C,1mm+grey);
dot(A--B--C,linewidth(6bp));
draw((A--ctrl_rgt_A),Arrow, p=grey);
draw((B--ctrl_rgt_B),Arrow, p=grey);
draw((B--ctrl_lft_B),Arrow, p=grey);
draw((C--ctrl_lft_C),Arrow, p=grey);
```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote
size(8cm);
path p1 = (0,0){up}..(5,4)..(10,0){down};

pair post0=postcontrol(p1,0);
pair pre1=precontrol(p1,1);
pair post1=postcontrol(p1,1);
pair pre2=precontrol(p1,2);

dot(post0^^pre1^^post1^^pre2);
path p2 = (0,0)..controls post0 and pre1..(5,4)..controls post1 and pre2..(10,0);

draw(p1,2mm+red);
draw(p2,linewidth(1mm));
```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote
size(0,0);

path pt1=scale(4cm)*unitcircle;
path pt2=scale(2cm)*unitcircle;

draw(pt1^^pt2);
dot(pt1^^pt2);
```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote
size(0,0);

path cle=scale(4cm)*unitcircle;

draw(cle);

for(real i=0; i<=length(cle); i+=.2)
  {
    dot(point(cle,i));
    draw((0,0)--point(cle,i),dotted);
  }
```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote
size(0,0);

path cle=scale(4cm)*unitcircle;

draw(cle);

for(real i=0; i<=length(cle); i+=.2)
  draw(point(cle,i)--2cm*dir(cle,i)+point(cle,i),Arrow,p=i/length(cle)*red);
```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote
size(0,0);

path cle=scale(4cm)*reverse(unitcircle);

draw(cle);

for(real i=0; i<=length(cle); i+=.2)
  draw(point(cle,i)--2cm*dir(cle,i)+point(cle,i),Arrow,p=i/length(cle)*red);
```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote
size(8cm,0);
pair O=(0,0);
path p=(0,0){dir(0)}..{dir(45)}(2,2){dir(-45)}..{dir(0)}(4,0);

pair En1=dir(p, 1, -1);
pair En2=dir(p, 2, -1);
draw(p);
draw(Label("dir(p,1,-1)", EndPoint), point(p,1)--point(p,1)+En1, red, Arrow);
draw(Label("dir(p,2,-1)", EndPoint), point(p,2)--point(p,2)+En2, red, Arrow);

pair Ep0=dir(p, 0, 1);
pair Ep1=dir(p, 1, 1);
draw(Label("dir(p,0,1)", EndPoint), point(p,0)--point(p,0)+Ep0, blue, Arrow);
draw(Label("dir(p,1,1)", EndPoint, E), point(p,1)--point(p,1)+Ep1, blue, Arrow);

draw(p, dot);
```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote
size(0,0);

path cle=scale(4cm)*reverse(unitcircle);

draw(cle);

for(real i=0; i<=length(cle); i+=.2)
  draw(point(cle,i)--(1cm*I*dir(cle,i))+point(cle,i),Arrow,p=i/length(cle)*red);
```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote
size(6cm,0);

path cle=scale(2)*unitcircle;

radialshade(scale(2)*cle, white, (0,0), 2, yellow, (0,0), 4);
radialshade(cle, white, (1,.5), 0, 0.8*blue, (0,0), 2);

for(real i=0; i<=length(cle); i+=.2)
  draw(point(cle,i)--(-2*I*dir(cle,i)+point(cle,i)),p=2mm+yellow+linecap(0));
```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote
size(6cm,0);

path curv=reverse((0,2){dir(-60)}..(1,0)..{dir(60)}(2,2));

draw(curv);

for(real i=0; i<=length(curv); i+=.1)
  draw(point(curv,i)--dir(curv,i)+point(curv,i),grey);
```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote
size(10cm,0);

path curv=reverse((0,2){dir(10)}..(1,0)..{dir(-50)}(3,2));
guide dirc;

draw(curv,linewidth(1mm)+grey);

for(real i=0; i<=length(curv); i+=.005)
  {
    draw(point(curv,i)--dir(curv,i)+point(curv,i),grey+yellow);
    dirc=dirc..dir(curv,i)+point(curv,i);
  }

draw(dirc,grey);
```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote
// Author: John Bowman
pair[] z=new pair[10];
z[0]=(0,100); z[1]=(50,0); z[2]=(180,0);
for(int n=3; n <= 9; ++n)
  z[n]=z[n-3]+(200,0);
path p=z[0]..z[1]---z[2]---z[3]
&z[3]..z[4]--z[5]::{up}z[6]
&z[6]::z[7]---z[8]..{up}z[9];
defaultpen(linewidth(1));
draw(p, grey);
dot(p);

real len=50;
for(int i = 0; i < z.length; ++i) {
  pair z=point(p,i);
  draw(z--z+len*dir(p,i,-1),red);
  draw(z--z+len*dir(p,i,1),blue+dashed);
  draw(z-len*dir(p,i)--z+len*dir(p,i),green+Dotted(defaultpen()));
}
```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote
size(10cm,0);
import math;

path cle=unitcircle;
path curv=reverse((1.5,2){dir(-60)}..(2.5,0)..{dir(60)}(3.5,2));

draw(cle);
draw(curv);

pair pt_cle=point(cle, 1.35);
pair pt_dir_cle=dir(cle, 1.35);

drawline((pt_cle - pt_dir_cle), (pt_cle + pt_dir_cle), red);

pair pt_curv=point(curv, dirtime(curv, pt_dir_cle));

drawline((pt_curv - pt_dir_cle), (pt_curv + pt_dir_cle), blue);
```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote
size(0,0);

pair O=(2cm,2cm);
path cle=shift(O)*scale(2cm)*unitcircle;
pair M=point(cle,.6);

dot("$O$",O,SW);
dot("$M$",M,unit(M-O));

draw(cle);
draw((0,0)--(0,4cm),Arrow);
draw((0,0)--(4cm,0),Arrow);

draw(Label("$X_M$",position=EndPoint),M--(xpart(M),0),dotted);
draw(Label("$Y_M$",position=EndPoint),M--(0,ypart(M)),dotted);
```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote
size(0,0);

path p= scale(3cm)*unitcircle;

draw(p,red+1mm);
draw(shift(1mm,2mm)*p);
draw(shift(2*(1mm,2mm))*p);
draw(shift(3*(1mm,2mm))*p);
draw(shift(4*(1mm,2mm))*p);
draw(shift(5*(1mm,2mm))*p);
```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote
size(0,0);

path p= (5mm,-5mm){right} .. (4cm,0);

for(int i=10; i<360; i+=10)
  draw(rotate(i)*p);

draw(p,red+1mm);
```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote
size(6cm,0);

path p= (1,-1){right} .. (4,0);
pair O=(3,.25);

for(int i=10; i<360; i+=10)
  draw(rotate(i,O)*p);

dot(O,blue);
draw(p,red+1mm);
```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote
size(8cm,0);

path curv=(0,0)..(1,1)..(1.5,-1)..(3,0);
pair A=(0,-1), B=(3,.75);

defaultpen(1mm);
draw(curv);
draw(reflect(A,B)*curv,.8red);
draw(A--B,grey);
```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote
size(6cm,0);

path cle=unitcircle;

draw(cle,red);
draw(xscale(2)*cle);
draw(yscale(2)*cle);
draw(scale(2)*cle,blue);
```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote
size(8cm,0);

transform scale(pair center, real k)
{
  return shift(center)*scale(k)*shift(-center);
}

path cle=unitcircle;
pair A=(4,0);
draw(cle);

draw(scale(A,.5)*cle,red);
draw(scale(A,-.75)*cle,blue);

for (real t; t<length(cle); t+=1)
  draw(point(cle,t)--point(scale(A,-.75)*cle,t),dotted);

dot("$A$",A,N);
```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote
size(0,0);

pair inversion(pair O, real k, pair M)
{
  return (O + k*unit(M-O)/abs(M-O));
}

guide inversion(pair O, real k, path M)
{
  guide opath=inversion(O,k,point(M,0));
  for (real i=0; i<=length(M); i+=length(M)/100)
    opath = opath .. inversion(O,k,point(M,i));
  return opath .. cycle;
}

real u=10cm;
path [] p;
path A = scale(u)*unitcircle;
path B = scale(3)*A;
pair z = rotate(10)*(5u,0);


draw(inversion( z, 2*u^2, A ),linewidth(1pt));
draw(inversion( z, 2*u^2, B ),linewidth(1pt));

p[0] = shift(2u,0)*scale(u)*unitcircle;

for (int i=0; i<=5; ++i)
  {
    if (i!=0) p[i] = rotate(360/6)*p[i-1];
    draw(inversion( z, 2 (u^2), p[i] ));
  }
```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote
size(10cm,0);

path unitpolygon(int n)
{
  guide opath;
  for (int i=1; i<=n; ++i)
    opath=opath--rotate((i-1)*360/n)*E;
  return opath--cycle;
}

for (int i=3; i<9; ++i)
  draw(shift(2.5*(i%3),-2.5*quotient(i,3))*unitpolygon(i));
```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote
size(0,0);

pair [] P, Q, R, S;
real u=1cm;

for (int i=0; i<=4; ++i)
  P[i] = rotate(i*360/5)*(0,-u);

P[5] = P[0];
for (int i=0; i<=4; ++i)
  Q[i] = 3*midpoint(P[i]--P[i+1]);

Q[5] = Q[0];
for (int i=0; i<=4; ++i)
  R[i] = 1/3*( Q[i] + Q[i+1] + P[i+1] );

R[5] = R[0];
for (int i=0; i<=5; ++i)
  S[i] = 1.5*Q[i];

for (int i=0; i<=4; ++i)
  {
    draw(P[i]   -- P[i+1]);
    draw(P[i+1] -- R[i]);
    draw(Q[i]   -- R[i]);
    draw(R[i]   -- Q[i+1]);
    draw(Q[i]   -- S[i]);
    draw(S[i]   -- S[i+1]);
    label(format("\small$P_%i$",i),P[i],-unit(P[i]));
    label(format("\small$Q_%i$",i),Q[i],rotate(60)*unit(Q[i]));
    label(format("\small$R_%i$",i),R[i],unit(R[i]));
    label(format("\small$S_%i$",i),S[i],unit(S[i]));
  }
```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote
size(0,0);

pair [] P, Q, R, S;
real u=2cm;

for (int i=0; i<=4; ++i)
  P[i] = rotate(i*360/5)*(0,-u);

P[5] = P[0];
for (int i=0; i<=4; ++i)
  Q[i] = 3*midpoint(P[i]--P[i+1]);

Q[5] = Q[0];
for (int i=0; i<=4; ++i)
  R[i] = 1/3*( Q[i] + Q[i+1] + P[i+1] );

R[5] = R[0];
for (int i=0; i<=5; ++i)
  S[i] = 1.5*Q[i];

for (int i=0; i<=4; ++i)
  {
    draw(P[i]   -- P[i+1]);
    draw(P[i+1] -- R[i]);
    draw(Q[i]   -- R[i]);
    draw(R[i]   -- Q[i+1]);
    draw(Q[i]   -- S[i]);
    draw(S[i]   -- S[i+1]);
  }

draw(P[2] -- P[3] -- P[4] -- P[0] -- P[1] --
     R[0] -- Q[0] -- R[4] -- Q[4] -- R[3]
     -- Q[3] -- R[2] -- Q[2] --
     S[2] -- S[3] -- S[4] -- S[0] -- S[1] --
     Q[1] -- R[1] -- cycle,
     linewidth(2bp));
```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote
size(0,0);

pair [] P, Q, R, S;
real u=2cm;

for (int i=0; i<=4; ++i)
  P[i] = rotate(i*360/5)*(0,-u);

P[5] = P[0];
for (int i=0; i<=4; ++i)
  Q[i] = 3*midpoint(P[i]--P[i+1]);

Q[5] = Q[0];
for (int i=0; i<=4; ++i)
  R[i] = 1/3*( Q[i] + Q[i+1] + P[i+1] );

R[5] = R[0];
for (int i=0; i<=5; ++i)
  S[i] = 1.5*Q[i];

fill(shift(-abs(S[0]),-abs(S[0]))*scale(2*abs(S[0]))*unitsquare,.2grey);

radialshade(scale(abs(S[0]))*unitcircle,lightgrey,(0,0),abs(S[0]),
            black,(0,0),abs(.85*midpoint(S[0]--S[1])));

P[6]=P[1];
for (int i=0; i<=4; ++i)
  {
    radialshade(S[i]--Q[i]--R[i]--Q[i+1]--S[i+1]--cycle,
                lightgrey,(0,0),abs(R[i]),
                black,(0,0),abs(S[i]));
    radialshade(R[i]--Q[i+1]--R[i+1]--P[i+2]--P[i+1]--cycle,
                .8red,(0,0),sqrt(1-(2-2cos(pi/5))/4)*u,
                black,(0,0),abs(Q[i+1]));
  }

for (real i=1; i>0; i-=.05)
  fill(rotate(90*(1-i))*scale(i)*(P[0]--P[1]--P[2]--P[3]--P[4]--cycle),
       (1-i)*red);

pen p=linewidth(1pt);
for (int i=0; i<=4; ++i)
  {
    draw(P[i]   -- P[i+1],p);
    draw(P[i+1] -- R[i],p);
    draw(Q[i]   -- R[i],p);
    draw(R[i]   -- Q[i+1],p);
    draw(Q[i]   -- S[i],p);
    draw(S[i]   -- S[i+1],p);
  }

shipout(bbox(0,black+4mm));
```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote
size(0,0);

label(graphic("dali.eps","width=10cm"));
layer();

draw(scale(2cm)*unitcircle,linewidth(.75mm));
shipout(bbox(0.25cm,Fill));
```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote
size(0,0);

label(graphic("dali.eps","width=10cm, bb=60 60 235 205, clip=true"));
shipout(bbox(0.25cm,Fill));
```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote
size(0,6cm);

texpreamble("\usepackage{amsmath}
             \DeclareMathOperator{\e}{e}");

pair A=2*expi(pi/3);

draw((0,-2)--(0,2.5));
draw((0,0)--(1,0),linewidth(1mm),Arrow(2mm));
draw((0,0)--(3.5,0));
draw((0,0)--(0,1),linewidth(1mm),Arrow(2mm));

dot(Label("$A(z_a=2\e^{i\frac{\pi}{3}})$"),A,NE);
label(format("$\vert z_a\vert=%.1f$",length(A)),(.5,-1),E);
label(format("$\arg(z_a)\simeq%.4f$",angle(A)),(.5,-2),E);
```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote
size(10cm,0);

texpreamble("\usepackage{amsmath}
             \DeclareMathOperator{\e}{e}");

pair A=2*expi(pi/3);
pair B=expi(pi/6);
pair C=A*B;
pair D=C-B;
pair Bp=2*B;
pair E=I*D;

draw((0,-2)--(0,2.5));
draw((0,0)--(1,0),linewidth(1mm),Arrow(2mm));
draw((-3,0)--(3.5,0));
draw((0,0)--(0,1),linewidth(1mm),Arrow(2mm));

dot(Label("$A(z_a=2\e^{i\frac{\pi}{3}})$"),A);
dot(Label("$B(z_a=\e^{i\frac{\pi}{6}})$"),B);
dot(Label("$B'(z_{b'}=2z_b)$"),Bp);
dot(Label("$\overline{A}(\overline{z_a})$"),conj(A));
dot(Label("$C(z_c=z_a z_c)$"),C,NE);
dot(Label("$D(z_d=z_c-z_d)$"),D,NW);
dot(Label("$E(z_e=iz_d)$"),E,NW);
```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote
size(6cm,0);

pair A=2expi(pi/2);

pair homography(pair z)
{
  return (z^2+A)/(z+2);
}

guide image;
pair tpt;

draw(unitcircle);
for(real t=0; t<length(unitcircle);t+=.05)
  {
    tpt=homography(point(unitcircle,t));
    image=image..tpt;
    draw(point(unitcircle,t)--tpt,dotted);
  }
draw(image..cycle,red);
```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote
size(6cm,0);

path apath=(0,0)..(1,1)..(2,-1){dir(-90)};

draw(apath);

dot(apath);
dot(point(apath,length(apath)),.8green+8pt);
draw(point(apath,0)--point(apath,1)--point(apath,2),.8red);
draw(point(apath,0.5)--point(apath,1.5)--point(apath,2.5),.8blue);
```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote
size(8cm,0);

path apath=(0,0)..(1,1)..(2,.5){dir(0)};

draw(subpath(apath,0,length(apath)/2),1pt+.8red,EndPenMargin);
draw(subpath(apath,length(apath)/2,length(apath)),1pt+.8blue,BeginPenMargin);
```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote
size(10cm,0);
texpreamble("\usepackage{amsmath}");

path p = (0,0)..(1,1)..(2,.5){dir(0)};
real al    = arclength(p);
real l     = length(p);
pair pt    = point(p,l/2);
pair apt   = arcpoint(p,al/2);

draw(p);
draw(subpath(p,0,arctime(p,al/2)),blue);
dot(pt,red);
dot(apt,blue);

arrow("$\frac{\text{lenght(p)}}{2}$",pt,SSE,1cm);
arrow("$\frac{\text{arclenght(p)}}{2}$",apt,SSW,1cm);
label("\small The sizes of the blue path and the black path are equal",(1,.25));
```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote
size(10cm,0);

path apath=(0,0)..(1,1)..(2,.5){dir(0)};
real l=length(apath);
real step=l/15;

for(real i=0; i<l-step; i+=step)
  draw(subpath(apath,i,i+step),4bp+(i/l*red+(l-i)/l*blue),PenMargins);
draw(apath);
```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote
size(10cm,0);

path apath=(0,0)..(1,1)..(2,.5){dir(0)};
real l=arclength(apath);
real step=l/15;

path arcpath(path apath, real t1, real t2)
{
  return subpath(apath, arctime(apath,t1), arctime(apath,t2));
}

for(real i=0; i<l-step; i+=step)
  draw(arcpath(apath,i,i+step),4bp+(i/l*red+(l-i)/l*blue),PenMargins);
draw(apath);
```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote
unitsize(5cm);

string text="A text along a curve";
path p=(0,0)..(1,1)..(2,0.5){dir(0)};
int n=length(text);
real at=0;
real step=arclength(p)/n;

for (int i=0; i<n; ++i){
  real t=arctime(p,at);
  label(rotate(degrees(angle(dir(p,t),false)))*scale(3)*baseline(substr(text,i,1)),point(p,t));
  at += step;
 }

draw(p,lightgrey);
```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote
import labelpath;

unitsize(5cm);
string text="\Huge A text along a curve";
path p=(0,0)..(1,1)..(2,0.5){dir(0)};

labelpath(text,p);
draw(p, lightgrey);
```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote
size(6cm,0);

path pth1=(0,-0.5)--(2,1);
path pth2=(0,0.5)--(2,-1);

draw(pth1^^pth2);

dot(intersectionpoint(pth1,pth2),red);
```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote
size(6cm,0);

path p = (0,0){up} .. (2cm,0){up};
path q = (0,1cm){dir(-60)}..(1cm,-1cm)..{dir(60)}(2cm,1cm);

draw(p^^q);
dot(intersectionpoint(p,q) , red);
dot(intersectionpoint(p,reverse(q)) , blue);
```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote
size(6cm,0);
import math;

pair A=(0,-.5), B=A+dir(45);
pair C=(0,1), D=C+5dir(20);

pair I=extension(A,B,C,D);

path AB=A--B;
path CD=C--D;

draw(AB^^CD);
dot("$I$",I,N,red);
draw(B--I,1pt+dotted);
dot("$A$",A,SE);
dot("$B$",B,SE);
dot("$C$",C,N);
dot("$D$",D,N);
```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote
size(6cm,0);
import math;

pair A=(0,-.5), B=A+dir(45);
pair C=(0,1)+2dir(20);
path cle=shift(C)*scale(1)*unitcircle;

pair I1=intersectionpoint(A--interp(A,B,2),cle);
pair I2=intersectionpoint(A--interp(A,B,10),cle);

path AB=A--B;

draw(AB^^cle);
dot(I1^^I2,red);
draw(B--I2,1pt+dotted);
```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote
size(6cm,0);

path Line(pair A, pair B)
{
  return interp(A,B,-100000/arclength(A--B))--interp(A,B,100000/arclength(A--B));
}

path Parallel(pair A, pair dir)
{
  return Line(A,A+dir);
}

pair A=0, B=(1,0), C=(.7,.7);
draw(A--B, .8red);
draw(A--C, .8green);
draw(B--C, .8blue);

label("$A$",A,SW);
label("$B$",B,SE);
label("$C$",C,N);

pair Ap=intersectionpoint(Parallel(B, A-C), Parallel(C, A-B));
pair Bp=intersectionpoint(Parallel(A, B-C), Parallel(C, A-B));
pair Cp=intersectionpoint(Parallel(A, B-C), Parallel(B, A-C));

draw(Ap--Bp, .8red);
draw(Ap--Cp, .8green);
draw(Bp--Cp, .8blue);

label("$A'$",Ap,NE);
label("$B'$",Bp,NW);
label("$C'$",Cp,S);
```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote
size(6cm,0);

path p = (0,0){up} .. (2cm,0){up};
path q = (0,1cm){dir(-60)}..(1cm,-1cm)..{dir(60)}(2cm,1cm);

draw(p, red);
draw(q, blue);
dot(intersectionpoint(p,q));
draw(point(p, intersect(p,q)[0])--postcontrol(p, intersect(p,q)[0]), .8red,Arrow);
draw(point(q, intersect(p,q)[1])--postcontrol(q, intersect(p,q)[1]), .8blue,Arrow);
```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote
import graph;
size(8cm,0);

path a = polargraph(new real(real t){return t;}, 0, 3pi, operator ..);
path b = polargraph(new real(real t){return 2t;}, 0, 3.75pi, operator ..);

real sharp=40;
path c=relpoint(a,1){relpoint(a,1)-postcontrol(a,length(a)-1)}..{dir(sharp)}relpoint(b,1);

fill(a..c..reverse(b)&cycle,0.8*red);
shipout(bbox(2mm, Fill(0.15*blue)));
```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote
size(6cm,0);

import math;

pair A=(0,0), B=(1,.5);
path cle=shift(1.75,2.5)*unitcircle;
pair pt, ptp;

pair project(pair pt, pair A, pair B)
  {
    return extension(pt,pt-dir(90+degrees(A-B,false)),A,B);
  }

draw(A--B);
draw(cle);

for (real t=0; t<=4; t+=.01)
  {
    pt=point(cle,t);
    ptp=project(pt,A,B);
    dot(ptp, red);
    draw(pt--ptp,dotted);

  }
```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote
size(6cm,0);

import math;

pair A=(0,0), B=(1,.5), C=(.25,1);

pair project(pair pt, pair A, pair B)
  {
    return extension(pt,pt-dir(90+degrees(A-B,false)),A,B);
  }

pair ocenter(pair A, pair B, pair C)
  {
    return extension(A, project(A,B,C), B, project(B,A,C));
  }

draw(A--B--C--cycle);

pair orth=ocenter(A,B,C);
pair Ap=project(A,B,C);
pair Bp=project(B,A,C);
pair Cp=project(C,A,B);

dot(orth, red);
dot(Ap^^Bp^^Cp);
drawline(A, orth, dotted);
drawline(B, orth, dotted);
drawline(C, orth, dotted);
```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote
size(6cm,0);

import math;

pair A=(0,0), B=(1,.5), C=(.25,1);

pair ccenter(pair A, pair B, pair C)
  {
    pair mAB=midpoint(A--B);
    pair mAC=midpoint(A--C);
    return extension(mAB, rotate(90,mAB)*A, mAC, rotate(90,mAC)*A);
  }

draw(A--B--C--cycle);

pair circ=ccenter(A,B,C);
pair mAB=midpoint(A--B);
pair mAC=midpoint(A--C);
pair mBC=midpoint(B--C);

dot(circ, red);
dot(mAB^^mAC^^mBC);
drawline(mAB, circ, dotted);
drawline(mAC, circ, dotted);
drawline(mBC, circ, dotted);
draw(shift(circ)*scale(abs(circ-A))*unitcircle);
```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote
size(6cm,0);

import math;

pair A=(0,0), B=(1,.5), C=(.25,1);

pair project(pair pt, pair A, pair B)
  {
    return extension(pt,pt-dir(90+degrees(A-B,false)),A,B);
  }

pair icenter(pair A, pair B, pair C)
  {
    return extension(A, A+dir(A--B,A--C), B, B+dir(B--A,B--C));
  }

draw(A--B--C--cycle);

pair ins=icenter(A,B,C);
pair iAB=project(ins,A,B);
pair iAC=project(ins,A,C);
pair iBC=project(ins,B,C);

dot(ins, red);
dot(iAB^^iAC^^iBC);
drawline(A, ins, dotted);
drawline(B, ins, dotted);
drawline(C, ins, dotted);
draw(shift(ins)*scale(abs(ins-iAB))*unitcircle);
```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote
size(6cm,0);
import math;

pair project(pair pt, pair A, pair B)
  {
    return extension(pt,pt-dir(90+degrees(A-B,false)),A,B);
  }


pair ecenter(pair A, pair B, pair C)
  {
    return extension(A, A+rotate(90)*dir(A--B,A--C), B, B+rotate(90)*dir(B--A,B--C));
  }

path ecircle(pair A, pair B, pair C)
  {
    return shift(ecenter(A,B,C))*scale(abs(ecenter(A,B,C)-project(ecenter(A,B,C),B,C)))*unitcircle;
  }

pair A=(0,0), B=(3,0), C=(3,4);
path tr=A--B--C--cycle;

draw(ecircle(A,B,C));
draw(ecircle(B,C,A));

pen p=linewidth(1pt);
drawline(A,B, p);
drawline(A,C, p);
drawline(B,C, p);
```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote
size(6cm,0);
defaultpen(2mm+linecap(0));

path p = (0,0){up} .. (2cm,0){up};
path q = (0,1cm){dir(-60)}..(1cm,-1cm)..{dir(60)}(2cm,1cm);


draw(firstcut(p,q).before, .8red);
draw(firstcut(p,q).after, .8blue);

draw(lastcut(q,p).before, .8green);
draw(lastcut(q,p).after, .8yellow);
```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote
size(6cm,0);

defaultpen(2mm+linecap(0));

path p = (0,0){up} .. (2cm,0){up};
path q = (0,1cm){dir(-60)}..(1cm,-1cm)..{dir(60)}(2cm,1cm);

real[] ipq=intersect(p,q);
real[] iprq=intersect(p,reverse(q));

draw(subpath(p, 0, ipq[0]), .8red);
draw(subpath(p, ipq[0], iprq[0]), .5red);
draw(subpath(p, iprq[0], length(p)), .3red);

draw(subpath(reverse(q), 0, iprq[1]), .8green);
draw(subpath(reverse(q), iprq[1], length(q)-ipq[1]), 0.5green);
draw(subpath(reverse(q), length(q)-ipq[1], length(q)), 0.3green);
```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote
size(0,0);

defaultpen(linewidth(1bp));
real u=4cm;
pair A, B, C, D, E;
path p, q, r;

A = u*up;
p = interp(A, rotate(72)*A, -.2) -- interp(A, rotate(72)*A,1.2);
for(int i=0; i<=5; ++i)
  draw(rotate(72i)*p);

B = midpoint(A--rotate(72)*A );
C = .8*B;

p = B --- C .. (rotate(2*72)*C){right};
// On allonge le chemin p
p = (point(p,0) - 4mm*dir(p,0.001))
  --
  point(p,0)
  & p &
  point(p,2)
  --
  (point(p,2) + 4mm*dir(p,2));

E = intersectionpoint(p, rotate(72)*p);
q = firstcut(p,shift(E)*scale(2mm)*unitcircle).before;
r = lastcut(p,shift(E)*scale(2mm)*unitcircle).after;

for(int i=0; i<=4; ++i)
  {
    draw(rotate(72i)*q);
    draw( rotate(72i)*r);
    draw(rotate(72i)*A,linewidth(4bp));
    draw(rotate(72i)*B,linewidth(4bp));
    draw(rotate(72i)*C,linewidth(4bp));
  }
```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote
// Venn diagram // Diagramme de Venn
// Edwards' construction // Construction d'Edwards
import roundedpath;
size(14cm,0);

path [] EdVenn(int n)
{
  path [] opath;
  if (n>=1)
    opath.push(shift(-1.4,-.9)*roundedpath(xscale(2.8)*yscale(.9)*unitsquare,.1));
  if (n>=2)
    opath.push(shift(0,-.9)*roundedpath(xscale(1.4)*yscale(1.8)*unitsquare,.1));
  if (n>=3)
    opath.push(scale(.5)*unitcircle);
  for (int i=1; i<=n-3; ++i)
    {
      pair pcle=point(opath[2],1/(2^i)),
        ccle=intersectionpoint(pcle--(pcle-dir(opath[2],1/(2^i))), (0,0)--(1,0));
      path cle=shift(ccle)*scale(abs(pcle-ccle))*unitcircle;
      real[] p1=intersect(cle, opath[2]);
      path ocle=subpath(cle,-p1[0],p1[0]);
      guide tpath;
      real step=360/(2^i), a=0;
      for (int j=0; j<2^i; ++j)
        {
          tpath=tpath..rotate(a)*ocle;
          a+=step;
        }
      opath.push(tpath..cycle);
    }
    return opath;
}

draw(EdVenn(6));
```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote
size(15cm,0);

srand(rand());
path p1 = randompath(9);
path p2 = randompath(8);
real Minx=min(min(p1).x,min(p2).x);
real Maxx=max(max(p1).x,max(p2).x);
real Miny=min(min(p1).y,min(p2).y);

pair[] inter=intersectionpoints(p1,p2);
int nb=inter.length;
for (int i=0 ; i<nb; ++i)
  {
    dot(inter[i]);
    label("$" + (string) i +"$", inter[i],N);
  }

draw(p1,.8red);
draw(p2,.8green);
label("I found " + (string) nb + " points of intersection.",((Maxx+Minx)/2,Miny),2S);
```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote
size(10cm,0);

pair[] self_intersection(path p, int n=100)
{
  pair[] rpair=new pair[];
  path tpath;
  real [] tpoint;
  real l=length(p);
  int i=1;
  for (real t1=0; t1<l ; t1+=l/n)
    {
      for (real t2=t1+2*l/n; t2<l; t2+=l/n)
        {
          tpoint=intersect(subpath(p,t1,t1+l/n),
                           subpath(p,t2,t2+l/n));
          if (tpoint.length == 2)
            {
              rpair[i]=point(subpath(p,t1,t1+l/n),tpoint[0]);
              ++i;
            }
        }
    }
  return rpair;
}

void dott(pair[] pt, pen p)
{
  for (int i=1 ; i<pt.length; ++i)
    {
      dot(pt[i], p);
    }
}

srand(rand());
path p = randompath(15);

pair[] inter=self_intersection(p);
dott(inter, .8red);
draw(p);
```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote
size(6cm,0);
path [] c;

c[1] = xscale(2)*unitcircle;
c[2] = shift((0,1))*c[1];
draw(c[1]^^c[2]);
draw(buildcycle(c[1],c[2]), .8red+4bp);
```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote
size(8cm,0);

path a,b,c,d;
a = (-1,-.2){up} .. tension 1.2 .. (1,-.2){down};
transform r90=rotate(90);
b = r90*a;
c = r90*b;
d = r90*c;
path bound=buildcycle(a,b,c,d);
fill(bound, lightgrey);
draw(a^^b^^c^^d,grey);
draw(bound);
```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote
size(8cm,0);

path a,b,c;
a = shift(1,0)*scale(2)*unitcircle;
b = rotate(120)*a;
c = rotate(120)*b;

fill(a, red);
fill(b, green);
fill(c, blue);
fill(buildcycle(a,b), red + green);
fill(buildcycle(b,c), green + blue);
fill(buildcycle(c,a), blue + red);
fill(buildcycle(a,b,c), white);

draw(a^^b^^c);
```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote
size(0,0);

path pt1=scale(2cm)*unitcircle;
path pt2=scale(1cm)*unitcircle;

filldraw(pt1^^pt2,yellow+.9white);
```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote
size(0,0);

path pt1=scale(2cm)*unitcircle;
path pt2=scale(1cm)*unitcircle;

filldraw(pt1^^pt2,evenodd+yellow+0.9white);
```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote
size(0,0);

path pt1=scale(2cm)*unitcircle;
path pt2=scale(1cm)*unitcircle;
path pt3=shift(0,.5cm)*pt2;

filldraw(pt1^^pt2^^pt3,evenodd+yellow+.9white);
```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote
size(0,0);

path pt1=scale(2cm)*unitcircle;
path pt2=scale(1cm)*unitcircle;
path pt3=shift(0,1.5cm)*pt2;

filldraw(pt1^^pt2^^pt3,evenodd+yellow+.9white);
```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote
size(6cm);

void extra()
{
  label("Read the code to understand...",(0,0),white);
  plain.exitfunction();
}

atexit(extra);
fill(xscale(2)*unitcircle);
```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote
size(8cm,0);
import patterns;

add("hatchback",hatch(NW));
filldraw(xscale(2)*unitsquare,pattern("hatchback"));

add("r_hatchback",hatch(2.5mm,NW,.8red));
filldraw(shift(0,-2)*yscale(2)*unitsquare,pattern("r_hatchback"));

add("b_hatchback",hatch(NW,2.5mm+.8blue));
filldraw(shift(1,-2)*yscale(2)*unitsquare,pattern("b_hatchback"));
```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote
void enclose(picture pic=currentpicture, envelope e,
             Label[] L=new Label[],
             real xmargin=0, real ymargin=xmargin, pen p=currentpen,
             filltype filltype=NoFill, bool above=true)
{

  real H;
  real[] h;
  pic.add(new void (frame f, transform t) {
      frame[] d=new frame[];
      for (int i=0; i<L.length; ++i) {
        d[i]=newframe;
        Label LL=L[i].copy();
        add(d[i],t,LL);
        add(f,d[i]);
        h[i]=ypart(max(d[i])-min(d[i]));
        if(H < h[i]) H=h[i];
      }
      for (int i=0; i<L.length; ++i) {
        real emy=(H-h[i])/2;
        e(f,d[i],xmargin,ymargin+emy,p,filltype,above);
      }
    });
}

void box(picture pic=currentpicture, Label[] L=new Label[],
         real xmargin=0, real ymargin=xmargin, pen p=currentpen,
         filltype filltype=NoFill, bool above=true)
{
  enclose(pic,box,L,xmargin,ymargin,p,filltype,above);
}

box(new Label[] {
    Label("\begin{minipage}{3cm}Some text some text some text.\end{minipage}",(2.2cm,0)),
    Label("Hello.",0),
    Label("\begin{minipage}{3cm}Some text some text some
text some text some text some text some text.\end{minipage}",(5.4cm,0)),
    Label("Bye.\rule{0pt}{1.5cm}",(1cm,-3cm))
      });
```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote

```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote

```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote

```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote

```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote

```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote

```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote

```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote

```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote

```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote

```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote

```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote

```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote

```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
```asymptote

```
// #figure(image("figures/asy-.pdf"), caption: [asy-])
#line()
#pagebreak()
