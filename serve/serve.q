\d .serve

HOSTNAME:@[value;`.serve.HOSTNAME;getenv`HOSTNAME];                                 //default to HOSTNAME env var if not set prior to pkg load
if[0=count HOSTNAME;HOSTNAME:"localhost"];                                          //default to localhost if not set elsewhere

head:""
body:"No content yet..."

addhead:{head,:x}
addbody:{body,:x}

headjs:{addhead .h.htac[`script;`type`src!("text/javascript";x)]""}
headcss:{addhead .h.htac[`style;(enlist`type)!enlist"text/css"]"@import '",x,"'"}

/ serve resultant chart over HTTP
.h.HOME:"html"                                                                      //set .h.HOME for finding CSS & JS
.h.ty:.h.ty,\:"; charset=utf-8";                                                    //set character set for everything
.z.ph:{
  ws:.h.htc[`script]"var ws=new WebSocket(\"ws://",HOSTNAME,":",string[system"p"],"\");ws.onmessage = function(event) { window.location.reload(true) };";
  x:.h.uh$[type x;x;first x];                                                       //unescape characters
  :$[count r:@[read1;hsym p:`$.h.HOME,"/",x;""];                                    //attempt to read file
    .h.hy[`$(1+x?".")_x]"c"$r;                                                      //if file exists, return it's contents
    .h.hy[`htm] .h.htc[`html].h.htc[`head;head],.h.htc[`body]body,ws];              //otherwise return output HTML
 }

w:();
.z.wo:{w,:.z.w}                                                                     //record WebSocket connections
.z.wc:{.serve.w:w except x}                                                         //record ws connections closing
.z.ws:{x;}                                                                          //do nothing with WebSocket messages

refresh:{neg[w]@\:"";}                                                              //tell clients to refresh (via WebSockets)
publish:{.serve.body:x;refresh[]}                                                   //publish a page, overwriting existing

\d .

.port.printhttp .serve.HOSTNAME;                                                    //output HTTP URL for hosting
