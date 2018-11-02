#!/bin/bash
# usage: cd merlin/egs/mandarin_voice/s1, then run `bash run_demo.sh`

train_tts=true
run_tts=true
voice_name="mandarin_voice"
demo_voice=thchs30_250_demo
data_url=https://github.com/Jackiexiao/MTTS/releases/download/v0.1/thchs30_250_demo.tar.gz

if [ ! -f ${demo_voice}.tar.gz ]; then
    echo "downloading data......"
    wget $data_url
    tar -zxvf ${demo_voice}.tar.gz
    mkdir -p database
    cp -r ${demo_voice}/* database
fi

# train tts system
if [ "$train_tts" = true ]; then
    # step 1: run setup and check data
    ./01_setup.sh $voice_name

    # step 4: prepare config files for training and testing
    ./04_prepare_conf_files.sh conf/global_settings.cfg

fi

# run tts
if [ "$run_tts" = true ]; then

    # step 7: run text to speech
   ./07_run_merlin.sh conf/test_dur_synth_${voice_name}.conf conf/test_synth_${voice_name}.conf

fi

echo "done...!"
