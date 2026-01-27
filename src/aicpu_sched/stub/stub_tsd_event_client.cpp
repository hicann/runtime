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

int32_t ReportMsgToTsd(const uint32_t deviceId, const TsdWaitType waitType,
                       const uint32_t hostPid, const uint32_t vfId,
                       const char * const msgInfo)
{
    return 0;
}

int32_t RegEventMsgCallBackFunc(const struct SubProcEventCallBackInfo *regInfo)
{
    return 0;
}

void UnRegEventMsgCallBackFunc(const uint32_t eventType)
{
    return;
}

int32_t TsdReportStartOrStopErrCode(const uint32_t deviceId, const TsdWaitType waitType,
                                    const uint32_t hostPid, const uint32_t vfId,
                                    const char *errCode, const uint32_t errLen)
{
    return 0;
}

int32_t StartupResponse(const uint32_t deviceId, const TsdWaitType waitType,
                        const uint32_t hostPid, const uint32_t vfId)
{
    return 0;
}

int32_t WaitForShutDown(const uint32_t deviceId)
{
    return 0;
}

int32_t TsdDestroy(const uint32_t deviceId, const TsdWaitType waitType,
                   const uint32_t hostPid, const uint32_t vfId)
{
    return 0;
}

int32_t StopWaitForCustAicpu()
{
    return 0;
}

int32_t SubModuleProcessResponse(const uint32_t deviceId, const TsdWaitType waitType,
                                 const uint32_t hostPid, const uint32_t vfId,
                                 const uint32_t eventType)
{
    return 0;
}

int32_t StartUpRspAndWaitProcess(const uint32_t deviceId, const TsdWaitType waitType,
                                 const uint32_t hostPid, const uint32_t vfId)
{
    return 0;
}

int32_t SetDstTsdEventPid(const uint32_t dstPid)
{
    return 0;
}

int32_t TsdWaitForShutdown(const uint32_t deviceId, const TsdWaitType waitType,
                          const uint32_t hostPid, const uint32_t vfId) {
    (void)deviceId; (void)waitType; (void)hostPid; (void)vfId;
    return 0;  // 返回 int32_t
}