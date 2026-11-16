#!/bin/bash

sudo tcpdump -c 10 host 10.0.2.15 -C 1 -G 15 -w capture.pcap