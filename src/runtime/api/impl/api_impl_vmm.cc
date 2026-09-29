/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <cinttypes>
#include <memory>
#include <mutex>
#include <new>
#include <string>

#include "api_impl_creator.hpp"
#include "api_impl_vmm.hpp"
#include "base.hpp"
#include "context.hpp"
#include "device.hpp"
#include "driver/ascend_hal.h"
#include "driver_enum_desc.hpp"
#include "enum_desc.hpp"
#include "error_message_manage.hpp"
#include "mem_type.hpp"
#include "npu_driver.hpp"
#include "runtime.hpp"
#include "utils.h"

namespace cce {
namespace runtime {
namespace {
constexpr uint32_t HUGE1G_PAGE = 2U;
constexpr uint32_t DEVICE_TYPE = 1U;
constexpr uint32_t NUMA_TYPE = 4U;
constexpr uint32_t DRV_MEM_HOST_NUMA_SIDE = 2U;
constexpr int32_t FEATURE_SVM_VMM_NORMAL_GRANULARITY = 6; // check drv is support alloc mem via numa id
constexpr char_t MEM_SHARED_HANDLE_TYPE_EXPECT_DESC[] =
    "MEM_SHARE_HANDLE_TYPE_DEFAULT(1) or MEM_SHARE_HANDLE_TYPE_FABRIC(2)";

rtError_t DoFreePhysical(rtDrvMemHandle handle)
{
    RT_LOG(RT_LOG_INFO, "Start to FreePhysical");
    return NpuDriver::FreePhysical(handle);
}

rtError_t DoMemRetainAllocationHandle(void* virPtr, rtDrvMemHandle* handle)
{
    const rtError_t error = NpuDriver::MemRetainAllocationHandle(virPtr, handle);
    ERROR_RETURN(error, "Failed to obtain the handle from virtual pointer, ptr=%p, handle=%p.", virPtr, handle);
    return RT_ERROR_NONE;
}

rtError_t DoMemGetAddressRange(void* ptr, void** pbase, size_t* psize)
{
    RT_LOG(RT_LOG_INFO, "Start to MemGetAddressRange");
    const rtError_t error = NpuDriver::MemGetAddressRange(ptr, pbase, psize);
    ERROR_RETURN(error, "Call MemGetAddressRange failed, ptr=%p", ptr);
    return error;
}

rtError_t ParseMallocCfg(const rtMallocConfig_t* const cfg, rtConfigValue_t* const cfgVal)
{
    // 如果有多个重复的属性取最后一个
    for (size_t i = 0U; i < cfg->numAttrs; ++i) {
        switch (cfg->attrs[i].attr) {
            case RT_MEM_MALLOC_ATTR_RSV:
                break;
            case RT_MEM_MALLOC_ATTR_MODULE_ID:
                cfgVal->moduleId = cfg->attrs[i].value.moduleId;
                break;
            case RT_MEM_MALLOC_ATTR_DEVICE_ID:
                cfgVal->deviceId = cfg->attrs[i].value.deviceId;
                break;
            default:
                RT_LOG(RT_LOG_ERROR, "invalid attribute %s", MallocAttrToString(cfg->attrs[i].attr));
                RT_LOG_OUTER_MSG_WITH_FUNC_DESC(
                    ErrorCode::EE1003, "Parsing the memory allocation configuration",
                    MallocAttrToString(cfg->attrs[i].attr), "cfg->attrs[i].attr", "[0, 2]");
                return RT_ERROR_INVALID_VALUE;
        }
    }
    return RT_ERROR_NONE;
}
} // namespace

bool IsImplVmmSupported() { return true; }

ApiVmm* CreateImplVmmAndGet()
{
    ApiVmm* const apiImplVmm = new (std::nothrow) ApiImplVmm();
    if (apiImplVmm == nullptr) {
        RT_LOG_OUTER_MSG_IMPL(ErrorCode::EE1013, sizeof(ApiImplVmm), "new");
        RT_LOG(RT_LOG_ERROR, "create ApiImplVmm failed.");
        return nullptr;
    }
    RT_LOG(RT_LOG_INFO, "ApiImplVmm:Runtime_alloc_size %zu", sizeof(ApiImplVmm));
    return apiImplVmm;
}

void DestroyImplVmm(ApiVmm*& apiImplVmm)
{
    delete apiImplVmm;
    apiImplVmm = nullptr;
}

rtError_t ApiImplVmm::ReserveMemAddress(void** devPtr, size_t size, size_t alignment, void* devAddr, uint64_t flags)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(devPtr, RT_ERROR_INVALID_VALUE, "Virtual memory allocation");
    Runtime::Instance()->CallApiBegin(RT_PROF_API_DEV_MALLOC);
    const rtError_t error = NpuDriver::ReserveMemAddress(devPtr, size, alignment, devAddr, flags);
    RT_LOG(
        RT_LOG_INFO, "device malloc Succ, size=%" PRIu64 ", start ptr=%p, end ptr=%p", size, *devPtr,
        RtPtrToPtr<void*>(RtPtrToPtr<uint8_t*>(*devPtr) + size));
    if (error == RT_ERROR_NONE) {
        Runtime::Instance()->FillRuntimeMemMngExtInfo(
            RtPtrToValue(*devPtr), static_cast<uint64_t>(size), RT_PROF_MEM_MNG_TYPE_MALLOC, MSPROF_MEMORY_TYPE_DEVICE,
            nullptr);
    }
    Runtime::Instance()->CallApiEnd(error);
    return error;
}

rtError_t ApiImplVmm::ReleaseMemAddress(void* devPtr)
{
    Runtime::Instance()->CallApiBegin(RT_PROF_API_DEV_FREE);
    RT_LOG(RT_LOG_INFO, "device free mem=0x%llx", RtPtrToPtr<uint64_t*>(devPtr));
    const rtError_t error = NpuDriver::ReleaseMemAddress(devPtr);
    if (error == RT_ERROR_NONE) {
        Runtime::Instance()->FillRuntimeMemMngExtInfo(
            RtPtrToValue(devPtr), 0U, RT_PROF_MEM_MNG_TYPE_FREE, MSPROF_MEMORY_TYPE_DEVICE, nullptr);
    }
    Runtime::Instance()->CallApiEnd(error);
    return error;
}

rtError_t ApiImplVmm::MallocPhysical(rtDrvMemHandle* handle, size_t size, rtDrvMemProp_t* prop, uint64_t flags)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(prop, RT_ERROR_INVALID_VALUE, "Physical memory allocation");
    rtError_t error = RT_ERROR_NONE;
    // only device id need covert
    if (prop->side == DEVICE_TYPE) {
        const uint32_t userDeviceId = prop->devid;
        error = Runtime::Instance()->ChgUserDevIdToDeviceId(userDeviceId, &prop->devid);
        COND_RETURN_ERROR(
            error != RT_ERROR_NONE, RT_ERROR_DEVICE_ID, "Failed to convert the user device ID %u to driver device ID.",
            userDeviceId);
        error = Runtime::Instance()->CheckDeviceIdIsValid(static_cast<int32_t>(prop->devid));
        COND_RETURN_ERROR_MSG_INNER(
            error != RT_ERROR_NONE, error, "drv devId is invalid, drv devId=%u, retCode=%#x", prop->devid,
            static_cast<uint32_t>(error));
    }
    // check feature is support
    if (prop->side == NUMA_TYPE) {
        Context* curCtx = Runtime::Instance()->CurrentContext();
        CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
        NULL_PTR_RETURN_MSG(curCtx->Device_(), RT_ERROR_DEVICE_NULL);
        COND_RETURN_WARN(
            (!(NpuDriver::CheckIsSupportFeature(curCtx->Device_()->Id_(), FEATURE_SVM_VMM_NORMAL_GRANULARITY))),
            RT_ERROR_DRV_NOT_SUPPORT, "[drv api] driver does not support the alloc mem via numa id feature.");
        // rt location type covert drv location type
        prop->side = DRV_MEM_HOST_NUMA_SIDE;
    }
    if (prop->pg_type == HUGE1G_PAGE) {
        error = NpuDriver::CheckIfSupport1GHugePage();
        COND_RETURN_ERROR_MSG_INNER(
            error != RT_ERROR_NONE, error, "pageType does not support, pageType[%u], retCode=%#x", prop->pg_type,
            static_cast<uint32_t>(error));
    }
    Runtime::Instance()->CallApiBegin(RT_PROF_API_DEV_MALLOC);
    /* 输出参数handle在上下文中作为一个整体使用, 内部的devid不用进行转换 */
    RT_LOG(RT_LOG_INFO, "Start to MallocPhysical, size=%zu", size);
    error = NpuDriver::MallocPhysical(handle, size, prop, flags);
    if (error == RT_ERROR_NONE) {
        const uint64_t addr = (handle == nullptr) ? 0U : RtPtrToValue(*handle);
        Runtime::Instance()->FillRuntimeMemMngExtInfo(
            addr, static_cast<uint64_t>(size), RT_PROF_MEM_MNG_TYPE_MALLOC, MSPROF_MEMORY_TYPE_DEVICE, nullptr);
    }

