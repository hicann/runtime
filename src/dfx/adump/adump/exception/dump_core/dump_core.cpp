/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <map>
#include "adump_pub.h"
#include "log/adx_log.h"
#include "runtime/mem.h"
#include "adump_dsmi.h"
#include "sys_utils.h"
#include "path.h"
#include "exception_info_common.h"
#include "dump_core.h"

namespace Adx {
int32_t DumpCore::DumpCoreFile(const rtExceptionInfo &exception)
{
    DumpCoreInfo(exception.deviceid);
    KernelInfoCollector::DumpKernelErrorSymbols(exception, exceptionRegInfo_);
    DumpGlobalMemory(exception);
    DumpResourceInit();

    for (uint16_t aicId : aiCoreIds_) {
        DumpLocalMemory(CORE_TYPE_AIC, aicId);
        DumpRegister(CORE_TYPE_AIC, aicId);
    }
    for (uint16_t aivId : aiVectorCoreIds_) {
        DumpLocalMemory(CORE_TYPE_AIV, aivId);
        DumpRegister(CORE_TYPE_AIV, aivId);
    }

    SaveCoreFile(exception);

    return ADUMP_SUCCESS;
}

void DumpCore::DumpGlobalMemory(const rtExceptionInfo &exception)
{
    std::vector<GlobalMemInfo> memInfoList;

    rtExceptionArgsInfo_t exceptionArgsInfo{};
    rtExceptionExpandType_t exceptionTaskType = exception.expandInfo.type;
    if (ExceptionInfoCommon::GetExceptionInfo(exception, exceptionTaskType, exceptionArgsInfo) != ADUMP_SUCCESS) {
        IDE_LOGE("Get exception args info failed.");
        return;
    }
    DumpArgsInfo(exceptionArgsInfo, memInfoList);

    DumpArgs args;
    if (args.LoadArgsExceptionInfo(exception) == ADUMP_SUCCESS) {
        if (args.DumpArgsDumpWithDfxFlag()) {
            DumpTensorBuffer(args, memInfoList);
            DumpWorkSpace(args, memInfoList);
        } else {
            DumpInput(args, memInfoList);
        }
    }

    DumpStack(exceptionArgsInfo.exceptionKernelInfo.bin, memInfoList);
    DumpDeviceKernelBin(exceptionArgsInfo.exceptionKernelInfo, memInfoList);
    DumpGlobalAuxInfo(memInfoList);

    DumpHostKernelBin(exceptionArgsInfo.exceptionKernelInfo);
    DumpHostFile(exceptionArgsInfo);
}

void DumpCore::DumpResourceInit()
{
    char version[SOC_VERSION_SIZE] = {0};
    rtError_t ret = rtGetSocVersion(version, SOC_VERSION_SIZE);
    IDE_CTRL_VALUE_FAILED(ret == RT_ERROR_NONE, return, "Failed to get soc version");
    const std::string socVersion(version);

    IDE_CTRL_VALUE_FAILED(AdumpPlatformApi::GetAicoreSizeInfo(socVersion, bufferSize_),
        return, "Failed to read platform info from fe api.");
    IDE_LOGD("Get local buffer size: L0A: %llu, L0B: %llu, L0C: %llu, L1: %llu, UB: %llu",
        bufferSize_.l0aSize, bufferSize_.l0bSize, bufferSize_.l0cSize, bufferSize_.l1Size, bufferSize_.ubSize);
}

void DumpCore::DumpCoreInfo(uint32_t devId)
{
    std::string data(sizeof(DevInfo), 0);
    DevInfo *devInfo = reinterpret_cast<DevInfo *>(const_cast<char *>(data.data()));
    devInfo->devId = devId;
    IDE_CTRL_VALUE_FAILED(AdumpDsmi::DrvGetPlatformType(devInfo->devType), return, "Get platform type failed.");

    rtError_t ret = rtDebugGetStalledCore(&devInfo->coreInfo);
    IDE_CTRL_VALUE_FAILED(ret == RT_ERROR_NONE, return, "Get core id failed, ret: %d", ret);
    IDE_LOGD("get core info: aicBitmap: 0x%llx 0x%llx, aivBitmap: 0x%llx 0x%llx",  devInfo->coreInfo.aicBitmap0,
        devInfo->coreInfo.aicBitmap1, devInfo->coreInfo.aivBitmap0, devInfo->coreInfo.aivBitmap1);

    for (uint16_t i = 0; i < CORE_ID_BIT_MAP_SIZE; ++i) {
        if ((devInfo->coreInfo.aicBitmap0 & (1ULL << i)) != 0) {
            aiCoreIds_.emplace_back(i);
        }
        if ((devInfo->coreInfo.aicBitmap1 & (1ULL << i)) != 0) {
            aiCoreIds_.emplace_back(i + CORE_ID_BIT_MAP_SIZE);
        }
        if ((devInfo->coreInfo.aivBitmap0 & (1ULL << i)) != 0) {
            aiVectorCoreIds_.emplace_back(i);
        }
        if ((devInfo->coreInfo.aivBitmap1 & (1ULL << i)) != 0) {
            aiVectorCoreIds_.emplace_back(i + CORE_ID_BIT_MAP_SIZE);
        }
    }

    ELF::SectionPtr devtbl = coreFile_.AddSection(ASCEND_SHTYPE_DEVTBL, ASCEND_SHNAME_DEVTBL);
    IDE_CTRL_VALUE_FAILED(devtbl != nullptr, return, "Create %s section failed.", ASCEND_SHNAME_DEVTBL.c_str());
    devtbl->SetData(data);
}

void DumpCore::DumpLocalMemory(uint8_t coreType, uint16_t coreId)
{
    std::string coreIdStr =  std::to_string(ConvertCoreId(coreType, coreId));
    std::string sectionName = ASCEND_SHNAME_LOCAL + "." + coreIdStr;
    std::vector<LocalMemInfo> localMemInfoList;

    DumpBuffer(coreType, coreId, sectionName, localMemInfoList);
    DumpCache(coreType, coreId, sectionName, localMemInfoList);
    DumpLocalAuxInfo(coreIdStr, localMemInfoList);
}

void DumpCore::DumpCache(uint8_t coreType, uint16_t coreId, const std::string &sectionName,
    std::vector<LocalMemInfo> &localMemInfoList)
{
    // icache
    DumpCache(coreType, coreId, binParam_, sectionName, localMemInfoList);

    // dcache
    DumpCache(coreType, coreId, argsParam_, sectionName, localMemInfoList);
    DumpCache(coreType, coreId, tilingDataParam_, sectionName, localMemInfoList);

    for (const auto &stackParam : stackParamList_) {
        if (stackParam.coreType == coreType && stackParam.coreId == coreId) {
            DumpCache(coreType, coreId, stackParam, sectionName, localMemInfoList);
        }
    }
}

void DumpCore::DumpCache(uint8_t coreType, uint16_t coreId, const CacheParam &cacheParam, const std::string &sectionName,
    std::vector<LocalMemInfo> &localMemInfoList)
{
    if (cacheParam.memSize == 0) {
        return;
    }
    std::string cacheData(cacheParam.memSize, 0);
    rtDebugMemoryParam_t param =
        {coreType, 0, coreId, cacheParam.cacheType, 0, 0, cacheParam.memAddr, 0, cacheParam.memSize};
    param.dstAddr = reinterpret_cast<uint64_t>(cacheData.data());
    rtError_t ret = rtDebugReadAICore(&param);
    IDE_CTRL_VALUE_FAILED(ret == RT_ERROR_NONE, return, "Failed to copy icache data from device, ret: %d", ret);

    ELF::SectionPtr localSec = coreFile_.AddSection(ASCEND_SHTYPE_LOCAL, sectionName);
    IDE_CTRL_VALUE_FAILED(localSec != nullptr, return, "Create %s section failed.", sectionName.c_str());

    LocalMemInfo localMemInfo = {param.memLen, localSec->GetIndex(), cacheParam.sectionIndex, param.debugMemType, 0};
    localMemInfoList.emplace_back(localMemInfo);
    localSec->SetData(cacheData);
    localSec->SetInfo(localMemInfoList.size() - 1);

    IDE_LOGD("Dump cache data success, core type: %hhu, core id: %hu, cache type: %d, addr: %llx, size: %llu",
        coreType, coreId, cacheParam.cacheType, cacheParam.memAddr, cacheParam.memSize);
}

void DumpCore::DumpBuffer(uint8_t coreType, uint16_t coreId, const std::string &sectionName,
    std::vector<LocalMemInfo> &localMemInfoList)
{
    std::vector<rtDebugMemoryParam_t> memParamList = {
        { CORE_TYPE_AIC, 0, coreId, RT_MEM_TYPE_L0A, 0, 0, 0, 0, bufferSize_.l0aSize },
        { CORE_TYPE_AIC, 0, coreId, RT_MEM_TYPE_L0B, 0, 0, 0, 0, bufferSize_.l0bSize },
        { CORE_TYPE_AIC, 0, coreId, RT_MEM_TYPE_L0C, 0, 0, 0, 0, bufferSize_.l0cSize },
        { CORE_TYPE_AIC, 0, coreId, RT_MEM_TYPE_L1, 0, 0, 0, 0, bufferSize_.l1Size },
        { CORE_TYPE_AIV, 0, coreId, RT_MEM_TYPE_UB, 0, 0, 0, 0, bufferSize_.ubSize },
    };
    for (auto &memParam : memParamList) {
        if (memParam.coreType != coreType) {
            continue;
        }
        // memLen zero check
        std::string localData(memParam.memLen, 0);
        memParam.dstAddr = reinterpret_cast<uint64_t>(localData.data());

        rtError_t ret = rtDebugReadAICore(&memParam);
        IDE_CTRL_VALUE_FAILED_NODO(ret == RT_ERROR_NONE, continue, "Failed to copy data from device, ret: %d", ret);

        ELF::SectionPtr localSec = coreFile_.AddSection(ASCEND_SHTYPE_LOCAL, sectionName);
        IDE_CTRL_VALUE_FAILED_NODO(localSec != nullptr, continue, "Create %s section failed.", sectionName.c_str());

        LocalMemInfo localMemInfo = {memParam.memLen, localSec->GetIndex(), 0, memParam.debugMemType, 0};
        localMemInfoList.emplace_back(localMemInfo);
        localSec->SetData(localData);
        localSec->SetInfo(localMemInfoList.size() - 1);

        IDE_LOGD("Dump local memory success, core type: %hhu, core id: %hu, type: %d, size: %llu",
            coreType, coreId, memParam.debugMemType, memParam.memLen);
    }
}

void DumpCore::DumpLocalAuxInfo(const std::string &coreIdStr, std::vector<LocalMemInfo> &localMemInfoList)
{
    if (localMemInfoList.empty()) {
        return;
    }

    size_t totalSize = localMemInfoList.size() * sizeof(LocalMemInfo);
    std::string localData(reinterpret_cast<const char *>(localMemInfoList.data()), totalSize);

    std::string sectionName = ASCEND_SHNAME_AUXINFO_LOCAL + "." + coreIdStr;
    ELF::SectionPtr localSec = coreFile_.AddSection(ASCEND_SHTYPE_AUXINFO_LOCAL, sectionName);
    IDE_CTRL_VALUE_FAILED(localSec != nullptr, return, "Create %s section failed.", sectionName.c_str());

    localSec->SetData(localData);
    localSec->SetEntSize(sizeof(LocalMemInfo));
    for (const LocalMemInfo &localMemInfo : localMemInfoList) {
        ELF::SectionPtr sec = coreFile_.GetSectionByIndex(localMemInfo.sectionIndex);
        IDE_CTRL_VALUE_FAILED_NODO(sec != nullptr, continue, "Get section by index failed, index: %u",
            localMemInfo.sectionIndex);
        sec->SetLink(localSec->GetIndex());
    }
}

void DumpCore::SaveCoreFile(const rtExceptionInfo &exception)
{
    std::string kernelName;
    rtExceptionArgsInfo_t exceptionArgsInfo{};
    rtExceptionExpandType_t exceptionTaskType = exception.expandInfo.type;
    if (ExceptionInfoCommon::GetExceptionInfo(exception, exceptionTaskType, exceptionArgsInfo) != ADUMP_SUCCESS) {
        IDE_LOGE("Get exception args info failed.");
        kernelName = DEFAULT_KERNEL_NAME;
    } else {
        std::string rtKernelName(exceptionArgsInfo.exceptionKernelInfo.kernelName,
            exceptionArgsInfo.exceptionKernelInfo.kernelNameSize);
        kernelName = rtKernelName.empty() ? DEFAULT_KERNEL_NAME : rtKernelName;
    }
    std::string dumpFileName = kernelName + "." + std::to_string(exception.streamid) + "." +
        std::to_string(exception.taskid) + "." + SysUtils::GetCurrentTimeWithMillisecond() + ".core";
    // File names should not exceed the filesystem limits.
    dumpFileName = dumpFileName.length() > 255U ? dumpFileName.substr(dumpFileName.length() - 255U) : dumpFileName;
    Path dumpFilePath(path_);
    IDE_CTRL_VALUE_FAILED(dumpFilePath.RealPath(), return, "Get path %s real path failed, strerr=%s.",
        dumpFilePath.GetCString(), strerror(errno));
    std::string dir = dumpFilePath.GetString();
    dumpFilePath.Concat(dumpFileName);
    IDE_CTRL_VALUE_FAILED(dumpFilePath.ParentPath().GetString() == dir, return,
        "Check dump file path %s failed.", dumpFilePath.GetCString());
    coreFile_.Save(dumpFilePath.GetString());
}

int32_t DumpCore::D2HMemcpyWithNoCheck(const GlobalMemInfo &memInfo, std::string &data) const
{
    std::vector<char> buffer(memInfo.size);
    rtError_t rtRet = rtMemcpyEx(static_cast<void *>(buffer.data()), memInfo.size,
        reinterpret_cast<void *>(memInfo.devAddr), memInfo.size, RT_MEMCPY_DEVICE_TO_HOST);
    if (rtRet != RT_ERROR_NONE) {
        IDE_LOGE("Call rtMemcpyEx failed, data type: %d, addr: 0x%llx, size: %llu, ret: %d",
            static_cast<int32_t>(memInfo.type), memInfo.devAddr, memInfo.size, rtRet);
        return ADUMP_FAILED;
    } else {
        data.assign(buffer.data(), memInfo.size);
    }
    return ADUMP_SUCCESS;
}

int32_t DumpCore::D2HMemcpyWithCheck(const GlobalMemInfo &memInfo, std::string &data) const
{
    rtMemInfo_t info{};
    uint64_t *deviceAddr[1] = {reinterpret_cast<uint64_t *>(memInfo.devAddr)};
    info.addrInfo.addr = static_cast<uint64_t **>(deviceAddr);
    info.addrInfo.cnt = 1;
    info.addrInfo.memType = RT_MEM_MASK_DEV_TYPE | RT_MEM_MASK_RSVD_TYPE;
    info.addrInfo.flag = true;
    rtError_t rtRet = rtMemGetInfoByType(static_cast<int32_t>(devId_), RT_MEM_INFO_TYPE_ADDR_CHECK, &info);
    if ((rtRet != RT_ERROR_NONE) || (info.addrInfo.flag == false)) {
        IDE_LOGE("Check global memory addr 0x%llx invalid", memInfo.devAddr);
        return ADUMP_FAILED;
    }

    std::vector<char> buffer(memInfo.size);
    rtRet = rtMemcpy(static_cast<void *>(buffer.data()), memInfo.size,
        reinterpret_cast<void *>(memInfo.devAddr), memInfo.size, RT_MEMCPY_DEVICE_TO_HOST);
    if (rtRet != RT_ERROR_NONE) {
        IDE_LOGE("Call rtMemcpy failed, data type: %d, addr: 0x%llx, size: %llu, ret: %d",
            static_cast<int32_t>(memInfo.type), memInfo.devAddr, memInfo.size, rtRet);
        return ADUMP_FAILED;
    } else {
        data.assign(buffer.data(), memInfo.size);
    }
    return ADUMP_SUCCESS;
}

int32_t DumpCore::ProcessGlobalMemory(GlobalMemInfo &memInfo, std::vector<GlobalMemInfo> &memInfoList, bool checkAddr)
{
    std::string curData(memInfo.size, 0);
    if (memInfo.size != 0) {
        if (checkAddr) {
            if (D2HMemcpyWithCheck(memInfo, curData) != ADUMP_SUCCESS) {
                memInfo.size |= INVALID_DATA_FLAG;
            }
        } else {
            if (D2HMemcpyWithNoCheck(memInfo, curData) != ADUMP_SUCCESS) {
                memInfo.size |= INVALID_DATA_FLAG;
            }
        }
    }

    ELF::SectionPtr curSection = coreFile_.AddSection(ASCEND_SHTYPE_GLOBAL, ASCEND_SHNAME_GLOBAL);
    IDE_CTRL_VALUE_FAILED(curSection != nullptr, return ADUMP_FAILED, "Create %s section failed.",
        ASCEND_SHNAME_GLOBAL.c_str());

    memInfo.sectionIndex = curSection->GetIndex();
    memInfoList.emplace_back(memInfo);
    curSection->SetInfo(memInfoList.size() - 1);
    curSection->SetData(curData);
    curSection->SetAddr(memInfo.devAddr);
    return ADUMP_SUCCESS;
}

void DumpCore::DumpArgsInfo(const rtExceptionArgsInfo_t &exceptionArgsInfo, std::vector<GlobalMemInfo> &memInfoList)
{
    GlobalMemInfo memInfo = {
        .devAddr = reinterpret_cast<uint64_t>(exceptionArgsInfo.argAddr),
        .size = exceptionArgsInfo.argsize,
        .sectionIndex = 0,
        .type = DfxTensorType::ARGS,
        .reserve = 0,
        .extraInfo = {.coreInfo = {.coreId = 0}}
    };

    int32_t ret = ProcessGlobalMemory(memInfo, memInfoList);
    IDE_CTRL_VALUE_FAILED(ret == ADUMP_SUCCESS, return, "Save args to section failed.");
    argsParam_ = {0, 0, exceptionArgsInfo.argsize, memInfo.devAddr, memInfo.sectionIndex, RT_MEM_TYPE_DCACHE};
}

void DumpCore::DumpInput(const DumpArgs &args, std::vector<GlobalMemInfo> &memInfoList)
{
    const std::vector<InputBuffer> inputBuffer = args.DumpArgsGetInputBuffer();
    int32_t ret = 0;
    for (const auto &input : inputBuffer) {
        if (input.addr == nullptr) {         // skip placeholder tensor
            continue;
        }
        GlobalMemInfo memInfo = {
            .devAddr = reinterpret_cast<uint64_t>(input.addr),
            .size = input.length,
            .sectionIndex = 0,
            .type = DfxTensorType::INPUT_TENSOR,
            .reserve = 0,
            .extraInfo = {.shape = {.dim = 0, .dimSize = {0}}}
        };

        ret = ProcessGlobalMemory(memInfo, memInfoList);
        IDE_CTRL_VALUE_FAILED_NODO(ret == ADUMP_SUCCESS, continue,
            "Save input to section failed, addr: 0x%llx, size: %llu", memInfo.devAddr, memInfo.size);
    }
}

void DumpCore::DumpTensorBuffer(const DumpArgs &args, std::vector<GlobalMemInfo> &memInfoList)
{
    const std::vector<TensorBuffer> tensorBuffer = args.DumpArgsGetTensorBuffer();
    int32_t ret = 0;
    for (const auto &tensor : tensorBuffer) {
        if (tensor.addr == nullptr) {       // skip placeholder tensor
            continue;
        }
        IDE_CTRL_VALUE_FAILED_NODO(tensor.dimension < MAX_DIM_SIZE, continue,
            "Invalid dimension %llu, addr: %p, arg index: %u, tensor type %hu, pointer type: %hu",
            tensor.dimension, tensor.addr, tensor.argIndex, tensor.tensorType, tensor.pointerType);

        GlobalMemInfo memInfo = {
            .devAddr = reinterpret_cast<uint64_t>(tensor.addr),
            .size = tensor.GetTotalByteSize(),
            .sectionIndex = 0,
            .type = static_cast<DfxTensorType>(tensor.tensorType),
            .reserve = 0,
            .extraInfo = {.shape = {.dim = static_cast<uint32_t>(tensor.dimension), .dimSize = {0}}}
        };
        for (uint32_t i = 0; i < memInfo.extraInfo.shape.dim; ++i) {
            memInfo.extraInfo.shape.dimSize[i] = tensor.shape[i];
        }
        ret = ProcessGlobalMemory(memInfo, memInfoList);
        IDE_CTRL_VALUE_FAILED_NODO(ret == ADUMP_SUCCESS, continue,
            "Save tensor to section failed, addr: 0x%llx, size: %llu, type: %hu",
            memInfo.devAddr, memInfo.size, memInfo.type);

        if (tensor.tensorType == DfxTensorType::TILING_DATA) {
            tilingDataParam_ = {0, 0, memInfo.size, memInfo.devAddr, memInfo.sectionIndex, RT_MEM_TYPE_DCACHE};
        }
    }
}

void DumpCore::DumpWorkSpace(const DumpArgs &args, std::vector<GlobalMemInfo> &memInfoList)
{
    const std::vector<DumpWorkspace> workSpace = args.DumpArgsGetWorkSpace();
    int32_t ret = 0;
    for (const auto &ws : workSpace) {
        GlobalMemInfo memInfo = {
            .devAddr = reinterpret_cast<uint64_t>(ws.addr),
            .size = ws.bytes,
            .sectionIndex = 0,
            .type = DfxTensorType::WORKSPACE_TENSOR,
            .reserve = 0,
            .extraInfo = {.shape = {.dim = 0, .dimSize = {0}}}
        };

        ret = ProcessGlobalMemory(memInfo, memInfoList);
        IDE_CTRL_VALUE_FAILED_NODO(ret == ADUMP_SUCCESS, continue,
            "Save input to section failed, addr: 0x%llx, size: %llu", memInfo.devAddr, memInfo.size);
    }
}

void DumpCore::DumpStack(const rtBinHandle &binHandle, std::vector<GlobalMemInfo> &memInfoList)
{
    for (uint16_t aicId : aiCoreIds_) {
        DumpCoreStack(binHandle, CORE_TYPE_AIC, aicId, memInfoList);
    }
    for (uint16_t aivId : aiVectorCoreIds_) {
        DumpCoreStack(binHandle, CORE_TYPE_AIV, aivId, memInfoList);
    }
}

void DumpCore::DumpCoreStack(const rtBinHandle &binHandle, uint8_t coreType, uint16_t coreId,
    std::vector<GlobalMemInfo> &memInfoList)
{
    const void *stackAddr = nullptr;
    uint32_t stackSize = 0;
    rtError_t rtRet = rtGetStackBuffer(binHandle, coreType, coreId, &stackAddr, &stackSize);
    if ((rtRet != RT_ERROR_NONE) || (stackAddr == nullptr)) {
        IDE_LOGE("Call rtGetStackBuffer to get stack data failed, coreType: %hhu coreId: %hu, ret: %d",
            coreType, coreId, static_cast<int32_t>(rtRet));
        return;
    }
    GlobalMemInfo memInfo = {
        .devAddr = reinterpret_cast<uint64_t>(stackAddr),
        .size = stackSize,
        .sectionIndex = 0,
        .type = DfxTensorType::STACK,
        .reserve = 0,
        .extraInfo = {.coreInfo = {ConvertCoreId(coreType, coreId)}}
    };

    int32_t ret = ProcessGlobalMemory(memInfo, memInfoList, false);
    IDE_CTRL_VALUE_FAILED(ret == ADUMP_SUCCESS, return,
            "Save stack section failed, core type: %hhu, core id: %hu", coreType, coreId);

    stackParamList_.emplace_back(
        coreType, coreId, stackSize, memInfo.devAddr, memInfo.sectionIndex, RT_MEM_TYPE_DCACHE);
}

void DumpCore::DumpHostKernelBin(const rtExceptionKernelInfo_t &kernelInfo)
{
    void *binAddr = nullptr;
    uint32_t binSize = 0;
    rtError_t rtRet = rtGetBinBuffer(kernelInfo.bin, RT_BIN_HOST_ADDR, &binAddr, &binSize);
    IDE_CTRL_VALUE_FAILED((rtRet == RT_ERROR_NONE) && (binAddr != nullptr), return,
        "Call rtGetBinBuffer get host kernel object failed, ret: %d", static_cast<int32_t>(rtRet));

    std::string hostBinData(static_cast<char*>(binAddr), binSize);
    ELF::SectionPtr curSection = coreFile_.AddSection(ASCEND_SHTYPE_HOST_KERNEL_OBJECT,
        ASCEND_SHNAME_HOST_KERNEL_OBJECT);
    IDE_CTRL_VALUE_FAILED(curSection != nullptr, return, "Create %s section failed.",
        ASCEND_SHNAME_HOST_KERNEL_OBJECT.c_str());
    curSection->SetData(hostBinData);
}

void DumpCore::DumpDeviceKernelBin(const rtExceptionKernelInfo_t &kernelInfo, std::vector<GlobalMemInfo> &memInfoList)
{
    void *deviceBinAddr = nullptr;
    uint32_t binSize = 0;
    rtError_t rtRet = rtGetBinBuffer(kernelInfo.bin, RT_BIN_DEVICE_ADDR, &deviceBinAddr, &binSize);
    IDE_CTRL_VALUE_FAILED(rtRet == RT_ERROR_NONE, return,
        "Call rtGetBinBuffer get device kernel object failed, ret: %d", static_cast<int32_t>(rtRet));

    GlobalMemInfo memInfo = {
        .devAddr = reinterpret_cast<uint64_t>(deviceBinAddr),
        .size = binSize,
        .sectionIndex = 0,
        .type = DfxTensorType::DEVICE_KERNEL_OBJECT,
        .reserve = 0,
        .extraInfo = {.shape = {.dim = 0, .dimSize = {0}}}
    };

    int32_t ret = ProcessGlobalMemory(memInfo, memInfoList);
    IDE_CTRL_VALUE_FAILED(ret == ADUMP_SUCCESS, return,
            "Save device kernel object section failed, addr: %p, size: %u", deviceBinAddr, binSize);

    binParam_ = {0, 0, binSize, memInfo.devAddr, memInfo.sectionIndex, RT_MEM_TYPE_ICACHE};
}

void DumpCore::DumpHostFile(const rtExceptionArgsInfo_t &argsInfo)
{
    KernelInfoCollector collector;
    collector.LoadKernelInfo(argsInfo);
    std::vector<std::string> searchPath = collector.GetSearchPath();
    std::string kernelName = collector.GetProcessedKernelName();
    IDE_CTRL_VALUE_FAILED(!kernelName.empty(), return, "Get kernel name failed.");
    IDE_LOGI("kernel name: %s", kernelName.c_str());
    DumpKernelInfo(kernelName);

    for (const auto &path : searchPath) {
        std::string jsonFilePath = collector.SearchJsonFiles(path, kernelName);
        if (jsonFilePath.empty()) {
            continue;
        }
        DumpHostFile(jsonFilePath, ASCEND_SHTYPE_FILE_KERNEL_JSON, ASCEND_SHNAME_FILE_KERNEL_JSON);
        std::string kernelFilePath = jsonFilePath.substr(0, jsonFilePath.size() - JSON_SUFFIX_LEN) + ".o";
        DumpHostFile(kernelFilePath, ASCEND_SHTYPE_FILE_KERNEL_OBJECT, ASCEND_SHNAME_FILE_KERNEL_OBJECT);
        break;
    }
}

void DumpCore::DumpHostFile(const std::string &filePath, uint32_t sectionType, const std::string &sectionName)
{
    char canonicalPath[PATH_MAX] = {0};
    IDE_CTRL_VALUE_FAILED(realpath(filePath.c_str(), canonicalPath) != nullptr, return,
        "Get file path %s realpath failed, strerr=%s", filePath.c_str(), strerror(errno));
    std::ifstream file(canonicalPath);
    IDE_CTRL_VALUE_FAILED(file.is_open(), return, "Open file failed, path: %s", canonicalPath);

    do {
        std::string content((std::istreambuf_iterator<char>(file)), std::istreambuf_iterator<char>());
        IDE_CTRL_VALUE_FAILED_NODO(!content.empty(), break, "Read file content failed, path: %s", canonicalPath);

        ELF::SectionPtr curSection = coreFile_.AddSection(sectionType, sectionName);
        IDE_CTRL_VALUE_FAILED_NODO(curSection != nullptr, break, "Create %s section failed.", sectionName.c_str());

        curSection->SetData(content);
    } while (0);

    file.close();
}

void DumpCore::DumpKernelInfo(const std::string &kernelName)
{
    std::string content;
    uint32_t nameSize = static_cast<uint32_t>(kernelName.length());
    content.append(reinterpret_cast<const char *>(&nameSize), sizeof(nameSize));
    content.append(kernelName);
    ELF::SectionPtr curSection = coreFile_.AddSection(ASCEND_SHTYPE_KERNEL_INFO, ASCEND_SHNAME_KERNEL_INFO);
    IDE_CTRL_VALUE_FAILED_NODO(curSection != nullptr, return,
        "Create %s section failed.",ASCEND_SHNAME_KERNEL_INFO.c_str());
    curSection->SetData(content);
}

void DumpCore::DumpGlobalAuxInfo(const std::vector<GlobalMemInfo> &memInfoList)
{
    ELF::SectionPtr infoSection = coreFile_.AddSection(ASCEND_SHTYPE_AUXINFO_GLOABL, ASCEND_SHNAME_AUXINFO_GLOABL);
    IDE_CTRL_VALUE_FAILED(infoSection != nullptr, return,
        "Create %s section failed.", ASCEND_SHNAME_AUXINFO_GLOABL.c_str());

    uint32_t index = infoSection->GetIndex();
    for (const GlobalMemInfo &memInfo : memInfoList) {
        ELF::SectionPtr section = coreFile_.GetSectionByIndex(memInfo.sectionIndex);
        IDE_CTRL_VALUE_FAILED_NODO(section != nullptr, continue, "Get section by index %u failed",
            memInfo.sectionIndex);
        section->SetLink(index);
    }

    size_t perLen = sizeof(GlobalMemInfo);
    size_t totalSize = perLen * memInfoList.size();
    infoSection->SetEntSize(perLen);
    std::string memInfoData(reinterpret_cast<const char *>(memInfoList.data()), totalSize);
    infoSection->SetData(memInfoData);
}
}  // namespace Adx
