/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <atomic>
#include <cstring>
#include <thread>

#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "runtime/rt.h"
#include "cond_op_manager.hpp"
#include "cond_op_stream_task.h"
#define private public
#include "model.hpp"
#undef private
#include "model_execute_task.h"
#include "inner_thread_local.hpp"
#include "rt_unwrap.h"
#include "runtime.hpp"
#include "stars_cond_isa_define.hpp"
#include "stars_cond_isa_helper.hpp"
#include "stream.hpp"
#include "stream_task.h"
#include "thread_local_container.hpp"
#include "task_info.hpp"

using namespace cce::runtime;

namespace {

template <typename T>
uint32_t GetWord(const T& value, const size_t offset = 0U)
{
    uint32_t word = 0U;
    std::memcpy(&word, reinterpret_cast<const uint8_t*>(&value) + offset, sizeof(word));
    return word;
}

uint32_t EncodeArch9201Word(
    const uint32_t opCode, const uint32_t rd, const uint32_t func3, const uint32_t rs1, const uint32_t immediate = 0U)
{
    return opCode | (rd << 7U) | (func3 << 12U) | (rs1 << 15U) | (immediate << 20U);
}

void ExpectAllConstructFuncsRegistered(const rtChipType_t chipType)
{
    EXPECT_NE(g_condIsaConstructFunc[chipType].constructNop, nullptr);
    EXPECT_NE(g_condIsaConstructFunc[chipType].constructLoad, nullptr);
    EXPECT_NE(g_condIsaConstructFunc[chipType].constructLoadImm, nullptr);
    EXPECT_NE(g_condIsaConstructFunc[chipType].constructOpImmAndi, nullptr);
    EXPECT_NE(g_condIsaConstructFunc[chipType].constructOpImmSlli, nullptr);
    EXPECT_NE(g_condIsaConstructFunc[chipType].constructOpOp, nullptr);
    EXPECT_NE(g_condIsaConstructFunc[chipType].constructLhwi, nullptr);
    EXPECT_NE(g_condIsaConstructFunc[chipType].constructLlwi, nullptr);
    EXPECT_NE(g_condIsaConstructFunc[chipType].constructBranch, nullptr);
    EXPECT_NE(g_condIsaConstructFunc[chipType].constructLoop, nullptr);
    EXPECT_NE(g_condIsaConstructFunc[chipType].constructActiveI, nullptr);
    EXPECT_NE(g_condIsaConstructFunc[chipType].constructDeActiveI, nullptr);
    EXPECT_NE(g_condIsaConstructFunc[chipType].constructActiveR, nullptr);
    EXPECT_NE(g_condIsaConstructFunc[chipType].constructDeActiveR, nullptr);
    EXPECT_NE(g_condIsaConstructFunc[chipType].constructGotoI, nullptr);
    EXPECT_NE(g_condIsaConstructFunc[chipType].constructGotoR, nullptr);
    EXPECT_NE(g_condIsaConstructFunc[chipType].constructStore, nullptr);
    EXPECT_NE(g_condIsaConstructFunc[chipType].constructSystemCsr, nullptr);
    EXPECT_NE(g_condIsaConstructFunc[chipType].constructFuncCall, nullptr);
    EXPECT_NE(g_condIsaConstructFunc[chipType].constructErrorInstr, nullptr);
}

void ConstructAllOps(const rtChipType_t chipType)
{
    InnerThreadLocalContainer::SetCurrentChipType(chipType);

    RtStarsCondOpNop nop = {};
    ConstructNop(nop);
    EXPECT_EQ(nop.opCode, RT_STARS_COND_ISA_OP_CODE_NOP);

    RtStarsCondOpLoad load = {};
    ConstructLoad(
        RT_STARS_COND_ISA_REGISTER_R10, 0xABCU, RT_STARS_COND_ISA_REGISTER_R9, RT_STARS_COND_ISA_LOAD_FUNC3_LDR, load);

    RtStarsCondOpLoadImm loadImm = {};
    constexpr uint64_t address = 0x123456789ABCDEF0ULL;
    ConstructLoadImm(RT_STARS_COND_ISA_REGISTER_R8, address, RT_STARS_COND_ISA_LOAD_IMM_FUNC3_LD, loadImm);

    RtStarsCondOpImm opImmAndi = {};
    ConstructOpImmAndi(
        RT_STARS_COND_ISA_REGISTER_R7, RT_STARS_COND_ISA_REGISTER_R6, 0x1ABCU, RT_STARS_COND_ISA_OP_IMM_FUNC3_ANDI,
        opImmAndi);

    RtStarsCondOpImmSLLI opImmSlli = {};
    ConstructOpImmSlli(
        RT_STARS_COND_ISA_REGISTER_R5, RT_STARS_COND_ISA_REGISTER_R4, 0x2AU, RT_STARS_COND_ISA_OP_IMM_FUNC3_SLLI,
        RT_STARS_COND_ISA_OP_IMM_FUNC7_SLLI, opImmSlli);

    RtStarsCondOpOp opOp = {};
    ConstructOpOp(
        RT_STARS_COND_ISA_REGISTER_R3, RT_STARS_COND_ISA_REGISTER_R2, RT_STARS_COND_ISA_REGISTER_R1,
        RT_STARS_COND_ISA_OP_FUNC3_ADD, RT_STARS_COND_ISA_OP_FUNC7_ADD, opOp);

    RtStarsCondOpLHWI lhwi = {};
    ConstructLHWI(RT_STARS_COND_ISA_REGISTER_R2, address, lhwi);

    RtStarsCondOpLLWI llwi = {};
    ConstructLLWI(RT_STARS_COND_ISA_REGISTER_R2, address, llwi);

    RtStarsCondOpBranch branch = {};
    ConstructBranch(
        RT_STARS_COND_ISA_REGISTER_R10, RT_STARS_COND_ISA_REGISTER_R9, RT_STARS_COND_ISA_BRANCH_FUNC3_BNE, 0xABU,
        branch);

    RtStarsCondOpLoop loop = {};
    ConstructLoop(RT_STARS_COND_ISA_REGISTER_R8, 0x3FFFU, 0xABU, loop);

    RtStarsCondOpStreamActiveI activeI = {};
    ConstructActiveI(RT_STARS_COND_ISA_REGISTER_R7, 0x123U, activeI);

    RtStarsCondOpStreamDeActiveI deactiveI = {};
    ConstructDeActiveI(RT_STARS_COND_ISA_REGISTER_R7, 0x123U, deactiveI);

    RtStarsCondOpStreamActiveR activeR = {};
    ConstructActiveR(RT_STARS_COND_ISA_REGISTER_R10, RT_STARS_COND_ISA_REGISTER_R9, activeR);

    RtStarsCondOpStreamDeActiveR deactiveR = {};
    ConstructDeActiveR(RT_STARS_COND_ISA_REGISTER_R10, RT_STARS_COND_ISA_REGISTER_R9, deactiveR);

    RtStarsCondOpStreamGotoI gotoI = {};
    ConstructGotoI(RT_STARS_COND_ISA_REGISTER_R8, 0x123U, 0x4567U, gotoI);

    RtStarsCondOpStreamGotoR gotoR = {};
    ConstructGotoR(RT_STARS_COND_ISA_REGISTER_R10, RT_STARS_COND_ISA_REGISTER_R9, gotoR);

    RtStarsCondOpStore store = {};
    ConstructStore(
        RT_STARS_COND_ISA_REGISTER_R8, RT_STARS_COND_ISA_REGISTER_R7, 0xABCU, RT_STARS_COND_ISA_STORE_FUNC3_SD, store);

    RtStarsCondOpSystemCsr systemCsr = {};
    ConstructSystemCsr(
        RT_STARS_COND_ISA_REGISTER_R6, RT_STARS_COND_ISA_REGISTER_R5, RT_STARS_COND_CSR_JUMP_PC_REG,
        RT_STARS_COND_ISA_SYSTEM_FUNC3_CSRRW, systemCsr);

    RtStarsCondOpFuncCall funcCall = {};
    ConstructFuncCall(RT_STARS_COND_ISA_REGISTER_R4, RT_STARS_COND_ISA_REGISTER_R3, funcCall);

    RtStarsCondOpErrorInstr errorInstr = {0xFFFFFFFFU};
    ConstructErrorInstr(errorInstr);

    if (chipType == CHIP_CLOUD_V5) {
        EXPECT_EQ(
            GetWord(load), EncodeArch9201Word(
                               RT_STARS_COND_ISA_OP_CODE_LOAD, RT_STARS_COND_ISA_REGISTER_R9,
                               RT_STARS_COND_ISA_LOAD_FUNC3_LDR, RT_STARS_COND_ISA_REGISTER_R10, 0xABCU));
        EXPECT_EQ(
            GetWord(loadImm), RT_STARS_COND_ISA_OP_CODE_LOAD_IMM | (RT_STARS_COND_ISA_REGISTER_R8 << 7U) |
                                  (RT_STARS_COND_ISA_LOAD_IMM_FUNC3_LD << 12U) |
                                  (static_cast<uint32_t>((address >> 32U) & 0x1FFFFU) << 15U));
        EXPECT_EQ(GetWord(loadImm, sizeof(uint32_t)), static_cast<uint32_t>(address));
        EXPECT_EQ(
            GetWord(activeR), EncodeArch9201Word(
                                  RT_STARS_COND_ISA_OP_CODE_STREAM, RT_STARS_COND_ISA_REGISTER_R9,
                                  RT_STARS_COND_ISA_STREAM_FUNC3_ACTIVE_R, RT_STARS_COND_ISA_REGISTER_R10));
        EXPECT_EQ(
            GetWord(deactiveR), EncodeArch9201Word(
                                    RT_STARS_COND_ISA_OP_CODE_STREAM, RT_STARS_COND_ISA_REGISTER_R9,
                                    RT_STARS_COND_ISA_STREAM_FUNC3_DEACTIVE_R, RT_STARS_COND_ISA_REGISTER_R10));
    } else {
        EXPECT_EQ(load.opCode, RT_STARS_COND_ISA_OP_CODE_LOAD);
        EXPECT_EQ(load.rd, RT_STARS_COND_ISA_REGISTER_R9 & 0x7U);
        EXPECT_EQ(load.rs1, RT_STARS_COND_ISA_REGISTER_R10 & 0x7U);
        EXPECT_EQ(load.immd, 0xABCU);
        EXPECT_EQ(loadImm.opCode, RT_STARS_COND_ISA_OP_CODE_LOAD_IMM);
        EXPECT_EQ(loadImm.rd, RT_STARS_COND_ISA_REGISTER_R8 & 0x7U);
        EXPECT_EQ(loadImm.immdAddrLow, static_cast<uint32_t>(address));
        EXPECT_EQ(activeR.rd, RT_STARS_COND_ISA_REGISTER_R9 & 0x7U);
        EXPECT_EQ(activeR.rs1, RT_STARS_COND_ISA_REGISTER_R10 & 0x7U);
    }

    EXPECT_EQ(opImmAndi.opCode, RT_STARS_COND_ISA_OP_CODE_OP_IMM);
    EXPECT_EQ(opImmSlli.opCode, RT_STARS_COND_ISA_OP_CODE_OP_IMM);
    EXPECT_EQ(opOp.opCode, RT_STARS_COND_ISA_OP_CODE_OP);
    EXPECT_EQ(lhwi.opCode, RT_STARS_COND_ISA_OP_CODE_LWI);
    EXPECT_EQ(llwi.opCode, RT_STARS_COND_ISA_OP_CODE_LWI);
    EXPECT_EQ(branch.opCode, RT_STARS_COND_ISA_OP_CODE_BRANCH);
    EXPECT_EQ(loop.opCode, RT_STARS_COND_ISA_OP_CODE_LOOP);
    EXPECT_EQ(activeI.opCode, RT_STARS_COND_ISA_OP_CODE_STREAM);
    EXPECT_EQ(deactiveI.opCode, RT_STARS_COND_ISA_OP_CODE_STREAM);
    EXPECT_EQ(gotoI.opCode, RT_STARS_COND_ISA_OP_CODE_STREAM);
    EXPECT_EQ(gotoR.opCode, RT_STARS_COND_ISA_OP_CODE_STREAM);
    EXPECT_EQ(store.opCode, RT_STARS_COND_ISA_OP_CODE_STORE);
    EXPECT_EQ(systemCsr.opCode, RT_STARS_COND_ISA_OP_CODE_SYSTEM);
    EXPECT_EQ(funcCall.opCode, RT_STARS_COND_ISA_OP_CODE_FUNC_CALL);
    EXPECT_EQ(errorInstr.err, 0U);
}

} // namespace

