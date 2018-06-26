/dependencies
.utl.require"log"
.utl.require"os"

/package code
if[.os.test"tput cols";                          //only load code if tput is available
   .utl.pkg"size.q";
  ]

if[not .os.test"tput cols";
   .utl.require"ffi";
   .utl.require"winapi";
   .utl.pkg"size_win.q";
 ]
