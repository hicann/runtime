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
#include "mockcpp/mockcpp.hpp"
#include "ide_daemon_api.h"
#include "hdc_api.h"
#include "impl_utils.h"
#include "mmpa_api.h"
#include "ide_platform_util.h"
#include "ide_common_util.h"

using namespace IdeDaemon::Common::Utils;

class IDE_COMMON_UTILS_STEST: public testing::Test {
protected:
    virtual void SetUp() {
    }
    virtual void TearDown() {
        GlobalMockObject::verify();
    }
};

TEST_F(IDE_COMMON_UTILS_STEST, Split)
{
    std::vector<std::string> res;
    std::string input = "abc,def,hig";
    res = Split(input, true, "def", ",");
    EXPECT_EQ(res[0], "abc");
    EXPECT_EQ(res[1], "hig");
}

TEST_F(IDE_COMMON_UTILS_STEST,  LeftTrim)
{
    EXPECT_EQ("abc", LeftTrim(" abc", " "));
    EXPECT_EQ("", LeftTrim("    ", " "));
    EXPECT_EQ("", LeftTrim("", " "));
}
