#!/usr/bin/env bats

setup() {
    RESULTS_FILE="./.tmc_test_results.json"
    POINTS_FILE="./.tmc_available_points.json"

    BASIC_PROJECT=`find ./ -name "basicSample"`
    # NO_POINT_PROJECT=`find ./ -name "noPointSample"`

    cd $BASIC_PROJECT
}


@test "Runner can run tests properly in basicSample dir" {
    run ./tmc/runner.sh
    [ "$status" -eq 0 ]
}

@test "File with tests results exists after running tests in basicSample dir" {
    [ -f $RESULTS_FILE ]
}

@test "Available points file exists after executing available_points.sh in basicSample dir" {
    run ./tmc/available_points.sh
    [ "$status" -eq 0 ]
    [ -f $POINTS_FILE ]
}

@test "The number of tests is correct in the result file in basicSample dir" {
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

@test "All test names and points can be found correspondingly from .tmc_available_points.json file" {
    name1="This is a failed test with wrong return value"
    name2="This is a failed test with wrong status"
    name3="This is a passed test"

    if grep -R "\"$name3\":\"2.3\"" $POINTS_FILE && grep -R "\"$name1\":\"2.4\"" $POINTS_FILE && grep -R "\"$name2\":\"2.5\"" $POINTS_FILE; then
        points=3
    fi

    [ "$points" = "3" ]

}