#!/usr/bin/env python3

import sys
import argparse

def convert_hex_to_sizes(hex_input):
    decimal_value = int(hex_input, 16)

    kib_value = decimal_value / 1024
    mib_value = kib_value / 1024

    print(f"RAW : {decimal_value}")
    print(f"{kib_value:.2f} KiB")
    print(f"{mib_value:.2f} MiB")

def convert_int_to_hex(decimal_input):
    decimal_value = parse_decimal_with_suffix(decimal_input)
    hex_value = hex(decimal_value)
    print(f"HEX : {hex_value}")

def parse_decimal_with_suffix(value):
    suffixes = {'K': 1024, 'M': 1024**2, 'G': 1024**3}
    if value[-1].upper() in suffixes:
        return int(value[:-1]) * suffixes[value[-1].upper()]
    return int(value)

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: hex_converter.py [hex|decimal] value")
        sys.exit(1)

    if sys.argv[1] == "hex":
        convert_hex_to_sizes(sys.argv[2])
    elif sys.argv[1] == "decimal":
        convert_int_to_hex(sys.argv[2])
    else:
        print("Usage: hex_converter.py [hex|decimal] value")
        sys.exit(1)

    sys.exit(0)