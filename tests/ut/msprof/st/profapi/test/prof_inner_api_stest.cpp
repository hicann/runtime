/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <dlfcn.h>
#include "mockcpp/mockcpp.hpp"
#include "gtest/gtest.h"
#include "msprof_dlog.h"
#include "prof_plugin.h"
#include "prof_cann_plugin.h"
#include "prof_api.h"
#include "prof_inner_api.h"
#ifdef PROF_API_STUB
extern void profOstreamStub(void);
#endif
class PROF_INNER_API_STEST : public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown() {}
};


int32_t ProfOpSubscribeStub(uint32_t devId, const PROFAPI_SUBSCRIBECONFIG_CONST_PTR profSubscribeConfig) { return 0; }
int32_t ProfOpUnSubscribeStub(uint32_t devId, const PROFAPI_SUBSCRIBECONFIG_CONST_PTR profSubscribeConfig) { return 0; }
std::map<std::string, void*> g_SubscribeMap = {
    {"ProfOpUnSubscribe", (void *)ProfOpUnSubscribeStub},
    {"ProfOpSubscribe", (void *)ProfOpSubscribeStub}
};

void *mmDlsymStub(void *handle, const char* funcName)
{
    auto it = g_SubscribeMap.find(funcName);
    if (it != g_SubscribeMap.end()) {
        return it->second;
    }
    return nullptr;
}

TEST_F(PROF_INNER_API_STEST, PROF_INNER_API)
{
  MOCKER(dlsym).stubs().will(invoke(mmDlsymStub));
  uint32_t devId = 0;
  uint32_t streamId = 1;
  EXPECT_EQ(0, ProfOpSubscribe(devId, nullptr));
  EXPECT_EQ(0, ProfOpUnSubscribe(devId));
}
