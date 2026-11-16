#!/bin/bash

export SSLKEYLOGFILE=/home/kali/tcpdump_project/sslkeys.log
/usr/bin/google-chrome-stable &
sudo tcpdump host apd.nasa.gov -w capture.pcap -G 600 -C 1
