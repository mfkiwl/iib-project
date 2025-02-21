EESchema Schematic File Version 4
LIBS:pa-cache
EELAYER 26 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L agg-kicad:12v #PWR01
U 1 1 5BE11335
P 1700 1250
F 0 "#PWR01" H 1700 1360 50  0001 L CNN
F 1 "12v" H 1700 1350 50  0000 C CNN
F 2 "" H 1700 1250 50  0001 C CNN
F 3 "" H 1700 1250 50  0001 C CNN
	1    1700 1250
	1    0    0    -1  
$EndComp
$Comp
L agg-kicad:GND #PWR02
U 1 1 5BE11396
P 1700 1500
F 0 "#PWR02" H 1570 1540 50  0001 L CNN
F 1 "GND" H 1700 1400 50  0000 C CNN
F 2 "" H 1700 1500 50  0001 C CNN
F 3 "" H 1700 1500 50  0001 C CNN
	1    1700 1500
	1    0    0    -1  
$EndComp
$Comp
L agg-kicad:CONN_01x02 J1
U 1 1 5BE11485
P 1525 1325
F 0 "J1" H 1500 1425 50  0000 C CNN
F 1 "PWR" H 1525 1125 50  0000 C CNN
F 2 "agg:B02B-PASK" H 1525 1325 50  0001 C CNN
F 3 "" H 1525 1325 50  0001 C CNN
F 4 "512-8585" H 1525 1325 50  0001 C CNN "RS"
	1    1525 1325
	1    0    0    -1  
$EndComp
Wire Wire Line
	1625 1325 1700 1325
Wire Wire Line
	1700 1325 1700 1250
Wire Wire Line
	1625 1425 1700 1425
Wire Wire Line
	1700 1425 1700 1500
$Comp
L agg-kicad:COAX P1
U 1 1 5BE1168E
P 2200 1275
F 0 "P1" H 2275 1375 50  0000 C CNN
F 1 "RF IN" H 2225 1100 50  0000 C CNN
F 2 "agg:SMA-EDGE" H 2200 1065 50  0001 C CNN
F 3 "" H 2300 1175 50  0001 C CNN
F 4 "1608592" H 2200 995 50  0001 C CNN "Farnell"
	1    2200 1275
	-1   0    0    -1  
$EndComp
$Comp
L agg-kicad:GND #PWR03
U 1 1 5BE117A3
P 2400 1475
F 0 "#PWR03" H 2270 1515 50  0001 L CNN
F 1 "GND" H 2400 1375 50  0000 C CNN
F 2 "" H 2400 1475 50  0001 C CNN
F 3 "" H 2400 1475 50  0001 C CNN
	1    2400 1475
	1    0    0    -1  
$EndComp
Wire Wire Line
	2400 1475 2400 1375
Wire Wire Line
	2400 1375 2300 1375
$Comp
L agg-kicad:COAX P2
U 1 1 5BE1182C
P 4925 1275
F 0 "P2" H 5000 1375 50  0000 C CNN
F 1 "RF OUT" H 4950 1100 50  0000 C CNN
F 2 "agg:SMA-EDGE" H 4925 1065 50  0001 C CNN
F 3 "" H 5025 1175 50  0001 C CNN
F 4 "1608592" H 4925 995 50  0001 C CNN "Farnell"
	1    4925 1275
	1    0    0    -1  
$EndComp
$Comp
L agg-kicad:GND #PWR08
U 1 1 5BE11914
P 4725 1475
F 0 "#PWR08" H 4595 1515 50  0001 L CNN
F 1 "GND" H 4725 1375 50  0000 C CNN
F 2 "" H 4725 1475 50  0001 C CNN
F 3 "" H 4725 1475 50  0001 C CNN
	1    4725 1475
	-1   0    0    -1  
$EndComp
Wire Wire Line
	4725 1475 4725 1375
Wire Wire Line
	4725 1375 4825 1375
$Comp
L agg-kicad:PHA-202+ IC1
U 1 1 5BE11B15
P 3450 1475
F 0 "IC1" H 3100 1775 50  0000 C CNN
F 1 "PHA-202+" H 3250 1175 50  0000 C CNN
F 2 "agg:DL1636" H 3050 1075 50  0001 L CNN
F 3 "https://ww2.minicircuits.com/pdfs/PHA-202+.pdf" H 3050 975 50  0001 L CNN
F 4 "PHA-202+" H 3050 875 50  0001 L CNN "Minicircuits"
	1    3450 1475
	1    0    0    -1  
$EndComp
$Comp
L agg-kicad:C C1
U 1 1 5BE11CB7
P 2575 1275
F 0 "C1" H 2625 1350 39  0000 C CNN
F 1 "0.01u" H 2625 1200 39  0000 C CNN
F 2 "agg:0402" H 2575 1275 50  0001 C CNN
F 3 "" H 2575 1275 50  0001 C CNN
F 4 "80-C0402T103K4RACTU" H 2575 1275 50  0001 C CNN "Mouser"
	1    2575 1275
	1    0    0    -1  
$EndComp
$Comp
L agg-kicad:L L1
U 1 1 5BE11D3F
P 4150 1000
F 0 "L1" V 4162 1041 39  0000 L CNN
F 1 "5.6u" V 4237 1041 39  0000 L CNN
F 2 "agg:WA8514-AE" H 4150 1000 50  0001 C CNN
F 3 "https://www.coilcraft.com/pdfs/wa8514.pdf" H 4150 1000 50  0001 C CNN
	1    4150 1000
	0    1    1    0   
