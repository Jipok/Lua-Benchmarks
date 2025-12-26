#!/bin/bash

BASE_NAME=${1:-results}
NBINARIES=$(head -n1 "${BASE_NAME}.dat" | awk '{print NF-1}')

# Check if data exists
if [ ! -f "${BASE_NAME}.dat" ]; then
    echo "Error: ${BASE_NAME}.dat not found."
    exit 1
fi

echo "Generating plots for ${BASE_NAME} using ${NBINARIES} binaries..."

# 1. Plot Raw Time
gnuplot -e "datafile='${BASE_NAME}.dat'" \
        -e "outfile='${BASE_NAME}.png'" \
        -e "ylabel='Elapsed time (sec)'" \
        -e "nbinaries=${NBINARIES}" \
        plot.gpi
echo "Created ${BASE_NAME}.png"

# 2. Plot Normalized Time
gnuplot -e "datafile='${BASE_NAME}-norm.dat'" \
        -e "outfile='${BASE_NAME}-norm.png'" \
        -e "ylabel='Normalized time (lower is better)'" \
        -e "nbinaries=${NBINARIES}" \
        plot.gpi
echo "Created ${BASE_NAME}-norm.png"

# 3. Plot Speedup
gnuplot -e "datafile='${BASE_NAME}-speed.dat'" \
        -e "outfile='${BASE_NAME}-speed.png'" \
        -e "ylabel='Speedup factor (higher is better)'" \
        -e "nbinaries=${NBINARIES}" \
        plot.gpi
echo "Created ${BASE_NAME}-speed.png"
