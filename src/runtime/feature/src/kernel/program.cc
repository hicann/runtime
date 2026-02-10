/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "program_common.hpp"
#include <thread>
#include "securec.h"
#include "context.hpp"
#include "runtime.hpp"
#include "elf.hpp"
#include "error_message_manage.hpp"
#include "utils.h"
#include <vector>
#include <string>
#include <map>
#include "base.hpp"
#include "elf.hpp"
#include "runtime/elf_base.h"
#include "osal.hpp"
#include "stream_factory.hpp"

namespace cce {
namespace runtime {
constexpr uint32_t MIX_KERNEL_PROC_V1 = 1U;
constexpr uint32_t MIX_KERNEL_PROC_V2 = 2U;

#pragma pack(push, 1)
struct CpuSoBuf {
  uint64_t kernelSoBuf;
  uint32_t kernelSoBufLen;
  uint64_t kernelSoName;
  uint32_t kernelSoNameLen;
};

struct BatchProcCpuOpFromBufArgs {
  uint32_t soNum;
  uint64_t args;
};
#pragma pack(pop)

Program::Program(const uint32_t progMachine)
    : NoCopy(),
      KernelTable_(nullptr),
      kernelCount_(0U),
      kernelPos_(0U),
      isSupportMix_(false),
      binary_(nullptr),
      binarySize_(0UL),
      machine_(progMachine),
      kernelNames_(),
      progId_(UINT32_MAX),
      progType_(PLAIN_PROGRAM),
      progMemType_(PROGRAM_MEM_DDR)
{
    kernelNameMap_.clear();
    for (uint32_t i = 0U; i < RT_MAX_DEV_NUM; i++) {
        soNameDevAddrMap_[i].clear();
        funcNameDevAddrMap_[i].clear();
    }
}

Program::~Program()
{
    kernelMapLock_.Lock();
    std::vector<const Kernel *> deletedKernels;
    for (uint32_t i = 0U; i < kernelPos_; i++) {
        const Kernel * const delKernel = KernelTable_[i].kernel;
        deletedKernels.push_back(delKernel);
        delete delKernel;
    }
    delete [] KernelTable_;
    KernelTable_ = nullptr;

    for (auto iter = kernelNameMap_.begin(); iter != kernelNameMap_.end(); ++iter) {
        const Kernel * const kernel = iter->second;
        const auto it = std::find(deletedKernels.begin(), deletedKernels.end(), kernel);
        if (it == deletedKernels.end()) {
            delete kernel;
        }
    }

    kernelMapLock_.Unlock();

    if ((!isUserData_) && (binary_ != nullptr)) {
        char_t *buff = static_cast<char_t *>(binary_);
        DELETE_A(buff);
    }

    if (progId_ < Runtime::maxProgramNum_) {
        RefObject<Program *> *const programItem = Runtime::Instance()->GetProgramAllocator()->GetDataToItem(progId_);
        if (programItem != nullptr) {
            Program *programInst = programItem->GetVal(false);
            if (programInst != nullptr) {
                programInst = nullptr;
                programItem->ResetVal();
            }
        }
    }

    if (binHandle_ != nullptr) {
        (void)mmDlclose(binHandle_);
        binHandle_ = nullptr;
    }
}

void Program::Dereference()
{
    // dereference modules
    rtError_t err = RT_ERROR_NONE;
    while (!mapUsedCtx_.empty() && err == RT_ERROR_NONE) {
        const auto iter = mapUsedCtx_.begin();
        if (iter->first == nullptr) {
            RT_LOG_INNER_MSG(RT_LOG_ERROR, "Null module attached to context.");
            break;
        }

        Context * const dereferenceCtx = iter->second;
        err = dereferenceCtx->ReleaseModule(progId_);
    }
    if (!dependencies_.empty()) {
        // dereference depended program
        for (Program * const prog : dependencies_) {
            Runtime::Instance()->PutProgram(prog);
        }
        dependencies_.clear();
    }
}

void Program::Insert2CtxMap(Module ** const moduleItem, Context * const ctxItem)
{
    mapLock_.Lock();
    mapUsedCtx_[moduleItem] = ctxItem;
    mapLock_.Unlock();
}

void Program::Remove2CtxMap(Module ** const moduleItem)
{
    mapLock_.Lock();

    const size_t eraseNum = mapUsedCtx_.erase(moduleItem);
    if (eraseNum == 0ULL) {
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "Can not find context which the module attached to.");
    }

    mapLock_.Unlock();
}

void Program::SaveBinaryData(const void *data, uint64_t length, const bool isLoadFromFile)
{
    binarySize_ = length;
    isUserData_ = true;
    if (isLoadFromFile) {
        binary_ = const_cast<void *>(data);
        isUserData_ = false;
        return;
    }

    auto buffer = std::unique_ptr<char_t[]>(new (std::nothrow) char_t[length]());
    if (buffer != nullptr) {
        if (memcpy_s(buffer.get(), length, data, length) == EOK) {
            RT_LOG(RT_LOG_INFO, "Malloc the buffer for elfData, len=%llu", length);
            binary_ = RtPtrToPtr<void *>(buffer.release());
            isUserData_ = false;
            return;
        }
    }
    binary_ = const_cast<void *>(data);
}

rtError_t Program::Register(const void *data, const uint64_t length, const bool isLoadFromFile)
{
    NULL_PTR_RETURN_MSG(data, RT_ERROR_INVALID_VALUE);
    COND_RETURN_ERROR_MSG_INNER(length == 0ULL, RT_ERROR_INVALID_VALUE,
        "Register program failed, bin size can not be 0.");

    SaveBinaryData(data, length, isLoadFromFile);
    rtError_t error = ParserBinary();
    COND_RETURN_ERROR(error != RT_ERROR_NONE, error, "parse binary failed, retCode=%#x", error);
    error = Runtime::Instance()->AddProgramToPool(this);
    COND_RETURN_ERROR(error != RT_ERROR_NONE, error, "add program to pool failed, retCode=%#x", error);
    return RT_ERROR_NONE;
}

void Program::HalfSearch(const uint32_t searchLen, const uint64_t target,
                         rtHalfSearchResult_t *halfSearchResult) const
{
    int32_t topIndex = searchLen - 1;
    int32_t bottomIndex = 0;
    int32_t middleIndex = 0;
    constexpr uint32_t half = 2;
    RT_LOG(RT_LOG_DEBUG, "Program HalfSearch searchLen=%u, target=%llu.", searchLen, target);

    while (topIndex >= bottomIndex) {
        middleIndex = (topIndex + bottomIndex) / half;
        if (KernelTable_[middleIndex].TilingKey == target) {
            halfSearchResult->matchFlag = true;
            halfSearchResult->matchIndex = middleIndex;
            return;
        } else if (KernelTable_[middleIndex].TilingKey > target) {
            topIndex = middleIndex - 1;
        } else {
            bottomIndex = middleIndex + 1;
        }
    }

    halfSearchResult->matchFlag = false;
    halfSearchResult->matchIndex = bottomIndex;
}

Kernel* Program::SearchKernelByPcAddr(const uint64_t pcAddr) const
{
    RT_LOG(RT_LOG_ERROR, "pc_addr=0x%llx, kernelTable pos=%u, kernel count=%u.", pcAddr, kernelPos_, kernelCount_);
    if (pcAddr == 0ULL) {
        return nullptr;
    }

    uint64_t pcAddrWithoutOffset = (pcAddr & 0x7FFFFFFFFFFFFFFULL);
    for (uint32_t i = 0; i < kernelPos_; i++) {
        Kernel * const k = KernelTable_[i].kernel;
        uint32_t length1;
        uint32_t length2;
        uint64_t func1 = 0ULL;
        uint64_t func2 = 0ULL;
        rtError_t err = RT_ERROR_NONE;
        k->GetKernelLength(length1, length2);
        err = k->GetFunctionDevAddr(func1, func2);
        COND_PROC(err != RT_ERROR_NONE, continue);

        RT_LOG(RT_LOG_DEBUG, "list kernel_name=%s, func1=0x%llx, func2=0x%llx, length1=0x%llx, length2=0x%llx",
            k->Name_().c_str(), func1, func2, length1, length2);
        if ((pcAddrWithoutOffset - func1) <= length1) {
            RT_LOG(RT_LOG_ERROR, "kernel_name=%s", k->Name_().c_str());
            return k;
        }
        if ((func2 != 0ULL) && (length2 != 0UL) && (pcAddrWithoutOffset - func2) <= length2) {
            RT_LOG(RT_LOG_ERROR, "kernel_name=%s", k->Name_().c_str());
            return k;
        }
    }
    RT_LOG(RT_LOG_ERROR, "Not found the kernel by pc_addr=0x%llx", pcAddr);
    return nullptr;
}

rtError_t Program::ArrayInsert(const int32_t insertIndex, const uint64_t tilingKey,
                               Kernel *&addKernel, const uint32_t curLen)
{
    const uint32_t copySize = static_cast<uint32_t>(sizeof(rtKernelArray_t)) *
                              (curLen - static_cast<uint32_t>(insertIndex));
    RT_LOG(RT_LOG_DEBUG, "Program ArrayInsert insertIndex=%d, curLen=%u, copySize=%u",
           insertIndex, curLen, copySize);

    if (copySize > 0U) {
        const errno_t ret = memmove_s(KernelTable_ + insertIndex + 1, copySize, KernelTable_ + insertIndex, copySize);

        COND_RETURN_ERROR_MSG_INNER(ret != EOK, RT_ERROR_SEC_HANDLE,
            "Call memmove_s failed, copy size is %u", copySize);
    }

    KernelTable_[insertIndex].TilingKey = tilingKey;
    KernelTable_[insertIndex].kernel = addKernel;

    return RT_ERROR_NONE;
}

rtError_t Program::AllKernelAdd(Kernel *&addKernel, bool &isRepeated)
{
    rtError_t error = RT_ERROR_NONE;
    rtHalfSearchResult_t halfSearchResult;
    const uint64_t kernelInfoExt = addKernel->TilingKey();

    kernelMapLock_.Lock();
    HalfSearch(kernelPos_, kernelInfoExt, &halfSearchResult);
    if (!halfSearchResult.matchFlag) {
        error = ArrayInsert(halfSearchResult.matchIndex, kernelInfoExt, addKernel, kernelPos_);
        COND_PROC_RETURN_ERROR(error != RT_ERROR_NONE, error,
            kernelMapLock_.Unlock();,
            "Program AllKernelAdd failed, retCode=%#x.", static_cast<uint32_t>(error));
        kernelPos_ += 1;
    } else {
        RT_LOG(RT_LOG_WARNING, "Add all kernel repeatedly, using registered programid=%u, kernelInfoExt=%" PRIu64,
            addKernel->Program_()->Id_(), kernelInfoExt);
        kernelMapLock_.Unlock();
        isRepeated = true;
        return RT_ERROR_NONE;
    }
    kernelMapLock_.Unlock();

    RT_LOG(RT_LOG_DEBUG, "add kernel success, prog=%p, programid=%u, kernelInfoExt=%" PRIu64, addKernel->Program_(),
        addKernel->Program_()->Id_(), kernelInfoExt);
    return error;
}

rtError_t Program::MixKernelAdd(Kernel *&addKernel)
{
    kernelMapLock_.Lock();
    const auto iter = kernelNameMap_.find(addKernel->Name_());
    if (iter != kernelNameMap_.end()) {
        RT_LOG(RT_LOG_ERROR, "add kernel repeat, kernel_name=%s", addKernel->Name_().c_str());
        kernelMapLock_.Unlock();
        return RT_ERROR_KERNEL_DUPLICATE;
    }

    kernelNameMap_[addKernel->Name_()] = addKernel;

    RT_LOG(RT_LOG_DEBUG, "add mix kernel success, kernel_name=%s", addKernel->Name_().c_str());

    kernelMapLock_.Unlock();
    return RT_ERROR_NONE;
}

rtError_t Program::MixKernelRemove(Kernel *&delKernel)
{
    kernelMapLock_.Lock();
    const auto iter = kernelNameMap_.find(delKernel->Name_());
    if (iter != kernelNameMap_.end()) {
        (void)kernelNameMap_.erase(iter);
        kernelMapLock_.Unlock();
        return RT_ERROR_NONE;
    }
    RT_LOG(RT_LOG_WARNING, "try to remove kernel from kernel name map, but cannot found. name=%s",
        delKernel->Name_().c_str());
    kernelMapLock_.Unlock();

    return RT_ERROR_NONE;
}

const Kernel *Program::GetKernelByName(const char_t *kernelName)
{
    kernelMapLock_.Lock();
    const Kernel *retKernel = nullptr;
    const auto iter = kernelNameMap_.find(std::string(kernelName));
    if (iter != kernelNameMap_.end()) {
        retKernel = iter->second;
    }

    kernelMapLock_.Unlock();
    return retKernel;
}

Kernel *Program::AllKernelLookup(const uint64_t tilingKey, const bool getProgFlag)
{
    Kernel *retKernel = nullptr;
    rtHalfSearchResult_t halfSearchResult;
    kernelMapLock_.Lock();
    HalfSearch(kernelPos_, tilingKey, &halfSearchResult);
    retKernel = halfSearchResult.matchFlag ?
                KernelTable_[halfSearchResult.matchIndex].kernel : nullptr;
    if ((retKernel != nullptr) && (getProgFlag)) {
        const bool notReleased = Runtime::Instance()->GetProgram(this);
        // Program was releasing and kernel will be deleted later.
        if (!notReleased) {
            retKernel = nullptr;
        }
    }
    kernelMapLock_.Unlock();
    RT_LOG(RT_LOG_DEBUG, "AllKernelLookup end, tilingKey=%lu, programid=%u.", tilingKey, Id_());
    return retKernel;
}

const Kernel *Program::GetKernelByTillingKey(const uint64_t tilingKey)
{
    const Kernel *retKernel = nullptr;
    rtHalfSearchResult_t halfSearchResult;
    kernelMapLock_.Lock();
    HalfSearch(kernelPos_, tilingKey, &halfSearchResult);
    retKernel = halfSearchResult.matchFlag ?
                KernelTable_[halfSearchResult.matchIndex].kernel : nullptr;
    kernelMapLock_.Unlock();
    RT_LOG(RT_LOG_DEBUG, "AllKernelLookup end, tilingKey=%lu, programId=%u. kernelRegType=%d",
        tilingKey, Id_(), GetKernelRegType());

    return retKernel;
}

void Program::DependencyRegister(Program * const prog)
{
    const bool success = Runtime::Instance()->GetProgram(prog);
    if (unlikely(!success)) {
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "Dependence program may be already released");
        return;
    }

