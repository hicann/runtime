/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <memory>
#include <acl/acl.h>
#include "utils.h"

typedef uint16_t Float16;
typedef uint16_t BF16;

aclError DropoutBitmask(
    float ration, uint64_t seed, uint64_t num, void* counterDevAddr, void* devOutput, aclrtStream stream);

aclError UniformBF16Async(
    BF16 min, BF16 max, uint64_t seed, uint64_t num, void* counterDevAddr, void* devOutput, aclrtStream stream);

aclError UniformFloat16Async(
    Float16 min, Float16 max, uint64_t seed, uint64_t num, void* counterDevAddr, void* devOutput, aclrtStream stream);

aclError UniformFloatAsync(
    float min, float max, uint64_t seed, uint64_t num, void* counterDevAddr, void* devOutput, aclrtStream stream);

aclError UniformInt32Async(
    int32_t min, int32_t max, uint64_t seed, uint64_t num, void* counterDevAddr, void* devOutput, aclrtStream stream);

aclError UniformInt64Async(
    int64_t min, int64_t max, uint64_t seed, uint64_t num, void* counterDevAddr, void* devOutput, aclrtStream stream);

aclError UniformUint32Async(
    uint32_t min, uint32_t max, uint64_t seed, uint64_t num, void* counterDevAddr, void* devOutput, aclrtStream stream);

aclError UniformUint64Async(
    uint64_t min, uint64_t max, uint64_t seed, uint64_t num, void* counterDevAddr, void* devOutput, aclrtStream stream);

aclError NormalFloatAsync(
    float mean, float stddev, bool isTruncated, uint64_t seed, uint64_t num, void* counterDevAddr, void* devOutput,
    aclrtStream stream);

aclError NormalFloat16Async(
    Float16 mean, Float16 stddev, bool isTruncated, uint64_t seed, uint64_t num, void* counterDevAddr, void* devOutput,
    aclrtStream stream);

aclError NormalBF16Async(
    BF16 mean, BF16 stddev, bool isTruncated, uint64_t seed, uint64_t num, void* counterDevAddr, void* devOutput,
    aclrtStream stream);

