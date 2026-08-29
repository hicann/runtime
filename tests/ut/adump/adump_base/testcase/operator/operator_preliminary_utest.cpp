/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <cstring>
#include <string>

#include <gtest/gtest.h>
#include "mockcpp/mockcpp.hpp"
#include "runtime/rt.h"
#include "adump_dsmi.h"
#include "adump_platform_manager.h"
#include "dump_setting.h"
#include "operator_preliminary.h"
#include "common/path.h"
#include "lib_path.h"

using namespace Adx;

namespace {
std::string g_launchedSoName;
std::string g_launchedKernelName;
bool g_launchCalled = false;

void ResetLaunchCapture()
{
    g_launchedSoName.clear();
    g_launchedKernelName.clear();
    g_launchCalled = false;
}

rtError_t RtAicpuKernelLaunchCaptureStub(
    const uint32_t kernelType, const char_t* const opName, const uint32_t blockDim, const rtAicpuArgsEx_t* argsInfo,
    rtSmDesc_t* const smDesc, const rtStream_t stm, const uint32_t flags)
{
    (void)kernelType;
    (void)opName;
    (void)blockDim;
    (void)smDesc;
    (void)stm;
    (void)flags;
    g_launchCalled = true;
    if (argsInfo != nullptr && argsInfo->args != nullptr) {
        const auto* param = static_cast<const KfcDumpOpInitParam*>(argsInfo->args);
        g_launchedSoName = param->soName;
        g_launchedKernelName = param->kernelName;
    }
    return RT_ERROR_NONE;
}

// 构造一份可通过 DumpSetting::Init 的统计 dump 配置
DumpSetting MakeStatsDumpSetting()
{
    struct DumpConfig dumpConf;
    dumpConf.dumpPath = "/path/to/dump/dir";
    dumpConf.dumpStatus = "on";
    dumpConf.dumpMode = "all";
    dumpConf.dumpSwitch = (OPERATOR_OP_DUMP | OPERATOR_KERNEL_DUMP);
    dumpConf.dumpData = "stats";

    DumpSetting setting;
    (void)setting.Init(DumpType::OPERATOR, dumpConf);
    return setting;
}

// 让 OperatorInit 能一路走到 KFCKernelLaunch：桩掉平台查询与 bin 路径
void StubOperatorInitDependencies()
{
    MOCKER(rtMalloc).stubs().will(returnValue(0));
    MOCKER_CPP(&DumpSetting::GetPlatformType).stubs().will(returnValue(PlatformType::CHIP_CLOUD_V2));
    uint32_t v2Type = static_cast<uint32_t>(PlatformType::CHIP_CLOUD_V2);
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(v2Type)).will(returnValue(true));
    std::string path = ADUMP_BASE_DIR "stub/data/simulated_data.txt";
    Path retPath(path);
    MOCKER_CPP(&Path::Concat).stubs().will(returnValue(retPath));
    MOCKER(rtAicpuKernelLaunchExWithArgs).stubs().will(invoke(RtAicpuKernelLaunchCaptureStub));
}
} // namespace

class OperatorPreliminaryUtest : public testing::Test {
protected:
    virtual void SetUp() { ResetAllPlatformManagers(); }
    virtual void TearDown()
    {
        ResetAllPlatformManagers();
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
        uint32_t v2Type = static_cast<uint32_t>(PlatformType::CHIP_CLOUD_V2);
        MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(v2Type)).will(returnValue(true));
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
        std::string path = "./llt/runtime/src/dfx/adump/ut/adump_base/stub/data/";
        MOCKER_CPP(&LibPath::GetInstallPath).stubs().will(returnValue(Adx::Path(path)));

        EXPECT_EQ(opIniter->OperatorInit(), ADUMP_FAILED);
    } while (0);
}

// ---------------------------------------------------------------------------
// 驱动版本门禁三档（DecideKFCLaunchMode + UpdateKFCLaunchInfo）
//
// version 一律按大小比较，不为 0 设特例：0 落在 "< KFC_AICPU_DRV_VERSION" 区间，
// 与查询失败(-1)同样判 UNSUPPORTED、不下发。
// ---------------------------------------------------------------------------

// 档位 1：version == 0（halGetAPIVersion 弱符号缺失，接口已废弃）→ 不下发
TEST_F(OperatorPreliminaryUtest, KfcLaunchTier_VersionZero_NotLaunched)
{
    ResetLaunchCapture();
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetAPIVersion).stubs().will(returnValue(0));
    StubOperatorInitDependencies();

    DumpSetting setting = MakeStatsDumpSetting();
    OperatorPreliminary opIniter(setting, 0);
    // 不支持时主流程仍返回成功，只是不下发 KFC 初始化
    EXPECT_EQ(opIniter.OperatorInit(), ADUMP_SUCCESS);
    EXPECT_FALSE(g_launchCalled);
}

// 档位 1：version == -1（halGetAPIVersion 调用失败）→ 不下发
TEST_F(OperatorPreliminaryUtest, KfcLaunchTier_VersionQueryFailed_NotLaunched)
{
    ResetLaunchCapture();
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetAPIVersion).stubs().will(returnValue(-1));
    StubOperatorInitDependencies();

    DumpSetting setting = MakeStatsDumpSetting();
    OperatorPreliminary opIniter(setting, 0);
    // 不支持时主流程仍返回成功，只是不下发 KFC 初始化
    EXPECT_EQ(opIniter.OperatorInit(), ADUMP_SUCCESS);
    EXPECT_FALSE(g_launchCalled);
}

