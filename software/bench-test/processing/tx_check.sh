#!/usr/bin/env bash

for i in {1..45}; do
    python3 -W ignore calc_delay.py ./../tx/data/${i}.bin
done
