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
#include "prof_plugin.h"
#include "prof_cann_plugin.h"
#include "prof_atls_plugin.h"
#include "prof_api.h"
#include "prof_inner_api.h"
#include "mmpa_api.h"
#include "platform/platform.h"
#ifdef PROF_API_STUB
extern void profOstreamStub(void);
#endif
class PROF_API_STTEST : public testing::Test {
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
    virtual void SetUp() {}
    virtual void TearDown() {}
};

int32_t profInitStub(uint32_t moduleId, void *data, uint32_t dataLen)
{
  return 0;
}

int32_t profRegisterCallbackStub(uint32_t moduleId, ProfCommandHandle handle)
{
  return 0;
}

int32_t profStartStub(uint32_t deviceId, bool isOpen)
{
  return 0;
}

int32_t profReportDataStub(uint32_t moduleId, uint32_t type, void* data, uint32_t len)
{
  return 0;
}

int32_t profSetDeviceIdByGeModelIdxStub(const uint32_t geModelIdx, const uint32_t deviceId)
{
  return 0;
}

int32_t profUnsetDeviceIdByGeModelIdxStub(const uint32_t geModelIdx, const uint32_t deviceId)
{
  return 0;
}

int32_t profNotifySetDeviceStub(uint32_t chipId, uint32_t deviceId, bool isOpen)
{
  return 0;
}

int32_t profSetDeviceStub(void *data, uint32_t len)
{
  return 0;
}

int32_t profFinalizeStub()
{
  return 0;
}

int32_t profAclInitStub(uint32_t type, const char *profilerPath, uint32_t len)
{
  return 0;
}

int32_t profAclStartStub(uint32_t type, PROFAPI_CONFIG_CONST_PTR profilerConfig)
{
  return 0;
}

int32_t profAclStopStub(uint32_t type, PROFAPI_CONFIG_CONST_PTR profilerConfig)
{
  return 0;
}

int32_t profAclFinalizeStub(uint32_t type)
{
  return 0;
}

int32_t ProfAclSetConfigStub(uint32_t configType, const char *config, size_t configLength)
{
  return 0;
}

int32_t profAclSubscribeStub(uint32_t type, uint32_t modelId, PROFAPI_SUBSCRIBECONFIG_CONST_PTR config)
{
  return 0;
}

int32_t profAclUnSubscribeStub(uint32_t type, uint32_t modelId)
{
  return 0;
}

int32_t profAclDrvGetDevNumStub()
{
  return 0;
}

int64_t profAclGetOpTimeStub(uint32_t type, const void *opInfo, size_t opInfoLen, uint32_t index)
{
  return 0;
}

int32_t profAclGetIdStub(uint32_t type, const void *opInfo, size_t opInfoLen, uint32_t index)
{
  return 0;
}

int32_t profAclGetOpValStub(uint32_t type, const void *opInfo, size_t opInfoLen,
                                      uint32_t index, void *data, size_t len)
{
  return 0;
}

uint64_t ProfGetOpExecutionTimeStub(const void *data, uint32_t len, uint32_t index)
{
  return 0;
}

void* profAclCreateStampStub()
{
  return nullptr;
}

int32_t profAclDestroyStampStub(VOID_PTR stamp)
{
  return 0;
}

int32_t profAclPushStub(VOID_PTR stamp)
{
  return 0;
}

int32_t profAclPopStub()
{
  return 0;
}

int32_t profAclRangeStartStub(VOID_PTR stamp, uint32_t *rangeId)
{
  return 0;
}

int32_t profAclRangeStopStub(uint32_t rangeId)
{
  return 0;
}

int32_t profAclSetStampTraceMessageStub(VOID_PTR stamp, const char *msg, uint32_t msgLen)
{
  return 0;
}

int32_t profAclMarkStub(VOID_PTR stamp)
{
  return 0;
}

int32_t profAclSetCategoryNameStub(uint32_t category, const char *categoryName)
{
  return 0;
}

