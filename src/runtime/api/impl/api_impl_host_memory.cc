/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "api_impl_host_memory.hpp"

#include <cinttypes>
#include <new>
#include <string>

#include "api_impl_creator.hpp"
#include "base.hpp"
#include "context.hpp"
#include "context_manage.hpp"
#include "dev_info_manage.h"
#include "device.hpp"
#include "enum_desc.hpp"
#include "error_message_manage.hpp"
#include "internal_error_define.hpp"
#include "mem_type.hpp"
#include "npu_driver.hpp"
#include "register_memory.hpp"
#include "runtime.hpp"
#include "utils.h"

namespace {
constexpr char_t MALLOC_ATTR_MODULE_ID_EXPECT_DESC[] = "MEM_MALLOC_ATTR_MODULE_ID(1)";
} // namespace

namespace cce {
namespace runtime {
namespace {
rtError_t HostMallocImpl(void** const hostPtr, const uint64_t size, const uint16_t moduleId)
{
    Context* const curCtx = Runtime::Instance()->CurrentContext(true, DEFAULT_DEVICE_ID);
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    const uint32_t deviceId = curCtx->Device_()->Id_();
    RT_LOG(RT_LOG_INFO, "size=%" PRIu64 ", moduleId=%hu, deviceId=%u.", size, moduleId, deviceId);

    const uint64_t curSize = (((size + 0x1FU) >> 5U) << 5U); // 32 byte align

    return curCtx->Device_()->Driver_()->HostMemAlloc(hostPtr, curSize, deviceId, moduleId);
}

rtError_t HostFreeImpl(void* const hostPtr)
{
    Context* const curCtx = Runtime::Instance()->CurrentContext(true, DEFAULT_DEVICE_ID);
    Driver* curDrv = nullptr;
    if (!ContextManage::CheckContextIsValid(curCtx)) {
        curDrv = Runtime::Instance()->driverFactory_.GetDriver(NPU_DRIVER);
    } else {
        curDrv = curCtx->Device_()->Driver_();
    }
    NULL_PTR_RETURN_MSG(curDrv, RT_ERROR_DRV_NULL);

#ifndef CFG_DEV_PLATFORM_PC
    rtPtrAttributes_t attributes;
    RT_LOG(RT_LOG_DEBUG, "get memory attribute.");
    const rtError_t error = curDrv->PtrGetAttributes(hostPtr, &attributes);
    COND_RETURN_ERROR_MSG_INNER(
        error != RT_ERROR_NONE, RT_ERROR_INVALID_VALUE, "Get hostPtr pointer attributes failed, retCode=%#x",
        static_cast<uint32_t>(error));
    const rtMemLocationType locationType = attributes.location.type;
    COND_RETURN_AND_MSG_OUTER(
        locationType != RT_MEMORY_LOC_HOST && locationType != RT_MEMORY_LOC_UNREGISTERED, RT_ERROR_INVALID_VALUE,
        ErrorCode::EE1011, "Host memory release", MemLocationTypeToString(locationType), "hostPtr locationType",
        "The specified address must be a host address");
#endif

    return curDrv->HostMemFree(hostPtr);
}

} // namespace

bool IsImplHostMemorySupported() { return true; }

ApiHostMemory* CreateImplHostMemoryAndGet()
{
    ApiHostMemory* const apiImplHostMemory = new (std::nothrow) ApiImplHostMemory();
    if (apiImplHostMemory == nullptr) {
        RT_LOG_OUTER_MSG_IMPL(ErrorCode::EE1013, sizeof(ApiImplHostMemory), "new");
        RT_LOG(RT_LOG_ERROR, "create ApiImplHostMemory failed.");
        return nullptr;
    }
    RT_LOG(RT_LOG_INFO, "ApiImplHostMemory:Runtime_alloc_size %zu", sizeof(ApiImplHostMemory));
    return apiImplHostMemory;
}

void DestroyImplHostMemory(ApiHostMemory*& apiImplHostMemory)
{
    delete apiImplHostMemory;
    apiImplHostMemory = nullptr;
}

rtError_t ApiImplHostMemory::HostMalloc(void** const hostPtr, const uint64_t size, const uint16_t moduleId)
{
    const uint16_t moduleIdCov = (moduleId > DEFAULT_MODULEID) ? static_cast<uint16_t>(APP) : moduleId;

    Runtime* const runtime = Runtime::Instance();
    bool needErrorLog = false;
    if (runtime != nullptr) {
        runtime->CallApiBegin(RT_PROF_API_HOST_MALLOC);
    }
    const rtError_t error = [&]() -> rtError_t {
        NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(hostPtr, RT_ERROR_INVALID_VALUE, "Host memory allocation");
        ZERO_RETURN_AND_MSG_OUTER_WITH_FUNC_DESC(size, "Host memory allocation");
        needErrorLog = true;
        const rtError_t ret = HostMallocImpl(hostPtr, size, moduleIdCov);
        if ((ret == RT_ERROR_NONE) && (runtime != nullptr)) {
            const uint64_t addr = (hostPtr == nullptr) ? 0U : RtPtrToValue(*hostPtr);
            runtime->FillRuntimeMemMngExtInfo(addr, size, RT_PROF_MEM_MNG_TYPE_MALLOC, MSPROF_MEMORY_TYPE_HOST);
        }
        return ret;
    }();
    if (runtime != nullptr) {
        runtime->CallApiEnd(error);
    }

    if (!needErrorLog) {
        return error;
    }
    ERROR_RETURN(error, "Host memory malloc failed, size=%" PRIu64 "(bytes), moduleId=%hu.", size, moduleId);
    RT_LOG(
        RT_LOG_INFO, "Host memory malloc succeed, size=%" PRIu64 " bytes, moduleId=%hu, host addr=%#" PRIx64 ".", size,
        moduleId, RtPtrToValue(*hostPtr));
    return error;
}

void ApiImplHostMemory::CheckMallocHostCfg(uint16_t* moduleId) const
{
    if (*moduleId > DEFAULT_MODULEID) {
        *moduleId = static_cast<uint16_t>(MODULEID_RUNTIME);
    }
    return;
}

rtError_t ApiImplHostMemory::GetMallocHostConfigAttr(
    rtMallocAttribute_t* attr, uint16_t* moduleId, uint32_t* vaFlag) const
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(
        attr, RT_ERROR_INVALID_VALUE, "Obtaining the configuration attributes of the memory allocated on the host");
    if (attr->attr == RT_MEM_MALLOC_ATTR_MODULE_ID) {
        *moduleId = attr->value.moduleId;
        return RT_ERROR_NONE;
    }

