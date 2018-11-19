\d .expect

config:@[value;`.expect.config;`:expect.csv];
ations:update passed:0b,ag:0b,ao:0b,ar:0b from ("S*TTT";1#",")0:config;

check:{[]
  update passed:1b from `.expect.ations where not passed,value each test;
  a:select from ations where passed,not ag;
  alert[`GREEN] each a`id;
  update ag:1b from `.expect.ations where passed,not ag;
  a:select from ations where not passed,not ao,orange>.z.P;
  alert[`ORANGE] each a`id;
  update ao:1b from `.expect.ations where not passed,not ao,orange>.z.P;
  a:select from ations where not passed,not ar,red>.z.P;
  alert[`RED] each a`id;
  update ar:1b from `.expect.ations where not passed,not ar,red>.z.P;
 }

alert:{[x;y] .lg.o " | "sv string x,y}

\d .

.timer.add[`.expect.check;1#`;00:00:01;1b]
