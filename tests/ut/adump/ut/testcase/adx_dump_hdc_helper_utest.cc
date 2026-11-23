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
#include <cstring>
#include <vector>
#include "mockcpp/mockcpp.hpp"
#define protected public
#define private public

#include "config.h"
#include "adx_dump_hdc_helper.h"
#include "adx_datadump_callback.h"
#include "adx_comm_opt.h"
#include "ascend_hal.h"
#include "mmpa_api.h" // mmSleep（超时步数推导用例的退避断言）

class ADX_DUMP_HDC_HELPER_TEST : public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown() { GlobalMockObject::verify(); }
};

TEST_F(ADX_DUMP_HDC_HELPER_TEST, ParseConnectInfo)
{
    const std::string privInfo = "127.0.0.1:22118;0;123";
    std::map<std::string, std::string> proto;
    int ret = Adx::AdxDumpHdcHelper::Instance().ParseConnectInfo(privInfo, proto);
    EXPECT_EQ(0, ret);
    EXPECT_EQ(proto[Adx::OPT_DEVICE_KEY], "0");
    EXPECT_EQ(proto[Adx::OPT_PID_KEY], "123");
    const std::string privInfo1 = "127.0.0.1";
    ret = Adx::AdxDumpHdcHelper::Instance().ParseConnectInfo(privInfo1, proto);
    EXPECT_EQ(IDE_DAEMON_INVALID_PARAM_ERROR, ret);
    const std::string privInfo2 = "127.0.0.1:22118;a;abc";
    ret = Adx::AdxDumpHdcHelper::Instance().ParseConnectInfo(privInfo2, proto);
    EXPECT_EQ(IDE_DAEMON_INVALID_PARAM_ERROR, ret);
    const std::string privInfo3 = "127.0.0.1:22118;0;abc";
    ret = Adx::AdxDumpHdcHelper::Instance().ParseConnectInfo(privInfo3, proto);
    EXPECT_EQ(IDE_DAEMON_INVALID_PARAM_ERROR, ret);

    // test environment variables for 1971 helper
    std::string hostPID = "456";
    ret = setenv(IdeDaemon::Common::Config::HELPER_HOSTPID.c_str(), hostPID.c_str(), 0);
    ret = Adx::AdxDumpHdcHelper::Instance().ParseConnectInfo(privInfo, proto);
    EXPECT_EQ(proto[Adx::OPT_PID_KEY], hostPID);
    ret = unsetenv(IdeDaemon::Common::Config::HELPER_HOSTPID.c_str());

    hostPID = "abc";
    ret = setenv(IdeDaemon::Common::Config::HELPER_HOSTPID.c_str(), hostPID.c_str(), 0);
    ret = Adx::AdxDumpHdcHelper::Instance().ParseConnectInfo(privInfo, proto);
    EXPECT_EQ(proto[Adx::OPT_PID_KEY], "123");
    ret = unsetenv(IdeDaemon::Common::Config::HELPER_HOSTPID.c_str());
}

TEST_F(ADX_DUMP_HDC_HELPER_TEST, IdeDumpStart)
{
    const char* privInfo = "127.0.0.1:22118;0;123";
    IDE_SESSION session = IdeDumpStart(privInfo);
    EXPECT_EQ(0, session);
}

static void FillIdeDumpChunk(IdeDumpChunk& dumpChunk, unsigned char* buf, const char* fileName)
{
    dumpChunk.fileName = const_cast<char*>(fileName);
    dumpChunk.dataBuf = buf;
    dumpChunk.bufLen = 1;
    dumpChunk.isLastChunk = 0;
    dumpChunk.offset = 0;
    dumpChunk.flag = IDE_DUMP_NONE_FLAG;
}

TEST_F(ADX_DUMP_HDC_HELPER_TEST, IdeDumpData_WriteError)
{
    IDE_SESSION session = (IDE_SESSION)0xFFFFF000;
    IdeDumpChunk dumpChunk;
    unsigned char ch = 'a';
    FillIdeDumpChunk(dumpChunk, &ch, "/home/test.log");
    const IdeDumpChunk constDumpChunk = dumpChunk;
    EXPECT_EQ(IDE_DAEMON_INVALID_PARAM_ERROR, IdeDumpData(nullptr, nullptr));
    EXPECT_EQ(IDE_DAEMON_INVALID_PARAM_ERROR, IdeDumpData(session, nullptr));
    int ret = IdeDumpData(session, &constDumpChunk);
    EXPECT_EQ(IDE_DAEMON_WRITE_ERROR, ret);
}

