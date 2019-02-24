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
wfm_file = open('./wfm.bin', 'rb')
    
# Compute Number of Samples Present
sample_file.read()
num_samples = int((sample_file.tell()-24)/4)
sample_file.seek(0)

# Read Data Capture Metadata
meta = struct.unpack('QQQ', sample_file.read(24))
tx_start =  meta[2] + 1360*1800
offset = tx_start - meta[1]

# Extract I and Q Channels
smp_I = np.zeros(num_samples, dtype=float)
smp_Q = np.zeros(num_samples, dtype=float)
for n in range(0, num_samples):
    
    smp_I[n] = struct.unpack('h', sample_file.read(2))[0]
    smp_Q[n] = struct.unpack('h', sample_file.read(2))[0]

# Complex Sample Array
samples = (smp_I + 1j*smp_Q)

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

# Compute Cross Correlation
c = np.absolute(signal.correlate(np.asarray(np.real(samples)), np.asarray(np.real(waveform)), 'same'))
c2 = np.absolute(signal.correlate(np.asarray(np.imag(samples)), np.asarray(np.imag(waveform)), 'same'))

# Search for Peak
delay_i = -1
delay_q = -1
while delay_i < 0:
    peak_idx_i = np.argmax(c)
    measured_offset_i = peak_idx_i - (wfm_samples/2)
    delay_i = measured_offset_i - offset
    c[peak_idx_i] = 0

while delay_q < 0:
    peak_idx_q = np.argmax(c2)
    measured_offset_q = peak_idx_q - (wfm_samples/2)
    delay_q = measured_offset_q - offset
    c2[peak_idx_q] = 0

print(delay_i, '    ',delay_q)
