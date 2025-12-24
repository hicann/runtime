/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "ttlv.hpp"
#include <sstream>
#include <map>
#include "tsch_defines.h"
#include "ttlv_decoder_utils.hpp"
#include "error_message_manage.hpp"

namespace cce {
namespace runtime {
static std::map<uint8_t, uint16_t> g_tsDataTypeToSize = {
    {TS_ERR_MSG_UINT8, sizeof(uint8_t)},
    {TS_ERR_MSG_INT8, sizeof(int8_t)},
    {TS_ERR_MSG_UINT16, sizeof(uint16_t)},
    {TS_ERR_MSG_INT16, sizeof(uint16_t)},
    {TS_ERR_MSG_UINT32, sizeof(uint32_t)},
    {TS_ERR_MSG_INT32, sizeof(int32_t)},
    {TS_ERR_MSG_UINT64, sizeof(uint64_t)},
    {TS_ERR_MSG_INT64, sizeof(int64_t)},
};

// define for decode sentence member var
static std::map<uint16_t, addErrMsgInfo> g_addErrMsgInfoMap = {
    {TAG_TS_ERR_MSG_FUNC_CODE, &TTLVDecoderUtils::ParseFuncCode},
    {TAG_TS_ERR_MSG_LINE_CODE, &TTLVDecoderUtils::ParseLineCode},
    {TAG_TS_ERR_MSG_TS_ERR_CODE, &TTLVDecoderUtils::ParseTsErrCode},
    {TAG_TS_ERR_MSG_TIMESTAMP_SEC, &TTLVDecoderUtils::ParseTimestampSec},
    {TAG_TS_ERR_MSG_TIMESTAMP_USEC, &TTLVDecoderUtils::ParseTimestampUsec},
    {TAG_TS_ERR_MSG_CURRENT_TIME, &TTLVDecoderUtils::ParseCurrentTimeString},
    {TAG_TS_ERR_MSG_STRING, &TTLVDecoderUtils::ParseErrMsgString},
    {TAG_TS_ERR_MSG_ERROR_CODE, &TTLVDecoderUtils::ParseErrCode},
};

void TTLV::ParseTTLV(TTLVWordDecoder &ttlv)
{
    // parse tag, add sentence
    if (ttlv.GetTag() >= static_cast<uint16_t>(TAG_TS_ERR_MSG_FIRST_SENTENCE_ID)) {
        if (unlikely(ttlv.GetTag() == static_cast<uint16_t>(TAG_TS_ERR_MSG_FIRST_SENTENCE_ID))) {
            return;
        }
        TTLVSentenceDecoder sen(ttlv.GetTag());
        paragraph_.AddSentence(sen);
        // tag is sentence, no need decode
        return;
    }
    // parse tag, add error message
    if (ttlv.GetTag() == static_cast<uint16_t>(TAG_TS_ERR_MSG_CODE_STRUCT)) {
        TTLVErrMsgDecoder errMsg;
        paragraph_.GetRecentSentence().AddErrMsg(errMsg);
        // tag is error message, no need decode
        return;
    }
    // parse tag, add error message info
    if (ttlv.GetTag() < static_cast<uint16_t>(TAG_TS_ERR_MSG_MAX_ID)) {
        // get error message info
        auto &sen = paragraph_.GetRecentSentence();
        auto &errMsg = sen.GetRecentErrMsg();
        // decode basic type
        const auto addErrMsgInfoIter = g_addErrMsgInfoMap.find(ttlv.GetTag());
        // unknown tag
        if (addErrMsgInfoIter == g_addErrMsgInfoMap.end()) {
            (void)ttlv.DecodeUnknownData();
            errMsg.AddWord(ttlv);
        } else {
            // decode word for error message
            const auto ret = addErrMsgInfoIter->second(errMsg, ttlv);
            COND_RETURN_VOID(ret != RT_ERROR_NONE, "decode word failed, tag=%hu.", ttlv.GetTag());
        }
    } else {
        // add sentence info
        auto &sen = paragraph_.GetRecentSentence();
        if (unlikely(ttlv.DecodeWord() != RT_ERROR_NONE)) {
            offset_ += TTLV_HEAD_SIZE + static_cast<uint32_t>(ttlv.GetMsgLen());
            return;
        }
        sen.AddWord(ttlv);
    }
    offset_ += ttlv.GetMsgLen();
}

rtError_t TTLV::GetTTLV(TTLVWordDecoder &ttlvTag)
{
    uint16_t msgLen;
    const void *tlvValue = nullptr;
    const void * const readBuffer = static_cast<const char_t *>(buffer_) + offset_;
    // read min size is ttv head
    if ((offset_ + sizeof(ts_ttv_msg_t)) > length_) {
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "length is not enough. offset=%u, length=%u, need %zu.",
            offset_, length_, sizeof(ts_ttv_msg_t));
        return RT_ERROR_INVALID_VALUE;
    }

