/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __CCE_RUNTIME_LOGGER_HPP__
#define __CCE_RUNTIME_LOGGER_HPP__

#include "api.hpp"
#include "engine.hpp"
#include "task.hpp"

namespace cce {
namespace runtime {
class EngineLogObserver : public EngineObserver {
public:
    EngineLogObserver() = default;
    ~EngineLogObserver() override = default;
    void TaskSubmited(Device * const dev, TaskInfo * const tsk) override;
    void TaskLaunched(const uint32_t devId, TaskInfo * const tsk, rtTsCommand_t * const command) override;
    virtual void TaskLaunchedEx(const uint32_t devId, TaskInfo * const tsk, rtTsCommand_t * const command) const;
    void TaskFinished(const uint32_t devId, const TaskInfo * const tsk) override;

private:
    void KernelTaskEventLogProc(const uint32_t devId, const TaskInfo * const logProcTask,
        const char_t * const kernelType) const;
    uint64_t task_launched_num_{0UL};
    uint64_t task_finished_num_{0UL};
};

class Logger : public NoCopy {
public:
    Logger() = default;
    ~Logger() override = default;

    const EngineLogObserver *EngineLogObserver_() const
    {
        return &engineLogObserver_;
    }

private:
    EngineLogObserver engineLogObserver_;
};
}
}

#endif  // __CCE_RUNTIME_LOGGER_HPP__
