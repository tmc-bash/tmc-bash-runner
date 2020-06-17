#!/usr/bin/env bats

setup() {
    TEST_Project=`find ./ -name "passingSample"`
    cd $TEST_Project
}

@test "runner can run tests properly" {
    run ./tmc/runner.sh
    [ "$status" -eq 0 ]
}

@test "file with tests results exist after running tests" {
    [ -f "./.tmc_test_results.json" ]
}

@test "available points file exists after calling available_points.sh" {
    load ./tmc/available_points.sh
    [ -f "./.tmc_available_points.json" ]
}