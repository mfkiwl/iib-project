#!/usr/bin/env bash

for i in {1..60}; do
    python3 -W ignore calc_delay.py ./data/${i}.bin
done