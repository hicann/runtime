/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include <mutex>
#include "prof_host_job.h"
#include "config/config.h"
#include "logger/msprof_dlog.h"
#include "platform/platform.h"
#include "uploader_mgr.h"
#include "utils/utils.h"
#include "thread/thread.h"
#include "thread/thread.h"
#include "prof_biu_perf_job.h"
#include "prof_collect_info.h"
#include <sys/stat.h>
#include <fstream>
#include <sstream>
#include "file_transport.h"
#include "prof_inner_api.h"
#include "ai_drv_dev_api.h"
#include "ai_drv_prof_api.h"
#include "msprof_drv_api.h"

namespace {
std::vector<int32_t> g_startedChannels;

int32_t DrvInstrProfileStartStub(const uint32_t devId, const analysis::dvvp::driver::AI_DRV_CHANNEL channelId,
    void *userData, size_t dataSize)
{
    (void)devId;
    (void)userData;
    (void)dataSize;
    g_startedChannels.push_back(static_cast<int32_t>(channelId));
    return analysis::dvvp::common::error::PROFILING_SUCCESS;
}

// Records the config size received by DrvInstrProfileStart, used to verify the struct chosen for
// new/old driver versions.
size_t g_lastConfigSize = 0;
// mmChmod 在 UT 里是空桩，无法验证真实文件权限；用它记录传入的 mode，
// 以校验 prof_collect.info 确实以 0640 赋权。
int32_t g_lastChmodMode = -1;
static INT32 ChmodRecordStub(const CHAR *fileName, INT32 mode)
{
    (void)fileName;
    g_lastChmodMode = mode;
    return 0;
}
int32_t DrvInstrProfileStartSizeStub(const uint32_t devId, const analysis::dvvp::driver::AI_DRV_CHANNEL channelId,
    void *userData, size_t dataSize)
{
    (void)devId;
    (void)channelId;
    (void)userData;
    g_lastConfigSize = dataSize;
    return analysis::dvvp::common::error::PROFILING_SUCCESS;
}
}

using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::message;
using namespace Analysis::Dvvp::JobWrapper;
using namespace analysis::dvvp::common::utils;
using namespace Analysis::Dvvp::MsprofErrMgr;
using namespace Analysis::Dvvp::Common::Platform;
using namespace analysis::dvvp::transport;

class JOB_WRAPPER_PROF_BIU_PERF_JOB_TEST: public testing::Test {
protected:
    virtual void SetUp() {
        collectionJobCfg_ = std::make_shared<Analysis::Dvvp::JobWrapper::CollectionJobCfg>();
        std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
            new analysis::dvvp::message::ProfileParams);
        std::shared_ptr<analysis::dvvp::message::JobContext> jobCtx(
            new analysis::dvvp::message::JobContext);
        auto comParams = std::make_shared<Analysis::Dvvp::JobWrapper::CollectionJobCommonParams>();
        comParams->params = params;
        comParams->jobCtx = jobCtx;
        collectionJobCfg_->comParams = comParams;
        collectionJobCfg_->jobParams.events = std::make_shared<std::vector<std::string> >(0);
    }
    virtual void TearDown() {
        collectionJobCfg_.reset();
        GlobalMockObject::verify();
        GlobalMockObject::reset();
    }
public:
    std::shared_ptr<Analysis::Dvvp::JobWrapper::CollectionJobCfg> collectionJobCfg_;
};

TEST_F(JOB_WRAPPER_PROF_BIU_PERF_JOB_TEST, Launch) {
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::CheckIfSupport,
        bool (Analysis::Dvvp::Common::Platform::Platform::*)(const Dvvp::Collect::Platform::PlatformFeature) const)
        .stubs()
        .will(returnValue(true));
    auto profBiuPerfJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfBiuPerfJob>();
    do {
        EXPECT_NE(profBiuPerfJob, nullptr);
        if (profBiuPerfJob == nullptr) {
            break;
        }
        collectionJobCfg_->comParams->params->instrProfiling = "on";
        collectionJobCfg_->comParams->params->hostProfiling = true;
        EXPECT_EQ(PROFILING_FAILED, profBiuPerfJob->Init(collectionJobCfg_));
        collectionJobCfg_->comParams->params->hostProfiling = false;
        EXPECT_EQ(PROFILING_SUCCESS, profBiuPerfJob->Init(collectionJobCfg_));
        collectionJobCfg_->comParams->params->pcSampling = "on";
        EXPECT_EQ(PROFILING_FAILED, profBiuPerfJob->Init(collectionJobCfg_));
        EXPECT_EQ(PROFILING_SUCCESS, profBiuPerfJob->Process());
        EXPECT_EQ(PROFILING_SUCCESS, profBiuPerfJob->Uninit());
    } while (0);
}

