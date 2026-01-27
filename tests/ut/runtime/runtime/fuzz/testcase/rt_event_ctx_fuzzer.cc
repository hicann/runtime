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

typedef struct tagRtEventFuzzer
{
    int32_t     priority;
    uint32_t    sleepTime;
    uint32_t    count;
    int32_t     listener;
    int32_t     device;
    uint32_t    flags;
} rtEventFuzzer;

int rt_event_fuzzer(const uint8_t *Data, size_t DataSize)
{
    rtEventFuzzer *fuzzer = (rtEventFuzzer *)Data;
    if (DataSize <= sizeof(rtEventFuzzer))
        return 0;

    int32_t priority = fuzzer->priority;
    uint32_t sleepTime = fuzzer->sleepTime;
    uint32_t count = fuzzer->count;
    uint8_t listener = fuzzer->listener;
    int32_t device = fuzzer->device;
    uint32_t flags = fuzzer->flags;
    rt_event_ctx_test(device, flags, priority, sleepTime, count, listener);
    return 0;
}

#if 0
int seed_gen(rtEventFuzzer *fuzzer, const char *seed_file)
{
    size_t size = sizeof(rtEventFuzzer);
    rt_event_fuzzer((uint8_t *)fuzzer, size);
    FILE *fp = fopen(seed_file, "wb");
    fwrite(&fuzzer, size, 1, fp);
    fclose(fp);
    return 0;
}

//using for seed generate
int main() {
    rtEventFuzzer fuzzer1;
    fuzzer1.priority = 0;
    fuzzer1.sleepTime = 100;
    fuzzer1.count = 1;
    fuzzer1.listener = 1;
    fuzzer1.device = 0;
    fuzzer1.flags = 0;
    seed_gen(&fuzzer1, "seed_rt_event_ctx_001");
    return 0;
}
#else

extern "C" int LLVMFuzzerTestOneInput(uint8_t *Data, size_t Size) {
    return rt_event_fuzzer(Data, Size);
}

extern "C" int LLVMFuzzerInitialize(int *argc, char ***argv) {
    rtDevBinary_t binary;
    uint32_t stubFunc;
    uint32_t devFunc;
    void *binHandle = NULL;
    unsigned char binArray[2] = { 0xff, 0xff };

    binary.magic = RT_DEV_BINARY_MAGIC_PLAIN;
    binary.version = 0;
    binary.data = binArray;
    binary.length = 2;
    rtDevBinaryRegister(&binary, &binHandle);

    uint32_t funcMode = 0;
    rtFunctionRegister(binHandle, &stubFunc, "fuzz", &devFunc, funcMode);
    return 0;
}

#endif
