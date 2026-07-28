/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_CONTEXT_HPP
#define CCE_RUNTIME_CONTEXT_HPP

#include <list>
#include <memory>
#include <unordered_set>
#include "runtime/kernel.h"
#include "runtime/mem.h"
#include "runtime/rt_inner_mem.h"
#include "base.hpp"
#include "osal.hpp"
#include "reference.hpp"
#include "arg_loader.hpp"
#include "runtime.hpp"
#include "kernel.hpp"
#include "program.hpp"
#include "pctrace.hpp"
#include "model.hpp"
#include "capture_model.hpp"
#include "jetty_pool.h"
#include "label.hpp"
#include "rw_lock.h"
#include "error_message_manage.hpp"
#ifndef CFG_DEV_PLATFORM_PC
#include "error_manager.h"
#endif
#include "profiler_struct.hpp"
#include "task_to_sqe.hpp"
#include "context_manage.hpp"
#include "rts/rts.h"
#include "mmpa_linux.h"
#include "cond_handle.hpp"

#define CHECK_CONTEXT_VALID_WITH_RETURN(tmpCtx, ERRCODE)                                    \
    {                                                                                       \
        const bool isValidFlag = ContextManage::CheckContextIsValid((tmpCtx));              \
        COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_GE, !isValidFlag, (ERRCODE), "ctx is NULL!"); \
    }
#define CHECK_CONTEXT_VALID_WITH_PROC_RETURN(tmpCtx, ERRCODE, PROC)     \
    {                                                                   \
        const bool flag = ContextManage::CheckContextIsValid((tmpCtx)); \
        COND_PROC_RETURN_WARN(!flag, (ERRCODE), PROC, "ctx is NULL!");  \
    }
#define RT_STARS_MODEL_RDMADB_TASK_NUM (2U)
namespace cce {
namespace runtime {
class Device;
class Stream;
class Module;
class CaptureModel;
class Program;
class Kernel;
class DavinciKernelTask;
class PCTraceTask;
class Runtime;
struct StarsArgLoaderResult;
class Model;
class Label;
struct ArgLoaderResult;
class DvppGrp;
class SqeInfo;

enum TearDownStatus {
    TEARDOWN_NOT_EXECUTE = 0, // TDT threads is idle
    TEARDOWN_WORKING = 1,     // TDT threads is working
    TEARDOWN_ERROR = 2,       // TDT threads begin to stop
    TEARDOWN_SUCCESS = 3      // TDT threads stopped
};

enum class ContextState : uint8_t {
    /* Not set up, or reset and waiting for reuse. */
    CTX_STATE_NOT_INITIALIZED = 0U,
    /* Setup is running; only internal paths may access. */
    CTX_STATE_INITIALIZING = 1U,
    /* Ready for user API access. */
    CTX_STATE_ACTIVE = 2U,
    /* Teardown is running; user API access is blocked. */
    CTX_STATE_FINALIZING = 3U,
    /* Teardown finished, resources are not fully released yet. */
    CTX_STATE_FINALIZED = 4U,
    /* Releasing resources or deleting the context. */
    CTX_STATE_DEINITIALIZING = 5U,
};

constexpr uint64_t MEM_BLOCK_SIZE = 64ULL * 1024ULL * 1024ULL; // 64MB:64 * 1024 * 1024
constexpr uint32_t TS_NUM_ADC = 2U;
constexpr uint32_t OVERFLOW_ADDR_MAX_SIZE = 512U;
extern bool g_isAddrFlatDevice;
rtError_t LaunchAicpuKernelForCpuSo(
    const rtKernelLaunchNames_t* const launchNames, const rtArgsEx_t* const argsInfo, Stream* const stm);
class ContextCallBack : public ThreadRunnable {
    void Run(const void* const param) override;

public:
    std::atomic<bool> callBackThreadRunFlag_{false};
};

class Context : public NoCopy {
public:
    static constexpr uint64_t MEM_ALIGN_SIZE = 0x40ULL;
    Context(Device* const ctxDevice, const bool primaryCtx);
    ~Context() override;

    // init context
    virtual rtError_t Setup();

    // destroy this context
    virtual rtError_t TearDown();
    rtError_t TearDownForFinalRelease();

    // Wait event recorded to complete.
    rtError_t Synchronize(int32_t timeout);

    rtError_t DatadumpInfoLoad(const void* const dumpInfo, const uint32_t length, const uint32_t flag);

