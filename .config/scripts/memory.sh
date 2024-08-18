#!/bin/bash

#memory usage in MiB
mem=$(free -m | awk '/Mem:/ {print $3}')

echo "${mem}"