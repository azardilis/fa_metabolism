import numpy as np
import pysces
import os
from collections import namedtuple
from operator import attrgetter
import matplotlib.pyplot as plt

def is_enabled(spn, ri, state):
    #check if applying reaction ri can proceed and return either True or False
    return np.all(spn.pre[:, ri] <= state)
    
def simulate(spn, n_steps):
    SimResults = namedtuple('SimResults', ['trajectories', 'wait_times'])
    state_out = np.zeros((n_steps+1, len(spn.places)))
    w_times = np.zeros(n_steps+1)
    state_out[0, :] = spn.init
    state = spn.init
    t = 0.0
    w_times[0] = t
    for i in range(1, n_steps+1):
        mres = np.random.multinomial(1, pvals=spn.rates/np.sum(spn.rates))
        ri = np.nonzero(mres)[0][0]
        if is_enabled(spn, ri, state): state = state + spn.S[:, ri]
        state_out[i, :] = state
        dt = np.random.exponential(1/np.sum(spn.rates))
        t += dt
        w_times[i] = t

    return SimResults._make([state_out, w_times])

def load_model(fpath):
    StochastiPetriNet = namedtuple("StochasticPetriNet", ["pre", "init", "S", "rates",
                                                          "places", "transitions"])
    d, fname =  os.path.split(fpath)
    mod = pysces.model(fname, d)
    mod.Simulate()
    S = np.copy(mod.Nmatrix.array)
    pre = np.copy(S)
    pre[pre == 1] = 0
    pre[pre == -1] = 1

    places, transitions = mod.Nmatrix.getLabels()
    init = list(getattr(mod, place+"_init") for place in places)
    rate_getter = attrgetter("rate")
    rates = list(rate_getter(getattr(mod, transition)) for transition in transitions)

    return StochastiPetriNet._make([pre, np.array(init), S, np.array(rates),
                                    places, transitions])

def plot_sim_results(results):
    plt.plot(results.wait_times, results.trajectories)
    plt.show()
    
def sim_fa_model(fpath, n_steps):
    spn = load_model(fpath)
    results = simulate(spn, n_steps)

    return results


    

    

    








