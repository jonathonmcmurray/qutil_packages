/ utilise bootstrap.css in q-backed web server
\d .bs

url:"https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css";
hash:"sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T";
.serve.addhead .h.hta[`link;`rel`href`integrity`crossorigin!(`stylesheet;url;hash;`anonymous)];

tab.rec:{[c;r] /c:conditions,r:record
 cl:1#key[c] where {y[1]x y 0}[r]'[value c];
 f:$[0=count cl;.h.htc;.h.htac[;(1#`class)!cl]]`tr;
 raze f raze .serve.el[`td] each value r
 }

table:{[c;t] .h.htac[`table;(1#`class)!1#`table].h.htc[`tr;raze .serve.el[`th]cols t],raze tab.rec[c]'[t]}

\d .

\
condition dict
- keys are bootstrap classes e.g. table-warning etc.
- values are (field;condition) e.g. (`volume;>[;5000) to check where volume>5000
first matching condition is taken (e.g. if error for over 5000 & warn for over 3000, warn should be after err in dict)


example

q).utl.require"serve"
[ 2019.02.23T15:37:53.206 ] [ ALERT ] Serving on HTTP: http://localhost:42013
q).utl.require"serve/bootstrap.q"
q)c:(enlist"table-danger")!enlist(`volume;>[;5000])
q)c["table-warning"]:(`volume;>[;3000])
q)c["table-success"]:(`volume;<[;3000])
q)N:8
q)dates:2018.03.28 + til 3
q)tab:([] date:N?dates;category:N?`CORP`EQ`GOV;volume:N?til 10000)
q)c
"table-danger" | `volume >[;5000]
"table-warning"| `volume >[;3000]
"table-success"| `volume <[;3000]
q).serve.publish .bs.table[c;tab]

