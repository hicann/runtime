/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CCE_RUNTIME_DEVICE_ERROR_PROC_HPP
#define CCE_RUNTIME_DEVICE_ERROR_PROC_HPP

#include <atomic>
#include <mutex>
#include <thread>
#include "base.hpp"
#include "device.hpp"
#include "device_error_info.hpp"
#include "device_error_inner_data.hpp"

#define BITMAP_CLR(val, pos) ((val) &= (~(1ULL << (pos))))
#define RUNTIME_NULL_NO_PROC_WITH_RET(x) \
    if ((x) == nullptr) { \
        return RT_ERROR_NONE; \
    }

namespace cce {
namespace runtime {
constexpr size_t DEVICE_FAST_RINGBUFFER_SIZE = 4 * 1024U; // 4k
bool HasMteErr(const Device * const dev);
bool HasMemUceErr(const uint32_t deviceId, const std::map<uint32_t, std::string>& eventIdBlkList = g_mulBitEccEventId);
void SetTaskMteErr(TaskInfo *errTaskPtr, const Device * const dev,
    const std::map<uint32_t, std::string>& eventIdBlkList = g_mulBitEccEventId);
void GetMteErrFromCqeStatus(TaskInfo *errTaskPtr, const Device * const dev, const uint32_t cqeStatus,
    const std::map<uint32_t, std::string>& eventIdBlkList = g_mulBitEccEventId);
rtError_t GetDeviceFaultEvents(const uint32_t deviceId, rtDmsFaultEvent *faultEventInfo,
    uint32_t &eventCount, const uint32_t maxFaultNum = 128U);
bool IsFaultEventOccur(const uint32_t faultEventId, const rtDmsFaultEvent * const faultEventInfo, const uint32_t eventCount);
bool IsHitBlacklist(const rtDmsFaultEvent *faultEventInfo, const uint32_t eventCount, const std::map<uint32_t, std::string>& eventIdBlkList);
bool IsEventRasMatch(const rtDmsFaultEvent &event, const EventRasFilter &filter);
bool IsEventIdAndRasCodeMatch(const uint32_t deviceId, const std::vector<EventRasFilter> &ubNonMemPoisonRasList = g_ubNonMemPoisonRasList);
bool HasBlacklistEventOnDevice(const uint32_t deviceId, const std::map<uint32_t, std::string>& eventIdBlkList = g_mulBitEccEventId);
class DeviceErrorProc {
public:
    explicit DeviceErrorProc(Device *dev);
    DeviceErrorProc(Device *dev, uint32_t ringBufferSize);

    ~DeviceErrorProc() noexcept;

    DeviceErrorProc(const DeviceErrorProc &) = delete;
    DeviceErrorProc &operator=(const DeviceErrorProc &) = delete;
    DeviceErrorProc(DeviceErrorProc &&) = delete;
    DeviceErrorProc &operator=(DeviceErrorProc &&) = delete;
    
    using StarsErrorInfoProc = rtError_t (*)(const StarsDeviceErrorInfo * const info,
                                            const uint64_t errorNumber,
                                            const Device * const dev, const DeviceErrorProc * const insPtr);

    // create a ringbuffer and send task to device.
    rtError_t CreateDeviceRingBufferAndSendTask();
    rtError_t CreateFastRingbuffer();

    // restore ringbuffer, send task to device.
    rtError_t RingBufferRestore();

    // stop device to use the ringbuffer.
    rtError_t SendTaskToStopUseRingBuffer();

    // create a ringbuffer and send task to device.
    rtError_t DestroyDeviceRingBuffer();

    // process all error information in ringbuffer.
    rtError_t ProcErrorInfo(const TaskInfo * const taskPtr = nullptr);
    rtError_t ProcTaskErrorWithoutLock(const TaskInfo * const taskPtr = nullptr, const bool isPrintTaskInfo = false);
    rtError_t ProcessReportRingBuffer(const DevRingBufferCtlInfo * const tmpCtrlInfo,
        Driver * const devDrv, uint16_t *errorStreamId);

    // read ringbuffer for watchDog.
    rtError_t ReportRingBuffer(uint16_t *errorStreamId);
    void ProcessReportFastRingBuffer();

