#!/usr/bin/env bats

setup() {
    RESULTS_FILE="./.tmc_test_results.json"
    POINTS_FILE="./.tmc_available_points.json"

    TEST_PROJECT=`find ./ -name "testSample"`
    cd $TEST_PROJECT
}


@test "Runner can run tests properly" {
    run ./tmc/runner.sh
    [ "$status" -eq 0 ]
}

@test "File with tests results exists after running tests" {
    [ -f $RESULTS_FILE ]
}

@test "Available points file exists after executing available_points.sh" {
    run ./tmc/available_points.sh
    [ "$status" -eq 0 ]
    [ -f $POINTS_FILE ]
}

@test "The number of tests is correct in the result file" {
    count=$(grep -o 'name' $RESULTS_FILE | wc -l)

    [ "$count" -eq 3 ]
}

@test "Two wrong tests with corresponding messages in the result file" {
    msg1="Function sum return value doesn't match. Expected 'Sum is 6' but was 'Sum is 6.'."
    msg2="Wrong status. Expected '0' but was '127'."
    
    if grep -R "$msg1" $RESULTS_FILE && grep -R "$msg2" $RESULTS_FILE; then
        exist=1
    else
        exist=0
    fi

    [ "$exist" = "1" ]
}

@test "One passed test and two failed tests" {
    passed=$(grep -o 'true' $RESULTS_FILE | wc -l)
    [ "$passed" -eq 1 ]

    failed=$(grep -o 'false' $RESULTS_FILE | wc -l)

    [ "$failed" = "2" ]
}

@test "All points can be found from .tmc_available_points.json file" {
    if grep -R "2.3" $RESULTS_FILE && grep -R "2.4" $RESULTS_FILE && grep -R "2.5" $RESULTS_FILE; then
        sum=3
    fi

    [ "$sum" = "3" ]
}
