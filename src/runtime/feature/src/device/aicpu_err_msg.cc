/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "aicpu_err_msg.hpp"
#include "base.hpp"
#include "kernel.h"
#include "runtime.hpp"
#include "task_fail_callback_manager.hpp"
#include "program.hpp"
#include "arg_loader.hpp"
#include "npu_driver.hpp"
#include "task.hpp"
#include "osal.hpp"
#include "task_info.hpp"
#include "task_submit.hpp"
#include "error_code.h"

namespace cce {
namespace runtime {
constexpr uint32_t DEV_ERR_MSG_BUF_TOTAL_LEN = 4096U; /* err msg buf total len, 4K */
constexpr const char_t *AICPU_ERR_MSG_CONFIG_OP_NAME = "CfgLogAddr";

AicpuErrMsg::AicpuErrMsg(Device * const dev)
    : NoCopy(),
      device_(dev)
{
}

AicpuErrMsg::~AicpuErrMsg() noexcept
{
    FreeResource();
    errMsgBuf_ = nullptr;
    device_ = nullptr;
}

void AicpuErrMsg::ErrMsgBufLock(void)
{
    errMsgBufMutex_.lock();
}

void AicpuErrMsg::ErrMsgBufUnLock(void)
{
    errMsgBufMutex_.unlock();
}

rtError_t AicpuErrMsg::AllocResource(void)
{
    rtError_t retErr = RT_ERROR_NONE;

    if (errMsgBuf_ == nullptr) {
        Driver * const devDrv = device_->Driver_();
        retErr = devDrv->DevMemAlloc(&errMsgBuf_, DEV_ERR_MSG_BUF_TOTAL_LEN, RT_MEMORY_DEFAULT, device_->Id_());
        if (retErr != RT_ERROR_NONE) {
            RT_LOG(RT_LOG_ERROR, "malloc dev msg buf failed, retCode=%d.", retErr);
            return retErr;
        }
        (void)devDrv->MemSetSync(errMsgBuf_, DEV_ERR_MSG_BUF_TOTAL_LEN, 0U, DEV_ERR_MSG_BUF_TOTAL_LEN);
    }

    return retErr;
}

void AicpuErrMsg::FreeResource(void) noexcept
{
    if (errMsgBuf_ != nullptr) {
        Driver * const devDrv = device_->Driver_();
        const rtError_t retErr = devDrv->DevMemFree(errMsgBuf_, device_->Id_());
        if (retErr != RT_ERROR_NONE) {
            RT_LOG(RT_LOG_ERROR, "free dev msg buf failed, retCode=%d.", retErr);
            return;
        }
        errMsgBuf_ = nullptr;
    }

    return;
}

rtError_t AicpuErrMsg::FillKernelLaunchPara(const rtKernelLaunchNames_t &launchNames,
                                            TaskInfo * const kernTask) const
{
    const char_t * const launchSoName = launchNames.soName;
    const char_t * const kernelName = launchNames.kernelName;
    void *soNameAddr = nullptr;
    void *kernelNameAddr = nullptr;
    ArgLoader * const devArgLdr = device_->ArgLoader_();

    // Set soName and kernelName for task
    if (launchSoName != nullptr) {
        const rtError_t retErr = devArgLdr->GetKernelInfoDevAddr(static_cast<const char_t *>(launchSoName),
                                                                 KernelInfoType::SO_NAME, &soNameAddr);
        if (retErr != RT_ERROR_NONE) {
            RT_LOG(RT_LOG_ERROR, "Failed to get so address by name, retCode=%d", retErr);
            return retErr;
        }
    }
    if (kernelName != nullptr) {
        const rtError_t retErr = devArgLdr->GetKernelInfoDevAddr(static_cast<const char_t *>(kernelName),
                                                                 KernelInfoType::KERNEL_NAME, &kernelNameAddr);
        if (retErr != RT_ERROR_NONE) {
            RT_LOG(RT_LOG_ERROR, "Failed to get kernel address by name, retCode=%d", retErr);
            return retErr;
        }
    }
    SetNameArgs(kernTask, soNameAddr, kernelNameAddr);

    return RT_ERROR_NONE;
}

/* method only for AicpuErrMsg */
rtError_t AicpuErrMsg::SendTaskToAicpu(const rtKernelLaunchNames_t &launchNames, const uint32_t coreDim,
    const void * const args, const uint32_t argsSize, const uint32_t flag) const
{
    rtError_t retErr = RT_ERROR_NONE;
    Stream * const stm = device_->PrimaryStream_();
    NULL_PTR_RETURN(stm, RT_ERROR_STREAM_NULL);

    TaskInfo submitTask = {};
    rtError_t errorReason;
    TaskInfo* kernTask = stm->AllocTask(&submitTask, TS_TASK_TYPE_KERNEL_AICPU, errorReason);
    NULL_PTR_RETURN(kernTask, errorReason);

    ArgLoader * const devArgLdr = device_->ArgLoader_();
    ArgLoaderResult result{};
    tsAicpuKernelType aicpuKernelType;

    // Init task
    AicpuTaskInit(kernTask, static_cast<uint16_t>(coreDim), flag);

    AicpuTaskInfo *aicpuTaskInfo = &(kernTask->u.aicpuTaskInfo);
    RT_LOG(RT_LOG_INFO, "flag=%u, kernelFlag=0x%x, blkdim=%u.",
        flag, aicpuTaskInfo->comm.kernelFlag, aicpuTaskInfo->comm.dim);

    // Set args for task
    rtArgsEx_t argsInfo = {};
    argsInfo.args = const_cast<void *>(args);
    argsInfo.argsSize = argsSize;
    retErr = devArgLdr->LoadCpuKernelArgs(&argsInfo, stm, &result);
    if (retErr != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "Failed to load cpu Kernel args , retCode=%d", retErr);
        (void)device_->GetTaskFactory()->Recycle(kernTask);
        return retErr;
    }

