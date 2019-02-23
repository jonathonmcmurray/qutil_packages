\d .worker

qline:"q $QPATH/worker/register.q ",(":"sv("";string .z.h;string system"p"));                        //q start-up line
preline:"";                                                                                          //placeholder for any preamble required

sline:{[c]$[count preline;preline," && ";""],qline," ",string[c]," &"}                               //build startup line

create:{[c]c:$[c~(::);`;c];system sline c}                                                           //create local worker (c:class)
rcreate:{[c;r]system"ssh ",r," '",sline[c],"' &"}                                                    //create remote worker given remote name & q path

workers:([]host:();handle:();pid:();class:())

preset:()!()                                                                                         //queue for variables to set
prerun:()!()                                                                                         //queue for commands to run
prereq:()!()                                                                                         //queue for packages to require

.worker.set:{[c;x;y] /c:class,x:variable;y:value
  wk:$[c=`;.worker.workers;select from .worker.workers where class in c];
  if[count wk;
     wk[`handle]@\:(set;x;y)];                                                                       //set on existant workers
  preset[c],:enlist(x;y);                                                                            //queue for future workers
 }

.worker.run:{[c;x] /c:class,x:string to run
  wk:$[c=`;.worker.workers;select from .worker.workers where class in c];
  if[count wk;
     wk[`handle]@\:(value;x)];                                                                       //run on existant workers
  prerun[c],:enlist x;                                                                               //queue for future workers
 }

.worker.require:{[c;x] /c:class,x:package
  wk:$[c=`;.worker.workers;select from .worker.workers where class in c];
  if[count wk;
     wk[`handle]@\:(`.utl.require;x)];                                                               //require on existant workers
  prereq[c],:enlist x;                                                                               //queue for future workers
 }

register:{
  `.worker.workers upsert (x;.z.w;y;z);
  f:{x where 0<count'[x]};
  if[count preset;neg[.z.w](set'),flip raze preset`,z];                                              //set queued variables
  if[count prerun;neg[.z.w](value'),enlist f raze prerun`,z];                                        //run queued commands
  if[count prereq;neg[.z.w](`.utl.require'),enlist f raze prereq`,z];                                //req queued packages
 }

\d .

.z.exit:{[x;y]neg[.worker.workers[`handle]]@\:"exit 0";x[]}@[value;`.z.exit;{{}}];                   //close all workers on exit, maintain existing .z.exit
.z.pc:{x y;delete from `.worker.workers where handle=y}@[value;`.z.pc;{{}}];                         //maintain existing .z.pc & delete from .worker.workers
