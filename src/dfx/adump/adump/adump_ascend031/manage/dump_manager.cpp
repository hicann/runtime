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
#include "exception_info_common.h"
#include "dump_config_converter.h"
#include "adump_api.h"

namespace Adx {
constexpr char EXCEPTION_CB_MODULE[] = "AdumpException";
constexpr char COREDUMP_CB_MODULE[] = "AdumpCoredump";
static const uint32_t ADUMP_ACL_ERROR_RT_AICORE_OVER_FLOW = 207003;  // aicore over flow
static const uint32_t ADUMP_ACL_ERROR_RT_AIVEC_OVER_FLOW = 207016;   // aivec over flow

static void ExceptionCallback(rtExceptionInfo *const exception)
{
    IDE_LOGD("An exception callback message is received.");
    if (exception != nullptr) {
        if (exception->retcode == ADUMP_ACL_ERROR_RT_AICORE_OVER_FLOW ||
            exception->retcode == ADUMP_ACL_ERROR_RT_AIVEC_OVER_FLOW) {
            IDE_LOGW("Ignore exception dump request, retcode: %u.", exception->retcode);
            return;
        }
        rtExceptionArgsInfo_t exceptionArgsInfo{};
        rtExceptionExpandType_t exceptionTaskType = exception->expandInfo.type;
        if (ExceptionInfoCommon::GetExceptionInfo(*exception, exceptionTaskType, exceptionArgsInfo) != ADUMP_SUCCESS) {
            IDE_LOGW("Get exception args info failed.");
            return;
        }
        rtContext_t curCtx = nullptr;
        bool isCreate = false;
        rtError_t rtRet = rtCtxGetCurrent(&curCtx);
        if (rtRet != RT_ERROR_NONE) {
            rtRet = rtCtxCreate(&curCtx, RT_CTX_NORMAL_MODE, exception->deviceid);
            if (rtRet != RT_ERROR_NONE) {
                IDE_LOGE("Call rtCtxCreate falied, ret: 0x%X.", rtRet);
            } else {
                isCreate = true;
            }
        }

        (void)DumpManager::Instance().DumpExceptionInfo(*exception);

        if (isCreate && (rtCtxGetCurrent(&curCtx) == RT_ERROR_NONE)) {
            rtRet = rtCtxDestroy(curCtx);
            if (rtRet != RT_ERROR_NONE) {
                IDE_LOGE("Call rtCtxDestroy failed, ret: 0x%X.", rtRet);
            }
        }
    }
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

int32_t DumpManager::ExceptionConfig(DumpType dumpType, const DumpConfig &dumpConfig)
{
    if ((exceptionDumper_.GetExceptionStatus() || exceptionDumper_.GetArgsExceptionStatus() ||
            exceptionDumper_.GetCoredumpStatus())) {
        std::string dumpStatus = dumpConfig.dumpStatus;
        std::transform(dumpStatus.begin(), dumpStatus.end(), dumpStatus.begin(), ::tolower);
        if (dumpStatus == "on") {
            IDE_LOGI("Exception dump is already enable, can't enable dump type[%d] again.", dumpType);
            return ADUMP_SUCCESS;
        }
    }

    IDE_LOGI("Set %d dump setting, status: %s, dump switch: %llu", dumpType, dumpConfig.dumpStatus.c_str(),
        dumpConfig.dumpSwitch);
    if (exceptionDumper_.ExceptionDumperInit(dumpType, dumpConfig) != ADUMP_SUCCESS) {
        IDE_LOGW("Failed to initialize the exception dump.");
        return ADUMP_SUCCESS;
    }
    dumpSetting_.InitDumpSwitch(dumpConfig.dumpSwitch & DUMP_SWITCH_MASK);
    IDE_CTRL_VALUE_WARN(RegsiterExceptionCallback(), return ADUMP_SUCCESS,
        "Failed to register the args exception dump callback function.");

    return ADUMP_SUCCESS;
}

int32_t DumpManager::SetDumpConfig(DumpType dumpType, const DumpConfig &dumpConfig)
{
    std::lock_guard<std::mutex> lk(resourceMtx_);
    if (dumpType == DumpType::EXCEPTION || dumpType == DumpType::ARGS_EXCEPTION ||
        dumpType == DumpType::AIC_ERR_DETAIL_DUMP) {
        return ExceptionConfig(dumpType, dumpConfig);
    }
    return ADUMP_SUCCESS;
}

int32_t DumpManager::SetDumpConfig(const char *dumpConfigData, size_t dumpConfigSize)
{
    std::lock_guard<std::mutex> lk(resourceMtx2_);
    DumpConfig config;
    if (DumpConfigConverter::EnabledExceptionWithEnv(config)) {
        IDE_CTRL_VALUE_FAILED(SetDumpConfig(DumpType::EXCEPTION, config) == ADUMP_SUCCESS,
            return ADUMP_FAILED, "Set exception dump config failed");
    }

    if ((dumpConfigData == nullptr) || (dumpConfigSize == 0U)) {
        IDE_LOGE("Set dump config failed. Config data is null or empty.");
        return ADUMP_FAILED;
    }
    DumpConfig dumpConfig;
    DumpType dumpType;
    bool needDump = true;
    DumpConfigConverter converter{dumpConfigData, dumpConfigSize};
    int32_t ret = converter.Convert(dumpType, dumpConfig, needDump);
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
    // 同步触发callback事件
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
    // 同步触发callback事件
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
    if (dumpType == DumpType::ARGS_EXCEPTION) {
        return exceptionDumper_.GetArgsExceptionStatus() || exceptionDumper_.GetCoredumpStatus();
    } else if (dumpType == DumpType::OPERATOR) {
        return dumpSetting_.GetDumpStatus();
    } else if (dumpType == DumpType::OP_OVERFLOW) {
        return dumpSetting_.GetDumpDebugStatus();
    } else if (dumpType == DumpType::EXCEPTION) {
        return exceptionDumper_.GetExceptionStatus();
    } else if (dumpType == DumpType::AIC_ERR_DETAIL_DUMP) {
        return exceptionDumper_.GetCoredumpStatus();
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

void DumpManager::AddExceptionOp(const OperatorInfo &opInfo)
{
    exceptionDumper_.AddDumpOperator(opInfo);
}

void DumpManager::AddExceptionOpV2(const OperatorInfoV2 &opInfo)
{
    exceptionDumper_.AddDumpOperatorV2(opInfo);
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

int32_t DumpManager::DelExceptionOp(uint32_t deviceId, uint32_t streamId)
{
    return exceptionDumper_.DelDumpOperator(deviceId, streamId);
}

int32_t DumpManager::DumpExceptionInfo(const rtExceptionInfo &exception)
{
    return exceptionDumper_.DumpException(exception);
}

uint64_t DumpManager::AdumpGetDumpSwitch()
{
    std::lock_guard<std::mutex> lk(resourceMtx_);
    return dumpSetting_.GetDumpSwitch();
}

bool DumpManager::RegsiterExceptionCallback()
{
    if (!registered_ && rtRegTaskFailCallbackByModule(EXCEPTION_CB_MODULE, ExceptionCallback) == RT_ERROR_NONE) {
        registered_ = true;
    }
    IDE_LOGI("Register exception callback, registered: %d", static_cast<int32_t>(registered_));
    return registered_;
}

DumpSetting DumpManager::GetDumpSetting() const
{
    return dumpSetting_;
}

void DumpManager::ExceptionModeDowngrade()
{
    exceptionDumper_.ExceptionModeDowngrade();
}

bool DumpManager::CheckCoredumpSupportedPlatform() const
{
    return false;
}

int32_t DumpManager::RegisterCallback(uint32_t moduleId, AdumpCallback enableFunc, AdumpCallback disableFunc)
{
    if (enableFunc == nullptr)
    {
        IDE_LOGE("Register callback failed: enableFunc is null for module %u", moduleId);
        return ADUMP_FAILED;
    }

    if (disableFunc == nullptr)
    {
        IDE_LOGE("Register callback failed: disableFunc is null for module %u", moduleId);
        return ADUMP_FAILED;
    }
    std::lock_guard<std::mutex> lk(resourceMtx2_);
    enableCallbackFunc_[moduleId] = enableFunc;
    disableCallbackFunc_[moduleId] = disableFunc;
    IDE_LOGI("Registered callback for module %u", moduleId);
    return HandleDumpEvent(moduleId, DumpEnableAction::AUTO);
}

// DUMP 配置变化时，触发dump事件，同步回调用户接口
int32_t DumpManager::HandleDumpEvent(uint32_t moduleId,DumpEnableAction action)
{
    IDE_LOGI("RegisterCallback HandleDumpEvent start for module %u", moduleId);
    const uint64_t dumpSwitch = dumpSetting_.GetDumpSwitch();
    auto callbackFunc = disableCallbackFunc_[moduleId];
    if (action == DumpEnableAction::ENABLE) {
        callbackFunc = enableCallbackFunc_[moduleId];
    }
    if (action == DumpEnableAction::AUTO) {
        if (dumpConfigInfo_.data() == nullptr || dumpConfigInfo_.size() == 0U) {
            IDE_LOGW("Config data is null or empty. Not trigger HandleDumpEvent.");
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
    registered_ = false;
    exceptionDumper_.Reset();
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
