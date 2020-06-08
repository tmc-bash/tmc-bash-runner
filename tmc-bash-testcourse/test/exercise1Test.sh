
function setup(){
    EXERCISE_PATH=`find ./ -name "src"`
    cd $EXERCISE_PATH
}


@test "The shell script file 'exercise1.sh' exists" {
  [ -f "exercise1.sh" ]
}

@test "The shell script file 'exercise1.sh' is executable" {
  [ -x "exercise1.sh" ]
}

@test "The script runs without generating an error code" {
  run ./exercise1.sh <<< '-1'
  [ "$status" -eq 0 ]
}