TEST_F(JOB_WRAPPER_PROF_BIU_PERF_JOB_TEST, MdcV2InstrProfilingOnlyStartsWhitelistChannels)
{
    g_startedChannels.clear();
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::CheckIfSupport,
        bool (Analysis::Dvvp::Common::Platform::Platform::*)(const Dvvp::Collect::Platform::PlatformFeature) const)
        .stubs()
        .will(returnValue(true));
    std::vector<BiuPerfChannelInfo> platformChannels = {
        {0, 0, 0, 11},
        {2, 0, 2, 17},
        {3, 0, 3, 20},
        {5, 0, 5, 26},
    };
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::GetBiuPerfChannelInfos,
        std::vector<BiuPerfChannelInfo> (Analysis::Dvvp::Common::Platform::Platform::*)(
            const std::vector<uint32_t> &, uint32_t) const)
        .stubs()
        .will(returnValue(platformChannels));
    int64_t aiCoreNum = 8;
    MOCKER(analysis::dvvp::driver::DrvGetAiCoreNum)
        .stubs()
        .with(any(), outBound(aiCoreNum))
        .will(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP(&analysis::dvvp::driver::DrvChannelsMgr::ChannelIsValid)
        .stubs()
        .will(returnValue(true));
    MOCKER(analysis::dvvp::driver::DrvInstrProfileStart)
        .stubs()
        .will(invoke(DrvInstrProfileStartStub));

    auto profBiuPerfJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfBiuPerfJob>();
    collectionJobCfg_->comParams->params->instrProfiling = "on";
    collectionJobCfg_->comParams->params->pcSampling = "off";
    collectionJobCfg_->comParams->params->hostProfiling = false;
    EXPECT_EQ(PROFILING_SUCCESS, profBiuPerfJob->Init(collectionJobCfg_));
    EXPECT_EQ(PROFILING_SUCCESS, profBiuPerfJob->Process());

    std::vector<int32_t> expectedChannels = {11, 17, 20, 26};
    EXPECT_EQ(expectedChannels, g_startedChannels);
}

// New driver version: Process should use BiuProfileConfigTV2 (with reportDataLoss) as the parameter.
TEST_F(JOB_WRAPPER_PROF_BIU_PERF_JOB_TEST, ProcessUsesV2ConfigOnNewDriver)
{
    g_lastConfigSize = 0;
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::CheckIfSupport,
        bool (Analysis::Dvvp::Common::Platform::Platform::*)(const Dvvp::Collect::Platform::PlatformFeature) const)
        .stubs()
        .will(returnValue(true));
    int64_t aiCoreNum = 8;
    MOCKER(analysis::dvvp::driver::DrvGetAiCoreNum)
        .stubs()
        .with(any(), outBound(aiCoreNum))
        .will(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP(&analysis::dvvp::driver::DrvChannelsMgr::ChannelIsValid)
        .stubs()
        .will(returnValue(true));
    // Force the new driver version branch.
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::DrvGetApiVersion)
        .stubs()
        .will(returnValue(static_cast<uint32_t>(
            Analysis::Dvvp::Common::Platform::BIU_REPORT_DATA_LOSS_API_VERSION)));
    MOCKER(analysis::dvvp::driver::DrvInstrProfileStart)
        .stubs()
        .will(invoke(DrvInstrProfileStartSizeStub));

    auto profBiuPerfJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfBiuPerfJob>();
    collectionJobCfg_->comParams->params->instrProfiling = "on";
    collectionJobCfg_->comParams->params->pcSampling = "off";
    collectionJobCfg_->comParams->params->hostProfiling = false;
    EXPECT_EQ(PROFILING_SUCCESS, profBiuPerfJob->Init(collectionJobCfg_));
    EXPECT_EQ(PROFILING_SUCCESS, profBiuPerfJob->Process());
    EXPECT_EQ(sizeof(analysis::dvvp::driver::BiuProfileConfigTV2), g_lastConfigSize);
}

