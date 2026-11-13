/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <algorithm>
#include <cstring>
#include <memory>
#include <gtest/gtest.h>
#include "mockcpp/mockcpp.hpp"
#include "aicpu_c.hpp"
#include "aix_c.hpp"
#include "dvpp_c.hpp"
#include "fusion_c.hpp"
#include "kernel.hpp"
#include "model.hpp"
#include "context.hpp"
#include "npu_driver.hpp"
#include "capture_adapt.hpp"
#include "cond_c.hpp"
#include "program.hpp"
#include "task_submit.hpp"
#include "task_recycle.hpp"
#include "rt_unwrap.h"
#include "api_error.hpp"
#include "api_impl_david.hpp"
#include "device_sched_gate.hpp"
#include "event_c.hpp"
#include "event_david.hpp"
#include "event_task.h"
#include "raw_device.hpp"
#include "runtime.hpp"
#include "runtime/rt.h"
#include "runtime/rt_inner_device.h"
#include "stream_david.hpp"
#include "thread_local_container.hpp"
#include "../../rt_utest_config_define.hpp"

namespace {
using namespace cce::runtime;
constexpr uint32_t TASK_INTERVAL = 2U;
constexpr uint32_t DEVICE_ID = 0U;

drvError_t GetDavidDeviceInfo(uint32_t, const int32_t module, const int32_t type, int64_t* value)
{
    if (value == nullptr) {
        return DRV_ERROR_INVALID_VALUE;
    }
    *value = ((module == MODULE_TYPE_SYSTEM) && (type == INFO_TYPE_VERSION)) ? PLATFORMCONFIG_DAVID_950PR_9599 : 0;
    return DRV_ERROR_NONE;
}

rtError_t CompletedQueueHead(const Stream* stream, uint16_t& head, bool)
{
    head = static_cast<uint16_t>(stream->GetTaskPosTail());
    return RT_ERROR_NONE;
}

rtError_t CheckInternalWaitThenFail(TaskInfo* task, Stream* stream)
{
    EXPECT_EQ(task->stream, stream);
    EXPECT_EQ(task->type, TS_TASK_TYPE_DAVID_EVENT_WAIT);
    EXPECT_EQ(task->taskOwner, static_cast<uint8_t>(TaskOwner::RT_TASK_INNER));
    EXPECT_EQ(task->u.davidEventWaitTaskInfo.event, stream->Device_()->GetSchedGate()->GateEvent());
    EXPECT_EQ(task->u.davidEventWaitTaskInfo.timeout, UINT32_MAX);
    return RT_ERROR_DRV_ERR;
}

class SchedGateTest : public testing::Test {
protected:
    void SetUp() override
    {
        runtime_ = Runtime::Instance();
        savedGlobalChip_ = GlobalContainer::GetRtChipType();
        savedDisableThread_ = runtime_->GetDisableThread();
        savedConnectUb_ = runtime_->GetConnectUbFlag();
        savedUserSoc_ = runtime_->GetIsUserSetSocVersion();
        // This target supplies David HAL stubs. Save/restore platform selection for every case.
        GlobalContainer::SetRtChipType(CHIP_DAVID);
        runtime_->SetDisableThread(true);
        runtime_->SetConnectUbFlag(false);
        runtime_->SetIsUserSetSocVersion(false);
        ASSERT_EQ(runtime_->GetDevice(DEVICE_ID, 0U, false), nullptr);
        ASSERT_EQ(runtime_->GetSuspendConfig(DEVICE_ID, &savedConfig_), RT_ERROR_NONE);
        ASSERT_EQ(runtime_->SetSuspendConfig(DEVICE_ID, {}), RT_ERROR_NONE);
        MOCKER(halGetDeviceInfo).stubs().will(invoke(GetDavidDeviceInfo));
        const char* soc = "Ascend950PR_9599";
        MOCKER(halGetSocVersion)
            .stubs()
            .with(mockcpp::any(), outBoundP(soc, std::strlen(soc)), mockcpp::any())
            .will(returnValue(DRV_ERROR_NONE));
        // Control task submission/completion is the dependency boundary of the gate state machine.
        MOCKER(EvtRecord).stubs().will(returnValue(RT_ERROR_NONE));
        MOCKER(EvtReset).stubs().will(returnValue(RT_ERROR_NONE));
        MOCKER_CPP(&Stream::SynchronizeImpl).stubs().will(returnValue(RT_ERROR_NONE));
        MOCKER_CPP(&Stream::StarsWaitForTask).stubs().will(returnValue(RT_ERROR_NONE));
        MOCKER(SyncTask).stubs().will(returnValue(RT_ERROR_NONE));
        MOCKER(GetDrvSqHead).stubs().will(invoke(CompletedQueueHead));
        MOCKER(halSqTaskSend).stubs().will(returnValue(DRV_ERROR_NONE));
    }
    void TearDown() override
    {
        const ScopeGuard restore([this]() {
            GlobalContainer::SetRtChipType(savedGlobalChip_);
            runtime_->SetDisableThread(savedDisableThread_);
            runtime_->SetConnectUbFlag(savedConnectUb_);
            runtime_->SetIsUserSetSocVersion(savedUserSoc_);
        });
        if (captureActive_) {
            EXPECT_EQ(rtStreamEndCapture(streamHandle_, &modelHandle_), RT_ERROR_NONE);
            captureActive_ = false;
        }
        if (modelHandle_ != nullptr) {
            EXPECT_EQ(rtModelDestroy(modelHandle_), RT_ERROR_NONE);
            modelHandle_ = nullptr;
        }
        if (extraStream_ != nullptr) {
            EXPECT_EQ(runtime_->CurrentContext()->StreamDestroy(extraStream_), RT_ERROR_NONE);
            extraStream_ = nullptr;
        }
        if (streamHandle_ != nullptr) {
            EXPECT_EQ(rtStreamDestroyForce(streamHandle_), RT_ERROR_NONE);
            streamHandle_ = nullptr;
            stream_ = nullptr;
        }
        if (eventHandle_ != nullptr) {
            EXPECT_EQ(rtEventDestroy(eventHandle_), RT_ERROR_NONE);
            eventHandle_ = nullptr;
        }
        if (opened_) {
            EXPECT_EQ(rtDeviceReset(static_cast<int32_t>(DEVICE_ID)), RT_ERROR_NONE);
        }
        EXPECT_EQ(runtime_->SetSuspendConfig(DEVICE_ID, savedConfig_), RT_ERROR_NONE);
        GlobalMockObject::verify();
    }
    void OpenDevice(const bool enabled = true)
    {
        rtDeviceSuspendConfig config{};
        config.mode = enabled ? RT_DEVICE_SUSPEND_MODE_DEVICE : RT_DEVICE_SUSPEND_MODE_DISABLE;
        config.taskInterval = TASK_INTERVAL;
        ASSERT_EQ(rtDeviceSetSuspendConfig(DEVICE_ID, &config), RT_ERROR_NONE);
        ASSERT_EQ(rtSetDevice(DEVICE_ID), RT_ERROR_NONE);
        opened_ = true;
        device_ = runtime_->GetDevice(DEVICE_ID, 0U, false);
        ASSERT_NE(device_, nullptr);
        MOCKER_CPP_VIRTUAL(device_->Driver_(), &Driver::LogicCqReportV2)
            .stubs()
            .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBound(uint32_t{0}))
            .will(returnValue(RT_ERROR_NONE));
        if (enabled) {
            ASSERT_NE(device_->GetSchedGate(), nullptr);
            ASSERT_NE(device_->GetSchedGate()->GateEvent(), nullptr);
        }
    }
    void CreateStream()
    {
        ASSERT_EQ(rtStreamCreate(&streamHandle_, 0), RT_ERROR_NONE);
        stream_ = rt_ut::UnwrapOrNull<Stream>(streamHandle_);
        ASSERT_NE(stream_, nullptr);
        stream_->SetSqMemAttr(false);
        stream_->SetSqBaseAddr(0U);
    }
    rtError_t SubmitOperator(Stream* target = nullptr)
    {
        if (kernel_ == nullptr) {
            program_ = std::make_unique<PlainProgram>(RT_KERNEL_ATTR_TYPE_AICORE);
            kernel_ = std::make_unique<Kernel>("", 0UL, program_.get(), RT_KERNEL_ATTR_TYPE_AICORE, 0U);
            MOCKER_CPP(&Kernel::GetFunctionDevAddr).stubs().will(returnValue(RT_ERROR_NONE));
        }
        rtArgsEx_t args{};
        args.args = &argument_;
        args.argsSize = sizeof(argument_);
        args.isNoNeedH2DCopy = 1U;
        rtStreamLaunchKernelV2ExtendArgs_t extend{};
        extend.argsInfo = &args;
        return StreamLaunchKernelV2(kernel_.get(), 1U, target == nullptr ? stream_ : target, &extend);
    }
    std::unique_ptr<PlainProgram> program_;
    std::unique_ptr<Kernel> kernel_;
    uint64_t argument_ = 0U;
    rtModel_t modelHandle_ = nullptr;
    bool captureActive_ = false;
    Stream* extraStream_ = nullptr;
    rtEvent_t eventHandle_ = nullptr;
    rtStream_t streamHandle_ = nullptr;
    Stream* stream_ = nullptr;
    Runtime* runtime_ = nullptr;
    Device* device_ = nullptr;
    bool opened_ = false;
    rtChipType_t savedGlobalChip_{};
    rtDeviceSuspendConfig savedConfig_{};
    bool savedDisableThread_ = false;
    bool savedConnectUb_ = false;
    bool savedUserSoc_ = false;
};

