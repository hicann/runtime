/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __CCE_RUNTIME_RUNTIME_HPP__
#define __CCE_RUNTIME_RUNTIME_HPP__

#include "runtime/rt.h"
#include "base.hpp"
#include "osal.hpp"
#include "reference.hpp"
#include "kernel.hpp"
#include "config.hpp"
#include "program.hpp"
#include "tsch_defines.h"
#include "driver.hpp"
#include "tsd_client.h"
#include "stream.hpp"
#include "label.hpp"
#include "dfx_api.hpp"
#include "base_starsv2.hpp"
#include "capability.hpp"
#include "runtime_intf.hpp"
#include "dev_info.h"

extern "C" {
drvError_t __attribute__((weak)) halTsdrvCtl(uint32_t devId, int cmd, void *param, size_t paramSize,
    void *out, size_t *outSize);
drvError_t __attribute__((weak)) halGetSocVersion(uint32_t devId, char_t *socVersion, uint32_t len);
drvError_t __attribute__((weak)) halGetChipInfo(uint32_t devId, halChipInfo *chipInfo);
void __attribute__((weak)) halSetRuntimeApiVer(int Version);
};

namespace cce {
namespace runtime {
namespace {
constexpr uint32_t DEFAULT_PROGRAM_NUMBER = 2000U;
constexpr uint32_t DEFAULT_PHY_PAGE_SIZE = 4U * 1024U;
constexpr int32_t RT_THREAD_GROUP_ID_MAX = 128;
constexpr uint32_t STMSYNC_ESCHED_MAX_THREAD_NUM = 128U;
constexpr int64_t DEFAULT_AICPU_INVALID_NUM = -1;
constexpr uint64_t DEFAULT_TILING_KEY = 0xFFFFFFFFFFFFFFFFU;
constexpr int32_t DEFAULT_DEVICE_ID = 0xFFFFFFFF;
constexpr uint16_t ADC_MODEL_EXE_TIMEOUT = 150U; // 150ms
constexpr uint32_t RT_TIMEOUT_S_TO_MS = 1000U;
constexpr uint32_t RT_TIMEOUT_MS_TO_US = 1000U;
constexpr uint64_t RT_TIMEOUT_S_TO_US = 1000000UL;
constexpr float64_t RT_TIMEOUT_US_TO_NS = 1000.0F;
constexpr int32_t DEFAULT_HOSTCPU_USER_DEVICE_ID = 65535; // used to identify the host CPU scenario
constexpr int32_t DEFAULT_HOSTCPU_LOGIC_DEVICE_ID = 0;
constexpr uint8_t PREFETCH_CNT_910_B_93 = 8U;
constexpr uint32_t RECYCLE_POOL_ISOLATION_WIDTH = 1;

constexpr uint32_t SOFT_STREAM_MAX_NUM = 33792U;
constexpr uint32_t LOG_SAVE_MODE_DEF_RUN = 33792U;

constexpr uint32_t HBM_ECC_NOTIFY_EVENT_ID = 0x80E18400U; // for ReadFaultEvent
constexpr uint32_t HBM_ECC_EVENT_ID = 0x80E01801U;
constexpr uint16_t RT_DSM_EVENT_FILTER_FLAG_EVENT_ID = 1U;
constexpr uint16_t READ_FAULT_EVENT_TIMEOUT = 1000U;

constexpr size_t NON_CPU_KERNEL_ARGS_ALIGN_SIZE = sizeof(uint64_t);
constexpr size_t CPU_KERNEL_ARGS_ALIGN_SIZE = 1U;
constexpr size_t SINGLE_NON_CPU_SYS_PARAM_SIZE = sizeof(uint64_t);

constexpr float64_t RT_STARS_TASK_KERNEL_CREDIT_SCALE_US = 4294967.296F;  // 2^32 / 1000M *1000*1000(us)
constexpr float64_t RT_STARS_TASK_KERNEL_CREDIT_SCALE_MIN = 0.001F;  // 0.001(us) = 1ns

constexpr float64_t RT_STARS_OP_TIMEOUT_THRESHOLD = 100000.0F;  // 小于100ms则开启故障快速上报，单位：us
} // namespace

enum RtMixType : std::uint8_t {
    NO_MIX = 0,
    MIX_AIC = 1,
    MIX_AIV = 2,
    MIX_AIC_AIV_MAIN_AIC = 3,
    MIX_AIC_AIV_MAIN_AIV = 4
};

enum RtTaskTimeUnitType : std::uint16_t {
    RT_TIME_UNIT_TYPE_S = 0,    // second
    RT_TIME_UNIT_TYPE_MS = 1,    // millisecond
    RT_TIME_UNIT_TYPE_US = 2,    // us
};

enum HbmRasProcStatus : std::uint16_t {
    HBM_RAS_WORKING = 0U,
    HBM_RAS_WAIT_PROC,
    HBM_RAS_NOT_SUPPORT,
    HBM_RAS_END,
};

struct TaskAbortCallbackInfo{
    TaskAbortCallbackType       type;
    rtTaskAbortCallBack         callback;
    rtsDeviceTaskAbortCallback  callbackV2;
    void                        *args;
};

rtError_t GetHardVerBySocVer(const uint32_t deviceId, int64_t &hardwareVersion);

static inline bool IsAbortError(rtError_t error)
{
    if (error == RT_ERROR_STREAM_ABORT || error == RT_ERROR_STREAM_ABORT_SEND_TASK_FAIL ||
        error == RT_ERROR_STREAM_ABORT_SYNC_TASK_FAIL || error == RT_ERROR_DEVICE_TASK_ABORT ||
        error == RT_ERROR_DEVICE_ABORT_SEND_TASK_FAIL || error == RT_ERROR_DEVICE_ABORT_SYNC_TASK_FAIL) {
        return true;
    }
    return false;
}

class Api;
class Context;
class Device;
class ApiErrorDecorator;
class Logger;
class Profiler;
class EngineObserver;
class Runtime;
class Debug;
class Driver;
class Config;
class Bitmap;
class CbSubscribe;

typedef TDT_StatusType (*FUNC_TDT_OPEN)(uint32_t, uint32_t);
typedef TDT_StatusType (*FUNC_TDT_OPEN_EX)(uint32_t, uint32_t, uint32_t);
typedef TDT_StatusType (*FUNC_TDT_CLOSE)(uint32_t);
typedef TDT_StatusType (*FUNC_TDT_CLOSE_EX)(uint32_t, uint32_t);
typedef TDT_StatusType (*FUNC_TDT_UPDATE)(uint32_t, uint32_t);
typedef TDT_StatusType (*FUNC_TDT_SET_PROF_CALLBACK)(MsprofReporterCallback callback);
typedef TDT_StatusType (*FUNC_TDT_INIT_QS)(const uint32_t, const char *);
typedef TDT_StatusType (*FUNC_TDT_INIT_FLOW_GW)(const uint32_t, const InitFlowGwInfo * const);
typedef TDT_StatusType (*FUNC_TDT_SET_ATTR)(const char_t * const, const char_t * const);
typedef TDT_StatusType (*FUNC_TDT_GET_HDC_CON_STA)(const uint32_t logicDeviceId, int32_t *hdcSessStat);
typedef TDT_StatusType (*FUNC_TDT_GET_QOS)(const int32_t, const int32_t, const uint64_t);
typedef TDT_StatusType (*FUNC_TDT_OPEN_AICPU_SD)(const uint32_t);
typedef TDT_StatusType (*FUNC_TDT_OPEN_NET_SERVICE)(const uint32_t, const NetServiceOpenArgs *);
typedef TDT_StatusType (*FUNC_TDT_CLOSE_NET_SERVICE)(const uint32_t);

Runtime *RuntimeKeeperGetRuntime();
class RuntimeRas : public ThreadRunnable {
    void Run(const void * const param) override;
};

// Runtime instance.
class Runtime : public RuntimeIntf {
public:
    enum {
        AICORE_NUM_LEVEL_AG = 1,
        AICORE_NUM_LEVEL_PG = 2
    };
    enum {
        AICORE_FREQ_LEVEL_BASE = 1,
        AICORE_FREQ_LEVEL_PRO = 2,
        AICORE_FREQ_LEVEL_PREMIUM = 3
    };

