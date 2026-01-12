/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_DEVICE_HPP
#define CCE_RUNTIME_DEVICE_HPP

#include <mutex>
#include <map>
#include <vector>
#include <memory>
#include <queue>
#include <algorithm>
#include <condition_variable>
#include "base.hpp"
#include "engine.hpp"
#include "reference.hpp"
#include "config.hpp"
#include "aicpu_scheduler_agent.hpp"
#include "atrace_log.hpp"
#include "engine_factory.hpp"
#include "spm_pool.hpp"
#include "event_pool.hpp"
#include "memory_pool_manager.hpp"
#include "dev_info_manage.h"
#include "device_snapshot.hpp"
#include "event_expanding.hpp"

namespace cce {
namespace runtime {
constexpr uint32_t DMA_CPY_NUM_DEVICE_MAX = 5 * 1024U;
#define STREAM_MESSAGE_QUEUE_SIZE (static_cast<uint16_t>(RT_MAX_STREAM_ID * 3U))
constexpr uint32_t RT_DEFAULT_STACK_SIZE_32K = 32U * 1024U;
constexpr uint32_t RT_DEFAULT_STACK_SIZE_16K = 16U * 1024U;

extern bool g_isAddrFlatDevice;

enum rtTschVersion {
    TS_VERSION_INIT = 0,
    TS_VERSION_SUPER_TASK_FOR_DVPP = 1,
    TS_VERSION_MORE_LABEL = 2,
    TS_VERSION_EXPAND_STREAM_TASK = 3,
    TS_VERSION_AICPU_EVENT_RECORD = 4,
    TS_VERSION_GET_DEV_MSG = 5,
    TS_VERSION_SUPPORT_STREAM_TASK_FULL = 6,
    TS_VERSION_AIC_ERR_REG_EXT = 7,
    TS_VERSION_EXPEND_MODEL_ID = 8,
    TS_VERSION_REDUCE_V2_ID = 9,
    TS_VERSION_LITE_LAUNCH = 10,
    TS_VERSION_TS_MODEL_ABORT = 11,
    TS_VERSION_CTRL_SQ = 12,
    TS_VERSION_SET_STREAM_MODE = 13,
    TS_VERSION_AIC_ERR_DHA_INFO = 14,
    TS_VERSION_STREAM_TIMEOUT_SNAPSHOT = 15,
    TS_VERSION_STARS_COMPATIBILITY = 16,
    TS_VERSION_IPC_NOTICE_DC = 17,
    TS_VERSION_OVER_FLOW_DEBUG = 18,
    TS_VERSION_D2D_ADDR_ASYNC = 19,
    TS_VERSION_FLIPTASK = 20,
    TS_VERSION_FFTSPLUS_TIMEOUT = 21,
    TS_VERSION_FFTSPLUS_TASKID_SAME_FIX = 22,
    TS_VERSION_MC2_RTS_SUPPORT_HCCL = 23,
    TS_VERSION_IPC_NOTICE_910_B_93 = 24,
    TS_VERSION_MC2_RTS_SUPPORT_HCCL_DC = 25,
    TS_VERSION_REDUCV2_SUPPORT_DC = 26,
    TS_VERSION_TILING_KEY_SINK = 27,
    TS_VERSION_NOP_TASK = 28,
    TS_VERSION_MODEL_STREAM_REUSE = 29,
    TS_VERSION_MC2_ENHANCE = 30,
    TS_VERSION_REDUCV2_OPTIMIZE = 31,
    TS_VERSION_WAIT_TIMEOUT_DC = 32,
    TS_VERSION_TASK_SAME_FOR_ALL = 33,
    TS_VERSION_TASK_ABORT = 34,
    TS_VERSION_AICPU_SINGLE_TIMEOUT = 35,
    TS_VERSION_LATEST
};

typedef struct {
    uint64_t addr;
    std::string kernelName;
} rtAddrKernelName_t;

typedef struct {
    std::mutex mapMutex;
    std::map<uint64_t, std::string> mapInfo;
} rtKernelNameMapTable_t;

typedef struct {
    std::mutex mtx;
    std::map<uint64_t, void *> map;
} rtBinHandleTable_t;

typedef struct  {
    uint32_t sdma_reduce_support; /**< bit for CAP_SDMA_REDUCE_* */
    uint32_t memory_support;      /**< bit for CAP_MEM_SUPPORT_* */
    uint32_t ts_group_number;
    uint32_t sdma_reduce_kind;    /**< bit for CAP_SDMA_REDUCE_KIND_* */
}rtDevCapabilityInfo;

enum class DeviceStateCallback : uint8_t {
    RT_DEVICE_STATE_CALLBACK = 0,
    RTS_DEVICE_STATE_CALLBACK,
    DEVICE_CALLBACK_TYPE_MAX
};

enum class TaskFailCallbackType : uint8_t {
    RT_SET_TASK_FAIL_CALLBACK = 0,
    RT_REG_TASK_FAIL_CALLBACK_BY_MODULE,
    RTS_SET_TASK_FAIL_CALLBACK,
    TASK_FAIL_CALLBACK_TYPE_MAX
};

enum class TaskAbortCallbackType : uint8_t {
    RT_SET_TASK_ABORT_CALLBACK = 0,
    RTS_SET_DEVICE_TASK_ABORT_CALLBACK,
    TASK_ABORT_TYPE_MAX
};

class TaskFactory;
class Task;
class ArgLoader;
class UbArgLoader;
class UmaArgLoader;
class Program;
class Module;
class Stream;
class CtrlStream;
class Engine;
class StreamSqCqManage;
class DeviceErrorProc;
class AicpuErrMsg;
class DvppGrp;
class CtrlResEntry;
class DeviceSqCqPool;
class SqAddrMemoryOrder;

// Management of a Davinci device.
class Device : public NoCopy { // Interface
public:
    enum DevType {
        RAW_DEVICE,
        STUB_DEVICE
    };

