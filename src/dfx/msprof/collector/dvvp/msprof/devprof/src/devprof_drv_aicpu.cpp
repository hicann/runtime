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
#include "base/log_types.h"
#include "config/config.h"
#include "ai_drv_prof_api.h"
#include "devprof_common.h"
#include "hash_data.h"
#include "platform_interface.h"

#ifndef RC_MODE
int __attribute__((weak)) halProfQueryAvailBufLen(unsigned int dev_id, unsigned int chan_id, unsigned int *buff_avail_len);
#endif
int __attribute__((weak)) halProfSampleRegisterEx(unsigned int dev_id, unsigned int chan_id, struct prof_sample_register_para *para);

using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::config;
using namespace analysis::dvvp::driver;
using namespace Devprof;

constexpr uint64_t START_SWITCH = 1U;       // define by runtime
constexpr uint32_t AICPU_SWITCH = 2U;       // define by runtime
constexpr uint32_t MAX_ADD_REPORT_SIZE = 131072; // 512 * sizeof(MsprofAdditionalInfo)
constexpr uint64_t HOST_MOVE_BUFFER_SIZE = 4 * 1024 * 1024;
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

STATIC int32_t ProfStartHostMove(ProfSampleStartPara *para)
{
    if ((para->out_data == nullptr) ||
        (para->out_data_max_len < sizeof(Devprof::AicpuUserProfileBufferInfo))) {
        MSPROF_LOGE("Host move: out_data invalid (ptr=%p, max_len=%u, need=%zu)",
            para->out_data, para->out_data_max_len, sizeof(Devprof::AicpuUserProfileBufferInfo));
        return PROFILING_FAILED;
    }

    auto instance = DevprofDrvAicpu::instance();
    auto *info = static_cast<Devprof::AicpuUserProfileBufferInfo *>(para->out_data);
    if (instance->RecordHostMoveBufferAddresses(info) != PROFILING_SUCCESS) {
        return PROFILING_FAILED;
    }
    instance->SetSupportHostMove(true);
    MSPROF_LOGI("Host move mode enabled, base=0x%llx, wptr=0x%llx, rptr=0x%llx",
        info->buffer_base_user_va, info->buffer_write_ptr_user_va, info->buffer_read_ptr_user_va);
    return PROFILING_SUCCESS;
}

STATIC int32_t ProfStartAicpu(ProfSampleStartPara *para)
{
    MSPROF_EVENT("drv start aicpu");
    if (para == nullptr) {
        MSPROF_LOGE("ProfStartAicpu para is nullptr");
        return PROFILING_FAILED;
    }
    auto instance = DevprofDrvAicpu::instance();
    if (para->is_support_host_move) {
        int32_t ret = ProfStartHostMove(para);
        if (ret != PROFILING_SUCCESS) {
            instance->Release();
            return ret;
        }
    } else {
        instance->SetSupportHostMove(false);
    }
    instance->DeviceReportStart();
    return instance->Start();
}

STATIC int32_t ProfSampleAicpu(ProfSamplePara *para)
{
    UNUSED(para);
    return PROFILING_SUCCESS;
}

STATIC int32_t ProfStopDevicePause(ProfSampleStopPara *para)
{
    MSPROF_LOGI("ProfStopDevicePause: stop reporting data");
    DevprofDrvAicpu::instance()->DeviceReportStop();
    return DevprofDrvAicpu::instance()->Stop();
}

STATIC int32_t ProfStopDeviceRelease(ProfSampleStopPara *para)
{
    MSPROF_LOGI("ProfStopDeviceRelease: clear host move addresses, isSupportHostMove=%d",
        DevprofDrvAicpu::instance()->IsSupportHostMove());
    DevprofDrvAicpu::instance()->Release();
    return PROFILING_SUCCESS;
}

