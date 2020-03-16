#!/bin/sh -l

set -x

if diff -U3 "$1" "$2"
then
  echo "same/success"
else
  echo "exit code = $?"
  echo "diff/failure"
  #git config --local user.email "action@github.com"
  #git config --local user.name "GitHub cprepo action"
  #git -c core.quotepath=false checkout -b repofilesync/foo
  cp "$1" "$2"
  #git add .
  #git commit -m "update workflow"
  ls -al "$2"
  cat "$2"
  #git status
fi
