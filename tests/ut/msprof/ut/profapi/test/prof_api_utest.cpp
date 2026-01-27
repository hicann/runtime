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
#include "acl/acl_prof.h"
#include "prof_inner_api.h"
#include "prof_tx_plugin.h"
#include "prof_cann_plugin.h"
#include "errno/error_code.h"
#include "prof_plugin_manager.h"
#include "platform/platform.h"
#include "mmpa_api.h"
using namespace analysis::dvvp::common::error;
class PROF_API_UTTEST : public testing::Test {
public:
    void mockReportBufInit() {
        MOCKER_CPP(&analysis::dvvp::common::queue::ReportBuffer<MsprofApi>::Init)
          .stubs();
        MOCKER_CPP(&analysis::dvvp::common::queue::ReportBuffer<MsprofCompactInfo>::Init)
          .stubs();
        MOCKER_CPP(&analysis::dvvp::common::queue::ReportBuffer<MsprofAdditionalInfo>::Init)
          .stubs();
    }
protected:
    virtual void SetUp() {
        MOCKER(dlsym).stubs().will(returnValue((void *)nullptr));
    }
    virtual void TearDown() {
        GlobalMockObject::verify();
    }
};

TEST_F(PROF_API_UTTEST, PROF_INIT)
{
  mockReportBufInit();
  EXPECT_EQ(0, MsprofInit(0, nullptr, 0));
  void *handle = (void *)0x1;
  MOCKER(mmDlopen).stubs().will(returnValue(handle));
  EXPECT_EQ(0, MsprofInit(0, nullptr, 0));
}

TEST_F(PROF_API_UTTEST, PROF_SET_CONFIG)
{
    EXPECT_EQ(0, MsprofSetConfig(0, nullptr, 0));
}

int32_t fake_callback2(uint32_t, void *, uint32_t) {return 0;};
TEST_F(PROF_API_UTTEST, PROF_REGISTER_CALLBACK)
{
  EXPECT_EQ(-1, MsprofRegisterCallback(0, nullptr));
  EXPECT_EQ(0, MsprofRegisterCallback(0, &fake_callback2));
}

TEST_F(PROF_API_UTTEST, PROF_NOTIFY_SETDEVICE)
{
  EXPECT_EQ(0, MsprofNotifySetDevice(0, 0, true));
}

TEST_F(PROF_API_UTTEST, PROF_SETSTEPINFO)
{
  EXPECT_EQ(-1, profSetStepInfo(0, 0, nullptr));
}

TEST_F(PROF_API_UTTEST, PROF_REPORT_DATA)
{
  EXPECT_EQ(0, MsprofReportData(0, 0, nullptr, 0));
}

TEST_F(PROF_API_UTTEST, PROF_REPORT_API)
{
    EXPECT_EQ(-1, MsprofReportApi(0, nullptr));
    MsprofApi api;
    EXPECT_EQ(6, MsprofReportApi(0, &api));
}

TEST_F(PROF_API_UTTEST, PROF_REPORT_EVENT)
{
    EXPECT_EQ(-1, MsprofReportEvent(0, nullptr));
    MsprofEvent event;
    EXPECT_EQ(6, MsprofReportEvent(0, &event));
}

TEST_F(PROF_API_UTTEST, PROF_REPORT_COMPACTINFO)
{
    MsprofCompactInfo compactInfo;
    EXPECT_EQ(-1, MsprofReportCompactInfo(0, nullptr, 0));
    EXPECT_EQ(6, MsprofReportCompactInfo(0, &compactInfo, sizeof(compactInfo)));
}

TEST_F(PROF_API_UTTEST, PROF_REPORT_ADDINFO)
{
    MsprofAdditionalInfo additionalInfo;
    EXPECT_EQ(-1, MsprofReportAdditionalInfo(0, nullptr, 0));
    EXPECT_EQ(6, MsprofReportAdditionalInfo(0, &additionalInfo, sizeof(additionalInfo)));
}

TEST_F(PROF_API_UTTEST, PROF_REPORT_REGISTER_TYPE_INFO)
{
    EXPECT_EQ(-1, MsprofRegTypeInfo(0, 0, nullptr));
    EXPECT_EQ(0, MsprofRegTypeInfo(0, 0, "test register type info"));
}

TEST_F(PROF_API_UTTEST, PROF_REPORT_GET_HASH_ID)
{
    std::string info = "test get hash id";
    EXPECT_EQ(0, MsprofGetHashId(info.c_str(), info.length()));
    EXPECT_EQ(0, MsprofGetHashId("hash", 4));
    EXPECT_EQ(std::numeric_limits<uint64_t>::max(), MsprofGetHashId(nullptr, 0));
}

