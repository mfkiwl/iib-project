#include <ctime>
#include <chrono>
#include <thread>
#include <math.h>
#include <fstream>
#include <stdio.h>
#include <iostream>
#include "string.h"
#include "lime/LimeSuite.h"
#include "tranciever_setup.h"
using namespace std;

// g++ main.cpp tranciever_setup.cpp -std=c++11 -lLimeSuite -o rf-loop.out

/* Entry Point */
int main(int argc, char** argv){
    
    /* Hardware Config */
    tranciever_configuration config;
    config.rx_centre_frequency = 868e6;                 // RX Center Freuency    
    config.rx_antenna = LMS_PATH_LNAW;                  // RX RF Path = 10MHz - 2GHz
    config.rx_gain = 55;                                // RX Gain 0 to 73 dB
    config.enable_rx_LPF = false;                       // Disable RX Low Pass Filter
    config.rx_LPF_bandwidth = 10e6;                     // RX Analog Low Pass Filter Bandwidth
    config.enable_rx_cal = true;                        // Enable RX Calibration
    config.rx_cal_bandwidth = 25e6;                     // Automatic Calibration Bandwidth
    
    config.tx_centre_frequency = 2.4e9;                 // TX Center Freuency
    config.tx_antenna = LMS_PATH_TX1;                   // TX RF Path = 2GHz - 3GHz
    config.tx_gain = 60;                                // TX Gain 0 to 73 dB
    config.enable_tx_LPF = false;                       // Disable TX Low Pass Filter
    config.tx_LPF_bandwidth = 10e6;                     // TX Analog Low Pass Filter Bandwidth
    config.enable_tx_cal = true;                        // Enable TX Calibration
    config.tx_cal_bandwidth = 25e6;                     // Automatic Calibration Bandwidth
    
    config.sample_rate = 30.72e6;                       // Device Sample Rate 
    config.rf_oversample_ratio = 4;                     // ADC Oversample Ratio
    
    configure_tranciever(config);


    /* Enable RF Loopback */
    LMS_WriteParam(device, LMS7_TX_MUX, 2);
    LMS_WriteParam(device, LMS7_TXWRCLK_MUX, 2);


    /* TxTSP */
    LMS_WriteParam(device, LMS7_MAC, 1);
    LMS_WriteParam(device, LMS7_EN_TXTSP, 1);
    LMS_WriteParam(device, LMS7_CMIX_BYP_TXTSP, 1);
    LMS_WriteParam(device, LMS7_ISINC_BYP_TXTSP, 1);
    LMS_WriteParam(device, LMS7_GFIR3_BYP_TXTSP, 1);
    LMS_WriteParam(device, LMS7_GFIR2_BYP_TXTSP, 1);
    LMS_WriteParam(device, LMS7_GFIR1_BYP_TXTSP, 1);
    LMS_WriteParam(device, LMS7_DC_BYP_TXTSP, 0);
    LMS_WriteParam(device, LMS7_GC_BYP_TXTSP, 0);
    LMS_WriteParam(device, LMS7_PH_BYP_TXTSP, 0);

    /* RxTSP */
    LMS_WriteParam(device, LMS7_MAC, 1);
    LMS_WriteParam(device, LMS7_EN_RXTSP, 1);
    LMS_WriteParam(device, LMS7_CMIX_BYP_RXTSP, 1);
    LMS_WriteParam(device, LMS7_AGC_BYP_RXTSP, 1);
    LMS_WriteParam(device, LMS7_GFIR3_BYP_RXTSP, 1);
    LMS_WriteParam(device, LMS7_GFIR2_BYP_RXTSP, 1);
    LMS_WriteParam(device, LMS7_GFIR1_BYP_RXTSP, 1);
    LMS_WriteParam(device, LMS7_DC_BYP_RXTSP, 0);
    LMS_WriteParam(device, LMS7_GC_BYP_RXTSP, 0);
    LMS_WriteParam(device, LMS7_PH_BYP_RXTSP, 0);
    LMS_WriteParam(device, LMS7_DCLOOP_STOP, 0);
    LMS_WriteParam(device, LMS7_DCCORR_AVG_RXTSP, 6);

    
    /* Program Termination */
    char exit_char;
    cout << endl << "Press Any  Key + Enter to Exit" << endl;
    cin >> exit_char;

    /* Disable TX/RX Channels */
    if (LMS_EnableChannel(device, LMS_CH_TX, 0, false)!=0)
        error();
    if (LMS_EnableChannel(device, LMS_CH_RX, 0, false)!=0)
        error();
       
    /* Close Device */
    if (LMS_Close(device)==0)
        cout << "Device closed" << endl;

    return 0;
}
