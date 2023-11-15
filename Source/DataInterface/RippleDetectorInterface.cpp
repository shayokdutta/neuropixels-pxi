#include "RippleDetectorInterface.h"


RippleDetectorInterface::RippleDetectorInterface() {

}

void RippleDetectorInterface::setNumChannels(int channelCount)
{
	numChannels = channelCount;
	// trigger the GUI table generation somehow...
	// probably going to want to have some socket communication for messages
}
