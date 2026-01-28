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
#include "operator_dumper.h"
#include "adx_dump_record.h"
#include "common/file.h"

namespace Adx {
constexpr char EXCEPTION_CB_MODULE[] = "AdumpException";
constexpr char COREDUMP_CB_MODULE[] = "AdumpCoredump";
static const uint32_t ADUMP_ACL_ERROR_RT_AICORE_OVER_FLOW = 207003;  // aicore over flow
static const uint32_t ADUMP_ACL_ERROR_RT_AIVEC_OVER_FLOW = 207016;   // aivec over flow

std::vector<std::shared_ptr<OperatorPreliminary>> DumpManager::operatorMap_;

static void ExceptionCallback(rtExceptionInfo *const exception)
{
    IDE_RUN_LOGI("An exception callback message is received.");
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

        (void)DumpManager::Instance().DumpExceptionInfo(*exception);
        AdxLogFlush();
    }
}

static void NotifyCoredumpCallback(uint32_t devId, bool isOpen)
{
    static std::map<uint32_t, uint32_t> setDeviceRecord;
    static std::mutex coredumpMtx;
    std::lock_guard<std::mutex> lk(coredumpMtx);
    auto it = setDeviceRecord.find(devId);
    if (!isOpen) {
        if (it != setDeviceRecord.end()) {
            it->second--;
            if (it->second == 0) {
                setDeviceRecord.erase(it);
                IDE_LOGI("Device %u has been removed from the effective list.", devId);
            }
        }
        return;
    }
    if (it != setDeviceRecord.end()) {
        it->second++;
        return;
    }
    rtError_t ret = rtDebugSetDumpMode(RT_DEBUG_DUMP_ON_EXCEPTION);
    if (ret != RT_ERROR_NONE) {
        IDE_RUN_LOGI("detail exception dump mode not support, switch to lite exception dump, ret:%d", ret);
        DumpManager::Instance().ExceptionModeDowngrade();
    }
    IDE_LOGI("Device %u has been added to the effective list.", devId);
    setDeviceRecord[devId] = 1;
}

DumpManager &DumpManager::Instance()
{
    static DumpManager instance;
    return instance;
}

DumpManager::DumpManager()
{
    // enable dump functions with environment variables
    DumpConfig config;
    // 1. check and enable L1 exception dump with NPU_COLLECT_PATH
    if (DumpConfigConverter::EnabledExceptionWithEnv(config)) {
        if (SetDumpConfig(DumpType::EXCEPTION, config) != ADUMP_SUCCESS) {
            IDE_LOGW("Enable L1 exception dump with env[NPU_COLLECT_PATH] failed!");
        }
    }
}

void DumpManager::KFCResourceInit()
{
#if !defined(ADUMP_SOC_HOST) || ADUMP_SOC_HOST == 1
    if (isKFCInit_) {
        IDE_LOGD("KFC resources have been initialized on all devices.");
        return;
    }
    std::vector<uint32_t> devList = AdumpDsmi::DrvGetDeviceList();

    for (uint32_t &deviceId : devList) {
        IDE_LOGI("Start to initialize KFC resources on device %u.", deviceId);
        SharedPtr<OperatorPreliminary> opIniter = MakeSharedInstance<OperatorPreliminary>(GetDumpSetting(), deviceId);
        IDE_CTRL_VALUE_FAILED_NODO(opIniter != nullptr && opIniter->OperatorInit() == ADUMP_SUCCESS, return,
                                   "Failed to execute the resource initialization task on device %u.", deviceId);
        DumpManager::operatorMap_.emplace_back(std::move(opIniter));
        IDE_LOGI("KFC executed on the device %u successfully.", deviceId);
    }
#endif
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
    if (dumpType == DumpType::AIC_ERR_DETAIL_DUMP && !CheckCoredumpSupportedPlatform()) {
        IDE_LOGE("Current platform is not support coredump mode.");
        return ADUMP_FAILED;
    }

    IDE_RUN_LOGI("Set %d dump setting, status: %s, dump switch: %llu", dumpType, dumpConfig.dumpStatus.c_str(),
        dumpConfig.dumpSwitch);
    if (exceptionDumper_.ExceptionDumperInit(dumpType, dumpConfig) != ADUMP_SUCCESS) {
        IDE_LOGW("Failed to initialize the exception dump.");
        return ADUMP_SUCCESS;
    }
    dumpSetting_.InitDumpSwitch(dumpConfig.dumpSwitch & DUMP_SWITCH_MASK);
    IDE_CTRL_VALUE_WARN(RegsiterExceptionCallback(), return ADUMP_SUCCESS,
        "Failed to register the args exception dump callback function.");
    if (exceptionDumper_.GetCoredumpStatus()) { // 如果启动了coredump模式
        IDE_CTRL_VALUE_FAILED(rtRegDeviceStateCallbackEx(COREDUMP_CB_MODULE, &NotifyCoredumpCallback,
            DEV_CB_POS_BACK) == RT_ERROR_NONE, return ADUMP_FAILED,
            "Failed to register the coredump callback function to rtSetDevice.");
    }
    return ADUMP_SUCCESS;
}

