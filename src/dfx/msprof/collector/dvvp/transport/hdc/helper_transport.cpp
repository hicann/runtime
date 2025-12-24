/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "helper_transport.h"
#include "config/config.h"
#include "utils/utils.h"
#include "errno/error_code.h"
#include "adx_prof_api.h"
#include "message/message.h"
#include "memory_utils.h"

namespace analysis {
namespace dvvp {
namespace transport {
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::config;
using namespace analysis::dvvp::common::utils;
using namespace Analysis::Dvvp::Adx;
int32_t SendBufferPacket(HelperTransport &transport, VOID_PTR buffer, int32_t length)
{
    const int32_t retLengthError = -1;
    if (buffer == nullptr) {
        MSPROF_LOGE("buffer is null");
        return retLengthError;
    }
    const uint64_t startRawTime = analysis::dvvp::common::utils::Utils::GetClockMonotonicRaw();
    if (transport.SendAdxBuffer(buffer, length) != PROFILING_SUCCESS) {
        return retLengthError;
    }
    MSPROF_LOGD("SendBufferPacket head=%x, version=%x.", (static_cast<ProfHalTlv *>(buffer))->head,
                (static_cast<ProfHalTlv *>(buffer))->version);
    const uint64_t endRawTime = analysis::dvvp::common::utils::Utils::GetClockMonotonicRaw();
    if (transport.perfCount_ != nullptr) {
        transport.perfCount_->UpdatePerfInfo(startRawTime, endRawTime, length);
    }
    return length;
}

HelperTransport::HelperTransport(HDC_SESSION session, bool isClient, HDC_CLIENT client)
    : session_(session),
      isClient_(isClient),
      client_(client),
      isLastChunk_(false)
{
}

HelperTransport::~HelperTransport()
{
    Destroy();
}

int32_t HelperTransport::SendAdxBuffer(VOID_PTR out, int32_t outLen) const
{
    MSPROF_LOGD("SendAdxBuffer head=%x, version=%x.", (static_cast<ProfHalTlv *>(out))->head,
                (static_cast<ProfHalTlv *>(out))->version);
    int32_t ret = Analysis::Dvvp::Adx::AdxHdcWrite(session_, out, outLen);
    if (ret != IDE_DAEMON_OK) {
        MSPROF_LOGE("hdc write failed, outLen=%d, err=%d.", outLen, ret);
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

int32_t HelperTransport::PackingData(ProfHalStruct &package,
                                     SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq)
{
    std::string pid = std::to_string(Utils::GetPid());
    // copy int32_t info into ProfHalStruct
    isLastChunk_ = fileChunkReq->isLastChunk;
    package.chunkModule = fileChunkReq->chunkModule;
    package.offset = fileChunkReq->offset;
    // copy str info into ProfHalStruct
    (void)memset_s(package.fileName, HAL_FILENAME_MAX_LEN + 1, 0, HAL_FILENAME_MAX_LEN + 1);
    (void)memset_s(package.extraInfo, HAL_EXTRAINFO_MAX_LEN + 1, 0, HAL_EXTRAINFO_MAX_LEN + 1);
    (void)memset_s(package.id, HAL_ID_MAX_LEN + 1, 0, HAL_ID_MAX_LEN + 1);
    auto err = memcpy_s(package.fileName, HAL_FILENAME_MAX_LEN, fileChunkReq->fileName.c_str(),
                        fileChunkReq->fileName.length());
    if (err != EOK) {
        MSPROF_LOGE("[Helper PackingData]memcpy_s fileName failed, ret is %d, fileName is %s.", err,
                    fileChunkReq->fileName.c_str());
        return err;
    }
    err = memcpy_s(package.extraInfo, HAL_EXTRAINFO_MAX_LEN, fileChunkReq->extraInfo.c_str(),
                   fileChunkReq->extraInfo.length());
    if (err != EOK) {
        MSPROF_LOGE("[Helper PackingData]memcpy_s extraInfo failed, ret is %d, extraInfo is %s.", err,
                    fileChunkReq->extraInfo.c_str());
        return err;
    }
    err = memcpy_s(package.id, HAL_ID_MAX_LEN, pid.c_str(), pid.length());
    if (err != EOK) {
        MSPROF_LOGE("[Helper PackingData]memcpy_s id failed, ret is %d, pid is %s.", err, pid.c_str());
        return err;
    }
    MSPROF_LOGD("package.chunkModule:%d, package.offset:%08x.", package.chunkModule, package.offset);
    MSPROF_LOGD("package.fileName:%s, package.extraInfo:%s, package.id:%s.", package.fileName, package.extraInfo,
                package.id);
    return EOK;
}

int32_t HelperTransport::SendPackingData(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq,
                                         ProfHalStruct &package, SHARED_PTR_ALIA<ProfHalTlv> tlvbuff)
{
    uint32_t stackLength = fileChunkReq->chunkSize;
    uint32_t pos = 0;
    int32_t err;
    do {
        (void)memset_s(package.chunk, HAL_CHUNK_MAX_LEN + 1, 0, HAL_CHUNK_MAX_LEN + 1);
        uint32_t copyLen = (stackLength > HAL_CHUNK_MAX_LEN) ? HAL_CHUNK_MAX_LEN : stackLength;
        if (copyLen > 0) {
            err = memcpy_s(package.chunk, HAL_CHUNK_MAX_LEN, fileChunkReq->chunk.c_str() + pos, copyLen);
            if (err != EOK) {
                MSPROF_LOGE("[Helper SendBuffer]memcpy_s chunk failed.");
                return PROFILING_FAILED;
            }
        }
        pos += copyLen;
        stackLength = (stackLength > copyLen) ? (stackLength - copyLen) : 0;
        FillLastChunk(stackLength, package);
        package.chunkSize = copyLen;
        MSPROF_LOGD("[Helper SendBuffer]package.chunkSize:%u bytes, copyLen:%u bytes, package.isLastChunk:%d",
                    package.chunkSize, copyLen, package.isLastChunk);

        // filling tlvbuff finished
        tlvbuff->len = static_cast<uint32_t>(sizeof(ProfHalStruct));
        err = memcpy_s(tlvbuff->value, HAL_TLV_VALUE_MAX_LEN, &package, HAL_TLV_VALUE_MAX_LEN);
        if (err != EOK) {
            MSPROF_LOGE("[Helper SendBuffer] memcpy_s profiling data failed.");
            return PROFILING_FAILED;
        }
        const int32_t tlvbufflen = static_cast<int32_t>(sizeof(ProfHalTlv));
        if (SendBufferPacket(*this, Utils::ReinterpretCast<void *>(tlvbuff.get()), tlvbufflen) != tlvbufflen) {
            MSPROF_LOGE("[Helper SendBuffer] sendbuffer profiling data failed.");
            return PROFILING_FAILED;
        }
    } while (stackLength > 0);

    return PROFILING_SUCCESS;
}

int32_t HelperTransport::SendBuffer(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq)
{
    ProfHalStruct package;
    SHARED_PTR_ALIA<ProfHalTlv> tlvbuff = nullptr;
    MSVP_MAKE_SHARED0(tlvbuff, ProfHalTlv, return PROFILING_FAILED);
    FUNRET_CHECK_NULL_PTR(tlvbuff, return PROFILING_FAILED);
    // filling ProfHalTlv content
    tlvbuff->head = HAL_HELPER_TLV_HEAD;
    tlvbuff->version = HAL_TLV_VERSION;
    tlvbuff->type = HELPER_TLV_TYPE;
    if (fileChunkReq->fileName == DEVICE_PID) {
        tlvbuff->type = HELPER_DEVICE_PID_TYPE;
    }
    MSPROF_LOGD("[HelperTransport_] tlvbuff->head:%x, tlvbuff->version:%u", tlvbuff->head, tlvbuff->version);

    if (PackingData(package, fileChunkReq) != EOK) {
        MSPROF_LOGE("[Helper SendBuffer]Packing data failed.");
        return PROFILING_FAILED;
    }
    return SendPackingData(fileChunkReq, package, tlvbuff);
}

void HelperTransport::FillLastChunk(uint32_t stackLength, ProfHalStruct &package) const
{
    if (stackLength == 0) {
        package.isLastChunk = isLastChunk_;
    } else {
        package.isLastChunk = false;
    }
}

int32_t HelperTransport::ReceivePacket(ProfHalTlv **packet) const
{
    if (packet == nullptr) {
        return PROFILING_FAILED;
    }

    void *buffer = nullptr;
    int32_t bufLen = 0;

    const int32_t ret = Analysis::Dvvp::Adx::AdxHdcRead(session_, &buffer, &bufLen);
    if ((ret != IDE_DAEMON_OK) || (bufLen < static_cast<int32_t>(sizeof(struct ProfHalTlv)))) {
        MSPROF_LOGW("Unable to read HDC message : ret=%d; bufLen=%d", ret, bufLen);
        return PROFILING_FAILED;
    }

    *packet = static_cast<ProfHalTlv *>(buffer);
    return bufLen;
}

void HelperTransport::FreePacket(ProfHalTlv *packet) const
{
    IdeBuffT buf = static_cast<IdeBuffT>(packet);
    Analysis::Dvvp::Adx::AdxIdeFreePacket(buf);
}

int32_t HelperTransport::SendBuffer(CONST_VOID_PTR /* buffer */, int32_t /* length */)
{
    MSPROF_LOGW("No need to send buffer");
    return PROFILING_SUCCESS;
}

void HelperTransport::WriteDone()
{
    MSPROF_LOGI("No need to do anything in helper mode.");
}

int32_t HelperTransport::CloseSession()
{
    std::unique_lock<std::mutex> lk(sessionMtx_);
    if (session_ != nullptr) {
        MSPROF_LOGI("close HDC session");
        if (isClient_) {
            (void)Analysis::Dvvp::Adx::AdxHdcSessionDestroy(session_);
        } else {
            (void)Analysis::Dvvp::Adx::AdxHdcSessionClose(session_);
        }
        session_ = nullptr;
    }
    MSPROF_LOGI("close HDC session finished");
    return PROFILING_SUCCESS;
}

void HelperTransport::Destroy()
{
    CloseSession();
    if (isClient_) {
        if (client_ != nullptr) {
            (void)Analysis::Dvvp::Adx::AdxHdcClientDestroy(client_);
            client_ = nullptr;
        }
    }
}

SHARED_PTR_ALIA<HelperTransport> HelperTransportFactory::CreateHdcServerTransport(int32_t logicDevId,
                                                                                  HDC_SERVER server) const
{
    MSPROF_LOGI("CreateHelperServerTransport begin, logicDevId:%d", logicDevId);
    if (server == nullptr) {
        MSPROF_LOGW("Helper HDC server is invalid");
        return nullptr;
    }
    HDC_SESSION session = Analysis::Dvvp::Adx::AdxHdcServerAccept(server);
    if (session == nullptr) {
        MSPROF_LOGW("Helper HDC session is invalid");
        return nullptr;
    }
    SHARED_PTR_ALIA<HelperTransport> hdcTransport;
    MSVP_MAKE_SHARED2(hdcTransport, HelperTransport, session, false, return hdcTransport);

    MSPROF_LOGI("CreateHdcServerTransport success, logicDevId:%d", logicDevId);
    std::string moduleName = HDC_PERFCOUNT_MODULE_NAME + "_" + std::to_string(logicDevId);
    MSVP_MAKE_SHARED2(hdcTransport->perfCount_, PerfCount, moduleName, TRANSPORT_PRI_FREQ, return nullptr);
    return hdcTransport;
}

SHARED_PTR_ALIA<ITransport> HelperTransportFactory::CreateHdcClientTransport(int32_t hostPid, int32_t devId,
                                                                             HDC_CLIENT client) const
{
    MSPROF_LOGI("Helper createHdcClientTransport, hostPid:%d, devId:%d", hostPid, devId);
    HDC_SESSION session = nullptr;
    int32_t ret = Analysis::Dvvp::Adx::AdxHalHdcSessionConnect(0, devId, hostPid, client, &session);
    if (ret != IDE_DAEMON_OK) {
        MSPROF_LOGW("CreateHdcTransport did not complete successfully, ret is %d", ret);
        return SHARED_PTR_ALIA<ITransport>();
    }
    SHARED_PTR_ALIA<HelperTransport> hdcTransport;
    do {
        MSVP_MAKE_SHARED3_NODO(hdcTransport, HelperTransport, session, true, client, break);
        std::string moduleName = HDC_PERFCOUNT_MODULE_NAME + "_" + std::to_string(hostPid);
        MSVP_MAKE_SHARED2_NODO(hdcTransport->perfCount_, PerfCount, moduleName, TRANSPORT_PRI_FREQ, break);
    } while (0);

    if (hdcTransport == nullptr || hdcTransport->perfCount_ == nullptr) {
        Analysis::Dvvp::Adx::AdxHdcSessionClose(session);
        session = nullptr;
    }
    return hdcTransport;
}
}  // namespace transport
}  // namespace dvvp
}  // namespace analysis