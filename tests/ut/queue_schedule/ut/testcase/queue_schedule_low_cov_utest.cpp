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
#include "mockcpp/mockcpp.hpp"

#define private public
#define protected public
#include "data_obj_manager.h"
#include "fsm/state_base.h"
#include "simple_entity.h"
#include "strategy/strategy_manager.h"
#undef private
#undef protected

#include "hccl/hcom.h"
#include "hccl/hccl_ex.h"
#include "hccl/hccl_so_manager.h"
#include "bqs_log.h"
#include "qs_args_parser.h"
#include "tsd.h"

using namespace dgw;

namespace bqs {
extern void* hostQsFuncMap[static_cast<uint32_t>(QsLogFuncId::FUNC_MAXID)];
}

namespace {

int32_t FakeCheckLogLevel(int32_t, int32_t) { return 1; }
int32_t FakeCheckLogLevelDisabled(int32_t, int32_t) { return 0; }
void FakeDlogRecord(int32_t, int32_t, const char*, ...) {}
int32_t FakeDlogSetLevel(int32_t, int32_t, int32_t) { return 1; }
int32_t FakeDlogSetAttr(LogAttr) { return 1; }

HcclResult FakeHcclInitComm(const char_t*, uint32_t, const CommAttr*, HcclComm*) { return HCCL_SUCCESS; }
HcclResult FakeHcclFinalizeComm(HcclComm) { return HCCL_SUCCESS; }
int32_t FakeHcclIsend(void*, int32_t, HcclDataType, int32_t, int32_t, HcclComm, HcclRequest*) { return HCCL_SUCCESS; }
int32_t FakeHcclImrecv(void*, int32_t, HcclDataType, HcclMessage*, HcclRequest*) { return HCCL_SUCCESS; }
int32_t FakeHcclImprobe(int32_t, int32_t, HcclComm, int32_t*, HcclMessage*, HcclStatus*) { return HCCL_SUCCESS; }
int32_t FakeHcclGetCount(const HcclStatus*, HcclDataType, int32_t*) { return HCCL_SUCCESS; }
int32_t FakeHcclTestSome(int32_t, HcclRequest[], int32_t*, int32_t[], HcclStatus[]) { return HCCL_SUCCESS; }
HcclResult FakeHcclRegisterMemory(HcclComm, void*, uint64_t) { return HCCL_SUCCESS; }
HcclResult FakeHcclUnregisterMemory(HcclComm, void*) { return HCCL_SUCCESS; }
HcclResult FakeHcclSetGrpIdCallback(int32_t (*)(int32_t, int32_t*, int32_t*)) { return HCCL_SUCCESS; }

class TestState : public StateBase {
public:
    FsmStatus PreProcess(Entity& entity) override
    {
        (void)entity;
        return FsmStatus::FSM_SUCCESS;
    }

