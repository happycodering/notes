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
// texpreamble("\setmathfont[Path=../fonts/,Extension=.ttf,]{NotoSansMath-Regular}");
texpreamble("\setmathfont{Noto Sans Math}");

import x11colors;
