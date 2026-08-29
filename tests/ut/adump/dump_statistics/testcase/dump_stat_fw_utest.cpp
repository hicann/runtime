/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "gtest/gtest.h"
#include <atomic>
#include <cstddef>
#include <vector>
#include <cstdint>
#include <thread>
#include <unistd.h>
#include "ascend_hal_define.h"
#include "kfc_dump_data_stub.h"
#include "dump_stats_interface.h"
#include "dump_stats_process.h"
#include "dump_stats_task.h"
#include "operator_preliminary.h"

using namespace kfc_dump_stats;

// 应答线程的退出与就绪标志按线程独立分配，不使用全局变量。
// 曾用全局 g_KFCRuning 导致偶发失败：用例 A 末尾置 false 后，用例 B 开头又置回 true，
// 若 A 的线程尚未走到 while 判断即被"复活"，B 运行期就有两个线程轮询同一 msgQ，
// 互抢消息使收发游标错位，被测代码等不到应答而返回 KFC_DUMP_E_TIMEOUT。

// KfcDumpOpInitParam 布局一致性（需求 U9）
// 下发侧(`Adx::`, operator_preliminary.h)与 server 侧(`kfc_dump_stats::`)是两份独立定义
// (Q2 不合并), 通过 offsetof 传递 so/kernel 名, 布局错位编译期发现不了。
// 原先此处复刻一份下发侧结构体做断言, 与 operator_preliminary.h 构成重复代码; 且复刻件
// 会随下发侧演进而静默失配 —— 那时断言比的是两份陈旧定义, 反而漏报。改为直接 include
// 下发侧头, 断言两侧真实定义。
static_assert(
    sizeof(Adx::KfcDumpOpInitParam) == sizeof(kfc_dump_stats::KfcDumpOpInitParam),
    "KfcDumpOpInitParam size mismatch between host and device side");
static_assert(
    offsetof(Adx::KfcDumpOpInitParam, soName) == offsetof(kfc_dump_stats::KfcDumpOpInitParam, soName),
    "KfcDumpOpInitParam soName offset mismatch");
static_assert(
    offsetof(Adx::KfcDumpOpInitParam, kernelName) == offsetof(kfc_dump_stats::KfcDumpOpInitParam, kernelName),
    "KfcDumpOpInitParam kernelName offset mismatch");
static_assert(
    sizeof(Adx::KfcDumpWorkSpace) == sizeof(kfc_dump_stats::KfcDumpWorkSpace), "KfcDumpWorkSpace size mismatch");
static_assert(sizeof(Adx::KfcDumpOpConfig) == sizeof(kfc_dump_stats::KfcDumpOpConfig), "KfcDumpOpConfig size mismatch");
static_assert(
    sizeof(Adx::KfcDumpStreamInfo) == sizeof(kfc_dump_stats::KfcDumpStreamInfo), "KfcDumpStreamInfo size mismatch");
// so/kernel 名长度必须容纳最长的下发字符串
static_assert(sizeof("libaicpu_extend_kernels.so") <= Adx::FILE_NAME_MAX, "soName buffer too small");
static_assert(sizeof("AdumpStatsOpSrvInit") <= Adx::FILE_NAME_MAX, "kernelName buffer too small");

// 模拟 AIV 侧应答线程：轮询请求区，回写应答。
// 内存序说明：被测代码 PostMsg 以 "先写消息体、再置 valid" 的顺序发布消息
// （aarch64 上带 dsb st 屏障），RcvMsg 则以 valid 为消息就绪的判据。本线程
// 必须遵守同一约定 —— 若 valid 的写入先于消息体对被测线程可见，RcvMsg 会
// 读到 valid 已置位但 msgType 仍为旧值的消息，落入 "非 RESPONSE" 分支返回
// KFC_DUMP_E_PARA，表现为偶发失败。故此处显式插入 release/acquire 屏障。
void KFCSeverProcess(
    uint64_t workspace, DumpStatMsgType responseMsgType, uint32_t result, std::atomic<bool>* running,
    std::atomic<bool>* ready, std::atomic<uint32_t>* consumed, std::atomic<bool>* exited,
    std::atomic<bool>* sawFinished)
{
    uint32_t recCount = 0;
    uint32_t sndCount = 0;
    KfcDumpStatsMsg* rcvMsg = reinterpret_cast<KfcDumpStatsMsg*>(workspace + DUMP_MSG_CNT * sizeof(KfcDumpStatsMsg));
    KfcDumpStatsMsg* sndMsg = reinterpret_cast<KfcDumpStatsMsg*>(workspace);
    // 通知主线程已进入轮询：超时被缩短为 1s，线程启动延迟超过该阈值会导致
    // RcvMsg 超时。此处显式同步，不依赖线程启动时序。
    *ready = true;
    // 循环结构与真实 AIV 对齐(canndev kfc_dump_stat.cpp:215-258)：退出判据放在 while
    // 条件处而非循环体开头，否则绕回时会把同一槽位的残留 REQUEST 当成新请求。
    do {
        if (rcvMsg->msgType == KFC_DUMP_MSG_REQUEST && rcvMsg->valid == DUMP_MSG_VALID_MASK) {
            // acquire：确保后续对消息体的读取不会被重排到 valid 检查之前
            std::atomic_thread_fence(std::memory_order_acquire);
            // 只清 valid，不动 msgType —— 与真实 AIV 的 UpdateMsg 一致
            // (canndev kfc_dump_base.h:261)。若额外清 msgType，会与被测 PostMsg 竞争出
            // msgType=DEFAULT + valid=MASK 的状态，两侧判据都不成立而永久互等。
            rcvMsg->valid = ~DUMP_MSG_VALID_MASK;
            sndMsg->msgType = responseMsgType;
            sndMsg->result = result;
            sndMsg->outputAddr = rcvMsg->outputAddr;
            sndMsg->outputAddrSize = rcvMsg->outputAddrSize;
            // release：确保上述消息体写入先于 valid 置位对被测线程可见
            std::atomic_thread_fence(std::memory_order_release);
            sndMsg->valid = DUMP_MSG_VALID_MASK;
            (*consumed)++;
            recCount = (recCount + 1) % DUMP_MSG_CNT;
            sndCount = (sndCount + 1) % DUMP_MSG_CNT;
            rcvMsg = reinterpret_cast<KfcDumpStatsMsg*>(
                workspace + DUMP_MSG_CNT * sizeof(KfcDumpStatsMsg) + recCount * sizeof(KfcDumpStatsMsg));
            sndMsg = reinterpret_cast<KfcDumpStatsMsg*>(workspace + sndCount * sizeof(KfcDumpStatsMsg));
        }
        if (rcvMsg->msgType == KFC_DUMP_MSG_FINISHED) {
            // 真实 AIV 的唯一退出条件。与被 running 强行收回区分开，
            // 供用例断言"被测确实发了 FINISHED"，否则该断言恒真形同虚设。
            *sawFinished = true;
            break;
        }
        // running 为 false 时退出，供用例在异常路径(被测未发 FINISHED)下回收本线程
    } while (*running);
    *exited = true;
}

