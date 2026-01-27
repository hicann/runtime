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
#include "msprof_dlog.h"
#include "prof_acl_plugin.h"
#include "prof_plugin.h"
#include "prof_atls_plugin.h"
#include "prof_api.h"
#include "prof_inner_api.h"
#include "prof_tx_plugin.h"
#include "prof_cann_plugin.h"
#include "errno/error_code.h"
#include "prof_plugin_manager.h"
#include "platform/platform.h"
#include "mmpa_api.h"
#include "acl/acl_prof.h"
#include "msprofiler_acl_api.h"
#include "prof_acl_mgr.h"
#include "msprofiler_impl.h"

extern "C" {
extern Msprofiler::AclApi::ProfCreateTransportFunc ProfCreateParsertransport();
extern void ProfRegisterTransport(Msprofiler::AclApi::ProfCreateTransportFunc callback);
}

using namespace analysis::dvvp::common::error;
class MSPROFILER_ADAPTER_UTEST : public testing::Test {
protected:
    virtual void SetUp() {
    }
    virtual void TearDown() {
      GlobalMockObject::verify();
    }
};

TEST_F(MSPROFILER_ADAPTER_UTEST, PROF_OP_SUBSCRIBE)
{
  MOCKER(&Msprofiler::Api::ProfAclMgr::ProfStartAclSubscribe)
    .stubs()
    .will(returnValue(ACL_SUCCESS));

  EXPECT_EQ(ACL_ERROR_INVALID_PARAM, ProfOpSubscribe(0, nullptr));
  aclprofSubscribeConfig config;
  config.config.timeInfo = true;
  config.config.aicoreMetrics = PROF_AICORE_ARITHMETIC_UTILIZATION;
  EXPECT_EQ(ACL_ERROR_NONE, ProfOpSubscribe(0, &config));
}

TEST_F(MSPROFILER_ADAPTER_UTEST, PROF_OP_UNSUBSCRIBE)
{
  MOCKER(&Msprofiler::Api::ProfAclMgr::IsModelSubscribed)
    .stubs()
    .will(returnValue(false))
    .then(returnValue(true));

  EXPECT_EQ(ACL_ERROR_PROFILING_FAILURE, ProfOpUnSubscribe(0));
  EXPECT_EQ(ACL_ERROR_NONE, ProfOpUnSubscribe(0));
}

TEST_F(MSPROFILER_ADAPTER_UTEST, PROF_ACL_SUBSCRIBE)
{
  ProfRegisterTransport(ProfCreateParsertransport());
  EXPECT_EQ(ACL_ERROR_INVALID_MODEL_ID, ProfAclSubscribe(0, 0, nullptr));
}
