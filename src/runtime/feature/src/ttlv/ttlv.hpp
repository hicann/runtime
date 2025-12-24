/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef RT_RUNTIME_TTLV_HPP
#define RT_RUNTIME_TTLV_HPP

#include "ttlv_paragraph_decoder.hpp"

namespace cce {
namespace runtime {
constexpr uint32_t TTV_HEAD_SIZE = 4U;  // message tag(2B) + message type(2B)
constexpr uint32_t TTLV_HEAD_SIZE = 6U;  // message tag(2B) + message type(2B) + message length(2B)

using addErrMsgInfo = rtError_t (*)(TTLVErrMsgDecoder &, TTLVWordDecoder &);

// defined for device all message decoder
class TTLV {
public:
    TTLV(const void *buffer, uint32_t length) : buffer_(buffer), length_(length), offset_(0U), decodeMsgFlag_(false) {}
    const std::string &GetDecodeStr() const
    {
        return outStr_;
    };
    virtual ~TTLV() = default;
    rtError_t Decode();
    bool DecodeMsgFlag();
    void ParseTTLV(TTLVWordDecoder &ttlv);
    rtError_t GetTTLV(TTLVWordDecoder &ttlvTag);
private:
    rtError_t CheckValid() const;
    const void *buffer_;
    uint32_t length_;
    uint32_t offset_;
    std::string outStr_;
    TTLVParagraphDecoder paragraph_;
    bool decodeMsgFlag_;
};

}
}
#endif // RT_RUNTIME_TTLV_HPP
