\d .os

es:$[.z.o like "w*";" 2>NUL";" 2>/dev/null"];                                       //error suppression dependent on os
test:{[x]
  /* .os.test - test if a command works on current os */
  :@[{system x;1b};x,es;0b];                                                        //run with system & suppress error
  }

home:hsym`$getenv$[.z.o like "w*";`USERPROFILE;`HOME]                               //get home dir depending on OS
hfile:(` sv home,)                                                                  //get file path relative to home dir

\d .
