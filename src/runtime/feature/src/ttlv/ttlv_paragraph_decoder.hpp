/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef RT_RUNTIME_TTLV_PARAGRAPH_DECODER_HPP
#define RT_RUNTIME_TTLV_PARAGRAPH_DECODER_HPP

#include "ttlv_sentence_decoder.hpp"

namespace cce {
namespace runtime {
// defined for message line
class TTLVParagraphDecoder {
public:
    TTLVParagraphDecoder() = default;
    virtual ~TTLVParagraphDecoder() = default;
    void AddSentence(TTLVSentenceDecoder &sentence)
    {
        decoderSentence_.emplace_back(sentence);
    }
    TTLVSentenceDecoder &GetRecentSentence();
    void PrintOut(std::string &outStr);
private:
    std::vector<TTLVSentenceDecoder> decoderSentence_;
};
}
}
#endif // RT_RUNTIME_TTLV_PARAGRAPH_DECODER_HPP
