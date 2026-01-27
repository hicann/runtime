/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef EVENT_PROCESS_KERNEL_STUB_H
#define EVENT_PROCESS_KERNEL_STUB_H

#include <list>
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "aicpusd_status.h"
#include "aicpusd_common.h"
#define private public
#include "aicpusd_model.h"
#include "aicpusd_resource_manager.h"
#undef private
#include <iostream>
namespace AicpuSchedule {
class EventProcessKernelTest : public testing::Test {
public:
    virtual void SetUp()
    {}

    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

int halGrpQueryWithTwoGroup(
    GroupQueryCmdType cmd, void *inBuff, unsigned int inLen, void *outBuff, unsigned int *outLen);
int halGrpQueryWithError(GroupQueryCmdType cmd, void *inBuff, unsigned int inLen, void *outBuff, unsigned int *outLen);

int32_t CreateOrFindCustPidStub(const uint32_t deviceId, const uint32_t loadLibNum, const char *const loadLibName[],
    const uint32_t hostPid, const uint32_t vfId, const char *groupNameList, const uint32_t groupNameNum,
    int32_t *custProcPid, bool *firstStart);
int32_t CreateOrFindCustPidStubExist(const uint32_t deviceId, const uint32_t loadLibNum,
    const char *const loadLibName[], const uint32_t hostPid, const uint32_t vfId, const char *groupNameList,
    const uint32_t groupNameNum, int32_t *custProcPid, bool *firstStart);
int32_t CreateOrFindCustPidFailedStub(const uint32_t deviceId, const uint32_t loadLibNum,
    const char *const loadLibName[], const uint32_t hostPid, const uint32_t vfId, const char *groupNameList,
    const uint32_t groupNameNum, int32_t *custProcPid, bool *firstStart);
int32_t CreateOrFindCustPidFailedStub2(const uint32_t deviceId, const uint32_t loadLibNum,
    const char *const loadLibName[], const uint32_t hostPid, const uint32_t vfId, const char *groupNameList,
    const uint32_t groupNameNum, int32_t *custProcPid, bool *firstStart);
}  // namespace AicpuSchedule

#endif  // EVENT_PROCESS_KERNEL_STUB_H