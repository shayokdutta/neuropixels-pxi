#include "RippleDetectorInterface.h"
#include "../../../../plugin-GUI/Source/Utils/Utils.h"

// I'm just assumiing the 384 channel that this tends to assume anyways here...
RippleDetectorInterface::RippleDetectorInterface():numChannels(384)
{
    serverIPAddress = "127.0.0.1";
    ListenSocket = INVALID_SOCKET;
    ClientSocket = INVALID_SOCKET;
    writeData = false;
    return;
}

/**
* close all handles as we destroy this object!
**/
RippleDetectorInterface::~RippleDetectorInterface() 
{
    // Close the process and thread handles if they are valid
    if (procInfo.hProcess) {
        /*Figure out graceful exit...try to not use commented out line below*/
        // TerminateProcess(procInfo.hProcess, 0); // forceful termination. 
        LOGC("Mooooooooooooooooo: Attempting to send exit message to RippleDetectorUIApp!");
        this->sendMessageViaSocket("exit"); // exit rippledetectoruiapp gracefully
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

    if (shutdown(ClientSocket, SD_SEND) == SOCKET_ERROR) {
        LOGC("Error: Shutdown of socket failed. Error code: " + std::to_string(WSAGetLastError()));
        closesocket(ClientSocket);
    }

    // Clean up Winsock
    WSACleanup();
}


/**
* 
**/
void RippleDetectorInterface::setLFPTimeStamps(int packetNum, int64_t lfp_timestamp)
{
    lfp_timestamps[packetNum] = lfp_timestamp; 
}

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
void RippleDetectorInterface::launchRippleDetectorUI(std::string channelCount) 
{
    
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
        
        // Accept a RippleDetectorUIApp client
        ClientSocket = accept(ListenSocket, NULL, NULL);
        if (ClientSocket == INVALID_SOCKET) {
            LOGC("Mooooooooooooooooo: accept failed with error: %d\n", WSAGetLastError());
            closesocket(ListenSocket);
            WSACleanup();
        }

        // Launch a thread to listen to the client
        std::thread listenThread(&RippleDetectorInterface::listenToClient, this);
        listenThread.detach(); // Or handle the thread according to your application's threading model

        // No longer need server socket
        closesocket(ListenSocket);
    }
    else {
        LOGC("RippleDetectorUIApp.exe file not found");
    }
}


