#!/bin/bash

# Variable declaration
freq=$(cat /proc/cpuinfo | rg --trim "cpu MHz" | sed -e "s/cpu MHz//g" | xargs | sed -e "s/:\ //g" | awk -vRS=" " '{sum+=$0} END{ sum/=8; print sum}')

# Print information about the local process communications
function print_local {
    time_send=$(get_time "MpiSend" $1)
    time_recv=$(get_time "MpiRecv" $1)
    time_barr=$(get_time "MpiBarrier" $1)

    sigma_send=$(get_sigma "MpiSend" $1)
    sigma_recv=$(get_sigma "MpiRecv" $1)
    sigma_barr=$(get_sigma "MpiBarrier" $1)

    min_send=$(get_min "MpiSend" $1)
    min_recv=$(get_min "MpiRecv" $1)
    min_barr=$(get_min "MpiBarrier" $1)

    max_send=$(get_max "MpiSend" $1)
    max_recv=$(get_max "MpiRecv" $1)
    max_barr=$(get_max "MpiBarrier" $1)

    printf "\n\033[1mLocal communications to process \033[33m%d:\033[0m%13s\033[1;36m%9s\033[0m ± \033[1m%10s\033[0m (\033[34m%s\033[0m … \033[91m%s\033[0m)\n" $1 " " "Time" "σ" "min" "max"
    printf "  Messages sent:                   \033[1;32m%9d\033[0m ─ \033[1;36m%9s\033[0m ± %10s%s\033[34m%s\033[0m … \033[91m%s\033[0m)\n" ${rank_send[$1]} $time_send $sigma_send " (" $min_send $max_send
    printf "  Messages received:               \033[1;32m%9d\033[0m ─ \033[1;36m%9s\033[0m ± %10s%s\033[34m%s\033[0m … \033[91m%s\033[0m)\n" ${rank_recv[$1]} $time_recv $sigma_recv " (" $min_recv $max_recv
    printf "  Barriers:                        \033[1;32m%9d\033[0m ─ \033[1;36m%9s\033[0m ± %10s%s\033[34m%s\033[0m … \033[91m%s\033[0m)\n" ${rank_barrier[$1]} $time_barr $sigma_barr " (" $min_barr $max_barr
    printf "  Number of partner processes:     \033[1;32m%9d\033[0m (partner ranks ID:" ${nb_partners[$1]}
    printf " \033[1;33m%s\033[0m" ${partners[$@]}
    printf ")\n"
}

scale=1000000
unit="s"

# Determine the scale of the time and rescale accordingly
function rescale {
    # If less than 0.001s, we're at the microsecond level
    if (($(echo "$1 < 0.001" | bc -l))); then
        scale=1
        unit="µs"
    # If less than 1s, we're at the millisecond level
    elif (($(echo "$1 < 1" | bc -l))); then
        scale=1000
        unit="ms"
    # We're at the second level
    else
        scale=1000000
        unit="s"
    fi
    # Recompute
    echo "$(echo "scale=3; $2 / ($freq * $scale)" | bc -l)$unit"
}

# Estimate time of a communication
function get_time {
    local file="tmp/${1}_${2}.tsc"
    if [ -f $file ]; then
        :
    else
        mkdir -p tmp/
        rg -A7 --trim $1 $interpol_traces | rg -A6 "current_rank\": $2" | rg "duration" | sed -e "s/\"duration\": //g" | sort -g > $file
    fi

    local mean_tsc=$(paste -sd+ $file | bc)
    local mean_time=$(echo "scale=3; $mean_tsc / ($freq * 1000000)" | bc -l)
    echo $(rescale $mean_time $mean_tsc)
}

function get_sigma {
    local file="tmp/${1}_${2}.tsc"
    if [ -f $file ]; then
        :
    else
        mkdir -p tmp/
        rg -A7 --trim $1 $interpol_traces | rg -A6 "current_rank\": $2" | rg "duration" | sed -e "s/\"duration\": //g" | sort -g > $file
    fi

    local sigma_tsc=$(awk '{sum+=$0;a[NR]=$0}END{for(i in a)y+=(a[i]-(sum/NR))^2;print sqrt(y/(NR-1))}' $file)
    local sigma_time=$(echo "scale=3; $sigma_tsc / ($freq * 1000000)" | bc -l)
    echo $(rescale $sigma_time $sigma_tsc)
}