    Runtime();
    ~Runtime() override;
    rtError_t Init() override;
    // Singleton instance.
    static Runtime *Instance()
    {
#if RUNTIME_API || STATIC_RT_LIB
        if (runtime_ == nullptr) {
            runtime_ = RuntimeKeeperGetRuntime();
        }
#endif
        return runtime_;
    }

    // Get api implement.
    Api *Api_() const override
    {
        return api_;
    }

    // Get apiMbuf implement.
    ApiMbuf *ApiMbuf_() const override
    {
        return apiMbuf_;
    }

    Api *ApiImpl_() const override
    {
        return apiImpl_;
    }

    Profiler *Profiler_() const
    {
        return profiler_;
    }

    Config *Config_()
    {
    #ifndef CDQ_VECTOR_CAST
        return &config_;
    #endif
    }

    FacadeDriver &FacadeDriver_()
    {
        return facadeDriver_;
    }

    rtError_t MallocProgramAndReg(const rtDevBinary_t *const bin, Program **const newProg) const;
    rtError_t MallocProgramAndRegMixKernel(
        const void *data, const uint64_t length, Program **const newProg) const;
    rtError_t ProgramRegister(const rtDevBinary_t *bin, Program **result);
    rtError_t AddProgramToPool(Program *const prog);
    bool GetProgram(const Program *const prog);
    void PutProgram(const Program *const programPtr, bool isUnRegisterApi = false);
    rtError_t KernelRegister(Program *prog, const void *stubFunc, const char_t *stubName,
                             const void * const kernelInfoExt, const uint32_t funcMode = 0U);
    rtError_t KernelRegisterV2(Program *prog, const void *stubFunc, const char_t *stubName,
                               const char_t *kernelInfoExt, const uint32_t funcMode = 0U);
    rtError_t AllKernelRegister(Program * const prog, const bool isHostApiReg) const;
    rtError_t AllKernelRegisterV2(Program * const prog, const bool isHostApiReg = false);
    rtError_t MixKernelRegister(Program * const prog);
    const Kernel *KernelLookup(const void * const stub);
    const void *StubFuncLookup(const char_t * const name);
    rtError_t LookupAddrByFun(const void * const stubFunc, Context * const ctx, void ** const addr);
    rtError_t LookupAddrAndPrefCntWithHandle(const void * const handlePtr, const void * const kernelInfoExt,
                                             Context * const ctx, void ** const addr, uint32_t * const prefetchCnt);
    rtError_t LookupAddrAndPrefCnt(const Kernel * const kernel, Context * const ctx,
                                   void ** const addr, uint32_t * const prefetchCnt);
    rtError_t LookupAddrAndPrefCnt(const Kernel * const kernel, Context * const ctx,
                                   rtKernelDetailInfo_t * const kernelInfo);

    RefObject<Context *> *PrimaryContextRetain(const uint32_t devId);
    rtError_t GetPrimaryCtxState(const int32_t devId, uint32_t *flags, int32_t *active);
    rtError_t PrimaryContextRelease(const uint32_t devId, const bool isForceReset = false);

