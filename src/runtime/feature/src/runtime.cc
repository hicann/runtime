/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "runtime.hpp"
#include <fstream>
#include "mmpa/mmpa_api.h"
#include "driver/ascend_hal.h"
#include "api_impl.hpp"
#include "api_impl_mbuf.hpp"
#include "context.hpp"
#include "ctrl_stream.hpp"
#include "engine_stream_observer.hpp"
#include "raw_device.hpp"
#include "program.hpp"
#include "module.hpp"
#include "api_error.hpp"
#include "logger.hpp"
#include "profiler.hpp"
#include "api_profile_decorator.hpp"
#include "api_profile_log_decorator.hpp"
#include "stub_task.hpp"
#include "driver.hpp"
#include "subscribe.hpp"
#include "base.hpp"
#include "device_state_callback_manager.hpp"
#include "prof_ctrl_callback_manager.hpp"
#include "errcode_manage.hpp"
#include "error_message_manage.hpp"
#include "toolchain/prof_acl_api.h"
#include "thread_local_container.hpp"
#include "inner_thread_local.hpp"
#include "prof_api.h"
#include "profiling_agent.hpp"
#include "task_submit.hpp"
#include "atrace_log.hpp"
#include "platform/platform_info.h"
#include "stream_state_callback_manager.hpp"
#include "memory_pool.hpp"
#include "soc_info.h"
#include "runtime_keeper.h"
#include "utils.h"
#include "device.hpp"
#include "api_impl_creator.hpp"
#include "dev_info_manage.h"
#include "global_state_manager.hpp"
#include "kernel.hpp"
#include "printf.hpp"

namespace cce {
namespace runtime {
namespace {
constexpr uint32_t TSD_OK = 0U;
constexpr int64_t RTS_INVALID_HARDWARE_VERSION = 0xFFFFFFFFFFFFFFFFLL;
constexpr int32_t MAX_REPORT_TIMEOUT_CNT = 36;

constexpr uint32_t  TSD_SUBPROCESS_NUM_EXCEED_THE_LIMIT = 100U;
constexpr uint32_t  TSD_SUBPROCESS_BINARY_FILE_DAMAGED = 101U;
constexpr uint32_t  TSD_DEVICE_DISCONNECTED = 102U;
constexpr uint32_t  TSD_DRV_HDC_SEND_FILE_FAILED = 103U;
constexpr uint32_t  TSD_ADD_AICPUSD_TO_CGROUP_FAILED = 104;
constexpr uint32_t  TSD_OPEN_NOT_SUPPORT_FOR_MDC = 200U;
constexpr uint32_t  MONITOR_THREAD_MAX_WAIT_TIMES = 10U;
constexpr uint32_t  TSD_CLOSE_EX_FLAG_QUICK_CLOSE = 1U;
constexpr uint32_t  PAGE_FAULT_CNT_THRESHOLD = 100U;
constexpr uint64_t  PAGE_FAULT_TIME_THRESHOLD = 2000U;
constexpr int32_t FEATURE_TRSDRV_SQ_DEVICE_MEM_PRIORITY = 0;
constexpr uint32_t BASE_AICPU_STREAM_ID = 1024U;
constexpr uint32_t KERNEL_INFO_EXT_MAX = 4096U;
enum AiCpuProfilingConfig : uint32_t {
    PROFILING_FEATURE_SWITCH = 0U,       // bit0 means profiling start or profiling stop
    PROFILING_FEATURE_KERNEL_MODE = 1U,  // bit1 means profiling mode of kernel
    PROFILING_FEATURE_MODEL_MODE = 2U,   // bit2 means profiling mode of model
    PROFILING_FEATURE_TIME = 3U,         // bit3 means l0
    PROFILING_FEATURE_TIME_L1 = 4U,      // bit4 means l1
    PROFILING_FEATURE_TIME_L2 = 5U       // bit5 means l2
};
}

TIMESTAMP_EXTERN(rtBinaryLoad_DevMemAlloc);
TIMESTAMP_EXTERN(rtBinaryLoad_MemCopySync);

static const std::unordered_map<std::string, rtArchType_t> archMap_ = {
    {"ARCH_BEGIN", ARCH_BEGIN},
    {"0", ARCH_V100},
    {"1", ARCH_V200},
    {"2", ARCH_V300},
    {"3", ARCH_C100},
    {"4", ARCH_C220},
    {"5", ARCH_M100},
    {"6", ARCH_M200},
    {"7", ARCH_M201},
    {"8", ARCH_T300},
    {"9", ARCH_N350},
    {"10", ARCH_M300},
    {"11", ARCH_M310},
    {"12", ARCH_S200},
    {"13", ARCH_S202},
    {"14", ARCH_M510},
    {"15", ARCH_END}
};

RtMacroValue Runtime::macroValue_ = {};
uint32_t Runtime::starsPendingMax_ = 0U;
uint32_t Runtime::maxProgramNum_ = 0U;

Runtime::Runtime() : RuntimeIntf()
{
    cbSubscribe_ = nullptr;
    excptCallBack_ = nullptr;
    api_ = nullptr;
    apiMbuf_ = nullptr;
    apiImpl_ = nullptr;
    apiImplMbuf_ = nullptr;
    logger_ = nullptr;
    apiError_ = nullptr;
    profiler_ = nullptr;
    streamObserver_ = nullptr;
    aicpuStreamIdBitmap_ = nullptr;
    programAllocator_ = nullptr;
    threadGuard_ = nullptr;

    SetChipType(CHIP_BEGIN);
    socType_ = SOC_BEGIN;
    archType_ = ARCH_BEGIN;
    tsNum_ = 1U;
    apiProfilingType_ = 0U;
    trackProfilingType_ = 0U;
    profileLogType_ = 0U;
    profileLogModeEnable_ = false;
    for (uint32_t i = 0U; i <= RT_MAX_DEV_NUM; i++) {
        for (uint32_t j = 0U; j < RT_MAX_TS_NUM; j++) {
            devNeedSendProf_[i][j] = 0ULL;
            devNeedSendProfSwitchHi_[i][j] = 0ULL;
            watchDogDevStatus_[i][j] = RT_DEVICE_STATUS_NORMAL;
        }
    }
    tsdClientHandle_ = nullptr;
    tsdOpen_ = nullptr;
    tsdOpenEx_ = nullptr;
    tsdClose_ = nullptr;
    tsdCloseEx_ = nullptr;
    tsdInitQs_ = nullptr;
    tsdInitFlowGw_ = nullptr;
    tsdHandleAicpuProfiling_ = nullptr;
    tsdSetProfCallback_ = nullptr;
    virAicoreNum_ = 0U;
    labelAllocator_ = nullptr;
    tsdSetAttr_ = nullptr;
    tsdGetCapability_ = nullptr;
    tsdGetHdcConctStatus_ = nullptr;
    tsdOpenNetService_ = nullptr;
    tsdCloseNetService_ = nullptr;
    timeoutConfig_.isCfgOpWaitTaskTimeout = false;
    timeoutConfig_.isCfgOpExcTaskTimeout = false;
    timeoutConfig_.opWaitTaskTimeout = 0ULL;
    timeoutConfig_.opExcTaskTimeout = 0ULL;
    isHaveDevice_ = false;
    profileEnabled_ =0U;
    rasInfo_ = {.devId = MAX_UINT32_NUM, .eventId = 0U, .sysCnt = 0U};
}

Runtime *Runtime::runtime_ = nullptr;

/*
 *   aicore level  1:32    2:30
 *   Ascend910  freq(MHz)
 *   CORE_LEVEL   FREQ_LEVEL   SOC
 *   1            1          Ascend910A          1.0Ghz@32core
 *   1            2          Ascend910ProA       1.1Ghz@32core
 *   1            3          Ascend910PremiumA   1.22Ghz@32core
 *   2            1          Ascend910B          0.9Ghz@30core
 *   2            2          Ascend910ProB       1.15Ghz@30core
 */
void Runtime::SocTypeInit(const int64_t aicoreNumLevel, const int64_t aicoreFreqLevel)
{
    switch (aicoreNumLevel) {
        case AICORE_NUM_LEVEL_AG:
            if (aicoreFreqLevel == AICORE_FREQ_LEVEL_BASE) {
                socType_ = SOC_ASCEND910A;
            } else if (aicoreFreqLevel == AICORE_FREQ_LEVEL_PRO) {
                socType_ = SOC_ASCEND910ProA;
            } else if (aicoreFreqLevel == AICORE_FREQ_LEVEL_PREMIUM) {
                socType_ = SOC_ASCEND910PremiumA;
            } else {
                socType_ = SOC_END;
            }
            break;
        case AICORE_NUM_LEVEL_PG:
            if (aicoreFreqLevel == AICORE_FREQ_LEVEL_BASE) {
                socType_ = SOC_ASCEND910B;
            } else if (aicoreFreqLevel == AICORE_FREQ_LEVEL_PRO) {
                socType_ = SOC_ASCEND910ProB;
            } else {
                socType_ = SOC_END;
            }
            break;
        default:
            socType_ = SOC_END;
            break;
    }
}

rtSocType_t Runtime::GetSocType() const
{
    if (GlobalContainer::GetSocType() != SOC_BEGIN) {
        return GlobalContainer::GetSocType();
    }
    return socType_;
}

rtChipType_t Runtime::GetChipType() const
{
    if (GlobalContainer::GetSocType() != SOC_BEGIN) {
        return GlobalContainer::GetRtChipType();
    }
    return chipType_;
}

bool Runtime::ChipIsHaveStars() const
{
    const rtChipType_t chipType = GetChipType();
    bool ret = false;
    auto it = propertiesMap_.find(chipType);
    if (it != propertiesMap_.end()) {
        ret = it->second.isStars;
    }
    return ret;
}

void Runtime::MacroInitDefault(RtMacroValue &value) const
{
    value.maxPersistTaskNum = 15000U;
    value.maxTaskNumPerStream = 1018U;
    value.maxSinkTaskNum = 15000U;
    value.maxSupportTaskNum = MAX_UINT16_NUM;
    value.pctraceFileLength = (4U * 1024U) + 6U;
    value.pctraceFileHead = 32U;
    value.maxAllocStreamNum = 56U;
    value.stubEventCount = 512U;
    value.maxReportTimeoutCnt = MAX_REPORT_TIMEOUT_CNT;
    value.maxModelNum = 1024U;
    value.baseAicpuStreamId = BASE_AICPU_STREAM_ID;
}

void Runtime::MacroInit(const rtChipType_t chipTypeValue)
{
    macroValue_.rtsqDepth = 4096U;
    DevDynInfoProcFunc func{};
    const rtError_t ret = GET_DEV_INFO_PROC_FUNC(chipTypeValue, func);
    if ((ret != RT_ERROR_NONE) || (func.macroInitFunc == nullptr)) {
        RT_LOG(RT_LOG_WARNING,
            "can not get chip[%d] reg info, ret[%d], use default value.",
            static_cast<int32_t>(chipTypeValue),
            ret);
        MacroInitDefault(macroValue_);
        return;
    }
    func.macroInitFunc(socType_, macroValue_);
    starsPendingMax_ = macroValue_.rtsqDepth * 3U / 4U;
    return;
}

void Runtime::TsdClientInit()
{
#if (!defined CFG_DEV_PLATFORM_PC)
    // unsupport in lhisi & nezha
    if (!isHaveDevice_ ||
        !IS_SUPPORT_CHIP_FEATURE(chipType_, RtOptionalFeatureType::RT_FEATURE_DEVICE_HAS_TS_DEAMON)) {
        return;
    }
    constexpr const char_t *libSoName = "libtsdclient.so";
    // global so should be set nodelete flag in case of core dump in dlclose func at singleton destructor
    constexpr const int32_t flags = static_cast<int32_t>(static_cast<uint32_t>(MMPA_RTLD_LAZY) |
        static_cast<uint32_t>(MMPA_RTLD_NODELETE));
    void * const handlePtr = mmDlopen(libSoName, flags);
    if (handlePtr == nullptr) {
        const char_t * const dlRet = mmDlerror();
        RT_LOG_CALL_MSG(ERR_MODULE_AICPU, "Open %s failed, dlerror() = %s", libSoName, dlRet);
        return;
    }

    FUNC_TDT_OPEN openFunc = nullptr;
    FUNC_TDT_OPEN_EX openFuncEx = nullptr;

    if (IS_SUPPORT_CHIP_FEATURE(chipType_, RtOptionalFeatureType::RT_FEATURE_DEVICE_TS_DEAMON_OPEN_EX)) {
        openFuncEx = RtPtrToPtr<FUNC_TDT_OPEN_EX, void *>(mmDlsym(handlePtr, "TsdOpenEx"));
        if (openFuncEx == nullptr) {
            RT_LOG_CALL_MSG(ERR_MODULE_AICPU, "No TsdOpenEx symbol found in %s.", libSoName);
            (void)mmDlclose(handlePtr);
            return;
        }
    } else {
        openFunc = RtPtrToPtr<FUNC_TDT_OPEN>(mmDlsym(handlePtr, "TsdOpen"));
        if (openFunc == nullptr) {
            RT_LOG_CALL_MSG(ERR_MODULE_AICPU, "No TsdOpen symbol found in %s.", libSoName);
            (void)mmDlclose(handlePtr);
            return;
        }
    }

    FUNC_TDT_CLOSE const closeFunc = RtPtrToPtr<FUNC_TDT_CLOSE>(mmDlsym(handlePtr, "TsdClose"));
    if (closeFunc == nullptr) {
        RT_LOG_CALL_MSG(ERR_MODULE_AICPU, "No TsdClose symbol found in %s.", libSoName);
        (void)mmDlclose(handlePtr);
        return;
    }

    FUNC_TDT_CLOSE_EX const closeFuncEx = RtPtrToPtr<FUNC_TDT_CLOSE_EX>(mmDlsym(handlePtr, "TsdCloseEx"));
    if (closeFuncEx == nullptr) {
        RT_LOG_CALL_MSG(ERR_MODULE_AICPU, "No TsdCloseEx symbol found in %s.", libSoName);
    }

    FUNC_TDT_UPDATE const updateFunc = RtPtrToPtr<FUNC_TDT_UPDATE>(mmDlsym(handlePtr, "UpdateProfilingMode"));
    if (updateFunc == nullptr) {
        // if runtime cloud not find new api, allowed continue set device and not dlclose
        RT_LOG(RT_LOG_WARNING, "No UpdateProfilingMode symbol found in %s.", libSoName);
    }

    FUNC_TDT_SET_PROF_CALLBACK const setProfCallback =
            RtPtrToPtr<FUNC_TDT_SET_PROF_CALLBACK>(mmDlsym(handlePtr, "TsdSetMsprofReporterCallback"));
    if (setProfCallback == nullptr) {
        // if runtime cloud not find new api, allowed continue set device and not dlclose
        RT_LOG(RT_LOG_WARNING, "No TsdSetMsprofReporterCallback symbol found in %s.", libSoName);
    }

    FUNC_TDT_INIT_QS const initQsFunc = RtPtrToPtr<FUNC_TDT_INIT_QS>(mmDlsym(handlePtr, "TsdInitQs"));
    if (initQsFunc == nullptr) {
        // if runtime cloud not find new api, allowed continue set device and not dlclose
        RT_LOG(RT_LOG_WARNING, "No TsdInitQs symbol found in %s.", libSoName);
    }
    FUNC_TDT_SET_ATTR const setAttrFunc = RtPtrToPtr<FUNC_TDT_SET_ATTR>(mmDlsym(handlePtr, "TsdSetAttr"));
    if (setAttrFunc == nullptr) {
        // if runtime can not find callback, allowed continue
        RT_LOG(RT_LOG_WARNING, "No SetAttr symbol found in %s.", libSoName);
    }
    FUNC_TDT_GET_QOS const capabilityGetFunc = RtPtrToPtr<FUNC_TDT_GET_QOS>(mmDlsym(handlePtr,
        "TsdCapabilityGet"));
    if (capabilityGetFunc == nullptr) {
        // if runtime cloud not find new api, allowed continue
        RT_LOG(RT_LOG_WARNING, "No TsdCapabilityGet symbol found in %s.", libSoName);
    }

    FUNC_TDT_OPEN_AICPU_SD const openAicpuSdFunc = RtPtrToPtr<FUNC_TDT_OPEN_AICPU_SD>(mmDlsym(handlePtr,
        "TsdOpenAicpuSd"));
    if (openAicpuSdFunc == nullptr) {
        RT_LOG(RT_LOG_WARNING, "No TsdOpenAicpuSd symbol found in %s.", libSoName);
    }

    FUNC_TDT_OPEN_NET_SERVICE const openNetServiceFunc = RtPtrToPtr<FUNC_TDT_OPEN_NET_SERVICE>(mmDlsym(handlePtr,
        "TsdOpenNetService"));
    if (openNetServiceFunc == nullptr) {
        RT_LOG(RT_LOG_WARNING, "No TsdOpenNetService symbol found in %s.", libSoName);
    }

    FUNC_TDT_CLOSE_NET_SERVICE const closeNetServiceFunc = RtPtrToPtr<FUNC_TDT_CLOSE_NET_SERVICE>(mmDlsym(handlePtr,
        "TsdCloseNetService"));
    if (closeNetServiceFunc == nullptr) {
        RT_LOG(RT_LOG_WARNING, "No TsdCloseNetService symbol found in %s.", libSoName);
    }

    LoadFunction(handlePtr, libSoName);

    tsdClientHandle_ = handlePtr;
    tsdOpenEx_ = openFuncEx;
    tsdOpen_ = openFunc;
    tsdClose_ = closeFunc;
    tsdCloseEx_ = closeFuncEx;
    tsdInitQs_ = initQsFunc;
    tsdHandleAicpuProfiling_ = updateFunc;
    tsdSetProfCallback_ = setProfCallback;
    tsdSetAttr_ = setAttrFunc;
    tsdGetCapability_ = capabilityGetFunc;
    tsdOpenAicpuSd_ = openAicpuSdFunc;
    tsdOpenNetService_ = openNetServiceFunc;
    tsdCloseNetService_ = closeNetServiceFunc;
#endif
}

void Runtime::LoadFunction(void * const handlePtr, const char_t * const libSoName)
{
    FUNC_TDT_INIT_FLOW_GW const tsdInitFlowGwFunc =
            RtPtrToPtr<FUNC_TDT_INIT_FLOW_GW>(mmDlsym(handlePtr, "TsdInitFlowGw"));
    if (tsdInitFlowGwFunc == nullptr) {
        // if runtime cloud not find new api, allowed continue set device and not dlclose
        RT_LOG(RT_LOG_WARNING, "No TsdInitFlowGw symbol found in %s.", libSoName);
    }
    tsdInitFlowGw_ = tsdInitFlowGwFunc;

    FUNC_TDT_GET_HDC_CON_STA const getHdcConctStatus =
            RtPtrToPtr<FUNC_TDT_GET_HDC_CON_STA>(mmDlsym(handlePtr, "GetHdcConctStatus"));
    if (getHdcConctStatus == nullptr) {
        // if runtime can not find callback, allowed continue
        RT_LOG(RT_LOG_WARNING, "No GetHdcConctStatus symbol found in %s.", libSoName);
    }
    tsdGetHdcConctStatus_ = getHdcConctStatus;
}

rtError_t Runtime::GetAicoreNumByLevel(const rtChipType_t chipTypeValue, int64_t &aicoreNumLevel,
    uint32_t &aicoreNum)
{
    if (IS_SUPPORT_CHIP_FEATURE(chipTypeValue, RtOptionalFeatureType::RT_FEATURE_DEVICE_AICORE_NUM_BY_LEVEL)) {
        uint32_t devCnt = 0U;
        drvError_t drvRet = drvGetDevNum(&devCnt);
        if (drvRet != DRV_ERROR_NONE) {
            DRV_ERROR_PROCESS(drvRet, "[drv api] drvGetDevNum failed: drvRetCode=%d!", static_cast<int32_t>(drvRet));
            return RT_GET_DRV_ERRCODE(drvRet);
        }

        for (uint32_t i = 0U; i < devCnt; i++) {
            drvRet = halGetDeviceInfo(i, MODULE_TYPE_AICORE, INFO_TYPE_CORE_NUM_LEVEL, &aicoreNumLevel);
            if (drvRet == DRV_ERROR_NONE) {
                workingDev_ = i;
                RT_LOG(RT_LOG_EVENT, "workingDev_=%u", workingDev_);
                break;
            }
        }

        UNUSED(chipTypeValue);

        if (drvRet != DRV_ERROR_NONE) {
            DRV_ERROR_PROCESS(drvRet, "Call halGetDeviceInfo failed: drvRetCode=%u, module type=%d, info type=%d.",
                static_cast<uint32_t>(drvRet), MODULE_TYPE_AICORE, INFO_TYPE_CORE_NUM_LEVEL);
            return RT_GET_DRV_ERRCODE(drvRet);
        }
        RT_LOG(RT_LOG_INFO, "Get aicore num level=%" PRId64 ", chipTypeValue:%d", aicoreNumLevel, chipType_);
        if (aicoreNumLevel == AICORE_NUM_LEVEL_AG) {
            aicoreNum = RT_AICORE_NUM_32;
        } else if (aicoreNumLevel == AICORE_NUM_LEVEL_PG) {
            aicoreNum = RT_AICORE_NUM_30;
        } else {
            return RT_ERROR_DRV_ERR;
        }
    }
    return RT_ERROR_NONE;
}

void Runtime::CheckVirtualMachineMode(uint32_t &aicoreNum, int64_t &vmAicoreNum)
{
    if (IS_SUPPORT_CHIP_FEATURE(chipType_, RtOptionalFeatureType::RT_FEATURE_DEVICE_VIRTUAL_MODE_CHECK) &&
        (aicoreNum != static_cast<uint32_t>(vmAicoreNum))) {
#ifndef CFG_DEV_PLATFORM_PC
        isVirtualMode_ = true;
#endif
        virAicoreNum_ = static_cast<uint32_t>(vmAicoreNum);
        RT_LOG(RT_LOG_INFO, "Check virtual machine mode, vir aicore num=%" PRId64 ", phyc aicore num=%u.",
               vmAicoreNum, aicoreNum);
    }
}

void Runtime::InitSocTypeFrom910Version(const int64_t hardwareVersion)
{
    const RtPGVersion pgVer = static_cast<RtPGVersion>(PLAT_GET_VER(static_cast<uint64_t>(hardwareVersion)));
    switch (pgVer) {
        case PG_VER_BIN0:
            socType_ = SOC_ASCEND910_9599;
            break;
        case PG_VER_BIN1:
            socType_ = SOC_ASCEND910_9589;
            break;
        case PG_VER_BIN2:
            socType_ = SOC_ASCEND910_958A;
            break;
        case PG_VER_BIN3:
            socType_ = SOC_ASCEND910_958B;
            break;
        case PG_VER_BIN4:
            socType_ = SOC_ASCEND910_957B;
            break;
        case PG_VER_BIN5:
            socType_ = SOC_ASCEND910_957D;
            break;
        case PG_VER_BIN6:
            socType_ = SOC_ASCEND910_950Z;
            break;
        case PG_VER_BIN7:
            socType_ = SOC_ASCEND910_9579;
            break;
        case PG_VER_BIN11:
            socType_ = SOC_ASCEND910_9591;
            break;
        case PG_VER_BIN12:
            socType_ = SOC_ASCEND910_9592;
            break;
        case PG_VER_BIN13:
            socType_ = SOC_ASCEND910_9581;
            break;
        case PG_VER_BIN14:
            socType_ = SOC_ASCEND910_9582;
            break;
        case PG_VER_BIN15:
            socType_ = SOC_ASCEND910_9584;
            break;
        case PG_VER_BIN16:
            socType_ = SOC_ASCEND910_9587;
            break;
        case PG_VER_BIN17:
            socType_ = SOC_ASCEND910_9588;
            break;
        case PG_VER_BIN18:
            socType_ = SOC_ASCEND910_9572;
            break;
        case PG_VER_BIN19:
            socType_ = SOC_ASCEND910_9575;
            break;
        case PG_VER_BIN20:
            socType_ = SOC_ASCEND910_9576;
            break;
        case PG_VER_BIN21:
            socType_ = SOC_ASCEND910_9574;
            break;
        case PG_VER_BIN22:
            socType_ = SOC_ASCEND910_9577;
            break;
        case PG_VER_BIN23:
            socType_ = SOC_ASCEND910_9578;
            break;
        case PG_VER_BIN24:
            socType_ = SOC_ASCEND910_957C;
            break;
        case PG_VER_BIN25:
            socType_ = SOC_ASCEND910_95A1;
            break;
        case PG_VER_BIN26:
            socType_ = SOC_ASCEND910_95A2;
            break;
        case PG_VER_BIN27:
            socType_ = SOC_ASCEND910_9595;
            break;
        case PG_VER_BIN28:
            socType_ = SOC_ASCEND910_9596;
            break;
        case PG_VER_BIN29:
            socType_ = SOC_ASCEND910_9585;
            break;
        case PG_VER_BIN30:
            socType_ = SOC_ASCEND910_9586;
            break;
        case PG_VER_BIN31:
            socType_ = SOC_ASCEND910_9583;
            break;
        case PG_VER_BIN32:
            socType_ = SOC_ASCEND910_9571;
            break;
        case PG_VER_BIN33:
            socType_ = SOC_ASCEND910_9573;
            break;
        case PG_VER_BIN34:
            socType_ = SOC_ASCEND910_950X;
            break;
        case PG_VER_BIN35:
            socType_ = SOC_ASCEND910_950Y;
            break;
        default:
            socType_ = SOC_END;
            break;
    }
}

void Runtime::InitSocTypeFrom310BVersion(const int64_t hardwareVersion)
{
    const rtPGVersion_t pgVer = static_cast<rtPGVersion_t>(PLAT_GET_VER(static_cast<uint64_t>(hardwareVersion)));
    if ((pgVer == RT_VER_BIN1) || (pgVer == RT_VER_NA)) {
        socType_ = SOC_ASCEND310B1;
    } else if (pgVer == RT_VER_BIN2) {
        socType_ = SOC_ASCEND310B2;
    } else if (pgVer == RT_VER_BIN3) {
        socType_ = SOC_ASCEND310B3;
    } else if (pgVer == RT_VER_BIN4) {
        socType_ = SOC_ASCEND310B4;
    } else {
        RT_LOG_CALL_MSG(ERR_MODULE_GE, "faultVersion(%#" PRIx64 ") from driver", static_cast<uint64_t>(hardwareVersion));
    }
}

void Runtime::InitSocTypeFrom910BVersion(int64_t hardwareVersion)
{
    const rtPGVersion_t pgVer = static_cast<rtPGVersion_t>(PLAT_GET_VER(static_cast<uint64_t>(hardwareVersion)));
    if (pgVer == RT_VER_NA) {
        socType_ = SOC_ASCEND910B4;
    } else if (pgVer == RT_VER_BIN1) {
        socType_ = SOC_ASCEND910B1;
    } else if (pgVer == RT_VER_BIN2) {
        socType_ = SOC_ASCEND910B2;
    } else if (pgVer == RT_VER_BIN3) {
        socType_ = SOC_ASCEND910B3;
    } else if (pgVer == RT_VER_BIN8) {
        socType_ = SOC_ASCEND910B2C;
    } else if (pgVer == RT_VER_BIN10) {
        socType_ = SOC_ASCEND910B4_1;
    } else {
        RT_LOG_CALL_MSG(ERR_MODULE_GE, "faultVersion(%#" PRIx64 ") from driver, cann and hdk may not compatible", static_cast<uint64_t>(hardwareVersion));
    }
}

void Runtime::InitSocTypeFromBS9SX1AXVersion()
{
    int64_t aicNum = 0;
    int64_t aivNum = 0;
    drvError_t drvRet = DRV_ERROR_NONE;

    socType_ = SOC_BS9SX1AA;
    drvRet = halGetDeviceInfo(RT_DEV_ZERO, MODULE_TYPE_AICORE, INFO_TYPE_CORE_NUM, &aicNum);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "Call halGetDeviceInfo failed: drvRetCode=%u, module type=%d, info type=%d.",
            static_cast<uint32_t>(drvRet), MODULE_TYPE_AICORE, INFO_TYPE_CORE_NUM);
        return;
    }

    drvRet = halGetDeviceInfo(RT_DEV_ZERO, MODULE_TYPE_VECTOR_CORE, INFO_TYPE_CORE_NUM, &aivNum);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "Call halGetDeviceInfo failed: drvRetCode=%u, module type=%d, info type=%d.",
            static_cast<uint32_t>(drvRet), MODULE_TYPE_VECTOR_CORE, INFO_TYPE_CORE_NUM);
        return;
    }

    RT_LOG(RT_LOG_DEBUG, "aicNum=%" PRId64 ", aivNum=%" PRId64, aicNum, aivNum);

    if (((aicNum == RT_BS9SX1AA_AICORE_NUM_AG) && (aivNum == RT_BS9SX1AA_AIVECTOR_NUM_AG)) ||
        ((aicNum == RT_BS9SX1AA_AICORE_NUM) && (aivNum == RT_BS9SX1AA_AIVECTOR_NUM))) {
        socType_ = SOC_BS9SX1AA;
    } else if ((aicNum == RT_BS9SX1AB_AICORE_NUM) && (aivNum == RT_BS9SX1AB_AIVECTOR_NUM)) {
        socType_ = SOC_BS9SX1AB;
    } else if ((aicNum == RT_BS9SX1AC_AICORE_NUM) && (aivNum == RT_BS9SX1AC_AIVECTOR_NUM)) {
        socType_ = SOC_BS9SX1AC;
    } else {
        RT_LOG(RT_LOG_DEBUG, "other version.");
    }
}

void Runtime::InitSocTypeFromADCVersion(const rtVersion_t ver, const int64_t hardwareVersion)
{
    UNUSED(hardwareVersion);
    socType_ = SOC_ASCEND610;
    if (ver == VER_CS) {
        InitSocTypeFromBS9SX1AXVersion();
    } else {
        // do nothing
    }
}

void Runtime::Init310PSocType(const int64_t vmAicoreNum)
{
    if (static_cast<uint32_t>(vmAicoreNum) == RT_AICORE_NUM_10) {
        socType_ = SOC_ASCEND310P1;
        return;
    }
    socType_ = SOC_ASCEND310P3;
#ifndef CFG_DEV_PLATFORM_PC
    halChipInfo chipInfo;
    const drvError_t drvRet = halGetChipInfo(workingDev_, &chipInfo);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "Call halGetChipInfo failed: drvRetCode=%d, device=%u.", drvRet, workingDev_);
        return;
    }
    const char* chipName = RtPtrToPtr<const char*>(chipInfo.name);
    RT_LOG(RT_LOG_DEBUG, "device %u get chipName is %s.", workingDev_, chipName);
    if (strncmp(chipName, "310P5", strlen("310P5")) == 0) {
        socType_ = SOC_ASCEND310P5;
    } else if (strncmp(chipName, "310P7", strlen("310P7")) == 0) {
        socType_ = SOC_ASCEND310P7;
    } else {
        // do nothing
    }
#endif
}

rtError_t Runtime::SetSocTypeByChipType(int64_t hardwareVersion, int64_t aicoreNumLevel, int64_t vmAicoreNum)
{
    int64_t aicoreFreqLevel = 0;
    drvError_t drvRet = DRV_ERROR_NONE;
    const rtVersion_t ver = static_cast<rtVersion_t>(PLAT_GET_VER(static_cast<uint64_t>(hardwareVersion)));
    switch (chipType_) {
        case CHIP_910_B_93:
            InitSocTypeFrom910BVersion(hardwareVersion);
            break;
        case CHIP_DAVID:
            InitSocTypeFrom910Version(hardwareVersion);
            break;
        case CHIP_CLOUD_V5:
            socType_ = SOC_ASCEND910_5591;
            break;
        case CHIP_MINI_V3:
            InitSocTypeFrom310BVersion(hardwareVersion);
            break;
        case CHIP_ASCEND_031:
            socType_ = SOC_ASCEND320T;
            break;
        case CHIP_CLOUD:
            drvRet = halGetDeviceInfo(workingDev_, MODULE_TYPE_AICORE, INFO_TYPE_FREQUE_LEVEL, &aicoreFreqLevel);
            if (drvRet != DRV_ERROR_NONE) {
                DRV_ERROR_PROCESS(drvRet, "Call halGetDeviceInfo failed: drvRetCode=%u, module type=%d, info type=%d.",
                    static_cast<uint32_t>(drvRet), MODULE_TYPE_AICORE, INFO_TYPE_FREQUE_LEVEL);
                return RT_GET_DRV_ERRCODE(drvRet);
            }
            SocTypeInit(aicoreNumLevel, aicoreFreqLevel);
            RT_LOG(RT_LOG_INFO, "aicore freq level=%" PRId64, aicoreFreqLevel);
            break;
        case CHIP_ADC:
            InitSocTypeFromADCVersion(ver, hardwareVersion);
            break;
        case CHIP_DC:
            Init310PSocType(vmAicoreNum);
            break;
        case CHIP_AS31XM1:
            socType_ = SOC_AS31XM1X;
            break;
        case CHIP_610LITE:
            socType_ = SOC_ASCEND610Lite;
            break;
        case CHIP_MC62CM12A:
            socType_ = SOC_MC62CM12A;
            break;
        case CHIP_X90:
            socType_ = SOC_KIRINX90;
            break;
        case CHIP_9030:
            socType_ = SOC_KIRIN9030;
            break;
        default:
            socType_ = SOC_END;
            break;
    }

    if (GlobalContainer::GetSocType() == SOC_BEGIN) {
        GlobalContainer::SetRtChipType(chipType_);
        GlobalContainer::SetSocType(socType_);
        GlobalContainer::SetArchType(archType_);
    } else {
        RT_LOG(RT_LOG_DEBUG, "GlobalContainer socType_ = %u, chipType_ = %u, archType_ = %u",
               GlobalContainer::GetSocType(), GlobalContainer::GetRtChipType(),
               GlobalContainer::GetArchType());
    }

    return RT_ERROR_NONE;
}

rtError_t GetHardVerBySocVer(const uint32_t deviceId, int64_t &hardwareVersion)
{
    drvError_t drvRet = DRV_ERROR_NONE;
    if (&halGetSocVersion != nullptr) {
        char_t socVersion[SOC_VERSION_LEN] = {0};
        drvRet = halGetSocVersion(deviceId, socVersion, SOC_VERSION_LEN);
        if ((drvRet != DRV_ERROR_NONE) && (drvRet != DRV_ERROR_NOT_SUPPORT)) {
            RT_LOG(RT_LOG_ERROR, "[drv api] halGetSocVersion failed, device_id=%u, drv_ret=%d.", deviceId, drvRet);
            return RT_GET_DRV_ERRCODE(drvRet);
        }

        if (drvRet == DRV_ERROR_NONE) {
            RtDevInfo info = {CHIP_END, ARCH_END, PG_VER_END, nullptr};
            const rtError_t ret = DevInfoManage::Instance().GetDevInfo(socVersion, info);
            if (ret == RT_ERROR_NONE) {
                const rtChipType_t chipType = info.chipType;
                const rtArchType_t archType = info.archType;
                const uint32_t pgType = static_cast<uint32_t>(info.pgType);
                hardwareVersion = static_cast<int64_t>(
                    (static_cast<uint32_t>(archType) << 16U) | (static_cast<uint32_t>(chipType) << 8U) | pgType);
                RT_LOG(RT_LOG_INFO,
                    "socVersion=%s, chipType=%d, archType=%d, pgType=%u, hardwareVersion=%#" PRIx64,
                    socVersion, chipType, archType, pgType, hardwareVersion);
                return RT_ERROR_NONE;
            }
            RT_LOG(RT_LOG_INFO, "not find socVersion=%s in DEV_INFO", socVersion);
        }
    }

    RT_LOG(RT_LOG_INFO, "drv_ret=%d", drvRet);
    drvRet = halGetDeviceInfo(deviceId, MODULE_TYPE_SYSTEM, INFO_TYPE_VERSION, &hardwareVersion);
    if (drvRet != DRV_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "[drv api] halGetDeviceInfo failed, device_id=%u, drv_ret=%d", deviceId, drvRet);
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    return RT_ERROR_NONE;
}

rtError_t Runtime::InitSocType()
{
    int64_t hardwareVersion = 0;
    rtError_t error = GetHardVerBySocVer(workingDev_, hardwareVersion);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "Get hardwareVersion failed.");
        return error;
    }
    if (static_cast<rtChipType_t>(PLAT_GET_CHIP(static_cast<uint64_t>(hardwareVersion))) == CHIP_NO_DEVICE) {
        return RT_ERROR_NONE;
    }

    drvError_t drvRet;
    chipType_ = static_cast<rtChipType_t>(PLAT_GET_CHIP(static_cast<uint64_t>(hardwareVersion)));
    archType_ = static_cast<rtArchType_t>(PLAT_GET_ARCH(static_cast<uint64_t>(hardwareVersion)));

    error = GetConnectUbFlagFromDrv(connectUbFlag_);
    if (error != RT_ERROR_NONE) {
        return error;
    }

    int64_t tsNumber = 0;
    drvRet = halGetDeviceInfo(workingDev_, MODULE_TYPE_SYSTEM, INFO_TYPE_CORE_NUM, &tsNumber);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "Call halGetDeviceInfo failed: drvRetCode=%u, module type=%d, info type=%d.",
            static_cast<uint32_t>(drvRet), MODULE_TYPE_SYSTEM, INFO_TYPE_CORE_NUM);
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_DRV, (tsNumber == 0) || (static_cast<uint32_t>(tsNumber) > RT_MAX_TS_NUM),
        RT_ERROR_DRV_ERR,
        "Get ts num failed, tsNumber=%" PRId64 ", valid range is [1,%u]", tsNumber, RT_MAX_TS_NUM);
    tsNum_ = static_cast<uint32_t>(tsNumber);

    int64_t vmAicoreNum = 0;
    drvRet = halGetDeviceInfo(workingDev_, MODULE_TYPE_AICORE, INFO_TYPE_CORE_NUM, &vmAicoreNum);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "Call halGetDeviceInfo failed: drvRetCode=%u, module type=%d, info type=%d.",
            static_cast<uint32_t>(drvRet), MODULE_TYPE_AICORE, INFO_TYPE_CORE_NUM);
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    uint32_t aicoreNum = 0U;
    int64_t aicoreNumLevel = 0;
    const rtError_t ret = GetAicoreNumByLevel(chipType_, aicoreNumLevel, aicoreNum);
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_DRV, ret != RT_ERROR_NONE, RT_ERROR_DRV_ERR,
        "Get aicore number by level failed: aicore numer level=%u", static_cast<uint32_t>(aicoreNumLevel));

    CheckVirtualMachineMode(aicoreNum, vmAicoreNum);

    return SetSocTypeByChipType(hardwareVersion, aicoreNumLevel, vmAicoreNum);
}

