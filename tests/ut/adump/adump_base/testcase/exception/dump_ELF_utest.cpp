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
#include "dump_ELF.h"

using namespace Adx;

class DUMP_ELF_UTEST : public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown() {
        GlobalMockObject::verify();
    }
};

TEST_F(DUMP_ELF_UTEST, TEST_ELF_CREATE_AND_SAVE) {
    ELF::DumpELF coreFile;
    ELF::SectionPtr sec = coreFile.AddSection(ASCEND_SHTYPE_GLOBAL, std::string("test"));
    std::string data("test");
    sec->SetData(data);
    system("mkdir -p /tmp/adump_ELF_utest");
    coreFile.Save("/tmp/adump_ELF_utest/test.elf");
    EXPECT_EQ(0, system("readelf /tmp/adump_ELF_utest/test.elf -t"));
    EXPECT_EQ(0, system("readelf /tmp/adump_ELF_utest/test.elf  -p test"));
    system("rm -r /tmp/adump_ELF_utest");
}