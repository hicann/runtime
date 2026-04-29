/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __CCE_RUNTIME_PROGRAM_HPP__
#define __CCE_RUNTIME_PROGRAM_HPP__
#include <vector>
#include <string>
#include <map>
#include "base.hpp"
#include "elf.hpp"
#include "runtime/elf_base.h"
#include "osal.hpp"
#include "kernel.hpp"

namespace cce {
namespace runtime {
const std::string LOAD_CPU_SO = "batchLoadsoFrombuf";
const std::string DELETE_CPU_SO = "deleteCustOp";
class Context;
class Module;
// The kernels program to be execuced on device cores. A program contains one
// or more kernel's code holded in continuous memory space.
struct rtKernelArray_t final {
    uint64_t TilingKey;
    Kernel *kernel;
};

struct TilingInfoExt {
    uint32_t shareMemSize; // for david tiling key
    uint32_t kernelVfType; // for david tiling key
};

struct TilingTabl final {
    uint64_t tilingKey;
    std::array<uint64_t, 2> pcInfo; // the number of functions is 2
    uint32_t taskRation;
    uint8_t mixType;
    std::array<uint8_t, 3> rsv; // 3 bytes are reserved
};

struct TilingTablForDavid final {
    uint64_t tilingKey;
    std::array<uint64_t, 2> pcInfo; // the number of functions is 2
    uint32_t taskRation;
    uint8_t mixType;
    std::array<uint8_t, 3> rsv; // 3 bytes are reserved
    union {
        TilingInfoExt tilingInfoExt;
        uint64_t rsv1;
    } u;
};

struct CpuKernelInfo {
    std::string key;
    std::string funcName;
    std::string kernelSo;
    std::string opKernelLib;
    bool isUserDefined;
    bool hasOpKernelLib;
};

class Program : public NoCopy {
public:
    static constexpr uint32_t PLAIN_PROGRAM    = 0U;
    static constexpr uint32_t ELF_PROGRAM      = 1U;

    static constexpr uint32_t PROGRAM_MEM_DDR  = 0U;
    static constexpr uint32_t PROGRAM_MEM_FAST = 1U;

    explicit Program(const rtKernelAttrType kernelAttrType = RT_KERNEL_ATTR_TYPE_AICORE);
    ~Program() override;

    // derenference for force free
    void Dereference();

    void Insert2CtxMap(Module ** const moduleItem, Context * const ctxItem);

    void Remove2CtxMap(Module ** const moduleItem);

    void SetId(uint32_t progId)
    {
        progId_ = progId;
    }

    uint32_t Id_() const
    {
        return progId_;
    }

    void SetType(uint32_t progType)
    {
        progType_ = progType;
    }

    uint32_t Type_() const
    {
        return progType_;
    }

    void SetProgMemType(uint32_t progMemType)
    {
        progMemType_ = progMemType;
    }

    uint32_t ProgMemType_() const
    {
        return progMemType_;
    }

    void *GetBinary() const
    {
        return binary_;
    }

    uint32_t GetBinarySize() const
    {
        return static_cast<uint32_t>(binarySize_);
    }

    const std::string &GetSoName() const
    {
        return soName_;
    }

    void SetSoName(const std::string &soName)
    {
        soName_ = soName;
    }

    const std::string &GetMetadata() const
    {
        return metadata_;
    }

    void SetMetadata(const std::string &metadata)
    {
        metadata_ = metadata;
    }

    void SetMachine(const uint32_t machine)
    {
        machine_ = machine;
    }

    void SetUnRegisteringFlag()
    {
        unRegisteringFlag_ = true;
    }

    bool GetUnRegisteringFlag() const
    {
        return unRegisteringFlag_;
    }

    void SetBinAlignBaseAddr(void *addr, const uint32_t deviceId)
    {
        baseAddrAlign_[deviceId] = addr;
    }

    const void *GetBinAlignBaseAddr(const uint32_t deviceId) const
    {
        return baseAddrAlign_[deviceId];
    }

    void SetBinBaseAddr(void *addr, const uint32_t deviceId)
    {
        baseAddr_[deviceId] = addr;
    }

    void *GetBinBaseAddr(const uint32_t deviceId) const
    {
        return baseAddr_[deviceId];
    }

    void SetBinPath(const std::string &binPath)
    {
        binPath_ = binPath;
    }