TEST_F(PROF_API_UTTEST, PROF_REPORT_GET_HASH_ID_Str_2_Id)
{
    std::string info = "test get hash id";
    EXPECT_EQ(0, MsprofStr2Id(info.c_str(), info.length()));
    EXPECT_EQ(0, MsprofStr2Id("hash", 4));
    EXPECT_EQ(std::numeric_limits<uint64_t>::max(), MsprofStr2Id(nullptr, 0));
}

TEST_F(PROF_API_UTTEST, PROF_SET_DEVICEID)
{
  EXPECT_EQ(0, MsprofSetDeviceIdByGeModelIdx(0, 0));
}

TEST_F(PROF_API_UTTEST, PROF_GET_DEVICEID)
{
  uint32_t deviceId;
  EXPECT_EQ(PROFILING_FAILED, profGetDeviceIdByGeModelIdx(0, &deviceId));
}

TEST_F(PROF_API_UTTEST, PROF_UNSET_DEVICEID)
{
  EXPECT_EQ(0, MsprofUnsetDeviceIdByGeModelIdx (0, 0));
}

TEST_F(PROF_API_UTTEST, PROF_FINALIZE)
{
  EXPECT_EQ(0, MsprofFinalize());
}

TEST_F(PROF_API_UTTEST, PROF_START_STOP)
{
    EXPECT_EQ(0, MsprofStart(0, nullptr, 0));
    EXPECT_EQ(0, MsprofStop(0, nullptr, 0));
}

TEST_F(PROF_API_UTTEST, PROF_ACLINIT)
{
  MOCKER(dlopen).stubs().will(invoke(mmDlopen));
  VOID_PTR profImplHandle = dlopen("libprofimpl.so", RTLD_LAZY);
  ProfAPI::ProfAclPlugin::instance()->ProfAclApiInit(profImplHandle);
  EXPECT_EQ(0, ProfAclInit(0, nullptr, 0));
}

TEST_F(PROF_API_UTTEST, PROF_ACLSTART)
{
  EXPECT_EQ(0, ProfAclStart(0, nullptr));
}

TEST_F(PROF_API_UTTEST, PROF_ACLSTOP)
{
  EXPECT_EQ(0, ProfAclStop(0, nullptr));
}

TEST_F(PROF_API_UTTEST, PROF_ACLFINALIZE)
{
  EXPECT_EQ(0, ProfAclFinalize(0));
}

TEST_F(PROF_API_UTTEST, PROF_ACLSETCONFIG)
{
  aclprofConfigType configType = ACL_PROF_SYS_HARDWARE_MEM_FREQ;
  std::string config("50");
  EXPECT_EQ(0, ProfAclSetConfig(configType, config.c_str(), config.size()));
}

TEST_F(PROF_API_UTTEST, PROF_ACLGETCOMPATIBLEFEATURES)
{
  size_t size = 0;
  void* dataPtr = nullptr;
  EXPECT_EQ(0, ProfAclGetCompatibleFeatures(&size, &dataPtr));
}

TEST_F(PROF_API_UTTEST, PROF_ACLSUBSCRIBE)
{
  EXPECT_EQ(0, ProfAclSubscribe(0, 0, nullptr));
}

TEST_F(PROF_API_UTTEST, PROF_ACLUNSUBSCRIBE)
{
  EXPECT_EQ(0, ProfAclUnSubscribe(0, 0));
}

TEST_F(PROF_API_UTTEST, PROF_OPSUBSCRIBE)
{
  EXPECT_EQ(0, ProfOpSubscribe(0, nullptr));
}

TEST_F(PROF_API_UTTEST, PROF_OPUNSUBSCRIBE)
{
  EXPECT_EQ(0, ProfOpUnSubscribe(0));
}

TEST_F(PROF_API_UTTEST, PROF_ACLDRVGETDEVNUM)
{
  EXPECT_EQ(-1, ProfAclDrvGetDevNum());
}

TEST_F(PROF_API_UTTEST, PROF_ACLGETOPTIME)
{
  EXPECT_EQ(0, ProfAclGetOpTime(0, nullptr, 0, 0));
}

TEST_F(PROF_API_UTTEST, PROF_ACLGETID)
{
  EXPECT_EQ(0, ProfAclGetId(0, nullptr, 0, 0));
}

TEST_F(PROF_API_UTTEST, PROF_ACLGETOPVAL)
{
  EXPECT_EQ(0, ProfAclGetOpVal(0, nullptr, 0, 0, nullptr, 0));
}

TEST_F(PROF_API_UTTEST, PROF_ACLGETOPEXECTIME)
{
  EXPECT_EQ(0, ProfGetOpExecutionTime(nullptr, 0, 0));
}

TEST_F(PROF_API_UTTEST, PROF_PROFACLCREATESTAMP)
{
  EXPECT_EQ(nullptr, ProfAclCreateStamp());
}