int32_t DumpManager::SetDumpConfig(DumpType dumpType, const DumpConfig &dumpConfig)
{
    std::lock_guard<std::mutex> lk(resourceMtx_);
    if (dumpType == DumpType::EXCEPTION || dumpType == DumpType::ARGS_EXCEPTION ||
        dumpType == DumpType::AIC_ERR_DETAIL_DUMP) {
        return ExceptionConfig(dumpType, dumpConfig);
    }
    auto ret = dumpSetting_.Init(dumpType, dumpConfig);
    if (ret != ADUMP_SUCCESS) {
        return ret;
    }

    if (CheckBinValidation() && (isKFCInit_ == false)) {
        auto kfcBind = std::bind(&DumpManager::KFCResourceInit, this);
        std::thread kfcThread(kfcBind);
        kfcThread.join();
        if (!isKFCInit_) {
            IDE_LOGE("SetDumpConfig failed due to fkc resource initialization error.");
            DumpManager::operatorMap_.clear();
            return ADUMP_FAILED;
        }
    }
    IDE_RUN_LOGI("Set %d dump setting, status: %s, mode: %s, data: %s, dump switch: %llu, path:%s, dump stats:%s.",
        dumpType, dumpConfig.dumpStatus.c_str(), dumpConfig.dumpMode.c_str(), dumpConfig.dumpData.c_str(),
        dumpConfig.dumpSwitch, dumpConfig.dumpPath.c_str(), StrUtils::ToString(dumpConfig.dumpStatsItem).c_str());
    return ADUMP_SUCCESS;
}

