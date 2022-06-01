"""Code to fill Alaska Daymet files."""

import pandas as pd
from gdptools.fill_missing_vals_nearest_neighbor import fill_onhm_ncf
# the year string and periods can be adjusted based on the files you want
# to fill
f_time_series = pd.date_range(pd.to_datetime("2000"), periods=10, freq="1Y")
file_time = [t.strftime("%Y") for t in f_time_series]

for index, ts in enumerate(file_time):
    print(f'processing year: {ts}')
    fill_onhm_ncf(nfile=f'../../data/NHM_19/{ts}_dm_ak.nc',
        output_dir='../../data/NHM_19/',
        var='tmax',
        lat='lat',
        lon='lon',
        feature_id='nhru',
        mfile='../../data/NHM_19/fill_missing_nearest.csv',
        genmap=False)