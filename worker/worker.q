\d .worker

create:{system"q $QPATH/worker/register.q ",":" sv ("";string .z.h;string system"p")}                             //create local worker
rcreate:{[r]system"ssh ",r," 'q $QPATH/worker/register.q ",(":" sv ("";string .z.h;string system"p")),"' &"}      //create remote worker given remote name & q path

workers:([] host:();handle:();pid:())

register:{`.worker.workers upsert (x;.z.w;y)}

\d .

.z.exit:{neg[.worker.workers[`handle]]@\:"exit 0"}

