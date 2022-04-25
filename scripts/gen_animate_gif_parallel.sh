#!/bin/bash

# Check it has been run with bash
if [ -n "$BASH_VERSION" ]; then
    :
else
    echo "This script must be run with bash" 1>&2
    echo "Usage: bash $0 <input.raw> <output.gif>" 1>&2
    exit 1
fi

# Check args
if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Usage: bash $0 <input.raw> <output.gif>" 1>&2
    exit 1
fi

# Check if gnu-parallel is installed
if ! type parallel > /dev/null; then
    printf "\033[1;31merror:\033[0m gnu-parallel is not installed\n" 1>&2
    exit 1
fi

# Get values
INPUT_FILE=$1
OUTPUT_FILE=$2

# Get info
FRAMES=$(target/display --info "$INPUT_FILE" 0 | grep frames | sed -e 's/frames\ =\ //g')
FRAMES=$(( $FRAMES - 1 ))

rm -rf GIF_TMP
mkdir -p GIF_TMP

# Gen gnuplot command
gen_gnuplot_command() {
    ID="$1"
    echo "set pm3d map"
    echo "set palette defined (0 '#000090', 1 '#000fff', 2 '#0090ff', 3 '#0fffee', 4 '#90ff70', 5 '#ffee00', 6 '#ff7000', 7 '#ee0000', 8 '#7f0000')"
    echo "set cbr [0:0.14]"
    echo "set terminal png size 1700,300"
    printf "set output './GIF_TMP/%04d.png'\n" "$ID"
    echo "splot \"< target/display --gnuplot $2 $ID\" u 1:2:4"
}

export -f gen_gnuplot_command

full_command() {
    PERCENT=$(echo "scale=4; $1 / $3 * 100" | bc -l)
    printf "Generating image %d/%d (%.2f%%)\r" $(( $1 + 1 )) $(( $3 + 1 )) $PERCENT
    gen_gnuplot_command "$1" "$2" | gnuplot
}

export -f full_command

start=$(date +%s.%N)
parallel -j 4 full_command {} "$INPUT_FILE" "$FRAMES" ::: $(seq 0 "$FRAMES")
printf "\n\033[1;34m==>\033[0m Generating \033[35m%s\033[0m...\n" $OUTPUT_FILE
convert ./GIF_TMP/*.png "$OUTPUT_FILE"
end=$(date +%s.%N)

elapsed=$(echo "scale=4; $end - $start" | bc -l)
printf "\nFinished generating GIF in \033[36m%.2fs\033[0m.\n" $elapsed
PWD=$(pwd)
printf "\033[1;32m[+]\033[0m %s\n" "${PWD}/${OUTPUT_FILE}"