    dependencies_.push_back(prog);
}

void Program::LoadDependencies(Context * const ctxItem)
{
    const uint32_t machineType = Machine();
    if (machineType == Program::MACH_AI_CPU) {
        for (Program * const prog : dependencies_) {
            Module *moduleItem = RtPtrToPtr<Module *>(ctxItem->GetModule(prog));
            COND_LOG_DEBUG(moduleItem == nullptr, "get module failed, progId_=%u", prog->progId_);
        }
    }
}

uint32_t Program::AppendKernelName(const char_t *kernelName)
{
    const uint32_t offset = kernelNames_.size();
    if (kernelName != nullptr) {
        while (*kernelName != '\0') {
            kernelNames_.push_back(*kernelName);
            kernelName++;
        }
        kernelNames_.push_back('\0');
    }
    return offset;
}

rtError_t Program::BuildTilingTblForNewFlow(TilingTabl **tilingTab, uint32_t *kernelLen)
{
    kernelMapLock_.Lock();
    const size_t kernelCnt = kernelNameMap_.size();
    COND_PROC_RETURN_ERROR(kernelCnt == 0U, RT_ERROR_PROGRAM_SIZE, kernelMapLock_.Unlock(),
        "kernel count == 0");
    const size_t totalSize = sizeof(TilingTabl) * kernelCnt;
    TilingTabl *tilingTabInfo = (TilingTabl *)malloc(totalSize);
    COND_PROC_RETURN_ERROR(tilingTabInfo == nullptr, RT_ERROR_MEMORY_ALLOCATION, kernelMapLock_.Unlock(),
        "Call malloc failed, copy size is %u", totalSize);

    uint64_t func1 = 0ULL;
    uint64_t func2 = 0ULL;
    uint32_t idx = 0U;
    rtError_t err = RT_ERROR_NONE;
    for (auto iter = kernelNameMap_.begin(); iter != kernelNameMap_.end(); ++iter) {
        const Kernel * const kernel = iter->second;
        err = kernel->GetFunctionDevAddr(func1, func2);
        COND_PROC(err != RT_ERROR_NONE, continue);
        tilingTabInfo[idx].tilingKey = kernel->TilingKey();
        tilingTabInfo[idx].pcInfo[0] = func1;
        tilingTabInfo[idx].pcInfo[1] = func2;
        tilingTabInfo[idx].taskRation = kernel->GetTaskRation();
        tilingTabInfo[idx].mixType = kernel->GetMixType();
        tilingTabInfo[idx].rsv = {0U};
        RT_LOG(RT_LOG_INFO,
            "tilingKey=%" PRIu64 ",func1=%#" PRIu64 ",func2=%#" PRIu64 ",taskRation=%u,mixType=%u,idx=%u.",
            tilingTabInfo[idx].tilingKey, tilingTabInfo[idx].pcInfo[0],
            tilingTabInfo[idx].pcInfo[1], tilingTabInfo[idx].taskRation, tilingTabInfo[idx].mixType, idx);
        idx++;
    }

    *tilingTab = tilingTabInfo;
    *kernelLen = idx;
    kernelMapLock_.Unlock();
    RT_LOG(RT_LOG_INFO, "kernelCnt=%zu, realCnt=%u, tilingTabSize=%u, totalSize=%zu.",
        kernelCnt, idx, sizeof(TilingTabl), totalSize);
    return RT_ERROR_NONE;
}

rtError_t Program::BuildTilingTbl(const Module *mdl, TilingTabl **tilingTab, uint32_t *kernelLen)
{
    if (IsNewBinaryLoadFlow()) {
        return BuildTilingTblForNewFlow(tilingTab, kernelLen);
    }

    NULL_PTR_RETURN_MSG(mdl, RT_ERROR_MODULE_NULL);
    RT_LOG(RT_LOG_INFO, "kernelPos_ = %u tilingTab size=%u.", kernelPos_, sizeof(TilingTabl));
    if (kernelPos_ == 0) {
        RT_LOG(RT_LOG_ERROR, "kernelPos_ == 0.");
        return RT_ERROR_PROGRAM_SIZE;
    }

    kernelMapLock_.Lock();
    const uint32_t size = kernelPos_;
    TilingTabl *tilingTabInfo = (TilingTabl *)malloc(sizeof(TilingTabl) * size);
    if (tilingTabInfo == nullptr) {
        RT_LOG(RT_LOG_ERROR, "malloc fail size = %u.", (sizeof(TilingTabl) * size));
        kernelMapLock_.Unlock();
        return RT_ERROR_PROGRAM_SIZE;
    }

    uint64_t function1;
    uint64_t function2;
    for (uint32_t i = 0; i < size; i++) {
        (void)mdl->GetFunction(KernelTable_[i].kernel, &function1, &function2);
        tilingTabInfo[i].tilingKey = KernelTable_[i].TilingKey;
        tilingTabInfo[i].pcInfo[0] = function1;
        tilingTabInfo[i].pcInfo[1] = function2;
        (void)mdl->GetTaskRation(KernelTable_[i].kernel, tilingTabInfo[i].taskRation);
        tilingTabInfo[i].mixType = KernelTable_[i].kernel->GetMixType();
        tilingTabInfo[i].rsv = {0U};
        RT_LOG(RT_LOG_INFO,
            "tilingKey=0x%llx,function1=0x%llx,function2=0x%llx,taskRation=%u,mixType=%u,i=%u.",
            tilingTabInfo[i].tilingKey, tilingTabInfo[i].pcInfo[0],
            tilingTabInfo[i].pcInfo[1], tilingTabInfo[i].taskRation, tilingTabInfo[i].mixType, i);
    }

    *tilingTab = tilingTabInfo;
    *kernelLen = size;
    kernelMapLock_.Unlock();
    return RT_ERROR_NONE;
}

void Program::DestroyTilingTbl(TilingTabl *tilingTab) const
{
    if (tilingTab != nullptr) {
        free(tilingTab);
    }

    return;
}

