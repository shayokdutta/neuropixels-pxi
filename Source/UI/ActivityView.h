/*
------------------------------------------------------------------

This file is part of the Open Ephys GUI
Copyright (C) 2019 Allen Institute for Brain Science and Open Ephys

------------------------------------------------------------------

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

*/

#ifndef __ACTIVITYVIEW_H__
#define __ACTIVITYVIEW_H__

#include <VisualizerEditorHeaders.h>
#include <immintrin.h>
#include <omp.h>

enum ActivityToView {
	APVIEW = 0,
	LFPVIEW = 1
};

/**

Helper class for viewing real-time activity across the probe.

*/


class ActivityView
{
public:
	ActivityView(int numChannels, int updateInterval_)
	{
		for (int i = 0; i < numChannels; i++)
			peakToPeakValues.add(0);

		updateInterval = updateInterval_;

		initialReset();
	}

	const float* getPeakToPeakValues() {

		return peakToPeakValues.getRawDataPointer();
	}

	void addSample(float sample, int channel)
	{
		if (channel == 0)
		{
			if (counter == updateInterval)
				reset();

			counter++;
		}

		if (counter % 100 == 0)
		{
			if (sample < minChannelValues[channel])
			{
				minChannelValues.set(channel, sample);
				return;
			}

			if (sample > maxChannelValues[channel])
			{
				maxChannelValues.set(channel, sample);
			}
		}
	}

	void initialReset() {
		for (int i = 0; i < peakToPeakValues.size(); i++)
		{

			peakToPeakValues.set(i, maxChannelValues[i] - minChannelValues[i]);

			minChannelValues.set(i, 999999.9f);
			maxChannelValues.set(i, -999999.9f);
		}
		counter = 0;
	}

	void reset()
	{
		float* minValsPtr = minChannelValues.getRawDataPointer();
		float* maxValsPtr = maxChannelValues.getRawDataPointer();
		float* peakToPeakPtr = peakToPeakValues.getRawDataPointer();

		for (int i = 0; i < peakToPeakValues.size(); i += 16) {
			__m512 maxVals = _mm512_loadu_ps(maxValsPtr + i);
			__m512 minVals = _mm512_loadu_ps(minValsPtr + i);

			__m512 peakToPeakVals = _mm512_sub_ps(maxVals, minVals);

			_mm512_storeu_ps(peakToPeakPtr + i, peakToPeakVals);

			_mm512_storeu_ps(minValsPtr + i, _mm512_set1_ps(999999.9f));
			_mm512_storeu_ps(maxValsPtr + i, _mm512_set1_ps(-999999.9f));
		}

		/*for (int i = 0; i < peakToPeakValues.size(); i++)
		{

			peakToPeakValues.set(i, maxChannelValues[i] - minChannelValues[i]);

			minChannelValues.set(i, 999999.9f);
			maxChannelValues.set(i, -999999.9f);
		}*/
		counter = 0;
		
	}

private:

	Array<float, CriticalSection> minChannelValues;
	Array<float, CriticalSection> maxChannelValues;
	Array<float, CriticalSection> peakToPeakValues;

	int counter;
	int updateInterval;

};

	


#endif  // __ACTIVITYVIEW_H__