TEST_F(PROF_API_UTTEST, PROF_PROFACLMARKEX)
{
    EXPECT_EQ(PROFILING_FAILED, ProfAclMarkEx(nullptr, 0, nullptr));
}

TEST_F(PROF_API_UTTEST, PROF_PROFACLPUSH)
{
  EXPECT_EQ(PROFILING_FAILED, ProfAclPush(nullptr));
}

TEST_F(PROF_API_UTTEST, PROF_PROFACLPOP)
{
  EXPECT_EQ(PROFILING_FAILED, ProfAclPop());
}

TEST_F(PROF_API_UTTEST, PROF_PROFACLRANGESTART)
{
  uint32_t a = 0;
  EXPECT_EQ(PROFILING_FAILED, ProfAclRangeStart(nullptr, &a));
}

TEST_F(PROF_API_UTTEST, PROF_PROFACLRANGESTOP)
{
  uint32_t a = 0;
  EXPECT_EQ(PROFILING_FAILED, ProfAclRangeStop(a));
}

TEST_F(PROF_API_UTTEST, PROF_PROFACLSETSTAMPTRACEMESSAGE)
{
  const char *p = "hello";
  uint32_t len = 6;
  EXPECT_EQ(PROFILING_FAILED, ProfAclSetStampTraceMessage(nullptr, p, len));
}

TEST_F(PROF_API_UTTEST, PROF_PROFACLMARK)
{
  EXPECT_EQ(PROFILING_FAILED, ProfAclMark(nullptr));
}

TEST_F(PROF_API_UTTEST, PROF_PROFACLSETCATEGORYNAME)
{
  uint32_t category = 0;
  const char *categoryName = "zero";
  EXPECT_EQ(PROFILING_FAILED, ProfAclSetCategoryName(category, categoryName));
}

TEST_F(PROF_API_UTTEST, PROF_PROFACLSETSTAMPCATEGORY)
{
  uint32_t category = 0;
  EXPECT_EQ(PROFILING_FAILED, ProfAclSetStampCategory(nullptr, category));
}

TEST_F(PROF_API_UTTEST, PROF_PROFACLSETSTAMPPAYLOAD)
{
  EXPECT_EQ(PROFILING_FAILED, ProfAclSetStampPayload(nullptr, 0, nullptr));
}

TEST_F(PROF_API_UTTEST, PROF_PROFREGREPORTERCALLBACK)
{
  EXPECT_EQ(PROFILING_SUCCESS, profRegReporterCallback(nullptr));
}

TEST_F(PROF_API_UTTEST, PROF_PROFREGCTRLCALLBACK)
{
  EXPECT_EQ(PROFILING_SUCCESS, profRegCtrlCallback(nullptr));
}

int32_t profHandleStub(void *data, uint32_t len)
{
  return 0;
}

TEST_F(PROF_API_UTTEST, PROF_PROFREGDEVICESTATECALLBACK)
{
  EXPECT_EQ(PROFILING_FAILED, profRegDeviceStateCallback(nullptr));
  EXPECT_EQ(PROFILING_SUCCESS, profRegDeviceStateCallback(&profHandleStub));
}

TEST_F(PROF_API_UTTEST, PROF_PROFSETPROFCOMMAND)
{
  MsprofCommandHandle command;
  command.type = PROF_COMMANDHANDLE_TYPE_MAX;
  auto data = reinterpret_cast<void *>(&command);
  EXPECT_EQ(PROFILING_SUCCESS, profSetProfCommand(data, 0));
}

int32_t profCommandStub(uint32_t type, void *data, uint32_t len)
{
return 0;
}
TEST_F(PROF_API_UTTEST, PROF_ATLS_TEST)
{
  EXPECT_EQ(PROFILING_FAILED, MsprofRegisterCallback(0, nullptr));
  EXPECT_EQ(PROFILING_SUCCESS, MsprofRegisterCallback(0, &profCommandStub));
  EXPECT_EQ(PROFILING_FAILED, profSetStepInfo(0, 0, nullptr));
  EXPECT_EQ(PROFILING_FAILED, MsprofInit(0, nullptr, 0));
  EXPECT_EQ(PROFILING_FAILED, MsprofReportData(0, 0, nullptr, 0));
  EXPECT_EQ(PROFILING_SUCCESS, MsprofSetDeviceIdByGeModelIdx(0, 0));
  EXPECT_EQ(PROFILING_SUCCESS, MsprofUnsetDeviceIdByGeModelIdx(0, 0));
  EXPECT_EQ(PROFILING_SUCCESS, MsprofNotifySetDevice(0, 0, 0));
  EXPECT_EQ(PROFILING_FAILED, MsprofFinalize());
  EXPECT_NE(0, MsprofSysCycleTime());
}
