beginPause: "computations"
comment: "Where are your sound files and TextGrids?"
sentence: "directory1", "D:\ArticlesResearch\GitHub_scripts\Praat\test_VQ"
comment: "Results File"
sentence: "output1", "VQResults2"
clicked = endPause: "OK", 1


if directory1$ = ""
	directory1$ = chooseDirectory$("Select your directory of sound files and TextGrids")
endif

Create Strings as file list: "fileList", "'directory1$'\*.wav"
nbFiles = Get number of strings

if fileReadable ("'output1$'.xls")
	deleteFile: "'output1$'.xls"
endif

			appendFileLine: "'output1$'.xls", "File name", tab$, "start", tab$, "end", tab$, "duration", tab$, 
			... "durationMsec", tab$, "meanPeriod(s)", tab$, "sdPeriod(s)", tab$, 
			... "jitterLocal%", tab$, "jitterLocalAbsdB", tab$, "jitterRAP%", tab$, "jitterPPQ5%", tab$, "jitterDDP%", tab$, 
			... "shimmerLocal%", tab$, "shimmerLocaldB", tab$, "shimmerAPQ3%", tab$, "shimmerAPQ5%", tab$, "shimmerAPQ11%", tab$, 
			... "shimmerDDA%", tab$, "hnrMeanFulldB", tab$, "hnrSDFulldB", tab$, "hnrMean500dB", tab$, "hnrSD500dB", tab$, 
			... "hnrMean1500dB", tab$, "hnrSD1500dB", tab$, "hnrMean2500dB", tab$, "hnrSD2500dB", tab$, "hnrMean3500dB", tab$, 
			... "hnrSD3500dB", tab$, "energy1000dB", tab$, "energy2000dB", tab$, "energy4000dB", tab$, 
			... "energy6000dB", tab$, "hammarbergIndexdB", tab$, "slopedB", tab$, "tiltdB", tab$, 
			... "beddB", tab$, "gne3500", tab$, "gne4500", tab$, "cppdB"


