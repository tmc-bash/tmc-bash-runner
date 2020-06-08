#!/usr/bin/env bats

TEST_PATH=`find ./ -name "test"`

TEST_FILES=()
for file in $TEST_PATH/*
  do
    TEST_FILES+=("$file")
done

RESULTS_FILE="test_results.txt"
if [ -e $RESULTS_FILE ]
  then
    rm $RESULTS_FILE
fi

bats ${TEST_FILES[@]} > test_results.txt
STATUS="$?"

if [ $STATUS == 0 ]
  then
    printf "PASSED" >> test_results.txt
else
    printf "FAILED" >> test_results.txt
fi



