import argparse

parser = argparse.ArgumentParser(prog='ProgramName');
parser.add_argument('cniInterface');
parser.add_argument('defaultInterface');
args = parser.parse_args();

print(args.cniInterface);
print(args.defaultInterface);