// 档位 1 边界：低于支持下界一个版本 → 不下发
TEST_F(OperatorPreliminaryUtest, KfcLaunchTier_BelowSupportedBoundary_NotLaunched)
{
    ResetLaunchCapture();
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetAPIVersion).stubs().will(returnValue(KFC_AICPU_DRV_VERSION - 1));
    StubOperatorInitDependencies();

    DumpSetting setting = MakeStatsDumpSetting();
    OperatorPreliminary opIniter(setting, 0);
    EXPECT_EQ(opIniter.OperatorInit(), ADUMP_SUCCESS);
    EXPECT_FALSE(g_launchCalled);
}

// 档位 2 下边界：恰好等于支持下界 → 走 aicpu_extend_kernels
TEST_F(OperatorPreliminaryUtest, KfcLaunchTier_AtSupportedBoundary_UsesAicpuExtendKernels)
{
    ResetLaunchCapture();
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetAPIVersion).stubs().will(returnValue(KFC_AICPU_DRV_VERSION));
    StubOperatorInitDependencies();

    DumpSetting setting = MakeStatsDumpSetting();
    OperatorPreliminary opIniter(setting, 0);
    EXPECT_EQ(opIniter.OperatorInit(), ADUMP_SUCCESS);

    EXPECT_TRUE(g_launchCalled);
    EXPECT_EQ(g_launchedSoName, "libaicpu_extend_kernels.so");
    EXPECT_EQ(g_launchedKernelName, "AicpuKfcDumpSrvInit");
}

// 档位 2 上边界：迁移版本前一个 → 仍走 aicpu_extend_kernels
TEST_F(OperatorPreliminaryUtest, KfcLaunchTier_JustBelowMigration_UsesAicpuExtendKernels)
{
    ResetLaunchCapture();
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetAPIVersion).stubs().will(returnValue(KFC_ADUMP_DRV_VERSION - 1));
    StubOperatorInitDependencies();

    DumpSetting setting = MakeStatsDumpSetting();
    OperatorPreliminary opIniter(setting, 0);
    EXPECT_EQ(opIniter.OperatorInit(), ADUMP_SUCCESS);

    EXPECT_TRUE(g_launchCalled);
    EXPECT_EQ(g_launchedSoName, "libaicpu_extend_kernels.so");
}

// 档位 3 下边界：恰好等于迁移版本 → 走 adump
TEST_F(OperatorPreliminaryUtest, KfcLaunchTier_AtMigrationBoundary_UsesAdump)
{
    ResetLaunchCapture();
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetAPIVersion).stubs().will(returnValue(KFC_ADUMP_DRV_VERSION));
    StubOperatorInitDependencies();

    DumpSetting setting = MakeStatsDumpSetting();
    OperatorPreliminary opIniter(setting, 0);
    EXPECT_EQ(opIniter.OperatorInit(), ADUMP_SUCCESS);

    EXPECT_TRUE(g_launchCalled);
    EXPECT_EQ(g_launchedSoName, "libadump.so");
    EXPECT_EQ(g_launchedKernelName, "AdumpStatsOpSrvInit");
}

// 档位 3：远高于迁移版本 → 走 adump
TEST_F(OperatorPreliminaryUtest, KfcLaunchTier_AboveMigration_UsesAdump)
{
    ResetLaunchCapture();
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetAPIVersion).stubs().will(returnValue(KFC_ADUMP_DRV_VERSION + 10000));
    StubOperatorInitDependencies();

    DumpSetting setting = MakeStatsDumpSetting();
    OperatorPreliminary opIniter(setting, 0);
    EXPECT_EQ(opIniter.OperatorInit(), ADUMP_SUCCESS);

    EXPECT_TRUE(g_launchCalled);
    EXPECT_EQ(g_launchedSoName, "libadump.so");
}

// 两个承载方的 so 名与 kernel 名必须成对，混搭会使目标 so 中找不到符号
TEST_F(OperatorPreliminaryUtest, KfcLaunchInfo_NamesArePaired)
{
    EXPECT_STREQ(AICPU_LAUNCH_INFO.soName, "libaicpu_extend_kernels.so");
    EXPECT_STREQ(AICPU_LAUNCH_INFO.kernelName, "AicpuKfcDumpSrvInit");
    EXPECT_STREQ(ADUMP_LAUNCH_INFO.soName, "libadump.so");
    EXPECT_STREQ(ADUMP_LAUNCH_INFO.kernelName, "AdumpStatsOpSrvInit");
    // 名长须在 FILE_NAME_MAX 内，否则 strcpy_s 会失败
    EXPECT_LT(strlen(AICPU_LAUNCH_INFO.soName), FILE_NAME_MAX);
    EXPECT_LT(strlen(AICPU_LAUNCH_INFO.kernelName), FILE_NAME_MAX);
    EXPECT_LT(strlen(ADUMP_LAUNCH_INFO.soName), FILE_NAME_MAX);
    EXPECT_LT(strlen(ADUMP_LAUNCH_INFO.kernelName), FILE_NAME_MAX);
}
