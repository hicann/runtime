/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __CCE_RUNTIME_BINARY_LOADER_HPP__
#define __CCE_RUNTIME_BINARY_LOADER_HPP__

#include "base.hpp"
#include "program.hpp"

namespace cce {
namespace runtime {
class BinaryLoader {
public:
    BinaryLoader(const char_t * const binPath, const rtLoadBinaryConfig_t * const optionalCfg);
    BinaryLoader(const void * const data, const uint64_t length, const rtLoadBinaryConfig_t * const optionalCfg);
    rtError_t Load(Program **prog);
private:
    ElfProgram* LoadProgram();
    ElfProgram* LoadFromFile();
    ElfProgram* LoadFromData() const;
    rtError_t ParseLoadOptions();
    rtError_t ReadBinaryFile();
    rtError_t ParseKernelJsonFile(ElfProgram * const prog) const;
    // load cpu kernel and get program
    rtError_t LoadCpu(Program **prog);
    // load non cpu kernel (such as : aic / aiv ...) and get program
    rtError_t LoadNonCpu(Program **prog);
    PlainProgram *LoadCpuKernelFromData();
    PlainProgram *LoadCpuKernelFromFile();
    PlainProgram *LoadCpuMode0Program();
    PlainProgram *LoadCpuMode1Program();
    PlainProgram *ParseJsonAndRegisterCpuKernel();
    rtError_t SetCpuBinInfo(const rtLoadBinaryOptionValue_t &option);

    std::string binPath_;
    std::string binRealPath_;
    const rtLoadBinaryConfig_t * const loadOptions_;
    bool isLoadFromFile_ = false;

    void *binaryBuffer_ = nullptr;
    uint32_t binarySize_ = 0;
    uint32_t magic_ = 0;
    bool isLazyLoad_ = false;

    // Used to distinguish cpu or non cpu
    bool isLoadCpu_ = false;
    int32_t cpuKernelMode_ = -1;
    std::string soName_;
};
}
}
#endif  // __CCE_RUNTIME_BINARY_LOADER_HPP__
