#!/usr/bin/env bash

for i in {1..610}; do
    python3 -W ignore calc_delay.py ./../rx/data/${i}.bin
done