struct IntervalCase {
    rtDeviceSuspendMode mode;
    uint32_t input;
    uint32_t normalized;
};
class SuspendConfigTest : public SchedGateTest, public testing::WithParamInterface<IntervalCase> {};
TEST_P(SuspendConfigTest, StoresNormalizedConfigWithoutOpeningDevice)
{
    const auto param = GetParam();
    rtDeviceSuspendConfig config{};
    config.mode = param.mode;
    config.taskInterval = param.input;
    ASSERT_EQ(rtDeviceSetSuspendConfig(DEVICE_ID, &config), RT_ERROR_NONE);
    rtDeviceSuspendConfig actual{};
    std::fill(std::begin(actual.reserved), std::end(actual.reserved), UINT32_MAX);
    EXPECT_EQ(rtDeviceGetSuspendConfig(DEVICE_ID, &actual), RT_ERROR_NONE);
    EXPECT_EQ(actual.mode, param.mode);
    EXPECT_EQ(actual.taskInterval, param.normalized);
    for (const auto value : actual.reserved) {
        EXPECT_EQ(value, 0U);
    }
    EXPECT_EQ(runtime_->GetDevice(DEVICE_ID, 0U, false), nullptr);
}
INSTANTIATE_TEST_SUITE_P(
    Intervals, SuspendConfigTest,
    testing::Values(
        IntervalCase{RT_DEVICE_SUSPEND_MODE_DISABLE, 1024U, 0U}, IntervalCase{RT_DEVICE_SUSPEND_MODE_DEVICE, 0U, 8U},
        IntervalCase{RT_DEVICE_SUSPEND_MODE_DEVICE, 1U, 1U},
        IntervalCase{RT_DEVICE_SUSPEND_MODE_DEVICE, 1024U, 1024U}));

TEST_F(SchedGateTest, NullConfigIsRejectedAtBothBoundaries)
{
    ApiImplDavid impl;
    ApiErrorDecorator checked(&impl);
    EXPECT_EQ(checked.DeviceSetSuspendConfig(DEVICE_ID, nullptr), RT_ERROR_INVALID_VALUE);
    EXPECT_EQ(checked.DeviceGetSuspendConfig(DEVICE_ID, nullptr), RT_ERROR_INVALID_VALUE);
    EXPECT_EQ(runtime_->GetSuspendConfig(DEVICE_ID, nullptr), RT_ERROR_INVALID_VALUE);
}

class InvalidSuspendModeTest : public SchedGateTest, public testing::WithParamInterface<int32_t> {};
TEST_P(InvalidSuspendModeTest, RejectsUnknownModeWithoutChangingConfig)
{
    rtDeviceSuspendConfig config{};
    config.mode = static_cast<rtDeviceSuspendMode>(GetParam());
    EXPECT_EQ(rtDeviceSetSuspendConfig(DEVICE_ID, &config), ACL_ERROR_RT_PARAM_INVALID);
    ASSERT_EQ(rtDeviceGetSuspendConfig(DEVICE_ID, &config), RT_ERROR_NONE);
    EXPECT_EQ(config.mode, RT_DEVICE_SUSPEND_MODE_DISABLE);
    EXPECT_EQ(config.taskInterval, 0U);
}
INSTANTIATE_TEST_SUITE_P(Modes, InvalidSuspendModeTest, testing::Values(-1, 2, INT32_MAX));

TEST_F(SchedGateTest, ExcessiveIntervalDoesNotChangeConfig)
{
    rtDeviceSuspendConfig config{};
    config.mode = RT_DEVICE_SUSPEND_MODE_DEVICE;
    config.taskInterval = MAX_DEVICE_SUSPEND_TASK_INTERVAL + 1U;
    EXPECT_EQ(rtDeviceSetSuspendConfig(DEVICE_ID, &config), ACL_ERROR_RT_PARAM_INVALID);
    ASSERT_EQ(rtDeviceGetSuspendConfig(DEVICE_ID, &config), RT_ERROR_NONE);
    EXPECT_EQ(config.mode, RT_DEVICE_SUSPEND_MODE_DISABLE);
    EXPECT_EQ(config.taskInterval, 0U);
}

