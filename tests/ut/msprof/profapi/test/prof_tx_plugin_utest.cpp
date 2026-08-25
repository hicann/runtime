/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <condition_variable>
#include <mutex>
#include <sys/wait.h>
#include <thread>
#include <unistd.h>
#include <vector>
#include "mockcpp/mockcpp.hpp"
#include "gtest/gtest.h"
#include "msprof_dlog.h"
#include "prof_acl_plugin.h"
#include "prof_cann_plugin.h"
#include "prof_tx_plugin.h"
#include "prof_runtime_plugin.h"
#include "errno/error_code.h"
#include "mmpa_api.h"
#include "acl/acl_base.h"
#include "runtime/base.h"
#include "utils.h"

using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::utils;
using namespace ProfAPI;
class PROF_TX_UTTEST : public testing::Test {
protected:
    virtual void SetUp()
    {
        MOCKER(dlopen).stubs().will(invoke(mmDlopen));
        MOCKER(dlsym).stubs().will(invoke(mmDlsym));
        MOCKER(dlclose).stubs().will(invoke(mmDlclose));
        MOCKER(dlerror).stubs().will(invoke(mmDlerror));
    }
    virtual void TearDown() { GlobalMockObject::verify(); }
};

TEST_F(PROF_TX_UTTEST, PROF_ACLPOP)
{
    ProfTxPlugin::GetProftxInstance().ProftxApiInit((void*)0x1);
    EXPECT_EQ(PROFILING_FAILED, ProfTxPlugin::GetProftxInstance().ProftxPop());
}

TEST_F(PROF_TX_UTTEST, PROF_PROFACLRANGESTART)
{
    uint32_t rangeId;
    EXPECT_EQ(PROFILING_FAILED, ProfTxPlugin::GetProftxInstance().ProftxRangeStart(nullptr, &rangeId));
}

TEST_F(PROF_TX_UTTEST, PROF_PROFACLRANGESTOP)
{
    uint32_t rangeId;
    EXPECT_EQ(PROFILING_FAILED, ProfTxPlugin::GetProftxInstance().ProftxRangeStop(rangeId));
}

TEST_F(PROF_TX_UTTEST, PROF_PROFACLSETSTAMPTRACEMESSAGE)
{
    const char* message = "hello";
    EXPECT_EQ(PROFILING_FAILED, ProfTxPlugin::GetProftxInstance().ProftxSetStampTraceMessage(nullptr, message, 6));
}

TEST_F(PROF_TX_UTTEST, PROF_PROFACLMARK)
{
    EXPECT_EQ(PROFILING_FAILED, ProfTxPlugin::GetProftxInstance().ProftxMark(nullptr));
}

TEST_F(PROF_TX_UTTEST, PROF_PROFACLSETCATEGORYNAME)
{
    EXPECT_EQ(PROFILING_FAILED, ProfTxPlugin::GetProftxInstance().ProftxSetCategoryName(0, nullptr));
}

TEST_F(PROF_TX_UTTEST, PROF_PROFACLSETSTAMPCATEGORY)
{
    EXPECT_EQ(PROFILING_FAILED, ProfTxPlugin::GetProftxInstance().ProftxSetStampCategory(nullptr, 0));
}

TEST_F(PROF_TX_UTTEST, PROF_PROFACLSETSTAMPPAYLOAD)
{
    EXPECT_EQ(PROFILING_FAILED, ProfTxPlugin::GetProftxInstance().ProftxSetStampPayload(nullptr, 0, nullptr));
}

TEST_F(PROF_TX_UTTEST, PROF_PROFACLCREATESTAMP)
{
    EXPECT_EQ(nullptr, ProfTxPlugin::GetProftxInstance().ProftxCreateStamp());
}

int gFuncRunFlage = 0;
TEST_F(PROF_TX_UTTEST, PROF_ACLPUSH)
{
    EXPECT_EQ(PROFILING_FAILED, ProfTxPlugin::GetProftxInstance().ProftxPush(nullptr));
}

void Fake_ProfAclDestroyStamp(void*) { gFuncRunFlage = 2; }

