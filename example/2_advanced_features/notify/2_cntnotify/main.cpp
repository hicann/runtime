/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <iostream>
#include "utils.h"
#include "acl/acl.h"
#include <unistd.h>

using namespace std;

// 模拟一个耗时操作
void SimulateWork(aclrtStream stream, int milliseconds)
{
    // 使用aclrtSynchronizeStream模拟耗时操作
    // 实际应用中，这里可以是真正的计算任务
    usleep(milliseconds * 1000);
    INFO_LOG("Work completed after %d milliseconds", milliseconds);
}

int main()
{
    // 初始化
    int32_t deviceId = 0;
    aclrtStream streamA = nullptr;
    aclrtStream streamB = nullptr;
    aclrtContext context;
    aclrtCntNotify cntNotify = nullptr;
    uint32_t notifyId = 0;
    
    // 初始化AscendCL
    CHECK_ERROR(aclInit(nullptr));
    // 申请设备
    CHECK_ERROR(aclrtSetDevice(deviceId));
    CHECK_ERROR(aclrtCreateContext(&context, deviceId));
    // 创建两个Stream
    CHECK_ERROR(aclrtCreateStream(&streamA));
    CHECK_ERROR(aclrtCreateStream(&streamB));
    
    INFO_LOG("Begin CntNotify sample between StreamA and StreamB");
    
    // 1. 创建CntNotify
    CHECK_ERROR(aclrtCntNotifyCreate(&cntNotify, 0));
    INFO_LOG("Create CntNotify successfully");
    
    // 2. 获取CntNotify ID
    CHECK_ERROR(aclrtCntNotifyGetId(cntNotify, &notifyId));
    INFO_LOG("Get CntNotify ID: %u", notifyId);
    
    // 3. 在StreamA上执行一些工作
    INFO_LOG("StreamA: Start working...");
    SimulateWork(streamA, 500);
    
    // 4. 在StreamA上记录CntNotify
    aclrtCntNotifyRecordInfo recordInfo = {};
    recordInfo.mode = ACL_RT_CNT_NOTIFY_RECORD_SET_VALUE_MODE;
    recordInfo.value = 1;
    CHECK_ERROR(aclrtCntNotifyRecord(cntNotify, streamA, &recordInfo));
    INFO_LOG("StreamA: Record CntNotify successfully");
    
    // 5. 在StreamB上等待CntNotify完成
    INFO_LOG("StreamB: Waiting for CntNotify from StreamA...");
    aclrtCntNotifyWaitInfo waitInfo = {};
    waitInfo.mode = ACL_RT_CNT_NOTIFY_WAIT_EQUAL_MODE; // 等待计数值等于value
    waitInfo.value = 1; // 等待计数值等于1
    waitInfo.timeout = 2000; // 设置超时时间为2000ms
    waitInfo.isClear = 0; // 不自动清除计数值
    CHECK_ERROR(aclrtCntNotifyWaitWithTimeout(cntNotify, streamB, &waitInfo));
    INFO_LOG("StreamB: Wait CntNotify with timeout successfully");
    
    // 6. 在StreamB上执行后续工作
    INFO_LOG("StreamB: Start working after receiving CntNotify...");
    SimulateWork(streamB, 300);
    
    // 7. 复位CntNotify
    CHECK_ERROR(aclrtCntNotifyReset(cntNotify, streamA));
    INFO_LOG("Reset CntNotify successfully");
    
    // 同步所有Stream，确保所有操作完成
    CHECK_ERROR(aclrtSynchronizeStream(streamA));
    CHECK_ERROR(aclrtSynchronizeStream(streamB));
    
    // 8. 销毁CntNotify
    CHECK_ERROR(aclrtCntNotifyDestroy(cntNotify));
    INFO_LOG("Destroy CntNotify successfully");
    
    // 释放资源
    CHECK_ERROR(aclrtDestroyStreamForce(streamA));
    CHECK_ERROR(aclrtDestroyStreamForce(streamB));
    CHECK_ERROR(aclrtDestroyContext(context));
    CHECK_ERROR(aclrtResetDeviceForce(deviceId));
    aclFinalize();
    INFO_LOG("Resource cleanup completed.");
    return 0;
}