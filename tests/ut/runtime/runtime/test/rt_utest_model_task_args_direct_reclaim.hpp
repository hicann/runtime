/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <array>
#include <cstdlib>
#include <cstring>
#include <vector>
#include "error_codes/rt_error_codes.h"
#include "rt_unwrap.h"
#include "capture_model.hpp"
#include "kernel_utils.hpp"
#include "model_c.hpp"
#include "h2d_copy_mgr.hpp"
#include "uma_arg_loader.hpp"

namespace {
void* watchedCopyBackup = nullptr;
uint32_t copyBackupFreeCount = 0U;
rtError_t CopyDeviceArgsForReclaim(
    Driver*, void* dst, uint64_t, const void* src, uint64_t size, rtMemcpyKind_t kind, bool, uint32_t)
{
    if ((kind == RT_MEMCPY_DEVICE_TO_DEVICE) || (kind == RT_MEMCPY_DEVICE_TO_HOST) ||
        (kind == RT_MEMCPY_HOST_TO_DEVICE)) {
        std::memcpy(dst, src, size);
    }
    return RT_ERROR_NONE;
}
#ifndef ARGS_RECLAIM_EMULATE_DEVICE_MEMORY
drvError_t ObserveCopyBackupFree(void* address)
{
    if (address == watchedCopyBackup) {
        ++copyBackupFreeCount;
    }
    std::free(address);
    return DRV_ERROR_NONE;
}
#endif
#ifdef ARGS_RECLAIM_EMULATE_DEVICE_MEMORY
std::vector<void*> emulatedDeviceAllocations;
void* watchedDeviceArgs = nullptr;
uint32_t watchedDeviceFreeCount = 0;
drvError_t AllocateDistinctDeviceMemory(void** address, UINT64 size, UINT64 flag)
{
    (void)flag;
    *address = std::malloc(size);
    if (*address == nullptr) {
        return DRV_ERROR_OUT_OF_MEMORY;
    }
    emulatedDeviceAllocations.push_back(*address);
    return DRV_ERROR_NONE;
}
drvError_t FreeDistinctDeviceMemory(void* address)
{
    if (address == watchedCopyBackup) {
        ++copyBackupFreeCount;
    }
    if (address == watchedDeviceArgs) {
        ++watchedDeviceFreeCount;
    }
    for (auto it = emulatedDeviceAllocations.begin(); it != emulatedDeviceAllocations.end(); ++it) {
        if (*it == address) {
            std::free(address);
            emulatedDeviceAllocations.erase(it);
            break;
        }
    }
    return DRV_ERROR_NONE;
}
#endif
class ARGS_RECLAIM_TEST_CLASS : public ARGS_RECLAIM_TEST_BASE {
protected:
    struct Allocation {
        BufferAllocator* handles;
        int32_t handleId;
        BufferAllocator* args;
        int32_t argsId;
    };

