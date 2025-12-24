/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "thread.h"
#include "config/config.h"
#include "errno/error_code.h"
#include "securec.h"
#include "utils/utils.h"

namespace analysis {
namespace dvvp {
namespace common {
namespace thread {
using namespace analysis::dvvp::common::config;
using namespace analysis::dvvp::common::error;
using namespace Analysis::Dvvp::MsprofErrMgr;

Thread::Thread()
    :tid_(0),
     quit_(false),
     isStarted_(false),
     threadName_(MSVP_PROFILER_THREADNAME_MAXNUM, 0),
     errorContext_({0UL, "", "", ""})
{
}

Thread::~Thread()
{
    if (Stop() != PROFILING_SUCCESS) {
        MSPROF_LOGW("Failed to stop thread.");
    }
}

int32_t Thread::Start()
{
    if (isStarted_) {
        return PROFILING_SUCCESS;
    }

    OsalUserBlock funcBlock;
    (void)memset_s(&funcBlock, sizeof(OsalUserBlock), 0, sizeof(OsalUserBlock));
    OsalThreadAttr threadAttr;
    (void)memset_s(&threadAttr, sizeof(OsalThreadAttr), 0, sizeof(OsalThreadAttr));

    funcBlock.procFunc = Thread::ThrProcess;
    funcBlock.pulArg = this;
    const uint32_t defaultStackSize = 128 * 1024; // 128 * 1024 means 128 kb
    threadAttr.stackFlag = 0;
    threadAttr.stackSize = defaultStackSize;

    quit_ = false;
    errorContext_ = MsprofErrorManager::instance()->GetErrorManagerContext();
    int32_t ret = OsalCreateTaskWithThreadAttr(&tid_, &funcBlock, &threadAttr);
    if (ret != OSAL_EN_OK) {
        tid_ = 0;
        return PROFILING_FAILED;
    }
    isStarted_ = true;

    return PROFILING_SUCCESS;
}

int32_t Thread::Stop()
{
    quit_ = true;
    if (isStarted_) {
        isStarted_ = false;
        return Join();
    }

    return PROFILING_SUCCESS;
}

int32_t Thread::Join()
{
    if (tid_ != 0) {
        int32_t ret = OsalJoinTask(&tid_);
        if (ret != OSAL_EN_OK) {
            return PROFILING_FAILED;
        }
        isStarted_ = false;
        tid_ = 0;
    }

    return PROFILING_SUCCESS;
}

bool Thread::IsQuit() const
{
    return quit_;
}

void Thread::SetThreadName(const std::string &threadName)
{
    threadName_ = threadName;
}

const std::string &Thread::GetThreadName() const
{
    return threadName_;
}

void *Thread::ThrProcess(VOID_PTR arg)
{
    if (arg == nullptr) {
        return nullptr;
    }
    auto runnable = reinterpret_cast<Thread *>(arg);
    (void)OsalSetCurrentThreadName(runnable->threadName_.c_str());

    MSPROF_LOGI("New thread [%s] begins to run", runnable->threadName_.c_str());

    runnable->Run(runnable->errorContext_);
    return nullptr;
}
}  // namespace thread
}  // namespace common
}  // namespace dvvp
}  // namespace analysis
