/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "codec.h"
#include <cstdio>
#include <google/protobuf/util/json_util.h>
#include "config/config.h"
#include "msprof_dlog.h"

namespace analysis {
namespace dvvp {
namespace message {
using namespace analysis::dvvp::common::config;

const google::protobuf::Descriptor *FindMessageTypeByName(const std::string &name)
{
    return google::protobuf::DescriptorPool::generated_pool()->FindMessageTypeByName(name);
}

SHARED_PTR_ALIA<google::protobuf::Message> CreateMessage(const std::string &name)
{
    SHARED_PTR_ALIA<google::protobuf::Message> message = nullptr;
    /* to fix FindMessageTypeByName sometimes returns nullptr */
    std::string descripterStr = name;
    descripterStr.assign(name.c_str());
    const google::protobuf::Descriptor *descriptor = FindMessageTypeByName(descripterStr);
    if (descriptor == nullptr) {
        descriptor = FindMessageTypeByName(descripterStr);
    }

    if (descriptor != nullptr) {
        auto generatedFactory = google::protobuf::MessageFactory::generated_factory();
        if (generatedFactory != nullptr) {
            const google::protobuf::Message *prototype = generatedFactory->GetPrototype(descriptor);
            if (prototype != nullptr) {
                message = SHARED_PTR_ALIA<google::protobuf::Message>(prototype->New());
            } else {
                MSPROF_LOGE("Failed to GetPrototype by descriptor of name=%s", name.c_str());
            }
        } else {
            MSPROF_LOGE("Failed to generated_factory by descriptor of name=%s", name.c_str());
        }
    } else {
        MSPROF_LOGW("Unable to find message type by name %s.", name.c_str());
    }

    return message;
}

/*
|---    4   ---|--- \0 ---|---      xxx      ---|
|---NAME LEN---|---NAME---|---PROTO BUF DATA ---|
*/
bool AppendMessage(std::string &out, SHARED_PTR_ALIA<google::protobuf::Message> message)
{
    if (message == nullptr) {
        return false;
    }
    return message->AppendToString(&out);
}

std::string EncodeMessage(SHARED_PTR_ALIA<google::protobuf::Message> message)
{
    std::string out;

    if (message == nullptr) {
        MSPROF_LOGE("Message is null");
        return out;
    }

    const std::string &type = message->GetTypeName();

    if (type.size() > analysis::dvvp::common::config::MSVP_MESSAGE_TYPE_NAME_MAX_LEN) {
        MSPROF_LOGE("Type size:%zu is invalid", type.size());
        return out;
    }
    auto nameLen = static_cast<uint32_t>(type.size() + 1);
    uint32_t nameLenN = ::htonl(nameLen);

    const int32_t intSize = sizeof(nameLenN);
    union UnionData {
        char data[intSize];
        uint32_t nameLen;
    };

    UnionData ud = { {0} };
    ud.nameLen = nameLenN;
    out.append(ud.data, intSize);
    out.append(type.c_str(), nameLen);

    if (!AppendMessage(out, message)) {
        MSPROF_LOGE("Failed to append message");
        out.clear();
    }

    return out;
}

SHARED_PTR_ALIA<std::string> EncodeMessageShared(SHARED_PTR_ALIA<google::protobuf::Message> message)
{
    SHARED_PTR_ALIA<std::string> out = nullptr;

    if (message == nullptr) {
        MSPROF_LOGE("Message is null");
        return out;
    }

    MSVP_MAKE_SHARED0(out, std::string, return out);

    const std::string &type = message->GetTypeName();

    if (type.size() > analysis::dvvp::common::config::MSVP_MESSAGE_TYPE_NAME_MAX_LEN) {
        MSPROF_LOGE("Type size:%zu is invalid", type.size());
        return out;
    }
    auto nameLen = static_cast<uint32_t>(type.size() + 1);
    uint32_t nameLenN = ::htonl(nameLen);
    out->append(reinterpret_cast<CHAR_PTR>(&nameLenN), sizeof(nameLenN));
    out->append(type.c_str(), nameLen);

    if (!AppendMessage(*(out.get()), message)) {
        MSPROF_LOGE("Failed to append message");
        out.reset();
    }

    return out;
}

SHARED_PTR_ALIA<google::protobuf::Message> DecodeMessage(const std::string &buf)
{
    if (buf.size() > analysis::dvvp::common::config::MSVP_DECODE_MESSAGE_MAX_LEN) {
        MSPROF_LOGE("[DecodeMessage] buf size(%zu) is too big.", buf.size());
        return nullptr;
    }
    SHARED_PTR_ALIA<google::protobuf::Message> message = nullptr;

    size_t bufLen = buf.size();
    uint32_t currLen = 0;

    // parse name len
    if (bufLen < currLen + sizeof(uint32_t)) {
        MSPROF_LOGE("bufLen less than name len, bufLen=%d, expected_len=%d", bufLen, sizeof(uint32_t));
        return message;
    }
    uint32_t nameLen = ::ntohl(*(reinterpret_cast<const uint32_t *>(buf.c_str())));
    if (nameLen > analysis::dvvp::common::config::MSVP_MESSAGE_TYPE_NAME_MAX_LEN + 1) { // 1 :typename + \0
        MSPROF_LOGE("[DecodeMessage] buf size(%u) is too big.", nameLen);
        return nullptr;
    }
    currLen += sizeof(uint32_t);

    // parse name
    if (bufLen < (currLen + nameLen)) {
        MSPROF_LOGE("bufLen less than name, bufLen=%d, expected_len=%d",
            bufLen, currLen + nameLen);
        return message;
    }
    std::string name(buf.begin() + currLen, buf.begin() + currLen + nameLen);
    currLen += nameLen;

    // parse message
    message = CreateMessage(name);
    if (message == nullptr) {
        message = CreateMessage(name);
    }

    if (message != nullptr) {
        int32_t dataLen = bufLen - currLen;
        if (!message->ParseFromArray(buf.c_str() + currLen, dataLen)) {
            MSPROF_LOGE("Failed to ParseFromArray, dataLen=%d", dataLen);
            message.reset();
        }
    } else {
        MSPROF_LOGW("Unable to create message with name %s.", name.c_str());
    }

    return message;
}

}  // namespace message
}  // namespace dvvp
}  // namespace analysis
