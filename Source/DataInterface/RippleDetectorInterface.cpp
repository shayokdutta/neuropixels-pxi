#include "RippleDetectorInterface.h"
#include "../../../../plugin-GUI/Source/Utils/Utils.h"

// I'm just assumiing the 384 channel that this tends to assume anyways here...
RippleDetectorInterface::RippleDetectorInterface():numChannels(384)
{
    serverIPAddress = "127.0.0.1";
    return;
}

/**
* close all handles as we destroy this object!
**/
RippleDetectorInterface::~RippleDetectorInterface() {
    // Close the process and thread handles if they are valid
    if (procInfo.hProcess) {
        /*Figure out graceful exit...try to not use commented out line below*/
        // TerminateProcess(procInfo.hProcess, 0); // forceful termination. 
        this->sendMessageViaSocket("exit"); // exit rippledetectoruiapp gracefully
        LOGC("Mooooooooooooooooo: Sent message to close RippleDetectorUIApp!");
        CloseHandle(procInfo.hProcess);
    }
    if (procInfo.hThread) {
        CloseHandle(procInfo.hThread);
    }

    // Close the shared memory file
    if (hMapFile) {
        CloseHandle(hMapFile);
    }

    // Close the socket
    if (ListenSocket != INVALID_SOCKET) {
        closesocket(ListenSocket);
    }

    // Clean up Winsock
    WSACleanup();
}


/**
* 
**/
void RippleDetectorInterface::setLFPTimeStamps(int packetNum, int64_t lfp_timestamp){
    lfp_timestamps[packetNum] = lfp_timestamp; 
};

void RippleDetectorInterface::setNumChannels(int channelCount)
{
	// note this is hardcoded as 384 within the API code. 
	// I thought we could select less than 384 or is that
	// what's always sent and perhaps less just displayed?
	numChannels = channelCount; 
    
    launchRippleDetectorUI(std::to_string(numChannels));    
}

/**
* This should start the RippleDetectorUI process hopefully.
**/
void RippleDetectorInterface::launchRippleDetectorUI(std::string channelCount) {
    
    std::filesystem::path relativePath = "../../../OEPlugins/neuropixels-pxi/Modules/RippleDetectorUI-Binaries/RippleDetectorUIApp.exe";

    std::filesystem::path currentWorkingDir = std::filesystem::current_path();

    std::filesystem::path fullPath = currentWorkingDir / relativePath;

    fullPath = fullPath.lexically_normal();

    std::string fullPathStr = fullPath.string();

    // Create shared memory and get its name
    sharedMemoryName = createSharedFIFODataBuffer();
    std::string serverPort = createMessagingSocket();


    serverPortNum = atoi(serverPort.c_str());

    // Form the command line argument string
    std::string command = fullPathStr + " " + "WindowsOpenEphysIMECNPXIe " + channelCount + " " + sharedMemoryName + " " + serverIPAddress + " " + serverPort;
    LPSTR cmdLine = const_cast<char*>(command.c_str());


    if (std::filesystem::exists(fullPath)) {
        STARTUPINFO si;
        PROCESS_INFORMATION pi;

        // set the size of the structures
        ZeroMemory(&si, sizeof(si));
        si.cb = sizeof(si);
        ZeroMemory(&procInfo, sizeof(procInfo));


        LOGC("Mooooooooooooooooo: Launching RippleDetectorUIApp with command: " + command);
        // start the program up
        CreateProcess(fullPathStr.c_str(),   // the path
            cmdLine,        // Command line
            NULL,           // Process handle not inheritable
            NULL,           // Thread handle not inheritable
            FALSE,          // Set handle inheritance to FALSE
            0,              // No creation flags
            NULL,           // Use parent's environment block
            NULL,           // Use parent's starting directory
            &si,            // Pointer to STARTUPINFO structure
            &procInfo             // Pointer to PROCESS_INFORMATION structure (removed extra parentheses)
        );
    }
    else {
        LOGC("RippleDetectorUIApp.exe file not found");
    }
}