class SuspendReservedTest : public SchedGateTest, public testing::WithParamInterface<size_t> {};
TEST_P(SuspendReservedTest, RejectsEachNonzeroReservedField)
{
    rtDeviceSuspendConfig config{};
    ASSERT_LT(GetParam(), sizeof(config.reserved) / sizeof(config.reserved[0]));
    config.reserved[GetParam()] = 1U;
    EXPECT_EQ(rtDeviceSetSuspendConfig(DEVICE_ID, &config), ACL_ERROR_RT_PARAM_INVALID);
    ASSERT_EQ(rtDeviceGetSuspendConfig(DEVICE_ID, &config), RT_ERROR_NONE);
    EXPECT_EQ(config.reserved[GetParam()], 0U);
}
INSTANTIATE_TEST_SUITE_P(Fields, SuspendReservedTest, testing::Range(size_t{0}, size_t{6}));

TEST_F(SchedGateTest, InvalidDeviceDoesNotAccessDeviceSlot)
{
    rtDeviceSuspendConfig config{};
    ApiImplDavid impl;
    ApiErrorDecorator checked(&impl);
    EXPECT_EQ(checked.DeviceSetSuspendConfig(-1, &config), RT_ERROR_DEVICE_ID);
    EXPECT_EQ(checked.DeviceGetSuspendConfig(-1, &config), RT_ERROR_DEVICE_ID);
    EXPECT_EQ(checked.DeviceSuspendExecution(-1, 0U), RT_ERROR_DEVICE_ID);
    EXPECT_EQ(checked.DeviceResumeExecution(-1, 0U), RT_ERROR_DEVICE_ID);
    EXPECT_EQ(runtime_->SetSuspendConfig(RT_MAX_DEV_NUM, config), RT_ERROR_DEVICE_ID);
    EXPECT_EQ(runtime_->GetSuspendConfig(RT_MAX_DEV_NUM, &config), RT_ERROR_DEVICE_ID);
    EXPECT_EQ(runtime_->ControlSchedGate(RT_MAX_DEV_NUM, false), RT_ERROR_DEVICE_ID);
}

TEST_F(SchedGateTest, ReservedControlFlagsAreRejected)
{
    EXPECT_EQ(rtDeviceSuspendExecution(DEVICE_ID, 1U), ACL_ERROR_RT_PARAM_INVALID);
    EXPECT_EQ(rtDeviceResumeExecution(DEVICE_ID, UINT32_MAX), ACL_ERROR_RT_PARAM_INVALID);
    EXPECT_EQ(runtime_->GetDevice(DEVICE_ID, 0U, false), nullptr);
}

TEST_F(SchedGateTest, ControlBeforeOpeningDoesNotCreateDevice)
{
    EXPECT_EQ(runtime_->ControlSchedGate(DEVICE_ID, false), RT_ERROR_DEVICE_NULL);
    EXPECT_EQ(runtime_->ControlSchedGate(DEVICE_ID, true), RT_ERROR_DEVICE_NULL);
    EXPECT_EQ(runtime_->GetDevice(DEVICE_ID, 0U, false), nullptr);
}

TEST_F(SchedGateTest, OpenCreatesSharedGateAndRepeatedControlPreservesIt)
{
    ASSERT_NO_FATAL_FAILURE(OpenDevice());
    auto* gate = device_->GetSchedGate();
    auto* event = gate->GateEvent();
    EXPECT_EQ(device_->SetupSchedGate(TASK_INTERVAL), RT_ERROR_NONE);
    EXPECT_EQ(rtDeviceSuspendExecution(DEVICE_ID, 0U), RT_ERROR_NONE);
    EXPECT_EQ(rtDeviceSuspendExecution(DEVICE_ID, 0U), RT_ERROR_NONE);
    EXPECT_EQ(rtDeviceResumeExecution(DEVICE_ID, 0U), RT_ERROR_NONE);
    EXPECT_EQ(rtDeviceResumeExecution(DEVICE_ID, 0U), RT_ERROR_NONE);
    EXPECT_EQ(device_->GetSchedGate(), gate);
    EXPECT_EQ(gate->GateEvent(), event);
    EXPECT_TRUE(gate->IsInsertionEnabled());
}

TEST_F(SchedGateTest, OpenDeviceRejectsReconfiguration)
{
    ASSERT_NO_FATAL_FAILURE(OpenDevice());
    rtDeviceSuspendConfig config{};
    config.mode = RT_DEVICE_SUSPEND_MODE_DEVICE;
    config.taskInterval = TASK_INTERVAL + 1U;
    EXPECT_EQ(rtDeviceSetSuspendConfig(DEVICE_ID, &config), ACL_ERROR_RT_PARAM_INVALID);
    ASSERT_EQ(rtDeviceGetSuspendConfig(DEVICE_ID, &config), RT_ERROR_NONE);
    EXPECT_EQ(config.taskInterval, TASK_INTERVAL);
}

