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
    UNUSED(type);
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

}  // namespace runtime
}  // namespace cce