    void SetUp() override
    {
        ARGS_RECLAIM_TEST_BASE::SetUp();
#ifdef ARGS_RECLAIM_EMULATE_DEVICE_MEMORY
        // The default David stub aliases every allocation to one buffer. Graph SQ
        // and argument pools need distinct allocations to validate real ownership.
        ASSERT_TRUE(emulatedDeviceAllocations.empty());
        MOCKER(halMemAlloc).stubs().will(invoke(AllocateDistinctDeviceMemory));
        MOCKER(halMemFree).stubs().will(invoke(FreeDistinctDeviceMemory));
#endif
        ASSERT_EQ(rtCtxGetCurrent(&previousContext_), RT_ERROR_NONE);
        MOCKER(CheckCaptureModelSupportSoftwareSq).stubs().will(returnValue(RT_ERROR_NONE));
        rtDevBinary_t binary = {RT_DEV_BINARY_MAGIC_ELF, 2, elf_o, elf_o_len};
        ASSERT_EQ(rtDevBinaryRegister(&binary, &graphBinary_), RT_ERROR_NONE);
        ASSERT_EQ(rtFunctionRegister(graphBinary_, &graphFunction_, "foo", nullptr, 0), RT_ERROR_NONE);
        ASSERT_EQ(rtCtxCreate(&graphContext_, 0, 0), RT_ERROR_NONE);
        ASSERT_EQ(rtStreamCreate(&graphStream_, 0), RT_ERROR_NONE);
        Stream* const realStream = rt_ut::UnwrapOrNull<Stream>(graphStream_);
        ASSERT_NE(realStream, nullptr);
        MOCKER_CPP_VIRTUAL(realStream->Device_(), &Device::CheckFeatureSupport).stubs().will(returnValue(true));
        // CQ completion belongs to Device execution. Preserve real model load-complete
        // bookkeeping and resolve this virtual mock through a real Stream instance.
        MOCKER_CPP_VIRTUAL(realStream, &Stream::Synchronize).stubs().will(returnValue(RT_ERROR_NONE));
        MOCKER(MdlUnBindTaskSubmit).stubs().will(returnValue(RT_ERROR_NONE));
        ASSERT_EQ(rtStreamBeginCapture(graphStream_, RT_STREAM_CAPTURE_MODE_GLOBAL), RT_ERROR_NONE);
        ASSERT_EQ(
            rtKernelLaunch(&graphFunction_, 1, hostArgs_.data(), sizeof(hostArgs_), nullptr, graphStream_),
            RT_ERROR_NONE);
        ASSERT_EQ(
            rtKernelLaunch(&graphFunction_, 1, hostArgs_.data(), sizeof(hostArgs_), nullptr, graphStream_),
            RT_ERROR_NONE);
        ASSERT_EQ(
            rtKernelLaunch(&graphFunction_, 1, hostArgs_.data(), sizeof(hostArgs_), nullptr, graphStream_),
            RT_ERROR_NONE);
        ASSERT_EQ(rtStreamEndCapture(graphStream_, &graph_), RT_ERROR_NONE);
        uint32_t streamCount = 1;
        rtStream_t stream = nullptr;
        ASSERT_EQ(rtModelGetStreams(graph_, &stream, &streamCount), RT_ERROR_NONE);
        uint32_t taskCount = 4;
        rtTask_t tasks[4] = {};
        ASSERT_EQ(rtStreamGetTasks(stream, tasks, &taskCount), RT_ERROR_NONE);
        task_ = static_cast<TaskInfo*>(tasks[0]);
        unchangedTask_ = static_cast<TaskInfo*>(tasks[2]);
        model_ = dynamic_cast<CaptureModel*>(task_->stream->Model_());
        ASSERT_NE(model_, nullptr);
        ASSERT_TRUE(model_->IsSoftwareSqEnable());
        ASSERT_TRUE(task_->stream->IsSoftwareSqEnable());
        loader_ = static_cast<UmaArgLoader*>(task_->stream->Device_()->ArgLoader_());
    }

    void TearDown() override
    {
        DestroyGraph();
        watchedCopyBackup = nullptr;
        copyBackupFreeCount = 0U;
        if (graphStream_ != nullptr) {
            EXPECT_EQ(rtStreamDestroy(graphStream_), RT_ERROR_NONE);
        }
        if (graphBinary_ != nullptr) {
            EXPECT_EQ(rtDevBinaryUnRegister(graphBinary_), RT_ERROR_NONE);
        }
        if (graphContext_ != nullptr) {
            EXPECT_EQ(rtCtxDestroy(graphContext_), RT_ERROR_NONE);
        }
        if (previousContext_ != nullptr) {
            EXPECT_EQ(rtCtxSetCurrent(previousContext_), RT_ERROR_NONE);
        }
        ARGS_RECLAIM_TEST_BASE::TearDown();
        GlobalMockObject::verify();
#ifdef ARGS_RECLAIM_EMULATE_DEVICE_MEMORY
        // Do not free pool backing memory while an unexpectedly retained Device can
        // still own it. Reset alone is insufficient when a reference has leaked.
        Device* const retained = Runtime::Instance()->GetDevice(0, 0);
        EXPECT_EQ(retained, nullptr);
        if (retained == nullptr) {
            for (void* address : emulatedDeviceAllocations) {
                std::free(address);
            }
            emulatedDeviceAllocations.clear();
        }
        watchedDeviceArgs = nullptr;
        watchedDeviceFreeCount = 0;
#endif
    }

    void DestroyGraph()
    {
        if (graph_ != nullptr) {
            EXPECT_EQ(rtModelDestroy(graph_), RT_ERROR_NONE);
            graph_ = nullptr;
        }
    }