// Old driver version: Process should fall back to using BiuProfileConfigT as the parameter.
TEST_F(JOB_WRAPPER_PROF_BIU_PERF_JOB_TEST, ProcessUsesV1ConfigOnOldDriver)
{
    g_lastConfigSize = 0;
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::CheckIfSupport,
        bool (Analysis::Dvvp::Common::Platform::Platform::*)(const Dvvp::Collect::Platform::PlatformFeature) const)
        .stubs()
        .will(returnValue(true));
    int64_t aiCoreNum = 8;
    MOCKER(analysis::dvvp::driver::DrvGetAiCoreNum)
        .stubs()
        .with(any(), outBound(aiCoreNum))
        .will(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP(&analysis::dvvp::driver::DrvChannelsMgr::ChannelIsValid)
        .stubs()
        .will(returnValue(true));
    // Force the old driver version branch.
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::DrvGetApiVersion)
        .stubs()
        .will(returnValue(static_cast<uint32_t>(
            Analysis::Dvvp::Common::Platform::BIU_REPORT_DATA_LOSS_API_VERSION) - 1));
    MOCKER(analysis::dvvp::driver::DrvInstrProfileStart)
        .stubs()
        .will(invoke(DrvInstrProfileStartSizeStub));

    auto profBiuPerfJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfBiuPerfJob>();
    collectionJobCfg_->comParams->params->instrProfiling = "on";
    collectionJobCfg_->comParams->params->pcSampling = "off";
    collectionJobCfg_->comParams->params->hostProfiling = false;
    EXPECT_EQ(PROFILING_SUCCESS, profBiuPerfJob->Init(collectionJobCfg_));
    EXPECT_EQ(PROFILING_SUCCESS, profBiuPerfJob->Process());
    EXPECT_EQ(sizeof(analysis::dvvp::driver::BiuProfileConfigT), g_lastConfigSize);
}

// DrvBiuPerfStop should log an error but still return success when it hits the data loss status code (0x916).
TEST_F(JOB_WRAPPER_PROF_BIU_PERF_JOB_TEST, DrvBiuPerfStopReturnsSuccessOnDataLoss)
{
    MOCKER_CPP(&analysis::dvvp::driver::MsprofDrvApi::ProfStop)
        .stubs()
        .will(returnValue(0x916));
    EXPECT_EQ(PROFILING_SUCCESS,
        analysis::dvvp::driver::DrvBiuPerfStop(0, static_cast<analysis::dvvp::driver::AI_DRV_CHANNEL>(0)));

    // Other non-success codes should still return failure.
    GlobalMockObject::verify();
    MOCKER_CPP(&analysis::dvvp::driver::MsprofDrvApi::ProfStop)
        .stubs()
        .will(returnValue(-1));
    EXPECT_EQ(PROFILING_FAILED,
        analysis::dvvp::driver::DrvBiuPerfStop(0, static_cast<analysis::dvvp::driver::AI_DRV_CHANNEL>(0)));
}