    rtError_t ProcCleanRingbuffer();
    void ProcClearFastRingBuffer() const;

    void ProduceProcNum();

    void SetRealFaultTaskPtr(TaskInfo *taskPtr)
    {
        realFaultTaskPtr_ = taskPtr;
    }

    TaskInfo *GetRealFaultTaskPtr() const
    {
        return realFaultTaskPtr_;
    }

    // print event/notify wait timeout task info.
    bool IsPrintStreamTimeoutSnapshot();
    rtError_t PrintStreamTimeoutSnapshotInfo();
    void *GetSnapshotAddr() const
    {
        return RtValueToPtr<void *>(RtPtrToValue(deviceRingBufferAddr_) + static_cast<uint64_t>(snapshotLenOffset_));
    }
    uint32_t GetSnapshotLen() const
    {
        return snapshotLen_;
    }

    static AicErrorInfo error_pc[MAX_DEV_ID];
    void GetErrorPcArr(const uint16_t devId, uint64_t **errorPc, uint32_t *cnt) const
    {
        if (devId >= MAX_DEV_ID) {
            return;
        }

        *errorPc = &error_pc[devId].last_error_pc[0U];
        *cnt = MAX_AIC_ID + MAX_AIV_ID;
        return;
    }
    
    static rtError_t ProcessStarsCoreErrorInfo(const StarsDeviceErrorInfo * const info,
                                               const uint64_t errorNumber,
                                               const Device * const dev, const DeviceErrorProc * const insPtr);
    static rtError_t ProcessStarsWaitTimeoutErrorInfo(const StarsDeviceErrorInfo * const info,
                                                      const uint64_t errorNumber,
                                                      const Device * const dev, const DeviceErrorProc * const insPtr);
    // process sdma error information and record info to host log
    static rtError_t ProcessStarsSdmaErrorInfo(const StarsDeviceErrorInfo * const info,
                                               const uint64_t errorNumber,
                                               const Device * const dev, const DeviceErrorProc * const insPtr);
    static rtError_t ProcessStarsDvppErrorInfo(const StarsDeviceErrorInfo * const info,
                                               const uint64_t errorNumber,
                                               const Device *const dev, const DeviceErrorProc *const insPtr);
    static rtError_t ProcessStarsDsaErrorInfo(const StarsDeviceErrorInfo * const info,
                                              const uint64_t errorNumber,
                                              const Device * const dev, const DeviceErrorProc * const insPtr);
    static rtError_t ProcessStarsSqeErrorInfo(const StarsDeviceErrorInfo * const info,
                                              const uint64_t errorNumber,
                                              const Device * const dev, const DeviceErrorProc * const insPtr);
	static rtError_t ProcessStarsHcclFftsPlusTimeoutErrorInfo(const StarsDeviceErrorInfo * const info,
                                                      const uint64_t errorNumber,
                                                      const Device * const dev, const DeviceErrorProc * const insPtr);
    static rtError_t ProcessStarsCoreTimeoutDfxInfo(const StarsDeviceErrorInfo *const info, const uint64_t errorNumber,
        const Device *const dev, const DeviceErrorProc *const insPtr);
private:
    rtError_t ProcErrorInfoWithoutLock(const TaskInfo * const taskPtr = nullptr, const bool isPrintTaskInfo = false);

    // process aicore error information and record info to host log
    static rtError_t ProcessCoreErrorInfo(const DeviceErrorInfo * const coreInfo,
                                          const uint64_t errorNumber,
                                          const Device *const dev);

    static void PrintCoreErrorInfo(const DeviceErrorInfo * const coreInfo,
                                   const uint64_t errorNumber,
                                   const std::string &coreType,
                                   const uint64_t coreIdx,
                                   const Device *const dev,
                                   const std::string &errorStr);
    static void PrintCoreInfoErrMsg(const DeviceErrorInfo * const coreInfo);

    // process sdma error information and record info to host log
    static rtError_t ProcessSdmaErrorInfo(const DeviceErrorInfo * const info,
                                          const uint64_t errorNumber,
                                          const Device *const dev);

