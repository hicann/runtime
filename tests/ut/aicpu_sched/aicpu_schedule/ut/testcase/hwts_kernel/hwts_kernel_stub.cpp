/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "hwts_kernel_stub.h"

namespace AicpuSchedule {

int halGrpQueryWithTwoGroup(
    GroupQueryCmdType cmd, void *inBuff, unsigned int inLen, void *outBuff, unsigned int *outLen)
{
    GroupQueryOutput *groupQueryOutput = reinterpret_cast<GroupQueryOutput *>(outBuff);
    groupQueryOutput->grpQueryGroupsOfProcInfo[0].groupName[0] = 'g';
    groupQueryOutput->grpQueryGroupsOfProcInfo[0].groupName[1] = '1';
    groupQueryOutput->grpQueryGroupsOfProcInfo[0].groupName[2] = '\0';
    groupQueryOutput->grpQueryGroupsOfProcInfo[0].attr.admin = 1;
    groupQueryOutput->grpQueryGroupsOfProcInfo[0].attr.read = 1;
    groupQueryOutput->grpQueryGroupsOfProcInfo[0].attr.write = 1;
    groupQueryOutput->grpQueryGroupsOfProcInfo[0].attr.alloc = 1;
    groupQueryOutput->grpQueryGroupsOfProcInfo[1].groupName[0] = 'g';
    groupQueryOutput->grpQueryGroupsOfProcInfo[1].groupName[1] = '2';
    groupQueryOutput->grpQueryGroupsOfProcInfo[1].groupName[2] = '\0';
    groupQueryOutput->grpQueryGroupsOfProcInfo[1].attr.admin = 0;
    groupQueryOutput->grpQueryGroupsOfProcInfo[1].attr.read = 1;
    groupQueryOutput->grpQueryGroupsOfProcInfo[1].attr.write = 1;
    groupQueryOutput->grpQueryGroupsOfProcInfo[1].attr.alloc = 1;
    *outLen = sizeof(groupQueryOutput->grpQueryGroupsOfProcInfo[0]) * 2;
    return 0;
}

int halGrpQueryWithError(GroupQueryCmdType cmd, void *inBuff, unsigned int inLen, void *outBuff, unsigned int *outLen)
{
    GroupQueryOutput *groupQueryOutput = reinterpret_cast<GroupQueryOutput *>(outBuff);
    groupQueryOutput->grpQueryGroupsOfProcInfo[0].groupName[0] = 'g';
    groupQueryOutput->grpQueryGroupsOfProcInfo[0].groupName[1] = '1';
    groupQueryOutput->grpQueryGroupsOfProcInfo[0].groupName[2] = '\0';
    groupQueryOutput->grpQueryGroupsOfProcInfo[0].attr.admin = 1;
    groupQueryOutput->grpQueryGroupsOfProcInfo[0].attr.read = 1;
    groupQueryOutput->grpQueryGroupsOfProcInfo[0].attr.write = 1;
    groupQueryOutput->grpQueryGroupsOfProcInfo[0].attr.alloc = 1;
    groupQueryOutput->grpQueryGroupsOfProcInfo[1].groupName[0] = 'g';
    groupQueryOutput->grpQueryGroupsOfProcInfo[1].groupName[1] = '2';
    groupQueryOutput->grpQueryGroupsOfProcInfo[1].groupName[2] = '\0';
    groupQueryOutput->grpQueryGroupsOfProcInfo[1].attr.admin = 0;
    groupQueryOutput->grpQueryGroupsOfProcInfo[1].attr.read = 1;
    groupQueryOutput->grpQueryGroupsOfProcInfo[1].attr.write = 1;
    groupQueryOutput->grpQueryGroupsOfProcInfo[1].attr.alloc = 1;
    *outLen = sizeof(groupQueryOutput->grpQueryGroupsOfProcInfo[0]);
    return 0;
}

int32_t CreateOrFindCustPidStub(const uint32_t deviceId, const uint32_t loadLibNum,
    const char * const loadLibName[], const uint32_t hostPid, const uint32_t vfId, const char *groupNameList,
    const uint32_t groupNameNum, int32_t *custProcPid, bool *firstStart)
{
    *custProcPid = 1234509;
    *firstStart = true;
    return 0;
}
int32_t CreateOrFindCustPidStubExist(const uint32_t deviceId, const uint32_t loadLibNum,
    const char * const loadLibName[], const uint32_t hostPid, const uint32_t vfId, const char *groupNameList,
    const uint32_t groupNameNum, int32_t *custProcPid, bool *firstStart)
{
    *custProcPid = 1234509;
    *firstStart = false;
    return 0;
}
int32_t CreateOrFindCustPidFailedStub(const uint32_t deviceId, const uint32_t loadLibNum,
    const char * const loadLibName[], const uint32_t hostPid, const uint32_t vfId, const char *groupNameList,
    const uint32_t groupNameNum, int32_t *custProcPid, bool *firstStart)
{
    *custProcPid = -1;
    *firstStart = false;
    return 1;
}
int32_t CreateOrFindCustPidFailedStub2(const uint32_t deviceId, const uint32_t loadLibNum,
    const char * const loadLibName[], const uint32_t hostPid, const uint32_t vfId, const char *groupNameList,
    const uint32_t groupNameNum, int32_t *custProcPid, bool *firstStart)
{
    *custProcPid = -100;
    *firstStart = false;
    return 1;
}
}  // namespace AicpuSchedule