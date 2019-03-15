#!/usr/bin/env bash

echo "Lock Test - 0dB Attenuation"
for i in {1..30}; do
    python3 -W ignore delay.py ./lock-test-0/${i}.bin
done


echo "Lock Test - 10dB Attenuation"
for i in {1..30}; do
    python3 -W ignore delay.py ./lock-test-10/${i}.bin
done


echo "Lock Test - 20dB Attenuation"
for i in {1..30}; do
    python3 -W ignore delay.py ./lock-test-20/${i}.bin
done


echo "Lock Test - 30dB Attenuation"
for i in {1..30}; do
    python3 -W ignore delay.py ./lock-test-30/${i}.bin
done


echo "Lock Test - LNA w/ 30dB Attenuation"
for i in {1..30}; do
    python3 -W ignore delay.py ./lock-test-30-lna/${i}.bin
done


echo "Lock Test - 40dB Attenuation"
for i in {1..30}; do
    python3 -W ignore delay.py ./lock-test-40/${i}.bin
done


echo "Lock Test - LNA w/ 40dB Attenuation"
for i in {1..30}; do
    python3 -W ignore delay.py ./lock-test-40-lna/${i}.bin
done


echo "Lock Test - 50dB Attenuation"
for i in {1..30}; do
    python3 -W ignore delay.py ./lock-test-50/${i}.bin
done


echo "Lock Test - LNA w/ 50dB Attenuation"
for i in {1..30}; do
    python3 -W ignore delay.py ./lock-test-50-lna/${i}.bin
done


echo "Lock Test - 60dB Attenuation [1]"
for i in {1..30}; do
    python3 -W ignore delay.py ./lock-test-60/${i}.bin
done


echo "Lock Test - 60dB Attenuation [2]"
for i in {1..30}; do
    python3 -W ignore delay.py ./lock-test-60-2/${i}.bin
done


echo "Lock Test - LNA w/ 60dB Attenuation"
for i in {1..30}; do
    python3 -W ignore delay.py ./lock-test-60-lna/${i}.bin
done


echo "RTT Test - 0dB Attenuation"
for i in {1..200}; do
    python3 -W ignore delay.py ./rtt-test-0/${i}.bin
done


echo "RTT Test - 30dB Attenuation"
for i in {1..200}; do
    python3 -W ignore delay.py ./rtt-test-30/${i}.bin
done


echo "RTT Test - LNA w/ 30dB Attenuation"
for i in {1..200}; do
    python3 -W ignore delay.py ./rtt-test-30-lna/${i}.bin
done
