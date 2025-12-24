/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_TASK_FAIL_CALLBACK_DATA_MANAGER_HPP
#define CCE_RUNTIME_TASK_FAIL_CALLBACK_DATA_MANAGER_HPP

#include <unordered_map>
#include "base.hpp"
#include "runtime.hpp"

namespace cce {
namespace runtime {

struct TaskFailCallbackInfo{
    TaskFailCallbackType    type;
    rtTaskFailCallback      callback;
    rtsTaskFailCallback     callbackV2;
    void                    *args;
};

class TaskFailCallBackManager {
public:
    static TaskFailCallBackManager &Instance();
    rtError_t RegTaskFailCallback(const char_t *regName, void *callback, void *args,
        TaskFailCallbackType type);
    void Notify(rtExceptionInfo_t * const exceptionInfo);
    TaskFailCallBackManager();
    ~TaskFailCallBackManager();

private:
    TaskFailCallBackManager(const TaskFailCallBackManager &other) = delete;
    TaskFailCallBackManager &operator=(const TaskFailCallBackManager &other) = delete;
    TaskFailCallBackManager(TaskFailCallBackManager &&other) = delete;
    TaskFailCallBackManager &operator=(TaskFailCallBackManager &&other) = delete;

private:
    std::unordered_map<std::string, TaskFailCallbackInfo> callbackMap_;
    std::mutex mapMutex_;
};

}
}

#endif // CCE_RUNTIME_TASK_FAIL_CALLBACK_DATA_MANAGER_HPP