bool g_profIsInited = false;
int32_t g_reportAdditionalInfoCount = 0;
int32_t g_profDlopenCount = 0;
int32_t g_profIsInitedDlsymCount = 0;

bool FakeProfIsInited() { return g_profIsInited; }

void* FakeProfDlopen(const char*, int32_t mode)
{
    (void)mode;
    ++g_profDlopenCount;
    return g_profDlopenCount == 1 ? nullptr : reinterpret_cast<void*>(0x1);
}

int32_t FakeReportAdditionalInfo(uint32_t, void*, uint32_t)
{
    ++g_reportAdditionalInfoCount;
    return PROFILING_SUCCESS;
}

void* ProfIsInitedDlsym(void*, const char* funcName)
{
    if (std::strcmp(funcName, "ProfIsInited") == 0) {
        ++g_profIsInitedDlsymCount;
        if (g_profIsInitedDlsymCount == 1) {
            return nullptr;
        }
        return reinterpret_cast<void*>(&FakeProfIsInited);
    }
    return mmDlsym(nullptr, funcName);
}

bool HasLogMessageAtLevel(const std::string& logs, const char* message, const char* level)
{
    const size_t messagePos = logs.find(message);
    if (messagePos == std::string::npos) {
        return false;
    }
    const size_t lineBreakPos = logs.rfind('\n', messagePos);
    const size_t lineStartPos = lineBreakPos == std::string::npos ? 0 : lineBreakPos + 1;
    const size_t levelPos = logs.rfind(level, messagePos);
    return levelPos != std::string::npos && levelPos >= lineStartPos;
}

std::mutex g_tensorInfoMutex;
std::vector<uint64_t> g_reportedTensorNodeIds;

int32_t FakeReportTensorInfo(uint32_t, void* infoPtr, uint32_t infoSize)
{
    if (infoPtr == nullptr || infoSize < sizeof(MsprofShapeInfo) + sizeof(uint64_t)) {
        return PROFILING_FAILED;
    }
    const auto* shapeInfo = static_cast<const MsprofShapeInfo*>(infoPtr);
    uint64_t nodeId = 0;
    if (memcpy_s(&nodeId, sizeof(nodeId), shapeInfo->data, sizeof(nodeId)) != EOK) {
        return PROFILING_FAILED;
    }
    const std::lock_guard<std::mutex> lock(g_tensorInfoMutex);
    g_reportedTensorNodeIds.push_back(nodeId);
    return PROFILING_SUCCESS;
}

TEST_F(PROF_TX_UTTEST, PROF_ProfAclDestroyStamp)
{
    GlobalMockObject::verify();
    MOCKER(dlsym).stubs().will(returnValue((void*)&Fake_ProfAclDestroyStamp));
    ProfTxPlugin::GetProftxInstance().ProftxDestroyStamp(nullptr);
    EXPECT_EQ(2, gFuncRunFlage);
}

rtError_t rtProfilerTraceExStub2(uint64_t indexId, uint64_t modelId, uint16_t tagId, rtStream_t stm)
{
    (void)indexId;
    (void)modelId;
    (void)tagId;
    (void)stm;
    return -1;
}

TEST_F(PROF_TX_UTTEST, RuntimePluginBase)
{
    std::shared_ptr<ProfRuntimePlugin> plugin;
    plugin = std::make_shared<ProfRuntimePlugin>();
    // Failed to get api stub[rtProfilerTraceEx] func
    EXPECT_EQ(PROFILING_SUCCESS, plugin->RuntimeApiInit());
    EXPECT_EQ(PROFILING_FAILED, plugin->ProfMarkEx(0, 0, 0, nullptr));
    MOCKER(&ProfRuntimePlugin::GetPluginApiFunc).stubs().will(returnValue((void*)&rtProfilerTraceExStub2));
    EXPECT_EQ(PROFILING_FAILED, plugin->ProfMarkEx(0, 0, 0, nullptr));
    plugin->runtimeLibHandle_ = nullptr;
    plugin->runtimeApiInfoMap_.clear();
}

