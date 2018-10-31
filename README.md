# Matt's 4th Year Project

## GPSDO
This contains the design files and firmware for a GPS disciplined oscillator. It combines the frequency reference from a Ublox MAX-M8Q GPS module with a low jitter timing reference to create a very stable and accurate user defined frequency reference. There are two identical buffered clock outputs as well as a 1Hz PPS. The PPS output is used as a timing reference for synchronizing the output streams of multiple independent SDRs. There is also a command line application to view the status of the GPS and PLL live.

## AMP
This folder contains PCB designs for custom LNA's and PA's that make use of Minicircuits range of amplifier ICs.

## Lime-SDR
This folder contains various resources such as the modified gateware running on the Lime Mini's MAX10 FPGA, the design files for a small PCB to break the 0.1" header on the Lime Mini out to an SMA connector, and a setup guide.

## Model
This folder contains some python notebooks that attempt to model the RF system, in addition to a MATLAB program to compute the position of a source based on some time of flight measurements.

## Software
This folder contains some prototype applications written in C++ that make use of the LimeSuite LMS API.

### pps_delta
This is a simple application used to measure the number of samples between PPS events in order to check the true frequency of the PLL.

### pps_rx_sync
This program produces an output file each second that contains a header followed by a buffer of interleaved IQ samples in int16_t format. The header specifies the index of the first sample in the buffer and the index of the sample corresponding to the PPS trigger event as well as a unix timestamp for the file.

### pps_tx_sync
This program transmitts a buffer of samples once per second, with the transmission occuring a predefined number of samples after the PPS event. Assuming there is some external loopback path the program also records the TX event and writes this out to file, along with the relevant metadata. The baseband waveform to be sent can be generated using the included python script and the C++ application will load this data into the TX buffer each time it runs. There is also a script to plot the recieved samples and cross correlate this with the original signal.

### vctcxo
This program demonstrates tuning the onboard VCTCXO against an external PPS reference.

### rx_power
This program records a bunch of samples from the SDR at a gain defined by the user and then computes the power of the recieved signal in lime units. This program was used to characterise the relationship between the signal power in lime units and dBm.

### tx_testing
This program demonstrates how to succesfully specify at what sample the transmission of a buffer should occur, and how to the record the transmission in order to verify when it occured, which initially proved problematic!