TEST(CondIsaArch9201Test, RegistrationAndAllConstructors)
{
    const rtChipType_t originalChipType = InnerThreadLocalContainer::GetCurrentChipType();
    ExpectAllConstructFuncsRegistered(CHIP_DAVID);
    ExpectAllConstructFuncsRegistered(CHIP_CLOUD_V5);

    ConstructAllOps(CHIP_DAVID);
    ConstructAllOps(CHIP_CLOUD_V5);

    InnerThreadLocalContainer::SetCurrentChipType(originalChipType);
}

TEST(CondIsaArch9201Test, TaskRegistrationAndInvalidDispatch)
{
    const rtChipType_t originalChipType = InnerThreadLocalContainer::GetCurrentChipType();

    InnerThreadLocalContainer::SetCurrentChipType(CHIP_CLOUD_V5);
    const CondIsaTaskFuncs* const arch9201Funcs = GetCurrentCondIsaTaskFuncs();
    ASSERT_NE(arch9201Funcs, nullptr);
    EXPECT_NE(arch9201Funcs->prepareStreamSwitch, nullptr);
    EXPECT_NE(arch9201Funcs->prepareStreamActive, nullptr);
    EXPECT_NE(arch9201Funcs->reconstructStreamActive, nullptr);
    EXPECT_NE(arch9201Funcs->prepareModelExecuteFuncCall, nullptr);

    InnerThreadLocalContainer::SetCurrentChipType(CHIP_DAVID);
    EXPECT_EQ(GetCurrentCondIsaTaskFuncs(), nullptr);

    InnerThreadLocalContainer::SetCurrentChipType(CHIP_END);
    EXPECT_EQ(GetCurrentCondIsaTaskFuncs(), nullptr);
    RtStarsCondOpNop nop = {};
    ConstructNop(nop);
    EXPECT_EQ(nop.opCode, 0U);

    InnerThreadLocalContainer::SetCurrentChipType(CHIP_CLOUD);
    nop = {};
    ConstructNop(nop);
    EXPECT_EQ(nop.opCode, 0U);

    RegCondIsaTaskFuncs(CHIP_END, nullptr);
    RegCondIsaConstructFunc(CHIP_END, {});
    InnerThreadLocalContainer::SetCurrentChipType(originalChipType);
}