rtError_t Runtime::InitChipAndSocType()
{
    if (!CheckHaveDevice()) {
        chipType_ = GlobalContainer::GetRtChipType();
        socType_ = GlobalContainer::GetSocType();
        archType_ = GlobalContainer::GetArchType();
        isHaveDevice_ = false;
    } else {
        rtError_t error = InitSocType();
        if (error != RT_ERROR_NONE) {
            RT_LOG(RT_LOG_ERROR, "Init SocType failed.");
            return error;
        }
        error = InitAiCpuCnt();
        ERROR_RETURN_MSG_INNER(error, "init aicpu count fail, retCode=%#x", static_cast<uint32_t>(error));
        isHaveDevice_ = true;
    }
    rtError_t ret = GET_ALL_DEV_PROPERTIES(propertiesMap_);
    ERROR_RETURN_MSG_INNER(ret, "init chip properties fail, retCode=%#x", static_cast<uint32_t>(ret));
    ret = GET_DEV_PROPERTIES(chipType_, curChipProperties_);
    ERROR_RETURN_MSG_INNER(ret, "init chip:%d properties fail, retCode=%#x", chipType_, static_cast<uint32_t>(ret));
    RT_LOG(RT_LOG_INFO, "Runtime init: device type=%d, soc type=%d, arch type=%d, have device=%d",
           chipType_, socType_, archType_, isHaveDevice_);
    return RT_ERROR_NONE;
}

rtError_t Runtime::InitApiImplies()
{
    apiImpl_ = CreateImplAndGet();
    if (apiImpl_ == nullptr) {
        RT_LOG(RT_LOG_ERROR, "create ApiImpl failed");
        return RT_ERROR_API_NEW;
    }
    RT_LOG(RT_LOG_INFO, "ApiImpl:Runtime_alloc_size %zu", sizeof(ApiImpl));

    apiImplMbuf_ = CreateImplMbufAndGet();
    if (apiImplMbuf_ == nullptr) {
        RT_LOG(RT_LOG_ERROR, "create ApiImplMbuf failed");
        return RT_ERROR_API_NEW;
    }
    RT_LOG(RT_LOG_INFO, "ApiImplMbuf:Runtime_alloc_size %zu", sizeof(ApiImplMbuf));
    return RT_ERROR_NONE;
}

rtError_t Runtime::InitLogger()
{
    logger_ = new (std::nothrow) Logger();
    if (logger_ == nullptr) {
        return RT_ERROR_MEMORY_ALLOCATION;
    }
    RT_LOG(RT_LOG_INFO, "Logger:Runtime_alloc_size %zu", sizeof(Logger));
    return RT_ERROR_NONE;
}

rtError_t Runtime::InitApiProfiler(Api * const apiObj)
{
    profiler_ = new (std::nothrow) Profiler(apiObj);
    if (profiler_ == nullptr) {
        return RT_ERROR_PROF_NEW;
    }
    RT_LOG(RT_LOG_INFO, "RProfiler:Runtime_alloc_size %zu", sizeof(Profiler));

    const rtError_t error = profiler_->Init();
    if (error != RT_ERROR_NONE) {
        DELETE_O(profiler_);
        RT_LOG(RT_LOG_WARNING, "profiler_ init failed.");
    }
    return RT_ERROR_NONE;
}

rtError_t Runtime::InitApiErrorDecorator(Api * const apiObj)
{
    apiError_ = new (std::nothrow) ApiErrorDecorator(apiObj);
    if (apiError_ == nullptr) {
        return RT_ERROR_API_NEW;
    }
    RT_LOG(RT_LOG_INFO, "ApiErrorDecorator:Runtime_alloc_size %zu.", sizeof(ApiErrorDecorator));
    return RT_ERROR_NONE;
}

rtError_t Runtime::InitThreadGuard()
{
    threadGuard_ = new(std::nothrow) ThreadGuard();
    if (threadGuard_ == nullptr) {
        return RT_ERROR_MEMORY_ALLOCATION;
    }
    RT_LOG(RT_LOG_INFO, "Runtime init:new ThreadGuard ok, Runtime_alloc_size %zu.", sizeof(ThreadGuard));
    return RT_ERROR_NONE;
}

rtError_t Runtime::InitStreamObserver()
{
    streamObserver_ = new(std::nothrow) EngineStreamObserver();
    if (streamObserver_ == nullptr) {
        return RT_ERROR_ENGINE_NEW;
    }
    RT_LOG(RT_LOG_INFO, "EngineStreamObserver:Runtime_alloc_size %zu.",
        sizeof(EngineStreamObserver));
    return RT_ERROR_NONE;
}

rtError_t Runtime::InitAicpuStreamIdBitmap()
{
    aicpuStreamIdBitmap_ = new(std::nothrow) Bitmap(RT_MAX_AICPU_STREAM_COUNT);
    if (aicpuStreamIdBitmap_ == nullptr) {
        return RT_ERROR_MEMORY_ALLOCATION;
    }

    RT_LOG(RT_LOG_INFO, "Bitmap(%u):Runtime_alloc_size %zu.", RT_MAX_AICPU_STREAM_COUNT,
        sizeof(Bitmap));
    return RT_ERROR_NONE;
}

rtError_t Runtime::InitCbSubscribe()
{
    int32_t maxGrpNum = RT_THREAD_GROUP_ID_MAX;

    rtError_t error = RT_ERROR_NONE;
    size_t outSize = sizeof(maxGrpNum);
    if (halTsdrvCtl != nullptr) {
        error = halTsdrvCtl(RT_DEV_ZERO, TSDRV_CTL_CMD_CB_GROUP_NUM_GET, nullptr, 0, &maxGrpNum, &outSize);
    }
    if (error != DRV_ERROR_NONE) {
        RT_LOG(RT_LOG_INFO, "Get group num is not succeed, use default val");
        maxGrpNum = RT_THREAD_GROUP_ID_MAX;
    }

    RT_LOG(RT_LOG_INFO, "The thread group num is %d", maxGrpNum);

    cbSubscribe_ = new(std::nothrow) CbSubscribe(static_cast<uint32_t>(maxGrpNum));
    if (cbSubscribe_ == nullptr) {
        return RT_ERROR_SUBSCRIBE_NEW;
    }
    RT_LOG(RT_LOG_INFO, "Runtime init:new CbSubscribe ok, Runtime_alloc_size %zu.", sizeof(CbSubscribe));
    return RT_ERROR_NONE;
}

void Runtime::TryToRecyclePool() const
{
    static mmTimespec beginTimeSpec = mmGetTickCount();
    const mmTimespec endTimeSpec = mmGetTickCount();
    const uint64_t beginCnt = static_cast<uint64_t>(beginTimeSpec.tv_sec) * RT_MS_PER_S +
                              static_cast<uint64_t>(beginTimeSpec.tv_nsec) / RT_MS_TO_NS;
    const uint64_t endCnt = static_cast<uint64_t>(endTimeSpec.tv_sec) * RT_MS_PER_S +
                            static_cast<uint64_t>(endTimeSpec.tv_nsec) / RT_MS_TO_NS;
    /* 翻转场景 */
    if (endCnt < beginCnt) {
        beginTimeSpec = endTimeSpec;
        return;
    }

    /* 600s轮询检测一次 */
    if (endCnt - beginCnt < 600000UL) {
        return;
    }

    beginTimeSpec = endTimeSpec;
    ContextManage::TryToRecycleCtxMdlPool();

    return;
}

rtError_t Runtime::InitProgramAllocator()
{
#if (defined CFG_DEV_PLATFORM_PC)
    maxProgramNum_ = 480000U;
    RT_LOG(RT_LOG_DEBUG, "max program num %u", maxProgramNum_);
#else
    if (!isHaveDevice_) {
        maxProgramNum_ = 480000U;
        RT_LOG(RT_LOG_DEBUG, "max program num %u", maxProgramNum_);
    } else {
        uint32_t runMode = RT_RUN_MODE_RESERVED;
        (void)drvGetPlatformInfo(&runMode);
        if (runMode == RT_RUN_MODE_ONLINE) {
            maxProgramNum_ = 40000000U;
        } else {
            maxProgramNum_ = 2000000U;
        }

        if (IS_SUPPORT_CHIP_FEATURE(chipType_, RtOptionalFeatureType::RT_FEATURE_KERNEL_DOT_PROGRAM_ALLOCATOR)) {
            maxProgramNum_ = 20000U;
        }
        RT_LOG(RT_LOG_DEBUG, "run mode = %u [0:offline, 1:online], max program num %u, rtsqDepth=%u.",
               runMode, maxProgramNum_, macroValue_.rtsqDepth);
    }
#endif

    programAllocator_ = new (std::nothrow) ObjAllocator<RefObject<Program *>>(DEFAULT_PROGRAM_NUMBER,
        Runtime::maxProgramNum_);
    if (programAllocator_ == nullptr) {
        return RT_ERROR_PROGRAM_NEW;
    }
    return programAllocator_->Init();
}

rtError_t Runtime::InitLabelAllocator()
{
    labelAllocator_ = new(std::nothrow) LabelAllocator(static_cast<uint16_t>(MAX_UINT16_NUM));
    if (labelAllocator_ == nullptr) {
        return RT_ERROR_LABEL_ALLOCATOR;
    }
    RT_LOG(RT_LOG_INFO, "Runtime init:new LabelAllocator ok, Runtime_alloc_size %zu.", sizeof(LabelAllocator));
    return RT_ERROR_NONE;
}

rtError_t Runtime::InitSetRuntimeVersion()
{
    if (halSetRuntimeApiVer != nullptr) {
        halSetRuntimeApiVer(__HAL_API_VERSION);
        RT_LOG(RT_LOG_INFO, "set runtime api ver success");
    } else {
        RT_LOG(RT_LOG_WARNING, "can not find halSetRuntimeApiVer");
    }

    return RT_ERROR_NONE;
}

void Runtime::InitNpuCollectPath()
{
    const char_t *npuCollectPathEnv = nullptr;
    MM_SYS_GET_ENV(MM_ENV_NPU_COLLECT_PATH, npuCollectPathEnv);
    if (npuCollectPathEnv == nullptr) {
        RT_LOG(RT_LOG_INFO, "NPU_COLLECT_PATH is not set!");
    } else {
        SetNpuCollectFlag(true);
    }
    return;
}

void Runtime::InitStreamSyncMode()
{
    // StreamSyncEschedMode for 310P helper scene
    uint32_t runMode = RT_RUN_MODE_RESERVED;
    (void)drvGetPlatformInfo(&runMode);
    if (isHaveDevice_ && (runMode == RT_RUN_MODE_OFFLINE)) {
        ReadStreamSyncModeFromConfigIni();
    }
    return;
}

bool Runtime::CheckHaveDevice()
{
    int64_t hardwareVersion = RTS_INVALID_HARDWARE_VERSION;
    drvError_t drvRet = halGetDeviceInfo(RT_DEV_ZERO, MODULE_TYPE_SYSTEM, INFO_TYPE_VERSION, &hardwareVersion);
    if (drvRet != DRV_ERROR_NONE) {
        uint32_t devCnt = 0U;
        const drvError_t drvNumRet = drvGetDevNum(&devCnt);
        if (drvNumRet != DRV_ERROR_NONE) {
            devCnt = RT_MAX_DEV_NUM;
        }

        for (uint32_t i = 0U; i < devCnt; i++) {
            drvRet = halGetDeviceInfo(i, MODULE_TYPE_SYSTEM, INFO_TYPE_VERSION, &hardwareVersion);
            if (drvRet == DRV_ERROR_NONE) {
                workingDev_ = i;
                RT_LOG(RT_LOG_EVENT, "workingDev_=%u", workingDev_);
                break;
            }
        }
    }

    if (drvRet != DRV_ERROR_NONE) {
        if (drvRet != DRV_ERROR_NOT_SUPPORT) {
            DRV_ERROR_PROCESS(drvRet, "Call halGetDeviceInfo failed: drvRet=%d, module type=%d, info type=%d.",
                drvRet, MODULE_TYPE_SYSTEM, INFO_TYPE_VERSION);
        } else {
            RT_LOG(RT_LOG_WARNING, "[Call][halGetDeviceInfo] failed, function does not support, module type=%d,"
                   " info type=%d.", MODULE_TYPE_SYSTEM, INFO_TYPE_VERSION);
        }
    }

    RT_LOG(RT_LOG_INFO, "hardwareVersion=%#" PRIx64, hardwareVersion);
    return hardwareVersion != RTS_INVALID_HARDWARE_VERSION;
}

void Runtime::ParseHostCpuModelInfo()
{
    if (!IS_SUPPORT_CHIP_FEATURE(chipType_, RtOptionalFeatureType::RT_FEATURE_HOST_CPU_MODEL_INFO_FROM_FILE)) {
        return;
    }
    const std::string hostCpu = "RK3588";
    std::string line;
    std::ifstream cpuModelFile("/proc/device-tree/model");
    if (!cpuModelFile.is_open()) {
        RT_LOG(RT_LOG_INFO, "can't find model file!");
        return;
    }

    while (std::getline(cpuModelFile, line)) {
        if (line.find(hostCpu) != std::string::npos) {
            isRk3588Cpu_ = true;
            break;
        }
    }
    cpuModelFile.close();
}

static rtError_t GetDcacheLockMixPath(std::string &binaryPath)
{
    std::string libPath;
    const char_t *getPath = nullptr;
    MM_SYS_GET_ENV(MM_ENV_LD_LIBRARY_PATH, getPath);
    if (getPath == nullptr) {
        RT_LOG(RT_LOG_ERROR, "getenv fail.");
        return RT_ERROR_INVALID_VALUE;
    }

    libPath = getPath;
    RT_LOG(RT_LOG_INFO, "libPath:%s", libPath.c_str());
    const size_t mid = libPath.find("runtime/lib64");
    if (mid == libPath.npos) {
        RT_LOG(RT_LOG_WARNING, "getenv runtime/lib64 fail.");
        return RT_ERROR_INVALID_VALUE;
    }
    size_t diff;
    const size_t find = libPath.find(":", mid);
    const size_t findr = libPath.rfind(":", mid);
    if (find == libPath.npos) {
        diff = libPath.length() - findr;
    } else {
        diff = find - findr;
    }
    binaryPath = libPath.substr(findr + 1U, diff - 1U);
    binaryPath = binaryPath + "/ascend910_95/";

    RT_LOG(RT_LOG_INFO, "path:%s, diff:%u, find:%u, findr:%u, npos:%u.", binaryPath.c_str(), diff, find, findr,
           libPath.npos);
    return RT_ERROR_NONE;
}

rtError_t Runtime::GetDcacheLockMixOpPath(std::string &dcacheLockMixOpPath) const
{
    std::string libPath;
    DevProperties prop;
    rtError_t ret = GET_DEV_PROPERTIES(chipType_, prop);
    COND_RETURN_ERROR_MSG_INNER(ret != RT_ERROR_NONE, ret, "GetDevProperties failed.");
    if (prop.dcacheLockMixPathSourceType == DcacheLockMixPathSourceType::DCACHE_LOCK_MIX_PATH_FROM_LIB) {
        if (GetDriverPath(libPath)) {
            dcacheLockMixOpPath = libPath + "/driver/lib64/common/dcache_lock_mix.o";
        } else {
            dcacheLockMixOpPath = "/usr/local/Ascend/driver/lib64/common/dcache_lock_mix.o";
        }
    } else if (prop.dcacheLockMixPathSourceType == DcacheLockMixPathSourceType::DCACHE_LOCK_MIX_PATH_FROM_ENV) {
        const rtError_t ret = GetDcacheLockMixPath(libPath);
        if (ret != RT_ERROR_NONE) {
            RT_LOG(RT_LOG_WARNING, "get env fail.");
            return ret;
        }
        dcacheLockMixOpPath = libPath + "dcache_lock_mix.o";
    } else {
        return RT_ERROR_DEVICE_CHIPTYPE;
    }
    RT_LOG(RT_LOG_INFO, "dcacheLockMixOpPath %s.", dcacheLockMixOpPath.c_str());
    return RT_ERROR_NONE;
}

void Runtime::FindDcacheLockOp()
{
    if (!IS_SUPPORT_CHIP_FEATURE(chipType_, RtOptionalFeatureType::RT_FEATURE_DEVICE_DCACHE_LOCK)) {
        RT_LOG(RT_LOG_INFO, "dcache lock feature does not support on chip type=%u.", chipType_);
        return;
    }
    std::string dcacheLockMixOpPath;
    if (GetDcacheLockMixOpPath(dcacheLockMixOpPath) != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_WARNING, "get op path unexpected.");

        return;
    }
    if (dcacheLockMixOpPath.empty()) {
        RT_LOG(RT_LOG_INFO, "dcacheLockMixOpPath is invalid, path=[%s]", dcacheLockMixOpPath.c_str());
        return;
    }
    struct stat buf;
    if (stat(dcacheLockMixOpPath.c_str(), &buf) < 0) {
        RT_LOG(RT_LOG_INFO,
            "unable to find dcache lock op file, path=%s, reason is %s",
            dcacheLockMixOpPath.c_str(),
            strerror(errno));
        return;
    }

    std::ifstream file(dcacheLockMixOpPath, std::ios::binary);
    if (!file.is_open()) {
        RT_LOG(RT_LOG_INFO,
            "unable to open dcache lock op file, path=%s, reason is %s",
            dcacheLockMixOpPath.c_str(),
            strerror(errno));
        return;
    }

    dcacheLockMixOpData_.resize(buf.st_size);
    if (!file.read(dcacheLockMixOpData_.data(), dcacheLockMixOpData_.size())) {
        RT_LOG(RT_LOG_INFO, "unable to read dcache lock op file, path=%s, reason is %s", dcacheLockMixOpPath.c_str(), strerror(errno));
        dcacheLockMixOpData_.clear();
        return;
    }

    RT_LOG(RT_LOG_INFO, "read dcache lock op file success");
    return;
}

rtError_t Runtime::Init()
{
    FeatureToTsVersionInit();
    RegAtraceInfoInit();
    rtError_t error = InitChipAndSocType();
    COND_RETURN_WITH_NOLOG((error != RT_ERROR_NONE), error);

    MacroInit(chipType_);
    ParseHostCpuModelInfo();
    (void)GetVisibleDevices();
    if (IS_SUPPORT_CHIP_FEATURE(chipType_, RtOptionalFeatureType::RT_FEATURE_OVERFLOW_MODE)) {
        SetSatMode(RT_OVERFLOW_MODE_INFNAN);
    }

    error = InitApiImplies();
    Api *api = nullptr;
    COND_GOTO_ERROR_MSG_AND_ASSIGN_CALL(ERR_MODULE_SYSTEM, error != RT_ERROR_NONE, INIT_FAIL, error,
        error, "Failed to new ApiImpl.");

    api = apiImpl_;
    error = InitLogger();
    COND_GOTO_ERROR_MSG_AND_ASSIGN_CALL(ERR_MODULE_SYSTEM, error != RT_ERROR_NONE, INIT_FAIL, error,
        error, "Failed to new Logger.");

    error = InitApiProfiler(api);
    COND_GOTO_ERROR_MSG_AND_ASSIGN_CALL(ERR_MODULE_SYSTEM, error != RT_ERROR_NONE, INIT_FAIL, error,
        error, "Failed to new Profiler.");

    error = InitApiErrorDecorator(api);
    COND_GOTO_ERROR_MSG_AND_ASSIGN_CALL(ERR_MODULE_SYSTEM, error != RT_ERROR_NONE, INIT_FAIL, error,
        error, "Failed to new ApiErrorDecorator.");
    api_ = apiError_;
    apiMbuf_ = apiImplMbuf_; // apiImplMbuf_ no Profiler and Decorator

    error = InitThreadGuard();
    COND_GOTO_ERROR_MSG_AND_ASSIGN_CALL(ERR_MODULE_SYSTEM, error != RT_ERROR_NONE, INIT_FAIL, error,
        error, "Failed to new ThreadGuard.");

    error = InitStreamObserver();
    COND_GOTO_ERROR_MSG_AND_ASSIGN_CALL(ERR_MODULE_SYSTEM, error != RT_ERROR_NONE, INIT_FAIL, error,
        error, "Failed to new EngineStreamObserver.");

    error = InitAicpuStreamIdBitmap();
    COND_GOTO_ERROR_MSG_AND_ASSIGN_CALL(ERR_MODULE_SYSTEM, error != RT_ERROR_NONE, INIT_FAIL, error,
        error, "Failed to new Bitmap, num=%u.", RT_MAX_AICPU_STREAM_COUNT);

    error = InitCbSubscribe();
    COND_GOTO_ERROR_MSG_AND_ASSIGN_CALL(ERR_MODULE_SYSTEM, error != RT_ERROR_NONE, INIT_FAIL, error,
        error, "Failed to new CbSubscribe.");

    error = InitProgramAllocator();
    COND_GOTO_ERROR_MSG_AND_ASSIGN_CALL(ERR_MODULE_SYSTEM, error != RT_ERROR_NONE, INIT_FAIL, error,
        error, "Init runtime failed, failed to new RefObject, num=%u.", maxProgramNum_);

    error = InitLabelAllocator();
    COND_GOTO_ERROR_MSG_AND_ASSIGN_CALL(ERR_MODULE_SYSTEM, error != RT_ERROR_NONE, INIT_FAIL, error,
        RT_ERROR_LABEL_ALLOCATOR, "Failed to new LabelAllocator, num=%u.", RT_MAX_LABEL_NUM);

    error = InitSetRuntimeVersion();
    COND_GOTO_ERROR_MSG_AND_ASSIGN_CALL(ERR_MODULE_SYSTEM, error != RT_ERROR_NONE, INIT_FAIL, error,
        error, "Failed to new ApiErrorDecorator.");

    TsdClientInit();
    excptCallBack_ = nullptr;

    InitNpuCollectPath();
    RegTaskFunc();
    InitStreamSyncMode();

    FindDcacheLockOp();

    return error;

INIT_FAIL:
    DELETE_O(programAllocator_);
    DELETE_O(cbSubscribe_);
    DELETE_O(aicpuStreamIdBitmap_);
    DELETE_O(threadGuard_);
    DELETE_O(streamObserver_);
    DELETE_O(apiError_);
    DELETE_O(profiler_);
    DELETE_O(logger_);
    DELETE_O(apiImpl_);
    DELETE_O(apiImplMbuf_);
    return error;
}

rtError_t Runtime::WaitMonitorExit() const
{
    uint32_t cnt = 0U;
    while ((cnt < MONITOR_THREAD_MAX_WAIT_TIMES) && (monitorThreadNum_.Value() > 0U)) {
        (void)mmSleep(100U);
        ++cnt;
    }
    if (monitorThreadNum_.Value() > 0U) {
        RT_LOG(RT_LOG_EVENT, "wait monitor not complete, used count=%u, monitor thread num=%u.",
            cnt, monitorThreadNum_.Value());
    } else {
        RT_LOG(RT_LOG_EVENT, "wait monitor success, used count=%u.", cnt);
    }

    return RT_ERROR_NONE;
}

rtError_t Runtime::MallocProgramAndReg(const rtDevBinary_t * const bin, Program ** const newProg) const
{
    Program *prog = nullptr;
    const rtChipType_t chipType = Runtime::Instance()->GetChipType();
    if (bin->magic == RT_DEV_BINARY_MAGIC_PLAIN) {
        prog = new (std::nothrow) PlainProgram(Program::MACH_AI_CORE);
        RT_LOG(RT_LOG_INFO, "MAGIC_PLAIN new PlainProgram ok, Runtime_alloc_size %zu", sizeof(PlainProgram));
    } else if (bin->magic == RT_DEV_BINARY_MAGIC_PLAIN_AICPU) {
        prog = new (std::nothrow) PlainProgram(Program::MACH_AI_CPU);
        RT_LOG(RT_LOG_INFO, "MAGIC_PLAIN_AICPU new PlainProgram ok, Runtime_alloc_size %zu", sizeof(PlainProgram));
    } else if (bin->magic == RT_DEV_BINARY_MAGIC_PLAIN_AIVEC) {
        prog = new (std::nothrow) PlainProgram(Program::MACH_AI_VECTOR);
        RT_LOG(RT_LOG_INFO, "MAGIC_PLAIN_AIVEC new PlainProgram ok, Runtime_alloc_size %zu", sizeof(PlainProgram));
    } else if (bin->magic == RT_DEV_BINARY_MAGIC_ELF) {
        const uint32_t machine = (IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_KERNEL_BINARY_MACHINE_CVMIX)) ?
                                 Program::MACH_AI_CVMIX : Program::MACH_AI_CORE;
        prog = new (std::nothrow) ElfProgram(machine);
        RT_LOG(RT_LOG_INFO, "MAGIC_ELF new ElfProgram ok, Runtime_alloc_size %zu", sizeof(ElfProgram));
    } else if (bin->magic == RT_DEV_BINARY_MAGIC_ELF_AICUBE) {
        prog = new (std::nothrow) ElfProgram(Program::MACH_AI_CORE);
        RT_LOG(RT_LOG_INFO, "MAGIC_ELF_AICUBE new ElfProgram ok, Runtime_alloc_size %zu", sizeof(ElfProgram));
    } else if (bin->magic == RT_DEV_BINARY_MAGIC_ELF_AICPU) {
        prog = new (std::nothrow) ElfProgram(Program::MACH_AI_CPU);
        RT_LOG(RT_LOG_INFO, "MAGIC_ELF_AICPU new ElfProgram ok, Runtime_alloc_size %zu", sizeof(ElfProgram));
    } else if (bin->magic == RT_DEV_BINARY_MAGIC_ELF_AIVEC) {
        prog = new (std::nothrow) ElfProgram(Program::MACH_AI_VECTOR);
        RT_LOG(RT_LOG_INFO, "MAGIC_ELF_AIVEC new ElfProgram ok, Runtime_alloc_size %zu", sizeof(ElfProgram));
    } else {
        RT_LOG_CALL_MSG(ERR_MODULE_GE, "Program register failed, magic error, magic: %#x", bin->magic);
        return RT_ERROR_INVALID_VALUE;
    }

    NULL_PTR_RETURN_MSG(prog, RT_ERROR_PROGRAM_NEW);
    const rtError_t error = prog->Register(bin->data, bin->length);
    if (error != RT_ERROR_NONE) {
        RT_LOG_CALL_MSG(ERR_MODULE_GE, "Program register failed, magic: %#x", bin->magic);
        delete prog;
        prog = nullptr;
        return error;
    }

    RT_LOG(RT_LOG_INFO, "isSupportMix=%u, kernelType=%u", prog->GetSupportMix(), prog->Machine());
    if ((prog->GetSupportMix()) &&
        (IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_KERNEL_REGISTER_V2))) {
        prog->SetMachine(Program::MACH_AI_MIX_KERNEL);
    }

    *newProg = prog;
    return RT_ERROR_NONE;
}

rtError_t Runtime::AddProgramToPool(Program *const prog)
{
    // just for loop from last pos.
    static uint32_t programsTryIdx = 0U;
    const uint32_t newEnd = maxProgramNum_ + programsTryIdx;
    for (uint32_t i = programsTryIdx; i < newEnd; i++) {
        const uint32_t id = i % maxProgramNum_;  // init in Runtime::MacroInit
        RefObject<Program *> *const programItem = programAllocator_->GetDataToItem(id);
        if ((programItem != nullptr) && (programItem->TryIncAndSet(prog))) {
            prog->SetId(id);
            latestPoolIdx_ = i / DEFAULT_PROGRAM_NUMBER;
            programsTryIdx = ((id + 1U) >= maxProgramNum_) ? 0U : (id + 1U);
            RT_LOG(RT_LOG_INFO, "progId=%u", id);
            return RT_ERROR_NONE;
        }
    }
    RT_LOG(RT_LOG_ERROR, "Program register failed, program out of %u", maxProgramNum_);
    return RT_ERROR_PROGRAM_USEOUT;
}

rtError_t Runtime::ProgramRegister(const rtDevBinary_t *bin, Program **result)
{
    Program *prog = nullptr;
    const rtError_t error = MallocProgramAndReg(bin, &prog);
    COND_RETURN_WITH_NOLOG((error != RT_ERROR_NONE), error);
    *result = prog;
    return RT_ERROR_NONE;
}

bool Runtime::GetProgram(const Program * const prog)
{
    if ((prog == nullptr) || (prog->IsNewBinaryLoadFlow())) {
        return false;
    }

    COND_RETURN_WARN((prog->Id_() >= maxProgramNum_), false,
        "id=%u, valid range is [0,%u)", prog->Id_(), maxProgramNum_);

    RefObject<Program *> * const refObj = programAllocator_->GetDataToItem(prog->Id_());
    if (refObj == nullptr) {
        return false;
    }

    return refObj->TryIncRef();
}

void Runtime::PutProgram(const Program * const programPtr, bool isUnRegisterApi)
{
    if (unlikely(programPtr == nullptr) || (programPtr->IsNewBinaryLoadFlow())) {
        return;
    }

    const uint32_t id = programPtr->Id_();
    COND_RETURN_VOID((id >= maxProgramNum_), "id=%u, valid range is [0,%u)", id, maxProgramNum_);

    bool needReset = false;
    RefObject<Program *> * const refObj = programAllocator_->GetDataToItem(id);
    if (refObj == nullptr) {
        return;
    }

    Program *prog = refObj->GetVal(false);

    if (!refObj->TryDecRef(needReset)) {
        RT_LOG(RT_LOG_WARNING, "Try to double free program");
        return;
    }
    if (!needReset) {
        if (isUnRegisterApi) {
            RT_LOG(RT_LOG_EVENT, "After unregister, prog is not nullptr!");
        }
        return;
    }

    refObj->ResetVal();
    /* kernelTable_.RemoveAll must be done after refObj.ResetVal.
     * Otherwise, KernelTable::Lookup may be deadlocked with
     * kernelTable_.RemoveAll.
     */
    (void)kernelTable_.RemoveAll(prog);
    delete prog;
    prog = nullptr;
}

rtError_t Runtime::JudgeOffsetByMixType(Program * const prog, const void * const kernelInfoExt,
                                        uint8_t &mixType, rtKernelContent *info1, rtKernelContent *info2)
{
    if ((kernelInfoExt == nullptr) || !prog->HasMixKernel()) {
        return RT_ERROR_INVALID_VALUE;
    }
    std::string mixAicName;
    std::string mixAivName;
    (void)mixAicName.assign(RtPtrToPtr<const char_t *>(kernelInfoExt));
    (void)mixAicName.append("_mix_aic");
    (void)mixAivName.assign(RtPtrToPtr<const char_t *>(kernelInfoExt));
    (void)mixAivName.append("_mix_aiv");
    rtKernelContent aicInfo = {0, 0, false, 0};
    rtKernelContent aivInfo = {0, 0, false, 0};
    prog->KernelContent(mixAicName.c_str(), &aicInfo);
    prog->KernelContent(mixAivName.c_str(), &aivInfo);
    info1->simtFlag = aivInfo.simtFlag;
    info1->shareMemSize = aivInfo.shareMemSize;

    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_GE, ((aicInfo.offset == UINT32_MAX) && (aivInfo.offset == UINT32_MAX)),
        RT_ERROR_KERNEL_OFFSET,
        "Kernel register failed, kernel aicOffset=%u, aivOffset=%u, valid range is [0,%u).",
        aicInfo.offset, aivInfo.offset, UINT32_MAX);

    if (aivInfo.offset == UINT32_MAX) {
        info1->offset = aicInfo.offset;
        info1->length = aicInfo.length;
        mixType = static_cast<uint8_t>(MIX_AIC);
    } else if (aicInfo.offset == UINT32_MAX) {
        info1->offset = aivInfo.offset;
        info1->length = aivInfo.length;
        mixType = static_cast<uint8_t>(MIX_AIV);
    } else {
        info1->offset = aicInfo.offset;
        info2->offset = aivInfo.offset;
        info1->length = aicInfo.length;
        info2->length = aivInfo.length; 
        mixType = static_cast<uint8_t>(MIX_AIC_AIV_MAIN_AIC);
    }
    return RT_ERROR_NONE;
}

rtError_t Runtime::GetOffsetByCustomKernelType(Program *prog, const uint32_t kernelType,
    const void * const kernelInfoExt, rtKernelContent *info1, rtKernelContent *info2) const
{
    std::string mixAicName;
    std::string mixAivName;
    (void)mixAicName.assign(RtPtrToPtr<const char_t *>(kernelInfoExt));
    (void)mixAicName.append("_mix_aic");
    (void)mixAivName.assign(RtPtrToPtr<const char_t *>(kernelInfoExt));
    (void)mixAivName.append("_mix_aiv");
    rtKernelContent aicInfo = {UINT32_MAX, 0, false, 0};
    rtKernelContent aivInfo = {UINT32_MAX, 0, false, 0};
    prog->KernelContent(mixAicName.c_str(), &aicInfo);
    prog->KernelContent(mixAivName.c_str(), &aivInfo);
    info1->simtFlag = aivInfo.simtFlag;
    info1->shareMemSize = aivInfo.shareMemSize;

    if (kernelType == static_cast<uint32_t>(MIX_AIC)) {
        info1->offset = aicInfo.offset;
        info1->length = aicInfo.length;
        COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_GE, aicInfo.offset == UINT32_MAX, RT_ERROR_KERNEL_OFFSET,
            "Aic kernel register failed, kernel offset1=%u, valid range is [0,%u).", aicInfo.offset, UINT32_MAX);
        return RT_ERROR_NONE;
    }
    if (kernelType == static_cast<uint32_t>(MIX_AIV)) {
        info1->offset = aivInfo.offset;
        info1->length = aivInfo.length;
        COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_GE, aivInfo.offset == UINT32_MAX, RT_ERROR_KERNEL_OFFSET,
            "Aiv kernel register failed, kernel offset1=%u, valid range is [0,%u).", aivInfo.offset, UINT32_MAX);
        return RT_ERROR_NONE;
    }
    if (kernelType == static_cast<uint32_t>(MIX_AIC_AIV_MAIN_AIC)) {
        info1->offset = aicInfo.offset;
        info2->offset = aivInfo.offset;
        info1->length = aicInfo.length;
        info2->length = aivInfo.length;
        COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_GE, ((aicInfo.offset == UINT32_MAX) || (aivInfo.offset == UINT32_MAX)),
            RT_ERROR_KERNEL_OFFSET,
            "Mix kernel register failed, kernel offset1=%u, offset2=%u.", aicInfo.offset, aivInfo.offset);
        return RT_ERROR_NONE;
    }
    if (kernelType > static_cast<uint32_t>(MIX_AIC_AIV_MAIN_AIC)) {
        RT_LOG(RT_LOG_ERROR, "kernel register failed, mixType is an invalid value. mixType=%u.", kernelType);
        return RT_ERROR_KERNEL_OFFSET;
    }

    return RT_ERROR_NONE;
}

void Runtime::KernelSetDfx(Program * const prog, const void * const kernelInfoExt, Kernel *kernelPtr) const
{
    ElfProgram * const elfProg = dynamic_cast<ElfProgram *>(prog);
    if (elfProg == nullptr) {
        RT_LOG(RT_LOG_INFO, "can't dynamic_cast program.");
        return;
    }
    const RtKernel * const kernels = elfProg->GetKernels();
    const uint32_t kernelCount = elfProg->GetKernelsCount();
    if (kernels == nullptr) {
        RT_LOG(RT_LOG_INFO, "kernels is null, kernelCount=%u", kernelCount);
        return;
    }
    for (uint32_t idx = 0U; idx < kernelCount; idx++) {
        if (strcmp(kernels[idx].name, RtPtrToPtr<const char_t *>(kernelInfoExt)) == 0) {
            kernelPtr->SetDfxSize(kernels[idx].dfxSize);
            kernelPtr->SetDfxAddr(kernels[idx].dfxAddr);
            kernelPtr->SetElfDataFlag(kernels[idx].elfDataFlag);
            RT_LOG(RT_LOG_INFO, "kernel_name=%s, dfxAddr=%#" PRIu64 ", dfxSize=%u, elfDataFlag=%d",
                kernels[idx].name, RtPtrToValue<const void *>(kernels[idx].dfxAddr),
                kernels[idx].dfxSize, kernels[idx].elfDataFlag);
        }
    }
}