    Runtime::Instance()->CallApiEnd(error);
    return error;
}

rtError_t ApiImplVmm::FreePhysical(rtDrvMemHandle handle)
{
    Runtime::Instance()->CallApiBegin(RT_PROF_API_DEV_FREE);
    /* handle在上下文中作为一个整体使用, 内部的devid不用进行转换 */
    const rtError_t error = DoFreePhysical(handle);
    if (error == RT_ERROR_NONE) {
        Runtime::Instance()->FillRuntimeMemMngExtInfo(
            RtPtrToValue(handle), 0U, RT_PROF_MEM_MNG_TYPE_FREE, MSPROF_MEMORY_TYPE_DEVICE, nullptr);
    }
    Runtime::Instance()->CallApiEnd(error);
    return error;
}

rtError_t ApiImplVmm::MapMem(void* devPtr, size_t size, size_t offset, rtDrvMemHandle handle, uint64_t flags)
{
    /* handle在上下文中作为一个整体使用, 内部的devid不用进行转换 */
    const rtError_t error = NpuDriver::MapMem(devPtr, size, offset, handle, flags);
    ERROR_RETURN(error, "failed, size=%" PRIu64 ", ptr=%p.", size, devPtr);
    RT_LOG(
        RT_LOG_INFO, "device malloc Succ, size=%" PRIu64 ", start ptr=%p, end ptr=%p", size, devPtr,
        RtPtrToPtr<void*>(RtPtrToPtr<uint8_t*>(devPtr) + size));
    return error;
}

