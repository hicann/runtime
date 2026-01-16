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
#include <fstream>
#include "error_message_manage.hpp"
#include "runtime.hpp"
#include "utils.h"
#include "program.hpp"
#include "context.hpp"
#include "nlohmann/json.hpp"

namespace cce {
namespace runtime {
constexpr uint32_t LOAD_OPTION_LAZY_LOAD_ENABLE = 1U;
constexpr uint32_t LOAD_OPTION_LAZY_LOAD_DISABLE = 0U;

BinaryLoader::BinaryLoader(const char_t * const binPath, const rtLoadBinaryConfig_t * const optionalCfg) :
                           loadOptions_(optionalCfg)
{
    this->binPath_ = std::string(binPath);
    this->isLoadFromFile_ = true;
}

BinaryLoader::BinaryLoader(const void * const data, const uint64_t length,
                           const rtLoadBinaryConfig_t * const optionalCfg) :
                           loadOptions_(optionalCfg),
                           binarySize_(static_cast<uint32_t>(length))
{
    this->binaryBuffer_ = const_cast<void *>(data);
}

static uint32_t Magic2Machine(const uint32_t magic)
{
    uint32_t machine = Program::MACH_INVALID_CPU;
    switch (magic) {
        case RT_DEV_BINARY_MAGIC_ELF: {
            if (IS_SUPPORT_CHIP_FEATURE(Runtime::Instance()->GetChipType(), RtOptionalFeatureType::RT_FEATURE_KERNEL_BINARY_MACHINE_CVMIX)) {
                machine = Program::MACH_AI_CVMIX;
            } else {
                machine = Program::MACH_AI_CORE;
            }
            break;
        }
        case RT_DEV_BINARY_MAGIC_ELF_AICUBE:
            machine = Program::MACH_AI_CORE;
            break;
        case RT_DEV_BINARY_MAGIC_ELF_AIVEC:
            machine = Program::MACH_AI_VECTOR;
            break;
        default:
            RT_LOG(RT_LOG_ERROR, "Invalid magic: %#x should be {%#x, %#x, %#x}", magic, RT_DEV_BINARY_MAGIC_ELF,
                RT_DEV_BINARY_MAGIC_ELF_AICUBE, RT_DEV_BINARY_MAGIC_ELF_AIVEC);
            break;
    }
    return machine;
}

static uint32_t ConvertMagic(const std::string &magicStr)
{
    if (magicStr == "RT_DEV_BINARY_MAGIC_ELF") {
        return RT_DEV_BINARY_MAGIC_ELF;
    } else if (magicStr == "RT_DEV_BINARY_MAGIC_ELF_AICUBE") {
        return RT_DEV_BINARY_MAGIC_ELF_AICUBE;
    } else if ((magicStr == "RT_DEV_BINARY_MAGIC_ELF_AIVEC") || (magicStr == "FFTS_BINARY_MAGIC_ELF_MIX_AIC") ||
               (magicStr == "FFTS_BINARY_MAGIC_ELF_MIX_AIV")) {
        return RT_DEV_BINARY_MAGIC_ELF_AIVEC;
    } else {
        RT_LOG(RT_LOG_ERROR, "Invalid magic=%s", magicStr.c_str());
        return 0U;
    }
}

static uint32_t ParseMagic(const nlohmann::json &kernelJson)
{
    if (kernelJson.find("magic") == kernelJson.end()) {
        RT_LOG(RT_LOG_ERROR, "Magic not found in json file");
        return 0U;
    }

    const auto &magicStr = kernelJson["magic"].get<std::string>();
    return ConvertMagic(magicStr);
}

static void ParseInterCrossSync(const nlohmann::json &kernelJson, ElfProgram * const prog)
{
    if (kernelJson.contains("intercoreSync") && kernelJson["intercoreSync"] == 1U) {
        RT_LOG(RT_LOG_DEBUG, "support inter core sync");
        prog->SetIsSupportInterCoreSync(true);
    }
}

static rtError_t ParseDebugOptions(const nlohmann::json &kernelJson)
{
    if (kernelJson.find("debugOptions") == kernelJson.end()) {
        return RT_ERROR_NONE;
    }
    const auto &debugOptions = kernelJson["debugOptions"].get<std::string>();
    if (debugOptions.find("printf") != std::string::npos) {
        RT_LOG(RT_LOG_ERROR, "kernel debug option 'printf' does not support, debugOptions=[%s]", debugOptions.c_str());
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }
    return RT_ERROR_NONE;
}

static rtError_t GetJsonObj(const std::string &path, std::string &jsonFileRealPath, 
                            nlohmann::json &kernelJsonObj)
{
    // json file have the same name with binary file. binary file suffix is .o, json file suffix is .json
    std::string jsonFilePath;
    const auto dotPos = path.find_last_of(".");
    if (dotPos != std::string::npos) {
        jsonFilePath = path.substr(0, dotPos);
    }
    jsonFilePath = jsonFilePath + ".json";

    jsonFileRealPath = RealPath(jsonFilePath);
    if (jsonFileRealPath.empty()) {
        return RT_ERROR_INVALID_VALUE;
    }

    std::ifstream f(jsonFileRealPath);
    try {
        kernelJsonObj = nlohmann::json::parse(f);
    } catch (nlohmann::json::exception &e) {
        RT_LOG(RT_LOG_ERROR, "Parse kenerl json file=[%s] failed, because %s.", jsonFileRealPath.c_str(), e.what());
        return RT_ERROR_INVALID_VALUE;
    }

    return RT_ERROR_NONE;
}

static void GetCpuKernelFromJson(const nlohmann::json &jsonObj, std::vector<CpuKernelInfo> &kernelInfos)
{
    CpuKernelInfo kernelInfo{};
    for (auto &op : jsonObj.items()) {
        auto value = op.value();
        if (!value.contains("opInfo")) {
            RT_LOG(RT_LOG_WARNING, "opInfo does not exist, continue");
            continue;
        }

        kernelInfo.key = op.key();
        kernelInfo.funcName = "";
        kernelInfo.kernelSo = "";
        kernelInfo.opKernelLib = "";
        kernelInfo.isUserDefined = false;
        kernelInfo.hasOpKernelLib = false;

        auto opInfo = value["opInfo"];
        if (opInfo.contains("functionName")) {
            kernelInfo.funcName = opInfo["functionName"].get<std::string>();
        } else {
            // 当前识别TF算子可以没有functionName
            RT_LOG(RT_LOG_WARNING, "functionName does not exist, key=%s.");
        }
        if (opInfo.contains("kernelSo")) {
            kernelInfo.kernelSo = opInfo["kernelSo"].get<std::string>();
        } else {
            RT_LOG(RT_LOG_WARNING, "kernelSo does not exist.");
        }

        if (opInfo.contains("opKernelLib")) {
            kernelInfo.hasOpKernelLib = true;
            kernelInfo.opKernelLib = opInfo["opKernelLib"].get<std::string>();
        }
        if (opInfo.contains("userDefined") && (opInfo["userDefined"].get<string>() == "True")) {
            kernelInfo.isUserDefined = true;
        }

        kernelInfos.push_back(kernelInfo);
    }
    return;
}

rtError_t BinaryLoader::ParseLoadOptions()
{
    if (loadOptions_ == nullptr) {
        RT_LOG(RT_LOG_DEBUG, "Load options is empty, no need to parse.");
        return RT_ERROR_NONE;
    }
    if (loadOptions_->options == nullptr) {
        RT_LOG(RT_LOG_ERROR, "optionalCfg is not null, but options is nullptr");
        return RT_ERROR_INVALID_VALUE;
    }

    for (size_t idx = 0U; idx < loadOptions_->numOpt; idx++) {
        const rtLoadBinaryOption optionId = loadOptions_->options[idx].optionId;
        if (optionId == RT_LOAD_BINARY_OPT_LAZY_LOAD) {
            const uint32_t lazyLoadCfg = loadOptions_->options[idx].value.isLazyLoad;
            if (lazyLoadCfg == LOAD_OPTION_LAZY_LOAD_ENABLE) { // lazy load
                isLazyLoad_ = true;
            } else if (lazyLoadCfg == LOAD_OPTION_LAZY_LOAD_DISABLE) {
                isLazyLoad_ = false;
            } else {
                RT_LOG(RT_LOG_ERROR, "Binary load failed, RT_LOAD_BINARY_OPT_LAZY_LOAD value is illegal, "
                    "val=%u, should be [0, 1]", lazyLoadCfg);
                return RT_ERROR_INVALID_VALUE;
            }
            RT_LOG(RT_LOG_DEBUG, "Parse binary load option isLazyLoad=%u", lazyLoadCfg);
        } else if (optionId == RT_LOAD_BINARY_OPT_MAGIC) {
            if (isLoadFromFile_) {
                RT_LOG(RT_LOG_ERROR, "Binary load failed, RT_LOAD_BINARY_OPT_MAGIC does not support in load from file");
                return RT_ERROR_INVALID_VALUE;
            }
            const uint32_t magic = loadOptions_->options[idx].value.magic;
            if ((magic != RT_DEV_BINARY_MAGIC_ELF) && (magic != RT_DEV_BINARY_MAGIC_ELF_AICUBE) &&
                (magic != RT_DEV_BINARY_MAGIC_ELF_AIVEC)) {
                RT_LOG(RT_LOG_ERROR, "binary load failed, RT_LOAD_BINARY_OPT_MAGIC value=%#x is illegal, "
                    "should be {%#x, %#x, %#x}", magic, RT_DEV_BINARY_MAGIC_ELF, RT_DEV_BINARY_MAGIC_ELF_AICUBE,
                    RT_DEV_BINARY_MAGIC_ELF_AIVEC);
                return RT_ERROR_INVALID_VALUE;
            }
            magic_ = magic;
            RT_LOG(RT_LOG_DEBUG, "Parse binary load option magic=%#x", magic);
        } else if (optionId == RT_LOAD_BINARY_OPT_CPU_KERNEL_MODE) {
            const rtError_t ret = SetCpuBinInfo(loadOptions_->options[idx].value);
            ERROR_RETURN(ret, "set cpu bin info failed! ret=%#x", ret);
        } else {
            RT_LOG(RT_LOG_ERROR, "Binary load failed, load option type[%d] is illegal, should be [1, %u)", optionId,
                RT_LOAD_BINARY_OPT_MAX);
            return RT_ERROR_INVALID_VALUE;
        }
    }

    return RT_ERROR_NONE;
}

rtError_t BinaryLoader::SetCpuBinInfo(const rtLoadBinaryOptionValue_t &option)
{
    const int32_t mode = option.cpuKernelMode;
    // 0, 1 user for load from file
    COND_RETURN_OUT_ERROR_MSG_CALL((isLoadFromFile_ && (mode != 0) && (mode != 1)), RT_ERROR_INVALID_VALUE,
        "load from file scenario cpu kernel mode is invalid, mode=%d, should be [0, 1]", mode);
    // 2 only user for load from data
    COND_RETURN_OUT_ERROR_MSG_CALL(!isLoadFromFile_ && (mode != 2), RT_ERROR_INVALID_VALUE,
        "load from data scenario cpu kernel mode is invalid, mode=%d, should be 2", mode);
    size_t binSize;
    switch (mode) {
        case 0: // 0: only need .json
        case 1: // 1: need .so and .json
            binPath_ = GetFilePathByExtension(binPath_, ".so");
            soName_ = GetFileName(binPath_);
            break;
        case 2: // 2: load form data
            binPath_ = "";
            binSize = binarySize_ > 1024UL ? 1024UL : binarySize_;
            soName_ = std::to_string(GetQuickHash(binaryBuffer_, binSize)) + ".so";
            break;
        default:
            // mode range only support [0, 1, 2]
            RT_LOG_OUTER_MSG_INVALID_PARAM(mode, "[0, 2]");
            return RT_ERROR_INVALID_VALUE;
    }

    isLoadCpu_ = true;
    cpuKernelMode_ = mode;

    RT_LOG(RT_LOG_DEBUG,
        "set cpu bin info, binPath_=[%s], soName=[%s], mode=%d", binPath_.c_str(), soName_.c_str(), mode);

    return RT_ERROR_NONE;
}

rtError_t BinaryLoader::ReadBinaryFile()
{
    binRealPath_ = RealPath(binPath_);
    if (binRealPath_.empty()) {
        RT_LOG(RT_LOG_ERROR, "Binary file path is invalid, path=[%s]", binPath_.c_str());
        return RT_ERROR_INVALID_VALUE;
    }

    RT_LOG(RT_LOG_DEBUG, "Binary file path, binPath=[%s], binRealPath=[%s]",
        binPath_.c_str(), binRealPath_.c_str());
    char_t *buffer;
    const rtError_t ret = Runtime::Instance()->GetKernelBinByFileName(binRealPath_.c_str(), &buffer, &binarySize_);
    binaryBuffer_ = static_cast<void *>(buffer);
    if (ret != RT_ERROR_NONE) {
        return RT_ERROR_INVALID_VALUE;
    }

    return RT_ERROR_NONE;
}

rtError_t BinaryLoader::ParseKernelJsonFile(ElfProgram * const prog) const
{
    nlohmann::json kernelJsonObj;
    std::string jsonFileRealPath;
    rtError_t error = GetJsonObj(binRealPath_, jsonFileRealPath, kernelJsonObj);
    if (error != RT_ERROR_NONE) {
        if (!prog->ContainsAscendMeta()) {
            RT_LOG(RT_LOG_ERROR, "binary no metainfo and kernel json is not exists. bin=[%s]", binRealPath_.c_str());
            return error;
        }
        return RT_ERROR_NONE;
    }

    ParseInterCrossSync(kernelJsonObj, prog);

    error = ParseDebugOptions(kernelJsonObj);
    ERROR_RETURN(error, "Parse degbug options failed, json=[%s]", jsonFileRealPath.c_str());

    prog->SetElfMagic(magic_);
    if (!prog->ContainsAscendMeta()) {
        const uint32_t magic = ParseMagic(kernelJsonObj);
        const uint32_t machine = Magic2Machine(magic);
        if ((magic == 0U) || (machine == Program::MACH_INVALID_CPU)) {
            RT_LOG(RT_LOG_ERROR, "Binary no metainfo and magic in kernel json is invalid, json=[%s]",
                jsonFileRealPath.c_str());
            return RT_ERROR_INVALID_VALUE;
        }
        RT_LOG(RT_LOG_DEBUG, "Load binary from file, magic=%#x, machine=%u", magic, machine);
        prog->SetMachine(machine);
        prog->SetElfMagic(magic);
    }
    return RT_ERROR_NONE;
}

ElfProgram* BinaryLoader::LoadFromFile()
{
    rtError_t ret = ReadBinaryFile();
    if (ret != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "Read binary file failed");
        return nullptr;
    }
    // MACH_AI_MIX_KERNEL meanings all kinds of kernel in one .o file, each kernel's machine type is defined in metainfo
    ElfProgram *prog = new (std::nothrow) ElfProgram(Program::MACH_AI_MIX_KERNEL);
    if (prog == nullptr) {
        RT_LOG(RT_LOG_ERROR, "Malloc new ElfProgram failed");
        char_t *buffer = RtPtrToPtr<char_t *, void *>(binaryBuffer_);
        DELETE_A(buffer);
        return nullptr;
    }
    RT_LOG(RT_LOG_INFO, "New ElfProgram ok, Runtime_alloc_size %zu", sizeof(ElfProgram));

