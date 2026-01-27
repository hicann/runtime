/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <gtest/gtest.h>
#include <string>
#include <iostream>
#include "mockcpp/mockcpp.hpp"
#include "mem.h"
#include "rt.h"
#include "hal_ts.h"
#include "error_codes/rt_error_codes.h"

using namespace std;
using namespace testing;

class ApiModelCTest : public testing::Test {
protected:
    void SetUp() {}
    void TearDown() {}
};

TEST_F(ApiModelCTest, model_load) {
    rtMdlLoad_t modelLoad = {0};
    uint32_t phyModelId = 0UL;
    EXPECT_EQ(rtNanoModelLoad(&modelLoad, &phyModelId), RT_ERROR_NONE);
    EXPECT_EQ(rtNanoModelLoad(nullptr, &phyModelId), ACL_ERROR_RT_PARAM_INVALID);
    modelLoad.weightPrefetch = 1;
    EXPECT_EQ(rtNanoModelLoad(&modelLoad, &phyModelId), ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiModelCTest, model_exec) {
    rtError_t error;
    error = rtInit();
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtMdlExecute_t modelExec;
    rtStreamConfigHandle handle;
    modelExec.sync = true;
    EXPECT_EQ(rtNanoModelExecute(&modelExec), RT_ERROR_NONE);

    modelExec.sync = false;
    EXPECT_EQ(rtNanoModelExecute(&modelExec), RT_ERROR_NONE);

    EXPECT_EQ(rtNanoModelExecute(nullptr), ACL_ERROR_RT_PARAM_INVALID);

    error = rtDeviceReset(0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    rtDeinit();
}

TEST_F(ApiModelCTest, model_destroy) {
    uint32_t phyModelId = 0UL;
    EXPECT_EQ(rtNanoModelDestroy(phyModelId), RT_ERROR_NONE);
}

TEST_F(ApiModelCTest, dump_init) {
    EXPECT_EQ(rtDumpInit(), RT_ERROR_NONE);
    MOCKER(halDumpInit).stubs().will(returnObjectList(DRV_ERROR_NO_DEVICE));
    EXPECT_EQ(rtDumpInit(), DRV_ERROR_NO_DEVICE);
}

TEST_F(ApiModelCTest, dump_deinit) {
    EXPECT_EQ(rtDumpDeInit(), RT_ERROR_NONE);
    MOCKER(halDumpDeinit).stubs().will(returnObjectList(DRV_ERROR_NO_DEVICE));
    EXPECT_EQ(rtDumpDeInit(), DRV_ERROR_NO_DEVICE);
}

TEST_F(ApiModelCTest, dump_msg_send) {
    uint32_t tId;
    uint32_t sendTid = 0U;
    int32_t timeout = 0;
    void *sendInfo = NULL;
    uint32_t size;
    EXPECT_EQ(rtMsgSend(tId, sendTid, timeout, sendInfo, size), RT_ERROR_NONE);

    MOCKER(halMsgSend).stubs().will(returnObjectList(DRV_ERROR_SEND_MESG));
    EXPECT_EQ(rtMsgSend(tId, sendTid, timeout, sendInfo, size), DRV_ERROR_SEND_MESG);
}

TEST_F(ApiModelCTest, set_taskDesc_dumpFlag) {
    uint32_t taskId;
    void *taskDescBaseAddr = NULL;
    size_t taskDescSize = 0UL;
    EXPECT_EQ(rtSetTaskDescDumpFlag(taskDescBaseAddr, taskDescSize, taskId), ACL_ERROR_RT_PARAM_INVALID);
    taskId = 1U;
    taskDescBaseAddr = malloc(100);
    EXPECT_EQ(rtSetTaskDescDumpFlag(taskDescBaseAddr, taskDescSize, taskId), ACL_ERROR_RT_PARAM_INVALID);
    taskId = 0U;
    taskDescSize = 8UL;
    EXPECT_EQ(rtSetTaskDescDumpFlag(taskDescBaseAddr, taskDescSize, taskId), RT_ERROR_NONE);
    free(taskDescBaseAddr);
}