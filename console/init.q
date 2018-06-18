/dependencies
.utl.require"log"

/package code
if[@[{system x;1b};"tput cols 2>NUL";0b];        //only load code if tput is available
   .utl.pkg"size.q";
  ]