TEST_F(ADX_DUMP_HDC_HELPER_TEST, IdeDumpData_SessionError)
{
    MOCKER(halHdcGetSessionAttr).stubs().will(returnValue(1));
    IDE_SESSION session = (IDE_SESSION)0xFFFFF000;
    IdeDumpChunk dumpChunk;
    unsigned char ch = 'a';
    FillIdeDumpChunk(dumpChunk, &ch, "/home/test.log");
    const IdeDumpChunk constDumpChunk = dumpChunk;
    EXPECT_EQ(IDE_DAEMON_INVALID_PARAM_ERROR, IdeDumpData(nullptr, nullptr));
    EXPECT_EQ(IDE_DAEMON_INVALID_PARAM_ERROR, IdeDumpData(session, nullptr));
    int ret = IdeDumpData(session, &constDumpChunk);
    EXPECT_EQ(IDE_DAEMON_CHANNEL_ERROR, ret);
}

TEST_F(ADX_DUMP_HDC_HELPER_TEST, DataProcess_FileNameRobustness)
{
    IDE_SESSION session = (IDE_SESSION)0xFFFFF000;
    IdeDumpChunk dumpChunk;
    unsigned char ch = 'a';
    FillIdeDumpChunk(dumpChunk, &ch, nullptr);
    const IdeDumpChunk constDumpChunk = dumpChunk;
    int ret = IdeDumpData(session, &constDumpChunk);
    // 组包已收敛到 BuildDumpChunkMsg：fileName 空指针在组包层按路径错误拒绝（INVALID_PATH=4）
    EXPECT_EQ(IDE_DAEMON_INVALID_PATH_ERROR, ret);

    std::vector<char> longName(Adx::MAX_FILE_PATH_LENGTH, 'a');
    FillIdeDumpChunk(dumpChunk, &ch, longName.data());
    const IdeDumpChunk longDumpChunk = dumpChunk;
    ret = IdeDumpData(session, &longDumpChunk);
    EXPECT_EQ(IDE_DAEMON_INVALID_PATH_ERROR, ret);

    MOCKER(halHdcGetSessionAttr).stubs().will(returnValue(1));
    std::vector<char> maxName(Adx::MAX_FILE_PATH_LENGTH, 'a');
    maxName.back() = '\0';
    FillIdeDumpChunk(dumpChunk, &ch, maxName.data());
    const IdeDumpChunk maxDumpChunk = dumpChunk;
    ret = IdeDumpData(session, &maxDumpChunk);
    EXPECT_EQ(IDE_DAEMON_CHANNEL_ERROR, ret);
}

// 新回传 flag 的 device 侧真实处理（HDC 发送路径）。两条负向：
// ① fileName=nullptr 在组包层被拒（新 flag 语义上 fileName 为空串而非空指针，
//    空指针是组装函数必须自防的入参）；
// ② 空串（合法语义形态）组包通过，推进到发送层被未连接会话拦截——
//    UT 环境无 HDC 会话，整链折返"通路"错误码，不触碰组包以外的任何外部资源。
TEST_F(ADX_DUMP_HDC_HELPER_TEST, IdeDumpData_NewFlagNullName)
{
    IDE_SESSION session = (IDE_SESSION)0xFFFFF000;
    IdeDumpChunk dumpChunk = {};
    unsigned char ch = 'a';
    dumpChunk.fileName = nullptr;
    dumpChunk.dataBuf = &ch;
    dumpChunk.bufLen = 1;
    dumpChunk.isLastChunk = 1;
    dumpChunk.offset = -1;
    dumpChunk.flag = IDE_DUMP_CHECKSUPPORT;
    EXPECT_EQ(IDE_DAEMON_INVALID_PATH_ERROR, IdeDumpData(session, &dumpChunk));
}

TEST_F(ADX_DUMP_HDC_HELPER_TEST, IdeDumpData_NewFlagNotConnected)
{
    static char emptyName[] = "";
    IDE_SESSION session = (IDE_SESSION)0xFFFFF000;
    IdeDumpChunk dumpChunk = {};
    unsigned char ch = 'a';
    dumpChunk.fileName = emptyName; // 新 flag 的契约形态：空文件路径
    dumpChunk.dataBuf = &ch;
    dumpChunk.bufLen = 1;
    dumpChunk.isLastChunk = 1;
    dumpChunk.offset = -1;
    dumpChunk.flag = IDE_DUMP_CHECKSUPPORT;
    // 会话层拦截：stub 对会话状态恒回"已连接"，mock 其失败锁定折返点，
    // 验证新 flag 的探测请求走到发送层即按通路错误返回（不落文件、不崩）。
    MOCKER(halHdcGetSessionAttr).stubs().will(returnValue(1));
    EXPECT_EQ(IDE_DAEMON_CHANNEL_ERROR, IdeDumpData(session, &dumpChunk));
    dumpChunk.flag = IDE_DUMP_REQ_WITH_ID;
    EXPECT_EQ(IDE_DAEMON_CHANNEL_ERROR, IdeDumpData(session, &dumpChunk));
}