    ret = prog->Register(binaryBuffer_, static_cast<uint64_t>(binarySize_), true);
    if (ret != RT_ERROR_NONE) {
        RT_LOG_CALL_MSG(ERR_MODULE_GE, "program register failed");
        delete prog;
        return nullptr;
    }

    ret = ParseKernelJsonFile(prog);
    if (ret != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "Parse kernel json file failed, ret=%#x", ret);
        delete prog;
        return nullptr;
    }
    return prog;
}

PlainProgram* BinaryLoader::LoadCpuKernelFromFile()
{
    PlainProgram *prog = nullptr;
    switch (cpuKernelMode_) {
        case 0:
            // RT_LOAD_BINARY_OPT_CPU_KERNEL_MODE=0
            // 表示只加载json，自研算子仅需要加载json。做成自定义一样，自行检查是否已加载
            prog = LoadCpuMode0Program();
            break;
        case 1:
            // RT_LOAD_BINARY_OPT_CPU_KERNEL_MODE=1  表示加载cpu so&json。
            // 并会读取配套同名json文件描述cpu算子信息func name和opType.
            prog = LoadCpuMode1Program();
            break;
        default:
            break;
    }

    return prog;
}

PlainProgram* BinaryLoader::LoadCpuKernelFromData()
{
    PlainProgram *prog = new (std::nothrow) PlainProgram(RT_KERNEL_REG_TYPE_CPU, Program::MACH_AI_CPU);
    if (prog == nullptr) {
        RT_LOG(RT_LOG_ERROR, "Malloc new PlainProgram failed");
        return nullptr;
    }

    prog->RegCpuProgInfo(binaryBuffer_, binarySize_, soName_, cpuKernelMode_, isLoadFromFile_);
    return prog;
}

