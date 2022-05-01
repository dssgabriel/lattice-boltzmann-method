set term pngcairo size 1080,720 font "SF Pro Display,16"
set output outputname

set grid
set style data histograms
set style fill solid border 0.3
set xlabel xlab
set ylabel 'Simulation latency in seconds'
set title tit
set key font "SF Pro Display,12"
set key width -8
set key off

plot datafile u 2:xtic(1) with histogram title 'Latency by number of processes', \
     '' u 0:2:2 with labels font "SF Pro Display,12" offset 0, char 0.5