rtError_t Runtime::KernelRegister(Program *prog, const void *stubFunc, const char_t *stubName,
                                  const void * const kernelInfoExt, const uint32_t funcMode)
{
    rtKernelContent info1 = {0, 0, false, 0};
    rtKernelContent info2 = {0, 0, false, 0};
    prog->KernelContent(kernelInfoExt, &info1);
    uint8_t mixType = static_cast<uint8_t>(NO_MIX);
    const uint32_t funcModeInner = (funcMode & 0xFFFFU);

    if (IS_SUPPORT_CHIP_FEATURE(GetChipType(), RtOptionalFeatureType::RT_FEATURE_KERNEL_NO_MIX_DOT_REGISTER)) {
        COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_GE, info1.offset == UINT32_MAX, RT_ERROR_KERNEL_OFFSET,
            "Kernel register failed, kernel offset1=%u, valid range is [0,%u).", info1.offset, UINT32_MAX);
    } else {
        uint32_t kernelType = ((funcMode & 0xF0000U) >> 16U);
        if (kernelType == static_cast<uint32_t>(MIX_AIC_AIV_MAIN_AIC)) {
            kernelType = static_cast<uint32_t>(NO_MIX);
        }
        if (kernelType != 0U) {
            const rtError_t ret = GetOffsetByCustomKernelType(prog, kernelType, kernelInfoExt, &info1, &info2);
            if (ret != RT_ERROR_NONE) {
                return ret;
            }
            mixType = static_cast<uint8_t>(kernelType);
        } else if (info1.offset == UINT32_MAX) {
            const rtError_t error = JudgeOffsetByMixType(prog, kernelInfoExt, mixType, &info1, &info2);
            COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_GE, error != RT_ERROR_NONE, RT_ERROR_KERNEL_OFFSET,
                "Kernel register failed, kernel offset1=%u, valid range is [0,%u).", info1.offset, UINT32_MAX);
        } else {
            // do nothing
        }

        if ((mixType == static_cast<uint8_t>(MIX_AIC)) || (mixType == static_cast<uint8_t>(MIX_AIV))) {
            ElfProgram * const elfProg = dynamic_cast<ElfProgram *>(prog);
            const bool isDegenerateFlag = elfProg->GetDegenerateFlag();
            if (isDegenerateFlag) {
                RT_LOG(RT_LOG_DEBUG, "The current mixType is %d, degenerate to NO_MIX", mixType);
                mixType = static_cast<uint8_t>(NO_MIX);
            }
        }
    }

    /* kernelTable_ will maintain kernel and the function PutProgram() will release memory. */
    Kernel *kernelPtr = new (std::nothrow) Kernel(stubFunc, stubName, RtPtrToPtr<const char_t *>(kernelInfoExt),
        prog, info1.offset, info2.offset, mixType);
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, kernelPtr == nullptr, RT_ERROR_KERNEL_NEW,
        "Kernel register failed, new Kernel failed.");

    RT_LOG(RT_LOG_INFO, "Runtime_alloc_size %zu, type=%u, funcMode=%u, kernelInfoExt=%s, "
        "offset1=%u, length1=%u, offset2=%u, length2=%u, mixType=%hhu, simtFlag=%d, shareMemSize=%u.",
        sizeof(Kernel), prog->Machine(), funcModeInner, RtPtrToPtr<const char_t *>(kernelInfoExt),
        info1.offset, info1.length, info2.offset, info2.length, mixType, info1.simtFlag, info1.shareMemSize);

    const uint32_t nameOffset = prog->AppendKernelName(RtPtrToPtr<const char_t *>(kernelInfoExt));
    kernelPtr->SetNameOffset(nameOffset);
    KernelSetDfx(prog, kernelInfoExt, kernelPtr);
    kernelPtr->SetKernelLength1(info1.length);
    kernelPtr->SetKernelLength2(info2.length);
    (void)GetPrefetchCnt(prog, kernelPtr);
    kernelPtr->SetSimtFlag_(info1.simtFlag);
    kernelPtr->SetShareMemSize_(info1.shareMemSize);
    if ((funcModeInner == FUNC_MODE_PCTRACE_USERPROFILE_RECORDLOOP) ||
        (funcModeInner == FUNC_MODE_PCTRACE_USERPROFILE_SKIPLOOP) ||
        (funcModeInner == FUNC_MODE_PCTRACE_CYCLECNT_RECORDLOOP) ||
        (funcModeInner == FUNC_MODE_PCTRACE_CYCLECNT_SKIPLOOP)) {
        kernelPtr->SetPctraceFlag(funcModeInner);
    }
    // 这里会设置minStackSize，避免了重复进行字符串的查找
    InitKernel(prog, kernelInfoExt, mixType, kernelPtr);
    const rtError_t error = kernelTable_.Add(kernelPtr);
    if (error != RT_ERROR_NONE) {
        delete kernelPtr;
        kernelPtr = nullptr;
        return error;
    }

    const string &kernelName = kernelPtr->Name_();
    RT_LOG(RT_LOG_INFO,
        "kernel name=%s, mix type =%u, minStackSize1=%u, minStackSize2=%u.",
        kernelName.c_str(),
        kernelPtr->GetMixType(),
        kernelPtr->GetMinStackSize1(),
        kernelPtr->GetMinStackSize2());
    return RT_ERROR_NONE;
}

static void SetKernelAttributes(Program * const prog, Kernel *kernel, const RtKernel *rtKernel, const uint32_t kernelType,
    const char_t *kernelInfo)
{
    const uint32_t nameOffset = prog->AppendKernelName(rtKernel->name);
    kernel->SetNameOffset(nameOffset);
    kernel->SetKernelType_(kernelType);
    if (kernelInfo != nullptr) {
        kernel->SetKernelInfoExt(kernelInfo);
    }
    kernel->SetDfxSize(rtKernel->dfxSize);
    kernel->SetDfxAddr(rtKernel->dfxAddr);
    kernel->SetElfDataFlag(rtKernel->elfDataFlag);
    kernel->SetKernelLength1(static_cast<uint32_t>(rtKernel->length));
    kernel->SetMinStackSize1(rtKernel->minStackSize);
    kernel->SetSimtFlag_(rtKernel->simtFlag);
    kernel->SetShareMemSize_(rtKernel->shareMemSize);
}

bool IsKernelMatch(const char_t *kernelInfoExt, const char_t *kernelName)
{
    size_t kernelInfoExtSize = strnlen(kernelInfoExt, KERNEL_INFO_EXT_MAX);
    if (strncmp(kernelName, kernelInfoExt, kernelInfoExtSize) != 0) {
        return false;
    }
    size_t kernelNameSize = strnlen(kernelName, KERNEL_INFO_EXT_MAX);
    const std::string mixAicName = "_mix_aic";
    if ((kernelInfoExtSize != kernelNameSize) && (kernelNameSize != kernelInfoExtSize + mixAicName.length())) {
        return false;
    }
    return true;
}

rtError_t Runtime::AllocAndAddKernel(Program *prog, Kernel **kernelPtr, const RtKernelCombine& kernelCombine,
    const void * const kernelInfoExt, const char_t *stubName, const uint32_t funcModeInner)
{
    const void *stubFunc = kernelCombine.stubFunc;
    const uint64_t tilingKey = kernelCombine.tilingKey;
    const RtKernel* kernel = kernelCombine.kernel;
    const uint8_t mixType = kernelCombine.mixType;
    const uint32_t kernelType = kernelCombine.kernelType;
    const uint32_t curIdx = kernelCombine.kernelIdx;
    const char_t *kernelInfo = RtPtrToPtr<const char_t *>(kernelInfoExt);
    *kernelPtr = new (std::nothrow) Kernel(stubFunc, stubName, tilingKey, prog,
        static_cast<uint32_t>(kernel->offset), 0, mixType, kernel->taskRation, kernel->funcType);
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, *kernelPtr == nullptr, RT_ERROR_KERNEL_NEW,
        "Mix kernel register failed, new Kernel failed.");
    RT_LOG(RT_LOG_INFO, "Runtime_alloc_size %zu, funcType=%u, kernel_name=%s, mix_type=%u, offset=%u, length=%u, "
        "taskRation=%u, kernelType=%u, simtFlag=%d, shareMemSize=%u, dfxAddr=%#" PRIu64 ", dfxSize=%u.",
        sizeof(Kernel), kernel->funcType, kernel->name, mixType,
        static_cast<uint32_t>(kernel->offset), static_cast<uint32_t>(kernel->length),
        kernel->taskRation, kernelType, kernel->simtFlag, kernel->shareMemSize,
        RtPtrToValue(kernel->dfxAddr), kernel->dfxSize);
    SetKernelAttributes(prog, *kernelPtr, kernel, kernelType, kernelInfo);
    if (mixType != NO_MIX) {
        const RtKernel * const kernels = (dynamic_cast<ElfProgram *>(prog))->GetKernels();
        for (uint32_t idx = curIdx + 1U; idx < prog->kernelCount_; idx++) {
            if (!IsKernelMatch(kernelInfo, kernels[idx].name)) {
                continue;
            }
            (*kernelPtr)->SetOffset2(static_cast<uint32_t>(kernels[idx].offset));
            (*kernelPtr)->SetKernelLength2(static_cast<uint32_t>(kernels[idx].length));
            (*kernelPtr)->SetMinStackSize2(kernels[idx].minStackSize);
            (*kernelPtr)->SetMixMinStackSize();
            (*kernelPtr)->SetSimtFlag_((*kernelPtr)->SimtFlag_() || kernels[idx].simtFlag);
            uint32_t shareMemSize = (mixType == MIX_AIV) ? (*kernelPtr)->ShareMemSize_() : kernels[idx].shareMemSize;
            (*kernelPtr)->SetShareMemSize_(shareMemSize);
            const uint8_t type = kernels[idx].funcType == KERNEL_FUNCTION_TYPE_MIX_AIC_MAIN ?
                MIX_AIC_AIV_MAIN_AIC : MIX_AIC_AIV_MAIN_AIV;
            (*kernelPtr)->SetMixType(type);
            RT_LOG(RT_LOG_DEBUG, "kernel register offset2=%u, length2=%u, mixType=%u, simtFlag=%d, shareMemSize=%u.",
                (*kernelPtr)->Offset2_(), static_cast<uint32_t>(kernels[idx].length), type, (*kernelPtr)->SimtFlag_(), (*kernelPtr)->ShareMemSize_());
            break;
        }
    }

    (void)GetPrefetchCnt(prog, *kernelPtr);

    if ((funcModeInner == FUNC_MODE_PCTRACE_USERPROFILE_RECORDLOOP) ||
        (funcModeInner == FUNC_MODE_PCTRACE_USERPROFILE_SKIPLOOP) ||
        (funcModeInner == FUNC_MODE_PCTRACE_CYCLECNT_RECORDLOOP) ||
        (funcModeInner == FUNC_MODE_PCTRACE_CYCLECNT_SKIPLOOP)) {
        (*kernelPtr)->SetPctraceFlag(funcModeInner);
    }
    const rtError_t error = kernelTable_.Add(*kernelPtr);
    if (error != RT_ERROR_NONE) {
        delete *kernelPtr;
        *kernelPtr = nullptr;
        return error;
    }
    return RT_ERROR_NONE;
}

rtError_t Runtime::CheckSetKernelAndMixType(const RtKernel * const kernel, uint8_t& mixType,
    uint32_t& kernelType, std::string& kernelName)
{
    if (CheckMixKernelType(kernel) != RT_ERROR_NONE) {
        return RT_ERROR_INVALID_VALUE;
    }

    if (GetMixTypeAndKernelType(kernel, mixType, kernelType) != RT_ERROR_NONE) {
        return RT_ERROR_INVALID_VALUE;
    }

    kernelName = AdjustKernelName(kernel, mixType);
    if (kernelName.empty()) {
        return RT_ERROR_INVALID_VALUE;
    }
    return RT_ERROR_NONE;
}

// only for Program::MACH_AI_MIX_KERNEL
rtError_t Runtime::KernelRegisterV2(Program *prog, const void *stubFunc, const char_t *stubName,
                                    const char_t *kernelInfoExt, const uint32_t funcMode)
{
    const Kernel *kernelTmp = kernelTable_.Lookup(stubFunc);
    if (kernelTmp != nullptr) {
        PutProgram(prog);
        RT_LOG(RT_LOG_WARNING, "kernel had registered stubFunc=%p, stubName=%s.", stubFunc, stubName);
        return RT_ERROR_KERNEL_DUPLICATE;
    }

    ElfProgram * const elfProg = dynamic_cast<ElfProgram *>(prog);
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, elfProg == nullptr, RT_ERROR_NONE, "can't dynamic_cast program.");
    const rtChipType_t chipType = GetChipType();
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_GE,
        (!IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_KERNEL_REGISTER_V2)),
        RT_ERROR_FEATURE_NOT_SUPPORT, "Kernel register failed, chip type(%d) does not support", chipType);

    const RtKernel * const kernels = elfProg->GetKernels();
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, kernels == nullptr, RT_ERROR_NONE,
        "kernels is null, kernelCount=%u", elfProg->GetKernelsCount());

    prog->kernelCount_ = elfProg->GetKernelsCount();
    uint8_t mixType = static_cast<uint8_t>(NO_MIX);
    uint32_t kernelType = 0U;
    constexpr uint64_t tilingValue = 0ULL;
    bool isKernelFound = false;
    const bool kernelInfoExtVaild = (kernelInfoExt != nullptr) && (strnlen(kernelInfoExt, KERNEL_INFO_EXT_MAX) != 0);
    const uint32_t funcModeInner = (funcMode & 0xFFFFU);
    rtError_t error = RT_ERROR_NONE;
    /* kernelTable_ will maintain kernel and the function PutProgram() will release memory. */
    for (uint32_t idx = 0U; idx < prog->kernelCount_; idx++) {
        // 先检查kernels[idx] ->name(带mix_aic) 跟kernelInfoExt 前面是否一致
        if (kernelInfoExtVaild && strncmp(kernels[idx].name, kernelInfoExt, strnlen(kernelInfoExt, KERNEL_INFO_EXT_MAX)) != 0) {
            continue;
        }
        mixType = static_cast<uint8_t>(NO_MIX);
        std::string kernelName;
        if (CheckSetKernelAndMixType(&kernels[idx], mixType, kernelType, kernelName) != RT_ERROR_NONE) {
            return RT_ERROR_INVALID_VALUE;
        }
        RT_LOG(RT_LOG_INFO, "name=%s, kernel_name=%s, kernelInfoExt=%s, mixType=%u, kernelType=%u, tilingValue=%llu",
            kernels[idx].name, kernelName.c_str(), kernelInfoExt, mixType, kernelType, tilingValue);
        // kernelInfoExtVaild=false,历史遗留场景, 视为找到注册第一个kernel.
        if (kernelInfoExtVaild && strncmp(kernelName.c_str(), kernelInfoExt, kernelName.length()) != 0) {
            continue;
        }

        isKernelFound = true;
        RtKernelCombine kernelCombine = {&kernels[idx], stubFunc, mixType, kernelType, tilingValue, idx};
        Kernel *kernelPtr = nullptr;
        // 函数内部处理mix场景
        error = AllocAndAddKernel(prog, &kernelPtr, kernelCombine, kernelInfoExt, stubName, funcModeInner);
        break;
    }

    if (!isKernelFound) {
        RT_LOG(RT_LOG_ERROR, "kernel register fail stubFunc=%p, stubName=%s, kernelInfoExt=%s.",
            stubFunc, stubName, kernelInfoExt);
        return RT_ERROR_KERNEL_NAME;
    }

    return error;
}

void Runtime::InitKernel(
    Program * const prog, const void * const kernelInfoExt, const uint8_t mixType, Kernel *kernelPtr)
{
    if (mixType == static_cast<uint8_t>(NO_MIX)) {
        RtKernel kernel;
        const rtError_t kernelErr = prog->GetKernel(kernelInfoExt, kernel);
        if (kernelErr == RT_ERROR_NONE) {
            kernelPtr->SetMinStackSize1(kernel.minStackSize);
        } else {
            RT_LOG(RT_LOG_WARNING, "NO_MIX kernel prog->GetKernel fail");
        }
    } else if (mixType == static_cast<uint8_t>(MIX_AIC)) {
        BuildMixKernel(prog, kernelInfoExt, kernelPtr, 0, true);
    } else if (mixType == static_cast<uint8_t>(MIX_AIV)) {
        BuildMixKernel(prog, kernelInfoExt, kernelPtr, 0, false);
    } else if (mixType == static_cast<uint8_t>(MIX_AIC_AIV_MAIN_AIC) ||
               mixType == static_cast<uint8_t>(MIX_AIC_AIV_MAIN_AIV)) {
        BuildMixKernel(prog, kernelInfoExt, kernelPtr, 0, true);
        BuildMixKernel(prog, kernelInfoExt, kernelPtr, 1, false);
    } else {
    }
}

void Runtime::BuildMixKernel(
    Program * const prog, const void * const kernelInfoExt, Kernel *kernelPtr, const uint8_t idx, bool isAic) const
{
    RtKernel kernel;
    std::string name;
    (void)name.assign(RtPtrToPtr<const char_t *>(kernelInfoExt));
    if (isAic) {
        (void)name.append("_mix_aic");
    } else {
        (void)name.append("_mix_aiv");
    }
    if (prog->GetKernel(name.c_str(), kernel) == RT_ERROR_NONE) {
        if (idx == 0) {
            kernelPtr->SetMinStackSize1(kernel.minStackSize);
        } else {
            kernelPtr->SetMinStackSize2(kernel.minStackSize);
            kernelPtr->SetMixMinStackSize();
        }
    } else {
        RT_LOG(RT_LOG_WARNING, "mix kernel build prog->GetKernel fail");
    }
}

rtError_t Runtime::AllKernelRegister(Program * const prog, const bool isHostApiReg) const
{
    ElfProgram * const elfProg = dynamic_cast<ElfProgram *>(prog);
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_GE, elfProg == nullptr, RT_ERROR_NONE, "can't dynamic_cast program.");
    const RtKernel * const kernels = elfProg->GetKernels();
    const uint32_t kernelCount = elfProg->GetKernelsCount();

    if (kernels == nullptr) {
        RT_LOG(RT_LOG_INFO, "kernels is null, kernelCount=%u", kernelCount);
        return RT_ERROR_NONE;
    }

    if (prog->KernelTable_ == nullptr) {
        prog->KernelTable_ = new (std::nothrow) rtKernelArray_t[kernelCount];
        COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, prog->KernelTable_ == nullptr, RT_ERROR_MEMORY_ALLOCATION,
            "new rtKernelArray_t fail, kernelCount=%u.", kernelCount);
    }

    prog->kernelCount_ = kernelCount;
    RT_LOG(RT_LOG_DEBUG, "kernelCount=%u.", kernelCount);

    bool staticKernel = false;
    rtError_t error = CheckKernelsName(kernels, kernelCount, isHostApiReg, staticKernel);
    uint8_t mixType = NO_MIX;
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_GE, error != RT_ERROR_NONE, RT_ERROR_INVALID_VALUE,
        "current kernels not suit tilingkey rule.");
    const rtChipType_t chipType = GetChipType();
    /* kernelTable_ will maintain kernel and the function PutProgram() will release memory. */
    for (uint32_t idx = 0U; idx < kernelCount; idx++) {
        mixType = NO_MIX;
        const std::string kernelInfoExt = GetTilingKeyFromKernel(kernels[idx].name, mixType);
        elfProg->DegenerateMixType(mixType);

        uint64_t tilingValue = 0ULL;
        // static kernel register with using tilingkey as 0
        if ((!isHostApiReg) || (isHostApiReg && (!staticKernel))) {
            error = GetTilingValue(kernelInfoExt, tilingValue);
            if (error != RT_ERROR_NONE) {
                const std::string kernelInfo = kernels[idx].name;
                RT_LOG_OUTER_MSG_IMPL(ErrorCode::EE1003, "Register kernel " + kernelInfo,
                    kernelInfoExt.c_str(), "tiling", "a 64-bit unsigned long integer");
                return RT_ERROR_INVALID_VALUE;
            }
        }
        if (IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_KERNEL_MIX)) {
            const bool getProgFlag = (isHostApiReg ? false : true);
            Kernel *kernelPtrTmp = const_cast<Kernel*>(prog->AllKernelLookup(tilingValue, getProgFlag));
            if ((kernelPtrTmp != nullptr) && (kernelPtrTmp->Offset2_() == 0)) {
                kernelPtrTmp->SetOffset2(static_cast<uint32_t>(kernels[idx].offset));
                kernelPtrTmp->SetKernelLength2(static_cast<uint32_t>(kernels[idx].length));
                kernelPtrTmp->SetMinStackSize2(kernels[idx].minStackSize);
                kernelPtrTmp->SetMixMinStackSize();
                kernelPtrTmp->SetMixType(MIX_AIC_AIV_MAIN_AIC);
                kernelPtrTmp->SetSimtFlag_(kernelPtrTmp->SimtFlag_() || kernels[idx].simtFlag);
                uint32_t shareMemSize = (mixType == MIX_AIV) ? kernels[idx].shareMemSize : kernelPtrTmp->ShareMemSize_();
                kernelPtrTmp->SetShareMemSize_(shareMemSize);
                (void)GetPrefetchCnt(prog, kernelPtrTmp);
                if (IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_KERNEL_INIT_BY_CTRL_CODE)) {
                    continue;
                }
                RT_LOG(RT_LOG_DEBUG, "kernel register offset2=%u, length2=%u, simtFlag=%d, shareMemSize=%u.",
                    kernelPtrTmp->Offset2_(), static_cast<uint32_t>(kernels[idx].length),
                    kernelPtrTmp->SimtFlag_(), kernelPtrTmp->ShareMemSize_());
                continue;
            }
        }
        Kernel *kernelPtr = new (std::nothrow) Kernel(nullptr, kernels[idx].name, tilingValue, prog,
            static_cast<uint64_t>(kernels[idx].offset), 0, mixType);
        COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, kernelPtr == nullptr, RT_ERROR_KERNEL_NEW,
            "All kernel register failed, new Kernel failed.");
        RT_LOG(RT_LOG_INFO, "Runtime_alloc_size %zu, type=%u, kernel_name=%s, tilingkey=%" PRIu64
               ", offset=%u, length=%u, dfxAddr=0x%llx, dfxSize=%u, simtFlag=%d, shareMemSize=%u.",
               sizeof(Kernel), prog->Machine(), kernels[idx].name, kernelPtr->TilingKey(),
               static_cast<uint32_t>(kernels[idx].offset), static_cast<uint32_t>(kernels[idx].length),
               RtPtrToValue(kernels[idx].dfxAddr), kernels[idx].dfxSize,
               kernels[idx].simtFlag, kernels[idx].shareMemSize);

        SetKernelAttributes(prog, kernelPtr, &kernels[idx], kernelPtr->KernelType_(), nullptr);
        (void)GetPrefetchCnt(prog, kernelPtr);
        bool isRepeated = false;
        error = prog->AllKernelAdd(kernelPtr, isRepeated);
        if ((error != RT_ERROR_NONE) || (isRepeated)) {
            delete kernelPtr;
            kernelPtr = nullptr;
            return error;
        }
    }
    return RT_ERROR_NONE;
}

rtError_t Runtime::AllocAndAddKernelV2(Program *prog, Kernel **kernelPtr, const RtKernelCombine& kernelCombine,
    const std::string& kernelName)
{
    uint64_t tilingValue = kernelCombine.tilingKey;
    const RtKernel* kernel = kernelCombine.kernel;
    uint8_t mixType = kernelCombine.mixType;
    uint32_t kernelType = kernelCombine.kernelType;

    *kernelPtr = new (std::nothrow) Kernel(nullptr, kernelName.c_str(), tilingValue, prog,
        static_cast<uint32_t>(kernel->offset), 0, mixType, kernel->taskRation, kernel->funcType);
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, *kernelPtr == nullptr, RT_ERROR_KERNEL_NEW,
        "Mix kernel register failed, new Kernel failed.");
    RT_LOG(RT_LOG_INFO, "new kernel size %zu, funcType=%u, kernel_name=%s, mix_type=%u, offset=%u, length=%u, "
        "taskRation=%u, dfxAddr=%#" PRIu64 ", dfxSize=%u, kernelType=%u, simtFlag=%d, shareMemSize=%u.",
        sizeof(Kernel), kernel->funcType, kernel->name, mixType,
        static_cast<uint32_t>(kernel->offset), static_cast<uint32_t>(kernel->length), kernel->taskRation,
        RtPtrToValue(kernel->dfxAddr), kernel->dfxSize,
        kernelType, kernel->simtFlag, kernel->shareMemSize);
    const uint32_t nameOffset = prog->AppendKernelName(kernel->name);
    (*kernelPtr)->SetNameOffset(nameOffset);
    (*kernelPtr)->SetKernelType_(kernelType);
    (*kernelPtr)->SetDfxSize(kernel->dfxSize);
    (*kernelPtr)->SetDfxAddr(kernel->dfxAddr);
    (*kernelPtr)->SetElfDataFlag(kernel->elfDataFlag);
    (*kernelPtr)->SetKernelLength1(static_cast<uint32_t>(kernel->length));
    (*kernelPtr)->SetMinStackSize1(kernel->minStackSize);
    (*kernelPtr)->SetSimtFlag_(kernel->simtFlag);
    (*kernelPtr)->SetShareMemSize_(kernel->shareMemSize);
    (void)GetPrefetchCnt(prog, *kernelPtr);
    bool isRepeated = false;
    const rtError_t error = prog->AllKernelAdd(*kernelPtr, isRepeated);
    if ((error != RT_ERROR_NONE) || (isRepeated)) {
        delete *kernelPtr;
        *kernelPtr = nullptr;
        return error;
    }
    return RT_ERROR_NONE;
}

rtError_t Runtime::CheckSetKernelAndMixTypeV2(const RtKernel * const kernel, uint8_t& mixType,
    uint32_t& kernelType, uint64_t& tilingValue, std::string& kernelName)
{
    if (CheckMixKernelType(kernel) != RT_ERROR_NONE) {
        return RT_ERROR_INVALID_VALUE;
    }

    const std::string kernelInfoExt = GetTilingKeyFromKernel(kernel->name, mixType);
    rtError_t error = GetTilingValue(kernelInfoExt, tilingValue);
        COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_GE, error != RT_ERROR_NONE, RT_ERROR_INVALID_VALUE,
            "current kernels not suit dynamic tilingkey rule.");

    if (GetMixTypeAndKernelType(kernel, mixType, kernelType) != RT_ERROR_NONE) {
        return RT_ERROR_INVALID_VALUE;
    }

    kernelName = AdjustKernelName(kernel, mixType);
    if (kernelName.empty()) {
        return RT_ERROR_INVALID_VALUE;
    }
    return RT_ERROR_NONE;
}

bool Runtime::IsFoundKernelByTilingKey(Program * const prog, const RtKernel * const kernel,
    const uint64_t tilingValue, const uint8_t mixType)
{
    bool isFound = false;
    Kernel *kernelTmp = const_cast<Kernel*>(prog->AllKernelLookup(tilingValue));
    if (kernelTmp == nullptr) {
        return isFound;
    }
    if ((kernelTmp->Offset2_() == 0) && (kernelTmp->GetMixType() != mixType)) {
        isFound = true;
        kernelTmp->SetOffset2(static_cast<uint32_t>(kernel->offset));
        kernelTmp->SetKernelLength2(static_cast<uint32_t>(kernel->length));
        kernelTmp->SetMinStackSize2(kernel->minStackSize);
        kernelTmp->SetMixMinStackSize();
        kernelTmp->SetSimtFlag_(kernelTmp->SimtFlag_() || kernel->simtFlag);
        uint32_t shareMemSize = (mixType == MIX_AIV) ? kernel->shareMemSize : kernelTmp->ShareMemSize_();
        kernelTmp->SetShareMemSize_(shareMemSize);
        const uint8_t type = kernel->funcType == KERNEL_FUNCTION_TYPE_MIX_AIC_MAIN ?
            MIX_AIC_AIV_MAIN_AIC : MIX_AIC_AIV_MAIN_AIV;
        kernelTmp->SetMixType(type);
        (void)GetPrefetchCnt(prog, kernelTmp);
        RT_LOG(RT_LOG_DEBUG, "kernel register offset2=%u, length2=%u, mixType=%u, simtFlag=%d, shareMemSize=%u.",
            kernelTmp->Offset2_(), static_cast<uint32_t>(kernel->length), type, kernelTmp->SimtFlag_(), kernelTmp->ShareMemSize_());
    }
    Runtime::Instance()->PutProgram(prog);

    return isFound;
}

rtError_t Runtime::AllKernelRegisterV2(Program * const prog, const bool isHostApiReg)
{
    ElfProgram * const elfProg = dynamic_cast<ElfProgram *>(prog);
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, elfProg == nullptr, RT_ERROR_NONE, "can't dynamic_cast program.");
    const rtChipType_t chipType = GetChipType();
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_GE, 
        (!IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_KERNEL_REGISTER_V2)),
        RT_ERROR_FEATURE_NOT_SUPPORT, "Kernel register failed, chip type(%d) does not support.", chipType);

    const RtKernel * const kernels = elfProg->GetKernels();
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, kernels == nullptr, RT_ERROR_NONE,
        "kernels is null, kernelCount=%u", elfProg->GetKernelsCount());

    if (prog->KernelTable_ == nullptr) {
        prog->KernelTable_ = new (std::nothrow) rtKernelArray_t[elfProg->GetKernelsCount()];
        COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, prog->KernelTable_ == nullptr, RT_ERROR_MEMORY_ALLOCATION,
            "new rtKernelArray_t fail, kernelCount=%u.", elfProg->GetKernelsCount());
    }
    prog->kernelCount_ = elfProg->GetKernelsCount();

    bool staticKernel = false;
    rtError_t error = CheckKernelsName(kernels, prog->kernelCount_, isHostApiReg, staticKernel);
    RT_LOG(RT_LOG_INFO, "staticKernel=%u", staticKernel);

    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_GE, error != RT_ERROR_NONE, RT_ERROR_INVALID_VALUE,
        "current kernels not suit tilingkey rule.");

    uint8_t mixType = static_cast<uint8_t>(NO_MIX);
    uint32_t kernelType;

    /* kernelTable_ will maintain kernel and the function PutProgram() will release memory. */
    for (uint32_t idx = 0U; idx < prog->kernelCount_; idx++) {
        mixType = static_cast<uint8_t>(NO_MIX);
        uint64_t tilingValue = 0ULL;
        std::string kernelName;
        if (CheckSetKernelAndMixTypeV2(&kernels[idx], mixType, kernelType, tilingValue, kernelName)
            != RT_ERROR_NONE) {
            return RT_ERROR_INVALID_VALUE;
        }

        RT_LOG(RT_LOG_INFO, "kernel_name=%s, mixType=%u, kernelType=%u, tilingValue=%llu",
            kernelName.c_str(), mixType, kernelType, tilingValue);

        if (IsFoundKernelByTilingKey(prog, &kernels[idx], tilingValue, mixType)) {
            continue;
        }

        RtKernelCombine kernelCombine = {&kernels[idx], nullptr, mixType, kernelType, tilingValue, 0U};
        Kernel *kernelPtr = nullptr;
        error = AllocAndAddKernelV2(prog, &kernelPtr, kernelCombine, kernelName);
        COND_RETURN_WITH_NOLOG((error != RT_ERROR_NONE), error);
    }
    return RT_ERROR_NONE;
}

rtError_t Runtime::CheckStaticKernelName(const RtKernel * const kernels, const uint32_t kernelCount,
                                         const bool isHostApiRegister, bool &staticKernel) const
{
    staticKernel =  false;
    if (isHostApiRegister && (kernelCount == 1U)) {
        staticKernel = true;
        return RT_ERROR_NONE;
    }
    if (isHostApiRegister && (kernelCount == 2U)) {
        uint32_t mixkernelCount = 0U;
        for (uint32_t idx = 0U; idx < kernelCount; idx++) {
            std::string kernelValue = kernels[idx].name;
            const std::string mixAicName = "_mix_aic";
            const std::string mixAivName = "_mix_aiv";
            const auto aicPos = kernelValue.rfind(mixAicName);
            const auto aivPos = kernelValue.rfind(mixAivName);
            if (aicPos != std::string::npos || aivPos != std::string::npos) {
                mixkernelCount++;
            }
        }
        if (mixkernelCount == 1U) { // Invalid mixkernel, return error
            return RT_ERROR_INVALID_VALUE;
        } else if (mixkernelCount == 2U) {
            staticKernel = true;
        } else {
            // do nothing
        }
    }
    return RT_ERROR_NONE;
}

rtError_t Runtime::CheckKernelsName(const RtKernel * const kernels, const uint32_t kernelCount,
                                    const bool isHostApiRegister, bool &staticKernel) const
{
    // check static kernelname
    const rtError_t error = CheckStaticKernelName(kernels, kernelCount, isHostApiRegister, staticKernel);
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_GE, error != RT_ERROR_NONE, RT_ERROR_INVALID_VALUE,
        "current kernels not suit static kernel rule.");
    if (staticKernel) {
        return RT_ERROR_NONE;
    }
    // check dynamic kernelname
    for (uint32_t idx = 0U; idx < kernelCount; idx++) {
        std::string kernelValue = kernels[idx].name;
        const std::string mixAicName = "_mix_aic";
        const auto aicPos = kernelValue.rfind(mixAicName);
        const bool isAic = (aicPos != std::string::npos);
        if (isAic) {
            (void)kernelValue.erase(aicPos, mixAicName.length());
        }
        const std::string mixAivName = "_mix_aiv";
        const auto aivPos = kernelValue.rfind(mixAivName);
        const bool isAiv = (aivPos != std::string::npos);
        if (isAiv) {
            (void)kernelValue.erase(aivPos, mixAivName.length());
        }
        const auto pos = kernelValue.rfind('_');
        if (pos == std::string::npos) {
            RT_LOG(RT_LOG_ERROR, "check failed, cannot find '_' in kernel_name=%s.", kernelValue.c_str());
            return RT_ERROR_INVALID_VALUE;
        }

        const std::string tilingValue = kernelValue.substr(pos + 1U);
        // Judging that tilingValue is in the range of 0-9
        if (tilingValue.find_first_not_of("0123456789") != std::string::npos) {
            RT_LOG(RT_LOG_ERROR, "check failed, there are non numeric character in tilingValue=%s, kernel_name=%s.",
                tilingValue.c_str(), kernelValue.c_str());
            return RT_ERROR_INVALID_VALUE;
        }
    }

    return RT_ERROR_NONE;
}

rtError_t Runtime::CheckMixKernelType(const RtKernel * const kernel) const
{
    const uint32_t funcType = kernel->funcType;
    /* check kernel type, the rule is:
        1. 80 and 51 dc only support type of aicore
        2. 71 do not support  type of aicore */
    DevProperties prop;
    rtError_t ret = GET_DEV_PROPERTIES(chipType_, prop);
    COND_RETURN_ERROR_MSG_INNER(ret != RT_ERROR_NONE, ret, "GetDevProperties failed.");
    if ((funcType == static_cast<uint32_t>(KERNEL_FUNCTION_TYPE_INVALID)) || 
        (funcType >= static_cast<uint32_t>(KERNEL_FUNCTION_TYPE_MAX)) || 
        ((prop.kernelFuncType == KernelFuncType::Kernel_FUC_TYPE_SUPP_AICORE) && (funcType == static_cast<uint32_t>(KERNEL_FUNCTION_TYPE_AICORE))) || 
        ((prop.kernelFuncType == KernelFuncType::Kernel_FUC_TYPE_OTHER_AICORE) && (funcType != static_cast<uint32_t>(KERNEL_FUNCTION_TYPE_AICORE)))) {
        RT_LOG(RT_LOG_ERROR, "kernel function type is invalid, kerneName=%s, funcType=%u.",
            kernel->name, funcType);
        return RT_ERROR_INVALID_VALUE;
    }

    return RT_ERROR_NONE;
}

std::string Runtime::AdjustKernelName(const RtKernel * const kernel, uint8_t mixType) const
{
    uint32_t funcType = kernel->funcType;
    std::string kernelName = kernel->name;
    std::string mixName;

    switch (funcType) {
        case KERNEL_FUNCTION_TYPE_AICORE:
        case KERNEL_FUNCTION_TYPE_AIC:
        case KERNEL_FUNCTION_TYPE_AIV:
            return kernelName;

        case KERNEL_FUNCTION_TYPE_MIX_AIC_MAIN:
        case KERNEL_FUNCTION_TYPE_MIX_AIV_MAIN:
            if (mixType == static_cast<uint8_t>(MIX_AIC)) {
                mixName = "_mix_aic";
            } else {
                mixName = "_mix_aiv";
            }
            break;
        case KERNEL_FUNCTION_TYPE_AIC_ROLLBACK:
            mixName = "_mix_aic";
            break;
        case KERNEL_FUNCTION_TYPE_AIV_ROLLBACK:
            mixName = "_mix_aiv";
            break;

        default:
            return "";
    }

    const auto pos = kernelName.rfind(mixName);
    if (pos != std::string::npos) {
        (void)kernelName.erase(pos, mixName.length());
    } else {
        RT_LOG(RT_LOG_ERROR, "Get kernel name failed, kerneName=%s, funcType=%u, "
            "crossCoreSync=%u, mixType=%u.",
            kernel->name, funcType, kernel->crossCoreSync, mixType);
        return "";
    }

    return kernelName;
}

/* the relation of kernelName/func type/kernel type/mix type:
   kernelName    funcType            coreCrossSync    kernelType      mixType
   add           AICORE              NO               MACH_AI_CORE    NO_MIX
   add           AIC                 NO               MACH_AI_CORE    NO_MIX
   add           AIV                 NO               MACH_AI_VECTOR  NO_MIX
   add           AIC                 YES              MACH_AI_CORE    MIX_AIC
   add           AIV                 YES              MACH_AI_CORE    MIX_AIV
   add_mic_aic   AIC_MAIN            /                MACH_AI_CORE    MIX_AIC_AIV_MAIN_AIC
   add_mic_aiv   AIC_MAIN            /                MACH_AI_CORE    MIX_AIC_AIV_MAIN_AIC
   add_mic_aic   AIV_MAIN            /                MACH_AI_CORE    MIX_AIC_AIV_MAIN_AIV
   add_mic_aiv   AIV_MAIN            /                MACH_AI_CORE    MIX_AIC_AIV_MAIN_AIV
   add_mic_aic   AIC_ROLLBACK        NO               MACH_AI_CORE    NO_MIX
   add_mic_aiv   AIV_ROLLBACK        NO               MACH_AI_VECTOR  NO_MIX
   add_mic_aic   AIC_ROLLBACK        YES              MACH_AI_CORE    MIX_AIC
   add_mic_aiv   AIV_ROLLBACK        YES              MACH_AI_CORE    MIX_AIV
 */
