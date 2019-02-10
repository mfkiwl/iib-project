#!/usr/bin/env bash

for i in {1..10}; do
    python3 -W ignore calc_delay.py ./../rx/data/${i}.bin
done
python3 -W ignore rx_plot.py ../rx/data/4.bin