// 应答线程句柄：析构时自动停线程并 join，避免用例漏收尾或标志被其他用例干扰。
// 约定：用例在一轮 Launch 结束后即调 Stop() 主动收回线程，不把回收留给析构。
// 真实 AIV 算子在被测未发 FINISHED 时靠核上超时退出，本仿真线程没有该超时，
// 留到析构会让它在用例剩余部分继续轮询 msgQ，掩盖"被测该发 FINISHED 却没发"的问题。
class KfcServerHandle {
public:
    KfcServerHandle(uint64_t workspace, DumpStatMsgType responseMsgType, uint32_t result)
        : running_(std::make_shared<std::atomic<bool>>(true)),
          ready_(std::make_shared<std::atomic<bool>>(false)),
          consumed_(std::make_shared<std::atomic<uint32_t>>(0U)),
          exited_(std::make_shared<std::atomic<bool>>(false)),
          sawFinished_(std::make_shared<std::atomic<bool>>(false))
    {
        // 启动前先清收发区：各用例的 StubKFCDumpParam 是栈对象且地址被复用，
        // 上个用例的残留会被误判为新请求。被测在 Launch 内也会 memset，但发生在
        // 本线程启动之后，存在竞争窗口。
        (void)memset_s(reinterpret_cast<void*>(workspace), MSG_BODY_SIZE, 0, MSG_BODY_SIZE);
        thread_ = std::thread(
            KFCSeverProcess, workspace, responseMsgType, result, running_.get(), ready_.get(), consumed_.get(),
            exited_.get(), sawFinished_.get());
        // 等线程进入轮询再返回：被测代码的等待超时被缩短为 1s，
        // 若线程启动延迟超过该阈值，RcvMsg 会超时而非收到应答。
        while (!*ready_) {
            std::this_thread::yield();
        }
    }

    // 析构只回收线程，不做断言(gtest 断言不应在析构函数中执行)
    ~KfcServerHandle() { Join(); }

    KfcServerHandle(const KfcServerHandle&) = delete;
    KfcServerHandle& operator=(const KfcServerHandle&) = delete;

    // 停止并确认线程已正常退出，返回其实际应答的消息条数。
    // 用例可据此断言"桩确实干了活"，避免线程未消费任何消息却让用例静默通过。
    uint32_t Stop()
    {
        Join();
        EXPECT_TRUE(*exited_) << "kfc server thread did not exit normally";
        return *consumed_;
    }

    uint32_t Consumed() const { return *consumed_; }

    // 桩线程是否真正收到了 FINISHED 而自行退出（而非被 Stop() 的 running 标志强行收回）。
    // 这是"被测已通知 AIV 退出"的唯一可靠判据。
    bool SawFinished() const { return *sawFinished_; }

private:
    void Join()
    {
        if (thread_.joinable()) {
            *running_ = false;
            thread_.join();
        }
    }

    std::shared_ptr<std::atomic<bool>> running_;
    std::shared_ptr<std::atomic<bool>> ready_;
    std::shared_ptr<std::atomic<uint32_t>> consumed_;
    std::shared_ptr<std::atomic<bool>> exited_;
    std::shared_ptr<std::atomic<bool>> sawFinished_;
    std::thread thread_;
};

class KfcDumpServer_UT : public testing::Test {
protected:
    static void SetUpTestCase()
    {
        // 放开 DEBUG 级以覆盖被测代码内的各级日志分支
        dlog_setlevel(IDEDD, 0, 0);
        // 打桩超时阈值：由默认 30s 缩短为 1s，避免用例长时间阻塞。
        // 迁移前该行为由源码内 #ifdef RUN_TEST 控制，现改为打桩，源码不含测试分支。
        g_kfcDumpWaitTimeout = NSEC_PER_SEC;
        std::cout << "KfcDumpServer_UT SetUp" << std::endl;
    }
    static void TearDownTestCase()
    {
        g_kfcDumpWaitTimeout = DEFAULT_KFC_DUMP_WAIT_TIMEOUT;
        dlog_setlevel(IDEDD, 3, 0);
        std::cout << "KfcDumpServer_UT TearDown" << std::endl;
    }
    virtual void SetUp()
    {
        // 重置驱动打桩的 sq head/tail 计数器与 server 初始化状态，
        // 消除用例间的状态依赖（原 canndev UT 依赖执行顺序，存在跨用例污染）。
        ResetSqCqStub();
        ResetKfcCallbackStub();
        KfcDumpProcess::ResetForTest();
        std::cout << "KfcDumpServer_UT Test SetUp" << std::endl;
    }
    virtual void TearDown() { std::cout << "KfcDumpServer_UT Test TearDown" << std::endl; }
};

// ---------------------------------------------------------------------------
// Init 路径（迁移自 canndev InitKfcDumpInfo_*）
// ---------------------------------------------------------------------------
TEST_F(KfcDumpServer_UT, InitKfcDumpInfo_CHIP_CLOUD_V2_Success)
{
    StubKFCDumpParam kfcDumpParam;
    EXPECT_EQ(KFC_DUMP_SUCCESS, AdumpStatsOpSrvInit(&kfcDumpParam.initParam));
    // 初始化成功后对外状态应为已初始化；具体分派到哪个 sqe 构造函数属实现细节，
    // 由后续 AdumpStatsOpSrvLaunch_CHIP_* 用例通过实际执行通路验证。
    EXPECT_TRUE(AdumpStatsOpInitStatus());
}

TEST_F(KfcDumpServer_UT, InitKfcDumpInfo_CHIP_CLOUD_V4_Success)
{
    StubKFCDumpParam kfcDumpParam;
    kfcDumpParam.initParam.config.chipType = CHIP_CLOUD_V4;
    EXPECT_EQ(KFC_DUMP_SUCCESS, AdumpStatsOpSrvInit(&kfcDumpParam.initParam));
    EXPECT_TRUE(AdumpStatsOpInitStatus());
}

TEST_F(KfcDumpServer_UT, InitKfcDumpInfo_CHIP_DC_Success)
{
    StubKFCDumpParam kfcDumpParam;
    kfcDumpParam.initParam.config.chipType = CHIP_DC;
    EXPECT_EQ(KFC_DUMP_SUCCESS, AdumpStatsOpSrvInit(&kfcDumpParam.initParam));
    EXPECT_TRUE(AdumpStatsOpInitStatus());
}

TEST_F(KfcDumpServer_UT, InitKfcDumpInfo_CHIP_CLOUD_V5_Success)
{
    StubKFCDumpParam kfcDumpParam;
    kfcDumpParam.initParam.config.chipType = CHIP_CLOUD_V5;
    EXPECT_EQ(KFC_DUMP_SUCCESS, AdumpStatsOpSrvInit(&kfcDumpParam.initParam));
    EXPECT_TRUE(AdumpStatsOpInitStatus());
}

TEST_F(KfcDumpServer_UT, InitKfcDumpInfo_NotSupportChip)
{
    StubKFCDumpParam kfcDumpParam;
    kfcDumpParam.initParam.config.chipType = 0;
    EXPECT_EQ(KFC_DUMP_E_NOT_SUPPORT, AdumpStatsOpSrvInit(&kfcDumpParam.initParam));
}

// 驱动返回非法 sq 深度时必须在 Init 阶段拦截：LaunchTask 中的
// (tail + 1) % sqDepth 会因深度为 0 触发除零。
TEST_F(KfcDumpServer_UT, InitKfcDumpInfo_InvalidSqDepth)
{
    StubKFCDumpParam kfcDumpParam;
    SetStubSqDepth(0U);
    EXPECT_EQ(KFC_DUMP_E_DRIVE, AdumpStatsOpSrvInit(&kfcDumpParam.initParam));
    EXPECT_FALSE(AdumpStatsOpInitStatus());
}