    // 设置UVA特性
    if (attr->attr == RT_MEM_MALLOC_ATTR_VA_FLAG) {
        *vaFlag = attr->value.vaFlag;
        return RT_ERROR_NONE;
    }

    // 申请内存的接口不支持传入其他类型cfg
    RT_LOG_OUTER_MSG_WITH_FUNC_DESC(
        ErrorCode::EE1003, "Obtaining the configuration attributes of the memory allocated on the host",
        MallocAttrToString(attr->attr), "attr->attr", MALLOC_ATTR_MODULE_ID_EXPECT_DESC);
    return RT_ERROR_INVALID_VALUE;
}

rtError_t ApiImplHostMemory::GetMallocHostConfigInfo(
    const rtMallocConfig_t* cfg, uint16_t* moduleId, uint32_t* vaFlag) const
{
    rtError_t error = RT_ERROR_NONE;
    for (uint32_t i = 0U; i < cfg->numAttrs; i++) {
        rtMallocAttribute_t* attr = &(cfg->attrs[i]);
        error = GetMallocHostConfigAttr(attr, moduleId, vaFlag);
        if (error != RT_ERROR_NONE) {
            return error;
        }
    }
    CheckMallocHostCfg(moduleId);
    return RT_ERROR_NONE;
}

rtError_t ApiImplHostMemory::HostMallocWithCfg(void** const hostPtr, const uint64_t size, const rtMallocConfig_t* cfg)
{
    Runtime* const runtime = Runtime::Instance();
    uint16_t moduleId = static_cast<uint16_t>(MODULEID_RUNTIME);
    uint32_t vaFlag = 0U;
    if (runtime != nullptr) {
        runtime->CallApiBegin(RT_PROF_API_HOST_MALLOC);
    }
    const rtError_t error = [&]() -> rtError_t {
        NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(
            hostPtr, RT_ERROR_INVALID_VALUE, "Allocating host memory based on the configuration attributes");
        ZERO_RETURN_AND_MSG_OUTER_WITH_FUNC_DESC(size, "Allocating host memory based on the configuration attributes");
        rtError_t ret = RT_ERROR_NONE;
        if (cfg != nullptr) {
            NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(
                cfg->attrs, RT_ERROR_INVALID_VALUE, "Allocating host memory based on the configuration attributes");
            ret = GetMallocHostConfigInfo(cfg, &moduleId, &vaFlag);
            ERROR_RETURN(ret, "Host memory malloc failed, size=%" PRIu64 "(bytes)", size);
        }

        Context* const curCtx = Runtime::Instance()->CurrentContext(true, DEFAULT_DEVICE_ID);
        CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
        // 32 byte align
        const uint64_t curSize = (((size + 0x1FU) >> 5U) << 5U);

        ret = curCtx->Device_()->Driver_()->HostMemAlloc(hostPtr, curSize, curCtx->Device_()->Id_(), moduleId, vaFlag);
        if ((ret == RT_ERROR_NONE) && (runtime != nullptr)) {
            const uint64_t addr = (hostPtr == nullptr) ? 0U : RtPtrToValue(*hostPtr);
            runtime->FillRuntimeMemMngExtInfo(addr, size, RT_PROF_MEM_MNG_TYPE_MALLOC, MSPROF_MEMORY_TYPE_HOST);
        }
        COND_RETURN_WITH_NOLOG(ret == RT_ERROR_DRV_NOT_SUPPORT, ret);
        ERROR_RETURN(
            ret, "Host memory malloc failed, size=%" PRIu64 "(bytes), moduleId=%hu, vaFlag=%u.", size, moduleId,
            vaFlag);
        RT_LOG(
            RT_LOG_INFO,
            "Host memory malloc succeed,size=%" PRIu64 "(bytes), moduleId=%hu, vaFlag=%u, host addr=%#" PRIx64 ".",
            size, moduleId, vaFlag, RtPtrToValue(*hostPtr));
        return ret;
    }();
    if (runtime != nullptr) {
        runtime->CallApiEnd(error);
    }
    return error;
}

rtError_t ApiImplHostMemory::HostFree(void* const hostPtr)
{
    Runtime* const runtime = Runtime::Instance();
    bool needErrorLog = false;
    if (runtime != nullptr) {
        runtime->CallApiBegin(RT_PROF_API_HOST_FREE);
    }
    const rtError_t error = [&]() -> rtError_t {
        NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(hostPtr, RT_ERROR_INVALID_VALUE, "Host memory release");
        needErrorLog = true;
        const rtError_t ret = HostFreeImpl(hostPtr);
        if ((ret == RT_ERROR_NONE) && (runtime != nullptr)) {
            runtime->FillRuntimeMemMngExtInfo(
                RtPtrToValue(hostPtr), 0U, RT_PROF_MEM_MNG_TYPE_FREE, MSPROF_MEMORY_TYPE_HOST);
        }
        return ret;
    }();
    if (runtime != nullptr) {
        runtime->CallApiEnd(error);
    }

    if (!needErrorLog) {
        return error;
    }
    ERROR_RETURN(error, "Free host memory failed, host addr=%#" PRIx64 ".", RtPtrToValue(hostPtr));
    RT_LOG(RT_LOG_INFO, "Free host memory succeed, host addr=%#" PRIx64 ".", RtPtrToValue(hostPtr));
    return error;
}

rtError_t ApiImplHostMemory::MallocHostSharedMemory(
    rtMallocHostSharedMemoryIn* const in, rtMallocHostSharedMemoryOut* const out)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(in, RT_ERROR_INVALID_VALUE, "Shared memory allocation");
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(out, RT_ERROR_INVALID_VALUE, "Shared memory allocation");
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(in->name, RT_ERROR_INVALID_VALUE, "Shared memory allocation");
    ZERO_RETURN_AND_MSG_OUTER_WITH_FUNC_DESC(in->size, "Shared memory allocation");
    RT_LOG(RT_LOG_INFO, "sharedMemName=%s, sharedMemSize=%" PRIu64 ", flag=%u.", in->name, in->size, in->flag);
    Context* const curCtx = Runtime::Instance()->CurrentContext(true, DEFAULT_DEVICE_ID);
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    const rtError_t error = curCtx->Device_()->Driver_()->MallocHostSharedMemory(in, out, curCtx->Device_()->Id_());
    ERROR_RETURN(
        error,
        "Malloc host shared memory failed, hostPtr=%s, sharedMemSize=%" PRIu64 "(bytes), flag=%u,"
        "fd=%u.",
        in->name, in->size, in->flag, out->fd);
    return error;
}

