/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

// dump_stat_op UT：通过 stub/kernel_operator.h 在 host 侧仿真运行被测代码。
// stub 的 GetBlockIdx 默认 0（单核视角），多核归并由 0 核路径覆盖。
#include "gtest/gtest.h"
#include <cmath>
#include <cstdint>
#include <cstring>
#include <vector>
#include "securec.h"
#include "kfc_dump_param.h"
#include "kfc_dump_base.h"
#include "kfc_dump_server.h"
#include "kfc_dump_single_core.h"
#include "kfc_dump_multi_core.h"
#include "kfc_dump_stat.cpp"

using namespace KfcDumpStat;
using AscendC::StubBlockIdxRef;

namespace {
constexpr uint64_t UB_SIZE = 200 * 1024;
constexpr uint64_t AI_CORE_NUM = 4U;
constexpr uint64_t WORKSPACE_SIZE = AI_CORE_NUM * MAX_STAT_NUM * MAX_WORKSPACE_BYTE_SIZE;
constexpr uint64_t OUTPUT_SIZE = MAX_STAT_NUM * MAX_OUTPUT_BYTE_SIZE;

// 安全函数返回值统一检查：失败即断言（UT 内缓冲尺寸均匹配，失败属用例缺陷）
void CheckSecRet(errno_t ret) { EXPECT_EQ(EOK, ret); }

// 测试环境：模拟 device 侧内存（输入数据、输出缓冲、workspace）
class DumpStatOpTestEnv {
public:
    void Init(uint64_t dataBytes, uint64_t statClass, uint64_t coreNum = AI_CORE_NUM)
    {
        dataBuf_.assign(dataBytes, 0);
        outputBuf_.assign(OUTPUT_SIZE, 0);
        // workspace 按实际核数分配：多核归并时每核占用 statNum * 32B 的槽
        workspaceBuf_.assign(coreNum * MAX_STAT_NUM * MAX_WORKSPACE_BYTE_SIZE, 0);
        CheckSecRet(memset_s(&context_, sizeof(context_), 0, sizeof(context_)));
        context_.workspace = reinterpret_cast<uint64_t>(workspaceBuf_.data());
        context_.workspaceSize = WORKSPACE_SIZE;
        context_.aiCoreNum = coreNum;
        context_.ubSize = UB_SIZE;
        context_.syncspace = 0;

        CheckSecRet(memset_s(&rMsg_, sizeof(rMsg_), 0, sizeof(rMsg_)));
        rMsg_.dataCount = dataBytes;
        rMsg_.dataAddr = reinterpret_cast<uint64_t>(dataBuf_.data());
        rMsg_.dumpStatClass = statClass;
        rMsg_.outputAddr = reinterpret_cast<uint64_t>(outputBuf_.data());
        rMsg_.outputAddrSize = OUTPUT_SIZE;
        CheckSecRet(memset_s(&sMsg_, sizeof(sMsg_), 0, sizeof(sMsg_)));
    }

    template <typename T>
    void FillData(const std::vector<T>& values)
    {
        ASSERT_LE(values.size() * sizeof(T), dataBuf_.size());
        errno_t ret = memcpy_s(dataBuf_.data(), dataBuf_.size(), values.data(), values.size() * sizeof(T));
        if (ret != EOK) {
            ADD_FAILURE() << "FillData memcpy_s failed, ret=" << ret;
            return;
        }

        rMsg_.dataCount = values.size() * sizeof(T);
    }

    KfcDumpContext& Context() { return context_; }
    KfcDumpStatMsg& RMsg() { return rMsg_; }
    KfcDumpStatMsg& SMsg() { return sMsg_; }

    template <typename T>
    T GetOutput(int64_t statIdx)
    {
        T v{};
        errno_t ret = memcpy_s(&v, sizeof(T), outputBuf_.data() + statIdx * MAX_OUTPUT_BYTE_SIZE, sizeof(T));
        if (ret != EOK) {
            ADD_FAILURE() << "GetOutput memcpy_s failed, ret=" << ret;
        }
        return v;
    }

private:
    std::vector<uint8_t> dataBuf_;
    std::vector<uint8_t> outputBuf_;
    std::vector<uint8_t> workspaceBuf_;
    KfcDumpContext context_{};
    KfcDumpStatMsg rMsg_{};
    KfcDumpStatMsg sMsg_{};
};

int32_t OutI32(DumpStatOpTestEnv& env, int64_t idx) { return env.GetOutput<int32_t>(idx); }
float OutF32(DumpStatOpTestEnv& env, int64_t idx) { return env.GetOutput<float>(idx); }
int64_t StatIdx(StatClass c) { return static_cast<int64_t>(c); }
} // namespace

// ---------------------------------------------------------------------------
// 纯函数层：tiling 计算 / Ceil 工具
// ---------------------------------------------------------------------------
TEST(DumpStatOpPureTest, CeilDivBasic)
{
    EXPECT_EQ(CeilDiv(10, 3), 4);
    EXPECT_EQ(CeilDiv(11, 4), 3);
}

TEST(DumpStatOpPureTest, CeilDivExact) { EXPECT_EQ(CeilDiv(12, 4), 3); }

TEST(DumpStatOpPureTest, CeilDivZero) { EXPECT_EQ(CeilDiv(10, 0), 10); }

TEST(DumpStatOpPureTest, CeilAlignBasic) { EXPECT_EQ(CeilAlign(33, 32), 64); }

TEST(DumpStatOpPureTest, CeilAlignAlreadyAligned) { EXPECT_EQ(CeilAlign(64, 32), 64); }

TEST(DumpStatOpPureTest, CeilAlignZero) { EXPECT_EQ(CeilAlign(10, 0), 10); }

TEST(DumpStatOpPureTest, CalculateMaxProcCountEachDtype)
{
    for (int64_t dtypeSize = 1; dtypeSize <= 4; dtypeSize *= 2) {
        EXPECT_GT(CalculateMaxProcCount(dtypeSize, UB_SIZE), 0) << "dtypeSize=" << dtypeSize;
        EXPECT_GT(CalculateMaxProcCountMulti(dtypeSize, UB_SIZE), 0) << "dtypeSize=" << dtypeSize;
    }
}

// 不支持的字节数返回 -1
TEST(DumpStatOpPureTest, CalculateMaxProcCount_InvalidSize)
{
    EXPECT_EQ(CalculateMaxProcCount(3, UB_SIZE), -1);
    EXPECT_EQ(CalculateMaxProcCountMulti(3, UB_SIZE), -1);
}

// ubSize 过小使分子为负时不应返回正值（防御路径）
TEST(DumpStatOpPureTest, CalculateMaxProcCount_TinyUb)
{
    EXPECT_LT(CalculateMaxProcCount(1, 128), 1);
    EXPECT_LT(CalculateMaxProcCountMulti(1, 128), 1);
}

// 单核/多核公式各自为正即可：两者扣减项不同（单核多扣 mask 区，buffer 系数更小），
// floor 除法组合下不存在固定的大小关系，不构造强弱断言
TEST(DumpStatOpPureTest, MaxProcCountBothPositive)
{
    for (int64_t dtypeSize = 1; dtypeSize <= 4; dtypeSize *= 2) {
        EXPECT_GT(CalculateMaxProcCount(dtypeSize, UB_SIZE), 0);
        EXPECT_GT(CalculateMaxProcCountMulti(dtypeSize, UB_SIZE), 0);
    }
}

// 结果需满足 256B(COMMAND_SIZE) 对齐约束
TEST(DumpStatOpPureTest, MaxProcCountAlignedToCommandSize)
{
    for (int64_t dtypeSize = 1; dtypeSize <= 4; dtypeSize *= 2) {
        int64_t bytes = CalculateMaxProcCount(dtypeSize, UB_SIZE) * dtypeSize;
        EXPECT_EQ(0, bytes % COMMAND_SIZE) << "dtypeSize=" << dtypeSize;
    }
}

