/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "ttlv_sentence_decoder.hpp"
#include "tsch_defines.h"

namespace cce {
namespace runtime {
static std::map<const uint16_t, std::vector<std::string>> g_tsCodeToFormatInfo = {
    // msg code             msg desc,prefix,suffix
    {TAG_TS_ERR_MSG_CODE_STRUCT, {"Other info", "\n", ":"}},
    {TAG_TS_ERR_MSG_STRING, {"Message info", "\n", ":"}},
    {TAG_TS_ERR_MSG_SYS_MSG, {"SYSTEM ERROR", "\n", ":"}},
    {TAG_TS_ERR_MSG_TASK_TRACK_MSG, {"EXCEPTION TASK", "\n", ":"}},
    {TAG_TS_ERR_MSG_TASK_ID, {"task id", "", "="}},
    {TAG_TS_ERR_MSG_TASK_TYPE, {"task type", "", "="}},
    {TAG_TS_ERR_MSG_TASK_PHASE, {"task phase", "", "="}},
    {TAG_TS_ERR_MSG_STREAM_DESC_MSG, {"EXCEPTION STREAM", "\n", ":"}},
    {TAG_TS_ERR_MSG_STREAM_ID, {"stream id", "", "="}},
    {TAG_TS_ERR_MSG_STREAM_PHASE, {"stream phase", "", "="}},
    {TAG_TS_ERR_MSG_MODEL_DESC_MSG, {"EXCEPTION MODEL", "\n", ":"}},
    {TAG_TS_ERR_MSG_MODEL_ID, {"model id", "", "="}},
    {TAG_TS_ERR_MSG_PID_DESC_MSG, {"EXCEPTION TGID", "\n", ":"}},
    {TAG_TS_ERR_MSG_PID, {"TGID", "", "="}},
};

void TTLVSentenceDecoder::PrintErrMsg(std::string &outStr, const std::string &space)
{
    int32_t errMsgDepth = 0;
    for (auto &errMsgDecoder : decoderErrMsg_) {
        char_t outputString[RT_MAX_STRING_LEN] = {};
        int32_t copyCnt = 0;
        // print string
        int32_t cnt = sprintf_s(outputString, RT_MAX_STRING_LEN, "%sMessage info[%d]:%s",
            space.c_str(), errMsgDepth, errMsgDecoder.GetErrMsgSting().c_str());
        if (unlikely(cnt < 0)) {
            RT_LOG(RT_LOG_WARNING, "PrintErrMsg failed, sprintf_s ret=%d", cnt);
            return;
        }
        copyCnt += cnt;
        // print error message other info
        auto &currentTime = errMsgDecoder.GetCurTime();
        cnt = sprintf_s(outputString + copyCnt, RT_MAX_STRING_LEN - static_cast<uint32_t>(copyCnt),
                        "\n %s Other info[%d]:time=%s, function=%s, line=%hu, error code=%#hx",
                        space.c_str(), errMsgDepth, currentTime.c_str(), errMsgDecoder.GetFuncCode().c_str(),
                        errMsgDecoder.GetLine(), errMsgDecoder.GetRetErrCode());
        if (unlikely(cnt < 0)) {
            RT_LOG(RT_LOG_WARNING, "PrintErrMsg failed, sprintf_s ret=%d", cnt);
            return;
        }
        outStr += std::string(outputString);
        errMsgDepth++;
    }
}

// EE9001: Repeat bind model, please delete repeat bind operation, maintaince model_id=1.
//         Stream synchronize failed, stream_id=1
// Device[0] inner error:    ----TTLVParagraphDecoder
//   EXCEPTION TASK:         ----TTLVSentenceDecoder
//     Exception info:task_id=512,task_type=aicpu_kernel,stream_id=1, task_phase:TASK_PHASE_WAIT....
//     Message info[0]: Repeat bind model, maintaince model_id=1.       ----TTLVSentenceDecoder::decoderErrMsg_
//     Other info[0]: exception_function_code=6,line=536,return code=0x8F,timestamp=20210802160059.135.
void TTLVSentenceDecoder::PrintOut(std::string &outStr)
{
    std::string space = " ";
    std::string prefix;
    std::string suffix;
    std::string tagStr = "UNKNOWN SENTENCE:";
    std::string lineStr;
    // print tag
    auto iter = g_tsCodeToFormatInfo.find(tag_);
    if (iter != g_tsCodeToFormatInfo.end()) {
        prefix = (*iter).second[RT_DESC_PREFIX_IDX];
        tagStr = (*iter).second[RT_CONTEXT_DESC_IDX];
        suffix = (*iter).second[RT_DESC_SUFFIX_IDX];
    }
    outStr += space + prefix + tagStr + suffix + "\n";
    // print words
    space += " ";
    lineStr += space + "Exception info:";
    bool firstWord = true;
    for (auto &word : decoderWord_) {
        if (firstWord) {
            firstWord = false;
        } else {
            lineStr += ", ";
        }
        lineStr += word.GetOutputStr();
    }
    outStr += lineStr + "\n";
    // print error messages
    PrintErrMsg(outStr, space);
}

}
}
