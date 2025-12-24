/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ANALYSIS_DVVP_MESSAGE_CODEC_H
#define ANALYSIS_DVVP_MESSAGE_CODEC_H

#include <memory>
#include <string>
#include <google/protobuf/descriptor.h>
#include <google/protobuf/message.h>
#include "utils/utils.h"

namespace analysis {
namespace dvvp {
namespace message {
using namespace analysis::dvvp::common::utils;
enum class E_CODEC_FORMAT {
    CODEC_FORMAT_JSON = 0,
    CODEC_FORMAT_BINARY = 1,
};
const google::protobuf::Descriptor *FindMessageTypeByName(const std::string &name);
SHARED_PTR_ALIA<google::protobuf::Message> CreateMessage(const std::string &name);
bool AppendMessage(std::string &out, SHARED_PTR_ALIA<google::protobuf::Message> message);
SHARED_PTR_ALIA<std::string> EncodeMessageShared(SHARED_PTR_ALIA<google::protobuf::Message> message = nullptr);
std::string EncodeMessage(SHARED_PTR_ALIA<google::protobuf::Message> message = nullptr);
SHARED_PTR_ALIA<google::protobuf::Message> DecodeMessage(const std::string &buf);
}  // namespace message
}  // namespace dvvp
}  // namespace analysis

#endif
