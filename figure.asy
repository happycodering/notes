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

size(8cm,0);
pair A, B, C, D;
A=(0,0); B=(1,0);
C=(1,1); D=(0,1);
fill(A--C--B--D--cycle,grey);