    SetAicpuArgs(kernTask, result.kerArgs, argsSize, result.handle);
    result.handle = nullptr;

    retErr = FillKernelLaunchPara(launchNames, kernTask);
    if (retErr != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "Failed to fill kernel launch para, retCode=%d", retErr);
        (void)device_->GetTaskFactory()->Recycle(kernTask);
        return retErr;
    }

    // Set kernel type and flags
    aicpuKernelType = ((flag & RT_KERNEL_CUSTOM_AICPU) != 0U) ? TS_AICPU_KERNEL_CUSTOM_AICPU : TS_AICPU_KERNEL_AICPU;
    aicpuTaskInfo->aicpuKernelType = static_cast<uint8_t>(aicpuKernelType);

    // Submit task
    retErr = device_->SubmitTask(kernTask);
    if (retErr != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "Failed to submit kernel task, retCode=%d", retErr);
        (void)device_->GetTaskFactory()->Recycle(kernTask);
        return retErr;
    }

    return stm->Synchronize();
}

rtError_t AicpuErrMsg::SendConfigMsgToAicpu(const aicpu::AicpuConfigMsg * const configMsg) const
{
    rtKernelLaunchNames_t launchNames;
    launchNames.soName = nullptr;
    launchNames.kernelName = AICPU_ERR_MSG_CONFIG_OP_NAME;
    launchNames.opName = AICPU_ERR_MSG_CONFIG_OP_NAME;

    const rtError_t retErr = SendTaskToAicpu(launchNames, 1U, static_cast<const void *>(configMsg),
        static_cast<uint32_t>(sizeof(aicpu::AicpuConfigMsg)), 0U);
    if (retErr != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "aicpu kernel launch failed, retCode=%#x.", retErr);
    }

    return retErr;
}

void AicpuErrMsg::SetErrMsgBufAddr(void)
{
    ErrMsgBufLock();
    if (errMsgBuf_ != nullptr) {
        ErrMsgBufUnLock();
        return;
    }

    rtError_t retErr = AllocResource();
    if (retErr != RT_ERROR_NONE) {
        ErrMsgBufUnLock();
        return;
    }

    aicpu::AicpuConfigMsg configMsg;

    configMsg.msgType = static_cast<uint8_t>(aicpu::AicpuConfigMsgType::AICPU_CONFIG_MSG_TYPE_BUF_SET_ADDR);
    configMsg.bufAddr = RtPtrToValue(errMsgBuf_);
    configMsg.bufLen = DEV_ERR_MSG_BUF_TOTAL_LEN;
    configMsg.reserved1 = 0U;
    configMsg.offset = 0U;
    configMsg.tsId = device_->DevGetTsId();
    configMsg.reserved2 = 0U;

    retErr = SendConfigMsgToAicpu(&configMsg);
    if (retErr != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "set err msg buf addr to aicpu failed, retCode=%#x, [%s].",
            retErr, GetTsErrDescByRtErr(retErr));
        FreeResource();
    }
    ErrMsgBufUnLock();
}
}
}