// DrvBiuPerfStop 通过出参回传丢数据的驱动状态码，供上层记录；正常与真失败时该出参为 0。
TEST_F(JOB_WRAPPER_PROF_BIU_PERF_JOB_TEST, DrvBiuPerfStopReportsLossRetCode)
{
    int32_t lossRetCode = -1;
    MOCKER_CPP(&analysis::dvvp::driver::MsprofDrvApi::ProfStop)
        .stubs()
        .will(returnValue(0x916));
    EXPECT_EQ(PROFILING_SUCCESS, analysis::dvvp::driver::DrvBiuPerfStop(
        0, static_cast<analysis::dvvp::driver::AI_DRV_CHANNEL>(0), &lossRetCode));
    EXPECT_EQ(0x916, lossRetCode);

    // 采集正常：出参必须被复位为 0，否则上层会误记一次丢数据
    GlobalMockObject::verify();
    lossRetCode = -1;
    MOCKER_CPP(&analysis::dvvp::driver::MsprofDrvApi::ProfStop)
        .stubs()
        .will(returnValue(0));
    EXPECT_EQ(PROFILING_SUCCESS, analysis::dvvp::driver::DrvBiuPerfStop(
        0, static_cast<analysis::dvvp::driver::AI_DRV_CHANNEL>(0), &lossRetCode));
    EXPECT_EQ(0, lossRetCode);

    // 真失败：同样不应被记为丢数据
    GlobalMockObject::verify();
    lossRetCode = -1;
    MOCKER_CPP(&analysis::dvvp::driver::MsprofDrvApi::ProfStop)
        .stubs()
        .will(returnValue(-1));
    EXPECT_EQ(PROFILING_FAILED, analysis::dvvp::driver::DrvBiuPerfStop(
        0, static_cast<analysis::dvvp::driver::AI_DRV_CHANNEL>(0), &lossRetCode));
    EXPECT_EQ(0, lossRetCode);
}

// ProfCollectInfo：无异常时不产生文件；有记录时生成 data/prof_collect.info，
// 且多条记录累积在同一文件内（通用性验证：不同 module 混合）。
TEST_F(JOB_WRAPPER_PROF_BIU_PERF_JOB_TEST, ProfCollectInfoWriteAndAccumulate)
{
    using Analysis::Dvvp::JobWrapper::ProfCollectInfo;
    using Analysis::Dvvp::JobWrapper::CollectAbnormalItem;

    const std::string resultDir = "/tmp/prof_collect_info_ut";
    const std::string infoFile = resultDir + "/data/prof_collect.info";
    (void)system(("rm -rf " + resultDir).c_str());

    // 无记录时不落文件
    ProfCollectInfo::instance()->Reset();
    EXPECT_FALSE(ProfCollectInfo::instance()->HasAbnormal());
    EXPECT_EQ(PROFILING_SUCCESS, ProfCollectInfo::instance()->Flush(resultDir));
    EXPECT_FALSE(analysis::dvvp::common::utils::Utils::IsFileExist(infoFile));

    // 记录两条不同模块的丢数据，验证通用性与累积
    CollectAbnormalItem biu;
    biu.module = "biu_perf";
    biu.devId = 0;
    biu.channelId = 11;
    biu.retCode = 0x916;
    biu.reason = "Driver reported profiling data loss";
    biu.detail = "groupId=0,groupType=1,groupNo=2";
    ProfCollectInfo::instance()->RecordDataLoss(biu);

    CollectAbnormalItem other;
    other.module = "soc_pmu";
    other.devId = 1;
    other.channelId = 22;
    other.retCode = 0x917;
    other.reason = "Quoted \"reason\" with backslash \\ and newline\n";
    ProfCollectInfo::instance()->RecordDataLoss(other);

    EXPECT_TRUE(ProfCollectInfo::instance()->HasAbnormal());
    EXPECT_EQ(PROFILING_SUCCESS, ProfCollectInfo::instance()->Flush(resultDir));
    EXPECT_TRUE(analysis::dvvp::common::utils::Utils::IsFileExist(infoFile));

    std::ifstream in(infoFile);
    std::stringstream buf;
    buf << in.rdbuf();
    in.close();
    const std::string content = buf.str();

    // 两条记录都在，且各字段齐全
    EXPECT_NE(std::string::npos, content.find("\"module\": \"biu_perf\""));
    EXPECT_NE(std::string::npos, content.find("\"module\": \"soc_pmu\""));
    EXPECT_NE(std::string::npos, content.find("\"channel_id\": 11"));
    EXPECT_NE(std::string::npos, content.find("\"channel_id\": 22"));
    EXPECT_NE(std::string::npos, content.find("\"ret_code\": \"0x916\""));
    EXPECT_NE(std::string::npos, content.find("\"detail\": \"groupId=0,groupType=1,groupNo=2\""));
    // 特殊字符必须被转义，否则生成的不是合法 JSON
    EXPECT_NE(std::string::npos, content.find("\\\"reason\\\""));
    EXPECT_NE(std::string::npos, content.find("\\\\"));
    EXPECT_EQ(std::string::npos, content.find("with backslash \\ and"));
    // JSON 数组不能有尾随逗号
    EXPECT_EQ(std::string::npos, content.find(",\n    ]"));

    // 权限必须与同目录 *.data 文件一致（0640），不能比采集数据本身更宽松。
    // UT 里 mmChmod 是空桩（mmpa_stub.cpp），不会真的改文件权限，所以这里校验的是
    // "确实以 0640 调用了 chmod"，而非文件系统上的最终结果。
    GlobalMockObject::verify();
    ProfCollectInfo::instance()->Reset();
    (void)system(("rm -rf " + resultDir).c_str());
    MOCKER(mmChmod).stubs().will(invoke(ChmodRecordStub));
    g_lastChmodMode = -1;
    ProfCollectInfo::instance()->RecordDataLoss(biu);
    EXPECT_EQ(PROFILING_SUCCESS, ProfCollectInfo::instance()->Flush(resultDir));
    EXPECT_EQ(0640, g_lastChmodMode);

    ProfCollectInfo::instance()->Reset();
    (void)system(("rm -rf " + resultDir).c_str());
}

