#!/usr/bin/env python3
import sys

# Get script location

VERSION_FILE = './VERSION'
SCRIPT_FILE = './casper-node-util/usr/bin/casper-node-util'
DEBIAN_CONTROL_FILE = './casper-node-util/DEBIAN/control'


def set_version_file(version):
    print(f"Updating {VERSION_FILE}")
    with open(VERSION_FILE, "w") as f:
        f.write(version)


def _line_start_replace(line_start, new_text, file_path):
    found = False
    with open(file_path, "r") as f:
        lines = f.readlines()
    with open(file_path, 'w') as f:
        for line in lines:
            if line.startswith(line_start):
                found = True
                f.write(f'{new_text}\n')
            else:
                f.write(line)
    if not found:
        print(f"WARNING - {file_path} NOT UPDATED - '{line_start}' not found in file")


def set_script_version(version):
    print(f"Updating {SCRIPT_FILE}")
    line_start = 'VERSION ='
    _line_start_replace(line_start,
                        new_text=f'{line_start} "{version}"',
                        file_path=SCRIPT_FILE)


def set_control_version(version):
    print(f"Updating {DEBIAN_CONTROL_FILE}")
    line_start = 'Version:'
    _line_start_replace(line_start,
                        new_text=f"{line_start} {version}",
                        file_path=DEBIAN_CONTROL_FILE)


def set_version(version):
    print(f"setting version '{version}")
    set_version_file(version)
    set_script_version(version)
    set_control_version(version)


if __name__ == '__main__':
    if len(sys.argv) < 2:
        print("call with version as argument")
        exit(0)
    version = sys.argv[1]
    set_version(version)
