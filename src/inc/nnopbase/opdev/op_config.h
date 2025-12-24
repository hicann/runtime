/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef OP_API_OP_API_COMMON_INC_OPDEV_OP_CONFIG_H
#define OP_API_OP_API_COMMON_INC_OPDEV_OP_CONFIG_H

#include <cstdint>

namespace op {

struct OpConfigInfo {
    OpConfigInfo() = default;
    OpConfigInfo(const OpConfigInfo &rhs)
    {
        isDeterministicOn_ = rhs.isDeterministicOn_;
        aicNum_ = rhs.aicNum_;
        aivNum_ = rhs.aivNum_;
    }
    OpConfigInfo &operator=(const OpConfigInfo &rhs)
    {
        if (this != &rhs) {
            isDeterministicOn_ = rhs.isDeterministicOn_;
            aicNum_ = rhs.aicNum_;
            aivNum_ = rhs.aivNum_;
        }
        return *this;
    }

    uint32_t aicNum_{0};
    uint32_t aivNum_{0};
    bool isDeterministicOn_{false};
    uint8_t reserved[7] = {0};
};

}  // namespace op

#endif  // OP_API_OP_API_COMMON_INC_OPDEV_OP_CONFIG_H