int32_t DumpManager::SetDumpConfig(const char *dumpConfigData, size_t dumpConfigSize)
{
    std::lock_guard<std::mutex> lk(resourceMtx2_);
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
    // 同步触发callbcak事件
    for (auto& item : enableCallbackFunc_) {
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
    config.dumpSwitch = 0;
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
    // 同步触发callbcak事件
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
    auto it = BIN_NAME_MAP.find(dumpSetting_.GetPlatformType());
    if (it != BIN_NAME_MAP.cend()) {
        return it->second;
    }
    return "";
}

bool DumpManager::CheckBinValidation()
{
    const std::string opName = GetBinName();
    if ((dumpSetting_.GetDumpData().compare(DUMP_STATS_DATA) != 0) || opName.empty()) {
        return false;
    }
    const std::string opPath = LibPath::Instance().GetTargetPath(opName);
    IDE_CTRL_VALUE_FAILED(!opPath.empty(), return false, "Received an empty path for file %s.", opName.c_str());
    bool isExist = FileUtils::IsFileExist(opPath);
    IDE_LOGI("CheckBinValidation result is %s", isExist ? "true" : "false");
    return isExist;
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
                                  const std::vector<TensorInfo> &tensors, aclrtStream stream)
{
    return DumpOperatorV2(opType, opName, ConvertTensorInfoToDumpTensorV2(tensors), stream);
}

int32_t DumpManager::DumpOperatorV2(const std::string &opType, const std::string &opName,
                                  const std::vector<TensorInfoV2> &tensors, aclrtStream stream)
{
    std::lock_guard<std::mutex> lk(resourceMtx_);
    if (!dumpSetting_.GetDumpStatus() && !dumpSetting_.GetDumpDebugStatus()) {
        IDE_LOGW("Operator or overflow dump is not enable, can't dump.");
        return ADUMP_SUCCESS;
    }

    std::vector<DumpTensor> inputTensors;
    std::vector<DumpTensor> outputTensors;
    for (const auto &tensorInfo : tensors) {
        if (tensorInfo.tensorAddr == nullptr || tensorInfo.tensorSize == 0) {
            IDE_LOGE("Tensor is nullptr.");
            return ADUMP_FAILED;
        }

        if (tensorInfo.placement != TensorPlacement::kOnDeviceHbm) {
            IDE_LOGW("Tensor of of %s[%s] is on device, skip it.", opName.c_str(), opType.c_str());
            continue;
        }

        if (tensorInfo.type == TensorType::INPUT) {
            inputTensors.emplace_back(tensorInfo);
        } else if (tensorInfo.type == TensorType::OUTPUT) {
            outputTensors.emplace_back(tensorInfo);
        }
    }
    OperatorDumper opDumper(opType, opName);
    int32_t ret = opDumper.SetDumpSetting(dumpSetting_)
                      .RuntimeStream(stream)
                      .InputDumpTensor(inputTensors)
                      .OutputDumpTensor(outputTensors)
                      .Launch();
    if (ret != ADUMP_SUCCESS) {
        IDE_LOGE("Launch dump operator failed.");
        return ret;
    }
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

int32_t DumpManager::StartDumpArgs(const std::string &dumpPath)
{
    std::lock_guard<std::mutex> lk(resourceMtx_);
    uint64_t dumpSwitch = dumpSetting_.GetDumpSwitch();
    if ((dumpSwitch & OP_INFO_RECORD_DUMP) == OP_INFO_RECORD_DUMP) {
        IDE_LOGW("Double OpInfoRecord Start Entry");
        return -1;
    }

    Adx::Path path(dumpPath);
    if (path.Empty()) {
        IDE_LOGE("OpInfoRecord path[%s] is empty", dumpPath.c_str());
        return -1;
    }
    if (!path.Exist()) {
        if (!path.CreateDirectory(true)) {
            IDE_LOGE("Create path[%s] failed, strerr: %s", dumpPath.c_str(), strerror(errno));
            return -1;
        }
    }
    if (!path.IsDirectory()) {
        IDE_LOGE("OpInfoRecord path[%s] is not directory!", dumpPath.c_str());
        return -1;
    }

    dumpSwitch |= OP_INFO_RECORD_DUMP;
    dumpSetting_.InitDumpSwitch(dumpSwitch);
    opInfoRecordPath_ = path.GetString();

    for (auto &item : enableCallbackFunc_) {
        item.second(dumpSwitch, dumpConfigInfo_.data(), dumpConfigInfo_.size());
    }
    IDE_RUN_LOGI("OpInfoRecord start success!");
    return 0;
}

int32_t DumpManager::StopDumpArgs()
{
    std::lock_guard<std::mutex> lk(resourceMtx_);
    uint64_t dumpSwitch = dumpSetting_.GetDumpSwitch();
    if ((dumpSwitch & OP_INFO_RECORD_DUMP) != OP_INFO_RECORD_DUMP) {
        return 0;
    }
    IDE_RUN_LOGI("OpInfoRecord Stop Entry!");
    dumpSwitch &= ~OP_INFO_RECORD_DUMP;
    dumpSetting_.InitDumpSwitch(dumpSwitch);
        for (auto &item : disableCallbackFunc_) {
        item.second(dumpSwitch, dumpConfigInfo_.data(), dumpConfigInfo_.size());
    }
    IDE_RUN_LOGI("OpInfoRecord success!");
    return 0;
}

const char* DumpManager::GetExceptionDumpPath()
{
    std::lock_guard<std::mutex> lk(resourceMtx_);
    exceptionDumper_.CreateExtraDumpPath();
    return exceptionDumper_.GetExtraDumpCPath();
}

const char* DumpManager::GetDataDumpPath()
{
    std::lock_guard<std::mutex> lk(resourceMtx_);
    return dumpSetting_.GetDumpCPath();
}

int32_t DumpManager::SaveFile(const char *data, size_t dataLen, const char *fileName, SaveType type)
{
    Adx::Path filePath(opInfoRecordPath_);
    filePath.Concat(fileName);
    Adx::Path dirPath = filePath.ParentPath();
    if (!dirPath.Exist()) {
        if (!dirPath.CreateDirectory(true)) {
            IDE_LOGE("create directory[%s] failed", dirPath.GetCString());
            return -1;
        }
    }
    if (!dirPath.RealPath()) {
        IDE_LOGE("get real path failed, path:%s", dirPath.GetCString());
    }

    std::string canonicalPath = dirPath.GetString() + "/" + filePath.GetFileName();
    int32_t openFlag = 0;
    if (type == SaveType::OVERWRITE) {
        openFlag = O_CREAT | O_WRONLY | O_TRUNC;
    } else {
        openFlag = O_CREAT | O_WRONLY | O_APPEND;
    }
    File file(canonicalPath, openFlag);

    if (file.IsFileOpen() != 0) {
        IDE_LOGE("open file[%s] failed!", fileName);
        return -1;
    }
    int64_t ret = file.Write(data, dataLen);
    IDE_CTRL_VALUE_FAILED(ret >= 0, return -1, "Save file %s failed!", fileName);

    IDE_LOGI("DumpJsonToFile %s success!", fileName);
    return 0;
}

// DUMP 配置变化时，触发dump事件，同步回调用户接口
int32_t DumpManager::HandleDumpEvent(uint32_t moduleId, DumpEnableAction action)
{
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
