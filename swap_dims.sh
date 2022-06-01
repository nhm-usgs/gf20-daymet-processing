#!/bin/sh -e

SDIR=/home/rmcd/data/NHM_19
TDIR=/home/rmcd/tmp/swapped

for cyear in {1980..2021}; do
    echo ${cyear}
    time ncpdq -a time,nhru ${SDIR}/${cyear}_dm_ak_filled.nc -o ${TDIR}/${cyear}_dm_ak_filled.nc
done