    Device *DeviceRetain(const uint32_t devId, const uint32_t tsId);
    void DeviceRelease(Device *dev, const bool isForceReset = false);
    Device *GetDevice(const uint32_t devId, const uint32_t tsId, bool polling = true);

    rtError_t ProfilerStop(
        const uint64_t profConfig, const int32_t numsDev, uint32_t *const deviceList, const uint64_t profSwitchHi = 0) override;
    rtError_t ProfilerStart(const uint64_t profConfig, const int32_t numsDev, uint32_t *const deviceList,
        const uint32_t cacheFlag, const uint64_t profSwitchHi = 0) override;
    rtError_t SetTsdProfCallback(const MsprofReporterCallback profReporterCallback) const;

    rtError_t SetExceptCallback(const rtErrorCallback callback) override;
    rtError_t SetTaskAbortCallBack(const char_t *regName, void *callback, void *args,
        TaskAbortCallbackType type) override;
    rtError_t TaskAbortCallBack(int32_t devId, rtTaskAbortStage_t stage, uint32_t timeout);
    rtError_t SetAicpuAttr(const char_t * const key, const char_t * const value) const override;
    rtError_t StartAicpuSd(Device * const device) const;
    rtError_t OpenNetService(const rtNetServiceOpenArgs *args) const;
    rtError_t CloseNetService() const;
    rtError_t InitAicpuQS(const uint32_t devId, const char_t * const grpName) const;
    rtError_t InitAicpuFlowGw(const uint32_t devId, const rtInitFlowGwInfo_t * const initInfo) const;
    rtError_t GetHdcConctStatus(const uint32_t devId, int32_t &hdcSessStat);
    rtError_t GetTsdQos(const uint32_t devId, uint16_t &qos) const;

    rtError_t AllocAiCpuStreamId(int32_t &id);
    void FreeAiCpuStreamId(const int32_t id);
    rtError_t SubscribeReport(const uint64_t threadId, Stream * const stm, void *evtNotify) override;
    rtError_t UnSubscribeReport(const uint64_t threadId, Stream * const stm);
    rtError_t UnSubscribeReport(Stream * const stm) override;
    rtError_t GetGroupIdByThreadId(const uint64_t threadId, uint32_t * const deviceId, uint32_t * const tsId,
        uint32_t * const groupId, const bool noLog = false);
    rtError_t GetGroupIdByStreamId(const uint32_t devId, const int32_t streamId, uint32_t * const groupId);
    rtError_t GetEventByStreamId(const uint32_t devId, const int32_t streamId, Event ** const evt);
    rtError_t GetNotifyByStreamId(const uint32_t devId, const int32_t streamId, Notify ** const notify);
    rtError_t GetCqIdByStreamId(const uint32_t devId, const int32_t streamId, uint32_t * const cqId);
    rtError_t GetSqIdByStreamId(const uint32_t devId, const int32_t streamId, uint32_t * const sqId);
    rtError_t GetThreadIdByStreamId(const uint32_t devId, const int32_t streamId, uint64_t * const threadId);
    bool IsHostFuncCbReg(const Stream * const stm) const;
    Context *GetPriCtxByDeviceId(const uint32_t deviceId, uint32_t tsId) override;
    RefObject<Context *> *GetRefPriCtx(const uint32_t deviceId, const uint32_t tsId);
    rtError_t SetTimeoutConfig(const rtTaskTimeoutType_t type, const uint64_t timeout, const RtTaskTimeUnitType timeUnitType);
    rtError_t GetElfOffset(void * const elfData, const uint32_t elfLen, uint32_t* offset) const override;
    rtError_t GetKernelBin(const char_t *const binFileName, char_t **const buffer, uint32_t *length) const override;
    rtError_t GetBinBuffer(const rtBinHandle binHandle, const rtBinBufferType_t type, void **bin,
                           uint32_t *binSize) const;
    rtError_t FreeKernelBin(char_t * const buffer) const override;
    const RtTimeoutConfig& GetTimeoutConfig() const
    {
        return timeoutConfig_;
    }

    bool IsSupportOpTimeoutMs() const
    {
        return timeoutConfig_.isOpTimeoutMs;
    }

    void RtTimeoutConfigInit()
    {
        timeoutConfig_.interval = GetKernelCreditScaleUS();
        timeoutConfig_.isInit = true;
    }

    rtError_t SetMsprofReporterCallback(MsprofReporterCallback callback);
#if RUNTIME_API
    static rtChipType_t GetChipType();
#else 
    rtChipType_t GetChipType() const;
#endif
    bool ChipIsHaveStars() const override;

    rtSocType_t GetSocType() const override;

    rtArchType_t GetArchType() const override
    {
        return archType_;
    }
    bool GetIsUserSetSocVersion() const
    {
        return isUserSetSocVersion_;
    }
    uint32_t GetTsNum() const
    {
        return tsNum_;
    }

    int64_t GetAicpuCnt() const override
    {
        return aicpuCnt_;
    }

    rtFloatOverflowMode_t GetSatMode() const
    {
        return satMode_;
    }

    void SetSatMode(rtFloatOverflowMode_t floatOverflowMode)
    {
        satMode_ = floatOverflowMode;
    }

    bool IsVirtualMachineMode() const
    {
        return isVirtualMode_;
    }

    bool GetDisableThread() const override
    {
        return disableThread_;
    }

    void SetDisableThread(bool disable)
    {
        disableThread_ = disable;
    }

