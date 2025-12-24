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
#include <iostream>
#include <fstream>

#include "msprof_error_manager.h"
using namespace Analysis::Dvvp::MsprofErrMgr;
class ERR_MGR_STEST: public testing::Test {
protected:
    virtual void SetUp() {

    }
    virtual void TearDown() {
    }
};


TEST_F(ERR_MGR_STEST, GetErrorManagerContext)
{
    GlobalMockObject::verify();
    error_message::Context context = {0UL, "", "", ""};
    MOCKER_CPP(&ErrorManager::GetErrorManagerContext)
        .stubs()
        .will(returnValue(context));
    auto err_message = MsprofErrorManager::instance()->GetErrorManagerContext();
    EXPECT_EQ(0UL, err_message.work_stream_id);
}