    ~Device() noexcept override
    {
        RT_LOG(RT_LOG_INFO, "device destructor.");
    }

    virtual rtError_t Init() = 0;

    // Start this device
    virtual rtError_t Start() = 0;

    // Stop this device
    virtual rtError_t Stop() = 0;

    virtual rtError_t ReOpen() = 0;
    virtual rtError_t ResourceRestore() = 0;

    virtual void PushEvent(Event *const evt) = 0;
    virtual void RemoveEvent(Event *const evt) = 0;
    virtual rtError_t EventsReAllocId(void) = 0;
    virtual void PushNotify(Notify *const nty) = 0;
    virtual void RemoveNotify(Notify *const nty) = 0;
    virtual rtError_t NotifiesReAllocId(void) = 0;

    virtual Module *ModuleAlloc(Program * const prog) = 0;
    virtual bool ModuleRetain(Module * const mdl) = 0;
    virtual bool ModuleRelease(Module *mdl) = 0;
    virtual void TryToRecycleModulesPool(uint32_t latestPoolIdx) = 0;

    // 1. for fastlaunch scenarios, pass parameters : taskObj, flipTaskId and timeout.
    // flipTaskId and timeout are optional
    // 2. for non-fastlaunch scenarios, pass parameters : taskObj, callback. callback is optional.
    virtual rtError_t SubmitTask(TaskInfo * const taskObj, const rtTaskGenCallback callback = nullptr,
        uint32_t * const flipTaskId = nullptr, int32_t timeout = -1) = 0;

    virtual rtError_t TaskReclaim(const uint32_t streamId, const bool limited, uint32_t &taskId) = 0;
    virtual rtError_t TaskReclaimAllForNoRes(const bool limited, uint32_t &taskId) = 0;
    virtual rtError_t RecycleSeparatedStmByFinishedId(Stream * const stm, const uint16_t endTaskId) = 0;
    virtual uint32_t GetPendingNum() const = 0;
    virtual rtError_t DvppWaitGroup(DvppGrp *grp, rtDvppGrpCallback callBackFunc, int32_t timeout) = 0;

    virtual void AddObserver(EngineObserver *observer) = 0;
    virtual void WaitCompletion() = 0;
    virtual Driver *Driver_() const = 0;

