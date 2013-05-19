#!/bin/sh

ANSWERDIR=answers/
DIR=lib/
files="Vol00 Vol01 Vol02"

for f in $files
do
	echo $f
	cp ${ANSWERDIR}/${f}.pm ${DIR}/${f}.pm
done

