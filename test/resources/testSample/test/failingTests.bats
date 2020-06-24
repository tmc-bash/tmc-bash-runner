#!/usr/bin/env bats

load ./tmc/point.sh

@test "This is a failed test with wrong return value" {
    @point "2.4"
    run ./src/sum.sh 1 2 3
    
    msg "Function sum return value doesn't match. Expected 'Sum is 6' but was '$output'."
    [ "$output" = "Sum is 6" ]
}

@test "This is a failed test with wrong status" {
    @point "2.5"
    run ./src/non.sh

    msg "Wrong status. Expected '0' but ws '$status'."
    [ "$status" -eq 0 ]

    msg "Wrong return value. Expected 'Hello world!' but was '$output'."
    [ "$output" = "Hello world!" ]
}