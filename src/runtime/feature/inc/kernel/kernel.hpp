/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_KERNEL_TABLE_HPP
#define CCE_RUNTIME_KERNEL_TABLE_HPP

#include <map>
#include <string>
#include <vector>
#include <unordered_map>
#include <mutex>

#include "base.hpp"
#include "osal.hpp"
#include "elf.hpp"
#include "device.hpp"

#define SIMT_PREFETCH_INCREASE_SIZE  (1280U)  //1280byte
namespace cce {
namespace runtime {
constexpr uint32_t KERNEL_ARRAY_SIZE_PER_ALLOC = 2048U;

// 算子注册的类型分为CPU算子和非CPU算子
// 对于AIC/AIV/MIX都默认为非CPU算子，即：RT_KERNEL_REG_TYPE_NON_CPU
// CPU算子注册，即：RT_KERNEL_REG_TYPE_CPU
enum KernelRegisterType : int32_t {
    RT_KERNEL_REG_TYPE_CPU = 0,
    RT_KERNEL_REG_TYPE_NON_CPU,
};

class Program;

class Kernel {
public:
    Kernel(const void * const stubFunc, const char_t * const kernelName, const char_t * const kernelInfoExtern,
        Program * const prog, const uint32_t funcOffset1, const uint32_t funcOffset2 = 0U,
        const uint8_t mixType = 0U, const uint32_t taskRation = NONE_TASK_RATION, const uint32_t funcType = 0);
    Kernel(const void * const stubFunc, const char_t * const kernelName, const uint64_t key, Program * const prog,
        const uint32_t funcOffset1, const uint32_t funcOffset2 = 0U, const uint8_t mixType = 0U,
        const uint32_t taskRation = NONE_TASK_RATION, const uint32_t funcType = 0);
    Kernel(const std::string &cpuKernelSo, const std::string &cpuFunctionName, const std::string &cpuOpType);

    Kernel(const Kernel &) = delete;
    Kernel &operator=(const Kernel &) = delete;
    Kernel(Kernel &&) = delete;
    Kernel &operator=(Kernel &&) = delete;

    uint32_t Offset_() const
    {
        return offset1_;
    }

    uint32_t Offset2_() const
    {
        return offset2_;
    }

    void SetOffset(const uint32_t offset1)
    {
        offset1_ = offset1;
    }

    void SetOffset2(const uint32_t offset2)
    {
        offset2_ = offset2;
    }

    void SetKernelLength1(const uint32_t len)
    {
        length1_ = len;
    }

    void SetKernelLength2(const uint32_t len)
    {
        length2_ = len;
    }
    void SetMixType(const uint8_t mixType)
    {
        mixType_ = mixType;
    }

    uint8_t GetMixType() const
    {
        return mixType_;
    }

    Program *Program_() const
    {
        return program_;
    }

    const std::string &Name_() const
    {
        return name_;
    }

    void SetKernelType_(const uint32_t kernelType)
    {
        kernelType_ = kernelType;
    }

    uint32_t KernelType_() const
    {
        return kernelType_;
    }

    void SetKernelAttrType(const rtKernelAttrType kernelAttrType)
    {
        kernelAttrType_ = kernelAttrType;
    }

    rtKernelAttrType GetKernelAttrType() const
    {
        return kernelAttrType_;
    }

    const char_t *KernelInfoExt_() const
    {
        return kernelInfoExt_.c_str();
    }

    void SetKernelInfoExt(const char_t * const kernelInfoExtern)
    {
        if (kernelInfoExtern != nullptr) {
            kernelInfoExt_ = std::string(kernelInfoExtern);
        }
    }

    uint16_t DfxSize() const
    {
        return dfxSize_;
    }
 
    void SetDfxSize(const uint16_t dfxSize)
    {
        dfxSize_ = dfxSize;
    }
 
    const void *DfxAddr() const
    {
        return dfxAddr_;
    }
 
    void SetDfxAddr(const void * const dfxAddr)
    {
        dfxAddr_ = dfxAddr;
    }

    int32_t ElfDataFlag() const
    {
        return elfDataFlag_;
    }
 
    void SetElfDataFlag(const int32_t elfDataFlag)
    {
        elfDataFlag_ = elfDataFlag;
    }

    const std::string &KernelInfoExtString() const
    {
        return kernelInfoExt_;
    }

    uint64_t TilingKey() const
    {
        return tilingKey_;
    }

    const void *Stub_() const
    {
        return stubFun_;
    }

