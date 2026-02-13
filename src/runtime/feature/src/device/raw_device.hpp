/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_RAW_DEVICE_HPP
#define CCE_RUNTIME_RAW_DEVICE_HPP

#include <set>
#include <unordered_set>
#include <list>
#include "group_device.hpp"
#include <tuple>
#include "device.hpp"
#include "base_david.hpp"
#include "event_expanding.hpp"
#include "ctrl_sq.hpp"
#include "program.hpp"

namespace cce {
namespace runtime {

class DeviceSnapshot;
class RawDevice : public GroupDevice {
public:
    explicit RawDevice(const uint32_t devId);
    ~RawDevice() noexcept override;

    rtError_t Init() override;
    rtError_t Start() override;
    rtError_t Stop() override;
    rtError_t ReOpen() override;
    rtError_t ResourceRestore() override;

    void PushEvent(Event *const evt) override;
    void RemoveEvent(Event *const evt) override;
    rtError_t EventsReAllocId(void) override;
    void PushNotify(Notify *const nty) override;
    void RemoveNotify(Notify *const nty) override;
    rtError_t NotifiesReAllocId(void) override;

    Module *ModuleAlloc(Program * const prog) override;
    bool ModuleRetain(Module * const mdl) override;
    bool ModuleRelease(Module *mdl) override;

    rtError_t DevSetLimit(const rtLimitType_t type, const uint32_t val) override;
    rtError_t DevSetTsId(const uint32_t taskSchId) override;
    rtError_t DevSetOnlineProfStart(const bool profEnable) override;
    rtError_t ReportRingBuffer(uint16_t *errorStreamId) override;
    void ProcessReportFastRingBuffer() const override;
    rtError_t ProcCleanRingbuffer() override;
    void ProcClearFastRingBuffer() const override;

    rtError_t RegisterAndLaunchDcacheLockOp(Context *ctx) override;

    rtError_t SendTopicMsgVersionToAicpu() override;

    uint32_t DevGetTsId() const override
    {
        return tsId_;
    }

    bool DevGetOnlineProfStart() override
    {
        return onProfEnable_.Value();
    }

    void SetDevFailureMode(const uint64_t failureMode) override
    {
        devFailureMode_.Set(failureMode);
    }

    uint64_t GetDevFailureMode() override
    {
        return devFailureMode_.Value();
    }

    rtError_t SubmitTask(TaskInfo * const taskObj, const rtTaskGenCallback callback = nullptr,
        uint32_t * const flipTaskId = nullptr, int32_t timeout = -1) override
    {
        UNUSED(callback);
        const rtError_t error = GetDeviceStatus();
        COND_PROC((error != RT_ERROR_NONE), return error);
        return engine_->SubmitTask(taskObj, flipTaskId, timeout);
    }

    rtError_t TaskReclaim(const uint32_t streamId, const bool limited, uint32_t &taskId) override
    {
        return engine_->TaskReclaim(streamId, limited, taskId);
    }
    rtError_t TaskReclaimAllForNoRes(const bool limited, uint32_t &taskId) override
    {
        return engine_->TaskReclaimAllForNoRes(limited, taskId);
    }
    rtError_t  RecycleSeparatedStmByFinishedId(Stream * const stm, const uint16_t endTaskId) override
    {
        return engine_->RecycleSeparatedStmByFinishedId(stm, endTaskId);
    }

    uint32_t GetPendingNum() const override
    {
        return engine_->GetPendingNum();
    }

    rtError_t DvppWaitGroup(DvppGrp *grp, rtDvppGrpCallback callBackFunc, int32_t timeout) override
    {
        return engine_->DvppWaitGroup(grp, callBackFunc, timeout);
    }

    void AddObserver(EngineObserver *observer) override
    {
        engine_->AddObserver(observer);
    }
    void WaitCompletion() override
    {
        engine_->WaitCompletion();
    }
    Driver *Driver_() const override
    {
        return driver_;
    }

    ArgLoader *ArgLoader_() const override
    {
        return argLoader_;
    }

    UbArgLoader *UbArgLoaderPtr() const override
    {
        return ubArgLoader_;
    }
    Stream *PrimaryStream_() const override
    {
        return primaryStream_;
    }