    rtTaskParams KernelParams()
    {
        rtTaskParams params = {};
        EXPECT_EQ(rtModelTaskGetParams(task_, &params), RT_ERROR_NONE);
        params.kernelTaskParams.argsType = RT_KERNEL_ARGS_HOST_BUFFER;
        params.kernelTaskParams.hostBuffer = {};
        params.kernelTaskParams.hostBuffer.hostArgs = hostArgs_.data();
        params.kernelTaskParams.hostBuffer.hostArgsSize = sizeof(hostArgs_);
        return params;
    }

    void* CurrentHandle(TaskInfo* task)
    {
        void* handle = task->u.aicTaskInfo.comm.argHandle;
        return handle != nullptr ? handle : model_->GetArgHandle(static_cast<uint16_t>(task->stream->Id_()), task->id);
    }

    Allocation CurrentAllocation(TaskInfo* task = nullptr)
    {
        void* handle = CurrentHandle(task == nullptr ? task_ : task);
        EXPECT_NE(handle, nullptr);
        if (handle == nullptr) {
            return {};
        }
        Handle* const argsHandle = static_cast<Handle*>(handle);
        // No public metric exposes whether a pool entry was returned. Inspect the real
        // allocator bitmap so this test does not mistake a Release call for reclamation.
        BufferAllocator* const handles = loader_->handleAllocator_;
        BufferAllocator* const args = argsHandle->freeArgs ? argsHandle->argsAlloc->devAllocator_ : nullptr;
        const int32_t argsId =
            args == nullptr ? -1 : args->GetIdByItem(argsHandle->argsAlloc->GetDevAddr(argsHandle->kerArgs));
        return {handles, handles->GetIdByItem(handle), args, argsId};
    }

    void ExpectOccupied(const Allocation& allocation, bool occupied)
    {
        ASSERT_NE(allocation.handles, nullptr);
        EXPECT_EQ(allocation.handles->BitmapIsOccupied(allocation.handleId), occupied);
        if (allocation.args != nullptr) {
            EXPECT_EQ(allocation.args->BitmapIsOccupied(allocation.argsId), occupied);
        }
    }

    uint32_t OccupiedCount(BufferAllocator* allocator)
    {
        uint32_t count = 0;
        for (uint32_t id = 0; id < allocator->currentCount_; ++id) {
            count += allocator->BitmapIsOccupied(static_cast<int32_t>(id)) ? 1U : 0U;
        }
        return count;
    }

    void ExpectRetired(const Allocation& old, const Allocation& current)
    {
        // David may reuse A's slot when loading B. Combined with the pool count,
        // this checks reclamation without forbidding valid allocator reuse.
        EXPECT_EQ(
            old.handles->BitmapIsOccupied(old.handleId),
            old.handles == current.handles && old.handleId == current.handleId);
        if (old.args != nullptr) {
            EXPECT_EQ(old.args->BitmapIsOccupied(old.argsId), old.args == current.args && old.argsId == current.argsId);
        }
    }

    void ConvertKernelToValue(rtTaskType type)
    {
        const Allocation old = CurrentAllocation();
        uint64_t value = 0;
        rtTaskParams params = {};
        params.type = type;
        if (type == RT_TASK_VALUE_WRITE) {
            params.valueWriteTaskParams.devAddr = &value;
            params.valueWriteTaskParams.value = 1;
        } else {
            params.valueWaitTaskParams.devAddr = &value;
            params.valueWaitTaskParams.value = 1;
        }
        ASSERT_EQ(rtModelTaskSetParams(task_, &params), RT_ERROR_NONE);
        ExpectOccupied(old, true);
        ASSERT_EQ(rtModelUpdate(graph_), RT_ERROR_NONE);
        ExpectOccupied(old, false);
        EXPECT_EQ(
            task_->type, type == RT_TASK_VALUE_WRITE ? TS_TASK_TYPE_MEM_WRITE_VALUE : TS_TASK_TYPE_MEM_WAIT_VALUE);
        DestroyGraph();
        ExpectOccupied(old, false);
    }

