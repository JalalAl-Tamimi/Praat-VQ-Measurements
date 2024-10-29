To cite, use: [![DOI](https://zenodo.org/badge/515176455.svg)](https://zenodo.org/badge/latestdoi/515176455)

To access scripts and supporting documents, download the whole repository from [here](https://github.com/JalalAl-Tamimi/Praat-VQ-Measurements). You can access it by clicking on "View on GitHub" on top.

There are two version of this script: 

1) The script "VQ_measurements_V1.praat" is to be used if you have a Praat version 6.3.22 or below.
2) The script "VQ_measurements_V2.praat" is to be used for any version of Praat above 6.4. These new versions use the updated Praat algorithm for detection of pitch


The two scripts "VQ_measurements_V1.praat" and "VQ_measurements_V2.praat" provide multiple acoustic measures to Voice Quality (VQ). It uses the Two-pass method for estimation f0 range adapted to each speaker; uses the cross-correlation method. The measurements are:
1. Jitter and Shimmer (various measures)
2. Harmonics to Noise Ratio (HNR); full, between 0-500 Hz, 0-1500 Hz, 0-2500 Hz and 0-3500 Hz
3. Many of the Acoustic Breathiness Index: Energy components, spectral tilt and slope, glottal excitation, hammarberg Index, band energy differences, and cepstral peak prominence.

The script uses a Sound file and a TextGrid. A results file is outputted. 

Make sure to cite this github repo when using this script

