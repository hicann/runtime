/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "uploader.h"
#include "config/config.h"
#include "errno/error_code.h"
#include "msprof_dlog.h"
#include "utils/utils.h"

namespace analysis {
namespace dvvp {
namespace transport {
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::config;
using namespace Analysis::Dvvp::MsprofErrMgr;

Uploader::Uploader(SHARED_PTR_ALIA<analysis::dvvp::transport::ITransport> transport)
    : transport_(transport), queue_(nullptr), isInited_(false), forceQuit_(false), isStopped_(false)
{
}

Uploader::~Uploader()
{
    Uinit();
}

int32_t Uploader::Init(size_t size)
{
    int32_t ret = PROFILING_FAILED;

    do {
        MSVP_MAKE_SHARED1_NODO(queue_, UploaderQueue, size, break);
        queue_->SetQueueName(UPLOADER_QUEUE_NAME);
        isInited_ = true;

        ret = PROFILING_SUCCESS;
    } while (0);

    return ret;
}

int32_t Uploader::Uinit()
{
    if (isInited_) {
        (void)Stop(true);
        transport_.reset();
        if (pipeTransport_ != nullptr) {
            pipeTransport_->CloseSession();
            pipeTransport_->WriteDone();
        }
        isInited_ = false;
    }

    return PROFILING_SUCCESS;
}

int32_t Uploader::UploadData(CONST_VOID_PTR data, int32_t len)
{
    if (!isInited_) {
        MSPROF_LOGE("Uploader was not inited.");
        MSPROF_INNER_ERROR("EK9999", "Uploader was not inited.");
        return PROFILING_FAILED;
    }

    if (data == nullptr) {
        MSPROF_LOGE("[Uploader::UploadData]data is nullptr.");
        MSPROF_INNER_ERROR("EK9999", "data is nullptr.");
        return PROFILING_FAILED;
    }

    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq;
    MSVP_MAKE_SHARED0(fileChunkReq, analysis::dvvp::ProfileFileChunk, return PROFILING_FAILED);
    fileChunkReq->chunk = std::string(reinterpret_cast<CHAR_PTR>(const_cast<VOID_PTR>(data)), len);
    fileChunkReq->chunkSize = len;
    fileChunkReq->chunkModule = FileChunkDataModule::PROFILING_IS_FROM_INNER;
    return UploadData(fileChunkReq);
}

int32_t Uploader::UploadData(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq)
{
    if (!isInited_) {
        MSPROF_LOGE("Uploader was not inited.");
        MSPROF_INNER_ERROR("EK9999", "Uploader was not inited.");
        return PROFILING_FAILED;
    }

    if (fileChunkReq == nullptr) {
        MSPROF_LOGE("[Uploader::UploadData]data is nullptr.");
        MSPROF_INNER_ERROR("EK9999", "data is nullptr.");
        return PROFILING_FAILED;
    }
    if (!queue_->Push(fileChunkReq)) {
        MSPROF_LOGE("[Uploader::UploadData]Push data failed.");
        MSPROF_INNER_ERROR("EK9999", "Push data failed.");
        return PROFILING_FAILED;
    }

    return PROFILING_SUCCESS;
}

void Uploader::Run(const struct error_message::Context &errorContext)
{
    MsprofErrorManager::instance()->SetErrorContext(errorContext);
    if (!isInited_) {
        MSPROF_LOGE("Uploader was not inited.");
        MSPROF_INNER_ERROR("EK9999", "Uploader was not inited.");
        return;
    }

    do {
        SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq = nullptr;
        if (!queue_->TryPop(fileChunkReq) && Thread::IsQuit()) {
            break;
        }
        if (fileChunkReq == nullptr) {
            (void)queue_->Pop(fileChunkReq);
        }
        if (fileChunkReq == nullptr) {
            continue;
        }
        // send the data
        if (fileChunkReq->chunkModule == FileChunkDataModule::PROFILING_IS_FROM_INNER) {
            const int32_t sentLen = transport_->SendBuffer(fileChunkReq->chunk.c_str(), fileChunkReq->chunkSize);
            if (pipeTransport_ != nullptr && pipeTransport_->IsRegisterRawDataCallback()) {
                pipeTransport_->SendBuffer(fileChunkReq->chunk.c_str(), fileChunkReq->chunkSize);
            }
            if (sentLen != static_cast<int32_t>(fileChunkReq->chunkSize)) {
                MSPROF_LOGE("Failed to upload data, data_len=%zu bytes, sent len=%d bytes",
                    fileChunkReq->chunkSize, sentLen);
                MSPROF_INNER_ERROR("EK9999", "Failed to upload data, data_len=%zu bytes, sent len=%d bytes",
                    fileChunkReq->chunkSize, sentLen);
            }
        } else {
            if (transport_->SendBuffer(fileChunkReq) != PROFILING_SUCCESS) {
                MSPROF_LOGE("Failed to upload data");
                MSPROF_INNER_ERROR("EK9999", "Failed to upload data");
            }
            if (pipeTransport_ != nullptr && pipeTransport_->IsRegisterRawDataCallback()) {
                int32_t ret = pipeTransport_->SendBuffer(fileChunkReq);
                if (ret != PROFILING_SUCCESS) {
                    MSPROF_LOGE("PipeTransport failed to upload raw data");
                }
            }
        }
    } while (!forceQuit_);

    MSPROF_LOGI("queue size remaining: %zu, force_quit:%d", queue_->Size(), (forceQuit_ ? 1 : 0));
}


// Before you invoke stop, all data should already been enqueued
int32_t Uploader::Stop(bool force)
{
    if (!isStopped_ && isInited_) {
        isStopped_ = true;
        forceQuit_ = force;

        MSPROF_LOGI("Stopping uploader, force_quit:%d.", (forceQuit_ ? 1 : 0));

        queue_->Quit();
        int32_t ret = Thread::Stop();
        if (ret != PROFILING_SUCCESS) {
            MSPROF_LOGE("Failed to stop uploader");
            MSPROF_INNER_ERROR("EK9999", "Failed to stop uploader");
        }
    }

    return PROFILING_SUCCESS;
}

void Uploader::SetTransportStopped()
{
    transport_->SetStopped();
}

void Uploader::SetPipeTransport(SHARED_PTR_ALIA<ITransport> trans) {
    pipeTransport_ = trans;
}

int32_t Uploader::RegisterPipeTransportCallback(MsprofRawDataCallback callback)
{
    if (pipeTransport_ == nullptr) {
        MSPROF_LOGD("pipeTransport_ is null");
        return PROFILING_FAILED;
    }
    pipeTransport_->RegisterRawDataCallback(callback);
    MSPROF_LOGD("PipeTransport register raw data callback done");
    return PROFILING_SUCCESS;
}

int32_t Uploader::UnRegisterPipeTransportCallback()
{
    if (pipeTransport_ == nullptr) {
        MSPROF_LOGD("pipeTransport_ is null");
        return PROFILING_FAILED;
    }
    pipeTransport_->UnRegisterRawDataCallback();
    MSPROF_LOGD("UnRegisterPipeTransportCallback done");
    return PROFILING_SUCCESS;
}

void Uploader::RegisterTransportGenHashIdFuncPtr(HashDataGenIdFuncPtr* ptr)
{
    transport_->RegisterHashDataGenIdFuncPtr(ptr);
}

// wait all data to send
void Uploader::Flush() const
{
    while (queue_->Size() != 0) {
        const unsigned long UPLOADER_SLEEP_TIME_IN_US = 100000;
        analysis::dvvp::common::utils::Utils::UsleepInterupt(UPLOADER_SLEEP_TIME_IN_US);
    }
}

SHARED_PTR_ALIA<analysis::dvvp::transport::ITransport> Uploader::GetTransport()
{
    return transport_;
}
}  // namespace transport
}  // namespace dvvp
}  // namespace analysis