TEST_F(PROF_TX_UTTEST, ReportCustomTensorInfo_Success)
{
    // 12个tensor需要分3次上报(5 + 5 + 2)，验证单次上报不超过MSPROF_GE_TENSOR_DATA_NUM(5)个
    const int kTensorNum = 12;
    ProfTensor tensors[kTensorNum];
    for (int i = 0; i < kTensorNum; i++) {
        tensors[i].type = i;
        tensors[i].format = i + 1;
        tensors[i].dataType = i + 2;
        tensors[i].shapeDim = 4;
        for (int j = 0; j < 4; j++) {
            tensors[i].shape[j] = j + 1;
        }
    }

    ProfTensorInfo tensorInfo;
    tensorInfo.opNameId = 12345;
    tensorInfo.tensorNum = kTensorNum;
    tensorInfo.tensors = tensors;

    uint64_t timeStampPush = 1000;
    uint64_t timeStampPop = 2000;

    MOCKER(MsprofReportAdditionalInfo).expects(exactly(3)).will(returnValue(PROFILING_SUCCESS));

    EXPECT_EQ(
        PROFILING_SUCCESS,
        ProfTxPlugin::GetProftxInstance().ReportCustomTensorInfo(&tensorInfo, timeStampPush, timeStampPop));
}

TEST_F(PROF_TX_UTTEST, ReportCustomTensorInfo_ZeroTensorNum)
{
    ProfTensorInfo tensorInfo;
    tensorInfo.opNameId = 12345;
    tensorInfo.tensorNum = 0;
    tensorInfo.tensors = nullptr;

    uint64_t timeStampPush = 1000;
    uint64_t timeStampPop = 2000;

    MOCKER(MsprofReportAdditionalInfo).stubs().will(returnValue(PROFILING_SUCCESS));

    EXPECT_EQ(
        PROFILING_SUCCESS,
        ProfTxPlugin::GetProftxInstance().ReportCustomTensorInfo(&tensorInfo, timeStampPush, timeStampPop));
}

TEST_F(PROF_TX_UTTEST, ReportCustomTensorInfo_SingleTensor)
{
    ProfTensor tensor;
    tensor.type = 0;
    tensor.format = 1;
    tensor.dataType = 2;
    tensor.shapeDim = 3;
    for (int j = 0; j < 3; j++) {
        tensor.shape[j] = j + 1;
    }

    ProfTensorInfo tensorInfo;
    tensorInfo.opNameId = 67890;
    tensorInfo.tensorNum = 1;
    tensorInfo.tensors = &tensor;

    uint64_t timeStampPush = 500;
    uint64_t timeStampPop = 1500;

    MOCKER(MsprofReportAdditionalInfo).stubs().will(returnValue(PROFILING_SUCCESS));

    EXPECT_EQ(
        PROFILING_SUCCESS,
        ProfTxPlugin::GetProftxInstance().ReportCustomTensorInfo(&tensorInfo, timeStampPush, timeStampPop));
}

TEST_F(PROF_TX_UTTEST, ReportCustomTensorInfo_ReportFailed)
{
    ProfTensor tensor;
    tensor.type = 0;
    tensor.format = 1;
    tensor.dataType = 2;
    tensor.shapeDim = 2;
    tensor.shape[0] = 10;
    tensor.shape[1] = 20;

    ProfTensorInfo tensorInfo;
    tensorInfo.opNameId = 11111;
    tensorInfo.tensorNum = 1;
    tensorInfo.tensors = &tensor;

    uint64_t timeStampPush = 100;
    uint64_t timeStampPop = 200;

    MOCKER(MsprofReportAdditionalInfo).stubs().will(returnValue(PROFILING_FAILED));

    EXPECT_EQ(
        PROFILING_FAILED,
        ProfTxPlugin::GetProftxInstance().ReportCustomTensorInfo(&tensorInfo, timeStampPush, timeStampPop));
}

