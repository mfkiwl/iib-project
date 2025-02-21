EESchema Schematic File Version 4
EELAYER 26 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title "GPIO to PPS"
Date "2018-09-16"
Rev "1"
Comp "Matt Coates"
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L agg-kicad:CONN_01x05 J1
U 1 1 5B9ED1D1
P 4350 3500
F 0 "J1" H 4300 3600 50  0000 C CNN
F 1 "LimeMini" H 4400 3000 50  0000 C CNN
F 2 "agg:SIL-254P-05" H 4350 3500 50  0001 C CNN
F 3 "" H 4350 3500 50  0001 C CNN
	1    4350 3500
	1    0    0    -1  
$EndComp
$Comp
L agg-kicad:GND #PWR0101
U 1 1 5B9ED2BF
P 4550 3450
F 0 "#PWR0101" H 4420 3490 50  0001 L CNN
F 1 "GND" H 4550 3350 50  0000 C CNN
F 2 "" H 4550 3450 50  0001 C CNN
F 3 "" H 4550 3450 50  0001 C CNN
	1    4550 3450
	-1   0    0    1   
$EndComp
Wire Wire Line
	4450 3500 4550 3500
Wire Wire Line
	4550 3500 4550 3450
Wire Wire Line
	4450 3600 4850 3600
NoConn ~ 4450 3700
NoConn ~ 4450 3800
NoConn ~ 4450 3900
$Comp
L agg-kicad:COAX P1
U 1 1 5B9ED60D
P 4950 3600
F 0 "P1" H 5038 3620 50  0000 L CNN
F 1 "COAX" H 5038 3529 50  0000 L CNN
F 2 "gpio:SMA-J-P-H-ST-EM1" H 4950 3390 50  0001 C CNN
F 3 "" H 5050 3500 50  0001 C CNN
	1    4950 3600
	1    0    0    -1  
$EndComp
$Comp
L agg-kicad:GND #PWR0102
U 1 1 5B9ED69A
P 4800 3800
F 0 "#PWR0102" H 4670 3840 50  0001 L CNN
F 1 "GND" H 4800 3700 50  0000 C CNN
F 2 "" H 4800 3800 50  0001 C CNN
F 3 "" H 4800 3800 50  0001 C CNN
	1    4800 3800
	1    0    0    -1  
$EndComp
Wire Wire Line
	4800 3800 4800 3700
Wire Wire Line
	4800 3700 4850 3700
$EndSCHEMATC