rtError_t ApiImplVmm::UnmapMem(void* devPtr)
{
    RT_LOG(RT_LOG_INFO, "device free mem=%p", devPtr);
    const rtError_t error = NpuDriver::UnmapMem(devPtr);
    ERROR_RETURN(error, "failed mem=%p", devPtr);
    return error;
}

rtError_t ApiImplVmm::MemMapNoAccess(void* virPtr, size_t size, size_t offset, rtDrvMemHandle handle, uint64_t flags)
{
    const rtError_t error = NpuDriver::MemMapNoAccess(virPtr, size, offset, handle, flags);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, error);
    ERROR_RETURN(
        error, "failed, ptr=%p, size=%zu, offset=%zu, handle=%p, flags=%" PRIu64, virPtr, size, offset, handle, flags);
    return error;
}

rtError_t ApiImplVmm::MemSetAccess(void* virPtr, size_t size, rtMemAccessDesc* desc, size_t count)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(virPtr, RT_ERROR_INVALID_VALUE, "Setting the memory access permission");
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(desc, RT_ERROR_INVALID_VALUE, "Setting the memory access permission");
    if (count == 0U) {
        const rtError_t error = NpuDriver::MemSetAccess(virPtr, size, desc, count);
        COND_RETURN_WARN(
            error == RT_ERROR_FEATURE_NOT_SUPPORT, RT_ERROR_FEATURE_NOT_SUPPORT,
            "failed, ptr=0x%llx, size=%" PRIu64 ", count=%" PRIu64, RtPtrToValue(virPtr), size, count);
        ERROR_RETURN(error, "failed, ptr=0x%llx, size=%" PRIu64 ", count=%" PRIu64, RtPtrToValue(virPtr), size, count);
        return error;
    }

    std::unique_ptr<rtMemAccessDesc[]> realDesc;
    try {
        realDesc.reset(new (std::nothrow) rtMemAccessDesc[count]);
    } catch (const std::bad_array_new_length&) {
        RT_LOG_OUTER_MSG_WITH_FUNC_DESC(
            ErrorCode::EE1011, "Setting the memory access permission", count, "count",
            "The memory access descriptor array cannot be allocated with the specified count");
        return RT_ERROR_INVALID_VALUE;
    }
    COND_RETURN_AND_MSG_OUTER(
        realDesc == nullptr, RT_ERROR_INVALID_VALUE, ErrorCode::EE1011, "Setting the memory access permission", count,
        "count", "The memory access descriptor array cannot be allocated with the specified count");

    for (size_t idx = 0U; idx < count; ++idx) {
        realDesc[idx] = desc[idx];
        if (realDesc[idx].location.type != RT_MEMORY_LOC_DEVICE) {
            continue;
        }
        const uint32_t userDeviceId = realDesc[idx].location.id;
        const rtError_t convertError =
            Runtime::Instance()->ChgUserDevIdToDeviceId(userDeviceId, &realDesc[idx].location.id);
        COND_RETURN_ERROR(
            convertError != RT_ERROR_NONE, convertError, "Failed to convert the user device ID %u to driver device ID.",
            userDeviceId);
    }

    const rtError_t error = NpuDriver::MemSetAccess(virPtr, size, realDesc.get(), count);
    COND_RETURN_WARN(
        error == RT_ERROR_FEATURE_NOT_SUPPORT, RT_ERROR_FEATURE_NOT_SUPPORT,
        "failed, ptr=0x%llx, size=%" PRIu64 ", count=%" PRIu64, RtPtrToValue(virPtr), size, count);
    ERROR_RETURN(error, "failed, ptr=0x%llx, size=%" PRIu64 ", count=%" PRIu64, RtPtrToValue(virPtr), size, count);
    return error;
}

rtError_t ApiImplVmm::MemGetAccess(void* virPtr, rtMemLocation* location, uint64_t* flags)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(virPtr, RT_ERROR_INVALID_VALUE, "Obtaining the memory access permission");
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(
        location, RT_ERROR_INVALID_VALUE, "Obtaining the memory access permission");
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(flags, RT_ERROR_INVALID_VALUE, "Obtaining the memory access permission");
    rtMemLocation realLocation = *location;
    if (realLocation.type == RT_MEMORY_LOC_DEVICE) {
        const uint32_t userDeviceId = realLocation.id;
        const rtError_t convertError = Runtime::Instance()->ChgUserDevIdToDeviceId(userDeviceId, &realLocation.id);
        COND_RETURN_ERROR(
            convertError != RT_ERROR_NONE, convertError, "Failed to convert the user device ID %u to driver device ID.",
            userDeviceId);
    }
    const rtError_t error = NpuDriver::MemGetAccess(virPtr, &realLocation, flags);
    ERROR_RETURN(
        error, "failed, ptr=%p, location=%d, flags=%#" PRIu64 ".", virPtr, static_cast<int32_t>(realLocation.type),
        *flags);
    return error;
}

