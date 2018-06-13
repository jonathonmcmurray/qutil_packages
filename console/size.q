\d .con

// resize to full window size, output new size
size:{[]
 system"c ",raze (system"tput lines")," ",system"tput cols";
 .lg.i "Setting console size to "," "sv string system"c";
 }

// auto-resize to full size, no output
size[];

// full width, specified height
wide:{[lines]
  if[null lines;lines:first system"c"];
  system raze "c ",(string lines)," ",system"tput cols";
  :system"c";
 }

\d .
