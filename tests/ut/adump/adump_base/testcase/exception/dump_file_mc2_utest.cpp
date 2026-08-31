/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <gtest/gtest.h>

#include <memory>

#include "mockcpp/mockcpp.hpp"
#include "securec.h"
#include "adump_dsmi.h"
#include "adump_platform_manager.h"
#include "dump_file.h"
#include "dump_memory.h"
#include "hccl_mc2_define.h"

using namespace Adx;

namespace {
rtError_t GetAscend910BSocVersion(char* version, const uint32_t maxLen)
{
    (void)strcpy_s(version, maxLen, "Ascend910B4");
    return RT_ERROR_NONE;
}
} // namespace

class DumpFileMc2Utest : public testing::Test {
protected:
    void SetUp() override { ResetAllPlatformManagers(); }

    void TearDown() override
    {
        ResetAllPlatformManagers();
        GlobalMockObject::verify();
    }
};

TEST_F(DumpFileMc2Utest, SetMc2spaces_InvalidRank)
{
    uint32_t platformType = static_cast<uint32_t>(PlatformType::CHIP_CLOUD_V2);
    MOCKER_CPP(&AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(platformType)).will(returnValue(true));
    MOCKER(rtGetSocVersion).stubs().will(invoke(GetAscend910BSocVersion));

    auto hostParam = std::make_unique<HcclCombinOpParam>();
    uint8_t workspaceData[16] = {};
    IbVerbsData ibverbsData = {};
    hostParam->mc2WorkSpace = {reinterpret_cast<uint64_t>(workspaceData), sizeof(workspaceData)};
    hostParam->rankId = RANK_NUM;
    hostParam->winSize = sizeof(workspaceData);
    hostParam->ibverbsData = reinterpret_cast<uint64_t>(&ibverbsData);
    hostParam->ibverbsDataSize = sizeof(ibverbsData);

    MOCKER(&DumpMemory::CheckDeviceMemory).expects(once()).will(returnValue(ADUMP_SUCCESS));
    MOCKER(&DumpMemory::CopyDeviceToHost).expects(once()).will(returnValue(static_cast<void*>(hostParam.get())));
    MOCKER(&DumpMemory::FreeHost).expects(once());

    uint8_t deviceParam[sizeof(HcclCombinOpParam)] = {};
    DumpWorkspace mc2Space(deviceParam, sizeof(deviceParam), 0U);
    DumpFile dumpFile(0U, "/tmp/adump_mc2_invalid_rank_test.bin");
    dumpFile.SetMc2spaces({mc2Space});
}