    bool IsDrvBindStreamThread() const
    {
        return (halCqReportRecv == nullptr) ? false : true;
    }

    SpinLock& GetIpcMemNameLock()
    {
        return ipcMemNameLock_;
    }

    std::unordered_map<uint64_t, ipcMemInfo_t>& GetIpcMemNameMap()
    {
        return ipcMemNameMap_;
    }
    bool isRK3588HostCpu() const
    {
        return isRk3588Cpu_;
    }
    SpinLock ipcMemNameLock_;
    std::unordered_map<uint64_t, ipcMemInfo_t> ipcMemNameMap_;
    static RtMacroValue macroValue_;
    static uint32_t starsPendingMax_;
    static uint32_t maxProgramNum_;

    LabelAllocator *LabelAllocator_() const
    {
        return labelAllocator_;
    }

    bool HaveDevice() const
    {
        return isHaveDevice_;
    }

    void LockGroupId(const uint32_t groupId);
    void UnlockGroupId(const uint32_t groupId);

    /**
     * @brief process for all opened device.
     * @param processFunc process function
     * @param exitWhenError if break when once error.
     * @return error code
     */
    rtError_t ProcessForAllOpenDevice(const std::function<rtError_t(Device *dev)> &processFunc,
        const bool exitWhenError);

    rtMemType_t GetTsMemType(rtMemRequestFeature_t featureType, uint64_t memSize) override;
    static Runtime *runtime_;
    void SetBiuperfProfFlag(bool flag) override
    {
        biuperfProfFlag_ = flag;
    }

    bool GetBiuperfProfFlag() const
    {
        return biuperfProfFlag_;
    }

    void SetTsVersion(uint32_t tschVersion)
    {
        tschVersion_ = tschVersion;
    }

    uint32_t GetTsVersion() const
    {
        return tschVersion_;
    }

    void SetTilingkeyFlag(uint8_t flag)
    {
        tilingKeyFlag_ = flag;
    }

    uint8_t GetTilingkeyFlag() const
    {
        return tilingKeyFlag_;
    }

    void SetL2CacheProfFlag(bool flag) override
    {
        l2CacheProfFlag_ = flag;
    }

    bool GetL2CacheProfFlag() const
    {
        return l2CacheProfFlag_;
    }

    bool GetTrackProfFlag() const
    {
        return trackProfFlag_;
    }

    void SetWaitTimeout(uint32_t timeout)
    {
        waitTimeout_ = timeout;
    }

    uint32_t GetWaitTimeout() override
    {
        return waitTimeout_;
    }

    bool GetNpuCollectFlag() const
    {
        return isNpuCollect;
    }

    void SetProfileEnableFlag(bool isEnable) {
        if (isEnable) {
            profileEnabled_ =1U;
        } else {
            profileEnabled_ =0U;
        }
    }

    uint8_t GetProfileEnableFlag() const
    {
        return profileEnabled_;
    }

    rtError_t ChgUserDevIdToDeviceId(const uint32_t userDevId, uint32_t * const deviceId,
        bool isDeviceSetResetOp = false) const override;
    rtError_t GetUserDevIdByDeviceId(const uint32_t deviceId, uint32_t * const userDevId,
        const bool isDeviceSetResetOp = false, const bool ignoredError = false, const bool checkLog = false) const;
    void MacroInit(const rtChipType_t chipTypeValue) override;
    rtError_t BinaryLoad(const Device *const device, Program * const prog);
    rtError_t BinaryGetFunction(const Program * const prog, const uint64_t tilingKey,
                                Kernel ** const funcHandle) const;
    rtError_t BinaryGetFunctionByName(const Program * const binHandle, const char *kernelName,
                                      Kernel ** const funcHandle) const;
    rtError_t BinaryUnLoad(const Device *const device, Program * const prog) const;
    rtError_t ModelCheckArchVersion(const char_t * const omArchVersion, const rtArchType_t archType) const;
    rtError_t CheckArchVersionIsCompatibility(
        const rtArchType_t inputArchType, const rtArchType_t hardwareArchType) const;
    rtError_t SetWatchDogDevStatus(const Device *device, rtDeviceStatus deviceStatus);
    rtError_t GetWatchDogDevStatus(uint32_t deviceId, rtDeviceStatus *deviceStatus);
    rtError_t RegKernelLaunchFillFunc(const char* symbol, rtKernelLaunchFillFunc callback) override;
    rtError_t UnRegKernelLaunchFillFunc(const char* symbol) override;
    rtError_t ExeCallbackFillFunc(std::string symbol, void *cfgAddr, uint32_t size);
    rtError_t GetKernelBinByFileName(const char_t *const binFileName, char_t **const buffer, uint32_t *length) const;
    rtError_t CheckMixKernelType(const RtKernel * const kernel) const;
    rtError_t GetMixTypeAndKernelType(const RtKernel * const kernel, uint8_t &mixType, uint32_t &kernelType);
    rtError_t GetTilingValue(const std::string &kernelInfoExt, uint64_t &tilingValue) const;
    std::string GetTilingKeyFromKernel(const std::string &kernelName, uint8_t &mixType) const;
    std::string AdjustKernelName(const RtKernel * const kernel, uint8_t mixType) const;
    void ReportSoftwareSqEnableToMsprof(void) const;

    void StreamSyncEschedLock(void);
    void StreamSyncEschedUnLock(void);
    bool IsStreamSyncEsched(void) const
    {
        return isStreamSyncEsched_;
    }

    void SetStreamSyncEschedGrpID(const uint32_t id)
    {
        grpID_= id;
    }

    uint32_t GetStreamSyncEschedGrpID(void) const
    {
        return grpID_;
    }

