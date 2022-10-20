#!/usr/bin/env python3
import sys


def main(id_file):
    ids = {}
    with open(id_file, 'r') as f:
        for line in f:
            suny_id = [line[5:15].strip("0")]
            banner_id = line[33:45].strip("0")

            if banner_id in ids.keys():
                ids[banner_id] += suny_id
            else:
                ids[banner_id] = suny_id

    for key, val in ids.items():
        if len(val) > 1:
            print("Banner ID:", key)
            print("SUNY ID:", val, "\n")


if __name__ == "__main__":
    main(sys.argv[1])