    // process aicpu error information and record info to host log
    static rtError_t ProcessAicpuErrorInfo(const DeviceErrorInfo * const info,
                                           const uint64_t errorNumber,
                                           const Device *const dev);

    // process one element in ringbuffer.
    rtError_t ProcessOneElementInRingBuffer(const DevRingBufferCtlInfo * const ctlInfo, uint32_t head,
        const uint32_t tail) const;
    rtError_t ProcessStarsOneElementInRingBuffer(const DevRingBufferCtlInfo * const ctlInfo, uint32_t head,
        const uint32_t tail, const bool isPrintTaskInfo = false, const TaskInfo * const taskPtr = nullptr) const;
    // print task info in monitor
    void PrintTaskErrorInfo(const uint32_t errorType, const StarsDeviceErrorInfo * const errorInfo) const;

    // process information in ringbuffer
    rtError_t ProcRingBufferTask(const void * const devMem, const bool delFlag, const uint32_t len);

    rtError_t CheckValid(const DevRingBufferCtlInfo *const ctrlInfo);

    rtError_t PrintRingbufferErrorInfo(const DevRingBufferCtlInfo *const ctrlInfo) const;

    void ConsumeProcNum(const uint32_t procNum);

    static void ProcessStarsTimeoutDfxSlotInfo(
        const StarsDeviceErrorInfo *const info, const Device *const dev, uint16_t slotIdx);

    static void ProcessStarsTimeoutDfxSlotInfo4FftsPlus(
        const StarsDeviceErrorInfo *const info, Device *dev, uint16_t slotIdx);

	static void ProcessStarsCoreErrorOneMapInfo(uint32_t * const cnt, uint64_t err, std::string &errorString,
        uint32_t offset);

	static void ProcessStarsCoreErrorMapInfo(const StarsOneCoreErrorInfo * const info, std::string &errorString);

    rtError_t WriteRuntimeCapability(const void *hostAddr) const;
    rtError_t GetTschCapability(const void *devMem) const;

private:
    using ErrorInfoProc = rtError_t (*)(const DeviceErrorInfo * const info,
                                        const uint64_t errorNumber,
                                        const Device *const dev);
    static const std::map<uint64_t, ErrorInfoProc> funcMap_;
    static const std::map<uint64_t, std::string> errMsgCommMap_;
    static const std::map<uint64_t, std::string> cqeErrorMapInfo_;
    static const std::map<uint64_t, std::string> channelErrorMapInfo_;
    static const std::map<uint64_t, std::string> errorMapInfo_;
    std::mutex mutex_;
    Device *device_;
    void *deviceRingBufferAddr_;
    std::mutex fastRingbufferMutex_;
    void *fastRingBufferAddr_{nullptr};
    size_t fastRingBufferSize_{DEVICE_FAST_RINGBUFFER_SIZE};
    std::atomic<uint64_t> needProcNum_;
    std::atomic<uint64_t> consumeNum_;
    uint32_t ringBufferSize_;
    TaskInfo *realFaultTaskPtr_;
    uint32_t snapshotLenOffset_ = ringBufferSize_ - sizeof(RtsTimeoutStreamSnapshot);
    uint32_t snapshotLen_ = sizeof(RtsTimeoutStreamSnapshot);
};

const std::string GetStarsRingBufferHeadMsg(const uint16_t errType);
// process aicpu error information and record info to host log
rtError_t ProcessStarsAicpuErrorInfo(const StarsDeviceErrorInfo *const info, const uint64_t errorNumber,
    const Device *const dev, const DeviceErrorProc *const insPtr);
uint32_t GetRingbufferElementNum();

void UpdateDeviceErrorProcFunc(std::map<uint64_t, DeviceErrorProc::StarsErrorInfoProc> &funcMap);
uint16_t GetMteErrWaitCount();
void MteErrorProc(const TaskInfo * const errTaskPtr, const Device * const dev,
    const int32_t errorCode, bool &hasSpecialErrorCode);
void SetDeviceFaultTypeByErrorType(const Device * const dev, const rtErrorType errorType, bool &hasSpecialErrorCode);
}
}
#endif // CCE_RUNTIME_DEVICE_ERROR_PROC_HPP