int main()
{
    // 初始化 ACL
    CHECK_ERROR(aclInit(NULL));

    CHECK_ERROR(aclrtSetDevice(0));

    aclrtStream stream;
    CHECK_ERROR(aclrtCreateStream(&stream));

    uint64_t seed = 0;
    uint64_t num = 128;
    size_t size = num * sizeof(uint64_t); // 申请足够大内存存放随机数结果
    // 申请 Device 内存
    void* devOutput = NULL;
    CHECK_ERROR(aclrtMalloc(&devOutput, size, ACL_MEM_MALLOC_HUGE_FIRST));
    // 准备 Host 数据
    auto hostOutput = std::unique_ptr<void, decltype(&free)>(malloc(size), free);

    // 申请存放随机数状态 counter 的device内存 （要求 16Byte)
    void* counterAddr = NULL;
    CHECK_ERROR(aclrtMalloc((void**)&counterAddr, 16, ACL_MEM_MALLOC_HUGE_FIRST));    

    printf("Gen normal distribution random num, data type: float \n");
    float mean = 3.0;
    float stddev = 2.0;
    CHECK_ERROR(NormalFloatAsync(mean, stddev, false, seed, num, counterAddr, devOutput, stream));
    // 同步 stream
    CHECK_ERROR(aclrtSynchronizeStream(stream));
    // 拷回结果
    CHECK_ERROR(aclrtMemcpy(hostOutput.get(), size, devOutput, size, ACL_MEMCPY_DEVICE_TO_HOST));
    // 打印前5结果
    float* floatData = (float*)hostOutput.get();
    for (int i = 0; i < 5; i++) {
        printf("Random result[%d] = %f\n", i, floatData[i]);
    }

    printf("\nGen truncated normal distribution random num, data type: BF16 \n");
    BF16 meanBF16 = 0x3F80;   // bf16(1.0)
    BF16 stddevBF16 = 0x4000; // bf16(2.0)
    CHECK_ERROR(NormalBF16Async(meanBF16, stddevBF16, true, seed, num, counterAddr, devOutput, stream));
    // 同步 stream
    CHECK_ERROR(aclrtSynchronizeStream(stream));
    // 拷回结果
    CHECK_ERROR(aclrtMemcpy(hostOutput.get(), size, devOutput, size, ACL_MEMCPY_DEVICE_TO_HOST));
    // 打印前5结果
    BF16* bf16Data = (BF16*)hostOutput.get();
    for (int i = 0; i < 5; i++) {
        printf("Random result[%d] = %#x\n", i, bf16Data[i]);
    }

    printf("\nGen uniform distribution random num, data type: FP16 \n");
    Float16 minFP16 = 0x3C00; // fp16(1.0)
    Float16 maxFP16 = 0x4000; // fp16(2.0)
    CHECK_ERROR(UniformFloat16Async(minFP16, maxFP16, seed, num, counterAddr, devOutput, stream));
    // 同步 stream
    CHECK_ERROR(aclrtSynchronizeStream(stream));
    // 拷回结果
    CHECK_ERROR(aclrtMemcpy(hostOutput.get(), size, devOutput, size, ACL_MEMCPY_DEVICE_TO_HOST));
    // 打印前5结果
    Float16* fp16Data = (Float16*)hostOutput.get();
    for (int i = 0; i < 5; i++) {
        printf("Random result[%d] = %#x\n", i, fp16Data[i]);
    }

    printf("\nGen uniform distribution random num, data type: INT32 \n");
    int32_t min = 1;
    int32_t max = 100;
    CHECK_ERROR(UniformInt32Async(min, max, seed, num, counterAddr, devOutput, stream));
    // 同步 stream
    CHECK_ERROR(aclrtSynchronizeStream(stream));
    // 拷回结果
    CHECK_ERROR(aclrtMemcpy(hostOutput.get(), size, devOutput, size, ACL_MEMCPY_DEVICE_TO_HOST));
    // 打印前5结果
    int32_t* int32Data = (int32_t*)hostOutput.get();
    for (int i = 0; i < 5; i++) {
        printf("Random result[%d] = %d\n", i, int32Data[i]);
    }

    printf("\nGen dropout bitmask, output data type: UINT8 \n");
    float ration = 0.4;
    CHECK_ERROR(DropoutBitmask(ration, seed, num, counterAddr, devOutput, stream));
    // 同步 stream
    CHECK_ERROR(aclrtSynchronizeStream(stream));
    // 拷回结果
    CHECK_ERROR(aclrtMemcpy(hostOutput.get(), size, devOutput, size, ACL_MEMCPY_DEVICE_TO_HOST));
    // 打印前5结果
    uint8_t* uint8Data = (uint8_t*)hostOutput.get();
    for (int i = 0; i < 5; i++) {
        printf("Random result[%d] = %u\n", i, uint8Data[i]);
    }

    // 释放资源
    aclrtFree(devOutput);
    aclrtFree(counterAddr);
    aclrtDestroyStream(stream);
    aclrtResetDeviceForce(0);
    aclFinalize();
    printf("Sample Run Successfully.\n");
    return 0;
}

