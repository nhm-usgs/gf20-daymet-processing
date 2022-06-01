#!/bin/sh -e

# SDIR=/Users/pnorton/Projects/National_Hydrology_Model/datasets/daymet_v4/alaska/gf20_dmv4_ak_filled
SDIR=/home/rmcd/tmp/swapped
TDIR=/home/rmcd/tmp

for cyear in {1980..2021}; do
    fill_in=false

    if [ $[$cyear % 400] -eq "0" ]; then
        #echo "This is a leap year.  February has 29 days."
        fill_in=true
    elif [ $[$cyear % 4] -eq 0 ]; then
        if [ $[$cyear % 100] -ne 0 ]; then
            #echo "This is a leap year, February has 29 days."
            fill_in=true
        else
            fill_in=false
           #echo "This is not a leap year.  February has 28 days."
        fi
    else
        fill_in=false
        #echo "This is not a leap year.  February has 28 days."
    fi

    if [ "$fill_in" = true ]; then
        echo "${cyear}:  Fill in missing day"
        next_year=$((cyear+1))

        # Make a copy of the current year and next year data with time as a record
        #ncks -O --mk_rec_dmn time ${SDIR}/${cyear}_dm_ak_filled.nc -o ${TDIR}/tmp1a.nc
        #ncks -O --mk_rec_dmn time ${SDIR}/${next_year}_dm_ak_filled.nc -o ${TDIR}/tmp2a.nc

        # Grab the last day of the current year and the first day of the next year
        ncks -O -d time,364 ${SDIR}/${cyear}_dm_ak_filled.nc ${TDIR}/tmp1.nc
        ncks -O -d time,0 ${SDIR}/${next_year}_dm_ak_filled.nc ${TDIR}/tmp2.nc

        # Combine those dates into a single file
        ncrcat -O ${TDIR}/tmp1.nc ${TDIR}/tmp2.nc -o ${TDIR}/tmp3.nc

        # Average the two days
        ncra -O ${TDIR}/tmp3.nc ${TDIR}/tmp3_fillday.nc
        rm ${TDIR}/tmp3.nc

        # Append the fill day to the end of the year
        ncrcat -O ${SDIR}/${cyear}_dm_ak_filled.nc ${TDIR}/tmp3_fillday.nc -o ${TDIR}/${cyear}_dm_ak_filled.nc
        # ncrcat -O ${TDIR}/tmp1a.nc ${TDIR}/tmp3_fillday.nc -o ${TDIR}/tmp4.nc
        # nccopy -4 -d 2 ${TDIR}/tmp4.nc ${TDIR}/dm_climate_${cyear}_filled.nc
        rm ${TDIR}/tmp3_fillday.nc
     fi


done