    bool IsExiting(void) const
    {
        return isExiting_;
    }

    uint8_t GetStarsFftsDefaultKernelCredit() const
    {
        return curChipProperties_.starsDefaultKernelCredit;
    }

    uint32_t GetDefaultKernelCredit() const
    {
        return curChipProperties_.DefaultKernelCredit;
    }

    float64_t GetKernelCreditScaleUS() const
    {
        if (std::abs(curChipProperties_.KernelCreditScale - RT_STARS_TASK_KERNEL_CREDIT_SCALE_MIN) <
                   std::numeric_limits<float>::epsilon()) {
            return (timeoutConfig_.isInit ? timeoutConfig_.interval :
                                                        cce::runtime::RT_STARS_TASK_KERNEL_CREDIT_SCALE_US);
        }

        return curChipProperties_.KernelCreditScale;
    }

    uint32_t GetMaxKernelCredit() const
    {
        return curChipProperties_.MaxKernelCredit;
    }

    Context *CurrentContext() const override;
    driverType_t GetDriverType() const;

    ThreadGuard *GetThreadGuard() const
    {
        return threadGuard_;
    }

    uint32_t GetDefaultDeviceId() const
    {
        return defaultDeviceId_;
    }

    bool GetSetDefaultDevIdFlag() const
    {
        return hasSetDefaultDevId_;
    }

    void SetDefaultDeviceId(const int32_t deviceId)
    {
        const std::unique_lock<std::mutex> deviceIdLock(deviceIdMutex_);
        defaultDeviceId_ = static_cast<uint32_t>(deviceId);
        if (deviceId == DEFAULT_DEVICE_ID) {
            hasSetDefaultDevId_ = false;
        } else {
            hasSetDefaultDevId_ = true;
        }
    }
    void TryToRecyclePool() const;
    void SetGlobalErr(const rtError_t errcode) const override;
    rtError_t GetNpuDeviceCnt(int32_t &cnt) override;

    uint32_t GetRasInfoDevId() const
    {
        return rasInfo_.devId;
    }

    uint64_t GetRasInfoSysCnt() const
    {
        return rasInfo_.sysCnt;
    }

    void SetRasInfo(uint32_t devId, uint64_t sysCnt)
    {
        rasInfo_.devId = devId;
        rasInfo_.sysCnt = sysCnt;
    }

    void SetIsSupport1GHugePage(bool flag)
    {
        isSupport1GHugePage_ = flag;
    }

    bool GetIsSupport1GHugePage() const
    {
        return isSupport1GHugePage_;
    }

    ObjAllocator<RefObject<Program *>> *GetProgramAllocator() const
    {
        return programAllocator_;
    }

    uint32_t GetLatestPoolIdx() const
    {
        return latestPoolIdx_;
    }

    struct ModuleMemInfo {
        uint32_t devId;
        uint64_t memSize;
        const void* devAddr;
        Driver* drv;
        uint8_t* hostAddr;
        ModuleMemInfo(uint32_t deviceId, uint64_t memLen, const void* devAddrBase, Driver* driverEntry):
            devId(deviceId), memSize(memLen),devAddr(devAddrBase), drv(driverEntry),
            hostAddr((memSize != 0U) ? new (std::nothrow) uint8_t[memSize] : nullptr) {
        }
        ModuleMemInfo():devId(UINT32_MAX), memSize(0), devAddr(nullptr), drv(nullptr), hostAddr(nullptr) {
        }
        ~ModuleMemInfo() {
            DELETE_A(hostAddr);
        }
    };

    std::list<std::unique_ptr<ModuleMemInfo>> moduleBackupList_;
 
    rtError_t SaveModelAllDataToHost(void);
    rtError_t SaveModelAicpuInfo(const Module* const module, const uint32_t devId, Driver* curDrv);
    rtError_t SaveModelDataInfoToList(Program *prog);
    rtError_t SaveModule(void);

    rtError_t RestoreModule(void) const;
    rtError_t DeleteModuleBackupPoint(void);
    const std::vector<char> &GetDcacheLockMixOpData() const
    {
        return dcacheLockMixOpData_;
    }

    DriverFactory driverFactory_;
    KernelTable kernelTable_;
    FacadeDriver facadeDriver_;
    rtErrorCallback excptCallBack_;
    /* Config instance */
#ifndef CDQ_VECTOR_CAST
        Config config_;
#endif
    uint32_t deviceCnt = 0U;
    uint32_t userDeviceCnt = 0U;
    char inputDeviceStr[RT_SET_DEVICE_STR_MAX_LEN + 1] = {0};
    bool isSetVisibleDev = false;
    RtSetVisDevicesErrorType retType;

    std::map<int32_t, uint32_t> eschedMap_;
    uint32_t lastEschedTid_ = 0U;

    void MonitorNumAdd(uint32_t num)
    {
        monitorThreadNum_.Add(num);
    }

    void MonitorNumSub(uint32_t num)
    {
        monitorThreadNum_.Sub(num);
    }

    void SetConnectUbFlag(bool flag) {
        connectUbFlag_ = flag;
    }
    bool GetConnectUbFlag() const
    {
        return connectUbFlag_;
    }
    void SetSimtWarpStkSize(uint32_t simtWarpStkSize) {
        simtWarpStkSize_ = simtWarpStkSize;
    }

    uint32_t GetSimtWarpStkSize() const
    { 
        return simtWarpStkSize_;
    }

    void SetSimtDvgWarpStkSize(uint32_t simtDvgWarpStkSize) {
        simtDvgWarpStkSize_ = simtDvgWarpStkSize;
    }
    
