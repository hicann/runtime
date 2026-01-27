/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "ttlv_decoder_utils.hpp"
#include <sstream>
#include "tsch_defines.h"
#include "ttlv_err_msg_decoder.hpp"
#include "error_message_manage.hpp"

namespace cce {
namespace runtime {
static std::map<uint16_t, const char_t *> g_taskType2String = {
    {TS_TASK_TYPE_KERNEL_AICORE, "aicore kernel"},
    {TS_TASK_TYPE_KERNEL_AICPU, "aicpu kernel"},
    {TS_TASK_TYPE_EVENT_RECORD, "event record"},
    {TS_TASK_TYPE_STREAM_WAIT_EVENT, "stream wait event"},
    {TS_TASK_TYPE_FUSION_ISSUE, "fusion issue"},
    {TS_TASK_TYPE_MEMCPY, "memcpy"},
    {TS_TASK_TYPE_MAINTENANCE, "maintenance"},
    {TS_TASK_TYPE_CREATE_STREAM, "create stream"},
    {TS_TASK_TYPE_DATA_DUMP, "data dump"},
    {TS_TASK_TYPE_REMOTE_EVENT_WAIT, "remote event wait"},
    {TS_TASK_TYPE_PCTRACE_ENABLE, "pctrace enable"},
    {TS_TASK_TYPE_CREATE_L2_ADDR, "create l2 address"},
    {TS_TASK_TYPE_MODEL_MAINTAINCE, "model maintaince"},
    {TS_TASK_TYPE_MODEL_EXECUTE, "model execute"},
    {TS_TASK_TYPE_NOTIFY_WAIT, "notify wait"},
    {TS_TASK_TYPE_NOTIFY_RECORD, "notify record"},
    {TS_TASK_TYPE_RDMA_SEND, "rdma send"},
    {TS_TASK_TYPE_STREAM_SWITCH, "stream switch"},
    {TS_TASK_TYPE_STREAM_ACTIVE, "stream active"},
    {TS_TASK_TYPE_LABEL_SET, "label set"},
    {TS_TASK_TYPE_LABEL_SWITCH, "label switch"},
    {TS_TASK_TYPE_LABEL_GOTO, "label goto"},
    {TS_TASK_TYPE_PROFILER_TRACE, "profiler trace"},
    {TS_TASK_TYPE_EVENT_RESET, "event reset"},
    {TS_TASK_TYPE_RDMA_DB_SEND, "rdma db send"},
    {TS_TASK_TYPE_PROFILER_TRACE_EX, "profiler trace extend"},
    {TS_TASK_TYPE_STARS_COMMON, "stars common"},
    {TS_TASK_TYPE_FFTS, "ffts"},
    {TS_TASK_TYPE_PROFILING_ENABLE, "profiling enable"},
    {TS_TASK_TYPE_PROFILING_DISABLE, "profiling disable"},
    {TS_TASK_TYPE_KERNEL_AIVEC, "ai vector"},
    {TS_TASK_TYPE_MODEL_END_GRAPH, "model end graph"},
    {TS_TASK_TYPE_MODEL_TO_AICPU, "model to aicpu"},
    {TS_TASK_TYPE_ACTIVE_AICPU_STREAM, "active aicpu stream"},
    {TS_TASK_TYPE_DATADUMP_LOADINFO, "datadump loadinfo"},
    {TS_TASK_TYPE_STREAM_SWITCH_N, "stream switch N"},
    {TS_TASK_TYPE_HOSTFUNC_CALLBACK, "hostfunc callback"},
    {TS_TASK_TYPE_ONLINEPROF_START, "onlineprof start"},
    {TS_TASK_TYPE_ONLINEPROF_STOP, "onlineprof stop"},
    {TS_TASK_TYPE_STREAM_LABEL_SWITCH_BY_INDEX, "stream label switch by index"},
    {TS_TASK_TYPE_STREAM_LABEL_GOTO, "stream label goto"},
    {TS_TASK_TYPE_DEBUG_REGISTER, "debug register"},
    {TS_TASK_TYPE_DEBUG_UNREGISTER, "debug unregister"},
    {TS_TASK_TYPE_FUSIONDUMP_ADDR_SET, "fusiondump address set"},
    {TS_TASK_TYPE_MODEL_EXIT_GRAPH, "model exit graph"},
    {TS_TASK_TYPE_ADCPROF, "mdcprof"},
    {TS_TASK_TYPE_DEVICE_RINGBUFFER_CONTROL, "device ringbuffer control"},
    {TS_TASK_TYPE_DEBUG_REGISTER_FOR_STREAM, "debug register for stream"},
    {TS_TASK_TYPE_DEBUG_UNREGISTER_FOR_STREAM, "debug unregister for stream"},
    {TS_TASK_TYPE_TASK_TIMEOUT_SET, "task timeout set"},
    {TS_TASK_TYPE_GET_DEVICE_MSG, "get device message"},
    {TS_TASK_TYPE_REDUCE_ASYNC_V2, "reduce async v2"},
};

static std::map<uint8_t, const char_t *> g_taskPhase2String = {
    {TASK_PHASE_INIT, "INIT"},
    {TASK_PHASE_WAIT_EXEC, "WAIT EXECUTE"},
    {TASK_PHASE_RUN, "RUN"},
    {TASK_PHASE_COMPLETE, "COMPLETE"},
    {TASK_PHASE_PENDING, "PENDING"},
    {TASK_PHASE_AICPU_TASK_WAIT, "AICPU_TASK_WAIT"},
    {TASK_PHASE_TASK_PROCESS_MEMCPY, "TASK PROCESS MEMCPY"},
    {TASK_PHASE_AICORE_DONE, "AICORE DONE"},
    {TASK_PHASE_AIV_DONE, "AIVECTOR DONE"},
    {TASK_PHASE_AICPU_TIMEOUT_PROC, "AICPU TIMEOUT PROC"},
};

static std::map<uint16_t, const char_t *> g_streamPhase2String = {
    {STREAM_STATE_INIT, "INIT"},
    {STREAM_STATE_CREATE, "CREATE"},
    {STREAM_STATE_ACTIVE, "ACTIVE"},
    {STREAM_STATE_AICPU_ACTIVE, "AICPU ACTIVE"},
    {STREAM_STATE_SCHEDULE, "SCHEDULE"},
    {STREAM_STATE_DEACTIVE, "DEACTIVE"},
    {STREAM_STATE_DESTROY, "DESTROY"},
    {STREAM_STATE_RECYCLE, "RECYCLE"}
};

rtError_t TTLVDecoderUtils::DefaultPhaseValue(const uint16_t msgLen, const void * const buffer, uint64_t &outData)
{
    // no need parse
    if (msgLen == 0U) {
        return RT_ERROR_NONE;
    }
    if (msgLen > sizeof(uint64_t)) {
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "Can not parse this message, msgLen=%hu", msgLen);
        return RT_ERROR_INVALID_VALUE;
    }
    const auto err = memcpy_s(static_cast<void *>(&outData), sizeof(uint64_t), buffer,
        static_cast<std::size_t>(msgLen));
    COND_RETURN_ERROR_MSG_INNER(err != 0, RT_ERROR_SEC_HANDLE, "memcpy_s failed, copy size=%hu", msgLen);
    return RT_ERROR_NONE;
}

rtError_t TTLVDecoderUtils::PhaseValueHex(const uint16_t msgLen, const void * const buffer, std::string &outputStr)
{
    uint64_t outData = 0UL;
    const int32_t ret = DefaultPhaseValue(msgLen, buffer, outData);
    if (ret != RT_ERROR_NONE) {
        return ret;
    }
    std::ostringstream out;
    out << "0x" << std::hex << outData;
    outputStr = out.str();
    return ret;
}

rtError_t TTLVDecoderUtils::PhaseValueDecimal(const uint16_t msgLen, const void * const buffer, std::string &outputStr)
{
    uint64_t outData = 0UL;
    const int32_t ret = DefaultPhaseValue(msgLen, buffer, outData);
    if (ret != RT_ERROR_NONE) {
        return ret;
    }
    outputStr = std::to_string(outData);
    return ret;
}

rtError_t TTLVDecoderUtils::PhaseTaskType(const uint16_t msgLen, const void * const buffer, std::string &outputStr)
{
    if (msgLen != sizeof(uint16_t)) { // task type is uint16_t
        RT_LOG(RT_LOG_WARNING, "PhaseTaskType failed, msgLen=%hu", msgLen);
        return RT_ERROR_INVALID_VALUE;
    }
    const uint16_t taskType = *(static_cast<const uint16_t *>(buffer));
    int32_t ret = RT_ERROR_NONE;
    const auto iter = g_taskType2String.find(taskType);
    if (iter != g_taskType2String.end()) {
        const auto &outStr = (*iter).second;
        outputStr = std::string(outStr);
    } else {
        ret = PhaseValueDecimal(msgLen, buffer, outputStr);
    }
    return ret;
}

rtError_t TTLVDecoderUtils::PhaseTaskPhase(const uint16_t msgLen, const void * const buffer, std::string &outputStr)
{
    if (msgLen != sizeof(uint8_t)) { // task phase is uint16_t
        RT_LOG(RT_LOG_WARNING, "PhaseTaskPhase failed, msgLen=%hu", msgLen);
        return RT_ERROR_INVALID_VALUE;
    }
    const uint8_t taskPhase = *(static_cast<const uint8_t *>(buffer));
    int32_t ret = RT_ERROR_NONE;
    const auto iter = g_taskPhase2String.find(taskPhase);
    if (iter != g_taskPhase2String.end()) {
        const auto &outStr = (*iter).second;
        outputStr = std::string(outStr);
    } else {
        ret = PhaseValueDecimal(msgLen, buffer, outputStr);
    }
    return ret;
}

rtError_t TTLVDecoderUtils::PhaseStreamPhase(const uint16_t msgLen, const void * const buffer, std::string &outputStr)
{
    if (msgLen != sizeof(uint16_t)) { // task phase is uint16_t
        RT_LOG(RT_LOG_WARNING, "PhaseStreamPhase failed, msgLen=%hu", msgLen);
        return RT_ERROR_INVALID_VALUE;
    }
    const uint16_t streamPhase = *(static_cast<const uint16_t *>(buffer));
    rtError_t ret = RT_ERROR_NONE;
    const auto iter = g_streamPhase2String.find(streamPhase);
    if (iter != g_streamPhase2String.end()) {
        const auto &outStr = (*iter).second;
        outputStr = std::string(outStr);
    } else {
        ret = PhaseValueDecimal(msgLen, buffer, outputStr);
    }
    return ret;
}

// define for decode err message member var
rtError_t TTLVDecoderUtils::ParseFuncCode(TTLVErrMsgDecoder &errMsg, TTLVWordDecoder &ttlvTag)
{
    ERROR_RETURN(ttlvTag.DecoderString(), "ParseFuncCode failed, tag=%hu, type=%hu, len=%hu.",
                 ttlvTag.GetTag(), ttlvTag.GetType(), ttlvTag.GetMsgLen());
    errMsg.SetFuncCode(ttlvTag.GetOutputStr());
    return RT_ERROR_NONE;
}

rtError_t TTLVDecoderUtils::ParseLineCode(TTLVErrMsgDecoder &errMsg, TTLVWordDecoder &ttlvTag)
{
    uint64_t res = 0U;
    ERROR_RETURN(ttlvTag.DecoderBasicType(res), "ParseLineCode failed, tag=%hu, type=%hu, len=%hu.",
                 ttlvTag.GetTag(), ttlvTag.GetType(), ttlvTag.GetMsgLen());
    errMsg.SetLine(static_cast<uint16_t>(res));
    return RT_ERROR_NONE;
}

rtError_t TTLVDecoderUtils::ParseTsErrCode(TTLVErrMsgDecoder &errMsg, TTLVWordDecoder &ttlvTag)
{
    uint64_t res = 0U;
    ERROR_RETURN(ttlvTag.DecoderBasicType(res), "ParseTsErrCode failed, tag=%hu, type=%hu, len=%hu.",
                 ttlvTag.GetTag(), ttlvTag.GetType(), ttlvTag.GetMsgLen());
    errMsg.SetRetErrCode(static_cast<uint16_t>(res));
    return RT_ERROR_NONE;
}

rtError_t TTLVDecoderUtils::ParseTimestampSec(TTLVErrMsgDecoder &errMsg, TTLVWordDecoder &ttlvTag)
{
    uint64_t res = 0U;
    ERROR_RETURN(ttlvTag.DecoderBasicType(res), "ParseTimestampSec failed, tag=%hu, type=%hu, len=%hu.",
                 ttlvTag.GetTag(), ttlvTag.GetType(), ttlvTag.GetMsgLen());
    errMsg.SetTimestampSec(res);
    return RT_ERROR_NONE;
}

rtError_t TTLVDecoderUtils::ParseTimestampUsec(TTLVErrMsgDecoder &errMsg, TTLVWordDecoder &ttlvTag)
{
    uint64_t res = 0U;
    ERROR_RETURN(ttlvTag.DecoderBasicType(res), "ParseTimestampUsec failed, tag=%hu, type=%hu, len=%hu.",
                 ttlvTag.GetTag(), ttlvTag.GetType(), ttlvTag.GetMsgLen());
    errMsg.SetTimestampUsec(res);
    return RT_ERROR_NONE;
}

rtError_t TTLVDecoderUtils::ParseCurrentTimeString(TTLVErrMsgDecoder &errMsg, TTLVWordDecoder &ttlvTag)
{
    ERROR_RETURN(ttlvTag.DecoderString(), "ParseCurrentTimeString failed, tag=%hu, type=%hu, len=%hu.",
                 ttlvTag.GetTag(), ttlvTag.GetType(), ttlvTag.GetMsgLen());
    errMsg.SetCurrentTime(ttlvTag.GetOutputStr());
    return RT_ERROR_NONE;
}

rtError_t TTLVDecoderUtils::ParseErrMsgString(TTLVErrMsgDecoder &errMsg, TTLVWordDecoder &ttlvTag)
{
    ERROR_RETURN(ttlvTag.DecoderString(), "ParseErrMsgString failed, tag=%hu, type=%hu, len=%hu.",
                 ttlvTag.GetTag(), ttlvTag.GetType(), ttlvTag.GetMsgLen());
    errMsg.SetErrMsgSting(ttlvTag.GetOutputStr());
    return RT_ERROR_NONE;
}

rtError_t TTLVDecoderUtils::ParseErrCode(TTLVErrMsgDecoder &errMsg, TTLVWordDecoder &ttlvTag)
{
    ERROR_RETURN(ttlvTag.DecoderString(), "ParseErrCode failed, tag=%hu, type=%hu, len=%hu.",
                 ttlvTag.GetTag(), ttlvTag.GetType(), ttlvTag.GetMsgLen());
    errMsg.SetErrCode(ttlvTag.GetOutputStr());
    return RT_ERROR_NONE;
}

}
}