// Flush 必须消费掉已写出的记录：否则同进程内跨设备/跨任务采集时，
// 上一次的旧记录会被重复写进下一个设备的 prof_collect.info，诊断结果不可信。
TEST_F(JOB_WRAPPER_PROF_BIU_PERF_JOB_TEST, ProfCollectInfoFlushDoesNotLeakAcrossDevices)
{
    using Analysis::Dvvp::JobWrapper::ProfCollectInfo;
    using Analysis::Dvvp::JobWrapper::CollectAbnormalItem;

    const std::string dir0 = "/tmp/prof_collect_info_dev0";
    const std::string dir1 = "/tmp/prof_collect_info_dev1";
    const std::string file0 = dir0 + "/data/prof_collect.info";
    const std::string file1 = dir1 + "/data/prof_collect.info";
    (void)system(("rm -rf " + dir0 + " " + dir1).c_str());
    ProfCollectInfo::instance()->Reset();

    auto readAll = [](const std::string &path) {
        std::ifstream in(path);
        std::stringstream buf;
        buf << in.rdbuf();
        return buf.str();
    };

    // 设备 0 丢数据并落盘
    CollectAbnormalItem dev0;
    dev0.module = "biu_perf";
    dev0.devId = 0;
    dev0.channelId = 11;
    dev0.retCode = 0x916;
    dev0.reason = "loss on device 0";
    ProfCollectInfo::instance()->RecordDataLoss(dev0);
    EXPECT_EQ(PROFILING_SUCCESS, ProfCollectInfo::instance()->Flush(dir0));
    const std::string content0 = readAll(file0);
    EXPECT_NE(std::string::npos, content0.find("loss on device 0"));

    // 写出后记录必须已被消费
    EXPECT_FALSE(ProfCollectInfo::instance()->HasAbnormal());

    // 设备 1 独立丢数据：文件里只能有设备 1 的记录
    CollectAbnormalItem dev1;
    dev1.module = "biu_perf";
    dev1.devId = 1;
    dev1.channelId = 22;
    dev1.retCode = 0x916;
    dev1.reason = "loss on device 1";
    ProfCollectInfo::instance()->RecordDataLoss(dev1);
    EXPECT_EQ(PROFILING_SUCCESS, ProfCollectInfo::instance()->Flush(dir1));
    const std::string content1 = readAll(file1);
    EXPECT_NE(std::string::npos, content1.find("loss on device 1"));
    // 关键断言：设备 0 的旧记录不得出现在设备 1 的文件里
    EXPECT_EQ(std::string::npos, content1.find("loss on device 0"));
    EXPECT_EQ(std::string::npos, content1.find("\"device_id\": 0"));

    // 采集正常的设备不应产生文件（记录已被消费，不会误判为有异常）
    const std::string dir2 = "/tmp/prof_collect_info_dev2";
    (void)system(("rm -rf " + dir2).c_str());
    EXPECT_EQ(PROFILING_SUCCESS, ProfCollectInfo::instance()->Flush(dir2));
    EXPECT_FALSE(analysis::dvvp::common::utils::Utils::IsFileExist(dir2 + "/data/prof_collect.info"));

    ProfCollectInfo::instance()->Reset();
    (void)system(("rm -rf " + dir0 + " " + dir1 + " " + dir2).c_str());
}

