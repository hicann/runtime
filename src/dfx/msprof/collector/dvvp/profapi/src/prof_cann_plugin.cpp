/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "prof_cann_plugin.h"
#include <dlfcn.h>
#include "prof_acl_plugin.h"
#include "prof_tx_plugin.h"
#include "prof_mstx_plugin.h"
#include "msprof_dlog.h"
#include "errno/error_code.h"
#include "prof_api.h"
#include "utils/utils.h"
#include "securec.h"

using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::utils;
namespace ProfAPI {
#if (defined(_WIN32) || defined(_WIN64) || defined(_MSC_VER))
const std::string MSPROFILER_LIB_PATH = "libmsprofiler.dll";
#else
const std::string MSPROFILER_LIB_PATH = "libprofimpl.so";
#endif
const std::string PROFILER_SAMPLE_CONFIG_ENV = "PROFILER_SAMPLECONFIG";

#define LOAD_MSPROF_API(api, hanle, func, name)             \
    do {                                                    \
        api = reinterpret_cast<func>(dlsym(hanle, name)); \
    } while (0)

ProfCannPlugin::~ProfCannPlugin()
{
    if (msProfLibHandle_ != nullptr) {
        dlclose(msProfLibHandle_);
    }
    ProfUnInitReportBuf();
}

/**
 * @name  ProfApiInit
 * @brief load prof plugin
 * @param type    [IN] Init type
 * @param data    [IN] Init parameters
 * @param dataLen [IN] parameters length
 * @return void
 */
void ProfCannPlugin::ProfApiInit()
{
    if (msProfLibHandle_ == nullptr) {
        msProfLibHandle_ = dlopen(MSPROFILER_LIB_PATH.c_str(), RTLD_LAZY | RTLD_NODELETE);
    }
    if (msProfLibHandle_ != nullptr) {
        PthreadOnce(&profApiLoadFlag_, []() -> void { ProfCannPlugin::instance()->LoadProfApi(); });
    } else {
        MSPROF_LOGW("Unable to open MSPROF API from %s, return code: %s\n", MSPROFILER_LIB_PATH.c_str(), dlerror());
    }
    return;
}

void ProfCannPlugin::LoadProfApi()
{
    LOAD_MSPROF_API(profInit_, msProfLibHandle_, ProfInitFunc, "MsprofInit");
    LOAD_MSPROF_API(profStart_, msProfLibHandle_, ProfStartFunc, "MsprofStart");
    LOAD_MSPROF_API(profStop_, msProfLibHandle_, ProfStopFunc, "MsprofStop");
    LOAD_MSPROF_API(profSetConfig_, msProfLibHandle_, ProfSetConfigFunc, "MsprofSetConfig");
    LOAD_MSPROF_API(profRegisterCallback_, msProfLibHandle_, ProfRegisterCallbackFunc, "MsprofRegisterCallback");
    LOAD_MSPROF_API(profReportData_, msProfLibHandle_, ProfReportDataFunc, "MsprofReportData");
    LOAD_MSPROF_API(profReportRegTypeInfo_, msProfLibHandle_, ProfReportRegTypeInfoFunc, "ProfImplReportRegTypeInfo");
    LOAD_MSPROF_API(profReportRegDataFormat_, msProfLibHandle_, ProfReportRegDataFormatFunc, "ProfImplReportDataFormat");
    LOAD_MSPROF_API(profReportGetHashId_, msProfLibHandle_, ProfReportGetHashIdFunc, "ProfImplReportGetHashId");
    LOAD_MSPROF_API(profSetDeviceId_, msProfLibHandle_, ProfSetDeviceIdFunc, "MsprofSetDeviceIdByGeModelIdx");
    LOAD_MSPROF_API(profNotifySetDevice_, msProfLibHandle_, ProfNotifySetDeviceFunc, "MsprofNotifySetDevice");
    LOAD_MSPROF_API(profFinalize_, msProfLibHandle_, ProfFinalizeFunc, "MsprofFinalize");
    LOAD_MSPROF_API(profUnSetDeviceId_, msProfLibHandle_, ProfSetDeviceIdFunc, "MsprofUnsetDeviceIdByGeModelIdx");
    LOAD_MSPROF_API(profHostFreqIsEnable_, msProfLibHandle_, ProfHostFreqIsEnableFunc, "ProfImplHostFreqIsEnable");
    LOAD_MSPROF_API(profGetImplInfo_, msProfLibHandle_, ProfGetImplInfoFunc, "ProfImplGetImplInfo");
    LOAD_MSPROF_API(profApiBufPop_, msProfLibHandle_, ProfApiBufPopFunc, "ProfImplSetApiBufPop");
    LOAD_MSPROF_API(profCompactBufPop_, msProfLibHandle_, ProfCompactBufPopFunc, "ProfImplSetCompactBufPop");
    LOAD_MSPROF_API(profAdditionalBufPop_, msProfLibHandle_, ProfAdditionalBufPopFunc, "ProfImplSetAdditionalBufPop");
    LOAD_MSPROF_API(profReportBufEmpty_, msProfLibHandle_, ProfReportBufEmptyFunc, "ProfImplIfReportBufEmpty");
    LOAD_MSPROF_API(profAdditionalBufPush_, msProfLibHandle_, ProfAdditionalBufPushFunc, "ProfImplSetAdditionalBufPush");
    LOAD_MSPROF_API(profMarkEx_, msProfLibHandle_, ProfMarkExFunc, "ProfImplSetMarkEx");
    LOAD_MSPROF_API(profBatchAddBufPop_, msProfLibHandle_, ProfBatchAddBufPopFunc, "ProfImplSetBatchAddBufPop");
    LOAD_MSPROF_API(profBatchAddBufIndexShift_, msProfLibHandle_, ProfBatchAddBufIndexShiftFunc,
        "ProfImplSetBatchAddBufIndexShift");
    LOAD_MSPROF_API(profGetFeatureIsOn_, msProfLibHandle_, ProfGetFeatureIsOnFunc, "ProfImplGetFeatureIsOn");
    LOAD_MSPROF_API(profImplInitMstxInjection_, msProfLibHandle_, ProfImplInitMstxInjectionFunc,
        "ProfImplInitMstxInjection");
    LOAD_MSPROF_API(profSubscribeRawData_, msProfLibHandle_, ProfSubscribeRawDataFunc, "ProfImplSubscribeRawData");
    LOAD_MSPROF_API(profUnSubscribeRawData_, msProfLibHandle_, ProfUnSubscribeRawDataFunc, "ProfImplUnSubscribeRawData");

    LOAD_MSPROF_API(profVarAddBlockBufPop_, msProfLibHandle_, ProfVarAddBlockBufPopFunc, "ProfImplSetVarAddBlockBufBatchPop");
    LOAD_MSPROF_API(profVarAddBlockBufIndexShift_, msProfLibHandle_, ProfVarAddBufIndexShiftFunc, "ProfImplSetVarAddBlockBufIndexShift");
    LoadProfInfo();
    LoadProftxApiInit(msProfLibHandle_);
    ProfAclPlugin::instance()->ProfAclApiInit(msProfLibHandle_);
}

void ProfCannPlugin::LoadProfInfo()
{
    if (profRegisterCallback_ != nullptr) {
        for (const auto &model : ProfPlugin::moduleCallbacks_) {
            for (const auto &handle : model.second) {
                profRegisterCallback_(model.first, handle);
            }
        }
    }

    if (profSetDeviceId_ != nullptr) {
        for (const auto &corres : deviceIdMaps_) {
            profSetDeviceId_(corres.first, corres.second);
        }
    }

    if (profNotifySetDevice_ != nullptr) {
        for (const auto &device : deviceStates_) {
            profNotifySetDevice_(device.first & 0xFFFFFFFFULL, device.first >> 32ULL, device.second);
        }
    }
}

/**
 * @name  ProfInitReportBufSize
 * @brief Select report buffer size
 */
size_t ProfCannPlugin::ProfInitReportBufSize(uint32_t type)
{
    if (type == MSPROF_CTRL_INIT_PURE_CPU) {
        return API_RING_BUFF_CAPACITY;
    }

    ProfImplInfo info;
    info.profType = type;
    info.sysFreeRam = 0;
    info.profInitFlag = true;
    if (profGetImplInfo_ != nullptr) {
        ProfGetImplInfo(info);
        if (!info.profInitFlag) {
            return 0;
        }
    }

    size_t expectBuffer = MIN_RING_BUFF_CAPACITY;
    for (size_t loopBuffer = MIN_RING_BUFF_CAPACITY; loopBuffer <= MAX_RING_BUFF_CAPACITY;) {
        if (loopBuffer * NEG_RING_BUFF_PERCENT > info.sysFreeRam) {
            break;
        }
        expectBuffer = loopBuffer;
        loopBuffer *= CARDINALITY_RING_BUFF;
    }

    return expectBuffer;
}

/**
 * @name  ProfInitReportBuf
 * @brief Based on sys free ram, init three report buffer
 */
void ProfCannPlugin::ProfInitReportBuf(uint32_t type)
{
    // Compute suitable ring buffer
    size_t expectBuffer = ProfInitReportBufSize(type);
    if (expectBuffer == 0) {
        MSPROF_LOGI("Report buffer do not need to be initialized.");
        return;
    }
    // Init report buffer by dynamic expectBuffer
    const size_t apiBufferSize =
        (expectBuffer < API_RING_BUFF_CAPACITY) ? expectBuffer : API_RING_BUFF_CAPACITY;
    const size_t compactBufferSize =
        (expectBuffer < COM_RING_BUFF_CAPACITY) ? expectBuffer : COM_RING_BUFF_CAPACITY;
    const size_t additionalBufferSize =
        (expectBuffer < ADD_RING_BUFF_CAPACITY) ? expectBuffer : ADD_RING_BUFF_CAPACITY;
    apiBuffer_.Init(apiBufferSize, "api_event");
    compactBuffer_.Init(compactBufferSize, "compact");
    additionalBuffer_.Init(additionalBufferSize, "additional");

    variableAdditionalBuffer_.Init("variable");

    // Register try pop function to libprofimpl.so
    ProfRegisterFunc(REPORT_API_POP, reinterpret_cast<VOID_PTR>(TryPopApiBuf));
    ProfRegisterFunc(REPORT_COMPACCT_POP, reinterpret_cast<VOID_PTR>(TryPopCompactBuf));
    ProfRegisterFunc(REPORT_ADDITIONAL_POP, reinterpret_cast<VOID_PTR>(TryPopAdditionalBuf));
    ProfRegisterFunc(REPORT_BUF_EMPTY, reinterpret_cast<VOID_PTR>(IsReportBufEmpty));

    ProfRegisterFunc(REPORT_VARIABLE_ADDITIONAL_POP, reinterpret_cast<VOID_PTR>(TryPopVariableAdditionalBuf));
    ProfRegisterFunc(REPORT_VARIABLE_ADDITIONAL_INDEX_SHIFT, reinterpret_cast<VOID_PTR>(TryIndexShiftVariableAddBuf));
}

/**
 * @name  ProfUnInitReportBuf
 * @brief Uninit three report buffer in libprofapi.so
 */
void ProfCannPlugin::ProfUnInitReportBuf()
{
    // UnInit report buffer before finalize
    apiBuffer_.UnInit();
    compactBuffer_.UnInit();
    additionalBuffer_.UnInit();
    batchAdditionalBuffer_.UnInit();
    variableAdditionalBuffer_.UnInit();
}

/**
 * @name  ProfTxInit
 * @brief Init runtime plugin and register function to MsprofTxManager
 */
void ProfCannPlugin::ProfTxInit()
{
    if (ProfAPI::ProfRuntimePlugin::instance()->RuntimeApiInit() != PROFILING_SUCCESS) {
        return;
    }
    // Register try push function to libprofimpl.so for tx
    ProfRegisterFunc(REPORT_ADDITIONAL_PUSH, reinterpret_cast<VOID_PTR>(TryPushAdditionalBuf));
    ProfRegisterFunc(PROF_MARK_EX, reinterpret_cast<VOID_PTR>(TryMarkEx));

    // enable msprof mstx functions
    if (profImplInitMstxInjection_ != nullptr) {
        profImplInitMstxInjection_(ProfRegisterMstxFunc);
    }
    ProfEnableMstxFunc(PROF_MODULE_MSPROF);
}

int32_t ProfCannPlugin::ProfInit(uint32_t type, void *data, uint32_t dataLen)
{
    std::unique_lock<std::mutex> envLock(envMutex_);
    ProfApiInit();
    if (type == MSPROF_CTRL_INIT_AICPU) {
        ProfInitDevReportBuf();
    } else {
        ProfInitReportBuf(type);
        ProfTxInit();
    }
    if (profInit_ != nullptr) {
        return profInit_(type, data, dataLen);
    } else {
        MSPROF_LOGW("MSPROF API Has Not Been Load!");
    }
    return 0;
}

int32_t ProfCannPlugin::ProfStart(uint32_t dataType, const void *data, uint32_t length)
{
    std::unique_lock<std::mutex> envLock(envMutex_);
    ProfApiInit();
    ProfInitReportBuf(dataType);
    ProfTxInit();
    if (profStart_ != nullptr) {
        return profStart_(dataType, data, length);
    } else {
        MSPROF_LOGW("MSPROF API Has Not Been Load!");
    }
    return 0;
}
 
int32_t ProfCannPlugin::ProfStop(uint32_t dataType, const void *data, uint32_t length)
{
    if (profStop_ != nullptr) {
        int32_t ret = profStop_(dataType, data, length);
        ProfUnInitReportBuf();
        return ret;
    }
    return 0;
}

int32_t ProfCannPlugin::ProfSetConfig(uint32_t configType, const char *config, size_t configLength)
{
    if (profSetConfig_ != nullptr) {
        return profSetConfig_(configType, config, configLength);
    }
    return 0;
}

int32_t ProfCannPlugin::ProfRegisterCallback(uint32_t moduleId, ProfCommandHandle handle)
{
    if (handle == nullptr) {
        MSPROF_LOGE("Register callback with invalid handle nullptr, module[%u]", moduleId);
        return -1;
    }
    if (profRegisterCallback_ != nullptr) {
        MSPROF_LOGI("Register module[%u] callback with handle.", moduleId);
        profRegisterCallback_(moduleId, handle);
    } else {
        MSPROF_LOGI("Register module[%u] callback.", moduleId);
        const std::unique_lock<std::mutex> lock(ProfPlugin::callbackMutex_);
        auto it = ProfPlugin::moduleCallbacks_.find(moduleId);
        if (it != ProfPlugin::moduleCallbacks_.cend()) {
            ProfPlugin::moduleCallbacks_[moduleId].insert(handle);
        } else {
            ProfPlugin::moduleCallbacks_.insert(std::make_pair(moduleId, std::set<ProfCommandHandle>{handle}));
        }
    }
    return 0;
}

int32_t ProfCannPlugin::ProfReportData(uint32_t moduleId, uint32_t type, void *data, uint32_t len)
{
    if (profReportData_ != nullptr) {
        return profReportData_(moduleId, type, data, len);
    }
    return 0;
}

/**
 * @name  ProfReportApi
 * @brief push api data to apiBuffer_
 * @param [in] agingFlag : if need age
 * @param [in] api: data using MsprofApi struct
 * @return MSPROF_ERROR_UNINITIALIZE
           MSPROF_ERROR_NONE
 */
int32_t ProfCannPlugin::ProfReportApi(uint32_t agingFlag, const MsprofApi* api)
{
    return apiBuffer_.TryPush(agingFlag, *api);
}

/**
 * @name  ProfReportEvent
 * @brief push event data to apiBuffer_
 * @param [in] agingFlag : if need age
 * @param [in] event: data using MsprofEvent struct
 * @return MSPROF_ERROR_UNINITIALIZE
           MSPROF_ERROR_NONE
 */
int32_t ProfCannPlugin::ProfReportEvent(uint32_t agingFlag, const MsprofEvent* event)
{
    return apiBuffer_.TryPush(agingFlag, *reinterpret_cast<const MsprofApi *>(event));
}

/**
 * @name  ProfReportCompactInfo
 * @brief push compact data to compactBuffer_
 * @param [in] agingFlag : if need age
 * @param [in] data: data using MsprofCompactInfo struct
 * @return MSPROF_ERROR_UNINITIALIZE
           MSPROF_ERROR_NONE
 */
int32_t ProfCannPlugin::ProfReportCompactInfo(uint32_t agingFlag, const VOID_PTR data, uint32_t /* len */)
{
    return compactBuffer_.TryPush(agingFlag, *reinterpret_cast<const MsprofCompactInfo *>(data));
}

/**
 * @name  ProfReportAdditionalInfo
 * @brief push additional data to additionalBuffer_
 * @param [in] agingFlag : if need age
 * @param [in] data: data using MsprofAdditionalInfo struct
 * @return MSPROF_ERROR_UNINITIALIZE
           MSPROF_ERROR_NONE
 */
int32_t ProfCannPlugin::ProfReportAdditionalInfo(uint32_t agingFlag, const VOID_PTR data, uint32_t length)
{
    if (length > MAX_VARIABLE_DATA_LENGTH) {
        MSPROF_LOGE("Additional info length exceeds the maximum");
        return PROFILING_FAILED;
    }
    if (length > STANDARD_ADDITIONAL_INFO_LENGTH) {
        char* info = reinterpret_cast<char *>(data);
        return variableAdditionalBuffer_.BatchPush(info, length);
    } else {
        MsprofAdditionalInfo *info = static_cast<MsprofAdditionalInfo *>(data);
        if (info->level == MSPROF_REPORT_AICPU_LEVEL) {
            return batchAdditionalBuffer_.BatchPush(info, length);
        } else {
            return additionalBuffer_.TryPush(agingFlag, *info);
        }
    }
}

/**
 * @name  ProfIfReportBufEmpty
 * @brief check if report buffer empty
 * @return true  : report buffer is empty
           false : report buffer is not empty
 */
bool ProfCannPlugin::ProfIfReportBufEmpty()
{
    if (apiBuffer_.GetUsedSize() == 0 &&
        compactBuffer_.GetUsedSize() == 0 &&
        additionalBuffer_.GetUsedSize() == 0 &&
        batchAdditionalBuffer_.GetUsedSize() == 0 &&
        variableAdditionalBuffer_.GetUsedSize() == 0) {
        return true;
    }

    return false;
}

/**
 * @name  ProfReportBufPop
 * @brief pop from apiBuffer_
 */
bool ProfCannPlugin::ProfReportBufPop(uint32_t &aging, MsprofApi& data)
{
    return apiBuffer_.TryPop(aging, data);
}

/**
 * @name  ProfReportBufPop
 * @brief pop from compactBuffer_
 */
bool ProfCannPlugin::ProfReportBufPop(uint32_t &aging, MsprofCompactInfo& data)
{
    return compactBuffer_.TryPop(aging, data);
}

/**
 * @name  ProfReportBufPop
 * @brief pop from additionalBuffer_
 */
bool ProfCannPlugin::ProfReportBufPop(uint32_t &aging, MsprofAdditionalInfo& data)
{
    return additionalBuffer_.TryPop(aging, data);
}

/**
 * @name  ProfVarBlockBufBatchPop
 * @brief pop from variableAdditionalBuffer_
 */
void *ProfCannPlugin::ProfVarBlockBufBatchPop(size_t &popSize)
{
    return variableAdditionalBuffer_.BatchPop(popSize);
}

/**
 * @name  ProfVarAddBufIndexShift
 * @brief pop from variableAdditionalBuffer_
 */
void ProfCannPlugin::ProfVarAddBufIndexShift(void *popPtr, const size_t popSize)
{
    return variableAdditionalBuffer_.BatchPopBufferIndexShift(popPtr, popSize);
}

/**
 * @name  ProfRegisterFunc
 * @brief Register report function to impl
 */
void ProfCannPlugin::ProfRegisterFunc(uint32_t type, VOID_PTR func)
{
    switch (type) {
        case REPORT_API_POP:
            if (profApiBufPop_ != nullptr) {
                profApiBufPop_(reinterpret_cast<ProfApiBufPopCallback>(func));
            }
            break;
        case REPORT_COMPACCT_POP:
            if (profCompactBufPop_ != nullptr) {
                profCompactBufPop_(reinterpret_cast<ProfCompactBufPopCallback>(func));
            }
            break;
        case REPORT_ADDITIONAL_POP:
            if (profAdditionalBufPop_ != nullptr) {
                profAdditionalBufPop_(reinterpret_cast<ProfAdditionalBufPopCallback>(func));
            }
            break;
        case REPORT_BUF_EMPTY:
            if (profReportBufEmpty_ != nullptr) {
                profReportBufEmpty_(reinterpret_cast<ProfReportBufEmptyCallback>(func));
            }
            break;
        case REPORT_ADDITIONAL_PUSH:
            if (profAdditionalBufPush_ != nullptr) {
                profAdditionalBufPush_(reinterpret_cast<ProfAdditionalBufPushCallback>(func));
            }
            break;
        case PROF_MARK_EX:
            if (profMarkEx_ != nullptr) {
                profMarkEx_(reinterpret_cast<ProfMarkExCallback>(func));
            }
            break;
        case REPORT_ADPROF_POP:
            if (profBatchAddBufPop_ != nullptr) {
                profBatchAddBufPop_(reinterpret_cast<ProfBatchAddBufPopCallback>(func));
            }
            break;
        case REPORT_ADPROF_INDEX_SHIFT:
            if (profBatchAddBufIndexShift_ != nullptr) {
                profBatchAddBufIndexShift_(reinterpret_cast<ProfBatchAddBufIndexShiftCallBack>(func));
            }
            break;
        case REPORT_VARIABLE_ADDITIONAL_POP:
            if (profVarAddBlockBufPop_ != nullptr) {
                profVarAddBlockBufPop_(reinterpret_cast<ProfVarAddBlockBufPopCallback>(func));
            }
            break;
        case REPORT_VARIABLE_ADDITIONAL_INDEX_SHIFT:
            if (profVarAddBlockBufIndexShift_ != nullptr) {
                profVarAddBlockBufIndexShift_(reinterpret_cast<ProfVarAddBufIndexShiftCallBack>(func));
            }
            break;
        default:
            MSPROF_LOGE("Invalid register type");
            break;
    }
}

int32_t ProfCannPlugin::ProfReportRegTypeInfo(uint16_t level, uint32_t typeId, const char* typeName, size_t len)
{
    if (profReportRegTypeInfo_ != nullptr) {
        return profReportRegTypeInfo_(level, typeId, std::string(typeName, len));
    }
    return 0;
}

int32_t ProfCannPlugin::ProfReportRegDataFormat(uint16_t level, uint32_t typeId, const char* dataFormat, size_t len)
{
    if (profReportRegDataFormat_ != nullptr) {
        return profReportRegDataFormat_(level, typeId, std::string(dataFormat, len));
    }
    return 0;
}

uint64_t ProfCannPlugin::ProfReportGetHashId(const char* info, size_t len)
{
    if (profReportGetHashId_ != nullptr) {
        return profReportGetHashId_(std::string(info, len));
    }
    return 0;
}

int32_t ProfCannPlugin::ProfSetDeviceIdByGeModelIdx(const uint32_t geModelIdx, const uint32_t deviceId)
{
    if (profSetDeviceId_ != nullptr) {
        return profSetDeviceId_(geModelIdx, deviceId);
    } else {
        const std::unique_lock<std::mutex> lock(deviceMapsMutex_);
        deviceIdMaps_.insert(std::make_pair(geModelIdx, deviceId));
    }
    return 0;
}

int32_t ProfCannPlugin::ProfUnSetDeviceIdByGeModelIdx(const uint32_t geModelIdx, const uint32_t deviceId)
{
    if (profUnSetDeviceId_ != nullptr) {
        return profUnSetDeviceId_(geModelIdx, deviceId);
    } else {
        const std::unique_lock<std::mutex> lock(deviceMapsMutex_);
        const auto it = deviceIdMaps_.find(geModelIdx);
        if (it != deviceIdMaps_.end()) {
            deviceIdMaps_.erase(it);
        }
    }
    return 0;
}

bool ProfCannPlugin::ProfCheckCommandLine()
{
    std::unique_lock<std::mutex> envLock(envMutex_);
    // if command line mode, init profiling before notify
    static CHAR_PTR envPtr = nullptr;
    MM_SYS_GET_ENV(MM_ENV_PROFILER_SAMPLECONFIG, envPtr);
    if (envPtr == nullptr) {
        return false;
    }

    MSPROF_LOGI("Get profiler sample config in notify process, init prof api.");
    static bool initFlag = false;
    if (!initFlag) {
        ProfApiInit();
        ProfInitReportBuf(MSPROF_CTRL_INIT_ACL_ENV);
        ProfTxInit();
    }
    return true;
}

int32_t ProfCannPlugin::ProfNotifySetDevice(uint32_t chipId, uint32_t deviceId, bool isOpen)
{
    if (profNotifySetDevice_ != nullptr) {
        return profNotifySetDevice_(chipId, deviceId, isOpen);
    } else if (isOpen && ProfCheckCommandLine()) {
        if (profNotifySetDevice_ != nullptr) {
            return profNotifySetDevice_(chipId, deviceId, isOpen);
        }
    } else {
        uint64_t id = deviceId;
        id = (id << 32ULL) | chipId;
        const std::unique_lock<std::mutex> lock(deviceStateMutex_);
        deviceStates_[id] = isOpen;
    }

    return 0;
}

int32_t ProfCannPlugin::ProfSetStepInfo(const uint64_t indexId, const uint16_t tagId, void *const stream)
{
    for (auto it = ProfPlugin::moduleCallbacks_.begin(); it != ProfPlugin::moduleCallbacks_.end(); ++it) {
        if (it->first == GE) {
            ProfStepInfoCmd_t stepinfo;
            stepinfo.index_id = indexId;
            stepinfo.tag_id = tagId;
            stepinfo.stream = stream;
            int32_t flag = PROFILING_SUCCESS;
            for (auto& handle : it->second) {
                if (handle(static_cast<uint32_t>(PROF_CTRL_STEPINFO),
                    Utils::ReinterpretCast<VOID, ProfStepInfoCmd_t>(&stepinfo),
                    sizeof(ProfStepInfoCmd_t)) == PROFILING_FAILED) {
                    flag = PROFILING_FAILED;
                }
            }
            return flag;
        }
    }
    return PROFILING_FAILED;
}

int32_t ProfCannPlugin::ProfFinalize()
{
    if (profFinalize_ != nullptr) {
        const int32_t ret = profFinalize_();
        ProfUnInitReportBuf();
        return ret;
    }
    return 0;
}

bool ProfCannPlugin::ProfHostFreqIsEnable()
{
    if (profHostFreqIsEnable_ != nullptr) {
        return profHostFreqIsEnable_();
    }
    return false;
}

void ProfCannPlugin::ProfGetImplInfo(ProfImplInfo& info)
{
    if (profGetImplInfo_ != nullptr) {
        profGetImplInfo_(info);
    }
}

/**
 * @name  TryPopApiBuf
 * @brief Static function to try pop from apiBuffer_
 */
bool TryPopApiBuf(uint32_t &aging, MsprofApi& data)
{
    return ProfAPI::ProfCannPlugin::instance()->ProfReportBufPop(aging, data);
}

/**
 * @name  TryPopCompactBuf
 * @brief Static function to try pop from compactBuffer_
 */
bool TryPopCompactBuf(uint32_t &aging, MsprofCompactInfo& data)
{
    return ProfAPI::ProfCannPlugin::instance()->ProfReportBufPop(aging, data);
}

/**
 * @name  TryPopAdditionalBuf
 * @brief Static function to try pop from additionalBuffer_
 */
bool TryPopAdditionalBuf(uint32_t &aging, MsprofAdditionalInfo& data)
{
    return ProfAPI::ProfCannPlugin::instance()->ProfReportBufPop(aging, data);
}

/**
 * @name  IsReportBufEmpty
 * @brief Static function check if report buffer empty
 */
bool IsReportBufEmpty()
{
    return ProfAPI::ProfCannPlugin::instance()->ProfIfReportBufEmpty();
}

int32_t TryPushAdditionalBuf(uint32_t aging, const VOID_PTR data, uint32_t len)
{
    return ProfAPI::ProfCannPlugin::instance()->ProfReportAdditionalInfo(aging, data, len);
}

int32_t TryMarkEx(uint64_t indexId, uint64_t modelId, uint16_t tagId, VOID_PTR stm)
{
    return ProfAPI::ProfRuntimePlugin::instance()->ProfMarkEx(indexId, modelId, tagId, stm);
}

/**
 * @name  TryPopVariableAdditionalBuf
 * @brief Static function to try pop from variableAdditionalBuffer_
 */
void *TryPopVariableAdditionalBuf(size_t &popSize)
{
    return ProfAPI::ProfCannPlugin::instance()->ProfVarBlockBufBatchPop(popSize);
}

void TryIndexShiftVariableAddBuf(void *popPtr, const size_t popSize)
{
    ProfAPI::ProfCannPlugin::instance()->ProfVarAddBufIndexShift(popPtr, popSize);
}

/********************** devprof interface **********************/
void ProfCannPlugin::ProfInitDevReportBuf()
{
    batchAdditionalBuffer_.Init("adprof");
    ProfRegisterFunc(REPORT_ADPROF_POP, reinterpret_cast<VOID_PTR>(TryPopAdprofBuf));
    ProfRegisterFunc(REPORT_ADPROF_INDEX_SHIFT, reinterpret_cast<VOID_PTR>(TryIndexShiftAdprofBuf));
}

int32_t ProfCannPlugin::ProfReportBatchAdditionalInfo(uint32_t agingFlag, const VOID_PTR data, uint32_t len)
{
    UNUSED(agingFlag);
    return batchAdditionalBuffer_.BatchPush(static_cast<const MsprofAdditionalInfo *>(data), len);
}

size_t ProfCannPlugin::ProfGetBatchReportMaxSize(uint32_t type)
{
    if (type == MSPROF_BATCH_ADDITIONAL_INFO) {
        static size_t maxReportBatchSize = 131072; // 512 * sizeof(MsprofAdditionalInfo)
        return maxReportBatchSize;
    }

    MSPROF_LOGW("Unable to get batch report size of type: %u", type);
    return 0;
}

void *ProfCannPlugin::ProfBatchAddBufPop(size_t &popSize, bool popForce)
{
    return batchAdditionalBuffer_.BatchPop(popSize, popForce);
}

void ProfCannPlugin::ProfBatchAddBufIndexShift(void *popPtr, const size_t popSize)
{
    return batchAdditionalBuffer_.BatchPopBufferIndexShift(popPtr, popSize);
}

int32_t ProfCannPlugin::ProfAdprofCheckFeatureIsOn(uint64_t feature) const
{
    if (profGetFeatureIsOn_ != nullptr) {
        return profGetFeatureIsOn_(feature);
    }
    return 0;
}

int32_t ProfCannPlugin::ProfSubscribeRawData(MsprofRawDataCallback callback) const
{
    if (profSubscribeRawData_ != nullptr) {
        return profSubscribeRawData_(callback);
    }
    MSPROF_LOGW("profSubscribeRawData_ is null");
    return 0;
}

int32_t ProfCannPlugin::ProfUnSubscribeRawData() const
{
    if (profUnSubscribeRawData_ != nullptr) {
        return profUnSubscribeRawData_();
    }
    MSPROF_LOGW("profUnSubscribeRawData_ is null");
    return 0;
}

void *TryPopAdprofBuf(size_t &popSize, bool popForce)
{
    return ProfAPI::ProfCannPlugin::instance()->ProfBatchAddBufPop(popSize, popForce);
}

void TryIndexShiftAdprofBuf(void *popPtr, const size_t popSize)
{
    ProfAPI::ProfCannPlugin::instance()->ProfBatchAddBufIndexShift(popPtr, popSize);
}
}  // namespace ProfAPI