    const std::string &GetBinPath() const
    {
        return binPath_;
    }

    void SetStackSize(uint64_t stackSize)
    {
        stackSize_ = stackSize;
    }

    uint64_t GetStackSize() const
    {
        return stackSize_;
    }

    void SetIsLazyLoad(const bool isLazyLoad)
    {
        isLazyLoad_ = isLazyLoad;
    }

    bool IsSupportInterCoreSync() const
    {
        return isSupportInterCoreSync_;
    }

    void SetIsSupportInterCoreSync(const bool isSupportInterCoreSync)
    {
        isSupportInterCoreSync_ = isSupportInterCoreSync;
    }

    void SetIsDcacheLockOp(bool isDcacheLockOp)
    {
        isDcacheLockOp_ = isDcacheLockOp;
    }
 
    bool IsDcacheLockOp() const
    {
        return isDcacheLockOp_;
    }

    void SetIsNewBinaryLoadFlow(bool isNewBinaryLoadFlow)
    {
        isNewBinaryLoadFlow_ = isNewBinaryLoadFlow;
    }
 
    bool IsNewBinaryLoadFlow() const
    {
        return isNewBinaryLoadFlow_;
    }

    KernelRegisterType GetKernelRegType() const
    {
        return kernelRegType_;
    }

    void SetKernelRegType(const KernelRegisterType type)
    {
        kernelRegType_ = type;
    }
    
    std::map<Module **, Context *> &GetCtxMap() {
        return mapUsedCtx_;
    }

    const std::map<std::string, void*>& GetSoNameDevAddrMap(const uint32_t deviceId) const
    {
        return soNameDevAddrMap_[deviceId];
    }

    const std::map<std::string, void*>& GetFuncNameDevAddrMap(const uint32_t deviceId) const
    {
        return funcNameDevAddrMap_[deviceId];
    }

    const std::map<std::string, Kernel *>& GetKernelNameMap(void) const
    {
        return kernelNameMap_;
    }

    void SetDefaultKernelAttrType(rtKernelAttrType type)
    {
        defaultBinaryType_ = type;
    }

    rtKernelAttrType GetDefaultKernelAttrType(void) const
    {
        return defaultBinaryType_;
    }

    rtError_t Register(const void *data, const uint64_t length, const bool isLoadFromFile = false);
    // register only cpu kernel by json
    rtError_t RegisterCpuKernel(const std::vector<CpuKernelInfo> &kernelInfos);
    rtError_t XpuSetKernelLiteralNameDevAddr(Kernel *kernel, const uint32_t devId);
    // register only cpu kernel by single cpu info
    rtError_t RegisterSingleCpuKernel(const char *const funcName, const char *const kernelName,
        Kernel **kernelHandle);
    void HalfSearch(const uint32_t searchLen, const uint64_t target,
                    rtHalfSearchResult_t *halfSearchResult) const;
    Kernel* SearchKernelByPcAddr(const uint64_t pcAddr) const;
    rtError_t ArrayInsert(const int32_t insertIndex, const uint64_t tilingKey,
                          Kernel *&addKernel, const uint32_t curLen);
    rtError_t AllKernelAdd(Kernel *&addKernel, bool &isRepeated);
    Kernel *AllKernelLookup(const uint64_t tilingKey, const bool getProgFlag = true);
    const Kernel *GetKernelByTillingKey(const uint64_t tilingKey);
    rtError_t KernelNameMapAdd(Kernel *&addKernel);
    const Kernel *GetKernelByName(const char_t *kernelName);

    void DependencyRegister(Program * const prog);

    void LoadDependencies(Context * const ctxItem);

    uint32_t AppendKernelName(const char_t *kernelName);

    const std::string &GetKernelNamesBuffer() const;
    virtual uint32_t SymbolOffset(const void * const symbol, uint32_t &length) = 0;
    virtual uint32_t LoadSize() = 0;
    virtual bool IsReadOnly() = 0;
    virtual rtError_t LoadExtract(void *output, uint32_t size) = 0;
    virtual void *Data() = 0;
    virtual rtError_t GetKernel(const void * const symbol, RtKernel &kernel) = 0;
    virtual rtError_t RefreshSymbolAddr() = 0;
    virtual rtError_t BinaryGetMetaNum(const rtBinaryMetaType type, size_t *numOfMeta) = 0;
    virtual rtError_t BinaryGetMetaInfo(const rtBinaryMetaType type, const size_t numOfMeta, void **data,
                                        const size_t *dataSize) = 0;
    virtual rtError_t FunctionGetMetaInfo(const std::string &kernelName, const rtFunctionMetaType type,
                                          void *data, const uint32_t length) = 0;

