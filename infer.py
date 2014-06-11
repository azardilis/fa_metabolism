import os
import csv
import numpy as np
from collections import namedtuple
import fa

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

def get_fas_idx(spn, real_ds):
    def get_name_cor():
        return dict(tuple(line.split()) for line in open("data/uns_fas.txt"))

    names = get_name_cor()
    idxs = {}
    for rn, sn in names.iteritems():
        idxs[real_ds.col_labels.index(rn)] = spn.places.index(sn)

    return(idxs)

def get_ratios(ds):
    n_fas = np.shape(ds)[1]

    ds_sums = np.sum(ds, 1)
    r = np.array(list(ds[:, i] / ds_sums for i in xrange(n_fas)))
    r = np.transpose(r)

    return np.median(r, 0)

def dist(real_ds, sim_ds):
    real_ds_ratios = get_ratios(real_ds)
    sim_ds_ratios = get_ratios(sim_ds)

    dist = np.sum(np.square(real_ds_ratios - sim_ds_ratios))

    return dist

def score_spn(spn, real_ds):
    sim_ds = fa.get_model_dists(spn, n_iter=100, n_steps=500)
    idxs = get_fas_idx(spn, real_ds)

    real_ds  = real_ds.data[:, np.array(idxs.keys())]
    sim_ds = sim_ds[:, np.array(idxs.values())]

    return dist(real_ds, sim_ds)