// ---------------------------------------------------------------------------
// 消息结构层
// ---------------------------------------------------------------------------
TEST(DumpStatMsgTest, StatClassBitCount)
{
    uint64_t all = 0;
    for (int64_t i = 0; i <= static_cast<int64_t>(StatClass::STAT_L2NORM); ++i) {
        all |= (1ULL << i);
    }
    EXPECT_EQ(7, ScalarGetCountOfValue<1>(all));
    EXPECT_EQ(1, ScalarGetCountOfValue<1>(1ULL << StatIdx(StatClass::STAT_MAX)));
    EXPECT_EQ(0, ScalarGetCountOfValue<1>(0));
}

TEST(DumpStatMsgTest, MsgSizeIs64Bytes) { EXPECT_EQ(64U, sizeof(KfcDumpStatMsg)); }

TEST(DumpStatMsgTest, OutputDataTypeValues)
{
    EXPECT_EQ(1U, static_cast<uint32_t>(OutputDataType::DUMP_DT_FLOAT));
    EXPECT_EQ(2U, static_cast<uint32_t>(OutputDataType::DUMP_DT_FLOAT16));
    EXPECT_EQ(27U, static_cast<uint32_t>(OutputDataType::DUMP_DT_BF16));
}

// ---------------------------------------------------------------------------
// 服务端消息层：KfcDumpServer 游标推进与绕回
// ---------------------------------------------------------------------------
TEST(KfcDumpServerCursorTest, IncreaseAndWrapAround)
{
    std::vector<uint8_t> msgArea(sizeof(KfcDumpMsgBody), 0);
    KfcDumpServer server;
    server.Init(reinterpret_cast<uint64_t>(msgArea.data()));
    EXPECT_EQ(0U, server.GetSendPos());
    EXPECT_EQ(0U, server.GetRcvPos());
    for (uint32_t i = 0; i < DUMP_MSG_CNT; ++i) {
        server.IncreaseSnd();
        server.IncreaseRcv();
    }
    EXPECT_EQ(0U, server.GetSendPos()); // 满 16 绕回到 0
    EXPECT_EQ(0U, server.GetRcvPos());
    server.IncreaseSnd();
    EXPECT_EQ(1U, server.GetSendPos());
}

TEST(KfcDumpServerCursorTest, GetMsgBodyAddr)
{
    std::vector<uint8_t> msgArea(sizeof(KfcDumpMsgBody), 0);
    KfcDumpServer server;
    server.Init(reinterpret_cast<uint64_t>(msgArea.data()));
    EXPECT_EQ(reinterpret_cast<uint64_t>(msgArea.data()), server.GetMsgBody());
}

TEST(KfcDumpServerCursorTest, GetSndRcvMsgWithinArea)
{
    std::vector<uint8_t> msgArea(sizeof(KfcDumpMsgBody), 0);
    auto* body = reinterpret_cast<KfcDumpMsgBody*>(msgArea.data());
    KfcDumpServer server;
    server.Init(reinterpret_cast<uint64_t>(msgArea.data()));
    // GetSndMsg/GetRcvMsg 带 DCCI 空实现，仅验证地址正确性
    auto* snd = server.GetSndMsg();
    auto* rcv = server.GetRcvMsg();
    EXPECT_EQ(reinterpret_cast<uint64_t>(&body->msgSndArea[0]), reinterpret_cast<uint64_t>(snd));
    EXPECT_EQ(reinterpret_cast<uint64_t>(&body->msgRcvArea[0]), reinterpret_cast<uint64_t>(rcv));
    server.IncreaseSnd();
    server.IncreaseRcv();
    EXPECT_EQ(reinterpret_cast<uint64_t>(&body->msgSndArea[1]), reinterpret_cast<uint64_t>(server.GetSndMsg()));
    EXPECT_EQ(reinterpret_cast<uint64_t>(&body->msgRcvArea[1]), reinterpret_cast<uint64_t>(server.GetRcvMsg()));
}

// UpdateMsg：REQUEST -> RESPONSE 回写，valid 标志收发互换
TEST(UpdateMsgTest, RequestToResponse)
{
    KfcDumpStatMsg rMsg;
    KfcDumpStatMsg sMsg;
    CheckSecRet(memset_s(&rMsg, sizeof(rMsg), 0, sizeof(rMsg)));
    CheckSecRet(memset_s(&sMsg, sizeof(sMsg), 0, sizeof(sMsg)));
    rMsg.msgType = DumpStatMsgType::KFC_DUMP_MSG_REQUEST;
    rMsg.dataType = 1;
    rMsg.valid = DUMP_MSG_VALID_MASK;

    UpdateMsg(&sMsg, &rMsg, true);

    EXPECT_EQ(static_cast<uint32_t>(DumpStatMsgType::KFC_DUMP_MSG_RESPONSE), static_cast<uint32_t>(sMsg.msgType));
    EXPECT_EQ(1U, sMsg.dataType); // 消息体透传
    EXPECT_EQ(MSG_RESULT_SUCCESS, sMsg.result);
    EXPECT_EQ(DUMP_MSG_VALID_MASK, sMsg.valid);
    EXPECT_EQ(~DUMP_MSG_VALID_MASK, rMsg.valid); // 收方清 valid
}

TEST(UpdateMsgTest, FailedResult)
{
    KfcDumpStatMsg rMsg;
    KfcDumpStatMsg sMsg;
    CheckSecRet(memset_s(&rMsg, sizeof(rMsg), 0, sizeof(rMsg)));
    CheckSecRet(memset_s(&sMsg, sizeof(sMsg), 0, sizeof(sMsg)));
    rMsg.msgType = DumpStatMsgType::KFC_DUMP_MSG_REQUEST;
    UpdateMsg(&sMsg, &rMsg, false);
    EXPECT_EQ(MSG_RESULT_FAILED, sMsg.result);
}

// ---------------------------------------------------------------------------
// 单核模板：全部统计项（blockIdx=0 视角）
// ---------------------------------------------------------------------------
class DumpStatSingleCoreTest : public testing::Test {
protected:
    DumpStatOpTestEnv env;

    void SetUp() override
    {
        StubBlockIdxRef() = 0;
        // aiCoreNum=1 使全部统计项落在核 0（stub 单线程只呈现核 0 视角）
        env.Init(8 * 1024, 127, 1);
    }

    template <typename T>
    void RunOp()
    {
        TPipe pipe;
        KfcDumpStatSingleCore<T> op(&pipe, &env.RMsg(), &env.SMsg(), &env.Context());
        op.Init();
        op.Process();
        pipe.Destroy();
    }
};

TEST_F(DumpStatSingleCoreTest, Int32AllStatsPattern)
{
    std::vector<int32_t> data(256);
    for (size_t i = 0; i < data.size(); ++i) {
        data[i] = static_cast<int32_t>(i) - 128;
    }
    env.FillData(data);
    env.RMsg().dataType = static_cast<uint32_t>(OutputDataType::DUMP_DT_INT32);
    RunOp<int32_t>();
    EXPECT_EQ(127, OutI32(env, StatIdx(StatClass::STAT_MAX)));
    EXPECT_EQ(-128, OutI32(env, StatIdx(StatClass::STAT_MIN)));
    // 整型 nan/inf 输出 0
    EXPECT_EQ(0, OutI32(env, StatIdx(StatClass::STAT_NAN)));
    EXPECT_EQ(0, OutI32(env, StatIdx(StatClass::STAT_NEG_INF)));
    EXPECT_EQ(0, OutI32(env, StatIdx(StatClass::STAT_POS_INF)));
}

// int32 全负数据 + 非对齐尾块：max 不得被尾块填充抬高到 0（回归验证）
TEST_F(DumpStatSingleCoreTest, Int32AllNegativeMaxNotZero)
{
    std::vector<int32_t> data(257, -1); // 257 个元素构造尾块
    env.FillData(data);
    env.RMsg().dataType = static_cast<uint32_t>(OutputDataType::DUMP_DT_INT32);
    RunOp<int32_t>();
    EXPECT_EQ(-1, OutI32(env, StatIdx(StatClass::STAT_MAX)));
    EXPECT_EQ(-1, OutI32(env, StatIdx(StatClass::STAT_MIN)));
}