TEST(CondIsaArch9201Test, ThreadLocalChipSelectsIndependentConstructors)
{
    constexpr uint32_t registerMaskV100 = 0x7U;
    constexpr uint32_t registerMaskV200 = 0xFU;
    constexpr uint32_t rdOffset = 7U;
    constexpr uint32_t func3Offset = 12U;
    constexpr uint32_t rs1Offset = 15U;
    constexpr uint32_t rs1Value = 10U;
    constexpr uint32_t dstValue = 9U;
    constexpr uint32_t defaultWord = RT_STARS_COND_ISA_OP_CODE_STREAM | ((dstValue & registerMaskV100) << rdOffset) |
                                     (RT_STARS_COND_ISA_STREAM_FUNC3_ACTIVE_R << func3Offset) |
                                     ((rs1Value & registerMaskV100) << rs1Offset);
    constexpr uint32_t cloudV5Word = RT_STARS_COND_ISA_OP_CODE_STREAM | ((dstValue & registerMaskV200) << rdOffset) |
                                     (RT_STARS_COND_ISA_STREAM_FUNC3_ACTIVE_R << func3Offset) |
                                     ((rs1Value & registerMaskV200) << rs1Offset);

    std::atomic<uint32_t> readyCount{0U};
    std::atomic<bool> start{false};
    std::atomic<bool> defaultResult{true};
    std::atomic<bool> cloudV5Result{true};
    const auto constructAndCheck = [&](const rtChipType_t chipType, const uint32_t expectedWord,
                                       std::atomic<bool>& result) {
        InnerThreadLocalContainer::SetCurrentChipType(chipType);
        readyCount.fetch_add(1U, std::memory_order_release);
        while (!start.load(std::memory_order_acquire)) {
            std::this_thread::yield();
        }
        for (uint32_t i = 0U; i < 1000U; ++i) {
            RtStarsCondOpStreamActiveR op = {};
            ConstructActiveR(
                static_cast<rtStarsCondIsaRegister_t>(rs1Value), static_cast<rtStarsCondIsaRegister_t>(dstValue), op);
            if (GetWord(op) != expectedWord) {
                result.store(false, std::memory_order_release);
                return;
            }
        }
    };

    std::thread defaultThread(constructAndCheck, CHIP_DAVID, defaultWord, std::ref(defaultResult));
    std::thread cloudV5Thread(constructAndCheck, CHIP_CLOUD_V5, cloudV5Word, std::ref(cloudV5Result));
    while (readyCount.load(std::memory_order_acquire) != 2U) {
        std::this_thread::yield();
    }
    start.store(true, std::memory_order_release);
    defaultThread.join();
    cloudV5Thread.join();

    EXPECT_TRUE(defaultResult.load(std::memory_order_acquire));
    EXPECT_TRUE(cloudV5Result.load(std::memory_order_acquire));
}