rtError_t Program::DavidBuildTilingTblForNewFlow(TilingTablForDavid **tilingTab, uint32_t *kernelLen)
{
    kernelMapLock_.Lock();
    const size_t kernelCnt = kernelNameMap_.size();
    const size_t totalSize = sizeof(TilingTablForDavid) * kernelCnt;
    TilingTablForDavid *tilingTabInfo = (TilingTablForDavid *)malloc(totalSize);
    COND_PROC_RETURN_ERROR(tilingTabInfo == nullptr, RT_ERROR_MEMORY_ALLOCATION, kernelMapLock_.Unlock(),
        "Call malloc failed, copy size is %u", totalSize);

    uint64_t function1 = 0ULL;
    uint64_t function2 = 0ULL;
    uint32_t idx = 0U;
    rtError_t err = RT_ERROR_NONE;
    for (auto iter = kernelNameMap_.begin(); iter != kernelNameMap_.end(); ++iter) {
        const Kernel * const kernel = iter->second;
        err = kernel->GetFunctionDevAddr(function1, function2);
        COND_PROC(err != RT_ERROR_NONE, continue);
        tilingTabInfo[idx].tilingKey = kernel->TilingKey();
        tilingTabInfo[idx].pcInfo[0] = function1;
        tilingTabInfo[idx].pcInfo[1] = function2;
        tilingTabInfo[idx].taskRation = kernel->GetTaskRation();
        tilingTabInfo[idx].mixType = kernel->GetMixType();
        tilingTabInfo[idx].u.tilingInfoExt.kernelVfType = kernel->KernelVfType_();
        tilingTabInfo[idx].u.tilingInfoExt.shareMemSize = kernel->ShareMemSize_();
        tilingTabInfo[idx].rsv = {0U};
        idx++;
    }

    *tilingTab = tilingTabInfo;
    *kernelLen = idx;
    kernelMapLock_.Unlock();
    RT_LOG(RT_LOG_INFO, "kernelCnt=%zu, realCnt=%u, tilingTab size=%u, totalSize=%zu.",
        kernelCnt, idx, sizeof(TilingTablForDavid), totalSize);
    return RT_ERROR_NONE;
}

rtError_t Program::BuildTilingTblForDavid(const Module *mdl, TilingTablForDavid **tilingTab, uint32_t *kernelLen)
{
    // 新的注册流程 binHandle中不包含module信息，需要走兼容分支
    if (IsNewBinaryLoadFlow()) {
        return DavidBuildTilingTblForNewFlow(tilingTab, kernelLen);
    }

    NULL_PTR_RETURN_MSG(mdl, RT_ERROR_MODULE_NULL);
    RT_LOG(RT_LOG_INFO, "kernelPos_ = %u tilingTab size=%u.", kernelPos_, sizeof(TilingTablForDavid));
    if (kernelPos_ == 0) {
        RT_LOG(RT_LOG_ERROR, "kernelPos_ == 0.");
        return RT_ERROR_PROGRAM_SIZE;
    }
 
    kernelMapLock_.Lock();
    const uint32_t size = kernelPos_;
    TilingTablForDavid *tilingTabInfo = (TilingTablForDavid *)malloc(sizeof(TilingTablForDavid) * size);
    if (tilingTabInfo == nullptr) {
        RT_LOG(RT_LOG_ERROR, "malloc fail size = %u.", (sizeof(TilingTablForDavid) * size));
        kernelMapLock_.Unlock();
        return RT_ERROR_PROGRAM_SIZE;
    }
 
    uint64_t function1;
    uint64_t function2;
    for (uint32_t i = 0; i < size; i++) {
        (void)mdl->GetFunction(KernelTable_[i].kernel, &function1, &function2);
        tilingTabInfo[i].tilingKey = KernelTable_[i].TilingKey;
        tilingTabInfo[i].pcInfo[0] = function1;
        tilingTabInfo[i].pcInfo[1] = function2;
        (void)mdl->GetTaskRation(KernelTable_[i].kernel, tilingTabInfo[i].taskRation);
        tilingTabInfo[i].mixType = KernelTable_[i].kernel->GetMixType();
        tilingTabInfo[i].rsv = {0U};
        tilingTabInfo[i].u.tilingInfoExt.kernelVfType = KernelTable_[i].kernel->KernelVfType_();
        tilingTabInfo[i].u.tilingInfoExt.shareMemSize = KernelTable_[i].kernel->ShareMemSize_();
        RT_LOG(RT_LOG_INFO,
            "tilingKey=%" PRIu64 ",function1=%#" PRIu64 ",function2=%#" PRIu64 ",taskRation=%u,mixType=%u,i=%u.",
            tilingTabInfo[i].tilingKey, tilingTabInfo[i].pcInfo[0],
            tilingTabInfo[i].pcInfo[1], tilingTabInfo[i].taskRation, tilingTabInfo[i].mixType, i);
    }
 
    *tilingTab = tilingTabInfo;
    *kernelLen = size;
    kernelMapLock_.Unlock();
    return RT_ERROR_NONE;
}
 
void Program::DestroyTilingTblForDavid(TilingTablForDavid *tilingTab) const
{
    if (tilingTab != nullptr) {
        free(tilingTab);
    }
 
    return;
}

const std::string &Program::GetKernelNamesBuffer() const
{
    return kernelNames_;
}

rtError_t Program::CheckLoaded2Device()
{
    if (!isLazyLoad_) {
        return RT_ERROR_NONE;
    }

    return Load2Device();
}

rtError_t Program::Load2Device()
{
    Runtime* runtime = Runtime::Instance();
    NULL_PTR_RETURN_MSG(runtime, RT_ERROR_INSTANCE_NULL);
    Context * const curCtx = runtime->CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    Device * const device = curCtx->Device_();
    NULL_PTR_RETURN_MSG(device, RT_ERROR_DEVICE_NULL)

    if (GetBinBaseAddr(device->Id_()) != nullptr) {
        return RT_ERROR_NONE;
    }

    load2DeviceLock_.Lock();
    if (GetBinBaseAddr(device->Id_()) != nullptr) {
        load2DeviceLock_.Unlock();
        return RT_ERROR_NONE;
    }

    // load program binary to device
    const rtError_t error = runtime->BinaryLoad(device, this);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "Load program to device failed");
    }
    load2DeviceLock_.Unlock();
    RT_LOG(RT_LOG_DEBUG, "Program was loaded to device successfully.");
    return error;
}

uint32_t Program::GetMaxMinStackSize() const
{
    uint32_t maxMinStackSize = 0U;
    for (const auto &iter : kernelNameMap_) {
        const Kernel *kernel = iter.second;
        if (kernel != nullptr) {
            maxMinStackSize = std::max(maxMinStackSize,
                kernel->GetMinStackSize1() > kernel->GetMinStackSize2() ? kernel->GetMinStackSize1()
                                                                        : kernel->GetMinStackSize2());
        }
    }
    return maxMinStackSize;
}

rtError_t Program::CopyKernelLiteralNameToDevice(const std::string &literalName, void **devAddrHandle, const Device * const dev) const
{
    // get current device
    Runtime* runtime = Runtime::Instance();
	NULL_PTR_RETURN_MSG(runtime, RT_ERROR_INSTANCE_NULL);
	const uint32_t devId = static_cast<uint32_t>(dev->Id_());
	Driver *curDrv = dev->Driver_();

    // alloc dev memory for soName and funcName
    size_t nameSize = literalName.size() + 1;
    void *devAddr = nullptr;
    const rtMemType_t memType = runtime->GetTsMemType(MEM_REQUEST_FEATURE_DEFAULT, static_cast<uint64_t>(nameSize));
	rtError_t ret = curDrv->DevMemAlloc(&devAddr, nameSize, memType, devId);
    ERROR_RETURN(ret, "fail to alloc device memory for literalName, ret=%d, devId=%u.", ret, devId);
    
    // copy soName and funcName to device
    ret = curDrv->MemCopySync(devAddr, nameSize, literalName.c_str(), nameSize, RT_MEMCPY_HOST_TO_DEVICE);
    if (ret != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "fail to copy literalName to device, ret=%d, devId=%u.", ret, devId);
        (void)curDrv->DevMemFree(devAddr, devId);
        return ret;
    }   
    
    *devAddrHandle = devAddr;
    return RT_ERROR_NONE;
}

rtError_t Program::StoreKernelLiteralNameToDevice(Kernel *const kernel)
{
    void *soNameDevAddr = nullptr;
    void *funcNameDevAddr = nullptr;

    // get current device
    Runtime* runtime = Runtime::Instance();
    NULL_PTR_RETURN_MSG(runtime, RT_ERROR_INSTANCE_NULL);
    Context * const curCtx = runtime->CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    const uint32_t devId = static_cast<uint32_t>(curCtx->Device_()->Id_());

    // copy soName to device
    const auto iterSoName = soNameDevAddrMap_[devId].find(kernel->GetCpuKernelSo());
    if (iterSoName != soNameDevAddrMap_[devId].end()) {
        soNameDevAddr = iterSoName->second;
    } else {
        rtError_t ret = CopyKernelLiteralNameToDevice(kernel->GetCpuKernelSo(), &soNameDevAddr, curCtx->Device_());
        ERROR_RETURN(ret, "fail to copy soName to device, ret=%d.", ret);
        soNameDevAddrMap_[devId][kernel->GetCpuKernelSo()] = soNameDevAddr;
    }

    // copy funcName to device
    const auto iterFuncName = funcNameDevAddrMap_[devId].find(kernel->GetCpuFuncName());
    if (iterFuncName != funcNameDevAddrMap_[devId].end()) {
        funcNameDevAddr = iterFuncName->second;
    } else {
        rtError_t ret = CopyKernelLiteralNameToDevice(kernel->GetCpuFuncName(), &funcNameDevAddr, curCtx->Device_());
        ERROR_RETURN(ret, "fail to copy funcName to device, ret=%d.", ret);
        funcNameDevAddrMap_[devId][kernel->GetCpuFuncName()] = funcNameDevAddr;
    }
    kernel->SetKernelLiteralNameDevAddr(soNameDevAddr, funcNameDevAddr, devId);
    return RT_ERROR_NONE;
}

rtError_t Program::FreeKernelLiteralNameDevMem(const Device *const device)
{
    const uint32_t deviceId = device->Id_();
	Driver *curDrv = device->Driver_();

    for (auto iter = soNameDevAddrMap_[deviceId].begin(); iter != soNameDevAddrMap_[deviceId].end(); ) {
        if (iter->second != nullptr) {
            rtError_t ret = curDrv->DevMemFree(iter->second, deviceId);
            ERROR_RETURN(ret, "fail to free soNameDevMem %s, ret=%d, devId=%u.", iter->first.c_str(), ret, deviceId);
        }
        iter = soNameDevAddrMap_[deviceId].erase(iter);
    }

    for (auto iter = funcNameDevAddrMap_[deviceId].begin(); iter != funcNameDevAddrMap_[deviceId].end(); ) {
        if (iter->second != nullptr) {
            rtError_t ret = curDrv->DevMemFree(iter->second, deviceId);
            ERROR_RETURN(ret, "fail to free funcNameDevMem %s, ret=%d, devId=%u.", iter->first.c_str(), ret, deviceId);
        }    
        iter = funcNameDevAddrMap_[deviceId].erase(iter);
    }

    return RT_ERROR_NONE;
}

