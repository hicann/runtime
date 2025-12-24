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
#include "report/start_time.h"

class TimeFileUtest: public testing::Test {
protected:
    virtual void SetUp()
    {
    }
    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

static int32_t UploadDataStub(ProfFileChunk *chunk)
{
    OSAL_MEM_FREE(chunk->chunk);
    OSAL_MEM_FREE(chunk);
    return PROFILING_SUCCESS;
}

TEST_F(TimeFileUtest, CreateStartTimeFile)
{
    MOCKER(UploaderUploadData).stubs().will(invoke(UploadDataStub));
    int32_t deviceId = 0;
    EXPECT_EQ(CreateStartTimeFile(deviceId), PROFILING_SUCCESS);
    deviceId = 64;
    EXPECT_EQ(CreateStartTimeFile(deviceId), PROFILING_SUCCESS);
}

static int32_t UploadDataFailedStub(ProfFileChunk *chunk)
{
    OSAL_MEM_FREE(chunk->chunk);
    OSAL_MEM_FREE(chunk);
    return PROFILING_FAILED;
}

TEST_F(TimeFileUtest, CreateStartTimeFileFailed)
{
    MOCKER(UploaderUploadData).stubs().will(invoke(UploadDataFailedStub));
    int32_t deviceId = 0;
    EXPECT_EQ(CreateStartTimeFile(deviceId), PROFILING_FAILED);
    deviceId = 64;
    EXPECT_EQ(CreateStartTimeFile(deviceId), PROFILING_FAILED);
}