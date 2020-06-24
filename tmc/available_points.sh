#!/bin/bash

. ./tmc/utils.sh

if [ -z ${TEST_PATH+x} ]; then
  TEST_PATH=`find ./ -name "test"`

  TEST_FILES=()
  for file in $TEST_PATH/*
    do
      TEST_FILES+=("$file")
  done
fi

AVAILABLE_POINTS=".tmc_available_points.json"
if [ -e $AVAILABLE_POINTS ]; then
  rm $AVAILABLE_POINTS
fi

printf "{}" >> $AVAILABLE_POINTS

punc=""
count=0

while read line
do
  var=$(echo $line | cut -d'"' -f 2)

  if [ $(($count % 2)) == 0 ]; then
    add_name "$var"

  else
    if [[ $line == *"@point"* ]]; then
      sed -i "s/}/:\"$var\"}/" $AVAILABLE_POINTS
    else
      sed -i "s/}/:\"-\"}/" $AVAILABLE_POINTS
      add_name "$var"
      count=$(($count+1))
    fi
  fi

  count=$(($count+1))
done <<< "$(grep -e '@test\|@point' ${TEST_FILES[@]})"
