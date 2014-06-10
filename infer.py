import os
import csv
import numpy as np
from collections import namedtuple

def get_dists(fpath):
    Dataset = namedtuple('Dataset', ['data', 'col_labels'])
    d, file = os.path.split(fpath)
    even_fas = set(line.rstrip() for line in open(d + "/uns_fas.txt"))
    factor = "Treatment"

    d_reader = csv.reader(open(fpath))
    header = d_reader.next()
    header = np.array(header)
    
    even_fa_idx = {}
    for i, col in enumerate(header):
        if col.replace(" ", "") in even_fas:
            even_fa_idx[i] = col

    data = np.loadtxt(fpath, dtype=str, skiprows=1, delimiter=',')
    tr_idx = np.where(header == "Treatment")[0]

    
    #select even unsaturated FAs columns and Control samples
    is_control = np.array(list(b[0] for b in data[:, tr_idx] == "C"))
    data = data[is_control, :]
    data = data[:, np.array(even_fa_idx.keys())]

    return Dataset._make([data.astype(np.float), even_fa_idx.values()])

    
