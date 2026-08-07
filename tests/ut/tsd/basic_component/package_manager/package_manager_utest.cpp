/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "package_manager_test_common.h"

using namespace tsd;
using namespace tsdtest;

class PackageManagerFacadeTest : public PackageManagerComponentTest {};

TEST_F(PackageManagerFacadeTest, ResetOnCloseClearsSendConfigState)
{
    ProcessModeManager manager(deviceId, PROCESS_MODE);
    manager.GetPackageManager().loader_.hasSendConfigFile_ = true;

    manager.GetPackageManager().ResetOnClose();

    EXPECT_FALSE(manager.GetPackageManager().loader_.hasSendConfigFile_);
}

TEST_F(PackageManagerFacadeTest, GetHostCheckCodeReturnsServiceState)
{
    ProcessModeManager manager(deviceId, PROCESS_MODE);
    manager.GetPackageManager().checkCodeSvc_.SetHostCheckCodeByIndex(
        static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL), 42U);

    EXPECT_EQ(manager.GetPackageManager().GetHostCheckCode(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL), 42U);
}

TEST_F(PackageManagerFacadeTest, StoreAllPkgHashValueForwardsToHashStore)
{
    ProcessModeManager manager(deviceId, PROCESS_MODE);
    HDCMessage msg;
    msg.set_type(HDCMessage::TSD_GET_DEVICE_PACKAGE_CHECKCODE_NORMAL_RSP);
    auto* info = msg.add_package_hash_code_list();
    info->set_package_name("pkg");
    info->set_hash_code("hash");

    manager.GetPackageManager().StoreAllPkgHashValue(msg);

    EXPECT_EQ(manager.GetPackageManager().hashStore_.GetDeviceCommonSinkPackHashValue("pkg"), "hash");
}
