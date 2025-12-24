/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CCE_RUNTIME_ARGS_INNNER_H
#define CCE_RUNTIME_ARGS_INNNER_H

#include <stddef.h>
#include "base.h"
#include "rts/rts.h"
#include <cstdint>

#if defined(__cplusplus)
extern "C" {
#endif

typedef struct {
    rtEngineType engineType;
    uint64_t timeout; // unit: us
    bool blockTaskPrefetch; // only use for kernel launch [tiling key sink]
    uint8_t rsv[5];
} rtTaskCfgExInfo_t;

struct TaskCfg {
    uint32_t isBaseValid;
    rtTaskCfgInfo_t base;
    uint32_t isExtendValid;
    rtTaskCfgExInfo_t extend;
};

struct ParaDetail {
    uint32_t type : 1; // 0：normal; 1:place holder
    uint32_t rsv : 31;
    size_t paraOffset;
    size_t paraSize;
    size_t dataOffset; // 仅place holder时有效
};

struct CpuKernelSysArgsInfo {
    size_t kernelNameOffset;
    size_t kernelNameSize;
    size_t soNameOffset;
    size_t soNameSize;
};

struct RtArgsHandle {
    void *buffer;
    size_t bufferSize; // buffer总大小
    size_t sysParamSize;
    size_t argsSize; // 当前实际args占用大小，即将来要进行H2D搬运的大小 = args table + place holder指向的数据区大小
    CpuKernelSysArgsInfo cpuKernelSysArgsInfo; // user for cpu kernel launch
    void *funcHandle;
    bool isGotPhBuff;
    bool isProcessedOverflow;
    uint8_t placeHolderNum;
    uint8_t realUserParamNum;
    uint8_t maxUserParamNum;
    uint8_t isFinalized : 1;
    uint8_t isParamUpdating : 1;
    uint8_t rsv1 : 6;
    uint8_t rsv2[2];
    ParaDetail para[0];
};

enum ArgsType : int32_t {
    RT_ARGS_NON_CPU_EX = 1,
    RT_ARGS_CPU_EX,
    RT_ARGS_HANDLE,
    RT_ARGS_MAX
};

struct RtArgsWithType {
    ArgsType type;
    union {
        rtArgsEx_t *nonCpuArgsInfo;
        rtCpuKernelArgs_t *cpuArgsInfo;
        RtArgsHandle *argHandle;
    } args;
};

#if defined(__cplusplus)
}
#endif

#endif  // CCE_RUNTIME_KERNEL_H