TEST_F(PROF_TX_UTTEST, ProftxRangePushEx_NullAttr)
{
    EXPECT_EQ(ACL_ERROR_INVALID_PARAM, ProfTxPlugin::GetProftxInstance().ProftxRangePushEx(nullptr));
}

TEST_F(PROF_TX_UTTEST, ProftxRangePushEx_BadMessageType)
{
    ProfEventAttributes attr;
    attr.messageType = 0xFF; // not MESSAGE_TYPE_TENSOR_INFO
    EXPECT_EQ(PROFILING_FAILED, ProfTxPlugin::GetProftxInstance().ProftxRangePushEx(&attr));
}

TEST_F(PROF_TX_UTTEST, ProftxRangePushEx_Success)
{
    ProfTensor tensor{};
    tensor.shapeDim = 1;
    tensor.shape[0] = 1;
    ProfTensorInfo tensorInfo{};
    tensorInfo.tensorNum = 1;
    tensorInfo.tensors = &tensor;
    ProfEventAttributes attr;
    attr.messageType = MESSAGE_TYPE_TENSOR_INFO;
    attr.message.tensorInfo = &tensorInfo;
    EXPECT_EQ(PROFILING_SUCCESS, ProfTxPlugin::GetProftxInstance().ProftxRangePushEx(&attr));
}

TEST_F(PROF_TX_UTTEST, ProftxRangePop_GetAttrFail)
{
    // After previous PushEx success attr_ is set; force ProfRtsStreamGetAttribute to fail.
    ProfTensor tensor{};
    tensor.shapeDim = 1;
    tensor.shape[0] = 1;
    ProfTensorInfo tensorInfo{};
    tensorInfo.tensorNum = 1;
    tensorInfo.tensors = &tensor;
    ProfEventAttributes attr;
    attr.messageType = MESSAGE_TYPE_TENSOR_INFO;
    attr.message.tensorInfo = &tensorInfo;
    EXPECT_EQ(PROFILING_SUCCESS, ProfTxPlugin::GetProftxInstance().ProftxRangePushEx(&attr));

    MOCKER_CPP(&ProfRuntimePlugin::ProfRtsStreamGetAttribute).stubs().will(returnValue((int32_t)-1));
    EXPECT_EQ(PROFILING_FAILED, ProfTxPlugin::GetProftxInstance().ProftxRangePop());
}

TEST_F(PROF_TX_UTTEST, ProftxRangePop_AdditionalInfoBranch)
{
    ProfTensor tensor{};
    tensor.shapeDim = 1;
    tensor.shape[0] = 4;
    ProfTensorInfo tensorInfo{};
    tensorInfo.opNameId = 1;
    tensorInfo.tensorNum = 1;
    tensorInfo.tensors = &tensor;
    ProfEventAttributes attr;
    attr.messageType = MESSAGE_TYPE_TENSOR_INFO;
    attr.message.tensorInfo = &tensorInfo;
    EXPECT_EQ(PROFILING_SUCCESS, ProfTxPlugin::GetProftxInstance().ProftxRangePushEx(&attr));

    rtStreamAttrValue_t streamAttrValue{};
    streamAttrValue.cacheOpInfoSwitch = 0;
    MOCKER_CPP(&ProfRuntimePlugin::ProfRtsStreamGetAttribute)
        .stubs()
        .with(any(), any(), outBoundP(&streamAttrValue, sizeof(streamAttrValue)))
        .will(returnValue(static_cast<int32_t>(RT_ERROR_NONE)));
    MOCKER_CPP(&ProfCannPlugin::ProfApiInit).stubs();
    MOCKER_CPP(&ProfAclPlugin::IsInited).stubs().will(returnValue(true));
    MOCKER(MsprofReportAdditionalInfo).expects(once()).will(returnValue(PROFILING_SUCCESS));

    EXPECT_EQ(PROFILING_SUCCESS, ProfTxPlugin::GetProftxInstance().ProftxRangePop());
}

