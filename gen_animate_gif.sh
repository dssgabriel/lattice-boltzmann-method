#!/bin/bash

#check args
if [ -z "$1" ] || [ -z "$2" ]; then
	echo "Usage : $0 {input.raw} {output.gif}" 1>&2
	exit 1
fi

#get values
INPUT_FILE=$1
OUTPUT_FILE=$2

#get info
FRAMES=$(./display --info $INPUT_FILE 0 | grep frames | sed -e 's/frames=//g')

#gen gnuplot command
gen_gnuplot_command()
{
	echo "set pm3d map"
	echo "set palette defined ( 0 '#000090', 1 '#000fff',2 '#0090ff',3 '#0fffee', 4 '#90ff70', 5 '#ffee00', 6 '#ff7000', 7 '#ee0000', 8 '#7f0000')"
	echo "set cbr [0:0.14]"
	echo "set term gif animate delay 5 size 1700,300"
	echo "set output '$OUTPUT_FILE'"

	for tmp in $(seq 0 1 $FRAMES); do
		echo "splot \"< ./display --gnuplot $INPUT_FILE $tmp\" u 1:2:4"
	done
}

#call if
gen_gnuplot_command | gnuplot