// CHECKSUPPORT 应答超时折叠：限时收包始终无应答 → 按不支持返回（aicpu 据此回退老链路）。
// RecvCheckSupportResult 内部固定以 CHECKSUPPORT_RESP_TIMEOUT_MS(3000) 收应答（入口 timeout
// 不透传），按 1+2+…+N≤T 推导为 76 步退避——mmSleep 断言 exactly(76) 兼作步数推导回归锚点。
// timeout 推导本身（1ms→1 步）在 RecvSupportResponse 直测（见下 TimeoutStepsFollowTimeout）。
TEST_F(ADX_DUMP_HDC_HELPER_TEST, RecvCheckSupportResult_TimeoutFallback)
{
    static char emptyName[] = "";
    IdeDumpChunk dumpChunk = {};
    uint64_t ability = 0x3ULL;
    dumpChunk.fileName = emptyName;
    dumpChunk.dataBuf = reinterpret_cast<unsigned char*>(&ability);
    dumpChunk.bufLen = sizeof(ability);
    dumpChunk.isLastChunk = 1;
    dumpChunk.offset = -1;
    dumpChunk.flag = IDE_DUMP_CHECKSUPPORT;

    CommHandle handle = {};
    MOCKER_CPP(&Adx::AdxCommOptManager::TryRead).stubs().will(returnValue(IDE_DAEMON_RECV_NODATA));
    MOCKER(mmSleep).expects(exactly(76)).will(returnValue(0)); // 3000ms → 76 步（推导见 adx_msg_proto.cpp）
    const IdeErrorT ret = Adx::AdxDumpHdcHelper::Instance().RecvCheckSupportResult(handle, dumpChunk);
    EXPECT_EQ(IDE_DAEMON_HDC_TIMEOUT, ret);
}

// 超时步数推导直测：timeout=1ms 只退避一次即折返（不再固定 77 轮）。
// 直接驱动 RecvSupportResponse（跳过 RecvCheckSupportResult 的固定 3000ms 覆盖），
// TryRead 恒无数据，断言 mmSleep 恰一次 + 超时码。
TEST_F(ADX_DUMP_HDC_HELPER_TEST, RecvSupportResponse_TimeoutStepsFollowTimeout)
{
    CommHandle handle = {};
    handle.timeout = 1;
    uint64_t bitmap = 0;
    MOCKER_CPP(&Adx::AdxCommOptManager::TryRead).stubs().will(returnValue(IDE_DAEMON_RECV_NODATA));
    MOCKER(mmSleep).expects(once()).will(returnValue(0));
    const Adx::MsgCode ret = Adx::AdxMsgProto::RecvSupportResponse(handle, bitmap);
    EXPECT_EQ(IDE_DAEMON_HDC_TIMEOUT, ret);
}

// CHECKSUPPORT 请求能力位缺失（dataBuf 空指针 / 不足 8B）：按参数错误折返而非默认
// ability=0（默认 0 会让 (bitmap & 0)==0 恒过，坏探测请求被判成支持）。
// 校验已前置到收包之前：收包侧置 never 期望，锁定"坏请求不空等应答即折返"。
TEST_F(ADX_DUMP_HDC_HELPER_TEST, RecvCheckSupportResult_MissingAbility)
{
    static char emptyName[] = "";
    IdeDumpChunk dumpChunk = {};
    dumpChunk.fileName = emptyName;
    dumpChunk.dataBuf = nullptr; // 坏探测请求：不带能力位
    dumpChunk.bufLen = 0;
    dumpChunk.isLastChunk = 1;
    dumpChunk.offset = -1;
    dumpChunk.flag = IDE_DUMP_CHECKSUPPORT;

    CommHandle handle = {};
    MOCKER_CPP(&Adx::AdxMsgProto::RecvSupportResponse).expects(never());
    EXPECT_EQ(
        IDE_DAEMON_INVALID_PARAM_ERROR, Adx::AdxDumpHdcHelper::Instance().RecvCheckSupportResult(handle, dumpChunk));

    unsigned char partial[4] = {1, 2, 3, 4}; // 带了但不足 8B：同判
    dumpChunk.dataBuf = partial;
    dumpChunk.bufLen = sizeof(partial);
    EXPECT_EQ(
        IDE_DAEMON_INVALID_PARAM_ERROR, Adx::AdxDumpHdcHelper::Instance().RecvCheckSupportResult(handle, dumpChunk));
}
