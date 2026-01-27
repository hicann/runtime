/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef __CCE_RUNTIME_STREAM_C_HPP__
#define __CCE_RUNTIME_STREAM_C_HPP__

#include "stream_david.hpp"
#include "program.hpp"
#include "starsv2_base.hpp"
namespace cce {
namespace runtime {
    rtError_t StreamLaunchKernelPrepare(const Stream * const stm, Kernel *&registeredKernel, Program *&prog,
        uint32_t &kernelType, Module *&mdl, const void * const stubFunc, uint64_t &addr1, uint64_t &addr2,
        void * const progHandle, const uint64_t tilingKey);
    void StreamLaunchKernelRecycle(DavidArgLoaderResult &result, TaskInfo *&recycleTask, const Program * const prog, Stream *stm);

    rtError_t StreamCCULaunch(Stream *stm, rtCcuTaskInfo_t *taskInfo);

    rtError_t CmoTaskLaunchForDavid(const rtCmoTaskInfo_t * const taskInfo, Stream * const stm, const uint32_t flag);
    rtError_t CmoAddrTaskLaunchForDavid(rtDavidCmoAddrInfo * const cmoAddrInfo, const rtCmoOpCode_t cmoOpCode,
                                     Stream * const stm);
    rtError_t CallbackLaunchForDavidWithBlock(const rtCallback_t callBackFunc, void * const fnData, Stream * const stm);
    rtError_t CallbackLaunchForDavidNoBlock(const rtCallback_t callBackFunc, void * const fnData, Stream * const stm);
    rtError_t StreamDatadumpInfoLoad(const void * const dumpInfo, const uint32_t length, Stream * const dftStm);
    rtError_t StreamDebugRegister(Stream * const debugStream, const uint32_t flag, const void * const addr,
        uint32_t * const streamId, uint32_t * const taskId);
    rtError_t StreamDebugUnRegister(Stream * const debugStream);
    rtError_t StreamNpuGetFloatStatus(void * const outputAddrPtr, const uint64_t outputSize, const uint32_t checkMode,
        Stream * const stm, bool isDebug = false);
    rtError_t StreamNpuClearFloatStatus(const uint32_t checkMode, Stream * const stm, bool isDebug = false);
    rtError_t StreamGetSatStatus(const uint64_t outputSize, Stream * const curStm);
    rtError_t SyncGetDeviceMsg(Device * const dev, const void * const devMemAddr, const uint32_t devMemSize,
        const rtGetDevMsgType_t getDevMsgType);
    rtError_t SetOverflowSwitchOnStream(Stream * const stm, const uint32_t flags);
    rtError_t SetTagOnStream(Stream * const stm, const uint32_t geOpTag);
    rtError_t StreamUbDbSend(const rtUbDbInfo_t * const dbInfo, Stream * const stm);
    rtError_t StreamUbDirectSend(rtUbWqeInfo_t * const wqeInfo, Stream * const stm);

    rtError_t StreamNopTask(Stream * const stm);
    rtError_t StreamAicpuInfoLoad(Stream * const dftStm, const void * const aicpuInfo, const uint32_t length);

    rtError_t SetTimeoutConfigTaskSubmitDavid(Stream * const stm, const rtTaskTimeoutType_t type, const uint32_t timeout);

    rtError_t StreamWriteValue(rtWriteValueInfo_t * const info, Stream * const stm);
    rtError_t StreamWriteValuePtr(const rtWriteValueInfo_t * const writeValueInfo, Stream * const stm,
                                  void * const pointedAddr);
    rtError_t UpdateTimeoutConfigTaskSubmitDavid(Stream * const stm, const RtTimeoutConfig &timeoutConfig);
    void StreamLaunchKernelRecycleAicpu(DavidArgLoaderResult &result, TaskInfo *&recycleTask, const Program * const prog, Stream *stm);
    rtError_t SendTopicMsgVersionToAicpuDavid(Stream * const stm);

    template<typename T>
    bool UseArgsPool(DavidStream *const davidStm, const T *argsInfo, bool taskGroupFlag)
    {
        if ((!davidStm->GetIsHasArgPool()) || (argsInfo->argsSize > STM_ARG_POOL_COPY_SIZE) || (davidStm->IsCapturing()) ||
            taskGroupFlag) {
            return false;
        }
        return true;
    }
}  // namespace runtime
}  // namespace cce

#endif