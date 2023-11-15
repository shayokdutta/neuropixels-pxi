#pragma once
#include <string>
#include <stdint.h>


#define MAXPACKETS 64 // taken from NPX API

class RippleDetectorInterface

{
public:
	RippleDetectorInterface();
	
	/// <summary>
	/// Is there a reason this should _not_ be 384? 
	/// </summary>
	void setNumChannels(int channelCount);
	
	/// <summary>
	/// This should mostly be for initialization and ending the process communication
	/// let's do this via pipes for messages as the processes are on the same computer
	/// </summary>
	void sendMessageToStimHandler(std::string msg); 

	/// <summary>
	/// What we should use to share the neural data ...
	/// or whatever else from the NPX probes/IMEC things
	/// </summary>
	void writeToSharedMemory(float* data,
		int64_t sampleNumbers,
		double* timestamps,
		uint64_t eventCodes,
		int numItems,
		int chunkSize=1);

	/// <summary>
	///  
	/// </summary>
	void initializeRippleDetectorUI();

	/// <summary>
	/// Seems like the best thing to do would be to exec() the program from this side 
	/// of things once we have the SharedMemory things sorted out right? 
	/// Then we can close it whenever we're running it...
	/// </summary>
	void launchRippleDetectorUI();

private:
	int numChannels; 

	int64_t ap_timestamps[12 * MAXPACKETS];
	uint64_t event_codes[12 * MAXPACKETS];
	int64_t lfp_timestamps[MAXPACKETS];
	uint64_t lfp_event_codes[MAXPACKETS];
};