class Arch9201CondTaskTest : public testing::Test {
protected:
    void SetUp() override
    {
        Runtime* const runtime = static_cast<Runtime*>(Runtime::Instance());
        oldRuntimeChipType_ = runtime->GetChipType();
        oldGlobalChipType_ = GlobalContainer::GetRtChipType();
        oldThreadChipType_ = InnerThreadLocalContainer::GetCurrentChipType();
        oldDisableThread_ = runtime->GetDisableThread();
        runtime->SetDisableThread(true);
        runtime->SetChipType(CHIP_CLOUD_V5);
        GlobalContainer::SetRtChipType(CHIP_CLOUD_V5);
        ASSERT_EQ(rtSetDevice(0), RT_ERROR_NONE);
        device_ = runtime->DeviceRetain(0, 0);
        ASSERT_NE(device_, nullptr);
        device_->SetChipType(CHIP_CLOUD_V5);
        ASSERT_EQ(rtStreamCreate(&streamHandle_, 0), RT_ERROR_NONE);
        stream_ = rt_ut::UnwrapOrNull<Stream>(streamHandle_);
        ASSERT_NE(stream_, nullptr);
        InnerThreadLocalContainer::SetCurrentChipType(CHIP_CLOUD_V5);
    }

    void TearDown() override
    {
        GlobalMockObject::verify();
        if (streamHandle_ != nullptr) {
            (void)rtStreamDestroy(streamHandle_);
        }
        Runtime* const runtime = static_cast<Runtime*>(Runtime::Instance());
        if (device_ != nullptr) {
            runtime->DeviceRelease(device_);
        }
        (void)rtDeviceReset(0);
        runtime->SetChipType(oldRuntimeChipType_);
        runtime->SetDisableThread(oldDisableThread_);
        GlobalContainer::SetRtChipType(oldGlobalChipType_);
        InnerThreadLocalContainer::SetCurrentChipType(oldThreadChipType_);
        stream_ = nullptr;
        streamHandle_ = nullptr;
        device_ = nullptr;
    }

