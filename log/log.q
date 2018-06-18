\d .lg

lvls:`err`wrn`inf`alt!("ERROR";"WARN";"INFO";"ALERT")                               //define log level strings
lvls:max[count@'.lg.lvls]$.lg.lvls                                                  //pad all to max length

col:`err`wrn`inf`alt!31 33 0 34                                                     //define colours for each log level
cf:.os.test"tty"                                                                    //flag for if colours should be used

lg:{[lvl;msg]
  -1 $[cf;"\033[G";""],"[ ",string[.z.Z]," ] ",                                     //timestamp
     "[ ",$[cf;"\033[",string[col lvl],"m";""],lvls[lvl],$[cf;"\033[0m";""]," ] ",  //level, coloured
     msg;                                                                           //message
 }

o:i:lg[`inf]
w:lg[`wrn]
e:lg[`err]
a:lg[`alt]

\d .
