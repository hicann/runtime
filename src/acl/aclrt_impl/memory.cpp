/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <map>
#include <algorithm>
#include "acl_rt_impl.h"
#include "runtime/mem.h"
#include "runtime/rts/rts_mem.h"
#include "runtime/dev.h"
#include "runtime/rts/rts_device.h"
#include "runtime/rt_stars.h"
#include "runtime/rt_mem_queue.h"
#include "common/log_inner.h"
#include "common/error_codes_inner.h"
#include "common/prof_reporter.h"
#include "common/resource_statistics.h"

namespace {
constexpr uint32_t MEM_SIZE_MAX = 96U;
constexpr size_t DATA_MEMORY_ALIGN_SIZE = 32UL;
constexpr unsigned int FLAG_START_DYNAMIC_ALLOC_MEM = 0x200U;

static const std::map<aclDataType, rtDataType> kMapDataType = {
    { ACL_FLOAT, RT_DATA_TYPE_FP32 },
    { ACL_FLOAT16, RT_DATA_TYPE_FP16 },
    { ACL_INT16, RT_DATA_TYPE_INT16 },
    { ACL_INT4, RT_DATA_TYPE_INT4 },
    { ACL_INT8, RT_DATA_TYPE_INT8 },
    { ACL_INT32, RT_DATA_TYPE_INT32 },
    { ACL_BF16, RT_DATA_TYPE_BFP16 },
    { ACL_UINT8, RT_DATA_TYPE_UINT8 },
    { ACL_UINT16, RT_DATA_TYPE_UINT16 },
    { ACL_UINT32, RT_DATA_TYPE_UINT32 },
};

inline aclError MemcpyKindTranslate(const aclrtMemcpyKind kind, rtMemcpyKind_t &rtKind)
{
    switch (kind) {
        case ACL_MEMCPY_HOST_TO_DEVICE: {
            rtKind = RT_MEMCPY_HOST_TO_DEVICE;
            break;
        }
        case ACL_MEMCPY_DEVICE_TO_DEVICE: {
            rtKind = RT_MEMCPY_DEVICE_TO_DEVICE;
            break;
        }
        case ACL_MEMCPY_DEVICE_TO_HOST: {
            rtKind = RT_MEMCPY_DEVICE_TO_HOST;
            break;
        }
        case ACL_MEMCPY_HOST_TO_HOST: {
            rtKind = RT_MEMCPY_HOST_TO_HOST;
            break;
        }
        case ACL_MEMCPY_DEFAULT: {
            rtKind = RT_MEMCPY_DEFAULT;
            break;
        }
        case ACL_MEMCPY_HOST_TO_BUF_TO_DEVICE: {
            rtKind = RT_MEMCPY_HOST_TO_DEVICE_EX;
            break;
        }
        default: {
            ACL_LOG_ERROR("[Check][MemcpyKindTranslate]param kind invalid, which is %d.", static_cast<int32_t>(kind));
            acl::AclErrorLogManager::ReportInputError(acl::INVALID_PARAM_MSG,
                std::vector<const char *>({"param", "value", "reason"}),
                std::vector<const char *>({"kind", std::to_string(kind).c_str(),
                "Memcpy kind should be ACL_MEMCPY_HOST_TO_DEVICE,"
                "ACL_MEMCPY_DEVICE_TO_DEVICE, ACL_MEMCPY_DEVICE_TO_HOST,"
                "ACL_MEMCPY_HOST_TO_HOST, ACL_MEMCPY_DEFAULT or ACL_MEMCPY_HOST_TO_BUF_TO_DEVICE."}));
            return ACL_ERROR_INVALID_PARAM;
        }
    }
    return ACL_SUCCESS;
}

aclError CheckMemcpy2dParam(const void *const dst, const size_t dpitch, const void *const src, const size_t spitch,
    const size_t width, const size_t height, const aclrtMemcpyKind kind, rtMemcpyKind_t &rtKind)
{
    ACL_LOG_DEBUG("start to execute CheckMemcpy2dParam");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(dst);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(src);
    ACL_REQUIRES_POSITIVE(height);
    ACL_REQUIRES_POSITIVE(width);

    if ((width > spitch) || (width > dpitch)) {
        ACL_LOG_ERROR("[Check][Width]input param width[%zu] must be smaller than spitch[%zu] and dpitch[%zu]",
            width, spitch, dpitch);
        acl::AclErrorLogManager::ReportInputError(acl::INVALID_PARAM_MSG,
            std::vector<const char *>({"param", "value", "reason"}),
            std::vector<const char *>({"width", std::to_string(width).c_str(), "must be smaller than spitch and dpitch"}));
        return ACL_ERROR_INVALID_PARAM;
    }

    switch (kind) {
        case ACL_MEMCPY_HOST_TO_DEVICE: {
            rtKind = RT_MEMCPY_HOST_TO_DEVICE;
            break;
        }
        case ACL_MEMCPY_DEVICE_TO_HOST: {
            rtKind = RT_MEMCPY_DEVICE_TO_HOST;
            break;
        }
        case ACL_MEMCPY_DEVICE_TO_DEVICE: {
            rtKind = RT_MEMCPY_DEVICE_TO_DEVICE;
            break;
        }
        case ACL_MEMCPY_DEFAULT: {
            rtKind = RT_MEMCPY_DEFAULT;
            break;
        }
        default: {
            ACL_LOG_ERROR("[Check][Kind]invalid kind of memcpy, kind = %d", static_cast<int32_t>(kind));
            acl::AclErrorLogManager::ReportInputError(acl::INVALID_PARAM_MSG,
                std::vector<const char *>({"param", "value", "reason"}),
                std::vector<const char *>({"kind", std::to_string(kind).c_str(), "invalid kind of memcpy"}));
            return ACL_ERROR_INVALID_PARAM;
        }
    }
    return ACL_SUCCESS;
}
}

namespace acl {
aclError GetAlignedAndPaddingSize(const size_t size, const bool isPadding, size_t &alignedSize)
{
    // check overflow, the max value of size must be less than 0xFFFFFFFFFFFFFFFF-32*2
    if ((size + (DATA_MEMORY_ALIGN_SIZE * 2UL)) < size) {
        ACL_LOG_INNER_ERROR("[Check][Size]size too large: %zu", size);
        return ACL_ERROR_INVALID_PARAM;
    }

    // align size to multiple of 32 and padding 32 if needed
    const size_t appendSize = isPadding ? DATA_MEMORY_ALIGN_SIZE * 2UL : DATA_MEMORY_ALIGN_SIZE;
    alignedSize = (size + appendSize - 1UL) / DATA_MEMORY_ALIGN_SIZE * DATA_MEMORY_ALIGN_SIZE;
    return ACL_SUCCESS;
}

aclError aclMallocMemInner(void **devPtr, const size_t size, bool isPadding,
                           const aclrtMemMallocPolicy policy, const uint16_t moduleId)
{
    ACL_ADD_APPLY_TOTAL_COUNT(acl::ACL_STATISTICS_MALLOC_FREE);
    ACL_LOG_DEBUG("start to execute aclMallocMemInner, size = %zu", size);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(devPtr);
    // size must be greater than zero
    if (size == 0UL) {
        ACL_LOG_ERROR("malloc size must be greater than zero");
        acl::AclErrorLogManager::ReportInputError(acl::INVALID_PARAM_MSG,
            std::vector<const char *>({"param", "value", "reason"}),
            std::vector<const char *>({"size", std::to_string(size).c_str(), "size must be greater than zero"}));
        return ACL_ERROR_INVALID_PARAM;
    }
    size_t alignedSize = size;
    const bool huge1g = (policy == ACL_MEM_MALLOC_HUGE1G_ONLY) || (policy == ACL_MEM_MALLOC_HUGE1G_ONLY_P2P);
    isPadding = !huge1g && isPadding;
    ACL_REQUIRES_OK(acl::GetAlignedAndPaddingSize(size, isPadding, alignedSize));
    uint32_t flags = RT_MEMORY_DEFAULT;
    if (policy == ACL_MEM_MALLOC_HUGE_FIRST) {
        flags |= RT_MEMORY_POLICY_HUGE_PAGE_FIRST;
    } else if (policy == ACL_MEM_MALLOC_HUGE_ONLY) {
        flags |= RT_MEMORY_POLICY_HUGE_PAGE_ONLY;
    } else if (policy == ACL_MEM_MALLOC_NORMAL_ONLY) {
        flags |= RT_MEMORY_POLICY_DEFAULT_PAGE_ONLY;
    } else if (policy == ACL_MEM_MALLOC_HUGE_FIRST_P2P) {
        flags |= RT_MEMORY_POLICY_HUGE_PAGE_FIRST_P2P;
    } else if (policy == ACL_MEM_MALLOC_HUGE_ONLY_P2P) {
        flags |= RT_MEMORY_POLICY_HUGE_PAGE_ONLY_P2P;
    } else if (policy == ACL_MEM_MALLOC_NORMAL_ONLY_P2P) {
        flags |= RT_MEMORY_POLICY_DEFAULT_PAGE_ONLY_P2P;
    } else if (policy == ACL_MEM_MALLOC_HUGE1G_ONLY) {
        flags |= RT_MEMORY_POLICY_HUGE1G_PAGE_ONLY;
    } else if (policy == ACL_MEM_MALLOC_HUGE1G_ONLY_P2P) {
        flags |= RT_MEMORY_POLICY_HUGE1G_PAGE_ONLY_P2P;
    } else {
        flags = RT_MEMORY_DEFAULT;
    }
    const rtError_t rtErr = rtMalloc(devPtr, alignedSize, flags, moduleId);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("alloc device memory failed, runtime result = %d", rtErr);
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    ACL_ADD_APPLY_SUCCESS_COUNT(acl::ACL_STATISTICS_MALLOC_FREE);
    return ACL_SUCCESS;
}

aclError aclrtMallocInnerWithCfg(void **devPtr, const size_t size, aclrtMemMallocPolicy policy, rtMallocAdvise advise,
    aclrtMallocConfig *cfg)
{
    ACL_ADD_APPLY_TOTAL_COUNT(acl::ACL_STATISTICS_MALLOC_FREE);
    ACL_LOG_DEBUG("start to execute aclrtMallocInnerWithCfg, size = %zu", size);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(devPtr);

    // check attrs pointer
    if ((cfg != nullptr) && (cfg->numAttrs != 0) && (cfg->attrs == nullptr)) {
        ACL_LOG_ERROR("[Check][attrs]param must not be null when numAttrs is not 0.");
        acl::AclErrorLogManager::ReportInputError("EH0002", {"param"}, {"cfg"});
        return ACL_ERROR_INVALID_PARAM;
    }
    // size must be greater than zero
    if (size == 0UL) {
        ACL_LOG_ERROR("malloc size must be greater than zero");
        acl::AclErrorLogManager::ReportInputError(acl::INVALID_PARAM_MSG,
            std::vector<const char *>({"param", "value", "reason"}),
            std::vector<const char *>({"size", std::to_string(size).c_str(), "size must be greater than zero"}));
        return ACL_ERROR_INVALID_PARAM;
    }

    rtError_t rtErr = rtsMalloc(devPtr, size, static_cast<rtMallocPolicy>(policy), advise,
        reinterpret_cast<rtMallocConfig_t*>(cfg));
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("alloc memory failed, runtime result = %d", rtErr);
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    ACL_ADD_APPLY_SUCCESS_COUNT(acl::ACL_STATISTICS_MALLOC_FREE);
    return ACL_SUCCESS;
}
} // namespace acl

aclError aclrtMallocImpl(void **devPtr, size_t size, aclrtMemMallocPolicy policy)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtMalloc);
    ACL_LOG_DEBUG("start to execute aclrtMalloc, size = %zu", size);
    return acl::aclMallocMemInner(devPtr, size, true, policy, acl::APP_MODE_ID_U16);
}