rtError_t ApiImplVmm::ExportToShareableHandle(
    rtDrvMemHandle handle, rtDrvMemHandleType handleType, uint64_t flags, uint64_t* shareableHandle)
{
    constexpr uint64_t maxFlag = RT_VMM_EXPORT_FLAG_DISABLE_PID_VALIDATION;
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM_AND_FUNC_DESC(
        (flags > maxFlag), RT_ERROR_INVALID_VALUE, "Exporting the physical memory handle of the device", flags,
        "[0, " + std::to_string(maxFlag) + "]");
    /* handle在上下文中作为一个整体使用, 内部的devid不用进行转换 */
    const uint64_t drvFlags = 0UL;
    rtError_t error = NpuDriver::ExportToShareableHandle(handle, handleType, drvFlags, shareableHandle);
    COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
    if ((flags & RT_VMM_EXPORT_FLAG_DISABLE_PID_VALIDATION) != 0UL) {
        error = NpuDriver::SetMemShareHandleDisablePidVerify(*shareableHandle);
    }
    RT_LOG(
        RT_LOG_INFO, "handleType=%s, flags=%#" PRIx64 ", shareableHandle=%" PRIu64 ".",
        DrvMemHandleTypeToString(handleType), flags, *shareableHandle);
    return error;
}

rtError_t ApiImplVmm::ExportToShareableHandleV2(
    rtDrvMemHandle handle, rtMemSharedHandleType handleType, uint64_t flags, void* shareableHandle)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(
        shareableHandle, RT_ERROR_INVALID_VALUE, "Exporting the shared handle of the AI server");
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM_NAME_AND_FUNC_DESC(
        (handleType != RT_MEM_SHARE_HANDLE_TYPE_DEFAULT && handleType != RT_MEM_SHARE_HANDLE_TYPE_FABRIC),
        RT_ERROR_INVALID_VALUE, "Exporting the shared handle of the AI server",
        RtFmtMsg("UNKNOWN(%d)", static_cast<int32_t>(handleType)), "handleType", MEM_SHARED_HANDLE_TYPE_EXPECT_DESC);
    constexpr uint64_t maxFlag = RT_VMM_EXPORT_FLAG_DISABLE_PID_VALIDATION;
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM_AND_FUNC_DESC(
        (flags > maxFlag), RT_ERROR_INVALID_VALUE, "Exporting the shared handle of the AI server", flags,
        "[0, " + std::to_string(maxFlag) + "]");
    /* handle在上下文中作为一个整体使用, 内部的devid不用进行转换 */
    rtError_t error = RT_ERROR_NONE;
    if (handleType == RT_MEM_SHARE_HANDLE_TYPE_FABRIC) {
        Context* curCtx = Runtime::Instance()->CurrentContext();
        CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
        NULL_PTR_RETURN_MSG(curCtx->Device_(), RT_ERROR_DEVICE_NULL);
        const uint32_t devId = static_cast<uint32_t>(curCtx->Device_()->Id_());
        int64_t localServerId = 0;
        error = NpuDriver::GetServerId(devId, &localServerId);
        COND_RETURN_ERROR_MSG_INNER(
            error != RT_ERROR_NONE, error,
            "This device does not support cross-server communication drv devId=%u localServerId=%" PRId64 " err:%#x",
            devId, localServerId, static_cast<uint32_t>(error));
    }
    const uint64_t drvFlags = 0UL;
    error = NpuDriver::ExportToShareableHandleV2(handle, handleType, drvFlags, shareableHandle);
    COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
    if ((flags & RT_VMM_EXPORT_FLAG_DISABLE_PID_VALIDATION) != 0UL) {
        uint64_t shareableHandleU64 = 0UL;
        uint32_t serverId = 0U;
        error = NpuDriver::GetServerIdAndshareableHandle(handleType, shareableHandle, &serverId, &shareableHandleU64);
        COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
        error = NpuDriver::SetMemShareHandleDisablePidVerify(shareableHandleU64);
    }
    RT_LOG(RT_LOG_INFO, "handleType=%s, flags=%#" PRIu64 "", MemSharedHandleTypeToString(handleType), flags);
    return error;
}

rtError_t ApiImplVmm::ImportFromShareableHandle(uint64_t shareableHandle, int32_t devId, rtDrvMemHandle* handle)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(
        handle, RT_ERROR_INVALID_VALUE,
        "Obtaining shareableHandle information and returning the handle in the current process");
    int32_t realDeviceId = 0;
    rtError_t error =
        Runtime::Instance()->ChgUserDevIdToDeviceId(static_cast<uint32_t>(devId), RtPtrToPtr<uint32_t*>(&realDeviceId));
    COND_RETURN_ERROR(
        error != RT_ERROR_NONE, error, "Failed to convert the user device ID %d to driver device ID.", devId);
    error = Runtime::Instance()->CheckDeviceIdIsValid(realDeviceId);
    COND_RETURN_ERROR_MSG_INNER(
        error != RT_ERROR_NONE, error, "drv devId is invalid, drv devId=%d, retCode=%#x", realDeviceId,
        static_cast<uint32_t>(error));
    /* 输出参数handle在上下文中作为一个整体使用, 内部的devid不用进行转换 */
    RT_LOG(RT_LOG_INFO, "Start to ImportFromShareableHandle, drv devId=%d", realDeviceId);
    COND_RETURN_ERROR(
        Runtime::Instance()->CheckCurCtxValid(realDeviceId) != RT_ERROR_NONE, RT_ERROR_CONTEXT_NULL,
        "Current Context is null, drv devId[%d].", realDeviceId);

    uint32_t peerPhyDeviceId = 0U;
    error = NpuDriver::GetPhyDevIdByMemShareHandle(shareableHandle, &peerPhyDeviceId);
    if (error == RT_ERROR_DRV_NOT_SUPPORT) {
        return NpuDriver::ImportFromShareableHandle(shareableHandle, realDeviceId, handle);
    }

    COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
    Context* const curCtx = Runtime::Instance()->CurrentContext(true, DEFAULT_DEVICE_ID);
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    Device* const dev = curCtx->Device_();
    NULL_PTR_RETURN_MSG(dev, RT_ERROR_DEVICE_NULL);
    error = dev->EnableP2PWithOtherDevice(peerPhyDeviceId);
    COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
    return NpuDriver::ImportFromShareableHandle(shareableHandle, realDeviceId, handle);
}

