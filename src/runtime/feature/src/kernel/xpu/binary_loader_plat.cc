/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "binary_loader.hpp"
#include "json_parse.hpp"
#include <dlfcn.h>
namespace cce {
namespace runtime {

static PlainProgram* XpuParseJsonAndRegisterCpuKernel(std::string binPath)
{
    PlainProgram *prog = new (std::nothrow) PlainProgram(RT_KERNEL_REG_TYPE_CPU, Program::MACH_AI_CPU);
    if (prog == nullptr) {
        RT_LOG(RT_LOG_ERROR, "Malloc new PlainProgram failed");
        return nullptr;
    }
    RT_LOG(RT_LOG_INFO, "New PlainProgram ok, Runtime_alloc_size %zu", sizeof(PlainProgram));

    void *binHandle = mmDlopen(binPath.c_str(), RTLD_LAZY);
    if (binHandle == nullptr) {
        RT_LOG(RT_LOG_ERROR, "Can not dlopen lib %s, reason: %s.", binPath.c_str(), dlerror());
        DELETE_O(prog);
        return nullptr;
    }
    prog->SetBinHandle(binHandle);

    std::string jsonFileRealPath;
    nlohmann::json jsonObj;
    rtError_t ret = GetJsonObj(binPath, jsonFileRealPath, jsonObj);
    if (ret != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "Xpu Parse kernel json file failed, path=%s, ret=%#x", jsonFileRealPath.c_str(), ret);
        DELETE_O(prog);
        return nullptr;
    }

    std::vector<CpuKernelInfo> kernelInfos;
    GetCpuKernelFromJson(jsonObj, kernelInfos);

    ret = prog->XpuRegisterCpuKernel(kernelInfos);
    if (ret != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "Xpu register cpu kernel failed, ret=%#x", ret);
        DELETE_O(prog);
        return nullptr;
    }

    return prog;
}

rtError_t BinaryLoader::XpuLoad(Program **prog) const
{
    if (!isLoadCpu_ || !isLoadFromFile_ || cpuKernelMode_ != 1) {
        RT_LOG(RT_LOG_ERROR, "XPU only supports registering AICPU operators in mode 1, isLoadCpu_=%d, isLoadFromFile_=%d, cpuKernelMode_=%d", 
            isLoadCpu_, isLoadFromFile_, cpuKernelMode_);
        return RT_ERROR_INVALID_VALUE;
    }

    *prog = nullptr;
    PlainProgram *curProg = nullptr;

    curProg = XpuParseJsonAndRegisterCpuKernel(binPath_);
    if (curProg == nullptr) {
        RT_LOG(RT_LOG_ERROR, "Parse json and register cpu kernel failed");
        return RT_ERROR_INVALID_VALUE;
    }
    curProg->SetSoName(soName_);
    curProg->SetIsNewBinaryLoadFlow(true);
    *prog = curProg;

    return RT_ERROR_NONE;
}
}
}