    const uint16_t tag = *(static_cast<const uint16_t *>(readBuffer));
    const uint16_t type = *(static_cast<const uint16_t *>(readBuffer) + 1);
    // get msg length, value
    COND_RETURN_ERROR_MSG_INNER(static_cast<uint32_t>(type) >= TS_ERR_MSG_DATA_TYPE_RESERVED,
        RT_ERROR_INVALID_VALUE,
        "TTLV decode failed, invalid type=%hu can not greater than %u,offset=%u.",
        type, static_cast<uint32_t>(TS_ERR_MSG_DATA_TYPE_RESERVED), offset_);
    // only struct and array using TTLV
    if (static_cast<uint32_t>(type) < TS_ERR_MSG_BASIC_TYPE_MAX_ID) {
        const auto ttv = reinterpret_cast<const ts_ttv_msg_t *>(readBuffer);
        const auto dataTypeIter = g_tsDataTypeToSize.find(static_cast<uint8_t>(ttv->type));
        COND_RETURN_ERROR_MSG_INNER(dataTypeIter == g_tsDataTypeToSize.end(),
            RT_ERROR_INVALID_VALUE,
            "TTLV decode failed, can not find size of type=%hu, offset=%u.", ttv->type, offset_);
        msgLen = dataTypeIter->second;
        // get msg head addr
        tlvValue = reinterpret_cast<const void *>(ttv->value);
        // msg head size + value length
        offset_ += TTV_HEAD_SIZE;
    } else { // use TTLV, sentence, error message, array or other struct
        // TTLV read min size is ttlv head
        if ((offset_ + sizeof(ts_ttlv_msg_t)) > length_) {
            RT_LOG_INNER_MSG(RT_LOG_ERROR,
                "length is not enough for ttlv. offset=%u, length=%u, need %zu, tag=%hu, type=%hu.",
                offset_, length_, sizeof(ts_ttlv_msg_t), tag, type);
            return RT_ERROR_INVALID_VALUE;
        }
        const auto ttlvMsg = reinterpret_cast<const ts_ttlv_msg_t *>(readBuffer);
        // msg head addr
        tlvValue = reinterpret_cast<const void *>(ttlvMsg->value);
        // msg head size
        offset_ += TTLV_HEAD_SIZE;
        // message length should add in parse
        msgLen = ttlvMsg->length;
    }
    if ((offset_ + msgLen) > length_) {
        RT_LOG_INNER_MSG(RT_LOG_ERROR,
            "length is not enough for msg len. offset=%u, length=%u, need %zu, tag=%hu, type=%hu, msgLen=%hu.",
            offset_, length_, sizeof(ts_ttlv_msg_t), tag, type, msgLen);
        return RT_ERROR_INVALID_VALUE;
    }
    ttlvTag.SetTag(tag);
    ttlvTag.SetType(type);
    ttlvTag.SetMsgLen(msgLen);
    ttlvTag.SetVal(tlvValue);
    return RT_ERROR_NONE;
}

rtError_t TTLV::CheckValid() const
{
    COND_RETURN_ERROR_MSG_INNER(buffer_ == nullptr,
                                RT_ERROR_INVALID_VALUE,
                                "buffer is NULL, decode failed.");
    // can not parse msg
    COND_RETURN_ERROR_MSG_INNER((length_ < TTLV_HEAD_SIZE) && (length_ != 0U),
        RT_ERROR_INVALID_VALUE, "length=%u, can not need parse message.", length_);
    return RT_ERROR_NONE;
}

rtError_t TTLV::Decode()
{
    ERROR_RETURN_MSG_INNER(CheckValid(), "CheckValid failed.");
    while (offset_ < length_) {
        TTLVWordDecoder ttlvTag;
        auto err = GetTTLV(ttlvTag);
        ERROR_RETURN_MSG_INNER(err, "Get ttlv failed, offset=%u.", offset_);
        ParseTTLV(ttlvTag);
    }
    paragraph_.PrintOut(outStr_);
    if (unlikely(outStr_.empty())) {
        decodeMsgFlag_ = false;
    } else {
        decodeMsgFlag_ = true;
    }
    return RT_ERROR_NONE;
}

bool TTLV::DecodeMsgFlag()
{
    return decodeMsgFlag_;
}

}
}
