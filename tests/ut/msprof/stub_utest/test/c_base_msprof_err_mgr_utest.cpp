/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "mockcpp/mockcpp.hpp"
#include "gtest/gtest.h"
#include <vector>
#include <string>
#include "msprof_error_manager.h"

using namespace Analysis::Dvvp::MsprofErrMgr;

class C_BASE_ERR_MGR_UTEST : public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown() {
        GlobalMockObject::verify();
    }
};

TEST_F(C_BASE_ERR_MGR_UTEST, GetErrorManagerContext)
{
    auto &ctx = MsprofErrorManager::instance()->GetErrorManagerContext();
    EXPECT_EQ(0UL, ctx.workStreamId);
}

TEST_F(C_BASE_ERR_MGR_UTEST, SetErrorContext)
{
    error_message::Context ctx{1UL, "init", "parser", "header"};
    MsprofErrorManager::instance()->SetErrorContext(ctx);
}

TEST_F(C_BASE_ERR_MGR_UTEST, ReportErrorMessage_empty)
{
    std::vector<std::string> keys;
    std::vector<std::string> values;
    MsprofErrorManager::instance()->ReportErrorMessage("E00001", keys, values);
}

TEST_F(C_BASE_ERR_MGR_UTEST, ReportErrorMessage_with_data)
{
    std::vector<std::string> keys = {"key1", "key2"};
    std::vector<std::string> values = {"val1", "val2"};
    MsprofErrorManager::instance()->ReportErrorMessage("E00001", keys, values);
}