    uint32_t GetSimtDvgWarpStkSize() const
    {
        return simtDvgWarpStkSize_;
    }

    rtError_t CreateReportRasThread();
    void DestroyReportRasThread();
    void ReportRasRun();
    HbmRasProcStatus GetHbmRasProcFlag() const
    {
        return hbmRasProcFlag_;
    }

    // 目前只会在aclInit里面调用一次
    void SetDeviceCustomerStackSize(uint32_t val)
    {
        if (val > KERNEL_STACK_SIZE_32K) {
            val = (val + KERNEL_STACK_SIZE_16K - 1U) / KERNEL_STACK_SIZE_16K * KERNEL_STACK_SIZE_16K;
            deviceCustomerStackSize_ = val;
        }
    }

    uint32_t GetDeviceCustomerStackSize() const
    {
        return deviceCustomerStackSize_;
    }

    std::mutex& GetSimtStackMutex()
    {
        return simtStackMutex_;
    }
    void SetIsUserSetSocVersion(bool flag)
    {
        isUserSetSocVersion_ = flag;
    }
    rtError_t SubscribeCallback(const uint64_t threadId, Stream *stm, void *evtNotify);
    bool JudgeNeedSubscribe(const uint64_t threadId, Stream *stm, const uint32_t deviceId);
    void AllocDfxId(uint32_t &dfxId) {
        dfxId = dfxId_.FetchAndAdd(1U);
        dfxId = dfxId & 0x7FFFFFFFU;
        return;
    }
    rtError_t startAicpuExecutor(const uint32_t devId, const uint32_t tsId);
    rtError_t StopAicpuExecutor(const uint32_t devId, const uint32_t tsId, const bool isQuickClose = false) const;
    rtError_t InitOpExecTimeout(Device *dev);

private:
    void MacroInitDefault(RtMacroValue &value) const;
    void TsdClientInit();
    void LoadFunction(void *const handlePtr, const char_t * const libSoName);
    rtError_t GetAicoreNumByLevel(const rtChipType_t chipTypeValue, int64_t &aicoreNumLevel, uint32_t &aicoreNum);
    void CheckVirtualMachineMode(uint32_t &aicoreNum, int64_t &vmAicoreNum);
    void InitSocTypeFrom910BVersion(int64_t hardwareVersion);

    int32_t GetProfDeviceNum(const uint64_t profMask);
    rtError_t SetSocTypeByChipType(int64_t hardwareVersion, int64_t aicoreNumLevel, int64_t vmAicoreNum);
    bool IsSupportVisibleDevices() const;
    rtError_t InitChipAndSocType();
    rtError_t InitApiImplies();
    rtError_t InitLogger();
    rtError_t InitApiProfiler(Api * const apiObj);
    rtError_t InitApiErrorDecorator(Api * const apiObj);
    rtError_t InitThreadGuard();
    rtError_t InitStreamObserver();
    rtError_t InitAicpuStreamIdBitmap();
    rtError_t InitCbSubscribe();
    rtError_t InitProgramAllocator();
    rtError_t InitLabelAllocator();
    rtError_t InitSetRuntimeVersion();
    void InitNpuCollectPath();
    void InitStreamSyncMode();
    void NotifyProcWhenNewDevice(const uint32_t devId);
    void NotifyProcWhenReleaseDevice(const uint32_t devId) const;
    void MsProfNotifyWhenSetDevice(const uint32_t devId) const;
    void InitKernel(
        Program * const prog, const void * const kernelInfoExt, const uint8_t mixType, Kernel *kernelPtr);
    void BuildMixKernel(Program * const prog, const void * const kernelInfoExt, Kernel *kernelPtr, const uint8_t idx,
        bool isAic) const;
    void InitAtrace(Device* dev, TraHandle &curAtraceHandle) const;
    void KernelSetDfx(Program * const prog, const void * const kernelInfoExt, Kernel *kernelPtr) const;
    rtError_t JudgeOffsetByMixType(Program * const prog, const void * const kernelInfoExt, uint8_t &mixType,
                                   rtKernelContent *info1, rtKernelContent *info2);
    rtError_t GetOffsetByCustomKernelType(Program *prog, const uint32_t kernelType,
        const void * const kernelInfoExt, rtKernelContent *info1, rtKernelContent *info2) const;
    rtError_t CheckSetKernelAndMixType(
        const RtKernel * const kernel, uint8_t& mixType, uint32_t& kernelType, std::string& kernelName);
    rtError_t CheckSetKernelAndMixTypeV2(const RtKernel * const kernel, uint8_t& mixType,
        uint32_t& kernelType, uint64_t& tilingValue, std::string& kernelName);
    bool IsFoundKernelByTilingKey(Program * const prog, const RtKernel * const kernel,
        const uint64_t tilingValue, const uint8_t mixType);
    rtError_t AllocAndAddKernel(Program *prog, Kernel **kernelPtr, const RtKernelCombine& kernelCombine,
        const void * const kernelInfoExt, const char_t *stubName, const uint32_t funcModeInner);
    rtError_t AllocAndAddKernelV2(Program *prog, Kernel **kernelPtr, const RtKernelCombine& kernelCombine,
        const std::string& kernelName);
    void PrimaryContextCallBack(const Context * const ctx, const uint32_t devId);
    void PrimaryContextCallBackAfterTeardown(const uint32_t devId) const;
    void ProcContexRelease(Context *const ctx, const uint32_t devId, const bool isForceReset);
    Device *DeviceAddObserver(Device *dev);
    rtError_t RuntimeTrackProfilerStart(const uint64_t profConfig, int32_t numsDev,
        const uint32_t * const deviceList, const uint32_t cacheFlag);
    rtError_t RuntimeApiProfilerStart(const uint64_t profConfig, int32_t numsDev, const uint32_t * const deviceList);
    rtError_t RuntimeTrackProfilerStop(const uint64_t profConfig, int32_t numsDev, const uint32_t * const deviceList);
    rtError_t RuntimeApiProfilerStop(const uint64_t profConfig, int32_t numsDev, const uint32_t * const deviceList);
    rtError_t TsProfilerStart(const uint64_t profConfig, int32_t numsDev, const uint32_t * const deviceList);
    rtError_t TsProfilerStop(const uint64_t profConfig, int32_t numsDev, const uint32_t * const deviceList);
    rtError_t AiCpuProfilerStart(
        const uint64_t profConfig, int32_t numsDev, const uint32_t *const deviceList, const uint64_t profSwitchHi = 0);
    rtError_t AiCpuProfilerStop(
        const uint64_t profConfig, int32_t numsDev, const uint32_t *const deviceList, const uint64_t profSwitchHi = 0);
    rtError_t HandleAiCpuProfiling(
        const uint64_t profConfig, const uint32_t devId, const bool isStart, const uint64_t profSwitchHi = 0) const;
    rtError_t RuntimeProfileLogStart(const uint64_t profConfig, const int32_t numsDev, uint32_t * const deviceList);
    rtError_t RuntimeProfileLogStop(const uint64_t profConfig, const int32_t numsDev, const uint32_t * const deviceList);
    bool isConfigForProfileLog(const uint64_t profConfig) const;

