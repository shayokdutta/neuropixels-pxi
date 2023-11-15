#pragma once
class RippleDetectorInterface
{
public:
	RippleDetectorInterface();
	
	void setNumChannels(int channelCount);

private:
	int numChannels; 
};