aclError aclrtMallocAlign32Impl(void **devPtr, size_t size, aclrtMemMallocPolicy policy)
{
    ACL_LOG_DEBUG("start to execute aclrtMallocAlign32, size = %zu", size);
    return acl::aclMallocMemInner(devPtr, size, false, policy, acl::APP_MODE_ID_U16);
}

aclError aclrtMallocCachedImpl(void **devPtr, size_t size, aclrtMemMallocPolicy policy)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtMallocCached);
    ACL_ADD_APPLY_TOTAL_COUNT(acl::ACL_STATISTICS_MALLOC_FREE);
    ACL_LOG_DEBUG("start to execute aclrtMallocCached, size = %zu", size);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(devPtr);

    if (size == 0UL) {
        ACL_LOG_INNER_ERROR("malloc size must be greater than zero");
        return ACL_ERROR_INVALID_PARAM;
    }
    size_t alignedSize = size;
    const bool huge1g = (policy == ACL_MEM_MALLOC_HUGE1G_ONLY) || (policy == ACL_MEM_MALLOC_HUGE1G_ONLY_P2P);
    const bool isPadding = !huge1g;
    ACL_REQUIRES_OK(acl::GetAlignedAndPaddingSize(size, isPadding, alignedSize));
    uint32_t cacheFlags = RT_MEMORY_DEFAULT;
    if (policy == ACL_MEM_MALLOC_HUGE_FIRST) {
        cacheFlags |= RT_MEMORY_POLICY_HUGE_PAGE_FIRST;
    } else if (policy == ACL_MEM_MALLOC_HUGE_ONLY) {
        cacheFlags |= RT_MEMORY_POLICY_HUGE_PAGE_ONLY;
    } else if (policy == ACL_MEM_MALLOC_NORMAL_ONLY) {
        cacheFlags |= RT_MEMORY_POLICY_DEFAULT_PAGE_ONLY;
    } else if (policy == ACL_MEM_MALLOC_HUGE1G_ONLY) {
        cacheFlags |= RT_MEMORY_POLICY_HUGE1G_PAGE_ONLY;
    } else {
        cacheFlags = RT_MEMORY_DEFAULT;
    }
    const rtError_t rtErr = rtMallocCached(devPtr, alignedSize, cacheFlags, acl::APP_MODE_ID_U16);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("alloc device memory with cache failed, runtime result = %d", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    ACL_ADD_APPLY_SUCCESS_COUNT(acl::ACL_STATISTICS_MALLOC_FREE);
    return ACL_SUCCESS;
}

aclError aclrtMallocWithCfgImpl(void **devPtr, size_t size, aclrtMemMallocPolicy policy, aclrtMallocConfig *cfg)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtMallocWithCfg);
    ACL_ADD_APPLY_TOTAL_COUNT(acl::ACL_STATISTICS_MALLOC_FREE);
    ACL_LOG_DEBUG("start to execute aclrtMallocWithCfg, size = %zu", size);
    return acl::aclrtMallocInnerWithCfg(devPtr, size, policy, RT_MEM_ADVISE_NONE, cfg);
}

aclError aclrtMallocForTaskSchedulerImpl(void **devPtr, size_t size, aclrtMemMallocPolicy policy,
                                         aclrtMallocConfig *cfg)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtMallocForTaskScheduler);
    ACL_LOG_DEBUG("start to execute aclrtMallocForTaskScheduler, size = %zu", size);
    return acl::aclrtMallocInnerWithCfg(devPtr, size, policy, RT_MEM_ADVISE_TS, cfg);
}

aclError aclrtMallocHostWithCfgImpl(void **ptr, uint64_t size, aclrtMallocConfig *cfg)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtMallocHostWithCfg);
    ACL_ADD_APPLY_TOTAL_COUNT(acl::ACL_STATISTICS_MALLOC_FREE);
    ACL_LOG_DEBUG("start to execute aclrtMallocHostWithCfg, size = %zu", size);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(ptr);
    // size must be greater than zero
    if (size == 0UL) {
        ACL_LOG_ERROR("malloc size must be greater than zero");
        acl::AclErrorLogManager::ReportInputError(acl::INVALID_PARAM_MSG,
            std::vector<const char *>({"param", "value", "reason"}),
            std::vector<const char *>({"size", std::to_string(size).c_str(), "size must be greater than zero"}));
        return ACL_ERROR_INVALID_PARAM;
    }
    const rtError_t rtErr = rtsMallocHost(ptr, size, reinterpret_cast<rtMallocConfig_t*>(cfg));
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("alloc host memory with cfg failed, runtime result = %d", rtErr);
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    ACL_ADD_APPLY_SUCCESS_COUNT(acl::ACL_STATISTICS_MALLOC_FREE);
    return ACL_SUCCESS;
}

aclError aclrtPointerGetAttributesImpl(const void *ptr, aclrtPtrAttributes *attributes)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtPointerGetAttributes);
    ACL_LOG_DEBUG("start to execute aclrtPointerGetAttributes");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(ptr);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(attributes);
    const rtError_t rtErr = rtsPointerGetAttributes(ptr, reinterpret_cast<rtPtrAttributes_t*>(attributes));
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("call rtsPointerGetAttributes failed, runtime result = %d", rtErr);
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    return ACL_SUCCESS;
}

aclError aclrtHostRegisterImpl(void *ptr, uint64_t size, aclrtHostRegisterType type, void **devPtr)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtHostRegister);
    ACL_LOG_DEBUG("start to execute aclrtHostRegister");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(ptr);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(devPtr);
    // size must be greater than zero
    if (size == 0UL) {
        ACL_LOG_ERROR("register size must be greater than zero");
        acl::AclErrorLogManager::ReportInputError(acl::INVALID_PARAM_MSG,
            std::vector<const char *>({"param", "value", "reason"}),
            std::vector<const char *>({"size", std::to_string(size).c_str(), "size must be greater than zero"}));
        return ACL_ERROR_INVALID_PARAM;
    }
    const rtError_t rtErr = rtsHostRegister(ptr, size, static_cast<rtHostRegisterType>(type), devPtr);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("call rtsHostRegister failed, runtime result = %d", rtErr);
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    return ACL_SUCCESS;
}

aclError aclrtHostRegisterV2Impl(void *ptr, uint64_t size, uint32_t flag)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtHostRegisterV2);
    ACL_LOG_DEBUG("start to execute aclrtHostRegisterV2");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(ptr);
    // size must be greater than zero
    if (size == 0UL) {
        ACL_LOG_ERROR("register size must be greater than zero");
        acl::AclErrorLogManager::ReportInputError(acl::INVALID_PARAM_MSG,
            std::vector<const char *>({"param", "value", "reason"}),
            std::vector<const char *>({"size", std::to_string(size).c_str(), "size must be greater than zero"}));
        return ACL_ERROR_INVALID_PARAM;
    }
    const rtError_t rtErr = rtHostRegisterV2(ptr, size, flag);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("call rtHostRegisterV2 failed, runtime result = %d", rtErr);
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    return ACL_SUCCESS;
}

aclError aclrtHostGetDevicePointerImpl(void *pHost, void **pDevice, uint32_t flag)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtHostGetDevicePointer);
    ACL_LOG_DEBUG("start to execute aclrtHostGetDevicePointer");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(pHost);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(pDevice);
    if (flag != 0UL) {
        ACL_LOG_ERROR("register flag must be zero");
        acl::AclErrorLogManager::ReportInputError(acl::INVALID_PARAM_MSG,
            std::vector<const char *>({"param", "value", "reason"}),
            std::vector<const char *>({"flag", std::to_string(flag).c_str(), "flag must be zero"}));
        return ACL_ERROR_INVALID_PARAM;
    }
    const rtError_t rtErr = rtHostGetDevicePointer(pHost, pDevice, flag);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("call aclrtHostGetDevicePointer failed, runtime result = %d", rtErr);
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    return ACL_SUCCESS;
}

aclError aclrtHostUnregisterImpl(void *ptr)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtHostUnregister);
    ACL_LOG_DEBUG("start to execute aclrtHostUnregister");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(ptr);
    const rtError_t rtErr = rtsHostUnregister(ptr);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("call rtsHostUnregister failed, runtime result = %d", rtErr);
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    return ACL_SUCCESS;
}

aclError aclrtHostMemMapCapabilitiesImpl(uint32_t deviceId, aclrtHacType hacType,
    aclrtHostMemMapCapability *capabilities)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtHostMemMapCapabilities);
    ACL_LOG_DEBUG("start to execute aclrtHostMemMapCapabilities, deviceId = %u", deviceId);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(capabilities);
    const rtError_t rtErr = rtHostMemMapCapabilities(deviceId, static_cast<rtHacType>(hacType),
        reinterpret_cast<rtHostMemMapCapability*>(capabilities));
    if (rtErr != RT_ERROR_NONE) {
        if (rtErr == ACL_ERROR_RT_FEATURE_NOT_SUPPORT) {
            ACL_LOG_WARN("rtHostMemMapCapabilities not support this feature, runtime result = %d", static_cast<int32_t>(rtErr));
        } else {
            ACL_LOG_CALL_ERROR("call rtHostMemMapCapabilities failed, runtime result = %d", static_cast<int32_t>(rtErr));
        }
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    return ACL_SUCCESS;
}

aclError aclrtMemFlushImpl(void *devPtr, size_t size)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtMemFlush);
    ACL_LOG_DEBUG("start to execute aclrtMemFlush, size = %zu", size);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(devPtr);

    if (size == 0UL) {
        ACL_LOG_INNER_ERROR("flush cache size must be greater than zero");
        return ACL_ERROR_INVALID_PARAM;
    }
    const rtError_t rtErr = rtFlushCache(devPtr, size);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("flush cache data to ddr failed, runtime result = %d, size = %zu",
            static_cast<int32_t>(rtErr), size);
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    return ACL_SUCCESS;
}

aclError aclrtMemInvalidateImpl(void *devPtr, size_t size)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtMemInvalidate);
    ACL_LOG_INFO("start to execute aclrtMemInvalidate, size = %zu", size);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(devPtr);

    if (size == 0UL) {
        ACL_LOG_INNER_ERROR("invalidate cache size must be greater than zero");
        return ACL_ERROR_INVALID_PARAM;
    }
    const rtError_t rtErr = rtInvalidCache(devPtr, size);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("invalidate cache data failed, runtime result = %d, size = %zu",
            static_cast<int32_t>(rtErr), size);
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    return ACL_SUCCESS;
}

aclError aclrtFreeImpl(void *devPtr)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtFree);
    ACL_ADD_RELEASE_TOTAL_COUNT(acl::ACL_STATISTICS_MALLOC_FREE);
    ACL_LOG_DEBUG("start to execute aclrtFree");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(devPtr);

    const rtError_t rtErr = rtFree(devPtr);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("free device memory failed, runtime result = %d", rtErr);
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    ACL_ADD_RELEASE_SUCCESS_COUNT(acl::ACL_STATISTICS_MALLOC_FREE);
    return ACL_SUCCESS;
}

aclError aclrtMallocHostImpl(void **hostPtr, size_t size)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtMallocHost);
    ACL_ADD_APPLY_TOTAL_COUNT(acl::ACL_STATISTICS_MALLOC_FREE_HOST);
    ACL_LOG_DEBUG("start to execute aclrtMallocHost, size = %zu", size);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(hostPtr);
    // size must be greater than zero
    if (size == 0UL) {
        ACL_LOG_INNER_ERROR("malloc size must be greater than zero");
        return ACL_ERROR_INVALID_PARAM;
    }
    const rtError_t rtErr = rtMallocHost(hostPtr, size, acl::APP_MODE_ID_U16);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("alloc host memory failed, runtime result = %d", rtErr);
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    ACL_ADD_APPLY_SUCCESS_COUNT(acl::ACL_STATISTICS_MALLOC_FREE_HOST);
    return ACL_SUCCESS;
}