aclError UniformBF16Async(
    BF16 min, BF16 max, uint64_t seed, uint64_t num, void* counterDevAddr, void* devOutput, aclrtStream stream)
{
    aclrtRandomNumTaskInfo taskInfo;
    taskInfo.dataType = ACL_BF16;
    taskInfo.randomNumFuncParaInfo.funcType = ACL_RT_RANDOM_NUM_FUNC_TYPE_UNIFORM_DIS;
    taskInfo.randomParaAddr = NULL;
    taskInfo.randomCounterAddr = counterDevAddr;
    taskInfo.randomResultAddr = devOutput;
    *((BF16*)taskInfo.randomNumFuncParaInfo.paramInfo.uniformDisInfo.min.valueOrAddr) = min;
    taskInfo.randomNumFuncParaInfo.paramInfo.uniformDisInfo.min.size = sizeof(BF16);
    taskInfo.randomNumFuncParaInfo.paramInfo.uniformDisInfo.min.isAddr = 0;
    *((BF16*)taskInfo.randomNumFuncParaInfo.paramInfo.uniformDisInfo.max.valueOrAddr) = max;
    taskInfo.randomNumFuncParaInfo.paramInfo.uniformDisInfo.max.size = sizeof(BF16);
    taskInfo.randomNumFuncParaInfo.paramInfo.uniformDisInfo.max.isAddr = 0;
    *((uint64_t*)taskInfo.randomSeed.valueOrAddr) = seed;
    taskInfo.randomSeed.size = sizeof(uint64_t);
    taskInfo.randomSeed.isAddr = 0;
    *((uint64_t*)taskInfo.randomNum.valueOrAddr) = num;
    taskInfo.randomNum.size = sizeof(uint64_t);
    taskInfo.randomNum.isAddr = 0;
    return aclrtRandomNumAsync(&taskInfo, stream, NULL);
}

aclError UniformFloat16Async(
    Float16 min, Float16 max, uint64_t seed, uint64_t num, void* counterDevAddr, void* devOutput, aclrtStream stream)
{
    aclrtRandomNumTaskInfo taskInfo;
    taskInfo.dataType = ACL_FLOAT16;
    taskInfo.randomNumFuncParaInfo.funcType = ACL_RT_RANDOM_NUM_FUNC_TYPE_UNIFORM_DIS;
    taskInfo.randomParaAddr = NULL;
    taskInfo.randomCounterAddr = counterDevAddr;
    taskInfo.randomResultAddr = devOutput;
    *((Float16*)taskInfo.randomNumFuncParaInfo.paramInfo.uniformDisInfo.min.valueOrAddr) = min;
    taskInfo.randomNumFuncParaInfo.paramInfo.uniformDisInfo.min.size = sizeof(Float16);
    taskInfo.randomNumFuncParaInfo.paramInfo.uniformDisInfo.min.isAddr = 0;
    *((Float16*)taskInfo.randomNumFuncParaInfo.paramInfo.uniformDisInfo.max.valueOrAddr) = max;
    taskInfo.randomNumFuncParaInfo.paramInfo.uniformDisInfo.max.size = sizeof(Float16);
    taskInfo.randomNumFuncParaInfo.paramInfo.uniformDisInfo.max.isAddr = 0;
    *((uint64_t*)taskInfo.randomSeed.valueOrAddr) = seed;
    taskInfo.randomSeed.size = sizeof(uint64_t);
    taskInfo.randomSeed.isAddr = 0;
    *((uint64_t*)taskInfo.randomNum.valueOrAddr) = num;
    taskInfo.randomNum.size = sizeof(uint64_t);
    taskInfo.randomNum.isAddr = 0;
    return aclrtRandomNumAsync(&taskInfo, stream, NULL);
}

aclError UniformFloatAsync(
    float min, float max, uint64_t seed, uint64_t num, void* counterDevAddr, void* devOutput, aclrtStream stream)
{
    aclrtRandomNumTaskInfo taskInfo;
    taskInfo.dataType = ACL_FLOAT;
    taskInfo.randomNumFuncParaInfo.funcType = ACL_RT_RANDOM_NUM_FUNC_TYPE_UNIFORM_DIS;
    taskInfo.randomParaAddr = NULL;
    taskInfo.randomCounterAddr = counterDevAddr;
    taskInfo.randomResultAddr = devOutput;
    *((float*)taskInfo.randomNumFuncParaInfo.paramInfo.uniformDisInfo.min.valueOrAddr) = min;
    taskInfo.randomNumFuncParaInfo.paramInfo.uniformDisInfo.min.size = sizeof(float);
    taskInfo.randomNumFuncParaInfo.paramInfo.uniformDisInfo.min.isAddr = 0;
    *((float*)taskInfo.randomNumFuncParaInfo.paramInfo.uniformDisInfo.max.valueOrAddr) = max;
    taskInfo.randomNumFuncParaInfo.paramInfo.uniformDisInfo.max.size = sizeof(float);
    taskInfo.randomNumFuncParaInfo.paramInfo.uniformDisInfo.max.isAddr = 0;
    *((uint64_t*)taskInfo.randomSeed.valueOrAddr) = seed;
    taskInfo.randomSeed.size = sizeof(uint64_t);
    taskInfo.randomSeed.isAddr = 0;
    *((uint64_t*)taskInfo.randomNum.valueOrAddr) = num;
    taskInfo.randomNum.size = sizeof(uint64_t);
    taskInfo.randomNum.isAddr = 0;
    return aclrtRandomNumAsync(&taskInfo, stream, NULL);
}