    void CheckCopyLifecycle(bool replaceArgs, bool borrowCopy)
    {
        const Allocation old = CurrentAllocation();
        const auto originalArgs = hostArgs_;
        auto& comm = task_->u.aicTaskInfo.comm;
        // Device allocations in this Host fixture are CPU-addressable HAL buffers.
        // Seed the loaded bytes explicitly; this does not claim a real H2D transfer.
        ASSERT_EQ(comm.argsSize, sizeof(originalArgs));
        std::memcpy(comm.args, originalArgs.data(), sizeof(originalArgs));
        Driver* const driver = task_->stream->Device_()->Driver_();
        MOCKER_CPP_VIRTUAL(driver, &Driver::MemCopySync).stubs().will(invoke(CopyDeviceArgsForReclaim));
#ifndef ARGS_RECLAIM_EMULATE_DEVICE_MEMORY
        // Preserve the 910B HAL stub's normal malloc/free behavior while observing S.
        MOCKER(halMemFree).stubs().will(invoke(ObserveCopyBackupFree));
#endif
        if (replaceArgs && !borrowCopy) {
            hostArgs_[0] = 99U;
            rtTaskParams params = KernelParams();
            ASSERT_EQ(rtModelTaskSetParams(task_, &params), RT_ERROR_NONE);
        }
        void* backup = nullptr;
        size_t size = 0U;
        ASSERT_EQ(rtModelTaskCopyArgsDeviceBuffer(task_, &backup, &size), RT_ERROR_NONE);
        ASSERT_NE(backup, nullptr);
        ASSERT_NE(backup, comm.args);
        ASSERT_EQ(size, sizeof(originalArgs));
        watchedCopyBackup = backup;
        copyBackupFreeCount = 0U;
        EXPECT_EQ(std::memcmp(backup, originalArgs.data(), size), 0);
        if (borrowCopy) {
            rtTaskParams params = KernelParams();
            params.kernelTaskParams.argsType = RT_KERNEL_ARGS_DEVICE_BUFFER;
            params.kernelTaskParams.deviceBuffer.deviceArgs = backup;
            params.kernelTaskParams.deviceBuffer.deviceArgsSize = size;
            ASSERT_EQ(rtModelTaskSetParams(task_, &params), RT_ERROR_NONE);
        }
        if (replaceArgs) {
            ASSERT_EQ(rtModelUpdate(graph_), RT_ERROR_NONE);
            if (borrowCopy && CurrentHandle(task_) == nullptr) {
                // David can borrow a Device buffer without creating an ArgLoader handle.
                ExpectOccupied(old, false);
            } else {
                const Allocation current = CurrentAllocation();
                ExpectRetired(old, current);
            }
            if (borrowCopy) {
                EXPECT_EQ(comm.args, backup);
            }
            EXPECT_EQ(copyBackupFreeCount, 0U);
            EXPECT_EQ(std::memcmp(backup, originalArgs.data(), size), 0);
        }
        ASSERT_EQ(rtModelTaskDisable(task_), RT_ERROR_NONE);
        ASSERT_EQ(rtModelUpdate(graph_), RT_ERROR_NONE);
        ExpectOccupied(old, false);
        EXPECT_EQ(copyBackupFreeCount, 0U);
        EXPECT_EQ(std::memcmp(backup, originalArgs.data(), size), 0);
        DestroyGraph();
        EXPECT_EQ(copyBackupFreeCount, 1U);
        watchedCopyBackup = nullptr;
    }

