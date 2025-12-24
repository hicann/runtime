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
#include "mmpa_api.h"
#include "extra_config.h"

namespace Adx {
const mmThreadAttr IDE_DAEMON_DEFAULT_THREAD_ATTR        = {0, 0, 0, 0, 0, 1, 128 * 1024};
const mmThreadAttr IDE_DAEMON_DEFAULT_DETACH_THREAD_ATTR = {1, 0, 0, 0, 0, 1, 128 * 1024};

class Thread {
public:
    static int32_t CreateTask(mmThread &tid, mmUserBlock_t &funcBlock);
    static int32_t CreateDetachTask(mmThread &tid, mmUserBlock_t &funcBlock);
    static int32_t CreateTaskWithDefaultAttr(mmThread &tid, mmUserBlock_t &funcBlock);
    static int32_t CreateDetachTaskWithDefaultAttr(mmThread &tid, mmUserBlock_t &funcBlock);
};

class Runnable {
public:
    Runnable();
    virtual ~Runnable();
    virtual int32_t Start();
    virtual int32_t Terminate();
    int32_t Stop();
    int32_t Join();
    bool IsQuit() const;
    void SetThreadName(const std::string &name);
    const std::string &GetThreadName() const;

protected:
    virtual void Run() = 0;

private:
    static IdeThreadArg Process(IdeThreadArg arg);
private:
    mmThread tid_;
    mutable bool quit_;
    mutable bool isStarted_;
    std::string threadName_;
};
}
#endif
