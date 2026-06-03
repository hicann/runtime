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
// ProfIsInited / ProfGetResultPath are declared in msprofiler_adaptor.h, but that header cannot be
// included here because it declares ProfAclInit/Start/... as extern "C" with ProfType params, which
// conflicts with the uint32_t-param declarations already pulled in via prof_inner_api.h. Declare
// them locally, matching the existing pattern above for transport functions.
extern bool ProfIsInited();
extern int32_t ProfGetResultPath(char *path, uint32_t len);
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

TEST_F(MSPROFILER_ADAPTER_UTEST, PROF_CHECKOPSWITCH_TYPE_NOT_ZERO)
{
  EXPECT_EQ(false, Analysis::Dvvp::ProfilerCommon::ProfCheckOpSwitch(1, nullptr, 0));
  EXPECT_EQ(false, Analysis::Dvvp::ProfilerCommon::ProfCheckOpSwitch(1, "MatMul", 6));
  EXPECT_EQ(false, Analysis::Dvvp::ProfilerCommon::ProfCheckOpSwitch(2, "Add", 3));
  EXPECT_EQ(false, Analysis::Dvvp::ProfilerCommon::ProfCheckOpSwitch(UINT32_MAX, "Relu", 4));
}

TEST_F(MSPROFILER_ADAPTER_UTEST, PROF_CHECKOPSWITCH_NULLPTR_OP)
{
  EXPECT_EQ(false, Analysis::Dvvp::ProfilerCommon::ProfCheckOpSwitch(0, nullptr, 0));
  EXPECT_EQ(false, Analysis::Dvvp::ProfilerCommon::ProfCheckOpSwitch(0, nullptr, 6));
}

TEST_F(MSPROFILER_ADAPTER_UTEST, PROF_CHECKOPSWITCH_ZERO_LEN)
{
  const char *op = "MatMul";
  EXPECT_EQ(false, Analysis::Dvvp::ProfilerCommon::ProfCheckOpSwitch(0, op, 0));
  EXPECT_EQ(false, Analysis::Dvvp::ProfilerCommon::ProfCheckOpSwitch(0, "Add", 0));
}

TEST_F(MSPROFILER_ADAPTER_UTEST, PROF_CHECKOPSWITCH_EMPTY_CONFIG)
{
  MOCKER(&Msprofiler::Api::ProfAclMgr::GetOpTypeConfig)
    .stubs()
    .will(returnValue(std::string("")));
  
  const char *op = "MatMul";
  EXPECT_EQ(false, Analysis::Dvvp::ProfilerCommon::ProfCheckOpSwitch(0, op, 6));
  EXPECT_EQ(false, Analysis::Dvvp::ProfilerCommon::ProfCheckOpSwitch(0, "Add", 3));
}

TEST_F(MSPROFILER_ADAPTER_UTEST, PROF_CHECKOPSWITCH_OP_IN_CONFIG)
{
  MOCKER(&Msprofiler::Api::ProfAclMgr::GetOpTypeConfig)
    .stubs()
    .will(returnValue(std::string("MatMul,Add,Relu")));
  
  EXPECT_EQ(true, Analysis::Dvvp::ProfilerCommon::ProfCheckOpSwitch(0, "MatMul", 6));
  EXPECT_EQ(true, Analysis::Dvvp::ProfilerCommon::ProfCheckOpSwitch(0, "Add", 3));
  EXPECT_EQ(true, Analysis::Dvvp::ProfilerCommon::ProfCheckOpSwitch(0, "Relu", 4));
}

TEST_F(MSPROFILER_ADAPTER_UTEST, PROF_CHECKOPSWITCH_OP_NOT_IN_CONFIG)
{
  MOCKER(&Msprofiler::Api::ProfAclMgr::GetOpTypeConfig)
    .stubs()
    .will(returnValue(std::string("MatMul,Add")));
  
  EXPECT_EQ(false, Analysis::Dvvp::ProfilerCommon::ProfCheckOpSwitch(0, "Relu", 4));
  EXPECT_EQ(false, Analysis::Dvvp::ProfilerCommon::ProfCheckOpSwitch(0, "Conv2D", 6));
  EXPECT_EQ(false, Analysis::Dvvp::ProfilerCommon::ProfCheckOpSwitch(0, "Softmax", 7));
}

TEST_F(MSPROFILER_ADAPTER_UTEST, PROF_CHECKOPSWITCH_SINGLE_OP_CONFIG)
{
  MOCKER(&Msprofiler::Api::ProfAclMgr::GetOpTypeConfig)
    .stubs()
    .will(returnValue(std::string("MatMul")));
  
  EXPECT_EQ(true, Analysis::Dvvp::ProfilerCommon::ProfCheckOpSwitch(0, "MatMul", 6));
  EXPECT_EQ(false, Analysis::Dvvp::ProfilerCommon::ProfCheckOpSwitch(0, "Add", 3));
}

TEST_F(MSPROFILER_ADAPTER_UTEST, PROF_IS_INITED)
{
  // ProfIsInited passes through ProfAclMgr::IsInited().
  MOCKER(&Msprofiler::Api::ProfAclMgr::IsInited)
    .stubs()
    .will(returnValue(true))
    .then(returnValue(false));

  EXPECT_EQ(true, ProfIsInited());
  EXPECT_EQ(false, ProfIsInited());
}

TEST_F(MSPROFILER_ADAPTER_UTEST, PROF_GET_RESULT_PATH_NORMAL)
{
  // Normal: result path fits into the buffer, copied out and returns success.
  MOCKER(&Msprofiler::Api::ProfAclMgr::GetResultPath)
    .stubs()
    .will(returnValue(std::string("/tmp/prof_result")));

  char buf[64] = {0};
  EXPECT_EQ(PROFILING_SUCCESS, ProfGetResultPath(buf, sizeof(buf)));
  EXPECT_STREQ("/tmp/prof_result", buf);
}

TEST_F(MSPROFILER_ADAPTER_UTEST, PROF_GET_RESULT_PATH_EMPTY)
{
  // Empty result path: returns success with an empty C-string.
  MOCKER(&Msprofiler::Api::ProfAclMgr::GetResultPath)
    .stubs()
    .will(returnValue(std::string("")));

  char buf[64] = {'x', 'y', 'z', '\0'};
  EXPECT_EQ(PROFILING_SUCCESS, ProfGetResultPath(buf, sizeof(buf)));
  EXPECT_EQ('\0', buf[0]);
}

TEST_F(MSPROFILER_ADAPTER_UTEST, PROF_GET_RESULT_PATH_BUFFER_TOO_SMALL)
{
  // Buffer too small: path length >= len must fail without writing out of bounds.
  MOCKER(&Msprofiler::Api::ProfAclMgr::GetResultPath)
    .stubs()
    .will(returnValue(std::string("/tmp/a_long_result_path")));

  char buf[8] = {0};
  EXPECT_EQ(PROFILING_FAILED, ProfGetResultPath(buf, sizeof(buf)));
}
