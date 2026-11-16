#!/bin/bash

sudo tcpdump port 22 -i any -G 600 -C 2 -w proof.pcap