PlainProgram::PlainProgram(uint32_t const machine) : Program(machine)
{
    SetType(Program::PLAIN_PROGRAM);
}

PlainProgram::PlainProgram(const KernelRegisterType kernelRegType, const uint32_t machine) : Program(machine)
{
    SetKernelRegType(kernelRegType);
}

PlainProgram::~PlainProgram()
{
}

uint32_t PlainProgram::SymbolOffset(const void * const symbol, uint32_t &length)
{
    const auto symOffset = RtPtrToPtr<uintptr_t>(symbol);
    if (symOffset >= binarySize_) {
        length = 0U;
        return UINT32_MAX;
    } else {
        length = static_cast<uint32_t>(binarySize_ - symOffset);
        return static_cast<uint32_t>(symOffset);
    }
}

void PlainProgram::KernelContent(const void * const symbol,  rtKernelContent *info)
{
    const auto symOffset = RtPtrToPtr<uintptr_t>(symbol);
    if (symOffset >= binarySize_) {
        info->length = 0U;
        info->offset = UINT32_MAX;
    } else {
        info->length = static_cast<uint32_t>(binarySize_ - symOffset);
        info->offset = static_cast<uint32_t>(symOffset);
    }
}

uint32_t PlainProgram::LoadSize()
{
    return static_cast<uint32_t>(binarySize_);
}

bool PlainProgram::IsReadOnly()
{
    return false;
}

rtError_t PlainProgram::LoadExtract(void * const output, const uint32_t size)
{
    NULL_PTR_RETURN_MSG(output, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG(binary_, RT_ERROR_PROGRAM_DATA);

    const errno_t ret = memcpy_s(output, static_cast<size_t>(size), binary_, binarySize_);
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, ret != EOK, RT_ERROR_SEC_HANDLE,
        "Memcpy_s failed, retCode=%d, dst length=%u, src length=%" PRIu64, ret, size, binarySize_);
    return RT_ERROR_NONE;
}

bool PlainProgram::HasMixKernel()
{
    return false;
}

void *PlainProgram::Data()
{
    return binary_;
}

rtError_t PlainProgram::GetKernel(const void * const symbol, RtKernel &kernel)
{
    UNUSED(symbol);
    UNUSED(kernel);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t PlainProgram::RefreshSymbolAddr()
{
    return RT_ERROR_NONE;
}

void PlainProgram::AdaptKernelAttrType(const RtKernel * const kernelInput, Kernel *kernelOutput)
{
    UNUSED(kernelInput);
    UNUSED(kernelOutput);
    return;
}

rtError_t PlainProgram::BinaryGetMetaInfo(const rtBinaryMetaType type, void *data, const uint32_t length)
{
    UNUSED(type);
    UNUSED(data);
    UNUSED(length);
    return RT_ERROR_NONE;
}

rtError_t PlainProgram::FunctionGetMetaInfo(const std::string &kernelName, const rtFunctionMetaType type,
                                            void *data, const uint32_t length)
{
    UNUSED(kernelName);
    UNUSED(type);
    UNUSED(data);
    UNUSED(length);
    return RT_ERROR_NONE;
}

// 注册CPU算子
rtError_t Program::RegisterCpuKernel(const std::vector<CpuKernelInfo> &kernelInfos)
{
    constexpr uint64_t defaultTilingKey = 0ULL; // cpu kernel不使用tiling key，所以默认填值0
    kernelMapLock_.Lock();
    
    for (auto kernelInfo : kernelInfos) {	
        const std::string key = kernelInfo.key;
        const auto iter = kernelNameMap_.find(key); // 如果已经注册，不重复注册
        if (iter != kernelNameMap_.end()) {
            RT_LOG(RT_LOG_WARNING, "[%s] has been registered, continue", key.c_str());
            continue;
        }

        Kernel *kernel = new (std::nothrow) Kernel(nullptr, key.c_str(), defaultTilingKey, this, 0U, 0U);
        if (unlikely(kernel == nullptr)) {
            RT_LOG(RT_LOG_WARNING, "kernel new failed, continue");
            continue;
        }
        SetCpuKernelAttr(kernel, kernelInfo, key);
        kernelNameMap_[key] = kernel;
        RT_LOG(RT_LOG_DEBUG, "cpu kernel info:functionName[%s],kernelSo[%s],opType[%s]",
            kernel->GetCpuFuncName().c_str(), kernel->GetCpuKernelSo().c_str(), key.c_str());
    }

    kernelMapLock_.Unlock();
    return RT_ERROR_NONE;
}

// 通过funcName和opType单独注册单个cpu kernel
rtError_t Program::RegisterSingleCpuKernel(const char *const funcName, const char *const kernelName, Kernel **kernelHandle)
{
    *kernelHandle = nullptr;
    kernelMapLock_.Lock();
    const auto iter = kernelNameMap_.find(kernelName);  // 如果已经注册，不重复注册
    if (iter != kernelNameMap_.end()) {
        RT_LOG(RT_LOG_WARNING, "[%s] has been registered, continue", kernelName);
        *kernelHandle = iter->second;
        kernelMapLock_.Unlock();
        return RT_ERROR_NONE;
    }

    constexpr uint64_t defaultTilingKey = 0ULL;  // cpu kernel不使用tiling key，所以默认填值0
    Kernel *kernel = new (std::nothrow) Kernel(nullptr, kernelName, defaultTilingKey, this, 0U, 0U);
    COND_PROC_RETURN_ERROR(kernel == nullptr, RT_ERROR_MEMORY_ALLOCATION, kernelMapLock_.Unlock();,
            "kernel new failed, return.");

    kernel->SetKernelRegisterType(RT_KERNEL_REG_TYPE_CPU);
    std::string tmpFuncName = funcName;
    std::string tmpKernelName = kernelName;
    kernel->SetCpuFuncName(tmpFuncName);
    kernel->SetCpuKernelSo(soName_);
    kernel->SetCpuOpType(tmpKernelName);
    kernel->SetSystemParaNum(0U);
    kernel->SetUserParaNum(USER_ARGS_MAX_NUM);
    kernel->SetIsNeedSetFftsAddrInArg(false);
    kernel->SetIsSupportOverFlow(false);
    kernel->SetKernelType_(static_cast<uint32_t>(KERNEL_TYPE_AICPU_CUSTOM));
    kernel->SetKernelAttrType(RT_KERNEL_ATTR_TYPE_AICPU);
 
    // Aicpu算子注册时，把KernelName, soname存储至device侧，并把devAddr记录至kernel，从而args区无须填入kernelName, soname
    rtError_t ret = StoreKernelLiteralNameToDevice(kernel);
    if (ret != RT_ERROR_NONE) {
        delete kernel;
        kernelMapLock_.Unlock();
        RT_LOG(RT_LOG_ERROR, "fail to store kernel %s literal name to device, ret=%d", kernelName, ret);
        return ret;
    }
    kernelNameMap_[kernelName] = kernel;
    kernelMapLock_.Unlock();

    *kernelHandle = kernel;
    return RT_ERROR_NONE;
}

ElfProgram::ElfProgram(const uint32_t machine) : Program(machine)
{
    kernels_ = nullptr;
    SetType(Program::ELF_PROGRAM);
    elfData_ = new (std::nothrow) rtElfData;
    if (elfData_ != nullptr) {
        const errno_t ret = memset_s(elfData_, sizeof(rtElfData), '\0', sizeof(rtElfData));
        COND_LOG_DEBUG(ret != EOK, "memset_s failed, retCode=%d, size=%zu(bytes)", ret, sizeof(rtElfData));
    }
}

ElfProgram::~ElfProgram()
{
    if (elfData_ != nullptr) {
        for (uint32_t i = 0; i < elfData_->kernel_num; ++i) {
            if (kernels_ != nullptr) {
                DELETE_A(kernels_[i].name);
            }
        }
        delete [] elfData_->section_headers;
        elfData_->section_headers = nullptr;
        delete elfData_;
        elfData_ = nullptr;
    }

    delete [] kernels_;
    kernels_ = nullptr;
}

rtError_t ElfProgram::ParserBinary()
{
    NULL_PTR_RETURN_MSG(elfData_, RT_ERROR_PROGRAM_DATA);

    static const std::string ver("0.1");
    static const std::string sha256("");
    static const std::string property("exclusive");

    elfData_->obj_size = binarySize_;
    kernels_ = ProcessObject(RtPtrToPtr<char_t *>(binary_), elfData_, Machine(), &isSupportMix_);
    NULL_PTR_RETURN_MSG_OUTER(kernels_, RT_ERROR_INVALID_VALUE);

    const Runtime * const rtInstance = Runtime::Instance();
    const rtChipType_t chipType = rtInstance->GetChipType();
    if (IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_KERNEL_ELF_AICPU_MACHINE)) {
        machine_ = (elfData_->elf_header.e_machine == 183U) ? MACH_AI_CPU : MACH_AI_CORE; // 183:aicpu machine
    }

    if (IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_KERNEL_ELF_16K_STACK)) {
        SetStackSize(elfData_->stackSize);
    }

    if (elfData_->so_name != nullptr) {
        soName_ = elfData_->so_name;

        // runtime fake metadata
        (void)metadata_.append(soName_).append(1UL, ',');   // so name
        (void)metadata_.append(ver).append(1UL, ',');       // version
        (void)metadata_.append(sha256).append(1UL, ',');    // share256
        (void)metadata_.append(property).append(1UL, ';');  // shared
    }
    return RT_ERROR_NONE;
}

uint32_t ElfProgram::SymbolOffset(const void * const symbol, uint32_t &length)
{
    NULL_PTR_RETURN_MSG(elfData_, 0U);
    NULL_PTR_RETURN_MSG(symbol, UINT32_MAX);
    length = 0U;
    for (uint32_t idx = 0U; idx < elfData_->kernel_num; idx++) {
        if (kernels_ != nullptr) {
            if (strncmp(kernels_[idx].name, RtPtrToPtr<const char_t *>(symbol), NAME_MAX_LENGTH) == 0) {
                length = static_cast<uint32_t>(kernels_[idx].length);
                return static_cast<uint32_t>(kernels_[idx].offset);
            }
        }
    }
    return UINT32_MAX;
}