STATIC int32_t ProfStopAicpu(ProfSampleStopPara *para)
{
    if (para == nullptr) {
        MSPROF_LOGE("ProfStopAicpu para is nullptr");
        return PROFILING_FAILED;
    }
    MSPROF_EVENT("drv stop aicpu, release_flag=%u", para->release_flag);

    switch (para->release_flag) {
        case PROF_STOP_STAGE_DEFAULT:
            return ProfStopDevicePause(para);
        case PROF_STOP_STAGE_PAUSE:
            return ProfStopDevicePause(para);
        case PROF_STOP_STAGE_RELEASE:
            return ProfStopDeviceRelease(para);
        case PROF_STOP_STAGE_PAUSE_AND_RELEASE:
            ProfStopDevicePause(para);
            return ProfStopDeviceRelease(para);
        default:
            MSPROF_LOGE("Invalid release_flag=%u", para->release_flag);
            return PROFILING_FAILED;
    }
}

DevprofDrvAicpu::DevprofDrvAicpu() : stopped_(false), devId_(0), channelId_(0), profConfig_(0),
    isRegister_(false), isSupportHostMove_(false), hostMoveBuffer_(nullptr),
    hostMoveBufferSize_(0), hostMoveWptr_(nullptr), hostMoveRptr_(nullptr),
    hostMoveWriteIndex_(0)
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
    UninitHostMoveBuffer();
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
    profConfig_ = 0;

    if (Thread::Stop() != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to stop report %s thread", AICPU_PROFILING_REPORT_THREAD_NAME);
    }

    aicpuAdditionalBuffer_.Print();
    return PROFILING_SUCCESS;
}

void DevprofDrvAicpu::Release()
{
    UninitHostMoveBuffer();
    SetSupportHostMove(false);
}

void DevprofDrvAicpu::UninitHostMoveBuffer()
{
    hostMoveBuffer_ = nullptr;
    hostMoveWptr_ = nullptr;
    hostMoveRptr_ = nullptr;
    hostMoveBufferSize_ = 0;
    hostMoveWriteIndex_.store(0);
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
    errno_t ret = memcpy_s(additionInfo.data, MSPROF_ADDTIONAL_INFO_DATA_LENGTH, str.c_str(), additionInfo.dataLen);
    if(ret != EOK) {
        MSPROF_LOGE("Memcpy data into additionInfo failed, size:%uB", additionInfo.dataLen);
        return;
    }
    int32_t pushRet = ReportAdditionalInfo(0, static_cast<void*>(&additionInfo), sizeof(MsprofAdditionalInfo));
    if (pushRet != PROFILING_SUCCESS) {
        MSPROF_LOGE("Push str2id into additional buffer failed, size:%uB", additionInfo.dataLen);
        return;
    }
    MSPROF_LOGI("Add str2id into additional buffer, size:%uB", additionInfo.dataLen);
}

void DevprofDrvAicpu::FillStr2IdIntoBuffer(std::string& dataStr) {
    dataStr.insert(0, STR2ID_MARK);
    std::stringstream ss(dataStr);
    std::string item;
    std::string sendStr;
    uint32_t currentSize = 0;
    while (std::getline(ss, item, STR2ID_DELIMITER[0])) {
        uint32_t itemSize = item.length();
        if (itemSize > MSPROF_ADDTIONAL_INFO_DATA_LENGTH) {
            MSPROF_LOGW("Str size is over:%uB str:%s", MSPROF_ADDTIONAL_INFO_DATA_LENGTH, item.c_str());
            continue;
        }
        uint32_t addSize = currentSize > 0 ? itemSize + 1 : itemSize;
        if (currentSize + addSize > MSPROF_ADDTIONAL_INFO_DATA_LENGTH) {
            MSPROF_LOGD("AddStr2IdIntoBuffer str length:%uB str:%s", sendStr.length(), sendStr.c_str());
            AddStr2IdIntoBuffer(sendStr);
            sendStr = "";
            currentSize = 0;
        }
        if (currentSize > 0) {
            sendStr.append(STR2ID_DELIMITER + item);
            currentSize += item.length() + 1;
        } else {
            sendStr.append(item);
            currentSize += item.length();
        }
    }
    if (currentSize > 0) {
        MSPROF_LOGD("AddStr2IdIntoBuffer str length:%uB str:%s", sendStr.length(), sendStr.c_str());
        AddStr2IdIntoBuffer(sendStr);
    }
}

