import os,sys,re
from time import sleep
home = os.path.expanduser('~')
if (sys.version_info > (3, 0)):
  # Python 3 code in this block
  exec(open(home+'/homedir/scripts/hexecho.py').read())
else:
  # Python 2 code in this block
  execfile(home+'/homedir/scripts/hexecho.py')
hexoff
print ("Ran pystart and did import os,sys,re, sleep from time, and hexon/hexoff")
