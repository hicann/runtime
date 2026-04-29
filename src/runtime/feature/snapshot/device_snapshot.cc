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
#include "arg_loader_ub.hpp"
#include "memcpy_c.hpp"

namespace cce {
namespace runtime {

// TaskHandlers namespace contains handler functions for different task types
// Used by RecordFuncCallAddrAndSize() to record virtual addresses for snapshot
// Each handler extracts task-specific addresses and adds them to the snapshot
namespace TaskHandlers {
void HandleStreamSwitch(TaskInfo* const task, DeviceSnapshot* snapshot) {
    StreamSwitchTaskInfo* streamSwitchTask = &(task->u.streamswitchTask);
    snapshot->AddOpVirtualAddr(streamSwitchTask->funcCallSvmMem, 
                            static_cast<size_t>(streamSwitchTask->funCallMemSize));
}

void HandleStreamLabelSwitchByIndex(TaskInfo* const task, DeviceSnapshot* snapshot) {
    StmLabelSwitchByIdxTaskInfo* info = &(task->u.stmLabelSwitchIdxTask);
    snapshot->AddOpVirtualAddr(info->funcCallSvmMem, 
                            static_cast<size_t>(info->funCallMemSize));
    // index type is uint32_t, device addr need 8 byte align
    snapshot->AddOpVirtualAddr(info->indexPtr, sizeof(uint64_t));
    
    const uint32_t labelMemSize = sizeof(rtLabelDevInfo) * info->max;
    snapshot->AddOpVirtualAddr(info->labelInfoPtr, labelMemSize);
}

void HandleMemWaitValue(TaskInfo* const task, DeviceSnapshot* snapshot) {
    MemWaitValueTaskInfo* info = &(task->u.memWaitValueTask);
    snapshot->AddOpVirtualAddr(info->funcCallSvmMem2, 
                            static_cast<size_t>(info->funCallMemSize2));
    // devAddr的有效内存位宽为64bit
    snapshot->AddOpVirtualAddr(RtPtrToPtr<void*>(info->devAddr), sizeof(uint64_t));
}

void HandleRdmaPiValueModify(TaskInfo* const task, DeviceSnapshot* snapshot) {
    RdmaPiValueModifyInfo* info = &(task->u.rdmaPiValueModifyInfo);
    snapshot->AddOpVirtualAddr(info->funCallMemAddr, 
                            static_cast<size_t>(info->funCallMemSize));
}

void HandleStreamActive(TaskInfo* const task, DeviceSnapshot* snapshot) {
    StreamActiveTaskInfo* info = &(task->u.streamactiveTask);
    snapshot->AddOpVirtualAddr(info->funcCallSvmMem, 
                            static_cast<size_t>(info->funCallMemSize));
}
}

DeviceSnapshot::DeviceSnapshot(Device *dev)
{
    device_ = dev;
}

DeviceSnapshot::~DeviceSnapshot() noexcept
{
}

void DeviceSnapshot::RecordFuncCallAddrAndSize(TaskInfo *const task)
{
    static const auto& handlerMap = GetHandlerMap();
    auto it = handlerMap.find(task->type);
    if (it != handlerMap.end()) {
        it->second(task, this);
    }
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
    auto mdlList = std::make_unique<ModelList_t>();
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
    Stream* stm = curCtx->GetCtrlSQStream();
    for (auto it = vaAddrInfos.begin(); it != vaAddrInfos.end(); ++it) {
        void* addr = it->first;
        const size_t size = it->second;
        uint64_t realSize = 0U;
        const rtError_t error =
            MemcopyAsync(addr, size, hostAddr + offset, size, RT_MEMCPY_HOST_TO_DEVICE, stm, &realSize);

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
    } else if (mgr->GetPolicy() == COPY_POLICY_UB) {
        ret = mgr->UbArgsPoolConvertAddr();
        ERROR_RETURN(ret, "convert ub args pool addr failed, retCode=%#x.", ret);
    } else {
        // do nothing
    }
    return ret;
}

rtError_t DeviceSnapshot::ArgsPoolRestore(void) const
{
    ArgLoader * const argLoaderObj = device_->ArgLoader_();
    UmaArgLoader *umaArgLoader = dynamic_cast<UmaArgLoader *>(argLoaderObj);
    COND_RETURN_ERROR((umaArgLoader == nullptr), RT_ERROR_INVALID_VALUE, "Get umaArgLoader nullptr, devId=%d", device_->Id_());

    rtError_t ret = RT_ERROR_NONE;
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

rtError_t DeviceSnapshot::UbArgsPoolRestore(void) const
{
    if (!Runtime::Instance()->GetConnectUbFlag()) {
        return RT_ERROR_NONE;
    }

    UbArgLoader *ubArgLoader = device_->UbArgLoaderPtr();
    COND_RETURN_ERROR((ubArgLoader == nullptr), RT_ERROR_INVALID_VALUE, "Get ubArgLoader nullptr, devId=%d", device_->Id_());
    rtError_t ret;
    H2DCopyMgr *mgr = ubArgLoader->GetArgsAllocator();
    ret = ArgsPoolConvertAddr(mgr);
    ERROR_RETURN(ret, "convert args pool addr failed, retCode=%#x.", ret);

    mgr = ubArgLoader->GetSuperArgsAllocator();
    ret = ArgsPoolConvertAddr(mgr);
    ERROR_RETURN(ret, "convert args pool addr failed, retCode=%#x.", ret);

    return RT_ERROR_NONE;
}

}
} // namespace cce
