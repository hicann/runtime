/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef RT_RUNTIME_TTLV_DECODER_UTILS_HPP
#define RT_RUNTIME_TTLV_DECODER_UTILS_HPP

#include "base.hpp"

namespace cce {
namespace runtime {
class TTLVWordDecoder;
class TTLVErrMsgDecoder;

class TTLVDecoderUtils {
public:
    static rtError_t DefaultPhaseValue(const uint16_t msgLen, const void * const buffer, uint64_t &outData);
    static rtError_t PhaseValueHex(const uint16_t msgLen, const void * const buffer, std::string &outputStr);
    static rtError_t PhaseValueDecimal(const uint16_t msgLen, const void * const buffer, std::string &outputStr);
    static rtError_t PhaseTaskType(const uint16_t msgLen, const void * const buffer, std::string &outputStr);
    static rtError_t PhaseTaskPhase(const uint16_t msgLen, const void * const buffer, std::string &outputStr);
    static rtError_t PhaseStreamPhase(const uint16_t msgLen, const void * const buffer, std::string &outputStr);
    static rtError_t ParseErrCode(TTLVErrMsgDecoder &errMsg, TTLVWordDecoder &ttlvTag);

    static rtError_t ParseTimestampSec(TTLVErrMsgDecoder &errMsg, TTLVWordDecoder &ttlvTag);
    static rtError_t ParseCurrentTimeString(TTLVErrMsgDecoder &errMsg, TTLVWordDecoder &ttlvTag);
    static rtError_t ParseErrMsgString(TTLVErrMsgDecoder &errMsg, TTLVWordDecoder &ttlvTag);
    static rtError_t ParseFuncCode(TTLVErrMsgDecoder &errMsg, TTLVWordDecoder &ttlvTag);
    static rtError_t ParseLineCode(TTLVErrMsgDecoder &errMsg, TTLVWordDecoder &ttlvTag);
    static rtError_t ParseTsErrCode(TTLVErrMsgDecoder &errMsg, TTLVWordDecoder &ttlvTag);
    static rtError_t ParseTimestampUsec(TTLVErrMsgDecoder &errMsg, TTLVWordDecoder &ttlvTag);
};
}
}
#endif // RT_RUNTIME_TTLV_DECODER_UTILS_HPP
