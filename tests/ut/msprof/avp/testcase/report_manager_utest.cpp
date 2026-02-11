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
#include "toolchain/prof_api.h"
#include "errno/error_code.h"
#include "report/hash_dic.h"
#include "report/report_manager.h"
#include "logger/logger.h"
#include "osal/osal_thread.h"
#include "transport/transport.h"
#include "transport/uploader.h"
#include "utils/utils.h"

class TypeInfoUtest: public testing::Test {
protected:
    virtual void SetUp()
    {
    }
    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

TEST_F(TypeInfoUtest, RegisterTypeInfo)
{
    
    int16_t level = 5000;
    int32_t typeId = 1133;
    char hashData[] = "EventCreateEx";
    // level = 0
    EXPECT_EQ(PROFILING_FAILED, MsprofRegTypeInfo(0, typeId, hashData));
    // hashData = NULL
    EXPECT_EQ(PROFILING_FAILED, MsprofRegTypeInfo(level, typeId, nullptr));
    // report not inited
    EXPECT_EQ(PROFILING_FAILED, MsprofRegTypeInfo(level, typeId, hashData));
}