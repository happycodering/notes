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

size(8cm, 3cm);

path numberline = (0, 0)--(7.5, 0);

draw(numberline, Arrow);
label(shift(0,0.75cm)*"Number Line", midpoint(numberline));

for (int i = 0; i <= 7; ++i) {
  draw((i, -0.12)--(i, 0.12));
  label("$" + string(i) + "$", (i, -0.4));
}