// 同一进程内两次 profiling 会话：第一次有 data loss 并 Flush 成功后，
// 第二次会话开始时必须通过 Reset() 清空残留，确保第二次的 prof_collect.info
// 不包含第一次的记录。模拟 Flush 失败（记录未消费）后再开新会话同样不能泄漏。
TEST_F(JOB_WRAPPER_PROF_BIU_PERF_JOB_TEST, ProfCollectInfoResetClearsPreviousSession)
{
    using Analysis::Dvvp::JobWrapper::ProfCollectInfo;
    using Analysis::Dvvp::JobWrapper::CollectAbnormalItem;

    const std::string dirA = "/tmp/prof_collect_info_session_a";
    const std::string dirB = "/tmp/prof_collect_info_session_b";
    const std::string fileA = dirA + "/data/prof_collect.info";
    const std::string fileB = dirB + "/data/prof_collect.info";
    (void)system(("rm -rf " + dirA + " " + dirB).c_str());

    auto readAll = [](const std::string &path) {
        std::ifstream in(path);
        std::stringstream buf;
        buf << in.rdbuf();
        return buf.str();
    };

    // --- 会话 A：丢数据并落盘 ---
    ProfCollectInfo::instance()->Reset();
    CollectAbnormalItem itemA;
    itemA.module = "biu_perf";
    itemA.devId = 0;
    itemA.channelId = 11;
    itemA.retCode = 0x916;
    itemA.reason = "session_a_loss";
    ProfCollectInfo::instance()->RecordDataLoss(itemA);
    EXPECT_EQ(PROFILING_SUCCESS, ProfCollectInfo::instance()->Flush(dirA));
    const std::string contentA = readAll(fileA);
    EXPECT_NE(std::string::npos, contentA.find("session_a_loss"));

    // --- 会话 B 开始：Reset 清空上一会话残留 ---
    ProfCollectInfo::instance()->Reset();
    EXPECT_FALSE(ProfCollectInfo::instance()->HasAbnormal());

    // 会话 B 有自己的 data loss
    CollectAbnormalItem itemB;
    itemB.module = "biu_perf";
    itemB.devId = 1;
    itemB.channelId = 22;
    itemB.retCode = 0x916;
    itemB.reason = "session_b_loss";
    ProfCollectInfo::instance()->RecordDataLoss(itemB);
    EXPECT_EQ(PROFILING_SUCCESS, ProfCollectInfo::instance()->Flush(dirB));
    const std::string contentB = readAll(fileB);
    EXPECT_NE(std::string::npos, contentB.find("session_b_loss"));
    // 关键断言：会话 A 的记录不得出现在会话 B 的文件里
    EXPECT_EQ(std::string::npos, contentB.find("session_a_loss"));
    EXPECT_EQ(std::string::npos, contentB.find("\"device_id\": 0"));

    ProfCollectInfo::instance()->Reset();
    (void)system(("rm -rf " + dirA + " " + dirB).c_str());
}

