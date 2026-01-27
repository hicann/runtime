/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "runtime/rt.h"
//@@@split for klee@@@
using namespace std;
//@@@split for klee@@@
rtError_t rtCtxCreate(rtContext_t *ctx, uint32_t flags, int32_t device);

rtError_t rtCtxDestroy(rtContext_t ctx);

rtError_t rtCtxSetCurrent(rtContext_t ctx);

rtError_t rtCtxSynchronize(void);

rtError_t rtCtxGetCurrent(rtContext_t *ctx);

rtError_t rtCtxGetDevice(int32_t *device);

rtError_t rtGetDeviceCount(int32_t *count);

rtError_t rtSetDevice(int32_t device);

rtError_t rtGetDevice(int32_t *device);

rtError_t rtDeviceReset(void);

rtError_t rtDeviceSynchronize(void);

rtError_t rtDeviceGetStreamPriorityRange(int32_t *leastPriority, int32_t *greatestPriority);

rtError_t rtEventCreate(rtEvent_t *event);

rtError_t rtEventDestroy(rtEvent_t event);

rtError_t rtEventRecord(rtEvent_t event, rtStream_t stream);

rtError_t rtMultiDevEventRecord(rtEvent_t event_, rtStream_t stream_, int32_t *listeners, uint32_t count);

rtError_t rtEventSynchronize(rtEvent_t event);

rtError_t rtEventQuery(rtEvent_t event);

rtError_t rtEventElapsedTime(float *time, rtEvent_t start, rtEvent_t end);

rtError_t rtDevBinaryRegister(const rtDevBinary_t *bin, void **handle);

rtError_t rtDevBinaryUnRegister(void *handle);

rtError_t rtFunctionRegister(void *binHandle, const void *stubFunc, const char *stubName, const void *devFunc, uint32_t funcMode);

rtError_t rtKernelConfigDump(uint32_t kind, uint32_t dumpSizePerBlock, uint32_t blockDim, void **dumpBaseAddr);

rtError_t rtKernelLaunch(const void *stubFunc, uint32_t blockDim, void *args, uint32_t argsSize, rtSmDesc_t *smDesc, rtStream_t stream);

rtError_t rtConfigureCall(uint32_t numBlocks, rtSmDesc_t *smDesc = nullptr, rtStream_t stream = nullptr);

rtError_t rtSetupArgument(const void *arg, uint32_t size, uint32_t offset);

rtError_t rtLaunch(const void *stubFunc);

rtError_t rtKernelConfigTransArg(const void *ptr, uint64_t size, uint32_t flag, void** arg);

rtError_t rtMemGetInfo(size_t *free, size_t *total);

rtError_t rtMemGetInfoEx(rtMemInfoType_t memInfoType, size_t *free, size_t *total);

rtError_t rtMalloc(void **devPtr, uint64_t size, rtMemType_t type, const uint16_t moduleid);

rtError_t rtFree(void *devPtr);

rtError_t rtMallocHost(void **hostPtr,  uint64_t size, const uint16_t moduleid);

rtError_t rtFreeHost(void *hostPtr);

rtError_t rtMallocHostSharedMemory(rtMallocHostSharedMemoryIn *in, rtMallocHostSharedMemoryOut *out);

rtError_t rtFreeHostSharedMemory(rtFreeHostSharedMemoryIn *in);

rtError_t rtMemAllocManaged(void **ptr, uint64_t size, uint32_t flag, const uint16_t moduleid);

rtError_t rtMemFreeManaged(void *ptr);

rtError_t rtMemcpy(void *dst, uint64_t destMax, void *src, uint64_t count, rtMemcpyKind_t kind);

rtError_t rtMemcpyAsync(void *dst, uint64_t destMax, void *src, uint64_t count, rtMemcpyKind_t kind, rtStream_t stream);

rtError_t rtMemcpyAsyncPtr(void *memcpyAddrInfo, uint64_t destMax, uint64_t count,
                           rtMemcpyKind_t kind, rtStream_t stream);

rtError_t rtStreamCreate(rtStream_t *stream, int32_t priority);

rtError_t rtStreamDestroy(rtStream_t stream);

rtError_t rtStreamWaitEvent(rtStream_t stream, rtEvent_t event);

rtError_t rtStreamSynchronize(rtStream_t stream);

rtError_t rtStreamQuery(rtStream_t stream);

rtError_t rtGetAddrByFun(const void *stubFunc, uint64_t **addr);

rtError_t rtDebugRegister(rtModel_t model, uint32_t flag, const void *addr, uint32_t *streamId, uint32_t *taskId);

rtError_t rtDebugUnRegister(rtModel_t model);