aclError aclrtFreeHostImpl(void *hostPtr)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtFreeHost);
    ACL_ADD_RELEASE_TOTAL_COUNT(acl::ACL_STATISTICS_MALLOC_FREE_HOST);
    ACL_LOG_DEBUG("start to execute aclrtFreeHost");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(hostPtr);
    const rtError_t rtErr = rtFreeHost(hostPtr);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("free host memory failed, runtime result = %d", rtErr);
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    ACL_ADD_RELEASE_SUCCESS_COUNT(acl::ACL_STATISTICS_MALLOC_FREE_HOST);
    return ACL_SUCCESS;
}

aclError aclrtFreeWithDevSyncImpl(void *devPtr)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtFreeWithDevSync);
    ACL_ADD_RELEASE_TOTAL_COUNT(acl::ACL_STATISTICS_MALLOC_FREE);
    ACL_LOG_DEBUG("start to execute aclrtFreeWithDevSync");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(devPtr);

    const rtError_t rtErr = rtFreeWithDevSync(devPtr);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("free device memory with device synchronize failed, runtime result = %d", rtErr);
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    ACL_ADD_RELEASE_SUCCESS_COUNT(acl::ACL_STATISTICS_MALLOC_FREE);
    return ACL_SUCCESS;
}

aclError aclrtFreeHostWithDevSyncImpl(void *hostPtr)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtFreeHostWithDevSync);
    ACL_ADD_RELEASE_TOTAL_COUNT(acl::ACL_STATISTICS_MALLOC_FREE_HOST);
    ACL_LOG_DEBUG("start to execute aclrtFreeHostWithDevSync");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(hostPtr);
    const rtError_t rtErr = rtFreeHostWithDevSync(hostPtr);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("free host memory with device synchronize failed, runtime result = %d", rtErr);
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    ACL_ADD_RELEASE_SUCCESS_COUNT(acl::ACL_STATISTICS_MALLOC_FREE_HOST);
    return ACL_SUCCESS;
}

aclError aclrtMemcpyImpl(void *dst,
                         size_t destMax,
                         const void *src,
                         size_t count,
                         aclrtMemcpyKind kind)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtMemcpy);
    ACL_LOG_INFO("start to execute aclrtMemcpy, destMaxSize = %zu, srcSize = %zu, kind = %d",
        destMax, count, static_cast<int32_t>(kind));
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(dst);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(src);

    rtMemcpyKind_t rtKind = RT_MEMCPY_RESERVED;
    const aclError ret = MemcpyKindTranslate(kind, rtKind);
    if (ret != ACL_SUCCESS) {
        ACL_LOG_INNER_ERROR("invalid kind of memcpy, kind = %d", static_cast<int32_t>(kind));
        return ret;
    }

    const rtError_t rtErr = rtMemcpy(dst, destMax, src, count, rtKind);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("synchronized memcpy failed, kind = %d, runtime result = %d",
            static_cast<int32_t>(kind), static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    return ACL_SUCCESS;
}

aclError aclrtMemsetImpl(void *devPtr, size_t maxCount, int32_t value, size_t count)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtMemset);
    ACL_LOG_DEBUG("start to execute aclrtMemset, maxSize = %zu, size = %zu, value = %d",
        maxCount, count, value);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(devPtr);

    const rtError_t rtErr = rtMemset(devPtr, maxCount, static_cast<uint32_t>(value), count);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("set memory failed, runtime result = %d", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    return ACL_SUCCESS;
}

aclError aclrtMemcpyAsyncImpl(void *dst,
                              size_t destMax,
                              const void *src,
                              size_t count,
                              aclrtMemcpyKind kind,
                              aclrtStream stream)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtMemcpyAsync);
    ACL_LOG_DEBUG("start to execute aclrtMemcpyAsync, destMaxSize = %zu, srcSize = %zu, kind = %d",
        destMax, count, static_cast<int32_t>(kind));
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(dst);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(src);
    rtMemcpyKind_t rtKindVal = RT_MEMCPY_RESERVED;
    const aclError ret = MemcpyKindTranslate(kind, rtKindVal);
    if (ret != ACL_SUCCESS) {
        ACL_LOG_INNER_ERROR("invalid kind of memcpy, kind = %d", static_cast<int32_t>(kind));
        return ret;
    }

    ACL_REQUIRES_CALL_RTS_OK(rtMemcpyAsync(dst, destMax, src, count, rtKindVal, static_cast<rtStream_t>(stream)),
                             rtMemcpyAsync);
    return ACL_SUCCESS;
}

aclError aclrtMemcpyAsyncWithConditionImpl(void *dst,
                                           size_t destMax,
                                           const void *src,
                                           size_t count,
                                           aclrtMemcpyKind kind,
                                           aclrtStream stream)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtMemcpyAsyncWithCondition);
    ACL_LOG_DEBUG("start to execute aclrtMemcpyAsyncWithCondition, destMaxSize = %zu, srcSize = %zu, kind = %d",
                  destMax, count, static_cast<int32_t>(kind));
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(dst);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(src);
    rtMemcpyKind_t rtKindVal = RT_MEMCPY_RESERVED;
    const aclError ret = MemcpyKindTranslate(kind, rtKindVal);
    if (ret != ACL_SUCCESS) {
        ACL_LOG_INNER_ERROR("invalid kind of memcpy, kind = %d", static_cast<int32_t>(kind));
        return ret;
    }

    rtMemcpyAttributeValue_t memcpyAttrValue;
    // bit0 standing for not checking matching between address and kind, bit1 standing for checking page-locked addr
    memcpyAttrValue.checkBitmap = 0x00000002U;
    rtMemcpyAttribute_t memcpyAttr = {
        .id = RT_MEMCPY_ATTRIBUTE_CHECK,
        .value = memcpyAttrValue
    };
    rtMemcpyConfig_t memcpyConfig = {
        .attrs = &memcpyAttr,
        .numAttrs = 1U
    };

    ACL_REQUIRES_CALL_RTS_OK(rtMemcpyAsyncEx(dst, destMax, src, count, rtKindVal, static_cast<rtStream_t>(stream),
                             &memcpyConfig), rtMemcpyAsyncEx);
    return ACL_SUCCESS;
}

aclError aclrtMemsetAsyncImpl(void *devPtr, size_t maxCount, int32_t value, size_t count, aclrtStream stream)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtMemsetAsync);
    ACL_LOG_DEBUG("start to execute aclrtMemsetAsync, maxCount = %zu, value = %d, count = %zu",
        maxCount, value, count);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(devPtr);

    ACL_REQUIRES_CALL_RTS_OK(rtMemsetAsync(devPtr, maxCount, static_cast<uint32_t>(value), count, stream),
                             rtMemsetAsync);
    return ACL_SUCCESS;
}

aclError aclrtDeviceCanAccessPeerImpl(int32_t *canAccessPeer, int32_t deviceId, int32_t peerDeviceId)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtDeviceCanAccessPeer);
    ACL_LOG_INFO("start to execute aclrtDeviceCanAccessPeer");

    if (deviceId == peerDeviceId) {
        ACL_LOG_INNER_ERROR("deviceId shouldn't be equal to peeerDeviceId");
        return ACL_ERROR_INVALID_PARAM;
    }

    uint32_t peerPhyId = 0U;
    rtError_t rtErr = rtGetDevicePhyIdByIndex(static_cast<uint32_t>(peerDeviceId), &peerPhyId);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("call rtGetDevicePhyIdByIndex failed, deviceId = %d, peerDeviceId = %d, "
            "runtime result = %d", deviceId, peerDeviceId, static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }

    rtErr = rtDeviceCanAccessPeer(canAccessPeer, static_cast<uint32_t>(deviceId), peerPhyId);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("call rtDeviceCanAccessPeer failed, deviceId = %d, peerPhyId = %u, "
            "runtime result = %d", deviceId, peerPhyId, static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }

    return ACL_SUCCESS;
}

aclError aclrtDeviceEnablePeerAccessImpl(int32_t peerDeviceId, uint32_t flags)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtDeviceEnablePeerAccess);
    ACL_LOG_INFO("start to execute aclrtDeviceEnablePeerAccess");

    if (flags != 0U) {
        ACL_LOG_INNER_ERROR("the flags must be 0, but current is %u", flags);
        return ACL_ERROR_FEATURE_UNSUPPORTED;
    }

    int32_t deviceId = 0;
    rtError_t rtErr = rtGetDevice(&deviceId);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("call rtGetDevice failed, runtime result = %d", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }

    if (deviceId == peerDeviceId) {
        ACL_LOG_INNER_ERROR("deviceId shouldn't be equal to peeerDeviceId, deviceId = %d, peerDeviceId = %d",
            deviceId, peerDeviceId);
        return ACL_ERROR_INVALID_PARAM;
    }

    uint32_t peerPhyId = 0U;
    rtErr = rtGetDevicePhyIdByIndex(static_cast<uint32_t>(peerDeviceId), &peerPhyId);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("call rtGetDevicePhyIdByIndex failed, peerDeviceId = %d, runtime result = %d",
            peerDeviceId, static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }

    rtErr = rtEnableP2P(static_cast<uint32_t>(deviceId), peerPhyId, flags);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("call rtEnableP2P failed, deviceId = %d, peerPhyId = %u, runtime result = %d",
            deviceId, peerPhyId, static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }

    return ACL_SUCCESS;
}

aclError aclrtDeviceDisablePeerAccessImpl(int32_t peerDeviceId)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtDeviceDisablePeerAccess);
    ACL_LOG_INFO("start to execute aclrtDeviceDisablePeerAccess");

    int32_t deviceId = 0;
    rtError_t rtErr = rtGetDevice(&deviceId);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("call rtGetDevice failed, runtime result = %d", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }

    if (deviceId == peerDeviceId) {
        ACL_LOG_INNER_ERROR("deviceId shouldn't be equal to peeerDeviceId, deviceId = %d, peerDeviceId = %d",
            deviceId, peerDeviceId);
        return ACL_ERROR_INVALID_PARAM;
    }

    uint32_t peerPhyId = 0U;
    rtErr = rtGetDevicePhyIdByIndex(static_cast<uint32_t>(peerDeviceId), &peerPhyId);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("call rtGetDevicePhyIdByIndex failed, peerDeviceId = %u, runtime result = %d",
            peerDeviceId, static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }

    rtErr = rtDisableP2P(static_cast<uint32_t>(deviceId), peerPhyId);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("call rtDisableP2P failed, deviceId = %d, peerPhyId = %u, runtime result = %d",
            deviceId, peerPhyId, static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }

    return ACL_SUCCESS;
}

aclError aclrtGetMemInfoImpl(aclrtMemAttr attr, size_t *free, size_t *total)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtGetMemInfo);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(free);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(total);
    ACL_LOG_DEBUG("start to execute aclrtGetMemInfo, memory attribute = %d", static_cast<int32_t>(attr));

    const rtError_t rtErr = rtMemGetInfoEx(static_cast<rtMemInfoType_t>(attr), free, total);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("get memory information failed, runtime result = %d", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }

    ACL_LOG_DEBUG("successfully execute aclrtGetMemInfo, memory attribute = %d, free memory = %zu bytes, "
        "total memory = %zu bytes", static_cast<int32_t>(attr), *free, *total);
    return ACL_SUCCESS;
}

aclError aclrtGetMemUsageInfoImpl(int32_t deviceId, aclrtMemUsageInfo *memUsageInfo, size_t inputNum, size_t *outputNum)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtGetMemUsageInfo);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(memUsageInfo);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(outputNum);
    ACL_LOG_DEBUG("start to execute aclrtGetMemUsageInfo, deviceId = %d, inputNum = %zu", static_cast<int32_t>(deviceId), inputNum);

    const rtError_t rtErr = rtGetMemUsageInfo(static_cast<uint32_t>(deviceId), reinterpret_cast<rtMemUsageInfo_t*>(memUsageInfo), inputNum, outputNum);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("get memory usage information failed, runtime result = %d", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }

    ACL_LOG_DEBUG("successfully execute aclrtGetMemUsageInfo, deviceId = %d, inputNum = %zu", deviceId, inputNum);
    return ACL_SUCCESS;
}