rtError_t ApiImplVmm::ImportFromShareableHandleV2(
    const void* shareableHandle, rtMemSharedHandleType handleType, uint64_t flags, int32_t devId,
    rtDrvMemHandle* handle)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(
        shareableHandle, RT_ERROR_INVALID_VALUE,
        "Obtaining shareableHandle information and returning the handle in the current process");
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(
        handle, RT_ERROR_INVALID_VALUE,
        "Obtaining shareableHandle information and returning the handle in the current process");
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM_NAME_AND_FUNC_DESC(
        (handleType != RT_MEM_SHARE_HANDLE_TYPE_DEFAULT && handleType != RT_MEM_SHARE_HANDLE_TYPE_FABRIC),
        RT_ERROR_INVALID_VALUE, "Obtaining shareableHandle information and returning the handle in the current process",
        RtFmtMsg("UNKNOWN(%d)", static_cast<int32_t>(handleType)), "handleType", MEM_SHARED_HANDLE_TYPE_EXPECT_DESC);
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM_AND_FUNC_DESC(
        (flags != 0U), RT_ERROR_INVALID_VALUE,
        "Obtaining shareableHandle information and returning the handle in the current process", flags, "0");
    int32_t realDeviceId = 0;
    rtError_t error =
        Runtime::Instance()->ChgUserDevIdToDeviceId(static_cast<uint32_t>(devId), RtPtrToPtr<uint32_t*>(&realDeviceId));
    COND_RETURN_ERROR(
        error != RT_ERROR_NONE, error, "Failed to convert the user device ID %d to driver device ID.", devId);
    error = Runtime::Instance()->CheckDeviceIdIsValid(realDeviceId);
    COND_RETURN_ERROR_MSG_INNER(
        error != RT_ERROR_NONE, error, "Device id is invalid, drv deviceId=%d, retCode=%#x", realDeviceId,
        static_cast<uint32_t>(error));
    UNUSED(flags);
    /* 输出参数handle在上下文中作为一个整体使用, 内部的devid不用进行转换 */
    error = RT_ERROR_NONE;
    // handleType为fabric，获取localServerId
    int64_t localServerId = 0;
    if (handleType == RT_MEM_SHARE_HANDLE_TYPE_FABRIC) {
        error = NpuDriver::GetServerId(realDeviceId, &localServerId);
        COND_RETURN_ERROR_MSG_INNER(
            error != RT_ERROR_NONE, error,
            "This device does not support cross-server communication devId:%d ServerId:%" PRId64 " err:%#x",
            realDeviceId, localServerId, static_cast<uint32_t>(error));
    }
    uint32_t peerServerId = 0U;
    uint64_t shareableHandleU64 = 0UL;
    error = NpuDriver::GetServerIdAndshareableHandle(handleType, shareableHandle, &peerServerId, &shareableHandleU64);
    COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
    // handleType为none 或 为fabric但是检测到为同一个ServerId
    if (handleType == RT_MEM_SHARE_HANDLE_TYPE_DEFAULT || static_cast<int64_t>(peerServerId) == localServerId) {
        uint32_t peerPhyDeviceId = 0U;
        error = NpuDriver::GetPhyDevIdByMemShareHandle(shareableHandleU64, &peerPhyDeviceId);
        COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
        Context* const curCtx = Runtime::Instance()->CurrentContext(true, DEFAULT_DEVICE_ID);
        CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
        Device* const dev = curCtx->Device_();
        NULL_PTR_RETURN_MSG(dev, RT_ERROR_DEVICE_NULL);
        uint32_t hostId = 0U;
        error = NpuDriver::GetHostID(&hostId);
        COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
        if (hostId != peerPhyDeviceId) {
            error = dev->EnableP2PWithOtherDevice(peerPhyDeviceId);
        }
        COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
    }
    return NpuDriver::ImportFromShareableHandleV2(shareableHandle, handleType, realDeviceId, handle);
}

rtError_t ApiImplVmm::SetPidToShareableHandle(uint64_t shareableHandle, int32_t pid[], uint32_t pidNum)
{
    RT_LOG(RT_LOG_INFO, "Start to SetPidToShareableHandle");
    return NpuDriver::SetPidToShareableHandle(shareableHandle, pid, pidNum);
}

