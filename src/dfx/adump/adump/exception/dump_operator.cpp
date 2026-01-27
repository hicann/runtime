/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "dump_operator.h"
#include "runtime/rt.h"
#include "str_utils.h"
#include "sys_utils.h"
#include "file.h"
#include "path.h"
#include "dump_memory.h"
#include "dump_datatype.h"
#include "dump_file.h"
#include "log/hdc_log.h"
#include "dump_manager.h"

namespace Adx {
namespace {
const std::set<char> INVALID_FILE_NAME_CHAR = {' ', '.', '/', '\\'};
constexpr char REPLACE_FILE_NAME_CHAR = '_';
}  // namespace

bool OpIdentity::operator==(const OpIdentity &rhs) const
{
    return rhs.deviceId == deviceId && rhs.taskId == taskId && rhs.streamId == streamId && rhs.contextId == contextId;
}

std::string OpIdentity::GetString() const
{
    std::stringstream ss;
    ss << "stream_id:" << streamId << ", task_id:" << taskId << ", context_id:" << contextId << ", thread_id:";
    return ss.str();
}

DumpOperator::DumpOperator(const OperatorInfoV2 &opInfo)
{
    Init(opInfo);
}

void DumpOperator::Init(const OperatorInfoV2 &opInfo)
{
    // init base info
    opName_ = opInfo.opName;
    opType_ = opInfo.opType;

    identity_.taskId = opInfo.taskId;
    identity_.streamId = opInfo.streamId;
    identity_.deviceId = opInfo.deviceId;
    identity_.contextId = opInfo.contextId;

    // init device info
    deviceInfos_ = opInfo.deviceInfos;

    // init additional info
    additions_ = opInfo.additionalInfo;
    auto item = additions_.find(DUMP_ADDITIONAL_IS_HOST_ARGS);
    if (item != additions_.end()) {
        isHostArgs_ = item->second;
    }
    InitDeviceArgs();

    // init tensor or workspace
    for (const auto &tensorInfo : opInfo.tensorInfos)
    {
        if (tensorInfo.tensorAddr == nullptr || tensorInfo.tensorSize == 0 || tensorInfo.placement != TensorPlacement::kOnDeviceHbm) {
            continue;
        }

        if (tensorInfo.type == TensorType::INPUT) {
            inputTensors_.emplace_back(tensorInfo);
        }
        else if (tensorInfo.type == TensorType::OUTPUT) {
            outputTensors_.emplace_back(tensorInfo);
        }
        else if (tensorInfo.type == TensorType::WORKSPACE) {
            workspaces_.emplace_back(tensorInfo.tensorAddr, static_cast<uint64_t>(tensorInfo.tensorSize),
                                     tensorInfo.argsOffSet);
        }
    }
    return;
}

void DumpOperator::InitDeviceArgs()
{
    for (const auto &deviceInfo : deviceInfos_) {
        if (deviceInfo.name == DEVICE_INFO_NAME_ARGS) {
            if (deviceInfo.addr == nullptr) {
                IDE_LOGW("The args before execute is null.");
                break;
            }
            void *argsAddr = nullptr;
            void *argsMem = nullptr;
            if (isHostArgs_ == "false") {
                argsMem = DumpMemory::CopyDeviceToHost(deviceInfo.addr, deviceInfo.length);
                if (argsMem == nullptr) {
                    IDE_LOGE("Copy device args to host failed.");
                    return;
                }
                argsAddr = argsMem;
            } else {
                argsAddr = deviceInfo.addr;
            }
            HOST_RT_MEMORY_GUARD(argsMem);

            uint64_t maxArgNum = deviceInfo.length / sizeof(uint64_t);
            for (uint64_t i = 0; i < maxArgNum; ++i) {
                hostArgs_.emplace_back(static_cast<void **>(argsAddr)[i]);
            }
            break;
        }
    }
}

bool DumpOperator::IsBelongTo(const OpIdentity &identity) const
{
    return identity == identity_;
}

void DumpOperator::PrintAdditionInfo(const char *flag) const
{
    std::string value;
    auto it = additions_.find(flag);
    if (it != additions_.end()) {
        value = it->second;
    }
    IDE_RUN_LOGI("[AIC_INFO] %s:%s", flag, value.c_str());
}

int32_t DumpOperator::LogExceptionInfo(const rtExceptionArgsInfo &argsInfo)
{
    kernelCollector_.LoadKernelInfo(argsInfo);

    // log op basic info
    std::ostringstream oss;
    oss << "[AIC_INFO] node_name:" << opName_.c_str() << ", node_type:" << opType_.c_str() << ", "
        << identity_.GetString().c_str();
    IDE_RUN_LOGI("%s", oss.str().c_str());
    logRecord_.emplace_back(oss.str() + "\n");
    oss.str("");
    // log tensor info
    for (size_t i = 0U; i < inputTensors_.size(); ++i) {
        oss << "[Dump][Exception] begin to load input tensor, index:" << inputTensors_[i].GetArgsOffSet();
        RecordCurrentLog(oss);
        IDE_RUN_LOGI("[AIC_INFO] input:%zu;%s", i, GetTensorString(inputTensors_[i]).c_str());
        oss << "[Dump][Exception] end to load input tensor, index:" << inputTensors_[i].GetArgsOffSet();
        RecordCurrentLog(oss);
    }
    for (size_t i = 0U; i < outputTensors_.size(); ++i) {
        oss << "[Dump][Exception] begin to load output tensor, index:" << outputTensors_[i].GetArgsOffSet();
        RecordCurrentLog(oss);
        IDE_RUN_LOGI("[AIC_INFO] output:%zu;%s", i, GetTensorString(outputTensors_[i]).c_str());
        oss << "[Dump][Exception] end to load output tensor, index:" << outputTensors_[i].GetArgsOffSet();
        RecordCurrentLog(oss);
    }
    for (size_t i = 0U; i < workspaces_.size(); ++i) {
        oss << "[Dump][Exception] begin to load workspace, index:" << workspaces_[i].argsOffset;
        RecordCurrentLog(oss);
        oss << "[Dump][Exception] exception info dump args data, addr:" << workspaces_[i].addr
            << "; size:" << workspaces_[i].bytes << " bytes";
        RecordCurrentLog(oss);
        IDE_RUN_LOGI("[AIC_INFO] workspace:%zu;addr:%p;size:%llu bytes", i, workspaces_[i].addr, workspaces_[i].bytes);
        oss << "[Dump][Exception] end to load workspace, index:" << workspaces_[i].argsOffset;
        RecordCurrentLog(oss);
    }

    // log additional info
    PrintAdditionInfo(DUMP_ADDITIONAL_BLOCK_DIM);
    PrintAdditionInfo(DUMP_ADDITIONAL_WORKSPACE_BYTES);
    PrintAdditionInfo(DUMP_ADDITIONAL_WORKSPACE_ADDRS);
    PrintAdditionInfo(DUMP_ADDITIONAL_ALL_ATTRS);
    PrintAdditionInfo(DUMP_ADDITIONAL_DEV_FUNC);
    PrintAdditionInfo(DUMP_ADDITIONAL_TVM_MAGIC);
    PrintAdditionInfo(DUMP_ADDITIONAL_KERNEL_INFO);
    PrintAdditionInfo(DUMP_ADDITIONAL_TILING_KEY);
    PrintAdditionInfo(DUMP_ADDITIONAL_TILING_DATA);
    PrintAdditionInfo(DUMP_ADDITIONAL_OP_FILE_PATH);

    // log args
    return LogExceptionArgs(argsInfo);
}

int32_t DumpOperator::CopyOpKernelFile() const
{
    // src file path
    auto it = additions_.find(DUMP_ADDITIONAL_OP_FILE_PATH);
    std::string opFilePath = it != additions_.cend() ? it->second : "./kernel_meta";

    it = additions_.find(DUMP_ADDITIONAL_DEV_FUNC);
    if (it == additions_.cend()) {
        IDE_LOGW("can't find [%s] in additional info.", DUMP_ADDITIONAL_DEV_FUNC);
        return ADUMP_FAILED;
    }
    std::string devFunc = it->second;
    std::string opFileName = devFunc.substr(0, devFunc.rfind("__"));
    Path srcFilePath = Path(opFilePath).Concat(opFileName).AddExtension(".o");
    if (!srcFilePath.RealPath()) {
        IDE_LOGW("Can not get realpath for src op file %s.", srcFilePath.GetCString());
        return ADUMP_FAILED;
    }

    // dst file path
    std::string currentDir = SysUtils::GetCurrentWorkDir();
    if (currentDir.empty()) {
        IDE_LOGE("Get current program work dir failed.");
        return ADUMP_FAILED;
    }
    Path dstFilePath = Path(currentDir).Concat(opFileName).AddExtension(".o");

    // copy file
    const auto ret = File::Copy(srcFilePath.GetString(), dstFilePath.GetString());
    if (ret != ADUMP_SUCCESS) {
        IDE_LOGE("Copy op kernel file from %s to %s failed.", srcFilePath.GetCString(), dstFilePath.GetCString());
        return ADUMP_FAILED;
    }
    return ADUMP_SUCCESS;
}

int32_t DumpOperator::RefreshAddrs(const rtExceptionArgsInfo &argsInfo)
{
    void *hostMem = DumpMemory::CopyDeviceToHost(argsInfo.argAddr, argsInfo.argsize);
    if (hostMem == nullptr) {
        IDE_LOGE("Copy device args to host failed, ptr: %p, size: %lu bytes.", argsInfo.argAddr, argsInfo.argsize);
        return ADUMP_FAILED;
    }
    HOST_RT_MEMORY_GUARD(hostMem);

    IDE_LOGI("Op %s type %s refresh addr.", opName_.c_str(), opType_.c_str());
    void **argsOnHost = static_cast<void **>(hostMem);
    size_t maxArgNum = argsInfo.argsize / sizeof(uint64_t);
    for (size_t i = 0U; i < inputTensors_.size(); i++) {
        const void *oriAddr = inputTensors_[i].GetAddress();
        if (maxArgNum <= inputTensors_[i].GetArgsOffSet()) {
            IDE_LOGW("Tensor args offset[%u] is larger than max arg num[%llu].", inputTensors_[i].GetArgsOffSet(),
                     maxArgNum);
            continue;
        }
        const void *refreshAddr = *(argsOnHost + inputTensors_[i].GetArgsOffSet());
        IDE_LOGI("Input.%zu addr refresh from %p to %p.", i, oriAddr, refreshAddr);
        inputTensors_[i].SetAddress(refreshAddr);
    }

    for (size_t i = 0U; i < outputTensors_.size(); i++) {
        const void *oriAddr = outputTensors_[i].GetAddress();
        if (maxArgNum <= outputTensors_[i].GetArgsOffSet()) {
            IDE_LOGW("Tensor args offset[%u] is larger than max arg num[%llu].", outputTensors_[i].GetArgsOffSet(),
                     maxArgNum);
            continue;
        }
        const void *refreshAddr = *(argsOnHost + outputTensors_[i].GetArgsOffSet());
        IDE_LOGI("Output.%zu addr refresh from %p to %p.", i, oriAddr, refreshAddr);
        outputTensors_[i].SetAddress(refreshAddr);
    }
    return ADUMP_SUCCESS;
}

int32_t DumpOperator::DumpExceptionFile(const uint32_t deviceId, const std::string &dumpPath)
{
    std::string dumpFilePath = GetDumpFilePath(dumpPath);
    IDE_LOGI("[Dump][Exception] The exception dump file path is %s", dumpFilePath.c_str());

    DumpFile dumpFile(deviceId, dumpFilePath);
    dumpFile.SetHeader(opName_);
    dumpFile.SetInputTensors(inputTensors_);
    dumpFile.SetOutputTensors(outputTensors_);
    dumpFile.SetWorkspaces(workspaces_);

    AdxLogFlush();
    const int32_t ret = dumpFile.Dump(logRecord_);
    if (ret != ADUMP_SUCCESS) {
        IDE_LOGE("[Dump][Exception] write exception to file failed, file: %s", dumpFilePath.c_str());
        return ADUMP_FAILED;
    }
    IDE_LOGE("[Dump][Exception] dump exception to file, file: %s", dumpFilePath.c_str());
    IDE_LOGI("[Dump][Exception] Dump exception info success.");
    return ADUMP_SUCCESS;
}

int32_t DumpOperator::DumpException(const uint32_t deviceId, const std::string &dumpPath)
{
    int32_t ret = ADUMP_SUCCESS;
    if (DumpExceptionFile(deviceId, dumpPath) != ADUMP_SUCCESS) {
        ret = ADUMP_FAILED;
    }
    if (kernelCollector_.LoadKernelBinBuffer() != ADUMP_SUCCESS){
        ret = ADUMP_FAILED;
    }
    if (kernelCollector_.StartCollectKernel(dumpPath) != ADUMP_SUCCESS) {
        ret = ADUMP_FAILED;
    }
    return ret;
}

bool DumpOperator::IsTvmOperator() const
{
    const auto it = additions_.find(DUMP_ADDITIONAL_IMPLY_TYPE);
    if (it == additions_.cend()) {
        return false;
    }

    int32_t implType = 0;
    if (!StrUtils::ToInteger(it->second, implType)) {
        IDE_LOGW("Convert imply_type string %s to int failed.", it->second.c_str());
        return false;
    }
    return static_cast<ImplyType>(implType) == ImplyType::TVM;
}

std::string DumpOperator::GetTensorString(const DumpTensor &tensor)
{
    std::stringstream content;
    content << "shape:" << StrUtils::ToString(tensor.GetShape()) << ";"
            << "format:" << DumpDataType::FormatToSerialString(static_cast<int32_t>(tensor.GetFormat())) << ";"
            << "dtype:" << DumpDataType::DataTypeToSerialString(static_cast<int32_t>(tensor.GetDataType())) << ";"
            << "addr:" << tensor.GetAddress() << ";"
            << "size:" << tensor.GetSize() << " bytes";
    std::ostringstream oss;
    oss << "[Dump][Exception] exception info dump args data, addr:" << tensor.GetAddress()
        << "; size:" << tensor.GetSize() << " bytes";
    RecordCurrentLog(oss);
    return content.str();
}

int32_t DumpOperator::LogExceptionArgs(const rtExceptionArgsInfo &argsInfo) const
{
    if (hostArgs_.size() == 0) {
        IDE_LOGI("Op %s args is empty, skip log args.", opName_.c_str());
    } else {
        void *const *argsMem = hostArgs_.data();
        PrintLog(argsMem, hostArgs_.size(), std::string(DEVICE_INFO_NAME_ARGS));
    }

    if (argsInfo.argAddr == nullptr) {
        IDE_LOGE("exception callback argAddr is null");
        return ADUMP_SUCCESS;
    }
    void *hostMem = DumpMemory::CopyDeviceToHost(argsInfo.argAddr, argsInfo.argsize);
    if (hostMem == nullptr) {
        IDE_LOGE("Copy device args to host failed, addr: %p, size: %u.", argsInfo.argAddr, argsInfo.argsize);
        return ADUMP_FAILED;
    }
    HOST_RT_MEMORY_GUARD(hostMem);
    void *const *argsOnHost = static_cast<void *const *>(hostMem);
    size_t argNum = argsInfo.argsize / sizeof(uint64_t);
    PrintLog(argsOnHost, argNum, "args after execute");

    return ADUMP_SUCCESS;
}

void DumpOperator::PrintLog(void *const *argsOnHost, size_t argNum, const std::string &tag) const
{
    std::stringstream strStream;
    const uint32_t printNumEachTime = 20;
    uint32_t count = argNum / printNumEachTime;
    uint32_t left = argNum % printNumEachTime;

    for (uint32_t i = 0; i < count; ++i) {
        uint32_t begin = printNumEachTime * i;
        uint32_t end = printNumEachTime * (i + 1);
        for (uint32_t j = begin; j < end; ++j) {
            strStream << *(argsOnHost + j) << " ";
        }
        IDE_RUN_LOGI("[AIC_INFO] %s(%u to %u): %s", tag.c_str(), begin, end - 1, strStream.str().c_str());
        strStream.str("");
    }

    if (left != 0 && argNum > 0) {
        uint32_t begin = printNumEachTime * count;
        uint32_t end = argNum;
        for (uint32_t j = begin; j < end; ++j) {
            strStream << *(argsOnHost + j) << " ";
        }
        IDE_RUN_LOGI("[AIC_INFO] %s(%u to %u): %s", tag.c_str(), begin, end - 1, strStream.str().c_str());
    }
}

std::string DumpOperator::GetDumpFilePath(const std::string &dumpPath) const
{
    std::string opType = StrUtils::Replace(opType_, INVALID_FILE_NAME_CHAR, REPLACE_FILE_NAME_CHAR);
    std::string opName = StrUtils::Replace(opName_, INVALID_FILE_NAME_CHAR, REPLACE_FILE_NAME_CHAR);
    uint32_t taskId = identity_.taskId;
    std::string dumpFileName =
        opType + "." + opName + "." + std::to_string(taskId) + "." + SysUtils::GetCurrentTimeWithMillisecond();
    Path dumpFilePath(dumpPath);
    dumpFilePath.Concat(dumpFileName);
    return dumpFilePath.GetString();
}

void DumpOperator::RecordCurrentLog(std::ostringstream &oss)
{
    IDE_LOGE("%s", oss.str().c_str());
    logRecord_.emplace_back(oss.str() + "\n");
    oss.str("");
}
}  // namespace Adx