void ElfProgram::KernelContent(const void * const symbol, rtKernelContent *info)
{
    if (info == nullptr) {
        return;
    }
    info->offset = UINT32_MAX;
    if (elfData_ == nullptr) {
        info->offset = 0;
        return;
    }
    if (symbol == nullptr) {
        return;
    }

    for (uint32_t idx = 0U; idx < elfData_->kernel_num; idx++) {
        if (kernels_ != nullptr) {
            if (strcmp(kernels_[idx].name, static_cast<const char_t *>(symbol)) == 0) {
                info->length = static_cast<uint32_t>(kernels_[idx].length);
                info->offset= static_cast<uint32_t>(kernels_[idx].offset);
                info->kernelVfType = kernels_[idx].kernelVfType;
                info->shareMemSize = kernels_[idx].shareMemSize;
                return;
            }
        }
    }
}

bool ElfProgram::HasMixKernel()
{
    if ((kernels_ == nullptr) || (elfData_ == nullptr)) {
        RT_LOG(RT_LOG_WARNING, "kernels or elfData is null");
        return false;
    }
    const uint32_t kernelCount = elfData_->kernel_num;
    uint32_t mixkernelCount = 0U;
    for (uint32_t idx = 0U; idx < kernelCount; idx++) {
        std::string kernelValue = kernels_[idx].name;
        const std::string mixAicName = "_mix_aic";
        const std::string mixAivName = "_mix_aiv";
        const auto aicPos = kernelValue.rfind(mixAicName);
        const auto aivPos = kernelValue.rfind(mixAivName);
        if ((aicPos != std::string::npos) || (aivPos != std::string::npos)) {
            mixkernelCount++;
        }
    }
    RT_LOG(RT_LOG_DEBUG, "kernelCount:%u, mixkernelCount:%u", kernelCount, mixkernelCount);
    return mixkernelCount != 0;
}

uint32_t ElfProgram::LoadSize()
{
    return (elfData_ != nullptr) ? static_cast<uint32_t>(elfData_->text_size) : 0U;
}

rtError_t ElfProgram::GetKernel(const void * const symbol, RtKernel &kernel)
{
    for (uint32_t idx = 0U; idx < elfData_->kernel_num; idx++) {
        if (kernels_ != nullptr) {
            if (strncmp(kernels_[idx].name, RtPtrToPtr<const char_t *>(symbol), NAME_MAX_LENGTH) == 0) {
                kernel = kernels_[idx];
                return RT_ERROR_NONE;
            }
        }
    }
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ElfProgram::LoadExtract(void * const output, const uint32_t size)
{
    NULL_PTR_RETURN_MSG(output, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG(elfData_, RT_ERROR_PROGRAM_DATA);
    NULL_PTR_RETURN_MSG(binary_, RT_ERROR_PROGRAM_DATA);

    const errno_t ret = memcpy_s(output, static_cast<size_t>(size),
                                 RtPtrToPtr<char_t *>(binary_) + elfData_->text_offset, elfData_->text_size);
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, ret != EOK, RT_ERROR_SEC_HANDLE,
        "Memcpy_s failed, retCode=%d, dst length=%u, src length=%" PRIu64, ret, size, elfData_->text_size);
    RT_LOG(RT_LOG_INFO, "text_offset:%" PRIu64 ", elfData_->text_size:%" PRIu64, elfData_->text_offset,
        elfData_->text_size);
    return RT_ERROR_NONE;
}

void *ElfProgram::Data()
{
    return ((binary_ != nullptr) && (elfData_ != nullptr)) ?
        (RtPtrToPtr<char_t *>(binary_) + elfData_->text_offset) : nullptr;
}

bool ElfProgram::IsReadOnly()
{
    const rtChipType_t chipType = Runtime::Instance()->GetChipType();
    if (IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_KERNEL_DATA_READ_ONLY)) {
        return false;
    }
    return (elfData_ != nullptr) ? (!elfData_->dataFlag) : true;
}

/**
 * 1. Get mixType
 * 2. Remove mix_aic or mix_aiv from kernel name. Keep the tilingKey (e.g. _0123123).
 */
std::string ElfProgram::AdjustKernelNameAndGetMixType(const RtKernel * const kernel, uint8_t &mixType) const
{
    std::string kernelName = kernel->name;
    const std::string mixAicName = "_mix_aic";
    const std::string mixAivName = "_mix_aiv";
    const auto aicPos = kernelName.rfind(mixAicName);
    const auto aivPos = kernelName.rfind(mixAivName);

    const bool isAic = (aicPos != std::string::npos);
    const bool isAiv = (aivPos != std::string::npos);
    if (isAic && isAiv) { // this case seems impossible
        mixType = static_cast<uint8_t>(MIX_AIC_AIV_MAIN_AIC);
        (void)kernelName.erase(aicPos, mixAicName.length());
        (void)kernelName.erase(kernelName.rfind(mixAivName), mixAivName.length());
    } else if (isAic) {
        mixType = static_cast<uint8_t>(MIX_AIC);
        (void)kernelName.erase(aicPos, mixAicName.length());
    } else if (isAiv) {
        mixType = static_cast<uint8_t>(MIX_AIV);
        (void)kernelName.erase(aivPos, mixAivName.length());
    } else {
        RT_LOG(RT_LOG_DEBUG, "Not contains aic or aiv");
    }
    return kernelName;
}

/**
 * Parse tiling key from kernel name. Make sure mix_aic/mix_aiv has been removed from the kernel name.
 * if there is no valid tiling key, will return RT_ERROR_INVALID_VALUE
 */
rtError_t ElfProgram::ParseTilingKey(const std::string &kernelName, uint64_t &tilingKey) const
{
    const auto pos = kernelName.rfind('_');
    const std::string tilingKeyStr = kernelName.substr(pos + 1U);
    if (tilingKeyStr.empty()) {
        return RT_ERROR_INVALID_VALUE;
    }

    if (!IsStringNumeric(tilingKeyStr)) {
        return RT_ERROR_INVALID_VALUE;
    }

    const rtError_t ret = Runtime::Instance()->GetTilingValue(tilingKeyStr, tilingKey);
    if (ret != RT_ERROR_NONE) {
        tilingKey = 0ULL;
    }
    return ret;
}

static void SwapMixKernelOffsetAndLength(Kernel * const kernelTmp, const RtKernel * const kernel)
{
    // swap offset
    kernelTmp->SetOffset2(kernelTmp->Offset_());
    kernelTmp->SetOffset(static_cast<uint32_t>(kernel->offset));

    // swap minStackSize
    kernelTmp->SetMinStackSize2(kernelTmp->GetMinStackSize1());
    kernelTmp->SetMinStackSize1(kernel->minStackSize);

    // swap length
    uint32_t kernelLen1;
    uint32_t kernelLen2; // useless
    kernelTmp->GetKernelLength(kernelLen1, kernelLen2);
    kernelTmp->SetKernelLength1(static_cast<uint32_t>(kernel->length));
    kernelTmp->SetKernelLength2(kernelLen1);
}

// Search kernel from registered kernels. If the mixType is different, combine offset2 to make a mix kernel.
bool ElfProgram::FindAndProcMixKernel(const RtKernel * const kernel, const std::string &kernelName,
                                      const uint8_t mixType, const uint32_t mixProcVersion)
{
    if (!IS_SUPPORT_CHIP_FEATURE(Runtime::Instance()->GetChipType(), RtOptionalFeatureType::RT_FEATURE_KERNEL_MIX)) {
        return false;
    }

    Kernel *kernelTmp = const_cast<Kernel*>(GetKernelByName(kernelName.c_str()));
    if (kernelTmp == nullptr) {     // cann not found the previous mix kernel to combine with
        return false;
    }

    if ((kernelTmp->Offset2_() != 0ULL) || (kernelTmp->GetMixType() == mixType)) {
        RT_LOG(RT_LOG_WARNING, "found the previous mix kernel but conflict. found kernel name=[%s], mixType=%hu, "
            "offset2=%llu, current kernel name=[%s], mixType=%hu", kernelTmp->Name_().c_str(), mixType,
            kernelTmp->Offset2_(), kernel->name, mixType);
        return false;
    }

    const uint16_t kernelTmpMixType = kernelTmp->GetMixType();
    if (unlikely(kernelTmp->GetMixType() == static_cast<uint8_t>(MIX_AIV))) {
        // make sure offset1 is always mix_aic and offset2 is mix_aiv.
        SwapMixKernelOffsetAndLength(kernelTmp, kernel);
    } else {
        // this is the major case.
        kernelTmp->SetOffset2(static_cast<uint32_t>(kernel->offset));
        kernelTmp->SetKernelLength2(static_cast<uint32_t>(kernel->length));
        kernelTmp->SetMinStackSize2(kernel->minStackSize);
        kernelTmp->SetKernelVfType_(kernel->kernelVfType);
        kernelTmp->SetShareMemSize_(kernel->shareMemSize);
    }
    kernelTmp->SetMixMinStackSize();

    uint8_t type;
    if (mixProcVersion == MIX_KERNEL_PROC_V1) { // old and traditional mix kernels, only judge by name
        type = static_cast<uint8_t>(MIX_AIC_AIV_MAIN_AIC);
    } else {    // mix kernels, judge by functionType and kernel name
        type = (kernel->funcType == static_cast<uint32_t>(KERNEL_FUNCTION_TYPE_MIX_AIC_MAIN)) ?
        static_cast<uint8_t>(MIX_AIC_AIV_MAIN_AIC) : static_cast<uint8_t>(MIX_AIC_AIV_MAIN_AIV);
    }
    kernelTmp->SetMixType(type);
    (void)GetPrefetchCnt(static_cast<Program *>(this), kernelTmp);
    kernelTmp->SetKernelAttrType(RT_KERNEL_ATTR_TYPE_MIX);

    RT_LOG(RT_LOG_INFO, "proc mix kernel register, kernel name=[%s], offset1=%llu, offset2=%llu, mixType1=%hu, "
        "mixType2=%hu, final mixType=%hu version=%u, kernelVfType=%u, shareMemSize=%u", kernel->name,
        kernelTmp->Offset_(), kernelTmp->Offset2_(), kernelTmpMixType, 
        mixType, kernelTmp->GetMixType(), mixProcVersion, kernelTmp->KernelVfType_(), kernelTmp->ShareMemSize_());
    return true;
}