aclError aclrtMemcpy2dImpl(void *dst,
                           size_t dpitch,
                           const void *src,
                           size_t spitch,
                           size_t width,
                           size_t height,
                           aclrtMemcpyKind kind)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtMemcpy2d);
    ACL_LOG_DEBUG("start to execute aclrtMemcpy2d, dpitch = %zu, spitch = %zu, width = %zu, height = %zu, kind = %d",
        dpitch, spitch, width, height, static_cast<int32_t>(kind));

    rtMemcpyKind_t rtKind = RT_MEMCPY_RESERVED;
    const aclError ret = CheckMemcpy2dParam(dst, dpitch, src, spitch, width, height, kind, rtKind);
    if (ret != ACL_SUCCESS) {
        return ret;
    }

    const rtError_t rtErr = rtMemcpy2d(dst, dpitch, src, spitch, width, height, rtKind);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("[Synchronized][Memcpy]synchronized memcpy failed, kind = %d, runtime result = %d",
            static_cast<int32_t>(kind), static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }

    ACL_LOG_DEBUG("Successfuly execute aclrtMemcpy2d, dpitch = %zu, spitch = %zu, width = %zu, height = %zu, "
        "kind = %d", dpitch, spitch, width, height, static_cast<int32_t>(kind));
    return ACL_SUCCESS;
}

aclError aclrtMemcpy2dAsyncImpl(void *dst,
                                size_t dpitch,
                                const void *src,
                                size_t spitch,
                                size_t width,
                                size_t height,
                                aclrtMemcpyKind kind,
                                aclrtStream stream)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtMemcpy2dAsync);
    ACL_LOG_DEBUG("start to execute aclrtMemcpy2dAsync, dpitch = %zu, spitch = %zu, width = %zu, height = %zu,"
        " kind = %d", dpitch, spitch, width, height, static_cast<int32_t>(kind));

    rtMemcpyKind_t rtKindVal = RT_MEMCPY_RESERVED;
    const aclError ret = CheckMemcpy2dParam(dst, dpitch, src, spitch, width, height, kind, rtKindVal);
    if (ret != ACL_SUCCESS) {
        return ret;
    }

    ACL_REQUIRES_CALL_RTS_OK(rtMemcpy2dAsync(dst, dpitch, src, spitch, width, height, rtKindVal, stream),
                             rtMemcpy2dAsync);

    ACL_LOG_DEBUG("Successfuly execute aclrtMemcpy2dAsync, dpitch = %zu, spitch = %zu, width = %zu, height = %zu, "
        "kind = %d", dpitch, spitch, width, height, static_cast<int32_t>(kind));
    return ACL_SUCCESS;
}

aclError aclrtReserveMemAddressImpl(void **virPtr,
                                    size_t size,
                                    size_t alignment,
                                    void *expectPtr,
                                    uint64_t flags)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtReserveMemAddress);
    ACL_ADD_APPLY_TOTAL_COUNT(acl::ACL_STATISTICS_RESERVE_RELEASE_MEMORY_ADDRESS);
    ACL_LOG_DEBUG("start to execute aclrtReserveMemAddress, size = %zu", size);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(virPtr);

    if (size == 0UL) {
        ACL_LOG_ERROR("reserve size must be greater than zero");
        return ACL_ERROR_INVALID_PARAM;
    }
    if ((flags != 1ULL) && (flags != 0ULL)) {
        ACL_LOG_ERROR("flags of page type must be 0 or 1");
        return ACL_ERROR_INVALID_PARAM;
    }

    const rtError_t rtErr = rtReserveMemAddress(virPtr, size, alignment, expectPtr, flags);
    if (rtErr != RT_ERROR_NONE) {
        if (rtErr == ACL_ERROR_RT_FEATURE_NOT_SUPPORT) {
            ACL_LOG_WARN("reserve memory address unsupport, runtime result = %d", static_cast<int32_t>(rtErr));
        } else {
            ACL_LOG_CALL_ERROR("reserve memory address failed, runtime result = %d", static_cast<int32_t>(rtErr));
        }   
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    ACL_ADD_APPLY_SUCCESS_COUNT(acl::ACL_STATISTICS_RESERVE_RELEASE_MEMORY_ADDRESS);
    return ACL_SUCCESS;
}

aclError aclrtReleaseMemAddressImpl(void *virPtr)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtReleaseMemAddress);
    ACL_ADD_RELEASE_TOTAL_COUNT(acl::ACL_STATISTICS_RESERVE_RELEASE_MEMORY_ADDRESS);
    ACL_LOG_DEBUG("start to execute aclrtReleaseMemAddress");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(virPtr);

    const rtError_t rtErr = rtReleaseMemAddress(virPtr);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("release memory address failed, runtime result = %d", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    ACL_ADD_RELEASE_SUCCESS_COUNT(acl::ACL_STATISTICS_RESERVE_RELEASE_MEMORY_ADDRESS);
    return ACL_SUCCESS;
}

aclError aclrtMallocPhysicalImpl(aclrtDrvMemHandle *handle,
                                 size_t size,
                                 const aclrtPhysicalMemProp *prop,
                                 uint64_t flags)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtMallocPhysical);
    ACL_ADD_APPLY_TOTAL_COUNT(acl::ACL_STATISTICS_MALLOC_FREE_PHYSICAL_MEMORY);
    ACL_LOG_DEBUG("start to execute aclrtMallocPhysical, size = %zu", size);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(handle);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(prop);
    ACL_CHECK_WITH_MESSAGE_AND_RETURN(size != 0UL, ACL_ERROR_INVALID_PARAM,
                                      "malloc size must be greater than zero");
    ACL_CHECK_WITH_MESSAGE_AND_RETURN(flags == 0UL, ACL_ERROR_INVALID_PARAM,
                                      "flags must be 0");
    ACL_CHECK_WITH_MESSAGE_AND_RETURN(prop->handleType == ACL_MEM_HANDLE_TYPE_NONE,
                                      ACL_ERROR_INVALID_PARAM, "handleType must be ACL_MEM_HANDLE_TYPE_NONE");
    ACL_CHECK_WITH_MESSAGE_AND_RETURN(prop->allocationType == ACL_MEM_ALLOCATION_TYPE_PINNED,
                                      ACL_ERROR_INVALID_PARAM,
                                      "allocationType must be ACL_MEM_ALLOCATION_TYPE_PINNED");
    ACL_CHECK_WITH_MESSAGE_AND_RETURN(prop->location.type != ACL_MEM_LOCATION_TYPE_UNREGISTERED,
                                      ACL_ERROR_INVALID_PARAM,
                                      "locationType does not support ACL_MEM_LOCATION_TYPE_UNREGISTERED");

    rtDrvMemProp_t rtProp = {};
    rtProp.side = prop->location.type;
    rtProp.devid = prop->location.id;
    rtProp.module_id = acl::APP_MODE_ID_U16;
    rtProp.reserve = prop->reserve;
    // host alloc
    bool IsHostAlloc = (prop->location.type == ACL_MEM_LOCATION_TYPE_HOST) || (prop->location.type == ACL_MEM_LOCATION_TYPE_HOST_NUMA);
    // device alloc
    bool IsDeviceAlloc = (prop->location.type == ACL_MEM_LOCATION_TYPE_DEVICE);
    if (IsDeviceAlloc && ((prop->memAttr == ACL_DDR_MEM_HUGE) || (prop->memAttr == ACL_DDR_MEM_NORMAL) || (prop->memAttr == ACL_DDR_MEM_P2P_HUGE) 
        || (prop->memAttr == ACL_DDR_MEM_P2P_NORMAL))) {
        ACL_LOG_ERROR("memAttr [%d] only support ACL_MEM_LOCATION_TYPE_HOST/ACL_MEM_LOCATION_TYPE_HOST_NUMA.", static_cast<int32_t>(prop->memAttr));
        return ACL_ERROR_INVALID_PARAM;
    }
    switch (prop->memAttr) {
        case ACL_HBM_MEM_HUGE:
            rtProp.pg_type = HUGE_PAGE_TYPE;
            rtProp.mem_type = HBM_TYPE;
            break;
        case ACL_HBM_MEM_NORMAL:
            rtProp.pg_type = NORMAL_PAGE_TYPE;
            rtProp.mem_type = HBM_TYPE;
            break;
        case ACL_HBM_MEM_HUGE1G:
            rtProp.pg_type = HUGE1G_PAGE_TYPE; // 1G huge page
            rtProp.mem_type = HBM_TYPE;
            break;
        case ACL_DDR_MEM_HUGE:
            if (IsHostAlloc) {
                rtProp.pg_type = HUGE_PAGE_TYPE;
                rtProp.mem_type = DDR_TYPE; 
            }
            break;
        case ACL_DDR_MEM_NORMAL:
            if (IsHostAlloc) {
                rtProp.pg_type = NORMAL_PAGE_TYPE;
                rtProp.mem_type = DDR_TYPE;  
            }
            break;
        case ACL_DDR_MEM_P2P_HUGE:
            if (IsHostAlloc) {
                rtProp.pg_type = HUGE_PAGE_TYPE;
                rtProp.mem_type = P2P_DDR_TYPE;  // p2p_ddr 
            }
            break;
        case ACL_DDR_MEM_P2P_NORMAL:
            if (IsHostAlloc) {
                rtProp.pg_type = NORMAL_PAGE_TYPE;  
                rtProp.mem_type = P2P_DDR_TYPE;  // p2p_ddr
            }
            break;
        case ACL_MEM_NORMAL:
            if (IsHostAlloc) {
                rtProp.pg_type = NORMAL_PAGE_TYPE;
                rtProp.mem_type = DDR_TYPE;
            } else if (IsDeviceAlloc) {
                rtProp.pg_type = NORMAL_PAGE_TYPE;
                rtProp.mem_type = HBM_TYPE;
            }
            break;
        case ACL_MEM_HUGE:
            if (IsHostAlloc) {
                rtProp.pg_type = HUGE_PAGE_TYPE;
                rtProp.mem_type = DDR_TYPE;
            } else if (IsDeviceAlloc) {
                rtProp.pg_type = HUGE_PAGE_TYPE;
                rtProp.mem_type = HBM_TYPE;
            }
            break;
        case ACL_MEM_HUGE1G:
            if (IsHostAlloc) {
                rtProp.pg_type = HUGE1G_PAGE_TYPE;
                rtProp.mem_type = DDR_TYPE;
            } else if (IsDeviceAlloc) {
                rtProp.pg_type = HUGE1G_PAGE_TYPE;
                rtProp.mem_type = HBM_TYPE;
            }
            break;
        case ACL_MEM_P2P_NORMAL:
            if (IsHostAlloc) {
                rtProp.pg_type = NORMAL_PAGE_TYPE;
                rtProp.mem_type = P2P_DDR_TYPE; // p2p_ddr
            } else if (IsDeviceAlloc) {
                rtProp.pg_type = NORMAL_PAGE_TYPE;
                rtProp.mem_type = P2P_HBM_TYPE; // p2p_hbm
            }
            break;
        case ACL_MEM_P2P_HUGE:
            if (IsHostAlloc) {
                rtProp.pg_type = HUGE_PAGE_TYPE;
                rtProp.mem_type = P2P_DDR_TYPE; // p2p_ddr
            } else if (IsDeviceAlloc) {
                rtProp.pg_type = HUGE_PAGE_TYPE;
                rtProp.mem_type = P2P_HBM_TYPE; // p2p_hbm
            }
            break;
        case ACL_MEM_P2P_HUGE1G:
            if (IsHostAlloc) {
                rtProp.pg_type = HUGE1G_PAGE_TYPE;
                rtProp.mem_type = P2P_DDR_TYPE; // p2p_ddr
            } else if (IsDeviceAlloc) {
                rtProp.pg_type = HUGE1G_PAGE_TYPE;
                rtProp.mem_type = P2P_HBM_TYPE; // p2p_hbm
            }
            break;
        default:
            ACL_LOG_ERROR("memAttr [%d] support ACL_HBM_MEM_HUGE/ACL_HBM_MEM_NORMAL/ACL_HBM_MEM_HUGE1G. "
                          "Note that ACL_HBM_MEM_HUGE1G is only supported on certain products. "
                          "For details, please refer to the manual.",
                          static_cast<int32_t>(prop->memAttr));
            return ACL_ERROR_INVALID_PARAM;
    }

    const rtError_t rtErr = rtMallocPhysical(reinterpret_cast<rtDrvMemHandle*>(handle), size, &rtProp, flags);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("malloc physical memory failed, runtime result = %d", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    ACL_ADD_APPLY_SUCCESS_COUNT(acl::ACL_STATISTICS_MALLOC_FREE_PHYSICAL_MEMORY);
    return ACL_SUCCESS;
}

