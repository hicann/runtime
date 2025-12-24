/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "hdc_transport.h"
#include "config/config.h"
#include "utils/utils.h"
#include "errno/error_code.h"
#include "adx_prof_api.h"
#include "proto/profiler.pb.h"
#include "message/codec.h"
#include "message/message.h"

namespace analysis {
namespace dvvp {
namespace transport {
using namespace analysis::dvvp::proto;
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::config;
using namespace analysis::dvvp::common::utils;
int32_t SendBufferWithFixedLength(AdxTransport &transport, CONST_VOID_PTR buffer, int32_t length)
{
    const int32_t retLengthError = PROFILING_FAILED;
    if (buffer == nullptr) {
        MSPROF_LOGE("buffer is null");
        return retLengthError;
    }
    IdeBuffT out = nullptr;
    int32_t outLen = 0;
    const uint64_t startRawTime = analysis::dvvp::common::utils::Utils::GetClockMonotonicRaw();
    int32_t ret = Analysis::Dvvp::Adx::AdxIdeCreatePacket(buffer, length, out, outLen);
    if (ret != IDE_DAEMON_OK) {
        MSPROF_LOGE("Failed to AdxIdeCreatePacket, err=%d.", ret);
        return retLengthError;
    }
    ret = transport.SendAdxBuffer(out, outLen);
    Analysis::Dvvp::Adx::AdxIdeFreePacket(out);
    if (ret != PROFILING_SUCCESS) {
        return retLengthError;
    }
    const uint64_t endRawTime = analysis::dvvp::common::utils::Utils::GetClockMonotonicRaw();
    if (transport.perfCount_ != nullptr) {
        transport.perfCount_->UpdatePerfInfo(startRawTime, endRawTime, length);
    }
    return length;
}

HDCTransport::HDCTransport(HDC_SESSION session, bool isClient, HDC_CLIENT client)
    : session_(session), isClient_(isClient), client_(client)
{
}

HDCTransport::~HDCTransport()
{
    Destroy();
}

int32_t HDCTransport::SendAdxBuffer(IdeBuffT out, int32_t outLen)
{
    const int32_t ret = Analysis::Dvvp::Adx::AdxHdcWrite(session_, out, outLen);
    if (ret != IDE_DAEMON_OK) {
        MSPROF_LOGE("hdc write failed, outLen=%d bytes, err=%d.",
                    outLen, ret);
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

int32_t HDCTransport::SendBuffer(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq)
{
    SHARED_PTR_ALIA<analysis::dvvp::proto::FileChunkReq> fileChunk;
    MSVP_MAKE_SHARED0(fileChunk, analysis::dvvp::proto::FileChunkReq, return PROFILING_FAILED);
    SHARED_PTR_ALIA<analysis::dvvp::message::JobContext> jobCtx = nullptr;
    MSVP_MAKE_SHARED0(jobCtx, analysis::dvvp::message::JobContext, return PROFILING_FAILED);
    if (fileChunkReq->extraInfo.empty()) {
        MSPROF_LOGE("FileChunk info is empty in HDC SendBuffer");
        return PROFILING_FAILED;
    }
    jobCtx->job_id = Utils::GetInfoPrefix(fileChunkReq->extraInfo);
    jobCtx->dev_id = Utils::GetInfoSuffix(fileChunkReq->extraInfo);
    jobCtx->tag = Utils::GetInfoSuffix(fileChunkReq->fileName);
    std::string fileNameOri = Utils::GetInfoPrefix(fileChunkReq->fileName);
    fileChunk->set_filename(fileNameOri);
    fileChunk->set_offset(fileChunkReq->offset);
    fileChunk->set_chunk(fileChunkReq->chunk.c_str(), fileChunkReq->chunkSize);
    fileChunk->set_chunksizeinbytes(fileChunkReq->chunkSize);
    fileChunk->set_islastchunk(fileChunkReq->isLastChunk);
    fileChunk->set_needack(false);
    fileChunk->set_datamodule(fileChunkReq->chunkModule);
    fileChunk->mutable_hdr()->set_job_ctx(jobCtx->ToString());
    std::string encoded = analysis::dvvp::message::EncodeMessage(fileChunk);
    const int32_t length = static_cast<int32_t>(encoded.size());
    auto sentLen = SendBufferWithFixedLength(*this, static_cast<void *>(const_cast<CHAR_PTR>(encoded.c_str())), length);
    MSPROF_LOGD("SendBuffer size %d/%d", sentLen, length);
    if (sentLen != length) {
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

int32_t HDCTransport::SendBuffer(CONST_VOID_PTR buffer, int32_t length)
{
    return SendBufferWithFixedLength(*this, buffer, length);
}

int32_t HDCTransport::RecvPacket(TLV_REQ_2PTR packet, uint32_t timeout)
{
    if (packet == nullptr) {
        return PROFILING_FAILED;
    }

    void *buffer = nullptr;
    int32_t bufLen = 0;

    const int32_t ret = Analysis::Dvvp::Adx::AdxHdcRead(session_, &buffer, &bufLen, timeout);
    if ((ret != IDE_DAEMON_OK) || (bufLen < static_cast<int32_t>(sizeof(struct tlv_req)))) {
        MSPROF_LOGW("Unable to read the HDC message: ret=%d; bufLen=%d", ret, bufLen);
        return PROFILING_FAILED;
    }

    *packet = (TLV_REQ_PTR)buffer;
    int32_t noSupMsgSize = CONTAINER_NO_SUPPORT_MESSAGE.size();
    if (buffer != nullptr && (*packet)->len == noSupMsgSize &&
        CONTAINER_NO_SUPPORT_MESSAGE.compare(0, noSupMsgSize, (*packet)->value, noSupMsgSize) == 0) {
        return PROFILING_NOTSUPPORT;
    }

    return bufLen;
}

void HDCTransport::DestroyPacket(TLV_REQ_PTR packet)
{
    IdeBuffT buf = (IdeBuffT)packet;
    Analysis::Dvvp::Adx::AdxIdeFreePacket(buf);
}

int32_t HDCTransport::CloseSession()
{
    std::unique_lock<std::mutex> lk(hdcMtx_);
    if (session_ != nullptr) {
        MSPROF_LOGI("close HDC session");
        if (isClient_) {
            (void)Analysis::Dvvp::Adx::AdxHdcSessionDestroy(session_);
        } else {
            (void)Analysis::Dvvp::Adx::AdxHdcSessionClose(session_);
        }
        session_ = nullptr;
    }
    return PROFILING_SUCCESS;
}

void HDCTransport::Destroy()
{
    CloseSession();
    if (isClient_) {
        if (client_ != nullptr) {
            (void)Analysis::Dvvp::Adx::AdxHdcClientDestroy(client_);
            client_ = nullptr;
        }
    }
}

SHARED_PTR_ALIA<AdxTransport> HDCTransportFactory::CreateHdcTransport(HDC_SESSION session) const
{
    if (session == nullptr) {
        MSPROF_LOGE("HDC session is invalid");
        return nullptr;
    }
    SHARED_PTR_ALIA<HDCTransport> hdcTransport;
    MSVP_MAKE_SHARED1(hdcTransport, HDCTransport, session, return hdcTransport);
    int32_t devId = 0;
    const int32_t err = Analysis::Dvvp::Adx::AdxIdeGetDevIdBySession(session, &devId);
    if (err != IDE_DAEMON_OK) {
        MSPROF_LOGE("IdeGetDevIdBySession failed, err: %d", err);
        return nullptr;
    }
    if (!analysis::dvvp::common::utils::Utils::CheckStringIsNonNegativeIntNum(std::to_string(devId)) ||
        devId >= MSVP_MAX_DEV_NUM) {
        MSPROF_LOGE("[CreateHdcTransport]devId: %d is not valid!", devId);
        return nullptr;
    }
    MSPROF_LOGI("IdeGetDevIdBySession success, devid:%d", devId);
    std::string moduleName = HDC_PERFCOUNT_MODULE_NAME + "_" + std::to_string(devId);
    MSVP_MAKE_SHARED2(hdcTransport->perfCount_, PerfCount, moduleName, TRANSPORT_PRI_FREQ, return nullptr);
    return hdcTransport;
}

SHARED_PTR_ALIA<AdxTransport> HDCTransportFactory::CreateHdcServerTransport(int32_t logicDevId, HDC_SERVER server) const
{
    MSPROF_LOGI("CreateHdcServerTransport begin, logicDevId:%d", logicDevId);
    if (server == nullptr) {
        MSPROF_LOGW("HDC server is invalid");
        return nullptr;
    }
    HDC_SESSION session = Analysis::Dvvp::Adx::AdxHdcServerAccept(server);
    if (session == nullptr) {
        MSPROF_LOGW("HDC session is invalid");
        return nullptr;
    }
    SHARED_PTR_ALIA<HDCTransport> hdcTransport;
    MSVP_MAKE_SHARED2(hdcTransport, HDCTransport, session, false, return hdcTransport);

    MSPROF_LOGI("CreateHdcServerTransport success, logicDevId:%d", logicDevId);
    std::string moduleName = HDC_PERFCOUNT_MODULE_NAME + "_" + std::to_string(logicDevId);
    MSVP_MAKE_SHARED2(hdcTransport->perfCount_, PerfCount, moduleName, TRANSPORT_PRI_FREQ, return nullptr);
    return hdcTransport;
}

SHARED_PTR_ALIA<AdxTransport> HDCTransportFactory::CreateHdcTransport(HDC_CLIENT client, int32_t devId) const
{
    if (client == nullptr) {
        MSPROF_LOGE("HDC client is invalid");
        return SHARED_PTR_ALIA<AdxTransport>();
    }

    HDC_SESSION session = nullptr;

    const int32_t ret = Analysis::Dvvp::Adx::AdxHdcSessionConnect(0, devId, client, &session);
    FUNRET_CHECK_EXPR_ACTION_LOGW(ret != IDE_DAEMON_OK, return SHARED_PTR_ALIA<AdxTransport>(),
        "CreateHdcTransport did not complete successfully, ret is %d", ret);
    SHARED_PTR_ALIA<HDCTransport> hdcTransport;
    do {
        MSVP_MAKE_SHARED2_NODO(hdcTransport, HDCTransport, session, true, break);
        std::string moduleName = HDC_PERFCOUNT_MODULE_NAME + "_" + std::to_string(devId);
        MSVP_MAKE_SHARED2_NODO(hdcTransport->perfCount_, PerfCount, moduleName, TRANSPORT_PRI_FREQ, break);
    } while (0);

    if (hdcTransport == nullptr || hdcTransport->perfCount_ == nullptr) {
        Analysis::Dvvp::Adx::AdxHdcSessionClose(session);
        session = nullptr;
    }

    return hdcTransport;
}

SHARED_PTR_ALIA<AdxTransport> HDCTransportFactory::CreateHdcClientTransport(int32_t hostPid,
    int32_t devId, HDC_CLIENT client) const
{
    MSPROF_LOGI("CreateHdcClientTransport, hostPid:%d, devId:%d", hostPid, devId);

    HDC_SESSION session = nullptr;

    const int32_t ret = Analysis::Dvvp::Adx::AdxHalHdcSessionConnect(0, devId, hostPid, client, &session);
    FUNRET_CHECK_EXPR_ACTION_LOGW(ret != IDE_DAEMON_OK, return SHARED_PTR_ALIA<AdxTransport>(),
        "CreateHdcTransport did not complete successfully, ret is %d", ret);
    SHARED_PTR_ALIA<HDCTransport> hdcTransport;
    do {
        MSVP_MAKE_SHARED3_NODO(hdcTransport, HDCTransport, session, true, client, break);
        std::string moduleName = HDC_PERFCOUNT_MODULE_NAME + "_" + std::to_string(hostPid);
        MSVP_MAKE_SHARED2_NODO(hdcTransport->perfCount_, PerfCount, moduleName, TRANSPORT_PRI_FREQ, break);
    } while (0);

    if (hdcTransport == nullptr || hdcTransport->perfCount_ == nullptr) {
        Analysis::Dvvp::Adx::AdxHdcSessionClose(session);
        session = nullptr;
    }
    return hdcTransport;
}
}}}