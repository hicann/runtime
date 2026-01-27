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
    rtDevBinary_t binary;
    uint32_t magic;
    klee_make_symbolic(&magic, sizeof(magic), "magic");
    binary.magic = magic;
    uint32_t version;
    klee_make_symbolic(&version, sizeof(version), "version");
    binary.version = version;
    uint32_t funcMode;
    klee_make_symbolic(&funcMode, sizeof(funcMode), "funcMode");
    int32_t device;
    klee_make_symbolic(&device, sizeof(device), "device");
    int32_t priority;
    klee_make_symbolic(&priority, sizeof(priority), "priority");
    uint64_t size;
    klee_make_symbolic(&size, sizeof(size), "size");
    uint32_t blockDim;
    klee_make_symbolic(&blockDim, sizeof(blockDim), "blockDim");
    uint32_t argsSize;
    klee_make_symbolic(&argsSize, sizeof(argsSize), "argsSize");
    rtL2Ctrl_t l2ctrl;
    klee_make_symbolic(&l2ctrl, sizeof(l2ctrl), "l2ctrl");

    rt_kernel_test(&binary, funcMode, device, priority, size, blockDim, argsSize, &l2ctrl);
    return 0;
}