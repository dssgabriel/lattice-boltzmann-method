#!/bin/bash

function create_config {
    echo "iterations           = 16000" > config.txt
    echo "width                = $1" >> config.txt
    echo "height               = $2" >> config.txt
    echo "obstacle_x           = 0.0" >> config.txt
    echo "obstacle_y           = 0.0" >> config.txt
    echo "obstacle_r           = 0.0" >> config.txt
    echo "reynolds             = 100" >> config.txt
    echo "inflow_max_velocity  = 0.100000" >> config.txt
    echo "inflow_max_velocity  = 0.100000" >> config.txt
    echo "output_filename      = results.raw" >> config.txt
    echo "write_interval       = 50" >> config.txt
}

function get_config_param {
    echo "$(rg --trim '$1' $2 | sed -e 's/$1//g' | xargs | sed -e 's/=\ //g')"
}

function init_strong_bench {
    local limit=$(($1 * $2 * 2))
    local three_fourth=$(printf "%.0f" $(echo "3 / 4 * $limit" | bc -l))
    local array=()
    for ((i=1; i<$limit; i++)); do
        if [ $i -le $(($limit / 2)) ]; then
            array+=($i)
        elif [ $(($i % 2)) == 0 ] && [ $i -le $three_fourth ]; then
            array+=($i)
        fi
    done
    array+=($limit)
    array+=($(echo "$limit * 2" | bc))
    echo "${array[@]}"
}

start=$(date +%s.%N)

mkdir -p benchmarks/ plots/ tmp/
mode=$1
mpicmd=$2
if [ "$mpicmd" = "mpiexec" ]; then
    mpiflags="-n"
elif [ "$mpicmd" = "mpirun" ]; then
    mpiflags="--mca opal_warn_on_missing_libcuda 0 -n"
elif [ "$mpicmd" = "mpcrun" ]; then
    mpiflags="-n="
else
    printf "\033[1;31merror:\033[0m MPI command \`%s\` is unknown.\n" $mpicmd
    exit 1
fi
bin=$3

nb_cores=$(lscpu | rg "Core\(s\) per socket:" | awk '{print $4}')
nb_nodes=$(lscpu | rg "NUMA node\(s\):" | awk '{print $3}')
pwd=$(pwd)

bench=benchmarks/bench_$mode.dat
input="$pwd/$bench"
output="$pwd/plots/results_bench_$mode.png"
rm -f $bench

printf "\033[1;34m==>\033[0m Starting \033[1m%s scalability\033[0m benchmark on \033[35m%s\033[0m...\n" $mode $bin
if [ "$mode" = "strong" ]; then
    create_config 800 160
    procs=(1 2 4 8)
    
    for (( i=0; i<${#procs[@]}; i++)); do
        proc=${procs[$i]}
        printf "Running with \033[1;33m%d\033[0m processes... " $proc
        run=tmp/run_$proc.out

        $mpicmd $mpiflags $proc $bin > $run
        latency=$(rg "Global simulation latency:" $run | awk '{print $4}' | sed -e "s/s//g")

        # Safe because bench output file changes at each iteration
        echo "$proc $latency" >> $bench
        printf "\033[1;32mdone\033[0m\n"
    done
    gnuplot -e "datafile='${input}'; outputname='${output}'; xlab='Number of processes'; tit='Strong scalability of the LBM simulation'" ../scripts/bench_scalibility.gp
elif [ "$mode" = "weak" ]; then
    width=400
    height=80
    for (( i=0; i<4; i++ )); do
        printf "Running with dimensions \033[1;33m%d\033[0mx\033[1;33m%d\033[0m... " $width $height

        create_config $width $height
        run=tmp/run_$i.out
        $mpicmd $mpiflags 4 $bin > $run

        nb_cells=$(($width * $height))
        latency=$(rg "Global simulation latency:" $run | awk '{print $4}' | sed -e "s/s//g")

        if [ $(($i % 2)) == "0" ]; then
            height=$(($height * 2))
        else
            width=$(($width * 2))
        fi
        printf "\033[1;32mdone\033[0m\n"
        echo "$nb_cells $latency" >> $bench
    done
    gnuplot -e "datafile='${input}'; outputname='${output}'; xlab='Number of pixels'; tit='Weak scalability of the LBM simulation'" ../scripts/bench_scalibility.gp
else
    printf "\033[1;31merror:\033[0m mode \`%s\` is unknown. Available modes are: \`weak\`, \`strong\`.\n" $mode
    exit 1
fi
printf "\033[1;32m[+]\033[0m %s\n" "$input"
printf "\033[1;32m[+]\033[0m %s\n" "$output"
rm -rf tmp/

end=$(date +%s.%N)
elapsed=$(echo "scale=4; $end - $start" | bc -l)
printf "\nFinished running benchmarks in \033[36m%.2fs\033[0m.\n" $elapsed

exit 0