    void OpenDeviceProfiling(const uint32_t devId, Device * const dev);
    void TsTimelineStop(const uint64_t profConfig, bool &needCloseTimeline, Device *dev) const;
    void TsTimelineStop(const uint64_t profConfig, uint64_t &type, Device * const dev) const;
    void AicMetricStop(const uint64_t profConfig, uint64_t &type, const Device * const dev) const;
    void AivMetricStop(const uint64_t profConfig, uint64_t &type, const Device * const dev) const;
    void HwtsLogStop(const uint64_t profConfig, uint64_t &type, const Device * const dev) const;
    void AiCpuTraceStop(const uint64_t profConfig, uint64_t &type, const Device * const dev) const;
    void AiCpuModelTraceStop(const uint64_t profConfig, uint64_t &type, const Device * const dev) const;
    void TsTimelineStart(const uint64_t profConfig, uint64_t &type, Device * const dev) const;
    void TsTimelineStart(const uint64_t profConfig, bool &needOpenTimeline, Device * const dev) const;
    void AicMetricStart(const uint64_t profConfig, uint64_t &type, const Device * const dev) const;
    void AivMetricStart(const uint64_t profConfig, uint64_t &type, const Device * const dev) const;
    void HwtsLogStart(const uint64_t profConfig, uint64_t &type, const Device * const dev) const;
    void AiCpuTraceStart(const uint64_t profConfig, uint64_t &type, const Device * const dev) const;
    void AiCpuModelTraceStart(const uint64_t profConfig, uint64_t &type, const Device * const dev) const;
    rtError_t isOperateAllDevice(int32_t * const numsDev, bool &flag);
    rtError_t CheckStaticKernelName(const RtKernel * const kernels, const uint32_t kernelCount,
                                    const bool isHostApiRegister, bool &staticKernel) const;
    rtError_t CheckKernelsName(const RtKernel * const kernels, const uint32_t kernelCount,
                               const bool isHostApiRegister, bool &staticKernel) const;
    rtError_t GetVisibleDevices();
    bool IsNeedChangeDeviceId(const uint32_t userDevId, const bool isDeviceSetResetOp) const;
    rtError_t GetArchVersion(const char_t * const omArchVersion, rtArchType_t &omArchType) const;
    void ReadStreamSyncModeFromConfigIni(void);
    rtError_t InitAiCpuCnt();
    void ParseHostCpuModelInfo();
    rtError_t InitSocType();
    bool CheckHaveDevice();
    rtError_t WaitMonitorExit() const;
    rtError_t GetEnvPath(std::string &binaryPath) const;
    rtError_t GetDcacheLockMixOpPath(std::string &dcacheLockMixOpPath) const;
    void ReportHBMRasProc();
    void ProcHBMRas(const uint32_t devId);
    void ReportPageFaultProc();
    void ProcPageFault(Device * const device, const uint32_t value);

    void SetChipType(rtChipType_t chipType)
    {
        chipType_ = chipType;
    }

    void SetSocType(rtSocType_t socType)
    {
        socType_ = socType;
    }

    void SetArchType(rtArchType_t archType)
    {
        archType_ = archType;
    }

    void SetAicpuCnt(int64_t aicpuCnt)
    {
        aicpuCnt_ = aicpuCnt;
    }

    void SetTrackProfFlag(bool flag)
    {
        trackProfFlag_ = flag;
    }

    void SetNpuCollectFlag(bool flag)
    {
        isNpuCollect = flag;
    }

    void FindDcacheLockOp();
    uint32_t *deviceInfo{nullptr};
    uint32_t *userDeviceInfo{nullptr};
    char availableDeviceStr[RT_SET_DEVICE_STR_MAX_LEN + 1] = {0};
    uint32_t workingDev_ = 0U;

    Api *api_;
    ApiMbuf *apiMbuf_;

    Api *apiImpl_;
    ApiMbuf *apiImplMbuf_;

