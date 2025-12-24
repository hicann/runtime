/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <iostream>
#include <vector>
#include <unistd.h>
#include <string>
#include "acl/acl.h"
#include "acl/acl_prof.h"

int main(int argc, char *argv[]) {
    // 初始化
    uint32_t deviceIdList[1] = {0};  // 根据实际环境的DeviceID配置
    aclrtStream stream = nullptr;
    // 申请运行时资源
    aclInit(nullptr);
    aclrtSetDevice(deviceIdList[0]);
    aclrtCreateStream(&stream);

    // profiling初始化
    // 设置数据落盘路径
    std::string aclProfPath = "./output";
    aclprofInit(aclProfPath.c_str(), aclProfPath.length());

    // 进行profiling配置
    // 创建配置结构体
    aclprofConfig *config = aclprofCreateConfig(deviceIdList, 1, ACL_AICORE_ARITHMETIC_UTILIZATION, 
        nullptr, ACL_PROF_ACL_API | ACL_PROF_TASK_TIME | ACL_PROF_AICORE_METRICS | ACL_PROF_AICPU | ACL_PROF_L2CACHE | ACL_PROF_HCCL_TRACE | ACL_PROF_MSPROFTX | ACL_PROF_RUNTIME_API);
    std::string memFreq = "15";
    aclError ret = aclprofSetConfig(ACL_PROF_SYS_HARDWARE_MEM_FREQ, memFreq.c_str(), memFreq.length());
    aclprofStart(config);

    // 模型加载，加载成功后，返回标识模型的modelId
    // 创建aclmdlDataset类型的数据，用于描述模型的输入数据input、输出数据output
    // 执行模型 ret = aclmdlExecute(modelId, input, output);
    // 处理模型推理结果
    // 释放描述模型输入/输出信息、内存等资源，卸载模型

    // 关闭profiling配置, 释放配置资源, 释放profiling组件资源
    aclprofStop(config);
    aclprofDestroyConfig(config);
    aclprofFinalize();

    // 释放运行时资源
    aclrtDestroyStream(stream);
    aclrtResetDeviceForce(deviceIdList[0]);
    aclFinalize();
    return 0;
}