aclError aclrtFreePhysicalImpl(aclrtDrvMemHandle handle)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtFreePhysical);
    ACL_ADD_RELEASE_TOTAL_COUNT(acl::ACL_STATISTICS_MALLOC_FREE_PHYSICAL_MEMORY);
    ACL_LOG_DEBUG("start to execute aclrtFreePhysical");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(handle);

    const rtError_t rtErr = rtFreePhysical(reinterpret_cast<rtDrvMemHandle>(handle));
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("free physical memory failed, runtime result = %d", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    ACL_ADD_RELEASE_SUCCESS_COUNT(acl::ACL_STATISTICS_MALLOC_FREE_PHYSICAL_MEMORY);
    return ACL_SUCCESS;
}

aclError aclrtMapMemImpl(void *virPtr,
                         size_t size,
                         size_t offset,
                         aclrtDrvMemHandle handle,
                         uint64_t flags)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtMapMem);
    ACL_ADD_APPLY_TOTAL_COUNT(acl::ACL_STATISTICS_MAP_UNMAP_MEMORY);
    ACL_LOG_DEBUG("start to execute aclrtMapMem, size = %zu, offset = %zu", size, offset);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(virPtr);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(handle);

    if (size == 0UL) {
        ACL_LOG_ERROR("map size must be greater than zero");
        return ACL_ERROR_INVALID_PARAM;
    }
    if (flags != 0UL) {
        ACL_LOG_ERROR("flags must be 0");
        return ACL_ERROR_INVALID_PARAM;
    }

    const rtError_t rtErr = rtMapMem(virPtr, size, offset, reinterpret_cast<rtDrvMemHandle>(handle), flags);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("map memory failed, runtime result = %d", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    ACL_ADD_APPLY_SUCCESS_COUNT(acl::ACL_STATISTICS_MAP_UNMAP_MEMORY);
    return ACL_SUCCESS;
}

aclError aclrtUnmapMemImpl(void *virPtr)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtUnmapMem);
    ACL_ADD_RELEASE_TOTAL_COUNT(acl::ACL_STATISTICS_MAP_UNMAP_MEMORY);
    ACL_LOG_DEBUG("start to execute aclrtUnmapMem");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(virPtr);

    const rtError_t rtErr = rtUnmapMem(virPtr);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("unmap memory failed, runtime result = %d", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    ACL_ADD_RELEASE_SUCCESS_COUNT(acl::ACL_STATISTICS_MAP_UNMAP_MEMORY);
    return ACL_SUCCESS;
}

aclError aclrtMemGetAccessImpl(void *virPtr, aclrtMemLocation *location, uint64_t *flag) 
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtMemGetAccess);
    ACL_LOG_DEBUG("start to execute aclrtMemGetAccess");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(virPtr);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(location);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(flag);

    const rtError_t rtErr = rtMemGetAccess(virPtr, reinterpret_cast<rtMemLocation*>(location), flag);
    if (rtErr != ACL_RT_SUCCESS) {
        ACL_LOG_CALL_ERROR("get access failed, runtime result = %d", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    return ACL_SUCCESS;
}

aclError aclrtMemExportToShareableHandleImpl(aclrtDrvMemHandle handle, aclrtMemHandleType handleType,
                                             uint64_t flags, uint64_t *shareableHandle)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtMemExportToShareableHandle);
    ACL_LOG_DEBUG("start to execute aclrtMemExportToShareableHandle");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(handle);
    ACL_REQUIRES_TRUE(handleType == ACL_MEM_HANDLE_TYPE_NONE, ACL_ERROR_INVALID_PARAM,
                    "handleType in MemExportToShareableHandle must be ACL_MEM_HANDLE_TYPE_NONE !");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(shareableHandle);

    const rtError_t rtErr = rtsMemExportToShareableHandle(reinterpret_cast<rtDrvMemHandle>(handle),
                                                        RT_MEM_HANDLE_TYPE_NONE, flags, shareableHandle);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("export shareable handle failed, runtime result = %d", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    return ACL_SUCCESS;
}

aclError aclrtMemExportToShareableHandleV2Impl(aclrtDrvMemHandle handle, uint64_t flags, 
    aclrtMemSharedHandleType shareType, void *shareableHandle) 
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtMemExportToShareableHandleV2);
    ACL_LOG_DEBUG("start to execute aclrtMemExportToShareableHandleV2");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(handle);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(shareableHandle);

    const rtError_t rtErr = rtMemExportToShareableHandleV2(reinterpret_cast<rtDrvMemHandle>(handle),
        static_cast<rtMemSharedHandleType>(shareType), flags, shareableHandle);
    if (rtErr != ACL_RT_SUCCESS) {
        ACL_LOG_CALL_ERROR("export shareable handle failed, runtime result = %d", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    return ACL_SUCCESS;
}  

aclError aclrtMemImportFromShareableHandleImpl(uint64_t shareableHandle,
                                               int32_t deviceId, aclrtDrvMemHandle *handle)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtMemImportFromShareableHandle);
    ACL_LOG_DEBUG("start to execute aclrtMemImportFromShareableHandle");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(handle);

    const rtError_t rtErr = rtMemImportFromShareableHandle(shareableHandle, deviceId,
                                                            reinterpret_cast<rtDrvMemHandle*>(handle));
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("import from shareable handle failed, shareableHandle[%lu], deviceId[%d], runtime result = %d",
                        shareableHandle, deviceId, static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    return ACL_SUCCESS;
}

aclError aclrtMemImportFromShareableHandleV2Impl(void *shareableHandle, aclrtMemSharedHandleType shareType,
    uint64_t flags, aclrtDrvMemHandle *handle)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtMemImportFromShareableHandleV2);
    ACL_LOG_DEBUG("start to execute aclrtMemImportFromShareableHandleV2");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(shareableHandle);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(handle);
    ACL_REQUIRES_TRUE(flags == 0UL, ACL_ERROR_INVALID_PARAM,
        "flags in aclrtMemImportFromShareableHandleV2 must be 0 !");

    int32_t deviceId = 0;
    const rtError_t rtRet = rtsGetDevice(&deviceId);
    if (rtRet != ACL_RT_SUCCESS) {
        return rtRet;
    }

    const rtError_t rtErr = rtMemImportFromShareableHandleV2(shareableHandle, 
        static_cast<rtMemSharedHandleType>(shareType), flags, deviceId, reinterpret_cast<rtDrvMemHandle*>(handle));
    if (rtErr != ACL_RT_SUCCESS) {
        ACL_LOG_CALL_ERROR("import from shareable handle failed, shareableHandle[%lu], deviceId[%d], runtime result = %d",
            *(static_cast<uint64_t*>(shareableHandle)), deviceId, static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    return ACL_SUCCESS;
}

aclError aclrtMemSetPidToShareableHandleImpl(uint64_t shareableHandle, int32_t *pid, size_t pidNum)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtMemSetPidToShareableHandle);
    ACL_LOG_DEBUG("start to execute aclrtMemSetPidToShareableHandle");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(pid);
    ACL_REQUIRES_TRUE(pidNum > 0UL, ACL_ERROR_INVALID_PARAM,
                        "pidNum in SetPidToShareableHandle must be large than 0 !");

    const rtError_t rtErr = rtMemSetPidToShareableHandle(shareableHandle, pid, static_cast<uint32_t>(pidNum));
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("set pid to shareable handle failed, shareableHandle[%lu], pidNum[%zu], runtime result = %d",
                        shareableHandle, pidNum, static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    return ACL_SUCCESS;
}

aclError aclrtMemSetPidToShareableHandleV2Impl(void *shareableHandle, aclrtMemSharedHandleType shareType,
    int32_t *pid, size_t pidNum)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtMemSetPidToShareableHandleV2);
    ACL_LOG_DEBUG("start to execute AclrtMemSetPidToShareableHandleV2");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(shareableHandle);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(pid);
    ACL_REQUIRES_TRUE(pidNum > 0UL, ACL_ERROR_INVALID_PARAM,
        "pidNum in SetPidToShareableHandle must be large than 0 !");

    const rtError_t rtErr = rtMemSetPidToShareableHandleV2(shareableHandle,
        static_cast<rtMemSharedHandleType>(shareType), pid, static_cast<uint32_t>(pidNum));
    if (rtErr != ACL_RT_SUCCESS) {
        ACL_LOG_CALL_ERROR("set pid to shareable handle failed, shareableHandle[%lu], pidNum[%zu], runtime result = %d",
            *(static_cast<uint64_t*>(shareableHandle)), pidNum, static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    return ACL_SUCCESS;
}

aclError aclrtMemGetAllocationGranularityImpl(aclrtPhysicalMemProp *prop, aclrtMemGranularityOptions option,
                                              size_t *granularity)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtMemGetAllocationGranularity);
    ACL_LOG_DEBUG("start to execute aclrtMemGetAllocationGranularity");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(prop);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(granularity);

    rtDrvMemProp_t rtProp1 = {};
    rtProp1.side = prop->location.type;
    rtProp1.devid = prop->location.id;
    rtProp1.module_id = acl::APP_MODE_ID_U16;
    rtProp1.reserve = prop->reserve;
    switch (prop->memAttr) {
        case ACL_HBM_MEM_HUGE:
            rtProp1.pg_type = 1U;
            rtProp1.mem_type = 0U;
            break;
        case ACL_HBM_MEM_NORMAL:
            rtProp1.pg_type = 0U;
            rtProp1.mem_type = 0U;
            break;
        case ACL_HBM_MEM_HUGE1G:
            rtProp1.pg_type = 2U; // 1G huge page
            rtProp1.mem_type = 0U;
            break;
        default:
            ACL_LOG_ERROR("memAttr [%d] support ACL_HBM_MEM_HUGE/ACL_HBM_MEM_NORMAL/ACL_HBM_MEM_HUGE1G. "
                          "Note that ACL_HBM_MEM_HUGE1G is only supported on certain products. "
                          "For details, please refer to the manual.",
                static_cast<int32_t>(prop->memAttr));
            return ACL_ERROR_INVALID_PARAM;
    }

    const rtError_t rtErr = rtMemGetAllocationGranularity(&rtProp1,
        static_cast<rtDrvMemGranularityOptions>(option), granularity);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("Get Allocation Granularity failed, runtime result = %d", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    return ACL_SUCCESS;
}

aclError aclrtDeviceGetBareTgidImpl(int32_t *pid)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtDeviceGetBareTgid);
    ACL_LOG_DEBUG("start to execute aclrtDeviceGetBareTgid");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(pid);

    const rtError_t rtErr = rtDeviceGetBareTgid(reinterpret_cast<uint32_t *>(pid));
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("Get Bare Tgid Falied, runtime result = %d", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    return ACL_SUCCESS;
}

aclError aclrtCmoAsyncImpl(void *src, size_t size, aclrtCmoType cmoType, aclrtStream stream)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtCmoAsync);
    ACL_LOG_DEBUG("start to execute aclrtCmoAsync");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(src);
    if (size == 0UL) {
        ACL_LOG_ERROR("size must be greater than zero");
        return ACL_ERROR_INVALID_PARAM;
    }
    const rtCmoOpCode_t type = static_cast<rtCmoOpCode_t>(static_cast<uint32_t>(cmoType) +
        (static_cast<uint32_t>(RT_CMO_PREFETCH) - static_cast<uint32_t>(ACL_RT_CMO_TYPE_PREFETCH)));
    ACL_REQUIRES_CALL_RTS_OK(rtCmoAsync(src, size, type, stream), rtCmoAsync);
    return ACL_SUCCESS;
}