rtError_t SetKernelTypeByMetaInfo(uint32_t funcType, Kernel *kernelOutput)
{
    switch (funcType) {
        case KERNEL_FUNCTION_TYPE_AICORE:
        case KERNEL_FUNCTION_TYPE_MIX_AIC_MAIN:
        case KERNEL_FUNCTION_TYPE_MIX_AIV_MAIN:
            kernelOutput->SetKernelAttrType(RT_KERNEL_ATTR_TYPE_AICORE);
            break;
        case KERNEL_FUNCTION_TYPE_AIC:
        case KERNEL_FUNCTION_TYPE_AIC_ROLLBACK:
            kernelOutput->SetKernelAttrType(RT_KERNEL_ATTR_TYPE_CUBE);
            break;
        case KERNEL_FUNCTION_TYPE_AIV:
        case KERNEL_FUNCTION_TYPE_AIV_ROLLBACK:
            kernelOutput->SetKernelAttrType(RT_KERNEL_ATTR_TYPE_VECTOR);
            break;
        default:
            // 走到这里表示没配置functype
            return RT_ERROR_INVALID_VALUE;
            break;
    }

    return RT_ERROR_NONE;
}

void ElfProgram::AdaptKernelAttrType(const RtKernel * const kernelInput, Kernel *kernelOutput)
{
    std::string kernelName;
    uint8_t mixType = static_cast<uint8_t>(NO_MIX);
    /* 这里只刷新算子第一次注册时的类型，肯定是非mix，mix算子的type在第二次刷新offset2时刷。
     * 1、首先严格按照算子名中的_mix_aic/_mic_aiv进行匹配是哪种非mix算子
     * 2、根据metainfo刷新，只关注枚举2、3，枚举4/5/6/7对应的kernel name肯定会带_mix_aic/_mic_aiv，在第一点中能匹配
     * 3、根据magic字段匹配
     */

    kernelName = AdjustKernelNameAndGetMixType(kernelInput, mixType);
    if (mixType == static_cast<uint8_t>(MIX_AIC)) {
        kernelOutput->SetKernelAttrType(RT_KERNEL_ATTR_TYPE_CUBE);
        return;
    } else if (mixType == static_cast<uint8_t>(MIX_AIV)) {
        kernelOutput->SetKernelAttrType(RT_KERNEL_ATTR_TYPE_VECTOR);
        return;
    }

    if (ContainsAscendMeta()) {
        rtError_t error = SetKernelTypeByMetaInfo(kernelInput->funcType, kernelOutput);
        COND_RETURN_NORMAL(error == RT_ERROR_NONE, "funcType=%u", kernelInput->funcType);
    }

    uint32_t magic = GetElfMagic();
    if (magic == RT_DEV_BINARY_MAGIC_ELF) {
        kernelOutput->SetKernelAttrType(RT_KERNEL_ATTR_TYPE_AICORE);
    } else if (magic == RT_DEV_BINARY_MAGIC_ELF_AICUBE) {
        kernelOutput->SetKernelAttrType(RT_KERNEL_ATTR_TYPE_CUBE);
    } else if (magic == RT_DEV_BINARY_MAGIC_ELF_AIVEC) {
        kernelOutput->SetKernelAttrType(RT_KERNEL_ATTR_TYPE_VECTOR);
    }

    RT_LOG(RT_LOG_DEBUG, "adapt function type mixType=%hu, funtype=%u, magic=%u",
        mixType, kernelInput->funcType, magic);
    return;
}

void ElfProgram::SetKernelAttribute(const RtKernel * const kernel, Kernel * const kernelObj, const uint32_t kernelType)
{
    AdaptKernelAttrType(kernel, kernelObj);
    const uint32_t nameOffset = AppendKernelName(kernel->name);
    kernelObj->SetNameOffset(nameOffset);
    kernelObj->SetDfxSize(kernel->dfxSize);
    kernelObj->SetDfxAddr(kernel->dfxAddr);
    kernelObj->SetElfDataFlag(kernel->elfDataFlag);
    kernelObj->SetKernelLength1(static_cast<uint32_t>(kernel->length));
    kernelObj->SetMinStackSize1(kernel->minStackSize);
    kernelObj->SetUserParaNum(kernel->userArgsNum);
    kernelObj->SetKernelVfType_(kernel->kernelVfType);
    kernelObj->SetShareMemSize_(kernel->shareMemSize);
    kernelObj->SetSchedMode(kernel->schedMode);

    // only kernel with metainfo contains these info
    if (Machine() == Program::MACH_AI_MIX_KERNEL) {
        kernelObj->SetFuncType(kernel->funcType);
        kernelObj->SetKernelType_(kernelType);
        kernelObj->SetTaskRation(kernel->taskRation);
    } else {
        kernelObj->SetKernelType_(Machine());
    }

    uint16_t sysParamNum = 0U;
    if (kernelObj->IsSupportOverFlow()) {
        sysParamNum++;
    }
    const Runtime * const runtime = Runtime::Instance();
    NULL_PTR_RETURN_DIRECTLY(runtime);
    if ((IS_SUPPORT_CHIP_FEATURE(Runtime::Instance()->GetChipType(), RtOptionalFeatureType::RT_FEATURE_TASK_FFTS_PLUS)) &&
        !IsMetaFlagSupprotFfts() && (IsSupportInterCoreSync() || (kernel->crossCoreSync == FUNC_USE_SYNC) ||
        (kernelObj->GetMixType() != NO_MIX))) {
        kernelObj->SetIsNeedSetFftsAddrInArg(true);
        sysParamNum++;
    }
    kernelObj->SetSystemParaNum(sysParamNum);
    RT_LOG(RT_LOG_INFO, "kernel_name=%s, kernelType=%u, userParamNum=%hu, sysParamNum=%hu, IsNeedSetFftsAddrInArg=%u, "
        "isSupportOverFlow=%u, elfDataFlag=%d",
        kernel->name, kernelObj->KernelType_(), kernelObj->GetUserParaNum(), kernelObj->GetSystemParaNum(),
        kernelObj->IsNeedSetFftsAddrInArg(), kernelObj->IsSupportOverFlow(), kernelObj->ElfDataFlag());

    return;
}

void ElfProgram::DegenerateMixType(uint8_t &mixType) const
{
    if (!IS_SUPPORT_CHIP_FEATURE(Runtime::Instance()->GetChipType(), RtOptionalFeatureType::RT_FEATURE_KERNEL_MIX_DEGENERATE)) {
        return;
    }
    if ((mixType == static_cast<uint8_t>(MIX_AIC)) || (mixType == static_cast<uint8_t>(MIX_AIV))) {
        if (GetDegenerateFlag()) {
            RT_LOG(RT_LOG_DEBUG, "The current mixType is %d, degenerate to NO_MIX", mixType);
            mixType = static_cast<uint8_t>(NO_MIX);
        }
    }
}

rtError_t ElfProgram::CreateNewKernel(const RtKernel * const kernel, const std::string &kernelName,
                                      const uint8_t mixType, const uint64_t tilingKey, Kernel *&kernelObj)
{
    kernelObj = new (std::nothrow) Kernel(nullptr, kernelName.c_str(), tilingKey, this,
        static_cast<uint32_t>(kernel->offset), 0U, mixType);
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, kernelObj == nullptr, RT_ERROR_KERNEL_NEW,
        "Kernel register failed, allocate new Kernel failed.");

    RT_LOG(RT_LOG_INFO, "new kernel size %zu, original kernel_name=%s, register kernel_name=%s, tilingKey=%" PRIu64
        ", machine=%u, funcType=%u, mixType=%hu, taskRation=%u, offset=%u, dfxAddr=%#" PRIu64
        ", dfxSize=%u",
        sizeof(Kernel), kernel->name, kernelName.c_str(), tilingKey, Machine(), kernel->funcType, mixType,
        kernel->taskRation, static_cast<uint32_t>(kernel->offset),
        static_cast<uint64_t>(RtPtrToPtr<uintptr_t>(kernel->dfxAddr)), kernel->dfxSize);
    return RT_ERROR_NONE;
}

rtError_t ElfProgram::KernelAdd(Kernel *kernelPtr, const rtError_t tilingKeyParseRet)
{
    // add to program kernel map, key is kernel name
    rtError_t error = MixKernelAdd(kernelPtr);
    COND_RETURN_WITH_NOLOG((error != RT_ERROR_NONE), error);

    // If tilingKey is invalid, just skip.
    COND_RETURN_WITH_NOLOG((tilingKeyParseRet != RT_ERROR_NONE), RT_ERROR_NONE);

    /* kernelTable_ will maintain kernel and the function PutProgram() will release memory. */
    if (KernelTable_ == nullptr) {
        KernelTable_ = new (std::nothrow) rtKernelArray_t[GetKernelsCount()];
        COND_PROC_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, KernelTable_ == nullptr, RT_ERROR_MEMORY_ALLOCATION,
            (void)MixKernelRemove(kernelPtr), "new rtKernelArray_t fail, kernelCount=%u.", GetKernelsCount());
    }

    // If tiling key is valid, then register kernel to program kernel map. Insert key is tilingKey.
    bool isRepeated = false;
    error = AllKernelAdd(kernelPtr, isRepeated);
    if (error != RT_ERROR_NONE) {
        (void)MixKernelRemove(kernelPtr);
        return error;
    }
    return RT_ERROR_NONE;
}

