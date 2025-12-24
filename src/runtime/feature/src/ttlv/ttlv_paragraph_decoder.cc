/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "ttlv_paragraph_decoder.hpp"
#include "tsch_defines.h"
#include "runtime.hpp"
#include "error_message_manage.hpp"
#include "error_code.h"

namespace cce {
namespace runtime {
TTLVSentenceDecoder &TTLVParagraphDecoder::GetRecentSentence()
{
    if (decoderSentence_.empty()) {
        TTLVSentenceDecoder unknownSentence(static_cast<uint16_t>(TAG_TS_ERR_MSG_UNKNOWN_SENTENCE));
        decoderSentence_.emplace_back(unknownSentence);
    }
    return *(decoderSentence_.end() - 1);
}

void TTLVParagraphDecoder::PrintOut(std::string &outStr)
{
    // record error message
    std::vector<TTLVErrMsgDecoder> userInputErrMsg;
    for (auto &sen : decoderSentence_) {
        for (auto &errMsg : sen.GetErrMsgDecoder()) {
            if (strncmp(errMsg.GetErrCode().c_str(), RT_INNER_ERROR, strnlen(RT_INNER_ERROR,
                static_cast<size_t>(RT_MAX_STRING_LEN))) != 0) {
                userInputErrMsg.emplace_back(errMsg);
            }
        }
    }
    // sort all userInputErrMsg by timestamp
    const auto compFunc = [](const TTLVErrMsgDecoder &msgA, const TTLVErrMsgDecoder &msgB) -> bool {
        const uint64_t timestampSecA = msgA.GetTimestampSec();
        const uint64_t timestampSecB = msgB.GetTimestampSec();
        if (timestampSecA == timestampSecB) {
            const uint64_t timestampUsecA = msgA.GetTimestampUsec();
            const uint64_t timestampUsecB = msgB.GetTimestampUsec();
            return timestampUsecA < timestampUsecB;
        }
        return timestampSecA < timestampSecB;
    };
    // Sort the OpInfos based on the compute cost of the engine
    std::sort(userInputErrMsg.begin(), userInputErrMsg.end(), compFunc);
    // record input error message
    for (auto &msg : userInputErrMsg) {
        if (msg.GetErrCode() != RT_INNER_ERROR) {
            RT_LOG_INNER_DETAIL_MSG(msg.GetErrCode(), {"extend_info"}, {msg.GetErrMsgSting()});
            continue;
        }
        RT_LOG_CALL_MSG(GetTsErrModuleType(msg.GetRetErrCode()), "extend_info: %s", msg.GetErrMsgSting().c_str());
    }
    // print error message string
    for (auto &sen : decoderSentence_) {
        sen.PrintOut(outStr);
    }
}

}
}
