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
#include "osal/osal.h"
#include "osal/osal_mem.h"
#include "param/profile_param.h"
#include "job/collection_job.h"
#include "errno/error_code.h"
#include "transport/transport.h"
#include "transport/uploader.h"
#include "task/task_manager.h"
#include "job/job_manager.h"

class TaskManagerUtest: public testing::Test {
protected:
    virtual void SetUp()
    {
    }
    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

TEST_F(TaskManagerUtest, TestTaskManagerInitialize)
{
    TaskSlotAttribute attr;
    uint32_t deviceId = 0;
    EXPECT_EQ(TaskManagerInitialize(deviceId, &attr), PROFILING_SUCCESS);
    EXPECT_EQ(attr.deviceId, deviceId);
    TaskManagerFinalize(&attr);
}

static int32_t UploadDataStub(ProfFileChunk *chunk)
{
    OSAL_MEM_FREE(chunk->chunk);
    OSAL_MEM_FREE(chunk);
    return PROFILING_SUCCESS;
}

TEST_F(TaskManagerUtest, TestTaskManagerStart)
{
    ProfileParam params;
    TransportType transType = FILE_TRANSPORT;
    TaskSlotAttribute attr = { 0 };
    uint32_t deviceId = 0;
    params.hostProfiling = false;
    MOCKER(DestroyDataUploader).stubs();
    MOCKER(CreateProfMainDir).stubs().will(returnValue(PROFILING_SUCCESS));
    MOCKER(UploaderUploadData).stubs().will(invoke(UploadDataStub));

    EXPECT_EQ(TaskManagerInitialize(deviceId, &attr), PROFILING_SUCCESS);

    MOCKER(CreateDataUploader).stubs().will(returnValue(PROFILING_FAILED)).then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(TaskManagerStart(&params, transType, &attr), PROFILING_FAILED);
    EXPECT_EQ(TaskManagerStop(&params, &attr), PROFILING_SUCCESS);

    MOCKER(pthread_attr_init).stubs().will(returnValue(1)).then(returnValue(0));
    EXPECT_EQ(TaskManagerStart(&params, transType, &attr), PROFILING_FAILED);
    EXPECT_EQ(TaskManagerStop(&params, &attr), PROFILING_SUCCESS);

    MOCKER(JobManagerStart).stubs().will(returnValue(PROFILING_FAILED)).then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(TaskManagerStart(&params, transType, &attr), PROFILING_FAILED);
    EXPECT_EQ(TaskManagerStop(&params, &attr), PROFILING_SUCCESS);

    EXPECT_EQ(TaskManagerStart(&params, transType, &attr), PROFILING_SUCCESS);
    EXPECT_EQ(TaskManagerStop(&params, &attr), PROFILING_SUCCESS);

    TaskManagerFinalize(&attr);
}