rtError_t ApiImplHostMemory::FreeHostSharedMemory(rtFreeHostSharedMemoryIn* const in)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(in, RT_ERROR_INVALID_VALUE, "Releasing host shared memory");
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(in->name, RT_ERROR_INVALID_VALUE, "Releasing host shared memory");
    ZERO_RETURN_AND_MSG_OUTER_WITH_FUNC_DESC(in->size, "Releasing host shared memory");
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(in->ptr, RT_ERROR_INVALID_VALUE, "Releasing host shared memory");
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(in->devPtr, RT_ERROR_INVALID_VALUE, "Releasing host shared memory");
    RT_LOG(RT_LOG_INFO, "sharedMemName=%s, sharedMemSize=%" PRIu64 ", fd=%u.", in->name, in->size, in->fd);
    Context* const curCtx = Runtime::Instance()->CurrentContext(true, DEFAULT_DEVICE_ID);
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    const rtError_t error = curCtx->Device_()->Driver_()->FreeHostSharedMemory(in, curCtx->Device_()->Id_());
    ERROR_RETURN(
        error, "Free host shared memory failed, sharedMemName=%s, sharedMemSize=%" PRIu64 "(bytes), fd=%u.", in->name,
        in->size, in->fd);
    return error;
}

rtError_t ApiImplHostMemory::HostRegister(void* ptr, uint64_t size, rtHostRegisterType type, void** devPtr)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(
        ptr, RT_ERROR_INVALID_VALUE, "Registering the host memory as device-accessible memory");
    ZERO_RETURN_AND_MSG_OUTER_WITH_FUNC_DESC(size, "Registering the host memory as device-accessible memory");
    constexpr uint32_t validFlags = RT_HOST_REGISTER_IOMEMORY | RT_HOST_REGISTER_READONLY;
    const bool isValidFlag = ((static_cast<uint32_t>(type) & (~validFlags)) == 0U);
    COND_RETURN_AND_MSG_OUTER(
        !isValidFlag, RT_ERROR_FEATURE_NOT_SUPPORT, ErrorCode::EE1011, "Host memory address registration",
        static_cast<uint32_t>(type), "type",
        "Valid values are ACL_HOST_REGISTER_MAPPED(0), ACL_HOST_REGISTER_IOMEMORY(0x04), "
        "and ACL_HOST_REGISTER_READONLY(0x08). Multiple flags can be combined using bitwise-OR('|')");
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(
        devPtr, RT_ERROR_INVALID_VALUE, "Registering the host memory as device-accessible memory");

    RT_LOG(RT_LOG_INFO, "MemSize=%" PRIu64 ", type=%d.", size, type);
    Context* const curCtx = Runtime::Instance()->CurrentContext(true, DEFAULT_DEVICE_ID);
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    const Device* const dev = curCtx->Device_();
    NULL_PTR_RETURN_MSG(dev, RT_ERROR_DEVICE_NULL);

    const rtError_t error =
        dev->Driver_()->HostRegister(ptr, size, static_cast<uint32_t>(type), devPtr, curCtx->Device_()->Id_());
    if ((!dev->IsSupportPinRegister()) && (error == RT_ERROR_NONE)) {
        (void)InsertMappedMemory(ptr, size, *devPtr);
    }

    ERROR_RETURN(error, "Register host memory failed, MemSize=%" PRIu64 "(bytes), type=%d.", size, type);
    return error;
}