// float 全正数据 + 非对齐尾块：min 不得被尾块填充压到 0（回归验证）
TEST_F(DumpStatSingleCoreTest, FloatAllPositiveMinNotZero)
{
    std::vector<float> data(130, 1.5f);
    env.FillData(data);
    env.RMsg().dataType = static_cast<uint32_t>(OutputDataType::DUMP_DT_FLOAT);
    RunOp<float>();
    EXPECT_FLOAT_EQ(1.5f, OutF32(env, StatIdx(StatClass::STAT_MAX)));
    EXPECT_FLOAT_EQ(1.5f, OutF32(env, StatIdx(StatClass::STAT_MIN)));
    EXPECT_FLOAT_EQ(1.5f, OutF32(env, StatIdx(StatClass::STAT_MEAN)));
    EXPECT_NEAR(OutF32(env, StatIdx(StatClass::STAT_L2NORM)), 1.5f * sqrtf(130.0f), 1e-2f);
}

// int16 全负 + 非对齐尾块（回归验证）
TEST_F(DumpStatSingleCoreTest, Int16AllNegativeMaxNotZero)
{
    std::vector<int16_t> data(515, -3);
    env.FillData(data);
    env.RMsg().dataType = static_cast<uint32_t>(OutputDataType::DUMP_DT_INT16);
    RunOp<int16_t>();
    EXPECT_EQ(-3, OutI32(env, StatIdx(StatClass::STAT_MAX)));
    EXPECT_EQ(-3, OutI32(env, StatIdx(StatClass::STAT_MIN)));
}

// int8 全负 + 非对齐尾块（回归验证；b8 走 half 中转路径）
TEST_F(DumpStatSingleCoreTest, Int8AllNegativeMaxNotZero)
{
    std::vector<int8_t> data(1030, -5);
    env.FillData(data);
    env.RMsg().dataType = static_cast<uint32_t>(OutputDataType::DUMP_DT_INT8);
    RunOp<int8_t>();
    EXPECT_EQ(-5, OutI32(env, StatIdx(StatClass::STAT_MAX)));
    EXPECT_EQ(-5, OutI32(env, StatIdx(StatClass::STAT_MIN)));
}

// fp8(hifloat8) 全负 + 非对齐尾块：max 不得被尾块补 0 抬高（David 分支回归验证）
TEST_F(DumpStatSingleCoreTest, Fp8AllNegativeMaxNotZero)
{
    std::vector<hifloat8_t> data(130, hifloat8_t(-2.5f));
    env.FillData(data);
    env.RMsg().dataType = static_cast<uint32_t>(OutputDataType::DUMP_DT_HIFLOAT8);
    RunOp<hifloat8_t>();
    EXPECT_FLOAT_EQ(-2.5f, OutF32(env, StatIdx(StatClass::STAT_MAX)));
    EXPECT_FLOAT_EQ(-2.5f, OutF32(env, StatIdx(StatClass::STAT_MIN)));
}

// fp8(e5m2) 全正 + 非对齐尾块：min 不得被尾块补 0 拉低（David 分支回归验证）
TEST_F(DumpStatSingleCoreTest, Fp8AllPositiveMinNotZero)
{
    std::vector<fp8_e5m2_t> data(130, fp8_e5m2_t(1.5f));
    env.FillData(data);
    env.RMsg().dataType = static_cast<uint32_t>(OutputDataType::DUMP_DT_FLOAT8_E5M2);
    RunOp<fp8_e5m2_t>();
    EXPECT_FLOAT_EQ(1.5f, OutF32(env, StatIdx(StatClass::STAT_MAX)));
    EXPECT_FLOAT_EQ(1.5f, OutF32(env, StatIdx(StatClass::STAT_MIN)));
}

// fp8(e4m3fn) 混合正负 + 非对齐尾块：max/min/mean 基本正确性
// 129 = 7*17 + 10：7 轮完整 -8..8（和为 0），尾段 -8..1（和为 -35），mean = -35/129
TEST_F(DumpStatSingleCoreTest, Fp8MixedStats)
{
    std::vector<fp8_e4m3fn_t> data(129);
    for (size_t i = 0; i < data.size(); ++i) {
        data[i] = fp8_e4m3fn_t(static_cast<float>(i % 17) - 8.0f); // -8..8 循环
    }
    env.FillData(data);
    env.RMsg().dataType = static_cast<uint32_t>(OutputDataType::DUMP_DT_FLOAT8_E4M3FN);
    RunOp<fp8_e4m3fn_t>();
    EXPECT_FLOAT_EQ(8.0f, OutF32(env, StatIdx(StatClass::STAT_MAX)));
    EXPECT_FLOAT_EQ(-8.0f, OutF32(env, StatIdx(StatClass::STAT_MIN)));
    EXPECT_NEAR(OutF32(env, StatIdx(StatClass::STAT_MEAN)), -35.0f / 129.0f, 1e-4f);
}

// float 含 NaN/Inf：nan=2, posInf=1, negInf=1
TEST_F(DumpStatSingleCoreTest, FloatNanInfCount)
{
    std::vector<float> data(100, 1.0f);
    data[10] = NAN;
    data[20] = NAN;
    data[30] = INFINITY;
    data[40] = -INFINITY;
    env.FillData(data);
    env.RMsg().dataType = static_cast<uint32_t>(OutputDataType::DUMP_DT_FLOAT);
    RunOp<float>();
    EXPECT_EQ(2, OutI32(env, StatIdx(StatClass::STAT_NAN)));
    EXPECT_EQ(1, OutI32(env, StatIdx(StatClass::STAT_POS_INF)));
    EXPECT_EQ(1, OutI32(env, StatIdx(StatClass::STAT_NEG_INF)));
}

// fp16：max/min/mean 经 cast 后统计
TEST_F(DumpStatSingleCoreTest, HalfBasicStats)
{
    std::vector<half> data(64);
    for (size_t i = 0; i < data.size(); ++i) {
        data[i] = half(static_cast<float>(i));
    }
    env.FillData(data);
    env.RMsg().dataType = static_cast<uint32_t>(OutputDataType::DUMP_DT_FLOAT16);
    RunOp<half>();
    EXPECT_FLOAT_EQ(63.0f, OutF32(env, StatIdx(StatClass::STAT_MAX)));
    EXPECT_FLOAT_EQ(0.0f, OutF32(env, StatIdx(StatClass::STAT_MIN)));
    EXPECT_NEAR(OutF32(env, StatIdx(StatClass::STAT_MEAN)), 31.5f, 0.1f);
}

// uint8：b8 走 half 中转路径
TEST_F(DumpStatSingleCoreTest, Uint8BasicStats)
{
    std::vector<uint8_t> data(2060);
    for (size_t i = 0; i < data.size(); ++i) {
        data[i] = static_cast<uint8_t>(i & 0xFF);
    }
    env.FillData(data);
    env.RMsg().dataType = static_cast<uint32_t>(OutputDataType::DUMP_DT_UINT8);
    RunOp<uint8_t>();
    EXPECT_EQ(255, OutI32(env, StatIdx(StatClass::STAT_MAX)));
    EXPECT_EQ(0, OutI32(env, StatIdx(StatClass::STAT_MIN)));
}

// bf16
TEST_F(DumpStatSingleCoreTest, Bfloat16BasicStats)
{
    std::vector<bfloat16_t> data(64, bfloat16_t(2.5f));
    env.FillData(data);
    env.RMsg().dataType = static_cast<uint32_t>(OutputDataType::DUMP_DT_BF16);
    RunOp<bfloat16_t>();
    EXPECT_FLOAT_EQ(2.5f, OutF32(env, StatIdx(StatClass::STAT_MAX)));
    EXPECT_FLOAT_EQ(2.5f, OutF32(env, StatIdx(StatClass::STAT_MIN)));
    EXPECT_FLOAT_EQ(2.5f, OutF32(env, StatIdx(StatClass::STAT_MEAN)));
}

