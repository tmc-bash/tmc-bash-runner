# User Guide
This is a quick guide on how to use the bash runner that is developed for [tmc-bash/tmc-langs](https://github.com/tmc-bash/tmc-langs) to parse the results of a bash project.

## Description
The bash runner runs the unit tests written by [Bats-core](https://github.com/bats-core/bats-core). Additionally, it provides two attributes, `@point` and `msg`, to deliver points and error messages.

## Structure of the project
A bash project along with the runner should have at least three folders `src`, `test` and `tmc`. Project files and bats tests are located in `src` and `test`, respectively. All components of the runner are contained in `tmc`.

```
projectRoot
  -src
  -test
  -tmc
    -available_points.sh
    -point.sh
    -runner.sh
    -utils.sh
```

## Usage
To use attributes `@point` and `msg`, load file `point.sh` from `tmc` directory by adding `load ./tmc/point.sh` before any tests in a bats file. Remember to keep the root folder as working directory during testing.

An example to use two attributes in a test:

```bash
#!/usr/bin/env bats

load ./tmc/point.sh

@test "This is a test" {
    @point "1.1"
    # some commands

    msg "Expected status code is 0, but was $status."
    [ "$status" -eq 0 ]
    
    msg "Another assertion message"
    # assertion here
}
```

### @point
Point attribute is always assigned first inside a test. It accepts a string parameter as its content. For now, only one point can be assigned to a test. More than one point in a test can cause unexpected problems. Other test commands can be added after the point.


### msg
This is a message attribute used to provide a more specific error message if a test is failed. It accepts a string parameter as its content. There can be multiple error messages in a test for multiple assertions. The message displayed in file `.tmc_test_results.json` is the one where the test fails. Thus, it is suggested to assign `msg` before the assertion about which it will describe the error once the assertion fails.


## Running tests
To run the tests, execute the command below in the project root
```
$ ./tmc/runner.sh
```

Tests results are displayed in `.tmc_test_results.json`.

## Available points
To check available points, execute
```
$ ./tmc/available_points.sh
```

All available points are displayed in `.tmc_available_points.json`.
