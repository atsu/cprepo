#!/bin/sh -l

set -x

if ! diff -U3 "$1" "$2"
then
  echo "exit code = $?"
  echo "diff/failure"
  cp "$1" "$2"
  ls -al "$2"
  cat "$2"
fi