// 单元素数据：各统计项退化为单点
TEST_F(DumpStatSingleCoreTest, SingleElement)
{
    std::vector<float> data = {3.25f};
    env.FillData(data);
    env.RMsg().dataType = static_cast<uint32_t>(OutputDataType::DUMP_DT_FLOAT);
    RunOp<float>();
    EXPECT_FLOAT_EQ(3.25f, OutF32(env, StatIdx(StatClass::STAT_MAX)));
    EXPECT_FLOAT_EQ(3.25f, OutF32(env, StatIdx(StatClass::STAT_MIN)));
    EXPECT_FLOAT_EQ(3.25f, OutF32(env, StatIdx(StatClass::STAT_MEAN)));
    EXPECT_FLOAT_EQ(3.25f, OutF32(env, StatIdx(StatClass::STAT_L2NORM)));
}

// 仅使能部分统计项（max + l2norm）
TEST_F(DumpStatSingleCoreTest, PartialStatClass)
{
    std::vector<float> data(64, 2.0f);
    env.FillData(data);
    env.RMsg().dumpStatClass = (1ULL << StatIdx(StatClass::STAT_MAX)) | (1ULL << StatIdx(StatClass::STAT_L2NORM));
    env.RMsg().dataType = static_cast<uint32_t>(OutputDataType::DUMP_DT_FLOAT);
    RunOp<float>();
    EXPECT_FLOAT_EQ(2.0f, OutF32(env, StatIdx(StatClass::STAT_MAX)));
    EXPECT_FLOAT_EQ(2.0f * sqrtf(64.0f), OutF32(env, StatIdx(StatClass::STAT_L2NORM)));
}

// 恰好一个 tile（无尾块路径）
TEST_F(DumpStatSingleCoreTest, ExactOneTile)
{
    int64_t tileLen = CalculateMaxProcCount(4, UB_SIZE) / BUFFER_NUM;
    std::vector<float> data(static_cast<size_t>(tileLen), 4.0f);
    env.Init(tileLen * 4, 127, 1);
    env.FillData(data);
    env.RMsg().dataType = static_cast<uint32_t>(OutputDataType::DUMP_DT_FLOAT);
    RunOp<float>();
    EXPECT_FLOAT_EQ(4.0f, OutF32(env, StatIdx(StatClass::STAT_MAX)));
    EXPECT_FLOAT_EQ(4.0f, OutF32(env, StatIdx(StatClass::STAT_MEAN)));
}

// 多 tile + 尾块路径
TEST_F(DumpStatSingleCoreTest, MultiTileWithTail)
{
    int64_t tileLen = CalculateMaxProcCount(4, UB_SIZE) / BUFFER_NUM;
    int64_t total = tileLen * 2 + 33;
    std::vector<float> data(static_cast<size_t>(total), 7.0f);
    env.Init(static_cast<uint64_t>(total) * 4, 127, 1);
    env.FillData(data);
    env.RMsg().dataType = static_cast<uint32_t>(OutputDataType::DUMP_DT_FLOAT);
    RunOp<float>();
    EXPECT_FLOAT_EQ(7.0f, OutF32(env, StatIdx(StatClass::STAT_MAX)));
    EXPECT_FLOAT_EQ(7.0f, OutF32(env, StatIdx(StatClass::STAT_MIN)));
    EXPECT_NEAR(OutF32(env, StatIdx(StatClass::STAT_L2NORM)), 7.0f * sqrtf(static_cast<float>(total)), 1e-1f);
}

// 无统计项：直接回消息不进入统计分发（除零防护）
TEST_F(DumpStatSingleCoreTest, ZeroStatClassNoCrash)
{
    env.RMsg().dumpStatClass = 0;
    env.RMsg().dataType = static_cast<uint32_t>(OutputDataType::DUMP_DT_FLOAT);
    RunOp<float>(); // 不崩溃、输出区未被写入即通过
    EXPECT_EQ(0, OutI32(env, StatIdx(StatClass::STAT_NAN)));
}

// ---------------------------------------------------------------------------
// 多核模板：单线程模拟 block 0 承担全部数据（尾核视角）
// ---------------------------------------------------------------------------
class DumpStatMultiCoreTest : public testing::Test {
protected:
    DumpStatOpTestEnv env;

    void SetUp() override
    {
        StubBlockIdxRef() = 0;
        // aiCoreNum=1：单线程呈现尾核(blockIdx==aiCoreNum-1)视角，承担全部统计与归并
        env.Init(64 * 1024, 127, 1);
    }

    template <typename T>
    void RunOp()
    {
        TPipe pipe;
        KfcDumpStatMultiCore<T> op(&pipe, &env.RMsg(), &env.SMsg(), &env.Context());
        op.Init();
        op.Process();
        pipe.Destroy();
    }
};

TEST_F(DumpStatMultiCoreTest, FloatAllStatsPattern)
{
    std::vector<float> data(4096);
    for (size_t i = 0; i < data.size(); ++i) {
        data[i] = static_cast<float>(i);
    }
    env.FillData(data);
    env.RMsg().dataType = static_cast<uint32_t>(OutputDataType::DUMP_DT_FLOAT);
    RunOp<float>();
    EXPECT_FLOAT_EQ(4095.0f, OutF32(env, StatIdx(StatClass::STAT_MAX)));
    EXPECT_FLOAT_EQ(0.0f, OutF32(env, StatIdx(StatClass::STAT_MIN)));
    EXPECT_NEAR(OutF32(env, StatIdx(StatClass::STAT_MEAN)), 2047.5f, 0.5f);
    EXPECT_EQ(0, OutI32(env, StatIdx(StatClass::STAT_NAN)));
    EXPECT_EQ(0, OutI32(env, StatIdx(StatClass::STAT_POS_INF)));
    EXPECT_EQ(0, OutI32(env, StatIdx(StatClass::STAT_NEG_INF)));
    // l2 = sqrt(sum(i^2)), i=0..4095；大数累加存在浮点误差，放宽到 1e-1 相对档位
    float expectL2 = sqrtf(static_cast<float>(4095.0f * 4096.0f * (2.0f * 4095.0f + 1.0f) / 6.0f));
    EXPECT_NEAR(OutF32(env, StatIdx(StatClass::STAT_L2NORM)), expectL2, 1.0f);
}

TEST_F(DumpStatMultiCoreTest, Int32AllStats)
{
    std::vector<int32_t> data(8192);
    for (size_t i = 0; i < data.size(); ++i) {
        data[i] = static_cast<int32_t>(i) - 4096;
    }
    env.FillData(data);
    env.RMsg().dataType = static_cast<uint32_t>(OutputDataType::DUMP_DT_INT32);
    RunOp<int32_t>();
    EXPECT_EQ(4095, OutI32(env, StatIdx(StatClass::STAT_MAX)));
    EXPECT_EQ(-4096, OutI32(env, StatIdx(StatClass::STAT_MIN)));
}

TEST_F(DumpStatMultiCoreTest, HalfStats)
{
    std::vector<half> data(4096);
    for (size_t i = 0; i < data.size(); ++i) {
        data[i] = half(static_cast<float>(i % 100));
    }
    env.FillData(data);
    env.RMsg().dataType = static_cast<uint32_t>(OutputDataType::DUMP_DT_FLOAT16);
    RunOp<half>();
    EXPECT_FLOAT_EQ(99.0f, OutF32(env, StatIdx(StatClass::STAT_MAX)));
    EXPECT_FLOAT_EQ(0.0f, OutF32(env, StatIdx(StatClass::STAT_MIN)));
}

TEST_F(DumpStatMultiCoreTest, Int16AllNegative)
{
    std::vector<int16_t> data(16 * 1024 / 2, -7);
    env.FillData(data);
    env.RMsg().dataType = static_cast<uint32_t>(OutputDataType::DUMP_DT_INT16);
    RunOp<int16_t>();
    EXPECT_EQ(-7, OutI32(env, StatIdx(StatClass::STAT_MAX)));
    EXPECT_EQ(-7, OutI32(env, StatIdx(StatClass::STAT_MIN)));
}