    Stream *TsFFtsDsaStream_() const override
    {
        return tsFftsDsaStream_;
    }

    Stream *CtrlStream_() const override
    {
        return ctrlStream_;
    }

    uint32_t Id_() const override
    {
        return deviceId_;
    }

    uint16_t GetTsdQos() const override
    {
        return tsdQos_;
    }

    void SetDeviceStatus(rtError_t status) override
    {
        deviceStatus_.Set(status);
    }

    rtError_t GetDeviceStatus() const override
    {
        return deviceStatus_.Value();
    }

    void SetDeviceFaultType(const DeviceFaultType type) override
    {
        deviceFaultType_.Set(type);
    }

    DeviceFaultType GetDeviceFaultType() const override
    {
        return deviceFaultType_.Value();
    }

    uint64_t GetTTBR_() const override
    {
        return TTBR_;
    }

    uint32_t GetSSID_() const override
    {
        return SSID_;
    }
    uint64_t GetTCR_() const override
    {
        return TCR_;
    }

    void *GetL2Buffer_() const override
    {
        return l2buffer_;
    }

    DevType GetType_() const override
    {
        return RAW_DEVICE;
    }

    const void *GetStackPhyBase32k() const override
    {
        return stackPhyBase32kAlign_;
    }

    const void *GetStackPhyBase16k() const override
    {
        return stackPhyBase16k_;
    }

    uint32_t GetDeviceAllocStackSize() const override
    {
        return deviceAllocStackSize_;
    }

    uint32_t GetDeviceCustomerStackLevel() const override
    {
        return deviceCustomerStackLevel_;
    }

    void SetDeviceCustomerStackLevel(uint32_t val) override
    {
        deviceCustomerStackLevel_ = val / RT_DEFAULT_STACK_SIZE_16K - 2U; // 2 32k时stackLevel为0;
    }

    rtError_t AllocSPM(void **dptr, uint64_t size) override
    {
        COND_RETURN_ERROR(!IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DEVICE_SPM_POOL), RT_ERROR_FEATURE_NOT_SUPPORT,
            "MDC_AS31XM1X not support spm, so not support AllocSPM.");
        return spmPool_->AllocSPM(dptr, size);
    }

    rtError_t FreeSPM(const void * const dptr) override
    {
        if (!IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DEVICE_SPM_POOL)) {
            RT_LOG(RT_LOG_INFO, "MDC_AS31XM1X not support spm, so not support FreeSPM.");
            return RT_ERROR_NONE;
        }
        return spmPool_->FreeSPM(dptr);
    }
    rtError_t AllocPoolEvent(int32_t *eventId) override
    {
        return eventPool_->AllocEventId(eventId);
    }
    rtError_t FreePoolEvent(const int32_t eventId) override
    {
        return eventPool_->FreeEventId(eventId);
    }
    rtError_t FreeEventIdFromDrv(const int32_t eventId, const uint32_t eventFlag = 0, bool freeSyncFlag = false) override;

    rtError_t AllocExpandingPoolEvent(void ** const eventAddr, int32_t *eventId) override
    {
        return eventExpandingPool_->AllocAndInsertEvent(eventAddr, eventId);
    }

