/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "npu_driver.hpp"
#include "driver/ascend_hal.h"
#include "mmpa/mmpa_api.h"
#include "driver/ascend_inpackage_hal.h"
#include "task.hpp"
#include "driver.hpp"
#include "securec.h"
#include "runtime.hpp"
#include "osal.hpp"
#include "arg_loader.hpp"

#ifdef CFG_DEV_PLATFORM_PC
#include "cmodel_driver.h"
#endif
#include "errcode_manage.hpp"
#include "error_message_manage.hpp"
#include "npu_driver_record.hpp"
#include "register_memory.hpp"

namespace cce {
namespace runtime {
bool g_npuDriverRegResult = DriverFactory::RegDriver(NPU_DRIVER, &NpuDriver::Instance_);

std::map<rtMemInfoType_t, rtMemInfoType_t> g_memInfoTypeMap = {
    {RT_MEMORYINFO_DDR, RT_MEMORYINFO_DDR},
    {RT_MEMORYINFO_HBM, RT_MEMORYINFO_DDR},
    {RT_MEMORYINFO_DDR_HUGE, RT_MEMORYINFO_DDR_HUGE},
    {RT_MEMORYINFO_DDR_NORMAL, RT_MEMORYINFO_DDR_NORMAL},
    {RT_MEMORYINFO_HBM_HUGE, RT_MEMORYINFO_DDR_HUGE},
    {RT_MEMORYINFO_HBM_NORMAL, RT_MEMORYINFO_DDR_NORMAL},
    {RT_MEMORYINFO_DDR_P2P_HUGE, RT_MEMORYINFO_DDR_P2P_HUGE},
    {RT_MEMORYINFO_DDR_P2P_NORMAL, RT_MEMORYINFO_DDR_P2P_NORMAL},
    {RT_MEMORYINFO_HBM_P2P_HUGE, RT_MEMORYINFO_DDR_P2P_HUGE},
    {RT_MEMORYINFO_HBM_P2P_NORMAL, RT_MEMORYINFO_DDR_P2P_NORMAL},
};

static inline uint64_t FlagAddModuleId(uint64_t drvFlag, uint16_t moduleId)
{
    return (drvFlag | (static_cast<uint64_t>(moduleId) << 56U)); // 56 is shift. flag high 8 bit for moduleId
}

static inline uint64_t FlagAddReadBit(uint64_t drvFlag)
{
    return (drvFlag | (RT_MEM_DEV_READONLY << RT_MEM_DEV_READONLY_BIT));
}

static inline uint64_t FlagAddCpOnlyBit(uint64_t drvFlag)
{
    return (drvFlag | static_cast<uint64_t>(MEM_DEV_CP_ONLY));
}

NpuDriver::NpuDriver() : Driver()
{
    uint32_t info = static_cast<uint32_t>(RT_RUN_MODE_RESERVED);
    drvError_t drvRet = drvGetPlatformInfo(&info);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] drvGetPlatformInfo failed: drvRetCode=%d!", static_cast<int32_t>(drvRet));
        return;
    }

    runMode_ = info;
    // init chipType
    chipType_ = Runtime::Instance()->GetChipType();
    // get featureSet
    rtError_t error = GET_CHIP_FEATURE_SET(chipType_, featureSet_);
    // get properties
    error = GET_DEV_PROPERTIES(chipType_, properties_);
    UNUSED(error);

    // init aicpuDeploy
    switch (info) {
        case RT_RUN_MODE_OFFLINE:
            aicpuDeploy_ = static_cast<uint32_t>(AICPU_DEPLOY_CROSS_PROCESS);
            break;
        case RT_RUN_MODE_ONLINE:
            aicpuDeploy_ = static_cast<uint32_t>(AICPU_DEPLOY_CROSS_OS);
            break;
        case RT_RUN_MODE_AICPU_SCHED:
            aicpuDeploy_ = static_cast<uint32_t>(AICPU_DEPLOY_CROSS_THREAD);
            break;
        default:
            RT_LOG(RT_LOG_WARNING, "aicpuDeploy failed, get other platform[%u]!", info);
            break;
    }
    uint32_t devCnt = 0U;
    drvRet = halGetDeviceInfo(RT_DEV_ZERO, static_cast<int32_t>(MODULE_TYPE_SYSTEM),
        static_cast<int32_t>(INFO_TYPE_ENV), &envType_);
    if (drvRet != DRV_ERROR_NONE) {
        const drvError_t drvNumRet = drvGetDevNum(&devCnt);
        if (drvNumRet != DRV_ERROR_NONE) {
            devCnt = RT_MAX_DEV_NUM;
        }
        for (uint32_t i = 0U; i < devCnt; i++) {
            drvRet = halGetDeviceInfo(i, static_cast<int32_t>(MODULE_TYPE_SYSTEM),
                static_cast<int32_t>(INFO_TYPE_ENV), &envType_);
            if (drvRet == DRV_ERROR_NONE) {
                break;
            }
        }
    }

    COND_RETURN_NORMAL((drvRet == DRV_ERROR_NOT_SUPPORT),
        "halGetDeviceInfo not support in helper: drvRetCode=%d, ", static_cast<int32_t>(DRV_ERROR_NOT_SUPPORT));
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halGetDeviceInfo failed: drvRetCode=%d", static_cast<int32_t>(drvRet));
        return;
    }

    (void)drvGetDevNum(&devCnt);
    for (uint32_t i = 0U; i < devCnt; i++) {
        const drvError_t err1 = halGetDeviceInfo(i, MODULE_TYPE_SYSTEM, INFO_TYPE_RUN_MACH, &sysMode_);
        const drvError_t err2 = halGetDeviceInfo(i, MODULE_TYPE_SYSTEM, INFO_TYPE_ADDR_MODE, &addrMode_);
        if (err1 == DRV_ERROR_NONE && err2 == DRV_ERROR_NONE) {
            break;
        }
    }

    RT_LOG(RT_LOG_INFO, "Run mode=%u [0:offline, 1:online], env type=%" PRId64,
        info, envType_);
}

uint32_t NpuDriver::GetRunMode()
{
    return runMode_;
}

uint32_t NpuDriver::GetAicpuDeploy() const
{
    return aicpuDeploy_;
}

Driver *NpuDriver::Instance_()
{
    return new (std::nothrow) NpuDriver();
}

uint32_t NpuDriver::RtGetRunMode()
{
    uint32_t info = static_cast<uint32_t>(RT_RUN_MODE_RESERVED);
    const drvError_t drvRet = drvGetPlatformInfo(&info);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] drvGetPlatformInfo get run mode failed: drvRetCode=%d!",
            static_cast<int32_t>(drvRet));
        return static_cast<uint32_t>(RT_RUN_MODE_RESERVED);
    }
    return info;
}

bool NpuDriver::IsSupportFeature(RtOptionalFeatureType f) const
{
    return (featureSet_.find(f) != featureSet_.end());
}

const DevProperties& NpuDriver::GetDevProperties(void) const
{
    return properties_;
}

rtError_t NpuDriver::GetDeviceCount(int32_t * const cnt)
{
    TIMESTAMP_NAME(__func__);
    const drvError_t drvRet = drvGetDevNum(RtPtrToPtr<uint32_t *>(cnt));
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] drvGetDevNum failed: drvRetCode=%d!", static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    RT_LOG(RT_LOG_DEBUG, "device count=%d.", *cnt);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::GetDeviceIDs(uint32_t * const deviceIds, const uint32_t len)
{
    TIMESTAMP_NAME(__func__);
    const drvError_t drvRet = drvGetDevIDs(deviceIds, len);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] drvGetDevIDs failed: len=%u(bytes), drvRetCode=%d!", len,
                          static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::DevMemAllocHugePageManaged(void ** const dptr, const uint64_t size, const rtMemType_t type,
    const uint32_t deviceId, const uint16_t moduleId, const bool isLogError, const bool readOnlyFlag,
    const bool cpOnlyFlag)
{
    drvError_t drvRet;
    uint64_t drvFlag = 0;

    if (type == RT_MEMORY_P2P_DDR) {
        drvFlag = static_cast<uint64_t>(MEM_DEV) | static_cast<uint64_t>(MEM_TYPE_DDR) |
            static_cast<uint64_t>(MEM_ADVISE_P2P) | static_cast<uint64_t>(MEM_PAGE_HUGE) |
            static_cast<uint64_t>(MEM_SET_ALIGN_SIZE(9ULL)) | static_cast<uint64_t>(NODE_TO_DEVICE(deviceId));
    } else if (type == RT_MEMORY_P2P_HBM) {
        drvFlag = static_cast<uint64_t>(MEM_DEV) | static_cast<uint64_t>(MEM_TYPE_HBM) |
            static_cast<uint64_t>(MEM_PAGE_HUGE) | static_cast<uint64_t>(MEM_ADVISE_P2P) |
            static_cast<uint64_t>(MEM_SET_ALIGN_SIZE(9ULL)) | static_cast<uint64_t>(NODE_TO_DEVICE(deviceId));
    } else if (type == RT_MEMORY_DDR) {
        drvFlag = static_cast<uint64_t>(MEM_DEV) | static_cast<uint64_t>(MEM_TYPE_DDR) |
            static_cast<uint64_t>(MEM_PAGE_HUGE) | static_cast<uint64_t>(MEM_SET_ALIGN_SIZE(9ULL)) |
            static_cast<uint64_t>(NODE_TO_DEVICE(deviceId));
    } else if ((type == RT_MEMORY_TS) && ((GetDevProperties().hugeManagedFlag & TS_4G_CONTIGUOUS_PHY) != 0)) {
        drvFlag = static_cast<uint64_t>(MEM_DEV) | static_cast<uint64_t>(MEM_ADVISE_TS) |
            static_cast<uint64_t>(MEM_ADVISE_4G) | static_cast<uint64_t>(MEM_CONTIGUOUS_PHY) |
            static_cast<uint64_t>(NODE_TO_DEVICE(deviceId));
    } else if ((type == RT_MEMORY_TS) && ((GetDevProperties().hugeManagedFlag & TS_PAGE_HUGE_ALIGNED) != 0)) {
        drvFlag = static_cast<uint64_t>(MEM_DEV) | static_cast<uint64_t>(MEM_ADVISE_TS) |
            static_cast<uint64_t>(MEM_PAGE_HUGE) | static_cast<uint64_t>(MEM_SET_ALIGN_SIZE(9ULL)) |
            static_cast<uint64_t>(NODE_TO_DEVICE(deviceId));
        if ((GetDevProperties().hugeManagedFlag & TS_WITH_HBM) != 0) {
            drvFlag = drvFlag | static_cast<uint64_t>(MEM_TYPE_HBM);
        }
    } else if ((type == RT_MEMORY_HOST_SVM) && ((GetDevProperties().hugeManagedFlag & SVM_HOST_AGENT) != 0)) {
        drvFlag = static_cast<uint64_t>(MEM_HOST_AGENT) | static_cast<uint64_t>(NODE_TO_DEVICE(deviceId));
    } else {
        drvFlag = static_cast<uint64_t>(MEM_DEV) | static_cast<uint64_t>(MEM_TYPE_HBM) |
            static_cast<uint64_t>(MEM_PAGE_HUGE) | static_cast<uint64_t>(MEM_SET_ALIGN_SIZE(9ULL)) |
            static_cast<uint64_t>(NODE_TO_DEVICE(deviceId));
    }

    if (readOnlyFlag) {
        drvFlag = FlagAddReadBit(drvFlag);
    }

    if (cpOnlyFlag) {
        drvFlag = FlagAddCpOnlyBit(drvFlag);
    }

    drvFlag = FlagAddModuleId(drvFlag, moduleId);
    drvRet = halMemAlloc(dptr, static_cast<UINT64>(size), static_cast<UINT64>(drvFlag));
    if (drvRet != DRV_ERROR_NONE) {
        const rtError_t rtErrorCode = RT_GET_DRV_ERRCODE(drvRet);
        if (isLogError) {
            const std::string errorStr = RT_GET_ERRDESC(rtErrorCode);
            DRV_ERROR_PROCESS(drvRet, "[drv api] halMemAlloc failed:size=%" PRIu64
            "(bytes), type=%d, moduleId=%hu, drvFlag=%" PRIu64 ", drvRetCode=%d, device_id=%u, %s",
            size, type, moduleId, drvFlag, static_cast<int32_t>(drvRet), deviceId, errorStr.c_str());
        } else {
            RT_LOG(RT_LOG_WARNING, "[drv api] halMemAlloc failed:size=%" PRIu64
                    "(bytes), type=%u, moduleId=%hu, drvFlag=%" PRIu64 ", drvRetCode=%d, device_id=%u!",
                   size, type, moduleId, drvFlag, static_cast<int32_t>(drvRet), deviceId);
        }
        return rtErrorCode;
    }

    RT_LOG(RT_LOG_DEBUG, "device_id=%u,type=%u,size=%" PRIu64 "(bytes), chip type=%d, moduleId=%hu.",
           deviceId, static_cast<uint32_t>(type), size, static_cast<int32_t>(chipType_), moduleId);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::DevMemAlloc1GHugePage(void ** const dptr, const uint64_t size, const rtMemType_t type,
    const uint32_t memPolicy, const uint32_t deviceId, const uint16_t moduleId, const bool isLogError)
{
    const rtError_t ret = CheckIfSupport1GHugePage();
    if (ret != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "this feature does not support on current version, "
            "size=%lu, type=%u, memory policy=%u, deviceId=%u, moduleId=%u.",
            size, type, memPolicy, deviceId, moduleId);
        return ret;
    }

    rtMemType_t tempType = type;
    tempType = tempType & MEM_ALLOC_TYPE_BIT;
    if (tempType != RT_MEMORY_DEFAULT) {
        if (((tempType & RT_MEMORY_HBM) != RT_MEMORY_HBM) && ((tempType & RT_MEMORY_P2P_HBM) != RT_MEMORY_P2P_HBM) &&
            ((tempType & RT_MEMORY_DDR)) != RT_MEMORY_DDR && ((tempType & RT_MEMORY_P2P_DDR) != RT_MEMORY_P2P_DDR)) {
            RT_LOG(RT_LOG_WARNING, "Only support hbm or ddr memory, type=%d.", type);
            return RT_ERROR_INVALID_VALUE;
        }
    }

    uint64_t drvFlag = 0;
    if (memPolicy == RT_MEMORY_POLICY_HUGE1G_PAGE_ONLY) {
        drvFlag = static_cast<uint64_t>(MEM_DEV) | static_cast<uint64_t>(MEM_PAGE_GIANT) | static_cast<uint64_t>(MEM_TYPE_HBM) |
            static_cast<uint64_t>(NODE_TO_DEVICE(deviceId));
    } else if (memPolicy == RT_MEMORY_POLICY_HUGE1G_PAGE_ONLY_P2P) {
        drvFlag = static_cast<uint64_t>(MEM_DEV) | static_cast<uint64_t>(MEM_PAGE_GIANT) | static_cast<uint64_t>(MEM_TYPE_HBM) |
            static_cast<uint64_t>(MEM_ADVISE_P2P) | static_cast<uint64_t>(NODE_TO_DEVICE(deviceId));
    } else {
        RT_LOG(RT_LOG_ERROR, " memory policy does not support, memory policy=%u.", memPolicy);
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }

    drvFlag = FlagAddModuleId(drvFlag, moduleId);
    const drvError_t drvRet = halMemAlloc(dptr, static_cast<UINT64>(size), static_cast<UINT64>(drvFlag));
    if (drvRet != DRV_ERROR_NONE) {
        const rtError_t rtErrorCode = RT_GET_DRV_ERRCODE(drvRet);
        if (isLogError) {
            const std::string errorStr = RT_GET_ERRDESC(rtErrorCode);
            DRV_ERROR_PROCESS(drvRet, "[drv api] halMemAlloc failed:size=%" PRIu64
            "(bytes), type=%d, moduleId=%hu, drvFlag=%" PRIu64 ", drvRetCode=%d, device_id=%u, %s",
            size, type, moduleId, drvFlag, static_cast<int32_t>(drvRet), deviceId, errorStr.c_str());
        } else {
            RT_LOG(RT_LOG_WARNING, "[drv api] halMemAlloc failed:size=%" PRIu64
                   "(bytes), type=%d,moduleId=%hu,drvFlag=%" PRIu64 ", drvRetCode=%d, device_id=%u!",
                   size, type, moduleId, drvFlag, static_cast<int32_t>(drvRet), deviceId);
        }
        return rtErrorCode;
    }

    RT_LOG(RT_LOG_DEBUG, "device_id=%u, type=%u, size=%" PRIu64 ", chip type=%u, moduleId=%hu.",
           deviceId, type, size, chipType_, moduleId);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::DevMemAllocManaged(void ** const dptr, const uint64_t size, const rtMemType_t type,
    const uint32_t deviceId, const uint16_t moduleId, const bool isLogError, const bool readOnlyFlag,
    const bool starsTillingFlag, const bool cpOnlyFlag) const
{
    drvError_t drvRet;
    uint64_t drvFlag = 0;

    if (type == RT_MEMORY_P2P_DDR) {
        drvFlag = static_cast<uint64_t>(MEM_DEV) | static_cast<uint64_t>(MEM_TYPE_DDR) |
            static_cast<uint64_t>(MEM_ADVISE_P2P) | static_cast<uint64_t>(MEM_SET_ALIGN_SIZE(9ULL)) |
            static_cast<uint64_t>(NODE_TO_DEVICE(deviceId));
    } else if (type == RT_MEMORY_P2P_HBM) {
        drvFlag = static_cast<uint64_t>(MEM_DEV) | static_cast<uint64_t>(MEM_TYPE_HBM) |
            static_cast<uint64_t>(MEM_ADVISE_P2P) | static_cast<uint64_t>(MEM_SET_ALIGN_SIZE(9ULL)) |
            static_cast<uint64_t>(NODE_TO_DEVICE(deviceId));
    } else if (type == RT_MEMORY_DDR) {
        drvFlag = static_cast<uint64_t>(MEM_DEV) | static_cast<uint64_t>(MEM_TYPE_DDR) |
            static_cast<uint64_t>(MEM_SET_ALIGN_SIZE(9ULL)) | static_cast<uint64_t>(NODE_TO_DEVICE(deviceId));
    } else if ((type == RT_MEMORY_TS) && (GetDevProperties().allocManagedFlag == AllocManagedFlag::ALLOC_MANAGED_MEM_ADVISE_4G)) {
        drvFlag = static_cast<uint64_t>(MEM_DEV) | static_cast<uint64_t>(MEM_ADVISE_TS) |
                  static_cast<uint64_t>(MEM_ADVISE_4G) | static_cast<uint64_t>(MEM_CONTIGUOUS_PHY) |
                  static_cast<uint64_t>(NODE_TO_DEVICE(deviceId));
    } else if ((type == RT_MEMORY_TS) && (GetDevProperties().allocManagedFlag == AllocManagedFlag::ALLOC_MANAGED_MEM_SET_ALIGN_SIZE)) {
        drvFlag = static_cast<uint64_t>(MEM_DEV) | static_cast<uint64_t>(MEM_ADVISE_TS) |
            static_cast<uint64_t>(MEM_CONTIGUOUS_PHY) | static_cast<uint64_t>(MEM_SET_ALIGN_SIZE(9ULL)) |
            static_cast<uint64_t>(NODE_TO_DEVICE(deviceId));
    } else if ((type == RT_MEMORY_HOST_SVM) && (GetDevProperties().allocManagedFlag == AllocManagedFlag::ALLOC_MANAGED_MEM_HOST_AGENT)) {
        drvFlag = static_cast<uint64_t>(MEM_HOST_AGENT) | static_cast<uint64_t>(NODE_TO_DEVICE(deviceId));
    } else {
        if (starsTillingFlag == true) {
            drvFlag = static_cast<uint64_t>(MEM_DEV) | static_cast<uint64_t>(MEM_CONTIGUOUS_PHY) |
                static_cast<uint64_t>(MEM_SET_ALIGN_SIZE(9ULL)) | static_cast<uint64_t>(MEM_ADVISE_TS) |
                static_cast<uint64_t>(NODE_TO_DEVICE(deviceId));
        } else {
            drvFlag = static_cast<uint64_t>(MEM_DEV) | static_cast<uint64_t>(MEM_TYPE_HBM) |
                static_cast<uint64_t>(MEM_SET_ALIGN_SIZE(9ULL)) | static_cast<uint64_t>(NODE_TO_DEVICE(deviceId));
        }
    }

    if (readOnlyFlag) {
        drvFlag = FlagAddReadBit(drvFlag);
    }

    COND_PROC(cpOnlyFlag == true, drvFlag = FlagAddCpOnlyBit(drvFlag));

    drvFlag = FlagAddModuleId(drvFlag, moduleId);
    drvRet = halMemAlloc(dptr, static_cast<UINT64>(size), static_cast<UINT64>(drvFlag));
    if (drvRet != DRV_ERROR_NONE) {
        const rtError_t rtErrorCode = RT_GET_DRV_ERRCODE(drvRet);
        if (isLogError) {
            const std::string errorStr = RT_GET_ERRDESC(rtErrorCode);
            DRV_ERROR_PROCESS(drvRet, "[drv api] halMemAlloc failed:size=%" PRIu64
            "(bytes), type=%d, moduleId=%hu, drvFlag=%" PRIu64 ", drvRetCode=%d, device_id=%u, %s",
            size, type, moduleId, drvFlag, static_cast<int32_t>(drvRet), deviceId, errorStr.c_str());
        } else {
            RT_LOG(RT_LOG_WARNING, "[drv api] halMemAlloc failed:size=%" PRIu64
                    "(bytes), type=%d, moduleId=%hu, drvFlag=%" PRIu64 ", drvRetCode=%d, device_id=%u!",
                   size, type, moduleId, drvFlag, static_cast<int32_t>(drvRet), deviceId);
        }
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    RT_LOG(RT_LOG_DEBUG, "device_id=%u, type=%u, size=%" PRIu64 "(bytes), chip type=%d, moduleId=%hu, tillFlag=%d",
           deviceId, static_cast<uint32_t>(type), size, static_cast<int32_t>(chipType_), moduleId, starsTillingFlag);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::GetTransWayByAddr(void * const src, void * const dst, uint8_t * const transType)
{
    TIMESTAMP_NAME(__func__);
    const drvError_t drvRet = drvDeviceGetTransWay(src, dst, transType);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] drvDeviceGetTransWay failed:drvRetCode=%d",
                          static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    return RT_ERROR_NONE;
}

void NpuDriver::SetAllocNumaTsSupported()
{
    int64_t val = static_cast<int64_t>(RT_CAPABILITY_NOT_SUPPORT);
    (void)SupportNumaTsMemCtrl(val);
}

rtError_t NpuDriver::Support1GHugePageCtrl()
{
    // halMemCtl is weakref, probably nullptr
    if (unlikely(&halMemCtl == nullptr)) {
        return RT_ERROR_NONE;
    }

    size_t outSize = 0U;
    rtError_t ret = RT_ERROR_NONE;
    struct supportFeaturePara outVal = {};
    struct supportFeaturePara inVal = {};
    inVal.support_feature = static_cast<uint64_t>(CTRL_SUPPORT_GIANT_PAGE_MASK);
    const drvError_t drvRet = halMemCtl(static_cast<int32_t>(CTRL_TYPE_SUPPORT_FEATURE), &inVal, sizeof(inVal),
                                        &outVal, &outSize);

    const rtChipType_t curChipType = Runtime::Instance()->GetChipType();
    if (drvRet != DRV_ERROR_NONE) {
        RT_LOG(RT_LOG_WARNING,
            "halMemCtl failed, chip type=%d, drvRetCode=%d",
            static_cast<int32_t>(curChipType), static_cast<int32_t>(drvRet));
        ret = RT_GET_DRV_ERRCODE(drvRet);;
    }

    RT_LOG(RT_LOG_INFO, "chip type=%d, support flag=%llu", curChipType, outVal.support_feature);
    return ret;
}

rtError_t NpuDriver::SupportNumaTsMemCtrl(int64_t &val)
{
    if (!IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DRIVER_NUMA_TS_MEM_CTRL)) {
        val = static_cast<int64_t>(RT_CAPABILITY_NOT_SUPPORT);
        return RT_ERROR_NONE;
    }
    // halMemCtl is weakref, probably nullptr
    if (unlikely(&halMemCtl == nullptr)) {
        val = static_cast<int64_t>(RT_CAPABILITY_NOT_SUPPORT);
        return RT_ERROR_NONE;
    }
    size_t outSize = 0U;
    rtError_t ret = RT_ERROR_NONE;
    struct supportFeaturePara outVal = {};
    struct supportFeaturePara inVal = {};
    inVal.support_feature = static_cast<uint64_t>(CTRL_SUPPORT_NUMA_TS_MASK);
    const drvError_t drvRet = halMemCtl(static_cast<int32_t>(CTRL_TYPE_SUPPORT_FEATURE), &inVal, sizeof(inVal),
                                        &outVal, &outSize);
    if (drvRet != DRV_ERROR_NONE) {
        RT_LOG(RT_LOG_WARNING, "halMemCtl failed, chip type=%d, drvRetCode=%d",
            static_cast<int32_t>(chipType_), static_cast<int32_t>(drvRet));
        ret = RT_ERROR_DRV_ERR;
    }
    // support ts memory
    if ((outVal.support_feature & static_cast<uint64_t>(CTRL_SUPPORT_NUMA_TS_MASK)) != 0ULL) {
        val = static_cast<int64_t>(RT_CAPABILITY_SUPPORT);
    } else {
        val = static_cast<int64_t>(RT_CAPABILITY_NOT_SUPPORT);
    }
    RT_LOG(RT_LOG_INFO, "chip type=%d, support flag=%" PRId64, chipType_, val);
    return ret;
}

rtError_t NpuDriver::CheckIfSupport1GHugePage()
{
    if (Runtime::Instance()->GetIsSupport1GHugePage()) {
        return RT_ERROR_NONE;
    }
    const auto curChipType = Runtime::Instance()->GetChipType();
    // Static function does not have featureSet
    if (!IS_SUPPORT_CHIP_FEATURE(curChipType, RtOptionalFeatureType::RT_FEATURE_MEM_1G_HUGE_PAGE)) {
        RT_LOG(RT_LOG_ERROR, "chip type does not support, chip type=%d.", curChipType);
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }

    const rtError_t ret = Support1GHugePageCtrl();
    if (ret != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "this feature does not support on current version, "
            "memory policy=0x%x(RT_MEMORY_POLICY_HUGE1G_PAGE_ONLY) or 0x%x(RT_MEMORY_POLICY_HUGE1G_PAGE_ONLY_P2P)!.",
            RT_MEMORY_POLICY_HUGE1G_PAGE_ONLY, RT_MEMORY_POLICY_HUGE1G_PAGE_ONLY_P2P );
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }
    Runtime::Instance()->SetIsSupport1GHugePage(true);
    return RT_ERROR_NONE;
}

