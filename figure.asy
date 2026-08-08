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

size(10cm,2.5cm);
pair A, B, C, D;
A=(0,0);
B=(2,0);
C=(4,0);
D=(4,2);
draw(A--B);
draw(C--D);
