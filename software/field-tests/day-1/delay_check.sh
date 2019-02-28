#!/usr/bin/env bash

for i in {1..158}; do
    python3 -W ignore delay.py ./holdover-2/${i}.bin
done
python3 -W ignore plot.py ./holdover-2/130.bin
