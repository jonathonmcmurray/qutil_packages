/dependencies
.utl.require"log"
.utl.require"os"

/package code
if[.os.test"tput cols";                          //only load code if tput is available
   .utl.pkg"size.q";
  ]
