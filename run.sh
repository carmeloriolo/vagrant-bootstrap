#!/usr/bin/env bash

PWD=$(pwd)

run() {
  for i in $(ls machines | egrep -v '^off_.*'); do
    export VG_MACHINE_CONFIG_PATH=${PWD}/machines/${i};
    vagrant ${1};
  done;
}

run ${1}
