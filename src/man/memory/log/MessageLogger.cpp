/**
 * MessageLogger.cpp
 *
 *  The structure for a log file:
 *  -- ID number for the type of object logged
 *  -- the birth_time timestamp of the man process that parents the logger
 *
 *  -- for each message
 *  ---- size of serialized message
 *  ---- serialized message
 *
 *      Author: Octavian Neamtu
 *      E-mail: oneamtu@bowdoin.edu
 */

#include "MessageLogger.h"
#include "Profiler.h"

namespace man {
namespace memory {

namespace log {

using namespace std;

MessageLogger::MessageLogger(OutProvider::ptr out_provider,
                             Message::const_ptr objectToLog) :
        ThreadedLogger(out_provider, "Log" + objectToLog->getName()),
        messageToLog(objectToLog) {
}

MessageLogger::~MessageLogger() {
    this->stop();
    this->waitForThreadToFinish();
}

void MessageLogger::run() {
    while (running) {

        if (!out_provider->opened()) {
            //blocking for socket fds, (almost) instant for other ones
            out_provider->openCommunicationChannel();
            std::cout << "writing head out" << std::endl;
            this->writeHead();
        }

        this->waitForSignal();
        this->writeToLog();

        while (out_provider->writingInProgress()) {
            this->yield();
        }
    }
}

void MessageLogger::writeHead() {
    // log ID
    out_provider->writeValue<int32_t>(messageToLog->getIDTag());
    // the absolute time stamp of the log
    //(all other time stamps are relative to this)
    out_provider->writeValue<int64_t>(messageToLog->getBirthTime());
}

void MessageLogger::writeToLog() {
    PROF_ENTER(P_LOGGING);
    out_provider->writeValue<uint32_t>(messageToLog->byteSize());
    messageToLog->serializeToString(&write_buffer);
    out_provider->writeCharBuffer(write_buffer.data(), write_buffer.length());
    PROF_EXIT(P_LOGGING);
}

}
}
}