$EndComp
$Comp
L agg-kicad:GND #PWR04
U 1 1 5BE123F7
P 2850 1775
F 0 "#PWR04" H 2720 1815 50  0001 L CNN
F 1 "GND" H 2850 1675 50  0000 C CNN
F 2 "" H 2850 1775 50  0001 C CNN
F 3 "" H 2850 1775 50  0001 C CNN
	1    2850 1775
	1    0    0    -1  
$EndComp
Wire Wire Line
	2850 1375 2950 1375
Wire Wire Line
	2950 1475 2850 1475
Wire Wire Line
	2850 1375 2850 1475
Connection ~ 2850 1475
Wire Wire Line
	2950 1575 2850 1575
Wire Wire Line
	2850 1475 2850 1575
Connection ~ 2850 1575
Wire Wire Line
	2850 1575 2850 1675
Wire Wire Line
	2950 1675 2850 1675
Connection ~ 2850 1675
Wire Wire Line
	2850 1675 2850 1775
$Comp
L agg-kicad:GND #PWR05
U 1 1 5BE12757
P 4050 1775
F 0 "#PWR05" H 3920 1815 50  0001 L CNN
F 1 "GND" H 4050 1675 50  0000 C CNN
F 2 "" H 4050 1775 50  0001 C CNN
F 3 "" H 4050 1775 50  0001 C CNN
	1    4050 1775
	1    0    0    -1  
$EndComp
Wire Wire Line
	4050 1775 4050 1575
Wire Wire Line
	4050 1575 3950 1575
Wire Wire Line
	4050 1375 4050 1475
Connection ~ 4050 1575
Wire Wire Line
	3950 1375 4050 1375
Wire Wire Line
	4050 1475 3950 1475
Connection ~ 4050 1475
Wire Wire Line
	4050 1475 4050 1575
Wire Wire Line
	2675 1275 2950 1275
Wire Wire Line
	2300 1275 2575 1275
$Comp
L agg-kicad:C C3
U 1 1 5BE1393B
P 4450 1275
F 0 "C3" H 4500 1350 39  0000 C CNN
F 1 "0.01u" H 4500 1200 39  0000 C CNN
F 2 "agg:0402" H 4450 1275 50  0001 C CNN
F 3 "" H 4450 1275 50  0001 C CNN
F 4 "80-C0402T103K4RACTU" H 4450 1275 50  0001 C CNN "Mouser"
	1    4450 1275
	1    0    0    -1  
$EndComp
$Comp
L agg-kicad:C C2
U 1 1 5BE144C5
P 4400 900
F 0 "C2" H 4450 975 39  0000 C CNN
F 1 "0.01u" H 4450 825 39  0000 C CNN
F 2 "agg:0402" H 4400 900 50  0001 C CNN
F 3 "" H 4400 900 50  0001 C CNN
F 4 "80-C0402T103K4RACTU" H 4400 900 50  0001 C CNN "Mouser"
	1    4400 900 
	1    0    0    -1  
$EndComp
$Comp
L agg-kicad:12v #PWR06
U 1 1 5BE146DE
P 4150 800
F 0 "#PWR06" H 4150 910 50  0001 L CNN
F 1 "12v" H 4150 900 50  0000 C CNN
F 2 "" H 4150 800 50  0001 C CNN
F 3 "" H 4150 800 50  0001 C CNN
	1    4150 800 
	1    0    0    -1  
$EndComp
Wire Wire Line
	4150 800  4150 900 
Wire Wire Line
	4400 900  4150 900 
Connection ~ 4150 900 
Wire Wire Line
	4150 900  4150 1000
Wire Wire Line
	3950 1275 4150 1275
Wire Wire Line
	4150 1275 4150 1100
$Comp
L agg-kicad:GND #PWR07
U 1 1 5BE14F7D
P 4550 900
F 0 "#PWR07" H 4420 940 50  0001 L CNN
F 1 "GND" H 4550 800 50  0000 C CNN
F 2 "" H 4550 900 50  0001 C CNN
F 3 "" H 4550 900 50  0001 C CNN
	1    4550 900 
	0    -1   1    0   
$EndComp
Wire Wire Line
	4500 900  4550 900 
Wire Wire Line
	4150 1275 4450 1275
Connection ~ 4150 1275
Wire Wire Line
	4550 1275 4825 1275
$Comp
L agg-kicad:PART X1
U 1 1 5BE16733
P 5350 925
F 0 "X1" H 5400 1025 50  0000 L CNN
F 1 "M3 Hole" H 5400 925 50  0000 L CNN
F 2 "agg:M3_MOUNT" H 5350 925 50  0001 C CNN
F 3 "" H 5350 925 50  0001 C CNN
	1    5350 925 
	1    0    0    -1  
$EndComp
$Comp
L agg-kicad:PART X2
U 1 1 5BE16817
P 5350 1150
F 0 "X2" H 5400 1250 50  0000 L CNN
F 1 "M3 Hole" H 5400 1150 50  0000 L CNN
F 2 "agg:M3_MOUNT" H 5350 1150 50  0001 C CNN
F 3 "" H 5350 1150 50  0001 C CNN
	1    5350 1150
	1    0    0    -1  
$EndComp
$EndSCHEMATC
