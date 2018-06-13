\d .port

.port.get:{system"p"}
.port.set:{system"p ",string x}
.port.rand:{system"p 0W"}

if[not .port.get[];                                                                 //check if already running on port
   .port.rand[];                                                                    //if not set automatically
   .lg.a "No port set, setting to :",string .port.get[];                            //log setting of port
  ];

/utility functions to print URLs for connection, assume localhost if no hostname passed in
printhttp:{.lg.a"Serving on HTTP: http://",$[1<count x;x;"localhost"],":",string .port.get[];}
printws:{.lg.a"Listening for WS connections on ws://",$[1<count x;x;"localhost"],":",string .port.get[];}

\d .
