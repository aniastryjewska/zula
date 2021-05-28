#!/usr/bin/env bash

get_var_or_file(){
  var_name=$1
  file_name=$1_FILE
  if [ -n "${!file_name}" ]
  then
    cat "${!file_name}"
  elif [ -n "${!var_name}" ]
  then
    echo "${!var_name}"
  else
    if [ -n "$2" ]
    then
      echo "$2"
    else
      echo "${var_name}" nor "${file_name}" environment variables are set. exiting > /dev/stderr
      exit 1
    fi
  fi
}

ls

npm run build