aclError UniformInt32Async(
    int32_t min, int32_t max, uint64_t seed, uint64_t num, void* counterDevAddr, void* devOutput, aclrtStream stream)
{
    aclrtRandomNumTaskInfo taskInfo;
    taskInfo.dataType = ACL_INT32;
    taskInfo.randomNumFuncParaInfo.funcType = ACL_RT_RANDOM_NUM_FUNC_TYPE_UNIFORM_DIS;
    taskInfo.randomParaAddr = NULL;
    taskInfo.randomCounterAddr = counterDevAddr;
    taskInfo.randomResultAddr = devOutput;
    *((int32_t*)taskInfo.randomNumFuncParaInfo.paramInfo.uniformDisInfo.min.valueOrAddr) = min;
    taskInfo.randomNumFuncParaInfo.paramInfo.uniformDisInfo.min.size = sizeof(int32_t);
    taskInfo.randomNumFuncParaInfo.paramInfo.uniformDisInfo.min.isAddr = 0;
    *((int32_t*)taskInfo.randomNumFuncParaInfo.paramInfo.uniformDisInfo.max.valueOrAddr) = max;
    taskInfo.randomNumFuncParaInfo.paramInfo.uniformDisInfo.max.size = sizeof(int32_t);
    taskInfo.randomNumFuncParaInfo.paramInfo.uniformDisInfo.max.isAddr = 0;
    *((uint64_t*)taskInfo.randomSeed.valueOrAddr) = seed;
    taskInfo.randomSeed.size = sizeof(uint64_t);
    taskInfo.randomSeed.isAddr = 0;
    *((uint64_t*)taskInfo.randomNum.valueOrAddr) = num;
    taskInfo.randomNum.size = sizeof(uint64_t);
    taskInfo.randomNum.isAddr = 0;
    return aclrtRandomNumAsync(&taskInfo, stream, NULL);
}

aclError UniformInt64Async(
    int64_t min, int64_t max, uint64_t seed, uint64_t num, void* counterDevAddr, void* devOutput, aclrtStream stream)
{
    aclrtRandomNumTaskInfo taskInfo;
    taskInfo.dataType = ACL_INT64;
    taskInfo.randomNumFuncParaInfo.funcType = ACL_RT_RANDOM_NUM_FUNC_TYPE_UNIFORM_DIS;
    taskInfo.randomParaAddr = NULL;
    taskInfo.randomCounterAddr = counterDevAddr;
    taskInfo.randomResultAddr = devOutput;
    *((int64_t*)taskInfo.randomNumFuncParaInfo.paramInfo.uniformDisInfo.min.valueOrAddr) = min;
    taskInfo.randomNumFuncParaInfo.paramInfo.uniformDisInfo.min.size = sizeof(int64_t);
    taskInfo.randomNumFuncParaInfo.paramInfo.uniformDisInfo.min.isAddr = 0;
    *((int64_t*)taskInfo.randomNumFuncParaInfo.paramInfo.uniformDisInfo.max.valueOrAddr) = max;
    taskInfo.randomNumFuncParaInfo.paramInfo.uniformDisInfo.max.size = sizeof(int64_t);
    taskInfo.randomNumFuncParaInfo.paramInfo.uniformDisInfo.max.isAddr = 0;
    *((uint64_t*)taskInfo.randomSeed.valueOrAddr) = seed;
    taskInfo.randomSeed.size = sizeof(uint64_t);
    taskInfo.randomSeed.isAddr = 0;
    *((uint64_t*)taskInfo.randomNum.valueOrAddr) = num;
    taskInfo.randomNum.size = sizeof(uint64_t);
    taskInfo.randomNum.isAddr = 0;
    return aclrtRandomNumAsync(&taskInfo, stream, NULL);
}

