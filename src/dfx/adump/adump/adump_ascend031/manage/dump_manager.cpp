/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "dump_manager.h"
#include <thread>
#include <cctype>
#include <cinttypes>
#include <map>
#include <algorithm>
#include <cerrno>
#include "str_utils.h"
#include "lib_path.h"
#include "file_utils.h"
#include "log/adx_log.h"
#include "runtime/context.h"
#include "adump_dsmi.h"
#include "common_utils.h"
#include "dump_config_converter.h"
#include "adump_api.h"

namespace Adx {

// AdumpGetDFXInfoAddr chunk
uint64_t *g_dynamicChunk = nullptr;
uint64_t *g_staticChunk = nullptr;
    
DumpManager::DumpManager()
{
}

DumpManager &DumpManager::Instance()
{
    static DumpManager instance;
    return instance;
}

void DumpManager::KFCResourceInit()
{
    isKFCInit_ = true;
}

int32_t DumpManager::SetDumpConfig(DumpType dumpType, const DumpConfig &dumpConfig)
{
    UNUSED(dumpType);
    UNUSED(dumpConfig);
    std::lock_guard<std::mutex> lk(resourceMtx_);
    return ADUMP_SUCCESS;
}

int32_t DumpManager::SetDumpConfig(const char *dumpConfigData, size_t dumpConfigSize, const char *dumpConfigPath)
{
    std::lock_guard<std::mutex> lk(resourceMtx2_);
    if ((dumpConfigData == nullptr) || (dumpConfigSize == 0U) || (dumpConfigPath == nullptr)) {
        IDE_LOGE("Set dump config failed. Config data is null or empty.");
        return ADUMP_FAILED;
    }
    DumpConfig dumpConfig;
    DumpDfxConfig dumpDfxConfig;
    DumpType dumpType;
    bool needDump = true;
    DumpConfigConverter converter{dumpConfigData, dumpConfigSize, dumpConfigPath};
    int32_t ret = converter.Convert(dumpType, dumpConfig, needDump, dumpDfxConfig);
    if (ret != ADUMP_SUCCESS) {
        IDE_LOGE("Parse dump config from memory[%s] failed.", dumpConfigData);
        return ADUMP_INPUT_FAILED;
    }
    if (!needDump) {
        return ADUMP_SUCCESS;
    }

    (void)dumpConfigInfo_.assign(dumpConfigData, dumpConfigSize);
    IDE_LOGI("Dump config info set: addr=%p, size=%zu", dumpConfigInfo_.data(), dumpConfigInfo_.size());
    ret = SetDumpConfig(dumpType, dumpConfig);
    for (auto &item : enableCallbackFunc_) {
        IDE_LOGI("SetDumpConfig HandleDumpEvent start for module [%zu]", item.first);
        HandleDumpEvent(item.first, DumpEnableAction::ENABLE);
    }
    IDE_CTRL_VALUE_FAILED(ret == ADUMP_SUCCESS, return ret, "Set dump config failed.");
    (void)openedDump_.insert(dumpType);
    return ADUMP_SUCCESS;
}

int32_t DumpManager::UnSetDumpConfig()
{
    std::lock_guard<std::mutex> lk(resourceMtx2_);
    DumpConfig config;
    config.dumpStatus = ADUMP_DUMP_STATUS_SWITCH_OFF;
    for (const auto dumpType : openedDump_) {
        if (IsEnableDump(dumpType)) {
            const auto ret = SetDumpConfig(dumpType, config);
            if (ret != ADUMP_SUCCESS) {
                IDE_LOGE("[Set][Dump]set dump off failed, dumpType:[%d], errorCode = %d",
                         static_cast<int32_t>(dumpType), ret);
                return ADUMP_FAILED;
            }
            IDE_LOGI("set dump off successfully, dumpType:[%d].", static_cast<int32_t>(dumpType));
        }
    }
    openedDump_.clear();
    for (auto& item : disableCallbackFunc_) {
        IDE_LOGI("UnSetDumpConfig start for module [%zu]", item.first);
        HandleDumpEvent(item.first, DumpEnableAction::DISABLE);
    }
    dumpConfigInfo_.clear();
    IDE_LOGI("Dump config info cleared.");
    return ADUMP_SUCCESS;
}

std::string DumpManager::GetBinName() const
{
    return "";
}

bool DumpManager::CheckBinValidation()
{
    return false;
}

bool DumpManager::IsEnableDump(DumpType dumpType)
{
    std::lock_guard<std::mutex> lk(resourceMtx_);
    if (dumpType == DumpType::OPERATOR) {
        return dumpSetting_.GetDumpStatus();
    } else if (dumpType == DumpType::OP_OVERFLOW) {
        return dumpSetting_.GetDumpDebugStatus();
    } else {
        IDE_LOGW("Dump type is not support.");
    }
    return false;
}

int32_t DumpManager::DumpOperator(const std::string &opType, const std::string &opName,
                                  const std::vector<TensorInfo> &tensors, rtStream_t stream)
{
    UNUSED(opType);
    UNUSED(opName);
    UNUSED(tensors);
    UNUSED(stream);
    return ADUMP_SUCCESS;
}

int32_t DumpManager::DumpOperatorV2(const std::string &opType, const std::string &opName,
                                const std::vector<TensorInfoV2> &tensors, rtStream_t stream)
{
    UNUSED(opType);
    UNUSED(opName);
    UNUSED(tensors);
    UNUSED(stream);
    return ADUMP_SUCCESS;
}

int32_t DumpManager::DumpOperatorWithCfg(const std::string &opType, const std::string &opName,
    const std::vector<TensorInfo> &tensors, aclrtStream stream, const DumpCfg &dumpCfg)
{
    UNUSED(opType);
    UNUSED(opName);
    UNUSED(tensors);
    UNUSED(stream);
    UNUSED(dumpCfg);
    return ADUMP_SUCCESS;
}

void DumpManager::AddExceptionOp(const OperatorInfo &opInfo)
{
    UNUSED(opInfo);
}

void DumpManager::AddExceptionOpV2(const OperatorInfoV2 &opInfo)
{
    UNUSED(opInfo);
}

int32_t DumpManager::DelExceptionOp(uint32_t deviceId, uint32_t streamId)
{
    UNUSED(deviceId);
    UNUSED(streamId);
    return ADUMP_SUCCESS;
}

std::vector<TensorInfoV2> DumpManager::ConvertTensorInfoToDumpTensorV2(const std::vector<TensorInfo> &tensorInfos) const
{
    std::vector<TensorInfoV2> tensors;
    tensors.reserve(tensorInfos.size());
    for (const auto& tensorInfo : tensorInfos) {
        TensorInfoV2 tensor ={};
        ConvertTensorInfo(tensorInfo, tensor);
        tensors.emplace_back(tensor);
    }
    return tensors;
}

void DumpManager::ConvertTensorInfo(const TensorInfo &tensorInfo, TensorInfoV2 &tensor) const
{
    tensor.dataType = tensorInfo.dataType;
    tensor.format = tensorInfo.format;
    tensor.placement = tensorInfo.placement;
    tensor.tensorAddr = tensorInfo.tensorAddr;
    tensor.tensorSize = tensorInfo.tensorSize;
    tensor.type = tensorInfo.type;
    tensor.addrType = tensorInfo.addrType;
    tensor.argsOffSet = tensorInfo.argsOffSet;
    std::vector<int64_t> shape = tensorInfo.shape;
    for (auto dim : shape) {
        tensor.shape.emplace_back(static_cast<uint64_t>(dim));
    }
    std::vector<int64_t> originShape = tensorInfo.originShape;
    for (auto dim : originShape) {
        tensor.originShape.emplace_back(static_cast<uint64_t>(dim));
    }
}

void DumpManager::ConvertOperatorInfo(const OperatorInfo &opInfo, OperatorInfoV2 &operatorInfoV2) const
{
    operatorInfoV2.agingFlag = opInfo.agingFlag;
    operatorInfoV2.taskId = opInfo.taskId;
    operatorInfoV2.streamId = opInfo.streamId;
    operatorInfoV2.deviceId = opInfo.deviceId;
    operatorInfoV2.contextId = opInfo.contextId;
    operatorInfoV2.opType = opInfo.opType;
    operatorInfoV2.opName = opInfo.opName;
    operatorInfoV2.tensorInfos = ConvertTensorInfoToDumpTensorV2(opInfo.tensorInfos);
    operatorInfoV2.deviceInfos = opInfo.deviceInfos;
    operatorInfoV2.additionalInfo = opInfo.additionalInfo;
}

uint64_t DumpManager::AdumpGetDumpSwitch()
{
    std::lock_guard<std::mutex> lk(resourceMtx_);
    return dumpSetting_.GetDumpSwitch();
}

DumpSetting DumpManager::GetDumpSetting() const
{
    return dumpSetting_;
}

int32_t DumpManager::RegisterCallback(uint32_t moduleId, AdumpCallback enableFunc, AdumpCallback disableFunc)
{
    if (enableFunc == nullptr) {
        IDE_LOGE("Register callback failed: enableFunc is null for module %u", moduleId);
        return ADUMP_FAILED;
    }

    if (disableFunc == nullptr) {
        IDE_LOGE("Register callback failed: disableFunc is null for module %u", moduleId);
        return ADUMP_FAILED;
    }
    std::lock_guard<std::mutex> lk(resourceMtx2_);
    enableCallbackFunc_[moduleId] = enableFunc;
    disableCallbackFunc_[moduleId] = disableFunc;
    IDE_LOGI("Registered callback for module %u", moduleId);
    return HandleDumpEvent(moduleId, DumpEnableAction::AUTO);
}

int32_t DumpManager::HandleDumpEvent(uint32_t moduleId, DumpEnableAction action)
{
    IDE_LOGI("RegisterCallback HandleDumpEvent start for module %u", moduleId);
    const uint64_t dumpSwitch = dumpSetting_.GetDumpSwitch();
    auto callbackFunc = disableCallbackFunc_[moduleId];
    if (action == DumpEnableAction::ENABLE) {
        callbackFunc = enableCallbackFunc_[moduleId];
    }
    if (action == DumpEnableAction::AUTO) {
        if (dumpConfigInfo_.data() == nullptr || dumpConfigInfo_.size() == 0U) {
            IDE_LOGW("Config data is null or empty. Not trigger HandleDumpEvent. ");
            return ADUMP_SUCCESS;
        }
        if (dumpSwitch > 0U) {
            callbackFunc = enableCallbackFunc_[moduleId];
        }
    }

    if (!callbackFunc) {
        IDE_LOGE("No registered callback for module %u", moduleId);
        return ADUMP_FAILED;
    }

    IDE_LOGI("HandleDumpEvent callbackFunc start for module [%zu]", moduleId);
    IDE_LOGI("HandleDumpEvent callbackFunc switch [%" PRIu64 "]", dumpSwitch);
    IDE_LOGI("HandleDumpEvent callbackFunc Dump config info: addr=%p, size=%zu", dumpConfigInfo_.data(), dumpConfigInfo_.size());
    int32_t result = callbackFunc(dumpSwitch, dumpConfigInfo_.data(), dumpConfigInfo_.size());
    IDE_LOGI("callbackFunc returned: %d", result);
    return result;
}

#ifdef __ADUMP_LLT
void DumpManager::Reset()
{
}

bool DumpManager::GetKFCInitStatus()
{
    return isKFCInit_;
}

void DumpManager::SetKFCInitStatus(bool status)
{
    isKFCInit_ = status;
}
#endif
}  // namespace Adx