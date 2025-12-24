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
#include "utils.h"
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
        nullptr, ACL_PROF_ACL_API | ACL_PROF_TASK_TIME | ACL_PROF_MSPROFTX);
    std::string memFreq = "15";
    aclError ret = aclprofSetConfig(ACL_PROF_SYS_HARDWARE_MEM_FREQ, memFreq.c_str(), memFreq.length());
    aclprofStart(config);

    aclprofStepInfo *stepInfo = aclprofCreateStepInfo();
    ret = aclprofGetStepTimestamp(stepInfo, ACL_STEP_START, stream);

    // 模型加载，加载成功后，返回标识模型的modelId
    // 标记模型加载事件
    std::string load_mark = "model_load_mark";
    void *stamp = aclprofCreateStamp();
    aclprofSetStampTraceMessage(stamp, load_mark.c_str(), load_mark.length());
    aclprofMark(stamp);      
    aclprofDestroyStamp(stamp);

    // 创建aclmdlDataset类型的数据，用于描述模型的输入数据input、输出数据output
    // 执行模型 ret = aclmdlExecute(modelId, input, output);
    INFO_LOG("Model execute start");
    (void)sleep(static_cast<uint8_t>(5)); // 模拟模型执行，5秒
    INFO_LOG("Model execute end");
    // 标记模型执行事件
    std::string exec_mark = "model_exec_mark";
    stamp = aclprofCreateStamp();
    aclprofSetStampTraceMessage(stamp, exec_mark.c_str(), exec_mark.length());
    aclprofMark(stamp);
    aclprofDestroyStamp(stamp);

    // 处理模型推理结果
    // 释放描述模型输入/输出信息、内存等资源，卸载模型

    // 关闭profiling配置, 释放配置资源, 释放profiling组件资源
    ret = aclprofGetStepTimestamp(stepInfo, ACL_STEP_END, stream);
    aclprofDestroyStepInfo(stepInfo);
    
    aclprofStop(config);
    aclprofDestroyConfig(config);
    aclprofFinalize();

    // 释放运行时资源
    aclrtDestroyStream(stream);
    aclrtResetDeviceForce(deviceIdList[0]);
    aclFinalize();
    return 0;
}