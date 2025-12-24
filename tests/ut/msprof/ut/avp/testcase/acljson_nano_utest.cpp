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
#include "hal/hal_dsmi.h"
#include "platform_interface.h"

class AclJsonNanoUtest: public testing::Test {
protected:
    virtual void SetUp()
    {
    }
    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

int32_t CallbackStub(uint32_t, void *, uint32_t) {return 0;};
int32_t CallbackHandle(uint32_t dataType, void *data, uint32_t dataLen)
{
    return 0;
}
TEST_F(AclJsonNanoUtest, AclJsonDefault)
{
    MOCKER(HalGetChipVersion)
        .stubs()
        .will(returnValue(uint32_t(CHIP_NANO_V1)));
    uint32_t dataType = MSPROF_CTRL_INIT_ACL_JSON;
    char data[] = "{\"aic_metrics\":\"PipeUtilization\",\"output\":\"./output_dir\",\"switch\":\"on\"}";
    EXPECT_EQ(MsprofInit(dataType, data, sizeof(data)), PROFILING_SUCCESS);

    uint32_t chipId = 0;
    uint32_t deviceId = 0;
    EXPECT_EQ(MsprofNotifySetDevice(dataType, deviceId, true), PROFILING_SUCCESS);

    uint32_t moduleId;
    ProfCommandHandle handle = CallbackStub;
    EXPECT_EQ(MsprofRegisterCallback(moduleId, handle), PROFILING_SUCCESS);

    // reg type info
    int16_t level = 5000;
    int32_t typeId = 1133;
    char hashData[] = "EventCreateEx";
    EXPECT_EQ(MsprofRegTypeInfo(level, typeId, hashData), PROFILING_SUCCESS);

    uint32_t agingFlag = 1;
    uint32_t unAgingFlag = 0;
    MsprofApi api;
    api.level = 10000;
    api.type = 5000;
    api.beginTime = 100;
    EXPECT_EQ(MsprofReportApi(agingFlag, &api), PROFILING_SUCCESS);
    MsprofEvent event;
    event.level = 20000;
    event.type = 5000;
    EXPECT_EQ(MsprofReportEvent(unAgingFlag, &event), PROFILING_SUCCESS);

    MsprofCompactInfo compactData;
    uint32_t length = 0;
    EXPECT_EQ(MsprofReportCompactInfo(agingFlag, &compactData, length), PROFILING_FAILED);
    MsprofAdditionalInfo additionalData;
    EXPECT_EQ(MsprofReportAdditionalInfo(agingFlag, &additionalData, length), PROFILING_FAILED);

    additionalData.level = 5000;
    additionalData.type = 1133;
    EXPECT_EQ(MsprofReportAdditionalInfo(agingFlag, &additionalData, 20), PROFILING_SUCCESS);

    additionalData.level = 10000;
    additionalData.type = 1;
    EXPECT_EQ(MsprofReportAdditionalInfo(agingFlag, &additionalData, 20), PROFILING_SUCCESS);

    compactData.level = 10000;
    compactData.type = 0;
    EXPECT_EQ(MsprofReportCompactInfo(agingFlag, &compactData, 20), PROFILING_SUCCESS);

    EXPECT_EQ(MsprofNotifySetDevice(dataType, deviceId, false), PROFILING_SUCCESS);
    EXPECT_EQ(MsprofFinalize(), PROFILING_SUCCESS);   
}