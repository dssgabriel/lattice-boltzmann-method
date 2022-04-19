#!/bin/bash

# Check it has been run with bash
if [ -n "$BASH_VERSION" ]; then
    :
else
    echo "This script must be run with bash" 1>&2
    echo "Try: bash $0 <args>" 1>&2
    exit 1
fi

#check args
if [ -z "$1" ] || [ -z "$2" ]; then
	echo "Usage : bash $0 {input.raw} {output.gif}" 1>&2
	exit 1
fi

# Check if gnu-parallel is installed
if ! type parallel > /dev/null; then
  echo "Error: gnu-parallel is not installed" 1>&2
  exit 1
fi

#get values
INPUT_FILE=$1
OUTPUT_FILE=$2

#get info
FRAMES=$(./display --info "${INPUT_FILE}" 0 | grep frames | sed -e 's/frames=//g')

rm -rf ./GIF_TMP
mkdir -p GIF_TMP

#gen gnuplot command
gen_gnuplot_command() {
	ID="$1"
	echo "set pm3d map"
	echo "set palette defined ( 0 '#000090', 1 '#000fff',2 '#0090ff',3 '#0fffee', 4 '#90ff70', 5 '#ffee00', 6 '#ff7000', 7 '#ee0000', 8 '#7f0000')"
	echo "set cbr [0:0.14]"
	echo "set terminal png size 1700,300"
	printf "set output './GIF_TMP/%04d.png'\n" "${ID}"
	echo "splot \"< ./display --gnuplot $2 ${ID} \" u 1:2:4"
}

export -f gen_gnuplot_command

full_command() {
  PERCENT=$(echo "scale=4; $1 / $3 * 100" | bc -l)
  echo -ne "Generating GIF: $PERCENT%\r"
  gen_gnuplot_command "$1" "$2" | gnuplot
}

export -f full_command

echo "Input file: ${INPUT_FILE}"
echo "Number of frames to generate: ${FRAMES}"
echo "Output file: ${OUTPUT_FILE}"

parallel -j 4 full_command {} "${INPUT_FILE}" "${FRAMES}" :::: $(seq 0 1 "${FRAMES}")

echo "Generating GIF in $OUTPUT_FILE"
convert ./GIF_TMP/*.png "$OUTPUT_FILE"