ElfProgram* BinaryLoader::LoadFromData() const
{
    // MACH_AI_MIX_KERNEL meanings all kinds of kernel in one .o file, each kernel's machine type is defined in metainfo
    uint32_t machine = Program::MACH_AI_MIX_KERNEL;
    // If user give the specified magic param, use to set the machine.
    if (magic_ != 0) {
        machine = Magic2Machine(magic_);
        if (machine == Program::MACH_INVALID_CPU) {
            return nullptr;
        }
    }
    ElfProgram *prog = new (std::nothrow) ElfProgram(machine);
    if (prog == nullptr) {
        RT_LOG(RT_LOG_ERROR, "malloc new ElfProgram failed");
        return nullptr;
    }
    RT_LOG(RT_LOG_INFO, "New ElfProgram ok, Runtime_alloc_size %zu", sizeof(ElfProgram));

    const rtError_t ret = prog->Register(binaryBuffer_, static_cast<uint64_t>(binarySize_));
    if (ret != RT_ERROR_NONE) {
        RT_LOG_CALL_MSG(ERR_MODULE_GE, "program register failed");
        delete prog;
        return nullptr;
    }

    if ((!prog->ContainsAscendMeta()) && (magic_ == 0U)) {
        RT_LOG(RT_LOG_ERROR, "Binary format is illegal, should contain metainfo section!");
        delete prog;
        return nullptr;
    }

    if ((prog->ContainsAscendMeta()) && (prog->Machine() != Program::MACH_AI_MIX_KERNEL)) {
        prog->SetMachine(Program::MACH_AI_MIX_KERNEL);
    }

    prog->SetElfMagic(magic_);
    return prog;
}