    rtError_t AicpuInfoLoad(const void* const aicpuInfo, const uint32_t length);

    rtError_t DebugRegister(
        Model* const mdl, const uint32_t flag, const void* const addr, uint32_t* const streamId,
        uint32_t* const taskId);

    rtError_t DebugUnRegister(Model* const mdl);

    rtError_t DebugRegisterForStream(
        Stream* const debugStream, const uint32_t flag, const void* const addr, uint32_t* const streamId,
        uint32_t* const taskId);

    rtError_t DebugUnRegisterForStream(Stream* const debugStream);

    rtError_t GetDevArgsAddr(
        Stream* const stm, const rtArgsEx_t* const argsInfo, void** const devArgsAddr, void** const argsHandle) const;
    rtError_t LaunchSqeUpdateTask(
        const void* const src, const uint64_t cpySize, uint32_t sqId, uint32_t pos, Stream* const stm);

    virtual rtError_t StreamCreate(
        const uint32_t prio, const uint32_t flag, Stream** const result, DvppGrp* grp = nullptr,
        const bool isSoftWareSqEnable = false, const bool isAutoSplitEnable = false);

    virtual rtError_t StreamDestroy(Stream* const stm, bool flag = true);

    rtError_t CreateAutoSplitSlaveStream(Stream* const masterStm, Stream** newSlaveStream);

    void SetStreamsStatus(rtError_t status);

    rtError_t StreamsCleanSq(void);

    rtError_t StreamsKill(void);

    rtError_t StreamsQuery(uint32_t& status);

    rtError_t StreamsTaskClean(void);

    rtError_t StreamsRestore(void);

    rtError_t StreamsUpdate(void);

    rtError_t StreamBeginCapture(Stream* const stm, const rtStreamCaptureMode mode, Model* const mdl = nullptr);

    rtError_t StreamEndCapture(Stream* const stm, Model** const captureMdl);

    rtError_t StreamGetCaptureInfo(
        const Stream* const stm, rtStreamCaptureStatus* const status, Model** const captureMdl) const;

    rtError_t StreamBeginTaskUpdate(Stream* const stm, TaskGroup* handle) const;

    rtError_t StreamEndTaskUpdate(Stream* const stm) const;

    rtError_t StreamAddCondTask(CondHandle* condHandle, rtCondTaskParams params, Stream* const stm, uint32_t flags);
    rtError_t SubmitCaptureConditionTask(CondHandle* condHandle, Stream* const stm);

    rtError_t ModelGetNodes(const Model* const mdl, uint32_t* const num);

    rtError_t CreateSubCaptureModels(CondHandle* condHandle, rtCondTaskParams params, Stream* const stm);

    rtError_t ModelDebugDotPrint(const Model* const mdl);

    rtError_t ModelDebugJsonPrint(const Model* const mdl, const char* path, const uint32_t flags);

    rtError_t StreamAddToModel(Stream* const stm, Model* const captureMdl);

    rtError_t ThreadExchangeCaptureMode(rtStreamCaptureMode* const mode) const;

    rtError_t StreamBeginTaskGrp(Stream* const stm);

    rtError_t StreamEndTaskGrp(Stream* const stm, TaskGroup** const handle) const;

    rtError_t StreamAddToCaptureModelProc(Stream* const stm, Model* const captureMdl, const bool isOriginal = false);

    rtError_t ModelCreate(Model** const result, ModelType type = RT_MODEL_NORMAL);

    rtError_t AllocCascadeCaptureStream(const Stream* const stm, Model* const captureModel, Stream** newCaptureStream);

    void FreeCascadeCaptureStream(Stream* const cascadeCaptureStm);

    rtError_t CreateNotify(Notify** notify, uint32_t flag);

    rtError_t AddNotifyToAddedCaptureStream(Stream* const oriSingleStm, CaptureModel* const captureMdl);

    rtError_t SetNotifyForExeModel(CaptureModel* const captureMdl);

    rtError_t ModelDestroy(Model* mdl);

    void SubModelDestroy(Model* subMdl);

    rtError_t ModelBindStream(Model* const mdl, Stream* const stm, const uint32_t flag);

    rtError_t ModelUnbindStream(Model* const mdl, Stream* const stm);

    rtError_t ModelAddStream(Model* const mdl, Stream* const stm, const uint32_t flag);

    rtError_t ModelDelStream(Model* const mdl, Stream* const stm);

    rtError_t ModelLoadComplete(Model* const mdl) const;

