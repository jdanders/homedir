import os,sys,re
from time import sleep
from pprint import pprint
home = os.path.expanduser('~')
from math import log,ceil
def clog2(num):
  return int(ceil(log(num,2)))
if (sys.version_info > (3, 0)):
  # Python 3 code in this block
  exec(open(home+'/homedir/scripts/hexecho.py').read())
else:
  # Python 2 code in this block
  execfile(home+'/homedir/scripts/hexecho.py')
hexoff
print ("Imported os,sys,re,sleep,pprint. Defined clog2,hexon/hexoff")
