#!/bin/sh -l

if [ -f "$2" ]
then
    diff -U3 "$1" "$2"
    diff_result=$?

    if [ $diff_result -gt 1 ]
    then
	      echo "diff failed with exit code = $diff_result"
        exit 1
    fi

    if [ $diff_result -eq 0 ]
    then
	    echo ::set-output name=changed::no
	    exit 0
    fi
fi

echo "copying from source path = $1 to destination path = $2"
cp "$1" "$2"
cp_result=$?

if [ $cp_result -eq 0 ]
then
    echo ::set-output name=changed::yes
fi