bool NpuDriver::CheckIfSupportNumaTs()
{
    static int64_t val = SUPPORT_NUMA_TS_DEFAULT;
    if (val == SUPPORT_NUMA_TS_DEFAULT) {
        (void)SupportNumaTsMemCtrl(val);
    }
    const bool isSupport = (val == static_cast<int64_t>(RT_CAPABILITY_SUPPORT));
    return isSupport;
}

bool NpuDriver::CheckIfSupportDsaUpdate()
{
    // tmp solution for capability for driver and runtime
    // need new solution which set tsch version of milan
    if (unlikely(&halMemCreate == nullptr)) {
        RT_LOG(RT_LOG_WARNING, "dsa update feature does not support");
        return false;
    }
    return true;
}

/***
function: trans memory attribute in P2P mode by memory policy
***/
rtError_t NpuDriver::transMemAttribute(const uint32_t memPolicy, rtMemType_t * const type) const
{
    const rtMemType_t memMallocType = *type;
    rtError_t error = RT_ERROR_NONE;

    switch (memPolicy) {
        case RT_MEMORY_POLICY_HUGE_PAGE_FIRST_P2P:
        case RT_MEMORY_POLICY_HUGE_PAGE_ONLY_P2P:
        case RT_MEMORY_POLICY_DEFAULT_PAGE_ONLY_P2P:
            if (!IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DEVICE_P2P)) {
                RT_LOG_OUTER_MSG(RT_INVALID_ARGUMENT_ERROR, "this feature does not support on this chipType, "
                    "memory policy=0x%x(RT_MEMORY_POLICY_DEFAULT_PAGE_ONLY_P2P)!.",
                    RT_MEMORY_POLICY_DEFAULT_PAGE_ONLY_P2P);
                error = RT_ERROR_FEATURE_NOT_SUPPORT;
                break;
            }

            if (memMallocType == RT_MEMORY_DEFAULT) {
                if (IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_MEM_MIX_HBM_AND_DDR)) {
                    *type = RT_MEMORY_P2P_HBM;
                } else {
                    *type = RT_MEMORY_P2P_DDR;
                }
            } else if (memMallocType == RT_MEMORY_HBM) {
               *type = RT_MEMORY_P2P_HBM;
            } else if (memMallocType == RT_MEMORY_DDR) {
                *type = RT_MEMORY_P2P_DDR;
            } else {
                // no operation
            }
            break;
        default:
            break;
    }
    return error;
}

/***
function: check p2p memory in P2P mode by memory type offline
***/

static bool IsP2pMemType(const rtMemType_t * const type)
{
    return ((*type == RT_MEMORY_P2P_HBM) || (*type == RT_MEMORY_P2P_DDR));
}

void RtLogErrorLevelControl(bool isLogError, const char * format, ...)
{
    constexpr int32_t singleLogUpperLimit = 512U;
    char_t str[singleLogUpperLimit] = {};
    va_list arg;
    va_start(arg, format);
    const int32_t ret = vsnprintf_truncated_s(str, singleLogUpperLimit, format, arg);
    va_end(arg);
    if (ret < 0) {
        RT_LOG(RT_LOG_WARNING, "Log buffer exceeds the upper limit ret=%d", ret);
        return;
    }
    if (isLogError) {
        RT_LOG(RT_LOG_ERROR, "%s", str);
    } else {
        RT_LOG(RT_LOG_WARNING, "%s", str);
    }
}