rtError_t Runtime::GetMixTypeAndKernelType(const RtKernel * const kernel, uint8_t &mixType, uint32_t &kernelType)
{
    uint32_t funcType = kernel->funcType;
    uint32_t crossCoreSync = kernel->crossCoreSync;
    std::string kernelName = kernel->name;
    const std::string mixAicName = "_mix_aic";
    const std::string mixAivName = "_mix_aiv";
    rtError_t result = RT_ERROR_NONE;
    const rtChipType_t chipType = Runtime::Instance()->GetChipType();

    mixType = static_cast<uint8_t>(NO_MIX);

    switch (funcType) {
        case KERNEL_FUNCTION_TYPE_AICORE:
            kernelType = (IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_KERNEL_BINARY_MACHINE_CVMIX)) ?
                Program::MACH_AI_CVMIX : Program::MACH_AI_CORE;
            break;
        case KERNEL_FUNCTION_TYPE_AIC:
        case KERNEL_FUNCTION_TYPE_AIC_ROLLBACK:
            kernelType = Program::MACH_AI_CORE;
            if (crossCoreSync == FUNC_USE_SYNC) {
                mixType = static_cast<uint8_t>(MIX_AIC);
            }
            break;
        case KERNEL_FUNCTION_TYPE_AIV:
        case KERNEL_FUNCTION_TYPE_AIV_ROLLBACK:
            kernelType = Program::MACH_AI_VECTOR;
            if (crossCoreSync == FUNC_USE_SYNC) {
                mixType = static_cast<uint8_t>(MIX_AIV);
            }
            break;
        case KERNEL_FUNCTION_TYPE_MIX_AIC_MAIN:
        case KERNEL_FUNCTION_TYPE_MIX_AIV_MAIN:
            kernelType = Program::MACH_AI_CORE;
            if (kernelName.rfind(mixAicName) != std::string::npos) {
                mixType = static_cast<uint8_t>(MIX_AIC);
            } else if (kernelName.rfind(mixAivName) != std::string::npos) {
                mixType = static_cast<uint8_t>(MIX_AIV);
            } else {
                result = RT_ERROR_INVALID_VALUE;
            }
            break;

        default:
            result = RT_ERROR_INVALID_VALUE;
            break;
    }

    if (result != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "Get mix type failed, kerneName=%s, funcType=%lu, crossCoreSync=%lu, kernelType=%lu.",
            kernel->name, funcType, crossCoreSync, kernelType);
    }

    return result;
}

rtError_t Runtime::MixKernelRegister(Program * const prog)
{
    ElfProgram * const elfProg = dynamic_cast<ElfProgram *>(prog);
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, elfProg == nullptr, RT_ERROR_NONE, "can't dynamic_cast program.");
    const RtKernel * const kernels = elfProg->GetKernels();

    if (kernels == nullptr) {
        RT_LOG(RT_LOG_INFO, "kernels is null, kernelCount=%u", elfProg->GetKernelsCount());
        return RT_ERROR_NONE;
    }

    prog->kernelCount_ = elfProg->GetKernelsCount();

    uint8_t mixType = static_cast<uint8_t>(NO_MIX);
    uint32_t kernelType;
    constexpr uint64_t tilingValue = 0ULL;

    /* kernelTable_ will maintain kernel and the function PutProgram() will release memory. */
    for (uint32_t idx = 0U; idx < prog->kernelCount_; idx++) {
        mixType = static_cast<uint8_t>(NO_MIX);
        if (CheckMixKernelType(&kernels[idx]) != RT_ERROR_NONE) {
            return RT_ERROR_INVALID_VALUE;
        }

        if (GetMixTypeAndKernelType(&kernels[idx], mixType, kernelType) != RT_ERROR_NONE) {
            return RT_ERROR_INVALID_VALUE;
        }

        std::string kernelName = AdjustKernelName(&(kernels[idx]), mixType);
        if (kernelName.empty()) {
            return RT_ERROR_INVALID_VALUE;
        }

        if (IS_SUPPORT_CHIP_FEATURE(chipType_, RtOptionalFeatureType::RT_FEATURE_KERNEL_MIX)) {
            Kernel *kernelTmp = const_cast<Kernel*>(prog->GetKernelByName(kernelName.c_str()));
            if ((kernelTmp != nullptr) && (kernelTmp->Offset2_() == 0) && (kernelTmp->GetMixType() != mixType)) {
                kernelTmp->SetOffset2(static_cast<uint32_t>(kernels[idx].offset));
                kernelTmp->SetKernelLength2(static_cast<uint32_t>(kernels[idx].length));
                kernelTmp->SetMinStackSize2(kernels[idx].minStackSize);
                kernelTmp->SetMixMinStackSize();
                kernelTmp->SetSimtFlag_(kernelTmp->SimtFlag_() || kernels[idx].simtFlag);
                uint32_t shareMemSize = (mixType == MIX_AIV) ? kernels[idx].shareMemSize : kernelTmp->ShareMemSize_();
                kernelTmp->SetShareMemSize_(shareMemSize);
                const uint8_t type = kernels[idx].funcType == KERNEL_FUNCTION_TYPE_MIX_AIC_MAIN ?
                    MIX_AIC_AIV_MAIN_AIC : MIX_AIC_AIV_MAIN_AIV;
                kernelTmp->SetMixType(type);
                (void)GetPrefetchCnt(prog, kernelTmp);
                RT_LOG(RT_LOG_DEBUG, "kernel register offset2=%u, length2=%u, mixType=%u, simtFlag=%d, shareMemSize=%u.",
                    kernelTmp->Offset2_(), static_cast<uint32_t>(kernels[idx].length), type,
                    kernelTmp->SimtFlag_(), kernelTmp->ShareMemSize_());
                continue;
            }
        }

        Kernel *kernelPtr = new (std::nothrow) Kernel(nullptr, kernelName.c_str(), tilingValue, prog,
            static_cast<uint32_t>(kernels[idx].offset), 0, mixType, kernels[idx].taskRation);
        COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, kernelPtr == nullptr, RT_ERROR_KERNEL_NEW,
            "Mix kernel register failed, new Kernel failed.");
        RT_LOG(RT_LOG_INFO, "Runtime_alloc_size %zu, funcType=%u, kernel_name=%s, mix_type=%u, offset=%u, length=%u, "
            "taskRation=%u, kernelType=%u, simtFlag=%d, shareMemSize=%u, dfxAddr=%#" PRIu64 ", dfxSize=%u.",
            sizeof(Kernel), kernels[idx].funcType, kernels[idx].name, mixType,
            static_cast<uint32_t>(kernels[idx].offset), static_cast<uint32_t>(kernels[idx].length),
            kernels[idx].taskRation, kernelType, kernels[idx].simtFlag, kernels[idx].shareMemSize,
            RtPtrToValue(kernels[idx].dfxAddr), kernels[idx].dfxSize);
        SetKernelAttributes(prog, kernelPtr, &kernels[idx], kernelType, nullptr);
        (void)GetPrefetchCnt(prog, kernelPtr);
        const rtError_t error = prog->MixKernelAdd(kernelPtr);
        if (error != RT_ERROR_NONE) {
            delete kernelPtr;
            kernelPtr = nullptr;
            return error;
        }
    }
    return RT_ERROR_NONE;
}

rtError_t Runtime::MallocProgramAndRegMixKernel(const void *data, const uint64_t length, Program ** const newProg) const
{
    Program *prog = new (std::nothrow) ElfProgram(Program::MACH_AI_MIX_KERNEL);
    RT_LOG(RT_LOG_INFO, "new ElfProgram ok, Runtime_alloc_size %zu", sizeof(ElfProgram));

    NULL_PTR_RETURN_MSG(prog, RT_ERROR_PROGRAM_NEW);
    const rtError_t error = prog->Register(data, length);
    if (error != RT_ERROR_NONE) {
        RT_LOG_CALL_MSG(ERR_MODULE_GE, "mix program register failed");
        delete prog;
        prog = nullptr;
        return error;
    }
    *newProg = prog;
    return RT_ERROR_NONE;
}

rtError_t Runtime::GetTilingValue(const std::string &kernelInfoExt, uint64_t &tilingValue) const
{
    // dynamic shape kernel
    try {
        tilingValue = std::stoull(kernelInfoExt.c_str());
    } catch (const std::invalid_argument &ia) {
        RT_LOG(RT_LOG_ERROR, "%s failed, invalid_argument, tilingValue=%s.", ia.what(), kernelInfoExt.c_str());
        return RT_ERROR_INVALID_VALUE;
    } catch (const std::out_of_range &oor) {
        RT_LOG(RT_LOG_ERROR, "%s failed, out_of_range, tilingValue=%s.", oor.what(), kernelInfoExt.c_str());
        return RT_ERROR_INVALID_VALUE;
    }
    return RT_ERROR_NONE;
}

std::string Runtime::GetTilingKeyFromKernel(const std::string &kernelName, uint8_t &mixType) const
{
    std::string temp = kernelName;
    const std::string mixAicName = "_mix_aic";
    const std::string mixAivName = "_mix_aiv";
    const auto aicPos = kernelName.rfind(mixAicName);
    const auto aivPos = kernelName.rfind(mixAivName);

    const bool isAic = (aicPos != std::string::npos);
    const bool isAiv = (aivPos != std::string::npos);
    if (isAic && isAiv) {
        mixType = static_cast<uint8_t>(MIX_AIC_AIV_MAIN_AIC);
        (void)temp.erase(aicPos, mixAicName.length());
        (void)temp.erase(temp.rfind(mixAivName), mixAivName.length());
    } else if (isAic) {
        mixType = static_cast<uint8_t>(MIX_AIC);
        (void)temp.erase(aicPos, mixAicName.length());
    } else if (isAiv) {
        mixType = static_cast<uint8_t>(MIX_AIV);
        (void)temp.erase(aivPos, mixAivName.length());
    } else {
        RT_LOG(RT_LOG_DEBUG, "Not contain aic or aiv");
    }

    const auto pos = temp.rfind('_');
    RT_LOG(RT_LOG_INFO, "kernelName substr=%s, pos=%zu", temp.substr(pos + 1U).c_str(), pos);
    return temp.substr(pos + 1U);
}

const Kernel *Runtime::KernelLookup(const void * const stub)
{
    return kernelTable_.Lookup(stub);
}

const void *Runtime::StubFuncLookup(const char_t * const name)
{
    return kernelTable_.InvLookup(name);
}

rtError_t Runtime::SetAicpuAttr(const char_t * const key, const char_t * const value) const
{
    RT_LOG(RT_LOG_DEBUG, "key=%s, val=%s", (key != nullptr) ? key : "NULL", (value != nullptr) ? value : "NULL");

    if (tsdSetAttr_ != nullptr) {
        TDT_StatusType stat = tsdSetAttr_(key, value);
        if (stat != TSD_OK) {
            RT_LOG_INNER_MSG(RT_LOG_ERROR, "Set aicpu attribute failed, tdt error=%u", stat);
            return RT_ERROR_DRV_TSD_ERR;
        }
    }

    return RT_ERROR_NONE;
}

rtError_t Runtime::GetTsdQos(const uint32_t devId, uint16_t &qos) const
{
    qos = 0U;

    if (devId == STUB_DEVICE_ID) {
        return RT_ERROR_NONE;
    }

    if (tsdGetCapability_ == nullptr) {
        RT_LOG(RT_LOG_INFO, "[TSD] tsdGetCapability func is null, devId=%u", devId);
        return RT_ERROR_NONE;
    }

    RT_LOG(RT_LOG_INFO, "[TSD] start get qos, devId=%u", devId);
    uint64_t tsdQos;
    uint32_t userDeviceId;
    const rtError_t error = GetUserDevIdByDeviceId(devId, &userDeviceId, true);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, "Get userDeviceId failed. error=%#x, devId=%u", static_cast<uint32_t>(error), devId);
    const TDT_StatusType tdtStat = tsdGetCapability_(static_cast<int32_t>(userDeviceId), 0, RtPtrToPtr<uintptr_t>(&tsdQos));
    if (tdtStat != TSD_OK) {
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "[TSD] get qos failed, userDeviceId=%u, devId=%u, tdt error=%u", userDeviceId, devId, tdtStat);
        return RT_ERROR_DRV_TSD_ERR;
    }

    RT_LOG(RT_LOG_INFO, "[TSD] get qos success, userDeviceId=%u, devId=%u, qos=%" PRIu64, userDeviceId, devId, tsdQos);
    qos = static_cast<uint16_t>(tsdQos);
    return RT_ERROR_NONE;
}

#if (!defined CFG_DEV_PLATFORM_PC)
static void PrintfTsdError(const uint32_t devId, const TDT_StatusType tdtStatus)
{
    switch (tdtStatus) {
        case TSD_SUBPROCESS_NUM_EXCEED_THE_LIMIT: {
            RT_LOG_OUTER_MSG(RT_TSD_SUBPROCESS_NUM_EXCEED_THE_LIMIT_ERROR,
                "TsdOpen failed:The number of started NN processes exceeds the limit.");
            break;
        }
        case TSD_SUBPROCESS_BINARY_FILE_DAMAGED: {
            RT_LOG_OUTER_MSG(RT_TSD_SUBPROCESS_BINARY_FILE_DAMAGED,
                "TsdOpen failed:The binary file of the NN process is damaged or the file permissions are incorrect.");
            break;
        }
        case TSD_DEVICE_DISCONNECTED: {
            RT_LOG_OUTER_MSG(RT_TSD_DEVICE_DISCONNECTED,
                "TsdOpen failed:Device is disconnected.");
            break;
        }
        case TSD_DRV_HDC_SEND_FILE_FAILED: {
            RT_LOG_OUTER_MSG(RT_TSD_DRV_HDC_SEND_FILE_FAILED_ERROR,
                "TsdOpen failed:Failed to verify OPP package.");
            break;
        }
        case TSD_ADD_AICPUSD_TO_CGROUP_FAILED: {
            RT_LOG_OUTER_MSG(RT_TSD_ADD_AICPUSD_TO_CGROUP_FAILED,
                "TsdOpen failed:Failed to add the AI CPU scheduler to the Cgroup.");
            break;
        }
        default: {
            RT_LOG_CALL_MSG(ERR_MODULE_AICPU, "TsdOpen failed. devId=%u, tdt error=%u", devId, tdtStatus);
            break;
        }
    }
    return;
}
#endif

// runtime on host,  whether to start aicpu depends on envFlags
// runtime on device, always start aicpu
rtError_t Runtime::startAicpuExecutor(const uint32_t devId, const uint32_t tsId)
{
    rtError_t error = RT_ERROR_NONE;
    if ((tsId == RT_TSV_ID)) {
        return error;
    }

    if ((tsdOpen_ == nullptr) && (tsdOpenEx_ == nullptr)) {
        RT_LOG(RT_LOG_INFO, "no TsdOpen");
        return error;
    }

    RT_LOG(RT_LOG_INFO, "TsdOpen devId=%u", devId);
    const uint32_t envFlags = ThreadLocalContainer::GetEnvFlags();
    if ((envFlags & API_ENV_FLAGS_NO_TSD) != 0U) {
        RT_LOG(RT_LOG_INFO, "don't need TsdClient open, devId=%u", devId);
        return error;
    }

#if (!defined CFG_DEV_PLATFORM_PC)
    TDT_StatusType tdtStatus;
    uint32_t userDevId = 0U;
    error = GetUserDevIdByDeviceId(devId, &userDevId, true);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, "Get userDeviceId failed. error=%#x, devId=%u", error, devId);
    if (tsdOpenEx_ != nullptr) {
        tdtStatus = tsdOpenEx_(userDevId, 0U, 0);
    } else if (tsdOpen_ != nullptr) {
        tdtStatus = tsdOpen_(userDevId, 0U);
    } else {
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "TsdOpen func is null.");
        return RT_ERROR_DRV_SYM_TSD;
    }
    RT_LOG(RT_LOG_INFO, "userDeviceId=%u, devId=%u, tsdOpen ret=%u", userDevId, devId, tdtStatus);

    /* call tsdOpen will not take effect. Should call openAiCpuSd in aicpu related procedure. */
    if ((IS_SUPPORT_CHIP_FEATURE(chipType_, RtOptionalFeatureType::RT_FEATURE_DEVICE_AICPUSD_LAZY_START)) && (tdtStatus == TSD_OPEN_NOT_SUPPORT_FOR_MDC)) {
        RT_LOG(RT_LOG_INFO, "TsdOpen success, will open ai cpu sd in later procedure, devId=%u", devId);
        return RT_ERROR_NONE;
    }

    if (tdtStatus != TSD_OK) {
        PrintfTsdError(devId, tdtStatus);
        return RT_ERROR_DRV_OPEN_TSD;
    }
    RT_LOG(RT_LOG_INFO, "TsdOpen success, devId=%u, ret=%u", devId, error);
#endif
    return error;
}

rtError_t Runtime::OpenNetService(const rtNetServiceOpenArgs *args) const
{
    rtError_t error = RT_ERROR_NONE;
    COND_RETURN_ERROR(tsdOpenNetService_ == nullptr, RT_ERROR_DRV_TSD_ERR,
                    "handle is null, maybe no symbol TsdOpenNetService.");
    Context *ctx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(ctx, RT_ERROR_CONTEXT_NULL);
    uint32_t userDeviceId = 0U;
    error = GetUserDevIdByDeviceId(ctx->Device_()->Id_(), &userDeviceId, true);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, "Get userDeviceId failed. error=%#x, devId=%u", 
        static_cast<uint32_t>(error), ctx->Device_()->Id_());
    const TDT_StatusType tdtStatus = tsdOpenNetService_(userDeviceId, RtPtrToPtr<const NetServiceOpenArgs *>(args));
    if (tdtStatus != TSD_OK) {
        RT_LOG(RT_LOG_ERROR, "open NetService failed, devId=%u, tdt error=%u", userDeviceId, tdtStatus);
        return RT_ERROR_DRV_OPEN_TSD;
    }
    return RT_ERROR_NONE;
}

rtError_t Runtime::CloseNetService() const
{
    rtError_t error = RT_ERROR_NONE;
    COND_RETURN_ERROR(tsdCloseNetService_ == nullptr, RT_ERROR_DRV_TSD_ERR,
                    "handle is null, maybe no symbol TsdCloseNetService.");
    Context *ctx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(ctx, RT_ERROR_CONTEXT_NULL);
    uint32_t userDeviceId = 0U;
    error = GetUserDevIdByDeviceId(ctx->Device_()->Id_(), &userDeviceId, true);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, "Get userDeviceId failed. error=%#x, devId=%u", 
        static_cast<uint32_t>(error), ctx->Device_()->Id_());
    const TDT_StatusType tdtStatus = tsdCloseNetService_(userDeviceId);
    if (tdtStatus != TSD_OK) {
        RT_LOG(RT_LOG_ERROR, "close aicpu service failed, devId=%u, tdt error=%u", userDeviceId, tdtStatus);
        return RT_ERROR_DRV_CLOSE_TSD;
    }

    return RT_ERROR_NONE;
}

rtError_t Runtime::StartAicpuSd(Device * const device) const
{
    rtError_t error = InitDrvEventThread(device->Id_());
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, "Init drv event thread failed, error=%#x, devId=%u", 
        static_cast<uint32_t>(error), device->Id_());
#if (!defined CFG_DEV_PLATFORM_PC)
    RT_LOG(RT_LOG_DEBUG, "OpenAicpuSd, devId=%u, chipType=%d, isAicpuSchStart=%u", device->Id_(), chipType_,
        device->IsAiCpuSdStarted());

    if ((!device->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DEVICE_AICPUSD_LAZY_START)) || (device->IsAiCpuSdStarted())) {
        return RT_ERROR_NONE;
    }

    const uint32_t envFlags = ThreadLocalContainer::GetEnvFlags();
    if ((envFlags & API_ENV_FLAGS_NO_TSD) != 0U) {
        RT_LOG(RT_LOG_INFO, "don't need OpenAicpuSd, devId=%u", device->Id_());
        return RT_ERROR_NONE;
    }

    SpinLock * const aicpuSchSdLock = device->GetAiCpuSdLock();
    aicpuSchSdLock->Lock();
    if (device->IsAiCpuSdStarted()) {
        aicpuSchSdLock->Unlock();
        return RT_ERROR_NONE;
    }

    if (tsdOpenAicpuSd_ == nullptr) {
        RT_LOG(RT_LOG_ERROR, "TsdOpenAicpuSd func is null");
        aicpuSchSdLock->Unlock();
        return RT_ERROR_DRV_SYM_TSD;
    }

    uint32_t userDeviceId;
    error = GetUserDevIdByDeviceId(device->Id_(), &userDeviceId, true);
    if (error != RT_ERROR_NONE) {
        aicpuSchSdLock->Unlock();
        RT_LOG(RT_LOG_ERROR, "Get userDeviceId failed. error=%#x, devId=%u", error, device->Id_());
        return error;
    }
    const TDT_StatusType tdtStatus = tsdOpenAicpuSd_(userDeviceId);
    if (tdtStatus != TSD_OK) {
        aicpuSchSdLock->Unlock();
        PrintfTsdError(device->Id_(), tdtStatus);
        return RT_ERROR_DRV_OPEN_AICPU;
    }
    RT_LOG(RT_LOG_INFO, "TsdOpenAicpuSd success, userDeviceId=%u, devId=%u", userDeviceId, device->Id_());
    device->SetIsAiCpuSdStarted(true);
    aicpuSchSdLock->Unlock();
#endif
    return RT_ERROR_NONE;
}

rtError_t Runtime::StopAicpuExecutor(const uint32_t devId, const uint32_t tsId, const bool isQuickClose) const
{
    const rtError_t error = RT_ERROR_NONE;
    if ((tsId == RT_TSV_ID)) {
        return error;
    }

    if ((tsdClose_ == nullptr) && (tsdCloseEx_ == nullptr)) {
        RT_LOG(RT_LOG_INFO, "no TsdClose");
        return error;
    }

    RT_LOG(RT_LOG_DEBUG, "TsdClose devId=%u", devId);
    const uint32_t envFlags = ThreadLocalContainer::GetEnvFlags();
    if ((envFlags & API_ENV_FLAGS_NO_TSD) != 0U) {
        RT_LOG(RT_LOG_INFO, "don't need TsdClient close, devId=%u", devId);
        return error;
    }
#if (!defined CFG_DEV_PLATFORM_PC)
    if (tsdClose_ == nullptr) {
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "TsdClose is null.");
        return RT_ERROR_DRV_SYM_TSD;
    }
    uint32_t userDeviceId;
    const rtError_t err = GetUserDevIdByDeviceId(devId, &userDeviceId, true);
    COND_RETURN_ERROR_MSG_INNER(err != RT_ERROR_NONE, err, "Get userDeviceId failed. error=%#x, devId=%u", static_cast<uint32_t>(err), devId);
    TDT_StatusType tdtStatus;
    if (isQuickClose && tsdCloseEx_ != nullptr) {
        RT_LOG(RT_LOG_INFO, "tsdCloseEx_ start, userDeviceId=%u, devId=%u", userDeviceId, devId);
        tdtStatus = tsdCloseEx_(userDeviceId, TSD_CLOSE_EX_FLAG_QUICK_CLOSE);
    } else {
        tdtStatus = tsdClose_(userDeviceId);
    }
    
    if (tdtStatus != TSD_OK) {
        RT_LOG_CALL_MSG(ERR_MODULE_AICPU, "TsdClose failed. devId=%u, tdt error=%u", devId, tdtStatus);
        return RT_ERROR_DRV_CLOSE_TSD;
    }
    RT_LOG(RT_LOG_INFO, "TsdClose success, userDeviceId=%u, devId=%u, tdt status=%d", userDeviceId, devId, error);
#else
    UNUSED(isQuickClose);
#endif
    return error;
}

rtError_t Runtime::InitAicpuQS(const uint32_t devId, const char_t * const grpName) const
{
    rtInitFlowGwInfo_t info = {};
    info.groupName = grpName;
    return InitAicpuFlowGw(devId, &info);
}

rtError_t Runtime::InitAicpuFlowGw(const uint32_t devId, const rtInitFlowGwInfo_t * const initInfo) const
{
    if (devId == STUB_DEVICE_ID) {
        return RT_ERROR_NONE;
    }

    RT_LOG(RT_LOG_DEBUG, "TsdInitFlowGw drv devId=%u", devId);
    const uint32_t envFlags = ThreadLocalContainer::GetEnvFlags();
    if ((envFlags & API_ENV_FLAGS_NO_TSD) != 0U) {
        RT_LOG(RT_LOG_INFO, "don't need tsdInitQs, devId=%u", devId);
        return RT_ERROR_NONE;
    }

    if (!isHaveDevice_) {
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }
    InitFlowGwInfo info = {};
    if (initInfo != nullptr) {
        info = {initInfo->groupName, initInfo->schedPolicy, initInfo->reschedInterval, {}};
    }
#if (!defined CFG_DEV_PLATFORM_PC)
    if (tsdInitFlowGw_ == nullptr) {
        RT_LOG_INNER_MSG(RT_LOG_WARNING, "TsdInitFlowGw is null.");
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }

    uint32_t userDeviceId;
    const rtError_t error = GetUserDevIdByDeviceId(devId, &userDeviceId, true);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, "Get userDeviceId failed. error=%#x, devId=%u", static_cast<uint32_t>(error), devId);
    const TDT_StatusType tdtStatus = tsdInitFlowGw_(userDeviceId, &info);
    if (tdtStatus != TSD_OK) {
        RT_LOG_CALL_MSG(ERR_MODULE_AICPU, "tsdInitFlowGw failed. drv devId=%u, tdt error=%u", devId, tdtStatus);
        return RT_ERROR_DRV_CLOSE_TSD;
    }
    RT_LOG(RT_LOG_INFO, "tsdInitFlowGw success, userDeviceId=%u, drv devId=%u, tdt status=%u", userDeviceId, devId, tdtStatus);
#endif
    return RT_ERROR_NONE;
}

rtError_t Runtime::GetHdcConctStatus(const uint32_t devId, int32_t &hdcSessStat)
{
#if (!defined CFG_DEV_PLATFORM_PC)
    if (tsdGetHdcConctStatus_ == nullptr) {
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }

    uint32_t userDeviceId;
    const rtError_t error = GetUserDevIdByDeviceId(devId, &userDeviceId, true, false, true);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, "Get userDeviceId failed. error=%#x, devId=%u", static_cast<uint32_t>(error), devId);
    const TDT_StatusType tdtStatus = tsdGetHdcConctStatus_(userDeviceId, &hdcSessStat);
    if (tdtStatus != TSD_OK) {
        RT_LOG_INNER_MSG(RT_LOG_WARNING, "Get Hdc Connection Status failed. userDeviceId=%u, devId=%u, tdt status=%u.",
            userDeviceId, devId, tdtStatus);
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }
    return RT_ERROR_NONE;
#else
    UNUSED(devId);
    UNUSED(hdcSessStat);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
#endif
}

// isStart : 0:stop aicpu profiling 1:start aicpu profiling
rtError_t Runtime::HandleAiCpuProfiling(
    const uint64_t profConfig, const uint32_t devId, const bool isStart, const uint64_t profSwitchHi) const
{
    rtError_t error = RT_ERROR_NONE;
    uint32_t profSwitch = 0U;
    RT_LOG(RT_LOG_INFO,
        "Handle aicpu profiling, profConfig=%#" PRIx64 ", profSwitchHi=%#" PRIx64 ", devId=%u, isHaveDevice=%d, "
        "isStart=%d(0:close, 1:open)",
        profConfig,
        profSwitchHi,
        devId,
        isHaveDevice_,
        isStart);
    if (!isHaveDevice_) {
        return error;
    }
    if (isStart) {
        profSwitch |= (1U << static_cast<uint32_t>(PROFILING_FEATURE_SWITCH));
    }
    if ((profConfig & PROF_AICPU_TRACE_MASK) != 0UL) {
        profSwitch |= (1U << static_cast<uint32_t>(PROFILING_FEATURE_KERNEL_MODE));
    }
    if ((profConfig & PROF_AICPU_MODEL_MASK) != 0UL) {
        profSwitch |= (1U << static_cast<uint32_t>(PROFILING_FEATURE_MODEL_MODE));
    }
    if ((profConfig & PROF_TASK_TIME_MASK) != 0UL) {
        profSwitch |= (1U << static_cast<uint32_t>(PROFILING_FEATURE_TIME));
    }
    if ((profConfig & PROF_TASK_TIME_L1_MASK) != 0UL) {
        profSwitch |= (1U << static_cast<uint32_t>(PROFILING_FEATURE_TIME_L1));
    }
    if ((profConfig & PROF_TASK_TIME_L2_MASK) != 0UL) {
        profSwitch |= (1U << static_cast<uint32_t>(PROFILING_FEATURE_TIME_L2));
    }

    profSwitch |= ((profSwitchHi >> 32ULL) & 0xFFFF0000ULL);  // 32是因为profSwitch是uint32，且只需要profSwitchHi的高16位

    RT_LOG(RT_LOG_INFO, "Handle aicpu profiling, profSwitch=%#" PRIx64, profSwitch);
#if (!defined CFG_DEV_PLATFORM_PC)

        COND_RETURN_WARN(tsdHandleAicpuProfiling_ == nullptr, RT_ERROR_DRV_SYM_TSD,
            "handle is null, maybe can not find symbol UpdateProfilingMode in libtsd_client.so.");

        uint32_t userDeviceId;
        const rtError_t err = GetUserDevIdByDeviceId(devId, &userDeviceId, true);
        COND_RETURN_ERROR_MSG_INNER(err != RT_ERROR_NONE, err, "Get userDeviceId failed. error=%#x, devId=%u", static_cast<uint32_t>(err), devId);
        const TDT_StatusType tdtStatus = tsdHandleAicpuProfiling_(userDeviceId, profSwitch);
        if (tdtStatus != TSD_OK) {
            error = RT_ERROR_DRV_TSD_ERR;
            RT_LOG(RT_LOG_WARNING, "tsdHandleAicpuProfiling failed. devId=%u, tdt status=%u", devId, tdtStatus);
        }
        RT_LOG(RT_LOG_INFO, "tsdHandleAicpuProfiling success, userDeviceId=%u, devId=%u, tdt status=%u", userDeviceId, devId, tdtStatus);
#endif
    return error;
}

rtError_t Runtime::SetTsdProfCallback(const MsprofReporterCallback profReporterCallback) const
{
    UNUSED(profReporterCallback);

#if (!defined CFG_DEV_PLATFORM_PC)
    if (!IS_SUPPORT_CHIP_FEATURE(chipType_, RtOptionalFeatureType::RT_FEATURE_DEVICE_HAS_TS_DEAMON) && (tsdSetProfCallback_ == nullptr)) {
        return RT_ERROR_NONE;
    }

    RT_LOG(RT_LOG_INFO, "set tsd prof callback");

    COND_RETURN_WARN(tsdSetProfCallback_ == nullptr, RT_ERROR_DRV_SYM_TSD,
                     "handle is null, maybe no symbol TsdSetMsprofReporterCallback in libtsd_client.so.");

    const TDT_StatusType tdtStatus = tsdSetProfCallback_(profReporterCallback);
    if (tdtStatus != TSD_OK) {
        RT_LOG_INNER_MSG(RT_LOG_ERROR,
            "Set MsprofReporterCallback for tsdclient failed. tdt error=%u", tdtStatus);
        return RT_ERROR_DRV_TSD_ERR;
    }
#endif
    return RT_ERROR_NONE;
}

rtError_t Runtime::LookupAddrByFun(const void * const stubFunc, Context * const ctx, void ** const addr)
{
    uint64_t tmp_addr = 0U;
    Program *prog = nullptr;
    Module *programModule = nullptr;
    Runtime * const rt = Runtime::Instance();
    rtError_t error;
    const Kernel * const kernelObj = rt->kernelTable_.Lookup(stubFunc);
    if (unlikely(kernelObj == nullptr)) {
        RT_LOG(RT_LOG_ERROR, "Can not find kernel");
        goto LOOKUP_ERROR;
    }

    prog = kernelObj->Program_();
    if (unlikely(prog == nullptr)) {
        RT_LOG(RT_LOG_ERROR, "Can not find program");
        goto LOOKUP_ERROR;
    }

    programModule = ctx->GetModule(prog);
    if (unlikely(programModule == nullptr)) {
        RT_LOG(RT_LOG_ERROR, "Can not find module");
        goto MODULE_ERROR;
    }

    prog->LoadDependencies(ctx);

    error = programModule->GetFunction(kernelObj, &tmp_addr);
    if (unlikely(error != RT_ERROR_NONE)) {
        RT_LOG(RT_LOG_ERROR, "Get function failed by kernel");
        goto MODULE_ERROR;
    }

    *addr = RtValueToPtr<void *>(tmp_addr);
    Runtime::Instance()->PutProgram(prog);
    return RT_ERROR_NONE;

MODULE_ERROR:
    Runtime::Instance()->PutProgram(prog);
LOOKUP_ERROR:
    return RT_ERROR_KERNEL_LOOKUP;
}

rtError_t Runtime::LookupAddrAndPrefCntWithHandle(const void * const handlePtr, const void * const kernelInfoExt,
                                                  Context * const ctx, void ** const addr, uint32_t * const prefetchCnt)
{
    UNUSED(handlePtr);
    Program *program = nullptr;
    Module *mdl = nullptr;

    const Kernel *fftsKernel = kernelTable_.KernelInfoExtLookup((const char_t *)kernelInfoExt);
    RT_LOG(RT_LOG_INFO, "Look up fftsKernel, kernelInfoExt=%s.",
           RtPtrToPtr<const char_t *>(kernelInfoExt));
    COND_RETURN_ERROR(fftsKernel == nullptr, RT_ERROR_KERNEL_LOOKUP, "Can not find kernel.");

    program = fftsKernel->Program_();
    COND_RETURN_ERROR(program == nullptr, RT_ERROR_KERNEL_LOOKUP, "Can not find program.");

    std::function<void()> programGuardFunc = [program, this]() {
        this->PutProgram(program);
    };
    ScopeGuard programGuard(programGuardFunc);
    mdl = ctx->GetModule(program);
    COND_RETURN_ERROR(mdl == nullptr, RT_ERROR_KERNEL_LOOKUP, "Can not find module.");

    program->LoadDependencies(ctx);
    {
        uint64_t tmp_addr = 0U;
        rtError_t error = mdl->GetFunction(fftsKernel, &tmp_addr);
        COND_RETURN_ERROR(error != RT_ERROR_NONE, RT_ERROR_KERNEL_LOOKUP, "Get function failed by kernel.");

        *addr = RtValueToPtr<void *>(tmp_addr);
        uint32_t cnt = 0U;
        error = mdl->GetPrefetchCnt(fftsKernel, cnt);
        COND_RETURN_ERROR(error != RT_ERROR_NONE, RT_ERROR_KERNEL_LOOKUP, "Get prefetch cnt failed by kernel.");
        *prefetchCnt = cnt;
    }
    return RT_ERROR_NONE;
}

rtError_t Runtime::LookupAddrAndPrefCnt(const Kernel * const kernel, Context * const ctx,
                                        rtKernelDetailInfo_t * const kernelInfo)
{
    Program *prog = nullptr;
    Module *mdl = nullptr;

    prog = kernel->Program_();
    COND_RETURN_ERROR(prog == nullptr, RT_ERROR_KERNEL_LOOKUP, "Can not find program.");

    std::function<void()> progGuardFunc = [prog, this]() {
        this->PutProgram(prog);
    };
    ScopeGuard progGuard(progGuardFunc);
    mdl = ctx->GetModule(prog);
    COND_RETURN_ERROR(mdl == nullptr, RT_ERROR_KERNEL_LOOKUP, "Can not find module.");

    rtFunctionInfo_t * const functionInfo = kernelInfo->functionInfo;
    prog->LoadDependencies(ctx);
    {
        uint64_t tmpAddr1 = 0UL;
        uint64_t tmpAddr2 = 0UL;
        uint8_t functionNum = 1U;
        uint32_t cnt1 = 0U;
        uint32_t cnt2 = 0U;

        rtError_t error = mdl->GetFunction(kernel, &tmpAddr1, &tmpAddr2);
        COND_RETURN_ERROR(error != RT_ERROR_NONE, RT_ERROR_KERNEL_LOOKUP, "Get function failed by kernel.");
        error = mdl->GetPrefetchCnt(kernel, cnt1, cnt2);
        COND_RETURN_ERROR(error != RT_ERROR_NONE, RT_ERROR_KERNEL_LOOKUP, "Get prefetch cnt failed by kernel.");

        if (tmpAddr2 != 0UL) {
            functionNum = 2U;
        }
        kernelInfo->functionInfoNum = functionNum;
        functionInfo[0].pcAddr = RtValueToPtr<void *>(tmpAddr1);
        functionInfo[1].pcAddr = RtValueToPtr<void *>(tmpAddr2);
        functionInfo[0].prefetchCnt = cnt1;
        functionInfo[1].prefetchCnt = cnt2;
        functionInfo[0].mixType = kernel->GetMixType();
        functionInfo[1].mixType = kernel->GetMixType();

        const std::string kernelName = kernel->Name_();
        rtAddrKernelName_t mapInfo1 = {tmpAddr1, kernelName};
        rtAddrKernelName_t mapInfo2 = {tmpAddr2, kernelName};
        RT_LOG(RT_LOG_DEBUG, "tmpAddr1=%llu, tmpAddr2=%llu, kernel_name=%s", tmpAddr1, tmpAddr2, kernelName.c_str());
        (void)ctx->Device_()->AddAddrKernelNameMapTable(mapInfo1);
        (void)ctx->Device_()->AddAddrKernelNameMapTable(mapInfo2);
        (void)ctx->Device_()->AddAddrBinHandleMapTable(tmpAddr1, prog);
        (void)ctx->Device_()->AddAddrBinHandleMapTable(tmpAddr2, prog);
    }
    return RT_ERROR_NONE;
}