ElfProgram* BinaryLoader::LoadProgram()
{
    if (isLoadFromFile_) {
        return LoadFromFile();
    }

    return LoadFromData();
}

PlainProgram* BinaryLoader::ParseJsonAndRegisterCpuKernel()
{
    PlainProgram *prog = new (std::nothrow) PlainProgram(RT_KERNEL_REG_TYPE_CPU, Program::MACH_AI_CPU);
    if (prog == nullptr) {
        RT_LOG(RT_LOG_ERROR, "Malloc new PlainProgram failed");
        return nullptr;
    }
    RT_LOG(RT_LOG_INFO, "New PlainProgram ok, Runtime_alloc_size %zu", sizeof(PlainProgram));

    std::string jsonFilePath = GetFilePathByExtension(binPath_, ".json");
    std::string jsonFileRealPath;
    nlohmann::json jsonObj;
    rtError_t ret = GetJsonObj(jsonFilePath, jsonFileRealPath, jsonObj);
    if (ret != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "Parse kernel json file failed, path=%s, ret=%#x", jsonFileRealPath.c_str(), ret);
        DELETE_O(prog);
        return nullptr;
    }

    std::vector<CpuKernelInfo> kernelInfos;
    GetCpuKernelFromJson(jsonObj, kernelInfos);

    ret = prog->RegisterCpuKernel(kernelInfos);
    if (ret != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "register cpu kernel failed, ret=%#x", ret);
        DELETE_O(prog);
        return nullptr;
    }
    return prog;
}

