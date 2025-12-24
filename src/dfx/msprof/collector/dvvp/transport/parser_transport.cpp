/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "parser_transport.h"
#include "analyzer.h"
#include "errno/error_code.h"
#include "op_desc_parser.h"
#include "msprof_dlog.h"
#include "prof_acl_mgr.h"
#include "prof_acl_intf.h"

namespace analysis {
namespace dvvp {
namespace transport {
using namespace analysis::dvvp::common::error;
using namespace Msprofiler::Api;

ParserTransport::ParserTransport(SHARED_PTR_ALIA<Uploader> uploader)
{
    MSVP_MAKE_SHARED1(analyzer_, Analysis::Dvvp::Analyze::Analyzer, uploader, return);
}

ParserTransport::~ParserTransport()
{
    CloseSession();
}

int32_t ParserTransport::SendBuffer(CONST_VOID_PTR /* buffer */, int32_t /* length */)
{
    MSPROF_LOGW("No need to send buffer.");
    return 0;
}

int32_t ParserTransport::SendBuffer(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq)
{
    if (analyzer_ != nullptr) {
        analyzer_->OnOptimizeData(fileChunkReq);
        return PROFILING_SUCCESS;
    }
    MSPROF_LOGE("Analyzer is already closed");
    return PROFILING_FAILED;
}

int32_t ParserTransport::CloseSession()
{
    MSPROF_LOGI("ParserTransport Close");
    if (analyzer_ != nullptr) {
        analyzer_->Flush();
        analyzer_->PrintHostStats();
        analyzer_->PrintDeviceStats();
        analyzer_.reset();
    }
    return PROFILING_SUCCESS;
}

void ParserTransport::WriteDone()
{
    MSPROF_LOGI("ParserTransport WriteDone");
    if (analyzer_ != nullptr) {
        analyzer_->Flush();
    }
}

void ParserTransport::SetDevId(const std::string &devIdStr)
{
    MSPROF_LOGI("ParserTransport SetDeviceId");
    if (analyzer_ != nullptr) {
        analyzer_->SetDevId(devIdStr);
    }
}

void ParserTransport::SetType(const uint32_t type)
{
    MSPROF_LOGI("ParserTransport SetType: %u", type);
    if (analyzer_ != nullptr) {
        if (type == static_cast<uint32_t>(Msprof::Engine::Intf::ACL_GRPH_API_TYPE)) {
            analyzer_->SetGraphType(true);
        } else {
            analyzer_->SetGraphType(false);
        }

        if (type == static_cast<uint32_t>(Msprof::Engine::Intf::OP_TYPE)) {
            analyzer_->SetOpType(true);
        } else {
            analyzer_->SetOpType(false);
        }
    }
}

int32_t PipeTransport::SendBuffer(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> /* fileChunkReq */)
{
    MSPROF_LOGE("SendBuffer failed");
    return 0;
}

int32_t PipeTransport::SendBuffer(CONST_VOID_PTR buffer, int32_t length)
{
    int32_t sent = 0;
    const unsigned long pipeFullSleepUs = 1000;  // sleep 1ms and retry
    uint32_t modelId = 0;
    int32_t ret = Analysis::Dvvp::Analyze::OpDescParser::GetModelId(buffer, length, 0, &modelId);
    if (ret != ACL_SUCCESS) {
        MSPROF_LOGE("Failed to parse model id from data");
        return sent;
    }
    uint32_t threadId = 0;
    ret = Analysis::Dvvp::Analyze::OpDescParser::GetThreadId(buffer, length, 0, &threadId);
    if (ret != ACL_SUCCESS) {
        MSPROF_LOGE("Failed to parse thread id from data");
        return sent;
    }
    uint32_t devId = 0;
    ret = Analysis::Dvvp::Analyze::OpDescParser::GetDeviceId(buffer, length, 0, &devId);
    if (ret != ACL_SUCCESS) {
        MSPROF_LOGE("Failed to parse device id from data");
        return sent;
    }
    const ProfSubscribeKey subscribeModelId(modelId);
    int32_t fd = Msprofiler::Api::ProfAclMgr::instance()->GetSubscribeFdForModel(subscribeModelId);
    if (fd < 0) {
        const ProfSubscribeKey subscribeDevIdAndThreadId(devId, threadId);
        fd = Msprofiler::Api::ProfAclMgr::instance()->GetSubscribeFdForModel(subscribeDevIdAndThreadId);
        if (fd < 0) {
            MSPROF_LOGW("Model %u or thread %u not subscribed, drop buffer, size %d", modelId, threadId, length);
            return length;
        }
    }
    MSPROF_LOGD("Write %d bytes to fd %d", length, fd);
    int32_t count = 0;
    while (true) {
        sent = OsalWrite(fd, const_cast<VOID_PTR>(buffer), length);
        if (sent >= 0) {
            break;
        }
        if (errno == EAGAIN) {
            if (count++ % 1000 == 0) {  // record log every 1000 times
                MSPROF_LOGW("Pipe is full, count: %d", count);
            }
            analysis::dvvp::common::utils::Utils::UsleepInterupt(pipeFullSleepUs);
        } else {
            analysis::dvvp::common::utils::Utils::PrintSysErrorMsg();
            break;
        }
    }
    return sent;
}
int32_t PipeTransport::CloseSession()
{
    return PROFILING_SUCCESS;
}
}  // namespace transport
}  // namespace dvvp
}  // namespace analysis