rtError_t ApiImplVmm::SetPidToShareableHandleV2(
    const void* shareableHandle, rtMemSharedHandleType handleType, int32_t pid[], uint32_t pidNum)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(
        shareableHandle, RT_ERROR_INVALID_VALUE, "Setting the trustlist of processes that can share memory");
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM_NAME_AND_FUNC_DESC(
        (handleType != RT_MEM_SHARE_HANDLE_TYPE_DEFAULT && handleType != RT_MEM_SHARE_HANDLE_TYPE_FABRIC),
        RT_ERROR_INVALID_VALUE, "Setting the trustlist of processes that can share memory",
        RtFmtMsg("UNKNOWN(%d)", static_cast<int32_t>(handleType)), "handleType", MEM_SHARED_HANDLE_TYPE_EXPECT_DESC);
    rtError_t error = RT_ERROR_NONE;
    uint32_t serverId = 0U;
    uint64_t shareableHandleU64 = 0UL;
    error = NpuDriver::GetServerIdAndshareableHandle(handleType, shareableHandle, &serverId, &shareableHandleU64);
    COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
    error = NpuDriver::SetPidToShareableHandle(shareableHandleU64, pid, pidNum);
    RT_LOG(RT_LOG_DEBUG, "handleType = %s pidNum = %d.", MemSharedHandleTypeToString(handleType), pidNum);
    return error;
}

rtError_t ApiImplVmm::GetAllocationGranularity(
    rtDrvMemProp_t* prop, rtDrvMemGranularityOptions option, size_t* granularity)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(
        prop, RT_ERROR_INVALID_VALUE, "Querying the memory allocation granularity");
    if (prop->side == DEVICE_TYPE) {
        const uint32_t userDeviceId = prop->devid;
        rtError_t error = Runtime::Instance()->ChgUserDevIdToDeviceId(userDeviceId, &prop->devid);
        COND_RETURN_ERROR(
            error != RT_ERROR_NONE, RT_ERROR_DEVICE_ID, "Failed to convert the user device ID %u to driver device ID.",
            userDeviceId);
        error = Runtime::Instance()->CheckDeviceIdIsValid(static_cast<int32_t>(prop->devid));
        COND_RETURN_ERROR_MSG_INNER(
            error != RT_ERROR_NONE, error, "drv devId is invalid, drv devId=%u, retCode=%#x", prop->devid,
            static_cast<uint32_t>(error));
    }
    if (prop->side == NUMA_TYPE) {
        // rt location type covert drv location type
        prop->side = DRV_MEM_HOST_NUMA_SIDE;
    }
    RT_LOG(RT_LOG_INFO, "Start to GetAllocationGranularity");
    return NpuDriver::GetAllocationGranularity(prop, option, granularity);
}

rtError_t ApiImplVmm::MemReserveAddress(
    void** virPtr, size_t size, rtMallocPolicy policy, void* expectAddr, rtMallocConfig_t* cfg)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(virPtr, RT_ERROR_INVALID_VALUE, "Reserving the virtual address space");
    ZERO_RETURN_AND_MSG_OUTER_WITH_FUNC_DESC(size, "Reserving the virtual address space");
    COND_RETURN_AND_MSG_RESERVED_PARAM_WITH_FUNC_DESC(
        (expectAddr != nullptr), RT_ERROR_INVALID_VALUE, "expectAddr",
        "expectAddr is reserved parameter and must be null", "Reserving the virtual address space");
    COND_RETURN_AND_MSG_RESERVED_PARAM_WITH_FUNC_DESC(
        (cfg != nullptr), RT_ERROR_INVALID_VALUE, "cfg", "cfg is reserved parameter and must be null",
        "Reserving the virtual address space");
    UNUSED(cfg);
    rtError_t error;
    constexpr size_t alignment = 0U;
    constexpr uint64_t flags = 1ULL; // 0：normal page, 1：huge page

    if (static_cast<uint64_t>(policy) == static_cast<uint64_t>(RT_MEM_MALLOC_HUGE_FIRST)) {
        error = NpuDriver::ReserveMemAddress(virPtr, size, alignment, expectAddr, flags);
        // currently, only huge page is supported, small page can be added later here
    } else if (static_cast<uint64_t>(policy) == static_cast<uint64_t>(RT_MEM_MALLOC_HUGE_ONLY)) {
        error = NpuDriver::ReserveMemAddress(virPtr, size, alignment, expectAddr, flags);
    } else {
        RT_LOG(RT_LOG_ERROR, "flags of page type must be 0 or 1, current flags=%#llx", policy);
        return RT_ERROR_INVALID_VALUE;
    }

    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "huge page malloc failed, error=%#x.", static_cast<int32_t>(error));
        return error;
    }

    RT_LOG(
        RT_LOG_INFO, "device malloc Succ, size=%" PRIu64 ", start ptr=0x%llx, end ptr=0x%llx", size,
        RtPtrToPtr<uint64_t*>(*virPtr), RtPtrToPtr<uint64_t*>(RtPtrToPtr<uint8_t*>(*virPtr) + size));
    return error;
}

