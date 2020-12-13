import subprocess
import yaml
import sys
import time
import os
import pprint

def getClusterList():
  print('Getting Cluster list for the Project={0}'.format(projectId))
  clusters = []
  p = subprocess.Popen(['gcloud', 'container', 'clusters', 'list', '--project', projectId], stdout=subprocess.PIPE,
  stderr = subprocess.PIPE)
  output, error = p.communicate()
  if not error:
    #above command returns bytes type output so using decode to convert
    allData = output.decode("utf-8").rstrip().split('\n')
    print(allData)
    fields = allData[0].split()
    for i in range(1, len(allData)):
      cluster = {}
      row = allData[i].split()
      for j in range(len(fields)):
        cluster[fields[j]] = row[j]
      clusters.append(cluster)
    return clusters

  else:
    print('Failed to get cluster list')
    exit(1)


def getLabels(clusters):
  print('Getting Label for all the clusters')
  for cluster in clusters:
    p = subprocess.Popen(['gcloud', 'container', 'clusters', 'describe', cluster['NAME'], '--zone', cluster['LOCATION']],
                         stdout=subprocess.PIPE,
                         stderr=subprocess.PIPE)
    output, error = p.communicate()
    if not error:
      cluster['LABEL'] = yaml.safe_load(output)['resourceLabels']
    else:
      print('Failed to get cluster label')
      exit(1)

  return clusters

import asyncio
async def run(cmd):
    proc = await asyncio.create_subprocess_shell(
      cmd,
      stdin=asyncio.subprocess.PIPE,
      stdout=asyncio.subprocess.PIPE,
      stderr=asyncio.subprocess.PIPE)

    stdout, stderr = await proc.communicate(input=b'\n')

    print(f'[{cmd!r} exited with {proc.returncode}]')
    if stdout:
      print(f'[stdout]\n{stdout.decode()}')
    if stderr:
      print(f'[stderr]\n{stderr.decode()}')


def updateNumOfNodes(clusters):
  for cluster in clusters:
    if cluster['NAME'].lower() == clusterName.lower():
      if 'auto-scaledown' in cluster['LABEL'] and (cluster['LABEL']['auto-scaledown'] == 'true' or cluster['LABEL']['auto-scaledown'] != 'false'):
        print('Updating number of nodes=0 in Cluster={0}'.format(clusterName))
        proc = subprocess.Popen(['gcloud', 'container', 'clusters', 'resize', cluster['NAME'], '--zone', cluster['LOCATION'], '--num-nodes=0', '--verbosity', 'info'],
                             stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        output, error = proc.communicate(b'Y\n')
        print('output = {0}, error = {1}'.format(output, error))

        p = subprocess.Popen(['gcloud', 'container', 'clusters', 'describe', cluster['NAME'], '--zone', cluster['LOCATION']],
                             stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        output, error = p.communicate()

        if yaml.safe_load(output)['currentNodeCount'] == 0:
          print('Number of nodes=0 updated successfully in Cluster={0}'.format(clusterName))
        else:
          print('Failed to update Number of nodes=0 in Cluster={0}'.format(clusterName))

      else:
        print('auto-scaledown label is not set in Cluster={0}'.format(clusterName))


if __name__ == '__main__':
  if len(sys.argv) - 1 != 2:
    print('Please pass required arguments to the script')
    print('Usage: python shutdownCluster.py <Project ID> <Cluster Name>')
    exit(1)
  projectId = sys.argv[1]
  clusterName = sys.argv[2]
  print('Project ID = {0}, Cluster Name = {1}'.format(projectId, clusterName))
  clusters = getClusterList()
  clusters = getLabels(clusters)
  #pprint.pprint(clusters)
  updateNumOfNodes(clusters)