TEST_F(PROF_TX_UTTEST, ProftxRangePushPop_KeepsContextIsolatedBetweenThreads)
{
    ProfTensor tensor{};
    tensor.shapeDim = 1;
    tensor.shape[0] = 4;
    ProfTensorInfo mainTensorInfo{};
    mainTensorInfo.opNameId = 101;
    mainTensorInfo.tensorNum = 1;
    mainTensorInfo.tensors = &tensor;
    ProfTensorInfo workerTensorInfo{};
    workerTensorInfo.opNameId = 202;
    workerTensorInfo.tensorNum = 1;
    workerTensorInfo.tensors = &tensor;
    ProfEventAttributes mainAttr{};
    mainAttr.messageType = MESSAGE_TYPE_TENSOR_INFO;
    mainAttr.message.tensorInfo = &mainTensorInfo;
    ProfEventAttributes workerAttr{};
    workerAttr.messageType = MESSAGE_TYPE_TENSOR_INFO;
    workerAttr.message.tensorInfo = &workerTensorInfo;

    rtStreamAttrValue_t streamAttrValue{};
    streamAttrValue.cacheOpInfoSwitch = 0;
    MOCKER_CPP(&ProfRuntimePlugin::ProfRtsStreamGetAttribute)
        .stubs()
        .with(any(), any(), outBoundP(&streamAttrValue, sizeof(streamAttrValue)))
        .will(returnValue(static_cast<int32_t>(RT_ERROR_NONE)));
    MOCKER_CPP(&ProfCannPlugin::ProfApiInit).stubs();
    MOCKER_CPP(&ProfAclPlugin::IsInited).stubs().will(returnValue(true));
    MOCKER(MsprofReportAdditionalInfo).stubs().will(invoke(FakeReportTensorInfo));
    {
        const std::lock_guard<std::mutex> lock(g_tensorInfoMutex);
        g_reportedTensorNodeIds.clear();
    }

    EXPECT_EQ(PROFILING_SUCCESS, ProfTxPlugin::GetProftxInstance().ProftxRangePushEx(&mainAttr));
    std::mutex syncMutex;
    std::condition_variable syncCondition;
    bool workerPushed = false;
    bool mainPopped = false;
    int32_t workerPushRet = PROFILING_FAILED;
    int32_t workerPopRet = PROFILING_FAILED;
    std::thread worker([&]() {
        workerPushRet = ProfTxPlugin::GetProftxInstance().ProftxRangePushEx(&workerAttr);
        {
            const std::lock_guard<std::mutex> lock(syncMutex);
            workerPushed = true;
        }
        syncCondition.notify_one();
        {
            std::unique_lock<std::mutex> lock(syncMutex);
            syncCondition.wait(lock, [&]() { return mainPopped; });
        }
        workerPopRet = ProfTxPlugin::GetProftxInstance().ProftxRangePop();
    });

    {
        std::unique_lock<std::mutex> lock(syncMutex);
        syncCondition.wait(lock, [&]() { return workerPushed; });
    }
    const int32_t mainPopRet = ProfTxPlugin::GetProftxInstance().ProftxRangePop();
    {
        const std::lock_guard<std::mutex> lock(syncMutex);
        mainPopped = true;
    }
    syncCondition.notify_one();
    worker.join();

    EXPECT_EQ(PROFILING_SUCCESS, workerPushRet);
    EXPECT_EQ(PROFILING_SUCCESS, mainPopRet);
    EXPECT_EQ(PROFILING_SUCCESS, workerPopRet);
    const std::vector<uint64_t> expectedNodeIds{101, 202};
    EXPECT_EQ(expectedNodeIds, g_reportedTensorNodeIds);
}

