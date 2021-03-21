#!/usr/bin/env bash

function run {
  if ! pgrep -f $1 ;
  then
    $@&
  fi
}

run picom
run conky
run nitrogen --restore --set-zoom-fill

