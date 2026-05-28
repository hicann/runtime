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
#include <fstream>
#include <functional>
#include <thread>
#include <vector>
#include "mockcpp/mockcpp.hpp"

#include "dump_printf.h"
#include "toolchain/prof_common.h"
#include "adump_api.h"

using namespace Adx;

class TinyDumpPrintfUtest : public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

TEST_F(TinyDumpPrintfUtest, Test_DumpPrintfForTiny)
{
    void *workSpaceAddr = nullptr;
    size_t dumpWorkSpaceSize = 0;
    AdxPrintWorkSpace(nullptr, 0, nullptr, "test", false);
    std::vector<MsprofAicTimeStampInfo> timeStampInfo;
    AdxPrintTimeStamp(nullptr, 0, nullptr, "test", timeStampInfo);
    AdumpPrintConfig config = {false};
    AdxPrintSetConfig(config);
}