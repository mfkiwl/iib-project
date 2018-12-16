#!/usr/bin/env bash

for i in {1..15}; do
    python3 -W ignore calc_delay.py ./../tx/data/${i}.bin
done
python3 -W ignore rx_plot.py ../tx/data/10.bin
