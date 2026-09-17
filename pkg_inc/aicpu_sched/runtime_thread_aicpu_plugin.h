/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef RUNTIME_THREAD_AICPU_PLUGIN_H
#define RUNTIME_THREAD_AICPU_PLUGIN_H

#include <cstdint>

enum class RuntimeThreadAicpuStatus : uint32_t {
    OK = 0U,
    INVALID_PARAM,
    NO_MEMORY,
    NOT_SUPPORTED,
    RUNTIME_ERROR,
    OPEN_SO_FAILED,
    SYMBOL_NOT_FOUND,
    KERNEL_FAILED,
    INTERNAL_ERROR,
};

enum class RuntimeThreadAicpuSqeSubtype : uint32_t {
    AICPU = 22U,
};

struct RuntimeThreadAicpuRuntimeHooks {
    uint32_t structSize;
    void* runtimeData;
    RuntimeThreadAicpuStatus (*reserveGroupId)(void* runtimeData, uint32_t* groupId);
    void (*releaseGroupId)(void* runtimeData, uint32_t groupId);
    RuntimeThreadAicpuStatus (*createCompletionEvent)(
        void* runtimeData, void* streamHandle, void** eventHandle, uint32_t* eventId);
    void (*destroyCompletionEvent)(void* runtimeData, void* eventHandle);
    void (*setStreamError)(
        void* runtimeData, uint32_t deviceId, uint32_t tsId, uint32_t streamId, uint32_t executeResult);
    void (*monitorThreadEnter)(void* runtimeData);
    void (*monitorThreadExit)(void* runtimeData);
    bool (*isProcessExiting)(void* runtimeData);
};

struct RuntimeThreadAicpuKernelRequest {
    uint32_t structSize;
    uint32_t kernelType;
    uint32_t blockDim;
    uint32_t deviceId;
    uint32_t tsId;
    uint32_t streamId;
    void* streamHandle;
    const char* soName;
    const char* functionName;
    const char* opType;
    const void* args;
    uint64_t argsSize;
    uint64_t cpuParamHeadOffset;
    uint32_t soNameAddrOffset;
    uint32_t kernelNameAddrOffset;
};

struct RuntimeThreadAicpuPreparedKernel {
    uint32_t structSize;
    uint32_t callbackCqId;
    uint32_t callbackGroupId;
    uint32_t eventId;
    void* eventHandle;
    uint64_t taskCookie;
    uint64_t funcPtr;
    uint64_t fnData;
};

struct RuntimeThreadAicpuPluginApi {
    uint32_t structSize;
    RuntimeThreadAicpuStatus (*prepareKernel)(
        const RuntimeThreadAicpuKernelRequest* request, RuntimeThreadAicpuPreparedKernel* preparedKernel);
    void (*releasePreparedKernel)(uint64_t taskCookie);
    void (*streamDestroyed)(void* streamHandle);
};

using RuntimeThreadAicpuGetPluginApiFunc = RuntimeThreadAicpuStatus (*)(
    const RuntimeThreadAicpuRuntimeHooks* hooks, const RuntimeThreadAicpuPluginApi** pluginApi);

extern "C" __attribute__((visibility("default"))) RuntimeThreadAicpuStatus RuntimeThreadAicpuGetPluginApi(
    const RuntimeThreadAicpuRuntimeHooks* hooks, const RuntimeThreadAicpuPluginApi** pluginApi);

#endif