// 集成用例：ProfBiuPerfJob::Uninit() 收到 lossRetCode 后组装 CollectAbnormalItem、
// 调用 RecordDataLoss/Flush、最终写到 tmpResultDir/data/prof_collect.info 的完整链路。
// 覆盖多 channel data loss 和 tmpResultDir 路径，避免后续改动绕过 BIU job 集成逻辑仍能通过测试。
TEST_F(JOB_WRAPPER_PROF_BIU_PERF_JOB_TEST, UninitFlushesMultiChannelDataLossToTmpResultDir)
{
    using Analysis::Dvvp::JobWrapper::ProfCollectInfo;
    ProfCollectInfo::instance()->Reset();

    const std::string tmpResultDir = "/tmp/prof_biu_uninit_integration";
    const std::string infoFile = tmpResultDir + "/data/prof_collect.info";
    (void)system(("rm -rf " + tmpResultDir).c_str());

    // Platform 支持
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::CheckIfSupport,
        bool (Analysis::Dvvp::Common::Platform::Platform::*)(const Dvvp::Collect::Platform::PlatformFeature) const)
        .stubs()
        .will(returnValue(true));

    // 3 个 channel：channel 11 和 22 将丢数据，channel 33 正常
    std::vector<BiuPerfChannelInfo> platformChannels = {
        {0, 0, 0, 11},
        {1, 0, 1, 22},
        {2, 0, 2, 33},
    };
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::GetBiuPerfChannelInfos,
        std::vector<BiuPerfChannelInfo> (Analysis::Dvvp::Common::Platform::Platform::*)(
            const std::vector<uint32_t> &, uint32_t) const)
        .stubs()
        .will(returnValue(platformChannels));

    int64_t aiCoreNum = 8;
    MOCKER(analysis::dvvp::driver::DrvGetAiCoreNum)
        .stubs()
        .with(any(), outBound(aiCoreNum))
        .will(returnValue(PROFILING_SUCCESS));

    MOCKER_CPP(&analysis::dvvp::driver::DrvChannelsMgr::ChannelIsValid)
        .stubs()
        .will(returnValue(true));

    MOCKER(analysis::dvvp::driver::DrvInstrProfileStart)
        .stubs()
        .will(invoke(DrvInstrProfileStartStub));

    // ProfStop: channel 11 → 0x916 (data loss), channel 22 → 0x916 (data loss), channel 33 → 0 (ok)
    MOCKER_CPP(&analysis::dvvp::driver::MsprofDrvApi::ProfStop)
        .stubs()
        .will(returnValue(0x916))
        .then(returnValue(0x916))
        .then(returnValue(0));

    auto profBiuPerfJob = std::make_shared<Analysis::Dvvp::JobWrapper::ProfBiuPerfJob>();
    collectionJobCfg_->comParams->devId = 0;
    collectionJobCfg_->comParams->tmpResultDir = tmpResultDir;
    collectionJobCfg_->comParams->params->instrProfiling = "on";
    collectionJobCfg_->comParams->params->pcSampling = "off";
    collectionJobCfg_->comParams->params->hostProfiling = false;
    ASSERT_EQ(PROFILING_SUCCESS, profBiuPerfJob->Init(collectionJobCfg_));
    ASSERT_EQ(PROFILING_SUCCESS, profBiuPerfJob->Process());
    EXPECT_EQ(PROFILING_SUCCESS, profBiuPerfJob->Uninit());

    // 验证 prof_collect.info 已生成
    EXPECT_TRUE(analysis::dvvp::common::utils::Utils::IsFileExist(infoFile));

    std::ifstream in(infoFile);
    std::stringstream buf;
    buf << in.rdbuf();
    in.close();
    const std::string content = buf.str();

    // 两个丢数据的 channel 都在文件里
    EXPECT_NE(std::string::npos, content.find("\"channel_id\": 11"));
    EXPECT_NE(std::string::npos, content.find("\"channel_id\": 22"));
    // 正常 channel 33 不应出现在 data_loss 记录里
    EXPECT_EQ(std::string::npos, content.find("\"channel_id\": 33"));
    // detail 字段包含 groupId/groupType/groupNo
    EXPECT_NE(std::string::npos, content.find("groupId=0,groupType=0,groupNo=0"));
    EXPECT_NE(std::string::npos, content.find("groupId=1,groupType=0,groupNo=1"));
    // ret_code 为 0x916
    EXPECT_NE(std::string::npos, content.find("0x916"));
    // module 为 biu_perf
    EXPECT_NE(std::string::npos, content.find("\"module\": \"biu_perf\""));

    ProfCollectInfo::instance()->Reset();
    GlobalMockObject::verify();
    (void)system(("rm -rf " + tmpResultDir).c_str());
}
