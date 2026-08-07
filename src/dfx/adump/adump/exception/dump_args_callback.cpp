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
#include "exception_info_common.h"
#include "kernel_symbol_locator.h"
#include "str_utils.h"
#include "log/adx_log.h"
#include "log/hdc_log.h"

namespace Adx {

DumpArgsCallback::DumpArgsCallback(const rtExceptionInfo &exception, const ExceptionDumpInfo &info,
                                     const std::string &dumpPath)
    : exception_(exception),
      info_(info),
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

    // 先同步落 _host.o，再做慢的 kernel_meta 搜索拷贝。落盘失败需传播，保持与拆分前一致的错误可观测性。
    ret = collector.DumpHostKernelBin(dumpPath_);
    IDE_CTRL_VALUE_WARN(ret == ADUMP_SUCCESS, return ADUMP_FAILED,
        "DumpHostKernelBin failed, kernelName=%s.", kernelName.c_str());

    ret = collector.StartCollectKernel(dumpPath_);
    IDE_CTRL_VALUE_WARN(ret == ADUMP_SUCCESS, return ADUMP_FAILED,
        "StartCollectKernel failed, kernelName=%s.", kernelName.c_str());

    IDE_LOGI("DumpKernelBin success, kernelName=%s.", kernelName.c_str());
    return ADUMP_SUCCESS;
}

int32_t DumpArgsCallback::DumpKernelErrorSymbols()
{
    if (info_.bin == nullptr) {
        return ADUMP_SUCCESS;
    }
    KernelSymbolLocator locator;
    int32_t ret = locator.InitFromBinHandle(info_.bin);
    IDE_CTRL_VALUE_FAILED(ret == ADUMP_SUCCESS, return ADUMP_FAILED,
        "KernelSymbolLocator InitFromBinHandle failed for callback exception. ret=%d", ret);
    locator.UpdateStartPCFromDeviceAddr(info_.bin);

    ExceptionRegInfo exceptionRegInfo{0, nullptr};
    ret = ExceptionInfoCommon::GetExceptionRegInfo(exception_, exceptionRegInfo);
    IDE_CTRL_VALUE_WARN(ret == ADUMP_SUCCESS, return ADUMP_FAILED,
        "Get exception register information failed for callback exception. ret=%d", ret);

    ret = locator.LocateAndPrintErrorSymbolsForCore(info_.coreId, info_.coreType, exceptionRegInfo);
    IDE_CTRL_VALUE_WARN(ret == ADUMP_SUCCESS, return ADUMP_FAILED,
        "LocateAndPrintErrorSymbolsForCore failed for callback exception. ret=%d, coreId=%u, coreType=%u.",
            ret, info_.coreId, info_.coreType);

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

    const uint32_t baseOffset = static_cast<uint32_t>(tensorBuffer_.size() + workspaces_.size());
    std::vector<TensorInfo> tensors(info_.extraTensor, info_.extraTensor + info_.extraTensorNum);
    for (uint32_t i = 0; i < info_.extraTensorNum; ++i) {
        tensors[i].argsOffSet = baseOffset + i;
    }
    dumpFile_.SetTensors(tensors, logRecord_);

    IDE_LOGI("End to dump extra tensors.");
    return ADUMP_SUCCESS;
}

int32_t DumpArgsCallback::Dump()
{
    int32_t ret = dumpFile_.Dump(logRecord_);
    IDE_CTRL_VALUE_FAILED(ret == ADUMP_SUCCESS, return ADUMP_FAILED,
        "[Dump][Exception] Write callback exception to file failed, file: %s", dumpFilePath_.c_str());

    (void)mmChmod(dumpFilePath_.c_str(), M_IRUSR);  // readonly, 400
    IDE_LOGE("[Dump][Exception] dump exception to file, file: %s", dumpFilePath_.c_str());
    return ADUMP_SUCCESS;
}

void DumpArgsCallback::RecordDumpLog(const std::string &log)
{
    IDE_LOGE("%s", log.c_str());
    logRecord_.emplace_back(log + "\n");
}

} // namespace Adx
