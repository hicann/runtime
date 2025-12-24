/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef IDE_DAEMON_COMMON_THREAD_H
#define IDE_DAEMON_COMMON_THREAD_H
#include <string>
#include <cstdint>
#include "osal.h"
#include "extra_config.h"
#include "error_manager.h"

#define IDE_DAEMON_DEFAULT_THREAD_ATTR        {0, 0, 0, 0, 0, 1, 128 * 1024}
#define IDE_DAEMON_DEFAULT_DETACH_THREAD_ATTR {1, 0, 0, 0, 0, 1, 128 * 1024}

namespace Adx {
static const int32_t WAIT_TID_TIME   = 500;

class Thread {
public:
    static int32_t CreateTask(OsalThread &tid, OsalUserBlock &funcBlock);
    static int32_t CreateTaskWithDefaultAttr(OsalThread &tid, OsalUserBlock &funcBlock);
    static int32_t CreateDetachTaskWithDefaultAttr(OsalThread &tid, OsalUserBlock &funcBlock);
    static int32_t CreateDetachTask(OsalThread &tid, OsalUserBlock &funcBlock);
};

class Runnable {
public:
    Runnable();
    virtual ~Runnable();
    virtual int32_t Terminate();
    virtual int32_t Stop();
    int32_t Join();
    bool IsQuit();
    virtual int32_t Start();
    const std::string &GetThreadName();
    void SetThreadName(const std::string &threadName);

protected:
    virtual void Run(const struct error_message::Context &errorContext) = 0;

private:
    static IdeThreadArg Process(IdeThreadArg arg);

private:
    mutable bool quit_;
    OsalThread tid_;
    mutable bool isStarted_;
    std::string threadName_;
};
}
#endif
