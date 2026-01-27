/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "devprof_drv_aicpu.h"
#include <string>
#include "error_code.h"
#include "config/config.h"
#include "ai_drv_prof_api.h"
#include "devprof_common.h"
#include "hash_data.h"
#include "platform_interface.h"

#ifndef RC_MODE
int __attribute__((weak)) halProfQueryAvailBufLen(unsigned int dev_id, unsigned int chan_id, unsigned int *buff_avail_len);
#endif

using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::config;
using namespace analysis::dvvp::driver;
using namespace Devprof;

constexpr uint64_t START_SWITCH = 1U;       // define by runtime
constexpr uint32_t AICPU_SWITCH = 2U;       // define by runtime
constexpr uint32_t MAX_ADD_REPORT_SIZE = 131072; // 512 * sizeof(MsprofAdditionalInfo)
const char * const AICPU_EVENT_GRP_NAME = "prof_aicpu_grp";
const char * const AI_CUSTOM_CPU_EVENT_GRP_NAME = "prof_cus_grp";
const char * const AICPU_PROFILING_REPORT_THREAD_NAME = "Prof_Reporter";

size_t DevprofDrvAicpu::GetBatchReportMaxSize(uint32_t type) const
{
    if (type == ADPROF_ADDITIONAL_INFO) {
        return static_cast<size_t>(MAX_ADD_REPORT_SIZE);
    }
    MSPROF_LOGW("Unable to get batch report size of type: %u", type);
    return 0;
}