    void MockDeviceMemory()
    {
        Driver* const driver = device_->Driver_();
        ASSERT_NE(driver, nullptr);
        MOCKER_CPP_VIRTUAL(device_, &Device::GetStarsRegBaseAddr).stubs().will(returnValue(0x100000UL));
        void* const memory = reinterpret_cast<void*>(0x10000000ULL);
        memory_ = memory;
        MOCKER_CPP_VIRTUAL(driver, &Driver::MemAddressTranslate).stubs().will(returnValue(RT_ERROR_NONE));
        MOCKER_CPP_VIRTUAL(driver, &Driver::DevMemAlloc)
            .stubs()
            .with(outBoundP(&memory_, sizeof(memory_)), mockcpp::any(), mockcpp::any(), mockcpp::any())
            .will(returnValue(RT_ERROR_NONE));
        MOCKER_CPP_VIRTUAL(driver, &Driver::DevMemFree).stubs().will(returnValue(RT_ERROR_NONE));
        MOCKER_CPP_VIRTUAL(driver, &Driver::MemCopySync).stubs().will(returnValue(RT_ERROR_NONE));
    }

    rtChipType_t oldRuntimeChipType_{CHIP_END};
    rtChipType_t oldGlobalChipType_{CHIP_END};
    rtChipType_t oldThreadChipType_{CHIP_END};
    bool oldDisableThread_{false};
    Device* device_{nullptr};
    Stream* stream_{nullptr};
    rtStream_t streamHandle_{nullptr};
    void* memory_{nullptr};
};

