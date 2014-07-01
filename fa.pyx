import numpy as np
import os
from collections import namedtuple
from operator import attrgetter
from multiprocessing import Pool
from functools import partial
import matplotlib.pyplot as plt
import sys
cimport numpy as np
cimport cython
cdir = os.getcwd()
import pysces
os.chdir(cdir)

DTYPE = np.int
ctypedef np.int_t DTYPE_t

class StochasticPetriNet:

    def __init__(self, pre, init, S, rates, places, transitions):
        self.pre = pre
        self.init = init
        self.S = S
        self.rates = rates
        self.places = places
        self.transitions = transitions


def is_enabled(spn, state, ri):
    #check if applying reaction ri can proceed and return either True or False
    return np.all(spn.pre[:, ri] <= state)

def simulate_gill(spn, n_steps):
    # spn: A tuple representing the SPN
    #
    # Performs the standard Gillespie algorithm for (Markov) jump processes
    # Might not be consistent with the SPN operational semantics
    SimResults = namedtuple('SimResults', ['trajectories', 'wait_times'])
    state_out = np.zeros((n_steps+1, len(spn.places)))
    w_times = np.zeros(n_steps+1)
    state_out[0, :] = spn.init
    state = spn.init
    t = 0.0
    w_times[0] = t
    for i in xrange(1, n_steps+1):
        mres = np.random.multinomial(1, pvals=spn.rates/np.sum(spn.rates))
        ri = np.nonzero(mres)[0][0]
        if is_enabled(spn, ri, state): state = state + spn.S[:, ri]
        state_out[i, :] = state
        dt = np.random.exponential(1/np.sum(spn.rates))
        t += dt
        w_times[i] = t

    return SimResults._make([state_out, w_times])

@cython.boundscheck(False)
def get_enabled_c(np.ndarray[DTYPE_t, ndim=2] pre, np.ndarray[DTYPE_t, ndim=1] state):
    enabled = []
    cdef int i
    cdef int j
    cdef int t

    for i in range(pre.shape[1]):
        t = 1
        for j in range(pre.shape[0]):
            if pre[j, i] > state[j]:
                t = 0
                break
        if t == 1:
            enabled.append(i)

    return np.array(enabled, dtype=np.int)

def simulate_pn(spn, n_steps):
    # Simulates exactly according to the operational semantics of SPNs
    # Proceeds similarly to the animation pebble game
    steps_taken = n_steps
    state = np.copy(spn.init)

    for i in xrange(1, n_steps+1):
        enabled = get_enabled_c(spn.pre, state)
        if enabled.size == 0:
            # reached a dead state
            steps_taken = i
            break
        w_times = np.random.exponential(1/spn.rates[enabled])
        ri = enabled[np.argmin(w_times)]
        state = state + spn.S[:, ri]

    return state

def get_model_dists(spn, n_iter, n_steps):
    dists = np.zeros((n_iter, len(spn.places)))
    for i in xrange(n_iter):
        sim_res = simulate_pn(spn, n_steps)
        dists[i, :] = sim_res

    return dists

def load_model(fpath):
    cdir = os.getcwd()

    d, fname =  os.path.split(fpath)
    mod = pysces.model(fname, d)
    mod.Simulate()
    S = np.array(np.copy(mod.Nmatrix.array), dtype=np.int)
    pre = np.copy(S)
    pre[pre == 1] = 0
    pre[pre == -1] = 1

    places, transitions = mod.Nmatrix.getLabels()
    init = list(getattr(mod, place+"_init") for place in places)
    rate_getter = attrgetter("rate")
    rates = list(rate_getter(getattr(mod, transition)) for transition in transitions)
    os.chdir(cdir)

    spn = StochasticPetriNet(pre, np.array(init, dtype=np.int), S, np.array(rates),
                             places, transitions)

    return spn

def plot_sim_results(results):
    plt.plot(results.wait_times, results.trajectories)
    plt.show()

def sim_fa_model(fpath, n_steps):
    # Read the model and simulate with standard Gillespie for n_steps steps
    spn = load_model(fpath)
    results = simulate_gill(spn, n_steps)

    return results

def anim_fa_model(fpath, n_steps):
    # Read the model and animate for n_steps steps
    spn = load_model(fpath)
    results = simulate_pn(spn, n_steps)

    return results

def get_out(spn, sim_res):
    return dict(zip(spn.places, sim_res))