TEST_F(DumpStatMultiCoreTest, Uint8AllStats)
{
    std::vector<uint8_t> data(16 * 1024);
    for (size_t i = 0; i < data.size(); ++i) {
        data[i] = static_cast<uint8_t>(i & 0xFF);
    }
    env.FillData(data);
    env.RMsg().dataType = static_cast<uint32_t>(OutputDataType::DUMP_DT_UINT8);
    RunOp<uint8_t>();
    EXPECT_EQ(255, OutI32(env, StatIdx(StatClass::STAT_MAX)));
    EXPECT_EQ(0, OutI32(env, StatIdx(StatClass::STAT_MIN)));
}

// 多核小数据量（dataCount 字节数小于单 tile）也能正确完成
TEST_F(DumpStatMultiCoreTest, SmallData)
{
    std::vector<float> data = {1.0f, 2.0f, 3.0f};
    env.FillData(data);
    env.RMsg().dataType = static_cast<uint32_t>(OutputDataType::DUMP_DT_FLOAT);
    RunOp<float>();
    EXPECT_FLOAT_EQ(3.0f, OutF32(env, StatIdx(StatClass::STAT_MAX)));
    EXPECT_FLOAT_EQ(1.0f, OutF32(env, StatIdx(StatClass::STAT_MIN)));
    EXPECT_FLOAT_EQ(2.0f, OutF32(env, StatIdx(StatClass::STAT_MEAN)));
}

// ---------------------------------------------------------------------------
// 入口层：kfc_dump_stat.cpp 的消息循环与分发链路
// GetByteSizeByDataType / DispatchStatByDataType / ProcessMultiCore /
// ProcessSingleCore / SyncAllCoreG / SyncAllBlock / HandleInvalidMsg /
// ProcessStatMsg / kfc_dump_stat 入口
// ---------------------------------------------------------------------------
namespace {
// 构造 kfc_dump_stat 入口所需的 GM 侧内存：msgQ(收/发各 16 槽) + 标量参数区
class KernelEntryEnv {
public:
    static constexpr uint64_t WORKSPACE_SIZE = AI_CORE_NUM * MAX_STAT_NUM * MAX_WORKSPACE_BYTE_SIZE;

    KernelEntryEnv()
    {
        CheckSecRet(memset_s(msgq_, sizeof(msgq_), 0, sizeof(msgq_)));
        CheckSecRet(memset_s(output_, sizeof(output_), 0, sizeof(output_)));
        CheckSecRet(memset_s(workspace_, sizeof(workspace_), 0, sizeof(workspace_)));
        wkspaceSizeVal = WORKSPACE_SIZE;
        coreNumVal = 1; // 单核视角：全部统计项与归并由 block0 完成
        ubSizeVal = UB_SIZE;
    }

    // 在收队列槽 slot 构造一条 REQUEST
    KfcDumpStatMsg& MakeRequest(uint32_t slot)
    {
        auto& msg =
            *reinterpret_cast<KfcDumpStatMsg*>(msgq_ + sizeof(KfcDumpMsgBody) / 2 + slot * sizeof(KfcDumpStatMsg));
        CheckSecRet(memset_s(&msg, sizeof(msg), 0, sizeof(msg)));
        msg.msgType = DumpStatMsgType::KFC_DUMP_MSG_REQUEST;
        msg.dataAddr = reinterpret_cast<uint64_t>(input_);
        msg.outputAddr = reinterpret_cast<uint64_t>(output_);
        msg.outputAddrSize = OUTPUT_SIZE;
        msg.dumpStatClass = 127; // 默认全统计项，用例可按需覆盖
        msg.valid = DUMP_MSG_VALID_MASK;
        return msg;
    }

    // 发送队列槽 slot 的应答消息
    const KfcDumpStatMsg& GetResponse(uint32_t slot) const
    {
        return *reinterpret_cast<const KfcDumpStatMsg*>(msgq_ + slot * sizeof(KfcDumpStatMsg));
    }

    template <typename T>
    T Out(int64_t statIdx) const
    {
        T v{};
        errno_t ret = memcpy_s(&v, sizeof(T), output_ + statIdx * MAX_OUTPUT_BYTE_SIZE, sizeof(T));
        if (ret != EOK) {
            ADD_FAILURE() << "Out memcpy_s failed, ret=" << ret;
        }
        return v;
    }

    void ResetInput()
    {
        CheckSecRet(memset_s(input_, sizeof(input_), 0, sizeof(input_)));
        CheckSecRet(memset_s(output_, sizeof(output_), 0, sizeof(output_)));
        CheckSecRet(memset_s(workspace_, sizeof(workspace_), 0, sizeof(workspace_)));
    }

    uint8_t msgq_[sizeof(KfcDumpMsgBody)]{0};
    uint8_t output_[MAX_STAT_NUM * MAX_OUTPUT_BYTE_SIZE]{0};
    uint8_t workspace_[WORKSPACE_SIZE]{0};
    uint8_t input_[64 * 1024]{0};
    uint64_t wkspaceSizeVal = 0;
    uint64_t coreNumVal = 0;
    uint64_t ubSizeVal = 0;
};

// 以 0 核视角执行 kfc_dump_stat 入口（各入口用例统一走此封装）
void RunKernelEntry(const KernelEntryEnv& env)
{
    StubBlockIdxRef() = 0;
    kfc_dump_stat(
        reinterpret_cast<uint64_t>(env.msgq_), reinterpret_cast<uint64_t>(env.workspace_),
        reinterpret_cast<uint64_t>(&env.wkspaceSizeVal), reinterpret_cast<uint64_t>(&env.coreNumVal),
        reinterpret_cast<uint64_t>(&env.ubSizeVal), 0);
}

// Dispatch 用例共用的支持类型表（int8/uint8/int16/int32/fp16/fp32/bf16 + David 专属 fp8）
constexpr uint32_t kSupportedTypes[] = {
    static_cast<uint32_t>(OutputDataType::DUMP_DT_INT8),
    static_cast<uint32_t>(OutputDataType::DUMP_DT_UINT8),
    static_cast<uint32_t>(OutputDataType::DUMP_DT_INT16),
    static_cast<uint32_t>(OutputDataType::DUMP_DT_INT32),
    static_cast<uint32_t>(OutputDataType::DUMP_DT_FLOAT16),
    static_cast<uint32_t>(OutputDataType::DUMP_DT_FLOAT),
    static_cast<uint32_t>(OutputDataType::DUMP_DT_BF16),
#if KFC_DUMP_SUPPORT_FP8
    static_cast<uint32_t>(OutputDataType::DUMP_DT_HIFLOAT8),
    static_cast<uint32_t>(OutputDataType::DUMP_DT_FLOAT8_E5M2),
    static_cast<uint32_t>(OutputDataType::DUMP_DT_FLOAT8_E4M3FN),
#endif
};
} // namespace

// GetByteSizeByDataType：每个枚举值逐一验证
TEST(GetByteSizeByDataTypeTest, AllSupportedTypes)
{
    EXPECT_EQ(1, GetByteSizeByDataType(static_cast<uint32_t>(OutputDataType::DUMP_DT_INT8)));
    EXPECT_EQ(1, GetByteSizeByDataType(static_cast<uint32_t>(OutputDataType::DUMP_DT_UINT8)));
    EXPECT_EQ(1, GetByteSizeByDataType(static_cast<uint32_t>(OutputDataType::DUMP_DT_HIFLOAT8)));
    EXPECT_EQ(1, GetByteSizeByDataType(static_cast<uint32_t>(OutputDataType::DUMP_DT_FLOAT8_E5M2)));
    EXPECT_EQ(1, GetByteSizeByDataType(static_cast<uint32_t>(OutputDataType::DUMP_DT_FLOAT8_E4M3FN)));
    EXPECT_EQ(2, GetByteSizeByDataType(static_cast<uint32_t>(OutputDataType::DUMP_DT_INT16)));
    EXPECT_EQ(2, GetByteSizeByDataType(static_cast<uint32_t>(OutputDataType::DUMP_DT_FLOAT16)));
    EXPECT_EQ(2, GetByteSizeByDataType(static_cast<uint32_t>(OutputDataType::DUMP_DT_BF16)));
    EXPECT_EQ(4, GetByteSizeByDataType(static_cast<uint32_t>(OutputDataType::DUMP_DT_INT32)));
    EXPECT_EQ(4, GetByteSizeByDataType(static_cast<uint32_t>(OutputDataType::DUMP_DT_FLOAT)));
}