int32_t DevprofDrvAicpu::ReportStr2IdInfoToHost(std::string& dataStr) {
    FillStr2IdIntoBuffer(dataStr);
    int32_t ret = SendAddtionalInfo();
    if(ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("send str2id info failed");
        return ret;
    }
    MSPROF_LOGI("send str2id info ok");
    return ret;
}

int32_t DevprofDrvAicpu::DrainBufferToHostMove()
{
    uint64_t totalWriteLen = 0;
    while (!stopped_ || (aicpuAdditionalBuffer_.GetUsedSize() != 0)) {
        if (aicpuAdditionalBuffer_.GetUsedSize() == 0) {
            (void)OsalSleep(WAIT_DATA_TIME);
            continue;
        }

        uint32_t writeIdx = hostMoveWriteIndex_.load(std::memory_order_relaxed);
        uint32_t rptr = *hostMoveRptr_;
        uint32_t maxIdx = static_cast<uint32_t>(hostMoveBufferSize_ / sizeof(MsprofAdditionalInfo));
        if (writeIdx >= maxIdx || rptr >= maxIdx) {
            MSPROF_LOGE("Invalid wptr/rptr, wptr=%u rptr=%u max=%u", writeIdx, rptr, maxIdx);
            stopped_ = true;
            MSPROF_LOGE("Discarded pending data size=%zu in host move buffer", aicpuAdditionalBuffer_.GetUsedSize());
            return PROFILING_FAILED;
        }

        uint32_t usedSlots = (writeIdx >= rptr) ? (writeIdx - rptr) : (maxIdx - rptr + writeIdx);
        if (usedSlots >= maxIdx - 1) {
            MSPROF_LOGW("Host move ring buffer full, wptr=%u rptr=%u", writeIdx, rptr);
            if (stopped_) {
                MSPROF_LOGE("Discarded pending data size=%zu, ring buffer full on stop", aicpuAdditionalBuffer_.GetUsedSize());
                return PROFILING_FAILED;
            }
            (void)OsalSleep(WAIT_DATA_TIME);
            continue;
        }

        size_t outSize = sizeof(MsprofAdditionalInfo);
        void *outPtr = aicpuAdditionalBuffer_.BatchPop(outSize, stopped_);
        if (outPtr == nullptr) {
            (void)OsalSleep(WAIT_DRV_TIME);
            continue;
        }

        int32_t ret = WriteToHostMoveBuffer(static_cast<const MsprofAdditionalInfo *>(outPtr),
                      sizeof(MsprofAdditionalInfo));
        if (ret != PROFILING_SUCCESS) {
            MSPROF_LOGE("Write to host move buffer failed");
        } else {
            totalWriteLen += sizeof(MsprofAdditionalInfo);
        }
        aicpuAdditionalBuffer_.BatchPopBufferIndexShift(outPtr, sizeof(MsprofAdditionalInfo));
    }
    MSPROF_LOGI("Host move: write pointer wrote total length=%lu bytes to ring buffer", totalWriteLen);
    return PROFILING_SUCCESS;
}

void DevprofDrvAicpu::RunHostMoveMode()
{
    if (hostMoveBuffer_ == nullptr || hostMoveWptr_ == nullptr || hostMoveRptr_ == nullptr) {
        MSPROF_LOGE("Host move buffer pointers are null while isSupportHostMove_ is true");
        return;
    }
    if (hostMoveBufferSize_ == 0 || hostMoveBufferSize_ < sizeof(MsprofAdditionalInfo)) {
        MSPROF_LOGE("Host move buffer size is invalid, hostMoveBufferSize_=%zu", hostMoveBufferSize_);
        return;
    }

    int32_t drainRet = DrainBufferToHostMove();

    // send str2id keys to host via the ring buffer (mirrors RunNormalMode tail, but ring not driver).
    // Skip when the main drain already broke/filled the ring, otherwise we'd fill then discard str2id.
    if (drainRet == PROFILING_SUCCESS) {
        std::string str2Id;
        int32_t ret = analysis::dvvp::transport::HashData::instance()->GetHashKeys(str2Id);
        MSPROF_LOGD("dev get hash keys ret:%u and str length:%u", ret, str2Id.length());
        if (ret == PROFILING_SUCCESS && str2Id.length() > 0) {
            MSPROF_LOGI("report str2id info length:%u via host move ring buffer", str2Id.length());
            FillStr2IdIntoBuffer(str2Id);
            (void)DrainBufferToHostMove();
        }
    }

    MSPROF_LOGI("Host move: all pending data flushed to ring buffer, Run() exiting");
    (void)OsalSleep(WAIT_DRV_TIME);
}