rtError_t ApiImplHostMemory::HostRegisterV2(void* ptr, uint64_t size, uint32_t flag)
{
    const uint32_t originFlag = flag;
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(ptr, RT_ERROR_INVALID_VALUE, "Host memory address registration");
    ZERO_RETURN_AND_MSG_OUTER_WITH_FUNC_DESC(size, "Host memory address registration");
    constexpr uint32_t validFlags = RT_MEM_HOST_REGISTER_MAPPED | RT_MEM_HOST_REGISTER_IOMEMORY |
                                    RT_MEM_HOST_REGISTER_READONLY | RT_MEM_HOST_REGISTER_PINNED;
    const bool isValidFlag = ((flag & validFlags) != 0U) && ((flag & (~validFlags)) == 0U);
    COND_RETURN_AND_MSG_OUTER(
        !isValidFlag, RT_ERROR_INVALID_VALUE, ErrorCode::EE1011, "Host memory address registration", flag, "flag",
        "The valid flag is an OR combination of RT_MEM_HOST_REGISTER_MAPPED(0x2U), "
        "RT_MEM_HOST_REGISTER_IOMEMORY(0x4U), RT_MEM_HOST_REGISTER_READONLY(0x8U), and "
        "RT_MEM_HOST_REGISTER_PINNED(0x10000000U)");

    constexpr uint32_t invalidIOAndPin = RT_MEM_HOST_REGISTER_IOMEMORY | RT_MEM_HOST_REGISTER_PINNED;
    COND_RETURN_AND_MSG_OUTER(
        ((flag & invalidIOAndPin) == invalidIOAndPin), RT_ERROR_INVALID_VALUE, ErrorCode::EE1011,
        "Host memory address registration", flag, "flag",
        "IOMemory type memory does not support PIN, ACL_HOST_REG_IOMEMORY(0x4UL) and "
        "ACL_HOST_REG_PINNED(0x10000000UL) cannot be combined");

    RT_LOG(RT_LOG_INFO, "MemSize=%" PRIu64 ", flag=%u.", size, flag);
    Context* const curCtx = Runtime::Instance()->CurrentContext(true, DEFAULT_DEVICE_ID);
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    const Device* const dev = curCtx->Device_();
    NULL_PTR_RETURN_MSG(dev, RT_ERROR_DEVICE_NULL);
    const uint32_t deviceId = dev->Id_();

    rtError_t error = RT_ERROR_NONE;
    const bool supportDrvPinReg = dev->IsSupportPinRegister();

    void* devPtr = nullptr;
    void** devPtrAddr = &devPtr;

    if (supportDrvPinReg) {
        error = dev->Driver_()->HostRegister(ptr, size, flag, devPtrAddr, deviceId);
    } else {
        const bool isPinned = ((flag & RT_MEM_HOST_REGISTER_PINNED) != 0U);
        const bool isMapped =
            ((flag & (RT_MEM_HOST_REGISTER_MAPPED | RT_MEM_HOST_REGISTER_IOMEMORY | RT_MEM_HOST_REGISTER_READONLY)) !=
             0U);
        // Check range once driver not support pin register
        error = CheckMemoryRangeRegistered(ptr, size);
        if ((error == RT_ERROR_NONE) && isMapped) {
            // Only pass pin semantics only when driver supports pin
            flag &= ~RT_MEM_HOST_REGISTER_PINNED;
            error = dev->Driver_()->HostRegister(ptr, size, flag, devPtrAddr, deviceId);
            if (error == RT_ERROR_NONE) {
                (void)InsertMappedMemory(ptr, size, devPtr);
            }
        }
        if ((error == RT_ERROR_NONE) && isPinned) {
            (void)InsertPinnedMemory(ptr, size);
        }
    }
    COND_RETURN_AND_MSG_OUTER(
        error == RT_ERROR_HOST_MEMORY_ALREADY_REGISTERED, error, ErrorCode::EE1018, "Host memory address registration",
        "The memory range has already been registered");
    ERROR_RETURN(error, "Register host memory failed, MemSize=%" PRIu64 "(bytes), flag=%#x.", size, originFlag);
    return error;
}