/**
* Create socket for sending and receiving messages to RippleDetectorUIApp
**/
std::string RippleDetectorInterface::createMessagingSocket() {
    WSADATA wsaData;
    int iResult = WSAStartup(MAKEWORD(2, 2), &wsaData);
    if (iResult != 0) {
        // Handle error
        return "";
    }

    struct addrinfo* result = NULL, hints;
    ZeroMemory(&hints, sizeof(hints));
    hints.ai_family = AF_INET;
    hints.ai_socktype = SOCK_STREAM;
    hints.ai_protocol = IPPROTO_TCP;
    hints.ai_flags = AI_PASSIVE;

    // Resolve the local address and port to be used by the server
    iResult = getaddrinfo(serverIPAddress.c_str(), "0", &hints, &result);
    if (iResult != 0) {
        WSACleanup();
        return "\nMooooooooooooooooo: failed to get address and port number setup for socket";
    }

    SOCKET ListenSocket = socket(result->ai_family, result->ai_socktype, result->ai_protocol);
    if (ListenSocket == INVALID_SOCKET) {
        freeaddrinfo(result);
        WSACleanup();
        return "\nMooooooooooooooooo: Listen socket invalid";
    }

    iResult = bind(ListenSocket, result->ai_addr, (int)result->ai_addrlen);
    if (iResult == SOCKET_ERROR) {
        closesocket(ListenSocket);
        freeaddrinfo(result);
        WSACleanup();
        return "\nMooooooooooooooooo: failed to bind socket to address in order to listen";
    }

    // Listen on the socket
    if (listen(ListenSocket, SOMAXCONN) == SOCKET_ERROR) {
        closesocket(ListenSocket);
        WSACleanup();
        return "\nMooooooooooooooooo: failed to listen on message socket";
    }

    // Get the local socket address
    struct sockaddr_in sin;
    int len = sizeof(sin);
    if (getsockname(ListenSocket, (struct sockaddr*)&sin, &len) == -1) {
        closesocket(ListenSocket);
        WSACleanup();
        return "\nMooooooooooooooooo: failed to get local message socket address";
    }

    int localPort = ntohs(sin.sin_port);

    freeaddrinfo(result);


    LOGC("Mooooooooooooooooo: socket server for messaging started at: " + serverIPAddress + ":" + std::to_string(localPort));

    return std::to_string(localPort);
}

/**
*  Method to create and return the name of the shared memory
**/
std::string RippleDetectorInterface::createSharedFIFODataBuffer() {
    LOGC("Mooooooooooooooooo: Creating Shared memory for LFP data transfer...");
    // Create a memory-mapped file
    HANDLE hMapFile = CreateFileMappingW(
        INVALID_HANDLE_VALUE, // Use paging file
        NULL,                 // Default security
        PAGE_READWRITE,       // Read/write access
        0,                    // Maximum object size (high-order DWORD)
        385 * MAXPACKETS,          // Maximum object size (low-order DWORD)
        L"SharedMemoryLFPData");   // Name of mapping object

    if (hMapFile == NULL || hMapFile == INVALID_HANDLE_VALUE) {
        // Handle error
    }

    LOGC("Mooooooooooooooooo: Shared memory for LFP Data transfer created");

    // Return the name of the memory-mapped file
    return "SharedMemoryLFPData";

}

/**
* Writes messages to the RippleDetectorUIApp
**/
void RippleDetectorInterface::sendMessageViaSocket(std::string msg) {
    // Assuming serverPort is the port number obtained from createMessagingSocket
    struct addrinfo* result = NULL, * ptr = NULL, hints;
    ZeroMemory(&hints, sizeof(hints));
    hints.ai_family = AF_INET;
    hints.ai_socktype = SOCK_STREAM;
    hints.ai_protocol = IPPROTO_TCP;

    // Resolve the server address and port
    int iResult = getaddrinfo(serverIPAddress.c_str(), std::to_string(serverPortNum).c_str(), &hints, &result);
    if (iResult != 0) {
        WSACleanup();
        return;
    }

    // Create a SOCKET for connecting to server
    SOCKET ConnectSocket = INVALID_SOCKET;
    ptr = result;

    // Create a socket
    ConnectSocket = socket(ptr->ai_family, ptr->ai_socktype, ptr->ai_protocol);
    if (ConnectSocket == INVALID_SOCKET) {
        freeaddrinfo(result);
        WSACleanup();
        return;
    }

    // Connect to server
    iResult = connect(ConnectSocket, ptr->ai_addr, (int)ptr->ai_addrlen);
    if (iResult == SOCKET_ERROR) {
        closesocket(ConnectSocket);
        ConnectSocket = INVALID_SOCKET;
    }

    freeaddrinfo(result);

    if (ConnectSocket == INVALID_SOCKET) {
        WSACleanup();
        return;
    }

    // Send message
    iResult = send(ConnectSocket, msg.c_str(), (int)strlen(msg.c_str()), 0);
    if (iResult == SOCKET_ERROR) {
        closesocket(ConnectSocket);
        WSACleanup();
        return;
    }

    // Shutdown the connection since no more data will be sent
    iResult = shutdown(ConnectSocket, SD_SEND);
    if (iResult == SOCKET_ERROR) {
        closesocket(ConnectSocket);
        WSACleanup();
        return;
    }

    // Cleanup
    closesocket(ConnectSocket);
    WSACleanup();
}

/**
* 
**/
void RippleDetectorInterface::writeToSharedMemory(float* data, int64_t sampleNumbers, double* timestamps, uint64_t eventCodes, int numItems, int chunkSize)
{
}
