\d .con

getmaxsize:{[]
  cb:.wapi.alloc `CONSOLE_SCREEN_BUFFER_INFO;
   h:.ffi.cf[("j";`kernel32`GetStdHandle)](-11h;(::));
   r:.ffi.cf[("i";`kernel32`GetConsoleScreenBufferInfo)](h;cb);
   if[r=0;'"GetConsoleScreenBufferInfo failed"];
   cb:.wapi.allint .wapi.struct[`CONSOLE_SCREEN_BUFFER_INFO;cb];
   :1+(-).'cb[`srWindow](`BOTTOM`TOP;`RIGHT`LEFT);
 }

// resize to full window size, output new size
size:{[]
  system"c "," "sv string getmaxsize[];
  .lg.i "Setting console size to "," "sv string system"c";
 }

// auto-resize to full size, no output
size[];

// full width, specified height
wide:{[lines]
  if[null lines;lines:first system"c"];
  system raze "c ",(string lines)," ",string last getmaxsize[];
  .lg.i "Setting console size to "," "sv string system"c";
 }

\d .
