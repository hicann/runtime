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

#include "ide_daemon_dev.h"
#include "ide_daemon_hdc.h"
#include "hdc_api.h"
#include "ide_daemon_stub.h"

extern"C"{
extern void IdeDeviceStateNotifierRegister(int (*ide_dev_state_notifier)(devdrv_state_info_t *stateIfo));
}

class IDE_DAEMON_DEV_UTEST: public testing::Test {
protected:
	virtual void SetUp() {
	
	}
	virtual void TearDown() {
        GlobalMockObject::verify();
	}
};

int ide_dev_state_notifier(devdrv_state_info_t *state_info){
    return 0;
}

TEST_F(IDE_DAEMON_DEV_UTEST, IdeDeviceStateNotifierRegister)
{
    IdeDeviceStateNotifierRegister(ide_dev_state_notifier);
    IdeDeviceStateNotifierRegister(ide_dev_state_notifier);
    EXPECT_TRUE(g_ideInfo.devStateNotify.callbacks[0] != NULL);
    IdeDevStateNotifySetFlag(0, 1);
    EXPECT_EQ(1, g_ideInfo.devStateNotify.flag[0]);
    EXPECT_FALSE(IdeDevStateNotifyIsAllFlagSet());
}