    uint32_t NameOffset() const
    {
        return nameOffset_;
    }

    void SetNameOffset(const uint32_t offset)
    {
        nameOffset_ = offset;
    }

    void SetPctraceFlag(const uint32_t pctraceFlag)
    {
        pctraceFlag_ = pctraceFlag;
    }

    uint32_t PctraceFlag() const
    {
        return pctraceFlag_;
    }

    void SetTaskRation(const uint32_t taskRation)
    {
        taskRation_ = taskRation;
    }

    uint32_t GetTaskRation() const
    {
        return taskRation_;
    }

    void SetFuncType(const uint32_t funcType)
    {
        funcType_ = funcType;
    }

    uint32_t GetFuncType() const {
        return funcType_;
    }

    void SetSimtFlag_(bool flag)
    {
        simtFlag_ = flag;
    }

    bool SimtFlag_() const
    {
        return simtFlag_;
    }

    void SetShareMemSize_(uint32_t shareMemSize)
    {
        shareMemSize_ = shareMemSize;
    }

    uint32_t ShareMemSize_() const
    {
        return shareMemSize_;
    }

    void SetPrefetchCnt1_(uint32_t cnt)
    {
        prefetchCnt1_ = cnt;
    }

    uint32_t PrefetchCnt1_() const
    {
        return prefetchCnt1_;
    }

    void SetPrefetchCnt2_(uint32_t cnt)
    {
        prefetchCnt2_ = cnt;
    }

    uint32_t PrefetchCnt2_() const
    {
        return prefetchCnt2_;
    }
    uint64_t GetNameId();
    void ResetNameId() // 仅在KernelTable中调用，外部保证加锁
    {
        nameId_ = 0U;
    }

    void GetKernelLength(uint32_t &length1, uint32_t &length2) const
    {
        length1 = length1_;
        length2 = length2_;
    }

    rtError_t GetFunctionDevAddr(uint64_t &func1, uint64_t &func2) const;

    void SetUserParaNum(uint16_t userParaNum)
    {
        userParaNum_ = userParaNum;
    }

    uint16_t GetUserParaNum() const
    {
        return userParaNum_;
    }

    void SetSystemParaNum(uint16_t sysParaNum)
    {
        systemParaNum_ = sysParaNum;
    }

    uint16_t GetSystemParaNum() const
    {
        return systemParaNum_;
    }

    bool IsSupportOverFlow() const
    {
        return isSupportOverFlow_;
    }

    void SetIsSupportOverFlow(const bool supportOverflow)
    {
        isSupportOverFlow_ = supportOverflow;
    }

    void SetIsNeedSetFftsAddrInArg(const bool isNeedSetFftsAddrInArg)
    {
        isNeedSetFftsAddrInArg_ = isNeedSetFftsAddrInArg;
    }

    bool IsNeedSetFftsAddrInArg() const
    {
        return isNeedSetFftsAddrInArg_;
    }

    std::string GetCpuOpType() const
    {
        return cpuOpType_;
    }

    void SetCpuOpType(const std::string &cpuOpType)
    {
        cpuOpType_ = cpuOpType;
        // cpu算子Name_和OpType_相同概念
        name_ = cpuOpType_;
    }

    std::string GetCpuKernelSo() const
    {
        return cpuKernelSo_;
    }

    void SetCpuKernelSo(const std::string &kernelSo)
    {
        cpuKernelSo_ = kernelSo;
    }

    std::string GetCpuFuncName() const
    {
        return cpuFunctionName_;
    }

    void SetCpuFuncName(const std::string &funcName)
    {
        cpuFunctionName_ = funcName;
    }

    KernelRegisterType GetKernelRegisterType() const
    {
        return kernelRegisterType_;
    }

    void SetKernelRegisterType(const KernelRegisterType type)
    {
        kernelRegisterType_ = type;
    }

    void SetMinStackSize1(uint32_t minStackSize)
    {
        minStackSize1_ = minStackSize;
    }

    uint32_t GetMinStackSize1() const
    {
        return minStackSize1_;
    }

    void SetMinStackSize2(uint32_t minStackSize)
    {
        minStackSize2_ = minStackSize;
    }

    uint32_t GetMinStackSize2() const
    {
        return minStackSize2_;
    }

    void SetMixMinStackSize();

    void SetKernelLiteralNameDevAddr(void *cpuSoNameDevAddr, void *cpuFuncNameDevAddr, const uint32_t devId)
    {
        cpuSoNameDevAddr_[devId] = cpuSoNameDevAddr;
        cpuFuncNameDevAddr_[devId] = cpuFuncNameDevAddr;
    }

