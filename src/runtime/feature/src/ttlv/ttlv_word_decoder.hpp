/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef RT_RUNTIME_TTLV_WORD_DECODER_HPP
#define RT_RUNTIME_TTLV_WORD_DECODER_HPP

#include <string>
#include <map>
#include "base.hpp"

namespace cce {
namespace runtime {
using PhaseValueToStr = rtError_t (*)(uint16_t, const void *, std::string &);

// defined for words
class TTLVWordDecoder {
public:
    TTLVWordDecoder():tag_(MAX_UINT16_NUM), msgLen_(MAX_UINT16_NUM), type_(MAX_UINT16_NUM), buffer_(nullptr) {}
    TTLVWordDecoder(uint16_t tag, uint16_t type, uint16_t msgLen, const void *val) : tag_(tag), msgLen_(msgLen),
        type_(type), buffer_(val) {}
    virtual ~TTLVWordDecoder() = default;
    rtError_t DecodeUnknownData();
    rtError_t DecoderBasicType(uint64_t &res) const;
    rtError_t DecoderString();
    rtError_t DecodeWord();

    uint16_t GetTag() const
    {
        return tag_;
    }

    uint16_t GetMsgLen() const
    {
        return msgLen_;
    }

    uint16_t GetType() const
    {
        return type_;
    }

    void SetTag(uint16_t tag)
    {
        tag_ = tag;
    }

    void SetMsgLen(uint16_t msgLen)
    {
        msgLen_ = msgLen;
    }

    void SetType(uint16_t type)
    {
        type_ = type;
    }

    void SetVal(const void *val)
    {
        buffer_ = val;
    }

    const std::string &GetOutputStr() const
    {
        return outputStr_;
    }

private:
    uint16_t tag_;
    uint16_t msgLen_;
    uint16_t type_;
    const void *buffer_;
    std::string outputStr_;
    static const std::map<const uint16_t, std::pair<const std::string, PhaseValueToStr>> word2DataString;
};
}
}
#endif // RT_RUNTIME_TTLV_WORD_DECODER_HPP
