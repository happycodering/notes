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

defaultpen(fontsize(26pt));
dot(Label("$A$"),(0,0),NE, red+10bp);
dot(Label("$B$"),(2cm,0),NE+N, blue+10pt);
