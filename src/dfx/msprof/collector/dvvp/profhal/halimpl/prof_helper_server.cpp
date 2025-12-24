/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <chrono>
#include "codec.h"
#include "error_code.h"
#include "msprof_dlog.h"
#include "transport/hdc/helper_transport.h"
#include "transport/transport.h"
#include "config/config.h"
#include "proto/profiler.pb.h"
#include "adx_prof_api.h"
#include "message.h"
#include "prof_helper_server.h"

namespace Dvvp {
namespace Hal {
namespace Server {
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::transport;
using namespace Analysis::Dvvp::MsprofErrMgr;

ProfHelperServer::ProfHelperServer()
    : dataInitialized_(false), logicDevId_(-1), server_(nullptr), logicDevIdStr_(""),
    flushModuleCallback_(nullptr), sendHelperDataCallback_(nullptr),
    setHelperDirCallback_(nullptr)
{}

ProfHelperServer::~ProfHelperServer()
{
    UnInit();
}

int32_t ProfHelperServer::Init(const int32_t logicDevId)
{
    logicDevId_ = logicDevId;
    logicDevIdStr_ = std::to_string(logicDevId_);
    dataInitialized_ = true;
    MSPROF_LOGI("ProfHelperServer init, logicDevId:%d", logicDevId_);
    if (!analysis::dvvp::common::utils::Utils::CheckStringIsNonNegativeIntNum(logicDevIdStr_) ||
        logicDevId_ >= MSVP_MAX_DEV_NUM) {
        MSPROF_LOGE("[ProfHelperServer]devId: %d is not valid!", logicDevId_);
        MSPROF_INNER_ERROR("EK9999", "devId: %d is not valid!", logicDevId_);
        return PROFILING_FAILED;
    }
    server_ = Analysis::Dvvp::Adx::AdxHdcServerCreate(logicDevId_, HDC_SERVICE_TYPE_IDE1);
    if (server_ == nullptr) {
        MSPROF_LOGW("Helper server is invalid");
    }
    Thread::SetThreadName(analysis::dvvp::common::config::MSVP_HELPER_DUMPER_THREAD_NAME);

    if (Thread::Start() != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to start the logicDevId:%d in ProfHelperServer", logicDevId_);
        MSPROF_INNER_ERROR("EK9999", "Failed to start the logicDevId:%d in ProfHelperServer", logicDevId_);
        return PROFILING_FAILED;
    } else {
        MSPROF_LOGI("Succeeded in starting the logicDevId:%d in ProfHelperServer", logicDevId_);
    }
    return PROFILING_SUCCESS;
}

int32_t ProfHelperServer::UnInit()
{
    MSPROF_LOGI("Uinit ProfHelperServer Transport Begin, logicDevId:%d", logicDevId_);
    if (dataInitialized_) {
        dataInitialized_ = false;
        for (auto &tran : dataTran_) {
            if (tran != nullptr) {
                tran->CloseSession();
                tran.reset();
            }
        }

        std::chrono::seconds timeout(1);
        for (auto &val : result_) {
            if (val.valid() && val.wait_for(timeout) == std::future_status::ready) {
                MSPROF_LOGI("Device(%d) ProfHelperServer wait for receiving data success", logicDevId_);
                val.get();
            }
        }

        if (server_ != nullptr) {
            HDC_SERVER serverDestroyTmp = server_;
            server_ = nullptr;
            Analysis::Dvvp::Adx::AdxHdcServerDestroy(serverDestroyTmp);
        }
        StopNoWait();
        dataTran_.clear();
    }
    MSPROF_LOGI("Uinit ProfHelperServer Transport End, logicDevId:%d", logicDevId_);
    return PROFILING_SUCCESS;
}

int32_t ProfHelperServer::PackSampleJsonFile(std::string id, const ProfHalStruct *message)
{
    if (sampleJsonMap_.find(id) == sampleJsonMap_.end()) {
        sampleJsonMap_[id] = message->chunk;
    } else {
        sampleJsonMap_[id] += message->chunk;
    }

    if (message->isLastChunk) {
        SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq;
        MSVP_MAKE_SHARED0(fileChunkReq, analysis::dvvp::ProfileFileChunk, return PROFILING_FAILED);
        fileChunkReq->isLastChunk = true;
        fileChunkReq->chunk = sampleJsonMap_[id];
        fileChunkReq->chunkModule = message->chunkModule;
        fileChunkReq->chunkSize = fileChunkReq->chunk.size();
        fileChunkReq->offset = message->offset;
        fileChunkReq->fileName = message->fileName;
        fileChunkReq->extraInfo = message->extraInfo;
        fileChunkReq->id = id;
        return sendHelperDataCallback_(fileChunkReq);
    }
    return PROFILING_SUCCESS;
}

int32_t ProfHelperServer::ReceiveStreamData(CONST_VOID_PTR data, uint32_t dataLen)
{
    if ((data == nullptr) || (dataLen == 0) || (dataLen > analysis::dvvp::common::config::PROFILING_PACKET_MAX_LEN)) {
        MSPROF_LOGE("receive helper data, args invalid, data=%d, dataLen=%d.",
            ((data == nullptr) ? 0 : 1), dataLen);
        MSPROF_INNER_ERROR("EK9999", "receive helper data, args invalid, data=%d, dataLen=%d.",
            ((data == nullptr) ? 0 : 1), dataLen);
        return PROFILING_FAILED;
    }

    const ProfHalStruct *message = static_cast<const ProfHalStruct *>(data);
    if (message->isLastChunk && message->chunkSize == 0) {
        MSPROF_LOGI("Device(%d) receives the last chunk, start flushing", logicDevId_);
        flushModuleCallback_();
        return PROFILING_SUCCESS;
    }

    std::string fileName = message->fileName;
    MSPROF_LOGI("Device(%d) Reveive file : %s , length : %d",
        logicDevId_, fileName.c_str(), message->chunkSize);
    std::string id = Utils::PackDotInfo(logicDevIdStr_, message->id);
    if (fileName == "helper_device_pid") {
        MSPROF_LOGI("Device(%d) Reveive packet with name %s",
            logicDevId_, fileName.c_str());
        uint32_t ret = setHelperDirCallback_(id);
        if (ret != PROFILING_SUCCESS) {
            MSPROF_LOGE("Device(%d) Create Helper dir failed", logicDevId_);
            MSPROF_INNER_ERROR("EK9999", "Device(%d) Create Helper dir failed", logicDevId_);
        }
        return PROFILING_SUCCESS;
    }

    if (fileName == "sample.json") {
        return PackSampleJsonFile(id, message);
    }

    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq;
    MSVP_MAKE_SHARED0(fileChunkReq, analysis::dvvp::ProfileFileChunk, return PROFILING_FAILED);
    fileChunkReq->isLastChunk = message->isLastChunk;
    fileChunkReq->chunkModule = message->chunkModule;
    fileChunkReq->chunkSize = message->chunkSize;
    fileChunkReq->offset = message->offset;
    fileChunkReq->chunk = std::string(message->chunk, message->chunkSize);
    fileChunkReq->fileName = fileName;
    fileChunkReq->extraInfo = message->extraInfo;
    fileChunkReq->id = id;

    MSPROF_LOGI("Device(%d) Send file %s , length : %d",
        logicDevId_, fileName.c_str(), fileChunkReq->chunkSize);
    return sendHelperDataCallback_(fileChunkReq);
}

void ProfHelperServer::Run(const struct error_message::Context &errorContext)
{
    MsprofErrorManager::instance()->SetErrorContext(errorContext);
    if (!dataInitialized_) {
        MSPROF_LOGE("ProfHelperServer is not inited, logicDevId:%d", logicDevId_);
        return;
    }

    MSPROF_LOGI("Device(%d) ProfHelperServer is running", logicDevId_);
    while (!IsQuit()) {
        MSPROF_LOGI("Device(%d) ProfHelperServer CreateHelperServerTransport begin", logicDevId_);
        auto dataTran = analysis::dvvp::transport::HelperTransportFactory().CreateHdcServerTransport(logicDevId_,
            server_);
        if (dataTran == nullptr) {
            MSPROF_LOGW("Device(%d) can not CreateHelperServerTransport", logicDevId_);
            return;
        }

        dataTran_.push_back(dataTran);
        auto retval = std::async(std::launch::async, [this, dataTran]()->int32_t {
            ProfHalTlv *packet = nullptr;
            int32_t ret = PROFILING_SUCCESS;
            MSPROF_LOGI("Device(%d) ProfHelperServer read message begin", this->logicDevId_);
            while (!IsQuit()) {
                packet = nullptr;
                ret = dataTran->ReceivePacket(&packet);
                if (ret < 0 || packet == nullptr) {
                    MSPROF_EVENT("Device(%d) ProfHelperServer recv data ends, exits", this->logicDevId_);
                    break;
                }
                if (packet->head != HAL_HELPER_TLV_HEAD) {
                    MSPROF_LOGE("Device(%d) ProfHelperServer received data format is incorrect.\
                        The msg header is 0x%08x", this->logicDevId_, packet->head);
                    dataTran->FreePacket(packet);
                    packet = nullptr;
                    continue;
                }

                MSPROF_LOGD("[HelperTransport] RecvDataPacket %d bytes", packet->len);
                ret = ReceiveStreamData(packet->value, packet->len);
                if (ret != PROFILING_SUCCESS) {
                    MSPROF_LOGE("Device(%d) ReceiveStreamData failed", this->logicDevId_);
                }
                dataTran->FreePacket(packet);
                packet = nullptr;
            }
            dataTran->CloseSession();
            MSPROF_LOGI("Device(%d) ProfHelperServer read message end", logicDevId_);
            return ret;
        });
        MSPROF_LOGI("Device(%d) ProfHelperServer CreateHelperServerTransport success", logicDevId_);
        result_.emplace_back(std::move(retval));
    }
    MSPROF_LOGI("Device(%d) ProfHelperServer exit", logicDevId_);
}

}}}