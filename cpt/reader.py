import csv
from os.path import abspath, expanduser, dirname, join

PACKAGE_DIR = abspath(expanduser(dirname(__file__)))
DATA_DIR = join(PACKAGE_DIR, "data")


def read():
    with open(join(DATA_DIR, 'test.csv'), newline='') as f:
        reader = csv.reader(f)
        row1 = next(reader)
        print(row1)