function get_min {
    local file="tmp/${1}_${2}.tsc"
    if [ -f $file ]; then
        :
    else
        mkdir -p tmp/
        rg -A7 --trim $1 $interpol_traces | rg -A6 "current_rank\": $2" | rg "duration" | sed -e "s/\"duration\": //g" | sort -g > $file
    fi

    local min_tsc=$(head -n1 $file)
    local min_time=$(echo "scale=3; $min_tsc / ($freq * 1000000)" | bc -l)
    echo $(rescale $min_time $min_tsc)
}

function get_max {
    local file="tmp/${1}_${2}.tsc"
    if [ -f $file ]; then
        :
    else
        mkdir -p tmp/
        rg -A7 --trim $1 $interpol_traces | rg -A6 "current_rank\": $2" | rg "duration" | sed -e "s/\"duration\": //g" | sort -g > $file
    fi

    local max_tsc=$(tail -n1 $file)
    local max_time=$(echo "scale=3; $max_tsc / ($freq * 1000000)" | bc -l)
    echo $(rescale $max_time $max_tsc)
}

interpol_traces=$1
if [ -z $interpol_traces ]; then
    printf "\033[1;31merror:\033[0m one argument needed.\n\033[1musage:\033[0m bash $0 <interpol_traces.json>\n"
    exit 1
else
    if [ -f $interpol_traces ]; then
        :
    else
        printf "\033[1;31merror:\033[0m \`%s\` does not exist.\n" $interpol_traces
        exit 1
    fi
fi

start=$(date +%s.%N)
printf "\033[1;34m==>\033[0m Generating report summary for \033[35m%s\033[0m...\n" $interpol_traces
total_calls=$(rg -c "type" $interpol_traces)
total_sends=$(rg -c "MpiSend" $interpol_traces)
total_recvs=$(rg -c "MpiRecv" $interpol_traces)
total_barriers=$(rg -c "MpiBarrier" $interpol_traces)

nb_ranks=$(( $(rg -A 1 "MpiSend" $interpol_traces | rg "current_rank" | uniq | wc -l) - 1 ))
for i in $(seq 0 $nb_ranks); do
    rank_send[$i]=$(rg -A 1 "MpiSend" $interpol_traces | rg -c "current_rank\": $i")
    rank_recv[$i]=$(rg -A 1 "MpiRecv" $interpol_traces | rg -c "current_rank\": $i")
    rank_barrier[$i]=$(rg -A 1 "MpiBarrier" $interpol_traces | rg -c "current_rank\": $i")
    nb_partners[$i]=$(rg -A 2 "Mpi(Send|Recv)" $interpol_traces | rg -A 1 "current_rank\": $i" | rg "partner_rank" | sort | uniq | wc -l)
    partners[$i]=$(rg -A 2 "Mpi(Send|Recv)" $interpol_traces | rg -A 1 "current_rank\": $i" | rg --trim "partner_rank" | sed -e "s/\"partner_rank\": //g" | sed "s/,//g" | sort | uniq)
done

printf "\n\033[1mGlobal communications:\033[0m\n"
printf "  Messages sent:                   \033[1;32m%9d\033[0m\n" $total_sends
printf "  Messages received:               \033[1;32m%9d\033[0m\n" $total_recvs
printf "  Barriers:                        \033[1;32m%9d\033[0m\n" $total_barriers
printf "  Total MPI calls:                 \033[1;32m%9d\033[0m\n\n" $total_calls
echo "─────────────────────────────────────────────────────────────────────────────"

for i in $(seq 0 $nb_ranks); do
    print_local $i
done
rm -rf tmp/
end=$(date +%s.%N)

elapsed=$(echo "scale=4; $end - $start" | bc -l)
printf "\nFinished generating report summary in \033[36m%.2fs\033[0m.\n" $elapsed

exit 0