    rtError_t BuildTilingTbl(TilingTabl **tilingTab, uint32_t *kernelLen);
    rtError_t BuildTilingTblForDavid(const Module *mdl, TilingTablForDavid **tilingTab, uint32_t *kernelLen);
    rtError_t DavidBuildTilingTblForNewFlow(TilingTablForDavid **tilingTab, uint32_t *kernelLen);
    void DestroyTilingTbl(TilingTabl *tilingTab) const;
    void DestroyTilingTblForDavid(TilingTablForDavid *tilingTab) const;
    rtError_t CheckLoaded2Device();
    rtError_t Load2Device();
    virtual rtError_t ParserBinary()
    {
        return RT_ERROR_NONE;
    }
    uint32_t GetMaxMinStackSize() const;
    rtError_t StoreKernelLiteralNameToDevice(Kernel *const kernel);
    rtError_t FreeKernelLiteralNameDevMem(const Device *const device);
    void RegCpuProgInfo(const void *data, const uint64_t length, const std::string &soName, const int32_t cpuRegMode,
        const bool isLoadFromFile = false);
    rtError_t ProcCpuKernelH2DMem(bool isLoadCpuSo, Device * const device);
    rtError_t CopySoAndNameToCurrentDevice();
    rtError_t FreeSoAndNameByDeviceId(const uint32_t deviceId);
    void SetProgramInvalidToDevice(const uint32_t deviceId);
    void SetDeviceSoAndNameInvalid(const uint32_t deviceId);
    bool IsDeviceSoAndNameValid(const uint32_t deviceId);
    static rtError_t BinaryMemCopySync(void * const devMem, const uint32_t adviseSize, const uint32_t size, void * const data,
        const Device * const device, const bool readonly);
    static rtError_t BinaryPoolMemCopySync(void * const devMem, const uint32_t size, void * const data,
        const Device * const device, const bool readonly);