rtError_t Runtime::LookupAddrAndPrefCnt(const Kernel * const kernel, Context * const ctx,
                                        void ** const addr, uint32_t * const prefetchCnt)
{
    Program *prog = nullptr;
    Module *mdl = nullptr;

    prog = kernel->Program_();
    COND_RETURN_ERROR(prog == nullptr, RT_ERROR_KERNEL_LOOKUP, "Can not find program.");

    std::function<void()> progGuardFunc = [prog, this]() {
        this->PutProgram(prog);
    };
    ScopeGuard progGuard(progGuardFunc);
    mdl = ctx->GetModule(prog);
    COND_RETURN_ERROR(mdl == nullptr, RT_ERROR_KERNEL_LOOKUP, "Can not find module.");

    prog->LoadDependencies(ctx);
    {
        uint64_t tmp_addr = 0U;
        rtError_t error = mdl->GetFunction(kernel, &tmp_addr);
        COND_RETURN_ERROR(error != RT_ERROR_NONE, RT_ERROR_KERNEL_LOOKUP, "Get function failed by kernel.");

        *addr = RtValueToPtr<void *>(tmp_addr);
        uint32_t cnt = 0U;
        error = mdl->GetPrefetchCnt(kernel, cnt);
        COND_RETURN_ERROR(error != RT_ERROR_NONE, RT_ERROR_KERNEL_LOOKUP, "Get prefetch cnt failed by kernel.");
        *prefetchCnt = cnt;
        const std::string kernelName = kernel->Name_();
        rtAddrKernelName_t mapInfo = {tmp_addr, kernelName};
        RT_LOG(RT_LOG_DEBUG, "tmp_addr=%llu, kernel_name=%s", tmp_addr, kernelName.c_str());
        (void)ctx->Device_()->AddAddrKernelNameMapTable(mapInfo);
        (void)ctx->Device_()->AddAddrBinHandleMapTable(tmp_addr, prog);
    }
    return RT_ERROR_NONE;
}

RefObject<Context *> *Runtime::PrimaryContextRetain(const uint32_t devId)
{
    rtError_t err = RT_ERROR_NONE;

    COND_RETURN_ERROR_MSG_INNER(devId >= RT_MAX_DEV_NUM, nullptr,
        "Primary context retain failed, devId=%u, valid range is [0,%u)", devId, RT_MAX_DEV_NUM);

    COND_RETURN_ERROR_MSG_INNER((tsNum_ == 0U) || (tsNum_ > RT_MAX_TS_NUM), nullptr,
        "Primary context retain failed, tsNum=%u, valid range is [1,%u]", tsNum_, RT_MAX_TS_NUM);
    bool sentinelMode = Runtime::Instance()->GetSentinelMode();
    for (uint32_t i = 0U; i < tsNum_; i++) {
        if((sentinelMode) && (i == RT_TSC_ID)) {
 	            continue;
 	    }
        Context *ctx = nullptr;
        RefObject<Context *> &refObj = priCtxs_[devId][i];

        if (!refObj.IncRef()) {
            do {
                Device * const dev = DeviceRetain(devId, i);
                NULL_PTR_GOTO_MSG_INNER(dev, CTX_FREE, err, RT_ERROR_DEVICE_RETAIN);

                ctx = new(std::nothrow) Context(dev, true);
                NULL_PTR_GOTO_MSG_INNER(ctx, CTX_FREE, err, RT_ERROR_CONTEXT_NEW);
                RT_LOG(RT_LOG_INFO, "new Context ok, Runtime_alloc_size %zu", sizeof(Context));

                err = ctx->Setup();
                ERROR_GOTO_MSG_INNER(err, CTX_FREE, "Failed to setup context.");

                err = dev->UpdateTimeoutConfig();
                ERROR_GOTO_MSG_INNER(err, CTX_FREE, "Update time config of runtime failed, retCode=%#x.", static_cast<uint32_t>(err));

                ContextManage::InsertContext(ctx);
                refObj.SetVal(ctx);

                err = dev->RegisterAndLaunchDcacheLockOp(ctx);
                ERROR_GOTO_MSG_INNER(err, CTX_FREE, "device launch dcache lock op failed, retCode=%#x.", static_cast<uint32_t>(err));

                break;
            CTX_FREE:
                if (ctx != nullptr) {
                    (void)ctx->TearDown();
                }
                DELETE_O(ctx);
                refObj.SetVal(nullptr);
            } while (false);
        }

        const uint64_t refObjValue = refObj.GetRef();
        RT_LOG(RT_LOG_INFO, "Context inc ref, devId =%u, ts_id=%u, count=%#llx",devId,  i, refObjValue);
        ctx = refObj.GetVal();
        NULL_PTR_GOTO_MSG_INNER(ctx, CTX_DEC, err, RT_ERROR_CONTEXT_NULL);
        continue;

        CTX_DEC:
            if (!refObj.DecRef()) {
                refObj.ResetVal();
            }
            if (i == RT_TSV_ID) {
                RefObject<Context *> &tscRefObj = priCtxs_[devId][RT_TSC_ID];
                Context *tscCtx = tscRefObj.GetVal();
                if (tscCtx != nullptr) {
                    (void)tscCtx->TearDown();
                }
                DELETE_O(tscCtx);
                if (!tscRefObj.DecRef()) {
                    tscRefObj.ResetVal();
                }
            }
            return nullptr;
    }

    MsProfNotifyWhenSetDevice(devId);

    if (InnerThreadLocalContainer::GetTsId() == RT_TSC_ID) {
        return &priCtxs_[devId][RT_TSC_ID];
    } else {
        return &priCtxs_[devId][RT_TSV_ID];
    }
}

rtError_t Runtime::GetPrimaryCtxState(const int32_t devId, uint32_t *flags, int32_t *active)
{
    *flags = 0U; // 0 means SCHED_AUTO;
    *active = 0;
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM((static_cast<uint32_t>(devId) >= RT_MAX_DEV_NUM || devId < 0),
        RT_ERROR_DEVICE_ID, devId, "[0, " + std::to_string(RT_MAX_DEV_NUM) + ")");

    COND_RETURN_ERROR_MSG_INNER((tsNum_ == 0U) || (tsNum_ > RT_MAX_TS_NUM), RT_ERROR_DEVICE_ID,
        "Invalid para, tsNum=%u, valid range is [1,%u]", tsNum_, RT_MAX_TS_NUM);

    for (uint32_t i = 0U; i < tsNum_; i++) {
        RefObject<Context *> &refObj = priCtxs_[devId][i];
        const uint64_t refCnt = refObj.GetRef();
        RT_LOG(RT_LOG_INFO, "Default ctx state, devId =%u, ts_id=%u, count=%#llx", devId, i, refCnt);
        if (refCnt > 0ULL) {
            *active = 1; // 1 means ctx is in use
            return RT_ERROR_NONE;
        }
    }
    return RT_ERROR_NONE;
}

void Runtime::PrimaryContextCallBack(const Context * const ctx, const uint32_t devId)
{
    if (!isExiting_) {
        StreamStateCallbackManager::Instance().Notify(ctx->Device_()->PrimaryStream_(), false);
        DeviceStateCallbackManager::Instance().Notify(devId, true, DEV_CB_POS_FRONT, RT_DEVICE_STATE_RESET_PRE);
    }
}

void Runtime::PrimaryContextCallBackAfterTeardown(const uint32_t devId) const
{
    if (!isExiting_) {
        DeviceStateCallbackManager::Instance().Notify(devId, false, DEV_CB_POS_BACK, RT_DEVICE_STATE_RESET_POST);
    }
}

rtError_t Runtime::PrimaryContextRelease(const uint32_t devId, const bool isForceReset)
{
    bool ret = false;
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM(devId >= RT_MAX_DEV_NUM, RT_ERROR_DEVICE_ID, devId,
        "[0, " + std::to_string(RT_MAX_DEV_NUM) + ")");
    COND_RETURN_ERROR_MSG_INNER((tsNum_ == 0U) || (tsNum_ > RT_MAX_TS_NUM), RT_ERROR_CONTEXT_DEL,
        "release failed, tsNum=%u, valid range is [1,%u]", devId, RT_MAX_TS_NUM);
    const Device * const dev = GetDevice(devId, 0U);
    if (dev != nullptr) {
        dev->WaitForParsePrintf();
    }
    bool sentinelMode = Runtime::Instance()->GetSentinelMode();
    for (uint32_t i = tsNum_; i > 0U; i--) {
        const uint32_t ts_id = i - 1U;
        bool reset = false;  // must be false.
        RefObject<Context *> &refObj = priCtxs_[devId][ts_id];
        if((sentinelMode) && (ts_id == RT_TSC_ID)) {
 	        continue;
 	    }
        if (!isForceReset) {
            ret = refObj.TryDecRef(reset);
            const uint64_t refObjValue = refObj.GetRef();
            RT_LOG(RT_LOG_INFO, "Context TryDecRef, ts_id=%u, count=0x%llx, reset:%hhu", ts_id, refObjValue, reset);
            if (!reset) {
                continue;
            }
        } else {
            if (refObj.GetRef() == 0) {
                return RT_ERROR_CONTEXT_DEL;
            }
            while (!reset) {
                ret = refObj.TryDecRef(reset);
            }
        }
        Context *ctx = refObj.GetVal(false);
        if (unlikely(!ContextManage::CheckContextIsValid(ctx, true))) {
            refObj.ResetVal();
            return ret ? RT_ERROR_NONE : RT_ERROR_CONTEXT_DEL;
        }
        ctx->SetContextForceReset(isForceReset);
        refObj.SetPrimaryCtxCallBackFlag(true);
        PrimaryContextCallBack(ctx, devId);
        {
            const ContextProtect cp(ctx);
            (void)ctx->TearDown();
            if (ctx->DefaultStream_() != nullptr) {
                ctx->DefaultStream_()->SetContext(nullptr);
            }
        }
        if (ContextManage::EraseContextFromSet(ctx) != RT_ERROR_CONTEXT_NULL) {
            if (ctx->ContextOutUse() == 0ULL) {
                delete ctx;
                ctx = nullptr;
            }
        }
        InnerThreadLocalContainer::SetCurRef(nullptr);
        PrimaryContextCallBackAfterTeardown(devId);
        refObj.ResetVal();
    }
    return ret ? RT_ERROR_NONE : RT_ERROR_CONTEXT_DEL;
}

rtError_t Runtime::SetMsprofReporterCallback(MsprofReporterCallback callback)
{
    ProfCtrlCallbackManager::Instance().Notify(RT_PROF_CTRL_REPORTER, RtPtrToPtr<void *>(callback),
        sizeof(MsprofReporterCallback));

    ProfilingAgent::Instance().SetMsprofReporterCallback(callback);
    const Runtime * const rt = Runtime::Instance();
    return rt->SetTsdProfCallback(callback);
}

static void StartProfiler(const uint64_t profConfig, const uint32_t devId, Device * const dev)
{
    ProfStart(Runtime::Instance()->Profiler_(), profConfig, devId, dev);
    return;
}

static void StopProfiler(const uint64_t profConfig, const uint32_t devId, const Device * const dev)
{
    ProfStop(Runtime::Instance()->Profiler_(), profConfig, devId, dev);
    return;
}

void Runtime::OpenDeviceProfiling(const uint32_t devId, Device * const dev)
{
    rtError_t error = RT_ERROR_NONE;
    const uint32_t tsId = dev->DevGetTsId();

    profConfLock_.Lock();
    if (((devNeedSendProf_[devId][tsId] & PROF_AICPU_TRACE_MASK) != 0ULL)) {
        error = HandleAiCpuProfiling(devNeedSendProf_[devId][tsId], devId, true, devNeedSendProfSwitchHi_[devId][tsId]);
        if (error != RT_ERROR_NONE) {
            // allow aicpu profiling open failed, but set device normally
            RT_LOG(RT_LOG_WARNING, "HandleAiCpuProfiling failed, retCode=%#x, continue set device", error);
        } else {
            dev->SetDevProfStatus(PROF_AICPU_TRACE_MASK, true);
        }
    }

    if ((profiler_ != nullptr) && (devNeedSendProf_[devId][tsId] != 0ULL)) {
        StartProfiler(devNeedSendProf_[devId][tsId], devId, dev);
        dev->SetDevProfStatus(devNeedSendProf_[devId][tsId], true);
    }
    devNeedSendProf_[devId][tsId] = 0ULL;
    devNeedSendProfSwitchHi_[devId][tsId] = 0ULL;

    profConfLock_.Unlock();
}

void Runtime::NotifyProcWhenNewDevice(const uint32_t devId)
{
    const rtError_t error = SetMsprofReporterCallback(&MsprofReportData);
    if (error != MSPROF_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "SetMsprofReporterCallback Failed. ret= %d", error);
    }
    DeviceStateCallbackManager::Instance().ProfNotify(devId, true);
    return;
}

void Runtime::NotifyProcWhenReleaseDevice(const uint32_t devId) const
{
    DeviceStateCallbackManager::Instance().ProfNotify(devId, false);
    return;
}

void Runtime::MsProfNotifyWhenSetDevice(const uint32_t devId) const
{
    const auto profRet = MsprofNotifySetDevice(0, devId, true);
    if (profRet != MSPROF_ERROR_NONE) {
        RT_LOG(RT_LOG_WARNING, "MsprofNotifySetDevice failed, devId=%u, ret=%u", devId, profRet);
    }

    RT_LOG(RT_LOG_INFO, "MsprofNotifySetDevice success, devId=%u", devId);
    return;
}

void Runtime::InitAtrace(Device *dev, TraHandle &curAtraceHandle) const
{
    if (dev != nullptr && AtraceCreate != nullptr) {
        std::string curAtraceName =
            "RUNTIME_ATRACE_DEV" + std::to_string(dev->Id_()) + "_TS" + std::to_string(dev->DevGetTsId());
        curAtraceHandle = AtraceCreate(TracerType::TRACER_TYPE_SCHEDULE, curAtraceName.c_str());
        const TraEventHandle evHandle = AtraceEventCreate(curAtraceName.c_str());
        dev->SetAtraceEventHandle(evHandle);
        TraceEventAttr attr = {};
        attr.limitedNum = 1U;
        TraStatus ret = AtraceEventSetAttr(evHandle, &attr);
        if (ret != TRACE_SUCCESS) {
            RT_LOG(RT_LOG_WARNING, "Atrace event set attr failed , ret=%d", ret);
        } else {
            ret = AtraceEventBindTrace(evHandle, curAtraceHandle);
            if (ret != TRACE_SUCCESS) {
                RT_LOG(RT_LOG_WARNING, "Atrace event bind trace failed , ret=%d", ret);
            }
        }
    }
}

rtError_t Runtime::InitOpExecTimeout(Device *dev)
{
    if (timeoutConfig_.isInit) {
        return RT_ERROR_NONE;
    }

    const bool isSupportScaleMdy = dev->IsSupportFeature(
        RtOptionalFeatureType::RT_FEATURE_TASK_EXEC_TIMEOUT_SCALE_MODIFY);
    const bool isSupportOpTimeoutMs = dev->CheckFeatureSupport(TS_FEATURE_OP_EXEC_TIMEOUT_MS);
    std::lock_guard<std::mutex> lock(timeoutConfig_.mtx);
    if (timeoutConfig_.isInit) {
        return RT_ERROR_NONE;
    }

    if ((!isSupportScaleMdy) || (!isSupportOpTimeoutMs)) {
        timeoutConfig_.interval = GetKernelCreditScaleUS();
        timeoutConfig_.isInit = true;
        RT_LOG(RT_LOG_INFO, "Does not support op execute timeout with ms.");
        return RT_ERROR_NONE;
    }

    Driver* const curDrv = driverFactory_.GetDriver(NPU_DRIVER);
    COND_RETURN_ERROR(curDrv == nullptr, RT_ERROR_DRV_NULL, "get npu driver failed.");
    uint64_t timeoutInterval = 0ULL;
    const rtError_t error = curDrv->QueryOpExecTimeoutInterval(dev->Id_(), dev->DevGetTsId(), timeoutInterval);
    ERROR_RETURN(error,
        "Query op execute timeout failed, devId=%u, tsId=%u, retCode=%#x", dev->Id_(), dev->DevGetTsId(),
        static_cast<uint32_t>(error));

    timeoutConfig_.interval = static_cast<float64_t>(timeoutInterval) / RT_TIMEOUT_US_TO_NS;
    timeoutConfig_.isOpTimeoutMs =
        (timeoutConfig_.interval < RT_STARS_OP_TIMEOUT_THRESHOLD &&
        timeoutConfig_.interval > RT_STARS_TASK_KERNEL_CREDIT_SCALE_MIN) ?
        true : false;
    timeoutConfig_.isInit = true;
    RT_LOG(RT_LOG_INFO, "devId=%u, tsId=%u, op execute timeout interval=%" PRIu64 "ns, isOpTimeoutMs=%d.",
        dev->Id_(), dev->DevGetTsId(), timeoutInterval, timeoutConfig_.isOpTimeoutMs);
    return RT_ERROR_NONE;
}

Device *Runtime::DeviceRetain(const uint32_t devId, const uint32_t tsId)
{
    Device *dev = nullptr;
    rtError_t error = RT_ERROR_NONE;
    COND_RETURN_ERROR_MSG_INNER(devId > RT_MAX_DEV_NUM, nullptr,
        "Device retain failed, devId=%u, valid range is [0,%u]", devId, RT_MAX_DEV_NUM);
    COND_RETURN_ERROR_MSG_INNER(tsId > RT_MAX_TS_ID, nullptr,
        "Device retain failed, tsId=%u, valid range is [0,%u]", tsId, RT_MAX_TS_ID);
    RefObject<Device *> &refObj = devices_[devId][tsId];
    while (!refObj.IsValIdle()) {
        // wait idle
    }
    refObj.ChangeValStatus(refObj.STATUS_BUSY);
    if (!refObj.IncRef()) {
        do {
            TraHandle curAtraceHandle = -1;
            if (DlogReportStart != nullptr) {
                RT_LOG(RT_LOG_INFO, "[dlog api] DlogReportStart exist.");
                error = DlogReportStart(static_cast<int32_t>(devId), LOG_SAVE_MODE_DEF_RUN);
                COND_LOG(error != RT_ERROR_NONE, "call DlogReportStart api failed, retCode=%#x devId=%u",
                    error, devId);
            }
            rtError_t errorTrace = RT_ERROR_NONE;
            if (AtraceReportStart != nullptr) {
                RT_LOG(RT_LOG_INFO, "[dlog api] AtraceReportStart exist.");
                errorTrace = AtraceReportStart(static_cast<int32_t>(devId));
                COND_LOG(errorTrace != RT_ERROR_NONE, "call AtraceReportStart api failed, retCode=%#x devId=%u",
                    errorTrace, devId);
            }
            DeviceStateCallbackManager::Instance().Notify(devId, false, DEV_CB_POS_FRONT, RT_DEVICE_STATE_SET_PRE);
            error = startAicpuExecutor(devId, tsId);
            ERROR_GOTO(error, DEV_LOG_STOP, "Start aicpu executor failed, retCode=%#x, devId=%u", error, devId);

            dev = static_cast<Device *>(new (std::nothrow) RawDevice(devId));
            COND_GOTO_ERROR_MSG_AND_ASSIGN_CALL(ERR_MODULE_SYSTEM, dev == nullptr, DEV_FREE, error, RT_ERROR_DEVICE_NEW,
                "Failed to new device, device_id=%u.", devId);
            if (errorTrace == RT_ERROR_NONE) {
                dev->SetTsLogToHostFlag(RUNTIME_BUILD_VERSION);
            }

            RT_LOG(RT_LOG_INFO, "new dev ok id=%u, rawDevSize=%zu (bytes), ts_id=%u",
                devId, sizeof(RawDevice), tsId);
            error = dev->DevSetTsId(tsId);
            ERROR_GOTO(error, DEV_FREE, "Failed to set ts id.");

            error = dev->Init();
            if (GetIsUserSetSocVersion() && (GlobalContainer::GetRtChipType() != GlobalContainer::GetHardwareChipType())) {
                std::string inputSocVersion = GlobalContainer::GetUserSocVersion();
                ERROR_GOTO_MSG_INNER(RT_ERRORCODE_BASE, DEV_FREE, "The chip type=%d has been set,"
                    " device can not be created on real chip type=%d, the current input soc version(%s) does not match the NPU type.",
                    GlobalContainer::GetRtChipType(), GlobalContainer::GetHardwareChipType(), inputSocVersion.c_str());
            }

            ERROR_GOTO(error, DEV_FREE, "Failed to init device.");

            (void)DeviceAddObserver(dev);

            error = dev->Start();
            ERROR_GOTO(error, DEV_FREE, "Failed to start device.");

            if (!IS_SUPPORT_CHIP_FEATURE(chipType_, RtOptionalFeatureType::RT_FEATURE_DFX_ATRACE)) {
                InitAtrace(dev, curAtraceHandle);
            }
            if (curAtraceHandle < 0) {
                RT_LOG(RT_LOG_WARNING, "Can't create Atrace instance.");
            }
            dev->SetAtraceHandle(curAtraceHandle);

            refObj.SetVal(dev);
            NotifyProcWhenNewDevice(devId);
            OpenDeviceProfiling(devId, dev);
            break;

        DEV_FREE:
            DELETE_O(dev)
            (void)StopAicpuExecutor(devId, tsId);
        DEV_LOG_STOP:
            refObj.SetVal(nullptr);
            COND_PROC((AtraceReportStop != nullptr),
                AtraceReportStop(static_cast<int32_t>(devId));)
            COND_PROC((DlogReportStop != nullptr),
                DlogReportStop(static_cast<int32_t>(devId));)
        } while (false);
    }

    dev = refObj.GetVal();
    NULL_PTR_GOTO_MSG_INNER(dev, DEV_DEC, error, RT_ERROR_DEVICE_NULL);
    refObj.ChangeValStatus(refObj.STATUS_IDLE);

    return dev;

DEV_DEC:
    if (!refObj.DecRef()) {
        refObj.ResetVal();
    }
    refObj.ChangeValStatus(refObj.STATUS_IDLE);
    return nullptr;
}

Device *Runtime::GetDevice(const uint32_t devId, const uint32_t tsId, bool polling)
{
    COND_RETURN_ERROR_MSG_INNER(devId > RT_MAX_DEV_NUM, nullptr, "invalid drv devId=%u, valid range is [0,%u].",
        devId, RT_MAX_DEV_NUM);
    COND_RETURN_ERROR_MSG_INNER(tsId > RT_MAX_TS_ID, nullptr, "invalid tsId=%u, valid range is [0,%u].",
        tsId, RT_MAX_TS_ID);
    RefObject<Device *> &refObj = devices_[devId][tsId];

    return refObj.GetVal(polling);
}

void Runtime::DeviceRelease(Device *dev, const bool isForceReset)
{
    COND_RETURN_VOID_WARN(dev == nullptr, "ptr device is NULL!");
    const uint32_t devId = dev->Id_();
    const uint32_t tsId = dev->DevGetTsId();
    for (auto &refObj : devices_) {
        if (refObj[tsId].GetVal() != dev) {
            continue;
        }
        while (!refObj[tsId].IsValIdle()) {
            // wait idle
        }
        refObj[tsId].ChangeValStatus(refObj[tsId].STATUS_BUSY);
        if (!refObj[tsId].DecRef()) {
            profConfLock_.Lock();
            if ((profiler_ != nullptr) && (dev->GetDevProfStatus() != 0ULL)) {
                StopProfiler(dev->GetDevProfStatus(), devId, dev);
            }
            dev->SetDevProfStatus(0x0ULL, false);
            profConfLock_.Unlock();
            dev->SetDeviceRelease();
            (void)dev->Stop();
            refObj[tsId].ResetVal();
            if (!isExiting_) {
                NotifyProcWhenReleaseDevice(devId);
                RT_LOG(RT_LOG_INFO, "device_id=%u stop profiling", devId);
            }
            (void)SetWatchDogDevStatus(dev, RT_DEVICE_STATUS_NORMAL);
            if ((dev->GetAtraceHandle() >= 0) && (AtraceDestroy != nullptr)) {
                AtraceDestroy(dev->GetAtraceHandle());  // handle的合法性校验由Atrace模块校验
                AtraceEventDestroy(dev->GetAtraceEventHandle());
            }

            const uint32_t devRunningState = dev->GetDevRunningState();
            // 1.drvrelease
            DELETE_O(dev)

            // 2.tsdclose
            (void)StopAicpuExecutor(
                devId, tsId, (isForceReset && devRunningState == static_cast<uint32_t>(DEV_RUNNING_DOWN)));

            // 3.close log (in devicereset not in runtime destructor)
            if (!isExiting_) {
                COND_PROC((&AtraceReportStop != nullptr),
                    AtraceReportStop(static_cast<int32_t>(devId));)
                COND_PROC((&DlogReportStop != nullptr),
                    DlogReportStop(static_cast<int32_t>(devId));)
            }
            refObj[tsId].ChangeValStatus(refObj[tsId].STATUS_IDLE);
            // 1、2、3 order can not be changed (drv and log requirement)
            return;
        }
        refObj[tsId].ChangeValStatus(refObj[tsId].STATUS_IDLE);
    }
}

Device *Runtime::DeviceAddObserver(Device *dev)
{
    if (dev != nullptr) {
        if (streamObserver_ != nullptr) {
            dev->AddObserver(streamObserver_);
        }

        if (logger_ != nullptr) {
            dev->AddObserver(const_cast<EngineLogObserver *>(logger_->EngineLogObserver_()));
        }
    }

    return dev;
}

void Runtime::TsTimelineStart(const uint64_t profConfig, uint64_t &type, Device * const dev) const
{
    if ((profConfig & PROF_SCHEDULE_TIMELINE_MASK) != 0ULL) {
        if ((dev->GetDevProfStatus() & PROF_SCHEDULE_TIMELINE_MASK) == 0ULL) {
            type |= PROF_SCHEDULE_TIMELINE_MASK;
        } else {
            RT_LOG(RT_LOG_WARNING, "ts timeline has already enabled");
        }
    }
}

/* this function is for mini special case:PROF_TASK_TIME_MASK, PROF_SCHEDULE_TIMELINE_MASK
could both open ts timeline */
void Runtime::TsTimelineStart(const uint64_t profConfig, bool &needOpenTimeline, Device * const dev) const
{
    if ((profConfig & PROF_SCHEDULE_TIMELINE_MASK) != 0ULL) {
        if ((dev->GetDevProfStatus() & PROF_TASK_TIME_MASK) == 0ULL) { // acl not open timeline
            if ((dev->GetDevProfStatus() & PROF_SCHEDULE_TIMELINE_MASK) == 0ULL) {
                dev->SetDevProfStatus(PROF_SCHEDULE_TIMELINE_MASK, true);
                needOpenTimeline = true;
            } else {
                RT_LOG(RT_LOG_WARNING, "ts timeline has already enabled");
            }
        } else { // acl already open timeline
            RT_LOG(RT_LOG_WARNING, "ts timeline has already enabled");
            if ((dev->GetDevProfStatus() & PROF_SCHEDULE_TIMELINE_MASK) == 0ULL) {
                dev->SetDevProfStatus(PROF_SCHEDULE_TIMELINE_MASK, true);
            }
        }
    }

    if ((profConfig & PROF_TASK_TIME_MASK) != 0ULL) {
        if ((dev->GetDevProfStatus() & PROF_SCHEDULE_TIMELINE_MASK) == 0ULL) { // ge not open timeline
            if ((dev->GetDevProfStatus() & PROF_TASK_TIME_MASK) == 0ULL) {
                dev->SetDevProfStatus(PROF_TASK_TIME_MASK, true);
                needOpenTimeline = true;
            } else {
                RT_LOG(RT_LOG_WARNING, "ts timeline has already enabled");
            }
        } else { // ge already open timeline
            RT_LOG(RT_LOG_WARNING, "ts timeline has already enabled");
            if ((dev->GetDevProfStatus() & PROF_TASK_TIME_MASK) == 0ULL) {
                dev->SetDevProfStatus(PROF_TASK_TIME_MASK, true);
            }
        }
    }
}

void Runtime::AicMetricStart(const uint64_t profConfig, uint64_t &type, const Device * const dev) const
{
    const uint32_t devId = dev->Id_();
    if ((profConfig & PROF_AICORE_METRICS_MASK) != 0ULL) {
        if ((GetTsNum() == TS_NUM_ADC) && (dev->DevGetTsId() == 1U)) { // mdc
            RT_LOG(RT_LOG_WARNING, "mdc ts1 not support aicore metrics");
        } else {
            if ((dev->GetDevProfStatus() & PROF_AICORE_METRICS_MASK) == 0ULL) { // disabled
                type |= PROF_AICORE_METRICS_MASK;
            } else {
                RT_LOG(RT_LOG_WARNING, "aicore metrics has already enabled, devId=%u", devId);
            }
        }
    }
}
void Runtime::AivMetricStart(const uint64_t profConfig, uint64_t &type, const Device * const dev) const
{
    const uint32_t devId = dev->Id_();
    if ((profConfig & PROF_AIVECTORCORE_METRICS_MASK) != 0ULL) {
        if  ((GetTsNum() == TS_NUM_ADC) && (dev->DevGetTsId() == 1U)) { // mdc and ts1
            if ((dev->GetDevProfStatus() & PROF_AIVECTORCORE_METRICS_MASK) == 0ULL) { // disabled
                type |= PROF_AIVECTORCORE_METRICS_MASK;
            } else {
                RT_LOG(RT_LOG_WARNING, "aivector metrics has already enabled, devId=%u", devId);
            }
        } else {
            RT_LOG(RT_LOG_WARNING, "not support aivector metrics");
        }
    }
}
void Runtime::HwtsLogStart(const uint64_t profConfig, uint64_t &type, const Device * const dev) const
{
    RT_LOG(RT_LOG_DEBUG, "hwts log start execute!");

    if (((profConfig & PROF_TASK_TIME_MASK) == 0ULL) ||
        !IS_SUPPORT_CHIP_FEATURE(GetChipType(), RtOptionalFeatureType::RT_FEATURE_DFX_HWTS_LOG)) {
        return;
    }

    if ((dev->GetDevProfStatus() & PROF_TASK_TIME_MASK) == 0ULL) { // disabled
        type |= PROF_TASK_TIME_MASK;
    } else {
        RT_LOG(RT_LOG_WARNING, "hwts log has already enabled, devId=%u", dev->Id_());
    }
}

void Runtime::AiCpuTraceStart(const uint64_t profConfig, uint64_t &type, const Device * const dev) const
{
    const uint32_t devId = dev->Id_();
    if ((profConfig & PROF_AICPU_TRACE_MASK) == 0ULL) {
        return;
    }
    if ((dev->GetDevProfStatus() & PROF_AICPU_TRACE_MASK) != 0ULL) {
        RT_LOG(RT_LOG_WARNING, "aicpu profiling has already enabled, devId=%u", devId);
        return;
    }
    // disabled
    type |= PROF_AICPU_TRACE_MASK;
    return;
}

void Runtime::AiCpuModelTraceStart(const uint64_t profConfig, uint64_t &type, const Device * const dev) const
{
    RT_LOG(RT_LOG_INFO, "enter profConfig=%" PRIu64 ", type=%" PRIu64 ".", profConfig, type);
    if ((profConfig & PROF_AICPU_MODEL_MASK) == 0ULL) {
        return;
    }
    if ((dev->GetDevProfStatus() & PROF_AICPU_MODEL_MASK) != 0ULL) {
        RT_LOG(RT_LOG_WARNING, "aicpu model profiling has already enabled, devId=%u", dev->Id_());
        return;
    }
    // disabled
    type |= PROF_AICPU_MODEL_MASK;
    RT_LOG(RT_LOG_INFO, "AiCpuModelTraceStart set done, profConfig=%" PRIu64 ", type=%" PRIu64 "", profConfig, type);
    return;
}

rtError_t Runtime::TsProfilerStart(const uint64_t profConfig, int32_t numsDev, const uint32_t * const deviceList)
{
    bool flag = false;
    if (numsDev == -1) { // open all device
        Driver* const curDrv = driverFactory_.GetDriver(NPU_DRIVER);
        NULL_PTR_RETURN_MSG(curDrv, RT_ERROR_DRV_NULL);
        const rtError_t error = curDrv->GetDeviceCount(&numsDev);
        COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
            "Ts profiler start failed, get device count failed.");
        flag = true;
    }

    COND_RETURN_ERROR_MSG_INNER((tsNum_ == 0U) || (tsNum_ > RT_MAX_TS_NUM), RT_ERROR_INVALID_VALUE,
        "Ts profiler start failed, tsNum=%u, valid range is [1,%u].", tsNum_, RT_MAX_TS_NUM);
    profConfLock_.Lock();

    for (int32_t i = 0; i < numsDev; i++) {
        const uint32_t devId = flag ? static_cast<uint32_t>(i) : deviceList[i];
        uint64_t tmp_type = 0ULL;
        COND_PROC_RETURN_ERROR_MSG_INNER(devId > RT_MAX_DEV_NUM, RT_ERROR_INVALID_VALUE,
            profConfLock_.Unlock(), "Ts profiler start failed, devId=%u, valid range is [0,%u].",
            devId, RT_MAX_DEV_NUM);
        for (size_t j = 0U; j < tsNum_; j++) {
            RefObject<Device *> &refObj = devices_[devId][j];
            Device * const dev = refObj.GetVal();
            if (dev == nullptr) { // not set device
                devNeedSendProf_[devId][j] |= profConfig;
                continue;
            }
            // has set device
            COND_PROC_RETURN_ERROR_MSG_INNER(profiler_ == nullptr, RT_ERROR_INVALID_VALUE,
                profConfLock_.Unlock(), "Ts profiler start failed, profiler_ is null.");

            bool needOpenTimeline = false;
            TsTimelineStart(profConfig, tmp_type, dev);
            AicMetricStart(profConfig, tmp_type, dev);
            AivMetricStart(profConfig, tmp_type, dev);
            HwtsLogStart(profConfig, tmp_type, dev);
            if ((tmp_type == 0ULL) && (!needOpenTimeline)) {
                continue;
            }
            StartProfiler(tmp_type, devId, dev); // send task to ts
            dev->SetDevProfStatus(tmp_type, true);
        }
    }
    profConfLock_.Unlock();
    return RT_ERROR_NONE;
}

bool Runtime::isConfigForProfileLog(const uint64_t profConfig) const
{
    // profiling not use PROF_RUNTIME_PROFILE_LOG_MASK now.
    return (profConfig & PROF_RUNTIME_PROFILE_LOG_MASK) != 0ULL;
}

