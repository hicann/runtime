/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "ttlv_word_decoder.hpp"

#include "tsch_defines.h"
#include "ttlv_decoder_utils.hpp"

namespace cce {
namespace runtime {
const std::map<const uint16_t, std::pair<const std::string, PhaseValueToStr>> TTLVWordDecoder::word2DataString = {
    // msg code               parse function
    {TAG_TS_ERR_MSG_TASK_ID, {"task id", &TTLVDecoderUtils::PhaseValueDecimal}},
    {TAG_TS_ERR_MSG_TASK_TYPE, {"task type", &TTLVDecoderUtils::PhaseTaskType}},
    {TAG_TS_ERR_MSG_TASK_PHASE, {"task phase", &TTLVDecoderUtils::PhaseTaskPhase}},
    {TAG_TS_ERR_MSG_LAST_RECEIVE_TASK_ID, {"recently received task id", &TTLVDecoderUtils::PhaseValueDecimal}},
    {TAG_TS_ERR_MSG_LAST_SEND_TASK_ID, {"recently send task id", &TTLVDecoderUtils::PhaseValueDecimal}},
    {TAG_TS_ERR_MSG_STREAM_ID, {"stream id", &TTLVDecoderUtils::PhaseValueDecimal}},
    {TAG_TS_ERR_MSG_STREAM_PHASE, {"stream phase", &TTLVDecoderUtils::PhaseStreamPhase}},
    {TAG_TS_ERR_MSG_MODEL_ID, {"model id", &TTLVDecoderUtils::PhaseValueDecimal}},
    {TAG_TS_ERR_MSG_PID, {"TGID", &TTLVDecoderUtils::PhaseValueDecimal}},
};

rtError_t TTLVWordDecoder::DecodeUnknownData()
{
    std::string contextDescStr = "unknown data";
    std::string dataStr;
    COND_RETURN_WITH_NOLOG(msgLen_ == 0U, RT_ERROR_NONE);
    uint32_t cnt = static_cast<uint32_t>(msgLen_ / sizeof(uint64_t));
    const uint32_t surplus = static_cast<uint32_t>(msgLen_ % sizeof(uint64_t));
    int32_t ret;
    contextDescStr += "[tag=" + std::to_string(static_cast<uint32_t>(tag_)) + "]";
    contextDescStr += "[type=" + std::to_string(static_cast<uint32_t>(type_)) + "]";
    contextDescStr += "[len=" + std::to_string(static_cast<uint32_t>(msgLen_)) + "]=";
    while (cnt != 0U) {
        std::string res;
        ret = TTLVDecoderUtils::PhaseValueHex(msgLen_, buffer_, res);
        if (ret != RT_ERROR_NONE) {
            return ret;
        }
        outputStr_ += res + " ";
        cnt--;
    }
    ret = TTLVDecoderUtils::PhaseValueHex(static_cast<uint16_t>(surplus),
        static_cast<const uint8_t *>(buffer_) + static_cast<uint32_t>(msgLen_) - surplus, dataStr);
    COND_RETURN_WITH_NOLOG(ret != RT_ERROR_NONE, ret);
    outputStr_ += contextDescStr + dataStr;
    return RT_ERROR_NONE;
}

rtError_t TTLVWordDecoder::DecodeWord()
{
    rtError_t ret;
    const auto iter = word2DataString.find(tag_);
    if (iter == word2DataString.end()) {
        ret = DecodeUnknownData();
    } else {
        std::string dataStr;
        ret = iter->second.second(msgLen_, buffer_, dataStr);
        outputStr_ = iter->second.first + "=" + dataStr;
    }
    ERROR_RETURN(ret, "DecodeWord failed, len=%hu, tag=%hu, type=%hu.", msgLen_, tag_, type_);
    return ret;
}

rtError_t TTLVWordDecoder::DecoderBasicType(uint64_t &res) const
{
    return TTLVDecoderUtils::DefaultPhaseValue(msgLen_, buffer_, res);
}

rtError_t TTLVWordDecoder::DecoderString()
{
    std::string str(static_cast<const char_t *>(buffer_), msgLen_);
    outputStr_.swap(str);
    return RT_ERROR_NONE;
}

}
}