// output 缓冲区小于 STAT_LEN 时必须在 Init 阶段拦截：
// UpdateDumpResult 会固定从该缓冲区读 STAT_LEN 字节，过小即为越界读。
TEST_F(KfcDumpServer_UT, InitKfcDumpInfo_OutputBufferTooSmall)
{
    StubKFCDumpParam kfcDumpParam;
    kfcDumpParam.initParam.kfcWorkSpace.outputSize = STAT_LEN - 1U;
    EXPECT_EQ(KFC_DUMP_E_PARA, AdumpStatsOpSrvInit(&kfcDumpParam.initParam));
    EXPECT_FALSE(AdumpStatsOpInitStatus());
}

// 恰好等于 STAT_LEN 时应通过（边界值）
TEST_F(KfcDumpServer_UT, InitKfcDumpInfo_OutputBufferAtLimit)
{
    StubKFCDumpParam kfcDumpParam;
    kfcDumpParam.initParam.kfcWorkSpace.outputSize = STAT_LEN;
    EXPECT_EQ(KFC_DUMP_SUCCESS, AdumpStatsOpSrvInit(&kfcDumpParam.initParam));
    EXPECT_TRUE(AdumpStatsOpInitStatus());
}

// msgQ 布局为 msgBody(MSG_BODY_SIZE) + syncSpace(每核 SYNC_SPACE_BYTES_PER_CORE)
// + 尾部 KfcDumpContext，故下限随 vectorCoreNum 变化，用例按同一公式推导而非硬编码。
static uint64_t ExpectedMinMsgQSize(const KfcDumpOpInitParam& initParam)
{
    return MSG_BODY_SIZE + initParam.config.vectorCoreNum * SYNC_SPACE_BYTES_PER_CORE + sizeof(KfcDumpContext);
}

// msgQ 小于下限时必须在 Init 阶段拦截：KfcDumpRunStatServer 按
// msgQ + msgQSize - sizeof(KfcDumpContext) 定位算子入参，syncSpace 又固定取
// msgQ + MSG_BODY_SIZE，尺寸不足时二者会越界或与消息区重叠。
TEST_F(KfcDumpServer_UT, InitKfcDumpInfo_MsgQSizeTooSmall)
{
    StubKFCDumpParam kfcDumpParam;
    kfcDumpParam.initParam.kfcWorkSpace.msgQSize = ExpectedMinMsgQSize(kfcDumpParam.initParam) - 1U;
    EXPECT_EQ(KFC_DUMP_E_PARA, AdumpStatsOpSrvInit(&kfcDumpParam.initParam));
    EXPECT_FALSE(AdumpStatsOpInitStatus());
}

// 恰好等于下限时应通过（边界值）
TEST_F(KfcDumpServer_UT, InitKfcDumpInfo_MsgQSizeAtLimit)
{
    StubKFCDumpParam kfcDumpParam;
    kfcDumpParam.initParam.kfcWorkSpace.msgQSize = ExpectedMinMsgQSize(kfcDumpParam.initParam);
    EXPECT_EQ(KFC_DUMP_SUCCESS, AdumpStatsOpSrvInit(&kfcDumpParam.initParam));
    EXPECT_TRUE(AdumpStatsOpInitStatus());
}

// 核数增大时下限同步抬高：按旧公式(不计 syncSpace)刚好够用的尺寸，在核数翻倍后必须被拦截。
// 否则 AIV 侧 SyncAllCoreG 会写出 syncSpace 之外，踩到尾部的算子入参。
TEST_F(KfcDumpServer_UT, InitKfcDumpInfo_MsgQSizeScalesWithCoreNum)
{
    StubKFCDumpParam kfcDumpParam;
    const uint64_t sizeForBaseCoreNum = ExpectedMinMsgQSize(kfcDumpParam.initParam);
    kfcDumpParam.initParam.kfcWorkSpace.msgQSize = sizeForBaseCoreNum;
    kfcDumpParam.initParam.config.vectorCoreNum *= 2U;
    EXPECT_EQ(KFC_DUMP_E_PARA, AdumpStatsOpSrvInit(&kfcDumpParam.initParam));
    EXPECT_FALSE(AdumpStatsOpInitStatus());
}

TEST_F(KfcDumpServer_UT, InitKfcDumpInfo_InitArgsIsNullptr)
{
    EXPECT_EQ(KFC_DUMP_E_PARA, AdumpStatsOpSrvInit(nullptr));
}

// vectorCoreNum/ubSize 由 host 侧平台查询透传到 AIV 参数，为 0 时 tiling 计算会除零
// 挂死 AICore，server 侧只能等到超时。必须在 Init 阶段拦截，不进入 tiling 计算。
TEST_F(KfcDumpServer_UT, InitKfcDumpInfo_ZeroVectorCoreNum)
{
    StubKFCDumpParam kfcDumpParam;
    kfcDumpParam.initParam.config.vectorCoreNum = 0;
    EXPECT_EQ(KFC_DUMP_E_PARA, AdumpStatsOpSrvInit(&kfcDumpParam.initParam));
    EXPECT_FALSE(AdumpStatsOpInitStatus());
}

TEST_F(KfcDumpServer_UT, InitKfcDumpInfo_ZeroUbSize)
{
    StubKFCDumpParam kfcDumpParam;
    kfcDumpParam.initParam.config.ubSize = 0;
    EXPECT_EQ(KFC_DUMP_E_PARA, AdumpStatsOpSrvInit(&kfcDumpParam.initParam));
    EXPECT_FALSE(AdumpStatsOpInitStatus());
}

// ---------------------------------------------------------------------------
// Launch 路径（迁移自 canndev AicpuKfcDumpSrvLaunch_*，按需求 U8 补强为
// 真正调用 AdumpStatsOpSrvLaunch 并断言返回值）
// ---------------------------------------------------------------------------
TEST_F(KfcDumpServer_UT, AdumpStatsOpSrvLaunch_CHIP_CLOUD_V2_Success)
{
    StubKFCDumpParam kfcDumpParam;
    uint64_t msgAddr = kfcDumpParam.initParam.kfcWorkSpace.msgQ;
    KfcServerHandle kfcServer(msgAddr, KFC_DUMP_MSG_RESPONSE, 0);
    KfcDumpTask kfcDumpTask;
    kfcDumpTask.streamId_ = 1;
    kfcDumpTask.taskId_ = 5;
    kfcDumpTask.index_ = 1;
    KfcDumpInfo kfcDumpInfo = GetDumpInfo(kfcDumpTask);
    g_kfcDumpInfo = &kfcDumpInfo;
    EXPECT_EQ(KFC_DUMP_SUCCESS, AdumpStatsOpSrvInit(&kfcDumpParam.initParam));
    EXPECT_EQ(KFC_DUMP_SUCCESS, AdumpStatsOpSrvLaunch(reinterpret_cast<void*>(&kfcDumpTask)));
    (void)kfcServer.Stop();
}

