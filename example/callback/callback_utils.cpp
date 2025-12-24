/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <string>
#include <thread>
#include <sstream>
#include "callback_utils.h"

namespace CallbackUtils {
    bool IsLoopFlag(void *arg)
    {
        if (*(static_cast<bool *>(arg))) {
            return true;
        } else {
            return false;
        }
    }
    std::string GetThreadId(std::thread::id tid)
    {
        std::ostringstream oss;
        oss << tid;
        std::string tidStr = oss.str();
        return tidStr;
    }
}