TEST_F(PROF_TX_UTTEST, ProftxRangePop_CacheOpInfoBranchDoesNotCheckProfilingInit)
{
    ProfTensor tensor{};
    tensor.shapeDim = 1;
    tensor.shape[0] = 4;
    ProfTensorInfo tensorInfo{};
    tensorInfo.opNameId = 1;
    tensorInfo.tensorNum = 1;
    tensorInfo.tensors = &tensor;
    ProfEventAttributes attr;
    attr.messageType = MESSAGE_TYPE_TENSOR_INFO;
    attr.message.tensorInfo = &tensorInfo;
    EXPECT_EQ(PROFILING_SUCCESS, ProfTxPlugin::GetProftxInstance().ProftxRangePushEx(&attr));

    rtStreamAttrValue_t streamAttrValue{};
    streamAttrValue.cacheOpInfoSwitch = 1;
    MOCKER_CPP(&ProfRuntimePlugin::ProfRtsStreamGetAttribute)
        .stubs()
        .with(any(), any(), outBoundP(&streamAttrValue, sizeof(streamAttrValue)))
        .will(returnValue(static_cast<int32_t>(RT_ERROR_NONE)));
    MOCKER_CPP(&ProfCannPlugin::ProfApiInit).expects(never());
    MOCKER_CPP(&ProfAclPlugin::IsInited).expects(never());
    MOCKER_CPP(&ProfRuntimePlugin::ProfRtCacheLastTaskOpInfo)
        .expects(once())
        .will(returnValue(static_cast<int32_t>(RT_ERROR_NONE)));

    EXPECT_EQ(PROFILING_SUCCESS, ProfTxPlugin::GetProftxInstance().ProftxRangePop());
}

TEST_F(PROF_TX_UTTEST, ProftxRangePop_SkipCustomInfoWhenProfilingNotInited)
{
    constexpr char childEnv[] = "RUNTIME_PROF_TX_SKIP_LOG_EXEC_CHILD";
    constexpr char childEnvValue[] = "prof_tx_plugin_utest";
    const char* childMode = std::getenv(childEnv);
    if (childMode == nullptr || std::strcmp(childMode, childEnvValue) != 0) {
        ASSERT_EQ(0, setenv(childEnv, childEnvValue, 1));
        const pid_t childPid = fork();
        if (childPid == 0) {
            execl(
                "/proc/self/exe", "prof_api_utest",
                "--gtest_filter=PROF_TX_UTTEST.ProftxRangePop_SkipCustomInfoWhenProfilingNotInited",
                static_cast<char*>(nullptr));
            _exit(127);
        }
        const int32_t unsetRet = unsetenv(childEnv);
        ASSERT_GE(childPid, 0);
        ASSERT_EQ(0, unsetRet);

        int32_t childStatus = 0;
        ASSERT_EQ(waitpid(childPid, &childStatus, 0), childPid);
        ASSERT_TRUE(WIFEXITED(childStatus));
        EXPECT_EQ(0, WEXITSTATUS(childStatus));
        return;
    }

    ProfTensor tensor{};
    tensor.shapeDim = 1;
    tensor.shape[0] = 4;
    ProfTensorInfo tensorInfo{};
    tensorInfo.opNameId = 1;
    tensorInfo.tensorNum = 1;
    tensorInfo.tensors = &tensor;
    ProfEventAttributes attr;
    attr.messageType = MESSAGE_TYPE_TENSOR_INFO;
    attr.message.tensorInfo = &tensorInfo;
    EXPECT_EQ(PROFILING_SUCCESS, ProfTxPlugin::GetProftxInstance().ProftxRangePushEx(&attr));

    rtStreamAttrValue_t streamAttrValue{};
    streamAttrValue.cacheOpInfoSwitch = 0;
    MOCKER_CPP(&ProfRuntimePlugin::ProfRtsStreamGetAttribute)
        .stubs()
        .with(any(), any(), outBoundP(&streamAttrValue, sizeof(streamAttrValue)))
        .will(returnValue(static_cast<int32_t>(RT_ERROR_NONE)));
    MOCKER_CPP(&ProfCannPlugin::ProfApiInit).stubs();
    MOCKER_CPP(&ProfAclPlugin::IsInited).stubs().will(returnValue(false));
    MOCKER(MsprofReportAdditionalInfo).expects(never());

    EXPECT_EQ(PROFILING_SUCCESS, ProfTxPlugin::GetProftxInstance().ProftxRangePop());

    ASSERT_EQ(0, std::fflush(nullptr));
    const pid_t childPid = fork();
    if (childPid == 0) {
        const int32_t pushRet = ProfTxPlugin::GetProftxInstance().ProftxRangePushEx(&attr);
        testing::internal::CaptureStdout();
        testing::internal::CaptureStderr();
        const int32_t popRet = ProfTxPlugin::GetProftxInstance().ProftxRangePop();
        const std::string childSkipLog =
            testing::internal::GetCapturedStdout() + testing::internal::GetCapturedStderr();
        const bool childLoggedWarning =
            HasLogMessageAtLevel(childSkipLog, "skip reporting custom tensor info", "[WARING]");
        _exit(pushRet == PROFILING_SUCCESS && popRet == PROFILING_SUCCESS && childLoggedWarning ? 0 : 1);
    }
    ASSERT_GT(childPid, 0);
    int32_t childStatus = 0;
    ASSERT_EQ(waitpid(childPid, &childStatus, 0), childPid);
    ASSERT_TRUE(WIFEXITED(childStatus));
    EXPECT_EQ(0, WEXITSTATUS(childStatus));
    return;
}

