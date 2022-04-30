#!/bin/bash

function get_field {
    local field=$(target/display --info $2 0 | rg $1)
    local field=$(echo $field | sed -e "s/$1\ =\ //g")
    echo "$field"
}

function check_field {
    if [ $2 -ne $3 ]; then
        printf "\033[1;33mwarning:\033[0m simulations have different %s (base is \033[1m%d\033[0m and provided simulation is \033[1m%d\033[0m).\n" "$1" $2 $3
    fi
}

function check_cfg {
    check_field "width" $1 $2
    check_field "height" $3 $4
    check_field "frames" $5 $6
}

function min {
    if [ $1 -le $2 ]; then
        echo "$(($1 - 1))"
    else
        echo "$(($2 - 1))"
    fi
}

base_raw=../base/ref.raw
if [ -f $base_raw ]; then
    :
else
    printf "\033[1;31merror:\033[0m results of base simulation do not exist.\n\033[1;36mhint:\033[0m try running it first in the \`base\` directory.\n"
    exit 1
fi

sim_raw=$1
if [ -z $sim_raw ]; then
    printf "\033[1;31merror:\033[0m one argument needed.\n\033[1musage:\033[0m bash $0 <results.raw>\n"
    exit 1
else
    if [ -f $sim_raw ]; then
        :
    else
        printf "\033[1;31merror:\033[0m results of provided simulation do not exist.\n\033[1;36mhint:\033[0m try running it first.\n"
        exit 1
    fi
fi

code=0
base_width=$(get_field 'width' $base_raw)
base_height=$(get_field 'height' $base_raw)
base_frames=$(get_field 'frames' $base_raw)
sim_width=$(get_field 'width' $sim_raw)
sim_height=$(get_field 'height' $sim_raw)
sim_frames=$(get_field 'frames' $sim_raw)
check_cfg $base_width $sim_width $base_height $sim_height $base_frames $sim_frames

printf "\033[1;34m==>\033[0m Verifying checksum for \033[35m%s\033[0m... " $sim_raw
for i in $(seq 0 $(min $base_frames $sim_frames)); do
    base_checksum=$(target/display --checksum $base_raw $i)
    sim_checksum=$(target/display --checksum $sim_raw $i)

    if [ "$base_checksum" != "$sim_checksum" ]; then
        printf "\n\033[1;31mfailure:\033[0m checksum is incorrect for frame %d.\n  Base is:       \033[36m%s\033[0m\n  Simulation is: \033[36m%s\033[0m\n" $i "$base_checksum" "$sim_checksum"
        code=1
    fi
done
printf "\033[1;32mok\033[0m\n"

exit $code
