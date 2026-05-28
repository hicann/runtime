/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "dump_args_callback.h"
#include "dfx_args_parser.h"
#include "dump_memory.h"
#include "kernel_info_collector.h"
#include "log/adx_log.h"
#include "log/hdc_log.h"

namespace Adx {

DumpArgsCallback::DumpArgsCallback(const rtExceptionInfo &exception, const ExceptionDumpInfo &info,
                                     const std::string &dumpPath)
    : info_(info),
      dumpPath_(dumpPath),
      dumpFilePath_(dumpPath + "/" +
        std::string(info.kernelDisplayName[0] != '\0' ? info.kernelDisplayName : "exception_info") + "." +
        std::to_string(exception.streamid) + "." + std::to_string(exception.taskid) + "." +
        std::to_string(info.coreType) + "." + std::to_string(info.coreId) + "." +
        SysUtils::GetCurrentTimeWithMillisecond()),
      dumpFile_(exception.deviceid, dumpFilePath_)
{
}

int32_t DumpArgsCallback::DumpKernelBin()
{
    std::string kernelName(info_.kernelName);
    if (info_.bin == nullptr || kernelName.empty()) {
        return ADUMP_SUCCESS;
    }
    IDE_LOGI("Dump kernel bin file. bin=%p, kernelName=%s", info_.bin, kernelName.c_str());
    KernelInfoCollector collector;
    int32_t ret = collector.InitFromBinHandle(info_.bin, kernelName);
    IDE_CTRL_VALUE_FAILED(ret == ADUMP_SUCCESS, return ADUMP_FAILED,
        "Init for dump kernel bin failed. ret=%d, bin=%p, kernelName=%s.", ret, info_.bin, kernelName.c_str());

    ret = collector.StartCollectKernel(dumpPath_);
    if (ret != ADUMP_SUCCESS) {
        IDE_LOGW("StartCollectKernel failed, kernelName=%s.", kernelName.c_str());
        return ADUMP_FAILED;
    }
    
    IDE_LOGI("DumpKernelBin success, kernelName=%s.", kernelName.c_str());
    return ADUMP_SUCCESS;
}

int32_t DumpArgsCallback::QueryDfxIsTikInfo(rtFuncHandle funcHandle)
{
    size_t isTikSize = 0;
    rtError_t rtRet = rtFunctionGetMetaInfoSize(funcHandle, RT_FUNCTION_TYPE_L0_EXCEPTION_DFX_IS_TIK, &isTikSize);
    if (rtRet != RT_ERROR_NONE || isTikSize == 0 || isTikSize < sizeof(uint32_t)) {
        IDE_LOGW("rtFunctionGetMetaInfoSize for dfxIsTik failed, will set dfxIsTik with false. "
            "rtRet=%d, kernelName=%s", rtRet, info_.kernelName);
        return ADUMP_FAILED;
    }

    std::vector<uint8_t> isTikBuffer(isTikSize);
    rtRet = rtFunctionGetMetaInfo(funcHandle, RT_FUNCTION_TYPE_L0_EXCEPTION_DFX_IS_TIK, 
        isTikBuffer.data(), isTikSize);
    if (rtRet != RT_ERROR_NONE) {
        IDE_LOGW("rtFunctionGetMetaInfo for isTik failed, will set dfxIsTik with false. "
            "ret=%d, kernelName=%s, isTikSize=%zu.",  rtRet, info_.kernelName, isTikSize);
        return ADUMP_FAILED;
    }

    uint32_t isTik = 0;
    isTik = *reinterpret_cast<uint32_t*>(isTikBuffer.data());
    isTik_ = (isTik == 1U) ? true : false;
    IDE_LOGI("Query dfxIsTik info success. kernelName=%s, dfxIsTik=%u", info_.kernelName, isTik);
    return ADUMP_SUCCESS;
}

int32_t DumpArgsCallback::QueryDfxInfo(std::vector<uint8_t> &dfxBuffer)
{
    rtFuncHandle funcHandle = nullptr;
    rtError_t rtRet = rtBinaryGetFunctionByName(info_.bin, info_.kernelName, &funcHandle);
    IDE_CTRL_VALUE_FAILED(rtRet == RT_ERROR_NONE && funcHandle != nullptr, return ADUMP_FAILED,
        "rtBinaryGetFunctionByName failed, ret=%d, bin=%p, kernelName=%s.", rtRet, info_.bin, info_.kernelName);

    size_t dfxSize = 0;
    rtRet = rtFunctionGetMetaInfoSize(funcHandle, RT_FUNCTION_TYPE_DFX_TYPE, &dfxSize);
    IDE_CTRL_VALUE_FAILED(rtRet == RT_ERROR_NONE && dfxSize > 0, return ADUMP_FAILED,
        "rtFunctionGetMetaInfoSize failed, ret=%d, kernelName=%s, dfxSize=%zu.", rtRet, info_.kernelName, dfxSize);
    IDE_CTRL_VALUE_FAILED(dfxSize <= UINT16_MAX, return ADUMP_FAILED,
        "Dfx size exceeds uint16_t max, dfxSize=%zu", dfxSize);
    
    dfxBuffer.resize(dfxSize);
    rtRet = rtFunctionGetMetaInfo(funcHandle, RT_FUNCTION_TYPE_DFX_TYPE, dfxBuffer.data(), dfxSize);
    IDE_CTRL_VALUE_FAILED(rtRet == RT_ERROR_NONE, return ADUMP_FAILED,
        "rtFunctionGetMetaInfo failed, ret=%d, kernelName=%s, dfxSize=%zu.", rtRet, info_.kernelName, dfxSize);

    (void)QueryDfxIsTikInfo(funcHandle);

    IDE_LOGI("Query kernel dfx args info success. kernelName=%s, dfxSize=%zu, isTik=%d", 
        info_.kernelName, dfxSize, isTik_);
    return ADUMP_SUCCESS;
}

int32_t DumpArgsCallback::DumpDfxArgs()
{
    if (info_.argAddr == nullptr || info_.argSize == 0 || info_.bin == nullptr || info_.kernelName[0] == '\0') {
        return ADUMP_SUCCESS;
    }

    IDE_LOGI("Begin to dump dfx args tensors. argAddr=%p, argSize=%u, bin=%p, kernelName=%s",
             info_.argAddr, info_.argSize, info_.bin, info_.kernelName);

    int32_t ret = QueryDfxInfo(dfxBuffer_);
    IDE_CTRL_VALUE_FAILED(ret == ADUMP_SUCCESS, return ADUMP_FAILED, "Query kernel dfx info failed.");

    DfxArgsParser parser;
    ret = parser.Init(info_.argAddr, info_.argSize, dfxBuffer_.data(), static_cast<uint16_t>(dfxBuffer_.size()));
    IDE_CTRL_VALUE_FAILED(ret == ADUMP_SUCCESS, return ADUMP_FAILED, "Dfx args parser init failed.");
    
    parser.SetIsTik(isTik_);
    ret = parser.InitTensorModeInfo();
    IDE_CHECK_RET(ret, return ADUMP_FAILED);
    
    ret = parser.ParseAll();
    IDE_CHECK_RET(ret, return ADUMP_FAILED);
    
    tensorBuffer_ = parser.GetTensors();
    workspaces_ = parser.GetWorkspaces();
    logRecord_ = parser.GetLogRecords();
    
    IDE_LOGI("Dfx args tensors are parsed finished. tensor size=%zu, workspace size=%zu.",
        tensorBuffer_.size(), workspaces_.size());
    
    dumpFile_.SetTensorBuffer(tensorBuffer_);
    dumpFile_.SetWorkspaces(workspaces_);
    
    IDE_LOGI("End to dump dfx args tensors.");
    return ADUMP_SUCCESS;
}

int32_t DumpArgsCallback::DumpExtraTensors()
{
    if (info_.extraTensorNum == 0) {
        return ADUMP_SUCCESS;
    }
    if (info_.extraTensorNum > EXCEPTION_DUMP_MAX_TENSOR_NUM) {
        IDE_LOGE("Extra tensor size exceeds the maximum limit. realSize=%u, maxSize=%u",
            info_.extraTensorNum, EXCEPTION_DUMP_MAX_TENSOR_NUM);
        return ADUMP_FAILED;
    }

    IDE_LOGI("Begin to dump extra tensors. extra tensor size=%u", info_.extraTensorNum);
        
    std::vector<DumpTensor> inputTensors;
    std::vector<DumpTensor> outputTensors;
    std::vector<DumpWorkspace> workspaces;
    uint32_t baseOffset = static_cast<uint32_t>(tensorBuffer_.size() + workspaces_.size());
    
    for (uint32_t i = 0; i < info_.extraTensorNum; ++i) {
        if (info_.extraTensor[i].tensorAddr == nullptr || info_.extraTensor[i].tensorSize == 0) {
            IDE_LOGW("Skip null extra tensor[%u], addr=%p, size=%zu.",
                     i, info_.extraTensor[i].tensorAddr, info_.extraTensor[i].tensorSize);
            continue;
        }
        // tensor基于args偏移offset
        info_.extraTensor[i].argsOffSet = baseOffset + i;
        
        RecordDumpLog(StrUtils::Format("[Dump][Exception] exception info dump extra tensor data, "
            "addr:%p; size:%zu bytes; index:%u(origin:%u); type:%d",
            info_.extraTensor[i].tensorAddr, info_.extraTensor[i].tensorSize,
            info_.extraTensor[i].argsOffSet, i, static_cast<int>(info_.extraTensor[i].type)));
        
        if (info_.extraTensor[i].type == TensorType::INPUT) {
            inputTensors.emplace_back(info_.extraTensor[i]);
        } else if (info_.extraTensor[i].type == TensorType::OUTPUT) {
            outputTensors.emplace_back(info_.extraTensor[i]);
        } else if (info_.extraTensor[i].type == TensorType::WORKSPACE) {
            DumpWorkspace workspace;
            workspace.addr = info_.extraTensor[i].tensorAddr;
            workspace.bytes = info_.extraTensor[i].tensorSize;
            workspace.argsOffset = info_.extraTensor[i].argsOffSet;
            workspaces.push_back(workspace);
        }
    }

    dumpFile_.SetInputTensors(inputTensors);
    dumpFile_.SetOutputTensors(outputTensors);
    dumpFile_.SetWorkspaces(workspaces);

    IDE_LOGI("End to dump extra tensors.");
    return ADUMP_SUCCESS;
}

int32_t DumpArgsCallback::Dump()
{
    int32_t ret = dumpFile_.Dump(logRecord_);
    IDE_CTRL_VALUE_FAILED(ret == ADUMP_SUCCESS, return ADUMP_FAILED,
        "[Dump][Exception] write callback exception to file failed, file: %s", dumpFilePath_.c_str());

    (void)mmChmod(dumpFilePath_.c_str(), M_IRUSR);  // readonly, 400
    IDE_LOGE("[Dump][Exception] dump exception to file, file: %s", dumpFilePath_.c_str());
    return ADUMP_SUCCESS;
}

void DumpArgsCallback::RecordDumpLog(const std::string &log)
{
    IDE_LOGI("%s", log.c_str());
    logRecord_.emplace_back(log + "\n");
}

} // namespace Adx