TEST_F(KfcDumpServer_UT, AdumpStatsOpSrvLaunch_CHIP_CLOUD_V4_Success)
{
    StubKFCDumpParam kfcDumpParam;
    uint64_t msgAddr = kfcDumpParam.initParam.kfcWorkSpace.msgQ;
    KfcServerHandle kfcServer(msgAddr, KFC_DUMP_MSG_RESPONSE, 0);
    KfcDumpTask kfcDumpTask;
    kfcDumpTask.streamId_ = 1;
    kfcDumpTask.taskId_ = 15;
    kfcDumpTask.index_ = 1;
    KfcDumpInfo kfcDumpInfo = GetDumpInfo(kfcDumpTask);
    g_kfcDumpInfo = &kfcDumpInfo;
    kfcDumpParam.initParam.config.chipType = CHIP_CLOUD_V4;
    EXPECT_EQ(KFC_DUMP_SUCCESS, AdumpStatsOpSrvInit(&kfcDumpParam.initParam));
    EXPECT_EQ(KFC_DUMP_SUCCESS, AdumpStatsOpSrvLaunch(reinterpret_cast<void*>(&kfcDumpTask)));
    (void)kfcServer.Stop();
    rtDavidStarsAicAivSqeCloudV4 sqe = {};
    AddStatDumpTaskCloudV4(reinterpret_cast<uint8_t*>(&sqe), &kfcDumpParam.initParam, &kfcDumpParam.dumpContext);
    KfcDumpPrintf::PrintSqeCloudV4(reinterpret_cast<uint8_t*>(&sqe));
}

TEST_F(KfcDumpServer_UT, AdumpStatsOpSrvLaunch_CHIP_CLOUD_V5_Success)
{
    StubKFCDumpParam kfcDumpParam;
    uint64_t msgAddr = kfcDumpParam.initParam.kfcWorkSpace.msgQ;
    KfcServerHandle kfcServer(msgAddr, KFC_DUMP_MSG_RESPONSE, 0);
    KfcDumpTask kfcDumpTask;
    kfcDumpTask.streamId_ = 1;
    kfcDumpTask.taskId_ = 16;
    kfcDumpTask.index_ = 1;
    KfcDumpInfo kfcDumpInfo = GetDumpInfo(kfcDumpTask);
    g_kfcDumpInfo = &kfcDumpInfo;
    kfcDumpParam.initParam.config.chipType = CHIP_CLOUD_V5;
    EXPECT_EQ(KFC_DUMP_SUCCESS, AdumpStatsOpSrvInit(&kfcDumpParam.initParam));
    EXPECT_EQ(KFC_DUMP_SUCCESS, AdumpStatsOpSrvLaunch(reinterpret_cast<void*>(&kfcDumpTask)));
    (void)kfcServer.Stop();
    rtDavidStarsAicAivSqeCloudV5 sqe = {};
    AddStatDumpTaskCloudV5(reinterpret_cast<uint8_t*>(&sqe), &kfcDumpParam.initParam, &kfcDumpParam.dumpContext);
    // blockDim 取 dumpContext.aiCoreNum；blockDim >= 2 时 groupDim 为默认值 2
    EXPECT_EQ(1U, sqe.header.type); // AIV 任务
    EXPECT_EQ(static_cast<uint16_t>(kfcDumpParam.dumpContext.aiCoreNum), sqe.header.blockDim);
    EXPECT_EQ(GROUP_DIM_DEFAULT, sqe.groupDim);
    EXPECT_EQ(sqe.header.blockDim / sqe.groupDim, sqe.groupBlockdim);
    EXPECT_NE(0U, sqe.groupBlockdim);
    EXPECT_EQ(KERNEL_TIMEOUT_CONSTANT, sqe.kernelCredit);
    KfcDumpPrintf::PrintSqeCloudV4(reinterpret_cast<uint8_t*>(&sqe));
}

TEST_F(KfcDumpServer_UT, AdumpStatsOpSrvLaunch_CHIP_DC_Success)
{
    StubKFCDumpParam kfcDumpParam;
    uint64_t msgAddr = kfcDumpParam.initParam.kfcWorkSpace.msgQ;
    KfcServerHandle kfcServer(msgAddr, KFC_DUMP_MSG_RESPONSE, 0);
    KfcDumpTask kfcDumpTask;
    kfcDumpTask.streamId_ = 1;
    kfcDumpTask.taskId_ = 2;
    kfcDumpTask.index_ = 1;
    KfcDumpInfo kfcDumpInfo = GetDumpInfo(kfcDumpTask);
    g_kfcDumpInfo = &kfcDumpInfo;
    kfcDumpParam.initParam.config.chipType = CHIP_DC;
    EXPECT_EQ(KFC_DUMP_SUCCESS, AdumpStatsOpSrvInit(&kfcDumpParam.initParam));
    EXPECT_EQ(KFC_DUMP_SUCCESS, AdumpStatsOpSrvLaunch(reinterpret_cast<void*>(&kfcDumpTask)));
    (void)kfcServer.Stop();
}

TEST_F(KfcDumpServer_UT, AdumpStatsOpSrvLaunch_NoInputTensor)
{
    StubKFCDumpParam kfcDumpParam;
    uint64_t msgAddr = kfcDumpParam.initParam.kfcWorkSpace.msgQ;
    KfcServerHandle kfcServer(msgAddr, KFC_DUMP_MSG_RESPONSE, 0);
    KfcDumpTask kfcDumpTask;
    kfcDumpTask.streamId_ = 1;
    kfcDumpTask.taskId_ = 0;
    kfcDumpTask.index_ = 1;
    KfcDumpInfo kfcDumpInfo = GetDumpInfo(kfcDumpTask);
    g_kfcDumpInfo = &kfcDumpInfo;
    EXPECT_EQ(KFC_DUMP_SUCCESS, AdumpStatsOpSrvInit(&kfcDumpParam.initParam));
    EXPECT_EQ(KFC_DUMP_SUCCESS, AdumpStatsOpSrvLaunch(reinterpret_cast<void*>(&kfcDumpTask)));
    (void)kfcServer.Stop();
}

TEST_F(KfcDumpServer_UT, AdumpStatsOpSrvLaunch_NoOutputTensor)
{
    StubKFCDumpParam kfcDumpParam;
    uint64_t msgAddr = kfcDumpParam.initParam.kfcWorkSpace.msgQ;
    KfcServerHandle kfcServer(msgAddr, KFC_DUMP_MSG_RESPONSE, 0);
    KfcDumpTask kfcDumpTask;
    kfcDumpTask.streamId_ = 1;
    kfcDumpTask.taskId_ = 1;
    kfcDumpTask.index_ = 1;
    KfcDumpInfo kfcDumpInfo = GetDumpInfo(kfcDumpTask);
    g_kfcDumpInfo = &kfcDumpInfo;
    EXPECT_EQ(KFC_DUMP_SUCCESS, AdumpStatsOpSrvInit(&kfcDumpParam.initParam));
    EXPECT_EQ(KFC_DUMP_SUCCESS, AdumpStatsOpSrvLaunch(reinterpret_cast<void*>(&kfcDumpTask)));
    (void)kfcServer.Stop();
}

// input 与 output 均为空：直接返回成功，不拉起 AIV 算子。
// 若不提前返回，被测会下发 SQE 拉起算子却一条 REQUEST 都不发，
// 随后的 FINISHED 与 WaitTaskFinish 纯属为空任务付出的开销。
// 判据：应答线程全程未消费任何消息，即被测未进入消息收发。
TEST_F(KfcDumpServer_UT, AdumpStatsOpSrvLaunch_NoTensorAtAll)
{
    StubKFCDumpParam kfcDumpParam;
    KfcServerHandle kfcServer(kfcDumpParam.initParam.kfcWorkSpace.msgQ, KFC_DUMP_MSG_RESPONSE, 0);
    KfcDumpTask kfcDumpTask(1, 2, 1);
    // 桩的 GetDumpInfo 按 taskId 至少产出一类 tensor，此处直接构造空 tensor 列表
    KfcDumpInfo emptyDumpInfo;
    emptyDumpInfo.opName = "OP_EMPTY";
    emptyDumpInfo.opType = "AIV";
    g_kfcDumpInfo = &emptyDumpInfo;
    EXPECT_EQ(KFC_DUMP_SUCCESS, AdumpStatsOpSrvInit(&kfcDumpParam.initParam));
    EXPECT_EQ(KFC_DUMP_SUCCESS, AdumpStatsOpSrvLaunch(reinterpret_cast<void*>(&kfcDumpTask)));
    EXPECT_EQ(0U, kfcServer.Stop());
}

