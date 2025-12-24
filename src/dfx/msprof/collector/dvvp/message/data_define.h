/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef ANALYSIS_DVVP_MESSAGE_DATA_DEFINE_H
#define ANALYSIS_DVVP_MESSAGE_DATA_DEFINE_H

#include "message.h"

namespace analysis {
namespace dvvp {
namespace message {

struct CollectionTimeInfo : BaseInfo {
    std::string collectionDateBegin;
    std::string collectionDateEnd;
    std::string collectionTimeBegin;
    std::string collectionTimeEnd;
    std::string clockMonotonicRaw;

    void ToObject(NanoJson::Json &object) override
    {
        SET_VALUE(object, collectionDateBegin);
        SET_VALUE(object, collectionDateEnd);
        SET_VALUE(object, collectionTimeBegin);
        SET_VALUE(object, collectionTimeEnd);
        SET_VALUE(object, clockMonotonicRaw);
    }

    void FromObject(NanoJson::Json &object) override {}
};

} // namespace message
} // namespace dvvp
} // namespace analysis

#endif // ANALYSIS_DVVP_MESSAGE_DATA_DEFINE_H