TEST(GetByteSizeByDataTypeTest, UnsupportedType) { EXPECT_EQ(-1, GetByteSizeByDataType(0U)); }

// kfc_dump_stat 入口：单条 float 请求 -> 全统计 -> RESPONSE 应答
TEST(KfcDumpStatEntryTest, SingleFloatRequestAllStats)
{
    KernelEntryEnv env;
    constexpr int64_t N = 100;
    float input[N];
    for (int i = 0; i < N; ++i) {
        input[i] = static_cast<float>(i) - 50.0f;
    }
    input[10] = NAN; // nan 计 1；不留 inf，避免 max 被 inf 覆盖
    auto& req = env.MakeRequest(0);
    req.dataType = static_cast<uint32_t>(OutputDataType::DUMP_DT_FLOAT);
    req.dataCount = N * sizeof(float);
    CheckSecRet(memcpy_s(env.input_, sizeof(env.input_), input, sizeof(input)));
    // 槽 1 放 FINISHED 使循环退出
    auto& fin = env.MakeRequest(1);
    fin.msgType = DumpStatMsgType::KFC_DUMP_MSG_FINISHED;
    fin.valid = 0;

    RunKernelEntry(env);

    const auto& rsp = env.GetResponse(0);
    EXPECT_EQ(DUMP_MSG_VALID_MASK, rsp.valid);
    EXPECT_EQ(MSG_RESULT_SUCCESS, rsp.result);
    EXPECT_FLOAT_EQ(49.0f, env.Out<float>(StatIdx(StatClass::STAT_MAX)));
    EXPECT_FLOAT_EQ(-50.0f, env.Out<float>(StatIdx(StatClass::STAT_MIN)));
    EXPECT_EQ(1, env.Out<int32_t>(StatIdx(StatClass::STAT_NAN)));
    EXPECT_EQ(0, env.Out<int32_t>(StatIdx(StatClass::STAT_POS_INF)));
}

// 多条消息连续处理：REQUEST -> REQUEST -> FINISHED（含消息队列游标推进）
TEST(KfcDumpStatEntryTest, MultipleRequestsThenFinish)
{
    KernelEntryEnv env;
    // 消息 0：float 多核路径（> 8KB）
    constexpr int64_t N0 = 4096;
    std::vector<float> d0(N0);
    for (int64_t i = 0; i < N0; ++i) {
        d0[static_cast<size_t>(i)] = static_cast<float>(i);
    }
    auto& req0 = env.MakeRequest(0);
    req0.dataType = static_cast<uint32_t>(OutputDataType::DUMP_DT_FLOAT);
    req0.dataCount = N0 * sizeof(float);
    CheckSecRet(memcpy_s(env.input_, sizeof(env.input_), d0.data(), d0.size() * sizeof(float)));

    // 消息 1：int32 单核路径（<= 8KB）
    auto& req1 = env.MakeRequest(1);
    req1.dataType = static_cast<uint32_t>(OutputDataType::DUMP_DT_INT32);
    req1.dataCount = 100 * sizeof(int32_t);
    CheckSecRet(memset_s(env.input_, sizeof(env.input_), 0, sizeof(env.input_)));
    int32_t d1[100];
    for (int32_t i = 0; i < 100; ++i) {
        d1[i] = i;
    }
    CheckSecRet(memcpy_s(env.input_, sizeof(env.input_), d1, sizeof(d1)));

    // 消息 2：FINISHED 退出
    auto& fin = env.MakeRequest(2);
    fin.msgType = DumpStatMsgType::KFC_DUMP_MSG_FINISHED;
    fin.valid = 0;

    RunKernelEntry(env);

    // output 缓冲被两条消息先后复用，最终停留在最后一条消息（int32）的结果上
    EXPECT_EQ(99, env.Out<int32_t>(StatIdx(StatClass::STAT_MAX)));
    EXPECT_EQ(0, env.Out<int32_t>(StatIdx(StatClass::STAT_MIN)));
}

// 入口：无效请求（不支持的类型）-> HandleInvalidMsg -> result=FAILED
TEST(KfcDumpStatEntryTest, UnsupportedTypeRequest)
{
    KernelEntryEnv env;
    auto& req = env.MakeRequest(0);
    req.dataType = 0; // 不支持
    req.dataCount = 100;
    auto& fin = env.MakeRequest(1);
    fin.msgType = DumpStatMsgType::KFC_DUMP_MSG_FINISHED;
    fin.valid = 0;

    RunKernelEntry(env);

    const auto& rsp = env.GetResponse(0);
    EXPECT_EQ(DUMP_MSG_VALID_MASK, rsp.valid);
    EXPECT_EQ(MSG_RESULT_FAILED, rsp.result); // 类型不支持
}

// 入口：dataCount 为 0 的请求 -> HandleInvalidMsg -> result=SUCCESS（空数据视为成功）
TEST(KfcDumpStatEntryTest, ZeroDataCountRequest)
{
    KernelEntryEnv env;
    auto& req = env.MakeRequest(0);
    req.dataType = static_cast<uint32_t>(OutputDataType::DUMP_DT_FLOAT);
    req.dataCount = 0;
    auto& fin = env.MakeRequest(1);
    fin.msgType = DumpStatMsgType::KFC_DUMP_MSG_FINISHED;
    fin.valid = 0;

    RunKernelEntry(env);

    const auto& rsp = env.GetResponse(0);
    EXPECT_EQ(MSG_RESULT_SUCCESS, rsp.result);
}

// 入口：REQUEST 且 valid 未置位的消息不进入统计分支（if 条件的另一半）。
// 注：真实场景下 AIV 侧会持续更新收区，该循环最终会读到有效消息或 FINISHED；
// UT 单线程无法推进收区，故收槽 0 直接放 FINISHED（valid 无效 + msgType=FINISHED）
// 验证"valid 不满足时不处理消息"且循环正常退出。
TEST(KfcDumpStatEntryTest, SkipsInvalidMessages)
{
    KernelEntryEnv env;
    auto& notReq = env.MakeRequest(0);
    notReq.msgType = DumpStatMsgType::KFC_DUMP_MSG_FINISHED; // valid 未置位 -> 不处理
    notReq.valid = ~DUMP_MSG_VALID_MASK;
    notReq.dataCount = 100;                                  // 若误处理会写输出区，以此区分

    RunKernelEntry(env);
    // 未处理任何统计：输出区保持 0，发送区无应答
    EXPECT_EQ(0, env.Out<int32_t>(StatIdx(StatClass::STAT_NAN)));
    EXPECT_NE(DUMP_MSG_VALID_MASK, env.GetResponse(0).valid);
}

// DispatchStatByDataType 的分发矩阵：7 类型 x 单核/多核共 14 个组合逐一执行
TEST(DispatchTest, AllTypesSingleCore)
{
    DumpStatOpTestEnv env;
    StubBlockIdxRef() = 0;
    for (uint32_t t : kSupportedTypes) {
        env.Init(1024, 127, 1);
        env.RMsg().dataType = t;
        TPipe pipe;
        EXPECT_TRUE(DispatchStatByDataType<KfcDumpStatSingleCore>(t, &pipe, &env.RMsg(), &env.SMsg(), &env.Context()))
            << "type=" << t;
        pipe.Destroy();
    }
}

