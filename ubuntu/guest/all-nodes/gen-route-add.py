import argparse

# gen-route-add.py cni $(route | grep default | awk '{print $NF}') 10.85.0.0 192.168.64.29 192.168.64.33 192.168.64.35

parser = argparse.ArgumentParser(prog='ProgramName');
parser.add_argument('cniInterface');
parser.add_argument('defaultInterface');
parser.add_argument('startAddress');
parser.add_argument('nodeIps', nargs='*');
args = parser.parse_args();

print(args.cniInterface);
print(args.defaultInterface);
print(args.startAddress);

ipBytes = args.startAddress.split(".")
print(len(args.nodeIps));

def assembleRouteCmd(workerIp, nodeIp, cniInterface):
  return f"sudo ip route add \"{workerIp}/24\" via \"{nodeIp}\""

allRoutes = []
for idx, nodeIp in enumerate(args.nodeIps):
  nodeNum = int(ipBytes[2])+idx;
  workerIp = ipBytes[0] + "." + ipBytes[1] + "." + str(nodeNum) + "." + ipBytes[3]
  routeCmd = assembleRouteCmd(workerIp, nodeIp, args.cniInterface)
  allRoutes.append(routeCmd);

for nodeIndex, nodeIp in enumerate(args.nodeIps):
  print(nodeIp);
  routes = [route for routeIndex, route in enumerate(allRoutes) if nodeIndex != routeIndex] #if nodeIp not in route]
  [print(x) for x in routes]
  print("\n");


