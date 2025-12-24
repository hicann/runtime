/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "prof_hdc_server.h"
#include <chrono>
#include "codec.h"
#include "error_code.h"
#include "msprof_dlog.h"
#include "transport/hdc/hdc_transport.h"
#include "transport/transport.h"
#include "config/config.h"
#include "proto/profiler.pb.h"
#include "adx_prof_api.h"
#include "message.h"

namespace Dvvp {
namespace Hal {
namespace Server {
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::transport;
using namespace Analysis::Dvvp::MsprofErrMgr;

ProfHdcServer::ProfHdcServer()
    : dataInitialized_(false), logicDevId_(-1), server_(nullptr), logicDevIdStr_(""),
    flushModuleCallback_(nullptr), sendAicpuDataCallback_(nullptr),
    setHelperDirCallback_(nullptr)
{}

ProfHdcServer::~ProfHdcServer()
{
    UnInit();
}

int32_t ProfHdcServer::Init(const int32_t logicDevId)
{
    logicDevId_ = logicDevId;
    logicDevIdStr_ = std::to_string(logicDevId_);
    dataInitialized_ = true;
    MSPROF_LOGI("ProfHdcServer init, logicDevId:%d", logicDevId);
    if (!analysis::dvvp::common::utils::Utils::CheckStringIsNonNegativeIntNum(logicDevIdStr_) ||
        logicDevId >= MSVP_MAX_DEV_NUM) {
        MSPROF_LOGE("[ProfHdcServer]devId: %d is not valid!", logicDevId);
        MSPROF_INNER_ERROR("EK9999", "devId: %d is not valid!", logicDevId);
        return PROFILING_FAILED;
    }
    server_ = Analysis::Dvvp::Adx::AdxHdcServerCreate(logicDevId, HDC_SERVICE_TYPE_PROFILING);
    if (server_ == nullptr) {
        MSPROF_LOGW("HDC server is invalid");
    }
    Thread::SetThreadName(analysis::dvvp::common::config::MSVP_HDC_DUMPER_THREAD_NAME);

    if (Thread::Start() != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to start the logicDevId:%d in ProfHdcServer", logicDevId_);
        MSPROF_INNER_ERROR("EK9999", "Failed to start the logicDevId:%d in ProfHdcServer", logicDevId_);
        return PROFILING_FAILED;
    } else {
        MSPROF_LOGI("Succeeded in starting the logicDevId:%d in ProfHdcServer", logicDevId_);
    }
    return PROFILING_SUCCESS;
}

int32_t ProfHdcServer::UnInit()
{
    MSPROF_LOGI("Uinit ProfHdcServer Transport Begin, logicDevId:%d", logicDevId_);
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
                MSPROF_LOGI("Device(%d) ProfHdcServer wait for receiving data success", logicDevId_);
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
    MSPROF_LOGI("Uinit ProfHdcServer Transport End, logicDevId:%d", logicDevId_);
    return PROFILING_SUCCESS;
}

int32_t ProfHdcServer::ReceiveStreamData(CONST_VOID_PTR data, uint32_t dataLen)
{
    if ((data == nullptr) || (dataLen == 0) || (dataLen > analysis::dvvp::common::config::PROFILING_PACKET_MAX_LEN)) {
        MSPROF_LOGE("receive stream data, args invalid, data=%d, dataLen=%d.",
            ((data == nullptr) ? 0 : 1), dataLen);
        MSPROF_INNER_ERROR("EK9999", "receive stream data, args invalid, data=%d, dataLen=%d.",
            ((data == nullptr) ? 0 : 1), dataLen);
        return PROFILING_FAILED;
    }
    auto message = std::dynamic_pointer_cast<analysis::dvvp::proto::FileChunkReq>(
            analysis::dvvp::message::DecodeMessage(std::string(static_cast<CONST_CHAR_PTR>(data), dataLen)));
    if (message == nullptr) {
        MSPROF_LOGE("receive stream data, message = nullptr");
        MSPROF_INNER_ERROR("EK9999", "receive stream data, message = nullptr");
        return PROFILING_FAILED;
    }
    if (message->islastchunk() && message->chunksizeinbytes() == 0) {
        flushModuleCallback_();
        return PROFILING_SUCCESS;
    }
    analysis::dvvp::message::JobContext jobCtx;
    if (!jobCtx.FromString(message->hdr().job_ctx())) {
        MSPROF_LOGE("Failed to parse jobCtx:%s, devId:%d", message->hdr().job_ctx().c_str(), logicDevId_);
        MSPROF_INNER_ERROR("EK9999", "Failed to parse jobCtx:%s, devId:%d",
            message->hdr().job_ctx().c_str(), logicDevId_);
        return PROFILING_FAILED;
    }
    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq;
    MSVP_MAKE_SHARED0(fileChunkReq, analysis::dvvp::ProfileFileChunk, return PROFILING_FAILED);
    fileChunkReq->fileName = Utils::PackDotInfo(message->filename(), jobCtx.tag);
    fileChunkReq->chunk = std::string(message->chunk().c_str(), message->chunksizeinbytes());
    fileChunkReq->chunkSize = message->chunksizeinbytes();
    fileChunkReq->isLastChunk = message->islastchunk();
    fileChunkReq->chunkModule = message->datamodule();
    fileChunkReq->offset = message->offset();
    fileChunkReq->extraInfo = Utils::PackDotInfo(jobCtx.job_id, logicDevIdStr_);
    return sendAicpuDataCallback_(fileChunkReq);
}

void ProfHdcServer::Run(const struct error_message::Context &errorContext)
{
    MsprofErrorManager::instance()->SetErrorContext(errorContext);
    if (!dataInitialized_) {
        MSPROF_LOGE("ProfHdcServer is not inited, logicDevId:%d", logicDevId_);
        MSPROF_INNER_ERROR("EK9999", "ProfHdcServer is not inited, logicDevId:%d", logicDevId_);
        return;
    }

    MSPROF_LOGI("Device(%d) ProfHdcServer is running", logicDevId_);
    while (!IsQuit()) {
        MSPROF_LOGI("Device(%d) ProfHdcServer CreateHdcServerTransport begin", logicDevId_);
        auto dataTran = analysis::dvvp::transport::HDCTransportFactory().CreateHdcServerTransport(logicDevId_, server_);
        if (dataTran == nullptr) {
            MSPROF_LOGW("Device(%d) can not CreateHdcServerTransport", logicDevId_);
            return;
        }

        dataTran_.push_back(dataTran);
        auto retval = std::async(std::launch::async, [this, dataTran]()->int32_t {
            TLV_REQ_PTR packet = nullptr;
            int32_t ret = PROFILING_SUCCESS;
            MSPROF_LOGI("Device(%d) ProfHdcServer read message begin", this->logicDevId_);
            while (!IsQuit()) {
                packet = nullptr;
                ret = dataTran->RecvPacket(&packet);
                if (ret < 0 || packet == nullptr) {
                    MSPROF_EVENT("Device(%d) ProfHdcServer recv data ends, exits", this->logicDevId_);
                    break;
                }

                MSPROF_LOGD("[HdcTransport] RecvDataPacket %d bytes", packet->len);
                ret = ReceiveStreamData(packet->value, packet->len);
                if (ret != PROFILING_SUCCESS) {
                    MSPROF_LOGE("Device(%d) ReceiveStreamData failed", this->logicDevId_);
                    MSPROF_INNER_ERROR("EK9999", "Device(%d) ReceiveStreamData failed", this->logicDevId_);
                }
                dataTran->DestroyPacket(packet);
                packet = nullptr;
            }
            dataTran->CloseSession();
            MSPROF_LOGI("Device(%d) ProfHdcServer read message end", logicDevId_);
            return ret;
        });
        MSPROF_LOGI("Device(%d) ProfHdcServer CreateHdcServerTransport success", logicDevId_);
        result_.emplace_back(std::move(retval));
    }
    MSPROF_LOGI("Device(%d) ProfHdcServer exit", logicDevId_);
}
}
}
}