rtError_t ElfProgram::UnifiedOneKernelRegister(const RtKernel * const kernel)
{
    std::string kernelName;
    Kernel *kernelObj;
    uint32_t kernelType = 0U;
    uint64_t tilingKey = 0ULL;
    uint8_t mixType = static_cast<uint8_t>(NO_MIX);

    if (machine_ == Program::MACH_AI_MIX_KERNEL) { /* Use metainfo, such as funcType, taskRation... */
        if (Runtime::Instance()->CheckMixKernelType(kernel) != RT_ERROR_NONE) {
            return RT_ERROR_INVALID_VALUE;
        }
        if (Runtime::Instance()->GetMixTypeAndKernelType(kernel, mixType, kernelType) != RT_ERROR_NONE) {
            return RT_ERROR_INVALID_VALUE;
        }

        // Remove mix_aic or mix_aiv from kernel name. Keep the tilingKey (e.g. _0123123).
        uint32_t mixProcVersion = MIX_KERNEL_PROC_V2;
        if (kernel->funcType == static_cast<uint32_t>(KERNEL_FUNCTION_TYPE_AICORE)) {
            kernelName = AdjustKernelNameAndGetMixType(kernel, mixType);
            mixProcVersion = MIX_KERNEL_PROC_V1;
        } else {
            kernelName = Runtime::Instance()->AdjustKernelName(kernel, mixType);
        }

        if (kernelName.empty()) {
            return RT_ERROR_INVALID_VALUE;
        }

        if (FindAndProcMixKernel(kernel, kernelName, mixType, mixProcVersion)) {
            return RT_ERROR_NONE;
        }
    } else { /* No metainfo, this is the traditional kernel register way. */
        // Remove mix_aic or mix_aiv from kernel name. Get mixType
        kernelName = AdjustKernelNameAndGetMixType(kernel, mixType);
        if (kernelName.empty()) {
            return RT_ERROR_INVALID_VALUE;
        }

        // Degenerate to NO_MIX by flag(__CCE_KernelMetaData)
        DegenerateMixType(mixType);

        if (FindAndProcMixKernel(kernel, kernelName, mixType, MIX_KERNEL_PROC_V1)) {
            return RT_ERROR_NONE;
        }
    }

    // 1. not support function entry info but support old tilingKey process
    rtError_t tilingKeyParseRet = ParseTilingKey(kernelName, tilingKey);
    // 2. support function entry info
    if (kernel->funcEntryType == KERNEL_TYPE_FUNCTION_ENTRY) {
        RT_LOG(RT_LOG_INFO, "support function entry mode.");
        tilingKey = kernel->functionEntry;
        tilingKeyParseRet = RT_ERROR_NONE;
    }
    rtError_t ret = CreateNewKernel(kernel, kernelName, mixType, tilingKey, kernelObj);
    if (ret != RT_ERROR_NONE) {
        return ret;
    }

    // set other attrs
    SetKernelAttribute(kernel, kernelObj, kernelType);
    (void)GetPrefetchCnt(static_cast<Program *>(this), kernelObj);

    // 3. not support tilingKey and not support function entry
    if (kernel->funcEntryType == KERNEL_TYPE_NOT_SUPPORT_FUNCTION_ENTRY) {
        // add to program kernel map, key is kernel name
        const rtError_t error = MixKernelAdd(kernelObj);
        COND_RETURN_WITH_NOLOG((error != RT_ERROR_NONE), error);
        return RT_ERROR_NONE;
    }

    ret = KernelAdd(kernelObj, tilingKeyParseRet);
    if (ret != RT_ERROR_NONE) {
        delete kernelObj;
        kernelObj = nullptr;
        RT_LOG(RT_LOG_ERROR, "create new kernel failed, kernel name=[%s]", kernel->name);
        return ret;
    }
    return RT_ERROR_NONE;
}

rtError_t ElfProgram::UnifiedKernelRegister()
{
    if ((kernels_ == nullptr) || (GetKernelsCount() == 0U)) {
        RT_LOG(RT_LOG_INFO, "kernels is empty, kernelCount=%u", GetKernelsCount());
        return RT_ERROR_NONE;
    }

    for (uint32_t idx = 0U; idx < GetKernelsCount(); idx++) {
        const rtError_t error = UnifiedOneKernelRegister(&kernels_[idx]);
        if (error != RT_ERROR_NONE) {
            RT_LOG(RT_LOG_ERROR, "kernel register failed, kernel name=[%s]", kernels_[idx].name);
            return error;
        }
    }
    return RT_ERROR_NONE;
}

rtError_t ElfProgram::RefreshSymbolAddr()
{
    return RefreshSymbolAddress(elfData_);
}

rtError_t ElfProgram::BinaryGetMetaInfo(const rtBinaryMetaType type, void *data, const uint32_t length)
{
    return GetBinaryMetaInfo(elfData_, type, data, length);
}

rtError_t ElfProgram::FunctionGetMetaInfo(const std::string &kernelName, const rtFunctionMetaType type,
                                          void *data, const uint32_t length)
{
    return GetFunctionMetaInfo(elfData_, kernelName, type, data, length);
}

void Program::RegCpuProgInfo(const void *data, const uint64_t length, const std::string &soName, const int32_t cpuRegMode,
    const bool isLoadFromFile)
{
    SaveBinaryData(data, length, isLoadFromFile);
    SetSoName(soName);

    cpuRegMode_ = cpuRegMode;

    return;
}

rtError_t Program::FreeCpuSoH2dMem(Device * const device, std::vector<void *> &allocatedMem) const
{
    RT_LOG(RT_LOG_DEBUG, "free cpu so start");
    rtError_t error = RT_ERROR_NONE;
    Driver *drv = device->Driver_();
    const uint32_t devId = static_cast<uint32_t>(device->Id_());
    for (auto &mem : allocatedMem) {
        RT_LOG(RT_LOG_DEBUG, "cpu kernel proc recycle memory");
        error = drv->DevMemFree(mem, devId);
        COND_PROC((error != RT_ERROR_NONE),
            RT_LOG(RT_LOG_ERROR, "free dev mem failed! error=%#x", error));
    }

    RT_LOG(RT_LOG_DEBUG, "free cpu so end");

    return RT_ERROR_NONE;
}

static bool IsNoNeedProcCpuH2DMem(const KernelRegisterType kernelRegType, const int32_t cpuRegMode)
{
    // cpuRegMode : 1 代表注册方式为so & json  2 代表通过LoadFromData
    return ((kernelRegType != RT_KERNEL_REG_TYPE_CPU) || ((cpuRegMode != 1) && (cpuRegMode != 2)));
}

// isLoadCpuSo  true 代表注册， false 代表卸载
rtError_t Program::ProcCpuKernelH2DMem(bool isLoadCpuSo, Device * const device)
{
    NULL_PTR_RETURN_MSG(device, RT_ERROR_DEVICE_NULL);
    if (IS_SUPPORT_CHIP_FEATURE(device->GetChipType(), RtOptionalFeatureType::RT_FEATURE_XPU)) {
        return RT_ERROR_NONE;
    }
    COND_RETURN_WITH_NOLOG(IsNoNeedProcCpuH2DMem(kernelRegType_, cpuRegMode_), RT_ERROR_NONE);
    rtError_t ret = RT_ERROR_NONE;
    std::vector<void *> allocMem;
    std::unique_ptr<Stream, void(*)(Stream*)> stm(StreamFactory::CreateStream(device, 0U, RT_STREAM_DEFAULT),
                                                  [](Stream* ptr) {ptr->Destructor();});
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, stm == nullptr, RT_ERROR_STREAM_NEW, "new Stream failed.");
    ret = stm->Setup();
    ERROR_RETURN_MSG_INNER(ret, "stream setup failed, retCode=%#x.", static_cast<uint32_t>(ret));

    const std::function<void()> recycle = [&device, &allocMem, &stm, this]() {
        this->FreeCpuSoH2dMem(device, allocMem);
        const auto error = (stm->TearDown());
        // Disable thread stream destroy task will delete stream, other condition, we should delete stream here
        // Disable thread free in stream destroy task recycle, stream destroy task send in TearDown process.
        if ((error == RT_ERROR_NONE) && (!Runtime::Instance()->GetDisableThread())) {
            (void)stm.release();
        }
    };
    ScopeGuard procCpuKernelGuard(recycle);

    const uint32_t devId = static_cast<uint32_t>(device->Id_());
    void *devSoBuff = nullptr;
    if (isLoadCpuSo) {
        ret = device->Driver_()->DevMemAlloc(&devSoBuff, binarySize_, RT_MEMORY_HBM, devId, DEFAULT_MODULEID);
        ERROR_RETURN(ret, "devSoBuff alloc failed! error=%#x", ret);
        allocMem.push_back(devSoBuff);

        ret = device->Driver_()->MemCopySync(devSoBuff, binarySize_, binary_, binarySize_, RT_MEMCPY_HOST_TO_DEVICE);
        ERROR_RETURN(ret, "devSoBuff copy failed! error=%#x", ret);
    }

    void *devSoName = nullptr;
    ret = device->Driver_()->DevMemAlloc(&devSoName, soName_.size(), RT_MEMORY_HBM, devId, DEFAULT_MODULEID);
    ERROR_RETURN(ret, "devSoName alloc failed! error=%#x", ret);
    allocMem.push_back(devSoName);

    ret = device->Driver_()->MemCopySync(devSoName, soName_.size(), soName_.c_str(), soName_.size(), RT_MEMCPY_HOST_TO_DEVICE);
    ERROR_RETURN(ret, "devSoName copy failed! error=%#x", ret);

    CpuSoBuf cpuSoBuf = {.kernelSoBuf = PtrToValue(devSoBuff), .kernelSoBufLen = static_cast<uint32_t>(binarySize_),
        .kernelSoName = PtrToValue(devSoName), .kernelSoNameLen = static_cast<uint32_t>(soName_.size())};

    // 1. alloc device memory for args
    // 2. copy cpuSoBuf to device memory
    void *args = nullptr;
    constexpr size_t argsSize = sizeof(CpuSoBuf);
    ret = device->Driver_()->DevMemAlloc(&args, argsSize, RT_MEMORY_HBM, devId, DEFAULT_MODULEID);
    ERROR_RETURN(ret, "args alloc failed! error=%#x", ret);
    allocMem.push_back(args);

    ret = device->Driver_()->MemCopySync(args, argsSize, &cpuSoBuf, argsSize, RT_MEMCPY_HOST_TO_DEVICE);
    ERROR_RETURN(ret, "args copy failed! error=%#x", ret);

    const std::string opName = isLoadCpuSo ? LOAD_CPU_SO : DELETE_CPU_SO;
    const rtKernelLaunchNames_t launchName = {nullptr, opName.c_str(), ""};
    ERROR_RETURN_MSG_INNER(Runtime::Instance()->StartAicpuSd(device),
        "Cpu kernel launch failed, check and start tsd open aicpu sd error.");

    // only 1 so
    BatchProcCpuOpFromBufArgs batchCpuSo = {.soNum = 1U, .args = PtrToValue(args)};
    rtArgsEx_t argsInfo = {};
    argsInfo.args = &batchCpuSo;
    argsInfo.argsSize = static_cast<uint32_t>(sizeof(BatchProcCpuOpFromBufArgs));
    argsInfo.isNoNeedH2DCopy = 0U; // 0 is need h2d copy

    ret = LaunchAicpuKernelForCpuSo(&launchName, &argsInfo, stm.get());
    ERROR_RETURN(ret, "launch cpu kernel failed! error=%#x", ret);

    ret = stm->Synchronize(false, -1);  // -1代表永不超时
    ERROR_RETURN(ret, "stream sync failed! error=%#x", ret);
    return RT_ERROR_NONE;
}