    RefObject<Context *> priCtxs_[RT_MAX_DEV_NUM][RT_MAX_TS_NUM];
    RefObject<Device *> devices_[RT_MAX_DEV_NUM + 1][RT_MAX_TS_NUM];  // Last one is stub device
    uint32_t deviceCustomerStackSize_{KERNEL_STACK_SIZE_32K};  // 全局共享，所有device生效，向上取整到16KB对齐
    ObjAllocator<RefObject<Program *>> *programAllocator_;

    ApiErrorDecorator *apiError_;
    Logger *logger_;
    Profiler *profiler_;
    EngineObserver *streamObserver_;
    Bitmap *aicpuStreamIdBitmap_;
    CbSubscribe *cbSubscribe_;
    rtChipType_t chipType_;
    rtSocType_t socType_;
    int64_t aicpuCnt_ = DEFAULT_AICPU_INVALID_NUM;
    rtArchType_t archType_;
    rtFloatOverflowMode_t satMode_ = RT_OVERFLOW_MODE_SATURATION;
    SpinLock profConfLock_;
    uint32_t tsNum_;
    uint64_t apiProfilingType_;
    uint64_t trackProfilingType_;
    uint64_t profileLogType_;
    bool profileLogModeEnable_;
    uint64_t devNeedSendProf_[RT_MAX_DEV_NUM + 1][RT_MAX_TS_NUM];  // Last one is stub device
    uint64_t devNeedSendProfSwitchHi_[RT_MAX_DEV_NUM + 1][RT_MAX_TS_NUM];  // Last one is stub device
    void *tsdClientHandle_;
    FUNC_TDT_OPEN  tsdOpen_;
    FUNC_TDT_OPEN_EX  tsdOpenEx_;
    FUNC_TDT_CLOSE tsdClose_;
    FUNC_TDT_CLOSE_EX tsdCloseEx_;
    FUNC_TDT_OPEN_AICPU_SD tsdOpenAicpuSd_;
    FUNC_TDT_INIT_QS tsdInitQs_;
    FUNC_TDT_INIT_FLOW_GW tsdInitFlowGw_;
    FUNC_TDT_UPDATE tsdHandleAicpuProfiling_; // for open aicpu profiling
    FUNC_TDT_SET_PROF_CALLBACK tsdSetProfCallback_; // for set profiling callback
    FUNC_TDT_SET_ATTR tsdSetAttr_; // for set tsd attr and mode
    FUNC_TDT_GET_HDC_CON_STA tsdGetHdcConctStatus_; // for get hdc connection status
    FUNC_TDT_GET_QOS tsdGetCapability_;
    FUNC_TDT_OPEN_NET_SERVICE tsdOpenNetService_; // for hccl dlopen
    FUNC_TDT_CLOSE_NET_SERVICE tsdCloseNetService_;

    uint32_t virAicoreNum_;
    bool isVirtualMode_ = false;
    bool isExiting_ = false;
    LabelAllocator *labelAllocator_;
    bool disableThread_ = false;
    bool isHaveDevice_ = false;

    RtTimeoutConfig timeoutConfig_;
    bool biuperfProfFlag_ = false;
    bool l2CacheProfFlag_ = false;
    bool trackProfFlag_ = false;
    uint32_t waitTimeout_ = 0U; // defualt event wait timeout 0s(never timeout)
    bool disableWaitPrep_ = false;
    uint8_t profileEnabled_ = 0U;
    bool isNpuCollect = false;  // Corresponding to the environment NPU_COLLECT_PATH

    uint32_t grpID_ = UINT32_MAX;
    bool isStreamSyncEsched_ = false;
    std::mutex StreamSyncEschedMutex_;
    rtDeviceStatus watchDogDevStatus_[RT_MAX_DEV_NUM + 1][RT_MAX_TS_NUM];
    std::mutex watchDogDevStatusMutex_;
    std::map<std::string, rtKernelLaunchFillFunc> callbackMap_;
    std::mutex mapMutex_;
    std::map<std::string, TaskAbortCallbackInfo> taskAbortCallbackMap_;
    std::mutex taskAbortMutex_;
    uint32_t tschVersion_ = 0U;
    uint8_t tilingKeyFlag_ = UINT8_MAX;
    ThreadGuard *threadGuard_;
    std::mutex deviceIdMutex_;
    uint32_t defaultDeviceId_ = 0xFFFFFFFFU;
    bool hasSetDefaultDevId_ = false;
    bool isSupport1GHugePage_ = false;
    bool isRk3588Cpu_ = false;
    RtHbmRasInfo rasInfo_ = {};
    uint32_t latestPoolIdx_ = 0;

    std::vector<char> dcacheLockMixOpData_;
    bool connectUbFlag_ = false;
    std::mutex simtStackMutex_;
    uint32_t simtWarpStkSize_{RT_KIS_SIMT_WARP_STK_SIZE};
    uint32_t simtDvgWarpStkSize_{RT_KIS_SIMT_DVG_WARP_STK_SIZE};

    std::unique_ptr<Thread> hbmRasThread_;
    std::mutex hbmRasMtx_;
    std::atomic<bool> hbmRasThreadRunFlag_{false};
    std::atomic<HbmRasProcStatus> hbmRasProcFlag_{HBM_RAS_WORKING};
    bool pageFaultSupportFlag_ = true;
    Atomic<uint32_t> monitorThreadNum_{0U};
    bool isUserSetSocVersion_ = false;
    RuntimeRas ras_;

    /* starsv2 dfx task id in current process */
    Atomic<uint32_t> dfxId_{0U};

    std::unordered_map<rtChipType_t, DevProperties> propertiesMap_;
    DevProperties curChipProperties_;
};
}
}

#endif  // __CCE_RUNTIME_RUNTIME_HPP__
