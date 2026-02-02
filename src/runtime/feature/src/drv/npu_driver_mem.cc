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

rtError_t NpuDriver::MallocHostSharedMemory(rtMallocHostSharedMemoryIn * const in,
    rtMallocHostSharedMemoryOut * const out, const uint32_t deviceId)
{
    TIMESTAMP_NAME(__func__);
    rtError_t error = RT_ERROR_NONE;
    int32_t retVal;

    if (IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_MEM_HOST_REGISTER)) {
        if (IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_MEM_HOST_REGISTER_PCIE_THROUGH)) {
            RT_LOG(RT_LOG_INFO, "Change shared memory type %u to %d.",
                   in->flag, static_cast<int32_t>(HOST_MEM_MAP_DEV_PCIE_TH));
            in->flag = static_cast<uint32_t>(HOST_MEM_MAP_DEV_PCIE_TH);
        }

        RT_LOG(RT_LOG_INFO, "Shared memory type %u.", in->flag);
        struct stat buf;
        constexpr const char_t *path = "/dev/shm/";
        char_t name[MMPA_MAX_PATH] = {};
        errno_t retSafe = strcpy_s(&name[0], sizeof(name), path);
        COND_LOG_ERROR(retSafe != EOK, "strcpy_s failed, size=%zu(bytes), retCode=%d!",
                       sizeof(name), retSafe);
        retSafe = strcat_s(name, sizeof(name), in->name);
        COND_LOG_ERROR(retSafe != EOK, "strcat_s failed, size=%zu(bytes), retCode=%d!",
                       sizeof(name), retSafe);
        retVal = stat(name, &buf);

        out->fd = shm_open(in->name, static_cast<int32_t>(O_CREAT) | static_cast<int32_t>(O_RDWR),
            static_cast<mode_t>(S_IRUSR) | static_cast<mode_t>(S_IWUSR));

        COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, out->fd < 0, RT_ERROR_INVALID_VALUE,
            "Call shm_open failed, name=%s.",
            (in->name != nullptr) ? in->name : "");
        RT_LOG(RT_LOG_DEBUG, "malloc host shared memory shm_open success.");

        if (retVal == -1) {
            const int32_t err = ftruncate(out->fd, static_cast<off_t>(in->size));
            COND_GOTO_ERROR_MSG_AND_ASSIGN_CALL(ERR_MODULE_SYSTEM, err != 0, ERROR, error, RT_ERROR_SEC_HANDLE,
                "Malloc host shared memory failed, ftruncate failed!");
            RT_LOG(RT_LOG_DEBUG, "ftruncate success");
        } else if (in->size != static_cast<uint64_t>(buf.st_size)) {
            RT_LOG_OUTER_MSG(RT_INVALID_ARGUMENT_ERROR, "Failed to apply for the shared memory of the host. The"
                "current size=%" PRIu64 "(bytes), valid size=%" PRIu64 "(bytes)", in->size,
                static_cast<uint64_t>(buf.st_size));
            (void)close(out->fd);
            out->fd = -1;
            return RT_ERROR_INVALID_VALUE;
        } else {
            // no operation
        }
        out->ptr = mmap(nullptr, in->size, static_cast<int32_t>(PROT_READ) | static_cast<int32_t>(PROT_WRITE),
                        static_cast<int32_t>(MAP_SHARED), out->fd, 0);
        COND_GOTO_ERROR_MSG_AND_ASSIGN_CALL(ERR_MODULE_SYSTEM, out->ptr == static_cast<void*>(MAP_FAILED), ERROR,
            error, RT_ERROR_SEC_HANDLE,
            "Malloc host shared memory failed, mmap failed, size=%" PRIu64 "(bytes), retCode=%d!", in->size, error);
        RT_LOG(RT_LOG_DEBUG, "malloc host shared memory mmap success.");

        const int32_t ret = madvise(out->ptr, in->size, MADV_HUGEPAGE);
        COND_LOG(ret != 0, "madvise failed, size=%" PRIu64 "(bytes), retVal=%d!", in->size, ret);

        if (retVal == -1) {
            const uint64_t loop = (in->size + PAGE_SIZE - 1U) / PAGE_SIZE;
            for (uint64_t i = 0U; i < loop; ++i) {
                *(static_cast<char_t *>(out->ptr) + (PAGE_SIZE * i)) = '\0';
            }
        }

        const drvError_t drvRet = halHostRegister(out->ptr, static_cast<UINT64>(in->size), in->flag,
            deviceId, &(out->devPtr));
        RT_LOG(RT_LOG_DEBUG, "halHostRegister: drvRetCode=%d, device_id=%u, "
              "sharedMemSize=%" PRIu64 "!", static_cast<int32_t>(drvRet), deviceId, in->size);
        if (drvRet != DRV_ERROR_NONE) {
            DRV_ERROR_PROCESS(drvRet,
                "[drv api] Malloc host shared memory failed, halHostRegister failed, drvRetCode=%d, device_id=%u!",
                static_cast<int32_t>(drvRet), deviceId);
            error = RT_GET_DRV_ERRCODE(drvRet);
            goto RECYCLE;
        }
    } else {
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }
    return RT_ERROR_NONE;