TEST_F(PROF_TX_UTTEST, ProftxRangePop_RecoversAfterLibraryAndSymbolBecomeAvailable)
{
    constexpr char childEnv[] = "RUNTIME_PROF_TX_RECOVERY_EXEC_CHILD";
    constexpr char childEnvValue[] = "prof_tx_plugin_utest";
    const char* childMode = std::getenv(childEnv);
    if (childMode != nullptr && std::strcmp(childMode, childEnvValue) == 0) {
        GlobalMockObject::verify();
        MOCKER(dlopen).stubs().will(invoke(FakeProfDlopen));
        MOCKER(dlsym).stubs().will(invoke(ProfIsInitedDlsym));
        MOCKER(MsprofReportAdditionalInfo).stubs().will(invoke(FakeReportAdditionalInfo));

        g_profDlopenCount = 0;
        g_profIsInitedDlsymCount = 0;
        g_reportAdditionalInfoCount = 0;
        g_profIsInited = true;

        ProfTensor tensor{};
        tensor.shapeDim = 1;
        tensor.shape[0] = 4;
        ProfTensorInfo tensorInfo{};
        tensorInfo.opNameId = 1;
        tensorInfo.tensorNum = 1;
        tensorInfo.tensors = &tensor;
        ProfEventAttributes attr;
        attr.messageType = MESSAGE_TYPE_TENSOR_INFO;
        attr.message.tensorInfo = &tensorInfo;
        EXPECT_EQ(PROFILING_SUCCESS, ProfTxPlugin::GetProftxInstance().ProftxRangePushEx(&attr));

        rtStreamAttrValue_t streamAttrValue{};
        streamAttrValue.cacheOpInfoSwitch = 0;
        MOCKER_CPP(&ProfRuntimePlugin::ProfRtsStreamGetAttribute)
            .stubs()
            .with(any(), any(), outBoundP(&streamAttrValue, sizeof(streamAttrValue)))
            .will(returnValue(static_cast<int32_t>(RT_ERROR_NONE)));

        testing::internal::CaptureStdout();
        testing::internal::CaptureStderr();
        EXPECT_EQ(PROFILING_SUCCESS, ProfTxPlugin::GetProftxInstance().ProftxRangePop());
        const std::string firstSkipLog =
            testing::internal::GetCapturedStdout() + testing::internal::GetCapturedStderr();
        EXPECT_TRUE(HasLogMessageAtLevel(firstSkipLog, "skip reporting custom tensor info", "[WARING]"));
        EXPECT_EQ(1, g_profDlopenCount);
        EXPECT_EQ(0, g_profIsInitedDlsymCount);
        EXPECT_EQ(0, g_reportAdditionalInfoCount);

        EXPECT_EQ(PROFILING_SUCCESS, ProfTxPlugin::GetProftxInstance().ProftxRangePushEx(&attr));
        testing::internal::CaptureStdout();
        testing::internal::CaptureStderr();
        EXPECT_EQ(PROFILING_SUCCESS, ProfTxPlugin::GetProftxInstance().ProftxRangePop());
        const std::string repeatedSkipLog =
            testing::internal::GetCapturedStdout() + testing::internal::GetCapturedStderr();
        EXPECT_TRUE(HasLogMessageAtLevel(repeatedSkipLog, "skip reporting custom tensor info", "[DEBUG]"));
        EXPECT_EQ(2, g_profDlopenCount);
        EXPECT_EQ(1, g_profIsInitedDlsymCount);
        EXPECT_EQ(0, g_reportAdditionalInfoCount);

        EXPECT_EQ(PROFILING_SUCCESS, ProfTxPlugin::GetProftxInstance().ProftxRangePushEx(&attr));
        EXPECT_EQ(PROFILING_SUCCESS, ProfTxPlugin::GetProftxInstance().ProftxRangePop());
        EXPECT_EQ(2, g_profIsInitedDlsymCount);
        EXPECT_EQ(1, g_reportAdditionalInfoCount);
        return;
    }

    // Exec starts with fresh singleton, once, mock, and libc lock state.
    ASSERT_EQ(0, setenv(childEnv, childEnvValue, 1));
    const pid_t childPid = fork();
    if (childPid == 0) {
        execl(
            "/proc/self/exe", "prof_api_utest",
            "--gtest_filter=PROF_TX_UTTEST.ProftxRangePop_RecoversAfterLibraryAndSymbolBecomeAvailable",
            static_cast<char*>(nullptr));
        _exit(127);
    }
    const int32_t unsetRet = unsetenv(childEnv);
    ASSERT_GE(childPid, 0);
    ASSERT_EQ(0, unsetRet);

    int32_t childStatus = 0;
    ASSERT_EQ(waitpid(childPid, &childStatus, 0), childPid);
    ASSERT_TRUE(WIFEXITED(childStatus));
    EXPECT_EQ(0, WEXITSTATUS(childStatus));
}

