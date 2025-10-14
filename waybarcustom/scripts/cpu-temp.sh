#!/usr/bin/env bash

# ambil suhu dari thermal_zone1 (x86_pkg_temp = CPU)
temp=$(cat /sys/class/thermal/thermal_zone1/temp)
temp_c=$((temp / 1000))

# output dalam format JSON untuk Waybar
echo "{\"text\": \"${temp_c}°C\", \"alt\": \"cpu\", \"tooltip\": \"CPU Temperature: ${temp_c}°C\"}"