    void FreeExpandingPoolEvent(const int32_t eventId) override
 	{
 	    return eventExpandingPool_->FreeEventId(eventId);
    }
    bool IsSPM(const void *dptr) override
    {
        if (!IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DEVICE_SPM_POOL)) {
            RT_LOG(RT_LOG_INFO, "MDC_AS31XM1X not support spm, so not support IsSPM");
            return false;
        }
        return spmPool_->IsSPM(dptr);
    }

    rtChipType_t GetChipType() const override
    {
        return static_cast<rtChipType_t>(PLAT_GET_CHIP(platformConfig_));
    }

    void SetPlatformType(rtPlatformType_t platformType) override
    {
        platformType_ = platformType;
    }

    rtPlatformType_t GetPlatformType() const override
    {
        return platformType_;
    }

    void SetDevProfStatus(uint64_t profConfigType, bool isSet) override
    {
        if (isSet) {
            devProfStatus_ |= profConfigType;
        } else {
            devProfStatus_ &= profConfigType;
        }
        RT_LOG(RT_LOG_INFO, "devProfStatus_=%#" PRIx64 ", profConfigType=%#" PRIx64, devProfStatus_, profConfigType);
    }

    uint64_t GetDevProfStatus() const override
    {
        return devProfStatus_;
    }

    rtError_t DatadumpInfoLoad(const void * const dumpInfo, const uint32_t length) override;

    rtError_t  AicpuModelLoad(void * const modelInfo) override;

    rtError_t AicpuModelDestroy(const uint32_t modelId) override;

    rtError_t AicpuModelExecute(const uint32_t modelId) override;

    rtError_t AicpuModelAbort(const uint32_t modelId) override;

    StreamSqCqManage *GetStreamSqCqManage() const override
    {
        return streamSqCqManage_;
    }

    TaskFactory *GetTaskFactory() const override
    {
        return taskFactory_;
    }

    MemoryPoolManager *GetKernelMemoryPool() const override
    {
        return kernelMemPoolMng_;
    }

    uint32_t GetTschVersion() const override
    {
        return tschVersion_;
    }

    uint32_t IsSupportHcomcpu() const override
    {
        return isSupportHcomcpu_;
    }

    void SetTschVersionForCmodel() override
    {
        tschVersion_ = TS_VERSION_LATEST;
        RT_LOG(RT_LOG_DEBUG, "Simulation scene set tsch version to TS_VERSION_LATEST.");
    }
    void SetTschVersion(const uint32_t tschVersion) override;
    rtError_t ProcDeviceErrorInfo(TaskInfo * const taskPtr = nullptr) override;

    rtError_t UpdateTimeoutConfig() override;

    rtError_t InitStreamRes(const uint32_t streamId) override
    {
        return engine_->InitStreamRes(streamId);
    }

    rtError_t QueryLatestTaskId(const uint32_t streamId, uint32_t &taskId) override
    {
        return engine_->QueryLatestTaskId(streamId, taskId);
    }

    uint32_t GetTaskIdFromStreamShmTaskId(const uint32_t streamId) override
    {
        return engine_->GetTaskIdFromStreamShmTaskId(streamId);
    }

    uint32_t GetShareLogicCqId() const override
    {
        return engine_->GetShareLogicCqId();
    }

    uint32_t GetShareSqId() const override
    {
        return engine_->GetShareSqId();
    }

    bool GetFastCqFlag() const override
    {
        return fastCqFlag_;
    }

    void SetFastCqFlag(bool flag) override
    {
        fastCqFlag_ = flag;
    }

    void DmaCpyIncrease() override
    {
        dmaCpyUsedNum_++;
    }

    void DmaCpyDecrease() override
    {
        --dmaCpyUsedNum_;
    }

    bool IsDmaCpyNumLimit() const override
    {
        return (dmaCpyUsedNum_.load() >= DMA_CPY_NUM_DEVICE_MAX) ? true : false;
    }

    int64_t GetPhyChipId() const override
    {
        return phyChipId_;
    }

    int64_t GetPhyDieId() const override
    {
        return phyDieId_;
    }

    Stream *GetNextRecycleStream() override;
    bool AddStreamToMessageQueue(Stream *stm) override;
    void DelStreamFromMessageQueue(Stream * const stm) override;
    bool IsSupportEventPool() override {
        return eventPool_ != nullptr;
    }
    bool PopNextPoolFreeEventId() override;
    bool IsNeedFreeEventId() override;
    void PushNextPoolFreeEventId(int32_t eventId) override;
    void WakeUpRecycleThread() override
    {
        engine_->WakeUpRecycleThread();
    }
    
    Stream* GetCtrlStream(Stream* const stream) const override;

    void CtrlTaskReclaimByPos(CtrlStream* const stm, const uint32_t sqPos) override
    {
        return engine_->RecycleCtrlTask(stm, sqPos);
    }

    void CtrlTaskReclaim(CtrlStream* const stm) override
    {
        return engine_->CtrlTaskReclaim(stm);
    }
    void *GetSqVirtualArrBaseAddr_() const override
    {
        return sqVirtualArrBaseAddr_;
    }
    rtError_t AllocMemForSqVirtualArr();

    rtError_t AddAddrKernelNameMapTable(rtAddrKernelName_t &mapInfo) override;
    std::string LookupKernelNameByAddr(const uint64_t addr) override;
    void AddAddrBinHandleMapTable(const uint64_t addr, void *const handle) override;
    void *LookupBinHandleByAddr(const uint64_t addr) override;
    void CreateMessageQueue();
    void CreateFreeEventQueue();
    rtError_t TaskReclaimByStm(Stream * const stm, const bool limited, uint32_t &taskId) override
    {
        return engine_->TaskReclaimByStm(stm, limited, taskId);
    }
    bool GetSnapshotFlag() override
    {
        return isPrintSnapshotFlag_;
    }

    void SetSnapshotFlag(const bool flag) override
    {
        isPrintSnapshotFlag_ = flag;
    }

    uint32_t GetTsLogToHostFlag() override
    {
        return isSupportTslogTohost;
    }

    void SetTsLogToHostFlag(const uint32_t flag) override
    {
        isSupportTslogTohost |= flag;
    }

    Engine *Engine_() const
    {
        return engine_;
    }

    bool IsPrintStreamTimeoutSnapshot() override;
    rtError_t PrintStreamTimeoutSnapshotInfo() override;
    void *GetSnapshotAddr() override;
    uint32_t GetSnapshotLen() override;
    rtError_t GetDeviceCapabilities(rtDevCapabilityInfo &capInfo) override
    {
        capInfo = devCapInfo_;
        return RT_ERROR_NONE;
    }
    uint32_t GetDevRunningState() override
    {
        return engine_->GetDevRunningState();
    }

    void SetDevStatus(const rtError_t status) override
    {
        devStatus_ = status;
    }

    rtError_t GetDevStatus(void) override
    {
        return devStatus_;
    }

    SpinLock *GetAiCpuSdLock() override
    {
        return &aicpuSchSdLock_;
    }

    void SetIsAiCpuSdStarted(const bool value) override
    {
        isAicpuSdStarted_ = value;
    }

    bool IsAiCpuSdStarted() const override
    {
        return isAicpuSdStarted_;
    }

    void SetSupportFlipVersionSwitch() override;

    bool IsSupportTsVersionForFlipTask() const override
    {
        return supportFlipTask_;
    }
    uint64_t GetChipAddr() const override
    {
        return chipBaseAddr;
    }

    uint64_t GetChipOffset() const override
    {
        return chipOffset;
    }

    uint64_t GetStarsRegBaseAddr() const override
    {
        return starsRegBaseAddr_;
    }
    uint64_t GetDieOffset() const override
    {
        return chipDieOffset;
    }

    bool AllocHcclIndex(uint16_t &hcclIndex, uint16_t stmid) override;
    void FreeHcclIndex(uint16_t stmid) override;
    uint16_t GetHcclStreamIdWithIndex(uint16_t index) override
    {
        return hcclStream[index];
    }

    void SetIsChipSupportRecycleThread(bool flag) override
    {
        isChipSupportRecycleThread_ = flag;
    }

    bool GetIsChipSupportRecycleThread() const override
    {
        return isChipSupportRecycleThread_;
    }

    void SetIsChipSupportEventThread(bool flag) override
    {
        isChipSupportEventThread_ = flag;
    }

    bool GetIsChipSupportEventThread() const override
    {
        return isChipSupportEventThread_;
    }

    void TryFreeAllEventPoolId() override;
    void SetLastUsagePoolTimeStamp() override
    {
        lastUsagePoolTimeStamp_ = mmGetTickCount();
    }
    void PrintExceedLimitHcclStream() override;

	rtError_t AllocSimtStackPhyBase(const rtChipType_t chipType) override;
    rtError_t FreeSimtStackPhyBase() override;
    const void *GetSimtStackPhyBase() const override
    {
        return simtStackPhyBaseAlign_;
    }

    void SetSimtStackPhyBase(void *simtStackPhyBaseAlign) override
    {
        simtStackPhyBaseAlign_ = simtStackPhyBaseAlign;
    }

    uint8_t GetDavidDieNum() const override
    {
        return davidDieNum_;
    }

    rtError_t SetCurGroupInfo() override;

    bool CheckFeatureSupport(const uint32_t tsFeature) override;

    void InitTschCapability(uint8_t *tschCapability, uint32_t tschCapaLen, uint32_t tschCapaDepth) override
    {
        if (tschCapability_ != nullptr) {
            delete[] tschCapability_;
        }
        tschCapability_ = tschCapability;
        tschCapaLen_ = tschCapaLen;
        tschCapaDepth_ = tschCapaDepth;
    }
    void SetIsRingbufferGetErr(bool flag) override
    {
        isRingbufferGetErr_  = flag;
    }

    bool GetIsRingbufferGetErr() const override
    {
        return isRingbufferGetErr_;
    }
    bool CheckCanFreeModulesPool(uint32_t poolIdx);
    void TryToRecycleModulesPool(uint32_t latestPoolIdx) override;

    void FindAndEraseSyncEventMap(uint16_t id) override
    {
        const std::lock_guard<std::mutex> lock(syncEventMapLock_);
        auto it = syncEventMap_.find(id);
        if (it != syncEventMap_.end()) {
            syncEventMap_.erase(it);
        }
    }

    void SetDebugSqId(const uint32_t debugSqId) override
    {
        debugSqId_ = debugSqId;
    }
    uint32_t GetDebugSqId() const override
    {
        return debugSqId_;
    }
    void SetDebugCqId(const uint32_t debugCqId) override
    {
        debugCqId_ = debugCqId;
    }
    uint32_t GetDebugCqId() const override
    {
        return debugCqId_;
    }
    void SetCoredumpEnable() override
    {
        isCoredumpEnable_ = true;
    }
    bool IsCoredumpEnable() const override
    {
        return isCoredumpEnable_;
    }

    uint64_t GetInterCoreSyncAddr() const override
    {
        return interCoreSyncAddr_;
    }

    void InitResource();

    void InsertResInit(rtDevResLimitType_t type, uint32_t value);

    uint32_t GetResInitValue(const rtDevResLimitType_t type) const override;

    void InsertResLimit(rtDevResLimitType_t type, uint32_t value) override;

    uint32_t GetResValue(const rtDevResLimitType_t type) const override;

    void ResetResLimit(void) override;

    rtError_t AllocCustomerStackPhyBase() override;

    const void *GetCustomerStackPhyBase() const override
    {
        return customerStackPhyBase_;
    }

    uint32_t GetSimtDvgWarpStkSize() const override
    {
        return simtDvgWarpStkSize_;
    }

    uint32_t GetSimtWarpStkSize() const override
    { 
        return simtWarpStkSize_;
    }

    rtError_t AllocStackPhyBase() override;
    rtError_t AllocStackPhyBaseDavid();
    rtError_t AllocStackPhyBaseForCloudV2();
    rtError_t UbArgLoaderInit(void);
    void FreeStackPhyBase() override;
    void FreeCustomerStackPhyBase();
    
    void SetPageFaultBaseCnt(const uint32_t value) override
    {
        pageFaultBaseCnt_ = value;
    }

    void SetPageFaultBaseTime(const uint64_t time) override
    {
        pageFaultBaseTime_ = time;
    }

    uint32_t GetPageFaultBaseCnt() const override
    {
        return pageFaultBaseCnt_;
    }

    uint64_t GetPageFaultBaseTime() const override
    {
        return pageFaultBaseTime_;
    }

    void SetAixErrRecoverCnt() override
    {
        aixErrRecoverCnt_.Add(1U);
    }
 
    uint32_t GetAixErrRecoverCnt() const override
    {
        return aixErrRecoverCnt_.Value();
    }

    void AddSimtPrintTlvCnt(uint64_t val) const override
    {
        simtPrintTlvCnt_.Add(val);
    }
 
    uint64_t GetSimtPrintTlvCnt() const override
    {
        return simtPrintTlvCnt_.Value();
    }

    bool GetPrintSimtEnable() const override
    {
        return simtEnable_;
    }

    uint32_t GetSimtPrintLen() const override
    {
        return simtPrintLen_;
    }

    void* GetSimtPrintfAddr() const override
    {
        return simtPrintfAddr_;
    }

    void GetErrorPcArr(const uint16_t devId, uint64_t **errorPc, uint32_t *cnt) const override;

    bool IsSupportUserMem() const override
    {
        return isDrvSupportUserMem_;
    }

    CtrlResEntry *GetCtrlResEntry(void) override
    {
        return ctrlRes_;
    }
    /*
    * set run mode.
    * @param runMode: run mode to set
    */
    void SetRunMode(uint32_t runMode) override
    { 
        runMode_ = runMode; 
    }
    /*
     * get run mode.
     * @return uint32_t: current run mode
    */
    uint32_t GetRunMode() const override
    { 
        return runMode_; 
    }
    rtError_t WriteDevValue(void * const dest, const size_t size, const void * const data) override;
    rtError_t WriteDevString(void * const dest, const size_t max, const char_t * const str) override;

    rtError_t EnableP2PWithOtherDevice(const uint32_t peerPhyDeviceId) override;
    bool IsSupportFeature(RtOptionalFeatureType f) const override;
    DeviceSnapshot *GetDeviceSnapShot(void) override
    {
        return deviceSnapshot_;
    }
    rtError_t ParsePrintInfo() override;
    rtError_t ParseSimtPrintInfo() override;
    rtError_t ParseSimdPrintInfo() override;
    void WaitForParsePrintf() const override;
    rtError_t GetPrintFifoAddress(uint64_t * const addr, const uint32_t model) override;

    rtError_t StoreEndGraphNotifyInfo(Stream* exeStream, Model* captureModel, uint32_t endGraphNotifyPos) override;
    rtError_t DeleteEndGraphNotifyInfo(Stream* exeStream, Model* captureModel, uint32_t endGraphNotifyPos) override;
    rtError_t ClearEndGraphNotifyInfoByModel(Model* captureModel) override;
    void PollEndGraphNotifyInfo();

    bool IsSupportStopOnStreamError(void) override
    {
        return isSupportStopOnStreamError_;
    }

    uint64_t GetC2cCtrlAddr(void) override
    {
        return c2cCtrlAddr_.Value();
    }

    uint32_t GetC2cCtrlAddrLen(void) override
    {
        return c2cCtrlAddrLen_.Value();
    }

    void SetC2cCtrlAddr(const uint64_t addr, const uint32_t addrLen) override
    {
        c2cCtrlAddr_.Set(addr);
        c2cCtrlAddrLen_.Set(addrLen);
    }

    DeviceSqCqPool *GetDeviceSqCqManage() const override
    {
        return deviceSqCqPool_;
    }

    SqAddrMemoryOrder *GetSqAddrMemoryManage() const override
    {
        return sqAddrMemoryOrder_;
    }

    const DevProperties& GetDevProperties(void) const override
    {
        return properties_;
    }

    std::map<std::pair<uint32_t, uint32_t>, std::vector<rtExceptionErrRegInfo_t>>& GetExceptionRegMap() override
    {
        return exceptionRegMap_;
    }

    std::mutex &GetExceptionRegMutex() override
    {
        return exceptionRegMutex_;
    }

    uint64_t AllocSqIdMemAddr() override;
    void FreeSqIdMemAddr(const uint64_t sqIdAddr) override;

    CtrlSQ& GetCtrlSQ(void) const override
    {
        return *(ctrlSQ_.get());
    }

    void RegisterProgram(Program *prog) override;
    void UnRegisterProgram(Program *prog) override;
    void UnregisterAllProgram();
    bool ProgramSetMutexTryLock() override {
        return programMtx_.try_lock();
    }
    void ProgramSetMutexUnLock() override {
        programMtx_.unlock();
    }

    rtError_t SetQosCfg(const qos_master_config_type& qosCfg, uint32_t index);

    const qos_master_config_t& GetQosCfg()
    {
        return aicoreQosCfgs_;
    }

