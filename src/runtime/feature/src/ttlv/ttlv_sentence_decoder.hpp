/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef RT_RUNTIME_TTLV_SENTENCE_DECODER_HPP
#define RT_RUNTIME_TTLV_SENTENCE_DECODER_HPP

#include "ttlv_err_msg_decoder.hpp"

namespace cce {
namespace runtime {
constexpr uint32_t RT_CONTEXT_DESC_IDX = 0U;
constexpr uint32_t RT_DESC_PREFIX_IDX = 1U;
constexpr uint32_t RT_DESC_SUFFIX_IDX = 2U;

// defined for sentence line
class TTLVSentenceDecoder {
public:
    TTLVSentenceDecoder() : tag_(MAX_UINT16_NUM) {};
    explicit TTLVSentenceDecoder(uint16_t tag) : tag_(tag) {}
    virtual ~TTLVSentenceDecoder() = default;
    void AddWord(TTLVWordDecoder &word)
    {
        decoderWord_.emplace_back(word);
    }

    void AddErrMsg(TTLVErrMsgDecoder &word)
    {
        decoderErrMsg_.emplace_back(word);
    }

    TTLVErrMsgDecoder &GetRecentErrMsg()
    {
        if (decoderErrMsg_.empty()) {
            TTLVErrMsgDecoder errMsg;
            decoderErrMsg_.emplace_back(errMsg);
        }
        return *(decoderErrMsg_.end() - 1);
    }

    const std::vector<TTLVErrMsgDecoder> &GetErrMsgDecoder() const
    {
        return decoderErrMsg_;
    }
    void PrintOut(std::string &outStr);
    void PrintErrMsg(std::string &outStr, const std::string &space);
private:
    std::vector<TTLVWordDecoder> decoderWord_; // for specific sentence word, task id, stream id etc.
    std::vector<TTLVErrMsgDecoder> decoderErrMsg_;
    uint16_t tag_;        // used for define how to orgnize the message
};
}
}
#endif // RT_RUNTIME_TTLV_SENTENCE_DECODER_HPP
