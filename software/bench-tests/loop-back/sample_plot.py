import sys
import struct
import numpy as np
from scipy import signal
from datetime import datetime
import matplotlib.pyplot as plt

# Useage
if len(sys.argv) != 2:
    print("Usage: {} <samples.bin>".format(sys.argv[0]))
    sys.exit(1)
    
# Data Files
sample_file = open(sys.argv[1], 'rb')
wfm_file = open('wfm.bin', 'rb')
    
# Compute Number of Samples Present
sample_file.read()
num_samples = int((sample_file.tell()-24)/4)
sample_file.seek(0)
print("File contains", num_samples, "samples (%d buffers)" % int(num_samples/1360))
dur = (1/30.72)*num_samples
print("Duration: %.4f us" % dur)
print("")

# Read Sample Metadata
meta = struct.unpack('QQQ', sample_file.read(24))
print(datetime.utcfromtimestamp(meta[0]).strftime('%Y-%m-%d %H:%M:%S'))
print("File begins with sample", meta[1])
print("PPS sync occured at sample", meta[2])
tx_start =  meta[2] + 1360*175
offset = tx_start - meta[1]
print("TX begins at sample", tx_start)
print("Offset = ", offset)

# Extract I and Q Channels
smp_I = np.zeros(num_samples, dtype=float)
smp_Q = np.zeros(num_samples, dtype=float)
for n in range(0, num_samples):
    
    smp_I[n] = struct.unpack('h', sample_file.read(2))[0]
    smp_Q[n] = struct.unpack('h', sample_file.read(2))[0]

# Complex Sample Array
samples = (smp_I + 1j*smp_Q)

# Plot Complex Samples
plt.figure(1)
plt.title('Recieved Signal')
plt.plot(np.real(samples), label='I')
plt.plot(np.imag(samples), label='Q')
plt.grid(True)  
plt.legend(loc='upper right', frameon=True)


# Read in Waveform
wfm_file.read()
wfm_samples = int(wfm_file.tell()/4)
wfm_file.seek(0)
wfm_I = np.zeros(wfm_samples, dtype=float)
wfm_Q = np.zeros(wfm_samples, dtype=float)
for n in range(0, wfm_samples):
    
    wfm_I[n] = struct.unpack('h', wfm_file.read(2))[0]
    wfm_Q[n] = struct.unpack('h', wfm_file.read(2))[0]

# Complex Waveform Array
waveform = (wfm_I + 1j*wfm_Q)

# Plot Complex Waveform
plt.figure(2)
plt.title('Baseband Waveform')
plt.plot(np.real(waveform), label='I')
plt.plot(np.imag(waveform), label='Q')
plt.grid(True)  
plt.legend(loc='upper right', frameon=True)


# Compute Cross Correlation
c = signal.correlate(np.asarray(np.real(samples)), np.asarray(np.real(waveform)), 'same')
c2 = signal.correlate(np.asarray(np.imag(samples)), np.asarray(np.imag(waveform)), 'same')

# Plot Output
f,axarr = plt.subplots(2, sharex=True)
axarr[0].set_title('Cross Correlation of I&Q')
axarr[0].plot(c)
axarr[1].plot(c2)

# Stats
print('')
print('I Channel: ')
print('Offset =', offset)
print('Correlation Peak =', np.argmax(c))
print('Measured Offset =', np.argmax(c)-(wfm_samples/2))
print('Difference =', np.argmax(c)-(wfm_samples/2) - offset)
print('')
print('Q Channel: ')
print('Offset =', offset)
print('Correlation Peak =', np.argmax(c2))
print('Measured Offset =', np.argmax(c2)-(wfm_samples/2))
print('Difference =', np.argmax(c2)-(wfm_samples/2) - offset)

plt.show()


