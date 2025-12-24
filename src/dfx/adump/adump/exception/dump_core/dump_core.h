/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef DUMP_CORE_H
#define DUMP_CORE_H

#include <vector>
#include <string>
#include "runtime/base.h"
#include "dump_args.h"
#include "dump_ELF.h"
#include "dump_common.h"
#include "register_config.h"
#include "adump_platform_api.h"
#include "kernel_info_collector.h"

namespace Adx {
constexpr uint16_t CORE_ID_BIT_MAP_SIZE = 64;
constexpr uint64_t JSON_SUFFIX_LEN = 5; // length of ".json"
constexpr uint32_t SOC_VERSION_SIZE = 50U;
constexpr uint32_t MAX_DIM_SIZE = 25U;
const std::string DEFAULT_KERNEL_NAME("unknow_kernel");

class DumpCore {
public:
    explicit DumpCore(const std::string &path, uint32_t devId) : path_(path), devId_(devId) {};
    ~DumpCore() = default;
    int32_t DumpCoreFile(const rtExceptionInfo &exception);

private:
    struct CacheParam {
        uint8_t coreType;
        uint16_t coreId;
        uint64_t memSize;
        uint64_t memAddr;
        uint32_t sectionIndex;
        rtDebugMemoryType_t cacheType;
        CacheParam() : coreType(0), coreId(0), memSize(0), memAddr(0), sectionIndex(0), cacheType(RT_MEM_TYPE_MAX) {}
        CacheParam(uint8_t type, uint16_t id, uint64_t size, uint64_t addr, uint32_t index,
            rtDebugMemoryType_t memType) : coreType(type), coreId(id), memSize(size), memAddr(addr),
            sectionIndex(index), cacheType(memType) {}
    };

    void DumpCoreInfo(uint32_t devId);

    void DumpGlobalMemory(const rtExceptionInfo &exception);
    int32_t ProcessGlobalMemory(GlobalMemInfo &memInfo, std::vector<GlobalMemInfo> &memInfoList, bool checkAddr = true);
    void DumpArgsInfo(const rtExceptionArgsInfo_t &exceptionArgsInfo, std::vector<GlobalMemInfo> &memInfoList);
    void DumpInput(const DumpArgs &args, std::vector<GlobalMemInfo> &memInfoList);
    void DumpTensorBuffer(const DumpArgs &args, std::vector<GlobalMemInfo> &memInfoList);
    void DumpWorkSpace(const DumpArgs &args, std::vector<GlobalMemInfo> &memInfoList);
    void DumpStack(const rtBinHandle &binHandle, std::vector<GlobalMemInfo> &memInfoList);
    void DumpCoreStack(const rtBinHandle &binHandle, uint8_t coreType, uint16_t coreId,
        std::vector<GlobalMemInfo> &memInfoList);
    void DumpHostKernelBin(const rtExceptionKernelInfo_t &kernelInfo);
    void DumpDeviceKernelBin(const rtExceptionKernelInfo_t &kernelInfo, std::vector<GlobalMemInfo> &memInfoList);
    void DumpHostFile(const rtExceptionArgsInfo_t &argsInfo);
    void DumpHostFile(const std::string &filePath, uint32_t sectionType, const std::string &sectionName);
    void DumpGlobalAuxInfo(const std::vector<GlobalMemInfo> &memInfoList);
    int32_t D2HMemcpyWithCheck(const GlobalMemInfo &memInfo, std::string &data) const;
    int32_t D2HMemcpyWithNoCheck(const GlobalMemInfo &memInfo, std::string &data) const;
    void DumpResourceInit();
    void DumpLocalMemory(uint8_t coreType, uint16_t coreId);
    void DumpCache(uint8_t coreType, uint16_t coreId, const std::string &sectionName,
        std::vector<LocalMemInfo> &localMemInfoList);
    void DumpCache(uint8_t coreType, uint16_t coreId, const CacheParam &cacheParam, const std::string &sectionName,
        std::vector<LocalMemInfo> &localMemInfoList);
    void DumpBuffer(uint8_t coreType, uint16_t coreId, const std::string &sectionName,
        std::vector<LocalMemInfo> &localMemInfoList);
    void DumpLocalAuxInfo(const std::string &coreIdStr, std::vector<LocalMemInfo> &localMemInfoList);
    void DumpRegister(uint8_t coreType, uint16_t coreId);
    void DumpV2Register(uint8_t coreType, uint16_t coreId);
    void DumpV2DebugRegister(uint8_t coreType, uint16_t coreId, const std::vector<RegisterTable> &tables,
        std::vector<RegInfo> &regData) const;
    void DumpV2ErrorRegister(uint8_t coreType, uint16_t coreId, const std::vector<ErrorRegisterTable> &tables,
        std::vector<RegInfo> &regData) const;
    void DumpV4Register(uint8_t coreType, uint16_t coreId);
    void DumpV4DebugRegister(uint8_t coreType, uint16_t coreId, const std::vector<RegisterTable> &tables,
        std::vector<RegInfoWide> &regData) const;
    bool DumpReadDebugAICoreRegister(uint8_t coreType, uint16_t coreId, const RegisterTable &table,
        std::string &data) const;
    std::string FormatRegisterData(const uint8_t *valAddr, uint8_t valSize) const;
    uint16_t ConvertCoreId(uint8_t coreType, uint16_t coreId) const;
    void SaveCoreFile(const rtExceptionInfo &exception);

    std::string path_;
    uint32_t devId_;
    ELF::DumpELF coreFile_;
    std::vector<uint16_t> aiCoreIds_;
    std::vector<uint16_t> aiVectorCoreIds_;
    BufferSize bufferSize_{};

    CacheParam binParam_;
    CacheParam argsParam_;
    CacheParam tilingDataParam_;
    std::vector<CacheParam> stackParamList_;
    ExceptionRegInfo exceptionRegInfo_{0, nullptr};
};
}  // namespace Adx
#endif