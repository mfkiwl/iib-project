import sys
import struct
import numpy as np
from datetime import datetime
import matplotlib.pyplot as plt

# Useage
if len(sys.argv) != 2:
    print("Usage: {} <samples.bin>".format(sys.argv[0]))
    sys.exit(1)
    
# Open Datafile
file = open(sys.argv[1], 'rb')
    
# Compute Number of Samples Present
file.read()
num_samples = int((file.tell()-16)/4)
file.seek(0)
print("File contains", num_samples, "samples.")
dur = (1/30.72)*num_samples
print("Duration: %.4f us" % dur)
print("")

# Read Metadata
meta = struct.unpack('QIf', file.read(16))
print(datetime.utcfromtimestamp(meta[0]).strftime('%Y-%m-%d %H:%M:%S'))
print("RX Gain:", meta[1], 'dB')
print("Input Signal Power:", meta[2], 'dBm')

# Create I and Q Arrays
I = np.zeros(num_samples, dtype=float)
Q = np.zeros(num_samples, dtype=float)
for n in range(0, num_samples):
    
    I[n] = struct.unpack('h', file.read(2))[0]
    Q[n] = struct.unpack('h', file.read(2))[0]

# Creat Complex Array
samples = (I + 1j*Q)

# Find Signal Power
power_i = np.mean(np.square(I))
power_q = np.mean(np.square(Q))
peak_i = np.max(np.abs(I))
peak_q = np.max(np.abs(Q))

print("I Power = ", power_i, "\nQ Power = ", power_q)
print("I Peak = ", peak_i, "\nQ Peak = ", peak_q)

# Plot I&Q Channels
plt.plot(np.real(samples[0:1360]), label='I')
plt.plot(np.imag(samples[0:1360]), label='Q')
plt.grid(True)  
plt.legend(loc='upper right', frameon=True)
plt.show()