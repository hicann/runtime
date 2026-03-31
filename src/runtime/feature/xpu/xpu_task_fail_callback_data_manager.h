/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_XPU_TASK_FAIL_CALLBACK_DATA_MANAGER_HPP
#define CCE_RUNTIME_XPU_TASK_FAIL_CALLBACK_DATA_MANAGER_HPP

#include <unordered_map>
#include "base.hpp"

namespace cce {
namespace runtime {
class XpuTaskFailCallBackManager {
public:
    static XpuTaskFailCallBackManager &Instance();
    rtError_t RegXpuTaskFailCallback(const char_t *regName, void *callback);
    void XpuNotify(rtExceptionInfo_t * const exceptionInfo);
    XpuTaskFailCallBackManager();
    ~XpuTaskFailCallBackManager();

private:
    XpuTaskFailCallBackManager(const XpuTaskFailCallBackManager &other) = delete;
    XpuTaskFailCallBackManager &operator=(const XpuTaskFailCallBackManager &other) = delete;
    XpuTaskFailCallBackManager(XpuTaskFailCallBackManager &&other) = delete;
    XpuTaskFailCallBackManager &operator=(XpuTaskFailCallBackManager &&other) = delete;

private:
    std::unordered_map<std::string, rtTaskFailCallback> callbackMap_;
    std::mutex mapMutex_;
};

}
}

#endif // CCE_RUNTIME_XPU_TASK_FAIL_CALLBACK_DATA_MANAGER_HPP