aclError UniformUint32Async(
    uint32_t min, uint32_t max, uint64_t seed, uint64_t num, void* counterDevAddr, void* devOutput, aclrtStream stream)
{
    aclrtRandomNumTaskInfo taskInfo;
    taskInfo.dataType = ACL_UINT32;
    taskInfo.randomNumFuncParaInfo.funcType = ACL_RT_RANDOM_NUM_FUNC_TYPE_UNIFORM_DIS;
    taskInfo.randomParaAddr = NULL;
    taskInfo.randomCounterAddr = counterDevAddr;
    taskInfo.randomResultAddr = devOutput;
    *((uint32_t*)taskInfo.randomNumFuncParaInfo.paramInfo.uniformDisInfo.min.valueOrAddr) = min;
    taskInfo.randomNumFuncParaInfo.paramInfo.uniformDisInfo.min.size = sizeof(uint32_t);
    taskInfo.randomNumFuncParaInfo.paramInfo.uniformDisInfo.min.isAddr = 0;
    *((uint32_t*)taskInfo.randomNumFuncParaInfo.paramInfo.uniformDisInfo.max.valueOrAddr) = max;
    taskInfo.randomNumFuncParaInfo.paramInfo.uniformDisInfo.max.size = sizeof(uint32_t);
    taskInfo.randomNumFuncParaInfo.paramInfo.uniformDisInfo.max.isAddr = 0;
    *((uint64_t*)taskInfo.randomSeed.valueOrAddr) = seed;
    taskInfo.randomSeed.size = sizeof(uint64_t);
    taskInfo.randomSeed.isAddr = 0;
    *((uint64_t*)taskInfo.randomNum.valueOrAddr) = num;
    taskInfo.randomNum.size = sizeof(uint64_t);
    taskInfo.randomNum.isAddr = 0;
    return aclrtRandomNumAsync(&taskInfo, stream, NULL);
}

aclError UniformUint64Async(
    uint64_t min, uint64_t max, uint64_t seed, uint64_t num, void* counterDevAddr, void* devOutput, aclrtStream stream)
{
    aclrtRandomNumTaskInfo taskInfo;
    taskInfo.dataType = ACL_UINT64;
    taskInfo.randomNumFuncParaInfo.funcType = ACL_RT_RANDOM_NUM_FUNC_TYPE_UNIFORM_DIS;
    taskInfo.randomParaAddr = NULL;
    taskInfo.randomCounterAddr = counterDevAddr;
    taskInfo.randomResultAddr = devOutput;
    *((uint64_t*)taskInfo.randomNumFuncParaInfo.paramInfo.uniformDisInfo.min.valueOrAddr) = min;
    taskInfo.randomNumFuncParaInfo.paramInfo.uniformDisInfo.min.size = sizeof(uint64_t);
    taskInfo.randomNumFuncParaInfo.paramInfo.uniformDisInfo.min.isAddr = 0;
    *((uint64_t*)taskInfo.randomNumFuncParaInfo.paramInfo.uniformDisInfo.max.valueOrAddr) = max;
    taskInfo.randomNumFuncParaInfo.paramInfo.uniformDisInfo.max.size = sizeof(uint64_t);
    taskInfo.randomNumFuncParaInfo.paramInfo.uniformDisInfo.max.isAddr = 0;
    *((uint64_t*)taskInfo.randomSeed.valueOrAddr) = seed;
    taskInfo.randomSeed.size = sizeof(uint64_t);
    taskInfo.randomSeed.isAddr = 0;
    *((uint64_t*)taskInfo.randomNum.valueOrAddr) = num;
    taskInfo.randomNum.size = sizeof(uint64_t);
    taskInfo.randomNum.isAddr = 0;
    return aclrtRandomNumAsync(&taskInfo, stream, NULL);
}