int32_t profAclSetStampCategoryStub(VOID_PTR stamp, uint32_t category)
{
  return 0;
}

int32_t profAclSetStampPayloadStub(VOID_PTR stamp, const int32_t type, VOID_PTR value)
{
  return 0;
}

int32_t profAclGetCompatibleFeatureStub(size_t *featuresSize, void **featuresData)
{
  return 0;
}

#ifdef PROF_API_STUB
int ProfApiSutb(void)
{
   profOstreamStub();
   return 0;
}
#endif

int ProfApiInitStub(void)
{
   ProfAPI::ProfCannPlugin::instance()->ProfApiInit();
   return 0;
}

int32_t TestCallbackHandle1(uint32_t dataType, void *data, uint32_t dataLen) { return 0; };
TEST_F(PROF_API_STTEST, ProfCannAtlasRegisterCallback)
{
    MsprofCommandHandle command1;
    command1.type = PROF_COMMANDHANDLE_TYPE_INIT;
    auto data1 = reinterpret_cast<void *>(&command1);
    auto cnt = ProfAPI::ProfAtlsPlugin::instance()->moduleCallbacks_.size();
    EXPECT_EQ(0, ProfAPI::ProfCannPlugin::instance()->ProfRegisterCallback(0, &TestCallbackHandle1));
    EXPECT_EQ(0, ProfAPI::ProfAtlsPlugin::instance()->ProfRegisterCallback(1, &TestCallbackHandle1));
    EXPECT_EQ(ProfAPI::ProfAtlsPlugin::instance()->moduleCallbacks_.size(), cnt + 2);
}

TEST_F(PROF_API_STTEST, PROF_API_INIT)
{
  GlobalMockObject::verify();
  MOCKER_CPP(mmDlopen).stubs().will(returnValue((void*) 0));
  EXPECT_EQ(0, ProfApiInitStub());
}

