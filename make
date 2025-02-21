#!/usr/bin/env bash


# initialize variables

## diameter of magnet
DIAMETER=(4 5 6 8 10 12 15 20)
## height of magnet
HEIGHT=(2 3)
## number of layers above magnet
COVER=(3 5)


# generate

for c in ${COVER[@]}; do
    for h in ${HEIGHT[@]}; do
        for d in ${DIAMETER[@]}; do

            echo "# Generating files for ${d} x ${h} / ${c} toplayers"

            echo "- export/${d}x${h}-${c}_base.stl"
            RESPONSE=$(openscad -q -o "export/${d}x${h}-${c}_base.stl" \
            -D generate=\""base"\" \
            -D diameter=\"${d}\" \
            -D height=\"${h}\" \
            -D cover=\"${c}\" \
            magnet-tester.scad)
            # echo $RESPONSE

            echo "- export/${d}x${h}-${c}_text.stl"
            RESPONSE=$(openscad -q -o "export/${d}x${h}-${c}_text.stl" \
            -D generate=\""text"\" \
            -D diameter=\"${d}\" \
            -D height=\"${h}\" \
            -D cover=\"${c}\" \
            magnet-tester.scad)
            # echo $RESPONSE

        done
    done
done
