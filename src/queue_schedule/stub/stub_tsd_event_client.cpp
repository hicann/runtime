/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "tsd.h"
#include <iostream>

int32_t SendUpdateProfilingRspToTsd(const uint32_t deviceId, const uint32_t waitType,
                                    const uint32_t hostPid, const uint32_t vfId)
{
    return 0;
}

int32_t CreateOrFindCustPid(const uint32_t deviceId, const uint32_t loadLibNum,
    const char * const loadLibName[], const uint32_t hostPid, const uint32_t vfId, const char *groupNameList,
    const uint32_t groupNameNum, int32_t *custProcPid, bool *firstStart)
{
    return 0;
}

int32_t SetSubProcScheduleMode(const uint32_t deviceId, const uint32_t waitType,
                               const uint32_t hostPid, const uint32_t vfId,
                               const struct SubProcScheduleModeInfo *scheInfo)
{
    (void)deviceId;
    (void)waitType;
    (void)hostPid;
    (void)vfId;
    (void)scheInfo;
    return 0;
}

extern "C" {

// 修正函数签名，与头文件一致
int32_t RegEventMsgCallBackFunc(const struct SubProcEventCallBackInfo *regInfo) {
    (void)regInfo;
    std::cout << "STUB: RegEventMsgCallBackFunc called" << std::endl;
    return 0;  // 返回 int32_t
}

void UnRegEventMsgCallBackFunc(const uint32_t eventType) {
    (void)eventType;
    std::cout << "STUB: UnRegEventMsgCallBackFunc called" << std::endl;
}

int32_t TsdReportStartOrStopErrCode(const uint32_t deviceId, const TsdWaitType waitType,
                                   const uint32_t hostPid, const uint32_t vfId, 
                                   const char* msg, uint32_t msgLen) {
    (void)deviceId; (void)waitType; (void)hostPid; (void)vfId; (void)msg; (void)msgLen;
    std::cout << "STUB: TsdReportStartOrStopErrCode called" << std::endl;
    return 0;  // 返回 int32_t
}

int32_t TsdWaitForShutdown(const uint32_t deviceId, const TsdWaitType waitType,
                          const uint32_t hostPid, const uint32_t vfId) {
    (void)deviceId; (void)waitType; (void)hostPid; (void)vfId;
    std::cout << "STUB: TsdWaitForShutdown called" << std::endl;
    return 0;  // 返回 int32_t
}

int32_t TsdDestroy(const uint32_t deviceId, const TsdWaitType waitType,
                  const uint32_t hostPid, const uint32_t vfId) {
    (void)deviceId; (void)waitType; (void)hostPid; (void)vfId;
    std::cout << "STUB: TsdDestroy called" << std::endl;
    return 0;  // 返回 int32_t
}

int32_t SubModuleProcessResponse(const uint32_t deviceId, const TsdWaitType waitType,
                                const uint32_t hostPid, const uint32_t vfId, 
                                uint32_t response) {
    (void)deviceId; (void)waitType; (void)hostPid; (void)vfId; (void)response;
    std::cout << "STUB: SubModuleProcessResponse called" << std::endl;
    return 0;  // 返回 int32_t
}

} // extern "C"