TEST_F(PROF_API_STTEST, PROF_API)
{
  GlobalMockObject::verify();
  mockReportBufInit();
  EXPECT_EQ(0, MsprofInit(0xff, nullptr, 0));
  const std::string data = "{\"switch\":\"on\"}";
  const char *p = data.c_str();
  const std::string data1 = "{\"switch\":\"on\"},";
  const char *p1 = data1.c_str();
  int32_t stub = 123456;
  uint32_t devid = 0;
  void *handle = (void*)&stub;
#ifdef PROF_API_STUB
 EXPECT_EQ(0, ProfApiSutb());
#endif 
  MOCKER(mmDlopen).stubs().will(returnValue(handle));
  MOCKER(mmDlclose).stubs().will(returnValue(0));
  MOCKER(dlopen).stubs().will(returnValue(handle));
  MOCKER(dlclose).stubs().will(returnValue(0));
  MOCKER(mmDlsym).times(1).will(returnValue((void *)profInitStub));
  MOCKER(mmDlsym).times(2).will(returnValue((void *)profRegisterCallbackStub));
  MOCKER(mmDlsym).times(3).will(returnValue((void *)profReportDataStub));
  MOCKER(mmDlsym).times(4).will(returnValue((void *)profSetDeviceIdByGeModelIdxStub));
  MOCKER(mmDlsym).times(5).will(returnValue((void *)profNotifySetDeviceStub));
  MOCKER(mmDlsym).times(6).will(returnValue((void *)profFinalizeStub));
  MOCKER(mmDlsym).times(7).will(returnValue((void *)profUnsetDeviceIdByGeModelIdxStub));
  MOCKER(mmDlsym).times(8).will(returnValue((void *)profAclInitStub));
  MOCKER(mmDlsym).times(9).will(returnValue((void *)profAclStartStub));
  MOCKER(mmDlsym).times(10).will(returnValue((void *)profAclStopStub));
  MOCKER(mmDlsym).times(11).will(returnValue((void *)profAclFinalizeStub));
  MOCKER(mmDlsym).times(11).will(returnValue((void *)ProfAclSetConfigStub));
  MOCKER(mmDlsym).times(12).will(returnValue((void *)profAclSubscribeStub));
  MOCKER(mmDlsym).times(13).will(returnValue((void *)profAclDrvGetDevNumStub));
  MOCKER(mmDlsym).times(14).will(returnValue((void *)profAclGetOpTimeStub));
  MOCKER(mmDlsym).times(14).will(returnValue((void *)profAclGetIdStub));
  MOCKER(mmDlsym).times(14).will(returnValue((void *)profAclGetOpValStub));
  MOCKER(mmDlsym).times(14).will(returnValue((void *)ProfGetOpExecutionTimeStub));
  MOCKER(mmDlsym).times(14).will(returnValue((void *)profAclUnSubscribeStub));
  MOCKER(dlsym).times(1).will(returnValue((void *)profAclCreateStampStub));
  MOCKER(dlsym).times(2).will(returnValue((void *)profAclDestroyStampStub));
  MOCKER(dlsym).times(3).will(returnValue((void *)profAclPushStub));
  MOCKER(dlsym).times(4).will(returnValue((void *)profAclPopStub));
  MOCKER(dlsym).times(5).will(returnValue((void *)profAclRangeStartStub));
  MOCKER(dlsym).times(6).will(returnValue((void *)profAclRangeStopStub));
  MOCKER(dlsym).times(7).will(returnValue((void *)profAclSetStampTraceMessageStub));
  MOCKER(dlsym).times(8).will(returnValue((void *)profAclMarkStub));
  MOCKER(dlsym).times(9).will(returnValue((void *)profAclSetCategoryNameStub));
  MOCKER(dlsym).times(10).will(returnValue((void *)profAclSetStampCategoryStub));
  MOCKER(dlsym).times(11).will(returnValue((void *)profAclSetStampPayloadStub));
  MOCKER(dlsym).times(12).will(returnValue((void *)profAclGetCompatibleFeatureStub));

  EXPECT_EQ(-1, MsprofRegisterCallback(0, nullptr));
  EXPECT_EQ(0, MsprofNotifySetDevice(0, 0, true));
  EXPECT_EQ(0, MsprofSetDeviceIdByGeModelIdx(0, 0));
  EXPECT_EQ(0, MsprofUnsetDeviceIdByGeModelIdx(0, 0));
  EXPECT_EQ(0, MsprofInit(1, (void*)p1, data1.size()));
  EXPECT_EQ(0, MsprofInit(1, (void*)p, data.size()));
  EXPECT_EQ(0, MsprofSetConfig(0, nullptr, 0));
  EXPECT_EQ(-1, MsprofRegisterCallback(0, nullptr));
  EXPECT_EQ(0, MsprofNotifySetDevice(0, 0, true));
  EXPECT_EQ(0, MsprofSetDeviceIdByGeModelIdx(0, 0));
  EXPECT_EQ(0, MsprofUnsetDeviceIdByGeModelIdx(0, 0));
  EXPECT_EQ(0, MsprofReportData(0, 0, nullptr, 0));
  EXPECT_EQ(-1, MsprofReportApi(0, nullptr));
  EXPECT_EQ(-1, MsprofReportEvent(0, nullptr));
  MsprofApi api;
  MsprofEvent event;
  EXPECT_EQ(6, MsprofReportApi(0, &api));
  EXPECT_EQ(6, MsprofReportEvent(0, &event));
  EXPECT_EQ(-1, MsprofReportCompactInfo(0, nullptr, 0));
  EXPECT_EQ(-1, MsprofReportAdditionalInfo(0, nullptr, 0));
  MsprofCompactInfo compactInfo;
  MsprofAdditionalInfo additionalInfo;
  EXPECT_EQ(6, MsprofReportCompactInfo(0, &compactInfo, sizeof(MsprofCompactInfo)));
  EXPECT_EQ(6, MsprofReportAdditionalInfo(0, &additionalInfo, sizeof(MsprofAdditionalInfo)));
  EXPECT_EQ(0, MsprofRegTypeInfo(0, 0, "test"));
  EXPECT_EQ(0, MsprofGetHashId("test get hash id", 16));
  EXPECT_EQ(0, MsprofStr2Id("test get hash id", 16));
  EXPECT_EQ(std::numeric_limits<uint64_t>::max(), MsprofGetHashId(nullptr, 0));
  EXPECT_EQ(0, MsprofFinalize());

  EXPECT_EQ(0, ProfAclInit(0, nullptr, 0));
  EXPECT_EQ(0, ProfAclStart(0, 0));
  EXPECT_EQ(0, MsprofReportData (0, 0, nullptr, 0));
  EXPECT_EQ(0, ProfAclStart(0, nullptr));
  EXPECT_EQ(0, ProfAclStop(0, nullptr));
  EXPECT_EQ(0, ProfAclFinalize(0));
  EXPECT_EQ(0, ProfAclSetConfig(0, nullptr, 0));
  EXPECT_EQ(0, ProfAclSubscribe(0, 0, nullptr));
  EXPECT_EQ(0, ProfAclDrvGetDevNum());
  EXPECT_EQ(0, ProfAclGetOpTime(0, nullptr, 0, 0));
  EXPECT_EQ(0, ProfAclGetId(0, nullptr, 0, 0));
  EXPECT_EQ(0, ProfAclGetOpVal(0, nullptr, 0, 0, nullptr, 0));
  EXPECT_EQ(0, ProfGetOpExecutionTime(nullptr, 0, 0));
  EXPECT_EQ(0, ProfAclUnSubscribe(0, 0));

  EXPECT_EQ(nullptr, ProfAclCreateStamp());
  EXPECT_EQ(0, ProfAclMarkEx(nullptr, 0, nullptr));
  ProfAclDestroyStamp(nullptr);
  EXPECT_EQ(0, ProfAclPush(nullptr));
  EXPECT_EQ(0, ProfAclPop());
  EXPECT_EQ(0, ProfAclRangeStart(nullptr, nullptr));
  EXPECT_EQ(0, ProfAclRangeStop(0));
  EXPECT_EQ(0, ProfAclSetStampTraceMessage(nullptr, nullptr, 0));
  EXPECT_EQ(0, ProfAclMark(nullptr));
  EXPECT_EQ(0, ProfAclSetCategoryName(0, nullptr));
  EXPECT_EQ(0, ProfAclSetStampCategory(nullptr, 0));
  EXPECT_EQ(0, ProfAclSetStampPayload(nullptr, 0, nullptr));
  EXPECT_EQ(0, ProfAclGetCompatibleFeatures(nullptr, nullptr));

  EXPECT_EQ(0, profRegReporterCallback(&profReportDataStub));
  EXPECT_EQ(0, profRegCtrlCallback(&profInitStub));
  EXPECT_EQ(0, profRegDeviceStateCallback(&profSetDeviceStub));
  EXPECT_EQ(0, profSetProfCommand(nullptr, 0));
  EXPECT_EQ(-1, profSetStepInfo(0, 0, nullptr));
  EXPECT_EQ(0, MsprofInit(1, (void*)p1, data1.size()));
  EXPECT_EQ(0, MsprofInit(1, (void*)p, data.size()));
  EXPECT_EQ(-1, MsprofRegisterCallback(0, nullptr));
  EXPECT_EQ(0, MsprofReportData(0, 0, nullptr, 0));
  EXPECT_EQ(0, MsprofSetDeviceIdByGeModelIdx(0, 0));
  EXPECT_EQ(0, profGetDeviceIdByGeModelIdx(0, &devid));
  EXPECT_EQ(0, MsprofUnsetDeviceIdByGeModelIdx(0, 0));
  EXPECT_EQ(0, MsprofNotifySetDevice(0, 0, true));
  EXPECT_EQ(0, MsprofFinalize());
  EXPECT_EQ(0, MsprofStart(0, nullptr, 0));
  EXPECT_EQ(0, MsprofStop(0, nullptr, 0));
  EXPECT_NE(0, MsprofSysCycleTime());
}
