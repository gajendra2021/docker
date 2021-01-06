import subprocess
import yaml
import sys
import time
import os
import pprint

def fun():
  ps = subprocess.Popen(['gcloud', 'version' ], stdout=subprocess.PIPE,
  stderr = subprocess.PIPE)
  output, error = ps.communicate()
  return output
print(fun())
print("my vresion is",sys.version)