rtError_t ApiImplHostMemory::HostUnregister(void* ptr)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(ptr, RT_ERROR_INVALID_VALUE, "Host memory deregistration");

    Context* const curCtx = Runtime::Instance()->CurrentContext(true, DEFAULT_DEVICE_ID);
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    const Device* const dev = curCtx->Device_();
    NULL_PTR_RETURN_MSG(dev, RT_ERROR_DEVICE_NULL);
    const uint32_t deviceId = dev->Id_();

    rtError_t error = RT_ERROR_NONE;
    const bool isMapped = IsMappedMemoryBase(ptr);
    const bool isPinned = IsPinnedMemoryBase(ptr);
    const bool supportDrvPinReg = dev->IsSupportPinRegister();
    if (supportDrvPinReg) {
        error = dev->Driver_()->HostUnregister(ptr, deviceId, supportDrvPinReg);
    } else {
        if (isMapped) {
            error = dev->Driver_()->HostUnregister(ptr, deviceId, supportDrvPinReg);
            if (error == RT_ERROR_NONE) {
                EraseMappedMemory(ptr);
            }
        }
        if ((error == RT_ERROR_NONE) && isPinned) {
            ErasePinnedMemory(ptr);
        }
        if ((!isMapped) && (!isPinned)) {
            RT_LOG(RT_LOG_WARNING, "host memory is not registered.");
            error = RT_ERROR_HOST_MEMORY_NOT_REGISTERED;
        }
    }

    COND_RETURN_AND_MSG_OUTER(
        error == RT_ERROR_HOST_MEMORY_NOT_REGISTERED, error, ErrorCode::EE1018, "Unregistering host memory",
        "The host pointer has not been registered for device memory mapping");
    ERROR_RETURN(error, "Unregister host memory failed.");
    return error;
}

