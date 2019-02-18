#!/usr/bin/env bash

for i in {1..70}; do
    python3 -W ignore calc_delay.py ./../round-trip/data/${i}.bin
done
python3 -W ignore rx_plot.py ../round-trip/data/10.bin