rtError_t Runtime::RuntimeProfileLogStart(const uint64_t profConfig, const int32_t numsDev, uint32_t * const deviceList)
{
    UNUSED(profConfig);
    UNUSED(numsDev);
    UNUSED(deviceList);
    NULL_PTR_RETURN_MSG(apiError_, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG(apiImpl_, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG(profiler_, RT_ERROR_INVALID_VALUE);

    profConfLock_.Lock();

    const Api * const impl = profiler_->GetApiProfileLogDecorator_();
    COND_PROC_RETURN_ERROR_MSG_INNER(impl == nullptr, RT_ERROR_INVALID_VALUE,
        profConfLock_.Unlock(), "Runtime profiler log start failed, impl is null.");

    if ((profileLogType_ & PROF_RUNTIME_PROFILE_LOG_MASK) == 0ULL) { // disabled
        apiError_->SetImpl(const_cast<Api *>(impl));
        profileLogType_ |= PROF_RUNTIME_PROFILE_LOG_MASK;
        profiler_->SetProfLogEnable(true);
        RT_LOG(RT_LOG_INFO, "Start");
    } else {
        RT_LOG(RT_LOG_WARNING, "api profile log has already enabled");
    }

    profConfLock_.Unlock();
    return RT_ERROR_NONE;
}

rtError_t Runtime::RuntimeProfileLogStop(const uint64_t profConfig, const int32_t numsDev, const uint32_t * const deviceList)
{
    UNUSED(profConfig);
    UNUSED(numsDev);
    UNUSED(deviceList);
    NULL_PTR_RETURN_MSG(apiError_, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG(apiImpl_, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG(profiler_, RT_ERROR_INVALID_VALUE);

    profConfLock_.Lock();
    if (profileLogType_ != 0ULL) { // enabled
        profiler_->SetProfLogEnable(false);
        apiError_->SetImpl(apiImpl_);
        profileLogType_ &= (~(PROF_RUNTIME_PROFILE_LOG_MASK));
        RT_LOG(RT_LOG_INFO, "Stop");
    } else {
        RT_LOG(RT_LOG_WARNING, "api profile log not enabled");
    }

    profConfLock_.Unlock();
    return RT_ERROR_NONE;
}

rtError_t Runtime::RuntimeApiProfilerStart(const uint64_t profConfig, int32_t numsDev,
    const uint32_t * const deviceList)
{
    bool flag = false;
    rtError_t error = RT_ERROR_NONE;

    NULL_PTR_RETURN_MSG(apiError_, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG(apiImpl_, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG(profiler_, RT_ERROR_INVALID_VALUE);

    if (numsDev == -1) { // open all device
        Driver* const curDrv = driverFactory_.GetDriver(NPU_DRIVER);
        NULL_PTR_RETURN_MSG(curDrv, RT_ERROR_DRV_NULL);
        error = curDrv->GetDeviceCount(&numsDev);
        COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
            "Start profiler of runtime api failed, get device count failed, retCode=%#x.", static_cast<uint32_t>(error));
        flag = true;
    }

    COND_RETURN_ERROR_MSG_INNER((numsDev != 0) && ((tsNum_ == 0U) || (tsNum_ > RT_MAX_TS_NUM)),
        RT_ERROR_INVALID_VALUE,
        "Start profiler of runtime api failed, tsNum=%u, valid range is [1,%u]", tsNum_, RT_MAX_TS_NUM);

    profConfLock_.Lock();

    const Api * const impl = profiler_->GetApiProfileDecorator();
    COND_PROC_RETURN_ERROR_MSG_INNER(impl == nullptr, RT_ERROR_INVALID_VALUE,
        profConfLock_.Unlock(), "Runtime api profiler start failed, impl is null.");

    if ((profConfig & PROF_RUNTIME_API_MASK) == 0ULL) {
        profConfLock_.Unlock();
        return RT_ERROR_NONE;
    }

    if ((apiProfilingType_ & PROF_RUNTIME_API_MASK) != 0ULL) {
        RT_LOG(RT_LOG_WARNING, "api profiling has already enabled");
        profConfLock_.Unlock();
        return RT_ERROR_NONE;
    }
    // disabled
    apiError_->SetImpl(const_cast<Api *>(impl));
    apiProfilingType_ |= PROF_RUNTIME_API_MASK;

    char_t profilingToStdOut[128] = {};
    const bool enabled = (mmGetEnv("GE_PROFILING_TO_STD_OUT", static_cast<char_t *>(profilingToStdOut),
                                   sizeof(profilingToStdOut)) == EN_OK);
    if (!enabled) {
        profiler_->SetApiProfEnable(true);
    }

    if (trackProfilingType_ == 0ULL) {
        profiler_->RuntimeProfilerStart();
    }
    for (int32_t i = 0; i < numsDev; i++) {
        const uint32_t devId = flag ? static_cast<uint32_t>(i) : deviceList[i];
        COND_PROC_RETURN_ERROR_MSG_INNER(devId > RT_MAX_DEV_NUM, RT_ERROR_INVALID_VALUE,
            profConfLock_.Unlock(), "Runtime api profiler start failed, devId=%u, valid range is [0,%u]",
            devId, RT_MAX_DEV_NUM);

        for (size_t j = 0U; j < tsNum_; j++) {
            RefObject<Device *> &refObj = devices_[devId][j];
            Device * const dev = refObj.GetVal();
            if (dev != nullptr) {
                dev->SetDevProfStatus(static_cast<uint64_t>(PROF_RUNTIME_API_MASK), true);
            }
        }
    }
    profConfLock_.Unlock();
    return RT_ERROR_NONE;
}

rtError_t Runtime::RuntimeTrackProfilerStart(const uint64_t profConfig, int32_t numsDev,
    const uint32_t * const deviceList, const uint32_t cacheFlag)
{
    bool flag = false;
    rtError_t error = RT_ERROR_NONE;

    if (numsDev == -1) { // open all device
        Driver* const curDrv = driverFactory_.GetDriver(NPU_DRIVER);
        NULL_PTR_RETURN_MSG(curDrv, RT_ERROR_DRV_NULL);
        error = curDrv->GetDeviceCount(&numsDev);
        COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
            "Start profiler of runtime track failed, get device count failed, retCode=%#x.", static_cast<uint32_t>(error));
        flag = true;
    }

    COND_RETURN_ERROR_MSG_INNER((tsNum_ == 0U) || (tsNum_ > RT_MAX_TS_NUM), RT_ERROR_INVALID_VALUE,
        "Start profiler of runtime track failed, tsNum=%u, valid range is [1,%u].", tsNum_, RT_MAX_TS_NUM);
    profConfLock_.Lock();

    if ((profConfig & PROF_RUNTIME_TRACE_MASK) != 0ULL) {
        if ((trackProfilingType_ & PROF_RUNTIME_TRACE_MASK) == 0ULL) { // disabled
            trackProfilingType_ |= PROF_RUNTIME_TRACE_MASK;
            if (apiProfilingType_ == 0ULL) {
                profiler_->RuntimeProfilerStart();
            }
            profiler_->SetTrackProfEnable(true, static_cast<uint32_t>(cacheFlag));
            SetTrackProfFlag(true);
            for (int32_t i = 0; i < numsDev; i++) {
                const uint32_t devId = flag ? i : deviceList[i];
                COND_PROC_RETURN_ERROR_MSG_INNER(devId > RT_MAX_DEV_NUM, RT_ERROR_INVALID_VALUE,
                    profConfLock_.Unlock(), "Runtime track profiler start failed, devId=%u, valid range is [0,%u]",
                    devId, RT_MAX_DEV_NUM);
                for (size_t j = 0U; j < tsNum_; j++) {
                    RefObject<Device *> &refObj = devices_[devId][j];
                    Device * const dev = refObj.GetVal();
                    if (dev != nullptr) {
                        dev->SetDevProfStatus(static_cast<uint64_t>(PROF_RUNTIME_API_MASK), true);
                    }
                }
            }
        } else {
            RT_LOG(RT_LOG_WARNING, "runtime track profiling has already enabled");
        }
    }
    profConfLock_.Unlock();
    return RT_ERROR_NONE;
}

rtError_t Runtime::AiCpuProfilerStart(
    const uint64_t profConfig, int32_t numsDev, const uint32_t *const deviceList, const uint64_t profSwitchHi)
{
    bool flag = false;
    rtError_t error;

    RT_LOG(RT_LOG_DEBUG,
        "profConfig=%#" PRIx64 ", profSwitchHi=%#" PRIx64 ", chipType_ = %d", profConfig, profSwitchHi, chipType_);
    if (!IS_SUPPORT_CHIP_FEATURE(chipType_, RtOptionalFeatureType::RT_FEATURE_PROFILING_AICPU)) {
        RT_LOG(RT_LOG_WARNING, "Not support aicpu profiling chipType_ = %d.", chipType_);
        return RT_ERROR_NONE;
    }

    if (numsDev == -1) { // open all device
        Driver* const curDrv = driverFactory_.GetDriver(NPU_DRIVER);
        NULL_PTR_RETURN_MSG(curDrv, RT_ERROR_DRV_NULL);
        error = curDrv->GetDeviceCount(&numsDev);
        COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
            "Start aicpu profiler failed, get device count failed, retCode=%#x.", static_cast<uint32_t>(error));
        flag = true;
    }

    COND_RETURN_ERROR_MSG_INNER((tsNum_ == 0U) || (tsNum_ > RT_MAX_TS_NUM), RT_ERROR_INVALID_VALUE,
        "Start aicpu profiler failed, tsNum=%u, valid range is [1,%u]", tsNum_, RT_MAX_TS_NUM);

    profConfLock_.Lock();

    for (int32_t i = 0; i < numsDev; i++) {
        const uint32_t devId = flag ? static_cast<uint32_t>(i) : deviceList[i];
        COND_PROC_RETURN_ERROR_MSG_INNER(devId > RT_MAX_DEV_NUM, RT_ERROR_INVALID_VALUE,
            profConfLock_.Unlock(), "Aicpu profiler start failed, devId=%u, valid range is [0,%u].",
            devId, RT_MAX_DEV_NUM);
        for (size_t j = 0U; j < tsNum_; j++) {
            RefObject<Device *> &refObj = devices_[devId][j];
            Device * const dev = refObj.GetVal();
            if (dev == nullptr) { // not set device
                devNeedSendProf_[devId][j] |= profConfig;
                devNeedSendProfSwitchHi_[devId][j] |= profSwitchHi;
            } else { // has set device
                COND_PROC_RETURN_ERROR_MSG_INNER(profiler_ == nullptr, RT_ERROR_INVALID_VALUE,
                    profConfLock_.Unlock(), "Aicpu profiler start failed, profiler_ is null.");
                // Compatible with the old code, set PROF_AICPU_MODEL_MASK and PROF_AICPU_TRACE_MASK to 0.
                uint64_t tmp_type = profConfig & 0xBFFFFFFFFFFFFFF7ULL;
                AiCpuTraceStart(profConfig, tmp_type, dev);
                AiCpuModelTraceStart(profConfig, tmp_type, dev);

                if (tmp_type != 0ULL) {
                    if (j == RT_TSC_ID) {
                        error = HandleAiCpuProfiling(tmp_type, devId, true, profSwitchHi); // open aicpu profiling
                        ERROR_PROC_RETURN_MSG_INNER(error, profConfLock_.Unlock(),
                            "Aicpu profiler start failed, devId=%u", devId);
                    }
                    dev->SetDevProfStatus(tmp_type, true);
                }
            }
        }
    }
    profConfLock_.Unlock();
    return RT_ERROR_NONE;
}

void Runtime::ReportSoftwareSqEnableToMsprof(void) const
{
    COND_RETURN_VOID_WARN((!(NpuDriver::CheckIsSupportFeature(0U, FEATURE_TRSDRV_IS_SQ_SUPPORT_DYNAMIC_BIND_VERSION))),
        "software sq is not supported.");

    MsprofCompactInfo compactInfo = {};
    compactInfo.level = MSPROF_REPORT_RUNTIME_LEVEL;
    compactInfo.type = RT_PROFILE_TYPE_SOFTWARE_SQ_ENABLE;
    compactInfo.timeStamp = MsprofSysCycleTime();
    compactInfo.threadId = GetCurrentTid();
    compactInfo.dataLen = static_cast<uint32_t>(sizeof(MsprofStreamExpandSpecInfo));
    compactInfo.data.streamExpandInfo.expandStatus = 1U;  // 1: enable software sq  0: disable software sq
    compactInfo.data.streamExpandInfo.reserve1 = 0U;
    compactInfo.data.streamExpandInfo.reserve2 = 0U;

    const auto error =
        MsprofReportCompactInfo(0, &compactInfo, static_cast<uint32_t>(sizeof(MsprofCompactInfo)));
    COND_RETURN_VOID(error != MSPROF_ERROR_NONE, "report software sq enable failed, ret=%d.", error);

    RT_LOG(RT_LOG_DEBUG, "report software sq enable successfully.");
}

/* profConfig mask like PROF_SCHEDULE_TIMELINE_MASK is in hisi/inc/toolchain/prof_acl_api.h */
rtError_t Runtime::ProfilerStart(const uint64_t profConfig, const int32_t numsDev, uint32_t *const deviceList,
    const uint32_t cacheFlag, const uint64_t profSwitchHi)
{
    rtError_t error;
    RT_LOG(RT_LOG_INFO,
        "profConfig=%#" PRIx64 ", profSwitchHi=%#" PRIx64 " , numsDev=%d", profConfig, profSwitchHi, numsDev);

    if (profileLogModeEnable_) {
        RT_LOG(RT_LOG_ERROR, "Profiler status is on, repeated opening failed");
        return RT_ERROR_PROF_STATUS;
    }

    const bool bProfileLog = isConfigForProfileLog(profConfig);
    bool bTaskTrack = 0U;
    if ((profConfig & PROF_TASK_TIME_MASK) != 0ULL) {
        bTaskTrack = 1U;
        RT_LOG(RT_LOG_INFO, "PROF_TASK_TIME_MASK need to report task track.");
    }
    if (bProfileLog && (!bTaskTrack)) {
        RT_LOG(RT_LOG_INFO, "Start with new profilerlog.");

        // status check:
        if ((apiProfilingType_ & PROF_RUNTIME_API_MASK) != 0ULL) {
            RT_LOG(RT_LOG_ERROR, "Profiler status error, apiProfilingType enabled");
            return RT_ERROR_PROF_STATUS;
        }

        if ((trackProfilingType_ & PROF_RUNTIME_TRACE_MASK) != 0ULL) {
            RT_LOG(RT_LOG_ERROR, "Profiler status error, trackProfilingType enabled");
            return RT_ERROR_PROF_STATUS;
        }

        COND_PROC((numsDev == 0), return RT_ERROR_NONE);

        error = RuntimeProfileLogStart(profConfig, numsDev, deviceList);
        COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
            "Runtime profiler log start failed, retCode=%#x", static_cast<uint32_t>(error));
        error = TsProfilerStart(profConfig, -1, nullptr);
        COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
            "Ts profiler start failed, retCode=%#x", static_cast<uint32_t>(error));
        profileLogModeEnable_ = true;
    } else {
        RT_LOG(RT_LOG_INFO, "Start with original profiler.");

        // status check:
        if ((profileLogType_ & PROF_RUNTIME_PROFILE_LOG_MASK) != 0ULL) {
            RT_LOG(RT_LOG_ERROR, "Profiler status error, profileLogType enabled");
            return RT_ERROR_PROF_STATUS;
        }

        error = RuntimeApiProfilerStart(profConfig, numsDev, deviceList);
        ERROR_RETURN(error, "Runtime api profiler start failed, retCode=%#x", error);
        if (numsDev != 0) {
            error = RuntimeTrackProfilerStart(profConfig, numsDev, deviceList, cacheFlag);
            ERROR_RETURN(error, "Runtime track profiler start failed, retCode=%#x", error);
            error = TsProfilerStart(profConfig, numsDev, deviceList);
            ERROR_RETURN(error, "Ts profiler start failed, retCode=%#x", error);
            error = AiCpuProfilerStart(profConfig, numsDev, deviceList, profSwitchHi);
            ERROR_RETURN(error,"Aicpu profiler start failed, retCode=%#x", error);
        }
    }

    ReportSoftwareSqEnableToMsprof();

    return RT_ERROR_NONE;
}

void Runtime::TsTimelineStop(const uint64_t profConfig, uint64_t &type, Device * const dev) const
{
    const uint32_t devId = dev->Id_();
    if ((profConfig & PROF_SCHEDULE_TIMELINE_MASK) != 0ULL) {
        if ((dev->GetDevProfStatus() & PROF_SCHEDULE_TIMELINE_MASK) != 0ULL) {
            type |= PROF_SCHEDULE_TIMELINE_MASK;
        } else {
            RT_LOG(RT_LOG_WARNING, "ts timeline has already disabled, devId=%u", devId);
        }
    }
}

/* this function is for mini special case:PROF_TASK_TIME_MASK, PROF_SCHEDULE_TIMELINE_MASK
could both open ts timeline */
void Runtime::TsTimelineStop(const uint64_t profConfig, bool &needCloseTimeline, Device *dev) const
{
    uint64_t tmp_type;
    const uint32_t devId = dev->Id_();
    if ((profConfig & PROF_SCHEDULE_TIMELINE_MASK) != 0ULL) {
        if ((dev->GetDevProfStatus() & PROF_TASK_TIME_MASK) != 0ULL) { // acl not close timeline
            if ((dev->GetDevProfStatus() & PROF_SCHEDULE_TIMELINE_MASK) != 0ULL) {
                tmp_type = (~(PROF_SCHEDULE_TIMELINE_MASK));
                dev->SetDevProfStatus(tmp_type, false);
            } else {
                RT_LOG(RT_LOG_WARNING, "PROF_TASK_TIME_MASK exist, devId=%u", devId);
            }
        } else { // acl already closed timeline
            if ((dev->GetDevProfStatus() & PROF_SCHEDULE_TIMELINE_MASK) != 0ULL) {
                tmp_type = (~(PROF_SCHEDULE_TIMELINE_MASK));
                dev->SetDevProfStatus(tmp_type, false);
                needCloseTimeline = true;
            }
        }
    }
    if ((profConfig & PROF_TASK_TIME_MASK) != 0ULL) {
        if ((dev->GetDevProfStatus() & PROF_SCHEDULE_TIMELINE_MASK) != 0ULL) { // ge not close timeline
            if ((dev->GetDevProfStatus() & PROF_TASK_TIME_MASK) != 0ULL) {
                tmp_type = (~(PROF_TASK_TIME_MASK));
                dev->SetDevProfStatus(tmp_type, false);
            } else {
                RT_LOG(RT_LOG_WARNING, "PROF_SCHEDULE_TIMELINE_MASK exist, devId=%u", devId);
            }
        } else { // ge already closed timeline
            if ((dev->GetDevProfStatus() & PROF_TASK_TIME_MASK) != 0ULL) {
                tmp_type = (~(PROF_TASK_TIME_MASK));
                dev->SetDevProfStatus(tmp_type, false);
                needCloseTimeline = true;
            }
        }
    }
}

void Runtime::AicMetricStop(const uint64_t profConfig, uint64_t &type, const Device * const dev) const
{
    const uint32_t devId = dev->Id_();
    if ((profConfig & PROF_AICORE_METRICS_MASK) != 0ULL) {
        if ((GetTsNum() == TS_NUM_ADC) && (dev->DevGetTsId() == 1U)) { // mdc
            RT_LOG(RT_LOG_WARNING, "mdc ts1 not support aicore metrics");
        } else {
            if ((dev->GetDevProfStatus() & PROF_AICORE_METRICS_MASK) != 0ULL) { // enabled
                type |= PROF_AICORE_METRICS_MASK;
            } else {
                RT_LOG(RT_LOG_WARNING, "aicore metrics has already disabled, devId=%u", devId);
            }
        }
    }
}
void Runtime::AivMetricStop(const uint64_t profConfig, uint64_t &type, const Device * const dev) const
{
    const uint32_t devId = dev->Id_();
    if ((profConfig & PROF_AIVECTORCORE_METRICS_MASK) != 0ULL) {
        if ((dev->GetDevProfStatus() & PROF_AIVECTORCORE_METRICS_MASK) != 0ULL) {
            if  ((GetTsNum() == TS_NUM_ADC) && (dev->DevGetTsId() == 1U)) { // mdc and ts1
                type |= PROF_AIVECTORCORE_METRICS_MASK;
            } else {
                RT_LOG(RT_LOG_WARNING, "not support aivector metrics");
            }
        } else {
            RT_LOG(RT_LOG_WARNING, "aivector metrics has already disabled, devId=%u", devId);
        }
    }
}
void Runtime::HwtsLogStop(const uint64_t profConfig, uint64_t &type, const Device * const dev) const
{
    RT_LOG(RT_LOG_DEBUG, "hwts log stop execute!");

    if ((profConfig & PROF_TASK_TIME_MASK) == 0ULL) {
        return;
    }

    if (((profConfig & PROF_TASK_TIME_MASK) == 0ULL) ||
        !IS_SUPPORT_CHIP_FEATURE(GetChipType(), RtOptionalFeatureType::RT_FEATURE_DFX_HWTS_LOG)) {
        return;
    }

    if ((dev->GetDevProfStatus() & PROF_TASK_TIME_MASK) != 0ULL) { // enabled
        type |= PROF_TASK_TIME_MASK;
    } else {
        RT_LOG(RT_LOG_WARNING, "hwts log has already disabled, devId=%u", dev->Id_());
    }
}

void Runtime::AiCpuTraceStop(const uint64_t profConfig, uint64_t &type, const Device * const dev) const
{
    const uint32_t devId = dev->Id_();
    if ((profConfig & PROF_AICPU_TRACE_MASK) != 0ULL) {
        if ((dev->GetDevProfStatus() & PROF_AICPU_TRACE_MASK) != 0ULL) {
            type |= PROF_AICPU_TRACE_MASK;
        } else {
            RT_LOG(RT_LOG_WARNING, "ai cpu profiling has already disabled, devId=%u", devId);
        }
    }
}

void Runtime::AiCpuModelTraceStop(const uint64_t profConfig, uint64_t &type, const Device * const dev) const
{
    if ((profConfig & PROF_AICPU_MODEL_MASK) != 0ULL) {
        if ((dev->GetDevProfStatus() & PROF_AICPU_MODEL_MASK) != 0ULL) {
            type |= PROF_AICPU_MODEL_MASK;
        } else {
            RT_LOG(RT_LOG_WARNING, "ai cpu model profiling has already disabled, devId=%u", dev->Id_());
        }
    }
}

rtError_t Runtime::TsProfilerStop(const uint64_t profConfig, int32_t numsDev, const uint32_t * const deviceList)
{
    bool flag = false;
    if (numsDev == -1) { // close all device
        Driver* const curDrv = driverFactory_.GetDriver(NPU_DRIVER);
        NULL_PTR_RETURN_MSG(curDrv, RT_ERROR_DRV_NULL);
        const rtError_t error = curDrv->GetDeviceCount(&numsDev);
        COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
            "Ts profiler stop failed, get device count failed, retCode=%#x", static_cast<uint32_t>(error));
        flag = true;
    }

    COND_RETURN_ERROR_MSG_INNER((tsNum_ == 0U) || (tsNum_ > RT_MAX_TS_NUM), RT_ERROR_INVALID_VALUE,
        "Ts profiler stop failed, tsNum=%u, valid range is [1,%u]", tsNum_, RT_MAX_TS_NUM);
    profConfLock_.Lock();

    for (int32_t i = 0; i < numsDev; i++) {
        const uint32_t devId = flag ? static_cast<uint32_t>(i) : deviceList[i];

        COND_PROC_RETURN_ERROR_MSG_INNER(devId > RT_MAX_DEV_NUM, RT_ERROR_INVALID_VALUE,
            profConfLock_.Unlock(), "Ts profiler stop failed, devId=%u, valid range is [0,%u].",
            devId, RT_MAX_DEV_NUM);
        for (uint32_t j = tsNum_; j > 0U; j--) {
            RefObject<Device *> &refObj = devices_[devId][j - 1U];
            Device * const dev = refObj.GetVal();
            if (dev == nullptr) { // not set device
                devNeedSendProf_[devId][j - 1U] &= (~profConfig);
                continue;
            }
            COND_PROC_RETURN_ERROR_MSG_INNER(profiler_ == nullptr, RT_ERROR_INVALID_VALUE,
                profConfLock_.Unlock(), "Ts profiler stop failed, profiler_ is null.");

            bool needCloseTimeline = false;
            uint64_t tmp_type = 0ULL;
            TsTimelineStop(profConfig, tmp_type, dev);
            AicMetricStop(profConfig, tmp_type, dev);
            AivMetricStop(profConfig, tmp_type, dev);
            HwtsLogStop(profConfig, tmp_type, dev);

            if ((tmp_type == 0ULL) && (!needCloseTimeline)) {
                continue;
            }
            StopProfiler(tmp_type, devId, dev); // send task to ts
            tmp_type = ~tmp_type;
            dev->SetDevProfStatus(tmp_type, false);
        }
    }
    profConfLock_.Unlock();
    return RT_ERROR_NONE;
}

rtError_t Runtime::AiCpuProfilerStop(
    const uint64_t profConfig, int32_t numsDev, const uint32_t *const deviceList, const uint64_t profSwitchHi)
{
    bool flag = false;
    rtError_t error;

    if (!IS_SUPPORT_CHIP_FEATURE(chipType_, RtOptionalFeatureType::RT_FEATURE_PROFILING_AICPU)) {
        RT_LOG(RT_LOG_WARNING, "Not support aicpu profiling chipType_ = %d.", chipType_);
        return RT_ERROR_NONE;
    }

    if (numsDev == -1) { // close all device
        Driver* const curDrv = driverFactory_.GetDriver(NPU_DRIVER);
        NULL_PTR_RETURN_MSG(curDrv, RT_ERROR_DRV_NULL);
        error = curDrv->GetDeviceCount(&numsDev);
        COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
            "GetDeviceCount failed, retCode=%#x", error);
        flag = true;
    }

    COND_RETURN_ERROR_MSG_INNER((tsNum_ == 0U) || (tsNum_ > RT_MAX_TS_NUM), RT_ERROR_INVALID_VALUE,
        "Aicpu profiler stop failed, tsNum=%u, valid range is [1,%u]", tsNum_, RT_MAX_TS_NUM);
    profConfLock_.Lock();

    for (int32_t i = 0; i < numsDev; i++) {
        const uint32_t devId = flag ? static_cast<uint32_t>(i) : deviceList[i];
        COND_PROC_RETURN_ERROR_MSG_INNER(devId > RT_MAX_DEV_NUM, RT_ERROR_INVALID_VALUE,
            profConfLock_.Unlock(), "Aicpu profiler stop failed, devId=%u, valid range is [0,%u]",
            devId, RT_MAX_DEV_NUM);
        for (uint32_t j = tsNum_; j > 0U; j--) {
            RefObject<Device *> &refObj = devices_[devId][j - 1U];
            Device * const dev = refObj.GetVal();
            if (dev == nullptr) { // not set device
                devNeedSendProf_[devId][j - 1U] &= (~profConfig);
                devNeedSendProfSwitchHi_[devId][j - 1U] &= (~profSwitchHi);
                continue;
            }
            COND_PROC_RETURN_ERROR_MSG_INNER(profiler_ == nullptr, RT_ERROR_INVALID_VALUE,
                profConfLock_.Unlock(), "Aicpu profiler stop failed, profiler_ is null.");

            // Compatible with the old code, set PROF_AICPU_MODEL_MASK and PROF_AICPU_TRACE_MASK to 0.
            uint64_t tmp_type = profConfig & 0xBFFFFFFFFFFFFFF7ULL;
            AiCpuTraceStop(profConfig, tmp_type, dev);
            AiCpuModelTraceStop(profConfig, tmp_type, dev);

            if (tmp_type == 0ULL) {
                continue;
            }
            if ((j - 1U) == RT_TSC_ID) {
                error = HandleAiCpuProfiling(tmp_type, devId, false, profSwitchHi); // stop aicpu profiling
                ERROR_PROC_RETURN_MSG_INNER(error, profConfLock_.Unlock(),
                    "Aicpu profiler stop failed, retCode=%#x devId=%u.", error, devId);
            }

            tmp_type = ~tmp_type;
            dev->SetDevProfStatus(tmp_type, false);
        }
    }
    profConfLock_.Unlock();
    return RT_ERROR_NONE;
}

rtError_t Runtime::isOperateAllDevice(int32_t * const numsDev, bool &flag)
{
    if (*numsDev == -1) { // close all device
        Driver* const curDrv = driverFactory_.GetDriver(NPU_DRIVER);
        NULL_PTR_RETURN_MSG(curDrv, RT_ERROR_DRV_NULL);
        const rtError_t error = curDrv->GetDeviceCount(numsDev);
        COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
            "Check operate of all device failed, get device count failed, retCode=%#x", static_cast<uint32_t>(error));
        flag = true;
    }
    return RT_ERROR_NONE;
}

int32_t Runtime::GetProfDeviceNum(const uint64_t profMask)
{
    int32_t cnt = 0;
    for (uint32_t i = 0U; i < RT_MAX_DEV_NUM; i++) {
        for (uint32_t j = tsNum_; j > 0U; j--) {
            RefObject<Device *> &refObj = devices_[i][j - 1U];
            const Device * const dev = refObj.GetVal();
            if ((dev != nullptr) && ((dev->GetDevProfStatus() & profMask) != 0ULL)) {
                cnt++;
            }
        }
    }
    return cnt;
}

rtError_t Runtime::RuntimeApiProfilerStop(const uint64_t profConfig, int32_t numsDev, const uint32_t * const deviceList)
{
    bool flag = false;
    rtError_t error = RT_ERROR_NONE;

    NULL_PTR_RETURN_MSG(apiError_, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG(apiImpl_, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG(profiler_, RT_ERROR_INVALID_VALUE);

    error = isOperateAllDevice(&numsDev, flag);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "Runtime api profiler stop failed, check operation failed, retCode=%#x", error);

    COND_RETURN_ERROR_MSG_INNER((numsDev != 0) && ((tsNum_ == 0U) || (tsNum_ > RT_MAX_TS_NUM)),
        RT_ERROR_INVALID_VALUE,
        "Runtime api profiler stop failed, tsNum=%u, valid range is [1,%u]", tsNum_, RT_MAX_TS_NUM);

    profConfLock_.Lock();

    if ((profConfig & PROF_RUNTIME_API_MASK) == 0UL) {
        profConfLock_.Unlock();
        return RT_ERROR_NONE;
    }
    // need stop runtime api profiling
    for (int32_t i = 0; i < numsDev; i++) {
        const uint32_t devId = flag ? static_cast<uint32_t>(i) : deviceList[i];
        COND_PROC_RETURN_ERROR_MSG_INNER(devId > RT_MAX_DEV_NUM, RT_ERROR_INVALID_VALUE,
            profConfLock_.Unlock(), "Runtime api profiler stop failed, devId=%u, valid range is [0,%u]",
            devId, RT_MAX_DEV_NUM);
        for (uint32_t j = tsNum_; j > 0U; j--) {
            RefObject<Device *> &refObj = devices_[devId][j - 1U];
            if (refObj.GetVal() != nullptr) { // already reset device
                Device * const dev = refObj.GetVal();
                constexpr uint64_t tmpType = (~(PROF_RUNTIME_API_MASK));
                dev->SetDevProfStatus(tmpType, false);
            }
        }
    }
    if (flag) { // close all device
        if (apiProfilingType_ != 0ULL) { // enabled
            profiler_->SetApiProfEnable(false);
            apiError_->SetImpl(apiImpl_);
            apiProfilingType_ &= (~(PROF_RUNTIME_API_MASK));
            if (trackProfilingType_ == 0ULL) {
                profiler_->RuntimeProfilerStop();
            }
        }
    } else {
        if (GetProfDeviceNum(PROF_RUNTIME_API_MASK) == 0) {
            profiler_->SetApiProfEnable(false);
            apiError_->SetImpl(apiImpl_);
            apiProfilingType_ &= (~(PROF_RUNTIME_API_MASK));
            if (trackProfilingType_ == 0ULL) {
                profiler_->RuntimeProfilerStop();
            }
        }
    }
    profConfLock_.Unlock();
    return RT_ERROR_NONE;
}

rtError_t Runtime::RuntimeTrackProfilerStop(const uint64_t profConfig, int32_t numsDev, const uint32_t * const deviceList)
{
    bool flag = false;
    rtError_t error = RT_ERROR_NONE;

    error = isOperateAllDevice(&numsDev, flag);
    ERROR_RETURN(error, "Runtime track profiler stop failed, check operation failed, retCode=%#x", error);

    COND_RETURN_ERROR_MSG_INNER(tsNum_ > RT_MAX_TS_NUM, RT_ERROR_INVALID_VALUE,
        "Runtime track profiler stop failed, tsNum=%u, valid range is [1,%u]", tsNum_, RT_MAX_TS_NUM);
    profConfLock_.Lock();

    if ((profConfig & PROF_RUNTIME_TRACE_MASK) != 0ULL) { // need stop runtime track profiling
        for (int32_t i = 0; i < numsDev; i++) {
            const uint32_t devId = flag ? static_cast<uint32_t>(i) : deviceList[i];
            COND_PROC_RETURN_ERROR_MSG_INNER(devId > RT_MAX_DEV_NUM, RT_ERROR_INVALID_VALUE,
                profConfLock_.Unlock(), "Runtime track profiler stop failed, devId=%u, valid range is [0,%u].",
                devId, RT_MAX_DEV_NUM);
            for (uint32_t j = tsNum_; j > 0U; j--) {
                RefObject<Device *> &refObj = devices_[devId][j - 1U];
                if (refObj.GetVal() != nullptr) { // already reset device
                    Device * const dev = refObj.GetVal();
                    constexpr uint64_t tmpType = (~(PROF_RUNTIME_TRACE_MASK));
                    dev->SetDevProfStatus(tmpType, false);
                }
            }
        }
        if (flag) { // close all device
            if (trackProfilingType_ != 0ULL) { // enabled
                profiler_->SetTrackProfEnable(false);
                SetTrackProfFlag(false);
                trackProfilingType_ &= (~(PROF_RUNTIME_TRACE_MASK));
                if (apiProfilingType_ == 0ULL) {
                    profiler_->RuntimeProfilerStop();
                }
            }
        } else {
            if (GetProfDeviceNum(PROF_RUNTIME_TRACE_MASK) == 0) {
                profiler_->SetTrackProfEnable(false);
                SetTrackProfFlag(false);
                trackProfilingType_ &= (~(PROF_RUNTIME_TRACE_MASK));
                if (apiProfilingType_ == 0ULL) {
                    profiler_->RuntimeProfilerStop();
                }
            }
        }
    }
    profConfLock_.Unlock();
    return RT_ERROR_NONE;
}

rtError_t Runtime::ProfilerStop(
    const uint64_t profConfig, const int32_t numsDev, uint32_t *const deviceList, const uint64_t profSwitchHi)
{
    rtError_t error;
    RT_LOG(RT_LOG_INFO,
        "ProfilerStop stop, profConfig=%#" PRIx64 ", numsDev=%d", profConfig, numsDev);

    bool bTaskTrack = 0U;
    if ((profConfig & PROF_TASK_TIME_MASK) != 0ULL) {
        bTaskTrack = 1U;
    }
    const bool bConfig4Log = isConfigForProfileLog(profConfig);
    const bool bProfileLog = bConfig4Log && (!bTaskTrack);
    if (bProfileLog != profileLogModeEnable_) {
        RT_LOG(RT_LOG_ERROR, "Profiler status error, ProfileLog config do not match!");
        return RT_ERROR_PROF_STATUS;
    }

    if (bProfileLog) {
        RT_LOG(RT_LOG_INFO, "ProfilerLog Stop Path");
        COND_PROC((numsDev == 0), return RT_ERROR_NONE);
        error = TsProfilerStop(profConfig, -1, nullptr);
        COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
            "Ts profiler stop failed, retCode=%#x", error);
        error = RuntimeProfileLogStop(profConfig, numsDev, deviceList);
        COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
            "Runtime api profiler stop failed, retCode=%#x", error);
        profileLogModeEnable_ = false;
    } else {
        RT_LOG(RT_LOG_INFO, "Profiler Stop Path");
        error = RuntimeApiProfilerStop(profConfig, numsDev, deviceList);
        COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
            "Runtime api profiler stop failed, retCode=%#x", error);
        if (numsDev != 0) {
            error = TsProfilerStop(profConfig, numsDev, deviceList);
            COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
                "Ts profiler stop failed, retCode=%#x", error);
            error = RuntimeTrackProfilerStop(profConfig, numsDev, deviceList);
            COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
                "Runtime track profiler stop failed, retCode=%#x", error);
            error = AiCpuProfilerStop(profConfig, numsDev, deviceList, profSwitchHi);
            COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
                "Aicpu profiler stop failed, retCode=%#x", error);
        }
    }
    kernelTable_.ResetAllKernelNameId();

    return RT_ERROR_NONE;
}

rtError_t Runtime::SetExceptCallback(const rtErrorCallback callback)
{
    excptCallBack_ = callback;
    return RT_ERROR_NONE;
}

rtError_t Runtime::SetTaskAbortCallBack(const char_t *regName, void *callback, void *args,
    TaskAbortCallbackType type)
{
    std::string moduleStr;
    (void)moduleStr.assign(RtPtrToPtr<const char_t *>(regName));
    const std::unique_lock<std::mutex> taskAbortLock(taskAbortMutex_);
    if (callback == nullptr) {
        (void)taskAbortCallbackMap_.erase(regName);
        RT_LOG(RT_LOG_DEBUG, "unregister stream state callback finish, name:%s.", regName);
        return RT_ERROR_NONE;
    }

    if (type == TaskAbortCallbackType::RT_SET_TASK_ABORT_CALLBACK) {
        taskAbortCallbackMap_[regName].callback = RtPtrToPtr<rtTaskAbortCallBack>(callback);
        taskAbortCallbackMap_[regName].callbackV2 = nullptr;
        taskAbortCallbackMap_[regName].args = args;
    } else if(type == TaskAbortCallbackType::RTS_SET_DEVICE_TASK_ABORT_CALLBACK) {
        COND_RETURN_OUT_ERROR_MSG_CALL(taskAbortCallbackMap_.count(regName) > 0, RT_ERROR_INVALID_VALUE,
            "regName:%s has already been registered.", regName);
        taskAbortCallbackMap_[regName].callback = nullptr;
        taskAbortCallbackMap_[regName].callbackV2 = RtPtrToPtr<rtsDeviceTaskAbortCallback>(callback);
        taskAbortCallbackMap_[regName].args = args;
    } else {
        RT_LOG(RT_LOG_ERROR, "register task abort callback type:%u is invalid.", type);
        return RT_ERROR_INVALID_VALUE;
    }

    taskAbortCallbackMap_[regName].type = type;
    RT_LOG(RT_LOG_INFO, "register task abort callback finish, regName:%s.", regName);
    return RT_ERROR_NONE;
}

rtError_t Runtime::SnapShotCallbackRegister(const rtSnapShotStage stage, rtSnapShotCallBack callback, void *args)
{
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM((stage < RT_SNAPSHOT_LOCK_PRE || stage > RT_SNAPSHOT_UNLOCK_POST),
        RT_ERROR_INVALID_VALUE,
        stage,
        "[0, " + std::to_string(RT_SNAPSHOT_UNLOCK_POST) + "]");
    NULL_PTR_RETURN_MSG_OUTER(callback, RT_ERROR_INVALID_VALUE);
    const std::unique_lock<std::mutex> snapShotMapLock(snapShotCallBackMapMutex_);
    std::list<SnapShotCallBackInfo> &callBackList = snapShotCallBackMap_[stage];
    const auto &callBackIter = std::find_if(callBackList.begin(),
        callBackList.end(),
        [callback](const SnapShotCallBackInfo &info) { return info.callback == callback; });
    if (callBackIter != callBackList.end()) {
        RT_LOG(RT_LOG_ERROR,
            "this callback function already registered for this stage, stage:%d, callback=%p.",
            stage,
            callback);
        return RT_ERROR_SNAPSHOT_REGISTER_CALLBACK_FAILED;
    }
    callBackList.push_back({callback, args});
    RT_LOG(RT_LOG_EVENT, "register snapshot callback finish, stage:%d, callback=%p.", stage, callback);
    return RT_ERROR_NONE;
}

rtError_t Runtime::SnapShotCallbackUnregister(const rtSnapShotStage stage, rtSnapShotCallBack callback)
{
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM((stage < RT_SNAPSHOT_LOCK_PRE || stage > RT_SNAPSHOT_UNLOCK_POST),
        RT_ERROR_INVALID_VALUE,
        stage,
        "[0, " + std::to_string(RT_SNAPSHOT_UNLOCK_POST) + "]");
    NULL_PTR_RETURN_MSG_OUTER(callback, RT_ERROR_INVALID_VALUE);
    const std::unique_lock<std::mutex> snapShotMapLock(snapShotCallBackMapMutex_);
    if (snapShotCallBackMap_.find(stage) == snapShotCallBackMap_.end()) {
        RT_LOG(RT_LOG_ERROR, "no callback function was registered for this stage, stage:%d.", stage);
        return RT_ERROR_INVALID_VALUE;
    }

    std::list<SnapShotCallBackInfo>& callBackList = snapShotCallBackMap_[stage];
    const auto &callBackIter = std::find_if(callBackList.begin(),
        callBackList.end(),
        [callback](const SnapShotCallBackInfo &info) { return info.callback == callback; });
    if (callBackIter == callBackList.end()) {
        RT_LOG(RT_LOG_ERROR, "this callback function was not registered for this stage, stage:%d, callback=%p.", stage, callback);
        return RT_ERROR_INVALID_VALUE;
    }
    (void)callBackList.erase(callBackIter);
    RT_LOG(RT_LOG_EVENT, "unregister snapshot callback successfully, stage:%d, callback=%p.", stage, callback);
    return RT_ERROR_NONE;
}