    rtError_t ModelAddEndGraph(Model* const mdl, Stream* const stm, const uint32_t flags);

    bool CheckSubModelsIsEndCapture(const Stream* const captureStream) const;

    rtError_t ModelExecutorSet(Model* const mdl, const uint8_t flags) const;

    rtError_t ModelNameSet(Model* const mdl, const char_t* const name) const;

    rtError_t ModelGetName(const Model* const mdl, const uint32_t maxLen, char_t* const mdlName) const;

    rtError_t ModelAbort(Model* const mdl) const;

    rtError_t ModelAbortById(uint32_t modelId) const;

    rtError_t ModelExit(Model* const mdl, Stream* const stm);

    rtError_t ModelBindQueue(Model* const mdl, const uint32_t queueId, const rtModelQueueFlag_t flag) const;

    rtError_t CallbackLaunch(
        const rtCallback_t callBackFunc, void* const fnData, Stream* const stm, const bool isBlock,
        const int32_t evtId);

    rtError_t RDMASend(const uint32_t sqIndex, const uint32_t wqeIndex, Stream* const stm);

    rtError_t RdmaDbSendToDev(
        const uint32_t dbIndex, const uint64_t dbInfo, Stream* const stm, const uint32_t taskSqe = 0U) const;

    rtError_t RdmaDbSend(const uint32_t dbIndex, const uint64_t dbInfo, Stream* const stm);

    rtError_t ProfilerTrace(const uint64_t id, const bool notifyFlag, const uint32_t flags, Stream* const stm);

    rtError_t ProfilerTraceEx(const uint64_t id, const uint64_t modelId, const uint16_t tagId, Stream* stm);

    rtError_t SetStreamSqLockUnlock(Stream* const stm, const bool isLock);

    rtError_t NopTask(Stream* const stm) const;

    rtError_t CopyTilingTabToDev(
        Program* const programHdl, const Device* const device, void** devCopyMem, uint32_t* TilingTabLen);

    rtError_t ModelTaskUpdate(const Stream* desStm, uint32_t desTaskId, Stream* sinkStm, rtMdlTaskUpdateInfo_t* para);

    rtError_t StreamClear(const Stream* const stm, rtClearStep_t step) const;
    bool IsStreamAbortSupported();
    rtError_t StreamAbort(Stream* const stm);

    rtError_t GetStackBuffer(
        const rtBinHandle binHandle, const uint32_t coreType, const uint32_t coreId, const void** stack,
        uint32_t* stackSize) const;
    rtError_t DebugSetDumpMode(const uint64_t mode);
    rtError_t DebugGetStalledCore(rtDbgCoreInfo_t* const coreInfo);
    rtError_t DebugReadAICore(rtDebugMemoryParam_t* const param);
    rtError_t GetExceptionRegInfo(
        const rtExceptionInfo_t* const exceptionInfo, rtExceptionErrRegInfo_t** exceptionErrRegInfo,
        uint32_t* num) const;
    Stream* GetCtrlSQStream() const;

    void SetDefaultStream(Stream* stm) { defaultStream_ = stm; }
    Stream* DefaultStream_() const { return defaultStream_; }

    Stream* OnlineStream_() const { return onlineStream_; }

    Device* Device_() const { return device_; }

    bool IsPrimary() const { return isPrimary_; }

    uint32_t UserDeviceId() const { return userDeviceId_; }

    rtTaskGenCallback TaskGenCallback_() const { return taskGenCallback_; }

    void InsertStreamList(Stream* const stm)
    {
        std::unique_lock<std::mutex> taskLock(streamLock_);
        try {
            for (const Stream* const ownedStream : streams_) {
                if (ownedStream == stm) {
                    return;
                }
            }
            streams_.push_back(stm);
        } catch (std::exception& e) {
            RT_LOG(RT_LOG_ERROR, "%s", e.what());
        }
    }

    Module* GetModuleWithoutCreate(const Program* const prog);

    Module* GetModule(Program* const prog);
    void PutModule(Module* const delModule);
    rtError_t ReleaseModule(const uint32_t id);

    rtError_t StartOnlineProf(Stream* const stm, const uint32_t sampleNum);
    rtError_t StopOnlineProf(Stream* const stm);
    rtError_t GetOnlineProfData(
        const Stream* const stm, rtProfDataInfo_t* const pProfData, const uint32_t profDataNum) const;

    rtError_t AdcProfiler(Stream* const stm, const uint64_t addr, const uint32_t length);
    rtError_t LabelSwitchListCreate(Label** const labels, const size_t num, void** const labelList) const;

