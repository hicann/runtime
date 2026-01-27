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
#include "mmpa_linux.h"

class CmmpaTest : public testing::Test {
protected:
    void SetUp() {}
    void TearDown() {
        GlobalMockObject::verify();
    }
};

TEST_F(CmmpaTest, mmOpenFile_FILE_READ_BIN) {
    const char *fileName = "file_name";
    mmFileHandle *fd = mmOpenFile(fileName, FILE_READ_BIN);
    EXPECT_EQ(fd, nullptr);
}