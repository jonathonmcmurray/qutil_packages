\d .wapi

/* STRUCTS */

CONSOLE_SCREEN_BUFFER_INFO:(!/)flip(
    (`dwSize;               `COORD);
    (`dwCursorPosition;     `COORD);
    (`wAttributes;           `WORD);
    (`srWindow;        `SMALL_RECT);
    (`drMaximumWindowSize;  `COORD)
 );

COORD:(!/)flip(
    (`X;    `SHORT);
    (`Y;    `SHORT)
 );

SMALL_RECT:(!/)flip(
    (`LEFT;     `SHORT);
    (`TOP;      `SHORT);
    (`RIGHT;    `SHORT);
    (`BOTTOM;   `SHORT)
 );

/* PRIMITIVE DATATYPES */

SHORT:2#0x00
WORD:2#0x00

/* PUBLIC API */

raw:{{$[99=type x;.z.s'[x];-11=type x;.z.s .wapi x;x]}.wapi x}
alloc:{(raze/)@[x;where 99=type each x:raw x;value]}
struct:{[s;r]s:raw s;./[s;` vs' raze {$[99=type y;` sv'x,/:key y;x]}'[key s;s];:;2 cut r]}
toint:{0b sv raze 0b vs'reverse x}
allint:{$[4=type x;.wapi.toint x;.z.s'[x]]}

\d .