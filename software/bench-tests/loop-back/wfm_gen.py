import sys
import struct
import numpy as np
import matplotlib.pyplot as plt
from scipy import signal

# Parameters - LENGTH MUST BE  1360 x 8 = 10880
fs = 30.72e6
T = 1/fs
L = 10880

# Generate Time Vector
t = np.linspace(0, (L-1)*T, L)

# Generate Signal - 10kHz to 1MHz Chirp
f0 = 1e6
f1 = 15e6
t1 = L*T
x = signal.chirp(t, f0, t1, f1, method='linear', phi=0)
y = signal.chirp(t, f0, t1, f1, method='linear', phi=90)

# Generate Quantised DAC Values
i = np.round(x*2047)
q = np.round(y*2047)

# Create Interleaved Sample Buffer
f = open("wfm.bin","wb")
for n in range(0, L):
    
    f.write(struct.pack('h', int(i[n])))
    f.write(struct.pack('h', int(q[n])))

f.close()

# Plot Output Signal
fig = plt.figure(figsize=(9, 5))
plt.plot(t*1e6,i)
plt.plot(t*1e6,q)
plt.xlabel('Time [us]')
plt.ylabel('Signal')
plt.show()

