#!/bin/sh

BIN="/csb/toolchains/armv7-eabihf--glibc--stable-2018.11-1/bin"
SRC_FILE=$1
KERNEL=$2
OUT_FILE=${SRC_FILE%.*}.ko

echo "Compiling \"${SRC_FILE}\" into \"${OUT_FILE}\""

stap -gv -a arm -p4 -r $KERNEL -B CROSS_COMPILE=$BIN/arm-linux- -m $OUT_FILE $SRC_FILE
