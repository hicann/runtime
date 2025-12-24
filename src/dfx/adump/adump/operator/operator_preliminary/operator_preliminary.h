/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef OPERATOR_PRELIMINARY_H
#define OPERATOR_PRELIMINARY_H
#include <string>
#include <vector>
#include <memory>
#include "dump_setting.h"
#include "runtime/base.h"

namespace Adx {
constexpr uint32_t FILE_NAME_MAX = 32;
constexpr uint32_t SOC_VERSION_LEN = 50U;

struct OperatorData {
    aclrtStream deviceStm   = nullptr;
    void *pcAddr           = nullptr;
    rtBinHandle binHandle  = nullptr;
    void *memoryAddr       = nullptr;
    bool setDevice         = false;
    uint64_t msgQSize      = 0;
    uint64_t outputSize    = 0;
    uint64_t workspaceSize = 0;
    uint64_t stackBaseSize = 0;
    int32_t streamId       = 0;
    uint32_t sqId          = 0;
    uint32_t cqIds         = 0;
    uint32_t logicCqIds    = 0;
    uint64_t ubSize        = 0;
    uint32_t aiCoreCnt     = 0;
    uint32_t vectCoreCnt   = 0;
};

struct KfcDumpWorkSpace {
    uint64_t msgQ; //消息队列头指针
    uint64_t msgQSize; // 地址大小
    uint64_t output; //aiv计算用的output头指针
    uint64_t outputSize;
    uint64_t workspace; //aiv计算用的workspace头指针
    uint64_t workspaceSize;
    uint64_t stackBase;
    uint64_t stackBaseSize; // 32k处理空间
};

struct KfcDumpOpConfig {
    uint64_t aiCoreNum;
    uint64_t vectorCoreNum;
    uint64_t ubSize;
    uint64_t dumpStatPcAddr;  // dump算子入口地址
    uint64_t statsType; // 统计项比特位
    uint64_t chipType;
};

struct KfcDumpStreamInfo {
    int32_t streamId;
    uint32_t sqIds;
    uint32_t cqIds;   // 记录物理cqId
    uint32_t logicCqIds; // 记录逻辑cqId
    uint32_t deviceId;
    uint32_t res;
};

struct KfcDumpOpInitParam {
    KfcDumpWorkSpace kfcWorkSpace;
    KfcDumpOpConfig config; // 配置参数
    KfcDumpStreamInfo streamInfo;
    char soName[FILE_NAME_MAX] = "libaicpu_extend_kernels.so";
    char kernelName[FILE_NAME_MAX] = "AicpuKfcDumpSrvInit";
};

extern const std::map<PlatformType, std::string> BIN_NAME_MAP;

class OperatorPreliminary {
public:
    OperatorPreliminary(const DumpSetting &setting, const uint32_t deviceId);
    ~OperatorPreliminary();
    int32_t OperatorInit();

private:
    uint64_t CalcWorkspaceSize(uint64_t statsCnt);
    uint64_t CalcStackSize() const;
    std::string GetBinName() const;
    int32_t GetStreamInfo();
    int32_t GetUBSizeAndCoreNum();
    std::unique_ptr<char[]> LoadBinFile(const std::string &filename, size_t &fileSize) const;
    int32_t GetOperatorPCAddr();
    int32_t CreateMemory();
    int32_t KFCKernelLaunch();
    uint32_t deviceId_;
    DumpSetting setting_;
    OperatorData opData_;
};
} // namespace Adx
#endif // OPERATOR_PRELIMINARY_H