/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "task_fail_callback_manager.hpp"

namespace cce {
namespace runtime {

void TaskFailCallBackNotify(rtExceptionInfo_t *const exceptionInfo)
{
    const uint32_t realDeviceId = exceptionInfo->deviceid;
    (void)Runtime::Instance()->GetUserDevIdByDeviceId(realDeviceId, &exceptionInfo->deviceid);
    TaskFailCallBackManager::Instance().Notify(exceptionInfo);
    OpTaskFailCallbackNotify(exceptionInfo);

    Device *dev = Runtime::Instance()->GetDevice(realDeviceId, 0, false);
    COND_RETURN_VOID(dev == nullptr, "dev is nullptr");

    auto& exceptionRegMap = dev->GetExceptionRegMap();
    std::pair<uint32_t, uint32_t> key = {exceptionInfo->streamid, exceptionInfo->taskid};
    std::lock_guard<std::mutex> lock(dev->GetExceptionRegMutex());
    auto it = exceptionRegMap.find(key);
    if (it != exceptionRegMap.end()) {
        (void)exceptionRegMap.erase(it);
    }
}

rtError_t TaskFailCallBackReg(const char_t *regName, void *callback, void *args,
    TaskFailCallbackType type)
{
    return TaskFailCallBackManager::Instance().RegTaskFailCallback(regName, callback, args, type);
}

void OpTaskFailCallbackNotify(rtExceptionInfo_t *const exceptionInfo)
{
    rtBinHandle binHandle;

    if (exceptionInfo->expandInfo.type == RT_EXCEPTION_AICORE) {
        binHandle = exceptionInfo->expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.bin;
    } else if (exceptionInfo->expandInfo.type == RT_EXCEPTION_FUSION &&
        exceptionInfo->expandInfo.u.fusionInfo.type == RT_FUSION_AICORE_AICPU) {
        binHandle = exceptionInfo->expandInfo.u.fusionInfo.u.aicoreCcuInfo.exceptionArgs.exceptionKernelInfo.bin;
    } else {
        binHandle = nullptr;
    }
    
    if (binHandle == nullptr) {
        return;
    }
    
    Program *program = RtPtrToPtr<Program *>(binHandle);
    auto callback = program->opExceptionCallback_;
    void *userData = program->opExceptionCallbackUserData_;
    if (callback != nullptr) {
        RT_LOG(RT_LOG_ERROR, "excute binary exception callback, binHandle=%p, binHandle_id=%u, stream_id=%u, task_id=%u, retcode=%u",
            program, program->Id_(), exceptionInfo->streamid, exceptionInfo->taskid, exceptionInfo->retcode);
        callback(exceptionInfo, userData);
    }
}

rtError_t OpTaskFailCallbackReg(Program *binHandle, void *callback, void *userData)
{
    if (binHandle->opExceptionCallback_ != nullptr) {
        RT_LOG(RT_LOG_INFO, "the callback in the current binHandle has already been assigned, binHandle=%p, binHandle_id=%u, callback=%p",
            binHandle, binHandle->Id_(), binHandle->opExceptionCallback_);
    }

    binHandle->opExceptionCallback_ = RtPtrToPtr<rtOpExceptionCallback>(callback);
    binHandle->opExceptionCallbackUserData_ = userData;
    
    RT_LOG(RT_LOG_INFO, "reg binary exception callback success, binHandle=%p, binHandle_id=%u, callback=%p, userData=%p",
            binHandle, binHandle->Id_(), callback, userData);
    
    return RT_ERROR_NONE;
}

}  // namespace runtime
}  // namespace cce
