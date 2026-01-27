/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <stdint.h>
#include <stddef.h>
#include <stdio.h>
#include <string.h>
#include <string>
#include "runtime/rt.h"
#include "rt_comm_testcase.hpp"

typedef struct tagRtKernelFuzzer
{
    int32_t     priority;
    uint64_t    size;
    uint32_t    magic;
    uint32_t    version;
    uint32_t    funcMode;
    int32_t     device;
    uint32_t    blockDim;
    uint32_t    argsSize;
    rtL2Ctrl_t  l2ctrl;
} rtKernelFuzzer;

int rt_kernel_fuzzer(const uint8_t *Data, size_t DataSize)
{
    rtKernelFuzzer *fuzzer = (rtKernelFuzzer *)Data;
    if (DataSize <= sizeof(rtKernelFuzzer))
        return 0;
    
    rtDevBinary_t binary;
    binary.magic = fuzzer->magic;
    binary.version = fuzzer->version;
    uint32_t funcMode = fuzzer->funcMode;
    int32_t device = fuzzer->device;
    int32_t priority = fuzzer->priority;
    uint64_t size = fuzzer->size;
    uint32_t blockDim = fuzzer->blockDim;
    uint32_t argsSize = fuzzer->argsSize;
    rtL2Ctrl_t l2ctrl = fuzzer->l2ctrl;
    rt_kernel_test(&binary, funcMode, device, priority, size, blockDim, argsSize, &l2ctrl);

    return 0;
}

#if 0
int seed_gen(rtKernelFuzzer *fuzzer, const char *seed_file)
{
    size_t size = sizeof(rtKernelFuzzer);
    rt_kernel_fuzzer((uint8_t *)fuzzer, size);
    FILE *fp = fopen(seed_file, "wb");
    fwrite(&fuzzer, size, 1, fp);
    fclose(fp);
    return 0;
}

//using for seed generate
int main() {
    rtKernelFuzzer fuzzer1;
    fuzzer1.priority = 0;
    fuzzer1.size = 100;
    fuzzer1.magic = RT_DEV_BINARY_MAGIC_PLAIN;
    fuzzer1.version = 0;
    fuzzer1.funcMode = 0;
    fuzzer1.device = 0;
    fuzzer1.blockDim = 1;
    fuzzer1.argsSize = 4;
    fuzzer1.l2ctrl.preloadSrc = 0;
    fuzzer1.l2ctrl.preloadSize = 0;
    fuzzer1.l2ctrl.preloadOffset = 0;
    fuzzer1.l2ctrl.size = 0;

    seed_gen(&fuzzer1, "seed_rt_kernel_001");
    return 0;
}
#else

extern "C" int LLVMFuzzerTestOneInput(uint8_t *Data, size_t Size) {
    return rt_kernel_fuzzer(Data, Size);
}

extern "C" int LLVMFuzzerInitialize(int *argc, char ***argv) {
    return 0;
}

#endif