TEST_F(SchedGateTest, DisableStopsInsertionAndRejectsFurtherControl)
{
    ASSERT_NO_FATAL_FAILURE(OpenDevice());
    rtDeviceSuspendConfig config{};
    ASSERT_EQ(rtDeviceSetSuspendConfig(DEVICE_ID, &config), RT_ERROR_NONE);
    EXPECT_FALSE(device_->GetSchedGate()->IsInsertionEnabled());
    ASSERT_EQ(rtDeviceGetSuspendConfig(DEVICE_ID, &config), RT_ERROR_NONE);
    EXPECT_EQ(config.mode, RT_DEVICE_SUSPEND_MODE_DISABLE);
    EXPECT_EQ(config.taskInterval, 0U);
    EXPECT_EQ(rtDeviceSuspendExecution(DEVICE_ID, 0U), ACL_ERROR_RT_PARAM_INVALID);
    EXPECT_EQ(rtDeviceResumeExecution(DEVICE_ID, 0U), ACL_ERROR_RT_PARAM_INVALID);
    EXPECT_EQ(rtDeviceSetSuspendConfig(DEVICE_ID, &config), ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(SchedGateTest, FailedResumeDuringDisablePreservesConfiguration)
{
    ASSERT_NO_FATAL_FAILURE(OpenDevice());
    MOCKER_CPP(&DeviceSchedGate::Resume).stubs().will(returnValue(RT_ERROR_DRV_ERR));
    rtDeviceSuspendConfig config{};
    EXPECT_EQ(runtime_->SetSuspendConfig(DEVICE_ID, config), RT_ERROR_DRV_ERR);
    EXPECT_TRUE(device_->GetSchedGate()->IsInsertionEnabled());
    ASSERT_EQ(runtime_->GetSuspendConfig(DEVICE_ID, &config), RT_ERROR_NONE);
    EXPECT_EQ(config.mode, RT_DEVICE_SUSPEND_MODE_DEVICE);
    EXPECT_EQ(config.taskInterval, TASK_INTERVAL);
}

TEST_F(SchedGateTest, DisabledDeviceCannotEnableGateAfterOpening)
{
    ASSERT_NO_FATAL_FAILURE(OpenDevice(false));
    EXPECT_EQ(device_->GetSchedGate(), nullptr);
    rtDeviceSuspendConfig config{};
    config.mode = RT_DEVICE_SUSPEND_MODE_DEVICE;
    EXPECT_EQ(rtDeviceSetSuspendConfig(DEVICE_ID, &config), ACL_ERROR_RT_PARAM_INVALID);
    EXPECT_EQ(runtime_->ControlSchedGate(DEVICE_ID, false), RT_ERROR_INVALID_VALUE);
    EXPECT_EQ(device_->GetSchedGate(), nullptr);
}

TEST_F(SchedGateTest, SetupWithoutControlStreamLeavesEventEmpty)
{
    RawDevice device(DEVICE_ID);
    DeviceSchedGate gate(&device, TASK_INTERVAL);
    EXPECT_EQ(gate.Setup(), RT_ERROR_STREAM_NULL);
    EXPECT_EQ(gate.GateEvent(), nullptr);
}

TEST_F(SchedGateTest, ControlWithoutSetupRejectsMissingEvent)
{
    DeviceSchedGate gate(nullptr, TASK_INTERVAL);
    EXPECT_EQ(gate.Suspend(), RT_ERROR_EVENT_NULL);
    EXPECT_EQ(gate.Resume(), RT_ERROR_EVENT_NULL);
    gate.Release();
    EXPECT_EQ(gate.GateEvent(), nullptr);
    EXPECT_FALSE(gate.IsInsertionEnabled());
}

TEST_F(SchedGateTest, EventAllocationFailureLeavesNoOwnedEvent)
{
    ASSERT_NO_FATAL_FAILURE(OpenDevice(false));
    DeviceSchedGate gate(device_, TASK_INTERVAL);
    DavidEvent sample(device_, RT_EVENT_DDSYNC_NS, nullptr, false);
    MOCKER_CPP_VIRTUAL(static_cast<Event*>(&sample), &Event::GenEventId)
        .stubs()
        .will(returnValue(RT_ERROR_DRV_NO_EVENT_RESOURCES));
    EXPECT_EQ(gate.Setup(), RT_ERROR_DRV_NO_EVENT_RESOURCES);
    EXPECT_EQ(gate.GateEvent(), nullptr);
}

TEST_F(SchedGateTest, ReleaseUnsubmittedEventFreesDriverIdOnce)
{
    ASSERT_NO_FATAL_FAILURE(OpenDevice(false));
    DeviceSchedGate gate(device_, TASK_INTERVAL);
    ASSERT_EQ(gate.Setup(), RT_ERROR_NONE);
    const auto eventId = gate.GateEvent()->EventId_();
    MOCKER_CPP_VIRTUAL(device_, &Device::FreeEventIdFromDrv)
        .expects(once())
        .with(eq(eventId), eq(static_cast<uint32_t>(RT_EVENT_DDSYNC_NS)), eq(false))
        .will(returnValue(RT_ERROR_NONE));
    gate.Release();
    gate.Release();
    EXPECT_EQ(gate.GateEvent(), nullptr);
    EXPECT_FALSE(gate.IsInsertionEnabled());
}

TEST_F(SchedGateTest, ReleasePendingEventDoesNotRecycleDriverId)
{
    ASSERT_NO_FATAL_FAILURE(OpenDevice(false));
    TaskInfo task{};
    DeviceSchedGate gate(device_, TASK_INTERVAL);
    ASSERT_EQ(gate.Setup(), RT_ERROR_NONE);
    auto* event = gate.GateEvent();
    event->InsertRecordResetToMap(&task);
    MOCKER_CPP_VIRTUAL(device_, &Device::FreeEventIdFromDrv)
        .expects(never())
        .with(eq(event->EventId_()), mockcpp::any(), mockcpp::any());
    gate.Release();
    EXPECT_EQ(gate.GateEvent(), nullptr);
    EXPECT_FALSE(gate.IsInsertionEnabled());
}

TEST_F(SchedGateTest, CounterSaturatesAndRemainsIndependentAcrossStreams)
{
    ASSERT_NO_FATAL_FAILURE(OpenDevice());
    DavidStream first(device_, 0U, 0U, nullptr);
    DavidStream second(device_, 0U, 0U, nullptr);
    auto* gate = device_->GetSchedGate();
    EXPECT_TRUE(gate->NeedWait(&first, TS_TASK_TYPE_KERNEL_AICORE));
    first.ResetSchedOperatorCount();
    gate->CountSubmittedOperator(&first);
    EXPECT_EQ(first.GetSchedOperatorCount(), 1U);
    EXPECT_FALSE(gate->NeedWait(&first, TS_TASK_TYPE_KERNEL_AICORE));
    gate->CountSubmittedOperator(&first);
    gate->CountSubmittedOperator(&first);
    EXPECT_EQ(first.GetSchedOperatorCount(), TASK_INTERVAL);
    EXPECT_TRUE(gate->NeedWait(&first, TS_TASK_TYPE_KERNEL_AICORE));
    EXPECT_EQ(second.GetSchedOperatorCount(), UINT32_MAX);
}

struct TaskTypeCase {
    tsTaskType_t type;
    bool eligible;
};
class GateTaskTypeTest : public SchedGateTest, public testing::WithParamInterface<TaskTypeCase> {};
TEST_P(GateTaskTypeTest, OnlyOperatorTasksRequireGateWait)
{
    ASSERT_NO_FATAL_FAILURE(OpenDevice());
    DavidStream stream(device_, 0U, 0U, nullptr);
    EXPECT_EQ(device_->GetSchedGate()->NeedWait(&stream, GetParam().type), GetParam().eligible);
    EXPECT_EQ(DeviceSchedGate::IsOperatorTask(GetParam().type), GetParam().eligible);
}
INSTANTIATE_TEST_SUITE_P(
    TaskTypes, GateTaskTypeTest,
    testing::Values(
        TaskTypeCase{TS_TASK_TYPE_KERNEL_AICORE, true}, TaskTypeCase{TS_TASK_TYPE_KERNEL_AIVEC, true},
        TaskTypeCase{TS_TASK_TYPE_KERNEL_AICPU, true}, TaskTypeCase{TS_TASK_TYPE_FUSION_KERNEL, true},
        TaskTypeCase{TS_TASK_TYPE_KERNEL_MIX_AIC, true}, TaskTypeCase{TS_TASK_TYPE_KERNEL_MIX_AIV, true},
        TaskTypeCase{TS_TASK_TYPE_MULTIPLE_TASK, true}, TaskTypeCase{TS_TASK_TYPE_DAVID_EVENT_WAIT, false},
        TaskTypeCase{TS_TASK_TYPE_DAVID_EVENT_RECORD, false}, TaskTypeCase{TS_TASK_TYPE_RESERVED, false}));

class GateExcludedStreamTest : public SchedGateTest, public testing::WithParamInterface<uint32_t> {};
TEST_P(GateExcludedStreamTest, InternalStreamIsNotCountedOrSubmitted)
{
    ASSERT_NO_FATAL_FAILURE(OpenDevice());
    DavidStream stream(device_, 0U, GetParam(), nullptr);
    auto* gate = device_->GetSchedGate();
    MOCKER(EvtWait).expects(never());
    EXPECT_FALSE(DeviceSchedGate::Eligible(&stream));
    EXPECT_EQ(gate->TryInsertGateWait(&stream, TS_TASK_TYPE_KERNEL_AICORE), RT_ERROR_NONE);
    gate->CountSubmittedOperator(&stream);
    EXPECT_EQ(stream.GetSchedOperatorCount(), UINT32_MAX);
}
INSTANTIATE_TEST_SUITE_P(Flags, GateExcludedStreamTest, testing::Values(RT_STREAM_AICPU, RT_STREAM_CP_PROCESS_USE));

TEST_F(SchedGateTest, ControlAndNullStreamsNeverRequireWait)
{
    ASSERT_NO_FATAL_FAILURE(OpenDevice());
    auto* gate = device_->GetSchedGate();
    EXPECT_FALSE(DeviceSchedGate::Eligible(nullptr));
    EXPECT_FALSE(DeviceSchedGate::Eligible(device_->GetCtrlSQStream(nullptr)));
    EXPECT_FALSE(gate->NeedWait(nullptr, TS_TASK_TYPE_KERNEL_AICORE));
    EXPECT_EQ(gate->TryInsertGateWait(nullptr, TS_TASK_TYPE_KERNEL_AICORE), RT_ERROR_NONE);
}

TEST_F(SchedGateTest, DisabledInsertionPreservesCounterAndSubmitsNothing)
{
    ASSERT_NO_FATAL_FAILURE(OpenDevice());
    DavidStream stream(device_, 0U, 0U, nullptr);
    auto* gate = device_->GetSchedGate();
    gate->DisableInsertion();
    MOCKER(EvtWait).expects(never());
    EXPECT_FALSE(gate->NeedWait(&stream, TS_TASK_TYPE_KERNEL_AICORE));
    EXPECT_EQ(gate->TryInsertGateWait(&stream, TS_TASK_TYPE_KERNEL_AICORE), RT_ERROR_NONE);
    gate->CountSubmittedOperator(&stream);
    EXPECT_EQ(stream.GetSchedOperatorCount(), UINT32_MAX);
}

class GateAbortTest : public SchedGateTest, public testing::WithParamInterface<rtError_t> {};
TEST_P(GateAbortTest, StreamErrorPreventsWaitAndPreservesCounter)
{
    ASSERT_NO_FATAL_FAILURE(OpenDevice());
    DavidStream stream(device_, 0U, 0U, nullptr);
    stream.SetAbortStatus(GetParam());
    MOCKER(EvtWait).expects(never());
    EXPECT_EQ(device_->GetSchedGate()->TryInsertGateWait(&stream, TS_TASK_TYPE_KERNEL_AICORE), GetParam());
    EXPECT_EQ(stream.GetSchedOperatorCount(), UINT32_MAX);
    stream.SetAbortStatus(RT_ERROR_NONE);
}
INSTANTIATE_TEST_SUITE_P(Errors, GateAbortTest, testing::Values(RT_ERROR_STREAM_ABORT, RT_ERROR_DEVICE_MEM_ERROR));

TEST_F(SchedGateTest, FailedWaitRetainsFirstWaitPending)
{
    ASSERT_NO_FATAL_FAILURE(OpenDevice());
    DavidStream stream(device_, 0U, 0U, nullptr);
    auto* gate = device_->GetSchedGate();
    MOCKER(EvtWait)
        .expects(once())
        .with(eq(gate->GateEvent()), eq(static_cast<Stream*>(&stream)), eq(UINT32_MAX))
        .will(returnValue(RT_ERROR_TASK_NEW));
    EXPECT_EQ(gate->TryInsertGateWait(&stream, TS_TASK_TYPE_KERNEL_AICORE), RT_ERROR_TASK_NEW);
    EXPECT_EQ(stream.GetSchedOperatorCount(), UINT32_MAX);
    EXPECT_TRUE(gate->NeedWait(&stream, TS_TASK_TYPE_KERNEL_AICORE));
}

TEST_F(SchedGateTest, BelowIntervalDoesNotSubmitWait)
{
    ASSERT_NO_FATAL_FAILURE(OpenDevice());
    DavidStream stream(device_, 0U, 0U, nullptr);
    stream.ResetSchedOperatorCount();
    MOCKER(EvtWait).expects(never());
    EXPECT_EQ(device_->GetSchedGate()->TryInsertGateWait(&stream, TS_TASK_TYPE_KERNEL_AICORE), RT_ERROR_NONE);
    EXPECT_EQ(stream.GetSchedOperatorCount(), 0U);
}

TEST_F(SchedGateTest, CaptureWaitUsesDestinationCounterAndOriginStream)
{
    ASSERT_NO_FATAL_FAILURE(OpenDevice());
    DavidStream origin(device_, 0U, 0U, nullptr);
    DavidStream capture(device_, 0U, 0U, nullptr);
    origin.UpdateCaptureStream(&capture);
    const ScopeGuard restore([&origin]() { origin.UpdateCaptureStream(nullptr); });
    origin.ResetSchedOperatorCount();
    auto* gate = device_->GetSchedGate();
    MOCKER(EvtWait)
        .expects(once())
        .with(eq(gate->GateEvent()), eq(static_cast<Stream*>(&origin)), eq(UINT32_MAX))
        .will(returnValue(RT_ERROR_NONE));
    EXPECT_EQ(gate->TryInsertGateWait(&origin, TS_TASK_TYPE_KERNEL_AICORE), RT_ERROR_NONE);
    EXPECT_EQ(origin.GetSchedOperatorCount(), 0U);
    EXPECT_EQ(capture.GetSchedOperatorCount(), UINT32_MAX);
}

TEST_F(SchedGateTest, FailedRecordDuringSetupCanBeReleased)
{
    ASSERT_NO_FATAL_FAILURE(OpenDevice(false));
    DeviceSchedGate gate(device_, TASK_INTERVAL);
    GlobalMockObject::reset(reinterpret_cast<const void*>(EvtRecord));
    MOCKER(EvtRecord).expects(once()).will(returnValue(RT_ERROR_DRV_ERR));
    EXPECT_EQ(gate.Setup(), RT_ERROR_DRV_ERR);
    EXPECT_NE(gate.GateEvent(), nullptr);
    gate.Release();
    EXPECT_EQ(gate.GateEvent(), nullptr);
}

TEST_F(SchedGateTest, FailedResetIsReturnedWithoutSynchronizing)
{
    ASSERT_NO_FATAL_FAILURE(OpenDevice());
    auto* control = device_->GetCtrlSQStream(nullptr);
    GlobalMockObject::reset(reinterpret_cast<const void*>(EvtReset));
    MOCKER(EvtReset)
        .expects(once())
        .with(eq(device_->GetSchedGate()->GateEvent()), eq(control))
        .will(returnValue(RT_ERROR_DRV_ERR));
    MOCKER_CPP_VIRTUAL(control, &Stream::Synchronize).expects(never());
    EXPECT_EQ(device_->GetSchedGate()->Suspend(), RT_ERROR_DRV_ERR);
    EXPECT_TRUE(device_->GetSchedGate()->IsInsertionEnabled());
}

TEST_F(SchedGateTest, SynchronizationFailureIsReturnedAfterResume)
{
    ASSERT_NO_FATAL_FAILURE(OpenDevice());
    auto* control = device_->GetCtrlSQStream(nullptr);
    MOCKER_CPP_VIRTUAL(control, &Stream::Synchronize).expects(once()).will(returnValue(RT_ERROR_STREAM_SYNC_TIMEOUT));
    EXPECT_EQ(device_->GetSchedGate()->Resume(), RT_ERROR_STREAM_SYNC_TIMEOUT);
    EXPECT_NE(device_->GetSchedGate()->GateEvent(), nullptr);
}

TEST_F(SchedGateTest, MissingControlStreamDoesNotSubmitControlTask)
{
    ASSERT_NO_FATAL_FAILURE(OpenDevice());
    MOCKER_CPP_VIRTUAL(device_, &Device::GetCtrlSQStream).stubs().will(returnValue(static_cast<Stream*>(nullptr)));
    MOCKER(EvtReset).expects(never());
    EXPECT_EQ(device_->GetSchedGate()->Suspend(), RT_ERROR_STREAM_NULL);
    EXPECT_NE(device_->GetSchedGate()->GateEvent(), nullptr);
}

TEST_F(SchedGateTest, FailedGateInitializationRollsBackDeviceSlot)
{
    rtDeviceSuspendConfig config{};
    config.mode = RT_DEVICE_SUSPEND_MODE_DEVICE;
    ASSERT_EQ(runtime_->SetSuspendConfig(DEVICE_ID, config), RT_ERROR_NONE);
    GlobalMockObject::reset(reinterpret_cast<const void*>(EvtRecord));
    MOCKER(EvtRecord).expects(once()).will(returnValue(RT_ERROR_DRV_ERR));
    EXPECT_EQ(runtime_->DeviceRetain(DEVICE_ID, 0U), nullptr);
    EXPECT_EQ(runtime_->GetDevice(DEVICE_ID, 0U, false), nullptr);
}

class GateGroupTest : public SchedGateTest, public testing::WithParamInterface<StreamTaskGroupStatus> {};
TEST_P(GateGroupTest, GroupingDefersWaitAndUpdateDoesNotCountOperators)
{
    ASSERT_NO_FATAL_FAILURE(OpenDevice());
    DavidStream stream(device_, 0U, 0U, nullptr);
    ASSERT_EQ(stream.UpdateTaskGroupStatus(GetParam()), RT_ERROR_NONE);
    auto* gate = device_->GetSchedGate();
    MOCKER(EvtWait).expects(never());
    EXPECT_EQ(gate->TryInsertGateWait(&stream, TS_TASK_TYPE_KERNEL_AICORE), RT_ERROR_NONE);
    if (GetParam() == StreamTaskGroupStatus::UPDATE) {
        EXPECT_FALSE(gate->NeedWait(&stream, TS_TASK_TYPE_KERNEL_AICORE));
        stream.ResetSchedOperatorCount();
        gate->CountSubmittedOperator(&stream);
        EXPECT_EQ(stream.GetSchedOperatorCount(), 0U);
    } else {
        EXPECT_EQ(stream.GetSchedOperatorCount(), UINT32_MAX);
    }
    EXPECT_EQ(stream.UpdateTaskGroupStatus(StreamTaskGroupStatus::NONE), RT_ERROR_NONE);
}
INSTANTIATE_TEST_SUITE_P(
    Groups, GateGroupTest, testing::Values(StreamTaskGroupStatus::SAMPLE, StreamTaskGroupStatus::UPDATE));

TEST_F(SchedGateTest, AutoSplitUsesLastSlaveCounterAndSubmitsOnOrigin)
{
    ASSERT_NO_FATAL_FAILURE(OpenDevice());
    DavidStream origin(device_, 0U, 0U, nullptr);
    DavidStream slave(device_, 0U, 0U, nullptr);
    AutoSplitSqContext split{};
    split.slaveStreams.push_back(&slave);
    origin.SetAutoSplitCtx(&split);
    origin.SetAutoSplitSq(true);
    const ScopeGuard restore([&origin]() {
        origin.SetAutoSplitSq(false);
        origin.SetAutoSplitCtx(nullptr);
    });
    origin.ResetSchedOperatorCount();
    auto* gate = device_->GetSchedGate();
    MOCKER(EvtWait)
        .expects(once())
        .with(eq(gate->GateEvent()), eq(static_cast<Stream*>(&origin)), eq(UINT32_MAX))
        .will(returnValue(RT_ERROR_NONE));
    EXPECT_EQ(gate->TryInsertGateWait(&origin, TS_TASK_TYPE_KERNEL_AICORE), RT_ERROR_NONE);
    EXPECT_EQ(origin.GetSchedOperatorCount(), 0U);
    EXPECT_EQ(slave.GetSchedOperatorCount(), UINT32_MAX);
}

TEST_F(SchedGateTest, AutoSplitWithoutSlaveUsesOriginCounter)
{
    ASSERT_NO_FATAL_FAILURE(OpenDevice());
    DavidStream origin(device_, 0U, 0U, nullptr);
    AutoSplitSqContext split{};
    origin.SetAutoSplitCtx(&split);
    origin.SetAutoSplitSq(true);
    const ScopeGuard restore([&origin]() {
        origin.SetAutoSplitSq(false);
        origin.SetAutoSplitCtx(nullptr);
    });
    origin.ResetSchedOperatorCount();
    MOCKER(EvtWait).expects(never());
    EXPECT_EQ(device_->GetSchedGate()->TryInsertGateWait(&origin, TS_TASK_TYPE_KERNEL_AICORE), RT_ERROR_NONE);
    EXPECT_EQ(origin.GetSchedOperatorCount(), 0U);
}

class GateCapabilityTest : public SchedGateTest, public testing::WithParamInterface<rtChipType_t> {};
TEST_P(GateCapabilityTest, MissingCapabilityRejectsApiAndGateSetup)
{
    // Select the public platform override; teardown restores the original value.
    GlobalContainer::SetRtChipType(GetParam());
    rtDeviceSuspendConfig config{};
    config.mode = RT_DEVICE_SUSPEND_MODE_DEVICE;
    EXPECT_EQ(rtDeviceSetSuspendConfig(DEVICE_ID, &config), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(rtDeviceGetSuspendConfig(DEVICE_ID, &config), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(rtDeviceSuspendExecution(DEVICE_ID, 0U), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(rtDeviceResumeExecution(DEVICE_ID, 0U), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    DeviceSchedGate gate(nullptr, TASK_INTERVAL);
    EXPECT_EQ(gate.Setup(), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(gate.GateEvent(), nullptr);
}
INSTANTIATE_TEST_SUITE_P(Chips, GateCapabilityTest, testing::Values(CHIP_910_B_93, CHIP_MC62CM12A));

enum class LaunchKind { CORE_V1, CORE_HANDLE, CORE_V2, CPU, CPU_NAMES, CPU_ARGS, FUSION, MULTIPLE };
class GateLaunchTest : public SchedGateTest, public testing::WithParamInterface<LaunchKind> {
protected:
    rtError_t Launch(Stream* stream)
    {
        PlainProgram program(RT_KERNEL_ATTR_TYPE_AICORE);
        Kernel kernel("", 0UL, &program, RT_KERNEL_ATTR_TYPE_AICORE, 0U);
        rtArgsEx_t args{};
        rtStreamLaunchKernelV2ExtendArgs_t extend{};
        extend.argsInfo = &args;
        rtKernelLaunchNames_t names{};
        rtAicpuArgsEx_t cpuArgs{};
        rtFunsionTaskInfo_t fusion{};
        fusion.subTaskNum = 1U;
        fusion.subTask[0].type = RT_FUSION_AICPU;
        rtMultipleTaskInfo_t multiple{};
        switch (GetParam()) {
            case LaunchKind::CORE_V1:
                return StreamLaunchKernelV1(&kernel, 1U, &args, stream, nullptr, false);
            case LaunchKind::CORE_HANDLE:
                return StreamLaunchKernelWithHandle(&program, 0U, 1U, &args, stream);
            case LaunchKind::CORE_V2:
                return StreamLaunchKernelV2(&kernel, 1U, stream, &extend);
            case LaunchKind::CPU:
                return StreamLaunchKernelEx(nullptr, 0U, RT_KERNEL_DEFAULT, stream);
            case LaunchKind::CPU_NAMES:
                return StreamLaunchCpuKernel(&names, 1U, &args, stream, RT_KERNEL_DEFAULT);
            case LaunchKind::CPU_ARGS:
                return StreamLaunchCpuKernelExWithArgs(
                    1U, &cpuArgs, nullptr, stream, RT_KERNEL_DEFAULT, KERNEL_TYPE_AICPU, nullptr);
            case LaunchKind::FUSION:
                return LaunchFusionKernel(stream, &fusion, nullptr);
            case LaunchKind::MULTIPLE:
                return LaunchMultipleTaskInfo(&multiple, stream, 0U);
        }
        return RT_ERROR_INVALID_VALUE;
    }
};
TEST_P(GateLaunchTest, FailedGateWaitStopsOperatorBeforeSubmission)
{
    ASSERT_NO_FATAL_FAILURE(OpenDevice());
    ASSERT_NO_FATAL_FAILURE(CreateStream());
    MOCKER(EvtWait)
        .expects(once())
        .with(eq(device_->GetSchedGate()->GateEvent()), eq(stream_), eq(UINT32_MAX))
        .will(returnValue(RT_ERROR_TASK_NEW));
    const auto tail = stream_->GetTaskPosTail();
    EXPECT_EQ(Launch(stream_), RT_ERROR_TASK_NEW);
    EXPECT_EQ(stream_->GetSchedOperatorCount(), UINT32_MAX);
    EXPECT_EQ(stream_->GetTaskPosTail(), tail);
}
INSTANTIATE_TEST_SUITE_P(
    Operators, GateLaunchTest,
    testing::Values(
        LaunchKind::CORE_V1, LaunchKind::CORE_HANDLE, LaunchKind::CORE_V2, LaunchKind::CPU, LaunchKind::CPU_NAMES,
        LaunchKind::CPU_ARGS, LaunchKind::FUSION, LaunchKind::MULTIPLE));

TEST_F(SchedGateTest, GateWaitResetsCounterOnlyAfterSuccessfulSubmission)
{
    ASSERT_NO_FATAL_FAILURE(OpenDevice());
    ASSERT_NO_FATAL_FAILURE(CreateStream());
    auto* gate = device_->GetSchedGate();
    EXPECT_EQ(gate->TryInsertGateWait(stream_, TS_TASK_TYPE_KERNEL_AICORE), RT_ERROR_NONE);
    EXPECT_EQ(stream_->GetSchedOperatorCount(), 0U);
    EXPECT_FALSE(gate->NeedWait(stream_, TS_TASK_TYPE_KERNEL_AICORE));
}

TEST_F(SchedGateTest, FailedWaitIsInternalAndRollsBackTaskAllocation)
{
    ASSERT_NO_FATAL_FAILURE(OpenDevice());
    ASSERT_NO_FATAL_FAILURE(CreateStream());
    MOCKER(DavidSendTask).stubs().will(invoke(CheckInternalWaitThenFail));
    const ScopeGuard restoreSend([]() { GlobalMockObject::reset(reinterpret_cast<const void*>(DavidSendTask)); });
    const auto tail = stream_->GetTaskPosTail();
    EXPECT_EQ(device_->GetSchedGate()->TryInsertGateWait(stream_, TS_TASK_TYPE_KERNEL_AICORE), RT_ERROR_DRV_ERR);
    EXPECT_EQ(stream_->GetSchedOperatorCount(), UINT32_MAX);
    EXPECT_EQ(stream_->GetTaskPosTail(), tail);
}

TEST_F(SchedGateTest, OrdinaryEventWaitPreservesOperatorCount)
{
    ASSERT_NO_FATAL_FAILURE(OpenDevice());
    ASSERT_NO_FATAL_FAILURE(CreateStream());
    ASSERT_EQ(rtEventCreateWithFlag(&eventHandle_, RT_EVENT_DDSYNC_NS), RT_ERROR_NONE);
    stream_->ResetSchedOperatorCount();
    device_->GetSchedGate()->CountSubmittedOperator(stream_);
    EXPECT_EQ(rtStreamWaitEvent(streamHandle_, eventHandle_), RT_ERROR_NONE);
    EXPECT_EQ(stream_->GetSchedOperatorCount(), 1U);
}

TEST_F(SchedGateTest, SuccessfulOperatorsInsertFirstAndPeriodicWaits)
{
    ASSERT_NO_FATAL_FAILURE(OpenDevice());
    ASSERT_NO_FATAL_FAILURE(CreateStream());
    EXPECT_EQ(SubmitOperator(), RT_ERROR_NONE);
    EXPECT_EQ(stream_->GetSchedOperatorCount(), 1U);
    EXPECT_EQ(SubmitOperator(), RT_ERROR_NONE);
    EXPECT_EQ(stream_->GetSchedOperatorCount(), TASK_INTERVAL);
    EXPECT_EQ(SubmitOperator(), RT_ERROR_NONE);
    EXPECT_EQ(stream_->GetSchedOperatorCount(), 1U);
}

TEST_F(SchedGateTest, FailedOperatorSubmissionDoesNotIncrementCounter)
{
    ASSERT_NO_FATAL_FAILURE(OpenDevice());
    ASSERT_NO_FATAL_FAILURE(CreateStream());
    stream_->ResetSchedOperatorCount();
    GlobalMockObject::reset(reinterpret_cast<const void*>(halSqTaskSend));
    MOCKER(halSqTaskSend).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE)).then(returnValue(DRV_ERROR_NONE));
    EXPECT_EQ(SubmitOperator(), RT_ERROR_DRV_ERR);
    EXPECT_EQ(stream_->GetSchedOperatorCount(), 0U);
}

TEST_F(SchedGateTest, StreamResetRestoresFirstWaitRequirement)
{
    ASSERT_NO_FATAL_FAILURE(OpenDevice());
    DavidStream stream(device_, 0U, 0U, nullptr);
    stream.ResetSchedOperatorCount();
    stream.ResetDavidStreamConstruct();
    EXPECT_EQ(stream.GetSchedOperatorCount(), UINT32_MAX);
    EXPECT_TRUE(device_->GetSchedGate()->NeedWait(&stream, TS_TASK_TYPE_KERNEL_AICORE));
}

TEST_F(SchedGateTest, DestructorReleasesUnsubmittedEvent)
{
    ASSERT_NO_FATAL_FAILURE(OpenDevice(false));
    {
        DeviceSchedGate gate(device_, TASK_INTERVAL);
        ASSERT_EQ(gate.Setup(), RT_ERROR_NONE);
        const auto eventId = gate.GateEvent()->EventId_();
        MOCKER_CPP_VIRTUAL(device_, &Device::FreeEventIdFromDrv)
            .expects(once())
            .with(eq(eventId), eq(static_cast<uint32_t>(RT_EVENT_DDSYNC_NS)), eq(false))
            .will(returnValue(RT_ERROR_NONE));
        EXPECT_NE(gate.GateEvent(), nullptr);
    }
}

TEST_F(SchedGateTest, SoftwareCaptureCountsSubmittedOperatorsOnPhysicalStream)
{
    ASSERT_NO_FATAL_FAILURE(OpenDevice());
    ASSERT_NO_FATAL_FAILURE(CreateStream());
    MOCKER_CPP_VIRTUAL(device_, &Device::CheckFeatureSupport).stubs().will(returnValue(true));
    MOCKER(NpuDriver::CheckIsSupportFeature).stubs().will(returnValue(true));
    MOCKER_CPP(&Model::UnBindSqPerStream).stubs().will(returnValue(RT_ERROR_NONE));
    ASSERT_EQ(rtStreamBeginCapture(streamHandle_, RT_STREAM_CAPTURE_MODE_GLOBAL), RT_ERROR_NONE);
    captureActive_ = true;
    Stream* target = stream_->GetCaptureStream();
    ASSERT_NE(target, nullptr);
    ASSERT_TRUE(target->IsSoftwareSqEnable());
    const auto initialSize = target->GetCaptureSqeNum();
    ASSERT_EQ(SubmitOperator(), RT_ERROR_NONE);
    EXPECT_EQ(target->GetCaptureSqeNum(), initialSize + 2U);
    EXPECT_EQ(target->GetSchedOperatorCount(), 1U);
    EXPECT_EQ(stream_->GetSchedOperatorCount(), UINT32_MAX);
    ASSERT_EQ(SubmitOperator(), RT_ERROR_NONE);
    ASSERT_EQ(SubmitOperator(), RT_ERROR_NONE);
    EXPECT_EQ(target->GetCaptureSqeNum(), initialSize + 5U);
    EXPECT_EQ(target->GetSchedOperatorCount(), 1U);
}

TEST_F(SchedGateTest, AutoSplitSubmissionCountsOnlyAcceptedOperators)
{
    ASSERT_NO_FATAL_FAILURE(OpenDevice());
    MOCKER_CPP(&Model::UnBindSqPerStream).stubs().will(returnValue(RT_ERROR_NONE));
    ASSERT_EQ(
        runtime_->CurrentContext()->StreamCreate(0U, RT_STREAM_PERSISTENT, &extraStream_, nullptr, false, true),
        RT_ERROR_NONE);
    ASSERT_NE(extraStream_, nullptr);
    ASSERT_EQ(rtModelCreate(&modelHandle_, 0U), RT_ERROR_NONE);
    ASSERT_EQ(
        runtime_->CurrentContext()->ModelAddStream(rt_ut::UnwrapOrNull<Model>(modelHandle_), extraStream_, 0U),
        RT_ERROR_NONE);
    ASSERT_TRUE(extraStream_->IsAutoSplitSq());
    const auto initialSize = extraStream_->GetHostSqeCount();
    ASSERT_EQ(SubmitOperator(extraStream_), RT_ERROR_NONE);
    EXPECT_EQ(extraStream_->GetHostSqeCount(), initialSize + 2U);
    EXPECT_EQ(extraStream_->GetSchedOperatorCount(), 1U);
    ASSERT_EQ(SubmitOperator(extraStream_), RT_ERROR_NONE);
    ASSERT_EQ(SubmitOperator(extraStream_), RT_ERROR_NONE);
    EXPECT_EQ(extraStream_->GetHostSqeCount(), initialSize + 5U);
    EXPECT_EQ(extraStream_->GetSchedOperatorCount(), 1U);
}

TEST_F(SchedGateTest, CaptureExpansionPreservesCounterBeforeNextOperator)
{
    ASSERT_NO_FATAL_FAILURE(OpenDevice());
    ASSERT_NO_FATAL_FAILURE(CreateStream());
    MOCKER_CPP_VIRTUAL(device_, &Device::CheckFeatureSupport).stubs().will(returnValue(true));
    MOCKER(NpuDriver::CheckIsSupportFeature).stubs().will(returnValue(true));
    MOCKER_CPP(&Model::UnBindSqPerStream).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER(CondStreamActive).stubs().will(returnValue(RT_ERROR_NONE));
    ASSERT_EQ(rtStreamBeginCapture(streamHandle_, RT_STREAM_CAPTURE_MODE_GLOBAL), RT_ERROR_NONE);
    captureActive_ = true;
    Stream* original = stream_->GetCaptureStream();
    ASSERT_NE(original, nullptr);
    ASSERT_TRUE(original->IsSoftwareSqEnable());
    const uint32_t reserved = CAPTURE_TASK_RESERVED_NUM + device_->GetDevProperties().expandStreamRsvTaskNum;
    ASSERT_GT(original->GetSqDepth(), reserved + 1U);
    const uint32_t fillLimit = original->GetSqDepth() - reserved - 1U;
    while (original->GetCaptureSqeNum() < fillLimit) {
        ASSERT_EQ(EvtWait(device_->GetSchedGate()->GateEvent(), stream_, UINT32_MAX), RT_ERROR_NONE);
        ASSERT_EQ(stream_->GetCaptureStream(), original);
    }
    ASSERT_EQ(SubmitOperator(), RT_ERROR_NONE);
    ASSERT_EQ(original->GetSchedOperatorCount(), 1U);
    ASSERT_TRUE(NeedCascadeExpandStream(original));
    ASSERT_EQ(SubmitOperator(), RT_ERROR_NONE);
    Stream* expanded = stream_->GetCaptureStream();
    ASSERT_NE(expanded, original);
    EXPECT_EQ(original->GetSchedOperatorCount(), 1U);
    EXPECT_EQ(expanded->GetSchedOperatorCount(), TASK_INTERVAL);
    EXPECT_EQ(expanded->GetCaptureSqeNum(), 1U);
    ASSERT_EQ(SubmitOperator(), RT_ERROR_NONE);
    EXPECT_EQ(expanded->GetSchedOperatorCount(), 1U);
    EXPECT_EQ(expanded->GetCaptureSqeNum(), 3U);
}
} // namespace
