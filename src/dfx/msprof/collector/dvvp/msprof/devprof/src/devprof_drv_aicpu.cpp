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
#include <thread>
#include <unistd.h>
#include "error_code.h"
#include "log_types.h"
#include "config/config.h"
#include "ai_drv_prof_api.h"
#include "devprof_common.h"
#include "hash_data.h"
#include "platform_interface.h"
#include "msprof_drv_api.h"

using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::config;
using namespace analysis::dvvp::driver;
using namespace Devprof;

constexpr uint64_t START_SWITCH = 1U;            // define by runtime
constexpr uint32_t AICPU_SWITCH = 2U;            // define by runtime
constexpr uint32_t MAX_ADD_REPORT_SIZE = 131072; // 512 * sizeof(MsprofAdditionalInfo)
const char* const AICPU_EVENT_GRP_NAME = "prof_aicpu_grp";
const char* const AI_CUSTOM_CPU_EVENT_GRP_NAME = "prof_cus_grp";
const char* const AICPU_PROFILING_REPORT_THREAD_NAME = "Prof_Reporter";
constexpr useconds_t HOST_MOVE_PUSH_WAIT_TIME = 1;

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

    if (isSupportHostMove_) {
        const uint32_t recordCount = length / static_cast<uint32_t>(sizeof(MsprofAdditionalInfo));
        return WriteDirectlyToHostMoveBuffer(static_cast<const MsprofAdditionalInfo*>(data), recordCount);
    }

    int32_t ret = aicpuAdditionalBuffer_.BatchPush(static_cast<const MsprofAdditionalInfo*>(data), length);
    if (ret != MSPROF_ERROR_NONE) {
        MSPROF_LOGE("Try push buff failed, size: %" PRIu64 " bytes, ret:%d.", length, ret);
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

STATIC int32_t ProfStartHostMove(ProfSampleStartPara* para)
{
    if ((para->out_data == nullptr) || (para->out_data_max_len < sizeof(Devprof::AicpuUserProfileBufferInfo))) {
        MSPROF_LOGE(
            "Host move: out_data invalid (ptr=%p, max_len=%u, need=%zu)", para->out_data, para->out_data_max_len,
            sizeof(Devprof::AicpuUserProfileBufferInfo));
        return PROFILING_FAILED;
    }

    auto instance = DevprofDrvAicpu::instance();
    auto* info = static_cast<Devprof::AicpuUserProfileBufferInfo*>(para->out_data);
    if (instance->RecordHostMoveBufferAddresses(info) != PROFILING_SUCCESS) {
        return PROFILING_FAILED;
    }
    instance->SetSupportHostMove(true);
    MSPROF_LOGI(
        "Host move mode enabled, base=0x%llx, wptr=0x%llx, rptr=0x%llx", info->buffer_base_user_va,
        info->buffer_write_ptr_user_va, info->buffer_read_ptr_user_va);
    return PROFILING_SUCCESS;
}

STATIC int32_t ProfStartAicpu(ProfSampleStartPara* para)
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
        if (!instance->InitAdditionalBuffer()) {
            return PROFILING_FAILED;
        }
    }
    instance->DeviceReportStart();
    return instance->Start();
}

STATIC int32_t ProfSampleAicpu(ProfSamplePara* para)
{
    UNUSED(para);
    return PROFILING_SUCCESS;
}

bool DevprofDrvAicpu::InitAdditionalBuffer() { return aicpuAdditionalBuffer_.Init("AicpuBuffer"); }

STATIC int32_t ProfStopDevicePause(ProfSampleStopPara* para)
{
    MSPROF_LOGI("ProfStopDevicePause: stop reporting data");
    DevprofDrvAicpu::instance()->DeviceReportStop();
    return DevprofDrvAicpu::instance()->Stop();
}

STATIC int32_t ProfStopDeviceRelease(ProfSampleStopPara* para)
{
    MSPROF_LOGI(
        "ProfStopDeviceRelease: clear host move addresses, isSupportHostMove=%d",
        DevprofDrvAicpu::instance()->IsSupportHostMove());
    DevprofDrvAicpu::instance()->Release();
    return PROFILING_SUCCESS;
}

STATIC int32_t ProfStopAicpu(ProfSampleStopPara* para)
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

