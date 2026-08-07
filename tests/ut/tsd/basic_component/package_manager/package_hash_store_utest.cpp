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

class PackageHashStoreComponentTest : public PackageManagerComponentTest {};

TEST_F(PackageHashStoreComponentTest, MissingHostHashReturnsEmpty)
{
    PackageHashStore store;
    EXPECT_TRUE(store.GetHostCommonSinkPackHashValue("missing").empty());
}

TEST_F(PackageHashStoreComponentTest, MissingDeviceHashReturnsEmpty)
{
    PackageHashStore store;
    EXPECT_TRUE(store.GetDeviceCommonSinkPackHashValue("missing").empty());
}

TEST_F(PackageHashStoreComponentTest, SetAndGetHostHash)
{
    PackageHashStore store;
    store.SetHostCommonSinkPackHashValue("pkg", "host");
    EXPECT_EQ(store.GetHostCommonSinkPackHashValue("pkg"), "host");
}

TEST_F(PackageHashStoreComponentTest, SetAndGetDeviceHash)
{
    PackageHashStore store;
    store.SetDeviceCommonSinkPackHashValue("pkg", "device");
    EXPECT_EQ(store.GetDeviceCommonSinkPackHashValue("pkg"), "device");
}

TEST_F(PackageHashStoreComponentTest, SameHashReturnsTrue)
{
    PackageHashStore store;
    store.SetHostCommonSinkPackHashValue("pkg", "same");
    store.SetDeviceCommonSinkPackHashValue("pkg", "same");
    EXPECT_TRUE(store.IsCommonSinkHostAndDevicePkgSame("pkg"));
}

TEST_F(PackageHashStoreComponentTest, DifferentHashReturnsFalse)
{
    PackageHashStore store;
    store.SetHostCommonSinkPackHashValue("pkg", "host");
    store.SetDeviceCommonSinkPackHashValue("pkg", "device");
    EXPECT_FALSE(store.IsCommonSinkHostAndDevicePkgSame("pkg"));
}

TEST_F(PackageHashStoreComponentTest, EmptyHashesAreNotSame)
{
    PackageHashStore store;
    EXPECT_FALSE(store.IsCommonSinkHostAndDevicePkgSame("pkg"));
}

TEST_F(PackageHashStoreComponentTest, ClearRemovesHostAndDeviceHashes)
{
    PackageHashStore store;
    store.SetHostCommonSinkPackHashValue("pkg", "host");
    store.SetDeviceCommonSinkPackHashValue("pkg", "device");
    store.Clear();
    EXPECT_TRUE(store.GetHostCommonSinkPackHashValue("pkg").empty());
    EXPECT_TRUE(store.GetDeviceCommonSinkPackHashValue("pkg").empty());
}

TEST_F(PackageHashStoreComponentTest, StoreAllAcceptsConfigResponse)
{
    PackageHashStore store;
    HDCMessage msg;
    msg.set_type(HDCMessage::TSD_UPDATE_PACKAGE_PROCESS_CONFIG_RSP);
    auto* info = msg.add_package_hash_code_list();
    info->set_package_name("pkg");
    info->set_hash_code("hash");
    store.StoreAllPkgHashValue(msg);
    EXPECT_EQ(store.GetDeviceCommonSinkPackHashValue("pkg"), "hash");
}

TEST_F(PackageHashStoreComponentTest, StoreAllAcceptsNormalCheckCodeResponse)
{
    PackageHashStore store;
    HDCMessage msg;
    msg.set_type(HDCMessage::TSD_GET_DEVICE_PACKAGE_CHECKCODE_NORMAL_RSP);
    auto* info = msg.add_package_hash_code_list();
    info->set_package_name("pkg");
    info->set_hash_code("hash");
    store.StoreAllPkgHashValue(msg);
    EXPECT_EQ(store.GetDeviceCommonSinkPackHashValue("pkg"), "hash");
}

TEST_F(PackageHashStoreComponentTest, StoreAllIgnoresUnrelatedResponse)
{
    PackageHashStore store;
    HDCMessage msg;
    msg.set_type(HDCMessage::TSD_START_PROC_MSG);
    auto* info = msg.add_package_hash_code_list();
    info->set_package_name("pkg");
    info->set_hash_code("hash");
    store.StoreAllPkgHashValue(msg);
    EXPECT_TRUE(store.GetDeviceCommonSinkPackHashValue("pkg").empty());
}
