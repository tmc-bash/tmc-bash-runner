#!/bin/bash

clear_temps() {
    if [ -e $TEMP_RESULTS_FILE ]; then
        rm $TEMP_RESULTS_FILE
    fi
}

clear_results() {
    if [ -e $RESULTS_FILE ]; then
        rm $RESULTS_FILE
    fi
}

add_name() {

  if grep -q "\"" "$AVAILABLE_POINTS"; then
    punc=","
  fi
  
  sed -i "s/}/$punc\"$1\"}/" $AVAILABLE_POINTS

}