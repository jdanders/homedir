import sys

def display_hex(i):
 if (sys.version_info > (3, 0)):
   if isinstance(i,(int)):
     handle_it = True
   else:
     handle_it = False
 else:
   if isinstance(i,(int,long)):
     handle_it = True
   else:
     handle_it = False
 if handle_it:
   l = len(repr(i))
   s = "%s"%(hex(i).strip("L"))
   rows, columns = [int(ii) for ii in os.popen('stty size').read().split()]
   if (l > (columns/2)):
     print (repr(i)+"\n"+s.rjust(rows))
   else:
     print (repr(i)+" "+s.rjust(rows-1-l))
 else:
  if i:
   print (repr(i))

def hex_display_on():
  sys.displayhook = display_hex

def hex_display_off():
  sys.displayhook = sys.__displayhook__

class Hexon(object):
  def __repr__(self):
    ret=hex_display_on()
    return ""

class Hexoff(object):
  def __repr__(self):
    ret=hex_display_off()
    return ""

hexon = Hexon()
hexoff = Hexoff()

hexon
