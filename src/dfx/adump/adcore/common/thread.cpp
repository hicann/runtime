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
namespace Adx {
static const int32_t WAIT_TID_TIME   = 500;
/**
 * @brief create thread with default attributes
 * @param [out]tid : thread id
 * @param [int]funcBlock : function name and parameter
 *
 * @return
 *        EN_OK: succ
 *        other: failed
 */
int32_t Thread::CreateTaskWithDefaultAttr(mmThread &tid, mmUserBlock_t &funcBlock)
{
    mmThreadAttr threadAttr = IDE_DAEMON_DEFAULT_THREAD_ATTR;
    return mmCreateTaskWithThreadAttr(&tid, &funcBlock, &threadAttr);
}

/**
 * @brief create detach thread with default attributes
 * @param [out] tid : thread id
 * @param [in]  funcBlock : function name and parameter
 *
 * @return
 *        EN_OK: succ
 *        other: failed
 */
int32_t Thread::CreateDetachTaskWithDefaultAttr(mmThread &tid, mmUserBlock_t &funcBlock)
{
    mmThreadAttr threadAttr = IDE_DAEMON_DEFAULT_DETACH_THREAD_ATTR;
    return mmCreateTaskWithThreadAttr(&tid, &funcBlock, &threadAttr);
}

Runnable::Runnable()
    : tid_(0), quit_(false), isStarted_(false), threadName_("adx")
{
}

Runnable::~Runnable()
{
    Stop();
}

int32_t Runnable::Start()
{
    if (isStarted_) {
        return IDE_DAEMON_ERROR;
    }

    mmUserBlock_t funcBlock;
    funcBlock.procFunc = Runnable::Process;
    funcBlock.pulArg = this;
    quit_ = false;
    int32_t ret = Thread::CreateTaskWithDefaultAttr(tid_, funcBlock);
    if (ret != EN_OK) {
        tid_ = 0;
        return IDE_DAEMON_ERROR;
    }
    isStarted_ = true;
    return IDE_DAEMON_OK;
}

int32_t Runnable::Terminate()
{
    quit_ = true;
    while (tid_ != 0) {
        mmSleep(WAIT_TID_TIME);
    }
    isStarted_ = false;
    return IDE_DAEMON_OK;
}

int32_t Runnable::Stop()
{
    quit_ = true;
    if (isStarted_) {
        isStarted_ = false;
        return Join();
    }

    return IDE_DAEMON_OK;
}

int32_t Runnable::Join()
{
    if (tid_ != 0) {
        int32_t ret = mmJoinTask(&tid_);
        if (ret != EN_OK) {
            return IDE_DAEMON_ERROR;
        }
        isStarted_ = false;
        tid_ = 0;
    }

    return IDE_DAEMON_OK;
}

bool Runnable::IsQuit() const
{
    return quit_;
}

void Runnable::SetThreadName(const std::string &name)
{
    threadName_ = name;
}

const std::string &Runnable::GetThreadName() const
{
    return threadName_;
}

IdeThreadArg Runnable::Process(IdeThreadArg arg)
{
    if (arg == nullptr) {
        return nullptr;
    }
    auto runnable = reinterpret_cast<Runnable *>(arg);
    (void)mmSetCurrentThreadName(runnable->threadName_.c_str());
    runnable->Run();
    return nullptr;
}
}