    rtError_t FftsPlusTaskLaunch(
        const rtFftsPlusTaskInfo_t* const fftsPlusTaskInfo, Stream* const stm, const uint32_t flag);
    rtError_t CmoAddrTaskLaunch(
        rtCmoAddrInfo* const cmoAddrInfo, const uint64_t destMax, const rtCmoOpCode_t cmoOpCode, Stream* const stm,
        const uint32_t flag);
    rtError_t NpuGetFloatStatus(
        void* const outputAddrPtr, const uint64_t outputSize, const uint32_t checkMode, Stream* const stm,
        bool isDebug = false);
    rtError_t NpuClearFloatStatus(const uint32_t checkMode, Stream* const stm, bool isDebug = false);
    rtError_t SetStreamOverflowSwitch(Stream* const stm, const uint32_t flags);

    rtError_t DvppGroupCreate(DvppGrp** grp, const uint32_t flags);
    rtError_t DvppGroupDestory(DvppGrp* grp);
    rtError_t DvppWaitGroupReport(DvppGrp* const grp, const rtDvppGrpCallback callBackFunc, const int32_t timeout);
    rtError_t SetStreamTag(Stream* const stm, const uint32_t geOpTag) const;

    rtError_t CtxSetSysParamOpt(const rtSysParamOpt configOpt, const int64_t configVal);
    rtError_t CtxGetSysParamOpt(const rtSysParamOpt configOpt, int64_t* const configVal);
    rtError_t GetSatStatusForStars(const uint64_t outputSize, Stream* const curStm);
    rtError_t SetUpdateAddrTask(uint64_t devAddr, uint64_t len, Stream* stm);

    rtError_t LaunchRandomNumTask(const rtRandomNumTaskInfo_t* taskInfo, Stream* const stm, const void* reserve) const;

    void ContextThreadBind() { (void)threadRefCount_.fetch_add(1U, std::memory_order_acq_rel); }

    uint64_t ContextThreadUnbind()
    {
        uint64_t oldCount = threadRefCount_.load(std::memory_order_acquire);
        while (oldCount != 0U) {
            if (threadRefCount_.compare_exchange_weak(oldCount, oldCount - 1U, std::memory_order_acq_rel)) {
                return oldCount - 1U;
            }
        }
        return 0U;
    }

    uint64_t GetThreadRefCount() const { return threadRefCount_.load(std::memory_order_acquire); }

    void ResetThreadRefCount() { threadRefCount_.store(0U, std::memory_order_release); }

    void SetContextDeleteStatus() { isNeedDelete_.Set(true); }
    bool GetContextIsNeedDelStatus() const { return isNeedDelete_.Value(); }

    ContextState GetState() const { return lifecycleState_.load(std::memory_order_acquire); }

    bool IsStateAccessible(const ContextAccessMode accessMode) const
    {
        const ContextState state = GetState();
        if (state == ContextState::CTX_STATE_ACTIVE) {
            return true;
        }
        if (accessMode != ContextAccessMode::INTERNAL) {
            return false;
        }
        return (state == ContextState::CTX_STATE_INITIALIZING) || (state == ContextState::CTX_STATE_FINALIZING);
    }

    bool TrySwitchState(
        const ContextState expectedState, const ContextState targetState, const char_t* const trigger = nullptr);

    void SetState(const ContextState state, const char_t* const trigger = nullptr);
    void AttachDevice(Device* const device)
    {
        device_ = device;
        resourcesReleased_.store(false, std::memory_order_release);
    }

    void ReleaseResourcesAfterTearDown();

    bool TryDeleteIfNeeded();

    void SetCallBackThreadExistFlag() { callBackThreadExist_.Set(true); }

    bool GetCallBackThreadExistFlag() const { return callBackThreadExist_.Value(); }

    bool TearDownIsCanExecute();
    void SetTearDownExecuteResult(TearDownStatus status)
    {
        tearDownStatus_ = status;
        if (status == TEARDOWN_ERROR) {
            (void)TrySwitchState(
                ContextState::CTX_STATE_FINALIZING, ContextState::CTX_STATE_ACTIVE, "SetTearDownExecuteResultError");
        } else if (status == TEARDOWN_SUCCESS) {
            (void)TrySwitchState(
                ContextState::CTX_STATE_FINALIZING, ContextState::CTX_STATE_FINALIZED,
                "SetTearDownExecuteResultSuccess");
        }
    }