rtError_t Program::CopySoAndNameToCurrentDevice()
{
    rtError_t ret = RT_ERROR_NONE;
    Context *curCtx = Runtime::Instance()->CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    Device *device = curCtx->Device_();
    NULL_PTR_RETURN_MSG(device, RT_ERROR_DEVICE_NULL);
    if (!IsNewBinaryLoadFlow() || devicePtr_[device->Id_()] != nullptr) {
        RT_LOG(RT_LOG_INFO, "device_id=%d, handle=%p, isNewFlow=%d already copy or not need.", device->Id_(), this, IsNewBinaryLoadFlow());
        return ret;
    }
    {
        const std::lock_guard<std::mutex> lock(devValidMutex_[device->Id_()]);
        if (devicePtr_[device->Id_()] != nullptr) {
            RT_LOG(RT_LOG_INFO, "device_id=%d, handle=%p already copy.", device->Id_(), this);
            return ret;
        }
        if (!isLazyLoad_ && (kernelRegType_ == RT_KERNEL_REG_TYPE_NON_CPU)) {
            ret = Load2Device();
            ERROR_RETURN(ret, "load program to device_id=%d failed, retCode=%#x", device->Id_(), ret);
        }
        kernelMapLock_.Lock();
        for (auto item : kernelNameMap_) {
            // Aicpu算子注册时，把KernelName, soname存储至device侧，并把devAddr记录至kernel，从而args区无须填入kernelName, soname
            Kernel *kernel = item.second;
            ret = StoreKernelLiteralNameToDevice(kernel);
            if (unlikely(ret != RT_ERROR_NONE)) {
                RT_LOG(RT_LOG_ERROR, "fail to store kernel %s literal name to device_id=%d, retCode=%#x", item.first.c_str(), device->Id_(), ret);
                delete kernel;
                kernelNameMap_.erase(item.first);
            }
        }
        kernelMapLock_.Unlock();

        ret = ProcCpuKernelH2DMem(true, device);
        ERROR_RETURN(ret, "cpu kernel send to aicpu failed device_id=%d, retCode=%#x", device->Id_(), ret);
        devicePtr_[device->Id_()] = device;
    }
    device->RegisterProgram(this);
    return RT_ERROR_NONE;
}

void Program::SetDeviceSoAndNameInvalid(const uint32_t deviceId)
{
    const std::lock_guard<std::mutex> lock(devValidMutex_[deviceId]);
    devicePtr_[deviceId] = nullptr;
    soNameDevAddrMap_[deviceId].clear();
    funcNameDevAddrMap_[deviceId].clear();
    baseAddr_[deviceId] = nullptr;
    baseAddrAlign_[deviceId] = nullptr;
}

bool Program::IsDeviceSoAndNameValid(const uint32_t deviceId)
{
    if (!IsNewBinaryLoadFlow()) {
        return true;
    }
    return devicePtr_[deviceId] != nullptr;
}

void Program::SetProgramInvalidToDevice(const uint32_t deviceId)
{
    RT_LOG(RT_LOG_DEBUG, "begin to delete program=%p from device_id=%u.", this, deviceId);
    while (true) {
        devValidMutex_[deviceId].lock();
        if (devicePtr_[deviceId] == nullptr) {
            devValidMutex_[deviceId].unlock();
            break;
        }
        Device * dev =  devicePtr_[deviceId];
        if (dev->ProgramSetMutexTryLock()) {
            dev->UnRegisterProgram(this);
            devicePtr_[deviceId] = nullptr;
            dev->ProgramSetMutexUnLock();
            devValidMutex_[deviceId].unlock();
            break;
        } else {
            devValidMutex_[deviceId].unlock();
            std::this_thread::sleep_for(std::chrono::microseconds(10U));
        }
    }
    RT_LOG(RT_LOG_DEBUG, "delete program=%p from device_id=%u end.", this, deviceId);
    return;
}

rtError_t Program::FreeSoAndNameByDeviceId(const uint32_t deviceId)
{
    rtError_t error = RT_ERROR_NONE;
    {
        const std::lock_guard<std::mutex> lock(devValidMutex_[deviceId]);
        if (devicePtr_[deviceId] == nullptr) {
            return RT_ERROR_NONE;
        }
        error = Runtime::Instance()->BinaryUnLoad(devicePtr_[deviceId], this);
    }
    SetProgramInvalidToDevice(deviceId);
    return error;
}

static rtError_t BinaryMemAdvise(void * const devMem, const uint32_t devSize, rtAdviseMemType adviseType,
    const Device * const device, const bool readonly)
{
    if (!readonly) {
        return RT_ERROR_NONE;
    }

    uint32_t devId = device->Id_();
    Driver * const curDrv = device->Driver_();

    rtError_t error = curDrv->MemAdvise(devMem, static_cast<uint64_t>(devSize), static_cast<uint32_t>(adviseType), devId);
    // for compatibility between new and old packages, do not handle RT_ERROR_DRV_NOT_SUPPORT and RT_ERROR_DRV_INPUT.
    if ((error != RT_ERROR_NONE) && (error != RT_ERROR_DRV_NOT_SUPPORT) && (error != RT_ERROR_DRV_INPUT)) {
        RT_LOG(RT_LOG_ERROR, "advise memory, error=%u, dev_mem=%p, dev_size=%u, advise_type=%d, device_id=%u.", error, devMem, devSize, adviseType, devId);
        return error;
    }

    RT_LOG(RT_LOG_INFO, "advise memory, dev_mem=%p, dev_size=%u, advise_type=%d, device_id=%u.", devMem, devSize, adviseType, devId);
    return RT_ERROR_NONE;
}

TIMESTAMP_EXTERN(BinaryMemCpy);

rtError_t Program::BinaryMemCopySync(void * const devMem, const uint32_t adviseSize, const uint32_t size, void * const data,
    const Device * const device, const bool readonly)
{
    uint32_t devId = device->Id_();
    Driver * const curDrv = device->Driver_();

    RT_LOG(RT_LOG_INFO, "binary memcpy to dev_mem, dev_mem=%p, adviseSize=%u, size=%u, device_id=%u, readonly=%d.",
        devMem, adviseSize, size, devId, readonly);

    // in the UB scenario, read-only memory cannot be directly copied from host to device (H2D).
    // the memory needs to be set as readable and writable first.
    rtError_t error = BinaryMemAdvise(devMem, adviseSize, RT_ADVISE_ACCESS_READWRITE, device, readonly);
    ERROR_RETURN_MSG_INNER(error, "advise dev_mem failed, adviseSize=%u(bytes),"
        "type=%d(RT_ADVISE_ACCESS_READWRITE), retCode=%#x, device_id=%u.",
        adviseSize, static_cast<int32_t>(RT_ADVISE_ACCESS_READWRITE), static_cast<uint32_t>(error), devId);

    TIMESTAMP_BEGIN(BinaryMemCpy);
    error = curDrv->MemCopySync(devMem, static_cast<uint64_t>(size), data,
        static_cast<uint64_t>(size), RT_MEMCPY_HOST_TO_DEVICE);
    ERROR_RETURN_MSG_INNER(error, "memcpy failed, size=%u(bytes),"
        "type=%d(RT_MEMCPY_HOST_TO_DEVICE), retCode=%#x, device_id=%u.",
        size, static_cast<int32_t>(RT_MEMCPY_HOST_TO_DEVICE), static_cast<uint32_t>(error), devId);
    TIMESTAMP_END(BinaryMemCpy);

    // after the host-to-device (H2D) transfer is completed, the memory needs to be set as read-only.
    error = BinaryMemAdvise(devMem, adviseSize, RT_ADVISE_ACCESS_READONLY, device, readonly);
    ERROR_RETURN_MSG_INNER(error, "advise dev_mem failed, adviseSize=%u(bytes),"
        "type=%d(RT_ADVISE_ACCESS_READONLY), retCode=%#x, device_id=%u.",
        adviseSize, static_cast<int32_t>(RT_ADVISE_ACCESS_READONLY), static_cast<uint32_t>(error), devId);
    
    return RT_ERROR_NONE;
}

rtError_t Program::BinaryPoolMemCopySync(void * const devMem, const uint32_t size, void * const data,
    const Device * const device, const bool readonly)
{
    uint32_t devId = device->Id_();
    Driver * const curDrv = device->Driver_();
    // get the base address of the memory pool corresponding to the current memory.
    void *tmpAddr = const_cast<void *>(device->GetKernelMemoryPool()->GetMemoryPoolBaseAddr(devMem));
    void *const baseAddr = tmpAddr;
    // lock the current memory pool block.
    std::lock_guard<std::mutex> lock(*(device->GetKernelMemoryPool()->GetMemoryPoolAdviseMutex(devMem)));

    RT_LOG(RT_LOG_INFO, "binary memcpy to pool_mem, dev_mem=%p, size=%u, device_id=%u, readonly=%d.",
        devMem, size, devId, readonly);

    // in the UB scenario, read-only memory cannot be directly copied from host to device (H2D).
    // the memory needs to be set as readable and writable first.
    rtError_t error = BinaryMemAdvise(baseAddr, size, RT_ADVISE_ACCESS_READWRITE, device, readonly);
    ERROR_RETURN_MSG_INNER(error, "advise pool_mem failed, size=%u(bytes),"
        "type=%d(RT_ADVISE_ACCESS_READWRITE), retCode=%#x, device_id=%u.",
        size, static_cast<int32_t>(RT_ADVISE_ACCESS_READWRITE), static_cast<uint32_t>(error), devId);

    TIMESTAMP_BEGIN(BinaryMemCpy);
    error = curDrv->MemCopySync(devMem, static_cast<uint64_t>(size), data,
        static_cast<uint64_t>(size), RT_MEMCPY_HOST_TO_DEVICE);
    ERROR_RETURN_MSG_INNER(error, "memcpy failed, size=%u(bytes),"
        "type=%d(RT_MEMCPY_HOST_TO_DEVICE), retCode=%#x, device_id=%u.",
        size, static_cast<int32_t>(RT_MEMCPY_HOST_TO_DEVICE), static_cast<uint32_t>(error), devId);
    TIMESTAMP_END(BinaryMemCpy);

    // after the host-to-device (H2D) transfer is completed, the memory needs to be set as read-only.
    error = BinaryMemAdvise(baseAddr, size, RT_ADVISE_ACCESS_READONLY, device, readonly);
    ERROR_RETURN_MSG_INNER(error, "advise pool_mem failed, size=%u(bytes),"
        "type=%d(RT_ADVISE_ACCESS_READONLY), retCode=%#x, device_id=%u.",
        size, static_cast<int32_t>(RT_ADVISE_ACCESS_READONLY), static_cast<uint32_t>(error), devId);
    
    return RT_ERROR_NONE;
}

}
}