rtError_t Runtime::SnapShotCallback(const rtSnapShotStage stage)
{
    const std::unique_lock<std::mutex> SnapShotMapLock(snapShotCallBackMapMutex_);
    const auto& iter = snapShotCallBackMap_.find(stage);
    if (iter == snapShotCallBackMap_.end()) {
        RT_LOG(RT_LOG_INFO, "no callback function was registered for this stage, stage:%d.", stage);
        return RT_ERROR_NONE;
    }

    for (const auto& snapShotCallBackInfo : iter->second) {
        if (snapShotCallBackInfo.callback == nullptr) {
            continue;
        }

        for (int32_t devId = 0; devId < static_cast<int32_t>(RT_MAX_DEV_NUM); ++devId) {
            RefObject<Device*>& refObj = devices_[devId][0U];
            const Device* dev = refObj.GetVal();
            if (dev == nullptr) {
                continue;
            }
            uint32_t userDeviceId = 0U;
            rtError_t error = GetUserDevIdByDeviceId(static_cast<uint32_t>(devId), &userDeviceId);
            COND_RETURN_ERROR_MSG_INNER(
                error != RT_ERROR_NONE, error, "Get userDeviceId failed, error=%#x, drv devId=%u",
                static_cast<uint32_t>(error), devId);
            error = snapShotCallBackInfo.callback(userDeviceId, snapShotCallBackInfo.args);
            COND_RETURN_ERROR_MSG_INNER(
                error != RT_ERROR_NONE, RT_ERROR_SNAPSHOT_CALLBACK_FAILED,
                "snapshot call back func execution failed, drv devId=%d, user devId=%u, stage:%d, error=%#x", devId,
                userDeviceId, stage, static_cast<uint32_t>(error))
        }
    }
    return RT_ERROR_NONE;
}

rtError_t Runtime::AllocAiCpuStreamId(int32_t &id)
{
    const int32_t tmpId = aicpuStreamIdBitmap_->AllocId();
    COND_RETURN_ERROR_MSG_INNER(tmpId < 0, RT_ERROR_STREAM_AICPU_ALLOC_FAIL,
        "Alloc aicpu stream id=%d, can not be less than 0", tmpId);
    id = static_cast<int32_t>(static_cast<uint32_t>(tmpId) | macroValue_.baseAicpuStreamId);
    return RT_ERROR_NONE;
}

rtError_t Runtime::TaskAbortCallBack(int32_t devId, rtTaskAbortStage_t stage, uint32_t timeout)
{
    rtError_t error = RT_ERROR_NONE;
    uint32_t userDeviceId = 0U;
    error = Runtime::Instance()->GetUserDevIdByDeviceId(static_cast<uint32_t>(devId), &userDeviceId);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, "Get drvDeviceId:%d is err:%#x", devId,
        static_cast<uint32_t>(error));

    std::map<std::string, TaskAbortCallbackInfo> notifyMap;
    {
        const std::unique_lock<std::mutex> taskAbortLock(taskAbortMutex_);
        notifyMap.insert(taskAbortCallbackMap_.cbegin(), taskAbortCallbackMap_.cend());
    }

    for (const auto &info : notifyMap) {
        RT_LOG(RT_LOG_DEBUG, "notify [%s] task abort start.", info.first.c_str());
        TaskAbortCallbackType const type = info.second.type;
        void *args = info.second.args;
        if (type == TaskAbortCallbackType::RT_SET_TASK_ABORT_CALLBACK) {
            auto callback = info.second.callback;
            error = callback(userDeviceId, stage, timeout, args);
            ERROR_RETURN(error, "regName:%s retCode=%#x", info.first.c_str(), error);
        } else if (type == TaskAbortCallbackType::RTS_SET_DEVICE_TASK_ABORT_CALLBACK) {
            rtDeviceTaskAbortStage newStage = RT_DEVICE_TASK_ABORT_PRE;
            if (stage == RT_DEVICE_ABORT_POST) {
                newStage = RT_DEVICE_TASK_ABORT_POST;
            } 
            auto callback = info.second.callbackV2;
            error = callback(userDeviceId, newStage, timeout, args);
            ERROR_RETURN(error, "regName:%s retCode=%#x", info.first.c_str(), error);
        } else {
            RT_LOG(RT_LOG_ERROR, "notify task abort type:%u is invalid.", type);
            return error;
        }
        RT_LOG(RT_LOG_DEBUG, "notify [%s] task abort end.", info.first.c_str());
    }
    return error;
}

void Runtime::FreeAiCpuStreamId(const int32_t id)
{
    const uint32_t tmpId = static_cast<uint32_t>(id) & (~macroValue_.baseAicpuStreamId);
    if (tmpId < macroValue_.baseAicpuStreamId) {
        aicpuStreamIdBitmap_->FreeId(static_cast<int32_t>(tmpId));
    } else {
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "Free aicpu stream id=%d, tmpId=%u", id, tmpId);
    }
}

rtError_t Runtime::UnSubscribeReport(const uint64_t threadId, Stream * const stm)
{
    NULL_PTR_RETURN_MSG(cbSubscribe_, RT_ERROR_SUBSCRIBE_NULL);
    const rtError_t error = cbSubscribe_->Delete(threadId, stm);
    ERROR_RETURN_MSG_INNER(error, "unsubscribe fail, streamId=%d, threadId=%" PRIu64 ", retCode=%#x",
        stm->Id_(), threadId, static_cast<uint32_t>(error));
    stm->SetSubscribeFlag(StreamSubscribeFlag::SUBSCRIBE_NONE);
    return error;
}

rtError_t Runtime::SubscribeReport(const uint64_t threadId, Stream * const stm, void *evtNotify)
{
    NULL_PTR_RETURN_MSG(cbSubscribe_, RT_ERROR_SUBSCRIBE_NULL);
    const rtError_t error = cbSubscribe_->Insert(threadId, stm, evtNotify);
    ERROR_RETURN_MSG_INNER(error, "subscribe fail, streamId=%d, threadId=%" PRIu64 ", retCode=%#x",
        stm->Id_(), threadId, static_cast<uint32_t>(error));
    stm->SetSubscribeFlag(StreamSubscribeFlag::SUBSCRIBE_USER);
    return error;
}

rtError_t Runtime::UnSubscribeReport(Stream * const stm)
{
    NULL_PTR_RETURN_MSG(cbSubscribe_, RT_ERROR_SUBSCRIBE_NULL);
    const rtError_t error = cbSubscribe_->Delete(stm);
    ERROR_RETURN_MSG_INNER(error, "unsubscribe fail, streamId=%d, retCode=%#x",
        stm->Id_(), static_cast<uint32_t>(error));
    stm->SetSubscribeFlag(StreamSubscribeFlag::SUBSCRIBE_NONE);
    return error;
}

rtError_t Runtime::GetGroupIdByStreamId(const uint32_t devId, const int32_t streamId, uint32_t * const groupId)
{
    NULL_PTR_RETURN_MSG(cbSubscribe_, RT_ERROR_SUBSCRIBE_NULL);
    const rtError_t error = cbSubscribe_->GetGroupIdByStreamId(devId, streamId, groupId);
    COND_RETURN_DEBUG(error != RT_ERROR_NONE, error, "get groupId fail, streamId=%d, retCode=%#x", streamId, error);
    return error;
}

rtError_t Runtime::GetGroupIdByThreadId(const uint64_t threadId, uint32_t * const deviceId, uint32_t * const tsId,
                                        uint32_t * const groupId, const bool noLog)
{
    NULL_PTR_RETURN_MSG(cbSubscribe_, RT_ERROR_SUBSCRIBE_NULL);
    const rtError_t error = cbSubscribe_->GetGroupIdByThreadId(threadId, deviceId, tsId, groupId, noLog);
    COND_RETURN_DEBUG(error != RT_ERROR_NONE, error,
        "get groupId fail, threadId=%" PRIu64 ", retCode=%#x", threadId, error);
    return error;
}

rtError_t Runtime::GetEventByStreamId(const uint32_t devId, const int32_t streamId, Event ** const evt)
{
    NULL_PTR_RETURN_MSG(cbSubscribe_, RT_ERROR_SUBSCRIBE_NULL);
    const rtError_t error = cbSubscribe_->GetEventByStreamId(devId, streamId, evt);
    COND_RETURN_DEBUG(error != RT_ERROR_NONE, error, "get event fail, streamId=%d, retCode=%#x", streamId, error);
    return error;
}

rtError_t Runtime::GetNotifyByStreamId(const uint32_t devId, const int32_t streamId, Notify ** const notify)
{
    NULL_PTR_RETURN_MSG(cbSubscribe_, RT_ERROR_SUBSCRIBE_NULL);
    const rtError_t error = cbSubscribe_->GetNotifyByStreamId(devId, streamId, notify);
    COND_RETURN_DEBUG(error != RT_ERROR_NONE, error, "get notify fail, streamId=%d, retCode=%#x", streamId, error);
    return error;
}

rtError_t Runtime::GetCqIdByStreamId(const uint32_t devId, const int32_t streamId, uint32_t * const cqId)
{
    NULL_PTR_RETURN_MSG(cbSubscribe_, RT_ERROR_SUBSCRIBE_NULL);
    const rtError_t error = cbSubscribe_->GetCqIdByStreamId(devId, streamId, cqId);
    ERROR_RETURN_MSG_INNER(error, "get cqId fail, streamId=%d, retCode=%#x.", streamId, static_cast<uint32_t>(error));
    return error;
}

rtError_t Runtime::GetSqIdByStreamId(const uint32_t devId, const int32_t streamId, uint32_t * const sqId)
{
    NULL_PTR_RETURN_MSG(cbSubscribe_, RT_ERROR_SUBSCRIBE_NULL);
    const rtError_t error = cbSubscribe_->GetSqIdByStreamId(devId, streamId, sqId);
    ERROR_RETURN_MSG_INNER(error,
        "get sqId fail, streamId=%d, retCode=%#x.", streamId, static_cast<uint32_t>(error));
    return error;
}

rtError_t Runtime::GetThreadIdByStreamId(const uint32_t devId, const int32_t streamId, uint64_t * const threadId)
{
    NULL_PTR_RETURN_MSG(cbSubscribe_, RT_ERROR_SUBSCRIBE_NULL);
    const rtError_t error = cbSubscribe_->GetThreadIdByStreamId(devId, streamId, threadId);
    ERROR_RETURN_MSG_INNER(error,
        "get threadId fail, streamId=%d, retCode=%#x.", streamId, static_cast<uint32_t>(error));
    return error;
}

bool Runtime::IsHostFuncCbReg(const Stream * const stm) const
{
    NULL_PTR_RETURN_MSG(cbSubscribe_, false);
    return cbSubscribe_->IsExistInStreamMap(stm);
}

Context *Runtime::GetPriCtxByDeviceId(const uint32_t deviceId, uint32_t tsId)
{
    if (deviceId >= RT_MAX_DEV_NUM) {
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "Get primary context by deviceId=%u, valid range is [0,%u)", deviceId,
            RT_MAX_DEV_NUM);
        return nullptr;
    }

    if (tsId == MAX_UINT32_NUM) {
        tsId = InnerThreadLocalContainer::GetTsId();
    }

    if (tsId > RT_MAX_TS_ID) {
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "Get primary context failed, tsId=%u, valid range is [0,%u]", tsId,
            RT_MAX_TS_ID);
        return nullptr;
    }

    RefObject<Context *> &refObj = priCtxs_[deviceId][tsId];
    return refObj.GetPrimaryCtxCallBackFlag() ? refObj.GetVal(false) : refObj.GetVal();
}

RefObject<Context *> *Runtime::GetRefPriCtx(const uint32_t deviceId, const uint32_t tsId)
{
    if (deviceId >= RT_MAX_DEV_NUM) {
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "Get primary context failed, deviceId=%u, valid range is [0,%u)", deviceId,
            RT_MAX_DEV_NUM);
        return nullptr;
    }

    if (tsId > RT_MAX_TS_ID) {
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "Get primary context failed, tsId=%u, valid range is [0,%u]", tsId,
            RT_MAX_TS_ID);
        return nullptr;
    }
    return &priCtxs_[deviceId][tsId];
}

static rtError_t SetTimeoutConfigTaskSubmit(Stream * const stm, const rtTaskTimeoutType_t type,
    const uint32_t timeout)
{
    TaskInfo submitTask = {};
    rtError_t errorReason;
    TaskInfo *timeoutSetTask = stm->AllocTask(&submitTask, TS_TASK_TYPE_TASK_TIMEOUT_SET, errorReason);
    NULL_PTR_RETURN_MSG(timeoutSetTask, errorReason);

    rtError_t error = TimeoutSetTaskInit(timeoutSetTask, type, timeout);
    ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE,
        "Failed to init TaskTimeoutSetTask, stream_id=%d, task_id=%u, retCode=%#x.",
        stm->Id_(), static_cast<uint32_t>(timeoutSetTask->id), error);

    error = stm->Device_()->SubmitTask(timeoutSetTask);
    ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE, "Failed to submit TaskTimeoutSetTask, retCode=%#x", error);
    if (stm->IsCtrlStream()) {
        error = (dynamic_cast<CtrlStream*>(stm))->Synchronize();
    } else {
        error = stm->Synchronize();
    }
    ERROR_RETURN_MSG_INNER(error, "Failed to synchronize TaskTimeoutSetTask, retCode=%#x.", error);
    return error;

ERROR_RECYCLE:
    (void)stm->Device_()->GetTaskFactory()->Recycle(timeoutSetTask);
    return error;
}

static uint64_t ConvertTimeoutToUs(const uint64_t timeout, const RtTaskTimeUnitType timeUnitType)
{
    uint64_t opExcTaskTimeout;
    if (timeUnitType == RT_TIME_UNIT_TYPE_S) {
        opExcTaskTimeout = timeout * RT_TIMEOUT_S_TO_US;
    } else if (timeUnitType == RT_TIME_UNIT_TYPE_MS) {
        opExcTaskTimeout = timeout * RT_TIMEOUT_MS_TO_US;
    } else { // us
        opExcTaskTimeout = timeout;
    }
    COND_PROC(opExcTaskTimeout == MAX_UINT64_NUM, opExcTaskTimeout -= 1); // not support never timeout
    return opExcTaskTimeout;
}

rtError_t Runtime::SetTimeoutConfig(const rtTaskTimeoutType_t type, const uint64_t timeout,
    const RtTaskTimeUnitType timeUnitType)
{
    rtError_t error = RT_ERROR_NONE;

    COND_RETURN_ERROR_MSG_INNER((tsNum_ == 0U) || (tsNum_ > RT_MAX_TS_NUM), RT_ERROR_DEVICE_INVALID,
        "Set timeout config failed, tsNum=%u, valid range is [1,%u].", tsNum_, RT_MAX_TS_NUM);
    // AS31XM1 use ms to calculate timeout cfg
    if (socType_ == SOC_AS31XM1X) {
        timeoutConfig_.mtx.lock();
        timeoutConfig_.isCfgOpExcTaskTimeout = true;
        timeoutConfig_.opExcTaskTimeout = timeout * RT_TIMEOUT_MS_TO_US;
        timeoutConfig_.mtx.unlock();
        return RT_ERROR_NONE;
    }

    uint64_t opExcTaskTimeout = ConvertTimeoutToUs(timeout, timeUnitType);
    uint32_t taskTimeout;
    const Runtime * const rtInstance = Runtime::Instance();
    const rtChipType_t chipType = rtInstance->GetChipType();
    DevProperties prop;
    rtError_t ret = GET_DEV_PROPERTIES(chipType, prop);
    COND_RETURN_ERROR_MSG_INNER(ret != RT_ERROR_NONE, ret, "GetDevProperties failed.");
    if ((type == RT_TIMEOUT_TYPE_OP_EXECUTE) &&
        (prop.opExecuteTimeout)) {
        taskTimeout = opExcTaskTimeout / RT_TIMEOUT_MS_TO_US; // ms
    } else {
        taskTimeout = opExcTaskTimeout / RT_TIMEOUT_S_TO_US; // s
    }
    /* avoid deadlock when multi thread call the fuction frequently */
    static uint32_t cnt = 0U;
    if ((cnt % 100U) == 0U) {
        (void)mmSleep(1U);
    }
    cnt++;
#ifndef CFG_DEV_PLATFORM_PC
    for (auto &refObj : devices_) {
        for (size_t i = 0UL; i < tsNum_; i++) {
            if (refObj[i].GetRef() == 0ULL) {
                continue;
            }

            Device * const device = refObj[i].GetVal();
            if (device == nullptr) {
                continue;
            }

            if (socType_ == SOC_AS31XM1X) {
                // set op exec time out depend on aicpu in AS31XM1X
                ERROR_RETURN_MSG_INNER(StartAicpuSd(device),
                    "Set timeout config failed, start tsd open aicpu sd error.");
            }

            Stream * const stm = device->GetCtrlStream(device->PrimaryStream_());
            NULL_PTR_RETURN_MSG(stm, RT_ERROR_STREAM_NULL);
            if (device->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_TASK_ALLOC_FROM_STREAM_POOL)) {
                error = SetTimeoutConfigTaskSubmitDavid(stm, type, taskTimeout);
            } else {
                error = SetTimeoutConfigTaskSubmit(stm, type, taskTimeout);
            }
            ERROR_RETURN_MSG_INNER(error, "Failed to exe SetTimeoutConfigTaskSubmit, retCode=%#x.", error);
        }
    }
#endif
    timeoutConfig_.mtx.lock();
    if (type == RT_TIMEOUT_TYPE_OP_WAIT) {
        timeoutConfig_.isCfgOpWaitTaskTimeout = true;
        timeoutConfig_.opWaitTaskTimeout = timeout;
    } else if (type == RT_TIMEOUT_TYPE_OP_EXECUTE) {
        timeoutConfig_.isCfgOpExcTaskTimeout = true;
        timeoutConfig_.opExcTaskTimeout = opExcTaskTimeout;
    } else {
        // no operation
    }
    timeoutConfig_.mtx.unlock();
    return error;
}

void Runtime::LockGroupId(const uint32_t groupId)
{
    cbSubscribe_->LockGroupId(groupId);
}

void Runtime::UnlockGroupId(const uint32_t groupId)
{
    cbSubscribe_->UnlockGroupId(groupId);
}

rtError_t Runtime::ProcessForAllOpenDevice(const std::function<rtError_t(Device *)> &processFunc,
                                           const bool exitWhenError)
{
    rtError_t firstError = RT_ERROR_NONE;
    for (auto &refObj : devices_) {
        for (uint32_t i = 0U; i < tsNum_; i++) {
            if (refObj[i].GetRef() == 0ULL) {
                continue;
            }

            Device * const openDevice = refObj[i].GetVal();
            if (openDevice == nullptr) {
                continue;
            }
            RT_LOG(RT_LOG_INFO, "begin to process device[%u], tsId=%u.", openDevice->Id_(), i);
            const rtError_t error = processFunc(openDevice);
            RT_LOG(RT_LOG_INFO, "end to process device[%u], tsId=%u, retCode=%#x.", openDevice->Id_(), i, error);

            if (error == RT_ERROR_NONE) {
                continue;
            }
            if (exitWhenError) {
                RT_LOG(RT_LOG_ERROR, "process device[%u] failed, tsId=%u, retCode=%#x", openDevice->Id_(), i, error);
                return error;
            }
            if (firstError == RT_ERROR_NONE) {
                firstError = error;
            }
        }
    }
    return firstError;
}

rtMemType_t Runtime::GetTsMemType(rtMemRequestFeature_t featureType, uint64_t memSize)
{
    UNUSED(featureType);
    DevProperties props;
    rtError_t error = GET_DEV_PROPERTIES(Runtime::Instance()->GetChipType(), props);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, "GetDevProperties failed.");
    if (props.getTsMemTypeMethod == GetTsMemTypeMethod::GET_TS_MEM_TYPE_STATIC) {
        return RT_MEMORY_HBM;
    }

    Driver * const curDrv = driverFactory_.GetDriver(NPU_DRIVER);
    NULL_PTR_RETURN_MSG(curDrv, RT_ERROR_DRV_NULL);
    const bool isSupport = curDrv->CheckIfSupportNumaTs();
    if (isSupport) {
        return RT_MEMORY_TS;
    } else {
        constexpr rtMemType_t memType = RT_MEMORY_TS | static_cast<uint32_t>(RT_MEMORY_POLICY_HUGE_PAGE_ONLY);
        return (memSize > DEFAULT_PHY_PAGE_SIZE) ? memType : RT_MEMORY_HBM;
    }
}

static std::vector<std::string> SplitString(const std::string &str)
{
    std::vector<std::string> result;

    if (!isdigit(str[0U])) {
        return result;
    }

    std::string dataStr;
    char_t s[RT_SET_DEVICE_STR_MAX_LEN + 1U] = {0U};
    size_t dataCnt = 0U;
    size_t errCnt = 0U;
    for (size_t i = 0U; i < str.size(); i++) {
        if (isdigit(str[i]) != 0) {
            s[dataCnt] = str[i];
            dataCnt++;
            errCnt = 0U;
        } else {
            if (dataCnt != 0U) {
                dataStr = s;
                result.push_back(dataStr);
                dataCnt = 0U;
                (void)memset_s(s, static_cast<size_t>(RT_SET_DEVICE_STR_MAX_LEN + 1U), 0U,
                    static_cast<size_t>(RT_SET_DEVICE_STR_MAX_LEN + 1U));
            }

            if (str[i] != ',') {
                break;
            }

            errCnt++;
            if (errCnt > 1U) {
                break;
            }
        }
    }

    if (static_cast<uint32_t>(strlen(s)) != 0U) {
        dataStr = s;
        result.push_back(dataStr);
    }
    return result;
}

static bool IsdigitString(const std::string &strPara)
{
    for (uint32_t i = 0U; i < static_cast<uint32_t>(strPara.size()); i++) {
        if (!isdigit(strPara[i])) {
            return false;
        }
    }
    return true;
}

bool Runtime::IsSupportVisibleDevices() const
{
    return IS_SUPPORT_CHIP_FEATURE(chipType_, RtOptionalFeatureType::RT_FEATURE_DEVICE_VISIBLE);
}

bool Runtime::IsNeedChangeDeviceId(const uint32_t userDevId, const bool isDeviceSetResetOp) const
{
    if (!isSetVisibleDev) {
        return false;
    }

    /* 这里必须先判isDeviceSetResetOp再判mode, 编译态不需要切换deviceID */
    if (isDeviceSetResetOp) {
        return (!(userDevId == STUB_DEVICE_ID));
    }
    /* ctx is normal mode, need change deviceId. */
    return true;
}

rtError_t Runtime::ChgUserDevIdToDeviceId(const uint32_t userDevId, uint32_t * const deviceId, const bool isDeviceSetResetOp) const
{
    if (!IsNeedChangeDeviceId(userDevId, isDeviceSetResetOp)) {
        (*deviceId) = userDevId;
        return RT_ERROR_NONE;
    }

    if ((userDevId >= userDeviceCnt) || (deviceInfo[userDevId] == MAX_UINT32_NUM)) {
        RT_LOG(RT_LOG_ERROR, "input userDevId:%u is err, userDeviceCnt:%u, real deviceCnt:%u isSetVisibleDev:%d "
            "ASCEND_RT_VISIBLE_DEVICES:[%s], available visible devices:[%s]",
            userDevId, userDeviceCnt, deviceCnt, isSetVisibleDev, inputDeviceStr, availableDeviceStr);
        return RT_ERROR_DEVICE_ID;
    }
    (*deviceId) = deviceInfo[userDevId];
    RT_LOG(RT_LOG_INFO, "devId=%u, drv devId=%u, isDeviceSetResetOp=%u", userDevId, *deviceId, isDeviceSetResetOp);
    return RT_ERROR_NONE;
}

rtError_t Runtime::GetUserDevIdByDeviceId(const uint32_t deviceId, uint32_t * const userDevId,
    const bool isDeviceSetResetOp, const bool ignoredError, const bool checkLog) const
{
    if (!IsNeedChangeDeviceId(deviceId, isDeviceSetResetOp)) {
        (*userDevId) = deviceId;
        return RT_ERROR_NONE;
    }

    if ((deviceId >= deviceCnt) || (userDeviceInfo[deviceId] >= userDeviceCnt)) {
        if (!ignoredError) {
            RT_LOG(RT_LOG_ERROR, "Get userDevId failed, "
                "input deviceId:%u real deviceCnt:%u isSetVisibleDev:%d ASCEND_RT_VISIBLE_DEVICES:[%s].",
                deviceId, deviceCnt, isSetVisibleDev, inputDeviceStr);
        }
        return RT_ERROR_DEVICE_ID;
    }

    (*userDevId) = userDeviceInfo[deviceId];
    if (!checkLog) {
        RT_LOG(RT_LOG_INFO, "userDevId=%u, deviceId=%u, isDeviceSetResetOp=%u", *userDevId, deviceId, isDeviceSetResetOp);
    }
    return RT_ERROR_NONE;
}

rtError_t Runtime::BinaryLoad(const Device *const device, Program * const prog)
{
    void *devMem = nullptr;
    void *data = nullptr;
    bool readonly = true;
    uint32_t size = 0U;
    uint32_t alignSize = 0U;
    rtError_t error = RT_ERROR_NONE;
    Driver * const curDrv = device->Driver_();

    NULL_PTR_RETURN_MSG(prog, RT_ERROR_PROGRAM_NULL);
    size = prog->LoadSize();
    data = prog->Data();
    readonly = prog->IsReadOnly();
    error = prog->RefreshSymbolAddr();      // May differ from the initially registered binary, mainly due to the symbol address
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, RT_ERROR_PROGRAM_DATA, "refresh symbol address failed!");
    NULL_PTR_RETURN_MSG(data, RT_ERROR_PROGRAM_NULL);
    if (size == 0U) {
        RT_LOG(RT_LOG_ERROR, "Module load failed, prog size should be larger than 0, but current prog size is 0.");
        return RT_ERROR_PROGRAM_SIZE;
    }

    TIMESTAMP_BEGIN(rtBinaryLoad_DevMemAlloc);
    const uint32_t devSize = device->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DEVICE_SIMT) ?
        (size + PREFETCH_INCREASE_SIZE) : size;
    if (device->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_KERNEL_MEMORY_POOL)) {
        alignSize = (devSize + POOL_ALIGN_SIZE) & (~POOL_ALIGN_SIZE);
        devMem = device->GetKernelMemoryPool()->Allocate(static_cast<size_t>(alignSize), readonly);
    }

    if (devMem == nullptr) {
        error = curDrv->DevMemAlloc(&devMem, static_cast<uint64_t>(devSize + INSTR_ALIGN_SIZE),
            RT_MEMORY_HBM, device->Id_(), DEFAULT_MODULEID, true, readonly);
    }
    TIMESTAMP_END(rtBinaryLoad_DevMemAlloc);

    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "Malloc device program failed, retCode=%#x, size = %llu",
               static_cast<uint32_t>(error), static_cast<uint64_t>(devSize + INSTR_ALIGN_SIZE));
        return error;
    }
    prog->SetBinBaseAddr(devMem, device->Id_());

    // cce instr addr should align to 4K for ARM instr ADRP
    if ((RtPtrToPtr<uintptr_t>(devMem) & 0xFFFULL) != 0ULL) {
        // 2 ^ 12 is 4K align
        const uintptr_t devMemAlign = (((RtPtrToPtr<uintptr_t>(devMem)) >> 12U) + 1UL) << 12U;
        devMem = RtPtrToPtr<void *>(devMemAlign);
    }
    prog->SetBinAlignBaseAddr(devMem, device->Id_());

    TIMESTAMP_BEGIN(rtBinaryLoad_MemCopySync);
    error = curDrv->MemCopySync(devMem, static_cast<uint64_t>(size), data,
        static_cast<uint64_t>(size), RT_MEMCPY_HOST_TO_DEVICE);
    TIMESTAMP_END(rtBinaryLoad_MemCopySync);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR,  "Memcpy failed, size=%u(bytes), type=%d(RT_MEMCPY_HOST_TO_DEVICE), retCode=%#x",
            size, static_cast<int32_t>(RT_MEMCPY_HOST_TO_DEVICE), static_cast<uint32_t>(error));

        if ((device->GetKernelMemoryPool() != nullptr) && device->GetKernelMemoryPool()->Contains(prog->GetBinBaseAddr(device->Id_()))) {
            device->GetKernelMemoryPool()->Release(prog->GetBinBaseAddr(device->Id_()), alignSize);
        } else {
            (void)curDrv->DevMemFree(prog->GetBinBaseAddr(device->Id_()), device->Id_());
        }
        prog->SetBinBaseAddr(nullptr, device->Id_());
        prog->SetBinAlignBaseAddr(nullptr, device->Id_());
        return error;
    }

    RT_LOG(RT_LOG_DEBUG,
        "Load on device addr=%p, size=%u(bytes), program id=%u.", devMem, size, prog->Id_());
    return RT_ERROR_NONE;
}

rtError_t Runtime::GetVisibleDevices()
{
    if ((!isHaveDevice_) || (!IsSupportVisibleDevices())) {
        isSetVisibleDev = false;
        return RT_ERROR_NONE;
    }

    const char_t *inputStr = nullptr;
    MM_SYS_GET_ENV(MM_ENV_ASCEND_RT_VISIBLE_DEVICES, inputStr);
    if (inputStr == nullptr) {
        RT_LOG(RT_LOG_EVENT, "ASCEND_RT_VISIBLE_DEVICES param was not set");
        return RT_ERROR_NONE;
    }

    if (deviceInfo == nullptr) {
        deviceInfo = new (std::nothrow) uint32_t[RT_SET_DEVICE_STR_MAX_LEN];
        if (deviceInfo == nullptr) {
            return RT_ERROR_NONE;
        }
    }
    (void)memset_s(deviceInfo, static_cast<size_t>(sizeof(uint32_t) * RT_SET_DEVICE_STR_MAX_LEN), MAX_UINT32_NUM,
        static_cast<size_t>(sizeof(uint32_t) * RT_SET_DEVICE_STR_MAX_LEN));

    if (userDeviceInfo == nullptr) {
        userDeviceInfo = new (std::nothrow) uint32_t[RT_MAX_DEV_NUM];
        if (userDeviceInfo == nullptr) {
            return RT_ERROR_NONE;
        }
    }
    (void)memset_s(userDeviceInfo, static_cast<size_t>(sizeof(uint32_t) * RT_MAX_DEV_NUM), MAX_UINT32_NUM,
        static_cast<size_t>(sizeof(uint32_t) * RT_MAX_DEV_NUM));

    isSetVisibleDev = true;
    const drvError_t drvRet = drvGetDevNum(&deviceCnt);
    if ((drvRet != DRV_ERROR_NONE) || (deviceCnt > RT_MAX_DEV_NUM)) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] drvGetDevNum failed: drvRetCode=%d, deviceCnt=[%u,%u]!",
            static_cast<int32_t>(drvRet), deviceCnt, RT_MAX_DEV_NUM);
        retType = RT_GET_DRIVER_ERROR;
        return RT_ERROR_NONE;
    }

    uint32_t intDeviceLen = static_cast<uint32_t>(strlen(inputStr));
    intDeviceLen = (intDeviceLen > RT_SET_DEVICE_STR_MAX_LEN) ? RT_SET_DEVICE_STR_MAX_LEN : intDeviceLen;
    (void)memcpy_s(inputDeviceStr, static_cast<size_t>(RT_SET_DEVICE_STR_MAX_LEN + 1U), inputStr,
        static_cast<size_t>(intDeviceLen));
    inputDeviceStr[intDeviceLen] = '\0';

    std::string sourceStr = inputDeviceStr;
    std::vector<std::string> tokens = SplitString(sourceStr);
    uint32_t setDeviceCnt = 0U;
    for (uint32_t i = 0U; i < static_cast<uint32_t>(tokens.size()); i++) {
        if (!IsdigitString(tokens[i])) {
            break;
        }
        try {
            deviceInfo[setDeviceCnt] = static_cast<uint32_t>(std::stoi(tokens[i]));
        } catch (...) {
            deviceInfo[setDeviceCnt] = MAX_UINT32_NUM;
            RT_LOG(RT_LOG_EVENT, "ASCEND_RT_VISIBLE_DEVICES[%s] exceed MAX_UINT32_NUM.", tokens[i].c_str());
        }
        if (deviceInfo[setDeviceCnt] > (deviceCnt - 1U)) {
            deviceInfo[setDeviceCnt] = MAX_UINT32_NUM;
            break;
        }

        userDeviceInfo[deviceInfo[setDeviceCnt]] = setDeviceCnt;

        for (uint32_t j = 0U; j < setDeviceCnt; j++) {
            if ((setDeviceCnt > 0) && (deviceInfo[setDeviceCnt] < deviceInfo[setDeviceCnt - 1])) {
                RT_LOG(RT_LOG_ERROR,
                    "set ASCEND_RT_VISIBLE_DEVICES:[%s] error, it must be configured in ascending order.",
                    inputStr);
                retType = RT_ALL_ORDER_ERROR;
                return RT_ERROR_NONE;
            }
            if (deviceInfo[j] == deviceInfo[setDeviceCnt]) {
                RT_LOG(RT_LOG_ERROR, "set ASCEND_RT_VISIBLE_DEVICES:[%s] cannot be duplicated, input data range[0-%u)",
                    inputStr, deviceCnt);
                retType = RT_ALL_DUPLICATED_ERROR;
                return RT_ERROR_NONE;
            }
        }

        errno_t errNo = EOK;
        if (setDeviceCnt > 0) {
            errNo = strcat_s(availableDeviceStr, sizeof(availableDeviceStr), ",");
            COND_LOG_ERROR(errNo != EOK, "strcat_s failed, size=%zu(bytes), retCode=%d!", sizeof(availableDeviceStr), errNo);
        }
        errNo = strcat_s(availableDeviceStr, sizeof(availableDeviceStr), tokens[static_cast<size_t>(i)].c_str());
        COND_LOG_ERROR(errNo != EOK, "strcat_s failed, size=%zu(bytes), retCode=%d!", sizeof(availableDeviceStr), errNo);

        setDeviceCnt++;
        if (setDeviceCnt >= deviceCnt) {
            break;
        }
    }

    if (setDeviceCnt != 0U) {
        userDeviceCnt = setDeviceCnt;
    } else {
        RT_LOG(RT_LOG_ERROR, "set ASCEND_RT_VISIBLE_DEVICES:[%s] error, input data range[0-%u)",
            inputStr, deviceCnt);
        retType = RT_ALL_DATA_ERROR;
        return RT_ERROR_NONE;
    }

    retType = RT_ALL_DATA_OK;
    RT_LOG(RT_LOG_EVENT,
        "real deviceCnt:%u userDeviceCnt:%u isSetVisibleDev:%d ASCEND_RT_VISIBLE_DEVICES:[%s] available visible devices:[%s]",
        deviceCnt, userDeviceCnt, isSetVisibleDev, inputStr, availableDeviceStr);
    return RT_ERROR_NONE;
}

rtError_t Runtime::BinaryGetFunction(const Program * const prog, const uint64_t tilingKey,
                                     Kernel ** const funcHandle) const
{
    Program * const progTmp = const_cast<Program *>(prog);
    const uint32_t kernelCount = progTmp->kernelPos_;
    const Kernel *kernel = nullptr;
    if (kernelCount == 1U) {
        // static kernel, tilingkey is 0
        kernel = progTmp->GetKernelByTillingKey(0U);
    } else {
        kernel = progTmp->GetKernelByTillingKey(tilingKey);
    }
    COND_RETURN_ERROR_MSG_INNER(kernel == nullptr, RT_ERROR_KERNEL_NULL,
        "Can not find kernel by tilingKey[%" PRIu64 "].", tilingKey);
    *funcHandle = const_cast<Kernel *>(kernel);
    return RT_ERROR_NONE;
}

rtError_t Runtime::BinaryGetFunctionByName(const Program * const binHandle, const char *kernelName,
                                           Kernel ** const funcHandle) const
{
    const Program * const prog = binHandle;
    Program * const progTmp = const_cast<Program *>(prog);

    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    const Device * const dev = curCtx->Device_();
    NULL_PTR_RETURN_MSG(dev, RT_ERROR_DEVICE_NULL);
    if (!IS_SUPPORT_CHIP_FEATURE(dev->GetChipType(), RtOptionalFeatureType::RT_FEATURE_XPU)) {
        rtError_t ret = progTmp->CopySoAndNameToCurrentDevice();
        ERROR_RETURN(ret, "copy program to, failed retCode=%#x.", ret);
    }

    const Kernel *kernel = progTmp->GetKernelByName(kernelName);
    COND_RETURN_ERROR_MSG_INNER(kernel == nullptr, RT_ERROR_KERNEL_NULL,
        "Can not find kernel by name = %s.", kernelName);
    *funcHandle = const_cast<Kernel *>(kernel);
    return RT_ERROR_NONE;
}

