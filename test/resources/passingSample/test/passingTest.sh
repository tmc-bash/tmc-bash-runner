#!/usr/bin/env bats

load ./tmc/point.sh

@test "This is a passed test" {
    @point "2.3"
    result="$(echo 4+4 | bc)"

    msg "Passed test message should be empty"
    [ "$result" -eq 8 ]
}