RECYCLE:
    retVal = munmap(out->ptr, in->size);
    COND_LOG_ERROR(retVal != 0, "munmap failed, size=%" PRIu64 "(bytes), retCode=%d", in->size, retVal);
    out->ptr = nullptr;
ERROR:
    (void)close(out->fd);
    out->fd = -1;
    retVal = shm_unlink(in->name);
    COND_LOG_ERROR(retVal != 0, "shm_unlink failed, name=%s, retCode=%d!", in->name, retVal);
    return error;
}

rtError_t NpuDriver::FreeHostSharedMemory(rtFreeHostSharedMemoryIn * const in, const uint32_t deviceId)
{
    TIMESTAMP_NAME(__func__);
    if (IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_MEM_HOST_REGISTER)) {
        struct stat buf;
        constexpr const char_t *path = "/dev/shm/";
        char_t name[MMPA_MAX_PATH] = {};
        errno_t secRet = strcpy_s(name, sizeof(name), path);
        COND_LOG_ERROR(secRet != EOK, "strcpy_s failed, size=%zu(bytes), retCode=%d!", sizeof(name), secRet);
        secRet = strcat_s(&name[0], sizeof(name), in->name);
        COND_LOG_ERROR(secRet != EOK, "strcat_s failed, size=%zu(bytes), retCode=%d!", sizeof(name), secRet);
        /* 1980c wide&&deep temp code */
        drvError_t drvRet = DRV_ERROR_NONE;
        drvRet = halHostUnregister(in->ptr, deviceId);
        if (drvRet != DRV_ERROR_NONE) {
            DRV_ERROR_PROCESS(drvRet, "[drv api] halHostUnregister failed: device_id=%u, "
                "drvRetCode=%d!", deviceId, static_cast<int32_t>(drvRet));
            return RT_GET_DRV_ERRCODE(drvRet);
        }
        RT_LOG(RT_LOG_DEBUG, "halHostUnregister: device_id=%u, drvRetCode=%d!",
               deviceId, static_cast<int32_t>(drvRet));
        int32_t ret = munmap(in->ptr, in->size);
        COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, ret != 0, RT_ERROR_SEC_HANDLE,
            "Call munmap failed, retCode=%d, size=%" PRIu64 "(bytes)", ret, in->size);
        RT_LOG(RT_LOG_DEBUG, "free host shared mem munmap success");

        ret = stat(name, &buf);
        if ((ret == 0) && (in->size == static_cast<uint64_t>(buf.st_size))) {
            (void)close(in->fd);
            ret = shm_unlink(in->name);
            RT_LOG(RT_LOG_DEBUG, "shm_unlink name: %s, size=%" PRIu64 "", in->name, in->size);
            COND_RETURN_WARN(ret != 0, RT_ERROR_NONE,
                             "shm_unlink failed, %s may not exsit!", in->name);
        } else if ((ret == 0) && (in->size != static_cast<uint64_t>(buf.st_size))) {
            RT_LOG_OUTER_MSG_INVALID_PARAM(in->size, buf.st_size);
            return RT_ERROR_INVALID_VALUE;
        } else {
            RT_LOG(RT_LOG_WARNING, "%s is not exsit.", in->name);
        }
    } else {
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::HostRegister(void *ptr, uint64_t size, rtHostRegisterType type, void **devPtr,
    const uint32_t deviceId)
{
    TIMESTAMP_NAME(__func__);

    if (!IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_MEM_HOST_REGISTER)) {
        RT_LOG(RT_LOG_WARNING, "not support current chiptype");
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }

    rtError_t error = RT_ERROR_NONE;
    uint32_t flag = HOST_MEM_MAP_DEV_PCIE_TH;
    if (!IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_MEM_HOST_REGISTER_PCIE_THROUGH)) {
        flag = static_cast<uint32_t>(HOST_MEM_MAP_DEV);
    }
    uint32_t typeMask = static_cast<uint32_t>(type);
    if ((typeMask & RT_HOST_REGISTER_IOMEMORY) != 0U) {
        flag = HOST_IO_MAP_DEV;
    }
    if ((typeMask & RT_HOST_REGISTER_READONLY) != 0U) {
        flag |= MEM_REGISTER_READ_ONLY;
    }
    RT_LOG(RT_LOG_INFO, "memory type %u.", flag);
    const drvError_t drvRet = halHostRegister(ptr, static_cast<UINT64>(size), flag,
        deviceId, devPtr);
    RT_LOG(RT_LOG_DEBUG, "halHostRegister: drvRetCode=%d, device_id=%u, "
            "MemSize=%" PRIu64 "!", static_cast<int32_t>(drvRet), deviceId, size);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet,
            "[drv api] Malloc host memory failed, halHostRegister failed, drvRetCode=%d, device_id=%u!",
            static_cast<int32_t>(drvRet), deviceId);
        error = RT_GET_DRV_ERRCODE(drvRet);
    } else {
        InsertMappedMemory(ptr, size, *devPtr);
    }

    return error;
}

