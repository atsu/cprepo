#!/bin/sh -l

if ! diff -U3 "$1" "$2"
then
  echo "source file $1 differs from destination file $2"
  echo "will copy from source path to destination path"
  cp "$1" "$2"
  echo ::set-output name=changed::yes
else
  echo ::set-output name=changed::no
fi
