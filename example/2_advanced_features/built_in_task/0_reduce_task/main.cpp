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
#include <acl/acl.h>
#include "utils.h"

int main()
{
    aclError ret;

    // 初始化 ACL
    CHECK_ERROR(aclInit(NULL));

    CHECK_ERROR(aclrtSetDevice(0));

    aclrtStream stream;
    CHECK_ERROR(aclrtCreateStream(&stream));

    // 准备 Host 数据
    const int count = 4;
    float hostInput[4] = {1.0, 2.0, 3.0, 4.0};
    float hostOutput[4] = {0, 0, 0, 0};

    size_t size = count * sizeof(float);

    // 申请 Device 内存
    void* devInput = NULL;
    void* devOutput = NULL;

    CHECK_ERROR(aclrtMalloc(&devInput, size, ACL_MEM_MALLOC_HUGE_FIRST));
    CHECK_ERROR(aclrtMalloc(&devOutput, size, ACL_MEM_MALLOC_HUGE_FIRST));

    // 拷贝数据到 Device
    CHECK_ERROR(aclrtMemcpy(devInput, size, hostInput, size, ACL_MEMCPY_HOST_TO_DEVICE));
    CHECK_ERROR(aclrtMemcpy(devOutput, size, hostInput, size, ACL_MEMCPY_HOST_TO_DEVICE));

    // 调用 aclrtReduceAsync
    ret = aclrtReduceAsync(
        devOutput, devInput, size,
        ACL_RT_MEMCPY_SDMA_AUTOMATIC_SUM, // 归约类型
        ACL_FLOAT,                        // 数据类型
        stream, NULL);
    CHECK_ERROR(ret);

    // 同步 stream
    CHECK_ERROR(aclrtSynchronizeStream(stream));

    // 拷回结果
    CHECK_ERROR(aclrtMemcpy(hostOutput, size, devOutput, size, ACL_MEMCPY_DEVICE_TO_HOST));

    for (int i = 0; i < count; i++) {
        printf("Reduce SUM result[%d] = %f\n", i, hostOutput[i]);
    }
    /* 预期如下结果
    Reduce SUM result[0] = 2.000000
    Reduce SUM result[1] = 4.000000
    Reduce SUM result[2] = 6.000000
    Reduce SUM result[3] = 8.000000
    */

    // 释放资源
    aclrtFree(devInput);
    aclrtFree(devOutput);
    aclrtDestroyStream(stream);
    aclrtResetDeviceForce(0);
    aclFinalize();
    printf("Sample Run Successfully.\n");
    return 0;
}