    rtKernelArray_t *KernelTable_;
    uint32_t kernelCount_;
    uint32_t kernelPos_;
    void *binary_;
    uint64_t binarySize_;
    uint32_t machine_;
    std::string soName_;
    std::string metadata_;
    std::string kernelNames_;
    std::mutex devValidMutex_[RT_MAX_DEV_NUM];
    Device *devicePtr_[RT_MAX_DEV_NUM] = {nullptr};
    rtOpExceptionCallback opExceptionCallback_{nullptr};
    void *opExceptionCallbackUserData_{nullptr};

private:
    uint32_t progId_;
    uint32_t progType_;
    uint32_t progMemType_;
    bool unRegisteringFlag_ = false;
    rtKernelAttrType defaultBinaryType_;
    std::vector<Program *> dependencies_;
    std::map<Module **, Context *> mapUsedCtx_;
    SpinLock mapLock_;
    SpinLock kernelMapLock_;
    void *baseAddr_[RT_MAX_DEV_NUM] = {nullptr};
    void *baseAddrAlign_[RT_MAX_DEV_NUM] = {nullptr};
    void *binHandle_{nullptr};
	std::string binPath_;
    std::map<std::string, Kernel *> kernelNameMap_;
    uint64_t stackSize_{0ULL};        // 算子的栈大小，32k/16k
    SpinLock load2DeviceLock_;
    bool isLazyLoad_ = false;
    bool isUserData_ = true; // if the data not malloc by user, need free the memory when delete program
    bool isSupportInterCoreSync_ = false;
    bool isDcacheLockOp_{false};
    bool isNewBinaryLoadFlow_{false};
    KernelRegisterType kernelRegType_{RT_KERNEL_REG_TYPE_NON_CPU};
    int32_t cpuRegMode_ = -1;
    std::map<std::string, void *> soNameDevAddrMap_[RT_MAX_DEV_NUM];
    std::map<std::string, void *> funcNameDevAddrMap_[RT_MAX_DEV_NUM];
    rtError_t CopyKernelLiteralNameToDevice(const std::string &literalName, void **devAddrHandle, const Device * const dev) const;
    void SaveBinaryData(const void *data, uint64_t length, const bool isLoadFromFile);
    rtError_t FreeCpuSoH2dMem(Device * const device, std::vector<void *> &allocatedMem) const;
};

class PlainProgram : public Program {
public:
    explicit PlainProgram(const rtKernelAttrType kernelAttrType = RT_KERNEL_ATTR_TYPE_AICORE);
    explicit PlainProgram(const KernelRegisterType kernelRegType, const rtKernelAttrType kernelAttrType = RT_KERNEL_ATTR_TYPE_AICPU);
    ~PlainProgram() override;
    uint32_t SymbolOffset(const void * const symbol, uint32_t &length) override;
    uint32_t LoadSize() override;
    bool IsReadOnly() override;
    rtError_t LoadExtract(void * const output, const uint32_t size) override;
    void *Data() override;
    rtError_t GetKernel(const void * const symbol, RtKernel &kernel) override;
    rtError_t RefreshSymbolAddr() override;
    rtError_t BinaryGetMetaNum(const rtBinaryMetaType type, size_t *numOfMeta) override;
    rtError_t BinaryGetMetaInfo(const rtBinaryMetaType type, const size_t numOfMeta, void **data,
                                const size_t *dataSize) override;
    rtError_t FunctionGetMetaInfo(const std::string &kernelName, const rtFunctionMetaType type,
                                  void *data, const uint32_t length) override;
};

class ElfProgram : public Program {
public:
    explicit ElfProgram(const rtKernelAttrType kernelAttrType = RT_KERNEL_ATTR_TYPE_AICORE);
    ~ElfProgram() override;
    uint32_t SymbolOffset(const void * const symbol, uint32_t &length) override;
    uint32_t LoadSize() override;
    bool IsReadOnly() override;
    rtError_t LoadExtract(void * const output, const uint32_t size) override;
    void *Data() override;
    rtError_t GetKernel(const void * const symbol, RtKernel &kernel) override;
    rtError_t RefreshSymbolAddr() override;
    rtError_t BinaryGetMetaInfo(const rtBinaryMetaType type, const size_t numOfMeta, void **data,
                                const size_t *dataSize) override;
    rtError_t BinaryGetMetaNum(const rtBinaryMetaType type, size_t *numOfMeta) override;
    rtError_t FunctionGetMetaInfo(const std::string &kernelName, const rtFunctionMetaType type,
                                  void *data, const uint32_t length) override;

    rtError_t UnifiedKernelRegister();
    rtError_t RegisterAllKernelCommon(void);
    std::string AdjustKernelName(const std::string kernelName) const;
    rtError_t BuildNewKernel(const std::string tripKernelName, const RtKernel * const elfkernelInfo,
        Kernel * &kernel);
    rtError_t MergeKernel(const RtKernel * const elfkernelInfo, Kernel *oldKernel);

    bool IsMetaFlagSupprotFfts() const
    {
        if ((elfData_->ascendMetaFlag & KERNEL_FFTS_ADDR_BIT) != 0) {
            return true;
        }

        return false;
    }

    const RtKernel *GetKernels() const
    {
        return kernels_;
    }

    uint32_t GetKernelsCount()
    {
        return elfData_->kernel_num;
    }

    uint32_t GetElfMagic() const
    {
        return magic_;
    }

    void SetElfMagic(uint32_t magic)
    {
        magic_ = magic;
    }

protected:
    rtError_t ParserBinary() override;

private:
    void SetKernelAttribute(const RtKernel * const kernel, Kernel * const kernelObj);
    rtError_t ParseTilingKey(const std::string &kernelName, uint64_t &tilingKey) const;
    rtError_t GetKernelTypeAndMixTypeByMetaInfo(const RtKernel * const elfkernelInfo,
        rtKernelAttrType &kernelAttrType, uint8_t &mixType);
    void GetKernelTypeAndMixTypeByName(const std::string kernelName,
        rtKernelAttrType &kernelAttrType, uint8_t &mixType);
    rtError_t GetKernelTypeAndMixType(const RtKernel * const elfkernelInfo,
        rtKernelAttrType &kernelAttrType, uint8_t &mixType);

    rtElfData *elfData_;
    RtKernel *kernels_;
    uint32_t magic_{0U};
};
}
}

#endif  // __CCE_RUNTIME_PROGRAM_HPP__