TEST_F(KfcDumpServer_UT, AdumpStatsOpSrvLaunch_NotSupportChip)
{
    StubKFCDumpParam kfcDumpParam;
    uint64_t msgAddr = kfcDumpParam.initParam.kfcWorkSpace.msgQ;
    KfcDumpTask kfcDumpTask;
    kfcDumpTask.streamId_ = 1;
    kfcDumpTask.taskId_ = 2;
    kfcDumpTask.index_ = 1;
    KfcDumpInfo kfcDumpInfo = GetDumpInfo(kfcDumpTask);
    g_kfcDumpInfo = &kfcDumpInfo;
    kfcDumpParam.initParam.config.chipType = 0;
    EXPECT_EQ(KFC_DUMP_E_NOT_SUPPORT, AdumpStatsOpSrvInit(&kfcDumpParam.initParam));
    EXPECT_FALSE(AdumpStatsOpInitStatus());
    // 未初始化即 Launch，返回 KFC_DUMP_E_INTERNAL（kfc_dump_process.cpp KfcDumpRunStatServer）
    EXPECT_EQ(KFC_DUMP_E_INTERNAL, AdumpStatsOpSrvLaunch(reinterpret_cast<void*>(&kfcDumpTask)));
    KfcServerHandle kfcServer(msgAddr, KFC_DUMP_MSG_RESPONSE, 0);
    // 未初始化即 Launch 不会下发算子，线程无消息可消费，建后即收
    EXPECT_EQ(0U, kfcServer.Stop());
}

// shape 维数超过 SHAPE_SIZE 时必须报错返回，否则会越界覆写 OpStatsResult。
TEST_F(KfcDumpServer_UT, AdumpStatsOpSrvLaunch_ShapeSizeExceedsLimit)
{
    StubKFCDumpParam kfcDumpParam;
    uint64_t msgAddr = kfcDumpParam.initParam.kfcWorkSpace.msgQ;
    KfcServerHandle kfcServer(msgAddr, KFC_DUMP_MSG_RESPONSE, 0);
    SetStubShapeDims(SHAPE_SIZE + 1U);
    KfcDumpTask kfcDumpTask;
    kfcDumpTask.streamId_ = 1;
    kfcDumpTask.taskId_ = 2;
    kfcDumpTask.index_ = 1;
    KfcDumpInfo kfcDumpInfo = GetDumpInfo(kfcDumpTask);
    g_kfcDumpInfo = &kfcDumpInfo;
    EXPECT_EQ(KFC_DUMP_SUCCESS, AdumpStatsOpSrvInit(&kfcDumpParam.initParam));
    EXPECT_EQ(KFC_DUMP_E_PARA, AdumpStatsOpSrvLaunch(reinterpret_cast<void*>(&kfcDumpTask)));
    (void)kfcServer.Stop();
}

// 恰好等于上限时应正常处理（边界值）
TEST_F(KfcDumpServer_UT, AdumpStatsOpSrvLaunch_ShapeSizeAtLimit)
{
    StubKFCDumpParam kfcDumpParam;
    uint64_t msgAddr = kfcDumpParam.initParam.kfcWorkSpace.msgQ;
    KfcServerHandle kfcServer(msgAddr, KFC_DUMP_MSG_RESPONSE, 0);
    SetStubShapeDims(SHAPE_SIZE);
    KfcDumpTask kfcDumpTask;
    kfcDumpTask.streamId_ = 1;
    kfcDumpTask.taskId_ = 2;
    kfcDumpTask.index_ = 1;
    KfcDumpInfo kfcDumpInfo = GetDumpInfo(kfcDumpTask);
    g_kfcDumpInfo = &kfcDumpInfo;
    EXPECT_EQ(KFC_DUMP_SUCCESS, AdumpStatsOpSrvInit(&kfcDumpParam.initParam));
    EXPECT_EQ(KFC_DUMP_SUCCESS, AdumpStatsOpSrvLaunch(reinterpret_cast<void*>(&kfcDumpTask)));
    (void)kfcServer.Stop();
}

// blockDim 小于 2 时 groupDim 必须降为 1，否则 groupBlockdim 整除为 0，硬件调度异常
TEST_F(KfcDumpServer_UT, AddStatDumpTaskCloudV5_SmallBlockDim)
{
    StubKFCDumpParam kfcDumpParam;
    for (uint64_t coreNum = 0U; coreNum < 2U; ++coreNum) {
        kfcDumpParam.dumpContext.aiCoreNum = coreNum;
        rtDavidStarsAicAivSqeCloudV5 sqe = {};
        AddStatDumpTaskCloudV5(reinterpret_cast<uint8_t*>(&sqe), &kfcDumpParam.initParam, &kfcDumpParam.dumpContext);
        EXPECT_EQ(static_cast<uint16_t>(coreNum), sqe.header.blockDim);
        EXPECT_EQ(1U, sqe.groupDim);
        EXPECT_EQ(static_cast<uint16_t>(coreNum), sqe.groupBlockdim);
    }
}

// ---------------------------------------------------------------------------
// 新增：Launch 参数校验
// ---------------------------------------------------------------------------
TEST_F(KfcDumpServer_UT, AdumpStatsOpSrvLaunch_ArgsIsNullptr)
{
    EXPECT_EQ(KFC_DUMP_E_PARA, AdumpStatsOpSrvLaunch(nullptr));
}

// ---------------------------------------------------------------------------
// 新增：AdumpStatsOpInitStatus 状态语义（U5）
// ---------------------------------------------------------------------------
TEST_F(KfcDumpServer_UT, AdumpStatsOpInitStatus_FalseBeforeInit) { EXPECT_FALSE(AdumpStatsOpInitStatus()); }

TEST_F(KfcDumpServer_UT, AdumpStatsOpInitStatus_TrueAfterInitSuccess)
{
    StubKFCDumpParam kfcDumpParam;
    EXPECT_EQ(KFC_DUMP_SUCCESS, AdumpStatsOpSrvInit(&kfcDumpParam.initParam));
    EXPECT_TRUE(AdumpStatsOpInitStatus());
}

TEST_F(KfcDumpServer_UT, AdumpStatsOpInitStatus_FalseWhenInitNullptr)
{
    EXPECT_EQ(KFC_DUMP_E_PARA, AdumpStatsOpSrvInit(nullptr));
    EXPECT_FALSE(AdumpStatsOpInitStatus());
}

TEST_F(KfcDumpServer_UT, AdumpStatsOpInitStatus_FalseWhenInitNotSupport)
{
    StubKFCDumpParam kfcDumpParam;
    kfcDumpParam.initParam.config.chipType = 0;
    EXPECT_EQ(KFC_DUMP_E_NOT_SUPPORT, AdumpStatsOpSrvInit(&kfcDumpParam.initParam));
    // Init 失败时保持 false，使 AICPU 侧可回落旧流程（设计 T1 决议）
    EXPECT_FALSE(AdumpStatsOpInitStatus());
}

