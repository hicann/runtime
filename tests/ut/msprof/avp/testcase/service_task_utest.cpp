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
#include <fstream>
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "mmpa_api.h"
#include "data_manager.h"
#include "toolchain/prof_api.h"
#include "errno/error_code.h"
#include "task/task_slot.h"
#include "osal/osal.h"

extern "C" {
    #define MAX_REPORT_MODULE     20U // 支持总共20个组件的数据上报
    typedef struct {
        uint32_t regModuleCount;
        enum MsprofCommandHandleType handleType;
        uint32_t moduleId[MAX_REPORT_MODULE];
        ProfCommandHandle handle[MAX_REPORT_MODULE];
    } ReportAttribute;
    typedef enum {
        FILE_TRANSPORT,
        FLSH_TRANSPORT
    } TransportType;
    int32_t TaskPoolInitialize();
    int32_t TaskPoolFinalize();
    int32_t UploaderInitialize(uint32_t deviceId, TransportType type);
    int32_t UploaderFinalize();
    int32_t ReportManagerInitialize();
    int32_t ReportManagerCollectStart(const uint32_t deviceId, ReportAttribute *reportAttr, uint64_t dataTypeConfig);
    int32_t ReportManagerCollectStop(const uint32_t deviceId, ReportAttribute *reportAttr, uint64_t dataTypeConfig);
    int32_t ReportManagerFinalize(ReportAttribute *reportAttr, uint64_t dataTypeConfig);
    int32_t ReportManagerStartDeviceReporters(ReportAttribute *reportAttr);
    int32_t ReportManagerStopDeviceReporters(ReportAttribute *reportAttr);
    int32_t TaskManagerStart(TaskSlotAttribute *attr);
    int32_t TaskManagerStop(ProfileParam *params, TaskSlotAttribute *attr);
    int32_t TaskManagerFinalize();
    int32_t PlatformInitialize(uint32_t *repeatCount);
    int32_t PlatformFinalize(uint32_t *repeatCount);
}

class ServiceTaskUtest: public testing::Test {
protected:
    virtual void SetUp()
    {
    }
    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

extern int32_t CallbackStub(uint32_t, void *, uint32_t);
TEST_F(ServiceTaskUtest, TestMsprofNotifySetDeviceInvalidParam)
{
    uint32_t chipId = 0;
    uint32_t deviceId = MAX_TASK_SLOT;
    // test invalid device id
    EXPECT_EQ(MsprofNotifySetDevice(chipId, deviceId, true), PROFILING_FAILED);
}

TEST_F(ServiceTaskUtest, TestMsprofInitialize)
{
    uint32_t dataType = MSPROF_CTRL_INIT_ACL_JSON;
    char data[] = "{\"aic_metrics\":\"PipeUtilization\",\"output\":\"output_dir\",\"switch\":\"on\"}";

    MOCKER(PlatformInitialize).stubs().will(returnValue(PROFILING_FAILED)).then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(MsprofInit(dataType, data, sizeof(data)), PROFILING_FAILED);
    // platform init failed
    EXPECT_EQ(MsprofInit(dataType, data, sizeof(data)), PROFILING_FAILED);
}

TEST_F(ServiceTaskUtest, TestMsprofNotifySetDevice)
{
    uint32_t chipId = 0;
    uint32_t deviceId = 0;
    MOCKER(TaskPoolInitialize).stubs().will(returnValue(PROFILING_FAILED)).then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(MsprofNotifySetDevice(chipId, deviceId, true), PROFILING_FAILED);

    MOCKER(ReportManagerInitialize).stubs().will(returnValue(PROFILING_FAILED)).then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(MsprofNotifySetDevice(chipId, deviceId, true), PROFILING_FAILED);

    MOCKER(ReportManagerStartDeviceReporters).stubs().will(returnValue(PROFILING_FAILED)).then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(MsprofNotifySetDevice(chipId, deviceId, true), PROFILING_FAILED);
    
    MOCKER(TaskManagerStart).stubs().will(returnValue(PROFILING_FAILED)).then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(MsprofNotifySetDevice(chipId, deviceId, true), PROFILING_FAILED);

    MOCKER(ReportManagerCollectStart).stubs().will(returnValue(PROFILING_FAILED)).then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(MsprofNotifySetDevice(chipId, deviceId, true), PROFILING_FAILED);

    EXPECT_EQ(MsprofNotifySetDevice(chipId, deviceId, true), PROFILING_SUCCESS);
}

TEST_F(ServiceTaskUtest, TestMsprofFinalize)
{
    MOCKER(ReportManagerFinalize).stubs().will(returnValue(PROFILING_FAILED)).then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(MsprofFinalize(), PROFILING_FAILED);

    MOCKER(TaskManagerFinalize).stubs().will(returnValue(PROFILING_FAILED)).then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(MsprofFinalize(), PROFILING_FAILED);

    MOCKER(UploaderFinalize).stubs().will(returnValue(PROFILING_FAILED)).then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(MsprofFinalize(), PROFILING_FAILED); 

    MOCKER(TaskPoolFinalize).stubs().will(returnValue(PROFILING_FAILED)).then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(MsprofFinalize(), PROFILING_SUCCESS); 

    MOCKER(ReportManagerStopDeviceReporters).stubs().will(returnValue(PROFILING_FAILED)).then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(MsprofFinalize(), PROFILING_FAILED);
    EXPECT_EQ(MsprofFinalize(), PROFILING_SUCCESS);
}