// RT_LOAD_BINARY_OPT_CPU_KERNEL_MODE=0  表示只加载json，自研算子仅需要加载json。做成自定义一样，自行检查是否已加载
PlainProgram *BinaryLoader::LoadCpuMode0Program()
{
    PlainProgram *prog = ParseJsonAndRegisterCpuKernel();
    if (prog == nullptr) {
        RT_LOG(RT_LOG_ERROR, "Parse json and register cpu kernel failed");
        return nullptr;
    }

    return prog;
}

PlainProgram *BinaryLoader::LoadCpuMode1Program()
{
    rtError_t ret = ReadBinaryFile();
    if (ret != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "Read binary file failed");
        return nullptr;
    }

    char_t *buffer = RtPtrToPtr<char_t *, void *>(binaryBuffer_);
    PlainProgram *prog = ParseJsonAndRegisterCpuKernel();
    if (prog == nullptr) {
        RT_LOG(RT_LOG_ERROR, "Parse json and register cpu kernel failed");
        DELETE_A(buffer); // 如果prog为空，无法释放，此处需要显示释放
        return nullptr;
    }

    prog->RegCpuProgInfo(binaryBuffer_, binarySize_, soName_, cpuKernelMode_, isLoadFromFile_);
    return prog;
}

rtError_t BinaryLoader::LoadNonCpu(Program **prog)
{
    // check runtime instance for inner calls
    NULL_PTR_RETURN_MSG(Runtime::Instance(), RT_ERROR_INSTANCE_NULL);

    *prog = nullptr;
    // 1. Load binary file or data, parse elf, get the original kernel symbols and attributes.
    ElfProgram* program = LoadProgram();
    NULL_PTR_RETURN_MSG(program, RT_ERROR_INVALID_VALUE);

    // 2. Register all the kernels to kernel table in program
    rtError_t error = program->UnifiedKernelRegister();
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "Register kernel failed");
        delete program;
        return error;
    }

    // 3. If not lazy load, copy the kernels to the device
    program->SetIsLazyLoad(isLazyLoad_);
    program->SetIsNewBinaryLoadFlow(true);
    *prog = program;

    return RT_ERROR_NONE;
}

rtError_t BinaryLoader::LoadCpu(Program **prog)
{
   *prog = nullptr;
   PlainProgram *curProg = nullptr;
    if (isLoadFromFile_) {
        curProg = LoadCpuKernelFromFile();
    } else {
        curProg = LoadCpuKernelFromData();
    }

    NULL_PTR_RETURN_MSG(curProg, RT_ERROR_INVALID_VALUE);

    // 对于load from data的注册方式只做cpu so buff的H2D落盘没有soName，会hash一个值，所以需要在program handle中记录
    // rtsRegisterCpuFunc注册的时候，从program handle中获取注册到kernel handle中
    curProg->SetSoName(soName_);
    curProg->SetIsNewBinaryLoadFlow(true);
    *prog = curProg;

    return RT_ERROR_NONE;
}

rtError_t BinaryLoader::Load(Program **prog)
{
    const rtError_t ret = ParseLoadOptions();
    if (ret != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "parse load options failed, ret=%#x", ret);
        return ret;
    }

    if (isLoadCpu_) {
        return LoadCpu(prog);
    }

    return LoadNonCpu(prog);
}
} // runtime
} // cce