aclError aclrtGetMemcpyDescSizeImpl(aclrtMemcpyKind kind, size_t *descSize)
{
    ACL_LOG_INFO("start to execute aclrtGetMemcpyDescSize");
    ACL_REQUIRES_NOT_NULL_WITH_INNER_REPORT(descSize);
    ACL_CHECK_LESS_UINT(static_cast<uint32_t>(kind), static_cast<uint32_t>(RT_MEMCPY_KIND_MAX));
    const auto rt_mem_kind = static_cast<rtMemcpyKind>(static_cast<uint32_t>(kind));
    const auto rtErr = rtsGetMemcpyDescSize(rt_mem_kind, descSize);
    if (rtErr != RT_ERROR_NONE) {
       ACL_LOG_CALL_ERROR("Get memcpy desc size Failed, runtime result = %d", rtErr);
       return ACL_GET_ERRCODE_RTS(rtErr);
    }
    return ACL_SUCCESS;
}

aclError aclrtSetMemcpyDescImpl(void *desc, aclrtMemcpyKind kind, void *srcAddr, void *dstAddr, size_t count,
                                void *config)
{
    ACL_LOG_INFO("start to execute aclrtSetMemcpyDesc");
    ACL_REQUIRES_NOT_NULL_WITH_INNER_REPORT(desc);
    ACL_CHECK_LESS_UINT(static_cast<uint32_t>(kind), static_cast<uint32_t>(RT_MEMCPY_KIND_MAX));
    ACL_REQUIRES_NOT_NULL_WITH_INNER_REPORT(srcAddr);
    ACL_REQUIRES_NOT_NULL_WITH_INNER_REPORT(dstAddr);
    ACL_REQUIRES_POSITIVE_WITH_INPUT_REPORT(count);
    if (config != nullptr) {
        ACL_LOG_ERROR("[Check][config]param is reserved and only support currently nullptr."); \
        return ACL_ERROR_INVALID_PARAM;
    }

    const auto rt_mem_kind = static_cast<rtMemcpyKind>(static_cast<uint32_t>(kind));
    const auto rtErr = rtsSetMemcpyDesc(static_cast<rtMemcpyDesc_t>(desc), rt_mem_kind, srcAddr, dstAddr,
                                        count, nullptr);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("Set memcpy desc Failed, runtime result = %d", rtErr);
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    return ACL_SUCCESS;
}

aclError aclrtMemcpyAsyncWithDescImpl(void *desc, aclrtMemcpyKind kind, aclrtStream stream)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtMemcpyAsyncWithDesc);
    ACL_LOG_INFO("start to execute aclrtMemcpyAsyncWithDesc");
    ACL_REQUIRES_NOT_NULL_WITH_INNER_REPORT(desc);
    ACL_CHECK_LESS_UINT(static_cast<uint32_t>(kind), static_cast<uint32_t>(RT_MEMCPY_KIND_MAX));
    ACL_REQUIRES_NOT_NULL_WITH_INNER_REPORT(stream);

    const auto rt_mem_kind = static_cast<rtMemcpyKind>(static_cast<int32_t>(kind));
    const auto rtErr = rtsMemcpyAsyncWithDesc(static_cast<rtMemcpyDesc_t>(desc), rt_mem_kind, nullptr, stream);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("Async memcpy with desc Failed, runtime result = %d", rtErr);
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    return ACL_SUCCESS;
}

aclError aclrtMemcpyAsyncWithOffsetImpl(void **dst, size_t destMax, size_t dstDataOffset, const void **src,
    size_t count, size_t srcDataOffset, aclrtMemcpyKind kind, aclrtStream stream)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtMemcpyAsyncWithOffset);
    ACL_LOG_INFO("start to execute aclrtMemcpyAsyncWithOffset");
    const auto memKind = static_cast<rtMemcpyKind>(static_cast<int32_t>(kind));
    const auto rtErr = rtMemcpyAsyncWithOffset(dst, destMax, dstDataOffset, src, count, srcDataOffset, memKind, stream);
    if (rtErr != RT_ERROR_NONE) {
        if (rtErr == ACL_ERROR_RT_FEATURE_NOT_SUPPORT) {
            ACL_LOG_WARN("rtMemcpyAsyncWithOffset unsupport, runtime result = %d", static_cast<int32_t>(rtErr));
        } else {
            ACL_LOG_CALL_ERROR("call rtMemcpyAsyncWithOffset Failed, runtime result = %d", rtErr);
        }
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    ACL_LOG_INFO("successfully execute aclrtMemcpyAsyncWithOffset");
    return ACL_SUCCESS;
}

aclError aclrtValueWriteImpl(void* devAddr, uint64_t value, uint32_t flag, aclrtStream stream)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtValueWrite);
    ACL_LOG_INFO("start to execute aclrtValueWrite");
    ACL_REQUIRES_NOT_NULL_WITH_INNER_REPORT(devAddr);

    const auto rtErr = rtsValueWrite(devAddr, value, flag, static_cast<rtStream_t>(stream));
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("call rtsValueWrite Failed, runtime result = %d", rtErr);
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    return ACL_SUCCESS;
}

aclError aclrtValueWaitImpl(void* devAddr, uint64_t value, uint32_t flag, aclrtStream stream)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtValueWait);
    ACL_LOG_INFO("start to execute aclrtValueWait");
    ACL_REQUIRES_NOT_NULL_WITH_INNER_REPORT(devAddr);

    const auto rtErr = rtsValueWait(devAddr, value, flag, static_cast<rtStream_t>(stream));
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("call rtsValueWait Failed, runtime result = %d", rtErr);
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    return ACL_SUCCESS;
}

aclError aclrtReduceAsyncImpl(void *dst, const void *src, uint64_t count, aclrtReduceKind kind,
    aclDataType type, aclrtStream stream, void *reserve)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtReduceAsync);
    ACL_LOG_DEBUG("start to execute aclrtReduceAsync, count = [%lu], kind = [%u], type = [%u]", count,
        static_cast<uint32_t>(kind), static_cast<uint32_t>(type));
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(dst);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(src);
    if (reserve != nullptr) {
        ACL_LOG_ERROR("[Check][reserve]param must be null.");
        acl::AclErrorLogManager::ReportInputError("EH0002", {"param"}, {"reserve"});
        return ACL_ERROR_INVALID_PARAM;
    }

    rtDataType dataType;
    if (kMapDataType.count(type) > 0) {
        dataType = kMapDataType.at(type);
    } else {
        ACL_LOG_ERROR("[Check][param]param type [%d] is invalid.", static_cast<int32_t>(type));
        acl::AclErrorLogManager::ReportInputError(acl::INVALID_PARAM_MSG, {"param"}, {"type"});
        return ACL_ERROR_INVALID_PARAM;
    }

    rtReduceInfo_t reduceInfo;
    reduceInfo.dst = dst;
    reduceInfo.src = const_cast<void*>(src);
    reduceInfo.count = static_cast<size_t>(count);
    reduceInfo.kind = static_cast<rtReduceKind>(kind);
    reduceInfo.type = dataType;
    const rtError_t rtErr = rtsLaunchReduceAsyncTask(&reduceInfo, static_cast<rtStream_t>(stream), reserve);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("call rtsLaunchReduceAsyncTask failed, runtime result = %d", rtErr);
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    return ACL_SUCCESS;
}

aclError aclrtGetBufFromChainImpl(aclrtMbuf headBuf, uint32_t index, aclrtMbuf *buf)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtGetBufFromChain);
    ACL_REQUIRES_NOT_NULL(headBuf);
    ACL_REQUIRES_NOT_NULL(buf);
    ACL_REQUIRES_CALL_RTS_OK(rtMbufChainGetMbuf(headBuf, index, buf), rtMbufChainGetMbuf);
    return ACL_SUCCESS;
}

aclError aclrtGetBufChainNumImpl(aclrtMbuf headBuf, uint32_t *num)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtGetBufChainNum);
    ACL_REQUIRES_NOT_NULL(headBuf);
    ACL_REQUIRES_NOT_NULL(num);
    ACL_REQUIRES_CALL_RTS_OK(rtMbufChainGetMbufNum(headBuf, num), rtMbufChainGetMbufNum);
    return ACL_SUCCESS;
}

aclError aclrtAppendBufChainImpl(aclrtMbuf headBuf, aclrtMbuf buf)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtAppendBufChain);
    ACL_REQUIRES_NOT_NULL(headBuf);
    ACL_REQUIRES_NOT_NULL(buf);
    ACL_REQUIRES_CALL_RTS_OK(rtMbufChainAppend(headBuf, buf), rtMbufChainAppend);
    return ACL_SUCCESS;
}

aclError aclrtCopyBufRefImpl(const aclrtMbuf buf, aclrtMbuf *newBuf)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtCopyBufRef);
    ACL_REQUIRES_NOT_NULL(buf);
    ACL_REQUIRES_NOT_NULL(newBuf);
    ACL_REQUIRES_CALL_RTS_OK(rtMbufCopyBufRef(buf, newBuf), rtMbufCopyBufRef);
    return ACL_SUCCESS;
}

aclError aclrtGetBufUserDataImpl(const aclrtMbuf buf, void *dataPtr, size_t size, size_t offset)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtGetBufUserData);
    // The current default private data area size is 96B, if offset+size exceeds 96, an error is reported
    ACL_CHECK_LESS_UINT((size + offset), MEM_SIZE_MAX);
    ACL_REQUIRES_NOT_NULL(buf);
    ACL_REQUIRES_NOT_NULL(dataPtr);
    uint64_t bufSize = 0U;
    void *tmpDataPtr = nullptr;
    ACL_REQUIRES_CALL_RTS_OK(rtMbufGetPrivInfo(buf, &tmpDataPtr, &bufSize), rtMbufGetPrivInfo);
    ACL_CHECK_LESS_UINT(size, static_cast<size_t>(bufSize));
    ACL_REQUIRES_NOT_NULL(tmpDataPtr);
    const auto ret = memcpy_s(dataPtr, size, (static_cast<uint8_t *>(tmpDataPtr) + offset), size);
    if (ret != EOK) {
        ACL_LOG_INNER_ERROR("call memcpy_s failed, result = %d, size = %zu, bufSize = %lu, offset = %zu",
                            ret, size, bufSize, offset);
        return ACL_ERROR_FAILURE;
    }
    return ACL_SUCCESS;
}

aclError aclrtSetBufUserDataImpl(aclrtMbuf buf, const void *dataPtr, size_t size, size_t offset)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtSetBufUserData);
    // The current default private data area size is 96B, if offset+size exceeds 96, an error is reported
    ACL_CHECK_LESS_UINT((size + offset), MEM_SIZE_MAX);
    ACL_REQUIRES_NOT_NULL(buf);
    ACL_REQUIRES_NOT_NULL(dataPtr);
    uint64_t bufSize = 0U;
    void *tmpDataPtr = nullptr;
    ACL_REQUIRES_CALL_RTS_OK(rtMbufGetPrivInfo(buf, &tmpDataPtr, &bufSize), rtMbufGetPrivInfo);
    ACL_CHECK_LESS_UINT(size, static_cast<size_t>(bufSize));
    ACL_REQUIRES_NOT_NULL(tmpDataPtr);
    const auto ret = memcpy_s((static_cast<uint8_t *>(tmpDataPtr) + offset),
                              (static_cast<size_t>(bufSize) - offset),
                              dataPtr, size);
    if (ret != EOK) {
        ACL_LOG_INNER_ERROR("call memcpy_s failed, result = %d, size = %zu, bufSize = %lu, offset = %zu",
                            ret, size, bufSize, offset);
        return ACL_ERROR_FAILURE;
    }
    return ACL_SUCCESS;
}