DevprofDrvAicpu::DevprofDrvAicpu()
    : stopped_(false),
      devId_(0),
      channelId_(0),
      profConfig_(0),
      isRegister_(false),
      isSupportHostMove_(false),
      hostMoveBuffer_(nullptr),
      hostMoveBufferSize_(0),
      hostMoveWptr_(nullptr),
      hostMoveRptr_(nullptr),
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

int32_t DevprofDrvAicpu::Init(const struct AicpuStartPara* para)
{
    devId_ = para->devId;
    channelId_ = para->channelId;
    const char* grpName;
    if (para->channelId == PROF_CHANNEL_AICPU) {
        grpName = AICPU_EVENT_GRP_NAME;
    } else if (para->channelId == PROF_CHANNEL_CUS_AICPU) {
        grpName = AI_CUSTOM_CPU_EVENT_GRP_NAME;
    } else {
        MSPROF_LOGE(
            "Get channel id %u is invalid, expect %d or %d", para->channelId, PROF_CHANNEL_AICPU,
            PROF_CHANNEL_CUS_AICPU);
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
    ringFullLogged_.store(false, std::memory_order_relaxed);
    if (isSupportHostMove_) {
        hostMoveAcceptingWrites_.store(true, std::memory_order_release);
        return PROFILING_SUCCESS;
    }
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

    if (isSupportHostMove_) {
        hostMoveAcceptingWrites_.store(false, std::memory_order_release);
        while (hostMoveActiveWriters_.load(std::memory_order_acquire) != 0U) {
            std::this_thread::yield();
        }
        return ReportStr2IdInfoToHostMove(true);
    }

    if (!isSupportHostMove_ && Thread::Stop() != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to stop report %s thread", AICPU_PROFILING_REPORT_THREAD_NAME);
    }

    aicpuAdditionalBuffer_.Print();
    return PROFILING_SUCCESS;
}

void DevprofDrvAicpu::Release()
{
    if (isSupportHostMove_) {
        hostMoveAcceptingWrites_.store(false, std::memory_order_release);
        while (hostMoveActiveWriters_.load(std::memory_order_acquire) != 0U) {
            std::this_thread::yield();
        }
    }
    UninitHostMoveBuffer();
    SetSupportHostMove(false);
}

void DevprofDrvAicpu::UninitHostMoveBuffer()
{
    const uint32_t discardCount = hostMoveOverflowDiscardSize_.load(std::memory_order_acquire);
    if (discardCount != 0U) {
        const size_t discardLength = static_cast<size_t>(discardCount) * sizeof(MsprofAdditionalInfo);
        MSPROF_LOGE("Host move buffer overflow, channel id: %u, discard length: %zu bytes", channelId_, discardLength);
    }

    delete[] hostMoveCommitCounts_;
    hostMoveCommitCounts_ = nullptr;
    hostMoveCommitCountSize_ = 0;
    hostMoveBuffer_ = nullptr;
    hostMoveWptr_ = nullptr;
    hostMoveRptr_ = nullptr;
    hostMoveBufferSize_ = 0;
    hostMoveReadIndex_.store(0);
    hostMoveWriteIndex_.store(0);
    hostMoveIdleWriteIndex_.store(0);
    hostMoveFailedWriteIndex_.store(0);
    hostMoveOverflowDiscardSize_.store(0);
    hostMoveMaxCycles_ = HOST_MOVE_BUFFER_MAX_CYCLES;
    hostMoveAcceptingWrites_.store(false);
}

bool DevprofDrvAicpu::EnsureHostMoveCommitState(uint32_t maxIdx)
{
    if (hostMoveCommitCounts_ != nullptr && hostMoveCommitCountSize_ == maxIdx) {
        return true;
    }

    auto* commitCounts = new (std::nothrow) std::atomic<uint32_t>[maxIdx];
    if (commitCounts == nullptr) {
        MSPROF_LOGE("Alloc host move commit counts failed, count=%u", maxIdx);
        return false;
    }
    for (uint32_t i = 0; i < maxIdx; ++i) {
        commitCounts[i].store(0, std::memory_order_relaxed);
    }

    delete[] hostMoveCommitCounts_;
    hostMoveCommitCounts_ = commitCounts;
    hostMoveCommitCountSize_ = maxIdx;
    return true;
}

int32_t DevprofDrvAicpu::WriteDirectlyToHostMoveBuffer(
    const MsprofAdditionalInfo* data, uint32_t recordCount, bool flushWrite)
{
    if (hostMoveBuffer_ == nullptr || hostMoveWptr_ == nullptr || hostMoveRptr_ == nullptr || data == nullptr ||
        recordCount == 0) {
        MSPROF_LOGE("Write directly to host move buffer input invalid");
        return PROFILING_FAILED;
    }

    constexpr uint32_t recordSize = sizeof(MsprofAdditionalInfo);
    const uint32_t maxIdx = static_cast<uint32_t>(hostMoveBufferSize_ / recordSize);
    if (maxIdx == 0 || recordCount >= maxIdx) {
        MSPROF_LOGE("Host move direct write failed, recordCount=%u, maxIdx=%u", recordCount, maxIdx);
        return PROFILING_FAILED;
    }
    if (hostMoveCommitCounts_ == nullptr || hostMoveCommitCountSize_ != maxIdx) {
        MSPROF_LOGE("Host move commit state is invalid, count=%zu maxIdx=%u", hostMoveCommitCountSize_, maxIdx);
        return PROFILING_FAILED;
    }

    bool writerRegistered = false;
    while (!writerRegistered) {
        if (!flushWrite && !hostMoveAcceptingWrites_.load(std::memory_order_acquire)) {
            return PROFILING_FAILED;
        }
        (void)hostMoveActiveWriters_.fetch_add(1, std::memory_order_acq_rel);
        writerRegistered = flushWrite || hostMoveAcceptingWrites_.load(std::memory_order_acquire);
        if (!writerRegistered) {
            (void)hostMoveActiveWriters_.fetch_sub(1, std::memory_order_acq_rel);
        }
    }
    struct HostMoveWriterGuard {
        std::atomic<uint32_t>& activeWriters;
        ~HostMoveWriterGuard() { activeWriters.fetch_sub(1, std::memory_order_acq_rel); }
    } writerGuard{hostMoveActiveWriters_};

    uint64_t writeCursor = 0;
    size_t cycles = 0;
    while (true) {
        const uint32_t readIndex = *hostMoveRptr_;
        const uint32_t writeSlot = *hostMoveWptr_;
        if (readIndex >= maxIdx || writeSlot >= maxIdx) {
            MSPROF_LOGE("Host move pointers invalid, wptr=%u rptr=%u max=%u", writeSlot, readIndex, maxIdx);
            return PROFILING_FAILED;
        }
        if (!flushWrite && !hostMoveAcceptingWrites_.load(std::memory_order_acquire)) {
            return PROFILING_FAILED;
        }
        if (hostMoveFailedWriteIndex_.load(std::memory_order_acquire) != 0U) {
            return PROFILING_FAILED;
        }

        uint64_t expected = hostMoveIdleWriteIndex_.load(std::memory_order_acquire);
        if (!TryUpdateHostMoveReadIndex(maxIdx)) {
            return PROFILING_FAILED;
        }
        const uint64_t usedRecords = expected - hostMoveReadIndex_.load(std::memory_order_acquire);
        const uint64_t freeRecords = static_cast<uint64_t>(maxIdx) - 1ULL - usedRecords;
        if (freeRecords < recordCount) {
            cycles++;
            if (cycles >= hostMoveMaxCycles_) {
                (void)hostMoveOverflowDiscardSize_.fetch_add(recordCount, std::memory_order_acq_rel);
                MSPROF_LOGW(
                    "Host move cycle overflow, drop data, recordCount=%u free=%llu maxIdx=%u", recordCount,
                    static_cast<unsigned long long>(freeRecords), maxIdx);
                return PROFILING_SUCCESS;
            }
            if (!ringFullLogged_.load(std::memory_order_relaxed)) {
                ringFullLogged_.store(true, std::memory_order_relaxed);
                MSPROF_EVENT(
                    "Host move ring buffer full, channel id: %u, idle=%llu", channelId_,
                    static_cast<unsigned long long>(expected));
            }
            (void)usleep(HOST_MOVE_PUSH_WAIT_TIME);
            continue;
        }

        const uint64_t nextCursor = expected + static_cast<uint64_t>(recordCount);
        const bool reserved = hostMoveIdleWriteIndex_.compare_exchange_weak(
            expected, nextCursor, std::memory_order_acq_rel, std::memory_order_acquire);
        if (reserved) {
            writeCursor = expected;
            break;
        }
    }

    const uint32_t startSlot = writeCursor % maxIdx;
    const uint32_t firstCount = std::min(recordCount, maxIdx - startSlot);
    const uint32_t writeOffset = startSlot * recordSize;
    const uint32_t bufferLimit = static_cast<uint32_t>(hostMoveBufferSize_);
    errno_t ret = memcpy_s(
        hostMoveBuffer_ + writeOffset, bufferLimit - writeOffset, data, static_cast<size_t>(firstCount) * recordSize);
    if (ret != EOK) {
        FailReservedRange(writeCursor, recordCount);
        hostMoveAcceptingWrites_.store(false, std::memory_order_release);
        MSPROF_LOGE("Memcpy host move first segment failed, ret=%d firstCount=%u", ret, firstCount);
        return PROFILING_FAILED;
    }

    const uint32_t secondCount = recordCount - firstCount;
    if (secondCount != 0) {
        ret = memcpy_s(hostMoveBuffer_, bufferLimit, data + firstCount, static_cast<size_t>(secondCount) * recordSize);
        if (ret != EOK) {
            FailReservedRange(writeCursor, recordCount);
            hostMoveAcceptingWrites_.store(false, std::memory_order_release);
            MSPROF_LOGE("Memcpy host move wrapped segment failed, ret=%d secondCount=%u", ret, secondCount);
            return PROFILING_FAILED;
        }
    }

    std::atomic_thread_fence(std::memory_order_release);
    hostMoveCommitCounts_[writeCursor % maxIdx].store(recordCount, std::memory_order_release);
    if (hostMoveFailedWriteIndex_.load(std::memory_order_acquire) != 0U) {
        MSPROF_LOGE("A previous host move writer failed, cursor=%llu", static_cast<unsigned long long>(writeCursor));
        return PROFILING_FAILED;
    }
    if (!TryPublishHostMoveRange(maxIdx)) {
        MSPROF_LOGE(
            "Publish host move range failed, cursor=%llu count=%u", static_cast<unsigned long long>(writeCursor),
            recordCount);
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

bool DevprofDrvAicpu::TryPublishHostMoveRange(uint32_t maxIdx)
{
    while (true) {
        const uint64_t idleCursor = hostMoveIdleWriteIndex_.load(std::memory_order_acquire);
        const uint64_t cursor = hostMoveWriteIndex_.load(std::memory_order_acquire);
        if (cursor >= idleCursor) {
            return true;
        }

        const uint32_t slot = cursor % maxIdx;
        uint32_t count = hostMoveCommitCounts_[slot].load(std::memory_order_acquire);
        if (count == 0) {
            return true;
        }
        const uint64_t nextCursor = cursor + static_cast<uint64_t>(count);
        if (count >= maxIdx || nextCursor > idleCursor) {
            MSPROF_LOGE(
                "Host move commit state invalid, cursor=%llu count=%u idle=%llu",
                static_cast<unsigned long long>(cursor), count, static_cast<unsigned long long>(idleCursor));
            return false;
        }
        const bool commitCountCleared = hostMoveCommitCounts_[slot].compare_exchange_strong(
            count, 0, std::memory_order_acq_rel, std::memory_order_acquire);
        if (!commitCountCleared) {
            continue;
        }

        std::atomic_thread_fence(std::memory_order_release);
        *hostMoveWptr_ = nextCursor % maxIdx;
        hostMoveWriteIndex_.store(nextCursor, std::memory_order_release);
    }
}

bool DevprofDrvAicpu::TryUpdateHostMoveReadIndex(uint32_t maxIdx)
{
    if (maxIdx == 0) {
        return false;
    }

    uint64_t readCursor = hostMoveReadIndex_.load(std::memory_order_acquire);
    while (true) {
        const uint32_t readSlot = *hostMoveRptr_;
        if (readSlot >= maxIdx) {
            MSPROF_LOGE("Host move read pointer invalid, rptr=%u max=%u", readSlot, maxIdx);
            return false;
        }
        if (readCursor % maxIdx == readSlot) {
            return true;
        }

        const uint32_t consumedCount = static_cast<uint32_t>((readSlot + maxIdx - (readCursor % maxIdx)) % maxIdx);
        const uint64_t nextCursor = readCursor + consumedCount;
        if (nextCursor > hostMoveIdleWriteIndex_.load(std::memory_order_acquire)) {
            MSPROF_LOGE(
                "Host move read pointer jumped ahead, rptr=%u readCursor=%llu max=%u", readSlot,
                static_cast<unsigned long long>(readCursor), maxIdx);
            return false;
        }
        const bool readCursorUpdated = hostMoveReadIndex_.compare_exchange_weak(
            readCursor, nextCursor, std::memory_order_acq_rel, std::memory_order_acquire);
        if (readCursorUpdated) {
            const uint32_t publishedSlot = *hostMoveRptr_;
            if (publishedSlot == readSlot) {
                return true;
            }
            readCursor = nextCursor;
        }
    }
}

void DevprofDrvAicpu::FailReservedRange(uint64_t cursor, uint32_t count)
{
    const uint64_t failedCursor = cursor + static_cast<uint64_t>(count);
    uint64_t expected = hostMoveFailedWriteIndex_.load(std::memory_order_acquire);
    while (expected < failedCursor) {
        const bool failedCursorUpdated = hostMoveFailedWriteIndex_.compare_exchange_weak(
            expected, failedCursor, std::memory_order_acq_rel, std::memory_order_acquire);
        if (failedCursorUpdated) {
            return;
        }
    }
}

int32_t DevprofDrvAicpu::SendAddtionalInfo()
{
    uint32_t times = 0;
    uint32_t waitTimes = 0;
    while (aicpuAdditionalBuffer_.GetUsedSize() != 0) {
        uint64_t allStartTime = analysis::dvvp::common::utils::Utils::GetClockMonotonicRaw();
        uint32_t bufLen = 0;
        int32_t ret = MsprofDrvApi::instance()->halProfQueryAvailBufLen(devId_, channelId_, &bufLen);
        if (ret != DRV_ERROR_NONE) {
            MSPROF_LOGE("get driver buffer len failed, device id:%u, channel id:%u, ret:%d", devId_, channelId_, ret);
            return PROFILING_FAILED;
        }
        size_t outSize = std::min(static_cast<size_t>(bufLen), analysis::dvvp::common::queue::MAX_DRV_REPORT_SIZE);
        outSize = (outSize / sizeof(MsprofAdditionalInfo)) * sizeof(MsprofAdditionalInfo);
        void* outPtr = aicpuAdditionalBuffer_.BatchPop(outSize, stopped_);
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
        ret = MsprofDrvApi::instance()->halProfSampleDataReport(devId_, channelId_, 0, &profDataReportPara);
        if (ret != DRV_ERROR_NONE) {
            MSPROF_LOGE("report str2id data failed, ret: %d, data size: %zu", ret, outSize);
            return PROFILING_FAILED;
        }
        uint64_t reportEndTime = analysis::dvvp::common::utils::Utils::GetClockMonotonicRaw();
        aicpuAdditionalBuffer_.BatchPopBufferIndexShift(outPtr, outSize);
        uint64_t allEndTime = analysis::dvvp::common::utils::Utils::GetClockMonotonicRaw();
        MSPROF_LOGI(
            "#%u: report str2id data success, report cost: %llu ns, all cost: %llu ns, data size: %zu", times,
            (reportEndTime - reportStartTime), (allEndTime - allStartTime), outSize);
        times++;
    }
    return PROFILING_SUCCESS;
}

bool DevprofDrvAicpu::AddStr2IdIntoBuffer(std::string& str, bool flushWrite)
{
    MsprofAdditionalInfo additionInfo;
    additionInfo.magicNumber = MSPROF_REPORT_DATA_MAGIC_NUM;
    additionInfo.level = 0;
    additionInfo.type = 0;
    additionInfo.threadId = 0;
    additionInfo.dataLen = str.length();
    additionInfo.timeStamp = 0;
    (void)memset_s(additionInfo.data, MSPROF_ADDTIONAL_INFO_DATA_LENGTH, 0, MSPROF_ADDTIONAL_INFO_DATA_LENGTH);
    errno_t ret = memcpy_s(additionInfo.data, MSPROF_ADDTIONAL_INFO_DATA_LENGTH, str.c_str(), additionInfo.dataLen);
    if (ret != EOK) {
        MSPROF_LOGE("Memcpy data into additionInfo failed, size:%uB", additionInfo.dataLen);
        return false;
    }
    int32_t pushRet = 0;
    if (flushWrite) {
        pushRet = WriteDirectlyToHostMoveBuffer(&additionInfo, 1U, true);
    } else {
        pushRet = ReportAdditionalInfo(0, static_cast<void*>(&additionInfo), sizeof(MsprofAdditionalInfo));
    }
    if (pushRet != PROFILING_SUCCESS) {
        MSPROF_LOGE("Push str2id into additional buffer failed, size:%uB", additionInfo.dataLen);
        return false;
    }
    MSPROF_LOGI("Add str2id into additional buffer, size:%uB", additionInfo.dataLen);
    return true;
}

bool DevprofDrvAicpu::FillStr2IdIntoBuffer(std::string& dataStr, bool flushWrite)
{
    dataStr.insert(0, STR2ID_MARK);
    std::stringstream ss(dataStr);
    std::string item;
    std::string sendStr;
    uint32_t currentSize = 0;
    bool fillSuccess = true;
    while (std::getline(ss, item, STR2ID_DELIMITER[0])) {
        uint32_t itemSize = item.length();
        if (itemSize > MSPROF_ADDTIONAL_INFO_DATA_LENGTH) {
            MSPROF_LOGW("Str size is over:%uB str:%s", MSPROF_ADDTIONAL_INFO_DATA_LENGTH, item.c_str());
            continue;
        }
        uint32_t addSize = currentSize > 0 ? itemSize + 1 : itemSize;
        if (currentSize + addSize > MSPROF_ADDTIONAL_INFO_DATA_LENGTH) {
            MSPROF_LOGD("AddStr2IdIntoBuffer str length:%uB str:%s", sendStr.length(), sendStr.c_str());
            fillSuccess = AddStr2IdIntoBuffer(sendStr, flushWrite) && fillSuccess;
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
        fillSuccess = AddStr2IdIntoBuffer(sendStr, flushWrite) && fillSuccess;
    }
    return fillSuccess;
}

int32_t DevprofDrvAicpu::ReportStr2IdInfoToHost(std::string& dataStr)
{
    FillStr2IdIntoBuffer(dataStr);
    int32_t ret = SendAddtionalInfo();
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("send str2id info failed");
        return ret;
    }
    MSPROF_LOGI("send str2id info ok");
    return ret;
}

int32_t DevprofDrvAicpu::ReportStr2IdInfoToHostMove(bool flushWrite)
{
    if (hostMoveBuffer_ == nullptr || hostMoveWptr_ == nullptr || hostMoveRptr_ == nullptr) {
        MSPROF_LOGE("Report str2id info to host move buffer failed, buffer is invalid");
        return PROFILING_FAILED;
    }

    std::string str2Id;
    int32_t ret = analysis::dvvp::transport::HashData::instance()->GetHashKeys(str2Id);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Get str2id info failed, ret:%d", ret);
        return ret;
    }
    if (str2Id.empty()) {
        MSPROF_LOGD("No str2id info to report");
        return PROFILING_SUCCESS;
    }

    MSPROF_LOGI("Report str2id info length:%zu via host move buffer", str2Id.length());
    bool fillSuccess = FillStr2IdIntoBuffer(str2Id, flushWrite);
    if (!fillSuccess) {
        MSPROF_LOGE("Report str2id info to host move buffer failed");
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

void DevprofDrvAicpu::RunNormalMode()
{
    uint32_t bufLen = 0;
    int32_t ret = MsprofDrvApi::instance()->halProfQueryAvailBufLen(devId_, channelId_, &bufLen);
    if (ret != DRV_ERROR_NONE) {
        MSPROF_LOGE("get driver buffer len failed, device id:%u, channel id:%u, ret:%d", devId_, channelId_, ret);
        return;
    }

    while (!stopped_ || (aicpuAdditionalBuffer_.GetUsedSize() != 0)) {
        if (aicpuAdditionalBuffer_.GetUsedSize() == 0) {
            (void)OsalSleep(WAIT_DATA_TIME); // sleep wait data
            continue;
        }
        uint64_t allStartTime = analysis::dvvp::common::utils::Utils::GetClockMonotonicRaw();
        ret = MsprofDrvApi::instance()->halProfQueryAvailBufLen(devId_, channelId_, &bufLen);
        if (ret != DRV_ERROR_NONE) {
            MSPROF_LOGE("get driver buffer len failed, device id:%u, channel id:%u, ret:%d", devId_, channelId_, ret);
            break;
        }
        size_t outSize = std::min(static_cast<size_t>(bufLen), analysis::dvvp::common::queue::MAX_DRV_REPORT_SIZE);
        outSize = (outSize / sizeof(MsprofAdditionalInfo)) * sizeof(MsprofAdditionalInfo);
        void* outPtr = aicpuAdditionalBuffer_.BatchPop(outSize, stopped_);
        if (outPtr == nullptr) {
            OsalSleep(WAIT_DRV_TIME);
            continue;
        }
        uint64_t reportStartTime = analysis::dvvp::common::utils::Utils::GetClockMonotonicRaw();
        struct prof_data_report_para profDataReportPara = {outPtr, static_cast<uint32_t>(outSize)};
        ret = MsprofDrvApi::instance()->halProfSampleDataReport(devId_, channelId_, 0, &profDataReportPara);
        if (ret != DRV_ERROR_NONE) {
            MSPROF_LOGE("report data failed, ret: %d, data size: %zu", ret, outSize);
        }
        uint64_t reportEndTime = analysis::dvvp::common::utils::Utils::GetClockMonotonicRaw();
        aicpuAdditionalBuffer_.BatchPopBufferIndexShift(outPtr, outSize);
        uint64_t allEndTime = analysis::dvvp::common::utils::Utils::GetClockMonotonicRaw();
        MSPROF_LOGI(
            "report data success, report cost: %llu ns, all cost: %llu ns, data size: %zu",
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

void DevprofDrvAicpu::Run(const error_message::ErrorManagerContext& errorContext)
{
    (void)errorContext;
    RunNormalMode();
}

int32_t DevprofDrvAicpu::RecordHostMoveBufferAddresses(const Devprof::AicpuUserProfileBufferInfo* info)
{
    if (info == nullptr) {
        MSPROF_LOGE("RecordHostMoveBufferAddresses info is nullptr");
        return PROFILING_FAILED;
    }
    if (info->buffer_size < sizeof(MsprofAdditionalInfo) || info->buffer_base_user_va == 0) {
        MSPROF_LOGE(
            "RecordHostMoveBufferAddresses buffer_size=%u or buffer_base_user_va=0x%llx is invalid", info->buffer_size,
            info->buffer_base_user_va);
        return PROFILING_FAILED;
    }
    if (info->buffer_write_ptr_user_va == 0 || info->buffer_read_ptr_user_va == 0) {
        MSPROF_LOGE(
            "RecordHostMoveBufferAddresses wptr=0x%llx or rptr=0x%llx is invalid", info->buffer_write_ptr_user_va,
            info->buffer_read_ptr_user_va);
        return PROFILING_FAILED;
    }
    hostMoveBufferSize_ = static_cast<size_t>(info->buffer_size);
    hostMoveBuffer_ = reinterpret_cast<uint8_t*>(static_cast<uintptr_t>(info->buffer_base_user_va));
    hostMoveRptr_ = reinterpret_cast<volatile uint32_t*>(static_cast<uintptr_t>(info->buffer_read_ptr_user_va));
    hostMoveWptr_ = reinterpret_cast<volatile uint32_t*>(static_cast<uintptr_t>(info->buffer_write_ptr_user_va));
    const uint32_t maxIdx = static_cast<uint32_t>(hostMoveBufferSize_ / sizeof(MsprofAdditionalInfo));
    if (!EnsureHostMoveCommitState(maxIdx)) {
        UninitHostMoveBuffer();
        return PROFILING_FAILED;
    }
    hostMoveReadIndex_.store(0);
    hostMoveWriteIndex_.store(0);
    hostMoveIdleWriteIndex_.store(0);
    hostMoveFailedWriteIndex_.store(0);
    hostMoveOverflowDiscardSize_.store(0);
    hostMoveMaxCycles_ = HOST_MOVE_BUFFER_MAX_CYCLES;
    hostMoveAcceptingWrites_.store(true, std::memory_order_release);
    // The shared write/read pointers live in device memory allocated by the host (halMemAlloc does
    // not guarantee zeroed memory). Until WriteDirectlyToHostMoveBuffer writes the first record, *hostMoveWptr_
    // would otherwise hold stale bytes, and the host consumer (prof_sample_aicpu_channel.c) computes
    // write_index = wptr * AICPU_BUF_UNIT and copies [read_index, write_index) -- a garbage wptr makes
    // it read far more than was ever written. Explicitly zero both pointers so producer and consumer
    // share base 0 before any data is produced.
    *hostMoveWptr_ = 0;
    *hostMoveRptr_ = 0;
    std::atomic_thread_fence(std::memory_order_release);
    MSPROF_LOGI(
        "RecordHostMoveBufferAddresses: base=0x%llx, size=%zu, wptr=0x%llx, rptr=0x%llx", info->buffer_base_user_va,
        hostMoveBufferSize_, info->buffer_write_ptr_user_va, info->buffer_read_ptr_user_va);
    return PROFILING_SUCCESS;
}

int32_t DevprofDrvAicpu::RegisterDrvChannel(uint32_t devId, uint32_t channelId)
{
    ProfSampleRegisterPara registerPara = {1, {ProfStartAicpu, ProfSampleAicpu, nullptr, ProfStopAicpu}};
    int32_t ret = MsprofDrvApi::instance()->halProfSampleRegister(devId, channelId, &registerPara);
    if (ret != DRV_ERROR_NONE) {
        MSPROF_LOGE("Failed to register aicpu sample ops, ret = %d.", ret);
        return PROFILING_FAILED;
    }

    ret = MsprofDrvApi::instance()->halProfSampleRegisterEx(devId, channelId, &registerPara);
    if (ret != DRV_ERROR_NONE) {
        // If the driver does not support halProfSampleRegisterEx, run to the old process.
        if (ret == DRV_ERROR_NOT_SUPPORT) {
            MSPROF_LOGI(
                "halProfSampleRegister succeeded but halProfSampleRegisterEx failed, ret = %d. "
                "Driver not supported.",
                ret);
            isRegister_ = true;
            return PROFILING_SUCCESS;
        }
        MSPROF_LOGW(
            "halProfSampleRegister succeeded but halProfSampleRegisterEx failed, ret = %d. "
            "Partial registration remains in driver, state inconsistent.",
            ret);
        return PROFILING_FAILED;
    }
    isRegister_ = true;
    return PROFILING_SUCCESS;
}

bool DevprofDrvAicpu::IsRegister(void) const { return isRegister_; }

#ifdef __PROF_LLT
void DevprofDrvAicpu::Reset(void)
{
    isRegister_ = false;
    stopped_ = false;
    ringFullLogged_.store(false, std::memory_order_relaxed);
    hostMoveAcceptingWrites_.store(false);
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
    for (const auto& pair : moduleCallbacks_) {
        MSPROF_LOGI(
            "Execute %u callback function with type:%u, switch:%" PRIu64 ", switchHi:%" PRIu64 ", "
            "model:%u, devNums:%u, cache: %u.",
            pair.first, command_.type, command_.profSwitch, command_.profSwitchHi, command_.modelId, command_.devNums,
            command_.cacheFlag);
        for (auto& handle : pair.second) {
            (void)handle(
                static_cast<uint32_t>(PROF_CTRL_SWITCH), Utils::ReinterpretCast<void>(&command_),
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
        (void)commandHandle(
            static_cast<uint32_t>(PROF_CTRL_SWITCH), Utils::ReinterpretCast<void>(&command_), sizeof(command_));
    }
}

/**
 * @ingroup libascend_devprof
 * @name  ModuleRegisterCallback
 * @brief Store the incoming callback function; if it is already in the START state, the callback will be executed
 * immediately.
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

int32_t DevprofDrvAicpu::AdprofInit(const AicpuStartPara* para)
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
    MSPROF_EVENT(
        "Aicpu register, device id:%u, host pid:%u, channel id:%u, profConfig:0x%x", para->devId, para->hostPid,
        para->channelId, para->profConfig);

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

uint64_t DevprofDrvAicpu::GetProfConfig() const { return profConfig_; }

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

uint64_t AdprofGetProfConfig() { return DevprofDrvAicpu::instance()->GetProfConfig(); }

void AdprofSetProfConfig(uint64_t profConfig) { DevprofDrvAicpu::instance()->SetProfConfig(profConfig); }

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