TIMESTAMP_EXTERN(rtBinaryUnLoad_DevMemRelease);
rtError_t Runtime::BinaryUnLoad(const Device *const device, Program * const prog) const
{
    TIMESTAMP_BEGIN(rtBinaryUnLoad_DevMemRelease);
    rtError_t ret = RT_ERROR_NONE;
    if (prog->GetBinBaseAddr(device->Id_()) != nullptr) {
        if ((device->GetKernelMemoryPool() != nullptr) && device->GetKernelMemoryPool()->Contains(prog->GetBinBaseAddr(device->Id_()))) {
            const uint32_t devSize = device->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DEVICE_SIMT) ?
                (prog->LoadSize() + PREFETCH_INCREASE_SIZE) : prog->LoadSize();
            const uint32_t alignSize = (devSize + POOL_ALIGN_SIZE) & (~POOL_ALIGN_SIZE);
            device->GetKernelMemoryPool()->Release(prog->GetBinBaseAddr(device->Id_()), alignSize);
        } else {
            Driver * const curDrv = device->Driver_();
            ret = curDrv->DevMemFree(prog->GetBinBaseAddr(device->Id_()), device->Id_());
        }
        ERROR_RETURN(ret, "Free svm mem free failed, retCode=%#x, dev_id=%u.", ret, device->Id_());
        prog->SetBinBaseAddr(nullptr, device->Id_());
        prog->SetBinAlignBaseAddr(nullptr, device->Id_());
    }

    ret = prog->FreeKernelLiteralNameDevMem(device);
    ERROR_RETURN(ret, "Fail to FreeKernelLiteralNameDevMem, retCode=%#x, dev_id=%u.", ret, device->Id_());

    // 此处考虑prog的释放，做log记录，不return
    ret = prog->ProcCpuKernelH2DMem(false, const_cast<Device *const>(device));
    COND_PROC((ret != RT_ERROR_NONE),
        RT_LOG(RT_LOG_ERROR, "fail to free cpu so dev mem, retCode=%#x", ret));

    TIMESTAMP_END(rtBinaryUnLoad_DevMemRelease);
    return ret;
}

rtError_t Runtime::RegKernelLaunchFillFunc(const char* symbol, rtKernelLaunchFillFunc callback)
{
    NULL_PTR_RETURN_MSG_OUTER(symbol, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(callback, RT_ERROR_INVALID_VALUE);
    std::string symbolStr;
    (void)symbolStr.assign(RtPtrToPtr<const char_t *>(symbol));
    const std::unique_lock<std::mutex> regMapLock(mapMutex_);
    callbackMap_[symbolStr] = callback;
    RT_LOG(RT_LOG_INFO, "register callback finish, symbol:%s.", symbol);
    return RT_ERROR_NONE;
}

rtError_t Runtime::UnRegKernelLaunchFillFunc(const char* symbol)
{
    NULL_PTR_RETURN_MSG_OUTER(symbol, RT_ERROR_INVALID_VALUE);
    std::string symbolStr;
    (void)symbolStr.assign(RtPtrToPtr<const char_t *>(symbol));
    const std::unique_lock<std::mutex> regMapLock(mapMutex_);
    (void)callbackMap_.erase(symbolStr);
    RT_LOG(RT_LOG_INFO, "unregister callback finish, symbol:%s.", symbol);
    return RT_ERROR_NONE;
}

rtError_t Runtime::ExeCallbackFillFunc(std::string symbol, void *cfgAddr, uint32_t size)
{
    RT_LOG(RT_LOG_DEBUG, "symbol:%s, cfgAddr:%p , cfg len:%u.", symbol.c_str(), cfgAddr, size);
    const std::unique_lock<std::mutex> regMapLock(mapMutex_);
    auto iter = callbackMap_.find(symbol);
    if (iter != callbackMap_.end()) {
        RT_LOG(RT_LOG_INFO, "ExeCallbackFillFunc start, symbol:%s", symbol.c_str());
        iter->second(cfgAddr, size);
        RT_LOG(RT_LOG_INFO, "ExeCallbackFillFunc end");
    }
    return RT_ERROR_NONE;
}

rtError_t Runtime::GetElfOffset(void * const elfData, const uint32_t elfLen, uint32_t* offset) const
{
    NULL_PTR_RETURN_MSG(elfData, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG(offset, RT_ERROR_INVALID_VALUE);
    int32_t error = GetEhSizeOffset(elfData, elfLen, offset);
    if (error != 0) {
        return RT_ERROR_INVALID_VALUE;
    }
    return RT_ERROR_NONE;
}

// 调用方保证binFileName路径是realpath标准化之后的路径
rtError_t Runtime::GetKernelBinByFileName(const char_t *const binFileName,
                                         char_t **const buffer, uint32_t *length) const
{
    *length = 0U;
    std::ifstream file(binFileName, std::ios::binary | std::ios::in);
    COND_RETURN_ERROR(!file.is_open(), RT_ERROR_INVALID_VALUE,
        "file %s does not exist or is unaccessible. errno=%d, reason=%s",
         binFileName, errno, strerror(errno))

    const std::streampos begin = file.tellg();
    (void)file.seekg(0, std::ios::end);
    const std::streampos end = file.tellg();
    const uint32_t filelength = static_cast<uint32_t>(end - begin);
    if (filelength == 0U) {
        file.close();
        RT_LOG(RT_LOG_ERROR, "file %s is empty", binFileName);
        return RT_ERROR_INVALID_VALUE;
    }

    *buffer = new (std::nothrow) char_t[filelength]();
    if (*buffer == nullptr) {
        RT_LOG(RT_LOG_ERROR, "allocation of buffer failed filelength = %u", filelength);
        file.close();
        return RT_ERROR_MEMORY_ALLOCATION;
    }

    (void)file.seekg(0, std::ios::beg);
    (void)file.read(*buffer, static_cast<int64_t>(filelength));
    *length = filelength;
    file.close();
    return RT_ERROR_NONE;
}

rtError_t Runtime::GetEnvPath(std::string &binaryPath) const
{
    std::string libPath;
    const char_t *getPath = nullptr;
    MM_SYS_GET_ENV(MM_ENV_LD_LIBRARY_PATH, getPath);
    if (getPath == nullptr) {
        RT_LOG(RT_LOG_ERROR, "getenv fail.");
        return RT_ERROR_INVALID_VALUE;
    }

    libPath = getPath;
    const size_t mid = libPath.find("fwkacllib/lib64");
    if (mid == libPath.npos) {
        RT_LOG(RT_LOG_ERROR, "getenv fwkacllib/lib64 fail.");
        return RT_ERROR_INVALID_VALUE;
    }
    size_t diff;
    const size_t find = libPath.find(":", mid);
    const size_t findr = libPath.rfind(":", mid);
    if ((find == libPath.npos) || (findr == libPath.npos)) {
        RT_LOG(RT_LOG_ERROR, "find fail.");
        return RT_ERROR_INVALID_VALUE;
    }
    diff = find - findr;
    binaryPath = libPath.substr(findr + 1, diff - 1);
    binaryPath = binaryPath + "/";

    RT_LOG(RT_LOG_INFO, "patch:%s", binaryPath.c_str());
    return RT_ERROR_NONE;
}

rtError_t Runtime::GetKernelBin(const char_t *const binFileName,
                                char_t **const buffer, uint32_t *length) const
{
    std::string binaryPath;
    const rtError_t ret = GetEnvPath(binaryPath);
    if (ret != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "GetEnvPath fail.");
        return ret;
    }

    binaryPath = binaryPath + binFileName;
    const std::string binRealPath = RealPath(binaryPath);
    if (binRealPath.empty()) {
        RT_LOG(RT_LOG_ERROR, "Binary file path is invalid, path=[%s]", binaryPath.c_str());
        return RT_ERROR_INVALID_VALUE;
    }

    RT_LOG(RT_LOG_INFO, "kernel bin full path:%s", binRealPath.c_str());
    return GetKernelBinByFileName(binRealPath.c_str(), buffer, length);
}

rtError_t Runtime::GetBinBuffer(const rtBinHandle binHandle, const rtBinBufferType_t type, void **bin,
                                uint32_t *binSize) const
{
    Program * const programHdl = static_cast<Program *>(binHandle);
    RT_LOG(RT_LOG_INFO, "Start to get bin buffer, bin handle %p,  program id=%u, buffer type %d",
           binHandle, programHdl->Id_(), type);
    *binSize = programHdl->GetBinarySize();
    if (type == RT_BIN_HOST_ADDR) {
        *bin = programHdl->GetBinary();
    } else if (type == RT_BIN_DEVICE_ADDR) {
        Context *curCtx = CurrentContext();
        CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
        const rtError_t ret = programHdl->CopySoAndNameToCurrentDevice();
        COND_RETURN_ERROR_MSG_INNER(ret != RT_ERROR_NONE, ret, "copy bin to device failed device_id=%u, retCode=%#x.",
            curCtx->Device_()->Id_(), ret);
        *bin = programHdl->GetBinBaseAddr(curCtx->Device_()->Id_());
    } else {
        // do nothing
    }
    RT_LOG(RT_LOG_INFO, "Get bin addr %p, bin size %u", *bin, *binSize);
    return RT_ERROR_NONE;
}

rtError_t Runtime::FreeKernelBin(char_t * const buffer) const
{
    delete [] buffer;
    return RT_ERROR_NONE;
}

rtError_t Runtime::GetArchVersion(const char_t * const omArchVersion, rtArchType_t &omArchType) const
{
    const auto iter = archMap_.find(omArchVersion);
    if (iter != archMap_.end()) {
        omArchType = iter->second;
    } else {
        return RT_ERROR_INVALID_VALUE;
    }
    return RT_ERROR_NONE;
}

rtError_t Runtime::ModelCheckArchVersion(const char_t * const omArchVersion, const rtArchType_t archType) const
{
    DevProperties prop;
    rtError_t ret = GET_DEV_PROPERTIES(chipType_, prop);
    COND_RETURN_ERROR_MSG_INNER(ret != RT_ERROR_NONE, ret, "GetDevProperties failed.");
    rtArchType_t omArchType = ARCH_BEGIN;
    if (archType == ARCH_V100) {
        if ((prop.omArchVersion == OMArchVersion::omArchVersion_4) && (strcmp(omArchVersion, "4") == 0)) {
            return RT_ERROR_NONE;
        } else if ((prop.omArchVersion == OMArchVersion::omArchVersion_3) && (strcmp(omArchVersion, "3") == 0)) { // ，兼容性值
            return RT_ERROR_NONE;
        } else {
            RT_LOG(RT_LOG_DEBUG, "need to check archVersion");
        }
    }

    const rtError_t error = GetArchVersion(omArchVersion, omArchType);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "GetArchVersion failed,  please check omArchVersion=%s", omArchVersion);
        return RT_ERROR_INVALID_VALUE;
    }

    if (omArchType != archType) {
        RT_LOG(RT_LOG_ERROR, "ModelCheckArchVersion failed, omArchVersion=%s, archType=%d", omArchVersion, archType);
        return RT_ERROR_INSTANCE_VERSION;
    }

    return RT_ERROR_NONE;
}

rtError_t Runtime::CheckArchVersionIsCompatibility(const rtArchType_t inputArchType, const rtArchType_t hardwareArchType) const
{
    if (hardwareArchType == ARCH_V100) {
        DevProperties prop;
        rtError_t ret = GET_DEV_PROPERTIES(chipType_, prop);
        COND_RETURN_ERROR_MSG_INNER(ret != RT_ERROR_NONE, ret, "GetDevProperties failed.");
        if ((prop.checkArchVersionCompatibility == CheckArchVersionCompatibility::Arch_Version_Compat_V220) && (inputArchType == ARCH_C220)) {
            return RT_ERROR_NONE;
        } else if ((prop.checkArchVersionCompatibility == CheckArchVersionCompatibility::Arch_Version_Compat_V100) && (inputArchType == ARCH_C100)) {
            return RT_ERROR_NONE;
        } else {
            RT_LOG(RT_LOG_DEBUG, "need to check archVersion");
        }
    }
    if (inputArchType != hardwareArchType) {
        RT_LOG(RT_LOG_WARNING, "ModelCheckArchVersion failed, omArchVersion=%d, archType=%d", inputArchType, hardwareArchType);
        return RT_ERROR_INSTANCE_VERSION;
    }
    return RT_ERROR_NONE;
}

rtError_t Runtime::GetWatchDogDevStatus(uint32_t deviceId, rtDeviceStatus *deviceStatus)
{
    if (deviceId > RT_MAX_DEV_NUM) {
        RT_LOG(RT_LOG_ERROR, "input param is invalid. drv devId=%u", deviceId);
        return RT_ERROR_DEVICE_ID;
    }
    const std::unique_lock<std::mutex> lk(watchDogDevStatusMutex_);
    *deviceStatus = RT_DEVICE_STATUS_NORMAL;
    for (uint32_t i = 0U; i < RT_MAX_TS_NUM; i++) {
        if (watchDogDevStatus_[deviceId][i] == RT_DEVICE_STATUS_ABNORMAL) {
            *deviceStatus = RT_DEVICE_STATUS_ABNORMAL;
            break;
        }
    }
    return RT_ERROR_NONE;
}

rtError_t Runtime::SetWatchDogDevStatus(const Device *device, rtDeviceStatus deviceStatus)
{
    if (device != nullptr) {
        const uint32_t deviceId = device->Id_();
        const uint32_t tsId = device->DevGetTsId();
        if ((deviceId > RT_MAX_DEV_NUM) || (tsId >= RT_MAX_TS_NUM)) {
            RT_LOG(RT_LOG_ERROR, "input param is invalid. devId=%u, tsId=%u", deviceId, tsId);
            return RT_ERROR_DEVICE_ID;
        }
        const std::unique_lock<std::mutex> lk(watchDogDevStatusMutex_);
        if ((watchDogDevStatus_[deviceId][tsId] != RT_DEVICE_STATUS_ABNORMAL) &&
            (deviceStatus == RT_DEVICE_STATUS_ABNORMAL)) {
            RT_LOG(RT_LOG_EVENT, "There is errInfo of devId=%u, tsId=%u", deviceId, tsId);
        }
        if (deviceStatus != RT_DEVICE_STATUS_NORMAL) {
            TrySaveAtraceLogs(device->GetAtraceEventHandle());
        }
        watchDogDevStatus_[deviceId][tsId] = deviceStatus;
        return RT_ERROR_NONE;
    } else {
        return RT_ERROR_DEVICE_NULL;
    }
}

void Runtime::ReadStreamSyncModeFromConfigIni(void)
{
    const char_t *env = nullptr;
    MM_SYS_GET_ENV(MM_ENV_ASCEND_LATEST_INSTALL_PATH, env);
    if ((env == nullptr) || (*env == '\0')) {
        RT_LOG(RT_LOG_WARNING, "can not read ASCEND_LATEST_INSTALL_PATH! using non esched mode");
        isStreamSyncEsched_ = false;
        return;
    }

    const std::string rtCfgFile("/runtime/conf/RuntimeConfig.ini");
    const std::string path(env);
    const std::string fileName = path + rtCfgFile;
    const std::string key("IsStreamSyncEschedMode=");

    int32_t valueStreamSyncEschedMode = 0;
    const bool ret = GetConfigIniValueInt32(fileName, key, valueStreamSyncEschedMode);
    isStreamSyncEsched_ = (ret && (valueStreamSyncEschedMode == 1)) ? true : false;
    RT_LOG(RT_LOG_INFO, "IsStreamSyncEschedMode=%d", isStreamSyncEsched_);
    return;
}

Context *Runtime::CurrentContext() const
{
    Context * const curCtx = InnerThreadLocalContainer::GetCurCtx();
    if (curCtx != nullptr) {
        return curCtx;
    }

    RefObject<Context *> * const curRef = InnerThreadLocalContainer::GetCurRef();
    if (curRef != nullptr) {
        return curRef->GetPrimaryCtxCallBackFlag() ? curRef->GetVal(false) : curRef->GetVal();
    }
    return nullptr;
}

rtError_t Runtime::InitAiCpuCnt()
{
    int64_t aicpuNum = DEFAULT_AICPU_INVALID_NUM;
    const drvError_t drvRet = halGetDeviceInfo(workingDev_, MODULE_TYPE_AICPU, INFO_TYPE_CORE_NUM, &aicpuNum);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "Call halGetDeviceInfo failed:drvRetCode=%u, module type=%d, info type=%d.",
            static_cast<uint32_t>(drvRet), MODULE_TYPE_AICPU, INFO_TYPE_CORE_NUM);
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    aicpuCnt_ = aicpuNum;
    RT_LOG(RT_LOG_DEBUG, "aicpuNum=%" PRId64, aicpuNum);
    return RT_ERROR_NONE;
}

driverType_t Runtime::GetDriverType(void) const
{
    const driverType_t drvType = NPU_DRIVER;
    return drvType;
}

void Runtime::StreamSyncEschedLock(void)
{
    StreamSyncEschedMutex_.lock();
}

void Runtime::StreamSyncEschedUnLock(void)
{
    StreamSyncEschedMutex_.unlock();
}

void Runtime::SetGlobalErr(const rtError_t errcode) const
{
    InnerThreadLocalContainer::SetGlobalErr(errcode);
    ContextManage::SetGlobalErrToCtx(errcode);
}

rtError_t Runtime::GetNpuDeviceCnt(int32_t &cnt)
{
    const auto npuDrv = driverFactory_.GetDriver(NPU_DRIVER);
    NULL_PTR_RETURN_MSG(npuDrv, RT_ERROR_API_NULL);
    int32_t tmpCnt = 1;
    const rtError_t error = npuDrv->GetDeviceCount(&tmpCnt);
    if (error == RT_ERROR_NONE) {
        cnt = tmpCnt;
    }
    return error;
}

rtError_t Runtime::CreateReportRasThread()
{
    const std::lock_guard<std::mutex> lk(hbmRasMtx_);
    // 仅创建一个线程用于上报ras
    if (hbmRasThread_ != nullptr) {
        return RT_ERROR_NONE;
    }

    void * const reportRas = ValueToPtr(THREAD_REPORTRAS);
    constexpr const char_t* threadName = "REPORT_RAS";
    hbmRasThread_.reset(OsalFactory::CreateThread(threadName, &ras_, reportRas));
    NULL_PTR_RETURN(hbmRasThread_, RT_ERROR_MEMORY_ALLOCATION);
    hbmRasThreadRunFlag_ = true;
    const int32_t error = hbmRasThread_->Start();
    if (error != EN_OK) {
        hbmRasThreadRunFlag_ = false;
        hbmRasThread_.reset(nullptr);
        return RT_ERROR_MEMORY_ALLOCATION;
    }
    RT_LOG(RT_LOG_EVENT, "Start report ras thread success!");
    return RT_ERROR_NONE;
}

void Runtime::DestroyReportRasThread(void)
{
    const std::lock_guard<std::mutex> lk(hbmRasMtx_);
    if (hbmRasThread_ != nullptr) {
        hbmRasThreadRunFlag_ = false;
        hbmRasThread_->Join();
        RT_LOG(RT_LOG_EVENT, "Join report ras thread OK.");
        hbmRasThread_.reset(nullptr);
    }
}

void RuntimeRas::Run(const void * const param)
{
    UNUSED(param);
    Runtime::Instance()->ReportRasRun();
}

void Runtime::ReportRasRun(void)
{
    if (!IS_SUPPORT_CHIP_FEATURE(GetChipType(), RtOptionalFeatureType::RT_FEATURE_DFX_REPORT_RAS)) {
        RT_LOG(RT_LOG_WARNING, "ChipType %d does not support reporting RAS.",
            static_cast<int32_t>(GetChipType()));
        return;
    }

    GlobalStateManager::GetInstance().IncBackgroundThreadCount(__func__);
    while (hbmRasThreadRunFlag_ && !isExiting_ && threadGuard_->GetMonitorStatus()) {
        GlobalStateManager::GetInstance().BackgroundThreadWaitIfLocked(__func__);
        if ((hbmRasProcFlag_ != HBM_RAS_END) && (hbmRasProcFlag_ != HBM_RAS_NOT_SUPPORT)) {
            ReportHBMRasProc();
        }
        if (pageFaultSupportFlag_) {
            ReportPageFaultProc();
        }
        (void)mmSleep(10U); // 每10ms进行一次检测
    }
    GlobalStateManager::GetInstance().DecBackgroundThreadCount(__func__);
    RT_LOG(RT_LOG_EVENT, "Report ras thread exits normally!");
}

void Runtime::ProcHBMRas(const uint32_t devId)
{
    RT_LOG(RT_LOG_ERROR, "ProcHBMRas start, device_id=%u.", devId);

    // wait next cycle, check cqe error
    rtDeviceStatus deviceStatus = RT_DEVICE_STATUS_NORMAL;
    rtError_t error = GetWatchDogDevStatus(devId, &deviceStatus);
    RT_LOG(RT_LOG_ERROR, "get WatchDogDevStatus, ret=%u.", deviceStatus);
    if (error == RT_ERROR_NONE && deviceStatus == RT_DEVICE_STATUS_NORMAL) {
        RtHbmRasInfo rasInfo = {};
        rasInfo.eventId = HBM_ECC_EVENT_ID;
        error = NpuDriver::GetRasSyscnt(devId, &rasInfo);
        COND_RETURN_VOID((error != RT_ERROR_NONE), "get syscnt fail, ret=%u.", error);
        constexpr uint64_t offset = 200U * 1000U;
        constexpr uint64_t freqUs = static_cast<uint64_t>(RT_CHIP_CLOUD_V2_TIMESTAMP_FREQ) / 1000U;
        uint64_t timeUs = rasInfo.sysCnt / freqUs;
        timeUs = (timeUs > offset) ? timeUs - offset : timeUs;
        SetRasInfo(devId, timeUs);
        // all context enter context fail mode
        ContextManage::SetGlobalFailureErr(devId, RT_ERROR_MEM_RAS_ERROR);
        ContextManage::DeviceSetFaultType(devId, DeviceFaultType::HBM_UCE_ERROR);
        RT_LOG(RT_LOG_ERROR, "get syscnt, device_id=%u, time us=%" PRIu64 ".", devId, timeUs);
        RT_LOG_CALL_MSG(ERR_MODULE_DRV,
            "HBM MULTI BIT ECC, Uncorrectable ECC, device_id=%u, event_id=0x%x, time us=%" PRIu64 ".",
            devId, HBM_ECC_EVENT_ID, timeUs);
    }
}

void Runtime::ReportHBMRasProc(void)
{
    if (hbmRasProcFlag_ == HBM_RAS_WAIT_PROC) {
        // 上一次发现告警，此处已等待10ms，再等待190ms开始上报
        (void)mmSleep(190U);
        ProcHBMRas(rasInfo_.devId);
        hbmRasProcFlag_ = HBM_RAS_WORKING;
        return;
    }

    rtDmsEventFilter filter;
    filter.filterFlag = static_cast<uint64_t>(RT_DSM_EVENT_FILTER_FLAG_PID) |
                        static_cast<uint64_t>(RT_DSM_EVENT_FILTER_FLAG_EVENT_ID);
    filter.eventId = HBM_ECC_NOTIFY_EVENT_ID;
    rtDmsFaultEvent dmsEvent;
    // read dmsEvent, if assertion, change flag to wait proc
    const rtError_t error = NpuDriver::ReadFaultEvent(-1, READ_FAULT_EVENT_TIMEOUT, &filter, &dmsEvent);
    if (error == RT_ERROR_DRV_NO_RESOURCES) {
        hbmRasProcFlag_ = HBM_RAS_END;
        RT_LOG(RT_LOG_EVENT, "read fault event drv no resources");
    } else if (error == RT_ERROR_FEATURE_NOT_SUPPORT) {
        hbmRasProcFlag_ = HBM_RAS_NOT_SUPPORT;
        RT_LOG(RT_LOG_EVENT, "read fault event not support");
    } else if (error == RT_ERROR_NONE && dmsEvent.eventId == HBM_ECC_NOTIFY_EVENT_ID) {
        RT_LOG(RT_LOG_ERROR, "get fault event, device_id=%u, assert=%u, event_id=0x%x.",
            dmsEvent.deviceId, dmsEvent.assertion, dmsEvent.eventId);
        hbmRasProcFlag_ = HBM_RAS_WAIT_PROC;
        Device *dev = GetDevice(dmsEvent.deviceId, 0U);
        if (dev != nullptr) {
            dev->SetDeviceRas(true);
        }
        SetRasInfo(dmsEvent.deviceId, 0U);
    } else {
        // no op
    }
}

void Runtime::ReportPageFaultProc(void)
{
    mmTimeval time = {};
    (void)mmGetTimeOfDay(&time, nullptr);
    const uint64_t currentTime = (static_cast<uint64_t>(time.tv_sec) * RT_MS_PER_S) +
                                 (static_cast<uint64_t>(time.tv_usec) / RT_US_TO_MS);
    for (uint32_t i = 0U; i < RT_MAX_DEV_NUM; i++) {
        auto &refObj = devices_[i];
        for (uint32_t j = 0U; j < tsNum_; j++) {
            if (refObj[j].GetRef() == 0ULL) {
                continue;
            }
            Device * const device = refObj[j].GetVal();
            if (device == nullptr) {
                continue;
            }
            uint32_t value = 0U;
            const rtError_t error = NpuDriver::GetPageFaultCount(device->Id_(), &value);
            if (error == RT_ERROR_FEATURE_NOT_SUPPORT) {
                pageFaultSupportFlag_ = false;
                RT_LOG(RT_LOG_EVENT, "Get page fault count does not support.");
                return;
            } else if ((error == RT_ERROR_NONE) && (value != 0) && (device->GetPageFaultBaseCnt() == 0)) {
                device->SetPageFaultBaseCnt(value);
                device->SetPageFaultBaseTime(currentTime);
                continue;
            } else {
                // no op
            }
            COND_RETURN_VOID((error != RT_ERROR_NONE), "Get page fault count fail, ret=%u.", error);
            // value翻转异常场景
            if (value < device->GetPageFaultBaseCnt()) {
                device->SetPageFaultBaseCnt(value);
                device->SetPageFaultBaseTime(currentTime);
                continue;
            }
            if ((value - device->GetPageFaultBaseCnt()) >= PAGE_FAULT_CNT_THRESHOLD) {
                if ((currentTime - device->GetPageFaultBaseTime()) >= PAGE_FAULT_TIME_THRESHOLD) {
                    RT_LOG(RT_LOG_ERROR,
                        "Page fault count exceeds the limit, drv devId=%u, current page fault count=%u.",
                        device->Id_(), value);
                    ProcPageFault(device, value);
                }
            }
        }
    }
}

// 仅限于pagefault上报
void Runtime::ProcPageFault(Device * const device, const uint32_t value)
{
    const uint32_t devId = device->Id_();
    rtDeviceStatus deviceStatus = RT_DEVICE_STATUS_NORMAL;
    const rtError_t error = GetWatchDogDevStatus(devId, &deviceStatus);
    RT_LOG(RT_LOG_ERROR, "ProcPageFault start, drv devId=%u, get WatchDogDevStatus, ret=%u.", devId, deviceStatus);
    if (error == RT_ERROR_NONE && deviceStatus == RT_DEVICE_STATUS_NORMAL) {
        device->SetDevicePageFault(true);
        RT_LOG(RT_LOG_ERROR, "PageFault occurred, drv devId=%u, current page fault count=%u.", devId, value); 
    }
    pageFaultSupportFlag_ = false;
}

rtError_t Runtime::SaveModelAllDataToHost(void)
{
    rtError_t ret = RT_ERROR_NONE;
    Runtime * const rt = Runtime::Instance();
    Driver* devDrv = rt->driverFactory_.GetDriver(NPU_DRIVER);
    for (const auto& node : moduleBackupList_) {
        auto tempDrv = (node->drv == nullptr ? devDrv : node->drv);
        RT_LOG(RT_LOG_DEBUG, "device_id=%u, backup devAddr=0x%llx len=%u", node->devId, node->devAddr, node->memSize);
        ret = tempDrv->MemCopySync(static_cast<void *>(node->hostAddr), node->memSize, node->devAddr, node->memSize, RT_MEMCPY_DEVICE_TO_HOST);
        if (ret != RT_ERROR_NONE) {
            RT_LOG(RT_LOG_ERROR, "MemCopySync fail! src=0x%llx, dst=0x%llx, len=%lu", node->devAddr, node->hostAddr, node->memSize);
            DeleteModuleBackupPoint();
            break;
        }
    }
    return ret;
}

rtError_t Runtime::SaveModelAicpuInfo(const Module* const module, const uint32_t devId, Driver* curDrv)
{
    void *soNameBase = nullptr;
    void *kernelNameBase = nullptr;
    uint32_t soNameSize = 0U;
    uint32_t kenelNameSize = 0U;
    rtError_t ret = RT_ERROR_NONE;

    module->GetAicpuLoadInfo(&soNameBase, &soNameSize, &kernelNameBase, &kenelNameSize);

    // back aicpu so name
    std::unique_ptr<ModuleMemInfo> soNameMemInfo(std::make_unique<ModuleMemInfo>(devId, soNameSize, soNameBase, curDrv));
    COND_PROC(soNameMemInfo == nullptr, ret = RT_ERROR_MEMORY_ALLOCATION);
    NULL_PTR_RETURN(soNameMemInfo, RT_ERROR_MEMORY_ALLOCATION);
    COND_PROC(soNameBase != nullptr, moduleBackupList_.push_back(std::move(soNameMemInfo)));

    // backup aicpu kernel info
    std::unique_ptr<ModuleMemInfo> kernelNameMemInfo(std::make_unique<ModuleMemInfo>(devId, kenelNameSize, kernelNameBase, curDrv));
    COND_PROC(kernelNameMemInfo == nullptr, ret = RT_ERROR_MEMORY_ALLOCATION);
    NULL_PTR_RETURN(kernelNameMemInfo, RT_ERROR_MEMORY_ALLOCATION);
    COND_PROC(kernelNameBase != nullptr, moduleBackupList_.push_back(std::move(kernelNameMemInfo)));

    return ret;
}

rtError_t Runtime::SaveModelDataInfoToList(Program *prog)
{
    rtError_t ret = RT_ERROR_NONE;
    for (uint32_t i = 0U; i < RT_MAX_DEV_NUM; i++) {
        if (prog->GetBinAlignBaseAddr(i) != nullptr) {
            // save program load addr
            std::unique_ptr<ModuleMemInfo> progMemInfo(std::make_unique<ModuleMemInfo>(i, prog->LoadSize(),
                prog->GetBinAlignBaseAddr(i), nullptr));
            COND_PROC(progMemInfo == nullptr, ret = RT_ERROR_MEMORY_ALLOCATION);
            NULL_PTR_RETURN(progMemInfo, RT_ERROR_MEMORY_ALLOCATION);
            moduleBackupList_.push_back(std::move(progMemInfo));
        }
    }

    for (const auto iter : prog->GetCtxMap()) {
        COND_PROC(iter.first == nullptr, break);

        Context* const dereferenceCtx = iter.second;
        Module* const module = dereferenceCtx->GetModuleWithoutCreate(prog);                
        COND_PROC(module == nullptr, break);

        Driver* curDrv = dereferenceCtx->Device_()->Driver_();
        const uint32_t devId = dereferenceCtx->Device_()->Id_();
        const void* devAddr = nullptr;
        uint32_t memSize = 0U;
        devAddr = module->GetBaseAddr();
        memSize = module->GetBaseAddrSize();
        // The address in the module may be the same as that in the prog.
        std::unique_ptr<ModuleMemInfo> kernelMemInfo(std::make_unique<ModuleMemInfo>(
                devId, memSize, devAddr, curDrv));
        COND_PROC(kernelMemInfo == nullptr, ret = RT_ERROR_MEMORY_ALLOCATION);
        NULL_PTR_RETURN(kernelMemInfo, RT_ERROR_MEMORY_ALLOCATION);
        COND_PROC((prog->GetBinAlignBaseAddr(devId) != devAddr && prog->LoadSize() != memSize),
            moduleBackupList_.push_back(std::move(kernelMemInfo)));

        ret = SaveModelAicpuInfo(module, devId, curDrv);
        COND_PROC(ret != RT_ERROR_NONE, return ret);
    }

    return ret;
}

rtError_t Runtime::SaveModule(void)
{
    rtError_t ret = RT_ERROR_NONE;
    Runtime * const rt = Runtime::Instance();
    ObjAllocator<RefObject<Program *>> *programAllocator = rt->GetProgramAllocator();
    NULL_PTR_RETURN_MSG_OUTER(programAllocator, RT_ERROR_PROGRAM_BASE);
 
    COND_PROC(moduleBackupList_.empty() == false, DeleteModuleBackupPoint());

    RefObject<Program *> **progPool = programAllocator->GetObjAllocatorPool();
    NULL_PTR_RETURN(progPool, RT_ERROR_PROGRAM_BASE);
 
    std::mutex *progMtx = programAllocator->GetObjAllocatorMutex();
    NULL_PTR_RETURN(progMtx, RT_ERROR_PROGRAM_BASE);
 
    const uint32_t poolNum = Runtime::maxProgramNum_ / DEFAULT_PROGRAM_NUMBER;
 
    for (uint32_t i = 0; i < poolNum; i++) {
        COND_PROC(progPool[i] == nullptr, continue);
 
        std::function<void()> const errRecycle = [ret, this]() {
            if (ret != RT_ERROR_NONE) {
                this->moduleBackupList_.clear();
            }
        };
        ScopeGuard tskErrRecycle(errRecycle);
        const std::lock_guard<std::mutex> lk(progMtx[i]);
        
        const uint32_t baseId = programAllocator->AccumulatePoolCount(i);
        for (uint32_t index = baseId; index < baseId + DEFAULT_PROGRAM_NUMBER; index++) {
            RefObject<Program *> * const refObj = programAllocator->GetDataToItemApplied(index);
            COND_PROC(refObj == nullptr, continue);
 
            const uint64_t refObjValue = refObj->GetRef();
            COND_PROC(refObjValue == 0, continue);
 
            Program *prog = refObj->GetVal(false);
            COND_PROC(prog == nullptr, continue);
            
            RT_LOG(RT_LOG_DEBUG, "prog ctx cnt=%u, prog id=%u",   prog->GetCtxMap().size(), prog->Id_());
            ret = SaveModelDataInfoToList(prog);
            COND_PROC(ret != RT_ERROR_NONE, return ret);
        }
    }

    ret = SaveModelAllDataToHost();
    return ret;
}
 
rtError_t Runtime::RestoreModule(void) const
{
    rtError_t ret = RT_ERROR_NONE;
    Runtime * const rt = Runtime::Instance();
    Driver* devDrv = rt->driverFactory_.GetDriver(NPU_DRIVER);
    RT_LOG(RT_LOG_DEBUG, "backup begain");
    for (const auto& node : moduleBackupList_) {
        Driver* curDrv = (node->drv != nullptr ? node->drv : devDrv);
        void* devAddr = const_cast<void *>(node->devAddr);
        uint32_t memSize = node->memSize;
        void *hostAddr = static_cast<void *>(node->hostAddr);
        auto error = curDrv->MemCopySync(devAddr, memSize, hostAddr, memSize, RT_MEMCPY_HOST_TO_DEVICE);
        COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
            "device=%u MemCopySync fail! src=%p, dest=%p, len=%u", node->devId, hostAddr, devAddr, memSize);
        RT_LOG(RT_LOG_DEBUG,"baseAddr=0x%llx, hostMem=0x%llx.", devAddr, hostAddr);
    }
    RT_LOG(RT_LOG_DEBUG, "backup work finish");    
    return ret;
}
 
void Runtime::DeleteModuleBackupPoint(void)
{
    RT_LOG(RT_LOG_DEBUG, "Delete begin");
    moduleBackupList_.clear();
    RT_LOG(RT_LOG_DEBUG, "Delete finish");
}

bool Runtime::JudgeNeedSubscribe(const uint64_t threadId, Stream *stm, const uint32_t deviceId)
{
    NULL_PTR_RETURN_MSG(cbSubscribe_, false);
    return cbSubscribe_->JudgeNeedSubscribe(threadId, stm, deviceId);
}

rtError_t Runtime::SubscribeCallback(const uint64_t threadId, Stream *stm, void *evtNotify)
{
    NULL_PTR_RETURN_MSG(cbSubscribe_, RT_ERROR_SUBSCRIBE_NULL);
    const rtError_t error = cbSubscribe_->SubscribeCallback(threadId, stm, evtNotify);
    ERROR_RETURN_MSG_INNER(error, "SubscribeCallback, stream_id=%d, threadId=%" PRIu64 ", retCode=%#x",
        stm->Id_(), threadId, static_cast<uint32_t>(error));
    stm->SetSubscribeFlag(StreamSubscribeFlag::SUBSCRIBE_RUNTIME);
    return error;
}

rtError_t Runtime::SetSimdPrintFifoSize(uint32_t val)
{
    constexpr uint32_t MIN_FIFO_PRINTF_SIZE = sizeof(BlockInfo) + sizeof(DumpInfoHead) + sizeof(BlockReadInfo) + sizeof(BlockWriteInfo);
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM(val <= MIN_FIFO_PRINTF_SIZE, RT_ERROR_INVALID_VALUE, 
    val, "greater than " + std::to_string(MIN_FIFO_PRINTF_SIZE));
    printblockLen_ = val;
    return RT_ERROR_NONE;
}

rtError_t Runtime::SetSimtPrintFifoSize(uint32_t val)
{
    constexpr uint32_t MIN_FIFO_PRINTF_SIZE = sizeof(BlockInfo) + sizeof(DumpInfoHead) + sizeof(BlockReadInfo) + sizeof(BlockWriteInfo);
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM(val <= MIN_FIFO_PRINTF_SIZE, RT_ERROR_INVALID_VALUE, 
    val, "greater than " + std::to_string(MIN_FIFO_PRINTF_SIZE));
    simtPrintLen_ = val;
    return RT_ERROR_NONE;
}

uint32_t GetRuntimeStreamNum(void)
{
    Runtime *rt = Runtime::Instance();
    if ((rt != nullptr) && IS_SUPPORT_CHIP_FEATURE(rt->GetChipType(), RtOptionalFeatureType::RT_FEATURE_STREAM_EXTENSION)) {
        RT_LOG(RT_LOG_DEBUG, "StreamCnt=%u", SOFT_STREAM_MAX_NUM);
        return SOFT_STREAM_MAX_NUM;
    }
    RT_LOG(RT_LOG_DEBUG, "StreamCnt=%u", 3U * 1024U);
    return 3072U;
}

Stream *Runtime::GetCurStream(Stream * const stm) const
{
    if (stm == nullptr && 
        IS_SUPPORT_CHIP_FEATURE(GetChipType(), RtOptionalFeatureType::RT_FEATURE_DEVICE_CTRL_SQ)) {
        Context *curCtx = CurrentContext();
        CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, nullptr);
        return curCtx->DefaultStream_();
    }
    return stm;
}
}  // namespace runtime
}  // namespace cce