    void *GetSoNameDevAddr(const uint32_t devId) const
    {
        return cpuSoNameDevAddr_[devId];
    }

    void *GetFuncNameDevAddr(const uint32_t devId) const
    {
        return cpuFuncNameDevAddr_[devId];
    }
private:
    Program *program_;
    uint32_t kernelType_;
    rtKernelAttrType kernelAttrType_ = static_cast<rtKernelAttrType>(0x7FFFFFFF); //当前是kernel launch劫持用的，后续可以用于sqe填写
    const void *stubFun_;
    std::string name_;
    std::string kernelInfoExt_;
    uint64_t tilingKey_;
    uint32_t offset1_;
    uint32_t offset2_;
    uint32_t length1_;
    uint32_t length2_;
    uint32_t minStackSize1_{0U}; // aic min stack size
    uint32_t minStackSize2_{0U}; // aiv min stack size
    uint32_t pctraceFlag_;
    uint32_t nameOffset_;
    uint8_t mixType_;
    uint32_t taskRation_;     // task ration of aic : aiv
    uint32_t funcType_;
    uint16_t userParaNum_;
    uint16_t systemParaNum_;
    bool isNeedSetFftsAddrInArg_ = false;
    bool isSupportOverFlow_ = true;

    const void *dfxAddr_;
    uint16_t dfxSize_;
    int32_t elfDataFlag_;
    uint64_t nameId_; // hash id for profiling
    std::mutex kernelMtx_;
	bool simtFlag_;
    uint32_t shareMemSize_;
    uint32_t prefetchCnt1_;
    uint32_t prefetchCnt2_;
    KernelRegisterType kernelRegisterType_ = KernelRegisterType::RT_KERNEL_REG_TYPE_NON_CPU;

    // user for cpu Kernel
    std::string cpuOpType_;
    std::string cpuKernelSo_;
    std::string cpuFunctionName_;
    void *cpuSoNameDevAddr_[RT_MAX_DEV_NUM] = {nullptr};
    void *cpuFuncNameDevAddr_[RT_MAX_DEV_NUM] = {nullptr};
};

typedef struct rtAllKernelMapKey {
    uint64_t kernelInfoExt;
    const Program *program;
} rtAllKernelMapKey_t;

struct AllKernelHash {
    std::size_t operator()(const rtAllKernelMapKey_t & objKey) const
    {
        return std::hash<const Program *>()(objKey.program) +
            std::hash<uint64_t>()(objKey.kernelInfoExt);
    }
};

struct AllKernelEqual
{
    bool operator () (const rtAllKernelMapKey_t &objKey1, const rtAllKernelMapKey_t &objKey2) const
    {
        return (objKey1.kernelInfoExt == objKey2.kernelInfoExt) && (objKey1.program == objKey2.program);
    }
};

typedef struct {
    const void *stub;
    Kernel *kernel;
} rtKernelArr_t;

typedef struct {
    rtAllKernelMapKey_t kernelKey;
    Kernel *kernel;
} rtAllKernelArr_t;

typedef struct {
    bool matchFlag;
    int32_t  matchIndex;
} rtHalfSearchResult_t;

class KernelTable {
public:
    KernelTable();
    ~KernelTable();

    void HalfSearch(const uint32_t searchLen, const void * const stub,
                    rtHalfSearchResult_t *halfSearchResult);
    rtError_t ArrayInsert(const int32_t insertIndex, const void * const stub,
                          Kernel *&addKernel);
    rtError_t AllocKernelArr();
    rtError_t Add(Kernel *&addKernel);
    rtError_t RemoveAll(const Program * const prog);

    Kernel *Lookup(const void * const stub);
    const void *InvLookup(const char_t * const name);
    const Kernel *KernelInfoExtLookup(const char_t * const stubFunc);

    void ResetAllKernelNameId();
private:
    SpinLock kernelMapLock_;
    std::map<std::string, Kernel *> kernelInfoExtMap_;
    std::map<std::string, const void *> invKernelMap_;
    std::multimap<const Program *, const void *> programStubMultiMap_;
    rtKernelArr_t *kernelArr_;
    uint32_t rtKernelArrPos_;
    uint32_t kernelArrAllocTimes_;
};

rtError_t GetPrefetchCnt(const Program *prog, Kernel * const kernel);
}
}

#endif  // CCE_RUNTIME_KERNEL_TABLE_HPP