rtError_t ApiImplVmm::MemMallocPhysical(rtMemHandle* handle, size_t size, rtMallocPolicy policy, rtMallocConfig_t* cfg)
{
    ZERO_RETURN_AND_MSG_OUTER_WITH_FUNC_DESC(size, "Allocating the physical memory of a device");

    if ((cfg != nullptr) && (cfg->attrs == nullptr)) {
        RT_LOG(RT_LOG_ERROR, "cfg is not nullptr, but attrs is nullptr");
        return RT_ERROR_INVALID_VALUE;
    }

    /* 输出参数handle在上下文中作为一个整体使用, 内部的devid不用进行转换 */
    RT_LOG(RT_LOG_INFO, "Start to malloc physical mem.");
    Context* const curCtx = Runtime::Instance()->CurrentContext(true, DEFAULT_DEVICE_ID);
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    rtDrvMemProp_t prop = {};
    rtMemType_t type = RT_MEMORY_DEFAULT;
    rtConfigValue_t cfgVal;
    cfgVal.moduleId = static_cast<uint16_t>(APP);
    cfgVal.deviceId = curCtx->Device_()->Id_();
    uint32_t pgType = 0UL;
    constexpr uint64_t flags = 0ULL; // drv flag, must be 0.

    if (static_cast<uint64_t>(policy) ==
        static_cast<uint64_t>(RT_MEM_MALLOC_HUGE_ONLY | RT_MEM_TYPE_HIGH_BAND_WIDTH)) { // ACL_HBM_MEM_HUGE
        type = 0UL;
        pgType = 1UL;
    } else if (
        static_cast<uint64_t>(policy) ==
        static_cast<uint64_t>(RT_MEM_MALLOC_NORMAL_ONLY | RT_MEM_TYPE_HIGH_BAND_WIDTH)) { // ACL_HBM_MEM_NORMAL
        type = 0UL;
        pgType = 0UL;
    } else {
        RT_LOG(RT_LOG_ERROR, "invalid policy=%#llx, expected HBM huge-only or normal-only.", policy);
        return RT_ERROR_INVALID_VALUE;
    }

    prop.side = 1UL; // currently only support mem on device
    prop.pg_type = pgType;
    prop.mem_type = type;
    prop.devid = cfgVal.deviceId;
    prop.module_id = cfgVal.moduleId;

    if (cfg == nullptr) {
        return NpuDriver::MallocPhysical(RtPtrToPtr<rtDrvMemHandle*>(handle), size, &prop, flags);
    }

    rtError_t error = ParseMallocCfg(cfg, &cfgVal);
    COND_RETURN_ERROR_MSG_INNER(
        error != RT_ERROR_NONE, RT_ERROR_INVALID_VALUE, "Parse rtMallocConfig failed, error=%#x.",
        static_cast<uint32_t>(error));

    uint32_t realDeviceId = cfgVal.deviceId;
    if (cfgVal.deviceId != curCtx->Device_()->Id_()) {
        error = Runtime::Instance()->ChgUserDevIdToDeviceId(cfgVal.deviceId, &realDeviceId);
        COND_RETURN_ERROR(
            error != RT_ERROR_NONE, RT_ERROR_DEVICE_ID, "Failed to convert the user device ID %u to driver device ID.",
            cfgVal.deviceId);
    }

    prop.module_id = cfgVal.moduleId > DEFAULT_MODULEID ? static_cast<uint16_t>(APP) : cfgVal.moduleId;
    prop.devid = realDeviceId;
    RT_LOG(
        RT_LOG_INFO, "size=%" PRIu64 ", type=%#x, pgType=%#x, moduleId=%hu, deviceId=%d.", size, type, prop.pg_type,
        prop.module_id, prop.devid);
    return NpuDriver::MallocPhysical(RtPtrToPtr<rtDrvMemHandle*>(handle), size, &prop, flags);
}

rtError_t ApiImplVmm::MemRetainAllocationHandle(void* virPtr, rtDrvMemHandle* handle)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(
        virPtr, RT_ERROR_INVALID_VALUE,
        "Obtaining the handle of the physical memory based on the virtual memory address");
    return DoMemRetainAllocationHandle(virPtr, handle);
}

rtError_t ApiImplVmm::MemGetAllocationPropertiesFromHandle(rtDrvMemHandle handle, rtDrvMemProp_t* prop)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(
        handle, RT_ERROR_INVALID_VALUE,
        "Querying the memory attribute information based on the handle of the physical memory information");
    RT_LOG(RT_LOG_INFO, "Start to MemGetAllocationPropertiesFromHandle");
    return NpuDriver::MemGetAllocationPropertiesFromHandle(handle, prop);
}

rtError_t ApiImplVmm::MemGetAddressRange(void* ptr, void** pbase, size_t* psize)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(
        ptr, RT_ERROR_INVALID_VALUE,
        "Obtaining the start address and size of the memory block to which the address to be queried belongs");
    COND_RETURN_AND_MSG_OUTER(
        (pbase == nullptr) && (psize == nullptr), RT_ERROR_INVALID_VALUE, ErrorCode::EE1022,
        "Obtaining the start address and size of the memory block to which the address to be queried belongs",
        "nullptr and nullptr", "pbase and psize", "Parameters pbase and psize cannot both be nullptr");
    return DoMemGetAddressRange(ptr, pbase, psize);
}

