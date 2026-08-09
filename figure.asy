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


