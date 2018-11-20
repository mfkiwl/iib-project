#include <chrono>
#include <ctime>
#include <iostream>
#include <fstream>
#include <stdio.h>
#include "string.h"
#include "lime/LimeSuite.h"
#include "reciever_setup.h"

using namespace std;

// g++ main.cpp reciever_setup.cpp -std=c++11 -lLimeSuite -o rx-power-test.out

/* Entry Point */
int main(int argc, char** argv){

    /* Get Specs */
    float user_input_power;
    unsigned int user_rx_gain;
    cout << "Enter RX Gain (0 to 73 dB):" << endl;
    cin >> user_rx_gain;
    cout << "Enter Input Signal Power (dBm):" << endl;
    cin >> user_input_power;

    /* Hardware Config */
    reciever_configuration config;
    config.rx_centre_frequency = 868e6;                 // RX Center Freuency    
    config.rx_antenna = LMS_PATH_LNAW;                  // RX RF Path = 10MHz - 2GHz
    config.rx_gain = user_rx_gain;                      // RX Gain - 0 to 73 dB
    config.enable_rx_LPF = true;                        // Enable RX Low Pass Filter
    config.rx_LPF_bandwidth = 10e6;                     // RX Analog Low Pass Filter Bandwidth
    config.enable_rx_cal = true;                        // Enable RX Calibration
    config.rx_cal_bandwidth = 10e6;                     // Automatic Calibration Bandwidth
    
    config.sample_rate = 30.72e6;                       // Sample Rate 
    config.rf_oversample_ratio = 4;                     // ADC Oversample Ratio
    
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
    
    /* Output File */
    ofstream data_file;
    file_header file_metadata;
    const string out_path = "data/";
    
    /* Output Buffer */
    const int file_length = 128;
    int16_t file_buffer[rx_buffer_size * file_length];

    /* Start streaming */
    LMS_StartStream(&rx_stream);

    /* Let Stream Stabalise */
    for(int j=0; j<100; j++){
        LMS_RecvStream(&rx_stream, rx_buffer, num_rx_samples, &rx_metadata, 1000);
    }

    /* Record Samples */
    for(int k=0; k<file_length; k++){
        LMS_RecvStream(&rx_stream, rx_buffer, num_rx_samples, &rx_metadata, 1000);
        memcpy(&file_buffer[rx_buffer_size * k], rx_buffer, sizeof(rx_buffer));
    }

    /* Generate Metadata */
    file_metadata.unix_stamp = std::time(NULL);
    file_metadata.rx_gain = user_rx_gain;
    file_metadata.input_power = user_input_power;

    /* Write to File */
    string file_name = to_string(std::time(NULL)) + "_" + to_string((int)user_input_power) + "_" + to_string(user_rx_gain); 
    data_file.open(out_path + file_name + ".bin", std::ofstream::binary);
    data_file.write((char*)&file_metadata, sizeof(file_metadata));
    data_file.write((char*)file_buffer, sizeof(file_buffer));
    data_file.close();

    /* Stop Streaming */
    LMS_StopStream(&rx_stream);
    
    /* Destroy Stream */
    LMS_DestroyStream(device, &rx_stream);

    /* Disable RX Channel */
    if (LMS_EnableChannel(device, LMS_CH_RX, 0, false)!=0)
        error();

    /* Close Device */
    LMS_Close(device);

    /* Run Python Plotter */
    cout << endl;
    std::string args = "./data/" + file_name + ".bin";
    std::string filename = "./sample_plot.py ";
    std::string command = "python3 ";
    command = command + filename + args;
    system(command.c_str());

    return 0;
}