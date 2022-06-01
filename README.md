# gf20-daymet-processing
Processing scripts for GF 2.0 Alaska and Hawaii Daymet processing

## Install

```bash
conda env create -f environment.yml
conda activate gf2dmproc
```

## Alaska Fabric
https://www.sciencebase.gov/catalog/item/5fc51e65d34e4b9faad8877b

I extracted the hru's from the geopackage and created a new shapefile with only the hru_id and geometry.  NHM_19_nhrus_c.shp  Feature files for aggragation should have one attribute per geometry.

## Further documentation in check_results.ipynb