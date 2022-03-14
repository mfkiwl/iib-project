# Matt's 4th Year Project

## GPSDO
This contains the design files and firmware for a GPS disciplined oscillator. It combines the frequency reference from a Ublox MAX-M8Q GPS module with a low jitter timing reference to create a very stable and accurate user defined frequency reference. There are two identical buffered clock outputs as well as a 1Hz PPS. The PPS output is used as a timing reference for synchronizing the output streams of multiple independent SDRs. There is also a command line application to view the status of the GPS and PLL live.

## Amplifiers
This folder contains PCB designs for custom LNA's and PA's that make use of Minicircuits range of amplifier ICs.

## Lime-SDR
This folder contains various resources such as the modified gateware running on the Lime Mini's MAX10 FPGA, the design files for a small PCB to break the 0.1" header on the Lime Mini out to an SMA connector, and a setup guide.

## Model
This folder contains some python notebooks that attempt to model the RF system, in addition to a MATLAB program to compute the position of a source based on some time of flight measurements using a least squares approach.

## Software
This folder contains applications written in C++ that make use of the LimeSuite LMS API.