/**
* Create socket for sending and receiving messages to RippleDetectorUIApp
**/
std::string RippleDetectorInterface::createMessagingSocket() 
{

    // Initialize Winsock
    WSADATA wsaData;
    int iResult = WSAStartup(MAKEWORD(2, 2), &wsaData);
    if (iResult != 0) {
        LOGC("Mooooooooooooooooo: WSAStartup failed with error: %d\n", iResult);
        return "";
    }

    ZeroMemory(&hints, sizeof(hints));
    hints.ai_family = AF_INET;
    hints.ai_socktype = SOCK_STREAM;
    hints.ai_protocol = IPPROTO_TCP;
    hints.ai_flags = AI_PASSIVE;

    // Resolve the local address and port to be used by the server
    iResult = getaddrinfo(serverIPAddress.c_str(), "0", &hints, &result);
    if (iResult != 0) {
        WSACleanup();
        LOGC("Mooooooooooooooooo: failed to get address and port number setup for socket");
        return "\nMooooooooooooooooo: failed to get address and port number setup for socket";
    }

    // Create a SOCKET for the server to listen for client connections.
    ListenSocket = socket(result->ai_family, result->ai_socktype, result->ai_protocol);
    if (ListenSocket == INVALID_SOCKET) {
        freeaddrinfo(result);
        WSACleanup();
        LOGC("Mooooooooooooooooo: FAILED Create a SOCKET for the server to listen for client connections.");
        return "\nMooooooooooooooooo: Listen socket invalid";
    }

    iResult = bind(ListenSocket, result->ai_addr, (int)result->ai_addrlen);
    if (iResult == SOCKET_ERROR) {
        closesocket(ListenSocket);
        freeaddrinfo(result);
        WSACleanup();
        LOGC("Mooooooooooooooooo: failed to bind socket to address in order to listen");
        return "\nMooooooooooooooooo: failed to bind socket to address in order to listen";
    }

    freeaddrinfo(result);

    // Listen on the socket
    if (listen(ListenSocket, SOMAXCONN) == SOCKET_ERROR) {
        closesocket(ListenSocket);
        WSACleanup();
        LOGC("Mooooooooooooooooo: listen failed with error: %d\n", WSAGetLastError());
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


    LOGC("Mooooooooooooooooo: socket server for messaging started at: " + serverIPAddress + ":" + std::to_string(localPort));

    return std::to_string(localPort);
}

/**
*  Method to create and return the name of the shared memory
**/
std::string RippleDetectorInterface::createSharedFIFODataBuffer() 
{
    LOGC("Mooooooooooooooooo: Creating Shared memory for LFP data transfer...");
    // Create a memory-mapped file
    hMapFile = CreateFileMappingW(
        INVALID_HANDLE_VALUE, // Use paging file
        NULL,                 // Default security
        PAGE_READWRITE,       // Read/write access
        0,                    // Maximum object size (high-order DWORD)
        400 * MAXPACKETS * 3,          // Maximum object size (low-order DWORD)
        L"SharedMemoryLFPData");   // Name of mapping object

    if (hMapFile == NULL || hMapFile == INVALID_HANDLE_VALUE) {
        LOGC("Mooooooooooooooooo: Error: Unable to create file mapping.");
        return "";
    }

    // Map the shared memory
    lfpSharedMemory = MapViewOfFile(
        hMapFile,            // Handle to map object
        FILE_MAP_ALL_ACCESS, // Read/write permission
        0,                   // Max. object size (high DWORD)
        0,                   // Max. object size (low DWORD)
        400 * MAXPACKETS * 3);   // Map entire file
    currentWritePosition = static_cast<char*>(lfpSharedMemory);

    if (lfpSharedMemory == NULL) {
        LOGC("Mooooooooooooooooo: Error: Unable to map view of file.");
        CloseHandle(hMapFile);
        return "";
    }

    LOGC("Mooooooooooooooooo: Shared memory for LFP Data transfer created");

    // Return the name of the memory-mapped file
    return "SharedMemoryLFPData";
}

/**
* Alrighty so this reads in and sets the channels then flushes the buffer
**/
void RippleDetectorInterface::readChannelsFromSharedMemory()
{
    // if we need to read in new channels after a reset!
    if (!activeChannels.empty()) {
        activeChannels.clear();
    }

    std::istringstream stream(static_cast<char*>(lfpSharedMemory));
    std::string line;
    while (std::getline(stream, line)) {
        try {
            int channel = std::stoi(line);
            if (channel >= 0 && channel < 384) {
                activeChannels.push_back(channel);
                LOGC("Mooooooooooooooooo: Will send data from channel" + line);
            }
        }
        catch (const std::invalid_argument& e) {
            LOGC("Mooooooooooooooooo: Invalid argument encountered in shared memory data: " + line);
        }
        catch (const std::out_of_range& e) {
            LOGC("Mooooooooooooooooo: Out of range error encountered in shared memory data: " + line);
        }
    }
    memset(lfpSharedMemory, 0, 400*MAXPACKETS*3); // sets the entire memory to zero nibbles
}


/**
* Writes LFP data and timestamps to shared memory
**/
void RippleDetectorInterface::writeToSharedMemory(int SKIP) {
    if (writeData) {
        std::ostringstream stream;

        for (int packetNum = 0; packetNum < MAXPACKETS; ++packetNum) {
            int64_t timestamp = lfp_timestamps[packetNum];
            for (int channel : activeChannels) {
                int offset = channel + packetNum * SKIP;
                stream << channel << "," << timestamp << "," << lfpSamples[offset] << ";";
            }
        }

        std::string formattedData = stream.str();
        size_t dataSize = formattedData.size();

        if (dataSize < (400 * MAXPACKETS * 3)) {
            // Ensure the data does not exceed the buffer
            // Check if the data will fit in the remaining buffer space
            size_t remainingBufferSize = (400 * MAXPACKETS * 3) - (currentWritePosition - static_cast<char*>(lfpSharedMemory));
            if (dataSize <= remainingBufferSize) {
                // Write data to the current position
                std::memcpy(currentWritePosition, formattedData.c_str(), dataSize);
                // Update the current position
                currentWritePosition += dataSize;
            }
            else {
                // Wrap around and start from the beginning
                currentWritePosition = static_cast<char*>(lfpSharedMemory);
                std::memcpy(currentWritePosition, formattedData.c_str(), dataSize);
                currentWritePosition += dataSize;
            }
        }
        else {
            LOGC("Error: Formatted data size exceeds shared memory buffer size.");
        }
    }
}




/**
* Writes messages to the RippleDetectorUIApp
**/
void RippleDetectorInterface::sendMessageViaSocket(std::string msg) {
    
    int iResult = send(ClientSocket, msg.c_str(), (int)strlen(msg.c_str()), 0);
    if (iResult == SOCKET_ERROR) {
        LOGC("Mooooooooooooooooo: Error: Sending message failed. Error code: " + std::to_string(WSAGetLastError()));
        closesocket(ClientSocket);
        WSACleanup();
        return;
    }
    else {
        LOGC("Message sent successfully");
    }
}

/**
 * @brief toLowerCase: Function to convert string to lower case.
 * @param str
 * @return
 */
std::string toLowerCase(const std::string& str) 
{
    std::string lowerStr = str;
    std::transform(lowerStr.begin(), lowerStr.end(), lowerStr.begin(), ::tolower);
    return lowerStr;
}

/**
* 
**/
void RippleDetectorInterface::listenToClient() 
{
    char buffer[512];

    while (true) {
        int bytesReceived = recv(ClientSocket, buffer, sizeof(buffer), 0);

        if (bytesReceived > 0) {
            std::string receivedMsg = toLowerCase(std::string(buffer, bytesReceived));
            LOGC("Mooooooooooooooooo: Msg received: " + receivedMsg);

            if (receivedMsg == "exit") {
                break;
            }
            else if (receivedMsg == "channelsset" || receivedMsg == "setchannels") {
                readChannelsFromSharedMemory();
            }
            else if (receivedMsg == "feedmedata" || receivedMsg == "nomonomnom") {
                writeData = true;
            }
            else if (receivedMsg == "stopfeedingmedatapls") {
                writeData = false;
            }
            else if (receivedMsg == "clearsharedmemory" || receivedMsg == "nonibbles") {
                // sets the entire memory to zero nibbles (clears it)
                memset(lfpSharedMemory, 0, 385 * MAXPACKETS); 
            }
        }
        else if (bytesReceived == 0) {
            LOGC("Mooooooooooooooooo: Connection closing.");
            break;
        }
        else {
            LOGC("Mooooooooooooooooo: recv failed with error: " + std::to_string(WSAGetLastError()));
            break;
        }
    }

    // Clean up
    closesocket(ClientSocket);
    WSACleanup();
}