int32_t DevprofDrvAicpu::ReportAdditionalInfo(uint32_t agingFlag, ConstVoidPtr data, uint32_t length)
{
    UNUSED(agingFlag);
    if (data == nullptr) {
        MSPROF_LOGE("Report additional info interface input invalid data.");
        return PROFILING_FAILED;
    }
    if (length % sizeof(MsprofAdditionalInfo) != 0 || length > MAX_ADD_REPORT_SIZE) {
        MSPROF_LOGE("Report additional info length [%u bytes] is invalid.", length);
        return PROFILING_FAILED;
    }
    int32_t ret = aicpuAdditionalBuffer_.BatchPush(static_cast<const MsprofAdditionalInfo *>(data), length);
    if (ret != MSPROF_ERROR_NONE) {
        MSPROF_LOGE("Try push buff failed, size: %" PRIu64 " bytes, ret:%d.", length, ret);
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

STATIC int32_t ProfStartAicpu(ProfSampleStartPara *para)
{
    UNUSED(para);
    MSPROF_EVENT("drv start aicpu");
    return DevprofDrvAicpu::instance()->Start();
}

STATIC int32_t ProfSampleAicpu(ProfSamplePara *para)
{
    UNUSED(para);
    return PROFILING_SUCCESS;
}

STATIC int32_t ProfStopAicpu(ProfSampleStopPara *para)
{
    UNUSED(para);
    MSPROF_EVENT("drv stop aicpu");
    DevprofDrvAicpu::instance()->DeviceReportStop();
    return DevprofDrvAicpu::instance()->Stop();
}

DevprofDrvAicpu::DevprofDrvAicpu() : stopped_(false), devId_(0), channelId_(0), profConfig_(0), isRegister_(false)
{
    Thread::SetThreadName(AICPU_PROFILING_REPORT_THREAD_NAME);
    command_.type = static_cast<uint32_t>(PROF_COMMANDHANDLE_TYPE_MAX);
    command_.profSwitch = 0;
    command_.profSwitchHi = 0;
    command_.devNums = 1;
    command_.devIdList[0] = 0;
    command_.modelId = 0;
    command_.cacheFlag = 0;
    command_.params.pathLen = 0;
    command_.params.storageLimit = 0;
    command_.params.profDataLen = 0;
    command_.params.path[PATH_LEN_MAX] = '\0';
    command_.params.profData[PARAM_LEN_MAX] = '\0';
}

DevprofDrvAicpu::~DevprofDrvAicpu()
{
    Stop();
    aicpuAdditionalBuffer_.UnInit();
    moduleCallbacks_.clear();
}

int32_t DevprofDrvAicpu::Init(const struct AicpuStartPara *para)
{
    devId_ = para->devId;
    channelId_ = para->channelId;
    const char *grpName;
    if (para->channelId == PROF_CHANNEL_AICPU) {
        grpName = AICPU_EVENT_GRP_NAME;
    } else if (para->channelId == PROF_CHANNEL_CUS_AICPU) {
        grpName = AI_CUSTOM_CPU_EVENT_GRP_NAME;
    } else {
        MSPROF_LOGE("Get channel id %u is invalid, expect %d or %d",
            para->channelId, PROF_CHANNEL_AICPU, PROF_CHANNEL_CUS_AICPU);
        return PROFILING_FAILED;
    }
    int32_t ret = RegisterDrvChannel(para->devId, para->channelId);
    if (ret != PROFILING_SUCCESS) {
        return PROFILING_FAILED;
    }
    ret = ProfSendEvent(para->devId, para->hostPid, grpName);
    if (ret != PROFILING_SUCCESS) {
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

int32_t DevprofDrvAicpu::Start()
{
    stopped_ = false;
    if (Thread::Start() != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to start reporter %s thread", AICPU_PROFILING_REPORT_THREAD_NAME);
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

int32_t DevprofDrvAicpu::Stop()
{
    stopped_ = true;
    profConfig_ = 0;        // close all prof switch
    if (Thread::Stop() != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to stop report %s thread", AICPU_PROFILING_REPORT_THREAD_NAME);
    }
    aicpuAdditionalBuffer_.Print();
    return PROFILING_SUCCESS;
}

int32_t DevprofDrvAicpu::SendAddtionalInfo() {
    uint32_t times = 0;
    uint32_t waitTimes = 0;
    while(aicpuAdditionalBuffer_.GetUsedSize() != 0) {
        uint64_t allStartTime = analysis::dvvp::common::utils::Utils::GetClockMonotonicRaw();
        uint32_t bufLen = 0;
        int32_t ret = halProfQueryAvailBufLen(devId_, channelId_, &bufLen);
        if (ret != DRV_ERROR_NONE) {
            MSPROF_LOGE("get driver buffer len failed, device id:%u, channel id:%u, ret:%d", devId_, channelId_, ret);
            return PROFILING_FAILED;
        }
        size_t outSize = std::min(static_cast<size_t>(bufLen), analysis::dvvp::common::queue::MAX_DRV_REPORT_SIZE);
        outSize = (outSize / sizeof(MsprofAdditionalInfo)) * sizeof(MsprofAdditionalInfo);
        void *outPtr = aicpuAdditionalBuffer_.BatchPop(outSize, stopped_);
        const uint32_t maxWaitTimes = 3;
        if (outPtr == nullptr) {
            OsalSleep(WAIT_DRV_TIME);
            waitTimes++;
            if (waitTimes >= maxWaitTimes) {
                break;
            }
            continue;
        }
        uint64_t reportStartTime = analysis::dvvp::common::utils::Utils::GetClockMonotonicRaw();
        struct prof_data_report_para profDataReportPara = {outPtr, static_cast<uint32_t>(outSize)};
        ret = halProfSampleDataReport(devId_, channelId_, 0, &profDataReportPara);
        if (ret != DRV_ERROR_NONE) {
            MSPROF_LOGE("report str2id data failed, ret: %d, data size: %zu", ret, outSize);
            return PROFILING_FAILED;
        }
        uint64_t reportEndTime = analysis::dvvp::common::utils::Utils::GetClockMonotonicRaw();
        aicpuAdditionalBuffer_.BatchPopBufferIndexShift(outPtr, outSize);
        uint64_t allEndTime = analysis::dvvp::common::utils::Utils::GetClockMonotonicRaw();
        MSPROF_LOGI("#%u: report str2id data success, report cost: %llu ns, all cost: %llu ns, data size: %zu",
            times, (reportEndTime - reportStartTime), (allEndTime - allStartTime), outSize);
        times++;
    }
    return PROFILING_SUCCESS;
}

void DevprofDrvAicpu::AddStr2IdIntoBuffer(std::string& str) {
    MsprofAdditionalInfo additionInfo;
    additionInfo.magicNumber = MSPROF_REPORT_DATA_MAGIC_NUM;
    additionInfo.level = 0;
    additionInfo.type = 0;
    additionInfo.threadId = 0;
    additionInfo.dataLen = str.length();
    additionInfo.timeStamp = 0;
    (void)memset_s(additionInfo.data, MSPROF_ADDTIONAL_INFO_DATA_LENGTH, 0, MSPROF_ADDTIONAL_INFO_DATA_LENGTH);
    errno_t ret = memcpy_s(additionInfo.data, MSPROF_ADDTIONAL_INFO_DATA_LENGTH, str.c_str(), additionInfo.dataLen+1);
    if(ret != EOK) {
        MSPROF_LOGE("memcpy data into addtionInfo failed, size:%u", additionInfo.dataLen);
        return;
    }
    ReportAdditionalInfo(0, static_cast<void*>(&additionInfo), sizeof(MsprofAdditionalInfo));
    MSPROF_LOGI("add str2id into addtional buffer, size:%u", additionInfo.dataLen);
}

int32_t DevprofDrvAicpu::ReportStr2IdInfoToHost(std::string& dataStr) {
    // keep mark the same with file transport removeStr2IdHeaderMark
    std::string mark = "###drv_hashdata###";
    dataStr.insert(0, mark);
    std::stringstream ss(dataStr);
    std::string item;
    std::string sendStr;
    uint32_t currentSize = 0;
    while (std::getline(ss, item, STR2ID_DELIMITER[0])) {
        uint32_t itemSize = item.length();
        if (itemSize > MSPROF_ADDTIONAL_INFO_DATA_LENGTH) {
            MSPROF_LOGW("str size is over:%u str:%s", MSPROF_ADDTIONAL_INFO_DATA_LENGTH, item.c_str());
            continue;
        }
        if (currentSize + itemSize > MSPROF_ADDTIONAL_INFO_DATA_LENGTH) {
            MSPROF_LOGD("AddStr2IdIntoBuffer str lenght:%u str:%s", sendStr.length(), sendStr.c_str());
            AddStr2IdIntoBuffer(sendStr);
            sendStr = "";
            currentSize = 0;
        }
        if (currentSize > 0) {
            sendStr.append(STR2ID_DELIMITER + item);
        } else {
            sendStr.append(item);
        }
        currentSize += item.length();
    }
    if (currentSize > 0) {
        MSPROF_LOGD("AddStr2IdIntoBuffer str lenght:%u str:%s", sendStr.length(), sendStr.c_str());
        AddStr2IdIntoBuffer(sendStr);
    }
    int32_t ret = SendAddtionalInfo();
    if(ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("send str2id info failed");
        return ret;
    }
    MSPROF_LOGI("send str2id info ok");
    return ret;
}

void DevprofDrvAicpu::Run(const struct error_message::Context &errorContext)
{
    (void)errorContext;
    uint32_t bufLen = 0;
    int32_t ret = halProfQueryAvailBufLen(devId_, channelId_, &bufLen);
    if (ret != DRV_ERROR_NONE) {
        MSPROF_LOGE("get driver buffer len failed, device id:%u, channel id:%u, ret:%d", devId_, channelId_, ret);
        return;
    }

    while(!stopped_ || (aicpuAdditionalBuffer_.GetUsedSize() != 0)) {
        if (aicpuAdditionalBuffer_.GetUsedSize() == 0) {
            (void)OsalSleep(WAIT_DATA_TIME);    // sleep wait data
            continue;
        }
        uint64_t allStartTime = analysis::dvvp::common::utils::Utils::GetClockMonotonicRaw();
        ret = halProfQueryAvailBufLen(devId_, channelId_, &bufLen);
        if (ret != DRV_ERROR_NONE) {
            MSPROF_LOGE("get driver buffer len failed, device id:%u, channel id:%u, ret:%d", devId_, channelId_, ret);
            break;
        }
        size_t outSize = std::min(static_cast<size_t>(bufLen), analysis::dvvp::common::queue::MAX_DRV_REPORT_SIZE);
        outSize = (outSize / sizeof(MsprofAdditionalInfo)) * sizeof(MsprofAdditionalInfo);
        void *outPtr = aicpuAdditionalBuffer_.BatchPop(outSize, stopped_);
        if (outPtr == nullptr) {
            OsalSleep(WAIT_DRV_TIME);
            continue;
        }
        uint64_t reportStartTime = analysis::dvvp::common::utils::Utils::GetClockMonotonicRaw();
        struct prof_data_report_para profDataReportPara = {outPtr, static_cast<uint32_t>(outSize)};
        ret = halProfSampleDataReport(devId_, channelId_, 0, &profDataReportPara);
        if (ret != DRV_ERROR_NONE) {
            MSPROF_LOGE("report data failed, ret: %d, data size: %zu", ret, outSize);
        }
        uint64_t reportEndTime = analysis::dvvp::common::utils::Utils::GetClockMonotonicRaw();
        aicpuAdditionalBuffer_.BatchPopBufferIndexShift(outPtr, outSize);
        uint64_t allEndTime = analysis::dvvp::common::utils::Utils::GetClockMonotonicRaw();
        MSPROF_LOGI("report data success, report cost: %llu ns, all cost: %llu ns, data size: %zu",
            (reportEndTime - reportStartTime), (allEndTime - allStartTime), outSize);
    }
    // send str2id keys to host if not null
    std::string str2Id;
    ret = analysis::dvvp::transport::HashData::instance()->GetHashKeys(str2Id);
    MSPROF_LOGD("dev get hash keys ret:%u and str length:%u", ret, str2Id.length());
    if (ret == PROFILING_SUCCESS && str2Id.length() > 0) {
        MSPROF_LOGI("report str2id info length:%u", str2Id.length());
        ReportStr2IdInfoToHost(str2Id);
    }
}

int32_t DevprofDrvAicpu::RegisterDrvChannel(uint32_t devId, uint32_t channelId)
{
    ProfSampleRegisterPara registerPara = {1, {ProfStartAicpu, ProfSampleAicpu, nullptr, ProfStopAicpu}};
    int32_t ret = halProfSampleRegister(devId, channelId, &registerPara);
    if (ret != DRV_ERROR_NONE) {
        MSPROF_LOGE("Failed to regist aicpu sample ops, ret = %d.", ret);
        return PROFILING_FAILED;
    }
    isRegister_ = true;
    return PROFILING_SUCCESS;
}

bool DevprofDrvAicpu::IsRegister(void) const
{
    return isRegister_;
}

#ifdef __PROF_LLT
void DevprofDrvAicpu::Reset(void)
{
    isRegister_ = false;
    stopped_ = false;
    command_.type = static_cast<uint32_t>(PROF_COMMANDHANDLE_TYPE_MAX);
    command_.profSwitch = 0;
    command_.profSwitchHi = 0;
    profConfig_ = 0;
    moduleCallbacks_.clear();
}
#endif

bool DevprofDrvAicpu::CheckProfilingIsOn(uint64_t profConfig)
{
    constexpr uint32_t AICPU_CHANNEL_SWITCH_MASK = 0x10000U;
    if (profConfig == 0) {
        return false;
    }

    // 校验 aicpu 开关或 aicpu_channel_switch，MC2、HCCL 数据需要通过 aicpu 驱动通道上报
    if ((profConfig & (AICPU_SWITCH | AICPU_CHANNEL_SWITCH_MASK)) == 0) {
        return false;
    }

    if (!aicpuAdditionalBuffer_.Init("AicpuBuffer")) {
        return false;
    };

    return true;
}

/**
 * @ingroup libascend_devprof
 * @name  CommandHandleLaunch
 * @brief Execute all stored callback functions to notify the current status and configuration.
 * @return void
 */
void DevprofDrvAicpu::CommandHandleLaunch()
{
    for (const auto &pair : moduleCallbacks_) {
        MSPROF_LOGI("Execute %u callback function with type:%u, switch:%" PRIu64 ", switchHi:%" PRIu64 ", "
            "model:%u, devNums:%u, cache: %u.",
            pair.first, command_.type, command_.profSwitch, command_.profSwitchHi, command_.modelId, command_.devNums,
            command_.cacheFlag);
        for (auto& handle : pair.second) {
            (void)handle(static_cast<uint32_t>(PROF_CTRL_SWITCH), Utils::ReinterpretCast<void>(&command_),
                static_cast<uint32_t>(sizeof(MsprofCommandHandle)));
        }
    }
}

void DevprofDrvAicpu::DeviceReportStart()
{
    std::lock_guard<std::mutex> lock(aicpuRegisterMutex_);
    // Update current status to START
    command_.type = static_cast<uint32_t>(PROF_COMMANDHANDLE_TYPE_START);
    CommandHandleLaunch();
}

void DevprofDrvAicpu::DeviceReportStop()
{
    std::lock_guard<std::mutex> lock(aicpuRegisterMutex_);
    // Update current status to STOP
    command_.type = static_cast<uint32_t>(PROF_COMMANDHANDLE_TYPE_STOP);
    CommandHandleLaunch();
}

void DevprofDrvAicpu::DoCallbackHandle(uint32_t moduleId, ProfCommandHandle commandHandle)
{
    /* We are not concerned with their execution results; by using detach threads to carry them out, even if they
      encounter deadlocks, it will not affect main execution process. */
    if (command_.type == static_cast<uint32_t>(PROF_COMMANDHANDLE_TYPE_START)) {
        MSPROF_LOGI("Call module %u callback, command type %u", moduleId, command_.type);
        (void)commandHandle(static_cast<uint32_t>(PROF_CTRL_SWITCH),
                            Utils::ReinterpretCast<void>(&command_), sizeof(command_));
    }
}

/**
 * @ingroup libascend_devprof
 * @name  ModuleRegisterCallback
 * @brief Store the incoming callback function; if it is already in the START state, the callback will be executed immediately.
 * @param [in] moduleId: Report ID of the component
 * @param [in] commandHandle: Callback function for component registration
 * @return 0:SUCCESS, !0:FAILED
 */
int32_t DevprofDrvAicpu::ModuleRegisterCallback(uint32_t moduleId, ProfCommandHandle commandHandle)
{
    if (commandHandle == nullptr) {
        return PROFILING_FAILED;
    }

    std::lock_guard<std::mutex> lock(aicpuRegisterMutex_);
    moduleCallbacks_[moduleId].insert(commandHandle);
    MSPROF_LOGI("module %u register callback, current command type %u.", moduleId, command_.type);
    // if command_.type is not TYPE_MAX, 
    if (command_.type != PROF_COMMANDHANDLE_TYPE_MAX) {
        auto callbackBind = std::bind(&DevprofDrvAicpu::DoCallbackHandle, this, moduleId, commandHandle);
        std::thread callbackThread(callbackBind);
        callbackThread.detach();
        MSPROF_LOGD("Registration callback %u successfully, waiting for the next operation.", moduleId);
    }
    return PROFILING_SUCCESS;
}

int32_t DevprofDrvAicpu::AdprofInit(const AicpuStartPara *para)
{
    if (para == nullptr) {
        MSPROF_LOGE("Received para pointer is NULL.");
        return PROFILING_FAILED;
    }
    std::lock_guard<std::mutex> lock(aicpuRegisterMutex_);
    // Update prof config any way.
    SetProfConfig(para->profConfig);

    if (!CheckProfilingIsOn(para->profConfig)) {
        if (command_.type == static_cast<uint32_t>(PROF_COMMANDHANDLE_TYPE_START)) {
            command_.type = static_cast<uint32_t>(PROF_COMMANDHANDLE_TYPE_STOP);
            CommandHandleLaunch();
            MSPROF_LOGI("Profiling stop");
        }
        MSPROF_LOGI("Profiling is not started.");
        return PROFILING_SUCCESS;
    }
    if (IsRegister()) {
        MSPROF_LOGI("Already registered");
        CommandHandleLaunch();
        return PROFILING_SUCCESS;
    }
    MSPROF_EVENT("Aicpu register, device id:%u, host pid:%u, channel id:%u, profConfig:0x%x",
        para->devId, para->hostPid, para->channelId, para->profConfig);

    if (Init(para) != PROFILING_SUCCESS) {
        return PROFILING_FAILED;
    }
    if (analysis::dvvp::transport::HashData::instance()->Init() == PROFILING_FAILED) {
        MSPROF_LOGE("HashData init failed.");
        return PROFILING_FAILED;
    }
    command_.type = static_cast<uint32_t>(PROF_COMMANDHANDLE_TYPE_START);
    CommandHandleLaunch();
    return PROFILING_CONTINUE;
}

void DevprofDrvAicpu::SetProfConfig(uint64_t profConfig)
{
    profConfig_ = profConfig;
    command_.profSwitch = profConfig;
    command_.profSwitchHi = profConfig;
    MSPROF_LOGI("Set profConfig:0x%llx", profConfig);
}

uint64_t DevprofDrvAicpu::GetProfConfig() const
{
    return profConfig_;
}

int32_t DevprofDrvAicpu::CheckFeatureIsOn(uint64_t feature) const
{
    if (((profConfig_ & START_SWITCH) != 0) && ((feature & profConfig_) != 0)) {
        return 1;
    } else {
        return 0;
    }
}

int32_t AdprofRegisterCallback(uint32_t moduleId, ProfCommandHandle commandHandle)
{
    const int32_t ret = DevprofDrvAicpu::instance()->ModuleRegisterCallback(moduleId, commandHandle);
    MSPROF_LOGI("AdprofRegisterCallback execution finished for module %u.", moduleId);
    return ret;
}

uint64_t AdprofGetProfConfig()
{
    return DevprofDrvAicpu::instance()->GetProfConfig();
}

void AdprofSetProfConfig(uint64_t profConfig)
{
    DevprofDrvAicpu::instance()->SetProfConfig(profConfig);
}

void AdprofReportStop()
{
    DevprofDrvAicpu::instance()->DeviceReportStop();
    MSPROF_LOGI("AdprofReportStop execution finished.");
}

void AdprofReportStart()
{
    DevprofDrvAicpu::instance()->DeviceReportStart();
    MSPROF_LOGI("AdprofReportStart execution finished.");
}