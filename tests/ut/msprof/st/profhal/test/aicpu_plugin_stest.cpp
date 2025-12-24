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
#include "msprof_stub.h"
#include "prof_hal_plugin.h"
#include "prof_hal_api.h"
#include "securec.h"
#include "msprof_reporter.h"
#include "prof_acl_mgr.h"

class PROF_AICPU_PLUGIN_STTEST : public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown() {}
};

TEST_F(PROF_AICPU_PLUGIN_STTEST, PROF_AICPU_INIT_FINAL)
{
    uint32_t configSize =
        static_cast<uint32_t>(sizeof(ProfHalModuleConfig) + sizeof(uint32_t));
    auto moduleConfigP = static_cast<ProfHalModuleConfig *>(malloc(configSize));
    EXPECT_NE(nullptr, moduleConfigP);
    (void)memset_s(moduleConfigP, configSize, 0, configSize);
    const uint32_t devIdList[2] = {64, 0};
    moduleConfigP->devIdList = const_cast<uint32_t *>(devIdList);
    moduleConfigP->devIdListNums = 2;
    EXPECT_EQ(0, ProfAPI::ProfHalPlugin::instance()->ProfHalInit(PROF_HAL_AICPU, moduleConfigP, sizeof(moduleConfigP)));
    ProfAPI::ProfHalPlugin::instance()->ProfHalFlushModuleRegister(Msprof::Engine::FlushModule);
    ProfAPI::ProfHalPlugin::instance()->ProfHalSendDataRegister(Msprof::Engine::SendAiCpuData);
    ProfAPI::ProfHalPlugin::instance()->ProfHalHelperDirRegister(Msprofiler::Api::SetHelperDirToTransport);
    ProfAPI::ProfHalPlugin::instance()->ProfHalSendHelperDataRegister(Msprofiler::Api::SendHelperData);
    sleep(1);
    EXPECT_EQ(0, ProfAPI::ProfHalPlugin::instance()->ProfHalFinal());
    free(moduleConfigP);
}

TEST_F(PROF_AICPU_PLUGIN_STTEST, PROF_AICPU_GETVERSION)
{
    uint32_t version = 0;
    EXPECT_EQ(0, ProfAPI::ProfHalPlugin::instance()->ProfHalGetVersion(&version));
}

TEST_F(PROF_AICPU_PLUGIN_STTEST, PROF_AICPU_GETVERSION_NULLPTR)
{
    uint32_t *version = nullptr;
    EXPECT_EQ(-1, ProfAPI::ProfHalPlugin::instance()->ProfHalGetVersion(version));
}

TEST_F(PROF_AICPU_PLUGIN_STTEST, PROF_AICPU_INIT_NULLPTR)
{
    ProfHalModuleConfig *moduleConfigP = nullptr;
    EXPECT_EQ(-1, ProfAPI::ProfHalPlugin::instance()->ProfHalInit(PROF_HAL_AICPU, moduleConfigP, sizeof(moduleConfigP)));
}
