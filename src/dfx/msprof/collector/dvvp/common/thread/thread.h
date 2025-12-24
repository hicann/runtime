/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef ANALYSIS_DVVP_COMMON_THREAD_THREAD_H
#define ANALYSIS_DVVP_COMMON_THREAD_THREAD_H

#include <thread>
#include "osal.h"
#include "utils/utils.h"

namespace analysis {
namespace dvvp {
namespace common {
namespace thread {
using namespace analysis::dvvp::common::utils;
class Thread {
public:
    Thread();
    virtual ~Thread();

    virtual int32_t Start();
    virtual int32_t Stop();
    virtual void StopNoWait()
    {
        quit_ = true;
    };
    int32_t Join();
    bool IsQuit() const;
    void SetThreadName(const std::string &threadName);
    const std::string &GetThreadName() const;

protected:
    virtual void Run(const struct error_message::Context &errorContext) = 0;

private:
    static void *ThrProcess(VOID_PTR arg);

    OsalThread tid_;
    volatile bool quit_;
    volatile bool isStarted_;
    std::string threadName_;
    error_message::Context errorContext_;
};
}  // namespace thread
}  // namespace common
}  // namespace dvvp
}  // namespace analysis

#endif