aclError NormalFloatAsync(
    float mean, float stddev, bool isTruncated, uint64_t seed, uint64_t num, void* counterDevAddr, void* devOutput,
    aclrtStream stream)
{
    aclrtRandomNumTaskInfo taskInfo = {};
    taskInfo.dataType = ACL_FLOAT;
    taskInfo.randomNumFuncParaInfo.funcType =
        isTruncated ? ACL_RT_RANDOM_NUM_FUNC_TYPE_TRUNCATED_NORMAL_DIS : ACL_RT_RANDOM_NUM_FUNC_TYPE_NORMAL_DIS;
    taskInfo.randomParaAddr = NULL;
    taskInfo.randomCounterAddr = counterDevAddr;
    taskInfo.randomResultAddr = devOutput;
    *((float*)taskInfo.randomNumFuncParaInfo.paramInfo.normalDisInfo.mean.valueOrAddr) = mean;
    taskInfo.randomNumFuncParaInfo.paramInfo.normalDisInfo.mean.size = sizeof(float);
    taskInfo.randomNumFuncParaInfo.paramInfo.normalDisInfo.mean.isAddr = 0;
    *((float*)taskInfo.randomNumFuncParaInfo.paramInfo.normalDisInfo.stddev.valueOrAddr) = stddev;
    taskInfo.randomNumFuncParaInfo.paramInfo.normalDisInfo.stddev.size = sizeof(float);
    taskInfo.randomNumFuncParaInfo.paramInfo.normalDisInfo.stddev.isAddr = 0;
    *((uint64_t*)taskInfo.randomSeed.valueOrAddr) = seed;
    taskInfo.randomSeed.size = sizeof(uint64_t);
    taskInfo.randomSeed.isAddr = 0;
    *((uint64_t*)taskInfo.randomNum.valueOrAddr) = num;
    taskInfo.randomNum.size = sizeof(uint64_t);
    taskInfo.randomNum.isAddr = 0;
    return aclrtRandomNumAsync(&taskInfo, stream, NULL);
}

aclError NormalFloat16Async(
    Float16 mean, Float16 stddev, bool isTruncated, uint64_t seed, uint64_t num, void* counterDevAddr, void* devOutput,
    aclrtStream stream)
{
    aclrtRandomNumTaskInfo taskInfo = {};
    taskInfo.dataType = ACL_FLOAT16;
    taskInfo.randomNumFuncParaInfo.funcType =
        isTruncated ? ACL_RT_RANDOM_NUM_FUNC_TYPE_TRUNCATED_NORMAL_DIS : ACL_RT_RANDOM_NUM_FUNC_TYPE_NORMAL_DIS;
    taskInfo.randomParaAddr = NULL;
    taskInfo.randomCounterAddr = counterDevAddr;
    taskInfo.randomResultAddr = devOutput;
    *((Float16*)taskInfo.randomNumFuncParaInfo.paramInfo.normalDisInfo.mean.valueOrAddr) = mean;
    taskInfo.randomNumFuncParaInfo.paramInfo.normalDisInfo.mean.size = sizeof(Float16);
    taskInfo.randomNumFuncParaInfo.paramInfo.normalDisInfo.mean.isAddr = 0;
    *((Float16*)taskInfo.randomNumFuncParaInfo.paramInfo.normalDisInfo.stddev.valueOrAddr) = stddev;
    taskInfo.randomNumFuncParaInfo.paramInfo.normalDisInfo.stddev.size = sizeof(Float16);
    taskInfo.randomNumFuncParaInfo.paramInfo.normalDisInfo.stddev.isAddr = 0;
    *((uint64_t*)taskInfo.randomSeed.valueOrAddr) = seed;
    taskInfo.randomSeed.size = sizeof(uint64_t);
    taskInfo.randomSeed.isAddr = 0;
    *((uint64_t*)taskInfo.randomNum.valueOrAddr) = num;
    taskInfo.randomNum.size = sizeof(uint64_t);
    taskInfo.randomNum.isAddr = 0;
    return aclrtRandomNumAsync(&taskInfo, stream, NULL);
}

