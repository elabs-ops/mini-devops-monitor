#!/bin/sh

CPU_LOAD=$(uptime | awk -F'load average:' '{print $2}' | sed 's/ //g')
M1=$(echo "$CPU_LOAD" | cut -d',' -f1)
M5=$(echo "$CPU_LOAD" | cut -d',' -f2)
M10=$(echo "$CPU_LOAD" | cut -d',' -f3)

RAM_METRICS=$(free --mega | grep Mem)
TOTAL_RAM=$(echo "$RAM_METRICS" | awk '{print $2}')
USED_RAM=$(echo "$RAM_METRICS" | awk '{print $3}')
RAM_RATIO=$(echo "$RAM_METRICS" | awk '{printf "%.2f", ($3/$2) * 100}')%

DISK_DATA=$(df -h / | tail -n 1)
DISK_AVAIL=$(echo "$DISK_DATA" | awk '{print $4}')
DISK_USE_PCT=$(echo "$DISK_DATA" | awk '{print $5}')


cat <<-EOF
{
	"hostname": "$(hostname)",
	"cpu_load": {
		"1m": "$M1",
		"5m": "$M5",
		"10m": "$M10"
	},
	"ram_metrics": {
		"total_mo": "$TOTAL_RAM",
		"used_mo": "$USED_RAM",
		"ratio": "$RAM_RATIO"
	},
	"disk_metrics": {
		"available": "$DISK_AVAIL",
		"use_pct": "$DISK_USE_PCT"
	}
}
EOF
