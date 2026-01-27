/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "aicpu_pulse.h"
#include "gtest/gtest.h"

namespace aicpu {
    namespace pulse {
        class AicpuPulseUt : public ::testing::Test {
        protected:
            static void StubPulseNotify()
            {
                isNotified = true;
            }

        protected:
            static bool isNotified;
        };

        bool AicpuPulseUt::isNotified = false;

        TEST_F(AicpuPulseUt, AicpuPulseTest)
        {
            auto ret = RegisterPulseNotifyFunc(nullptr, AicpuPulseUt::StubPulseNotify);
            EXPECT_NE(ret, 0);

            ret = RegisterPulseNotifyFunc("test1", nullptr);
            EXPECT_NE(ret, 0);

            AicpuPulseNotify();
            EXPECT_FALSE(isNotified);

            ret = RegisterPulseNotifyFunc("test2", AicpuPulseUt::StubPulseNotify);
            EXPECT_EQ(ret, 0);

            AicpuPulseNotify();
            EXPECT_TRUE(isNotified);

            // repeat register
            ret = RegisterPulseNotifyFunc("test2", AicpuPulseUt::StubPulseNotify);
            EXPECT_NE(ret, 0);
        }

    }
}