TEST_F(KfcDumpServer_UT, AdumpStatsOpInitStatus_IdempotentOnRepeatInit)
{
    StubKFCDumpParam kfcDumpParam;
    EXPECT_EQ(KFC_DUMP_SUCCESS, AdumpStatsOpSrvInit(&kfcDumpParam.initParam));
    EXPECT_TRUE(AdumpStatsOpInitStatus());
    EXPECT_EQ(KFC_DUMP_SUCCESS, AdumpStatsOpSrvInit(&kfcDumpParam.initParam));
    EXPECT_TRUE(AdumpStatsOpInitStatus());
}

// ---------------------------------------------------------------------------
// 新增：SQE 构造与打点（覆盖 V1/V2 分支）
// ---------------------------------------------------------------------------
TEST_F(KfcDumpServer_UT, AddOneStatDumpTask_V1AndV2)
{
    StubKFCDumpParam kfcDumpParam;
    rtFftsPlusKernelSqe_t sqeV1 = {};
    AddOneStatDumpTaskV1(reinterpret_cast<uint8_t*>(&sqeV1), &kfcDumpParam.initParam, &kfcDumpParam.dumpContext);
    KfcDumpPrintf::PrintSqeV1(reinterpret_cast<uint8_t*>(&sqeV1));

    hwts_kernel_sqe_t sqeV2 = {};
    AddOneStatDumpTaskV2(reinterpret_cast<uint8_t*>(&sqeV2), &kfcDumpParam.initParam, &kfcDumpParam.dumpContext);
    KfcDumpPrintf::PrintSqeV2(reinterpret_cast<uint8_t*>(&sqeV2));
}

// Init 阶段：devId 转换失败
TEST_F(KfcDumpServer_UT, InitKfcDumpInfo_DevIdConvertFail)
{
    StubKFCDumpParam kfcDumpParam;
    SetStubDevIdConvertFail(true);
    EXPECT_EQ(KFC_DUMP_E_DRIVE, AdumpStatsOpSrvInit(&kfcDumpParam.initParam));
    EXPECT_FALSE(AdumpStatsOpInitStatus());
}

// Init 阶段：查询 SQ 基址 / 深度 / head / tail 分别失败
TEST_F(KfcDumpServer_UT, InitKfcDumpInfo_SqQueryFail)
{
    const int32_t props[] = {
        DRV_SQCQ_PROP_SQ_BASE, DRV_SQCQ_PROP_SQ_DEPTH, DRV_SQCQ_PROP_SQ_HEAD, DRV_SQCQ_PROP_SQ_TAIL};
    for (int32_t prop : props) {
        ResetSqCqStub();
        KfcDumpProcess::ResetForTest();
        StubKFCDumpParam kfcDumpParam;
        SetStubSqQueryFailProp(prop);
        EXPECT_EQ(KFC_DUMP_E_DRIVE, AdumpStatsOpSrvInit(&kfcDumpParam.initParam)) << "failed prop: " << prop;
        EXPECT_FALSE(AdumpStatsOpInitStatus());
    }
}

// Launch 阶段：AicpuGetOpTaskInfo 返回失败
TEST_F(KfcDumpServer_UT, AdumpStatsOpSrvLaunch_GetOpTaskInfoFail)
{
    StubKFCDumpParam kfcDumpParam;
    EXPECT_EQ(KFC_DUMP_SUCCESS, AdumpStatsOpSrvInit(&kfcDumpParam.initParam));
    KfcDumpTask kfcDumpTask(1, 2, 1);
    SetStubGetOpTaskInfoFail(true);
    EXPECT_NE(KFC_DUMP_SUCCESS, AdumpStatsOpSrvLaunch(reinterpret_cast<void*>(&kfcDumpTask)));
}

// Launch 阶段：AicpuGetOpTaskInfo 返回成功但回填空指针
TEST_F(KfcDumpServer_UT, AdumpStatsOpSrvLaunch_GetOpTaskInfoNull)
{
    StubKFCDumpParam kfcDumpParam;
    EXPECT_EQ(KFC_DUMP_SUCCESS, AdumpStatsOpSrvInit(&kfcDumpParam.initParam));
    KfcDumpTask kfcDumpTask(1, 2, 1);
    SetStubGetOpTaskInfoNull(true);
    EXPECT_EQ(KFC_DUMP_E_INTERNAL, AdumpStatsOpSrvLaunch(reinterpret_cast<void*>(&kfcDumpTask)));
}

// Launch 阶段：结果上报失败(AicpuDumpOpTaskData 返回非 0)
// tensorNum=20 且 STEP_COUNT=10，故失败点在满 STEP 上报处，即算子已拉起之后 ——
// 属于必须补发 FINISHED 的路径。
TEST_F(KfcDumpServer_UT, AdumpStatsOpSrvLaunch_PostDumpResultsFail)
{
    StubKFCDumpParam kfcDumpParam;
    KfcServerHandle kfcServer(kfcDumpParam.initParam.kfcWorkSpace.msgQ, KFC_DUMP_MSG_RESPONSE, 0);
    KfcDumpTask kfcDumpTask(1, 2, 1);
    KfcDumpInfo kfcDumpInfo = GetDumpInfo(kfcDumpTask);
    g_kfcDumpInfo = &kfcDumpInfo;
    EXPECT_EQ(KFC_DUMP_SUCCESS, AdumpStatsOpSrvInit(&kfcDumpParam.initParam));
    SetStubDumpOpTaskDataFail(true);
    EXPECT_EQ(KFC_DUMP_E_INTERNAL, AdumpStatsOpSrvLaunch(reinterpret_cast<void*>(&kfcDumpTask)));
    (void)kfcServer.Stop();
    EXPECT_TRUE(kfcServer.SawFinished()) << "上报失败后未发 FINISHED，AIV 实例将永久占核";
}

// Launch 阶段：SQ 下发时 halSqCqConfig 失败
TEST_F(KfcDumpServer_UT, AdumpStatsOpSrvLaunch_SqConfigFail)
{
    StubKFCDumpParam kfcDumpParam;
    KfcDumpTask kfcDumpTask(1, 2, 1);
    KfcDumpInfo kfcDumpInfo = GetDumpInfo(kfcDumpTask);
    g_kfcDumpInfo = &kfcDumpInfo;
    EXPECT_EQ(KFC_DUMP_SUCCESS, AdumpStatsOpSrvInit(&kfcDumpParam.initParam));
    SetStubSqConfigFail(true);
    EXPECT_EQ(KFC_DUMP_E_DRIVE, AdumpStatsOpSrvLaunch(reinterpret_cast<void*>(&kfcDumpTask)));
}

// Launch 阶段：AIV 不应答, RcvMsg 等待超时(超时阈值已在 SetUpTestCase 缩短为 1s)
TEST_F(KfcDumpServer_UT, AdumpStatsOpSrvLaunch_RcvMsgTimeout)
{
    StubKFCDumpParam kfcDumpParam;
    KfcDumpTask kfcDumpTask(1, 2, 1);
    KfcDumpInfo kfcDumpInfo = GetDumpInfo(kfcDumpTask);
    g_kfcDumpInfo = &kfcDumpInfo;
    EXPECT_EQ(KFC_DUMP_SUCCESS, AdumpStatsOpSrvInit(&kfcDumpParam.initParam));
    // 不启动应答线程, RcvMsg 轮询不到 valid 即超时
    EXPECT_EQ(KFC_DUMP_E_TIMEOUT, AdumpStatsOpSrvLaunch(reinterpret_cast<void*>(&kfcDumpTask)));
}

