#!/Users/robertpoenaru/.pyenv/shims/python

import numpy as np
from matplotlib import rc
import matplotlib.pyplot as plt

plot_file = 'T_SingleParticle.pdf'


# transfrom the angle from degrees into radians
def Rad(angle):
    return float(angle * np.pi / 180.0)


# transfrom the angle from radians into degrees
def Degrees(rad):
    return float(rad * 180.0 / np.pi)


# transfrom the moments of inertia into inertia parameters
def A_k(moi_k):
    return 1.0 / (2.0 * moi_k)


def T_SingleParticle(params, gm, j):
    A1 = params["A1"]
    A2 = params["A2"]
    A3 = params["A3"]
    V = params["V"]
    PI6 = np.pi / 6.0
    sin_gm = np.sin(Rad(gm) + PI6)
    T01 = 0.5 * (A2 + A3) * j
    T02 = A1 * np.power(j, 2)
    T03 = V * (2.0 * j - 1.0) / (j + 1.0) * sin_gm
    T_SP = T01 + T02 - T03
    return T_SP


PARAMS = {
    "A1": A_k(72),
    "A2": A_k(15),
    "A3": A_k(7),
    "V": 2.1,
    "gm": 22
}


j = 13.0 / 2.0
gammas = np.arange(-30, 61, 5)
sp_terms = [T_SingleParticle(PARAMS, x, j) for x in gammas]

plt.rcParams.update({'font.size': 15})
plt.rcParams['figure.dpi'] = 300

print(plt.rcParams['figure.dpi'])

# rc('font',**{'family':'serif','serif':['Times']})
rc('text', usetex=True)

plt.plot(gammas, sp_terms, '-b', label=r'$T_{s.p.}$')
plt.xlabel(r'$\gamma$ [$\hbar$]')
plt.ylabel(r'$T_{s.p.}$ [MeV]')
plt.legend(loc='best')
plt.savefig(plot_file, bbox_inches='tight')
plt.close()
