#!/usr/bin/env bash

for i in {1..15}; do
    python3 -W ignore calc_delay.py ./../rx/data/${i}.bin
done
python3 -W ignore rx_plot.py ../rx/data/10.bin