TEST(DispatchTest, AllTypesMultiCore)
{
    DumpStatOpTestEnv env;
    StubBlockIdxRef() = 0;
    for (uint32_t t : kSupportedTypes) {
        env.Init(16 * 1024, 127, 1);
        env.RMsg().dataType = t;
        TPipe pipe;
        EXPECT_TRUE(DispatchStatByDataType<KfcDumpStatMultiCore>(t, &pipe, &env.RMsg(), &env.SMsg(), &env.Context()))
            << "type=" << t;
        pipe.Destroy();
    }
}

// Dispatch 未命中返回 false：触发 ProcessMultiCore/ProcessSingleCore 的失败回消息
TEST(DispatchTest, UnknownTypeReturnsFalse)
{
    DumpStatOpTestEnv env;
    StubBlockIdxRef() = 0;
    env.Init(1024, 127, 1);
    TPipe pipe;
    EXPECT_FALSE(DispatchStatByDataType<KfcDumpStatSingleCore>(0U, &pipe, &env.RMsg(), &env.SMsg(), &env.Context()));
    EXPECT_FALSE(DispatchStatByDataType<KfcDumpStatMultiCore>(0U, &pipe, &env.RMsg(), &env.SMsg(), &env.Context()));
    pipe.Destroy();
}

// ProcessMultiCore / ProcessSingleCore 失败路径：0 核回 FAILED 消息
TEST(ProcessDispatchTest, UnsupportedTypeRepliesFailed)
{
    DumpStatOpTestEnv env;
    StubBlockIdxRef() = 0;
    env.Init(1024, 127, 1);
    env.RMsg().dataType = 0;
    TPipe pipe;
    ProcessSingleCore(&pipe, &env.RMsg(), &env.SMsg(), &env.Context());
    ProcessMultiCore(&pipe, &env.RMsg(), &env.SMsg(), &env.Context());
    pipe.Destroy();
    EXPECT_EQ(static_cast<uint32_t>(DumpStatMsgType::KFC_DUMP_MSG_RESPONSE), static_cast<uint32_t>(env.SMsg().msgType));
    EXPECT_EQ(MSG_RESULT_FAILED, env.SMsg().result);
}

// ProcessStatMsg：单核（<= 8KB）与多核（> 8KB）分发边界
TEST(ProcessStatMsgTest, SingleCoreBoundary)
{
    DumpStatOpTestEnv env;
    StubBlockIdxRef() = 0;
    env.Init(MULTI_CORE_BYTES_NUM, 127, 1); // 恰好 8KB -> 单核
    env.RMsg().dataType = static_cast<uint32_t>(OutputDataType::DUMP_DT_FLOAT);
    ProcessStatMsg(&env.RMsg(), &env.SMsg(), &env.Context());
    EXPECT_FLOAT_EQ(0.0f, OutF32(env, StatIdx(StatClass::STAT_MAX))); // 数据全 0
}

TEST(ProcessStatMsgTest, MultiCoreBoundary)
{
    DumpStatOpTestEnv env;
    StubBlockIdxRef() = 0;
    env.Init(MULTI_CORE_BYTES_NUM + 1, 127, 1); // 8KB+1 -> 多核
    env.RMsg().dataType = static_cast<uint32_t>(OutputDataType::DUMP_DT_FLOAT);
    ProcessStatMsg(&env.RMsg(), &env.SMsg(), &env.Context());
    EXPECT_FLOAT_EQ(0.0f, OutF32(env, StatIdx(StatClass::STAT_MAX)));
}

// ProcessStatMsg 无效消息直达 HandleInvalidMsg
TEST(ProcessStatMsgTest, InvalidDataTypeHandled)
{
    DumpStatOpTestEnv env;
    StubBlockIdxRef() = 0;
    env.Init(1024, 127, 1);
    env.RMsg().dataType = 0;
    ProcessStatMsg(&env.RMsg(), &env.SMsg(), &env.Context());
    EXPECT_EQ(MSG_RESULT_FAILED, env.SMsg().result);
}

// aiCoreNum 为 0（host 平台查询异常透传）：tiling 的多核切分会除零，
// 必须不进入 tiling 计算，由 0 核回失败应答
TEST(ProcessStatMsgTest, ZeroCoreNumRepliesFailedWithoutTiling)
{
    DumpStatOpTestEnv env;
    StubBlockIdxRef() = 0;
    env.Init(16 * 1024, 127, 0); // 多核数据量 + aiCoreNum=0
    env.RMsg().dataType = static_cast<uint32_t>(OutputDataType::DUMP_DT_FLOAT);
    ProcessStatMsg(&env.RMsg(), &env.SMsg(), &env.Context());
    EXPECT_EQ(MSG_RESULT_FAILED, env.SMsg().result);
}

// ubSize 为 0：CalculateMaxProcCount 分子恒负，同样必须拦截在 tiling 之前
TEST(ProcessStatMsgTest, ZeroUbSizeRepliesFailedWithoutTiling)
{
    DumpStatOpTestEnv env;
    StubBlockIdxRef() = 0;
    env.Init(16 * 1024, 127, 1);
    env.Context().ubSize = 0;
    env.RMsg().dataType = static_cast<uint32_t>(OutputDataType::DUMP_DT_FLOAT);
    ProcessStatMsg(&env.RMsg(), &env.SMsg(), &env.Context());
    EXPECT_EQ(MSG_RESULT_FAILED, env.SMsg().result);
}

TEST(ProcessStatMsgTest, ZeroCountHandled)
{
    DumpStatOpTestEnv env;
    StubBlockIdxRef() = 0;
    env.Init(1024, 127, 1);
    env.RMsg().dataType = static_cast<uint32_t>(OutputDataType::DUMP_DT_FLOAT);
    env.RMsg().dataCount = 0;
    ProcessStatMsg(&env.RMsg(), &env.SMsg(), &env.Context());
    EXPECT_EQ(MSG_RESULT_SUCCESS, env.SMsg().result);
}

// SyncAllCoreG / SyncAllBlock（非 David 软同步路径，stub 下直接返回）
TEST(SyncAllTest, SoftSyncNoop)
{
    std::vector<uint8_t> syncspace(AI_CORE_NUM * BLOCK_SIZE, 0);
    KfcDumpContext ctx{};
    ctx.syncspace = reinterpret_cast<uint64_t>(syncspace.data());
    ctx.aiCoreNum = AI_CORE_NUM;
    SyncAllCoreG(ctx.syncspace, ctx.aiCoreNum);
    SyncAllBlock(ctx);
    SUCCEED();
}

// ---------------------------------------------------------------------------
// 多核归并补强：aiCoreNum>1 时 StatReduce 的跨核累加/取最值/sqrt 与不均分 tiling
// ---------------------------------------------------------------------------
class DumpStatMultiCoreReduceTest : public testing::Test {
protected:
    DumpStatOpTestEnv env;

    void SetUp() override
    {
        StubBlockIdxRef() = 0;
        StubResetBarrierCounts();
    }

    // 多核模板 + aiCoreNum>1：block0 视角承担全部数据（尾核语义），归并循环遍历全部核
    template <typename T>
    void RunOp(uint64_t coreNum)
    {
        TPipe pipe;
        KfcDumpStatMultiCore<T> op(&pipe, &env.RMsg(), &env.SMsg(), &env.Context());
        op.Init();
        op.Process();
        pipe.Destroy();
    }

    // 全核模拟（高编号核先跑、block0 最后跑以便其 CoreReduce 归并全部槽），
    // 结束后校验各核屏障到达次数一致：全核屏障下次数不等 = 真实硬件上参与核挂死
    template <typename T>
    void RunAllCoresAndCheckBarrier(uint64_t coreNum)
    {
        StubResetBarrierCounts();
        for (int64_t block = static_cast<int64_t>(coreNum) - 1; block >= 0; --block) {
            StubBlockIdxRef() = block;
            RunOp<T>(coreNum);
        }
        StubBlockIdxRef() = 0;
        int64_t badIdx = -1;
        ASSERT_TRUE(StubCheckBarrierCounts(static_cast<int64_t>(coreNum), badIdx))
            << "barrier arrive count mismatch: core" << badIdx << "=" << StubBarrierCounts()[badIdx]
            << " vs core0=" << StubBarrierCounts()[0];
    }
};

