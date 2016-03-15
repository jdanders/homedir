import os,sys,re
from time import sleep
from pprint import pprint
home = os.path.expanduser('~')
if (sys.version_info > (3, 0)):
  # Python 3 code in this block
  exec(open(home+'/homedir/scripts/hexecho.py').read())
else:
  # Python 2 code in this block
  execfile(home+'/homedir/scripts/hexecho.py')
hexoff
print ("Imported os,sys,re,sleep,pprint, and hexon/hexoff")
