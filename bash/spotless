#!/bin/bash

# Removes all temporary files created by emacs and vim. This can be potentially harmful if data
#   is unsaved. Use with caution

cd $PWD

if [ $# == 0 ]; then
    rm *~ \#* .#* &> /dev/null
elif [ $1 == -r ]; then
    rm *~ \#* .#* &> /dev/null
    for dir in */
    do
	if [ -a $dir ]; then
	    cd $dir
	    spotless -r
	    cd .. 
	fi
    done
else
    for var in "$@"
    do
	if [[ $var = */ ]]; then
	    rm $var*~ $var#* .#* &> /dev/null
	else
	    rm $var/*~ $var/#* .#* &> /dev/null
	fi
   done
fi