rtError_t NpuDriver::HostUnregister(void *ptr,  const uint32_t deviceId)
{
    TIMESTAMP_NAME(__func__);

    if (!IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_MEM_HOST_REGISTER)) {
        RT_LOG(RT_LOG_WARNING, "not support current chiptype");
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }

    /* 1980c wide&&deep temp code */
    drvError_t drvRet = DRV_ERROR_NONE;
    uint32_t flag = HOST_MEM_MAP_DEV_PCIE_TH;
    if (!IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_MEM_HOST_REGISTER_PCIE_THROUGH)) {
        flag = static_cast<uint32_t>(HOST_MEM_MAP_DEV);
    }
    COND_RETURN_WARN(&halHostUnregisterEx == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halHostUnregisterEx does not exist");

    drvRet = halHostUnregisterEx(ptr, deviceId, static_cast<UINT32>(flag));
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halHostUnregister failed: device_id=%u, "
            "drvRetCode=%d!", deviceId, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    EraseMappedMemory(ptr);
    RT_LOG(RT_LOG_DEBUG, "halHostUnregister: device_id=%u, drvRetCode=%d!",
           deviceId, static_cast<int32_t>(drvRet));
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::HostMemMapCapabilities(uint32_t deviceId, rtHacType hacType, rtHostMemMapCapability *capabilities)
{
    COND_RETURN_WARN(&halHostRegisterCapabilities == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halHostRegisterCapabilities does not exist");
    drvError_t drvRet = DRV_ERROR_NONE;
    UINT32 drv_capabilities;
    drvRet = halHostRegisterCapabilities(deviceId, static_cast<UINT32>(hacType), &drv_capabilities);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halHostRegisterCapabilities failed: device_id=%u, hacType=%d,"
                          "drvRetCode=%d!", deviceId, static_cast<UINT32>(hacType), static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    //将drv_capabilities的值传递给capabilities
    *capabilities = static_cast<rtHostMemMapCapability>(drv_capabilities);
    RT_LOG(RT_LOG_DEBUG, "halHostRegisterCapabilities: device_id=%u, hacType=%d, capabilities=%d!",
           deviceId, hacType, *capabilities);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::HostAddrRegister(void * const addr, const uint64_t size, const uint32_t deviceId)
{
    // just use in hccs & smmu agent mode
    RUNTIME_WHEN_NO_VIRTUAL_MODEL_RETURN;

    COND_RETURN_WARN(&halHostRegister == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halHostRegister does not exist");
    const drvError_t drvRet = halHostRegister(addr, static_cast<UINT64>(size), static_cast<UINT32>(HOST_MEM_MAP_DMA),
        deviceId, nullptr);
    RT_LOG(RT_LOG_DEBUG, "ret=%u, deviceId=%u, size=%" PRIu64, drvRet, deviceId, size);

    return RT_ERROR_NONE;
}

rtError_t NpuDriver::HostAddrUnRegister(void * const addr, const uint32_t deviceId)
{
    // just use in hccs & smmu agent mode
    RUNTIME_WHEN_NO_VIRTUAL_MODEL_RETURN;

    COND_RETURN_WARN(&halHostUnregisterEx == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halHostUnregisterEx does not exist");
    const drvError_t drvRet = halHostUnregisterEx(addr, deviceId, static_cast<UINT32>(HOST_MEM_MAP_DMA));
    RT_LOG(RT_LOG_DEBUG, "ret=%u, deviceId=%u", drvRet, deviceId);

    return RT_ERROR_NONE;
}

rtError_t NpuDriver::ReserveMemAddress(void** devPtr, size_t size, size_t alignment, void *devAddr, uint64_t flags)
{
    drvError_t drvRet = DRV_ERROR_NONE;

    COND_RETURN_WARN(&halMemAddressReserve == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halMemAddressReserve does not exist");

    drvRet = halMemAddressReserve(devPtr, size, alignment, devAddr, flags);
    COND_RETURN_WARN(drvRet == DRV_ERROR_NOT_SUPPORT, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halMemAddressReserve does not support.");
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api]halMemAddressReserve failed. drvRetCode=%d.", static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    return RT_GET_DRV_ERRCODE(drvRet);
}

rtError_t NpuDriver::ReleaseMemAddress(void* devPtr)
{
    drvError_t drvRet = DRV_ERROR_NONE;

    COND_RETURN_WARN(&halMemAddressFree == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halMemAddressFree does not exist");

    drvRet = halMemAddressFree(devPtr);
    COND_RETURN_WARN(drvRet == DRV_ERROR_NOT_SUPPORT, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] ReleaseMemAddress does not support.");
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api]halMemAddressFree failed. drvRetCode=%d.", static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    return RT_GET_DRV_ERRCODE(drvRet);
}

rtError_t NpuDriver::MallocPhysical(rtDrvMemHandle* handle, size_t size, rtDrvMemProp_t* prop, uint64_t flags)
{
    drvError_t drvRet = DRV_ERROR_NONE;

    COND_RETURN_WARN(&halMemCreate == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halMemCreate does not exist");
    const Runtime * const rtInstance = Runtime::Instance();
    const rtChipType_t chipType = rtInstance->GetChipType();
    // The mem_type definitions of acl and runtime is different from drvier.
    DevProperties properties;
    auto error = GET_DEV_PROPERTIES(chipType, properties);
    COND_RETURN_WARN(error != RT_ERROR_NONE, RT_ERROR_FEATURE_NOT_SUPPORT,
        "Failed to access device properties when chipType=%d.", chipType);

    if ((properties.memInfoMapType & MAP_WHEN_SET_INFO) != 0) {
        if (prop->mem_type == RT_MEMORYINFO_DDR) { // acl&runtime DDR -> 0 HBM -> 1; driver DDR -> 1 HBM -> 0
            prop->mem_type = RT_MEMORYINFO_HBM;    // so pass 1 to driver which means DDR type.
        }
    }

    drvRet = halMemCreate(RtPtrToPtr<drv_mem_handle_t **>(handle), size,
        RtPtrToPtr<struct drv_mem_prop *>(prop), flags);
    COND_RETURN_WARN(drvRet == DRV_ERROR_NOT_SUPPORT, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halMemCreate does not support.");
    if (drvRet != DRV_ERROR_NONE) {
        const rtError_t rtErrorCode = RT_GET_DRV_ERRCODE(drvRet);
        const std::string errorStr = RT_GET_ERRDESC(rtErrorCode);
        DRV_ERROR_PROCESS(drvRet, "[drv api]halMemCreate failed drvRetCode=%d, size=%zu(bytes), flags=%" PRIu64 ", %s",
            static_cast<int32_t>(drvRet), size, flags, errorStr.c_str());
        return rtErrorCode;
    }

    return RT_GET_DRV_ERRCODE(drvRet);
}

rtError_t NpuDriver::FreePhysical(rtDrvMemHandle handle)
{
    drvError_t drvRet = DRV_ERROR_NONE;

    COND_RETURN_WARN(&halMemRelease == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halMemRelease does not exist");

    drvRet = halMemRelease(RtPtrToPtr<drv_mem_handle_t *>(handle));
    COND_RETURN_WARN(drvRet == DRV_ERROR_NOT_SUPPORT, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halMemRelease does not support.");
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api]halMemRelease failed. drvRetCode=%d.", static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    return RT_GET_DRV_ERRCODE(drvRet);
}

rtError_t NpuDriver::MapMem(void* devPtr, size_t size, size_t offset, rtDrvMemHandle handle, uint64_t flags)
{
    drvError_t drvRet = DRV_ERROR_NONE;

    COND_RETURN_WARN(&halMemMap == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halMemMap does not exist");

    drvRet = halMemMap(devPtr, size, offset, RtPtrToPtr<drv_mem_handle_t *>(handle), flags);
    COND_RETURN_WARN(drvRet == DRV_ERROR_NOT_SUPPORT, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halMemMap does not support.");
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api]halMemMap failed. drvRetCode=%d.", static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    return RT_GET_DRV_ERRCODE(drvRet);
}

rtError_t NpuDriver::UnmapMem(void* devPtr)
{
    drvError_t drvRet = DRV_ERROR_NONE;

    COND_RETURN_WARN(&halMemUnmap == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halMemUnmap does not exist");

    drvRet = halMemUnmap(devPtr);
    COND_RETURN_WARN(drvRet == DRV_ERROR_NOT_SUPPORT, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halMemUnmap does not support.");
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api]halMemUnmap failed. drvRetCode=%d.", static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    return RT_GET_DRV_ERRCODE(drvRet);
}

rtError_t NpuDriver::MemSetAccess(void *virPtr, size_t size, rtMemAccessDesc *desc, size_t count)
{
    drvError_t drvRet = DRV_ERROR_NONE;

    COND_RETURN_WARN(
        &halMemSetAccess == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT, "[drv api] halMemSetAccess does not exist");

    drvRet = halMemSetAccess(virPtr, size, RtPtrToPtr<struct drv_mem_access_desc *>(desc), count);
    COND_RETURN_WARN(
        drvRet == DRV_ERROR_NOT_SUPPORT, RT_ERROR_FEATURE_NOT_SUPPORT, "[drv api] halMemSetAccess does not support.");
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api]halMemSetAccess failed. drvRetCode=%d.", static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    return RT_GET_DRV_ERRCODE(drvRet);
}

rtError_t NpuDriver::MemGetAccess(void *virPtr, rtMemLocation *location, uint64_t *flags)
{
    COND_RETURN_WARN(
        &halMemGetAccess == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT, "[drv api] halMemGetAccess does not exist");

    const drvError_t drvRet = halMemGetAccess(virPtr, RtPtrToPtr<struct drv_mem_location *>(location), flags);
    COND_RETURN_WARN(
        drvRet == DRV_ERROR_NOT_SUPPORT, RT_ERROR_FEATURE_NOT_SUPPORT, "[drv api] halMemGetAccess does not support.");
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api]halMemGetAccess failed. drvRetCode=%d.", static_cast<int32_t>(drvRet));
    }
    return RT_GET_DRV_ERRCODE(drvRet);
}

rtError_t NpuDriver::GetAllocationGranularity(const rtDrvMemProp_t *prop, rtDrvMemGranularityOptions option,
    size_t *granularity)
{
    drvError_t drvRet = DRV_ERROR_NONE;

    COND_RETURN_WARN(&halMemGetAllocationGranularity == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halMemGetAllocationGranularity does not exist");

    drvRet = halMemGetAllocationGranularity(RtPtrToPtr<const struct drv_mem_prop *>(prop),
        static_cast<drv_mem_granularity_options>(option), granularity);
    COND_RETURN_WARN(drvRet == DRV_ERROR_NOT_SUPPORT, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halMemGetAllocationGranularity does not support.");
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api]halMemGetAllocationGranularity failed. drvRetCode=%d.",
            static_cast<int32_t>(drvRet));
    }

    return RT_GET_DRV_ERRCODE(drvRet);
}

static bool TransSharedHandleType(rtMemSharedHandleType handleType, drv_mem_handle_type &drvHandleType)
{
    static const std::map<rtMemSharedHandleType, drv_mem_handle_type> typeMap = {
        {RT_MEM_SHARE_HANDLE_TYPE_DEFAULT, MEM_HANDLE_TYPE_NONE},
        {RT_MEM_SHARE_HANDLE_TYPE_FABRIC, MEM_HANDLE_TYPE_FABRIC}};
    auto it = typeMap.find(handleType);
    if (it == typeMap.end()) {
        return false;
    }
    drvHandleType = it->second;
    return true;
}

rtError_t NpuDriver::ExportToShareableHandle(rtDrvMemHandle handle, rtDrvMemHandleType handleType,
    uint64_t flags, uint64_t *shareableHandle)
{
    drvError_t drvRet = DRV_ERROR_NONE;

    COND_RETURN_WARN(&halMemExportToShareableHandle == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halMemExportToShareableHandle does not exist");

    drvRet = halMemExportToShareableHandle(RtPtrToPtr<drv_mem_handle_t *>(handle),
        static_cast<drv_mem_handle_type>(handleType), flags, shareableHandle);
    COND_RETURN_WARN(drvRet == DRV_ERROR_NOT_SUPPORT, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halMemExportToShareableHandle does not support.");
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api]halMemExportToShareableHandle failed. drvRetCode=%d.",
            static_cast<int32_t>(drvRet));
    }

    return RT_GET_DRV_ERRCODE(drvRet);
}

rtError_t NpuDriver::ExportToShareableHandleV2(
    rtDrvMemHandle handle, rtMemSharedHandleType handleType, uint64_t flags, void *shareableHandle)
{
    if (handleType == RT_MEM_SHARE_HANDLE_TYPE_DEFAULT) {
        return NpuDriver::ExportToShareableHandle(
            handle, RT_MEM_HANDLE_TYPE_NONE, flags, RtPtrToPtr<uint64_t *>(shareableHandle));
    }
    drv_mem_handle_type drvHandleType = MEM_HANDLE_TYPE_NONE;
    COND_RETURN_ERROR(!TransSharedHandleType(handleType, drvHandleType),
        RT_ERROR_INVALID_VALUE,
        "Invalid handle type: %d",
        handleType);
    COND_RETURN_WARN(&halMemExportToShareableHandleV2 == nullptr,
        RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halMemExportToShareableHandleV2 does not exist");
    const drvError_t drvRet = halMemExportToShareableHandleV2(RtPtrToPtr<drv_mem_handle_t *>(handle),
        drvHandleType,
        flags,
        RtPtrToPtr<struct MemShareHandle *>(shareableHandle));
    COND_RETURN_WARN(drvRet == DRV_ERROR_NOT_SUPPORT,
        RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halMemExportToShareableHandleV2 does not support.");
    COND_RETURN_ERROR(drvRet != DRV_ERROR_NONE,
        RT_GET_DRV_ERRCODE(drvRet),
        "[drv api]halMemExportToShareableHandleV2 failed. drvRetCode=%d.",
        static_cast<int32_t>(drvRet));
    return RT_GET_DRV_ERRCODE(drvRet);
}

rtError_t NpuDriver::ImportFromShareableHandle(uint64_t shareableHandle, int32_t devId, rtDrvMemHandle* handle)
{
    drvError_t drvRet = DRV_ERROR_NONE;

    COND_RETURN_WARN(&halMemImportFromShareableHandle == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halMemImportFromShareableHandle does not exist");

    drvRet = halMemImportFromShareableHandle(shareableHandle, static_cast<uint32_t>(devId),
        RtPtrToPtr<drv_mem_handle_t **>(handle));
    COND_RETURN_WARN(drvRet == DRV_ERROR_NOT_SUPPORT, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halMemImportFromShareableHandle does not support.");
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api]halMemImportFromShareableHandle failed. drvRetCode=%d, device_id=%d.",
            static_cast<int32_t>(drvRet), devId);
    }

    return RT_GET_DRV_ERRCODE(drvRet);
}

rtError_t NpuDriver::ImportFromShareableHandleV2(
    const void *shareableHandle, rtMemSharedHandleType handleType, int32_t devId, rtDrvMemHandle *handle)
{
    if (handleType == RT_MEM_SHARE_HANDLE_TYPE_DEFAULT) {
        return NpuDriver::ImportFromShareableHandle(
            *RtPtrToPtr<uint64_t *>(RtPtrToUnConstPtr<void *>(shareableHandle)), devId, handle);
    }
    drv_mem_handle_type drvHandleType = MEM_HANDLE_TYPE_NONE;
    COND_RETURN_ERROR(!TransSharedHandleType(handleType, drvHandleType),
        RT_ERROR_INVALID_VALUE,
        "Invalid handle type: %d",
        handleType);
    COND_RETURN_WARN(&halMemImportFromShareableHandleV2 == nullptr,
        RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halMemImportFromShareableHandleV2 does not exist");
    const drvError_t drvRet = halMemImportFromShareableHandleV2(drvHandleType,
        RtPtrToPtr<struct MemShareHandle *>(RtPtrToUnConstPtr<void *>(shareableHandle)),
        static_cast<uint32_t>(devId),
        RtPtrToPtr<drv_mem_handle_t **>(handle));
    COND_RETURN_WARN(drvRet == DRV_ERROR_NOT_SUPPORT,
        RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halMemImportFromShareableHandleV2 does not support.");
    COND_RETURN_ERROR(drvRet != DRV_ERROR_NONE,
        RT_GET_DRV_ERRCODE(drvRet),
        "[drv api]halMemImportFromShareableHandleV2 failed. drvRetCode=%d, device_id=%d.",
        static_cast<int32_t>(drvRet),
        devId);
    return RT_GET_DRV_ERRCODE(drvRet);
}

rtError_t NpuDriver::SetPidToShareableHandle(uint64_t shareableHandle, int32_t pid[], uint32_t pidNum)
{
    drvError_t drvRet = DRV_ERROR_NONE;

    COND_RETURN_WARN(&halMemSetPidToShareableHandle == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halMemSetPidToShareableHandle does not exist");

    drvRet = halMemSetPidToShareableHandle(shareableHandle, pid, pidNum);
    COND_RETURN_WARN(drvRet == DRV_ERROR_NOT_SUPPORT, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halMemSetPidToShareableHandle does not support.");
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api]halMemSetPidToShareableHandle failed. drvRetCode=%d.",
            static_cast<int32_t>(drvRet));
    }

    return RT_GET_DRV_ERRCODE(drvRet);
}

rtError_t NpuDriver::GetServerIdAndshareableHandle(
    rtMemSharedHandleType handleType, const void *sharehandle, uint32_t *serverId, uint64_t *shareableHandle)
{
    if (handleType == RT_MEM_SHARE_HANDLE_TYPE_FABRIC) {
        COND_RETURN_WARN(&halMemTransShareableHandle == nullptr,
            RT_ERROR_FEATURE_NOT_SUPPORT,
            "[drv api] halMemTransShareableHandle does not exist");
        drv_mem_handle_type drvHandleType = MEM_HANDLE_TYPE_NONE;
        COND_RETURN_ERROR(!TransSharedHandleType(handleType, drvHandleType),
            RT_ERROR_INVALID_VALUE,
            "Invalid handle type: %d",
            handleType);
        const drvError_t drvRet = halMemTransShareableHandle(drvHandleType,
            RtPtrToPtr<struct MemShareHandle *>(RtPtrToUnConstPtr<void *>(sharehandle)),
            serverId,
            shareableHandle);
        if (drvRet != DRV_ERROR_NONE) {
            DRV_ERROR_PROCESS(
                drvRet, "[drv api]halMemTransShareableHandle failed. drvRetCode=%d.", static_cast<int32_t>(drvRet));
        }
        return RT_GET_DRV_ERRCODE(drvRet);
    } else if (handleType == RT_MEM_SHARE_HANDLE_TYPE_DEFAULT) {
        *shareableHandle = *RtPtrToPtr<uint64_t *>(RtPtrToUnConstPtr<void *>(sharehandle));
        return RT_ERROR_NONE;
    } else {
        RT_LOG(RT_LOG_ERROR, "Invalid handle type: %d", handleType);
        return RT_ERROR_INVALID_VALUE;
    }
}

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

rtError_t NpuDriver::MemAdvise(void * const devPtr, const uint64_t cnt, const uint32_t advise, const uint32_t devid)
{
    COND_RETURN_WARN(&halMemAdvise == nullptr, RT_ERROR_DRV_NOT_SUPPORT,
        "[drv api] halMemAdvise does not exist.");
    const drvError_t drvRet = halMemAdvise(RtPtrToPtr<DVdeviceptr>(devPtr),
        static_cast<size_t>(cnt), advise, static_cast<DVdevice>(devid));
    if (drvRet != DRV_ERROR_NONE) {
        if ((drvRet == DRV_ERROR_INVALID_VALUE) && (advise == RT_ADVISE_ACCESS_READWRITE || advise == RT_ADVISE_ACCESS_READONLY)) {
            RT_LOG(RT_LOG_WARNING, "[drv api] old version does not support the advise, advise=%u, device_id=%u", advise, devid);
        } else {
            DRV_ERROR_PROCESS(drvRet, "[drv api] MemAdvise failed: device_id=%u, count=%" PRIu64
                ", advise=%u, drvRetCode=%u", devid, cnt, advise, static_cast<uint32_t>(drvRet));
            return RT_GET_DRV_ERRCODE(drvRet);
        }
    }

    return RT_ERROR_NONE;
}

/* ========================================================
 * Subcategory: Alloc and Free
 * ======================================================== */

rtError_t NpuDriver::HostMemAlloc(void ** const dptr, const uint64_t size, const uint32_t deviceId,
    const uint16_t moduleId, const uint32_t vaFlag)
{
    TIMESTAMP_NAME(__func__);
    uint64_t drvFlag = static_cast<uint64_t>(MEM_SET_ALIGN_SIZE(9ULL)) | static_cast<uint64_t>(MEM_HOST);
    if (vaFlag == 1U) {
        // 接口cfg里面配置了使用UVA特性，但是驱动不支持，直接返回
        COND_RETURN_WARN(!CheckIsSupportFeature(deviceId, FEATURE_SVM_MEM_HOST_UVA),
            RT_ERROR_DRV_NOT_SUPPORT, "[drv api] driver not support uva feature.");
        drvFlag = static_cast<uint64_t>(MEM_SET_ALIGN_SIZE(9ULL)) | static_cast<uint64_t>(MEM_HOST_UVA);
    }

    drvFlag = FlagAddModuleId(drvFlag, moduleId);
    const drvError_t drvRet = halMemAlloc(dptr, static_cast<UINT64>(size), static_cast<UINT64>(drvFlag));
    if (drvRet != DRV_ERROR_NONE) {
        DRV_MALLOC_ERROR_PROCESS(drvRet, moduleId, "[drv api] halMemAlloc failed: size=%" PRIu64 "(bytes), drvRetCode=%d, device_id=%u, "
            "drvFlag=%" PRIu64 ", moduleId=%hu!", size, static_cast<int32_t>(drvRet), deviceId, drvFlag, moduleId);
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    return RT_ERROR_NONE;
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
                DRV_MALLOC_ERROR_PROCESS(drvRet, moduleId, "[drv api] halMemAlloc failed: "
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
            DRV_MALLOC_ERROR_PROCESS(drvRet, moduleId, "[drv api] halMemAlloc failed: "
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
            DRV_MALLOC_ERROR_PROCESS(drvRet, moduleId, "[drv api] halMemAlloc failed:size=%" PRIu64
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
            DRV_MALLOC_ERROR_PROCESS(drvRet, moduleId, "[drv api] halMemAlloc failed:size=%" PRIu64
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
            DRV_MALLOC_ERROR_PROCESS(drvRet, moduleId, "[drv api] halMemAlloc failed:size=%" PRIu64
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
        DRV_MALLOC_ERROR_PROCESS(drvRet, moduleId, "[drv api] halMemAlloc failed: "
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
        DRV_MALLOC_ERROR_PROCESS(drvRet, moduleId, "[drv api] halMemAlloc failed: "
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

    COND_RETURN_ERROR_MSG_INNER(!IsOfflineSupportMemType(type), RT_ERROR_FEATURE_NOT_SUPPORT,
        "Offline mode does not support memType=%d", static_cast<int>(type));
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
            DRV_MALLOC_ERROR_PROCESS(drvRet, moduleId, "[drv api] halMemAlloc failed: "
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
    rtError_t temptRet = RT_ERROR_DRV_ERR;
    const uint32_t devRunMode = GetRunMode();
    constexpr uint32_t p2PTypeSet = RT_MEMORY_POLICY_HUGE_PAGE_FIRST_P2P |
        RT_MEMORY_POLICY_HUGE_PAGE_ONLY_P2P | RT_MEMORY_POLICY_DEFAULT_PAGE_ONLY_P2P;

    RT_LOG(RT_LOG_DEBUG, "device_id=%d, type=%u, size=%" PRIu64 ", mode=%u.", deviceId, type, size, devRunMode);
    if (devRunMode == static_cast<uint32_t>(RT_RUN_MODE_ONLINE)) {
        temptRet = DevMemAllocOnline(dptr, size, type, deviceId, moduleId, isLogError, readOnlyFlag, starsTillingFlag,
            isNewApi, cpOnlyFlag);
    } else if ((devRunMode == static_cast<uint32_t>(RT_RUN_MODE_OFFLINE)) && ((type & p2PTypeSet) != 0U)) {
        RT_LOG_OUTER_MSG_WITH_FUNC(ErrorCode::EE1006, "P2P memory type at OFFLINE mode");
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
        DRV_MALLOC_ERROR_PROCESS(drvRet, moduleId, "[drv api] dvpp halMemAlloc failed: "
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

rtError_t NpuDriver::DevMemAllocForPctrace(void ** const dptr, const uint64_t size, const uint32_t deviceId)
{
    TIMESTAMP_NAME(__func__);
    if (GetRunMode() == static_cast<uint32_t>(RT_RUN_MODE_ONLINE)) {
        RT_LOG_OUTER_MSG_WITH_FUNC(ErrorCode::EE1006, "online mode");
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }

    drvError_t drvRet = halMemAlloc(dptr, static_cast<UINT64>(size), 
        static_cast<UINT64>(GetDevProperties().memAllocPctraceFlag) |
        static_cast<UINT64>(MEM_SET_ALIGN_SIZE(9ULL)) |
        static_cast<UINT64>(MEM_ADVISE_TS) | static_cast<UINT64>(NODE_TO_DEVICE(deviceId)));        
    if (drvRet != DRV_ERROR_NONE) {
        DRV_MALLOC_ERROR_PROCESS(drvRet, RUNTIME_MODULE_ID, "[drv api] halMemAlloc for pctrace failed: size=%" PRIu64 "(bytes), drvRetCode=%d,"
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
            DRV_MALLOC_ERROR_PROCESS(drvRet, moduleId, "[drv api] halMemAlloc cached failed: "
                "device_id=%u, size=%" PRIu64 "(bytes), drvRetCode=%d, drvFlag=%" PRIu64 ", %s",
                deviceId, size, static_cast<int32_t>(drvRet), drvFlag, errorStr.c_str());
            return rtErrorCode;
        }
    }

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

/* ========================================================
 * Subcategory: Get Memory Info
 * ======================================================== */

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

/* ========================================================
 * Subcategory: Memory Copy
 * ======================================================== */

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
    NULL_PTR_RETURN_MSG_OUTER(src, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(dst, RT_ERROR_INVALID_VALUE);
    if (kind >= RT_MEMCPY_RESERVED) {
        RT_LOG_OUTER_MSG_INVALID_PARAM(
            kind, "[" + std::to_string(RT_MEMCPY_HOST_TO_HOST) + ", " + std::to_string(RT_MEMCPY_RESERVED) + ")");
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
    NULL_PTR_RETURN_MSG_OUTER(src, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(dst, RT_ERROR_INVALID_VALUE);
    if (kind >= RT_MEMCPY_RESERVED) {
        RT_LOG_OUTER_MSG_INVALID_PARAM(
            kind, "[" + std::to_string(RT_MEMCPY_HOST_TO_HOST) + ", " + std::to_string(RT_MEMCPY_RESERVED) + ")");
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

/* ========================================================
 * Subcategory: Memory Control based on halMemCtl
 * ======================================================== */

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

}  // namespace runtime
}  // namespace cce
