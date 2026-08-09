#set document(title: [Asymptote])
#set text(
  font: ("Noto Sans", "Noto Color Emoji"),
  size: 15pt,
)
#show math.equation: set text(font: "Noto Sans Math")

#show raw: set text(
  font: "Noto Sans Mono",
  // font: "Jetbrains Mono"
)
#set page(
  paper: "a4",
  margin: (left: 1cm, right: 1cm, top: 1.5cm, bottom: 1cm),
)
#set par(
  justify: true,
  leading: 1em,
)
#set heading(
  numbering: "1.1",
)
#show heading.where(level: 1): it => {
  v(2cm)
  text(size: 24pt, weight: "bold")[#it]
  v(1.5cm)
}
#show raw.where(block: true): block.with(
  fill: luma(95%),
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
#set line(length: 100%, stroke: 2pt + luma(70%))
#set raw(
  syntaxes: (
    "asy.sublime-syntax",
  ),
)
///////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////
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
          section.body
        } else {
          chapter.body
        }
      } else {
        if chapter != none {
          chapter.body
        } else {
          none
        }
      }
      text(size: 12pt)[
        #grid(
          columns: (1fr, 1fr),
          align(left)[#upper[#header-text]], page-number,
        )
      ]
    }
  },
)

///////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////

= Generalities
```asymptote
settings.tex = "lualatex";
settings.outformat = "pdf";
settings.prc = false;

texpreamble("
\usepackage{fontspec}
\usepackage{amsmath}
\usepackage{amsthm}
\usepackage{unicode-math}
\setmainfont{Noto Sans}
\setsansfont{Noto Sans}
\setmathfont[Path=fonts/,
Extension=.ttf,
]{NotoSansMath-Regular}
");

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
```asymptote
path line=(0,0)--(5cm,0);
draw(line,linewidth(5bp),Arrow);
draw(shift(0,-2cm)*line,linewidth(5bp),Arrow(30bp,10));
draw(shift(0,-5cm)*line,linewidth(30bp),Arrow(20bp,50));
draw(shift(0,-8cm)*line,linewidth(10bp),Arrow(20bp,50,filltype=NoFill));
```
#figure(image("figures/asy-42.pdf"), caption: [asy-42])
#line()
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
```asymptote
unitsize(8cm);
path g=(0,0)--(1,0);
draw(g,Arrow(Relative(0.45)));
add(arrow(g,Relative(0.55)));
```
#figure(image("figures/asy-44.pdf"), caption: [asy-44])
#line()
```asymptote
size(8cm,0);
path g = (0,0)--(1,0);
draw(g,Arrow(Relative(0.75)));
add(arrow(reverse(g), invisible, FillDraw(green,red), Relative(0.75)));
```
#figure(image("figures/asy-45.pdf"), caption: [asy-45])
#line()
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
```asymptote
size(6cm,0);
draw((-0.5,0)--(1,0));
draw((0,-0.5)--(0,1));
draw((0,0)--(0.75,0),linewidth(1mm),Arrow(3mm));
draw((0,0)--(0,0.75),linewidth(1mm),Arrow(3mm));
```
#figure(image("figures/asy-48.pdf"), caption: [asy-48])
#line()
```asymptote
fill((0,0)--(0,6cm)--(6cm,0)--cycle, gray);
```
#figure(image("figures/asy-49.pdf"), caption: [asy-49])
#line()
```asymptote
filldraw((0,0)--(0,6cm)--(6cm,0)--cycle,gray);
```
#figure(image("figures/asy-50.pdf"), caption: [asy-50])
#line()
```asymptote
filldraw((0,0)--(0,6cm)--(6cm,0)--cycle,
    fillpen=gray, drawpen=linewidth(1mm) + 0.8 * red);
```
#figure(image("figures/asy-51.pdf"), caption: [asy-51])
#line()
```asymptote
pen[][] p={{rgb(black)}, {rgb(.8red)}};
latticeshade((0,0)--(0,6cm)--(6cm,0)--cycle, p);
```
#figure(image("figures/asy-52.pdf"), caption: [asy-52])
#line()
```asymptote
pen[][] p={{rgb(black),rgb(black)}, {rgb(red),rgb(green)}};
latticeshade((0,0)--(0,6cm)--(6cm,0)--cycle,p);
```
#figure(image("figures/asy-53.pdf"), caption: [asy-53])
#line()
```asymptote
size(8cm,0);
pen[][] p={{rgb(white),rgb(grey),rgb(black)},
    {red,green,blue},
    {cyan,magenta,yellow}};
latticeshade(unitsquare,p);
```
#figure(image("figures/asy-54.pdf"), caption: [asy-54])
#line()
```asymptote
size(8cm,0);
import palette;
real[][] v={{1,2},{3,4}};
pen[] Palette=Rainbow();
latticeshade(box((0,0),(1,1)),palette(v,Palette));
```
#figure(image("figures/asy-55.pdf"), caption: [asy-55])
#line()
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
```asymptote
size(8cm,0);
pair A, B, C, D;
A=(0,0); B=(1,0);
C=(1,1); D=(0,1);
fill(A--C--B--D--cycle,grey);
```
#figure(image("figures/asy-60.pdf"), caption: [asy-60])
#line()