aclError aclrtGetBufDataImpl(const aclrtMbuf buf, void **dataPtr, size_t *size)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtGetBufData);
    ACL_REQUIRES_NOT_NULL(buf);
    ACL_REQUIRES_NOT_NULL(dataPtr);
    ACL_REQUIRES_NOT_NULL(size);
    ACL_REQUIRES_CALL_RTS_OK(rtMbufGetBuffAddr(buf, dataPtr), rtMbufGetBuffAddr);
    uint64_t bufSize = 0U;
    ACL_REQUIRES_CALL_RTS_OK(rtMbufGetBuffSize(buf, &bufSize), rtMbufGetBuffSize);
    *size = static_cast<size_t>(bufSize);
    return ACL_SUCCESS;
}

aclError aclrtGetBufDataLenImpl(aclrtMbuf buf, size_t *len)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtGetBufDataLen);
    ACL_REQUIRES_NOT_NULL(buf);
    ACL_REQUIRES_NOT_NULL(len);
    uint64_t dataLen = 0U;
    ACL_REQUIRES_CALL_RTS_OK(rtMbufGetDataLen(buf, &dataLen), rtMbufGetDataLen);
    *len = static_cast<size_t>(dataLen);
    return ACL_SUCCESS;
}

aclError aclrtSetBufDataLenImpl(aclrtMbuf buf, size_t len)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtSetBufDataLen);
    ACL_REQUIRES_NOT_NULL(buf);
    ACL_REQUIRES_CALL_RTS_OK(rtMbufSetDataLen(buf, len), rtMbufSetDataLen);
    return ACL_SUCCESS;
}

aclError aclrtFreeBufImpl(aclrtMbuf buf)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtFreeBuf);
    ACL_REQUIRES_NOT_NULL(buf);
    const rtError_t rtRet = rtMbufFree(buf);
    if (rtRet != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("[Free][buf]fail to call rtMbufFree, result is [%d]", rtRet);
        return rtRet;
    }
    buf = nullptr;
    return ACL_SUCCESS;
}

aclError aclrtAllocBufImpl(aclrtMbuf *buf, size_t size)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtAllocBuf);
    ACL_LOG_INFO("start to execute aclrtAllocBuf, size is [%zu]", size);
    ACL_REQUIRES_NOT_NULL(buf);
    // size must be greater than zero
    if (size == 0UL) {
        ACL_LOG_ERROR("malloc size must be greater than zero");
        acl::AclErrorLogManager::ReportInputError(acl::INVALID_PARAM_MSG,
            std::vector<const char *>({"param", "value", "reason"}),
            std::vector<const char *>({"size", std::to_string(size).c_str(), "size must be greater than zero"}));
        return ACL_ERROR_INVALID_PARAM;
    }
    const rtError_t rtRet = rtMbufAlloc(buf, size);
    if (rtRet != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("[Alloc][buf]fail to call rtMbufAlloc, result is [%d]", rtRet);
        return rtRet;
    }
    return ACL_SUCCESS;
}

aclError aclrtCmoAsyncWithBarrierImpl(void *src, size_t size, aclrtCmoType cmoType, uint32_t barrierId,
    aclrtStream stream)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtCmoAsyncWithBarrier);
    ACL_LOG_INFO("start to execute aclrtCmoAsyncWithBarrier, size is [%zu], cmoType is [%u], barrierId is [%u]",
        size, static_cast<uint32_t>(cmoType), barrierId);
    ACL_REQUIRES_NOT_NULL_WITH_INNER_REPORT(src);
    const rtCmoOpCode rtCmoType = static_cast<rtCmoOpCode>(static_cast<uint32_t>(cmoType) +
        (static_cast<uint32_t>(RT_CMO_PREFETCH) - static_cast<uint32_t>(ACL_RT_CMO_TYPE_PREFETCH)));
    const auto rtErr = rtsCmoAsyncWithBarrier(src, size, rtCmoType, barrierId, static_cast<rtStream_t>(stream));
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("call rtsCmoAsyncWithBarrier Failed, runtime result = %d", rtErr);
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    return ACL_SUCCESS;
}

static aclError MemcpyBatchImpl(void **dsts, size_t *destMaxs, void **srcs, size_t *sizes, size_t numBatches,
    aclrtMemcpyBatchAttr *attrs, size_t *attrsIndexes, size_t numAttrs, size_t *failIndex,
    aclrtStream stream, bool async)
{
    ACL_REQUIRES_NOT_NULL_WITH_INNER_REPORT(dsts);
    ACL_REQUIRES_NOT_NULL_WITH_INNER_REPORT(destMaxs);
    ACL_REQUIRES_NOT_NULL_WITH_INNER_REPORT(srcs);
    ACL_REQUIRES_NOT_NULL_WITH_INNER_REPORT(sizes);
    ACL_REQUIRES_NOT_NULL_WITH_INNER_REPORT(attrs);
    ACL_REQUIRES_NOT_NULL_WITH_INNER_REPORT(attrsIndexes);
    ACL_REQUIRES_NOT_NULL_WITH_INNER_REPORT(failIndex);

    if (numBatches == 0UL) {
        ACL_LOG_ERROR("param numBatches must be greater than zero");
        acl::AclErrorLogManager::ReportInputError(acl::INVALID_PARAM_MSG,
            std::vector<const char *>({"param", "value", "reason"}),
            std::vector<const char *>({"numBatches", std::to_string(numBatches).c_str(),
                "numBatches must be greater than zero"}));
        return ACL_ERROR_INVALID_PARAM;
    }

    for (size_t i = 0UL; i < numBatches; i++) {
        if (destMaxs[i] < sizes[i]) {
            ACL_LOG_ERROR("element of destMaxs must be equal to or greater than corresponding element of sizes");
            acl::AclErrorLogManager::ReportInputError(acl::INVALID_PARAM_MSG,
                std::vector<const char *>({"param", "value", "reason"}),
                std::vector<const char *>({"destMaxs", std::to_string(destMaxs[i]).c_str(),
                    "element of destMaxs must be equal to or greater than corresponding element of sizes"}));
            return ACL_ERROR_INVALID_PARAM;
        }
    }

    constexpr uint32_t rsvMaxSize = sizeof(aclrtMemcpyBatchAttr::rsv) / sizeof(uint8_t);
    for (size_t idx = 0UL; idx < numAttrs; idx++) {
        for (uint32_t i = 0U; i < rsvMaxSize; i++) {
            if (attrs[idx].rsv[i] != 0U) {
                ACL_LOG_ERROR("rsv field of attrs[%zu] must be zero", idx);
                return ACL_ERROR_INVALID_PARAM;
            }
        }
    }

    if (async) {
        const auto rtErr = rtsMemcpyBatchAsync(dsts, destMaxs, srcs, sizes, numBatches, reinterpret_cast<rtMemcpyBatchAttr*>(attrs),
            attrsIndexes, numAttrs, failIndex, stream);
        if (rtErr != RT_ERROR_NONE) {
            ACL_LOG_CALL_ERROR("call rtsMemcpyBatchAsync failed, runtime result = %d.", static_cast<int32_t>(rtErr));
            return ACL_GET_ERRCODE_RTS(rtErr);
        }
        ACL_LOG_INFO("successfully execute aclrtMemcpyBatchAsync");
    } else {
        const auto rtErr = rtsMemcpyBatch(dsts, srcs, sizes, numBatches, reinterpret_cast<rtMemcpyBatchAttr*>(attrs),
            attrsIndexes, numAttrs, failIndex);
        if (rtErr != RT_ERROR_NONE) {
            ACL_LOG_CALL_ERROR("call rtsMemcpyBatch failed, runtime result = %d.", static_cast<int32_t>(rtErr));
            return ACL_GET_ERRCODE_RTS(rtErr);
        }
        ACL_LOG_INFO("successfully execute aclrtMemcpyBatch");
    }

    return ACL_SUCCESS;
}

aclError aclrtIpcMemGetExportKeyImpl(void *devPtr, size_t size, char *key, size_t len, uint64_t flags)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtIpcMemGetExportKey);
    ACL_LOG_INFO("start to execute aclrtIpcMemGetExportKey, size is [%zu], len is [%zu], flags is [%lu]",
        size, len, flags);
    ACL_REQUIRES_NOT_NULL_WITH_INNER_REPORT(devPtr);
    ACL_REQUIRES_NOT_NULL_WITH_INNER_REPORT(key);
    const auto rtErr = rtsIpcMemGetExportKey(devPtr, size, key, static_cast<uint32_t>(len), flags);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("call rtsIpcMemGetExportKey failed, runtime result = %d", rtErr);
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    return ACL_SUCCESS;
}

aclError aclrtIpcMemCloseImpl(const char *key)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtIpcMemClose);
    ACL_LOG_INFO("start to execute aclrtIpcMemClose");
    ACL_REQUIRES_NOT_NULL_WITH_INNER_REPORT(key);
    const auto rtErr = rtsIpcMemClose(key);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("call rtsIpcMemClose failed, runtime result = %d", rtErr);
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    return ACL_SUCCESS;
}

aclError aclrtIpcMemImportByKeyImpl(void **devPtr, const char *key, uint64_t flags)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtIpcMemImportByKey);
    ACL_LOG_INFO("start to execute aclrtIpcMemImportByKey, flags is [%lu]", flags);
    ACL_REQUIRES_NOT_NULL_WITH_INNER_REPORT(devPtr);
    ACL_REQUIRES_NOT_NULL_WITH_INNER_REPORT(key);
    const auto rtErr = rtsIpcMemImportByKey(devPtr, key, flags);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("call rtsIpcMemImportByKey failed, runtime result = %d", rtErr);
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    return ACL_SUCCESS;
}

aclError aclrtMemcpyBatchImpl(void **dsts, size_t *destMaxs, void **srcs, size_t *sizes, size_t numBatches,
    aclrtMemcpyBatchAttr *attrs, size_t *attrsIndexes, size_t numAttrs, size_t *failIndex)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtMemcpyBatch);
    ACL_LOG_INFO("start to execute aclrtMemcpyBatch");
    return MemcpyBatchImpl(dsts, destMaxs, srcs, sizes, numBatches, attrs, attrsIndexes, numAttrs, failIndex,
        nullptr, false);
}

aclError aclrtMemcpyBatchAsyncImpl(void **dsts, size_t *destMaxs, void **srcs, size_t *sizes,
    size_t numBatches, aclrtMemcpyBatchAttr *attrs, size_t *attrsIndexes, size_t numAttrs, size_t *failIndex,
    aclrtStream stream)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtMemcpyBatchAsync);
    ACL_LOG_INFO("start to execute aclrtMemcpyBatchAsync");
    return MemcpyBatchImpl(dsts, destMaxs, srcs, sizes, numBatches, attrs, attrsIndexes, numAttrs, failIndex,
        stream, true);
}

aclError aclrtIpcMemSetImportPidImpl(const char *key, int32_t *pid, size_t num)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtIpcMemSetImportPid);
    ACL_LOG_INFO("start to execute aclrtIpcMemSetImportPid, num is [%zu]", num);
    ACL_REQUIRES_NOT_NULL_WITH_INNER_REPORT(key);
    ACL_REQUIRES_NOT_NULL_WITH_INNER_REPORT(pid);
    const auto rtErr = rtsIpcMemSetImportPid(key, pid, static_cast<int32_t>(num));
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("call rtsIpcMemSetImportPid failed, runtime result = %d", rtErr);
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    return ACL_SUCCESS;
}

aclError aclrtIpcMemSetAttrImpl(const char *key, aclrtIpcMemAttrType type, uint64_t attr)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtIpcMemSetAttr);
    ACL_LOG_INFO("start to execute aclrtIpcMemSetAttr, type is [%d], attr is [%lu]", type, attr);
    const auto rtErr = rtIpcSetMemoryAttr(key, type, attr);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("call rtIpcSetMemoryAttr failed, runtime result = %d", rtErr);
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    ACL_LOG_INFO("successfully execute aclrtIpcMemSetAttr");
    return ACL_SUCCESS;
}

