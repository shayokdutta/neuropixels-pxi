#include "RippleDetectorInterface.h"
#include <windows.h>

// I'm just assumiing the 384 channel that this tends to assume anyways here...
RippleDetectorInterface::RippleDetectorInterface():numChannels(384) {
}

void RippleDetectorInterface::setNumChannels(int channelCount)
{
	// note this is hardcoded as 384 within the API code. 
	// I thought we could select less than 384 or is that
	// what's always sent and perhaps less just displayed?
	numChannels = channelCount; 
	// trigger the GUI table generation somehow...	
		// probably going to want to have some socket communication for messages

    /* this should work. have to test this soon...

    // additional information
    STARTUPINFO si;
    PROCESS_INFORMATION pi;

    // set the size of the structures
    ZeroMemory(&si, sizeof(si));
    si.cb = sizeof(si);
    ZeroMemory(&pi, sizeof(pi));

    // start the program up
    CreateProcess("../../Modules/RippleDetectorUI-Binaries/RippleDetectorUIApp.exe",   // the path
        NULL,        // Command line
        NULL,           // Process handle not inheritable
        NULL,           // Thread handle not inheritable
        FALSE,          // Set handle inheritance to FALSE
        0,              // No creation flags
        NULL,           // Use parent's environment block
        NULL,           // Use parent's starting directory 
        &si,            // Pointer to STARTUPINFO structure
        &pi             // Pointer to PROCESS_INFORMATION structure (removed extra parentheses)
    );

    // Close process and thread handles. 
    CloseHandle(pi.hProcess);
    CloseHandle(pi.hThread);

    */
}

/**
* Is this function needed if we run the program from the NPX plugin end?
* We should be able to kill it whenever we want? I guess is there a need
* for a graceful exit? 
**/
void RippleDetectorInterface::sendMessageToStimHandler(std::string msg)
{
}

/**
* 
**/
void RippleDetectorInterface::writeToSharedMemory(float* data, int64_t sampleNumbers, double* timestamps, uint64_t eventCodes, int numItems, int chunkSize)
{
}

/**
* Maybe pass in paramters here such as numChannels and how to initialize GUI
**/
void RippleDetectorInterface::initializeRippleDetectorUI()
{
}

/**
*
**/
void RippleDetectorInterface::launchRippleDetectorUI()
{
}
