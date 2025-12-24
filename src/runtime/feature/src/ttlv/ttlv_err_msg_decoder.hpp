/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef RT_RUNTIME_TTLV_ERR_MSG_DECODER_HPP
#define RT_RUNTIME_TTLV_ERR_MSG_DECODER_HPP

#include <vector>
#include "ttlv_word_decoder.hpp"

namespace cce {
namespace runtime {
// defined for error message
class TTLVErrMsgDecoder {
public:
    TTLVErrMsgDecoder() : timeStampSec_(MAX_UINT64_NUM),
                          timeStampUsec_(MAX_UINT64_NUM),
                          line_(MAX_UINT16_NUM),
                          retErrCode_(MAX_UINT16_NUM) {}
    void SetTimestampSec(uint64_t timeStamp)
    {
        timeStampSec_ = timeStamp;
    }

    void SetTimestampUsec(uint64_t timeStamp)
    {
        timeStampUsec_ = timeStamp;
    }

    void SetCurrentTime(const std::string &currentTime)
    {
        currentTime_ = currentTime;
    }

    void SetFuncCode(const std::string &funcCode)
    {
        funcCode_ = funcCode;
    }

    void SetLine(uint16_t line)
    {
        line_ = line;
    }

    void SetRetErrCode(uint16_t retErrCode)
    {
        retErrCode_ = retErrCode;
    }

    void SetErrMsgSting(const std::string &str)
    {
        errMsg_ = str;
    }

    void SetErrCode(const std::string &str)
    {
        errCode_ = str;
    }

    void AddWord(TTLVWordDecoder &word)
    {
        decoderWord_.emplace_back(word);
    }

    const std::string &GetErrMsgSting() const
    {
        return errMsg_;
    }

    const std::string &GetErrCode() const
    {
        return errCode_;
    }

    uint64_t GetTimestampSec() const
    {
        return timeStampSec_;
    }

    uint64_t GetTimestampUsec() const
    {
        return timeStampUsec_;
    }

    const std::string &GetCurTime() const
    {
        return currentTime_;
    }

    const std::string &GetFuncCode() const
    {
        return funcCode_;
    }

    uint16_t GetLine() const
    {
        return line_;
    }

    uint16_t GetRetErrCode() const
    {
        return retErrCode_;
    }

    virtual ~TTLVErrMsgDecoder() = default;
private:
    std::vector<TTLVWordDecoder> decoderWord_; // for extention
    uint64_t timeStampSec_;  // define for error message seq
    uint64_t timeStampUsec_;  // define for error message seq
    std::string funcCode_;
    std::string currentTime_;
    uint16_t line_;
    uint16_t retErrCode_;
    std::string errCode_; // defined for judge inner error or input error
    std::string errMsg_;  // define for error message info
};
}
}
#endif // RT_RUNTIME_TTLV_ERR_MSG_DECODER_HPP