TEST_F(Arch9201CondTaskTest, StreamSwitchAndStreamActiveUseArch9201TaskFuncs)
{
    MockDeviceMemory();

    TaskInfo switchTask = {};
    switchTask.stream = stream_;
    uint64_t variable = 0U;
    EXPECT_EQ(StreamSwitchTaskInitV1(&switchTask, &variable, RT_EQUAL, 1, stream_), RT_ERROR_NONE);
    EXPECT_GT(switchTask.u.streamswitchTask.funCallMemSize, 0U);
    StreamSwitchTaskUnInit(&switchTask);

    TaskInfo switchExTask = {};
    switchExTask.stream = stream_;
    uint32_t value = 1U;
    EXPECT_EQ(
        StreamSwitchTaskInitV2(&switchExTask, &variable, RT_EQUAL, stream_, &value, RT_SWITCH_INT32), RT_ERROR_NONE);
    EXPECT_GT(switchExTask.u.streamswitchTask.funCallMemSize, 0U);
    StreamSwitchTaskUnInit(&switchExTask);

    TaskInfo activeTask = {};
    activeTask.stream = stream_;
    EXPECT_EQ(StreamActiveTaskInit(&activeTask, stream_), RT_ERROR_NONE);
    EXPECT_EQ(ReConstructStreamActiveTaskFc(&activeTask), RT_ERROR_NONE);
    StreamActiveTaskUnInit(&activeTask);
}

TEST_F(Arch9201CondTaskTest, ModelExecuteUsesArch9201TaskFunc)
{
    MockDeviceMemory();
    rtModel_t modelHandle = nullptr;
    ASSERT_EQ(rtModelCreate(&modelHandle, 0), RT_ERROR_NONE);
    Model* const model = rt_ut::UnwrapOrNull<Model>(modelHandle);
    ASSERT_NE(model, nullptr);
    model->streams_.push_front(stream_);
    model->headStreams_.push_back(stream_);
    stream_->SetModel(model);
    stream_->SetBindFlag(true);

    TaskInfo executeTask = {};
    executeTask.stream = stream_;
    EXPECT_EQ(ModelExecuteTaskInit(&executeTask, model, model->Id_(), 0U), RT_ERROR_NONE);
    EXPECT_FALSE(model->GetFirstExecute());
    ModelExecuteTaskUnInit(&executeTask);

    stream_->SetModel(nullptr);
    stream_->SetBindFlag(false);
    model->ModelRemoveStream(stream_);
    model->headStreams_.remove(stream_);
    EXPECT_EQ(rtModelDestroy(modelHandle), RT_ERROR_NONE);
}