rtError_t ApiImplVmm::MemMapSelectedLink(void* virPtrDst, size_t size, void* virPtrSrc, uint32_t linkIdx)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(
        virPtrDst, RT_ERROR_INVALID_VALUE,
        "Mapping the target virtual address to the physical address corresponding to the source virtual address");
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(
        virPtrSrc, RT_ERROR_INVALID_VALUE,
        "Mapping the target virtual address to the physical address corresponding to the source virtual address");
    ZERO_RETURN_AND_MSG_OUTER_WITH_FUNC_DESC(
        size, "Mapping the target virtual address to the physical address corresponding to the source virtual address");
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM_AND_FUNC_DESC(
        linkIdx > RT_MEM_LINK_IDX_1, RT_ERROR_INVALID_VALUE,
        "Mapping the target virtual address to the physical address corresponding to the source virtual address",
        linkIdx, "[" + std::to_string(RT_MEM_LINK_IDX_0) + ", " + std::to_string(RT_MEM_LINK_IDX_1) + "]");

    size_t totalSize = 0U;
    void* base = nullptr;
    size_t baseSize = 0U;
    rtDrvMemHandle handle = nullptr;
    rtError_t error = RT_ERROR_NONE;
    void* virPtrOld = virPtrSrc;
    void* virPtrNew = virPtrDst;
    while (totalSize < size) {
        Runtime* rt = Runtime::Instance();
        std::unique_lock<std::mutex> lock(rt->GetMemMapSelectedLinkMutex_());
        error = DoMemGetAddressRange(virPtrOld, &base, &baseSize);
        ERROR_RETURN(error, "Call MemGetAddressRange failed, virPtrOld=%p", virPtrOld);
        COND_RETURN_ERROR(
            virPtrOld != base, RT_ERROR_INVALID_VALUE,
            "The address virPtrOld is not the starting address of its corresponding memory block. virPtrOld=%p, "
            "base=%p",
            virPtrOld, base);
        error = DoMemRetainAllocationHandle(base, &handle);
        ERROR_RETURN(error, "Failed to obtain the handle from virtual pointer, ptr=%p, handle=%p.", base, handle);
        COND_RETURN_ERROR(
            handle == nullptr, RT_ERROR_INVALID_VALUE, "virPtrSrc cannot get handle, virPtrSrc=%p", virPtrSrc);

        rtHandleAttr attrOrg;
        rtHandleAttr attrNew;
        error = NpuDriver::MemHandleGetAttribute(handle, HANDLE_ATTR_MEM_MAP_ROUTE, &attrOrg);
        COND_PROC_RETURN_ERROR(
            error != RT_ERROR_NONE, error, (void)DoFreePhysical(handle),
            "Call MemHandleGetAttribute failed, handle=%p, type=HANDLE_ATTR_MEM_MAP_ROUTE(%d).", handle,
            HANDLE_ATTR_MEM_MAP_ROUTE);
        attrNew.memMapRoute = linkIdx;
        error = NpuDriver::MemHandleSetAttribute(handle, HANDLE_ATTR_MEM_MAP_ROUTE, attrNew);
        COND_PROC_RETURN_ERROR(
            error != RT_ERROR_NONE, error, (void)DoFreePhysical(handle),
            "Call MemHandleSetAttribute failed, handle=%p, type=HANDLE_ATTR_MEM_MAP_ROUTE(%d), linkIdx=%u, "
            "attrNew.memMapRoute=%u.",
            handle, HANDLE_ATTR_MEM_MAP_ROUTE, linkIdx, attrNew.memMapRoute);
        error = MapMem(virPtrNew, baseSize, 0, handle, 0);
        COND_PROC_RETURN_ERROR(
            error != RT_ERROR_NONE, error, (void)DoFreePhysical(handle),
            "Call MapMem failed, baseSize=%" PRIu64 ", ptr=%p.", baseSize, virPtrNew);
        error = NpuDriver::MemHandleSetAttribute(handle, HANDLE_ATTR_MEM_MAP_ROUTE, attrOrg);
        COND_PROC_RETURN_ERROR(
            error != RT_ERROR_NONE, error, (void)DoFreePhysical(handle),
            "Call MemHandleGetAttribute failed, handle=%p, type=HANDLE_ATTR_MEM_MAP_ROUTE(%d).", handle,
            HANDLE_ATTR_MEM_MAP_ROUTE);

        error = DoFreePhysical(handle);
        ERROR_RETURN(error, "Call FreePhysical failed, handle=%p.", handle);
        virPtrOld = (uint8_t*)virPtrOld + baseSize;
        virPtrNew = (uint8_t*)virPtrNew + baseSize;
        totalSize += baseSize;
    }
    return RT_ERROR_NONE;
}

rtError_t ApiImplVmm::MemMapSetLink(rtDrvMemHandle handle, rtMemLinkType adviceLink)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(handle, RT_ERROR_INVALID_VALUE, "Setting the link ID for memory mapping");
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM_NAME_AND_FUNC_DESC(
        adviceLink > RT_MEM_ACCESS_UB_MULTI_PORT_PATH, RT_ERROR_INVALID_VALUE, "Setting the link ID for memory mapping",
        (adviceLink == RT_MEM_ACCESS_LINK_MAX) ? "MEM_ACCESS_LINK_MAX(4)" :
                                                 RtFmtMsg("UNKNOWN(%d)", static_cast<int32_t>(adviceLink)),
        "adviceLink",
        "[" + std::to_string(RT_MEM_ACCESS_LINK_SIO) + ", " + std::to_string(RT_MEM_ACCESS_UB_MULTI_PORT_PATH) + "]");
    Runtime* rt = Runtime::Instance();
    std::unique_lock<std::mutex> lock(rt->GetMemMapSelectedLinkMutex_());

    rtHandleAttr attr;
    attr.memMapRoute = static_cast<uint32_t>(adviceLink);
    return NpuDriver::MemHandleSetAttribute(handle, HANDLE_ATTR_MEM_MAP_ROUTE, attr);
}

} // namespace runtime
} // namespace cce