    virtual ArgLoader *ArgLoader_() const = 0;
    virtual UbArgLoader *UbArgLoaderPtr() const = 0;
    virtual Stream *PrimaryStream_() const = 0;
    virtual Stream *TsFFtsDsaStream_() const = 0;
    virtual Stream *CtrlStream_() const = 0;
    virtual uint32_t Id_() const = 0;
    virtual uint16_t GetTsdQos() const = 0;
    virtual void SetDeviceStatus(rtError_t status) = 0;
    virtual rtError_t GetDeviceStatus() const = 0;
    virtual uint64_t GetTTBR_() const = 0;
    virtual uint32_t GetSSID_() const = 0;
    virtual uint64_t GetTCR_() const = 0;
    virtual void *GetL2Buffer_() const = 0;
    virtual void *GetSqVirtualArrBaseAddr_() const = 0;
    virtual DevType GetType_() const = 0;
    virtual rtError_t AllocSPM(void **dptr, uint64_t size) = 0;
    virtual rtError_t FreeSPM(const void * const dptr) = 0;
    virtual bool IsSPM(const void *dptr) = 0;
    virtual rtError_t AllocPoolEvent(int32_t *eventId) = 0;
    virtual rtError_t FreeEventIdFromDrv(const int32_t eventId, const uint32_t eventFlag = 0, bool freeSyncFlag = false) = 0;
    virtual rtError_t FreePoolEvent(const int32_t eventId) = 0;
    virtual rtError_t AllocExpandingPoolEvent(void ** const eventAddr, int32_t *eventId) = 0;
    virtual rtError_t FindExpandingEventAddrById(void ** const eventAddr, int32_t eventId) =0;
    virtual void FreeExpandingPoolEvent(void * const eventAddr, const int32_t eventId) = 0;
    virtual rtChipType_t GetChipType() const = 0;
    virtual rtPlatformType_t GetPlatformType() const = 0;
    virtual void SetPlatformType(rtPlatformType_t platformType) = 0;
    virtual CtrlResEntry *GetCtrlResEntry(void) = 0;
    virtual rtError_t WriteDevValue(void * const dest, const size_t size, const void * const data) = 0;
    virtual rtError_t WriteDevString(void * const dest, const size_t max, const char_t * const str) = 0;

    virtual rtError_t AllocCustomerStackPhyBase() = 0;
    virtual const void *GetCustomerStackPhyBase() const = 0;
    virtual const void *GetStackPhyBase32k() const = 0;
    virtual const void *GetStackPhyBase16k() const = 0;
    virtual rtError_t AllocStackPhyBase() = 0;
    virtual void FreeStackPhyBase() = 0;
    virtual rtError_t RegisterAndLaunchDcacheLockOp(Context *ctx) = 0;
    virtual rtError_t SendTopicMsgVersionToAicpu() = 0;
    virtual const DevProperties& GetDevProperties(void) const = 0;
    bool IsStarsPlatform() const
    {
        return GetDevProperties().isStars;
    }

    bool IsStarsV2Platform() const
    {
        return false;
    }

    void SetDevType(bool isAddrFlatDev) const
    {
        g_isAddrFlatDevice = isAddrFlatDev;
    }

    bool IsAddrFlatDev() const
    {
        return g_isAddrFlatDevice;
    }

    bool IsDeviceRelease() const
    {
        return isDeviceRelease_;
    }

    void SetDeviceRelease()
    {
        isDeviceRelease_ = true;
    }

    void SetDevicePageFault(const bool flag)
    {
        isPageFault_ = flag;
    }

    bool IsDevicePageFault(void) const
    {
        return isPageFault_;
    }

    virtual rtError_t DevSetLimit(const rtLimitType_t type, const uint32_t val) = 0;
    virtual rtError_t DevSetTsId(const uint32_t taskSchId) = 0;
    virtual uint32_t DevGetTsId() const = 0;
    virtual rtError_t DevSetOnlineProfStart(const bool profEnable) = 0;
    virtual bool DevGetOnlineProfStart() = 0;
    virtual rtError_t DatadumpInfoLoad(const void * const dumpInfo, const uint32_t length) = 0;
    virtual bool IsSupportStopOnStreamError(void) = 0;
    virtual uint64_t GetC2cCtrlAddr(void) = 0;
    virtual uint32_t GetC2cCtrlAddrLen(void) = 0;
    virtual void SetC2cCtrlAddr(const uint64_t addr, const uint32_t addrLen) = 0; 	 

