#include <chrono>
#include <ctime>
#include <iostream>
#include <fstream>
#include <stdio.h>
#include "string.h"
#include "lime/LimeSuite.h"
#include "reciever_setup.h"

using namespace std;

// g++ main.cpp reciever_setup.cpp -std=c++11 -lLimeSuite -o vctcxo.out

/* Entry Point */
int main(int argc, char** argv){

    /* Hardware Config */
    reciever_configuration config;
    config.rx_centre_frequency = 868e6;                 // RX Center Freuency    
    config.rx_antenna = LMS_PATH_LNAW;                  // RX RF Path = 10MHz - 2GHz
    config.rx_gain = 0.7;                               // RX Normalised Gain - 0 to 1.0
    config.enable_rx_LPF = true;                        // Enable RX Low Pass Filter
    config.rx_LPF_bandwidth = 10e6;                     // RX Analog Low Pass Filter Bandwidth
    config.enable_rx_cal = true;                        // Enable RX Calibration
    config.rx_cal_bandwidth = 8e6;                      // Automatic Calibration Bandwidth
    
    config.sample_rate = 30.72e6;                       // Sample Rate 
    config.rf_oversample_ratio = 1;                     // ADC Oversample Ratio
    
    configure_reciever(config);
    
    /* RX Stream Config  */
    lms_stream_t rx_stream;
    rx_stream.channel = 0;                              // Channel Number
    rx_stream.fifoSize = 1360 * 4096;                   // Fifo Size in Samples
    rx_stream.throughputVsLatency = 1.0;                // Optimize Throughput (1.0) or Latency (0)
    rx_stream.isTx = false;                             // TX/RX Channel
    rx_stream.dataFmt = lms_stream_t::LMS_FMT_I12;      // Data Format - 12-bit sample stored as int16_t
    LMS_SetupStream(device, &rx_stream);

    /* RX Data Buffer */
    const int num_rx_samples = 1360;
    const int rx_buffer_size = num_rx_samples * 2;
    int16_t rx_buffer[rx_buffer_size];
    
    /* RX Stream Metadata */
    lms_stream_meta_t rx_metadata;

    /* Book Keeping Indicies */
    int i = 0;
    uint64_t freq = 0;
    uint64_t pps_sync_idx = 0;
    uint64_t prev_pps_sync_idx = 0;

    /* LMS7 Temperature */
    float_type temp = 0;

    /* VCTCXO DAC Controller - 0 to 4095 -> 0v to 2.538v */
    uint16_t dac_value = 2972;
    uint16_t tmp_value = 0;
    uint64_t target_freq = 30720000;
    bool dac_updated = false;
    
    /* Write & Read DAC */
    LMS_VCTCXORead(device, &tmp_value);
    cout << "DAC = " << tmp_value << endl;
    cout << "Writing " << dac_value << " to DAC..." <<endl;
    LMS_VCTCXOWrite(device, dac_value);
    LMS_VCTCXORead(device, &tmp_value);
    cout << "DAC = " << tmp_value << endl;

    /* Start streaming */
    LMS_StartStream(&rx_stream);

    /* Process Stream for 300s */
    auto t1 = chrono::high_resolution_clock::now();
    auto t2 = t1;
    while (chrono::high_resolution_clock::now() - t1 < chrono::seconds(300)){

        /* Read Samples into Buffer */
        if(LMS_RecvStream(&rx_stream, rx_buffer, num_rx_samples, &rx_metadata, 1000) != num_rx_samples){
            LMS_StopStream(&rx_stream);
            LMS_DestroyStream(device, &rx_stream);
            error();
        };

        /* Check PPS Sync Flag - MSB Set */
        if((rx_metadata.timestamp & 0x8000000000000000) == 0x8000000000000000){
            
            /* Extract PPS Sync Index - Clear MSB */
            prev_pps_sync_idx = pps_sync_idx;
            pps_sync_idx = rx_metadata.timestamp ^ 0x8000000000000000;
            
            /* Test for Unique PPS Event */
            if (pps_sync_idx != prev_pps_sync_idx){
                
                /* Calculate True Frequency */
                freq = pps_sync_idx - prev_pps_sync_idx;
                cout << "Freq: " << freq << endl;

                /* VCTCXO Tuning */
                if(dac_updated){
                    dac_updated = false;
                } else {
                    
                    /* Below Targe Frequency e.g. 30719997 and below */
                    if(freq < target_freq - 1){
                        dac_value += 1;
                        LMS_VCTCXOWrite(device, dac_value);
                        dac_updated = true;
                        cout << "DAC updated to " << dac_value << endl;
                    }
                    
                    /* Above Target Frequency e.g. 30720003 and above */
                    if(freq > target_freq + 1){
                        dac_value -= 1;
                        LMS_VCTCXOWrite(device, dac_value);
                        dac_updated = true;
                        cout << "DAC updated to " << dac_value << endl;
                    }
                }
            }
        }
    }

    /* Stop Streaming */
    LMS_StopStream(&rx_stream);
    
    /* Destroy Stream */
    LMS_DestroyStream(device, &rx_stream);

    /* Disable RX Channel */
    if (LMS_EnableChannel(device, LMS_CH_RX, 0, false)!=0)
        error();

    /* Close Device */
    LMS_Close(device);

    return 0;
}