rtError_t ApiImplHostMemory::HostGetDevicePointer(void* pHost, void** pDevice, uint32_t flag)
{
    constexpr char_t funcDesc[] = "Obtaining the on-device memory pointer based on the on-host virtual address";
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(pHost, RT_ERROR_INVALID_VALUE, funcDesc);
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(pDevice, RT_ERROR_INVALID_VALUE, funcDesc);
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM_AND_FUNC_DESC(
        (flag != 0), RT_ERROR_INVALID_VALUE, funcDesc, flag, "equal to 0");

    Context* const curCtx = Runtime::Instance()->CurrentContext(true, DEFAULT_DEVICE_ID);
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    rtError_t ret = curCtx->Device_()->Driver_()->HostGetDevPointer(pHost, curCtx->Device_()->Id_(), pDevice);
    if (ret == RT_ERROR_FEATURE_NOT_SUPPORT) {
        *pDevice = GetMappedDevicePointer(pHost);
        if (*pDevice == nullptr) {
            RT_LOG_OUTER_MSG_WITH_FUNC_DESC(
                ErrorCode::EE1011, funcDesc, RtFmtMsg("%#" PRIx64, RtPtrToValue(pHost)), "pHost",
                "The host pointer has not been registered for device address mapping");
            ret = RT_ERROR_INVALID_VALUE;
        } else {
            return RT_ERROR_NONE;
        }
    } else if (ret == RT_ERROR_INVALID_VALUE) {
        RT_LOG_OUTER_MSG_WITH_FUNC_DESC(
            ErrorCode::EE1011, funcDesc, RtFmtMsg("%#" PRIx64, RtPtrToValue(pHost)), "pHost",
            "The host pointer has not been registered for device address mapping");
    }
    ERROR_RETURN(ret, "Host get device memory failed.");
    return ret;
}

