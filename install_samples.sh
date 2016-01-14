#!/data/data/com.termux/files/usr/bin/applets/env python
import os,sys

files = [ii for ii in os.listdir('.') if "sample_" in ii]
for file in files:
    homedir = os.path.expanduser("~")
    newfile = homedir+os.sep+file.replace('sample_','')
    print "Copying %s to %s"%(file,newfile)
    if os.path.exists(newfile):
        print "Backing up existing copy"
        result=os.popen('cp %s %s.homedirbackup'%(newfile,newfile)).read()
    result=os.popen('cp %s %s'%(file,newfile))
