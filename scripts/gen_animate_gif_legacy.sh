#!/bin/bash

# Check args
if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Usage: bash $0 <input.raw> <output.gif>" 1>&2
    exit 1
fi

# Get values
INPUT_FILE=$1
OUTPUT_FILE=$2

# Get info
FRAMES=$(target/display --info $INPUT_FILE 0 | grep frames | sed -e "s/frames\ =\ //g")
FRAMES=$(( $FRAMES - 1 ))

mkdir -p GIF_TMP

# Gen gnuplot command
gen_gnuplot_command() {
    ID=$1
    echo "set pm3d map"
    echo "set palette defined (0 '#000090', 1 '#000fff',2 '#0090ff',3 '#0fffee', 4 '#90ff70', 5 '#ffee00', 6 '#ff7000', 7 '#ee0000', 8 '#7f0000')"
    echo "set cbr [0:0.14]"
    echo "set terminal png size 1700, 300"
    printf "set output './GIF_TMP/%04d.png'\n" $ID
    echo "splot \"< target/display --gnuplot $INPUT_FILE $ID\" u 1:2:4"
}

start=$(date +%s.%N)
for tmp in $(seq 0 "$FRAMES"); do
    printf "Generating image %d/%d (%.2lf%%)\r" $(( $tmp + 1 )) $(( $FRAMES + 1 )) $(echo "scale=4; $tmp / $FRAMES * 100" | bc)
    gen_gnuplot_command $tmp | gnuplot
done
printf "\n\033[1;34m==>\033[0m Generating \033[35m%s\033[0m...\n" $OUTPUT_FILE
convert ./GIF_TMP/*.png $2
end=$(date +%s.%N)

elapsed=$(echo "scale=4; $end - $start" | bc -l)
printf "\nFinished generating GIF in \033[36m%.2fs\033[0m.\n" $elapsed
PWD=$(pwd)
printf "\033[1;32m[+]\033[0m %s\n" "${PWD}/${OUTPUT_FILE}"