// Launch 阶段：AIV 回非 RESPONSE 消息类型
TEST_F(KfcDumpServer_UT, AdumpStatsOpSrvLaunch_UnexpectedMsgType)
{
    StubKFCDumpParam kfcDumpParam;
    KfcServerHandle kfcServer(kfcDumpParam.initParam.kfcWorkSpace.msgQ, KFC_DUMP_MSG_FINISHED, 0);
    KfcDumpTask kfcDumpTask(1, 2, 1);
    KfcDumpInfo kfcDumpInfo = GetDumpInfo(kfcDumpTask);
    g_kfcDumpInfo = &kfcDumpInfo;
    EXPECT_EQ(KFC_DUMP_SUCCESS, AdumpStatsOpSrvInit(&kfcDumpParam.initParam));
    EXPECT_EQ(KFC_DUMP_E_PARA, AdumpStatsOpSrvLaunch(reinterpret_cast<void*>(&kfcDumpTask)));
    (void)kfcServer.Stop();
}

// Launch 阶段：AIV 应答携带失败结果(result != 0), 走 CheckDumpResult 的 WARN 分支
TEST_F(KfcDumpServer_UT, AdumpStatsOpSrvLaunch_ResponseWithFailedResult)
{
    StubKFCDumpParam kfcDumpParam;
    KfcServerHandle kfcServer(kfcDumpParam.initParam.kfcWorkSpace.msgQ, KFC_DUMP_MSG_RESPONSE, 1);
    KfcDumpTask kfcDumpTask(1, 2, 1);
    KfcDumpInfo kfcDumpInfo = GetDumpInfo(kfcDumpTask);
    g_kfcDumpInfo = &kfcDumpInfo;
    EXPECT_EQ(KFC_DUMP_SUCCESS, AdumpStatsOpSrvInit(&kfcDumpParam.initParam));
    EXPECT_EQ(KFC_DUMP_SUCCESS, AdumpStatsOpSrvLaunch(reinterpret_cast<void*>(&kfcDumpTask)));
    (void)kfcServer.Stop();
}

// Launch 阶段：tensor 的 shape 维数超过 SHAPE_SIZE 上限
TEST_F(KfcDumpServer_UT, AdumpStatsOpSrvLaunch_ShapeSizeExceedLimit)
{
    StubKFCDumpParam kfcDumpParam;
    KfcServerHandle kfcServer(kfcDumpParam.initParam.kfcWorkSpace.msgQ, KFC_DUMP_MSG_RESPONSE, 0);
    SetStubShapeDims(SHAPE_SIZE + 1);
    KfcDumpTask kfcDumpTask(1, 2, 1);
    KfcDumpInfo kfcDumpInfo = GetDumpInfo(kfcDumpTask);
    g_kfcDumpInfo = &kfcDumpInfo;
    EXPECT_EQ(KFC_DUMP_SUCCESS, AdumpStatsOpSrvInit(&kfcDumpParam.initParam));
    EXPECT_EQ(KFC_DUMP_E_PARA, AdumpStatsOpSrvLaunch(reinterpret_cast<void*>(&kfcDumpTask)));
    (void)kfcServer.Stop();
}

// Launch 阶段：SQ 满且 head 不前进, LaunchTask 等待空闲槽位超时
TEST_F(KfcDumpServer_UT, AdumpStatsOpSrvLaunch_SqFullTimeout)
{
    StubKFCDumpParam kfcDumpParam;
    KfcDumpTask kfcDumpTask(1, 2, 1);
    KfcDumpInfo kfcDumpInfo = GetDumpInfo(kfcDumpTask);
    g_kfcDumpInfo = &kfcDumpInfo;
    // sq 深度设为 2, 使 Init 查得 head/tail 后队列即判满; 再固定 head 使其永不前进
    SetStubSqDepth(2U);
    EXPECT_EQ(KFC_DUMP_SUCCESS, AdumpStatsOpSrvInit(&kfcDumpParam.initParam));
    SetStubFixedSqHead(0);
    EXPECT_EQ(KFC_DUMP_E_TIMEOUT, AdumpStatsOpSrvLaunch(reinterpret_cast<void*>(&kfcDumpTask)));
}

// RcvMsg 空参
TEST_F(KfcDumpServer_UT, RcvMsg_NullArgs)
{
    StubKFCDumpParam kfcDumpParam;
    KfcDumpStatsServer dump;
    dump.Init(kfcDumpParam.initParam.kfcWorkSpace.msgQ);
    EXPECT_EQ(KFC_DUMP_E_PARA, dump.RcvMsg(nullptr));
}

// 一次 AdumpStatsOpSrvInit + 多次 AdumpStatsOpSrvLaunch（真机形态）
// 各次 Launch 复用同一块 msgQ，且内部会重置游标、清零 msgQ、复位 g_tensorCount。
// AIV 算子的生命周期为一次 Launch（末尾发 FINISHED 令其退出），故每次 Launch
// 需配一个独立应答线程。这些复位是否生效，只有连续调用才能观测到。

// 连续 5 次 Launch 均成功，每次由独立的应答线程服务
TEST_F(KfcDumpServer_UT, AdumpStatsOpSrvLaunch_RepeatedCallsAllSucceed)
{
    StubKFCDumpParam kfcDumpParam;
    KfcDumpTask kfcDumpTask(1, 2, 1);
    KfcDumpInfo kfcDumpInfo = GetDumpInfo(kfcDumpTask);
    g_kfcDumpInfo = &kfcDumpInfo;
    EXPECT_EQ(KFC_DUMP_SUCCESS, AdumpStatsOpSrvInit(&kfcDumpParam.initParam));

    const uint32_t perRound =
        static_cast<uint32_t>(kfcDumpInfo.inputDumpInfo.size() + kfcDumpInfo.outputDumpInfo.size());
    for (uint32_t i = 0; i < 5U; i++) {
        KfcServerHandle kfcServer(kfcDumpParam.initParam.kfcWorkSpace.msgQ, KFC_DUMP_MSG_RESPONSE, 0);
        EXPECT_EQ(KFC_DUMP_SUCCESS, AdumpStatsOpSrvLaunch(reinterpret_cast<void*>(&kfcDumpTask)))
            << "failed at launch round " << i;
        // 每轮应答条数不应少于该轮 tensor 数(逐 tensor 一问一答)。
        // 用 GE 的原因同 RepeatedCallsWithDifferentTasks 中的说明：绕回时桩可能多计 1 条。
        EXPECT_GE(kfcServer.Stop(), perRound) << "reply count too low at round " << i;
    }
}

