/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <klee/klee.h>
#include "runtime/rt.h"
#include "rt_comm_testcase.hpp"

int main() {
    int32_t priority;
    klee_make_symbolic(&priority, sizeof(priority), "priority");
    uint32_t sleepTime;
    klee_make_symbolic(&sleepTime, sizeof(sleepTime), "sleepTime");
    uint32_t count;
    klee_make_symbolic(&count, sizeof(count), "count");
    int32_t listener;
    klee_make_symbolic(&listener, sizeof(listener), "listener");
    int32_t device;
    klee_make_symbolic(&device, sizeof(device), "device");
    uint32_t flags;
    klee_make_symbolic(&flags, sizeof(flags), "flags");

    rt_event_ctx_test(device, flags, priority, sleepTime, count, listener);

    return 0;
}