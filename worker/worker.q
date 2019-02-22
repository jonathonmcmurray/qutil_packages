\d .worker

qline:"q $QPATH/worker/register.q ",(":"sv("";string .z.h;string system"p"))," &";                                //q start-up line
preline:"";                                                                                                       //placeholder for any preamble required

sline:{$[count preline;preline," && ";""],qline}                                                                  //build startup line

create:{system sline[]}                                                                                           //create local worker
rcreate:{[r]system"ssh ",r," '",sline[],"' &"}                                                                    //create remote worker given remote name & q path

workers:([] host:();handle:();pid:())

preset:()                                                                                                         //queue for variables to set
prerun:()                                                                                                         //queue for commands to run
prereq:()                                                                                                         //queue for packages to require

.worker.set:{[x;y] /x:variable;y:value
  if[count .worker.workers;
     .worker.workers[`handle]@\:(set;x;y)];                                                                       //set on existant workers
  preset,:enlist(x;y);                                                                                            //queue for future workers
 }

.worker.run:{[x] /x:string to run
  if[count .worker.workers;
     .worker.workers[`handle]@\:(value;x)];                                                                       //run on existant workers
  prerun,:enlist x;                                                                                               //queue for future workers
 }

.worker.require:{[x] /x:package
  if[count .worker.workers;
     .worker.workers[`handle]@\:(`.utl.require;x)];                                                               //require on existant workers
  prereq,:enlist x;                                                                                               //queue for future workers
 }

register:{
  `.worker.workers upsert (x;.z.w;y);
  if[count preset;neg[.z.w](set'),flip preset];                                                                   //set queued variables
  if[count prerun;neg[.z.w](value'),enlist prerun];                                                               //run queued commands
  if[count prereq;neg[.z.w](`.utl.require'),enlist prereq];                                                       //req queued packages
 }

\d .

.z.exit:{[x;y]neg[.worker.workers[`handle]]@\:"exit 0";x[]}@[value;`.z.exit;{{}}];                                //close all workers on exit, maintain existing .z.exit
.z.pc:{x y;delete from `.worker.workers where handle=y}@[value;`.z.pc;{{}}];                                      //maintain existing .z.pc & delete from .worker.workers
