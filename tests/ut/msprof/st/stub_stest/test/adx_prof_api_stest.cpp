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
#include "adx_prof_api.h"
#include "errno/error_code.h"
#include "securec.h"

using namespace analysis::dvvp::common::error;
using namespace Analysis::Dvvp::Adx;

class ADX_PROF_API_STEST: public testing::Test {
protected:
    virtual void SetUp() {

    }
    virtual void TearDown() {
        GlobalMockObject::verify();
    }
};

TEST_F(ADX_PROF_API_STEST, AdxIdeGetVfIdBySession) {
    GlobalMockObject::verify();
    HDC_SESSION session = (HDC_SESSION)0x12345678;
    int32_t vfId = 0;
    MOCKER(Analysis::Dvvp::Adx::IdeGetVfIdBySession)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK))
        .then(returnValue(IDE_DAEMON_ERROR));

    EXPECT_EQ(IDE_DAEMON_OK, AdxIdeGetVfIdBySession(session, vfId));
    EXPECT_EQ(IDE_DAEMON_ERROR, AdxIdeGetVfIdBySession(session, vfId));
}