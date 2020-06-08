#! /usr/bin/bash

  while true
      echo "-1 = Exit"
      do
      read -p "Choose option: " OPTION
      case "$OPTION" in
      -1)
          echo "EXIT"
          break
          ;;
      *)
          echo "DEFAULT"
          ;;
      esac
  done
