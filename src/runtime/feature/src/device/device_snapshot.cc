/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "device_snapshot.hpp"
#include "stream.hpp"
#include "device.hpp"
#include "kernel.hpp"
#include "runtime.hpp"
#include "context.hpp"
#include "inner_thread_local.hpp"
#include "error_message_manage.hpp"
#include "uma_arg_loader.hpp"

namespace cce {
namespace runtime {

DeviceSnapshot::DeviceSnapshot(Device *dev)
{
    device_ = dev;
}

DeviceSnapshot::~DeviceSnapshot() noexcept
{
}

void DeviceSnapshot::RecordOpAddrAndSize(const Stream *const stm)
{
    const std::vector<uint16_t>& taskIds = stm->GetDelayRecycleTaskId();
    const size_t size = taskIds.size();
    Device *dev = stm->Device_();
    for (uint16_t i = 0U; i < size; i++) {
        const uint16_t taskId = taskIds[i];
        TaskInfo *task = dev->GetTaskFactory()->GetTask(stm->Id_(), taskId);
        if (task == nullptr) {
            RT_LOG(RT_LOG_WARNING, "get task is nullptr, stream_id=%d, task_id=%u.", stm->Id_(), taskId);
            continue;
        }
        RT_LOG(RT_LOG_DEBUG, "stream_id==%d, taskId=%u, type=%d.", stm->Id_(), taskId, task->type);
        RecordArgsAddrAndSize(task);
        RecordFuncCallAddrAndSize(task);
    }
    return;
}

void DeviceSnapshot::RecordArgsAddrAndSize(TaskInfo *const task)
{
    if (task->type == TS_TASK_TYPE_KERNEL_AICORE || task->type == TS_TASK_TYPE_KERNEL_AIVEC) {
        // mix scene
        if ((task->u.aicTaskInfo.kernel != nullptr) &&
            (task->u.aicTaskInfo.kernel->GetMixType() != NO_MIX)) {
                void *contextAddr = task->u.aicTaskInfo.descAlignBuf;
                AddOpVirtualAddr(contextAddr, static_cast<size_t>(sizeof(rtFftsPlusMixAicAivCtx_t)));
        } 
        // no mix scene
        void *args = task->u.aicTaskInfo.comm.args;
        const size_t size = task->u.aicTaskInfo.comm.argsSize;
        AddOpVirtualAddr(args, static_cast<size_t>(size));
    } else if (task->type == TS_TASK_TYPE_KERNEL_AICPU) {
        void *args = task->u.aicpuTaskInfo.comm.args;
        const size_t size = task->u.aicpuTaskInfo.comm.argsSize;
        AddOpVirtualAddr(args, static_cast<size_t>(size));
    } else if (task->type == TS_TASK_TYPE_FFTS_PLUS) {
        FftsPlusTaskInfo *fftsPlusTask = &task->u.fftsPlusTask;
        void* contextAddr = fftsPlusTask->descAlignBuf;
        const size_t size = fftsPlusTask->descBufLen;
        AddOpVirtualAddr(contextAddr, static_cast<size_t>(size));
    } else {
        // do nothing
    }
    return;
}

void DeviceSnapshot::RecordFuncCallAddrAndSize(TaskInfo *const task)
{
    if (task->type == TS_TASK_TYPE_STREAM_SWITCH) {
        StreamSwitchTaskInfo* streamSwitchTask = &(task->u.streamswitchTask);
        void *addr = streamSwitchTask->funcCallSvmMem;
        const size_t size = streamSwitchTask->funCallMemSize;
        AddOpVirtualAddr(addr, static_cast<size_t>(size));
    } else if (task->type == TS_TASK_TYPE_STREAM_LABEL_SWITCH_BY_INDEX) {
        StmLabelSwitchByIdxTaskInfo * stmLabelSwitchByIdxTaskInfo = &(task->u.stmLabelSwitchIdxTask);
        void *addr = stmLabelSwitchByIdxTaskInfo->funcCallSvmMem;
        const size_t size = stmLabelSwitchByIdxTaskInfo->funCallMemSize;
        AddOpVirtualAddr(addr, static_cast<size_t>(size));
        /* index type is uin32_t, device addr need 8 byte align */
        AddOpVirtualAddr(stmLabelSwitchByIdxTaskInfo->indexPtr, sizeof(uint64_t));
        const uint32_t labelMemSize = sizeof(rtLabelDevInfo) * stmLabelSwitchByIdxTaskInfo->max;
        AddOpVirtualAddr(stmLabelSwitchByIdxTaskInfo->labelInfoPtr, labelMemSize);
    } else if (task->type == TS_TASK_TYPE_MEM_WAIT_VALUE) {
        MemWaitValueTaskInfo *memWaitValueTask = &(task->u.memWaitValueTask);
        void *addr = memWaitValueTask->funcCallSvmMem2;
        size_t size = memWaitValueTask->funCallMemSize2;
        AddOpVirtualAddr(addr, static_cast<size_t>(size));
        AddOpVirtualAddr(RtPtrToPtr<void *>(memWaitValueTask->devAddr), sizeof(uint64_t)); // devAddr的有效内存位宽为64bit
    } else if (task->type == TS_TASK_TYPE_RDMA_PI_VALUE_MODIFY) {
        RdmaPiValueModifyInfo *rdmaPiValueModifyInfo = &(task->u.rdmaPiValueModifyInfo);
        void *addr = rdmaPiValueModifyInfo->funCallMemAddr;
        const size_t size = rdmaPiValueModifyInfo->funCallMemSize;
        AddOpVirtualAddr(addr, static_cast<size_t>(size));
    } else if (task->type == TS_TASK_TYPE_STREAM_ACTIVE) {
        StreamActiveTaskInfo *streamActiveTask = &(task->u.streamactiveTask);
        void *addr = streamActiveTask->funcCallSvmMem;
        const size_t size = streamActiveTask->funCallMemSize;
        AddOpVirtualAddr(addr, static_cast<size_t>(size));
    } else if (task->type == TS_TASK_TYPE_MODEL_TASK_UPDATE) {
        MdlUpdateTaskInfo *mdlUpdateTaskInfo = &(task->u.mdlUpdateTask);
        const size_t size = mdlUpdateTaskInfo->tilingTabLen * sizeof(TilingTabl);
        void *addr = mdlUpdateTaskInfo->tilingTabAddr;
        AddOpVirtualAddr(addr, size);
        AddOpVirtualAddr(mdlUpdateTaskInfo->tilingKeyAddr, sizeof(uint64_t));
        AddOpVirtualAddr(mdlUpdateTaskInfo->blockDimAddr, sizeof(uint64_t));
    } else {
        // do nothing
    }
    return;
}

void DeviceSnapshot::GetOpTotalMemoryInfo(const Model *const mdl)
{
    std::list<Stream *> streams = mdl->StreamList_();
    for (auto stm : streams) {
        RecordOpAddrAndSize(stm);
    }
}

void DeviceSnapshot::OpMemoryInfoInit(void)
{
    opVirtualAddrs_.clear();
    opBackUpAddrs_.reset();
    opTotalHostMemSize_ = 0U;
}

rtError_t DeviceSnapshot::OpMemoryBackup(void)
{
    OpMemoryInfoInit();
    auto mdlList = std::make_unique<rtModelList_t>();
    NULL_PTR_RETURN(mdlList, RT_ERROR_MEMORY_ALLOCATION);
    ContextManage::DeviceGetModelList(static_cast<int32_t>(device_->Id_()), mdlList.get());

    for (uint32_t i = 0U; i < mdlList->mdlNum; i++) {
        Model *mdl = RtPtrToPtr<Model *>(mdlList->mdls[i]);
        if (mdl != nullptr) {
            GetOpTotalMemoryInfo(mdl);
        }
    }
    const size_t opTotalHostMemSize = GetOpTotalHostMemSize();
    if (opTotalHostMemSize == 0U) {
        RT_LOG(RT_LOG_DEBUG, "no memory need to back up.");
        return RT_ERROR_NONE;
    }

    std::unique_ptr<uint8_t[]> opBackupAddr(new (std::nothrow) uint8_t[opTotalHostMemSize]);
    SetOpBackUpAddr(opBackupAddr);
    uint8_t* hostAddr = GetOpBackUpAddr().get();

    auto vaAddrs = GetOpVirtualAddrs();
    size_t offset = 0U;
    Driver * const curDrv = device_->Driver_();
    rtError_t error = RT_ERROR_NONE;
    for (auto it = vaAddrs.begin(); it != vaAddrs.end(); ++it) {
        void* addr = it->first;
        const size_t size = it->second;        
        error = curDrv->MemCopySync(static_cast<void *>(hostAddr + offset), size, addr,  size, RT_MEMCPY_DEVICE_TO_HOST);
        ERROR_RETURN(error, "MemCopySync failed, retCode=%#x.", error);
        RT_LOG(RT_LOG_DEBUG, "hostAddr=%p, devAddr=%p, size=%zu, offset=%zu.",
            (hostAddr + offset), addr, size, offset);
        offset += size;
        COND_RETURN_ERROR((offset > opTotalHostMemSize), RT_ERROR_INVALID_VALUE,
            "offset is less than or equal to host memory size, offset=%lu, host memory size=%lu, devId=%d",
            offset, opTotalHostMemSize, device_->Id_());
    }
    COND_RETURN_ERROR((offset != opTotalHostMemSize), RT_ERROR_INVALID_VALUE,
        "offset not equal host memory size, offset=%lu, host memory size=%lu, devId=%d",
        offset, opTotalHostMemSize, device_->Id_());
    RT_LOG(RT_LOG_DEBUG, "hostAddr=%p, opTotalHostMemSize=%zu.", opBackupAddr.get(), opTotalHostMemSize);
    return error;
}

rtError_t DeviceSnapshot::OpMemoryRestore(void)
{
    const size_t opTotalHostMemSize = GetOpTotalHostMemSize();
    if (opTotalHostMemSize == 0U) {
        RT_LOG(RT_LOG_DEBUG, "no task args memory need to restore.");
        return RT_ERROR_NONE;
    }
    std::unique_ptr<uint8_t []> &opBackupAddr = GetOpBackUpAddr();
    const uint8_t *hostAddr = opBackupAddr.get();
    NULL_PTR_RETURN_MSG(hostAddr, RT_ERROR_INVALID_VALUE);

    auto vaAddrInfos = GetOpVirtualAddrs();
    size_t offset = 0U;
    Context *curCtx = Runtime::Instance()->CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    Stream* stm = curCtx->DefaultStream_();
    for (auto it = vaAddrInfos.begin(); it != vaAddrInfos.end(); ++it) {
        void* addr = it->first;
        const size_t size = it->second;
        uint64_t realSize = 0U;
        const rtError_t error = curCtx->MemcpyAsync(addr, size, hostAddr + offset, size,
            RT_MEMCPY_HOST_TO_DEVICE, stm, &realSize);

        ERROR_RETURN(error, "memcpy async failed, retCode=%#x.", error);
        RT_LOG(RT_LOG_DEBUG, "hostAddr=%p, devAddr=%p, size=%zu, offset=%zu.",
            (hostAddr + offset), addr, size, offset);
        offset += size;
        COND_RETURN_ERROR((offset > opTotalHostMemSize), RT_ERROR_INVALID_VALUE,
            "offset is less than or equal to host memory size, offset=%lu, host memory size=%lu, devId=%d",
            offset, opTotalHostMemSize, device_->Id_());
    }
    COND_RETURN_ERROR((offset != opTotalHostMemSize), RT_ERROR_INVALID_VALUE,
        "offset not equal host memory size, offset=%lu, host memory size=%lu, devId=%d",
        offset, opTotalHostMemSize, device_->Id_());
    const rtError_t error = stm->Synchronize();
    ERROR_RETURN(error, "Synchronize failed, streamId=%d, retCode=%#x.", stm->Id_(), error);
    RT_LOG(RT_LOG_DEBUG, "hostAddr=%p, opTotalHostMemSize=%zu, offset=%zu.",
        hostAddr, opTotalHostMemSize, offset);
    return RT_ERROR_NONE;
}

rtError_t DeviceSnapshot::ArgsPoolConvertAddr(H2DCopyMgr *const mgr) const
{
    rtError_t ret = RT_ERROR_NONE;
    if (mgr->GetPolicy() == COPY_POLICY_ASYNC_PCIE_DMA) {
        ret = mgr->ArgsPoolConvertAddr();
        ERROR_RETURN(ret, "convert args pool addr failed, retCode=%#x.", ret);
    }
    return ret;
}

rtError_t DeviceSnapshot::ArgsPoolRestore(void) const
{
    ArgLoader * const argLoaderObj = device_->ArgLoader_();
    UmaArgLoader *umaArgLoader = dynamic_cast<UmaArgLoader *>(argLoaderObj);
    COND_RETURN_ERROR((umaArgLoader == nullptr), RT_ERROR_INVALID_VALUE, "Get umaArgLoader nullptr, devId=%d", device_->Id_());

    void *addr = GetArgPcieBarAddr();
    const size_t size = GetArgPcieBarSize();
    void* outAddr = nullptr;

    rtError_t ret = device_->Driver_()->PcieHostRegister(addr, static_cast<uint64_t>(size), device_->Id_(), outAddr);
    ERROR_RETURN(ret, "PcieHostRegister failed, retCode=%#x.", ret);

    H2DCopyMgr *mgr = umaArgLoader->GetArgsAllocator();
    ret = ArgsPoolConvertAddr(mgr);
    ERROR_RETURN(ret, "convert args pool addr failed, retCode=%#x.", ret);

    mgr = umaArgLoader->GetSuperArgsAllocator();
    ret = ArgsPoolConvertAddr(mgr);
    ERROR_RETURN(ret, "convert args pool addr failed, retCode=%#x.", ret);

    mgr = umaArgLoader->GetMaxArgsAllocator();
    ret = ArgsPoolConvertAddr(mgr);
    ERROR_RETURN(ret, "convert args pool addr failed, retCode=%#x.", ret);
 
    mgr = umaArgLoader->GetRandomAllocator();
    ret = ArgsPoolConvertAddr(mgr);
    ERROR_RETURN(ret, "convert args pool addr failed, retCode=%#x.", ret);
    return ret;
}
}
}