    rtContext_t previousContext_ = nullptr;
    rtContext_t graphContext_ = nullptr;
    rtStream_t graphStream_ = nullptr;
    rtModel_t graph_ = nullptr;
    void* graphBinary_ = nullptr;
    char graphFunction_ = 0;
    TaskInfo* task_ = nullptr;
    TaskInfo* unchangedTask_ = nullptr;
    CaptureModel* model_ = nullptr;
    UmaArgLoader* loader_ = nullptr;
    std::array<uint64_t, 4> hostArgs_{{1, 2, 3, 4}};
};

TEST_F(ARGS_RECLAIM_TEST_CLASS, LaunchSnapshotRelocatesPlaceholderAndInlineTiling)
{
    Driver* const driver = task_->stream->Device_()->Driver_();
    DestroyGraph();
    MOCKER_CPP_VIRTUAL(driver, &Driver::MemCopySync).stubs().will(invoke(CopyDeviceArgsForReclaim));
    rtHostInputInfo_t placeholder = {};
    placeholder.addrOffset = 0U;
    placeholder.dataOffset = 2U * sizeof(uint64_t);
    rtArgsEx_t args = {};
    args.args = hostArgs_.data();
    args.argsSize = sizeof(hostArgs_);
    args.hostInputInfoNum = 1U;
    args.hostInputInfoPtr = &placeholder;
    args.hasTiling = 1U;
    args.tilingAddrOffset = sizeof(uint64_t);
    args.tilingDataOffset = 3U * sizeof(uint64_t);
    ASSERT_EQ(rtStreamBeginCapture(graphStream_, RT_STREAM_CAPTURE_MODE_GLOBAL), RT_ERROR_NONE);
    ASSERT_EQ(rtKernelLaunchWithFlagV2(&graphFunction_, 1U, &args, nullptr, graphStream_, 0U, nullptr), RT_ERROR_NONE);
    ASSERT_EQ(rtStreamEndCapture(graphStream_, &graph_), RT_ERROR_NONE);
    uint32_t count = 1U;
    rtStream_t stream = nullptr;
    ASSERT_EQ(rtModelGetStreams(graph_, &stream, &count), RT_ERROR_NONE);
    rtTask_t tasks[4] = {};
    count = 4U;
    ASSERT_EQ(rtStreamGetTasks(stream, tasks, &count), RT_ERROR_NONE);
    ASSERT_GT(count, 0U);
    task_ = static_cast<TaskInfo*>(tasks[0]);
    auto& comm = task_->u.aicTaskInfo.comm;
    auto loaded = hostArgs_;
    loaded[0] = reinterpret_cast<uintptr_t>(comm.args) + placeholder.dataOffset;
    loaded[1] = reinterpret_cast<uintptr_t>(comm.args) + args.tilingDataOffset;
    std::memcpy(comm.args, loaded.data(), sizeof(loaded));
    ASSERT_NE(task_->updateInfo, nullptr);
    ASSERT_EQ(task_->updateInfo->loadedParams.placeHolderNum, 2U);
    void* backup = nullptr;
    size_t size = 0U;
    ASSERT_EQ(rtModelTaskCopyArgsDeviceBuffer(task_, &backup, &size), RT_ERROR_NONE);
    ASSERT_EQ(size, sizeof(loaded));
    const auto* const copied = static_cast<const uint64_t*>(backup);
    EXPECT_EQ(copied[0], reinterpret_cast<uintptr_t>(backup) + placeholder.dataOffset);
    EXPECT_EQ(copied[1], reinterpret_cast<uintptr_t>(backup) + args.tilingDataOffset);
    EXPECT_EQ(copied[2], loaded[2]);
    EXPECT_EQ(copied[3], loaded[3]);
}

TEST_F(ARGS_RECLAIM_TEST_CLASS, CopyRelocatesLoadedPlaceholderBeforeOriginalArgsAreRetired)
{
    Driver* const driver = task_->stream->Device_()->Driver_();
    MOCKER_CPP_VIRTUAL(driver, &Driver::MemCopySync).stubs().will(invoke(CopyDeviceArgsForReclaim));
    rtTaskParams params = KernelParams();
    rtPlaceHolderInfo_t placeholder = {};
    placeholder.addrOffset = 0U;
    placeholder.dataOffset = 2U * sizeof(uint64_t);
    params.kernelTaskParams.hostBuffer.placeHolderArray = &placeholder;
    params.kernelTaskParams.hostBuffer.placeHolderNum = 1U;
    ASSERT_EQ(rtModelTaskSetParams(task_, &params), RT_ERROR_NONE);
    ASSERT_EQ(rtModelUpdate(graph_), RT_ERROR_NONE);
    auto& comm = task_->u.aicTaskInfo.comm;
    auto loaded = hostArgs_;
    loaded[0] = reinterpret_cast<uintptr_t>(comm.args) + placeholder.dataOffset;
    // HAL fixtures do not execute every H2D transport; seed its expected loaded bytes.
    std::memcpy(comm.args, loaded.data(), sizeof(loaded));
    void* backup = nullptr;
    size_t size = 0U;
    ASSERT_EQ(rtModelTaskCopyArgsDeviceBuffer(task_, &backup, &size), RT_ERROR_NONE);
    ASSERT_NE(backup, nullptr);
    ASSERT_EQ(size, sizeof(loaded));
    const auto* const copied = static_cast<const uint64_t*>(backup);
    EXPECT_EQ(copied[0], reinterpret_cast<uintptr_t>(backup) + placeholder.dataOffset);
    EXPECT_EQ(copied[2], loaded[2]);
    EXPECT_EQ(static_cast<const uint64_t*>(comm.args)[0], loaded[0]);
    ASSERT_EQ(rtModelTaskDisable(task_), RT_ERROR_NONE);
    ASSERT_EQ(rtModelUpdate(graph_), RT_ERROR_NONE);
    EXPECT_EQ(copied[0], reinterpret_cast<uintptr_t>(backup) + placeholder.dataOffset);
    EXPECT_EQ(*reinterpret_cast<const uint64_t*>(copied[0]), loaded[2]);
}

TEST_F(ARGS_RECLAIM_TEST_CLASS, HostGetSetReclaimsOldArgsOnlyAfterUpdate)
{
    const Allocation old = CurrentAllocation();
    ASSERT_NE(old.args, nullptr);
    rtTaskParams params = {};
    ASSERT_EQ(rtModelTaskGetParams(task_, &params), RT_ERROR_NONE);
    ASSERT_EQ(params.kernelTaskParams.argsType, RT_KERNEL_ARGS_HOST_BUFFER);
    const uint32_t handlesBefore = OccupiedCount(old.handles);
    const uint32_t argsBefore = OccupiedCount(old.args);
    ASSERT_EQ(rtModelTaskSetParams(task_, &params), RT_ERROR_NONE);
    ASSERT_EQ(rtModelTaskGetParams(task_, &params), RT_ERROR_NONE);
    ASSERT_EQ(params.kernelTaskParams.argsType, RT_KERNEL_ARGS_HOST_BUFFER);
    ASSERT_EQ(rtModelTaskSetParams(task_, &params), RT_ERROR_NONE);
    ExpectOccupied(old, true);
    EXPECT_EQ(OccupiedCount(old.handles), handlesBefore);
    EXPECT_EQ(OccupiedCount(old.args), argsBefore);
    ASSERT_EQ(rtModelUpdate(graph_), RT_ERROR_NONE);
    const Allocation current = CurrentAllocation();
    ExpectRetired(old, current);
    EXPECT_EQ(OccupiedCount(old.handles), handlesBefore);
    EXPECT_EQ(OccupiedCount(old.args), argsBefore);
    ExpectOccupied(current, true);
    DestroyGraph();
    ExpectOccupied(current, false);
}

TEST_F(ARGS_RECLAIM_TEST_CLASS, UpdatingOneTaskPreservesUnchangedTaskArgs)
{
    const Allocation unchanged = CurrentAllocation(unchangedTask_);
    rtTaskParams params = KernelParams();
    ASSERT_EQ(rtModelTaskSetParams(task_, &params), RT_ERROR_NONE);
    ASSERT_EQ(rtModelUpdate(graph_), RT_ERROR_NONE);
    ExpectOccupied(unchanged, true);
    DestroyGraph();
    ExpectOccupied(unchanged, false);
}

TEST_F(ARGS_RECLAIM_TEST_CLASS, RepeatedUpdatesReturnEveryPreviousPoolEntry)
{
    for (uint64_t version = 0; version < 4; ++version) {
        const Allocation old = CurrentAllocation();
        const uint32_t handlesBefore = OccupiedCount(old.handles);
        const uint32_t argsBefore = OccupiedCount(old.args);
        hostArgs_[0] = version;
        rtTaskParams params = KernelParams();
        ASSERT_EQ(rtModelTaskSetParams(task_, &params), RT_ERROR_NONE);
        ExpectOccupied(old, true);
        ASSERT_EQ(rtModelUpdate(graph_), RT_ERROR_NONE);
        const Allocation current = CurrentAllocation();
        ExpectRetired(old, current);
        EXPECT_EQ(OccupiedCount(old.handles), handlesBefore);
        EXPECT_EQ(OccupiedCount(old.args), argsBefore);
        ExpectOccupied(current, true);
    }
}

TEST_F(ARGS_RECLAIM_TEST_CLASS, DisableReclaimsOnlyAfterUpdate)
{
    const Allocation old = CurrentAllocation();
    ASSERT_EQ(rtModelTaskDisable(task_), RT_ERROR_NONE);
    ExpectOccupied(old, true);
    ASSERT_EQ(rtModelUpdate(graph_), RT_ERROR_NONE);
    ExpectOccupied(old, false);
    DestroyGraph();
    ExpectOccupied(old, false);
}

TEST_F(ARGS_RECLAIM_TEST_CLASS, DeviceInputRemainsBorrowedThroughDisableAndDestroy)
{
    const Allocation old = CurrentAllocation();
    std::array<uint64_t, 4> externalArgs{{11, 22, 33, 44}};
#ifdef ARGS_RECLAIM_EMULATE_DEVICE_MEMORY
    // Observe the external address independently of Runtime-owned allocations.
    watchedDeviceArgs = externalArgs.data();
    watchedDeviceFreeCount = 0;
#endif
    rtTaskParams params = KernelParams();
    params.kernelTaskParams.argsType = RT_KERNEL_ARGS_DEVICE_BUFFER;
    params.kernelTaskParams.deviceBuffer.deviceArgs = externalArgs.data();
    params.kernelTaskParams.deviceBuffer.deviceArgsSize = sizeof(externalArgs);
    ASSERT_EQ(rtModelTaskSetParams(task_, &params), RT_ERROR_NONE);
    ASSERT_EQ(rtModelUpdate(graph_), RT_ERROR_NONE);
    ExpectOccupied(old, false);
    EXPECT_EQ(task_->u.aicTaskInfo.comm.args, externalArgs.data());
    Allocation borrowed = {};
    void* const borrowedHandle = CurrentHandle(task_);
    if (borrowedHandle != nullptr) {
        EXPECT_FALSE(static_cast<Handle*>(borrowedHandle)->freeArgs);
        borrowed = CurrentAllocation();
    }
    ASSERT_EQ(rtModelTaskDisable(task_), RT_ERROR_NONE);
    ASSERT_EQ(rtModelUpdate(graph_), RT_ERROR_NONE);
    DestroyGraph();
    if (borrowed.handles != nullptr) {
        ExpectOccupied(borrowed, false);
    }
    EXPECT_EQ(externalArgs, (std::array<uint64_t, 4>{{11, 22, 33, 44}}));
#ifdef ARGS_RECLAIM_EMULATE_DEVICE_MEMORY
    EXPECT_EQ(watchedDeviceFreeCount, 0U);
    watchedDeviceArgs = nullptr;
#endif
}

TEST_F(ARGS_RECLAIM_TEST_CLASS, RebuildFailureReclaimsRetiredArgsBeforeDestroy)
{
    const Allocation old = CurrentAllocation();
    const Allocation unchanged = CurrentAllocation(unchangedTask_);
    const uint32_t handlesBefore = OccupiedCount(old.handles);
    const uint32_t argsBefore = OccupiedCount(old.args);
    rtTaskParams params = KernelParams();
    ASSERT_EQ(rtModelTaskSetParams(task_, &params), RT_ERROR_NONE);
    MOCKER_CPP(&CaptureModel::BuildLogicSqs).stubs().will(returnValue(RT_ERROR_MODEL_UPDATE_FAILED));
    EXPECT_EQ(rtModelUpdate(graph_), ACL_ERROR_RT_MODEL_UPDATE_FAILED);
    EXPECT_EQ(model_->GetCaptureModelStatus(), RtCaptureModelStatus::FAULT);
    ExpectOccupied(unchanged, true);
    const Allocation current = CurrentAllocation();
    ExpectRetired(old, current);
    EXPECT_EQ(OccupiedCount(old.handles), handlesBefore);
    EXPECT_EQ(OccupiedCount(old.args), argsBefore);
    ExpectOccupied(current, true);
    DestroyGraph();
    ExpectOccupied(old, false);
    ExpectOccupied(unchanged, false);
    ExpectOccupied(current, false);
}

TEST_F(ARGS_RECLAIM_TEST_CLASS, ArgumentLoadFailurePreservesPlatformOwnership)
{
    const Allocation old = CurrentAllocation();
    const Allocation unchanged = CurrentAllocation(unchangedTask_);
    rtTaskParams params = KernelParams();
    ASSERT_EQ(rtModelTaskSetParams(task_, &params), RT_ERROR_NONE);
    MOCKER(LoadKernelArgs).stubs().will(returnValue(RT_ERROR_MEMORY_ALLOCATION));
    EXPECT_EQ(rtModelUpdate(graph_), ACL_ERROR_RT_MEMORY_ALLOCATION);
    EXPECT_EQ(model_->GetCaptureModelStatus(), RtCaptureModelStatus::FAULT);
#ifdef ARGS_RECLAIM_EMULATE_DEVICE_MEMORY
    // TaskClearForUpdate releases David's task-owned A before the failed load.
    ExpectOccupied(old, false);
#else
    // v100 still owns A in the original model record until stream reconstruction.
    ExpectOccupied(old, true);
#endif
    ExpectOccupied(unchanged, true);
    DestroyGraph();
    ExpectOccupied(old, false);
    ExpectOccupied(unchanged, false);
}

TEST_F(ARGS_RECLAIM_TEST_CLASS, RunningModelDoesNotReleaseOldArgs)
{
    const Allocation old = CurrentAllocation();
    rtTaskParams params = KernelParams();
    ASSERT_EQ(rtModelTaskSetParams(task_, &params), RT_ERROR_NONE);
    MOCKER_CPP(&CaptureModel::IsCaptureModelRunningAfterPoll).stubs().will(returnValue(true));
    EXPECT_EQ(rtModelUpdate(graph_), ACL_ERROR_RT_MODEL_UPDATE_FAILED);
    ExpectOccupied(old, true);
}

TEST_F(ARGS_RECLAIM_TEST_CLASS, KernelToWriteReclaimsOldArgsDuringUpdate) { ConvertKernelToValue(RT_TASK_VALUE_WRITE); }

TEST_F(ARGS_RECLAIM_TEST_CLASS, KernelToWaitReclaimsOldArgsDuringUpdate) { ConvertKernelToValue(RT_TASK_VALUE_WAIT); }

TEST_F(ARGS_RECLAIM_TEST_CLASS, SetWithoutUpdateKeepsOriginalArgsUntilDestroy)
{
    const Allocation old = CurrentAllocation();
    const uint32_t handlesBefore = OccupiedCount(old.handles);
    const uint32_t argsBefore = OccupiedCount(old.args);
    rtTaskParams params = KernelParams();
    for (uint32_t version = 0; version < 4; ++version) {
        hostArgs_[0] = version;
        ASSERT_EQ(rtModelTaskSetParams(task_, &params), RT_ERROR_NONE);
        ExpectOccupied(old, true);
        EXPECT_EQ(OccupiedCount(old.handles), handlesBefore);
        EXPECT_EQ(OccupiedCount(old.args), argsBefore);
    }
    DestroyGraph();
    ExpectOccupied(old, false);
}

TEST_F(ARGS_RECLAIM_TEST_CLASS, DisableWithoutUpdateKeepsOriginalArgsUntilDestroy)
{
    const Allocation old = CurrentAllocation();
    ASSERT_EQ(rtModelTaskDisable(task_), RT_ERROR_NONE);
    ExpectOccupied(old, true);
    DestroyGraph();
    ExpectOccupied(old, false);
}

TEST_F(ARGS_RECLAIM_TEST_CLASS, ReadyUpdatePreservesCurrentArgs)
{
    const Allocation old = CurrentAllocation();
    const uint32_t handlesBefore = OccupiedCount(old.handles);
    EXPECT_EQ(model_->GetCaptureModelStatus(), RtCaptureModelStatus::READY);
    ASSERT_EQ(rtModelUpdate(graph_), RT_ERROR_NONE);
    EXPECT_EQ(model_->GetCaptureModelStatus(), RtCaptureModelStatus::READY);
    ExpectOccupied(old, true);
    EXPECT_EQ(OccupiedCount(old.handles), handlesBefore);
}

TEST_F(ARGS_RECLAIM_TEST_CLASS, CopySnapshotSurvivesHostUpdateAndDisable) { CheckCopyLifecycle(true, false); }

TEST_F(ARGS_RECLAIM_TEST_CLASS, CopySnapshotSurvivesDirectDisable) { CheckCopyLifecycle(false, false); }

TEST_F(ARGS_RECLAIM_TEST_CLASS, CopySnapshotRemainsModelOwnedWhenSetAsDeviceArgs) { CheckCopyLifecycle(true, true); }

} // namespace
