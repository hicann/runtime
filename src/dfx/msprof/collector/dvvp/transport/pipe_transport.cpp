/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "pipe_transport.h"
#include "errno/error_code.h"
#include "msprof_dlog.h"
#include "securec.h"

namespace analysis {
namespace dvvp {
namespace transport {
using namespace analysis::dvvp::common::error;

MsptiPipeTransport::MsptiPipeTransport(): profRawDataCallback_(nullptr)
{
    MSPROF_LOGD("MsptiPipeTransport init.");
}

MsptiPipeTransport::~MsptiPipeTransport()
{
    MSPROF_LOGD("MsptiPipeTransport uninit.");
    profRawDataCallback_ = nullptr;
}

int32_t MsptiPipeTransport::SendBuffer(CONST_VOID_PTR /* buffer */, int32_t /* length */)
{
    MSPROF_LOGW("No need to send buffer.");
    return 0;
}

int32_t MsptiPipeTransport::ConvertFileChunkToRawData(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq,
    MsprofRawData& rawData) const
{
    rawData.isLastChunk = fileChunkReq->isLastChunk;
    rawData.offset = fileChunkReq->offset;
    rawData.chunkModule = fileChunkReq->chunkModule;
    rawData.deviceId = 0;
    rawData.type = RawDataType::DEFAULT_DATA_TYPE;
    rawData.chunkSize = fileChunkReq->chunkSize;
    errno_t ret = strcpy_s(rawData.chunk, RAW_DATA_MAXSIZE, fileChunkReq->chunk.c_str());
    if (ret != EOK) {
        MSPROF_LOGE("strcpy_s file chunk req to raw data failed.");
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

int32_t MsptiPipeTransport::SendBuffer(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq)
{
    if (profRawDataCallback_ != nullptr) {
        MsprofRawData rawData;
        int32_t ret = ConvertFileChunkToRawData(fileChunkReq, rawData);
        if (ret == PROFILING_SUCCESS) {
            profRawDataCallback_(&rawData);
        }
        return PROFILING_SUCCESS;
    }
    MSPROF_LOGE("profRawDataCallback_ not set");
    return PROFILING_FAILED;
}

int32_t MsptiPipeTransport::CloseSession()
{
    MSPROF_LOGI("MsptiPipeTransport Close");
    return PROFILING_SUCCESS;
}

void MsptiPipeTransport::WriteDone()
{
    MSPROF_LOGI("MsptiPipeTransport WriteDone");
}

void MsptiPipeTransport::RegisterRawDataCallback(MsprofRawDataCallback callback)
{
    if (profRawDataCallback_ != nullptr) {
        MSPROF_LOGW("profRawDataCallback_ has been set before");
    }
    profRawDataCallback_ = callback;
    MSPROF_LOGD("RegisterRawDataCallback done");
}

bool MsptiPipeTransport::IsRegisterRawDataCallback() {
    return (profRawDataCallback_ != nullptr);
}

void MsptiPipeTransport::UnRegisterRawDataCallback()
{
    if (profRawDataCallback_ != nullptr) {
        MSPROF_LOGW("profRawDataCallback_ is null, no need to unregister");
    }
    profRawDataCallback_ = nullptr;
    MSPROF_LOGD("UnRegisterRawDataCallback done");
}

MsptiPipeTransportFactory::MsptiPipeTransportFactory()
{
    MSPROF_LOGD("MsptiPipeTransportFactory.");
}

MsptiPipeTransportFactory::~MsptiPipeTransportFactory()
{
    MSPROF_LOGD("MsptiPipeTransportFactory uninit.");
}

SHARED_PTR_ALIA<ITransport> MsptiPipeTransportFactory::CreateMsptiPipeTransport() const
{
    SHARED_PTR_ALIA<MsptiPipeTransport> msptiPipeTransport;
    MSVP_MAKE_SHARED0(msptiPipeTransport, MsptiPipeTransport, return msptiPipeTransport);
    MSPROF_LOGD("CreateMsptiPipeTransport done");
    return msptiPipeTransport;
}

}  // namespace transport
}  // namespace dvvp
}  // namespace analysis
