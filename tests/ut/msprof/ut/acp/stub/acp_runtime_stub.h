/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ST_REPORT_STUB_H
#define ST_REPORT_STUB_H

#include "acl/acl_prof.h"
#include "runtime/base.h"
#include "runtime/kernel.h"

extern "C" MSVP_PROF_API rtError_t rtSetDevice(int32_t devId);
extern "C" MSVP_PROF_API rtError_t rtKernelLaunch(const void *stubFunc, uint32_t blockDim, void *args,
    uint32_t argsSize, rtSmDesc_t *smDesc, rtStream_t stm);
extern "C" MSVP_PROF_API rtError_t rtKernelLaunchWithHandle(void *hdl, const uint64_t tilingKey, uint32_t blockDim,
    rtArgsEx_t *argsInfo, rtSmDesc_t *smDesc, rtStream_t stm, const void *kernelInfo);
extern "C" MSVP_PROF_API rtError_t rtKernelLaunchWithHandleV2(void *hdl, const uint64_t tilingKey, uint32_t blockDim,
    rtArgsEx_t *argsInfo, rtSmDesc_t *smDesc, rtStream_t stm, const rtTaskCfgInfo_t *cfgInfo);
extern "C" MSVP_PROF_API rtError_t rtKernelLaunchWithFlag(const void *stubFunc, uint32_t blockDim, rtArgsEx_t *argsInfo,
    rtSmDesc_t *smDesc, rtStream_t stm, uint32_t flags);
extern "C" MSVP_PROF_API rtError_t rtLaunch(const void *stubFunc);
extern "C" MSVP_PROF_API rtError_t rtDevBinaryRegister(const rtDevBinary_t *, void **);
extern "C" MSVP_PROF_API rtError_t rtDevBinaryUnRegister(void *);
extern "C" MSVP_PROF_API rtError_t rtFunctionRegister(void *, const void *, const char_t *, const void *, uint32_t);
extern "C" MSVP_PROF_API rtError_t rtRegisterAllKernel(const rtDevBinary_t *, void **);
extern "C" MSVP_PROF_API rtError_t rtGetBinaryDeviceBaseAddr(void* handle, void** launchBase);
#endif