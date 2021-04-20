#!/Users/robertpoenaru/.pyenv/shims/python

import numpy as np
from matplotlib import rc
import matplotlib.pyplot as plt

plot_file = '../../../sub-paper2/figs/T_Core.pdf'


# transfrom the angle from degrees into radians
def Rad(angle):
    return float(angle * np.pi / 180.0)


# transfrom the angle from radians into degrees
def Degrees(rad):
    return float(rad * 180.0 / np.pi)


# transfrom the moments of inertia into inertia parameters
def A_k(moi_k):
    return 1.0 / (2.0 * moi_k)


# the core term
def T_Core(params, I):
    A1 = params["A1"]
    A2 = params["A2"]
    A3 = params["A3"]
    T01 = 0.5 * I * (A1 + A2)
    T02 = A3 * np.power(I, 2)
    T_core = T01 + T02
    return T_core


PARAMS_FIT = {
    "A1": A_k(72),
    "A2": A_k(15),
    "A3": A_k(7),
    "V": 2.1,
    "gm": 22
}

PARAMS_2 = {
    "A1": A_k(7),
    "A2": A_k(72),
    "A3": A_k(15),
    "V": 2.1,
    "gm": 22
}
PARAMS_3 = {
    "A1": A_k(7),
    "A2": A_k(15),
    "A3": A_k(72),
    "V": 2.1,
    "gm": 22
}


plt.rcParams.update({'font.size': 15})
plt.rcParams['figure.dpi'] = 300

# rc('font',**{'family':'serif','serif':['Times']})
rc('text', usetex=True)

spins = np.arange(0.0, 25.0, 2.0)
core_terms_1 = [T_Core(PARAMS_FIT, I) for I in spins]
core_terms_2 = [T_Core(PARAMS_2, I) for I in spins]
core_terms_3 = [T_Core(PARAMS_3, I) for I in spins]

plt.figure(figsize=(5,4))

plt.plot(spins, core_terms_1, '-b', label=r'$A_1>A_2>A_3$')
plt.plot(spins, core_terms_2, '-m', label=r'$A_2>A_3>A_1$')
plt.plot(spins, core_terms_3, '-r', label=r'$A_3>A_2>A_1$')
plt.xlabel(r'$I$ [$\hbar$]')
plt.ylabel(r'$T_{core}$ [MeV]')
plt.legend(loc='best')
plt.savefig(plot_file, bbox_inches='tight')
plt.close()