// aiCoreNum=4 且 totalCount 不被整除：覆盖不均分 tiling 分支（blockLengthEnd != blockLengthMean）。
// stub 单线程仅呈现 block0 视角：其余 3 核分片不参与计算，归并时其 workspace 槽为 0，
// 故 mean 被摊薄为 1/4、min 被拉低为 0（单线程仿真固有语义，断言按此校验）
TEST_F(DumpStatMultiCoreReduceTest, UnalignedSplitTiling)
{
    env.Init(16 * 1024 + 40, 127, 4); // 4 核，数据量非 4 整除
    constexpr int64_t N = (16 * 1024 + 40) / 4;
    std::vector<float> data(static_cast<size_t>(N), 6.0f);
    env.FillData(data);
    env.RMsg().dataType = static_cast<uint32_t>(OutputDataType::DUMP_DT_FLOAT);
    RunOp<float>(4);
    EXPECT_FLOAT_EQ(6.0f, OutF32(env, StatIdx(StatClass::STAT_MAX)));           // max 不受 0 槽影响
    EXPECT_FLOAT_EQ(0.0f, OutF32(env, StatIdx(StatClass::STAT_MIN)));           // 0 槽参与 min
    EXPECT_NEAR(OutF32(env, StatIdx(StatClass::STAT_MEAN)), 6.0f / 4.0f, 0.1f); // 摊薄
}

// aiCoreNum=4：StatReduce 跨核归并（mean 累加、l2norm 平方和 + sqrt、max/min 逐核比较）。
// 单线程语义：仅 block0 分片产生有效结果，其余 3 槽为 0，mean 摊薄 1/4、l2 求和后开方
TEST_F(DumpStatMultiCoreReduceTest, CrossCoreReduceAllStats)
{
    env.Init(16 * 1024, 127, 4);
    constexpr int64_t N = (16 * 1024) / 4;
    std::vector<float> data(static_cast<size_t>(N));
    for (int64_t i = 0; i < N; ++i) {
        data[static_cast<size_t>(i)] = static_cast<float>(i % 50); // 0..49 循环，非负
    }
    env.FillData(data);
    env.RMsg().dataType = static_cast<uint32_t>(OutputDataType::DUMP_DT_FLOAT);
    RunOp<float>(4);
    EXPECT_FLOAT_EQ(49.0f, OutF32(env, StatIdx(StatClass::STAT_MAX)));
    EXPECT_FLOAT_EQ(0.0f, OutF32(env, StatIdx(StatClass::STAT_MIN))); // 含 0 值数据本身 min=0
    // mean: block0 分片(前 1024 元素 i%50)均值 24.195，跨 4 槽累加摊薄为 1/4
    EXPECT_NEAR(OutF32(env, StatIdx(StatClass::STAT_MEAN)), 24.1953f / 4.0f, 0.1f);
    // l2: sqrt(block0 分片平方和 sum((i%50)^2), i=0..1023 = 812824)
    EXPECT_NEAR(OutF32(env, StatIdx(StatClass::STAT_L2NORM)), sqrtf(812824.0f), 0.5f);
}

// 非 0 核视角：CoreReduce 提前 return，不写输出（177 行分支）
TEST_F(DumpStatMultiCoreReduceTest, NonZeroBlockSkipsCoreReduce)
{
    env.Init(16 * 1024, 127, 4);
    constexpr int64_t N = (16 * 1024) / 4;
    std::vector<float> data(static_cast<size_t>(N), 3.0f);
    env.FillData(data);
    env.RMsg().dataType = static_cast<uint32_t>(OutputDataType::DUMP_DT_FLOAT);
    StubBlockIdxRef() = 2; // 非 0 核
    RunOp<float>(4);
    StubBlockIdxRef() = 0;
    // 非 0 核不归并：输出区不被写入
    EXPECT_EQ(0, OutI32(env, StatIdx(StatClass::STAT_NAN)));
}

// 多核 int32 跨核归并（int32 的 max/min 走 StatReduce<int32_t> 实例化分支）。
// 单线程语义：block0 分片为数据前 1/4（i-100, i=0..1023 -> -100..923），
// max 取分片最大值 923，min 取 -100
TEST_F(DumpStatMultiCoreReduceTest, CrossCoreReduceInt32)
{
    env.Init(16 * 1024, 127, 4);
    constexpr int64_t N = (16 * 1024) / 4; // int32 元素数
    std::vector<int32_t> data(static_cast<size_t>(N));
    for (int64_t i = 0; i < N; ++i) {
        data[static_cast<size_t>(i)] = static_cast<int32_t>(i) - 100;
    }
    env.FillData(data);
    env.RMsg().dataType = static_cast<uint32_t>(OutputDataType::DUMP_DT_INT32);
    RunOp<int32_t>(4);
    EXPECT_EQ(1024 - 101, OutI32(env, StatIdx(StatClass::STAT_MAX))); // 分片内最大 923
    EXPECT_EQ(-100, OutI32(env, StatIdx(StatClass::STAT_MIN)));
}

// 元素数略大于核数：totalCount(2050) > aiCoreNum(70) 时旧逻辑 blockLengthEnd_ 为负，
// 尾核带负长度搬运并越界读 GM。修复后按 usedCoreNum 裁剪，无核越界。
// 循环模拟全部 70 个核执行（每核独立 TPipe），0 核归并出最终结果
TEST_F(DumpStatMultiCoreReduceTest, SlightlyMoreElementsThanCores)
{
    constexpr int64_t kCores = 70;
    constexpr int64_t kTotal = 2050; // 2050 = 29*70 + 20：usedCoreNum=69，尾核 20 元素
    std::vector<float> data(static_cast<size_t>(kTotal), -1.5f);
    env.Init(kTotal * 4, 127, kCores);
    env.FillData(data);
    env.RMsg().dataType = static_cast<uint32_t>(OutputDataType::DUMP_DT_FLOAT);
    RunAllCoresAndCheckBarrier<float>(kCores);
    // 全负数据：max/min 均为 -1.5；若旧逻辑下尾核负长度或 0 槽参与归并，max 会变 0
    EXPECT_FLOAT_EQ(-1.5f, OutF32(env, StatIdx(StatClass::STAT_MAX)));
    EXPECT_FLOAT_EQ(-1.5f, OutF32(env, StatIdx(StatClass::STAT_MIN)));
    EXPECT_NEAR(OutF32(env, StatIdx(StatClass::STAT_MEAN)), -1.5f, 1e-4f); // 分核累加有浮点误差
}

// 高编号核视角：blockIdx >= usedCoreNum(69) 时跳过搬运直接归并，不读 GM、不写 workspace
TEST_F(DumpStatMultiCoreReduceTest, IdleCoreSkipsCopyIn)
{
    constexpr int64_t kCores = 70;
    constexpr int64_t kTotal = 2050; // usedCoreNum=69：block69 为空闲核
    std::vector<float> data(static_cast<size_t>(kTotal), 2.0f);
    env.Init(kTotal * 4, 127, kCores);
    env.FillData(data);
    env.RMsg().dataType = static_cast<uint32_t>(OutputDataType::DUMP_DT_FLOAT);
    RunAllCoresAndCheckBarrier<float>(kCores);
    EXPECT_FLOAT_EQ(2.0f, OutF32(env, StatIdx(StatClass::STAT_MAX)));
    EXPECT_FLOAT_EQ(2.0f, OutF32(env, StatIdx(StatClass::STAT_MIN)));
    EXPECT_NEAR(OutF32(env, StatIdx(StatClass::STAT_MEAN)), 2.0f, 1e-4f); // 分核累加有浮点误差
}
