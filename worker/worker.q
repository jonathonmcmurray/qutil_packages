\d .worker

create:{system"q $QPATH/worker/register.q ",":" sv ("";string .z.h;string system"p")}                             //create local worker
rcreate:{[r]system"ssh ",r," 'q $QPATH/worker/register.q ",(":" sv ("";string .z.h;string system"p")),"' &"}      //create remote worker given remote name & q path

workers:([] host:();handle:();pid:())

register:{`.worker.workers upsert (x;.z.w;y)}

\d .

.z.exit:{[x;y]neg[.worker.workers[`handle]]@\:"exit 0";x[]}@[value;`.z.exit;{{}}];                                //close all workers on exit, maintain existing .z.exit
.z.pc:{x y;delete from `.worker.workers where handle=y}@[value;`.z.pc;{{}}];                                      //maintain existing .z.pc & delete from .worker.workers
