import numpy as np
import os
from collections import namedtuple
from operator import attrgetter
import matplotlib.pyplot as plt
import sys
cdir = os.getcwd()
import pysces
os.chdir(cdir)

def is_enabled(spn, ri, state):
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

def get_enabled(spn, state):
    enabled = list(is_enabled(spn, ri, state) for ri in xrange(len(spn.transitions)))
    enabled_trans = np.where(np.array(enabled) == True)[0]

    return enabled_trans

def simulate_pn(spn, n_steps):
    # Simulates exactly according to the operational semantics of SPNs
    # Proceeds similarly to the animation pebble game
    steps_taken = n_steps
    state_out = np.zeros((n_steps+1, len(spn.places)))
    state = np.copy(spn.init)
    state_out[0, :] = np.copy(spn.init)
    for i in xrange(1, n_steps+1):
        enabled = get_enabled(spn, state)
        if enabled.size == 0:
            # reached a dead state
            steps_taken = i
            break
        w_times = np.random.exponential(1/spn.rates[enabled])
        ri = enabled[np.argmin(w_times)]
        state = state + spn.S[:, ri]
        state_out[i, :] = state

    return state_out[:steps_taken,]

def get_model_dists(spn, n_iter, n_steps):
    dists = np.zeros((n_iter, len(spn.places)))
    for i in xrange(n_iter):
        sim_res = simulate_pn(spn, n_steps)
        final_marking = sim_res[-1, :]
        dists[i, :] = final_marking

    return dists
    
def load_model(fpath):
    cdir = os.getcwd()
    StochasticPetriNet = namedtuple("StochasticPetriNet", ["pre", "init", "S", "rates",
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
    os.chdir(cdir)
    return StochasticPetriNet._make([pre, np.array(init), S, np.array(rates),
                                    places, transitions])

def plot_sim_results(results):
    plt.plot(results.wait_times, results.trajectories)
    plt.show()
    
def sim_fa_model(fpath, n_steps):
    # Read the model and simulate with standard Gillespie for n_steps steps
    spn = load_model(fpath)
    results = simulate(spn, n_steps)

    return results

def anim_fa_model(fpath, n_steps):
    # Read the model and animate for n_steps steps
    spn = load_model(fpath)
    results = simulate(spn, n_steps)

    return results