private:
    bool JudgeIsEndGraphNotifyWaitExecuted(const Stream* const exeStream, Model* captureModel,
        std::list<uint32_t>& sqePosList) const;
    bool CheckTschCapability(const uint32_t tsFeature) const;
    uint32_t ConvertTsFeature(const uint32_t tsFeature) const;
    rtError_t RegisterDcacheLockOp(Program *&dcacheLockOpProgram);
    rtError_t AllocStackPhyAddrForDcache();
    rtError_t Alloc32kStackAddrForDcache();
    rtError_t GetStarsVersion();
    rtError_t TschStreamSetup();
    rtError_t TschStreamAllocDsaAddr() const;
    rtError_t SetSupportHcomcpuFlag();
    static void *MallocBufferForSqIdMem(const size_t size, void * const para);
    static void FreeBufferForSqIdMem(void * const addr, void * const para);

    void CtrlResEntrySetup();
    void CtrlStreamSetup();
    rtError_t InitRawDriver();
    rtError_t InitStreamSyncEsched() const;
    rtError_t InitTsdQos();
    rtError_t InitPrintInfo();
    rtError_t InitSimtPrintInfo();
    rtError_t InitCtrlSQ();
    rtError_t InitQosCfg();

    Stream *primaryStream_;
    Stream *tsFftsDsaStream_;
    Stream *ctrlStream_;
    ArgLoader *argLoader_;
    UbArgLoader *ubArgLoader_;
    ObjAllocator<RefObject<Module *>> *modulesAllocator_;
    RefObject<Stream *> ctrlStreamObj;
    uint32_t deviceId_;
    Driver *driver_;
    Engine *engine_;
    Atomic<rtError_t> deviceStatus_;
    SpmPool *spmPool_;
    EventPool *eventPool_; // stubdevice ?
    CtrlResEntry *ctrlRes_{nullptr};

    // driver info
    uint64_t TTBR_;
    uint32_t SSID_;
    uint64_t TCR_;
    void *l2buffer_;
    uint32_t platformConfig_;
    rtPlatformType_t platformType_;

    Atomic<bool> onProfEnable_;
    Atomic<uint64_t> devFailureMode_{0};  // device级别的遇错即停状态
    uint32_t tsId_;
    TaskFactory *taskFactory_;
    MemoryPoolManager* kernelMemPoolMng_;
    uint64_t devProfStatus_;
    StreamSqCqManage *streamSqCqManage_;
    uint32_t tschVersion_{static_cast<uint32_t>(TS_VERSION_LATEST)};
    uint32_t isSupportHcomcpu_{0U};
    DeviceErrorProc *deviceErrorProc_;
    AicpuSchedulerAgent aicpuSdAgent_;
    AicpuErrMsg *errMsgObj_;
    bool fastCqFlag_;  // is need to alloc fast cq
    std::atomic<uint32_t> dmaCpyUsedNum_;
    int64_t phyChipId_;
    int64_t phyDieId_;
    uint16_t tsdQos_{0U};  // for aicpu task
    uint64_t *messageQueue_{nullptr};
    uint16_t messageQueueSize_{STREAM_MESSAGE_QUEUE_SIZE};
    uint16_t messageQueueHead_{0U};
    uint16_t messageQueueTail_{0U};
    std::mutex messageQueueMutex_;
    std::mutex freeEventMutex_;
    void *sqVirtualArrBaseAddr_;
    int32_t *freeEvent_{nullptr};
    uint32_t freeEventQueueHead_{0U};
    uint32_t freeEventQueueTail_{0U};
    uint16_t hcclStreamSize_; // index range[0, 7]
    uint16_t hcclStream[MAX_HCCL_STREAM_NUM + 1U];
    uint32_t noIndexHcclStmId;
    rtKernelNameMapTable_t addrKernelNameMap_;
    rtBinHandleTable_t addrBinHandleMap_;
    bool isPrintSnapshotFlag_ = true;
    uint32_t isSupportTslogTohost = 0U;
    rtDevCapabilityInfo devCapInfo_ = {};
    rtError_t devStatus_ = RT_ERROR_NONE;
    SpinLock aicpuSchSdLock_;
    bool isAicpuSdStarted_ = false;
    bool supportFlipTask_{false};
    uint64_t chipBaseAddr{0ULL};    // for asic`s work base
    uint64_t starsRegBaseAddr_{0ULL};
    uint64_t chipOffset{RT_CHIP_ADDR_OFFSET_8T};      // the interval addr for tow diff chip
    uint64_t chipDieOffset{RT_DIE_ADDR_OFFSET_1T};   // the interval addr for tow die  in the one asic
    bool isChipSupportRecycleThread_ = false;
    bool isChipSupportEventThread_ = false;
    mmTimespec lastUsagePoolTimeStamp_ = mmGetTickCount();
	void *simtStackPhyBase_{nullptr};
    void *simtStackPhyBaseAlign_{nullptr};
    uint32_t simtWarpStkSize_{RT_KIS_SIMT_WARP_STK_SIZE};
    uint32_t simtDvgWarpStkSize_{RT_KIS_SIMT_DVG_WARP_STK_SIZE};
    uint8_t davidDieNum_{1};
    std::set<uint16_t> syncEventMap_;
    std::mutex syncEventMapLock_;
    static const std::map<uint32_t, uint32_t> tsFeatureMap_;
    const uint8_t *tschCapability_{nullptr};
    uint32_t tschCapaLen_{0};
    uint32_t tschCapaDepth_{0};
    bool isRingbufferGetErr_ = false;
    uint32_t debugSqId_ = 0U;
    uint32_t debugCqId_ = 0U;
    bool isCoredumpEnable_ = false;
    uint64_t interCoreSyncAddr_ = MAX_UINT64_NUM;

    void *stackPhyBase32k_{nullptr};
    void *stackPhyBase16k_{nullptr};
    void *stackPhyBase32kAlign_{nullptr};
    bool stackAddrIsDcache_{false};
    bool dCacheLockFlag_{false};
    std::array<uint32_t, RT_DEV_RES_TYPE_MAX> resInitArray_ = {};
    std::array<uint32_t, RT_DEV_RES_TYPE_MAX> resLimitArray_ = {};
    void *drvMemCtrlHandle_{nullptr};
    void *customerStackPhyBase_{nullptr};
    uint32_t deviceAllocStackSize_{RT_DEFAULT_STACK_SIZE_32K};
    uint32_t deviceCustomerStackLevel_{0};
    uint32_t pageFaultBaseCnt_= 0U;
    uint32_t pageFaultCurrentCnt_= 0U;
    uint64_t pageFaultBaseTime_= 0U;
    uint64_t pageFaultEndTime_= 0U;
    uint32_t runMode_;
    Atomic<DeviceFaultType> deviceFaultType_{DeviceFaultType::NO_ERROR};
    Atomic<uint32_t> aixErrRecoverCnt_{0};
    bool isDrvSupportUserMem_ = false;
    std::array<bool, FEATURE_MAX_VALUE> featureSet_{};
    DevProperties properties_;
    std::unordered_set<Event *> events_;
    std::mutex eventLock_;
    std::unordered_set<Notify *> notifies_;
    std::mutex notifyLock_;
    DeviceSnapshot *deviceSnapshot_{nullptr};
    EventExpandingPool *eventExpandingPool_;
    /* 
     * 支持的场景：exeStream多次执行相同的captureModel，exeStream执行多个不同的captureModel
     * 不支持的场景：不同的exestream执行相同的captureModel
     */
    std::map<std::tuple<Stream*, Model*>, std::list<uint32_t>> captureModelExeInfoMap_;     // key: tuple<exeStream, captureModel>, value: endGraphNotifyPosList
    std::mutex captureModelExeInfoLock_;
    DeviceSqCqPool *deviceSqCqPool_;
    SqAddrMemoryOrder *sqAddrMemoryOrder_;
    std::map<std::pair<uint32_t, uint32_t>, std::vector<rtExceptionErrRegInfo_t>> exceptionRegMap_;
    std::mutex exceptionRegMutex_;
    bool isSupportStopOnStreamError_{false};
    Atomic<uint64_t> c2cCtrlAddr_{0UL};
    Atomic<uint32_t> c2cCtrlAddrLen_{0U};

    std::mutex printfMtx_;
    void *printfAddr_ = nullptr;
    void *simtPrintfAddr_ = nullptr;
    uint32_t printblockLen_{SIMD_FIFO_PER_CORE_SIZE_32K}; // device 备份
 	uint32_t simtPrintLen_{SIMT_FIFO_SIZE_2M}; // device 备份
    bool simdEnable_{false};
    bool simtEnable_{false};
    std::atomic<uint64_t> parseCounter_{0};
    mutable Atomic<uint64_t> simtPrintTlvCnt_{0U};
    BufferAllocator* sqIdMemAddrPool_{nullptr};
    std::unique_ptr<CtrlSQ> ctrlSQ_ = nullptr;
    std::mutex programMtx_;
    std::unordered_set<Program *> programSet_;
    qos_master_config_t aicoreQosCfgs_;
};
}
}

#endif  // CCE_RUNTIME_RAW_DEVICE_HPP