rtError_t ApiImplHostMemory::HostGetDevicePointerAddrRange(rtAddrRange* addrRange, uint32_t* count)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(count, RT_ERROR_INVALID_VALUE, "Obtaining the device address range");
    Context* const curCtx = Runtime::Instance()->CurrentContext(true, DEFAULT_DEVICE_ID);
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    const uint32_t deviceId = curCtx->Device_()->Id_();
    RT_LOG(RT_LOG_INFO, "Start to HostGetDevicePointerAddrRange");
    rtError_t error = RT_ERROR_NONE;
    if (addrRange == nullptr) {
        error = NpuDriver::HostGetDevicePointerAddrCount(deviceId, count);
    } else {
        error = NpuDriver::HostGetDevicePointerAddrRange(deviceId, addrRange, count);
    }
    return error;
}

rtError_t ApiImplHostMemory::HostMemMapCapabilities(
    uint32_t deviceId, rtHacType hacType, rtHostMemMapCapability* capabilities)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(
        capabilities, RT_ERROR_INVALID_VALUE, "Querying the host memory mapping capability on a specified device");
    Runtime* const runtime = Runtime::Instance();
    uint32_t realDeviceId;
    rtError_t error = runtime->ChgUserDevIdToDeviceId(deviceId, &realDeviceId);
    COND_RETURN_ERROR(
        error != RT_ERROR_NONE, error, "Failed to convert the user device ID %u to driver device ID.", deviceId);

    error = runtime->CheckDeviceIdIsValid(static_cast<int32_t>(realDeviceId));
    COND_RETURN_ERROR_MSG_INNER(
        error != RT_ERROR_NONE, error, "Device ID is invalid, drv devId=%u, retCode=%#x", realDeviceId,
        static_cast<uint32_t>(error));

    COND_RETURN_AND_MSG_OUTER_WITH_PARAM_NAME_AND_FUNC_DESC(
        hacType >= RT_HAC_TYPE_MAX, RT_ERROR_INVALID_VALUE,
        "Querying the host memory mapping capability on a specified device", HacTypeToString(hacType), "hacType",
        "[0, " + std::to_string(RT_HAC_TYPE_MAX) + ")");
    Context* const curCtx = Runtime::Instance()->CurrentContext(true, DEFAULT_DEVICE_ID);
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    error = curCtx->Device_()->Driver_()->HostMemMapCapabilities(realDeviceId, hacType, capabilities);
    if (error == RT_ERROR_FEATURE_NOT_SUPPORT) {
        RT_LOG(RT_LOG_WARNING, "HostMemMapCapabilities is not supported on drv deviceId %u", realDeviceId);
    } else {
        ERROR_RETURN(error, "query host memory capabilities failed.");
    }
    return error;
}

} // namespace runtime
} // namespace cce