TEST_F(PROF_TX_UTTEST, ReportCacheOpInfo2RT_MallocFail)
{
    ProfTensor tensor{};
    tensor.shapeDim = 1;
    ProfTensorInfo tensorInfo{};
    tensorInfo.tensorNum = 1;
    tensorInfo.tensors = &tensor;
    MOCKER(&Utils::ProfMalloc).stubs().will(returnValue((void*)nullptr));
    EXPECT_EQ(PROFILING_FAILED, ProfTxPlugin::GetProftxInstance().ReportCacheOpInfo2RT(&tensorInfo));
}

TEST_F(PROF_TX_UTTEST, ReportCacheOpInfo2RT_RtFail)
{
    ProfTensor tensor{};
    tensor.shapeDim = 1;
    tensor.shape[0] = 4;
    ProfTensorInfo tensorInfo{};
    tensorInfo.opNameId = 1;
    tensorInfo.tensorNum = 1;
    tensorInfo.kernelType = 2;
    tensorInfo.blockNums = 3;
    tensorInfo.tensors = &tensor;
    MOCKER_CPP(&ProfRuntimePlugin::ProfRtCacheLastTaskOpInfo).stubs().will(returnValue((int32_t)-1));
    EXPECT_EQ(PROFILING_FAILED, ProfTxPlugin::GetProftxInstance().ReportCacheOpInfo2RT(&tensorInfo));
}

TEST_F(PROF_TX_UTTEST, ReportCacheOpInfo2RT_Success)
{
    ProfTensor tensor{};
    tensor.shapeDim = 1;
    tensor.shape[0] = 4;
    ProfTensorInfo tensorInfo{};
    tensorInfo.opNameId = 1;
    tensorInfo.tensorNum = 1;
    tensorInfo.tensors = &tensor;
    MOCKER_CPP(&ProfRuntimePlugin::ProfRtCacheLastTaskOpInfo).stubs().will(returnValue((int32_t)RT_ERROR_NONE));
    EXPECT_EQ(PROFILING_SUCCESS, ProfTxPlugin::GetProftxInstance().ReportCacheOpInfo2RT(&tensorInfo));
}
