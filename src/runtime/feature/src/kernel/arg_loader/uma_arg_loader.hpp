/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_UMA_ARG_LOADER_HPP
#define CCE_RUNTIME_UMA_ARG_LOADER_HPP

#include "arg_loader.hpp"

namespace cce {
namespace runtime {
class UmaArgLoader : public ArgLoader {
public:
    explicit UmaArgLoader(Device * const dev);
    ~UmaArgLoader() override;

    rtError_t Init() override;
    rtError_t AllocCopyPtr(const uint32_t size, ArgLoaderResult * const result) override;
    rtError_t Load(const uint32_t kernelType, const rtArgsEx_t * const argsInfo, rtSmDesc_t * const smDesc,
                   Stream * const stm, ArgLoaderResult * const result) override;
    rtError_t PureLoad(const uint32_t size, const void * const args, ArgLoaderResult * const result) override;
    rtError_t LoadForMix(const uint32_t kernelType, const rtArgsEx_t * const argsInfo,
                         rtSmDesc_t * const smDesc, Stream * const stm, ArgLoaderResult * const result, bool &mixOpt) override;
    rtError_t Release(void * const argHandle) override;
    rtError_t LoadCpuKernelArgs(const rtArgsEx_t * const argsInfo, Stream * const stm,
                                ArgLoaderResult * const result) override;
    rtError_t LoadCpuKernelArgsEx(const rtAicpuArgsEx_t * const argsInfo, Stream * const stm,
                                  ArgLoaderResult * const result) override;
    rtError_t GetKernelInfoDevAddr(const char_t * const name, const KernelInfoType type, void ** const addr) override;
    rtError_t LoadStreamSwitchNArgs(Stream * const stm, const void * const valuePtr, const uint32_t valueSize,
                                    Stream ** const trueStreamPtr, const uint32_t elementSize,
                                    const rtSwitchDataType_t dataType, StreamSwitchNLoadResult * const result) override;
    void GetKernelInfoFromAddr(std::string &name, const KernelInfoType type, void* addr) override;
    bool CheckPcieBar(void) override;
    void RestoreAiCpuKernelInfo(void) override;
    H2DCopyMgr *GetPcieBarAllocator(void)
    {
        return argPcieBarAllocator_;
    }

    H2DCopyMgr *GetArgsAllocator(void)
    {
        return argAllocator_;
    }
 
    H2DCopyMgr *GetSuperArgsAllocator(void)
    {
        return superArgAllocator_;
    }
 
    H2DCopyMgr *GetMaxArgsAllocator(void)
    {
        return maxArgAllocator_;
    }
 
    H2DCopyMgr *GetRandomAllocator(void)
    {
        return randomAllocator_;
    }
private:
    void UpdateAddrField(const void * const kerArgs,
                         void * const argsHostAddr,
                         const uint16_t hostInputInfoNum,
                         const rtHostInputInfo * const hostInputInfoPtr) const;
    void UpdateArgsAddr(const void * const kerArgs, const rtArgsEx_t *argsInfo) const;
    void UpdateAicpuArgsEx(const void * const kerArgs, const rtAicpuArgsEx_t *argsInfo) const;
    static void *MallocBuffer(const size_t size, void * const para);
    static void FreeBuffer(void * const addr, void * const para);
    rtError_t FindOrInsertDevAddr(const char_t * const name, std::unordered_map<std::string, void *> &nameMap,
                                  void ** const addr) const;
    rtError_t LoadSmDescArgs(const rtSmDesc_t * const smDesc, void ** const smArgs, bool &copyL2Desc, bool &freeL2Desc) const;
    rtError_t LoadInputOutputArgsHuge(const Stream * const stm, void *&kerArgs, H2DCopyMgr * const umaArgAllocator,
                                            bool &copyArgs, const uint32_t size,
                                            const void * const args, const rtArgsEx_t * const argsInfo) const;

    rtError_t LoadInputOutputArgs(const Stream * const stm, void *&kerArgs, H2DCopyMgr * const umaArgAllocator,
                                  bool &copyArgs, const uint32_t kernelType, const uint32_t size, const void * const args,
                                  const rtArgsEx_t * const argsInfo) const;
    rtError_t LoadInputOutputArgsForMix(const Stream * const stm, void *kerArgs, H2DCopyMgr * const umaArgAllocator,
                                        bool &copyArgs, const uint32_t kernelType, const uint32_t size, const void * const args,
                                        const rtArgsEx_t * const argsInfo) const;
    void FindKernelInfoName(std::string &name, std::unordered_map<std::string, void *> &nameMap, const void *addr) const;

    H2DCopyMgr *argAllocator_;
    H2DCopyMgr *superArgAllocator_;
    H2DCopyMgr *maxArgAllocator_;   // transpose kernel args allocator
    H2DCopyMgr *argPcieBarAllocator_;
    H2DCopyMgr *randomAllocator_;

    BufferAllocator *handleAllocator_;
    BufferAllocator *kernelInfoAllocator_;
    std::mutex soNameMapLock_;
    std::unordered_map<std::string, void *> soNameMap_;
    std::mutex kernelNameMapLock_;
    std::unordered_map<std::string, void *> kernelNameMap_;
    uint32_t itemSize_;
    uint32_t maxItemSize_;  // transpose kernel args size
};
}  // namespace runtime
}  // namespace cce
#endif  // CCE_RUNTIME_UMA_ARG_LOADER_HPP