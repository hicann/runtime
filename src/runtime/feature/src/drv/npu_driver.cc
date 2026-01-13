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