    void SetINFMode(bool mode) { infMode_ = mode; }

    bool IsINFMode() const { return infMode_; }

    rtError_t GetNotifyAddress(Notify* const notify, uint64_t& addr, Stream* const stm);

    void* CtxGetOverflowAddr() const { return overflowAddr_; }
    uint64_t CtxGetOverflowAddrOffset() const { return overflowAddrOffset_; }

    void SetFailureError(const rtError_t error) { failureError_.Set(error); }

    rtError_t GetFailureError() const { return failureError_.Value(); }

    bool GetAicpuExecuteModel() const { return containAicpuExecuteModel_; }
    void SetAicpuExecuteModel() { containAicpuExecuteModel_ = true; }

    const std::list<Stream*> StreamList_() const { return streams_; }

    rtError_t SyncStreamsWithTimeout(const std::list<Stream*>& streams, int32_t timeout, const mmTimespec start) const;
    rtError_t CheckMemAlign(const void* const addr, const rtDataType_t type) const;
    bool IsStreamInContext(Stream* const stm);
    rtError_t ResourceReset(void);

    rtError_t GetContextLastErr()
    {
        const rtError_t error = lastErr_.Value();
        lastErr_.Set(ACL_RT_SUCCESS);
        return error;
    }

    rtError_t PeekContextLastErr() const { return lastErr_.Value(); }

    void SetContextLastErr(rtError_t errcode) { lastErr_.Set(errcode); }

    bool ModelIsExistInContext(const Model* mdl);
    bool CheckCanFreeModulePool(uint32_t poolIdx);
    bool CheckCanFreePorgPool(uint32_t poolIdx) const;
    void TryToRecycleModulePool();
    void TryToRecycleProgPool(uint32_t latestPoolIdx);
    void TryToRecycleCtxPool(uint32_t latestPoolIdx);
    void TryToRecycleDevPool(uint32_t latestPoolIdx) const;
    rtError_t TaskReclaimforSyncDevice(const mmTimespec startTime, int32_t timeout);

    std::mutex& GetCaptureLock() { return captureLock_; }

    rtStreamCaptureMode GetContextCaptureMode(void) const { return captureMode_; }

    void SetContextCaptureMode(rtStreamCaptureMode mode) { captureMode_ = mode; }

    uint32_t GetCaptureModeRefNum(rtStreamCaptureMode mode) { return captureModeRefNum_[mode]; }

    void CaptureModeEnter(Stream* const stm, rtStreamCaptureMode mode);
    void CaptureModeExit(Stream* const stm);
    bool IsCaptureModeSupport(void) const;

    const std::list<Model*>& GetModelList() const { return models_; }

    SpinLock& GetModelLock() { return modelLock_; }
    rtError_t SetMemcpyDesc(
        rtMemcpyDesc_t desc, const void* const srcAddr, const void* const dstAddr, const size_t count);

    void SetContextForceReset(const bool isForceReset) { isForceReset_ = isForceReset; }

    bool IsContextForceReset() const { return isForceReset_; }

    rtError_t UpdateEndGraphTask(Stream* const origCaptureStream, Stream* const exeStream, Notify* ntf) const;
    rtError_t UpdateSuModelExeStreamNotifyWaitSqe(TaskInfo* taskInfo, Stream* const exeStream) const;
    rtError_t SendAndRecvDebugTask(RtDebugSendInfo* const sendInfo, rtDebugReportInfo_t* const reportInfo) const;
    uint64_t GetCallBackThreadId() const { return callBackThreadId_; }
    rtError_t CreateContextCallBackThread();
    void DestroyContextCallBackThread();
    std::mutex callbackTheadMutex_;
    virtual rtError_t CheckStatus(const Stream* const stm = nullptr, const bool isBlockDefault = true);
    rtError_t CheckTaskSend(const TaskInfo* const workTask);
    // ctxMode_ 只是遇错模式的配置,是否出错从GetFailureError获取.
    TsStreamFailureMode GetCtxMode() const { return ctxMode_; }
    void SetCtxMode(const TsStreamFailureMode flag) { ctxMode_ = flag; }
    rtError_t SyncAllStreamToGetError();
    void ProcessReportFastRingBuffer() const;
    rtError_t TryRecycleCaptureModelResource(
        const uint32_t allocSqNum, const uint32_t ntfCnt, const CaptureModel* const excludeMdl);
    rtError_t TryRecycleCaptureModelJettyResource(const CaptureModel* const excludeMdl, JettyType type);

