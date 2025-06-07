#!/bin/bash

# Loop over files containing "sample_" in the current directory
for file in sample_*; do
    # Skip if no matching files
    [ -e "$file" ] || continue

    homedir="$HOME"
    newfile="${homedir}/${file#sample_}"

    echo "Copying $file to $newfile"

    if [ -e "$newfile" ]; then
        echo "Backing up existing copy"
        cp "$newfile" "$newfile.homedirbackup"
    fi

    cp "$file" "$newfile"
done

##!/usr/bin/env python
#import os,sys
#
#files = [ii for ii in os.listdir('.') if "sample_" in ii]
#for file in files:
#    homedir = os.path.expanduser("~")
#    newfile = homedir+os.sep+file.replace('sample_','')
#    print("Copying %s to %s"%(file,newfile))
#    if os.path.exists(newfile):
#        print("Backing up existing copy")
#        result=os.popen('cp %s %s.homedirbackup'%(newfile,newfile)).read()
#    result=os.popen('cp %s %s'%(file,newfile))