for i from 1 to nbFiles
	select Strings fileList
	nameFile$ = Get string: i
	Read from file: "'directory1$'/'nameFile$'"
	name$ = selected$("Sound")	
	Read from file: "'directory1$'/'name$'.TextGrid"
	selectObject: "Sound 'name$'"
	#compute f0, two-passes
	noprogress To Pitch (cc): 0.005, 50, 15, "yes", 0.03, 0.45, 0.01, 0.35, 0.14, 600
	q1 = Get quantile: 0, 0, 0.25, "Hertz"
	q3 = Get quantile: 0, 0, 0.75, "Hertz"
	minPitch = q1*0.75
	maxPitch = q3*1.5
	Remove
	selectObject: "Sound 'name$'"
	noprogress To Pitch (cc): 0.005, minPitch, 15, "yes", 0.03, 0.45, 0.01, 0.35, 0.14, maxPitch
	selectObject: "Sound 'name$'"
	noprogress To Harmonicity (cc): 0.005, minPitch, 0.1, 1
	Rename: "'name$'_Full"
	selectObject: "Sound 'name$'"
	filt1 = Filter (pass Hann band): 0, 500, 100
	noprogress To Harmonicity (cc): 0.005, minPitch, 0.1, 1
	Rename: "'name$'_500"
	selectObject: "Sound 'name$'"
	filt2 = Filter (pass Hann band): 0, 1500, 100
	noprogress To Harmonicity (cc): 0.005, minPitch, 0.1, 1
	Rename: "'name$'_1500"
	selectObject: "Sound 'name$'"
	filt3 = Filter (pass Hann band): 0, 2500, 100
	noprogress To Harmonicity (cc): 0.005, minPitch, 0.1, 1
	Rename: "'name$'_2500"
	selectObject: "Sound 'name$'"
	filt4 = Filter (pass Hann band): 0, 3500, 100
	noprogress To Harmonicity (cc): 0.005, minPitch, 0.1, 1
	Rename: "'name$'_3500"

	select filt1
	plus filt2
	plus filt3
	plus filt4
	Remove

	selectObject: "Sound 'name$'"
    plusObject: "Pitch 'name$'"
    To PointProcess (cc)
	Rename: "'name$'"

	
	selectObject: "TextGrid 'name$'"
	nbIntervals = Get number of intervals: 1




		for j from 1 to nbIntervals
			selectObject: "TextGrid 'name$'"

			label$ = Get label of interval: 1, j
				if label$ = ""
					start = Get starting point: 1, j
					end = Get end point: 1, j
					duration = end - start
					durationMsec = duration * 1000

					selectObject: "PointProcess 'name$'"
					nbPeriods = Get number of periods: start, end, 0.0001, 0.02, 1.3
					meanPeriod = Get mean period: start, end, 0.0001, 0.02, 1.3
					sdPeriod = Get stdev period: start, end,  0.0001, 0.02, 1.3
					jitterLocal = Get jitter (local): start, end, 0.0001, 0.02, 1.3
					jitterLocalAbs = Get jitter (local, absolute): start, end, 0.0001, 0.02, 1.3
					jitterRAP = Get jitter (rap): start, end, 0.0001, 0.02, 1.3
					jitterPPQ5 = Get jitter (ppq5): start, end, 0.0001, 0.02, 1.3
					jitterDDP = Get jitter (ddp): start, end, 0.0001, 0.02, 1.3
					selectObject: "Sound 'name$'"
					plusObject: "PointProcess 'name$'"
					shimmerLocal = Get shimmer (local): start, end, 0.0001, 0.02, 1.3, 1.6
					shimmerLocaldB = Get shimmer (local_dB): start, end, 0.0001, 0.02, 1.3, 1.6
					shimmerAPQ3 = Get shimmer (apq3): start, end, 0.0001, 0.02, 1.3, 1.6
					shimmerAPQ5 = Get shimmer (apq5): start, end, 0.0001, 0.02, 1.3, 1.6
					shimmerAPQ11 = Get shimmer (apq11): start, end, 0.0001, 0.02, 1.3, 1.6
					shimmerDDA = Get shimmer (dda): start, end, 0.0001, 0.02, 1.3, 1.6
					selectObject: "Harmonicity 'name$'_Full"
					hnrMeanFull = Get mean: start, end
					hnrSDFull = Get standard deviation: start, end
					selectObject: "Harmonicity 'name$'_500"
					hnrMean500 = Get mean: start, end
					hnrSD500 = Get standard deviation: start, end
					selectObject: "Harmonicity 'name$'_1500"
					hnrMean1500 = Get mean: start, end
					hnrSD1500 = Get standard deviation: start, end
					selectObject: "Harmonicity 'name$'_2500"
					hnrMean2500 = Get mean: start, end
					hnrSD2500 = Get standard deviation: start, end
					selectObject: "Harmonicity 'name$'_3500"
					hnrMean3500 = Get mean: start, end
					hnrSD3500 = Get standard deviation: start, end


					selectObject: "Sound 'name$'"
					part = Extract part... start end Rectangular 1 yes
					spectrum = To Spectrum... yes
					energy1000 = Get band energy difference... 1000 10000 0 1000
					energy2000 = Get band energy difference... 2000 10000 0 2000
					energy4000 = Get band energy difference... 1000 4000 0 1000
					energy6000 = Get band energy difference... 6000 10000 0 6000
					hammarbergIndex = Get band energy difference... 2000 5000 0 2000
					energyLow = Get band energy... 0 500
					energyHigh = Get band energy... 4000 5000
					bed = 10 * log10(energyLow / energyHigh)
					select spectrum
					ltas = To Ltas (1-to-1)
					slope = Get slope: 0, 1000, 1000, 10000, "dB"
					trend = Compute trend line: 0, 10000
					tilt = Get slope: 0, 1000, 1000, 10000, "dB"
					select part
					har_gne_3500 = To Harmonicity (gne)... 500 3500 1000 80
					gne3500 = Get maximum
					select part
					har_gne_4500 = To Harmonicity (gne)... 500 4500 1000 80
					gne4500 = Get maximum
					select spectrum
					powerCepst = To PowerCepstrum
					cpp = Get peak prominence: 60, 333.3, "parabolic", 0.001, 0.05, "Exponential decay", "Robust slow"

					select part
					Remove
					select spectrum
					Remove
					select ltas
					Remove
					select har_gne_3500
					Remove
					select har_gne_4500
					Remove
					select powerCepst
					Remove
					select trend
					Remove



					appendFileLine: "'output1$'.xls", name$, tab$, start, tab$, end, tab$, duration, tab$, 
					... durationMsec, tab$, meanPeriod, tab$, sdPeriod, tab$, 
					... jitterLocal, tab$, jitterLocalAbs, tab$, jitterRAP, tab$, jitterPPQ5, tab$, jitterDDP, tab$, 
					... shimmerLocal, tab$, shimmerLocaldB, tab$, shimmerAPQ3, tab$, shimmerAPQ5, tab$, shimmerAPQ11, tab$, 
					... shimmerDDA, tab$,  hnrMeanFull, tab$, hnrSDFull, tab$, hnrMean500, tab$, hnrSD500, tab$, 
					... hnrMean1500, tab$, hnrSD1500, tab$, hnrMean2500, tab$, hnrSD2500, tab$, hnrMean3500, tab$, 
					... hnrSD3500, tab$, energy1000, tab$, energy2000, tab$, energy4000, tab$, 
					... energy6000, tab$, hammarbergIndex, tab$, slope, tab$, tilt, tab$, 
					... bed, tab$, gne3500, tab$, gne4500, tab$, cpp




			endif

		endfor

select all
minus Strings fileList
Remove
endfor


echo Finished! Check the file 'output1$'.xls located in the script directory
 