// 连续 Launch 复用同一块 msgQ，地址不变且不影响正确性
TEST_F(KfcDumpServer_UT, AdumpStatsOpSrvLaunch_RepeatedCallsReuseSameMsgQ)
{
    StubKFCDumpParam kfcDumpParam;
    const uint64_t msgAddr = kfcDumpParam.initParam.kfcWorkSpace.msgQ;
    KfcDumpTask kfcDumpTask(1, 2, 1);
    KfcDumpInfo kfcDumpInfo = GetDumpInfo(kfcDumpTask);
    g_kfcDumpInfo = &kfcDumpInfo;
    EXPECT_EQ(KFC_DUMP_SUCCESS, AdumpStatsOpSrvInit(&kfcDumpParam.initParam));

    for (uint32_t i = 0; i < 3U; i++) {
        KfcServerHandle kfcServer(msgAddr, KFC_DUMP_MSG_RESPONSE, 0);
        EXPECT_EQ(KFC_DUMP_SUCCESS, AdumpStatsOpSrvLaunch(reinterpret_cast<void*>(&kfcDumpTask)));
        (void)kfcServer.Stop();
        // 全过程复用同一块 msgQ
        EXPECT_EQ(msgAddr, kfcDumpParam.initParam.kfcWorkSpace.msgQ);
    }
}

// 连续 Launch 使用不同 task(tensor 组合不同)，验证上一次的 tensor 状态不残留
TEST_F(KfcDumpServer_UT, AdumpStatsOpSrvLaunch_RepeatedCallsWithDifferentTasks)
{
    StubKFCDumpParam kfcDumpParam;
    EXPECT_EQ(KFC_DUMP_SUCCESS, AdumpStatsOpSrvInit(&kfcDumpParam.initParam));

    // taskId=2 为 input+output 双向；taskId=0 仅 output；taskId=1 仅 input
    const uint32_t taskIds[] = {2U, 0U, 1U, 2U};
    for (uint32_t taskId : taskIds) {
        KfcDumpTask task(1U, taskId, 1U);
        KfcDumpInfo info = GetDumpInfo(task);
        g_kfcDumpInfo = &info;
        KfcServerHandle kfcServer(kfcDumpParam.initParam.kfcWorkSpace.msgQ, KFC_DUMP_MSG_RESPONSE, 0);
        EXPECT_EQ(KFC_DUMP_SUCCESS, AdumpStatsOpSrvLaunch(reinterpret_cast<void*>(&task)))
            << "failed at taskId " << taskId;
        const uint32_t expect = static_cast<uint32_t>(info.inputDumpInfo.size() + info.outputDumpInfo.size());
        // 用 GE 而非 EQ：tensor 数超过 DUMP_MSG_CNT 发生绕回时，桩可能把槽位残留的
        // REQUEST 多消费一次。被测已收齐全部应答并成功返回，属桩的固有局限。
        EXPECT_GE(kfcServer.Stop(), expect) << "reply count too low at taskId " << taskId;
    }
}

// 中途一次 Launch 失败后，后续 Launch 仍能正常工作(失败不污染后续调用)
TEST_F(KfcDumpServer_UT, AdumpStatsOpSrvLaunch_RecoversAfterFailedCall)
{
    StubKFCDumpParam kfcDumpParam;
    KfcDumpTask kfcDumpTask(1, 2, 1);
    KfcDumpInfo kfcDumpInfo = GetDumpInfo(kfcDumpTask);
    g_kfcDumpInfo = &kfcDumpInfo;
    EXPECT_EQ(KFC_DUMP_SUCCESS, AdumpStatsOpSrvInit(&kfcDumpParam.initParam));

    {
        KfcServerHandle kfcServer(kfcDumpParam.initParam.kfcWorkSpace.msgQ, KFC_DUMP_MSG_RESPONSE, 0);
        EXPECT_EQ(KFC_DUMP_SUCCESS, AdumpStatsOpSrvLaunch(reinterpret_cast<void*>(&kfcDumpTask)));
        (void)kfcServer.Stop();
    }

    // 注入回调失败：本次 Launch 在取 tensor 信息阶段即失败，未进入消息收发
    SetStubGetOpTaskInfoFail(true);
    EXPECT_NE(KFC_DUMP_SUCCESS, AdumpStatsOpSrvLaunch(reinterpret_cast<void*>(&kfcDumpTask)));
    SetStubGetOpTaskInfoFail(false);

    // 失败不应污染后续调用
    {
        KfcServerHandle kfcServer(kfcDumpParam.initParam.kfcWorkSpace.msgQ, KFC_DUMP_MSG_RESPONSE, 0);
        EXPECT_EQ(KFC_DUMP_SUCCESS, AdumpStatsOpSrvLaunch(reinterpret_cast<void*>(&kfcDumpTask)));
        (void)kfcServer.Stop();
    }
}

// 统计过程失败时仍须发出 FINISHED 令 AIV 退出，否则该实例永久占核，
// 且下一次 Launch 会再拉起一个实例，两者互抢消息。
// 判据：SawFinished() —— 桩线程必须是"见到 FINISHED 自行退出"，而非被 Stop() 强行收回。
TEST_F(KfcDumpServer_UT, AdumpStatsOpSrvLaunch_PostsFinishedEvenWhenFailed)
{
    StubKFCDumpParam kfcDumpParam;
    KfcDumpTask kfcDumpTask(1, 2, 1);
    KfcDumpInfo kfcDumpInfo = GetDumpInfo(kfcDumpTask);
    g_kfcDumpInfo = &kfcDumpInfo;
    EXPECT_EQ(KFC_DUMP_SUCCESS, AdumpStatsOpSrvInit(&kfcDumpParam.initParam));

    // 应答携带非预期类型使 KfcDumpStatClientProcess 返回 E_PARA
    KfcServerHandle kfcServer(kfcDumpParam.initParam.kfcWorkSpace.msgQ, KFC_DUMP_MSG_FINISHED, 0);
    // 失败仍保留首个错误码(E_PARA)，而非被 FINISHED 的收尾结果掩盖
    EXPECT_EQ(KFC_DUMP_E_PARA, AdumpStatsOpSrvLaunch(reinterpret_cast<void*>(&kfcDumpTask)));
    (void)kfcServer.Stop();
    EXPECT_TRUE(kfcServer.SawFinished()) << "统计阶段失败后未发 FINISHED，AIV 实例将永久占核";
}

// 上一次 Launch 失败后，下一次 Launch 仍能正常完成 —— 验证失败不残留 AIV 实例
TEST_F(KfcDumpServer_UT, AdumpStatsOpSrvLaunch_NextLaunchOkAfterFailure)
{
    StubKFCDumpParam kfcDumpParam;
    KfcDumpTask kfcDumpTask(1, 2, 1);
    KfcDumpInfo kfcDumpInfo = GetDumpInfo(kfcDumpTask);
    g_kfcDumpInfo = &kfcDumpInfo;
    EXPECT_EQ(KFC_DUMP_SUCCESS, AdumpStatsOpSrvInit(&kfcDumpParam.initParam));

    {
        KfcServerHandle kfcServer(kfcDumpParam.initParam.kfcWorkSpace.msgQ, KFC_DUMP_MSG_FINISHED, 0);
        EXPECT_EQ(KFC_DUMP_E_PARA, AdumpStatsOpSrvLaunch(reinterpret_cast<void*>(&kfcDumpTask)));
        (void)kfcServer.Stop();
        // 失败路径也必须已通知 AIV 退出，否则下一轮 Launch 会与残留实例争抢消息队列
        EXPECT_TRUE(kfcServer.SawFinished());
    }
    {
        KfcServerHandle kfcServer(kfcDumpParam.initParam.kfcWorkSpace.msgQ, KFC_DUMP_MSG_RESPONSE, 0);
        EXPECT_EQ(KFC_DUMP_SUCCESS, AdumpStatsOpSrvLaunch(reinterpret_cast<void*>(&kfcDumpTask)));
        (void)kfcServer.Stop();
        EXPECT_TRUE(kfcServer.SawFinished());
    }
}
