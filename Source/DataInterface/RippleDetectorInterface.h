#pragma once
#define _WINSOCKAPI_
#include <winsock2.h>
#include <ws2tcpip.h>
#include <iphlpapi.h>
#include <windows.h>
#include <string>
#include <stdint.h>
#include <filesystem>



#define MAXPACKETS 64 // taken from NPX API
#pragma comment(lib, "Ws2_32.lib")

class RippleDetectorInterface

{
public:
	RippleDetectorInterface();
	~RippleDetectorInterface();
	
	/// <summary>
	/// Is there a reason this should _not_ be 384? 
	/// </summary>
	void setNumChannels(int channelCount);

	float* getLFPSamplesReference() { return lfpSamples; };


	void setLFPTimeStamps(int packetNum, int64_t lfp_timestamp);

	/// <summary>
	/// Seems like the best thing to do would be to exec() the program from this side 
	/// of things once we have the SharedMemory things sorted out right? 
	/// Then we can close it whenever we're running it...
	/// </summary>
	void launchRippleDetectorUI(std::string channelCount);

	/// <summary>
	/// 
	/// </summary>
	/// <returns></returns>
	std::string createSharedFIFODataBuffer();

	/// <summary>
	/// What we should use to share the neural data ...
	/// or whatever else from the NPX probes/IMEC things
	/// </summary>
	void writeToSharedMemory(float* data,
		int64_t sampleNumbers,
		double* timestamps,
		uint64_t eventCodes,
		int numItems,
		int chunkSize = 1);

	std::string createMessagingSocket();

	/// <summary>
	/// This should mostly be for initialization and ending the process communication
	/// let's do this via pipes for messages as the processes are on the same computer
	/// </summary>
	void sendMessageViaSocket(std::string msg);

private:
	int numChannels; 

	int64_t ap_timestamps[12 * MAXPACKETS];
	//uint64_t event_codes[12 * MAXPACKETS];
	int64_t lfp_timestamps[MAXPACKETS];
	//uint64_t lfp_event_codes[MAXPACKETS];

	alignas(64) float apSamples[385 * 12 * MAXPACKETS];
	alignas(64) float lfpSamples[385 * MAXPACKETS];

	PROCESS_INFORMATION procInfo; // RippleDetectorUIApp process
	HANDLE hMapFile; // Handle for the shared memory
	std::string sharedMemoryName;

	SOCKET ListenSocket; // Socket for messaging
	std::string serverIPAddress; // IP Address for the socket server
	int serverPortNum; // Port number for the socket server
};

