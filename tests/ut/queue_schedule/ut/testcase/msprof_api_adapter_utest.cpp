/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "mockcpp/ChainingMockHelper.h"
#include "dlopen_stub.h"
#include "msprof_api_adapter.h"

using namespace bqs;

class BqsMsprofApiAdapterUTest : public testing::Test {
protected:
    void TearDown() override { GlobalMockObject::verify(); }
};

TEST_F(BqsMsprofApiAdapterUTest, ConstMsprofAdapterNullptr)
{
    MOCKER(dlopen).stubs().will(returnValue(static_cast<void*>(nullptr)));
    const BqsMsprofApiAdapter apiAdapter;

    EXPECT_EQ(apiAdapter.MsprofInit(0, nullptr, 0), ProfStatus::PROF_MSPROF_API_NULLPTR);
    EXPECT_EQ(apiAdapter.MsprofFinalize(), ProfStatus::PROF_MSPROF_API_NULLPTR);
    EXPECT_EQ(apiAdapter.MsprofReportEvent(0, nullptr), ProfStatus::PROF_MSPROF_API_NULLPTR);
}
