#!/bin/bash

ver=$1
mkdir -p releases/$ver

for i in */;
  do tar czf releases/$ver/${i%/}-${ver}.tar.gz $i;
done