rtError_t NpuDriver::DevMemAllocOnline(void ** const dptr, const uint64_t size, rtMemType_t type,
    const uint32_t deviceId, const uint16_t moduleId, const bool isLogError, const bool readOnlyFlag,
    const bool starsTillingFlag, const bool isNewApi, const bool cpOnlyFlag)
{
    const uint32_t memPolicy = static_cast<uint32_t>(type) & (~(static_cast<uint32_t>(MEM_ALLOC_TYPE_BIT)));
    type = type & MEM_ALLOC_TYPE_BIT;
    RT_LOG(RT_LOG_DEBUG, "memory policy=0x%x.", memPolicy);
    rtError_t temptRet = transMemAttribute(memPolicy, &type);
    if (temptRet != RT_ERROR_NONE) {
        return temptRet;
    }

    if (type == RT_MEMORY_TS) {
        Runtime * const rtInstance = Runtime::Instance();
        type = rtInstance->GetTsMemType(MEM_REQUEST_FEATURE_DEFAULT, static_cast<uint32_t>(size));
    }
    RT_LOG(RT_LOG_DEBUG, "device_id=%u, type=%u, size=%" PRIu64 ", chip type=%d, policy=0x%x.",
           deviceId, type, size, chipType_, memPolicy);
    const bool defaultPolicy = (memPolicy == RT_MEMORY_POLICY_NONE) || (memPolicy == RT_MEMORY_POLICY_HUGE_PAGE_FIRST);
    const bool isP2pHugeFirst = (isNewApi && (memPolicy == RT_MEMORY_POLICY_HUGE_PAGE_FIRST_P2P));
    const bool isP2pHugeOnly = (isNewApi && (memPolicy == RT_MEMORY_POLICY_HUGE_PAGE_ONLY_P2P));
    if (defaultPolicy || isP2pHugeFirst) {
        if (size > HUGE_PAGE_MEM_CRITICAL_VALUE) {
            // HugePage
            temptRet = DevMemAllocHugePageManaged(dptr, size, type, deviceId, moduleId, isLogError, readOnlyFlag,
                cpOnlyFlag);
            if (temptRet != RT_ERROR_NONE) {
                temptRet = DevMemAllocManaged(dptr, size, type, deviceId, moduleId, isLogError, readOnlyFlag,
                    starsTillingFlag, cpOnlyFlag);
                if (temptRet != RT_ERROR_NONE) {
                    RT_LOG(RT_LOG_WARNING, "DevMemAlloc huge page failed: device_id=%u, type=%u, "
                        "size=%" PRIu64 "(bytes), drvRetCode=%d!", deviceId, type, size, temptRet);
                    return temptRet;
                }
            }
        } else {
            temptRet = DevMemAllocManaged(dptr, size, type, deviceId, moduleId, isLogError, readOnlyFlag,
                starsTillingFlag, cpOnlyFlag);
            if (temptRet != RT_ERROR_NONE) {
                RtLogErrorLevelControl(isLogError, "DevMemAllocManaged failed: device_id=%u, type=%u, size=%"
                PRIu64 "(bytes), drvRetCode=%d!", deviceId, type, size, temptRet);
                return temptRet;
            }
        }
    } else if ((memPolicy == RT_MEMORY_POLICY_HUGE_PAGE_ONLY) || isP2pHugeOnly) {
        temptRet = DevMemAllocHugePageManaged(dptr, size, type, deviceId, moduleId, isLogError, readOnlyFlag,
            cpOnlyFlag);
        if (temptRet != RT_ERROR_NONE) {
            RtLogErrorLevelControl(isLogError, "DevMemAllocHugePageManaged failed: device_id=%u, type=%u, size=%"
            PRIu64 "(bytes), memPolicy=%u(RT_MEMORY_POLICY_HUGE_PAGE_ONLY), drvRetCode=%d!",
            deviceId, type, size, static_cast<uint32_t>(RT_MEMORY_POLICY_HUGE_PAGE_ONLY), temptRet);
            return temptRet;
        }
    } else if ((memPolicy == RT_MEMORY_POLICY_HUGE1G_PAGE_ONLY) || (memPolicy == RT_MEMORY_POLICY_HUGE1G_PAGE_ONLY_P2P)) {
        temptRet = DevMemAlloc1GHugePage(dptr, size, type, memPolicy, deviceId, moduleId, isLogError);
        if (temptRet != RT_ERROR_NONE) {
            RtLogErrorLevelControl(isLogError, "DevMemAlloc1GHugePage: device_id=%u, type=%u, size=%"
            PRIu64 "(bytes), memPolicy=%u, drvRetCode=%d!", deviceId, type, size, memPolicy, temptRet);
            return temptRet;
        }
    } else {
        temptRet = DevMemAllocManaged(dptr, size, type, deviceId, moduleId, isLogError, readOnlyFlag,
            starsTillingFlag, cpOnlyFlag);
        if (temptRet != RT_ERROR_NONE) {
            RtLogErrorLevelControl(isLogError, "DevMemAllocManaged failed: device_id=%u, type=%u, size=%"
            PRIu64 "(bytes), drvRetCode=%d!", deviceId, type, size, temptRet);
            return temptRet;
        }
    }

    RT_LOG(RT_LOG_DEBUG, "Success, memory policy=0x%x, device_id=%u, size=%" PRIu64 "(bytes), type=%u.",
        memPolicy, deviceId, size, type);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MemAllocHugePolicyPageOffline(void ** const dptr, const uint64_t size,
    const rtMemType_t type, const uint32_t deviceId, const uint16_t moduleId) const
{
    drvError_t drvRet;
    uint64_t drvFlag = 0;

    if ((type == RT_MEMORY_TS) &&
        ((GetDevProperties().hugePolicyFlag & TS_4G_CONTIGUOUS_PHY) != 0)) {
        drvFlag = static_cast<uint64_t>(MEM_DEV) | static_cast<uint64_t>(MEM_ADVISE_TS) |
            static_cast<uint64_t>(MEM_ADVISE_4G) | static_cast<uint64_t>(NODE_TO_DEVICE(deviceId));
    } else if ((type == RT_MEMORY_P2P_DDR) && ((GetDevProperties().hugePolicyFlag & P2P_ALIGNED) != 0)) {
        const uint64_t nonHugeDrvFlag = static_cast<uint64_t>(MEM_SVM) | static_cast<uint64_t>(MEM_TYPE_DDR) |
            static_cast<uint64_t>(MEM_ADVISE_P2P) | static_cast<uint64_t>(MEM_SET_ALIGN_SIZE(9ULL)) |
            static_cast<uint64_t>(NODE_TO_DEVICE(deviceId));
        if (size > HUGE_PAGE_MEM_CRITICAL_VALUE) {
            drvFlag = nonHugeDrvFlag | static_cast<uint64_t>(MEM_PAGE_HUGE);
            drvFlag = FlagAddModuleId(drvFlag, moduleId);
            drvRet = halMemAlloc(dptr, static_cast<UINT64>(size), drvFlag); // malloc huge page
            if (drvRet == DRV_ERROR_NONE) {
                RT_LOG(RT_LOG_INFO, "p2p halMemAlloc huge ok, device_id=%u size=%" PRIu64 ", "
                    "type=%u, drvFlag=%#" PRIx64 ".", deviceId, size, type, drvFlag);
                return RT_ERROR_NONE;
            }
        }
        drvFlag = nonHugeDrvFlag;
    } else {
        if (size > HUGE_PAGE_MEM_CRITICAL_VALUE) {
            drvFlag = static_cast<uint64_t>(MEM_SET_ALIGN_SIZE(9ULL)) |
                static_cast<uint64_t>(MEM_SVM_HUGE) | static_cast<uint64_t>(NODE_TO_DEVICE(deviceId));
            drvFlag = FlagAddModuleId(drvFlag, moduleId);
            drvRet = halMemAlloc(dptr, static_cast<UINT64>(size), static_cast<UINT64>(drvFlag)); // malloc huge page
            if (drvRet == DRV_ERROR_NONE) {
                RT_LOG(RT_LOG_INFO, "halMemAlloc huge ok, device_id=%u size=%" PRIu64 ", "
                    "type=%u, drvFlag=%#" PRIx64 ".", deviceId, size, type, drvFlag);
                return RT_ERROR_NONE;
            }
        }
        drvFlag = static_cast<uint64_t>(MEM_SET_ALIGN_SIZE(9ULL)) |
            static_cast<uint64_t>(MEM_SVM_NORMAL) | static_cast<uint64_t>(NODE_TO_DEVICE(deviceId));
    }
    drvFlag = FlagAddModuleId(drvFlag, moduleId);
    drvRet = halMemAlloc(dptr, static_cast<UINT64>(size), static_cast<UINT64>(drvFlag));
    if (drvRet != DRV_ERROR_NONE) {
        const rtError_t rtErrorCode = RT_GET_DRV_ERRCODE(drvRet);
        const std::string errorStr = RT_GET_ERRDESC(rtErrorCode);
        DRV_ERROR_PROCESS(drvRet, "[drv api] halMemAlloc failed: "
            "device_id=%u, size=%" PRIu64 "(bytes), type=%u, drvRetCode=%d, drvFlag=%#" PRIx64 ", %s", deviceId, size,
            type, static_cast<int32_t>(drvRet), drvFlag, errorStr.c_str());
        return rtErrorCode;
    }

    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MemAllocPolicyOffline(void ** const dptr, const uint64_t size, const uint32_t memPolicy,
    const rtMemType_t type, const uint32_t deviceId, const uint16_t moduleId) const
{
    drvError_t drvRet;
    if ((memPolicy == RT_MEMORY_POLICY_NONE) || (memPolicy == RT_MEMORY_POLICY_HUGE_PAGE_FIRST)) {
        const rtError_t temptRet = MemAllocHugePolicyPageOffline(dptr, size, type, deviceId, moduleId);
        return temptRet;
    }

    if (memPolicy == RT_MEMORY_POLICY_HUGE1G_PAGE_ONLY) {
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }

    uint64_t drvFlag = 0U;
    if (memPolicy == RT_MEMORY_POLICY_HUGE_PAGE_ONLY) {
        drvFlag = static_cast<uint64_t>(MEM_SET_ALIGN_SIZE(9ULL)) |
            static_cast<uint64_t>(MEM_SVM_HUGE) | static_cast<uint64_t>(NODE_TO_DEVICE(deviceId));
    } else {
        drvFlag = static_cast<uint64_t>(MEM_SET_ALIGN_SIZE(9ULL)) |
            static_cast<uint64_t>(MEM_SVM_NORMAL) | static_cast<uint64_t>(NODE_TO_DEVICE(deviceId));
    }

    drvFlag = FlagAddModuleId(drvFlag, moduleId);
    drvRet = halMemAlloc(dptr, static_cast<UINT64>(size), static_cast<UINT64>(drvFlag));
    if (drvRet != DRV_ERROR_NONE) {
        const rtError_t rtErrorCode = RT_GET_DRV_ERRCODE(drvRet);
        const std::string errorStr = RT_GET_ERRDESC(rtErrorCode);
        DRV_ERROR_PROCESS(drvRet, "[drv api] halMemAlloc failed: "
            "memPolicy=%u, device_id=%u, type=%u, size=%" PRIu64 "(bytes), drvRetCode=%d, drvFlag=%" PRIu64 ", %s",
            memPolicy, deviceId, type, size, static_cast<int32_t>(drvRet), drvFlag, errorStr.c_str());
        return rtErrorCode;
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::DevMemAllocOffline(void **dptr, const uint64_t size,
    rtMemType_t type, const uint32_t deviceId, const uint16_t moduleId) const
{
    const uint32_t memPolicy = type & static_cast<uint32_t>(~MEM_ALLOC_TYPE_BIT);
    type = type & MEM_ALLOC_TYPE_BIT;

    RT_LOG(RT_LOG_INFO, "Memory policy=0x%x.", memPolicy);
    rtError_t temptRet = transMemAttribute(memPolicy, &type);
    if (temptRet != RT_ERROR_NONE) {
        return temptRet;
    }

    if (type == RT_MEMORY_TS) {
        Runtime * const rtInstance = Runtime::Instance();
        type = rtInstance->GetTsMemType(MEM_REQUEST_FEATURE_DEFAULT, size);
    }
    RT_LOG(RT_LOG_DEBUG, "device offline alloc size=%" PRIu64 ", type=%u, device_id=%u, chipType=%d!",
           size, type, deviceId, chipType_);
    const bool isP2p = IsP2pMemType(&type);
    COND_RETURN_ERROR_MSG_INNER(isP2p, RT_ERROR_FEATURE_NOT_SUPPORT, "Can not support P2P!");
    if (memPolicy == RT_MEMORY_POLICY_HUGE1G_PAGE_ONLY) {
        const rtError_t ret = CheckIfSupport1GHugePage();
        if (ret != RT_ERROR_NONE) {
            RT_LOG(RT_LOG_ERROR, "this feature does not support on current version, "
                "size=%lu, type=%u, memory policy=%u, deviceId=%u, moduleId=%u.",
                size, type, memPolicy, deviceId, moduleId);
            return ret;
        }
    }

    if (IS_SUPPORT_CHIP_FEATURE(chipType_, RtOptionalFeatureType::RT_FEATURE_DRIVER_DFX_RECORD_MODULE_ID)) {
        uint64_t drvFlag = static_cast<uint64_t>(MEM_SET_ALIGN_SIZE(9ULL)) |
            static_cast<uint64_t>(MEM_SVM_NORMAL) | static_cast<uint64_t>(NODE_TO_DEVICE(deviceId));
        drvFlag = FlagAddModuleId(drvFlag, moduleId);
        drvError_t drvRet = halMemAlloc(dptr, static_cast<UINT64>(size), static_cast<UINT64>(drvFlag)); // 20:align size
        if (drvRet != DRV_ERROR_NONE) {
            const rtError_t rtErrorCode = RT_GET_DRV_ERRCODE(drvRet);
            const std::string errorStr = RT_GET_ERRDESC(rtErrorCode);
            DRV_ERROR_PROCESS(drvRet, "[drv api] halMemAlloc failed: "
                "device_id=%u, size=%" PRIu64 "(bytes), drvRetCode=%d, drvFlag=%" PRIu64 ", %s",
                deviceId, size, static_cast<int32_t>(drvRet), drvFlag, errorStr.c_str());
            return rtErrorCode;
        }

        RT_LOG(RT_LOG_INFO, "Device MbindHbm begin.");

        // warn: compromise for FPGA & ASIC , Will be deleted when FPGA pre-smoke teardown
        int64_t envType = envType_; // 0:FPGA 1:EMU 2:ESL 3:ASIC
        if ((envType == 3) && (type != RT_MEMORY_P2P_HBM)) {
            // type:2
            COND_RETURN_WARN(&drvMbindHbm == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
                "[drv api] drvMbindHbm does not support.");
            drvRet = drvMbindHbm(RtPtrToPtr<DVdeviceptr>(*dptr), size, 2U, deviceId);
        } else {
            // type:4
            COND_RETURN_WARN(&drvMbindHbm == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
                "[drv api] drvMbindHbm does not support.");
            drvRet = drvMbindHbm(RtPtrToPtr<DVdeviceptr>(*dptr), size, 4U, deviceId);
        }

        if (drvRet != DRV_ERROR_NONE) {
            DRV_ERROR_PROCESS(drvRet,
                "[drv api] drvMbindHbm failed: device_id=%u, size=%" PRIu64 "(bytes), type=%u, drvRetCode=%d",
                deviceId, size, type, static_cast<int32_t>(drvRet));
            (void)halMemFree(*dptr);
            return RT_GET_DRV_ERRCODE(drvRet);
        }
    } else {
        temptRet = MemAllocPolicyOffline(dptr, size, memPolicy, type, deviceId, moduleId);
    }

    return temptRet;
}

rtError_t NpuDriver::DevMemAlloc(void ** const dptr, const uint64_t size, const rtMemType_t type,const uint32_t deviceId,
    const uint16_t moduleId, const bool isLogError, const bool readOnlyFlag, const bool starsTillingFlag, const bool isNewApi,
    const bool cpOnlyFlag)
{
    UNUSED(cpOnlyFlag);
    rtError_t temptRet = RT_ERROR_DRV_ERR;
    const uint32_t devRunMode = GetRunMode();
    constexpr uint32_t p2PTypeSet = RT_MEMORY_POLICY_HUGE_PAGE_FIRST_P2P |
        RT_MEMORY_POLICY_HUGE_PAGE_ONLY_P2P | RT_MEMORY_POLICY_DEFAULT_PAGE_ONLY_P2P;

    RT_LOG(RT_LOG_DEBUG, "device_id=%d, type=%u, size=%" PRIu64 ", mode=%u.", deviceId, type, size, devRunMode);
    if (devRunMode == static_cast<uint32_t>(RT_RUN_MODE_ONLINE)) {
        temptRet = DevMemAllocOnline(dptr, size, type, deviceId, moduleId, isLogError, readOnlyFlag, starsTillingFlag,
            isNewApi, cpOnlyFlag);
    } else if ((devRunMode == static_cast<uint32_t>(RT_RUN_MODE_OFFLINE)) && ((type & p2PTypeSet) != 0U)) {
        RT_LOG_OUTER_MSG(RT_INVALID_ARGUMENT_ERROR, "Not support P2P memory type at OFFLINE mode: "
            "device_id=%u, type=%u.", deviceId, static_cast<uint32_t>(type));
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    } else if ((devRunMode == static_cast<uint32_t>(RT_RUN_MODE_OFFLINE)) ||
        (devRunMode == static_cast<uint32_t>(RT_RUN_MODE_AICPU_SCHED))) {
        temptRet = DevMemAllocOffline(dptr, size, type, deviceId, moduleId);
    } else {
        // no operation
    }
    return temptRet;
}

rtError_t NpuDriver::DevMemAllocConPhy(void ** const dptr, const uint64_t size,
                                       const rtMemType_t type, const uint32_t deviceId)
{
    const DVresult drvRet = halMemAlloc(dptr, static_cast<UINT64>(size),
        static_cast<UINT64>(MEM_SET_ALIGN_SIZE(9ULL)) | static_cast<UINT64>(MEM_CONTIGUOUS_PHY) |
        static_cast<UINT64>(NODE_TO_DEVICE(deviceId)));
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halMemAlloc failed: "
            "device_id=%u, size=%" PRIu64 "(bytes), type=%u, drvRetCode=%d!", deviceId, size, type,
            static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    RT_LOG(RT_LOG_DEBUG, "DevMemAllocConPhy success, device_id=%u, type=%u, size=%" PRIu64,
           deviceId, type, size);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::DevMemConPhyFree(void * const dptr, const uint32_t deviceId)
{
    const DVresult drvRet = halMemFree(dptr);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halMemFree failed: device_id=%u, drvRetCode=%d.",
            deviceId, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    RT_LOG(RT_LOG_DEBUG, "DevMemConPhyFree device_id=%u.", deviceId);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::DevDvppMemAlloc(void ** const dptr, const uint64_t size, const uint32_t deviceId,
    const uint32_t flag, const uint16_t moduleId)
{
    const uint64_t virtMemType = (((static_cast<uint64_t>(flag) & static_cast<uint64_t>(RT_MEM_DEV)) != 0) ?
         static_cast<uint64_t>(MEM_DEV) : static_cast<uint64_t>(MEM_DVPP));
    uint64_t memType;
    if ((flag & RT_MEMORY_HBM) != 0) {
        memType = static_cast<uint64_t>(MEM_TYPE_HBM);
    } else if ((flag & RT_MEMORY_DDR) != 0) {
        memType = static_cast<uint64_t>(MEM_TYPE_DDR);
    } else {
        memType = static_cast<uint64_t>(
            IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_MEM_MIX_HBM_AND_DDR) ? MEM_TYPE_HBM : MEM_TYPE_DDR);
    }
    uint64_t memAttr = 0UL;
    if ((flag & RT_MEMORY_ATTRIBUTE_READONLY) != 0U) {
        memAttr |= static_cast<uint64_t>(MEM_READONLY);
        RT_LOG(RT_LOG_DEBUG, "dvpp use readonly memory, flag=%u, memAttr=%#" PRIx64, flag, memAttr);
    }
    if ((flag & RT_MEMORY_POLICY_HUGE_PAGE_ONLY) != 0) {
        memAttr |= static_cast<uint64_t>(MEM_PAGE_HUGE);
        RT_LOG(RT_LOG_DEBUG, "dvpp use huge page size, flag=%u, memAttr=%#" PRIx64, flag, memAttr);
    }
    if ((flag & RT_MEMORY_POLICY_HUGE1G_PAGE_ONLY) != 0) {
        memAttr |= static_cast<uint64_t>(MEM_PAGE_GIANT);
        RT_LOG(RT_LOG_DEBUG, "dvpp use giant page size, flag=%u, memAttr=%#" PRIx64, flag, memAttr);
    }

    constexpr uint8_t defaultAlignSize = 9ULL;
    uint8_t alignSize = static_cast<uint8_t>((flag & RT_MEMORY_ALIGN_SIZE_MASK) >> RT_MEMORY_ALIGN_SIZE_BIT);
    alignSize = (alignSize == 0U) ? defaultAlignSize : alignSize;

    NpuDriverRecord record(static_cast<uint16_t>(RT_PROF_DRV_API_DevDvppMalloc));
    uint64_t drvFlag = virtMemType | memType | memAttr | static_cast<uint64_t>(MEM_SET_ALIGN_SIZE(alignSize)) |
        static_cast<uint64_t>(NODE_TO_DEVICE(deviceId));
    drvFlag = FlagAddModuleId(drvFlag, moduleId);
    RT_LOG(RT_LOG_DEBUG, "flag=%#x, drvFlag=%#" PRIx64 " , size=%#" PRIx64 , flag, drvFlag, size);
    RT_LOG(RT_LOG_DEBUG, "virtMemType=%#" PRIx64 ", memType=%#" PRIx64 ", alignSize=%u, memAttr=%#" PRIx64 ,
        virtMemType, memType, alignSize, memAttr);
    const drvError_t drvRet = halMemAlloc(dptr, static_cast<UINT64>(size), static_cast<UINT64>(drvFlag));
    if (drvRet != DRV_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "[drv api] dvpp halMemAlloc failed: "
            "virtMemType=%#" PRIx64 ", memType=%#" PRIx64 ", alignSize=%u, memAttr=%#" PRIx64 ,
            virtMemType, memType, alignSize, memAttr);
        DRV_ERROR_PROCESS(drvRet, "[drv api] dvpp halMemAlloc failed: "
            "device_id=%u, size=%" PRIu64 "(bytes), drvFlag=%#" PRIx64 ", drvRetCode=%d",
            deviceId, size, drvFlag, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    record.SaveRecord();
    return RT_ERROR_NONE;
}

// malloc device mem for dvpp cmdlist, read-only, huge page first, milan only
rtError_t NpuDriver::DvppCmdListMemAlloc(void ** const dptr, const uint64_t size, const uint32_t deviceId)
{
    drvError_t drvRet = halMemAlloc(dptr, static_cast<UINT64>(size), static_cast<UINT64>(MEM_DEV) |
        static_cast<UINT64>(MEM_TYPE_HBM) | static_cast<UINT64>(MEM_READONLY) | static_cast<UINT64>(MEM_PAGE_HUGE) |
        static_cast<UINT64>(MEM_SET_ALIGN_SIZE(9ULL)) | static_cast<UINT64>(NODE_TO_DEVICE(deviceId)));
    if (drvRet == DRV_ERROR_NONE) {
        return RT_ERROR_NONE;
    }

    RT_LOG(RT_LOG_WARNING, "[drv api] halMemAlloc huge page failed, device_id=%u, size=%" PRIu64 ", drvRetCode=%d",
        deviceId, size, static_cast<int32_t>(drvRet));

    drvRet = halMemAlloc(dptr, static_cast<UINT64>(size), static_cast<UINT64>(MEM_DEV) |
        static_cast<UINT64>(MEM_TYPE_HBM) | static_cast<UINT64>(MEM_READONLY) | static_cast<UINT64>(MEM_PAGE_NORMAL) |
        static_cast<UINT64>(MEM_SET_ALIGN_SIZE(9ULL)) | static_cast<UINT64>(NODE_TO_DEVICE(deviceId)));
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halMemAlloc failed: device_id=%u, size=%" PRIu64 "(bytes), drvRetCode=%d",
            deviceId, size, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    return RT_ERROR_NONE;
}

rtError_t NpuDriver::DevContinuousMemAlloc(void ** const dptr, const uint64_t size, const uint32_t deviceId)
{
    COND_RETURN_WARN(&drvCustomCall == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] drvCustomCall does not support.");

    devdrv_alloc_cm_para_t cmPara;
    cmPara.ptr = dptr;
    cmPara.size = size;

    const drvError_t drvRet = drvCustomCall(deviceId, static_cast<uint32_t>(CMD_TYPE_CM_ALLOC),
                                            static_cast<void *>(&cmPara));
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet,
            "[drv api] drvCustomCall failed: device_id=%u, size=%" PRIu64 "(bytes), drvRetCode=%d!",
            deviceId, size, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::DevContinuousMemFree(void * const dptr, const uint32_t deviceId)
{
    COND_RETURN_WARN(&drvCustomCall == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] drvCustomCall does not support.");

    devdrv_free_cm_para_t cmPara;
    cmPara.ptr = dptr;

    const drvError_t drvRet = drvCustomCall(deviceId, static_cast<uint32_t>(CMD_TYPE_CM_FREE),
                                            static_cast<void *>(&cmPara));
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet,
            "[drv api] drvCustomCall failed: device_id=%u, drvRetCode=%d!",
            deviceId, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::DevSCMemFree(void * const dptr, const uint32_t deviceId)
{
    COND_RETURN_WARN(&drvCustomCall == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] drvCustomCall does not support.");

    const drvError_t drvRet = drvCustomCall(deviceId, static_cast<uint32_t>(CMD_TYPE_SC_FREE), dptr);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet,
            "[drv api] drvCustomCall failed: device_id=%u, drvRetCode=%d!",
            deviceId, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::DevMemAllocForPctrace(void ** const dptr, const uint64_t size, const uint32_t deviceId)
{
    TIMESTAMP_NAME(__func__);
    if (GetRunMode() == static_cast<uint32_t>(RT_RUN_MODE_ONLINE)) {
        RT_LOG_OUTER_MSG(RT_INVALID_ARGUMENT_ERROR, "Pctrace does not support online mode");
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }

    drvError_t drvRet = halMemAlloc(dptr, static_cast<UINT64>(size), 
        static_cast<UINT64>(GetDevProperties().memAllocPctraceFlag) |
        static_cast<UINT64>(MEM_SET_ALIGN_SIZE(9ULL)) |
        static_cast<UINT64>(MEM_ADVISE_TS) | static_cast<UINT64>(NODE_TO_DEVICE(deviceId)));        

    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halMemAlloc for pctrace failed: size=%" PRIu64 "(bytes), drvRetCode=%d,"
            " device_id=%u!", size, static_cast<int32_t>(drvRet), deviceId);
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    RT_LOG(RT_LOG_INFO, "Device mem alloc pctrace : offline, size=%" PRIu64 ".", size);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::DevMemFreeForPctrace(const void * const dst)
{
    TIMESTAMP_NAME(__func__);
    const drvError_t drvRet = halMemFree(const_cast<void *>(dst));
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halMemFree for pctrace failed: drvRetCode=%d.",
            static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    return RT_ERROR_NONE;
}

rtError_t NpuDriver::DevMemAllocCached(void ** const dptr, const uint64_t size,
    const rtMemType_t type, const uint32_t deviceId, const uint16_t moduleId)
{
    TIMESTAMP_NAME(__func__);

    const uint32_t memPolicy = type & static_cast<uint32_t>(~MEM_ALLOC_TYPE_BIT);
    if (memPolicy == RT_MEMORY_POLICY_HUGE_PAGE_ONLY) {
        RT_LOG_OUTER_MSG(RT_INVALID_ARGUMENT_ERROR, "not support huge page, device_id=%u,size=%" PRIu64,
            deviceId, size);
        return RT_ERROR_INVALID_VALUE;
    } else {
        if (size > HUGE_PAGE_MEM_CRITICAL_VALUE) {
            RT_LOG(RT_LOG_WARNING, "invalid size, current size=%" PRIu64 ", valid size range is [%d, %" PRId64 "]!",
                   size, 0, HUGE_PAGE_MEM_CRITICAL_VALUE);
        }

        NpuDriverRecord record(static_cast<uint16_t>(RT_PROF_DRV_API_DevMallocCached));
        uint64_t drvFlag = static_cast<uint64_t>(MEM_SET_ALIGN_SIZE(9ULL)) | MEM_CACHED |
            static_cast<uint64_t>(NODE_TO_DEVICE(deviceId));
        drvFlag = FlagAddModuleId(drvFlag, moduleId);
        const drvError_t drvRet = halMemAlloc(dptr, static_cast<UINT64>(size), drvFlag); // 20:align size
        record.SaveRecord();

        if (drvRet != DRV_ERROR_NONE) {
            const rtError_t rtErrorCode = RT_GET_DRV_ERRCODE(drvRet);
            const std::string errorStr = RT_GET_ERRDESC(rtErrorCode);
            DRV_ERROR_PROCESS(drvRet, "[drv api] halMemAlloc cached failed: "
                "device_id=%u, size=%" PRIu64 "(bytes), drvRetCode=%d, drvFlag=%" PRIu64 ", %s",
                deviceId, size, static_cast<int32_t>(drvRet), drvFlag, errorStr.c_str());
            return rtErrorCode;
        }
    }

    return RT_ERROR_NONE;
}

rtError_t NpuDriver::DevMemFlushCache(const uint64_t base, const size_t len)
{
    TIMESTAMP_NAME(__func__);
    drvFlushCache(base, static_cast<uint32_t>(len));
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::DevMemInvalidCache(const uint64_t base, const size_t len)
{
    TIMESTAMP_NAME(__func__);
    drvFlushCache(base, static_cast<uint32_t>(len));
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::DevMemFree(void * const dptr, const uint32_t deviceId)
{
    (void)deviceId;
    TIMESTAMP_NAME(__func__);
    NULL_PTR_RETURN_MSG(dptr, RT_ERROR_DRV_PTRNULL);

    const drvError_t drvRet = halMemFree(dptr);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halMemFree failed, drvRetCode=%d!",
            static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::HostMemAlloc(void ** const dptr, const uint64_t size, const uint32_t deviceId,
    const uint16_t moduleId)
{
    TIMESTAMP_NAME(__func__);
    uint64_t drvFlag = static_cast<uint64_t>(MEM_SET_ALIGN_SIZE(9ULL)) | static_cast<uint64_t>(MEM_HOST);
    drvFlag = FlagAddModuleId(drvFlag, moduleId);
    const drvError_t drvRet = halMemAlloc(dptr, static_cast<UINT64>(size), static_cast<UINT64>(drvFlag));
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halMemAlloc failed: size=%" PRIu64 "(bytes), drvRetCode=%d, device_id=%u, "
            "drvFlag=%" PRIu64 ", moduleId=%hu!", size, static_cast<int32_t>(drvRet), deviceId, drvFlag, moduleId);
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    return RT_ERROR_NONE;
}

rtError_t NpuDriver::AllocFastRingBufferAndDispatch(void ** const dptr, const uint64_t size, const uint32_t deviceId,
    const uint16_t moduleId)
{
    void *ptr = nullptr;
    uint64_t drvFlag = static_cast<uint64_t>(MEM_SET_ALIGN_SIZE(9ULL)) | static_cast<uint64_t>(MEM_HOST) |
        static_cast<uint64_t>(MEM_CONTIGUOUS_PHY);
    drvFlag = FlagAddModuleId(drvFlag, moduleId);
    drvError_t drvRet = halMemAlloc(&ptr, static_cast<UINT64>(size), static_cast<UINT64>(drvFlag));
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_DRV, drvRet != DRV_ERROR_NONE, RT_GET_DRV_ERRCODE(drvRet),
        "[drv api] halMemAlloc failed: size=%" PRIu64 "(bytes), drvRetCode=%d, device_id=%u, "
        "drvFlag=%#" PRIx64 ", moduleId=%hu", size, static_cast<int32_t>(drvRet), deviceId, drvFlag, moduleId);

    COND_PROC_RETURN_ERROR(&halSetMemSharing == nullptr, RT_ERROR_DRV_NOT_SUPPORT, (void)halMemFree(ptr);,
        "[drv api] halSetMemSharing does not exist.");
    struct drvMemSharingPara para = {};
    para.ptr = ptr;
    para.size = size;
    para.id = deviceId;
    para.side = MEM_HOST_SIDE;
    para.accessor = TS_ACCESSOR;
    para.enable_flag =  0U; /* 0:enable; 1:disable */
    drvRet = halSetMemSharing(&para);
    COND_PROC_RETURN_ERROR(drvRet != DRV_ERROR_NONE, RT_GET_DRV_ERRCODE(drvRet), (void)halMemFree(ptr);,
         "[drv api] halSetMemSharing failed: size=%" PRIu64 "(bytes), drvRetCode=%d, device_id=%u, "
         "drvFlag=%#" PRIx64 ", moduleId=%hu", size, static_cast<int32_t>(drvRet), deviceId, drvFlag, moduleId);

    *dptr = ptr;
    return RT_ERROR_NONE;
}

void NpuDriver::FreeFastRingBuffer(void * const ptr, const uint64_t size, const uint32_t deviceId)
{
    COND_RETURN_VOID_WARN(&halSetMemSharing == nullptr, "[drv api] halSetMemSharing does not exist.");
    struct drvMemSharingPara para = {};
    para.ptr = ptr;
    para.size = size;
    para.id = deviceId;
    para.side = MEM_HOST_SIDE;
    para.accessor = TS_ACCESSOR;
    para.enable_flag = 1U; /* 0:enable; 1:disable */
    const drvError_t drvRet = halSetMemSharing(&para);
    COND_RETURN_VOID(drvRet != DRV_ERROR_NONE,
         "[drv api] halSetMemSharing set disable failed: size=%" PRIu64 "(bytes), drvRetCode=%d, device_id=%u.",
         size, static_cast<int32_t>(drvRet), deviceId);
    (void)halMemFree(ptr);
    return;
}

rtError_t NpuDriver::HostMemFree(void * const dptr)
{
    TIMESTAMP_NAME(__func__);

#ifndef CFG_DEV_PLATFORM_PC
    const drvError_t drvRet = halMemFree(dptr);
#else
    const drvError_t drvRet = cmodelDrvFreeHost(dptr);
#endif
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halMemFree failed: drvRetCode=%d, host addr=%#" PRIx64 "!",
            static_cast<int32_t>(drvRet), RtPtrToValue(dptr));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    return RT_ERROR_NONE;
}

rtError_t NpuDriver::ManagedMemAlloc(void ** const dptr, const uint64_t size, const ManagedMemFlag flag,
                                     const uint32_t deviceId, const uint16_t moduleId)
{
    NpuDriverRecord record(static_cast<uint16_t>(RT_PROF_DRV_API_MngMalloc));
    const rtError_t drvRet = ManagedMemAllocInner(dptr, size, flag, deviceId, moduleId);
    record.SaveRecord();
    return drvRet;
}

rtError_t NpuDriver::ManagedMemAllocInner(void ** const dptr, const uint64_t size, const ManagedMemFlag flag,
                                          const uint32_t deviceId, const uint16_t moduleId)
{
    TIMESTAMP_NAME(__func__);
    drvError_t drvRet;
    uint32_t hugePage = 1U;
    uint64_t drvFlag = 0;

    // HugePage first
    if (size > HUGE_PAGE_MEM_CRITICAL_VALUE) {
        // HugePage
        drvFlag = static_cast<uint64_t>(MEM_SET_ALIGN_SIZE(9ULL)) |
                  static_cast<uint64_t>(MEM_SVM_HUGE) | static_cast<uint64_t>(NODE_TO_DEVICE(deviceId));
        drvFlag = FlagAddModuleId(drvFlag, moduleId);
        drvRet = halMemAlloc(dptr, static_cast<UINT64>(size), static_cast<UINT64>(drvFlag));
        if (drvRet != DRV_ERROR_NONE) {
            drvFlag = static_cast<uint64_t>(MEM_SET_ALIGN_SIZE(9ULL)) |
                      static_cast<uint64_t>(MEM_SVM_NORMAL) | static_cast<uint64_t>(NODE_TO_DEVICE(deviceId));
            drvFlag = FlagAddModuleId(drvFlag, moduleId);
            drvRet = halMemAlloc(dptr, static_cast<UINT64>(size), static_cast<UINT64>(drvFlag));
            if (drvRet != DRV_ERROR_NONE) {
                const rtError_t rtErrorCode = RT_GET_DRV_ERRCODE(drvRet);
                const std::string errorStr = RT_GET_ERRDESC(rtErrorCode);
                DRV_ERROR_PROCESS(drvRet, "[drv api] halMemAlloc failed: "
                    "device_id=%u, size=%" PRIu64 "(bytes), flag=%d, drvRetCode=%d, drvFlag=%" PRIu64 ", %s",
                    deviceId, size, static_cast<int32_t>(flag), static_cast<int32_t>(drvRet), drvFlag,
                    errorStr.c_str());
                return rtErrorCode;
            }
            hugePage = 0U;
        }
    } else {
        hugePage = 0U;
        drvFlag = static_cast<uint64_t>(MEM_SET_ALIGN_SIZE(9ULL)) |
                  static_cast<uint64_t>(MEM_SVM_NORMAL) | static_cast<uint64_t>(NODE_TO_DEVICE(deviceId));
        drvFlag = FlagAddModuleId(drvFlag, moduleId);
        drvRet = halMemAlloc(dptr, static_cast<UINT64>(size), static_cast<UINT64>(drvFlag));
        if (drvRet != DRV_ERROR_NONE) {
            const rtError_t rtErrorCode = RT_GET_DRV_ERRCODE(drvRet);
            const std::string errorStr = RT_GET_ERRDESC(rtErrorCode);
            DRV_ERROR_PROCESS(drvRet, "[drv api] halMemAlloc failed: "
                "device_id=%u, size=%" PRIu64 "(bytes), flag=%d, drvRetCode=%d, drvFlag=%" PRIu64 ", %s", deviceId,
                size, static_cast<int32_t>(flag), static_cast<int32_t>(drvRet), drvFlag, errorStr.c_str());
            return rtErrorCode;
        }
    }
    RT_LOG(RT_LOG_INFO, "Manager mem alloc, device_id=%u, size=%" PRIu64 ", flag=%d, huge=%u.",
           deviceId, size, static_cast<int32_t>(flag), hugePage);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::ManagedMemFree(const void * const dptr)
{
    TIMESTAMP_NAME(__func__);
    NpuDriverRecord record(static_cast<uint16_t>(RT_PROF_DRV_API_MngFree));
    const drvError_t drvRet = halMemFree(const_cast<void *>(dptr));
    record.SaveRecord();
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halMemFree failed: drvRetCode=%d!",
            static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MemAdvise(void * const devPtr, const uint64_t cnt, const uint32_t advise, const uint32_t devid)
{
    COND_RETURN_WARN(&halMemAdvise == nullptr, RT_ERROR_DRV_NOT_SUPPORT,
        "[drv api] halMemAdvise does not exist.");
    const drvError_t drvRet = halMemAdvise(RtPtrToPtr<DVdeviceptr>(devPtr),
        static_cast<size_t>(cnt), advise, static_cast<DVdevice>(devid));
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] MemAdvise failed: device_id=%u, count=%" PRIu64
            ", advise=%u, drvRetCode=%u", devid, cnt, advise, static_cast<uint32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    return RT_ERROR_NONE;
}

TIMESTAMP_EXTERN(drvMemsetD8);
rtError_t NpuDriver::MemSetSync(const void * const devPtr, const uint64_t destMax,
                                const uint32_t val, const uint64_t cnt)
{
    NpuDriverRecord record(static_cast<uint16_t>(RT_PROF_DRV_API_DrvMemsetD8));
    TIMESTAMP_BEGIN(drvMemsetD8);
    const drvError_t drvRet = drvMemsetD8(RtPtrToPtr<DVdeviceptr>(devPtr),
        static_cast<size_t>(destMax), static_cast<UINT8>(val), static_cast<size_t>(cnt));
    TIMESTAMP_END(drvMemsetD8);
    record.SaveRecord();

    TIMESTAMP_NAME(__func__);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] drvMemsetD8 failed: destMax=%" PRIu64 ", value=%u, "
            "count=%" PRIu64 ", drvRetCode=%d!", destMax, val, cnt, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

static rtError_t GetMemInfoType(const rtMemInfoType_t memInfoType, uint32_t * const type)
{
    rtError_t error = RT_ERROR_NONE;

    switch (memInfoType)   {
        case RT_MEMORYINFO_DDR:
        case RT_MEMORYINFO_DDR_HUGE:
        case RT_MEMORYINFO_DDR_NORMAL:
            *type = RT_MEM_INFO_TYPE_DDR_SIZE;
            break;
        case RT_MEMORYINFO_HBM:
        case RT_MEMORYINFO_HBM_HUGE:
        case RT_MEMORYINFO_HBM_NORMAL:
        case RT_MEMORYINFO_HBM_HUGE1G:
            *type = RT_MEM_INFO_TYPE_HBM_SIZE;
            break;
        case RT_MEMORYINFO_DDR_P2P_HUGE:
        case RT_MEMORYINFO_DDR_P2P_NORMAL:
            *type = RT_MEM_INFO_TYPE_DDR_P2P_SIZE;
            break;
        case RT_MEMORYINFO_HBM_P2P_HUGE:
        case RT_MEMORYINFO_HBM_P2P_NORMAL:
        case RT_MEMORYINFO_HBM_P2P_HUGE1G:
            *type = RT_MEM_INFO_TYPE_HBM_P2P_SIZE;
            break;
        default:
            error = RT_ERROR_INVALID_MEMORY_TYPE;
            break;
    }
    return error;
}

static void ExtractDrvMemGetInfo(const rtMemType_t type, rtMemInfo_t * const info,
                                 const struct MemInfo * const drvMemInfo)
{
    errno_t ret;
    const char *typeDesc[] = {
        "DDR_SIZE", "HBM_SIZE", "DDR_P2P_SIZE", "HBM_P2P_SIZE", "ADDR_CHECK",
        "CTRL_NUMA_INFO", "AI_NUMA_INFO", "BAR_NUMA_INFO", "SVM_GRP_INFO",
        "UB_TOKEN_INFO", "SYS_NUMA_INFO"
    };
    switch (type) {
        case RT_MEM_INFO_TYPE_DDR_SIZE:
        case RT_MEM_INFO_TYPE_HBM_SIZE:
        case RT_MEM_INFO_TYPE_DDR_P2P_SIZE:
        case RT_MEM_INFO_TYPE_HBM_P2P_SIZE:
            info->phyInfo.free      = drvMemInfo->phy_info.free;
            info->phyInfo.hugeFree  = drvMemInfo->phy_info.huge_free;
            info->phyInfo.total     = drvMemInfo->phy_info.total;
            info->phyInfo.hugeTotal = drvMemInfo->phy_info.huge_total;
            if (NpuDriver::CheckIfSupport1GHugePage() == RT_ERROR_NONE) {
                info->phyInfo.giantHugeFree  = drvMemInfo->phy_info.giant_free;
                info->phyInfo.giantHugeTotal = drvMemInfo->phy_info.giant_total;
                RT_LOG(RT_LOG_DEBUG,
                    "[%s] total=%" PRIu64 ", hugeTotal=%" PRIu64 ", giantHugeTotal=%" PRIu64", free=%" PRIu64
                    ", hugeFree=%" PRIu64 ", giantHugeFree=%" PRIu64 "",
                    typeDesc[type - 1U],
                    info->phyInfo.total,
                    info->phyInfo.hugeTotal,
                    info->phyInfo.giantHugeTotal,
                    info->phyInfo.free,
                    info->phyInfo.hugeFree,
                    info->phyInfo.giantHugeFree);
            } else {
                RT_LOG(RT_LOG_DEBUG,
                    "[%s] total=%" PRIu64 ", hugeTotal=%" PRIu64 ", free=%" PRIu64 ", hugeFree=%" PRIu64,
                    typeDesc[type - 1U],
                    info->phyInfo.total,
                    info->phyInfo.hugeTotal,
                    info->phyInfo.free,
                    info->phyInfo.hugeFree);
            }
            break;
        case RT_MEM_INFO_TYPE_ADDR_CHECK:
            info->addrInfo.flag = drvMemInfo->addr_info.flag;
            RT_LOG(RT_LOG_DEBUG, "[%s] addr=%" PRIu64 ", cnt=%d, memType=%u, flag=%u",
                typeDesc[type - 1U],
                (uint64_t)(uintptr_t)(info->addrInfo.addr),
                info->addrInfo.cnt,
                info->addrInfo.memType,
                info->addrInfo.flag);
            break;
        case RT_MEM_INFO_TYPE_CTRL_NUMA_INFO:
        case RT_MEM_INFO_TYPE_AI_NUMA_INFO:
        case RT_MEM_INFO_TYPE_BAR_NUMA_INFO:
        case RT_MEM_INFO_TYPE_SYS_NUMA_INFO:
            info->numaInfo.nodeCnt = drvMemInfo->numa_info.node_cnt;
            for (uint32_t i = 0; i < info->numaInfo.nodeCnt; i++) {
                info->numaInfo.nodeId[i] = drvMemInfo->numa_info.node_id[i];
                RT_LOG(RT_LOG_DEBUG, "[%s] nodeIdx=%u, nodeId=%d", typeDesc[type - 1U], i, info->numaInfo.nodeId[i]);
            }
            break;
        case RT_MEM_INFO_TYPE_SVM_GRP_INFO:
            ret = strcpy_s(info->grpInfo.name, RT_SVM_GRP_NAME_LEN, drvMemInfo->grp_info.name);
            COND_RETURN_VOID(ret != EOK, "strcpy_s failed, retCode=%d!", ret);
            RT_LOG(RT_LOG_DEBUG, "[%s] name=%s", typeDesc[type - 1U], info->grpInfo.name);
            break;
        case RT_MEM_INFO_TYPE_UB_TOKEN_INFO:
            info->ubTokenInfo.tokenId = drvMemInfo->ub_token_info.token_id;
            info->ubTokenInfo.tokenValue = drvMemInfo->ub_token_info.token_value;
            RT_LOG(RT_LOG_DEBUG, "[%s] tokenId=%u", typeDesc[type - 1U], info->ubTokenInfo.tokenId);
            break;
        default:
            RT_LOG(RT_LOG_ERROR, "Unsupported memory type %d.", type);
            break;
    }
}

rtError_t NpuDriver::MemGetInfo(const uint32_t deviceId, bool isHugeOnly, size_t * const freeSize, size_t * const totalSize)
{
    TIMESTAMP_NAME(__func__);
    struct MemInfo info;
    uint32_t type = GetDevProperties().memInfoType;
    RT_LOG(RT_LOG_DEBUG, "halMemGetInfo get memType=%u", type);
    
    const drvError_t drvRet = halMemGetInfo(static_cast<DVdevice>(deviceId), type, &info);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halMemGetInfo failed: device_id=%u, drvRetCode=%d!",
            deviceId, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    if (isHugeOnly) {
        *freeSize = static_cast<size_t>(info.phy_info.huge_free);
        *totalSize = static_cast<size_t>(info.phy_info.huge_total);
    } else {
        *freeSize = static_cast<size_t>(info.phy_info.huge_free) + static_cast<size_t>(info.phy_info.free);
        *totalSize = static_cast<size_t>(info.phy_info.huge_total) + static_cast<size_t>(info.phy_info.total);
    }

    return RT_ERROR_NONE;
}

static void ConvertAddrCheckMemType(const rtMemType_t type, rtMemInfo_t * const info, struct MemInfo * const drvInfo)
{
    if (type == RT_MEM_INFO_TYPE_ADDR_CHECK) {
        static uint32_t cvtTable[][2] = {
            {RT_MEM_MASK_SVM_TYPE,  static_cast<uint32_t>(MEM_SVM_TYPE)},
            {RT_MEM_MASK_DEV_TYPE,  static_cast<uint32_t>(MEM_DEV_TYPE)},
            {RT_MEM_MASK_HOST_TYPE, static_cast<uint32_t>(MEM_HOST_TYPE)},
            {RT_MEM_MASK_DVPP_TYPE, static_cast<uint32_t>(MEM_DVPP_TYPE)},
            {RT_MEM_MASK_HOST_AGENT_TYPE, static_cast<uint32_t>(MEM_HOST_AGENT_TYPE)},
            {RT_MEM_MASK_RSVD_TYPE, static_cast<uint32_t>(MEM_RESERVE_TYPE)}
        };
        uint32_t drvMemType = 0U;
        constexpr std::int8_t arraySize = sizeof(cvtTable) / sizeof(cvtTable[0]);
        for (std::int8_t idx = 0; idx < arraySize; ++idx) {
            if ((info->addrInfo.memType & cvtTable[idx][0]) != 0) {
                drvMemType |= cvtTable[idx][1];
            }
        }
        RT_LOG(RT_LOG_DEBUG, "check memory type[%u->%u].", info->addrInfo.memType, drvMemType);
        drvInfo->addr_info.mem_type = drvMemType;
        drvInfo->addr_info.addr     = RtPtrToPtr<DVdeviceptr**>(info->addrInfo.addr);
        drvInfo->addr_info.cnt      = info->addrInfo.cnt;
        drvInfo->addr_info.flag     = info->addrInfo.flag;
    }
}

static void ConvertUbTokenMemType(const rtMemType_t type, rtMemInfo_t * const info, struct MemInfo * const drvInfo)
{
    if (type == RT_MEM_INFO_TYPE_UB_TOKEN_INFO) {
        RT_LOG(RT_LOG_DEBUG, "ub token info: va=%lu, size=%lu.", info->ubTokenInfo.va, info->ubTokenInfo.size);
        drvInfo->ub_token_info.va = info->ubTokenInfo.va;
        drvInfo->ub_token_info.size = info->ubTokenInfo.size;
    }
}

rtError_t NpuDriver::MemGetInfoByType(const uint32_t deviceId, const rtMemType_t type, rtMemInfo_t * const info)
{
    TIMESTAMP_NAME(__func__);
    struct MemInfo drvMemInfo;
    (void)memset_s(&drvMemInfo, sizeof(struct MemInfo), 0x0, sizeof(struct MemInfo));
    ConvertAddrCheckMemType(type, info, &drvMemInfo);
    ConvertUbTokenMemType(type, info, &drvMemInfo);
    RT_LOG(RT_LOG_INFO, "halMemGetInfo enter, type=%u", type);
    const drvError_t drvRet = halMemGetInfo(static_cast<DVdevice>(deviceId), type, &drvMemInfo);
    RT_LOG(RT_LOG_INFO, "halMemGetInfo return, type=%u, drvRet=%d", type, drvRet);
    COND_RETURN_WARN(drvRet == DRV_ERROR_NOT_SUPPORT, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halMemGetInfo does not support.");
    ExtractDrvMemGetInfo(type, info, &drvMemInfo);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halMemGetInfo failed: drv devId=%u, drvRetCode=%d!",
            deviceId, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::CheckMemType(void **addrs, uint32_t size, uint32_t memType, uint32_t *checkResult, uint32_t deviceId)
{
    TIMESTAMP_NAME(__func__);
    rtMemInfo_t info{};
    info.addrInfo.addr = RtPtrToPtr<uint64_t **>(addrs);
    info.addrInfo.cnt = size;
    info.addrInfo.memType = memType;
    info.addrInfo.flag = true;
    struct MemInfo drvMemInfo;
    (void)memset_s(&drvMemInfo, sizeof(struct MemInfo), 0x0, sizeof(struct MemInfo));
    ConvertAddrCheckMemType(RT_MEM_INFO_TYPE_ADDR_CHECK, &info, &drvMemInfo);
    const drvError_t drvRet = halMemGetInfo(static_cast<DVdevice>(deviceId), RT_MEM_INFO_TYPE_ADDR_CHECK, &drvMemInfo);
    COND_RETURN_WARN(drvRet == DRV_ERROR_NOT_SUPPORT, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halMemGetInfo does not support.");
    ExtractDrvMemGetInfo(RT_MEM_INFO_TYPE_ADDR_CHECK, &info, &drvMemInfo);
    *checkResult = info.addrInfo.flag;
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halMemGetInfo failed: drv devId=%u, drvRetCode=%d!",
            deviceId, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

static bool IsHugepageMem(const rtMemInfoType_t memInfoType)
{
    const bool flag =  ((memInfoType == RT_MEMORYINFO_DDR_HUGE) ||
                       (memInfoType == RT_MEMORYINFO_HBM_HUGE) ||
                       (memInfoType == RT_MEMORYINFO_DDR_P2P_HUGE) ||
                       (memInfoType == RT_MEMORYINFO_HBM_P2P_HUGE));
    return flag;
}

static bool Is1GHugePageMem(const rtMemInfoType_t memInfoType)
{
    const bool flag =  (memInfoType == RT_MEMORYINFO_HBM_HUGE1G) ||
                       (memInfoType == RT_MEMORYINFO_HBM_P2P_HUGE1G);
    return flag;
}

rtError_t NpuDriver::GetMemUsageInfo(const uint32_t deviceId, rtMemUsageInfo_t * const memUsageInfo,
                                     const size_t inputNum, size_t * const outputNum)
{
    COND_RETURN_WARN(&halGetMemUsageInfo == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
                     "[drv api] halGetMemUsageInfo does not support.");

    auto memUsage = std::make_unique<struct mem_module_usage[]>(inputNum);
    NULL_PTR_RETURN(memUsage, RT_ERROR_MEMORY_ALLOCATION);

    const drvError_t drvRet = halGetMemUsageInfo(deviceId, memUsage.get(), inputNum, outputNum);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet,
            "[drv api] halGetMemUsageInfo failed: device_id=%u, drvRetCode=%d!",
            deviceId, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    for (size_t i = 0ULL; i < *outputNum; i++) {
        memUsageInfo[i].curMemSize = memUsage[i].cur_mem_size;
        memUsageInfo[i].memPeakSize = memUsage[i].mem_peak_size;
        (void)strcpy_s(memUsageInfo[i].name, sizeof(memUsageInfo[i].name), memUsage[i].name);
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MemGetInfoEx(const uint32_t deviceId, const rtMemInfoType_t memInfoType,
                                  size_t * const freeSize, size_t * const totalSize)
{
    TIMESTAMP_NAME(__func__);
    uint32_t type = 0U;
    rtMemInfoType_t curMemInfoType = memInfoType;
    if ((GetDevProperties().memInfoMapType & MAP_WHEN_GET_INFO) != 0) {
        curMemInfoType = g_memInfoTypeMap[memInfoType];
        RT_LOG(RT_LOG_INFO, "memInfoType convert %d to %d.", memInfoType, curMemInfoType);
    }
    const rtError_t error = GetMemInfoType(curMemInfoType, &type);
    if (error != RT_ERROR_NONE) {
        RT_LOG_OUTER_MSG(RT_INVALID_ARGUMENT_ERROR, "GetMemInfoType failed: curMemInfoType=%d is not in "
            "range[%u, %u], retCode=%d!", static_cast<int32_t>(curMemInfoType), RT_MEMORYINFO_DDR,
            RT_MEMORYINFO_HBM_P2P_NORMAL, static_cast<int32_t>(error));
        return error;
    }
 
    struct MemInfo info;
    const drvError_t drvRet = halMemGetInfo(static_cast<DVdevice>(deviceId), type, &info);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halMemGetInfo failed: "
            "device_id=%u, type=%u, drvRetCode=%d!", deviceId, type, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
 
    RT_LOG(RT_LOG_INFO, "memory info type=%u, type=%u, free=%" PRIu64 ", hug_free=%" PRIu64,
        static_cast<uint32_t>(curMemInfoType), type,
        static_cast<uint64_t>(info.phy_info.free), static_cast<uint64_t>(info.phy_info.huge_free));
 
    if ((curMemInfoType == RT_MEMORYINFO_DDR) || (curMemInfoType == RT_MEMORYINFO_HBM)) {
        *freeSize = static_cast<size_t>(info.phy_info.huge_free + info.phy_info.free);
        *totalSize = static_cast<size_t>(info.phy_info.huge_total + info.phy_info.total);
    } else if (IsHugepageMem(curMemInfoType)) { // Hugepage memory
        *freeSize = static_cast<size_t>(info.phy_info.huge_free);
        *totalSize = static_cast<size_t>(info.phy_info.huge_total);
    } else if (Is1GHugePageMem(curMemInfoType)) {
        const rtError_t ret = CheckIfSupport1GHugePage();
        if (ret != RT_ERROR_NONE) {
            RT_LOG(RT_LOG_ERROR, "this feature does not support on current version, memory policy=%u.",
                curMemInfoType);
            return ret;
        }
        *freeSize = static_cast<size_t>(info.phy_info.giant_free);
        *totalSize = static_cast<size_t>(info.phy_info.giant_total);
    } else { // Normal memory
        *freeSize = static_cast<size_t>(info.phy_info.free);
        *totalSize = static_cast<size_t>(info.phy_info.total);
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::PointerGetAttributes(rtPointerAttributes_t * const attributes, const void * const ptr)
{
    TIMESTAMP_NAME(__func__);
    struct DVattribute dvAttributes;
    dvAttributes.devId = 0U;
    dvAttributes.memType = 0U;
    dvAttributes.pageSize = 0U;

    const drvError_t drvRet = drvMemGetAttribute(RtPtrToPtr<DVdeviceptr>(ptr),
        &dvAttributes);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] drvMemGetAttribute failed: drvRetCode=%d!", static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    attributes->deviceID = dvAttributes.devId;
    attributes->pageSize = dvAttributes.pageSize;
    attributes->memoryType = RT_MEMORY_TYPE_SVM;
    attributes->locationType = RT_MEMORY_LOC_MAX;

    if ((dvAttributes.memType & DV_MEM_LOCK_DEV) != 0U) {
        attributes->memoryType = RT_MEMORY_TYPE_DEVICE;
        attributes->locationType = RT_MEMORY_LOC_DEVICE;
    } else if ((dvAttributes.memType & DV_MEM_LOCK_HOST) != 0U) {
        attributes->memoryType = RT_MEMORY_TYPE_HOST;
        attributes->locationType = RT_MEMORY_LOC_HOST;
    } else if ((dvAttributes.memType & DV_MEM_LOCK_DEV_DVPP) != 0U) {
        attributes->memoryType = RT_MEMORY_TYPE_DVPP;
        attributes->locationType = RT_MEMORY_LOC_DEVICE;
    } else if ((dvAttributes.memType & DV_MEM_SVM) != 0U) {
        attributes->memoryType = RT_MEMORY_TYPE_SVM;
        attributes->locationType = RT_MEMORY_LOC_MANAGED;
    } else if ((dvAttributes.memType & DV_MEM_SVM_DEVICE) != 0U) {
        attributes->memoryType = RT_MEMORY_TYPE_SVM;
        attributes->locationType = RT_MEMORY_LOC_MANAGED;
    } else if ((dvAttributes.memType & DV_MEM_SVM_HOST) != 0U) {
        attributes->memoryType = RT_MEMORY_TYPE_SVM;
        attributes->locationType = RT_MEMORY_LOC_MANAGED;
    } else if ((dvAttributes.memType & DV_MEM_USER_MALLOC) != 0U) {
        attributes->memoryType = RT_MEMORY_TYPE_USER;
        attributes->locationType = (IsRegisteredMemory(ptr)) ? RT_MEMORY_LOC_HOST : RT_MEMORY_LOC_UNREGISTERED;
    } else {
        RT_LOG(RT_LOG_ERROR, "not support this type, drvMemGetAttribute get memType=%u", dvAttributes.memType);
        return RT_ERROR_INVALID_VALUE;
    }

    RT_LOG(RT_LOG_DEBUG, "drvMemGetAttribute get memType=%u", dvAttributes.memType);

    return RT_ERROR_NONE;
}

rtError_t NpuDriver::PtrGetAttributes(const void * const ptr, rtPtrAttributes_t * const attributes)
{
    TIMESTAMP_NAME(__func__);
    struct DVattribute dvAttributes;
    dvAttributes.devId = 0U;
    dvAttributes.memType = 0U;
    dvAttributes.pageSize = 0U;

    const drvError_t drvRet = drvMemGetAttribute(RtPtrToPtr<DVdeviceptr>(ptr),
                                                 &dvAttributes);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] drvMemGetAttribute failed: drvRetCode=%d!", static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    attributes->location.id = dvAttributes.devId; // devId is valid only for the device side memory
    attributes->pageSize = dvAttributes.pageSize;
    attributes->location.type = RT_MEMORY_LOC_HOST;

    if ((dvAttributes.memType & static_cast<uint32_t>(DV_MEM_LOCK_DEV)) != 0U) {
        attributes->location.type = RT_MEMORY_LOC_DEVICE;
    } else if ((dvAttributes.memType & static_cast<uint32_t>(DV_MEM_LOCK_HOST)) != 0U) {
        attributes->location.type = RT_MEMORY_LOC_HOST;
    } else if ((dvAttributes.memType & static_cast<uint32_t>(DV_MEM_LOCK_DEV_DVPP)) != 0U) {
        attributes->location.type = RT_MEMORY_LOC_DEVICE;
    } else if ((dvAttributes.memType & static_cast<uint32_t>(DV_MEM_SVM_DEVICE)) != 0U) {
        attributes->location.type = RT_MEMORY_LOC_MANAGED;
    } else if ((dvAttributes.memType & static_cast<uint32_t>(DV_MEM_SVM_HOST)) != 0U) {
        attributes->location.type = RT_MEMORY_LOC_MANAGED;
    } else if ((dvAttributes.memType & static_cast<uint32_t>(DV_MEM_SVM)) != 0U) {
        attributes->location.type = RT_MEMORY_LOC_MANAGED;
    } else if ((dvAttributes.memType & static_cast<uint32_t>(DV_MEM_USER_MALLOC)) != 0U) {
        attributes->location.type = (IsRegisteredMemory(ptr)) ? RT_MEMORY_LOC_HOST : RT_MEMORY_LOC_UNREGISTERED;
    } else {
        RT_LOG(RT_LOG_ERROR, "not support this type, drvMemGetAttribute get memType=%u", dvAttributes.memType);
        return RT_ERROR_INVALID_VALUE;
    }

    RT_LOG(RT_LOG_DEBUG, "drvMemGetAttribute memType=%u, devId=%u", dvAttributes.memType, dvAttributes.devId);

    return RT_ERROR_NONE;
}

rtError_t NpuDriver::PtrGetRealLocation(const void * const ptr, rtMemLocationType &location, rtMemLocationType &realLocation)
{
    TIMESTAMP_NAME(__func__);
    struct DVattribute dvAttributes;
    dvAttributes.devId = 0U;
    dvAttributes.memType = 0U;
    dvAttributes.pageSize = 0U;

    const drvError_t drvRet = drvMemGetAttribute(RtPtrToPtr<DVdeviceptr>(ptr),
                                                 &dvAttributes);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] drvMemGetAttribute failed: drvRetCode=%d!", static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    if ((dvAttributes.memType & static_cast<uint32_t>(DV_MEM_LOCK_DEV)) != 0U) {
        location = RT_MEMORY_LOC_DEVICE;
        realLocation = RT_MEMORY_LOC_DEVICE;
    } else if ((dvAttributes.memType & static_cast<uint32_t>(DV_MEM_LOCK_HOST)) != 0U) {
        location = RT_MEMORY_LOC_HOST;
        realLocation = RT_MEMORY_LOC_HOST;
    } else if ((dvAttributes.memType & static_cast<uint32_t>(DV_MEM_LOCK_DEV_DVPP)) != 0U) {
        location = RT_MEMORY_LOC_DEVICE;
        realLocation = RT_MEMORY_LOC_DEVICE;
    } else if ((dvAttributes.memType & static_cast<uint32_t>(DV_MEM_SVM_DEVICE)) != 0U) {
        location = RT_MEMORY_LOC_MANAGED;
        realLocation = RT_MEMORY_LOC_DEVICE;
    } else if ((dvAttributes.memType & static_cast<uint32_t>(DV_MEM_SVM_HOST)) != 0U) {
        location = RT_MEMORY_LOC_MANAGED;
        realLocation = RT_MEMORY_LOC_HOST;
    } else if ((dvAttributes.memType & static_cast<uint32_t>(DV_MEM_SVM)) != 0U) {
        location = RT_MEMORY_LOC_MANAGED;
        realLocation = RT_MEMORY_LOC_HOST; // to be check
    } else if ((dvAttributes.memType & static_cast<uint32_t>(DV_MEM_USER_MALLOC)) != 0U) {
        location = (IsRegisteredMemory(ptr)) ? RT_MEMORY_LOC_HOST : RT_MEMORY_LOC_UNREGISTERED;
        realLocation = RT_MEMORY_LOC_HOST;
    } else {
        RT_LOG(RT_LOG_ERROR, "not support this type, drvMemGetAttribute get memType=%u", dvAttributes.memType);
        return RT_ERROR_INVALID_VALUE;
    }

    RT_LOG(RT_LOG_DEBUG, "PtrGetRealLocation memType=%u, devId=%u, realLoc=%d", dvAttributes.memType, dvAttributes.devId, realLocation);

    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MemPrefetchToDevice(const void * const devPtr, const uint64_t len, const int32_t deviceId)
{
    TIMESTAMP_NAME(__func__);
    uint32_t logicDevId = 0U;
    drvError_t drvRet = drvDeviceGetIndexByPhyId(static_cast<uint32_t>(deviceId), &logicDevId);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] drvDeviceGetIndexByPhyId failed: device_id=%d, drvRetCode=%d!",
            deviceId, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    drvRet = drvMemPrefetchToDevice(RtPtrToPtr<DVdeviceptr>(devPtr),
        static_cast<size_t>(len), static_cast<DVdevice>(logicDevId));
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] drvMemPrefetchToDevice failed: "
            "device_id=%u, len=%" PRIu64 "(bytes), drvRetCode=%d!", logicDevId, len, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    return RT_ERROR_NONE;
}

drvError_t NpuDriver::MemCopySyncAdapter(void * const dst, const uint64_t destMax, const void * const src,
    const uint64_t size, const rtMemcpyKind_t kind, const uint32_t devId)
{
    if (devId != INVALID_COPY_MODULEID) {
        if (&halMemcpy == nullptr) {
            RT_LOG(RT_LOG_WARNING, "[drv api] halMemcpy does not exist, [drv api] drvMemcpy is called.");
        } else {
            struct memcpy_info drvDir = {static_cast<drvMemcpyKind_t>(kind), devId, {0, 0}};
            return halMemcpy(dst, static_cast<size_t>(destMax), const_cast<void *>(src),
                static_cast<size_t>(size), &drvDir);
        }
    }
    return drvMemcpy(RtPtrToPtr<UINT64>(dst), destMax,
        RtPtrToPtr<UINT64>(src), size);
}

TIMESTAMP_EXTERN(MemCopySync_drv);
rtError_t NpuDriver::MemCopySync(void * const dst, const uint64_t destMax, const void * const src,
                                 const uint64_t size, const rtMemcpyKind_t kind, bool errShow, uint32_t devId)
{
    TIMESTAMP_NAME(__func__);

    if ((static_cast<uint32_t>(kind) >= RT_MEMCPY_RESERVED) || (src == nullptr) || (dst == nullptr)) {
        RT_LOG_OUTER_MSG(RT_INVALID_ARGUMENT_ERROR,
            "memcpy kind or address is invalid, current kind=%d, cnt size=%" PRIu64
            "(bytes), valid kind range is [%d, %d)", static_cast<int32_t>(kind),
            size, static_cast<int32_t>(RT_MEMCPY_HOST_TO_HOST), static_cast<int32_t>(RT_MEMCPY_RESERVED));
        return RT_ERROR_DRV_INPUT;
    }

    NpuDriverRecord record(static_cast<uint16_t>(RT_PROF_DRV_API_DrvMemcpy));
    TIMESTAMP_BEGIN(MemCopySync_drv);
    drvError_t drvRet = DRV_ERROR_NONE;
#ifndef CFG_DEV_PLATFORM_PC
    const auto sdmaCopyMethod = GetDevProperties().sdmaCopyMethod;
    if (((sdmaCopyMethod == SdmaCopyMethod::SDMA_COPY_BY_HAL) ||
        ((sdmaCopyMethod == SdmaCopyMethod::SDMA_COPY_BY_HAL_WITH_OFFLINE) && (GetRunMode() == RT_RUN_MODE_OFFLINE) &&
        (size >= MEM_LENGTH_2M) && (kind == RT_MEMCPY_DEVICE_TO_DEVICE))) &&
        (&halSdmaCopy != nullptr)) {
        drvRet = halSdmaCopy(RtPtrToPtr<UINT64>(dst),
            destMax, RtPtrToPtr<UINT64>(src), size);
    } else {
        drvRet = MemCopySyncAdapter(dst, destMax, src, size, kind, devId);
    }
#else
    drvRet = cmodelDrvMemcpy(RtPtrToPtr<DVdeviceptr>(dst),
        destMax, RtPtrToPtr<DVdeviceptr>(src), size, static_cast<drvMemcpyKind_t>(kind));
#endif // end of ifndef CFG_DEV_PLATFORM_PC
    TIMESTAMP_END(MemCopySync_drv);
    record.SaveRecord();

    if (drvRet == DRV_ERROR_NOT_SUPPORT) {
        RT_LOG(RT_LOG_WARNING, "drv does not support, return.");
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    if (drvRet != DRV_ERROR_NONE) {
        if (errShow == true) {
            DRV_ERROR_PROCESS(drvRet, "[drv api] drvMemcpy failed: destMax=%" PRIu64
                ", size=%" PRIu64 "(bytes), kind=%d, devId=%u, drvRetCode=%d!", destMax, size,
                static_cast<int32_t>(kind), devId, static_cast<int32_t>(drvRet));
        }
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MemCopyAsync(void * const dst, const uint64_t destMax, const void * const src,
                                  const uint64_t size, const rtMemcpyKind_t kind, volatile uint64_t &copyFd)
{
    if ((static_cast<uint32_t>(kind) >= RT_MEMCPY_RESERVED) || (src == nullptr) || (dst == nullptr)) {
        RT_LOG_OUTER_MSG(RT_INVALID_ARGUMENT_ERROR,
            "mem async copy, kind or addr is invalid, current kind=%d, size=%" PRIu64
            "(bytes), valid kind range is [%d, %d)!", static_cast<int32_t>(kind),
            size, static_cast<int32_t>(RT_MEMCPY_HOST_TO_HOST), static_cast<int32_t>(RT_MEMCPY_RESERVED));
        return RT_ERROR_DRV_INPUT;
    }

    NpuDriverRecord record(static_cast<uint16_t>(RT_PROF_DRV_API_DrvMemcpy));
#ifndef CFG_DEV_PLATFORM_PC
    drvError_t drvRet = DRV_ERROR_NONE;

    if (&halMemCpyAsync == nullptr) {
        drvRet = drvMemcpy(RtPtrToPtr<UINT64>(dst),
            destMax, RtPtrToPtr<UINT64>(src), size);
        copyFd = ASYNC_COPY_STATU_SUCC;
        RT_LOG(RT_LOG_INFO, "not support halMemCpyAsync api, use sync copy api.");
    } else {
        drvRet = halMemCpyAsync(RtPtrToPtr<UINT64>(dst),
            destMax, RtPtrToPtr<UINT64>(src), size, const_cast<uint64_t *>(&copyFd));
        RT_LOG(RT_LOG_INFO, "call halMemCpyAsync success, destMax=%" PRIu64 ","
            " size=%" PRIu64 "(bytes), kind=%d.", destMax, size, static_cast<int32_t>(kind));
    }
#else
    drvError_t drvRet = cmodelDrvMemcpy(RtPtrToPtr<UINT64>(dst), destMax,
        RtPtrToPtr<UINT64>(src), size, static_cast<drvMemcpyKind_t>(kind));
    copyFd = ASYNC_COPY_STATU_SUCC;
#endif
    record.SaveRecord();

    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] drvAsyncMemcpy failed: destMax=%" PRIu64 ","
            " size=%" PRIu64 "(bytes), kind=%d, drvRetCode=%d!", destMax, size,
            static_cast<int32_t>(kind), static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MemCopyAsyncWaitFinish(const uint64_t copyFd)
{
    if (&halMemCpyAsyncWaitFinish == nullptr) {
        RT_LOG(RT_LOG_INFO, "not support halMemCpyAsyncWaitFinish api, return ok.");
        return RT_ERROR_NONE;
    }

    RT_LOG(RT_LOG_INFO, "Call MemCopyAsyncWaitFinish success, copyFd=%" PRIu64, copyFd);
    const drvError_t drvRet = halMemCpyAsyncWaitFinish(copyFd);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halMemCpyAsyncWaitFinish failed: copyFd=%" PRIu64
            " drvRetCode=%d!", copyFd, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MemAddressTranslate(const int32_t deviceId, const uint64_t vptr, uint64_t * const pptr)
{
    TIMESTAMP_NAME(__func__);

    const drvError_t drvRet = drvMemAddressTranslate(static_cast<UINT64>(vptr), RtPtrToPtr<UINT64 *>(pptr));
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] drvMemAddressTranslate failed: device_id=%d, "
            "vptr=%#" PRIx64 ", drvRetCode=%d!",
            deviceId, vptr, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    RT_LOG(RT_LOG_DEBUG, "device_id=%d, vptr=%#" PRIx64 ", offset=%#" PRIx64, deviceId, vptr, *pptr);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MemConvertAddr(const uint64_t src, const uint64_t dst, const uint64_t len,
                                    struct DMA_ADDR * const dmaAddress)
{
    TIMESTAMP_NAME(__func__);
    NULL_PTR_RETURN_MSG(dmaAddress, RT_ERROR_DRV_PTRNULL);
    const drvError_t drvRet = drvMemConvertAddr(static_cast<DVdeviceptr>(src), static_cast<DVdeviceptr>(dst),
        static_cast<UINT32>(len), dmaAddress);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] drvMemConvertAddr failed: pSrc=%" PRIu64 ", pDst=%" PRIu64
            ", len=%" PRIu64 "(bytes), drvRetCode=%d", src, dst, len, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    if (dmaAddress->fixed_size != len) {
        RT_LOG(RT_LOG_WARNING, "[drv api]drvMemConvertAddr, fixed_size!=len, pSrc=%" PRIu64 ", pDst=%" PRIu64
            ", len=%" PRIu64 "(bytes), fixed_size:%u(bytes), drvRetCode=%d!", src, dst, len, dmaAddress->fixed_size,
            static_cast<int32_t>(drvRet));
    }
    if (dmaAddress->fixed_size > len) {
        RT_LOG_OUTER_MSG(RT_INVALID_ARGUMENT_ERROR,
            "[drv api] drvMemConvertAddr failed: pSrc=%" PRIu64 ", pDst=%" PRIu64
            ", len=%" PRIu64 "(bytes), fixed_size:%u(bytes), drvRetCode=%d!",
            src, dst, len, dmaAddress->fixed_size, static_cast<int32_t>(drvRet));
        return RT_ERROR_DRV_ERR;
    }

    if ((dmaAddress->fixed_size != len) && (dmaAddress->fixed_size == 0U)) {
        RT_LOG_OUTER_MSG(RT_INVALID_ARGUMENT_ERROR,
            "[drv api] drvMemConvertAddr failed, fixed_size is 0 : pSrc=%" PRIu64 ", "
            "pDst=%" PRIu64 ", len=%" PRIu64 "(bytes), fixed_size:%u, drvRetCode=%d!", src,
            dst, len, dmaAddress->fixed_size, static_cast<int32_t>(drvRet));
        return RT_ERROR_DRV_ERR;
    }

    RT_LOG(RT_LOG_DEBUG, "drvMemConvertAddr success, pSrc=%" PRIu64 ", pDst=%" PRIu64 ", len=%" PRIu64 ", "
           "fixed_size:%u.", src, dst, len, dmaAddress->fixed_size);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MemDestroyAddr(struct DMA_ADDR * const ptr)
{
    TIMESTAMP_NAME(__func__);

    struct DMA_ADDR *tmp = ptr;
    drvError_t drvRet;

    drvRet = ((IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_MEM_DESTROY_ADDR_BATCH)) && (&halMemDestroyAddrBatch != nullptr)) ?
        halMemDestroyAddrBatch(&tmp, 1) : drvMemDestroyAddr(ptr);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] drvMemDestroyAddr failed: drvRetCode=%d!", static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::ProcessResBackup()
{
    COND_RETURN_WARN(
        &halProcessResBackup == nullptr, RT_ERROR_DRV_NOT_SUPPORT, "[drv api] halProcessResBackup does not exist.");

    halProcResBackupInfo info = {0};
    const drvError_t drvRet = halProcessResBackup(&info);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halProcessResBackup failed. drvRetCode=%d.",
            static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    RT_LOG(RT_LOG_INFO, "Process res backup success.");
    return RT_ERROR_NONE; 
}

rtError_t NpuDriver::ProcessResRestore()
{
    COND_RETURN_WARN(
        &halProcessResRestore == nullptr, RT_ERROR_DRV_NOT_SUPPORT, "[drv api] halProcessResRestore does not exist.");

    halProcResRestoreInfo info = {0};
    const drvError_t drvRet = halProcessResRestore(&info);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halProcessResRestore failed. drvRetCode=%d.",
            static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    RT_LOG(RT_LOG_INFO, "Process res restore success.");
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::HostDeviceClose(const uint32_t deviceId)
{
    COND_RETURN_WARN(
        &halDeviceClose == nullptr, RT_ERROR_DRV_NOT_SUPPORT, "[drv api] halDeviceClose does not exist.");

    halDevCloseIn devCloseIn = {DEV_CLOSE_HOST_USER, 0, {0}};
    const drvError_t drvRet = halDeviceClose(deviceId, &devCloseIn);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halDeviceClose failed. device_id=%u, drvRetCode=%d.",
            deviceId, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    RT_LOG(RT_LOG_INFO, "Close host device success, device_id=%u.", deviceId);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::DeviceClose(const uint32_t deviceId, const uint32_t tsId)
{
    if (isTscOpen_ && isTsvOpen_) {
        if (tsId == static_cast<uint32_t>(RT_TSV_ID)) {
            isTsvOpen_ = false;
        } else {
            isTscOpen_ = false;
        }
        RT_LOG(RT_LOG_INFO, "Close device success, device_id=%u, tsId=%u.", deviceId, tsId);
        return RT_ERROR_NONE;
    }

    TIMESTAMP_NAME(__func__);
    drvError_t drvRet = DRV_ERROR_NONE;
#ifndef CFG_DEV_PLATFORM_PC
    if (&halDeviceClose != nullptr) {
        halDevCloseIn devCloseIn = {0, 0, {0}};
        drvRet = halDeviceClose(deviceId, &devCloseIn);
        if (drvRet != DRV_ERROR_NONE) {
            DRV_ERROR_PROCESS(drvRet, "[drv api] halDeviceClose failed. device_id=%u, drvRetCode=%d.",
                deviceId, static_cast<int32_t>(drvRet));
            return RT_GET_DRV_ERRCODE(drvRet);
        }
    } else
#endif
    {
        COND_RETURN_WARN(&drvDeviceClose == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] drvDeviceClose does not support.");

        COND_RETURN_WARN(&drvMemDeviceClose == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] drvMemDeviceClose does not support.");

        drvRet = drvDeviceClose(deviceId);
        if (drvRet != DRV_ERROR_NONE) {
            DRV_ERROR_PROCESS(drvRet, "[drv api] drvDeviceClose failed: device_id=%u, drvRetCode=%d!",
                deviceId, drvRet);
            return RT_GET_DRV_ERRCODE(drvRet);
        }

        drvRet = static_cast<drvError_t>(drvMemDeviceClose(deviceId));
        if (drvRet != DRV_ERROR_NONE) {
            DRV_ERROR_PROCESS(drvRet, "[drv api] drvMemDeviceClose failed: device_id=%u, drvRetCode=%d!",
                deviceId, drvRet);
            return RT_GET_DRV_ERRCODE(drvRet);
        }
    }
    RT_LOG(RT_LOG_INFO, "Close device success, device_id=%u, tsId=%u.", deviceId, tsId);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::DeviceOpen(const uint32_t deviceId, const uint32_t tsId, uint32_t * const ssId)
{
    TIMESTAMP_NAME(__func__);

    if (tsId == static_cast<uint32_t>(RT_TSV_ID)) {
        RT_LOG(RT_LOG_INFO, "Open device success, device_id=%u, tsId=%u.", deviceId, tsId);
        isTsvOpen_ = true;
        return RT_ERROR_NONE;
    } else {
        isTscOpen_ = true;
    }

    RT_LOG(RT_LOG_INFO, "Open device start, device_id=%u, tsId=%u.", deviceId, tsId);
    drvError_t drvRet = DRV_ERROR_NONE;
#ifndef CFG_DEV_PLATFORM_PC
    if (&halDeviceOpen != nullptr) {
        halDevOpenIn devOpenIn= {0};
        halDevOpenOut devOpenOut = {0};
        drvRet = halDeviceOpen(deviceId, &devOpenIn, &devOpenOut);
        if (drvRet != DRV_ERROR_NONE) {
            DRV_ERROR_PROCESS(drvRet, "[drv api] halDeviceOpen failed. device_id=%u, drvRetCode=%d.",
                deviceId, static_cast<int32_t>(drvRet));
            return RT_GET_DRV_ERRCODE(drvRet);
        }
    } else
#endif
    {
        COND_RETURN_WARN(&drvDeviceOpen == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] drvDeviceOpen does not support.");

        COND_RETURN_WARN(&drvMemDeviceOpen == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] drvMemDeviceOpen does not support.");

        struct drvDevInfo devInfo = {0};
        drvRet = static_cast<drvError_t>(drvMemDeviceOpen(deviceId, static_cast<int32_t>(devInfo.fd)));
        if (drvRet != DRV_ERROR_NONE) {
            DRV_ERROR_PROCESS(drvRet, "[drv api] drvMemDeviceOpen failed: device_id=%u, drvRetCode=%d!",
                deviceId, static_cast<int32_t>(drvRet));
            return RT_GET_DRV_ERRCODE(drvRet);
        }
        drvRet = drvDeviceOpen(RtPtrToPtr<void **>(&devInfo), deviceId);
        if (drvRet != DRV_ERROR_NONE) {
            DRV_ERROR_PROCESS(drvRet, "[drv api] drvDeviceOpen failed: device_id=%u, drvRetCode=%d!",
                deviceId, static_cast<int32_t>(drvRet));
            const drvError_t drvRet1 = static_cast<drvError_t>(drvMemDeviceClose(deviceId));
            if (drvRet1 != DRV_ERROR_NONE) {
                DRV_ERROR_PROCESS(drvRet1, "[drv api] drvMemDeviceClose failed: device_id=%u, drvRetCode=%d!",
                    deviceId, static_cast<int32_t>(drvRet1));
            }
            return RT_GET_DRV_ERRCODE(drvRet);
        }
    } 

    drvRet = drvMemSmmuQuery(deviceId, ssId);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] drvMemSmmuQuery failed: device_id=%u, "
            "SSID=%#x, drvRetCode=%d!", deviceId, *ssId, static_cast<int32_t>(drvRet));
        (void)DeviceClose(deviceId, tsId);
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    RT_LOG(RT_LOG_INFO, "Open device success, device_id=%u, tsId=%u, SSID=%u.", deviceId, tsId, *ssId);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::GetDevInfo(const uint32_t deviceId, const int32_t moduleType,
                                const int32_t infoType, int64_t * const val)
{
    TIMESTAMP_NAME(__func__);
    uint32_t curDevIdx = deviceId;
    if (infoType == INFO_TYPE_MASTERID) { // INFO_TYPE_MASTERID need to use physical device ID
        const drvError_t drvRet = drvDeviceGetPhyIdByIndex(deviceId, &curDevIdx);
        if (drvRet != DRV_ERROR_NONE) {
            DRV_ERROR_PROCESS(drvRet,
                "[drv api] drvDeviceGetPhyIdByIndex failed: deviceId=%u, drvRetCode=%d!",
                deviceId, static_cast<int32_t>(drvRet));
            return RT_GET_DRV_ERRCODE(drvRet);
        }
    }
    const drvError_t drvRet = halGetDeviceInfo(curDevIdx, moduleType, infoType, val);
    if (drvRet != DRV_ERROR_NONE) {
        RT_LOG(RT_LOG_WARNING, "[drv api] halGetDeviceInfo failed: device_id=%u, "
                "moduleType=%d, infoType=%d, drvRetCode=%d!",
               deviceId, moduleType, infoType, static_cast<int32_t>(drvRet));
        if (moduleType == MODULE_TYPE_VECTOR_CORE) {
            (*val) = 0;
        } else {
            return RT_GET_DRV_ERRCODE(drvRet);
        }
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::GetPhyDevInfo(const uint32_t phyId, const int32_t moduleType,
                                   const int32_t infoType, int64_t * const val)
{
    TIMESTAMP_NAME(__func__);
    const drvError_t drvRet = halGetPhyDeviceInfo(phyId, moduleType, infoType, val);
    if (drvRet != DRV_ERROR_NONE) {
        RT_LOG(RT_LOG_WARNING, "[drv api] halGetPhyDeviceInfo failed: phyId=%u, drvRetCode=%d!",
               phyId, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::CreateIpcMem(const void * const vptr, const uint64_t byteCount,
                                  char_t * const name, const uint32_t len)
{
    TIMESTAMP_NAME(__func__);

    const drvError_t drvRet = halShmemCreateHandle(RtPtrToPtr<DVdeviceptr>(vptr),
        byteCount, name, len);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet,
            "[drv api] halShmemCreateHandle failed: name=%s, byteCount=%" PRIu64 ", len=%u(bytes), "
            "drvRetCode=%d!", name, byteCount, len, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    RT_LOG(RT_LOG_DEBUG, "create ipc mem success, name=%s, byteCount=%#" PRIx64 ", len=%u.",
            name, byteCount, len);

    return RT_ERROR_NONE;
}

rtError_t NpuDriver::SetIpcMemAttr(const char *name, uint32_t type, uint64_t attr)
{
    COND_RETURN_WARN(
        &halShmemSetAttribute == nullptr, RT_ERROR_DRV_NOT_SUPPORT, "[drv api] halShmemSetAttribute does not exist.");
    const drvError_t drvRet = halShmemSetAttribute(name, type, attr);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet,
            "[drv api] halShmemSetAttribute failed: type=%u, attr=%" PRIu64 ", "
            "drvRetCode=%d!",
            type,
            attr,
            static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    RT_LOG(RT_LOG_DEBUG, "set ipc mem attr success, name=%s, type=%u, attr=%" PRIx64 ".", name, type, attr);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::OpenIpcMem(const char_t * const name, uint64_t * const vptr, uint32_t devId)
{
    TIMESTAMP_NAME(__func__);

    drvError_t drvRet = DRV_ERROR_NONE;
    SpinLock &ipcMemNameLock = Runtime::Instance()->GetIpcMemNameLock();
    std::unordered_map<uint64_t, ipcMemInfo_t> &ipcMemNameMap = Runtime::Instance()->GetIpcMemNameMap();

    if (&halShmemOpenHandleByDevId == nullptr) {
        RT_LOG(RT_LOG_DEBUG, "not support halShmemOpenHandleByDevId api, use halShmemOpenHandle api.");
        drvRet = halShmemOpenHandle(name, RtPtrToPtr<DVdeviceptr *>(vptr));
    } else {
        drvRet = halShmemOpenHandleByDevId(devId, name, RtPtrToPtr<DVdeviceptr *>(vptr));
    }
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halShmemOpenHandle or halShmemOpenHandleByDevId failed: name=%s, drvRetCode=%d, device_id=%u!",
            name, static_cast<int32_t>(drvRet), devId);
        return RT_GET_DRV_ERRCODE(drvRet);
    } else {
        ipcMemNameLock.Lock();
        (void)ipcMemNameMap[*vptr].name.assign(name);
        ipcMemNameMap[*vptr].ref = 1;
        ipcMemNameMap[*vptr].locked = false;
        ipcMemNameLock.Unlock();
    }

    RT_LOG(RT_LOG_INFO, "Open ipc mem success, name=%s.", name);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::GetPhyDevIdByIpcMemName(const char *name, uint32_t *const phyDevId)
{
    COND_RETURN_WARN(
        &halShmemInfoGet == nullptr, RT_ERROR_DRV_NOT_SUPPORT, "[drv api] halShmemInfoGet does not exist.");
    struct ShmemGetInfo info {};
    const drvError_t drvRet = halShmemInfoGet(name, &info);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(
            drvRet, "[drv api] halShmemInfoGet failed: name=%s, drvRetCode=%d!", name, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    *phyDevId = info.phyDevid;
    RT_LOG(RT_LOG_DEBUG, "name=%s, pysical deviceId=%u.", name, *phyDevId);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::CloseIpcMem(const uint64_t vptr)
{
    TIMESTAMP_NAME(__func__);

    const drvError_t drvRet = halShmemCloseHandle(static_cast<DVdeviceptr>(vptr));
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halShmemCloseHandle failed: vptr=%#" PRIx64 ", drvRetCode=%d!",
            vptr, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    std::unordered_map<uint64_t, ipcMemInfo_t> &ipcMemNameMap = Runtime::Instance()->GetIpcMemNameMap();
    SpinLock &ipcMemNameLock = Runtime::Instance()->GetIpcMemNameLock();
    ipcMemNameLock.Lock();
    for (auto iter = ipcMemNameMap.begin(); iter != ipcMemNameMap.end(); iter++) {
        if (iter->first == vptr) {
            ipcMemNameMap.erase(iter);
            break;
        }
    }
    ipcMemNameLock.Unlock();

    RT_LOG(RT_LOG_DEBUG, "close ipc mem success,vptr=%#" PRIx64, vptr);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::DestroyIpcMem(const char_t * const name)
{
    TIMESTAMP_NAME(__func__);

    const drvError_t drvRet = halShmemDestroyHandle(name);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halShmemDestroyHandle failed: name=%s, drvRetCode=%d!",
            name, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    RT_LOG(RT_LOG_INFO, "Destroy ipc mem success, name=%s.", name);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::CreateIpcNotifyWithFlag(char_t * const name, const uint32_t len, const int32_t devId,
    uint32_t * const notifyId, const uint32_t tsId, const uint32_t notifyFlag) const
{
    if (&halShrIdCreate == nullptr) {
        RT_LOG(RT_LOG_ERROR, "Driver unspport with flag, name=%s", name);
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }

    drvShrIdInfo drvInfo;
    drvInfo.devid = static_cast<uint32_t>(devId);
    drvInfo.tsid = tsId;
    drvInfo.shrid = *notifyId;
    drvInfo.id_type = SHR_ID_NOTIFY_TYPE;
    drvInfo.flag = (notifyFlag == static_cast<uint32_t>(RT_NOTIFY_MC2)) ?
                   static_cast<uint32_t>(TSDRV_FLAG_REMOTE_ID) : 0U;

    RT_LOG(RT_LOG_INFO, "create ipc notify begin, deviceId=%u, notifyId=%u, tsId=%u, remote_notifyId=%u",
        drvInfo.devid, drvInfo.shrid, drvInfo.tsid, drvInfo.flag);
    const drvError_t drvRet = halShrIdCreate(&drvInfo, name, len);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet,
            "[drv api] halShrIdCreate failed: name=%s, device_id=%d, tsId=%u, notifyId=%u, "
            "drvRetCode=%d!", name, devId, tsId, *notifyId, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    RT_LOG(RT_LOG_INFO, "Create ipc notify success,name=%s, deviceId=%d, tsId=%u, notifyId=%u, "
           "len=%u, drvInfo.notifyId=%u.", name, devId, tsId, *notifyId, len, drvInfo.shrid);

    *notifyId = drvInfo.shrid;
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::CreateIpcNotify(char_t * const name, const uint32_t len, const int32_t devId,
                                     uint32_t * const notifyId, const uint32_t tsId,
                                     const uint32_t notifyFlag)
{
    return CreateIpcNotifyWithFlag(name, len, devId, notifyId, tsId, notifyFlag);
}

rtError_t NpuDriver::SetMemShareHandleDisablePidVerify(uint64_t shareableHandle)
{
    COND_RETURN_WARN(&halMemShareHandleSetAttribute == nullptr,
        RT_ERROR_DRV_NOT_SUPPORT,
        "[drv api] halMemShareHandleSetAttribute does not exist.");
    struct ShareHandleAttr attr {};
    attr.enableFlag = SHRID_NO_WLIST_ENABLE;
    const drvError_t drvRet = halMemShareHandleSetAttribute(shareableHandle, SHR_HANDLE_ATTR_NO_WLIST_IN_SERVER, attr);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet,
            "[drv api] halMemShareHandleSetAttribute failed: shareableHandle=%" PRIu64 " drvRetCode=%d!",
            shareableHandle,
            static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::GetPhyDevIdByMemShareHandle(uint64_t shareableHandle, uint32_t *const peerPhyDevId)
{
    COND_RETURN_WARN(&halMemShareHandleInfoGet == nullptr,
        RT_ERROR_DRV_NOT_SUPPORT,
        "[drv api] halMemShareHandleInfoGet does not exist.");
    struct ShareHandleGetInfo info {};
    const drvError_t drvRet = halMemShareHandleInfoGet(shareableHandle, &info);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet,
            "[drv api] halMemShareHandleInfoGet failed: shareableHandle=%" PRIu64 "drvRetCode=%d!",
            shareableHandle,
            static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    *peerPhyDevId = info.phyDevid;
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::SetIpcNotifyDisablePidVerify(const char_t *const name)
{
    COND_RETURN_WARN(
        &halShrIdSetAttribute == nullptr, RT_ERROR_DRV_NOT_SUPPORT, "[drv api] halShrIdSetAttribute does not exist.");
    struct shrIdAttr attr {};
    attr.enableFlag = SHRID_NO_WLIST_ENABLE;
    const drvError_t drvRet = halShrIdSetAttribute(name, SHR_ID_ATTR_NO_WLIST_IN_SERVER, attr);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(
            drvRet, "[drv api] halShrIdSetAttribute failed: name=%s, drvRetCode=%d!", name, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::GetIpcNotifyPeerPhyDevId(const char *const name, uint32_t *const peerPhyDevId)
{
    COND_RETURN_WARN(
        &halShrIdInfoGet == nullptr, RT_ERROR_DRV_NOT_SUPPORT, "[drv api] halShrIdInfoGet does not exist.");
    struct shrIdGetInfo info {};
    const drvError_t drvRet = halShrIdInfoGet(name, &info);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(
            drvRet, "[drv api] halShrIdInfoGet failed: name=%s, drvRetCode=%d!", name, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    *peerPhyDevId = info.phyDevid;
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::DestroyIpcNotify(const char_t * const name, const int32_t devId,
                                      const uint32_t notifyId, const uint32_t tsId)
{
    if (&halShrIdDestroy != nullptr) {
        const drvError_t drvRet = halShrIdDestroy(name);
        if (drvRet != DRV_ERROR_NONE) {
            DRV_ERROR_PROCESS(drvRet,
                "[drv api] halShrIdDestroy failed: name=%s, device_id=%d, tsId=%u, notifyId=%u, "
                "drvRetCode=%d!", name, devId, tsId, notifyId, static_cast<int32_t>(drvRet));
            return RT_GET_DRV_ERRCODE(drvRet);
        }
        RT_LOG(RT_LOG_INFO, "Destroy ipc with halShrIdDestroy success, device_id=%d, name=%s, notifyId=%u.",
            devId, name, notifyId);
        return RT_ERROR_NONE;
    }
    COND_RETURN_WARN(&drvDestroyIpcNotify == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] drvDestroyIpcNotify does not support.");
    
    drvIpcNotifyInfo drvInfo;
    drvInfo.devId = static_cast<uint32_t>(devId);
    drvInfo.tsId = tsId;
    drvInfo.notifyId = notifyId;
    const drvError_t drvRet = drvDestroyIpcNotify(name, &drvInfo);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet,
            "[drv api] drvDestroyIpcNotify failed: name=%s, device_id=%d, tsId=%u, notifyId=%u, "
            "drvRetCode=%d!", name, devId, tsId, notifyId, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    RT_LOG(RT_LOG_INFO, "Destroy ipc success, device_id=%d, name=%s, notifyId=%u.",
            devId, name, notifyId);
    return RT_ERROR_NONE;
}

static rtError_t OpenIpcNotifyWithFlag(const IpcNotifyOpenPara &openPara,
    uint32_t * const phyId, uint32_t * const notifyId, uint32_t * const tsId,
    uint32_t * const isPod)
{
    if (&halShrIdOpen == nullptr) {
        RT_LOG(RT_LOG_WARNING, "Driver unspport with flag, name=%s", openPara.name);
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }

    drvShrIdInfo drvInfo;
    drvInfo.devid = openPara.localDevId;
    drvInfo.tsid = openPara.localTsId;
    drvInfo.id_type = SHR_ID_NOTIFY_TYPE;
    drvInfo.flag = (((openPara.flag & static_cast<uint32_t>(RT_NOTIFY_FLAG_DOWNLOAD_TO_DEV)) != 0U) ?
        static_cast<uint32_t>(TSDRV_FLAG_REMOTE_ID) : 0U);
    RT_LOG(RT_LOG_INFO, "Open ipc notify begin, deviceId=%u, tsId=%u, flag=%u",
           drvInfo.devid, drvInfo.tsid, drvInfo.flag);
    const drvError_t drvRet = halShrIdOpen(openPara.name, &drvInfo);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halShrIdOpen failed: name=%s, drvRetCode=%d, device_id=%u!",
            openPara.name, static_cast<int32_t>(drvRet), drvInfo.devid);
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    if (drvInfo.id_type != SHR_ID_NOTIFY_TYPE) {
        RT_LOG(RT_LOG_ERROR, "[drv api] halShrIdOpen return type invalid: name=%s, "
            "id_type[%d] != SHR_ID_NOTIFY_TYPE.",
            openPara.name, static_cast<int32_t>(drvInfo.id_type));
        (void)halShrIdClose(openPara.name);
        return RT_ERROR_DRV_NO_NOTIFY_RESOURCES;
    }

    *phyId = drvInfo.devid; // driver returns phyId instead of devId
    *notifyId = drvInfo.shrid;
    *tsId = drvInfo.tsid;
    if ((drvInfo.flag & static_cast<uint32_t>(TSDRV_FLAG_SHR_ID_SHADOW)) != 0U) {
        *isPod = 1U;
    }

    RT_LOG(RT_LOG_INFO, "Open ipc notify success,phyId=%u, name=%s, notifyId=%u, tsId=%u.",
           *phyId, openPara.name, *notifyId, *tsId);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::OpenIpcNotify(const IpcNotifyOpenPara &openPara, uint32_t * const phyId,
    uint32_t * const notifyId, uint32_t * const tsId, uint32_t * const isPod)
{
    const bool isNewChip =
        IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DEVICE_NON_UNIFIED_ADDR) &&
        g_isAddrFlatDevice;
    RT_LOG(RT_LOG_INFO, "open notify name=%s, type=%d", openPara.name, isNewChip);

    if (isNewChip) {
        return OpenIpcNotifyWithFlag(openPara, phyId, notifyId, tsId, isPod);
    }

    return OpenIpcNotifyWithFlag(openPara, phyId, notifyId, tsId, isPod);
}

rtError_t NpuDriver::CloseIpcNotify(const char_t * const name, const int32_t devId,
                                    const uint32_t notifyId, const uint32_t tsId)
{
    drvIpcNotifyInfo drvInfo;
    drvInfo.devId = static_cast<uint32_t>(devId);
    drvInfo.tsId = tsId;
    drvInfo.notifyId = notifyId;
    RT_LOG(RT_LOG_INFO, "close ipc notify begin, deviceId=%u, name=%s, notifyId=%u, tsId=%u.",
            drvInfo.devId, name, drvInfo.notifyId, drvInfo.tsId);
    const drvError_t drvRet = drvCloseIpcNotify(name, &drvInfo);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] drvCloseIpcNotify failed: name=%s, device_id=%d, "
            "notifyId=%u, tsId=%u, drvRetCode=%d!", name, devId, notifyId, tsId, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    RT_LOG(RT_LOG_INFO, "close ipc notify, deviceId=%d, name=%s, notifyId=%u, tsId=%u.",
            devId, name, notifyId, tsId);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::SetIpcNotifyPid(const char_t * const name, int32_t pid[], const int32_t num)
{
    if (&halShrIdSetPid != nullptr) {
        const drvError_t drvRet = halShrIdSetPid(name, pid, static_cast<uint32_t>(num));
        if (drvRet != DRV_ERROR_NONE) {
            DRV_ERROR_PROCESS(drvRet, "[drv api] halShrIdSetPid failed, name=%s, drvRetCode=%d!",
                name, static_cast<int32_t>(drvRet));
            return RT_GET_DRV_ERRCODE(drvRet); 
        }
        RT_LOG(RT_LOG_INFO, "halShrIdSetPid success, name=%s, pid[0]=%d.", name, pid[0]);
        return RT_ERROR_NONE;
    }
    COND_RETURN_WARN(&drvSetIpcNotifyPid == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] drvSetIpcNotifyPid does not support.");
    const drvError_t drvRet = drvSetIpcNotifyPid(name, pid, num);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] drvSetIpcNotifyPid failed, name=%s, drvRetCode=%d!",
            name, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    RT_LOG(RT_LOG_INFO, "set ipc notify pid success, name=%s, pid[0]=%d.", name, pid[0]);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::SetIpcMemPid(const char_t * const name, int32_t pid[], const int32_t num)
{
    const drvError_t drvRet = halShmemSetPidHandle(name, pid, num);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halShmemSetPidHandle: drvRetCode=%d!", static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    RT_LOG(RT_LOG_INFO, "set ipc mem pid success, name=%s, pid[0]=%d, num=%d", name, pid[0], num);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::NotifyGetAddrOffset(const int32_t deviceId, const uint32_t notifyId,
                                         uint64_t * const devAddrOffset, const uint32_t tsId)
{
    if (&halResourceDetailQuery != nullptr) {
        struct halResourceIdInputInfo key = {DRV_NOTIFY_ID, tsId, notifyId, {0}};
        struct halResourceDetailInfo info = {DRV_RES_QUERY_OFFSET, 0, 0, {0}};
        const drvError_t drvRet = halResourceDetailQuery(static_cast<uint32_t>(deviceId), &key, &info);
        if (drvRet != DRV_ERROR_NONE) {
            DRV_ERROR_PROCESS(drvRet,
                "[drv api] halResourceDetailQuery failed: device_id=%d, notifyid=%u, "
                "tsId=%u, drvRetCode=%d!", deviceId, notifyId, tsId, static_cast<int32_t>(drvRet));
            return RT_GET_DRV_ERRCODE(drvRet);
        }
        if (devAddrOffset != nullptr) {
            *devAddrOffset = info.value0;
        }
        return RT_ERROR_NONE;
    }
    COND_RETURN_WARN(&drvNotifyIdAddrOffset == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT, "[drv api] drvDeviceOpen does not support.");
    drvNotifyInfo drvInfo = {};
    drvInfo.tsId = tsId;
    drvInfo.notifyId = notifyId;

    const drvError_t drvRet = drvNotifyIdAddrOffset(static_cast<uint32_t>(deviceId), &drvInfo);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet,
            "[drv api] drvNotifyIdAddrOffset failed, device_id=%d, notifyid=%u, "
            "tsId=%u, drvRetCode=%d!", deviceId, notifyId, tsId, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    if (devAddrOffset != nullptr) {
        *devAddrOffset = drvInfo.devAddrOffset;
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::LoadProgram(const int32_t devId, void * const prog, const uint32_t offset,
                                 const uint64_t size, void ** const vPtr)
{
    COND_RETURN_WARN(&drvLoadProgram == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] drvLoadProgram does not support.");
    const drvError_t drvRet = drvLoadProgram(static_cast<DVdevice>(devId), prog, offset, size, vPtr);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet,
            "[drv api] drvLoadProgram failed: device_id=%d, offset=%u, "
            "size=%" PRIu64 "(bytes), drvRetCode=%d!", devId, offset, size, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::GetDevicePhyIdByIndex(const uint32_t devIndex, uint32_t * const phyId)
{
    const drvError_t drvRet = drvDeviceGetPhyIdByIndex(devIndex, phyId);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet,
            "[drv api] drvDeviceGetPhyIdByIndex failed: devIndex=%u, drvRetCode=%d!",
            devIndex, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::GetDeviceIndexByPhyId(const uint32_t phyId, uint32_t * const devIndex)
{
    const drvError_t drvRet = drvDeviceGetIndexByPhyId(phyId, devIndex);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet,
            "[drv api] drvDeviceGetIndexByPhyId failed: phyId=%u, drvRetCode=%d!",
            phyId, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::DeviceGetPhyIdByIndex(const uint32_t devIndex, uint32_t * const phyId)
{
    const drvError_t drvRet = drvDeviceGetPhyIdByIndex(devIndex, phyId);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet,
            "[drv api] drvDeviceGetPhyIdByIndex failed: devIndex=%u, drvRetCode=%d!",
            devIndex, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    return RT_ERROR_NONE;
}

rtError_t NpuDriver::DeviceGetIndexByPhyId(const uint32_t phyId, uint32_t * const devIndex)
{
    const drvError_t drvRet = drvDeviceGetIndexByPhyId(phyId, devIndex);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] drvDeviceGetIndexByPhyId failed: phyId=%u, drvRetCode=%d!",
            phyId, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    return RT_ERROR_NONE;
}

rtError_t NpuDriver::EnableP2P(const uint32_t devIdDes, const uint32_t phyIdSrc, const uint32_t flag)
{
    const rtChipType_t type = Runtime::Instance()->GetChipType();
    // Static function does not have featureSet
    if (!IS_SUPPORT_CHIP_FEATURE(type, RtOptionalFeatureType::RT_FEATURE_DEVICE_P2P)) {
        UNUSED(devIdDes);
        UNUSED(phyIdSrc);
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    } else {
        const drvError_t drvRet = halDeviceEnableP2P(devIdDes, phyIdSrc, flag);
        if (drvRet != DRV_ERROR_NONE) {
            DRV_ERROR_PROCESS(drvRet, "[drv api] halDeviceEnableP2P failed: drv devId=%u, phyIdSrc=%u, "
                "drvRetCode=%d!", devIdDes, phyIdSrc, static_cast<int32_t>(drvRet));
            return RT_GET_DRV_ERRCODE(drvRet);
        }
        RT_LOG(RT_LOG_INFO, "devIdDes=%u, phyIdSrc=%u, flag=%u", devIdDes, phyIdSrc, flag);
        return RT_ERROR_NONE;
    }
}

rtError_t NpuDriver::DisableP2P(const uint32_t devIdDes, const uint32_t phyIdSrc)
{
    const rtChipType_t type = Runtime::Instance()->GetChipType();
    // Static function does not have featureSet
    if (!IS_SUPPORT_CHIP_FEATURE(type, RtOptionalFeatureType::RT_FEATURE_DEVICE_P2P)) {
        UNUSED(devIdDes);
        UNUSED(phyIdSrc);
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    } else {
        constexpr uint32_t flag = 0U;
        const drvError_t drvRet = halDeviceDisableP2P(devIdDes, phyIdSrc, flag);
        if (drvRet != DRV_ERROR_NONE) {
            DRV_ERROR_PROCESS(drvRet, "[drv api] halDeviceDisableP2P failed: devIdDes=%u, phyIdSrc=%u, "
                "drvRetCode=%d!", devIdDes, phyIdSrc, static_cast<int32_t>(drvRet));
            return RT_GET_DRV_ERRCODE(drvRet);
        }

        return RT_ERROR_NONE;
    }
}

rtError_t NpuDriver::DeviceCanAccessPeer(int32_t * const canAccessPeer, const uint32_t dev, const uint32_t peerDevice)
{
    const drvError_t drvRet = halDeviceCanAccessPeer(canAccessPeer, dev, peerDevice);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halDeviceCanAccessPeer failed: device=%u, peerDevice=%u, "
            "drvRetCode=%d!", dev, peerDevice, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::GetP2PStatus(const uint32_t devIdDes, const uint32_t phyIdSrc, uint32_t * const status)
{
    const rtChipType_t type = Runtime::Instance()->GetChipType();
    // Static function does not have featureSet
    if (!IS_SUPPORT_CHIP_FEATURE(type, RtOptionalFeatureType::RT_FEATURE_DEVICE_P2P)) {
        UNUSED(devIdDes);
        UNUSED(phyIdSrc);
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    } else {
        const drvError_t drvRet = drvGetP2PStatus(devIdDes, phyIdSrc, status);
        if (drvRet != DRV_ERROR_NONE) {
            DRV_ERROR_PROCESS(drvRet, "[drv api] drvGetP2PStatus failed: devIdDes=%u, phyIdSrc=%u, "
                "drvRetCode=%d!", devIdDes, phyIdSrc, static_cast<int32_t>(drvRet));
            return RT_GET_DRV_ERRCODE(drvRet);
        }

        return RT_ERROR_NONE;
    }
}

rtError_t NpuDriver::DeviceGetBareTgid(uint32_t * const pid) const
{
    *pid = static_cast<uint32_t>(drvDeviceGetBareTgid());
    return RT_ERROR_NONE;
}

// Alloc specified memory.
rtError_t NpuDriver::MemAllocEx(void ** const dptr, const uint64_t size, const rtMemType_t memType)
{
    (void)dptr;
    (void)size;
    (void)memType;
    return RT_ERROR_NONE;
}

// Free specified memory.
rtError_t NpuDriver::MemFreeEx(void * const dptr)
{
    (void)dptr;
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MemQueueExport(const int32_t devId, const uint32_t qid, const int32_t peerDevId,
        const char * const shareName)
{
    COND_RETURN_WARN(&halQueueExport == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halQueueExport does not exist.");
    TIMESTAMP_NAME(__func__);
    RT_LOG(RT_LOG_INFO, "Export mem queue, drv deviceId=%d, qid=%dm, peerDevId=%d .", 
        devId, qid, peerDevId);

    shareQueInfo queInfo = {};
    queInfo.peerDevId = peerDevId;
    errno_t ret = strcpy_s(queInfo.shareQueName, SHARE_QUEUE_NAME_LEN, shareName);
    COND_RETURN_WARN(ret != EOK, RT_ERROR_INVALID_VALUE, "strcpy_s failed!");

    const drvError_t drvRet = halQueueExport(devId, qid, &queInfo);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halQueueExport failed: device_id=%d, qid=%d, peerDevId=%d.",
            devId, qid, peerDevId);
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;    
}

rtError_t NpuDriver::MemQueueUnExport(const int32_t devId, const uint32_t qid, const int32_t peerDevId,
        const char * const shareName)
{
    COND_RETURN_WARN(&halQueueUnexport == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halQueueUnExport does not exist.");
    TIMESTAMP_NAME(__func__);
    RT_LOG(RT_LOG_INFO, "UnExport mem queue, drv deviceId=%d, qid=%dm, peerDevId=%d .", 
        devId, qid, peerDevId);

    shareQueInfo queInfo = {};
    queInfo.peerDevId = peerDevId;
    errno_t ret = strcpy_s(queInfo.shareQueName, SHARE_QUEUE_NAME_LEN, shareName);
    COND_RETURN_WARN(ret != EOK, RT_ERROR_INVALID_VALUE, "strcpy_s failed!");

    const drvError_t drvRet = halQueueUnexport(devId, qid, &queInfo);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halQueueUnExport failed: device_id=%d, qid=%d, peerDevId=%d.",
            devId, qid, peerDevId);
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;    
}


rtError_t NpuDriver::MemQueueImport(const int32_t devId, const int32_t peerDevId, const char * const shareName,
        uint32_t * const qid)
{
    COND_RETURN_WARN(&halQueueImport == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halQueueImport does not exist.");
    TIMESTAMP_NAME(__func__);
    RT_LOG(RT_LOG_INFO, "Import mem queue, drv deviceId=%d, peerDevId=%dm.", 
        devId, peerDevId);

    shareQueInfo queInfo = {};
    queInfo.peerDevId = peerDevId;
    errno_t ret = strcpy_s(queInfo.shareQueName, SHARE_QUEUE_NAME_LEN, shareName);
    COND_RETURN_WARN(ret != EOK, RT_ERROR_INVALID_VALUE, "strcpy_s failed!");

    const drvError_t drvRet = halQueueImport(devId, &queInfo, qid);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halQueueImport failed: device_id=%d, peerDevId=%d.",
            devId, peerDevId);
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;    
}

rtError_t NpuDriver::MemQueueUnImport(const int32_t devId, const uint32_t qid, const int32_t peerDevId, 
        const char * const shareName)
{
    COND_RETURN_WARN(&halQueueUnimport == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halQueueUnImport does not exist.");
    TIMESTAMP_NAME(__func__);
    RT_LOG(RT_LOG_INFO, "UnImport mem queue, drv deviceId=%d, qid=%dm, peerDevId=%d.", devId, qid, 
        peerDevId);

    shareQueInfo queInfo = {};
    queInfo.peerDevId = peerDevId;
    errno_t ret = strcpy_s(queInfo.shareQueName, SHARE_QUEUE_NAME_LEN, shareName);
    COND_RETURN_WARN(ret != EOK, RT_ERROR_INVALID_VALUE, "strcpy_s failed!");

    const drvError_t drvRet = halQueueUnimport(devId, qid, &queInfo);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halQueueUnimport failed: device_id=%d, peerDevId=%d.",
            devId, peerDevId);
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;    
}

rtError_t NpuDriver::MemQueueReset(const int32_t devId, const uint32_t qid)
{
    RT_LOG(RT_LOG_INFO, "drv devId=%d, qid=%u.", devId, qid);
    COND_RETURN_WARN(&halQueueReset == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halQueueReset does not exist.");
    const drvError_t drvRet = halQueueReset(static_cast<uint32_t>(devId), qid);
    COND_RETURN_WARN(drvRet == DRV_ERROR_NOT_SUPPORT, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halQueueReset does not support.");
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halQueueReset failed: device_id=%d, qid=%u, drvRetCode=%d.",
            devId, qid, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

bool NpuDriver::CheckIsSupportFeature(uint32_t devId, int32_t featureType)
{
    if (&halSupportFeature == nullptr) {
        RT_LOG(RT_LOG_INFO, "halSupportFeature does not exist");
        return false;
    }

    if (featureType < 0 || static_cast<drvFeature_t>(featureType) >= FEATURE_MAX) {
        RT_LOG(RT_LOG_ERROR, "featureType %d is invalid.", featureType);
        return false;
    }

    static std::map<drvFeature_t, std::string> featureNameMap = {
        {FEATURE_SVM_GET_USER_MALLOC_ATTR, "FEATURE_SVM_GET_USER_MALLOC_ATTR"},
        {FEATURE_MEMCPY_BATCH_ASYNC, "FEATURE_MEMCPY_BATCH_ASYNC"},
        {FEATURE_TRSDRV_SQ_DEVICE_MEM_PRIORITY, "FEATURE_TRSDRV_SQ_DEVICE_MEM_PRIORITY"},
        {FEATURE_TRSDRV_SQ_SUPPORT_DYNAMIC_BIND, "FEATURE_TRSDRV_SQ_SUPPORT_DYNAMIC_BIND"},
        {FEATURE_HOST_PIN_REGISTER_SUPPORT_UVA, "FEATURE_HOST_PIN_REGISTER_SUPPORT_UVA"},
        {FEATURE_SVM_VMM_NORMAL_GRANULARITY, "FEATURE_SVM_VMM_NORMAL_GRANULARITY"},
        {FEATURE_TRSDRV_IS_SQ_SUPPORT_DYNAMIC_BIND_VERSION, "FEATURE_TRSDRV_IS_SQ_SUPPORT_DYNAMIC_BIND_VERSION"},
    };

    auto iter = featureNameMap.find(static_cast<drvFeature_t>(featureType));
    if (iter == featureNameMap.end()) {
        RT_LOG(RT_LOG_INFO, "featureType %d is not exist", featureType);
        return false;
    }

    const bool isSupported = halSupportFeature(devId, static_cast<drvFeature_t>(featureType));
    RT_LOG(RT_LOG_INFO, "%s %s, drv devId=%u.", (isSupported ? "Support" : "Not support"), iter->second.c_str(), devId);
    return isSupported;
}

rtError_t NpuDriver::MemQueueQueryInfo(const int32_t devId, const uint32_t qid, rtMemQueueInfo_t * const queInfo)
{
    RT_LOG(RT_LOG_DEBUG, "query queue info, drv devId=%d, qid=%u.", devId, qid);

    COND_RETURN_WARN(&halQueueQueryInfo == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halQueueQueryInfo does not exist.");
    QueueInfo memQueInfo = {};
    const drvError_t drvRet = halQueueQueryInfo(static_cast<uint32_t>(devId), qid, &memQueInfo);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halQueueQueryInfo failed: drv devId=%d, qid=%u, drvRetCode=%d.",
            devId, qid, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    // only size is valid in host halQueueQueryInfo api
    queInfo->size = memQueInfo.size;
    queInfo->id = memQueInfo.id;
    queInfo->depth = static_cast<uint32_t>(memQueInfo.depth);
    queInfo->status = memQueInfo.status;
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MemQueueGrant(const int32_t devId, const uint32_t qid, const int32_t pid,
                                   const rtMemQueueShareAttr_t * const attr)
{
    RT_LOG(RT_LOG_INFO, "grant mem queue, drv devId=%d, qid=%u, pid=%d.", devId, qid, pid);

    COND_RETURN_WARN(&halQueueGrant == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halQueueGrant does not exist.");
    QueueShareAttr drvAttr = {};
    drvAttr.manage = attr->manage;
    drvAttr.read = attr->read;
    drvAttr.write = attr->write;
    const drvError_t drvRet = halQueueGrant(static_cast<uint32_t>(devId), static_cast<int32_t>(qid), pid, drvAttr);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halQueueGrant failed: device_id=%d, qid=%u, pid=%d, drvRetCode=%d.", devId,
            qid, pid, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::QueueSubscribe(const int32_t devId, const uint32_t qId,
                                    const uint32_t groupId, const int32_t type)
{
    RT_LOG(RT_LOG_INFO, "Esched attach device, drv devId=%d.", devId);

    COND_RETURN_WARN(&halQueueSubscribe == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halQueueSubscribe does not exist.");

    const drvError_t drvRet = halQueueSubscribe(static_cast<uint32_t>(devId), qId, groupId, type);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halQueueSubscribe failed: device_id=%d, drvRetCode=%d.", devId,
            static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::QueueSubF2NFEvent(const int32_t devId, const uint32_t qId, const uint32_t groupId)
{
    RT_LOG(RT_LOG_INFO, "Esched attach device, drv devId=%d.", devId);

    COND_RETURN_WARN(&halQueueSubF2NFEvent == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halQueueSubF2NFEvent does not exist.");

    const drvError_t drvRet = halQueueSubF2NFEvent(static_cast<uint32_t>(devId), qId, groupId);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halQueueSubF2NFEvent failed: device_id=%d, drvRetCode=%d.", devId,
            static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::QueryDevPid(const rtBindHostpidInfo_t * const info, int32_t * const devPid)
{
    TIMESTAMP_NAME(__func__);
    RT_LOG(RT_LOG_INFO, "chipId=%d, hostPid=%u.", info->chipId, static_cast<uint32_t>(info->hostPid));

    COND_RETURN_WARN(&halQueryDevpid == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halQueryDevpid does not exist.");
    struct halQueryDevpidInfo drvInfo;
    const errno_t ret = memset_s(&drvInfo, sizeof(drvInfo), 0, sizeof(drvInfo));
    COND_LOG_ERROR(ret != EOK, "memset_s failed, size=%zu(bytes), retCode=%d!", sizeof(drvInfo), ret);
    drvInfo.hostpid = info->hostPid;
    drvInfo.vfid = info->vfid;
    drvInfo.devid = info->chipId;
    drvInfo.proc_type = static_cast<enum devdrv_process_type>(info->cpType);

    const drvError_t drvRet = halQueryDevpid(drvInfo, devPid);
    if (drvRet != DRV_ERROR_NONE) {
        RT_LOG(RT_LOG_WARNING, "[drv api] halQueryDevpid failed: ChipId=%d, hostPid=%u, drvRetCode=%d.",
            info->chipId, static_cast<uint32_t>(info->hostPid), static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::GetChipCount(uint32_t * const cnt)
{
    *cnt = 1U;
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::GetChipList(uint32_t chipList[], const uint32_t cnt)
{
    for (uint32_t i = 0U; i < cnt; i++) {
        chipList[i] = i;
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::GetDeviceCountFromChip(const uint32_t chipId, uint32_t * const cnt)
{
    UNUSED(chipId);
    *cnt = 1U;
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::GetDeviceFromChip(const uint32_t chipId, uint32_t deviceList[], const uint32_t cnt)
{
    UNUSED(chipId);
    for (uint32_t i = 0U; i < cnt; i++) {
        deviceList[i] = i;
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::GetChipFromDevice(const uint32_t deviceId, uint32_t * const chipId)
{
    if (!IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DEVICE_MULTI_CHIP)) {
        *chipId = 0U;
        return RT_ERROR_NONE;
    }
    COND_RETURN_WARN(&halGetChipFromDevice == nullptr, RT_ERROR_DRV_NOT_SUPPORT,
        "[drv api] halGetChipFromDevice does not exist.");

    const drvError_t drvRet = halGetChipFromDevice(static_cast<int32_t>(deviceId), RtPtrToPtr<int32_t *>(chipId));
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "Call halGetChipFromDevice failed. device_id=%u", deviceId);
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    RT_LOG(RT_LOG_INFO, "deviceId=%u, chipId=%u.", deviceId, *chipId);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::GetPairDevicesInfo(const uint32_t devId, const uint32_t otherDevId,
                                        const int32_t infoType, int64_t * const val, const bool deviceFlag)
{
    drvError_t drvRet = DRV_ERROR_NONE;
    if(!deviceFlag){
        drvRet = halGetPairDevicesInfo(devId, otherDevId, infoType, val);
    }else{
        drvRet = halGetPairPhyDevicesInfo(devId, otherDevId, infoType, val);
    }

    if (drvRet == DRV_ERROR_NOT_SUPPORT) {
        std::string name = deviceFlag ? "halGetPairPhyDevicesInfo" : "halGetPairDevicesInfo";
        RT_LOG(RT_LOG_WARNING, "not support %s!", name.c_str());
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    if (drvRet != DRV_ERROR_NONE) {
        std::string name = deviceFlag ? "halGetPairPhyDevicesInfo" : "halGetPairDevicesInfo";
        DRV_ERROR_PROCESS(drvRet,
            "[drv api] %s failed: drv devId=%u, drv otherDevId=%u, infoType=%d, drvRetCode=%d!", name.c_str(), devId,
            otherDevId, infoType, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::GetCapabilityGroupInfo(const int32_t deviceId, const int32_t ownerId, const int32_t groupId,
                                            struct capability_group_info * const groupInfo, const int32_t groupCount)
{
    const drvError_t drvRet = halGetCapabilityGroupInfo(deviceId, ownerId, groupId, groupInfo, groupCount);
    if (drvRet == DRV_ERROR_NOT_SUPPORT) {
        RT_LOG(RT_LOG_WARNING, "not support halGetCapabilityGroupInfo!");
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halGetCapabilityGroupInfo failed: "
            "device_id=%d, drvRetCode=%d!", deviceId, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    return RT_ERROR_NONE;
}

rtError_t NpuDriver::GetChipCapability(const uint32_t deviceId, struct halCapabilityInfo * const info)
{
    const drvError_t drvRet = halGetChipCapability(deviceId, info);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halGetChipCapability failed: device_id=%u, drvRetCode=%d!",
            deviceId, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    return RT_ERROR_NONE;
}

rtError_t NpuDriver::GetL2CacheOffset(uint32_t deviceId, uint64_t *offset)
{
    size_t outSize = 0U;
    const drvError_t drvRet = halMemCtl(static_cast<int32_t>(RtCtrlType::RT_CTRL_TYPE_GET_DOUBLE_PGTABLE_OFFSET),
                                        &deviceId, sizeof(uint32_t), offset, &outSize);
    COND_RETURN_WARN(drvRet == DRV_ERROR_NOT_SUPPORT, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halMemCtl does not support.");
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halMemCtl get l2cache offset failed: drvRetCode=%d",
            static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    return RT_ERROR_NONE;
}

rtError_t NpuDriver::GetSmmuFaultValid(uint32_t deviceId, bool &isValid)
{
    COND_RETURN_WARN(&halCheckProcessStatus == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halCheckProcessStatus does not exist");
    const drvError_t drvRet = halCheckProcessStatus(deviceId, PROCESS_CP1, static_cast<processStatus_t>(2U), &isValid);
    COND_RETURN_WARN(drvRet == DRV_ERROR_NOT_SUPPORT, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halCheckProcessStatus does not support.");
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halCheckProcessStatus get smmu fault valid failed: drvRetCode=%d",
            static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    return RT_ERROR_NONE;
}

rtError_t NpuDriver::GetC2cCtrlAddr(const int32_t deviceId, uint64_t * const addr, uint32_t * const len)
{
    struct AddrMapInPara inPara = {};
    struct AddrMapOutPara outPara = {};
    size_t outSizeRet = sizeof(outPara);

    inPara.addr_type = static_cast<uint32_t>(ADDR_MAP_TYPE_REG_C2C_CTRL);
    inPara.devid = static_cast<uint32_t>(deviceId);

    const drvError_t drvRet = halMemCtl(static_cast<int32_t>(CTRL_TYPE_ADDR_MAP), &inPara, sizeof(inPara),
                                        &outPara, &outSizeRet);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halMemCtl get c2c ctrl addr failed: drvRetCode=%d",
            static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    *addr = static_cast<uint64_t>(outPara.ptr);
    *len  = static_cast<uint32_t>(outPara.len);

    return RT_ERROR_NONE;
}

TIMESTAMP_EXTERN(halMemcpy2D);
rtError_t NpuDriver::MemCopy2D(void * const dst, const uint64_t dstPitch, const void * const src,
                               const uint64_t srcPitch, const uint64_t width, const uint64_t height,
                               const uint32_t kind, const uint32_t type, const uint64_t fixedSize,
                               struct DMA_ADDR * const dmaAddress)
{
    struct MEMCPY2D memCpy2DValue = {};
    memCpy2DValue.type = type;
    if (type == static_cast<uint32_t>(DEVMM_MEMCPY2D_SYNC)) {
        memCpy2DValue.copy2d.dst = RtPtrToPtr<UINT64 *>(dst);
        memCpy2DValue.copy2d.dpitch = dstPitch;
        memCpy2DValue.copy2d.src = RtPtrToPtr<UINT64 *>(const_cast<void *>(src));
        memCpy2DValue.copy2d.spitch = srcPitch;
        memCpy2DValue.copy2d.width = width;
        memCpy2DValue.copy2d.height = height;
        memCpy2DValue.copy2d.direction = kind;
    } else if (type == static_cast<uint32_t>(DEVMM_MEMCPY2D_ASYNC_CONVERT)) {
        memCpy2DValue.copy2dAsync.copy2dInfo.direction = kind;
        memCpy2DValue.copy2dAsync.copy2dInfo.dst = RtPtrToPtr<UINT64 *>(dst);
        memCpy2DValue.copy2dAsync.copy2dInfo.dpitch = dstPitch;
        memCpy2DValue.copy2dAsync.copy2dInfo.src = RtPtrToPtr<UINT64 *>(const_cast<void *>(src));
        memCpy2DValue.copy2dAsync.copy2dInfo.spitch = srcPitch;
        memCpy2DValue.copy2dAsync.copy2dInfo.width = width;
        memCpy2DValue.copy2dAsync.copy2dInfo.height = height;
        memCpy2DValue.copy2dAsync.copy2dInfo.fixed_size = fixedSize;
        memCpy2DValue.copy2dAsync.dmaAddr = dmaAddress;
    } else {
        // do nothing
    }

    COND_RETURN_WARN(&halMemcpy2D == nullptr, RT_ERROR_DRV_NOT_SUPPORT,
        "[drv api] halMemcpy2D does not exist.");
    NpuDriverRecord record(static_cast<uint16_t>(RT_PROF_DRV_API_HalMemcpy2D));
    TIMESTAMP_BEGIN(halMemcpy2D);
    const drvError_t drvRet = halMemcpy2D(&memCpy2DValue);
    TIMESTAMP_END(halMemcpy2D);
    record.SaveRecord();

    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halMemcpy2D failed: drvRetCode=%d! ", static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    RT_LOG(RT_LOG_DEBUG, "halMemcpy2D success, dpitch=%" PRIu64 ", spitch=%" PRIu64
         ", width=%" PRIu64 ", height=%" PRIu64 ", fixed_size:%" PRIu64,
        dstPitch, srcPitch, width, height, fixedSize);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::PcieHostRegister(void * const addr, const uint64_t size, const uint32_t deviceId, void *&outAddr)
{
    const drvError_t drvRet = halHostRegister(addr, static_cast<UINT64>(size), static_cast<UINT32>(DEV_SVM_MAP_HOST),
        deviceId, &outAddr);
    if (drvRet != DRV_ERROR_NONE) {
        RT_LOG(RT_LOG_WARNING, "[drv api] halHostRegister failed, chip type=%d, drvRetCode=%d",
            static_cast<int32_t>(chipType_), static_cast<int32_t>(drvRet));
        return RT_ERROR_DRV_ERR;
    }

    RT_LOG(RT_LOG_DEBUG, "device_id=%u, size=%" PRIu64, deviceId, size);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::PcieHostUnRegister(void * const addr, const uint32_t deviceId)
{
    const drvError_t drvRet = halHostUnregister(addr, deviceId);
    if (drvRet != DRV_ERROR_NONE) {
        RT_LOG(RT_LOG_WARNING, "[drv api] halHostUnregister failed, chip type=%d, drvRetCode=%d",
            static_cast<int32_t>(chipType_), static_cast<int32_t>(drvRet));
        return RT_ERROR_DRV_ERR;
    }

    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MemCopyAsyncEx(struct DMA_ADDR *dmaHandle)
{
    drvError_t drvRet = DRV_ERROR_NONE;

    drvRet = halMemcpySumbit(dmaHandle, static_cast<int32_t>(MEMCPY_SUMBIT_ASYNC));
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halMemcpySumbit failed, drvRetCode=%d", static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    RT_LOG(RT_LOG_INFO, "call halMemcpySumbit success.");
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::CheckSupportPcieBarCopy(const uint32_t deviceId, uint32_t &val, const bool need4KAsync)
{
    val = RT_CAPABILITY_NOT_SUPPORT;

    const uint32_t devRunMode = GetRunMode();
    if ((devRunMode == static_cast<uint32_t>(RT_RUN_MODE_OFFLINE)) || (halMemCtl == nullptr)) {
        RT_LOG(RT_LOG_INFO, "chip type=%d, not support pcie bar copy", static_cast<int32_t>(chipType_));
        return RT_ERROR_NONE;
    }

    size_t outSize = 0U;
    struct supportFeaturePara outVal = {};
    struct supportFeaturePara inVal = {};
    inVal.support_feature = static_cast<uint64_t>(CTRL_SUPPORT_PCIE_BAR_MEM_MASK);
    inVal.devid = deviceId;
    if (need4KAsync == false) {
        inVal.support_feature |= 0x8U; // 0x8U use 64k map
    }
    const drvError_t drvRet = halMemCtl(static_cast<int32_t>(CTRL_TYPE_SUPPORT_FEATURE), &inVal, sizeof(inVal),
                                        &outVal, &outSize);
    if (drvRet != DRV_ERROR_NONE) {
        RT_LOG(RT_LOG_WARNING, "[drv api] halMemCtl failed, chip type=%d, drvRetCode=%d, device_id=%u.",
               static_cast<int32_t>(chipType_), static_cast<int32_t>(drvRet), deviceId);
        return RT_ERROR_DRV_ERR;
    }

    if ((outVal.support_feature & inVal.support_feature) != 0ULL) {
        val = RT_CAPABILITY_SUPPORT;
        RT_LOG(RT_LOG_INFO, "chip type=%d, drv support pcie bar copy", static_cast<int32_t>(chipType_));
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MemCopyAsyncWaitFinishEx(struct DMA_ADDR *dmaHandle)
{
    const drvError_t drvRet = halMemcpyWait(dmaHandle);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halMemcpyWait failed, drvRetCode=%d!", static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    RT_LOG(RT_LOG_INFO, "Call halMemcpyWait success.");
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::GetAllUtilizations(const int32_t devId, const rtTypeUtil_t kind, uint8_t * const util)
{
    int32_t infoType;
    switch (kind) {
        case RT_UTIL_TYPE_AICORE:
            infoType = MODULE_TYPE_AICORE;
            break;
        case RT_UTIL_TYPE_AIVECTOR:
            infoType = MODULE_TYPE_VECTOR_CORE;
            break;
        case RT_UTIL_TYPE_AICPU:
            infoType = MODULE_TYPE_AICPU;
            break;
        default:
            RT_LOG_OUTER_MSG(RT_INVALID_ARGUMENT_ERROR, "invalid util type=%d, valid range is (0, %d).",
                kind, RT_UTIL_TYPE_MAX);
            return RT_ERROR_INVALID_VALUE;
    }
    int64_t value = 0;
    const drvError_t drvRet = halGetDeviceInfo(devId, infoType, static_cast<int32_t>(INFO_TYPE_UTILIZATION),
        &value);
    COND_RETURN_WARN(drvRet == DRV_ERROR_NOT_SUPPORT, RT_GET_DRV_ERRCODE(drvRet), "not support"); // special state
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halGetDeviceInfo failed: device_id=%d, drvRetCode=%d.", devId,
            static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    *util = static_cast<uint8_t>(value);
    RT_LOG(RT_LOG_INFO, "success: drv devId=%d, utilType=%d, util=%u", devId, kind, *util);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::HdcServerCreate(const int32_t devId, const rtHdcServiceType_t type, rtHdcServer_t * const server)
{
    COND_RETURN_WARN(&drvHdcServerCreate == nullptr, RT_ERROR_DRV_NOT_SUPPORT,
        "[drv api] drvHdcServerCreate does not exist");
    RT_LOG(RT_LOG_INFO, "drvHdcServerCreate enter, drv devId=%d, type=%d", devId, type);
    const drvError_t drvRet = drvHdcServerCreate(devId, static_cast<int32_t>(type),
        RtPtrToPtr<HDC_SERVER *>(server));
    RT_LOG(RT_LOG_INFO, "drvHdcServerCreate return, drv devId=%d, type=%d, drvRet=%d", devId, type, drvRet);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "drvHdcServerCreate failed, drv devid(%u), drvRetCode(%d).",
            devId, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::HdcServerDestroy(rtHdcServer_t const server)
{
    COND_RETURN_WARN(&drvHdcServerDestroy == nullptr, RT_ERROR_DRV_NOT_SUPPORT,
        "[drv api] drvHdcServerDestroy does not exist");
    RT_LOG(RT_LOG_INFO, "drvHdcServerDestroy enter");
    const drvError_t drvRet = drvHdcServerDestroy(RtPtrToPtr<HDC_SERVER>(server));
    RT_LOG(RT_LOG_INFO, "drvHdcServerDestroy return, drvRet=%d", drvRet);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "drvHdcServerDestroy failed, drvRetCode(%d).",
            static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::HdcSessionConnect(const int32_t peerNode, const int32_t peerDevId, rtHdcClient_t const client,
        rtHdcSession_t * const session)
{
    COND_RETURN_WARN(&drvHdcSessionConnect == nullptr, RT_ERROR_DRV_NOT_SUPPORT,
        "[drv api] drvHdcSessionConnect does not exist");
    RT_LOG(RT_LOG_INFO, "drvHdcSessionConnect enter, node=%d, drv devId=%d", peerNode, peerDevId);
    const drvError_t drvRet = drvHdcSessionConnect(peerNode, peerDevId,
            RtPtrToPtr<HDC_CLIENT>(client), RtPtrToPtr<HDC_SESSION *>(session));
    RT_LOG(RT_LOG_INFO, "drvHdcSessionConnect return, node=%d, drv devId=%d, drvRet=%d", peerNode, peerDevId, drvRet);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "drvHdcSessionConnect failed, drvRetCode(%d).",
            static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::HdcSessionClose(rtHdcSession_t const session)
{
    COND_RETURN_WARN(&drvHdcSessionClose == nullptr, RT_ERROR_DRV_NOT_SUPPORT,
        "[drv api] drvHdcSessionClose does not exist");
    RT_LOG(RT_LOG_INFO, "drvHdcSessionClose enter");
    const drvError_t drvRet = drvHdcSessionClose(RtPtrToPtr<HDC_SESSION>(session));
    RT_LOG(RT_LOG_INFO, "drvHdcSessionClose return, drvRet=%d", drvRet);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "drvHdcSessionClose failed, drvRetCode(%d).",
            static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::GetServerId(const uint32_t deviceId, int64_t *const serverId)
{
    NULL_PTR_RETURN_MSG(serverId, RT_ERROR_INVALID_VALUE);
    const drvError_t drvRet = halGetDeviceInfo(deviceId, MODULE_TYPE_SYSTEM, INFO_TYPE_SERVER_ID, serverId);
    // 判断是否支持跨机 (71 serverId=0x3FF)
    if (drvRet == DRV_ERROR_NOT_SUPPORT || *serverId == 0x3FF) {
        return RT_ERROR_DRV_NOT_SUPPORT;
    }
    return RT_GET_DRV_ERRCODE(drvRet);
}

rtError_t NpuDriver::GetHostID(uint32_t *hostId)
{
    COND_RETURN_WARN(&halGetHostID == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT, "[drv api] halGetHostID does not exist");
    const drvError_t drvRet = halGetHostID(hostId);
    COND_RETURN_WARN(
        drvRet == DRV_ERROR_NOT_SUPPORT, RT_ERROR_FEATURE_NOT_SUPPORT, "[drv api] halGetHostID does not support.");
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api]halGetHostID failed. drvRetCode=%d.", static_cast<int32_t>(drvRet));
    }
    COND_RETURN_ERROR(drvRet != DRV_ERROR_NONE,
        RT_GET_DRV_ERRCODE(drvRet),
        "[drv api]halGetHostID failed. drvRetCode=%d.",
        static_cast<int32_t>(drvRet));
    return RT_GET_DRV_ERRCODE(drvRet);
}

rtError_t NpuDriver::GetAddrModuleId(void *memcpyAddr, uint32_t *moduleId)
{
    size_t moduleidSize = 0U;
    const drvError_t drvRet = halMemCtl(static_cast<int32_t>(CTRL_TYPE_GET_ADDR_MODULE_ID), memcpyAddr, sizeof(uint64_t),
                                  moduleId, &moduleidSize);
    COND_RETURN_WARN(drvRet == DRV_ERROR_NOT_SUPPORT, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halMemCtl not support get module id.");
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halMemCtl get module id failed: drvRetCode=%d",
            static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MemcpyBatch(uint64_t dsts[], uint64_t srcs[], size_t sizes[], size_t count)
{
    COND_RETURN_WARN(&halMemcpyBatch == nullptr, RT_ERROR_DRV_NOT_SUPPORT,
        "[drv api] halMemcpyBatch symbol does not exist.");
    NpuDriverRecord record(static_cast<uint16_t>(RT_PROF_DRV_API_MemcpyBatch));
    const drvError_t drvRet = halMemcpyBatch(dsts, srcs, sizes, count);
    record.SaveRecord();
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] MemcpyBatch failed: drvRetCode=%d",
            static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::GetPageFaultCount(const uint32_t deviceId, uint32_t * const value)
{
    NULL_PTR_RETURN_MSG(value, RT_ERROR_INVALID_VALUE);
    struct drv_process_status_output out = {};
    COND_RETURN_WARN(&halCheckProcessStatusEx == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halCheckProcessStatusEx does not exist");
    const drvError_t drvRet = halCheckProcessStatusEx(deviceId, PROCESS_CP1, STATUS_SVM_PAGE_FALUT_ERR_CNT, &out);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halCheckProcessStatusEx get page fault count failed: drvRetCode=%d",
            static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    *value = out.result;
    RT_LOG(RT_LOG_DEBUG, "drv devId=%u, page fault count=%u.", deviceId, *value);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::GetDqsQueInfo(const uint32_t devId, const uint32_t qid, DqsQueueInfo *queInfo)
{
    COND_RETURN_WARN(&halQueueGetDqsQueInfo == nullptr, RT_ERROR_DRV_NOT_SUPPORT,
        "[drv api] halQueueGetDqsQueInfo does not exist");

    const drvError_t drvRet = halQueueGetDqsQueInfo(devId, qid, queInfo);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "Get dqs queue info failed, qid=%u, ret=%d", qid, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    RT_LOG(RT_LOG_INFO, "halQueueGetDqsQueInfo: qid=%u, type=%d, enqueOpAddr=%#llx, dequeOpAddr=%#llx, "
        "prodqOwAddr=%#llx, prodqStatAddr=%#llx", qid, queInfo->queType, queInfo->enqueOpAddr, queInfo->dequeOpAddr,
        queInfo->prodqOwAddr, queInfo->prodqStatAddr);

    return RT_ERROR_NONE;
}

rtError_t NpuDriver::GetDqsMbufPoolInfo(const uint32_t poolId, DqsPoolInfo *dqsPoolInfo)
{
    COND_RETURN_WARN(&halBuffGetDQSPooInfoById == nullptr, RT_ERROR_DRV_NOT_SUPPORT,
        "[drv api] halBuffGetDQSPooInfoById does not exist");

    const drvError_t drvRet = halBuffGetDQSPooInfoById(poolId, dqsPoolInfo);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "Get dqs mbuf pool info failed, poolId=%u, ret=%d",
            poolId, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    RT_LOG(RT_LOG_INFO, "dqs mbuf pool info, pool_id=%u, dataPoolBaseAddr=%#llx, dataPoolBlkSize=%#x, "
        "dataPoolBlkOffset=%#x, headPoolBaseAddr=%#llx, headPoolBlkSize=%#x, headPoolBlkOffset=%#x, allocOpAddr=%#llx, "
        "freeOpAddr=%#llx",
        poolId, dqsPoolInfo->dataPoolBaseAddr, dqsPoolInfo->dataPoolBlkSize, dqsPoolInfo->dataPoolBlkOffset,
        dqsPoolInfo->headPoolBaseAddr, dqsPoolInfo->headPoolBlkSize, dqsPoolInfo->headPoolBlkOffset,
        dqsPoolInfo->allocOpAddr, dqsPoolInfo->freeOpAddr);

    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MemRetainAllocationHandle(void* virPtr, rtDrvMemHandle *handle)
{
    COND_RETURN_WARN(
        &halMemRetainAllocationHandle == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT, "[drv api] halMemRetainAllocationHandle does not exist");
    
    const drvError_t drvRet = halMemRetainAllocationHandle(RtPtrToPtr<drv_mem_handle_t **>(handle), virPtr);
    COND_RETURN_WARN(drvRet == DRV_ERROR_NOT_SUPPORT, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halMemRetainAllocationHandle does not support.");
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halMemRetainAllocationHandle failed: drvRetCode=%d", static_cast<int32_t>(drvRet));
    }
    return RT_GET_DRV_ERRCODE(drvRet);
}

rtError_t NpuDriver::MemGetAllocationPropertiesFromHandle(rtDrvMemHandle handle, rtDrvMemProp_t* prop)
{
    COND_RETURN_WARN(
        &halMemGetAllocationPropertiesFromHandle == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT, "[drv api] halMemGetAllocationPropertiesFromHandle does not exist");
    
    const drvError_t drvRet = halMemGetAllocationPropertiesFromHandle(RtPtrToPtr<struct drv_mem_prop *>(prop), RtPtrToPtr<drv_mem_handle_t *>(handle));
    COND_RETURN_WARN(drvRet == DRV_ERROR_NOT_SUPPORT, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halMemGetAllocationPropertiesFromHandle does not support.");
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halMemGetAllocationPropertiesFromHandle failed: drvRetCode=%d", static_cast<int32_t>(drvRet));
    }
    return RT_GET_DRV_ERRCODE(drvRet);
}
}  // namespace runtime
}  // namespace cce