    FsmStatus PostProcess(Entity& entity) override
    {
        (void)entity;
        return FsmStatus::FSM_SUCCESS;
    }
};

class QueueScheduleLowCovUtest : public testing::Test {
protected:
    void TearDown() override { GlobalMockObject::verify(); }
};

TEST_F(QueueScheduleLowCovUtest, HcclStubNullFunc)
{
    MOCKER_CPP(&HcclSoManager::GetFunc).stubs().will(returnValue(static_cast<void*>(nullptr)));

    EXPECT_NE(HcclInitComm(nullptr, 0U, nullptr, nullptr), HCCL_SUCCESS);
    EXPECT_NE(HcclFinalizeComm(nullptr), HCCL_SUCCESS);
    EXPECT_NE(HcclIsend(nullptr, 0, HCCL_DATA_TYPE_RESERVED, 0, 0, nullptr, nullptr), HCCL_SUCCESS);
    EXPECT_NE(HcclImrecv(nullptr, 0, HCCL_DATA_TYPE_RESERVED, nullptr, nullptr), HCCL_SUCCESS);
    EXPECT_NE(HcclImprobe(0, 0, nullptr, nullptr, nullptr, nullptr), HCCL_SUCCESS);
    EXPECT_NE(HcclGetCount(nullptr, HCCL_DATA_TYPE_RESERVED, nullptr), HCCL_SUCCESS);
    EXPECT_NE(HcclTestSome(0, nullptr, nullptr, nullptr, nullptr), HCCL_SUCCESS);
    EXPECT_NE(HcclRegisterMemory(nullptr, nullptr, 0U), HCCL_SUCCESS);
    EXPECT_NE(HcclUnregisterMemory(nullptr, nullptr), HCCL_SUCCESS);
    EXPECT_NE(::HcclSetGrpIdCallback(nullptr), HCCL_SUCCESS);
}

TEST_F(QueueScheduleLowCovUtest, HcclStubSuccessFunc)
{
    MOCKER_CPP(&HcclSoManager::GetFunc)
        .stubs()
        .will(returnValue(reinterpret_cast<void*>(FakeHcclInitComm)))
        .then(returnValue(reinterpret_cast<void*>(FakeHcclFinalizeComm)))
        .then(returnValue(reinterpret_cast<void*>(FakeHcclIsend)))
        .then(returnValue(reinterpret_cast<void*>(FakeHcclImrecv)))
        .then(returnValue(reinterpret_cast<void*>(FakeHcclImprobe)))
        .then(returnValue(reinterpret_cast<void*>(FakeHcclGetCount)))
        .then(returnValue(reinterpret_cast<void*>(FakeHcclTestSome)))
        .then(returnValue(reinterpret_cast<void*>(FakeHcclRegisterMemory)))
        .then(returnValue(reinterpret_cast<void*>(FakeHcclUnregisterMemory)))
        .then(returnValue(reinterpret_cast<void*>(FakeHcclSetGrpIdCallback)));

    EXPECT_EQ(HcclInitComm(nullptr, 0U, nullptr, nullptr), HCCL_SUCCESS);
    EXPECT_EQ(HcclFinalizeComm(nullptr), HCCL_SUCCESS);
    EXPECT_EQ(HcclIsend(nullptr, 0, HCCL_DATA_TYPE_RESERVED, 0, 0, nullptr, nullptr), HCCL_SUCCESS);
    EXPECT_EQ(HcclImrecv(nullptr, 0, HCCL_DATA_TYPE_RESERVED, nullptr, nullptr), HCCL_SUCCESS);
    EXPECT_EQ(HcclImprobe(0, 0, nullptr, nullptr, nullptr, nullptr), HCCL_SUCCESS);
    EXPECT_EQ(HcclGetCount(nullptr, HCCL_DATA_TYPE_RESERVED, nullptr), HCCL_SUCCESS);
    EXPECT_EQ(HcclTestSome(0, nullptr, nullptr, nullptr, nullptr), HCCL_SUCCESS);
    EXPECT_EQ(HcclRegisterMemory(nullptr, nullptr, 0U), HCCL_SUCCESS);
    EXPECT_EQ(HcclUnregisterMemory(nullptr, nullptr), HCCL_SUCCESS);
    EXPECT_EQ(::HcclSetGrpIdCallback(nullptr), HCCL_SUCCESS);
}

TEST_F(QueueScheduleLowCovUtest, BaseStateProcessMessage)
{
    EntityMaterial material{};
    material.eType = EntityType::ENTITY_QUEUE;
    SimpleEntity entity(material, 0U);
    InnerMessage msg{};
    TestState state;
    EXPECT_EQ(state.ProcessMessage(entity, msg), FsmStatus::FSM_SUCCESS);
}

TEST_F(QueueScheduleLowCovUtest, DataObjUpdateRecvEntities)
{
    EntityMaterial material{};
    material.eType = EntityType::ENTITY_QUEUE;
    EntityPtr group = std::make_shared<SimpleEntity>(material, 0U);
    material.id = 1U;
    EntityPtr elem = std::make_shared<SimpleEntity>(material, 0U);

    DataObj dataObj(nullptr, nullptr);
    dataObj.AddRecvEntity(group.get());
    EXPECT_TRUE(dataObj.UpdateRecvEntities(group, elem));
    EXPECT_TRUE(dataObj.RemoveRecvEntity(elem.get()));
    EXPECT_FALSE(dataObj.UpdateRecvEntities(group, elem));
    EXPECT_FALSE(dataObj.RemoveRecvEntity(group.get()));
    EXPECT_NE(DataObjManager::Instance().CreateDataObj(nullptr, nullptr), nullptr);
}

TEST_F(QueueScheduleLowCovUtest, StrategyManagerUnknownPolicy)
{
    const auto unknownPolicy = static_cast<bqs::GroupPolicy>(999);
    EXPECT_EQ(StrategyManager::GetInstance().GetStrategy(unknownPolicy), nullptr);
    EXPECT_EQ(StrategyManager::GetInstance().GetStrategyDesc(unknownPolicy), "");
}

TEST_F(QueueScheduleLowCovUtest, ArgsParserConstruct)
{
    bqs::ArgsParser parser;
    EXPECT_EQ(parser.GetDeviceId(), 0U);
}

TEST_F(QueueScheduleLowCovUtest, HostQsLogFunctionPointers)
{
    bqs::hostQsFuncMap[static_cast<uint32_t>(bqs::QsLogFuncId::FUNC_CHECKLOGLEVEL)] =
        reinterpret_cast<void*>(FakeCheckLogLevelDisabled);
    bqs::hostQsFuncMap[static_cast<uint32_t>(bqs::QsLogFuncId::FUNC_DLOGRECORD)] =
        reinterpret_cast<void*>(FakeDlogRecord);
    bqs::HostQsLog::GetInstance().LogPrintNormal(0, 0, "skip");

    bqs::hostQsFuncMap[static_cast<uint32_t>(bqs::QsLogFuncId::FUNC_CHECKLOGLEVEL)] =
        reinterpret_cast<void*>(FakeCheckLogLevel);
    bqs::HostQsLog::GetInstance().LogPrintNormal(0, 0, "normal %d", 1);
    bqs::HostQsLog::GetInstance().LogPrintError(0, "error %d", 1);

    bqs::hostQsFuncMap[static_cast<uint32_t>(bqs::QsLogFuncId::FUNC_DLOGSETLEVEL)] =
        reinterpret_cast<void*>(FakeDlogSetLevel);
    bqs::HostQsLog::GetInstance().DlogSetLevel(0, 0);

    LogAttr attr{};
    bqs::hostQsFuncMap[static_cast<uint32_t>(bqs::QsLogFuncId::FUNC_DLOGSETATTR)] =
        reinterpret_cast<void*>(FakeDlogSetAttr);
    bqs::HostQsLog::GetInstance().DlogSetAttr(attr);

    bqs::hostQsFuncMap[static_cast<uint32_t>(bqs::QsLogFuncId::FUNC_CHECKLOGLEVEL)] = nullptr;
    bqs::hostQsFuncMap[static_cast<uint32_t>(bqs::QsLogFuncId::FUNC_DLOGRECORD)] = nullptr;
    bqs::hostQsFuncMap[static_cast<uint32_t>(bqs::QsLogFuncId::FUNC_DLOGSETLEVEL)] = nullptr;
    bqs::hostQsFuncMap[static_cast<uint32_t>(bqs::QsLogFuncId::FUNC_DLOGSETATTR)] = nullptr;
}

TEST_F(QueueScheduleLowCovUtest, TsdClientStubFunctions)
{
    const char* libNames[] = {"liba.so"};
    int32_t custPid = -1;
    bool firstStart = false;
    SubProcScheduleModeInfo scheduleMode{};

    EXPECT_EQ(SendUpdateProfilingRspToTsd(0U, 1U, 2U, 3U), 0);
    EXPECT_EQ(CreateOrFindCustPid(0U, 1U, libNames, 2U, 3U, "group", 1U, &custPid, &firstStart), 0);
    EXPECT_EQ(SetSubProcScheduleMode(0U, 1U, 2U, 3U, &scheduleMode), 0);
}

} // namespace