void DevprofDrvAicpu::RunNormalMode()
{
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

void DevprofDrvAicpu::Run(const struct error_message::Context &errorContext)
{
    (void)errorContext;

    MSPROF_LOGI("Run() enter, isSupportHostMove_=%d, hostMoveBuffer_=%p, hostMoveWptr_=%p, hostMoveRptr_=%p",
        isSupportHostMove_, hostMoveBuffer_, hostMoveWptr_, hostMoveRptr_);

    if (isSupportHostMove_) {
        RunHostMoveMode();
    } else {
        RunNormalMode();
    }
}

int32_t DevprofDrvAicpu::RecordHostMoveBufferAddresses(const Devprof::AicpuUserProfileBufferInfo *info)
{
    if (info == nullptr) {
        MSPROF_LOGE("RecordHostMoveBufferAddresses info is nullptr");
        return PROFILING_FAILED;
    }
    if (info->buffer_size == 0 || info->buffer_base_user_va == 0) {
        MSPROF_LOGE("RecordHostMoveBufferAddresses buffer_size=%u or buffer_base_user_va=0x%llx is invalid",
            info->buffer_size, info->buffer_base_user_va);
        return PROFILING_FAILED;
    }
    if (info->buffer_write_ptr_user_va == 0 || info->buffer_read_ptr_user_va == 0) {
        MSPROF_LOGE("RecordHostMoveBufferAddresses wptr=0x%llx or rptr=0x%llx is invalid",
            info->buffer_write_ptr_user_va, info->buffer_read_ptr_user_va);
        return PROFILING_FAILED;
    }
    hostMoveBufferSize_ = static_cast<size_t>(info->buffer_size);
    hostMoveBuffer_ = reinterpret_cast<uint8_t *>(static_cast<uintptr_t>(info->buffer_base_user_va));
    hostMoveRptr_ = reinterpret_cast<volatile uint32_t *>(static_cast<uintptr_t>(info->buffer_read_ptr_user_va));
    hostMoveWptr_ = reinterpret_cast<volatile uint32_t *>(static_cast<uintptr_t>(info->buffer_write_ptr_user_va));
    hostMoveWriteIndex_.store(0);
    // The shared write/read pointers live in device memory allocated by the host (halMemAlloc does
    // not guarantee zeroed memory). Until WriteToHostMoveBuffer writes the first record, *hostMoveWptr_
    // would otherwise hold stale bytes, and the host consumer (prof_sample_aicpu_channel.c) computes
    // write_index = wptr * AICPU_BUF_UNIT and copies [read_index, write_index) -- a garbage wptr makes
    // it read far more than was ever written. Explicitly zero both pointers so producer and consumer
    // share base 0 before any data is produced.
    *hostMoveWptr_ = 0;
    *hostMoveRptr_ = 0;
    std::atomic_thread_fence(std::memory_order_release);
    MSPROF_LOGI("RecordHostMoveBufferAddresses: base=0x%llx, size=%zu, wptr=0x%llx, rptr=0x%llx",
        info->buffer_base_user_va, hostMoveBufferSize_,
        info->buffer_write_ptr_user_va, info->buffer_read_ptr_user_va);
    return PROFILING_SUCCESS;
}

int32_t DevprofDrvAicpu::WriteToHostMoveBuffer(const MsprofAdditionalInfo *data, size_t dataSize)
{
    if (hostMoveBuffer_ == nullptr || hostMoveWptr_ == nullptr || data == nullptr || dataSize == 0) {
        MSPROF_LOGE("Write to host move buffer input invalid");
        return PROFILING_FAILED;
    }

    uint32_t writeIdx = hostMoveWriteIndex_.load(std::memory_order_relaxed);
    uint32_t writeOffset = writeIdx * sizeof(MsprofAdditionalInfo);
    uint32_t bufferLimit = static_cast<uint32_t>(hostMoveBufferSize_);

    if (dataSize > sizeof(MsprofAdditionalInfo) || writeOffset + sizeof(MsprofAdditionalInfo) > bufferLimit) {
        MSPROF_LOGE("Host move buffer write failed, writeIdx=%u, dataSize=%zu, bufferSize=%zu",
            writeIdx, dataSize, hostMoveBufferSize_);
        return PROFILING_FAILED;
    }

    MSPROF_LOGD("WriteToHostMoveBuffer: writeIdx=%u, writeOffset=%u, hostMoveBuffer_=%p, hostMoveWptr_=%p (*wptr=%u)",
        writeIdx, writeOffset, hostMoveBuffer_, hostMoveWptr_,
        (hostMoveWptr_ != nullptr) ? *hostMoveWptr_ : 0xFFFF);

    errno_t ret = memcpy_s(hostMoveBuffer_ + writeOffset, bufferLimit - writeOffset, data, dataSize);
    if (ret != EOK) {
        MSPROF_LOGE("Memcpy to host move buffer failed, ret: %d", ret);
        return PROFILING_FAILED;
    }

    uint32_t newWriteIdx = (writeIdx + 1) % (bufferLimit / sizeof(MsprofAdditionalInfo));
    hostMoveWriteIndex_.store(newWriteIdx, std::memory_order_release);
    std::atomic_thread_fence(std::memory_order_release);
    *hostMoveWptr_ = newWriteIdx;

    MSPROF_LOGD("Write to host move buffer success, writeIdx=%u -> %u", writeIdx, newWriteIdx);
    return PROFILING_SUCCESS;
}

int32_t DevprofDrvAicpu::RegisterDrvChannel(uint32_t devId, uint32_t channelId)
{
    ProfSampleRegisterPara registerPara = {1, {ProfStartAicpu, ProfSampleAicpu, nullptr, ProfStopAicpu}};
    int32_t ret = halProfSampleRegister(devId, channelId, &registerPara);
    if (ret != DRV_ERROR_NONE) {
        MSPROF_LOGE("Failed to regist aicpu sample ops, ret = %d.", ret);
        return PROFILING_FAILED;
    }

    ret = halProfSampleRegisterEx(devId, channelId, &registerPara);
    if (ret != DRV_ERROR_NONE) {
        // If the driver does not support halProfSampleRegisterEx, run to the old process.
        if (ret == DRV_ERROR_NOT_SUPPORT) {
            MSPROF_LOGI("halProfSampleRegister succeeded but halProfSampleRegisterEx failed, ret = %d. "
                "Driver not supported.", ret);
            isRegister_ = true;
            return PROFILING_SUCCESS;
        }
        MSPROF_LOGW("halProfSampleRegister succeeded but halProfSampleRegisterEx failed, ret = %d. "
            "Partial registration remains in driver, state inconsistent.", ret);
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
    SetSupportHostMove(false);
    UninitHostMoveBuffer();
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

    std::unique_lock<std::mutex> lock(aicpuRegisterMutex_, std::defer_lock);
    lock.lock();
    moduleCallbacks_[moduleId].insert(commandHandle);
    lock.unlock();
    MSPROF_LOGI("module %u register callback, current command type %u.", moduleId, command_.type);
    // if command_.type is not TYPE_MAX, 
    if (command_.type != PROF_COMMANDHANDLE_TYPE_MAX) {
        DoCallbackHandle(moduleId, commandHandle);
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