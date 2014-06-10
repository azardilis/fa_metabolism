import os
import csv
import numpy as np
from collections import namedtuple

def get_dists(fpath):
    Dataset = namedtuple('Dataset', ['data', 'col_labels'])
    d, file = os.path.split(fpath)
    even_fas = set(line.split()[0].rstrip() for line in open(d + "/uns_fas.txt"))
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

    labels = list(label.replace(" ", "") for label in even_fa_idx.values()) 
    return Dataset._make([data.astype(np.float), labels])

def get_name_cor():
    return dict(tuple(line.split()) for line in open("data/uns_fas.txt"))

def get_fas_idx(spn, real_ds, names):
    idxs = {}
    for rn, sn in names.iteritems():
        idxs[real_ds.col_labels.index(rn)] = spn.places.index(sn)

    return(idxs)
    
def dist(real_ds, sim_ds, idxs):
    # simple distance between the simulated distributions
    # and the real distributions
    dist = 0.0
    for ri, si in idxs.iteritems():
        di = np.mean(real_ds.data[:, ri]) - np.mean(sim_ds[:, si])
        dist += di

    return dist

    

    
    

    

    