aclError NormalBF16Async(
    BF16 mean, BF16 stddev, bool isTruncated, uint64_t seed, uint64_t num, void* counterDevAddr, void* devOutput,
    aclrtStream stream)
{
    aclrtRandomNumTaskInfo taskInfo = {};
    taskInfo.dataType = ACL_BF16;
    taskInfo.randomNumFuncParaInfo.funcType =
        isTruncated ? ACL_RT_RANDOM_NUM_FUNC_TYPE_TRUNCATED_NORMAL_DIS : ACL_RT_RANDOM_NUM_FUNC_TYPE_NORMAL_DIS;
    taskInfo.randomParaAddr = NULL;
    taskInfo.randomCounterAddr = counterDevAddr;
    taskInfo.randomResultAddr = devOutput;
    *((BF16*)taskInfo.randomNumFuncParaInfo.paramInfo.normalDisInfo.mean.valueOrAddr) = mean;
    taskInfo.randomNumFuncParaInfo.paramInfo.normalDisInfo.mean.size = sizeof(BF16);
    taskInfo.randomNumFuncParaInfo.paramInfo.normalDisInfo.mean.isAddr = 0;
    *((BF16*)taskInfo.randomNumFuncParaInfo.paramInfo.normalDisInfo.stddev.valueOrAddr) = stddev;
    taskInfo.randomNumFuncParaInfo.paramInfo.normalDisInfo.stddev.size = sizeof(BF16);
    taskInfo.randomNumFuncParaInfo.paramInfo.normalDisInfo.stddev.isAddr = 0;
    *((uint64_t*)taskInfo.randomSeed.valueOrAddr) = seed;
    taskInfo.randomSeed.size = sizeof(uint64_t);
    taskInfo.randomSeed.isAddr = 0;
    *((uint64_t*)taskInfo.randomNum.valueOrAddr) = num;
    taskInfo.randomNum.size = sizeof(uint64_t);
    taskInfo.randomNum.isAddr = 0;
    return aclrtRandomNumAsync(&taskInfo, stream, NULL);
}

aclError DropoutBitmask(
    float ration, uint64_t seed, uint64_t num, void* counterDevAddr, void* devOutput, aclrtStream stream)
{
    aclrtRandomNumTaskInfo taskInfo = {};
    taskInfo.dataType = ACL_FLOAT;
    taskInfo.randomNumFuncParaInfo.funcType = ACL_RT_RANDOM_NUM_FUNC_TYPE_DROPOUT_BITMASK;
    taskInfo.randomParaAddr = NULL;
    taskInfo.randomCounterAddr = counterDevAddr;
    taskInfo.randomResultAddr = devOutput;
    *((float*)taskInfo.randomNumFuncParaInfo.paramInfo.dropoutBitmaskInfo.dropoutRation.valueOrAddr) = ration;
    taskInfo.randomNumFuncParaInfo.paramInfo.normalDisInfo.mean.size = sizeof(float);
    taskInfo.randomNumFuncParaInfo.paramInfo.normalDisInfo.mean.isAddr = 0;
    *((uint64_t*)taskInfo.randomSeed.valueOrAddr) = seed;
    taskInfo.randomSeed.size = sizeof(uint64_t);
    taskInfo.randomSeed.isAddr = 0;
    *((uint64_t*)taskInfo.randomNum.valueOrAddr) = num;
    taskInfo.randomNum.size = sizeof(uint64_t);
    taskInfo.randomNum.isAddr = 0;
    return aclrtRandomNumAsync(&taskInfo, stream, NULL);
}