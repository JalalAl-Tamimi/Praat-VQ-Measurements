To access scripts and supporting documents, download the whole repository from [here](https://github.com/JalalAl-Tamimi/Praat_Silence_Detection). You can access it by clicking on "View on GitHub" on top.

The script "detect_silence_speech.praat" provides an automated method to detect silence based on a sound file. 
This uses the following specifications:
1. The Two-pass method for estimation f0 range adapted to each speaker; uses the cross-correlation method
2. The the range of f0 (between 5-95%) is obtained
3. Intensity is then computed based on the 95% f0
4. Intensity range is obtained (between 5-95%); SD is also computed
5. The silence threshold is estimated based on range - SD/2

Pauses are marked with "xxx"; speech with an empty interval

An outputted TextGrid is provided.

Make sure to cite this github repo when using this script