    virtual rtError_t AicpuModelLoad(void * const modelInfo) = 0;
    virtual rtError_t AicpuModelDestroy(const uint32_t modelId) = 0;
    virtual rtError_t AicpuModelExecute(const uint32_t modelId) = 0;
    virtual rtError_t AicpuModelAbort(const uint32_t modelId) = 0;
    virtual uint8_t GetGroupId() const = 0;
    virtual rtError_t SetGroup(const int32_t grpId) = 0;
    virtual rtError_t ResetGroup() = 0;
    virtual uint32_t GetPoolId() const = 0;
    virtual uint32_t GetPoolIdMax() const = 0;
    virtual uint32_t GetVfId() const = 0;
    virtual rtError_t GroupInfoSetup() = 0;
    virtual rtError_t GetGroupInfo(const int32_t grpId, rtGroupInfo_t * const info, const uint32_t cnt) = 0;
    virtual rtError_t GetGroupCount(uint32_t * const cnt) = 0;
    virtual int32_t DefaultGroup() const = 0;
    virtual StreamSqCqManage *GetStreamSqCqManage() const = 0;
    virtual TaskFactory *GetTaskFactory() const = 0;
    virtual MemoryPoolManager *GetKernelMemoryPool() const = 0;
    virtual uint32_t GetTschVersion() const = 0;
    virtual uint32_t IsSupportHcomcpu() const = 0;
    virtual uint64_t GetStarsRegBaseAddr() const = 0;
    virtual void SetTschVersionForCmodel() = 0;
    virtual void SetTschVersion(const uint32_t tschVersion) = 0;
    virtual uint64_t GetDevProfStatus() const  = 0;
    virtual void SetDevProfStatus(uint64_t profConfigType, bool isSet) = 0;
    virtual rtError_t ProcDeviceErrorInfo(TaskInfo * const taskPtr = nullptr) = 0;
    virtual rtError_t UpdateTimeoutConfig() = 0;
    virtual uint32_t GetShareLogicCqId() const = 0;
    virtual uint32_t GetShareSqId() const = 0;
    virtual rtError_t InitStreamRes(const uint32_t streamId) = 0;
    virtual rtError_t QueryLatestTaskId(const uint32_t streamId, uint32_t &taskId) = 0;
    virtual bool GetFastCqFlag() const = 0;
    virtual void SetFastCqFlag(bool flag) = 0;
    virtual rtFloatOverflowMode_t GetSatMode() const = 0;
    virtual void SetSatMode(rtFloatOverflowMode_t floatOverflowMode) = 0;
    virtual void DmaCpyIncrease() = 0;
    virtual void DmaCpyDecrease() = 0;
    virtual bool IsDmaCpyNumLimit() const = 0;
    virtual int64_t GetPhyChipId() const = 0;
    virtual int64_t GetPhyDieId() const = 0;
    virtual Stream *GetNextRecycleStream() = 0;
    virtual bool IsSupportEventPool() = 0;
    virtual bool PopNextPoolFreeEventId() = 0;
    virtual bool IsNeedFreeEventId() = 0;
    virtual void PushNextPoolFreeEventId(int32_t eventId) = 0;
    virtual bool AddStreamToMessageQueue(Stream *stm) = 0;
    virtual void DelStreamFromMessageQueue(Stream * const stm) = 0;
    virtual void WakeUpRecycleThread() = 0;
    virtual Stream* GetCtrlStream(Stream * const stream) const = 0;
    virtual void CtrlTaskReclaimByPos(CtrlStream* const stm, const uint32_t sqPos) = 0;
    virtual void CtrlTaskReclaim(CtrlStream* const stm) = 0;
    virtual rtError_t AddAddrKernelNameMapTable(rtAddrKernelName_t &mapInfo) = 0;
    virtual std::string LookupKernelNameByAddr(const uint64_t addr) = 0;
    virtual void AddAddrBinHandleMapTable(const uint64_t addr, void *const handle) = 0;
    virtual void *LookupBinHandleByAddr(const uint64_t addr) = 0;
    virtual rtError_t TaskReclaimByStm(Stream * const stm, const bool limited, uint32_t &taskId) = 0;
    virtual bool GetSnapshotFlag() = 0;
    virtual void SetSnapshotFlag(const bool flag) = 0;
    virtual uint32_t GetTsLogToHostFlag() = 0;
    virtual void SetTsLogToHostFlag(const uint32_t flag) = 0;
    virtual bool IsPrintStreamTimeoutSnapshot() = 0;
    virtual rtError_t PrintStreamTimeoutSnapshotInfo() = 0;
    virtual void *GetSnapshotAddr() = 0;
    virtual uint32_t GetSnapshotLen() = 0;
    virtual rtError_t GetDeviceCapabilities(rtDevCapabilityInfo &capInfo) = 0;
    virtual uint32_t GetDevRunningState() = 0;
    virtual void SetDevStatus(const rtError_t status) = 0;
    virtual rtError_t GetDevStatus(void) = 0;
    virtual rtError_t ReportRingBuffer(uint16_t *errorStreamId) = 0;
    virtual void ProcessReportFastRingBuffer() const = 0;
    virtual rtError_t ProcCleanRingbuffer() = 0;
    virtual void ProcClearFastRingBuffer() const = 0;
    virtual void SetMonitorExitFlag(const bool value) = 0;
    virtual bool GetMonitorExitFlag(void) = 0;
    virtual void SetHasTaskError(const bool value) = 0;
    virtual bool GetHasTaskError(void) = 0;
    virtual void SetDeviceRas(const bool value) = 0;
    virtual bool GetDeviceRas(void) const = 0;
    virtual SpinLock *GetAiCpuSdLock() = 0;
    virtual void SetIsAiCpuSdStarted(const bool value) = 0;
    virtual bool IsAiCpuSdStarted() const = 0;
    virtual void SetSupportFlipVersionSwitch() = 0;
    virtual bool IsSupportTsVersionForFlipTask() const = 0;
    virtual uint64_t GetChipAddr() const = 0;
    virtual uint64_t GetChipOffset() const = 0;
    virtual uint64_t GetDieOffset() const = 0;
    virtual bool AllocHcclIndex(uint16_t &hcclIndex, uint16_t stmid) = 0;
    virtual void FreeHcclIndex(uint16_t stmid) = 0;
    virtual uint16_t GetHcclStreamIdWithIndex(uint16_t index) = 0;
    virtual void SetAtraceHandle(TraHandle handle) = 0;
    virtual TraHandle GetAtraceHandle(void) const = 0;
    virtual void SetAtraceEventHandle(TraEventHandle handle) = 0;
    virtual TraEventHandle GetAtraceEventHandle(void) const = 0;
    virtual void SetIsChipSupportRecycleThread(bool flag) = 0;
    virtual bool GetIsChipSupportRecycleThread() const = 0;
    virtual void SetIsChipSupportEventThread(bool flag) = 0;
    virtual bool GetIsChipSupportEventThread() const = 0;
    virtual void TryFreeAllEventPoolId() = 0;
    virtual void SetLastUsagePoolTimeStamp() =0;
    virtual uint32_t GetTaskIdFromStreamShmTaskId(const uint32_t streamId) = 0;
    virtual void PrintExceedLimitHcclStream() = 0;
    virtual void SetDevFailureMode(const uint64_t failureMode) = 0;
    virtual uint64_t GetDevFailureMode() = 0;
    virtual bool CheckFeatureSupport(const uint32_t tsFeature) = 0;
    virtual void InitTschCapability(uint8_t *tschCapability, uint32_t tschCapaLen, uint32_t tschCapaDepth) = 0;
    virtual void SetIsRingbufferGetErr(bool flag) = 0;
    virtual bool GetIsRingbufferGetErr() const = 0;
    virtual void FindAndEraseSyncEventMap(uint16_t id) = 0;
    virtual void SetDebugSqId(const uint32_t debugSqId) = 0;
    virtual uint32_t GetDebugSqId() const = 0;
    virtual void SetDebugCqId(const uint32_t debugCqId) = 0;
    virtual uint32_t GetDebugCqId() const = 0;
    virtual void SetCoredumpEnable() = 0;
    virtual bool IsCoredumpEnable() const = 0;
    virtual uint64_t GetInterCoreSyncAddr() const = 0;
    virtual rtError_t FreeSimtStackPhyBase() = 0;
    virtual rtError_t AllocSimtStackPhyBase(const rtChipType_t chipType) = 0;
    virtual const void *GetSimtStackPhyBase() const = 0;
    virtual void SetSimtStackPhyBase(void *simtStackPhyBaseAlign) = 0;
    virtual uint32_t GetSimtDvgWarpStkSize() const = 0;
    virtual uint32_t GetSimtWarpStkSize() const = 0;
    virtual uint8_t GetStarsV2DieNum() const = 0;
    virtual rtError_t SetCurGroupInfo() = 0;
    virtual void GetErrorPcArr(const uint16_t devId, uint64_t **errorPc, uint32_t *cnt) const = 0;
    virtual uint32_t GetDeviceAllocStackSize() const = 0;
    virtual uint32_t GetDeviceCustomerStackLevel() const = 0;
    virtual void SetDeviceCustomerStackLevel(uint32_t val) = 0;
    virtual void SetRunMode(uint32_t runMode) = 0;
    virtual uint32_t GetRunMode() const = 0;
    virtual DeviceSqCqPool *GetDeviceSqCqManage() const = 0;
    virtual SqAddrMemoryOrder *GetSqAddrMemoryManage() const = 0;
    virtual void InsertResLimit(rtDevResLimitType_t type, uint32_t value) = 0;
    virtual uint32_t GetResInitValue(const rtDevResLimitType_t type) const = 0;
    virtual uint32_t GetResValue(const rtDevResLimitType_t type) const = 0;
    virtual void ResetResLimit(void) = 0;
    virtual void SetPageFaultBaseCnt(const uint32_t value) = 0;
    virtual void SetPageFaultBaseTime(const uint64_t time) = 0;
    virtual uint32_t GetPageFaultBaseCnt() const = 0;
    virtual uint64_t GetPageFaultBaseTime() const = 0;
    virtual void SetDeviceFaultType(const DeviceFaultType type) = 0;
    virtual DeviceFaultType GetDeviceFaultType()  const = 0;
    virtual void SetAixErrRecoverCnt() = 0;
    virtual uint32_t GetAixErrRecoverCnt() const = 0;
    virtual bool IsSupportUserMem() const = 0;
    virtual rtError_t EnableP2PWithOtherDevice(const uint32_t peerPhyDeviceId) = 0;
    virtual bool IsSupportFeature(RtOptionalFeatureType f) const = 0;
    virtual DeviceSnapshot *GetDeviceSnapShot(void) = 0;
    virtual std::map<std::pair<uint32_t, uint32_t>, std::vector<rtExceptionErrRegInfo_t>>& GetExceptionRegMap() = 0;
    virtual std::mutex& GetExceptionRegMutex() = 0;
    virtual rtError_t ParsePrintInfo() = 0;
    virtual void WaitForParsePrintf() const = 0;
    virtual rtError_t GetPrintFifoAddress(uint64_t * const addr) = 0;
    virtual rtError_t StoreEndGraphNotifyInfo(Stream* exeStream, Model* captureModel, uint32_t endGraphNotifyPos) = 0;
    virtual rtError_t DeleteEndGraphNotifyInfo(Stream* exeStream, Model* captureModel, uint32_t endGraphNotifyPos) = 0;
    virtual rtError_t ClearEndGraphNotifyInfoByModel(Model* captureModel) = 0;
    virtual uint64_t AllocSqIdMemAddr() = 0;
    virtual void FreeSqIdMemAddr(const uint64_t sqIdAddr) = 0;

    inline std::mutex& GetHcclStreamIndexMutex(void)
    {
        return hcclStreamIndexMutex_;
    }

    inline void ArgStreamMutexLock(void)
    {
        argStreamMutex_.lock();
    }

    inline void ArgStreamMutexUnLock(void)
    {
        argStreamMutex_.unlock();
    }

    inline std::mutex& GetErrProLock(void)
    {
        return devErrProLock_;
    }

    inline void SetArgStreamNum(const uint8_t value)
    {
        argStreamNum_ = value;
    }

    inline uint8_t GetArgStreamNum(void) const
    {
        return argStreamNum_;
    }
    bool GetIsDoingRecycling() const
    {
        return isDoingRecycling_;
    }
    void SetIsDoingRecycling(const bool flag)
    {
        isDoingRecycling_ = flag;
    }

private:
    bool isPageFault_{false};
    bool isDeviceRelease_{false};
    bool isDoingRecycling_{false};
    uint8_t argStreamNum_{0};
    std::mutex devErrProLock_;
    std::mutex argStreamMutex_;
    std::mutex hcclStreamIndexMutex_; // lock for hcclStreamSize_
};
}
}

#endif  // CCE_RUNTIME_DEVICE_HPP