aclError aclrtIpcMemImportPidInterServerImpl(const char *key, aclrtServerPid *serverPids, size_t num)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtIpcMemImportPidInterServer);
    ACL_LOG_INFO("start to execute aclrtIpcMemImportPidInterServer, num is [%zu]", num);
    const auto rtErr = rtIpcMemImportPidInterServer(key, reinterpret_cast<const rtServerPid *>(serverPids), num);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("call aclrtIpcMemImportPidInterServer failed, runtime result = %d", rtErr);
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    ACL_LOG_INFO("successfully execute aclrtIpcMemImportPidInterServer");
    return ACL_SUCCESS;
}

aclError aclrtCheckMemTypeImpl(void** addrList, uint32_t size, uint32_t memType, uint32_t *checkResult, uint32_t reserve)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtCheckMemType);
    ACL_LOG_INFO("start to execute AclrtCheckMemType, size is [%u], memType is [%u], reserve is [%u]", size, memType, reserve);
    ACL_REQUIRES_NOT_NULL_WITH_INNER_REPORT(addrList);
    ACL_REQUIRES_NOT_NULL_WITH_INNER_REPORT(checkResult);
    const auto rtErr = rtsCheckMemType(addrList, size, memType, checkResult, reserve);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("call rtsCheckMemType failed, runtime result = %d", rtErr);
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    return ACL_SUCCESS;
}

aclError aclrtDevicePeerAccessStatusImpl(int32_t deviceId, int32_t peerDeviceId, int32_t *status)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtDevicePeerAccessStatus);
    ACL_LOG_INFO("start to execute aclrtDevicePeerAccessStatus");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(status);
    const rtError_t rtErr = rtsGetP2PStatus(
        static_cast<uint32_t>(deviceId), static_cast<uint32_t>(peerDeviceId), reinterpret_cast<uint32_t *>(status));
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("call rtsGetP2PStatus failed, runtime result = %d.", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    ACL_LOG_INFO("successfully execute aclrtDevicePeerAccessStatus");
    return ACL_SUCCESS;
}

aclError aclrtCmoGetDescSizeImpl(size_t *size)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtCmoGetDescSize);
    ACL_LOG_DEBUG("start to execute aclrtCmoGetDescSize");
    const rtError_t rtErr = rtsGetCmoDescSize(size);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("call rtsGetCmoDescSize failed, runtime result = %d", rtErr);
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    ACL_LOG_INFO("successfully execute aclrtCmoGetDescSize");
    return ACL_SUCCESS;
}

aclError aclrtCmoSetDescImpl(void *cmoDesc, void *src, size_t size)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtCmoSetDesc);
    ACL_LOG_DEBUG("start to execute aclrtCmoSetDesc, memLen =%zu", size);
    const rtError_t rtErr = rtsSetCmoDesc(cmoDesc, src, size);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("call rtsSetCmoDesc failed, runtime result = %d", rtErr);
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    ACL_LOG_INFO("successfully execute aclrtCmoSetDesc");
    return ACL_SUCCESS;
}

static rtCmoOpCode ConvertCmoType(aclrtCmoType cmoType)
{
    constexpr uint32_t offset =
        static_cast<uint32_t>(RT_CMO_PREFETCH) - static_cast<uint32_t>(ACL_RT_CMO_TYPE_PREFETCH);
    return static_cast<rtCmoOpCode>(static_cast<uint32_t>(cmoType) + offset);
}

aclError aclrtCmoAsyncWithDescImpl(void *cmoDesc, aclrtCmoType cmoType, aclrtStream stream, const void *reserve)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtCmoAsyncWithDesc);
    ACL_LOG_DEBUG("start to execute aclrtCmoAsyncWithDesc");
    const rtCmoOpCode rtCmoType = ConvertCmoType(cmoType);
    const rtError_t rtErr = rtsLaunchCmoAddrTask(cmoDesc, stream, rtCmoType, reserve);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("call rtsLaunchCmoAddrTask failed, runtime result = %d", rtErr);
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    ACL_LOG_INFO("successfully execute aclrtCmoAsyncWithDesc");
    return ACL_SUCCESS;
}

aclError aclrtMemSetAccessImpl(void *virPtr, size_t size, aclrtMemAccessDesc *desc, size_t count)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtMemSetAccess);
    ACL_LOG_INFO("start to execute aclrtMemSetAccess");
    
    const rtError_t rtErr = rtMemSetAccess(virPtr, size, reinterpret_cast<rtMemAccessDesc*>(desc), count);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("call aclrtMemSetAccess failed, runtime result = %d.", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    ACL_LOG_INFO("successfully execute aclrtMemSetAccess");
    return ACL_SUCCESS;
}

aclError aclrtMemRetainAllocationHandleImpl(void* virPtr, aclrtDrvMemHandle *handle) 
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtMemRetainAllocationHandle);
    ACL_LOG_DEBUG("start to execute aclrtMemRetainAllocationHandle");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(virPtr);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(handle);

    const rtError_t rtErr = rtMemRetainAllocationHandle(virPtr, reinterpret_cast<rtDrvMemHandle*>(handle));
    if (rtErr != ACL_RT_SUCCESS) {
        ACL_LOG_CALL_ERROR("get handle failed, runtime result = %d", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    return ACL_SUCCESS;
}

//initialize the mapping table
static const MemAttrMapping mapping[] {
    {HUGE_PAGE_TYPE, HBM_TYPE, true, ACL_HBM_MEM_HUGE},
    {NORMAL_PAGE_TYPE, HBM_TYPE, true, ACL_HBM_MEM_NORMAL},
    {HUGE1G_PAGE_TYPE, HBM_TYPE, true, ACL_HBM_MEM_HUGE1G},
    {NORMAL_PAGE_TYPE, P2P_DDR_TYPE, true, ACL_DDR_MEM_P2P_NORMAL},
    {NORMAL_PAGE_TYPE, DDR_TYPE, true, ACL_MEM_NORMAL},
    {HUGE_PAGE_TYPE, DDR_TYPE, true, ACL_MEM_HUGE},
    {HUGE1G_PAGE_TYPE, DDR_TYPE, true, ACL_MEM_HUGE1G},
    {HUGE_PAGE_TYPE, P2P_DDR_TYPE, true, ACL_MEM_P2P_HUGE},
    {HUGE1G_PAGE_TYPE, P2P_DDR_TYPE, true, ACL_MEM_P2P_HUGE1G},
    {NORMAL_PAGE_TYPE, HBM_TYPE, false, ACL_HBM_MEM_NORMAL},
    {HUGE_PAGE_TYPE, HBM_TYPE, false, ACL_HBM_MEM_HUGE},
    {HUGE1G_PAGE_TYPE, HBM_TYPE, false, ACL_HBM_MEM_HUGE1G},
    {NORMAL_PAGE_TYPE, DDR_TYPE, false, ACL_MEM_NORMAL},
    {HUGE_PAGE_TYPE, DDR_TYPE, false, ACL_MEM_HUGE},
    {HUGE1G_PAGE_TYPE, DDR_TYPE, false, ACL_MEM_HUGE1G},
    {NORMAL_PAGE_TYPE, P2P_HBM_TYPE, false, ACL_MEM_P2P_NORMAL},
    {HUGE_PAGE_TYPE, P2P_HBM_TYPE, false, ACL_MEM_P2P_HUGE},
    {HUGE1G_PAGE_TYPE, P2P_HBM_TYPE, false, ACL_MEM_P2P_HUGE1G}
};

aclError aclrtMemGetAllocationPropertiesFromHandleImpl(aclrtDrvMemHandle handle, aclrtPhysicalMemProp* prop)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtMemGetAllocationPropertiesFromHandle);
    ACL_LOG_DEBUG("start to execute AclrtMemGetAllocationPropertiesFromHandle");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(handle);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(prop);

    rtDrvMemProp_t rtProp = {};
    const rtError_t rtErr = rtMemGetAllocationPropertiesFromHandle(reinterpret_cast<rtDrvMemHandle>(handle), &rtProp);

    if (rtErr != ACL_RT_SUCCESS) {
        ACL_LOG_CALL_ERROR("get handle failed, runtime result = %d", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }

    prop->handleType = ACL_MEM_HANDLE_TYPE_NONE;
    prop->allocationType = ACL_MEM_ALLOCATION_TYPE_PINNED;
    prop->location.type = static_cast<aclrtMemLocationType>(rtProp.side);
    prop->location.id = rtProp.devid;
    prop->reserve = rtProp.reserve;

    //host alloc
    bool isHostAlloc = (prop->location.type == ACL_MEM_LOCATION_TYPE_HOST) || (prop->location.type == ACL_MEM_LOCATION_TYPE_HOST_NUMA);

    const auto& it = std::find_if(std::begin(mapping), std::end(mapping),
        [rtProp, isHostAlloc](const MemAttrMapping& entry) {
            return (entry.pgType == rtProp.pg_type) &&
                (entry.memType == rtProp.mem_type) &&
                (entry.isHostAlloc == isHostAlloc);
        });
    if (it != std::end(mapping)) {
        prop->memAttr = it->memAttr;
    } else {
        ACL_LOG_ERROR("memAttr not found for pg_type=%u, mem_type=%u, isHostAlloc=%u",
                      rtProp.pg_type, rtProp.mem_type, isHostAlloc);
        return ACL_ERROR_INVALID_PARAM;
    }
    return ACL_SUCCESS;
}

aclError aclrtReserveMemAddressNoUCMemoryImpl(void **virPtr, size_t size, size_t alignment, void *expectPtr, uint64_t flags)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtReserveMemAddressNoUCMemory);
    ACL_LOG_DEBUG("start to execute aclrtReserveMemAddressNoUCMemory, size = %zu", size);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(virPtr);

    if (size == 0UL) {
        ACL_LOG_ERROR("size is [%zu], reserve size must be greater than zero", size);
        acl::AclErrorLogManager::ReportInputError(acl::INVALID_PARAM_MSG,
            std::vector<const char *>({"param", "value", "reason"}),
            std::vector<const char *>({"size", std::to_string(size).c_str(), "reserve size must be greater than zero"}));
        return ACL_ERROR_INVALID_PARAM;
    }
    if ((flags != 1ULL) && (flags != 0ULL)) {
        ACL_LOG_ERROR("flags is [%lu], flags of page type must be 0 or 1", flags);
        acl::AclErrorLogManager::ReportInputError(acl::INVALID_PARAM_MSG,
            std::vector<const char *>({"param", "value", "reason"}),
            std::vector<const char *>({"size", std::to_string(flags).c_str(), "flags of page type must be 0 or 1"}));
        return ACL_ERROR_INVALID_PARAM;
    }

    flags = flags | FLAG_START_DYNAMIC_ALLOC_MEM; // bit 9置1
    const rtError_t rtErr = rtReserveMemAddress(virPtr, size, alignment, expectPtr, flags);
    if (rtErr != RT_ERROR_NONE) {
        if (rtErr == ACL_ERROR_RT_FEATURE_NOT_SUPPORT) {
            ACL_LOG_WARN("reserve memory address without UCMemeory unsupport, runtime result = %d", static_cast<int32_t>(rtErr));
        } else {
            ACL_LOG_CALL_ERROR("reserve memory address without UCMemeory failed, runtime result = %d", static_cast<int32_t>(rtErr));
        }   
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    return ACL_SUCCESS;
}

aclError aclrtMemGetAddressRangeImpl(void *ptr, void **pbase, size_t *psize)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtMemGetAddressRange);
    ACL_LOG_DEBUG("start to execute aclrtMemGetAddressRange");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(ptr);
    const rtError_t rtErr = rtMemGetAddressRange(ptr, pbase, psize);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("call  aclrtMemGetAddressRange failed, runtime result = %d.", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    ACL_LOG_INFO("successfully execute aclrtMemGetAddressRange");
    return ACL_SUCCESS;
}