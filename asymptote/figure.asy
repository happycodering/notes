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

size(6cm,0);
//Return Circle AB diameter
path circle(pair A, pair B)
{
  return shift(midpoint(A--B))*scale(abs(A-B)/2)*unitcircle;
}
pair A=(0,0), B=(1,0);
draw(circle(A,B));
dot(A--B);
