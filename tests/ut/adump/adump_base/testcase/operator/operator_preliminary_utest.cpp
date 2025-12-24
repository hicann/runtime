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
#include "runtime/rt.h"
#include "adump_dsmi.h"
#include "dump_setting.h"
#include "operator_preliminary.h"
#include "common/path.h"
#include "lib_path.h"

using namespace Adx;

class OperatorPreliminaryUtest: public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

TEST_F(OperatorPreliminaryUtest, Test_Operator_Init_Success)
{
    MOCKER(rtMalloc).stubs().will(returnValue(0));
    struct DumpConfig dumpConf;
    dumpConf.dumpPath = "/path/to/dump/dir";
    dumpConf.dumpStatus = "on";
    dumpConf.dumpMode = "all";
    dumpConf.dumpSwitch = (OPERATOR_OP_DUMP | OPERATOR_KERNEL_DUMP);
    dumpConf.dumpData = "stats";

    DumpSetting setting;
    EXPECT_EQ(setting.Init(DumpType::OPERATOR, dumpConf), ADUMP_SUCCESS);

    std::shared_ptr<OperatorPreliminary> opIniter = std::make_shared<OperatorPreliminary>(setting, 0);

    do {
        EXPECT_NE(opIniter, nullptr);
        if (opIniter == nullptr) {
            break;
        }
        MOCKER_CPP(&DumpSetting::GetPlatformType).stubs().will(returnValue(PlatformType::CHIP_CLOUD_V2));
        std::string path = ADUMP_BASE_DIR "stub/data/simulated_data.txt";
        Path retPath(path);
        MOCKER_CPP(&Path::Concat).stubs().will(returnValue(retPath));

        EXPECT_EQ(opIniter->OperatorInit(), ADUMP_SUCCESS);
    } while (0);
}

TEST_F(OperatorPreliminaryUtest, Test_Operator_Failed_BinLoad)
{
    struct DumpConfig dumpConf;
    dumpConf.dumpPath = "/path/to/dump/dir";
    dumpConf.dumpStatus = "on";
    dumpConf.dumpMode = "all";
    dumpConf.dumpSwitch = (OPERATOR_OP_DUMP | OPERATOR_KERNEL_DUMP);
    dumpConf.dumpData = "stats";

    DumpSetting setting;
    EXPECT_EQ(setting.Init(DumpType::OPERATOR, dumpConf), ADUMP_SUCCESS);

    std::shared_ptr<OperatorPreliminary> opIniter = std::make_shared<OperatorPreliminary>(setting, 0);

    do {
        EXPECT_NE(opIniter, nullptr);
        if (opIniter == nullptr) {
            break;
        }
        std::string path = "./llt/abl/adump/ut/adump_base/stub/data/";
        MOCKER_CPP(&LibPath::GetInstallPath).stubs().will(returnValue(Adx::Path(path)));

        EXPECT_EQ(opIniter->OperatorInit(), ADUMP_FAILED);
    } while (0);
}