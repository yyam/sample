#!/bin/sh

SKELDIR=preps/skel/
DIR=lib/
files="Vol00 Vol01 Vol02"

for f in $files
do
	echo $f
	cp ${SKELDIR}/${f}.pm ${DIR}/${f}.pm
done

