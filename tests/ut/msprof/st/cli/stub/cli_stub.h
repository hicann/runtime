/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CLI_STUB_H
#define CLI_STUB_H
#include "mmpa_api.h"
#include "msprof_stub.h"
#include "acl/acl_prof.h"
#include "runtime/base.h"
#include "runtime/kernel.h"
#include "acl/acl.h"
#include "runtime/mem.h"

INT32 mmCreateProcessStub(const CHAR* fileName, const mmArgvEnv *env, const CHAR* stdoutRedirectFile, mmProcess *id);
INT32 mmCreateProcessAcpStub(const CHAR* fileName, const mmArgvEnv *env, const CHAR* stdoutRedirectFile, mmProcess *id);
int32_t PerfSimulator(std::string argv0, std::string argv1, std::string argv2, const CHAR* stdoutRedirectFile);
int32_t Application(int32_t argc, char *argv[], int32_t envc, char*envp[]);
int32_t ApplicationAcp(int32_t argc, char *argv[], int32_t envc, char*envp[]);
uint32_t GetDynParams(const std::string str, std::string &env, int32_t envc, char * envp[]);

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
extern "C" MSVP_PROF_API rtError_t rtMalloc(void **devPtr, uint64_t size, rtMemType_t type, const uint16_t moduleId);
extern "C" MSVP_PROF_API rtError_t rtFree(void *devPtr);
bool executeStub();

#endif
