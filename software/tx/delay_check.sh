#!/usr/bin/env bash

for i in {1..15}; do
    python3 -W ignore delay.py ./data/${i}.bin
done
python3 -W ignore plot.py ./data/10.bin
