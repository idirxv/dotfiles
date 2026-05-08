# shellcheck shell=bash
# Prints CPU usage percentage with icon

run_segment() {
	local cpu_icon="󰍛"
	local user1 nice1 system1 idle1 iowait1 irq1 softirq1 steal1
	local user2 nice2 system2 idle2 iowait2 irq2 softirq2 steal2

	read -r _ user1 nice1 system1 idle1 iowait1 irq1 softirq1 steal1 _ < /proc/stat
	sleep 0.2
	read -r _ user2 nice2 system2 idle2 iowait2 irq2 softirq2 steal2 _ < /proc/stat

	local total1=$((user1 + nice1 + system1 + idle1 + iowait1 + irq1 + softirq1 + steal1))
	local total2=$((user2 + nice2 + system2 + idle2 + iowait2 + irq2 + softirq2 + steal2))
	local dtotal=$((total2 - total1))
	local didle=$(( (idle2 + iowait2) - (idle1 + iowait1) ))

	if [[ $dtotal -eq 0 ]]; then
		return 1
	fi

	local pct=$(( (dtotal - didle) * 100 / dtotal ))
	echo "${cpu_icon} ${pct}%"
	return 0
}