    void PushContextErrMsg();
    void PopContextErrMsg();
    virtual rtError_t TearDownStream(Stream* stm, bool flag = true) const;

private:
    rtError_t Init();
    rtError_t OnlineStreamInit(const rtChipType_t chipType);
    void RestoreOwnedStream(Stream* const stm);
    void FlushPendingTasksBeforeStreamTearDown(Stream* stm) const;
    rtError_t TearDownStreamAndFinalize(Stream* stm, bool flag, bool* destroyTaskRecycledStream = nullptr) const;
    rtError_t TearDownOwnedStream(Stream* stm, bool flag, bool* destroyTaskRecycledStream = nullptr) const;
    bool WillStreamBeDeletedOnTearDown(const Stream* stm) const;
    void TearDownModelsOnContextTearDown();
    rtError_t TearDownOwnedStreamsOnContextTearDown();
    rtError_t TearDownOwnedStreamsForPrimaryRelease();
    rtError_t TearDownContextStream(Stream*& stream, const char* const streamName) const;
    rtError_t TearDownContextStreamForPrimaryRelease(Stream*& stream, const char* const streamName) const;
    rtError_t TearDownStreamForPrimaryRelease(Stream*& stream, bool flag = true) const;
    rtError_t HandlePrimaryReleaseStreamTearDownFailure(
        Stream*& stream, Stream* tdStream, rtError_t error, bool destroyTaskRecycledStream) const;
    rtError_t DeleteStreamNoThrowForPrimaryRelease(Stream*& stream) const;
    void PrepareModelForDelete(Model* mdl) const;
    void DeleteModelOnContextTearDown(Model* mdl) const;
    void ReleaseModulesAfterTearDown();
    void ReleaseOverflowAddrAfterTearDown();
    void ResetCallbackAfterTearDown();
    void ReleaseDeviceAfterTearDown();
    void ResetResourceFieldsAfterTearDown();
    void LogStateTransition(
        const ContextState fromState, const ContextState toState, const char_t* const trigger) const;

    bool IsStreamNotSync(const uint32_t flags) const;

    void TryAllocFastCq();

    rtError_t CheckCaptureModelValidity(Model* const captureMdl) const;
    rtError_t SetOverflowAddr();

protected:
    std::list<Stream*> TakeOwnedStreamsForTearDown();
    Device* device_;

private:
    Stream* defaultStream_;
    Stream* onlineStream_; /* process online task */

    std::list<Stream*> streams_;
    SpinLock modelLock_;
    std::list<Model*> models_;

    std::mutex moduleLock_;
    ObjAllocator<Module*>* moduleAllocator_;

    bool isPrimary_;
    rtTaskGenCallback taskGenCallback_;
    std::atomic<uint64_t> threadRefCount_;
    Atomic<bool> isNeedDelete_;
    std::atomic<TearDownStatus> tearDownStatus_;
    std::atomic<ContextState> lifecycleState_;
    std::atomic<bool> deleteScheduled_;
    std::atomic<bool> resourcesReleased_;
    bool infMode_;
    void* overflowAddr_ = nullptr;
    uint64_t overflowAddrOffset_ = INVALID_CONTEXT_OVERFLOW_OFFSET;
    std::vector<std::pair<bool, int64_t>> sysParamOpt_;
    std::mutex sysParamOptLock_;
    Atomic<rtError_t> failureError_;
    bool containAicpuExecuteModel_ = false;
    Atomic<rtError_t> lastErr_;
    std::mutex captureLock_;
    rtStreamCaptureMode captureMode_{RT_STREAM_CAPTURE_MODE_MAX};
    uint32_t captureModeRefNum_[RT_STREAM_CAPTURE_MODE_MAX] = {0U};
    bool isForceReset_ = false;
    Atomic<bool> callBackThreadExist_;
    ContextCallBack threadCallBack_;
    std::unique_ptr<Thread> hostFuncCallBackThread_;
    uint64_t callBackThreadId_;
    TsStreamFailureMode ctxMode_ = CONTINUE_ON_FAILURE;
    std::mutex errMsgLock_;
    uint32_t userDeviceId_; // user device id
#ifndef CFG_DEV_PLATFORM_PC
    std::vector<error_message::ErrorItem> errMsg_;
#endif
public:
    std::mutex streamLock_;
};
} // namespace runtime
} // namespace cce

#endif // CCE_RUNTIME_CONTEXT_HPP
