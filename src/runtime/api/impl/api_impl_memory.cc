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
#include <mutex>
#include <new>

#include "api_impl.hpp"
#include "base.hpp"
#include "capture_model_utils.hpp"
#include "context.hpp"
#include "dev_info_manage.h"
#include "device.hpp"
#include "driver/ascend_hal.h"
#include "enum_desc.hpp"
#include "error_message_manage.hpp"
#include "host_task.hpp"
#include "internal_error_define.hpp"
#include "memcpy_c.hpp"
#include "memory_c.hpp"
#include "npu_driver.hpp"
#include "register_memory.hpp"
#include "rt_inner_mem.h"
#include "runtime.hpp"
#include "stream.hpp"
#include "utils.h"

#define NULL_STREAM_PTR_RETURN_MSG(STREAM) NULL_PTR_RETURN_MSG((STREAM), RT_ERROR_STREAM_NULL)

namespace {
constexpr uint32_t MEM_POLICY_MASK = 0xFFU;
constexpr uint32_t MEM_TYPE_MASK = 0xFF00U;
constexpr char_t MALLOC_ATTR_MODULE_ID_EXPECT_DESC[] = "MEM_MALLOC_ATTR_MODULE_ID(1)";
} // namespace

namespace cce {
namespace runtime {

TIMESTAMP_EXTERN(MemCopy2D);

rtError_t ApiImpl::HostMalloc(void** const hostPtr, const uint64_t size, const uint16_t moduleId)
{
    RT_LOG(RT_LOG_INFO, "size=%" PRIu64, size);
    Context* const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    const uint64_t curSize = (((size + 0x1FU) >> 5U) << 5U); // 32 byte align

    return curCtx->Device_()->Driver_()->HostMemAlloc(hostPtr, curSize, curCtx->Device_()->Id_(), moduleId);
}

void ApiImpl::CheckMallocHostCfg(uint16_t* moduleId) const
{
    if (*moduleId > DEFAULT_MODULEID) {
        *moduleId = static_cast<uint16_t>(MODULEID_RUNTIME);
    }
    return;
}

rtError_t ApiImpl::GetMallocHostConfigAttr(rtMallocAttribute_t* attr, uint16_t* moduleId, uint32_t* vaFlag) const
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

rtError_t ApiImpl::GetMallocHostConfigInfo(const rtMallocConfig_t* cfg, uint16_t* moduleId, uint32_t* vaFlag) const
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

rtError_t ApiImpl::HostMallocWithCfg(void** const hostPtr, const uint64_t size, const rtMallocConfig_t* cfg)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(
        hostPtr, RT_ERROR_INVALID_VALUE, "Allocating host memory based on the configuration attributes");
    ZERO_RETURN_AND_MSG_OUTER_WITH_FUNC_DESC(size, "Allocating host memory based on the configuration attributes");
    uint16_t moduleId = static_cast<uint16_t>(MODULEID_RUNTIME);
    uint32_t vaFlag = 0U;
    rtError_t error = RT_ERROR_NONE;
    if (cfg != nullptr) {
        NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(
            cfg->attrs, RT_ERROR_INVALID_VALUE, "Allocating host memory based on the configuration attributes");
        error = GetMallocHostConfigInfo(cfg, &moduleId, &vaFlag);
        ERROR_RETURN(error, "Host memory malloc failed, size=%" PRIu64 "(bytes)", size);
    }

    Context* const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    // 32 byte align
    const uint64_t curSize = (((size + 0x1FU) >> 5U) << 5U);

    error = curCtx->Device_()->Driver_()->HostMemAlloc(hostPtr, curSize, curCtx->Device_()->Id_(), moduleId, vaFlag);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_DRV_NOT_SUPPORT, error);
    ERROR_RETURN(
        error, "Host memory malloc failed, size=%" PRIu64 "(bytes), moduleId=%hu, vaFlag=%u.", size, moduleId, vaFlag);
    RT_LOG(
        RT_LOG_INFO,
        "Host memory malloc succeed,size=%" PRIu64 "(bytes), moduleId=%hu, vaFlag=%u, host addr=%#" PRIx64 ".", size,
        moduleId, vaFlag, RtPtrToValue(*hostPtr));
    return error;
}

rtError_t ApiImpl::HostFree(void* const hostPtr)
{
    Context* const curCtx = CurrentContext();
    Driver* curDrv = nullptr;
    if (!ContextManage::CheckContextIsValid(curCtx)) {
        curDrv = Runtime::Instance()->driverFactory_.GetDriver(NPU_DRIVER);
    } else {
        curDrv = curCtx->Device_()->Driver_();
    }
    NULL_PTR_RETURN_MSG(curDrv, RT_ERROR_DRV_NULL);

#ifndef CFG_DEV_PLATFORM_PC
    rtPtrAttributes_t attributes;
    const rtError_t error = PtrGetAttributes(hostPtr, &attributes);
    const rtMemLocationType locationType = attributes.location.type;
    COND_RETURN_ERROR_MSG_INNER(
        error != RT_ERROR_NONE, RT_ERROR_INVALID_VALUE, "Get hostPtr pointer attributes failed, retCode=%#x",
        static_cast<uint32_t>(error));
    COND_RETURN_AND_MSG_OUTER(
        locationType != RT_MEMORY_LOC_HOST && locationType != RT_MEMORY_LOC_UNREGISTERED, RT_ERROR_INVALID_VALUE,
        ErrorCode::EE1011, "Host memory release", MemLocationTypeToString(locationType), "hostPtr locationType",
        "The specified address must be a host address");
#endif

    return curDrv->HostMemFree(hostPtr);
}

rtError_t ApiImpl::HostRegister(void* ptr, uint64_t size, rtHostRegisterType type, void** devPtr)
{
    RT_LOG(RT_LOG_INFO, "MemSize=%" PRIu64 "u, type=%d.", size, type);
    Context* const curCtx = CurrentContext();
    NULL_PTR_RETURN_MSG(curCtx, RT_ERROR_CONTEXT_NULL);
    const Device* const dev = curCtx->Device_();
    NULL_PTR_RETURN_MSG(dev, RT_ERROR_DEVICE_NULL);

    const rtError_t error =
        dev->Driver_()->HostRegister(ptr, size, static_cast<uint32_t>(type), devPtr, curCtx->Device_()->Id_());
    if ((!dev->IsSupportPinRegister()) && (error == RT_ERROR_NONE)) {
        (void)InsertMappedMemory(ptr, size, *devPtr);
    }

    return error;
}

rtError_t ApiImpl::HostRegisterV2(void* ptr, uint64_t size, uint32_t flag)
{
    RT_LOG(RT_LOG_INFO, "MemSize=%" PRIu64 ", flag=%u.", size, flag);
    Context* const curCtx = CurrentContext();
    NULL_PTR_RETURN_MSG(curCtx, RT_ERROR_CONTEXT_NULL);
    const Device* const dev = curCtx->Device_();
    NULL_PTR_RETURN_MSG(dev, RT_ERROR_DEVICE_NULL);
    const uint32_t deviceId = dev->Id_();

    rtError_t error = RT_ERROR_NONE;
    const bool supportDrvPinReg = dev->IsSupportPinRegister();

    void* devPtr = nullptr;
    void** devPtrAddr = &devPtr;

    if (supportDrvPinReg) {
        error = dev->Driver_()->HostRegister(ptr, size, flag, devPtrAddr, deviceId);
        COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
    } else {
        const bool isPinned = ((flag & RT_MEM_HOST_REGISTER_PINNED) != 0U);
        const bool isMapped =
            ((flag & (RT_MEM_HOST_REGISTER_MAPPED | RT_MEM_HOST_REGISTER_IOMEMORY | RT_MEM_HOST_REGISTER_READONLY)) !=
             0U);
        // Check range once driver not support pin register
        error = CheckMemoryRangeRegistered(ptr, size);
        COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
        if (isMapped) {
            // Only pass pin semantics only when driver supports pin
            flag &= ~RT_MEM_HOST_REGISTER_PINNED;
            error = dev->Driver_()->HostRegister(ptr, size, flag, devPtrAddr, deviceId);
            COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
            (void)InsertMappedMemory(ptr, size, devPtr);
        }
        if (isPinned) {
            (void)InsertPinnedMemory(ptr, size);
        }
    }
    return error;
}

rtError_t ApiImpl::HostUnregister(void* ptr)
{
    Context* const curCtx = CurrentContext();
    NULL_PTR_RETURN_MSG(curCtx, RT_ERROR_CONTEXT_NULL);
    const Device* const dev = curCtx->Device_();
    NULL_PTR_RETURN_MSG(dev, RT_ERROR_DEVICE_NULL);
    const uint32_t deviceId = dev->Id_();

    rtError_t error = RT_ERROR_NONE;
    const bool isMapped = IsMappedMemoryBase(ptr);
    const bool isPinned = IsPinnedMemoryBase(ptr);
    const bool supportDrvPinReg = dev->IsSupportPinRegister();
    if (supportDrvPinReg) {
        error = dev->Driver_()->HostUnregister(ptr, deviceId, supportDrvPinReg);
        COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
    } else {
        if (isMapped) {
            error = dev->Driver_()->HostUnregister(ptr, deviceId, supportDrvPinReg);
            COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
            EraseMappedMemory(ptr);
        }
        if (isPinned) {
            ErasePinnedMemory(ptr);
        }
        if ((!isMapped) && (!isPinned)) {
            RT_LOG(RT_LOG_INFO, "set to error RT_ERROR_HOST_MEMORY_NOT_REGISTERED because of not registered.");
            error = RT_ERROR_HOST_MEMORY_NOT_REGISTERED;
        }
    }

    return error;
}

rtError_t ApiImpl::HostGetDevicePointer(void* pHost, void** pDevice, uint32_t flag)
{
    (void)flag;
    Context* const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    const rtError_t ret = curCtx->Device_()->Driver_()->HostGetDevPointer(pHost, curCtx->Device_()->Id_(), pDevice);
    if (ret == RT_ERROR_FEATURE_NOT_SUPPORT) {
        *pDevice = GetMappedDevicePointer(pHost);
        COND_RETURN_AND_MSG_OUTER(
            *pDevice == nullptr, RT_ERROR_INVALID_VALUE, ErrorCode::EE1011,
            "Obtaining the on-device memory pointer based on the on-host virtual address",
            RtFmtMsg("%#" PRIx64, RtPtrToValue(pHost)), "pHost",
            "The host pointer has not been registered for device address mapping");
        return RT_ERROR_NONE;
    } else {
        COND_RETURN_AND_MSG_OUTER(
            ret == RT_ERROR_INVALID_VALUE, RT_ERROR_INVALID_VALUE, ErrorCode::EE1011,
            "Obtaining the on-device memory pointer based on the on-host virtual address",
            RtFmtMsg("%#" PRIx64, RtPtrToValue(pHost)), "pHost",
            "The host pointer has not been registered for device address mapping");
    }
    return ret;
}

rtError_t ApiImpl::HostMemMapCapabilities(uint32_t deviceId, rtHacType hacType, rtHostMemMapCapability* capabilities)
{
    Context* const curCtx = CurrentContext();
    NULL_PTR_RETURN_MSG(curCtx, RT_ERROR_CONTEXT_NULL);

    return curCtx->Device_()->Driver_()->HostMemMapCapabilities(deviceId, hacType, capabilities);
}

rtError_t ApiImpl::ManagedMemAlloc(void** const ptr, const uint64_t size, const uint32_t flag, const uint16_t moduleId)
{
    RT_LOG(RT_LOG_DEBUG, "managed memory alloc, size=%" PRIu64 ", flag=%u", size, flag);
    Context* const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    if ((flag == RT_MEMORY_SPM) && (size <= 512U)) { // 512:alloc size
        return curCtx->Device_()->AllocSPM(ptr, size);
    } else if (flag == RT_MEMORY_DDR_NC) {
        return curCtx->Device_()->Driver_()->MemAllocEx(ptr, size, RT_MEMORY_DDR_NC);
    } else if (flag == RT_MEMORY_ATTACH_GLOBAL) {
        const uint64_t alignSize = (((size + 0x1FFFFFUL) >> 21U) << 21U);
        return curCtx->Device_()->Driver_()->ManagedMemAlloc(
            ptr, alignSize, Driver::MANAGED_MEM_UVM, curCtx->Device_()->Id_(), moduleId);
    } else {
        return curCtx->Device_()->Driver_()->ManagedMemAlloc(
            ptr, size, Driver::MANAGED_MEM_RW, curCtx->Device_()->Id_(), moduleId);
    }
}

rtError_t ApiImpl::MemCopySyncEx(
    void* const dst, const uint64_t destMax, const void* const src, const uint64_t cnt, const rtMemcpyKind_t kind)
{
    RT_LOG(RT_LOG_DEBUG, "memcpy sync, cnt=%" PRIu64 ", kind=%s.", cnt, MemcpyKindToStr(kind));
    Context* const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    Device* device = curCtx->Device_();
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(device, RT_ERROR_INVALID_VALUE, "Synchronous memory copy");
    const rtError_t error = device->GetDeviceStatus();
    COND_PROC((error == RT_ERROR_DEVICE_TASK_ABORT), return error);
    CHECK_CAPTURE_MODE_SUPPORT_AND_RETURN_WITH_FUNC_DESC(curCtx, "Synchronous memory copy");

    Driver* driver = device->Driver_();
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(driver, RT_ERROR_INVALID_VALUE, "Synchronous memory copy");
    rtMemcpyKind_t curKind = kind;
    if (device->IsSPM(dst)) {
        curKind = (driver->GetRunMode() == static_cast<uint32_t>(RT_RUN_MODE_ONLINE)) ? RT_MEMCPY_HOST_TO_DEVICE :
                                                                                        RT_MEMCPY_DEVICE_TO_DEVICE;
    }

    const rtChipType_t chipType = Runtime::Instance()->GetChipType();
    if (IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_MEM_MBUF_COPY)) {
        /* on cloudv2, mbuff memcpy */
        return driver->MemCopySync(dst, destMax, src, cnt, curKind, true, device->Id_());
    }
    return driver->MemCopySync(dst, destMax, src, cnt, curKind);
}

rtError_t ApiImpl::RtsMemcpyAsync(
    void* const dst, const uint64_t destMax, const void* const src, const uint64_t cnt, const rtMemcpyKind kind,
    rtMemcpyConfig_t* const config, Stream* const stm)
{
    UNUSED(dst);
    UNUSED(destMax);
    UNUSED(src);
    UNUSED(cnt);
    UNUSED(kind);
    UNUSED(config);
    UNUSED(stm);
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::RtsMemcpy(
    void* const dst, const uint64_t destMax, const void* const src, const uint64_t cnt, const rtMemcpyKind kind,
    rtMemcpyConfig_t* const config)
{
    UNUSED(dst);
    UNUSED(destMax);
    UNUSED(src);
    UNUSED(cnt);
    UNUSED(kind);
    UNUSED(config);
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::SetMemcpyDesc(
    rtMemcpyDesc_t desc, const void* const srcAddr, const void* const dstAddr, const size_t count,
    const rtMemcpyKind kind, rtMemcpyConfig_t* const config)
{
    UNUSED(kind);
    UNUSED(config);
    Context* const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    return curCtx->SetMemcpyDesc(desc, srcAddr, dstAddr, count);
}

rtError_t ApiImpl::MemcpyAsyncWithDesc(
    rtMemcpyDesc_t desc, Stream* stm, const rtMemcpyKind kind, rtMemcpyConfig_t* const config)
{
    UNUSED(desc);
    UNUSED(stm);
    UNUSED(kind);
    UNUSED(config);
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::MemcpyAsyncPtr(
    void* const memcpyAddrInfo, const uint64_t destMax, const uint64_t count, Stream* stm,
    const rtTaskCfgInfo_t* const cfgInfo, const bool isMemcpyDesc)
{
    RT_LOG(RT_LOG_DEBUG, "async memcpy, using ptr_mode = 1, stream=%p, count=%" PRIu64 ".", stm, count);
    Context* const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    if (stm == nullptr) {
        stm = curCtx->DefaultStream_();
        NULL_STREAM_PTR_RETURN_MSG(stm);
    }

    COND_RETURN_AND_MSG_INVALID_CONTEXT_STREAM_WITH_FUNC_DESC(
        stm, curCtx, RT_ERROR_STREAM_CONTEXT,
        "Performing asynchronous memory copy using the address description on the device");
    return MemcopyAsyncPtr(memcpyAddrInfo, destMax, count, stm, nullptr, cfgInfo, isMemcpyDesc);
}

rtError_t ApiImpl::CheckMemType(void** addrs, uint32_t size, uint32_t memType, uint32_t* checkResult, uint32_t reserve)
{
    UNUSED(reserve);
    RT_LOG(RT_LOG_INFO, "mem get info size=%u, type=%u.", size, memType);
    Runtime* runtime = Runtime::Instance();
    NULL_PTR_RETURN_MSG(runtime, RT_ERROR_INSTANCE_NULL);
    Context* const curCtx = runtime->CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    const uint32_t deviceId = curCtx->Device_()->Id_();
    return curCtx->Device_()->Driver_()->CheckMemType(addrs, size, memType, checkResult, deviceId);
}

rtError_t ApiImpl::GetMemUsageInfo(
    const uint32_t deviceId, rtMemUsageInfo_t* const memUsageInfo, const size_t inputNum, size_t* const outputNum)
{
    RT_LOG(RT_LOG_INFO, "get mem usage info: deviceId=%u, inputNum=%zu.", deviceId, inputNum);
    Context* const curCtx = CurrentContext(true, deviceId);
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    return curCtx->Device_()->Driver_()->GetMemUsageInfo(deviceId, memUsageInfo, inputNum, outputNum);
}

rtError_t ApiImpl::MemGetInfoEx(const rtMemInfoType_t memInfoType, size_t* const freeSize, size_t* const totalSize)
{
    RT_LOG(
        RT_LOG_DEBUG, "mem get info memInfoType=%s, free=%zu, total=%zu.", MemInfoTypeToString(memInfoType).c_str(),
        *freeSize, *totalSize);
    Context* const curCtx = CurrentContext();
    NULL_PTR_RETURN_MSG(curCtx, RT_ERROR_CONTEXT_NULL);

    return curCtx->Device_()->Driver_()->MemGetInfoEx(curCtx->Device_()->Id_(), memInfoType, freeSize, totalSize);
}

rtError_t ApiImpl::MemPrefetchToDevice(const void* const devPtr, const uint64_t len, const int32_t devId)
{
    RT_LOG(RT_LOG_DEBUG, "memory prefetch to device, len=%" PRIu64 ", devId=%d.", len, devId);
    Context* const curCtx = CurrentContext(true, devId);
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    return curCtx->Device_()->Driver_()->MemPrefetchToDevice(devPtr, len, devId);
}

rtError_t ApiImpl::MemCopy2DSync(
    void* const dst, const uint64_t dstPitch, const void* const src, const uint64_t srcPitch, const uint64_t width,
    const uint64_t height, const rtMemcpyKind_t kind, const rtMemcpyKind newKind)
{
    (void)newKind;
    RT_LOG(
        RT_LOG_DEBUG,
        "sync memcpy2d, dstPitch=%" PRIu64 ", srcPitch=%" PRIu64 ", width=%" PRIu64 ", height=%" PRIu64 ", kind=%s.",
        dstPitch, srcPitch, width, height, MemcpyKindToStr(kind));
    Context* const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    CHECK_CAPTURE_MODE_SUPPORT_AND_RETURN_WITH_FUNC_DESC(curCtx, "Synchronous 2D memory copy");

    TIMESTAMP_BEGIN(MemCopy2D);
    const rtError_t ret = curCtx->Device_()->Driver_()->MemCopy2D(
        dst, dstPitch, src, srcPitch, width, height, kind, static_cast<uint32_t>(DEVMM_MEMCPY2D_SYNC), 0UL, nullptr);
    TIMESTAMP_END(MemCopy2D);

    return ret;
}

rtError_t ApiImpl::MemCopy2DAsync(
    void* const dst, const uint64_t dstPitch, const void* const src, const uint64_t srcPitch, const uint64_t width,
    const uint64_t height, Stream* const stm, const rtMemcpyKind_t kind, const rtMemcpyKind newKind)
{
    (void)newKind;
    RT_LOG(
        RT_LOG_DEBUG,
        "sync memcpy2d, dstPitch=%" PRIu64 ", srcPitch=%" PRIu64 ", width=%" PRIu64 ", height=%" PRIu64 ", kind=%s.",
        dstPitch, srcPitch, width, height, MemcpyKindToStr(kind));
    rtError_t error = RT_ERROR_NONE;
    uint64_t remainSize = width * height;
    uint64_t realSize = 0UL;
    uint64_t fixedSize = 0UL;
    uint64_t srcoffset = 0UL;
    uint64_t dstoffset = 0UL;
    Context* const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    Stream* curStm = stm;
    if (curStm == nullptr) {
        curStm = curCtx->DefaultStream_();
        NULL_STREAM_PTR_RETURN_MSG(curStm);
    }
    COND_RETURN_AND_MSG_INVALID_CONTEXT_STREAM_WITH_FUNC_DESC(
        curStm, curCtx, RT_ERROR_STREAM_CONTEXT, "Asynchronous 2D memory copy");

    while (remainSize > 0UL) {
        if (kind == RT_MEMCPY_DEVICE_TO_DEVICE) {
            error = Memcpy2DAsync(
                (static_cast<char_t*>(dst)) + dstoffset, dstPitch, (static_cast<const char_t*>(src)) + srcoffset,
                srcPitch, width, height, kind, &realSize, curStm, fixedSize);
            dstoffset += dstPitch;
            srcoffset += srcPitch;
        } else {
            error = Memcpy2DAsync(dst, dstPitch, src, srcPitch, width, height, kind, &realSize, curStm, fixedSize);
        }
        if (error != RT_ERROR_NONE) {
            return error;
        }
        fixedSize += realSize;
        remainSize -= realSize;
    }
    return error;
}

rtError_t ApiImpl::MemcpyHostTask(
    void* const dst, const uint64_t destMax, const void* const src, const uint64_t cnt, const rtMemcpyKind_t kind,
    Stream* const stm)
{
    RT_LOG(RT_LOG_INFO, "memCopy for host task, kind=%s.", MemcpyKindToStr(kind));
    Context* const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    CHECK_CAPTURE_MODE_SUPPORT_AND_RETURN_WITH_FUNC_DESC(curCtx, "Delivering a memory copy task on the host");

    if (Runtime::Instance()->ChipIsHaveStars()) {
        return curCtx->Device_()->Driver_()->MemCopySync(dst, destMax, src, cnt, kind);
    }
    Stream* curStm = stm;
    if (curStm == nullptr) {
        curStm = curCtx->DefaultStream_();
        NULL_STREAM_PTR_RETURN_MSG(curStm);
    } else {
        if ((curStm->Flags() & RT_STREAM_FORBIDDEN_DEFAULT) != 0) {
            Stream* const onlineStream = curCtx->OnlineStream_();
            Stream* const defaultStream = curCtx->DefaultStream_();
            curStm = (onlineStream != nullptr) ? onlineStream : defaultStream;
            NULL_STREAM_PTR_RETURN_MSG(curStm);
        }
    }
    HostTaskMemCpy* hostTask = new (std::nothrow) HostTaskMemCpy(curCtx->Device_(), dst, destMax, src, cnt, kind);
    COND_RETURN_AND_MSG_OUTER(
        (hostTask == nullptr), RT_ERROR_INVALID_VALUE, ErrorCode::EE1013, sizeof(HostTaskMemCpy), "new");
    const rtError_t error = hostTask->AsyncCall();
    if (error != RT_ERROR_NONE) {
        DELETE_O(hostTask);
        ERROR_RETURN(error, "MemCpyAsync failed. error = %d", error);
    }
    curStm->InsertPendingList(static_cast<uint32_t>(RT_HOST_TASK_TYPE_MEMCPY), hostTask);
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::ReserveMemAddress(void** devPtr, size_t size, size_t alignment, void* devAddr, uint64_t flags)
{
    const rtError_t error = NpuDriver::ReserveMemAddress(devPtr, size, alignment, devAddr, flags);
    RT_LOG(
        RT_LOG_INFO, "device malloc Succ, size=%" PRIu64 ", start ptr=%p, end ptr=%p", size, *devPtr,
        RtPtrToPtr<void*>(RtPtrToPtr<uint8_t*>(*devPtr) + size));
    return error;
}

rtError_t ApiImpl::ReleaseMemAddress(void* devPtr)
{
    RT_LOG(RT_LOG_INFO, "device free mem=0x%llx", RtPtrToPtr<uint64_t*>(devPtr));
    const rtError_t error = NpuDriver::ReleaseMemAddress(devPtr);
    return error;
}

rtError_t ApiImpl::MallocPhysical(rtDrvMemHandle* handle, size_t size, rtDrvMemProp_t* prop, uint64_t flags)
{
    /* 输出参数handle在上下文中作为一个整体使用, 内部的devid不用进行转换 */
    RT_LOG(RT_LOG_INFO, "Start to MallocPhysical, size=%zu", size);
    return NpuDriver::MallocPhysical(handle, size, prop, flags);
}

rtError_t ApiImpl::FreePhysical(rtDrvMemHandle handle)
{
    RT_LOG(RT_LOG_INFO, "Start to FreePhysical");
    return NpuDriver::FreePhysical(handle);
}

rtError_t ApiImpl::MapMem(void* devPtr, size_t size, size_t offset, rtDrvMemHandle handle, uint64_t flags)
{
    const rtError_t error = NpuDriver::MapMem(devPtr, size, offset, handle, flags);
    ERROR_RETURN(error, "failed, size=%" PRIu64 ", ptr=%p.", size, devPtr);
    RT_LOG(
        RT_LOG_INFO, "device malloc Succ, size=%" PRIu64 ", start ptr=%p, end ptr=%p", size, devPtr,
        RtPtrToPtr<void*>(RtPtrToPtr<uint8_t*>(devPtr) + size));
    return error;
}

rtError_t ApiImpl::UnmapMem(void* devPtr)
{
    RT_LOG(RT_LOG_INFO, "device free mem=%p", devPtr);
    const rtError_t error = NpuDriver::UnmapMem(devPtr);
    ERROR_RETURN(error, "failed mem=%p", devPtr);
    return error;
}

rtError_t ApiImpl::MemSetAccess(void* virPtr, size_t size, rtMemAccessDesc* desc, size_t count)
{
    const rtError_t error = NpuDriver::MemSetAccess(virPtr, size, desc, count);
    COND_RETURN_WARN(
        error == RT_ERROR_FEATURE_NOT_SUPPORT, RT_ERROR_FEATURE_NOT_SUPPORT,
        "failed, ptr=0x%llx, size=%" PRIu64 ", count=%" PRIu64, RtPtrToValue(virPtr), size, count);
    ERROR_RETURN(error, "failed, ptr=0x%llx, size=%" PRIu64 ", count=%" PRIu64, RtPtrToValue(virPtr), size, count);
    return error;
}

rtError_t ApiImpl::MemGetAccess(void* virPtr, rtMemLocation* location, uint64_t* flags)
{
    const rtError_t error = NpuDriver::MemGetAccess(virPtr, location, flags);
    ERROR_RETURN(error, "failed, ptr=%p, location=%d, flags=%#" PRIu64 ".", virPtr, *location, *flags);
    return error;
}

rtError_t ApiImpl::ExportToShareableHandle(
    rtDrvMemHandle handle, rtDrvMemHandleType handleType, uint64_t flags, uint64_t* shareableHandle)
{
    uint64_t drvFlags = 0UL;
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

rtError_t ApiImpl::ExportToShareableHandleV2(
    rtDrvMemHandle handle, rtMemSharedHandleType handleType, uint64_t flags, void* shareableHandle)
{
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
            "This device does not support cross-server communication drv devId=%u localServerId=%" PRId64 "err:%#x",
            devId, localServerId, static_cast<uint32_t>(error));
    }
    uint64_t drvFlags = 0UL;
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

rtError_t ApiImpl::ImportFromShareableHandle(uint64_t shareableHandle, int32_t devId, rtDrvMemHandle* handle)
{
    /* 输出参数handle在上下文中作为一个整体使用, 内部的devid不用进行转换 */
    RT_LOG(RT_LOG_INFO, "Start to ImportFromShareableHandle, drv devId=%d", devId);
    COND_RETURN_ERROR(
        CheckCurCtxValid(devId) != RT_ERROR_NONE, RT_ERROR_CONTEXT_NULL, "Current Context is null, drv devId[%d].",
        devId);

    uint32_t peerPhyDeviceId = 0U;
    auto error = NpuDriver::GetPhyDevIdByMemShareHandle(shareableHandle, &peerPhyDeviceId);
    if (error == RT_ERROR_DRV_NOT_SUPPORT) {
        return NpuDriver::ImportFromShareableHandle(shareableHandle, devId, handle);
    }

    COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
    Context* const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    Device* const dev = curCtx->Device_();
    NULL_PTR_RETURN_MSG(dev, RT_ERROR_DEVICE_NULL);
    error = dev->EnableP2PWithOtherDevice(peerPhyDeviceId);
    COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
    return NpuDriver::ImportFromShareableHandle(shareableHandle, devId, handle);
}

rtError_t ApiImpl::ImportFromShareableHandleV2(
    const void* shareableHandle, rtMemSharedHandleType handleType, uint64_t flags, int32_t devId,
    rtDrvMemHandle* handle)
{
    UNUSED(flags);
    /* 输出参数handle在上下文中作为一个整体使用, 内部的devid不用进行转换 */
    rtError_t error = RT_ERROR_NONE;
    // handleType为fabric，获取localServerId
    int64_t localServerId = 0;
    if (handleType == RT_MEM_SHARE_HANDLE_TYPE_FABRIC) {
        error = NpuDriver::GetServerId(devId, &localServerId);
        COND_RETURN_ERROR_MSG_INNER(
            error != RT_ERROR_NONE, error,
            "This device does not support cross-server communication devId:%d ServerId:%" PRId64 " err:%#x", devId,
            localServerId, static_cast<uint32_t>(error));
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
        Context* const curCtx = CurrentContext();
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
    return NpuDriver::ImportFromShareableHandleV2(shareableHandle, handleType, devId, handle);
}

rtError_t ApiImpl::SetPidToShareableHandle(uint64_t shareableHandle, int32_t pid[], uint32_t pidNum)
{
    RT_LOG(RT_LOG_INFO, "Start to SetPidToShareableHandle");
    return NpuDriver::SetPidToShareableHandle(shareableHandle, pid, pidNum);
}

rtError_t ApiImpl::SetPidToShareableHandleV2(
    const void* shareableHandle, rtMemSharedHandleType handleType, int32_t pid[], uint32_t pidNum)
{
    rtError_t error = RT_ERROR_NONE;
    uint32_t serverId = 0U;
    uint64_t shareableHandleU64 = 0UL;
    error = NpuDriver::GetServerIdAndshareableHandle(handleType, shareableHandle, &serverId, &shareableHandleU64);
    COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
    error = NpuDriver::SetPidToShareableHandle(shareableHandleU64, pid, pidNum);
    RT_LOG(RT_LOG_DEBUG, "handleType = %s pidNum = %d.", MemSharedHandleTypeToString(handleType), pidNum);
    return error;
}

rtError_t ApiImpl::GetAllocationGranularity(
    rtDrvMemProp_t* prop, rtDrvMemGranularityOptions option, size_t* granularity)
{
    RT_LOG(RT_LOG_INFO, "Start to GetAllocationGranularity");
    return NpuDriver::GetAllocationGranularity(prop, option, granularity);
}

rtError_t ApiImpl::ParseMallocCfg(const rtMallocConfig_t* const cfg, rtConfigValue_t* cfgVal) const
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

rtError_t ApiImpl::DevMalloc(
    void** const devPtr, const uint64_t size, rtMallocPolicy policy, rtMallocAdvise advise,
    const rtMallocConfig_t* const cfg)
{
    Context* const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    rtMemType_t type = RT_MEMORY_DEFAULT;
    rtConfigValue_t cfgVal;
    cfgVal.moduleId = static_cast<uint16_t>(APP);
    cfgVal.deviceId = curCtx->Device_()->Id_();
    if (static_cast<uint32_t>(policy & MEM_TYPE_MASK) == RT_MEM_TYPE_LOW_BAND_WIDTH) {
        type = RT_MEMORY_DDR;
    } else if (static_cast<uint32_t>(policy & MEM_TYPE_MASK) == RT_MEM_TYPE_HIGH_BAND_WIDTH) {
        type = RT_MEMORY_HBM;
    } else {
        // default
    }

    if (static_cast<uint32_t>(
            static_cast<uint32_t>(policy) & static_cast<uint32_t>(RT_MEM_ACCESS_USER_SPACE_READONLY)) != 0U) {
        type |= RT_MEMORY_ATTRIBUTE_READONLY; // use for dvpp,  ddr | policy | readonly
    }
    policy = static_cast<rtMallocPolicy>(static_cast<uint32_t>(policy) & MEM_POLICY_MASK);
    if (policy == RT_MEM_MALLOC_HUGE_FIRST) {
        type |= RT_MEMORY_POLICY_HUGE_PAGE_FIRST;
    } else if (policy == RT_MEM_MALLOC_HUGE_ONLY) {
        type |= RT_MEMORY_POLICY_HUGE_PAGE_ONLY;
    } else if (policy == RT_MEM_MALLOC_NORMAL_ONLY) {
        type |= RT_MEMORY_POLICY_DEFAULT_PAGE_ONLY;
    } else if (policy == RT_MEM_MALLOC_HUGE_FIRST_P2P) {
        type |= RT_MEMORY_POLICY_HUGE_PAGE_FIRST_P2P;
    } else if (policy == RT_MEM_MALLOC_HUGE_ONLY_P2P) {
        type |= RT_MEMORY_POLICY_HUGE_PAGE_ONLY_P2P;
    } else if (policy == RT_MEM_MALLOC_NORMAL_ONLY_P2P) {
        type |= RT_MEMORY_POLICY_DEFAULT_PAGE_ONLY_P2P;
    } else if (policy == RT_MEM_MALLOC_HUGE1G_ONLY) {
        type |= RT_MEMORY_POLICY_HUGE1G_PAGE_ONLY;
    } else if (policy == RT_MEM_MALLOC_HUGE1G_ONLY_P2P) {
        type |= RT_MEMORY_POLICY_HUGE1G_PAGE_ONLY_P2P;
    } else {
        type = RT_MEMORY_DEFAULT;
    }
    rtError_t error = RT_ERROR_NONE;
    if (cfg == nullptr) {
        RT_LOG(RT_LOG_INFO, "cfg is nullptr use default cfg");
    } else {
        error = ParseMallocCfg(cfg, &cfgVal);
        COND_RETURN_ERROR_MSG_INNER(
            error != RT_ERROR_NONE, RT_ERROR_INVALID_VALUE, "Parse rtMallocConfig failed, error=%#x.",
            static_cast<uint32_t>(error));
    }
    Runtime* rtInstance = Runtime::Instance();
    uint32_t realDeviceId = cfgVal.deviceId;
    if (cfgVal.deviceId != curCtx->Device_()->Id_()) {
        error = rtInstance->ChgUserDevIdToDeviceId(cfgVal.deviceId, &realDeviceId);
        COND_RETURN_ERROR(
            error != RT_ERROR_NONE, RT_ERROR_INVALID_VALUE,
            "Failed to convert the user device ID %u to driver device ID.", cfgVal.deviceId);
        if (realDeviceId != curCtx->Device_()->Id_()) {
            RT_LOG(RT_LOG_ERROR, "invalid drv devId=%u, should be %u", realDeviceId, curCtx->Device_()->Id_());
            return RT_ERROR_INVALID_VALUE;
        }
    }

    cfgVal.moduleId = cfgVal.moduleId > DEFAULT_MODULEID ? static_cast<uint16_t>(APP) : cfgVal.moduleId;
    RT_LOG(RT_LOG_INFO, "size=%" PRIu64 ", advise=%u,type=%#x,moduleId=%hu.", size, advise, type, cfgVal.moduleId);
    const uint64_t tmpSize = (((size + 0x1FU) >> 5U) << 5U); // 32 byte align
    if (advise == RT_MEM_ADVISE_TS) {
        type |= RT_MEMORY_TS;                                // 申请TS内存 4G内;
    } else if (advise == RT_MEM_ADVISE_DVPP) {
        return curCtx->Device_()->Driver_()->DevDvppMemAlloc(devPtr, tmpSize, realDeviceId, type, cfgVal.moduleId);
    } else {
        // no operation
    }
    RT_LOG(RT_LOG_INFO, "type=%#x.", type);
    return (curCtx->Device_()->Driver_())
        ->DevMemAlloc(devPtr, tmpSize, type, realDeviceId, cfgVal.moduleId, true, false, false, true);
}

rtError_t ApiImpl::MemReserveAddress(
    void** virPtr, size_t size, rtMallocPolicy policy, void* expectAddr, rtMallocConfig_t* cfg)
{
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

rtError_t ApiImpl::MemMallocPhysical(rtMemHandle* handle, size_t size, rtMallocPolicy policy, rtMallocConfig_t* cfg)
{
    /* 输出参数handle在上下文中作为一个整体使用, 内部的devid不用进行转换 */
    RT_LOG(RT_LOG_INFO, "Start to malloc physical mem.");
    Context* const curCtx = CurrentContext();
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
        RT_LOG(RT_LOG_ERROR, "invalid policy %#llx", policy);
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

rtError_t ApiImpl::MemcpyBatch(
    void** dsts, void** srcs, size_t* sizes, size_t count, rtMemcpyBatchAttr* attrs, size_t* attrsIdxs, size_t numAttrs,
    size_t* failIdx)
{
    RT_LOG(RT_LOG_DEBUG, "Start to batch memcpy, count=%zd, numAttrs=%zd.", count, numAttrs);
    rtError_t error;
    size_t attrIdx = 0U;
    rtMemcpyBatchAttr memAttr = attrs[0];
    rtPtrAttributes_t dstAttr = {};
    rtPtrAttributes_t srcAttr = {};
    rtMemLocationType realDstLoc = RT_MEMORY_LOC_MAX;
    rtMemLocationType realSrcLoc = RT_MEMORY_LOC_MAX;
    for (size_t i = 0U; i < count; i++) {
        if (((attrIdx + 1U) < numAttrs) && (i >= attrsIdxs[attrIdx + 1U])) {
            attrIdx = attrIdx + 1U;
            memAttr = attrs[attrIdx];
        }
        error = CheckMemCpyAttr(dsts[i], srcs[i], memAttr, dstAttr, srcAttr);
        realDstLoc = (dstAttr.location.type == RT_MEMORY_LOC_UNREGISTERED) ? RT_MEMORY_LOC_HOST : dstAttr.location.type;
        realSrcLoc = (srcAttr.location.type == RT_MEMORY_LOC_UNREGISTERED) ? RT_MEMORY_LOC_HOST : srcAttr.location.type;
        ERROR_PROC_RETURN_MSG_INNER(
            error, SetFailIndex(failIdx, i), "Failed to verify %zuth memory pair attributes. retCode=%#x.", i,
            static_cast<uint32_t>(error));
        COND_PROC_RETURN_AND_MSG_OUTER(
            (realDstLoc == realSrcLoc), RT_ERROR_INVALID_VALUE, ErrorCode::EE1016, SetFailIndex(failIdx, i),
            "Batch synchronous memory copy",
            RtFmtMsg(
                "Only H2D and D2H copy directions are supported. The destination location type is %s,"
                " and the source location type is %s",
                MemLocationTypeToString(realDstLoc).c_str(), MemLocationTypeToString(realSrcLoc).c_str()));
    }
    return NpuDriver::MemcpyBatch(RtPtrToPtr<uint64_t*>(dsts), RtPtrToPtr<uint64_t*>(srcs), sizes, count);
}

rtError_t ApiImpl::CheckMemCpyAttr(
    const void* const dst, const void* const src, const rtMemcpyBatchAttr& memAttr, rtPtrAttributes_t& dstAttr,
    rtPtrAttributes_t& srcAttr)
{
    rtMemLocationType memType;
    rtError_t error = PtrGetAttributes(dst, &dstAttr);
    ERROR_RETURN(error, "get dst attribute failed, error=%#x", error);
    memType = (dstAttr.location.type == RT_MEMORY_LOC_UNREGISTERED) ? RT_MEMORY_LOC_HOST : dstAttr.location.type;
    const rtMemLocationType inputDstType =
        (memAttr.dstLoc.type == RT_MEMORY_LOC_HOST_NUMA) ? RT_MEMORY_LOC_HOST : memAttr.dstLoc.type;
    COND_RETURN_AND_MSG_OUTER(
        ((memType != inputDstType) ||
         ((memType == RT_MEMORY_LOC_DEVICE) && (dstAttr.location.id != memAttr.dstLoc.id))),
        RT_ERROR_INVALID_VALUE, ErrorCode::EE1017, "Checking memory copy attributes", "dst",
        RtFmtMsg(
            "The input memory type %s and the actual memory type %s do not match,"
            " or the input device ID (device_id=%d) and the actual device ID (device_id=%d) do not match",
            MemLocationTypeToString(memAttr.dstLoc.type).c_str(),
            MemLocationTypeToString(dstAttr.location.type).c_str(), memAttr.dstLoc.id, dstAttr.location.id));

    error = PtrGetAttributes(src, &srcAttr);
    ERROR_RETURN(error, "get src attribute failed, error=%#x.", error);
    memType = (srcAttr.location.type == RT_MEMORY_LOC_UNREGISTERED) ? RT_MEMORY_LOC_HOST : srcAttr.location.type;
    const rtMemLocationType inputSrcType =
        (memAttr.srcLoc.type == RT_MEMORY_LOC_HOST_NUMA) ? RT_MEMORY_LOC_HOST : memAttr.srcLoc.type;
    COND_RETURN_AND_MSG_OUTER(
        ((memType != inputSrcType) ||
         ((memType == RT_MEMORY_LOC_DEVICE) && (srcAttr.location.id != memAttr.srcLoc.id))),
        RT_ERROR_INVALID_VALUE, ErrorCode::EE1017, "Checking memory copy attributes", "src",
        RtFmtMsg(
            "The input memory type %s and the actual memory type %s do not match,"
            " or the input device ID (device_id=%d) and the actual device ID (device_id=%d) do not match",
            MemLocationTypeToString(memAttr.srcLoc.type).c_str(),
            MemLocationTypeToString(srcAttr.location.type).c_str(), memAttr.srcLoc.id, srcAttr.location.id));

    return RT_ERROR_NONE;
}

rtError_t ApiImpl::ValidateMemCpyParamsAndAttributes(
    void* dst, size_t destMax, void* src, size_t size, const rtMemcpyBatchAttr& memAttr, rtPtrAttributes_t& dstAttr,
    rtPtrAttributes_t& srcAttr)
{
    rtError_t error = RT_ERROR_NONE;
    rtMemLocationType realDstLoc = RT_MEMORY_LOC_MAX;
    rtMemLocationType realSrcLoc = RT_MEMORY_LOC_MAX;

    COND_RETURN_AND_MSG_OUTER(
        (size > destMax) || (size == 0U), RT_ERROR_INVALID_VALUE, ErrorCode::EE1017, "Checking memory copy params",
        "size",
        RtFmtMsg(
            "Parameter size %zu should be greater than 0 and less than or equal to parameter destMax %zu", size,
            destMax));
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(src, RT_ERROR_INVALID_VALUE, "Checking memory copy params");
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(dst, RT_ERROR_INVALID_VALUE, "Checking memory copy params");

    error = CheckMemCpyAttr(dst, src, memAttr, dstAttr, srcAttr);
    realDstLoc = (dstAttr.location.type == RT_MEMORY_LOC_UNREGISTERED) ? RT_MEMORY_LOC_HOST : dstAttr.location.type;
    realSrcLoc = (srcAttr.location.type == RT_MEMORY_LOC_UNREGISTERED) ? RT_MEMORY_LOC_HOST : srcAttr.location.type;
    COND_RETURN_ERROR_MSG_INNER(
        error != RT_ERROR_NONE, error,
        "check attributes failed, attributes of src locationType=%s, dst locationType=%s, "
        "actually dst locationType=%s, src locationType=%s.",
        MemLocationTypeToString(memAttr.srcLoc.type).c_str(), MemLocationTypeToString(memAttr.dstLoc.type).c_str(),
        MemLocationTypeToString(realDstLoc).c_str(), MemLocationTypeToString(realSrcLoc).c_str());

    COND_RETURN_AND_MSG_OUTER(
        (realDstLoc == realSrcLoc), RT_ERROR_INVALID_VALUE, ErrorCode::EE1016, "Checking memory copy params",
        RtFmtMsg(
            "Only H2D and D2H copy directions are supported. The destination location type is %s,"
            " and the source location type is %s",
            MemLocationTypeToString(realDstLoc).c_str(), MemLocationTypeToString(realSrcLoc).c_str()));
    return error;
}

rtError_t ApiImpl::ValidateAndCheckMemCpyBatchAsync(
    void* dst, size_t destMax, void* src, size_t size, const rtMemcpyBatchAttr& memAttr, rtPtrAttributes_t& dstAttr,
    rtPtrAttributes_t& srcAttr, rtMemcpyKind_t& kind)
{
    rtError_t error = RT_ERROR_NONE;
    error = ValidateMemCpyParamsAndAttributes(dst, destMax, src, size, memAttr, dstAttr, srcAttr);
    if (error != RT_ERROR_NONE) {
        return error;
    }

    if (dstAttr.location.type == RT_MEMORY_LOC_DEVICE) {
        kind = RT_MEMCPY_HOST_TO_DEVICE;
    } else {
        kind = RT_MEMCPY_DEVICE_TO_HOST;
    }

    return error;
}

rtError_t ApiImpl::LoopMemcpyAsync(
    void** const dsts, const size_t* const destMaxs, void** const srcs, const size_t* const sizes, const size_t count,
    const rtMemcpyBatchAttr* const attrs, const size_t* const attrsIdxs, const size_t numAttrs, size_t* const failIdx,
    Stream* const stm)
{
    rtError_t error = RT_ERROR_NONE;
    rtMemcpyBatchAttr memAttr = attrs[0];
    size_t attrIdx = 0U;
    rtPtrAttributes_t dstAttr = {};
    rtPtrAttributes_t srcAttr = {};
    rtMemcpyKind_t kind;

    for (size_t i = 0U; i < count; i++) {
        if (((attrIdx + 1U) < numAttrs) && (i >= attrsIdxs[attrIdx + 1U])) {
            attrIdx = attrIdx + 1U;
            memAttr = attrs[attrIdx];
        }

        error =
            ValidateAndCheckMemCpyBatchAsync(dsts[i], destMaxs[i], srcs[i], sizes[i], memAttr, dstAttr, srcAttr, kind);
        if (error != RT_ERROR_NONE) {
            SetFailIndex(failIdx, i);
            return error;
        }

        if (dstAttr.location.type == RT_MEMORY_LOC_UNREGISTERED ||
            srcAttr.location.type == RT_MEMORY_LOC_UNREGISTERED) {
            Context* const curCtx = CurrentContext();
            CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

            Stream* curStm = stm;
            curStm = (curStm == nullptr) ? curCtx->DefaultStream_() : curStm;
            NULL_STREAM_PTR_RETURN_MSG(curStm);

            error = StreamSynchronize(curStm, -1); // timeout 设置为默认值
            ERROR_RETURN_MSG_INNER(
                error, "Failed to synchronize stream for unregistered memory copy, stream_id=%d, retCode=%#x.",
                curStm->Id_(), static_cast<uint32_t>(error));
            RT_LOG(RT_LOG_DEBUG, "Stream Synchronize success, stream_id=%d.", curStm->Id_());

            error = MemCopySync(dsts[i], destMaxs[i], srcs[i], sizes[i], kind);
        } else {
            error = MemcpyAsync(dsts[i], destMaxs[i], srcs[i], sizes[i], kind, stm, nullptr, nullptr, false, nullptr);
        }

        COND_RETURN_AND_MSG_INNER(
            (error != RT_ERROR_NONE) && (error != RT_ERROR_DRV_NOT_SUPPORT), error,
            "Failed to copy memory asynchronously, count=%zu, kind=%s, retCode=%#x.", sizes[i], MemcpyKindToStr(kind),
            static_cast<uint32_t>(error));
    }

    return error;
}

rtError_t ApiImpl::MemcpyBatchAsync(
    void** const dsts, const size_t* const destMaxs, void** const srcs, const size_t* const sizes, const size_t count,
    const rtMemcpyBatchAttr* const attrs, const size_t* const attrsIdxs, const size_t numAttrs, size_t* const failIdx,
    Stream* const stm)
{
    Context* curCtx = Runtime::Instance()->CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    NULL_PTR_RETURN_MSG(curCtx->Device_(), RT_ERROR_DEVICE_NULL);

    if (!NpuDriver::CheckIsSupportFeature(curCtx->Device_()->Id_(), FEATURE_MEMCPY_BATCH_ASYNC)) {
        return LoopMemcpyAsync(dsts, destMaxs, srcs, sizes, count, attrs, attrsIdxs, numAttrs, failIdx, stm);
    }
    return RT_ERROR_DRV_NOT_SUPPORT;
}

rtError_t ApiImpl::MemWaitValue(const void* const devAddr, const uint64_t value, const uint32_t flag, Stream* const stm)
{
    Context* const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    Stream* curStm = stm;
    if (curStm == nullptr) {
        curStm = curCtx->DefaultStream_();
        NULL_STREAM_PTR_RETURN_MSG(curStm);
    }

    COND_RETURN_AND_MSG_INVALID_CONTEXT_STREAM_WITH_FUNC_DESC(
        curStm, curCtx, RT_ERROR_STREAM_CONTEXT,
        "Unblocking the data in the specified memory when the data meets certain conditions");

    return cce::runtime::MemWaitValue(devAddr, value, flag, curStm);
}

rtError_t ApiImpl::MemRetainAllocationHandle(void* virPtr, rtDrvMemHandle* handle)
{
    const rtError_t error = NpuDriver::MemRetainAllocationHandle(virPtr, handle);
    ERROR_RETURN(error, "Failed to obtain the handle from virtual pointer, ptr=%p, handle=%p.", virPtr, handle);
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::MemGetAllocationPropertiesFromHandle(rtDrvMemHandle handle, rtDrvMemProp_t* prop)
{
    RT_LOG(RT_LOG_INFO, "Start to MemGetAllocationPropertiesFromHandle");
    return NpuDriver::MemGetAllocationPropertiesFromHandle(handle, prop);
}

rtError_t ApiImpl::MemGetAddressRange(void* ptr, void** pbase, size_t* psize)
{
    RT_LOG(RT_LOG_INFO, "Start to MemGetAddressRange");
    rtError_t error = NpuDriver::MemGetAddressRange(ptr, pbase, psize);
    ERROR_RETURN(error, "Call MemGetAddressRange failed, ptr=%p", ptr);
    return error;
}

rtError_t ApiImpl::MemMapSelectedLink(void* virPtrDst, size_t size, void* virPtrSrc, uint32_t linkIdx)
{
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
        error = MemGetAddressRange(virPtrOld, &base, &baseSize);
        ERROR_RETURN(error, "Call MemGetAddressRange failed, virPtrOld=%p", virPtrOld);
        COND_RETURN_ERROR(
            virPtrOld != base, RT_ERROR_INVALID_VALUE,
            "The address virPtrOld is not the starting address of its corresponding memory block. virPtrOld=%p, "
            "base=%p",
            virPtrOld, base);
        error = MemRetainAllocationHandle(base, &handle);
        ERROR_RETURN(error, "Failed to obtain the handle from virtual pointer, ptr=%p, handle=%p.", base, handle);
        COND_RETURN_ERROR(
            handle == nullptr, RT_ERROR_INVALID_VALUE, "virPtrSrc cannot get handle, virPtrSrc=%p", virPtrSrc);

        rtHandleAttr attrOrg;
        rtHandleAttr attrNew;
        error = NpuDriver::MemHandleGetAttribute(handle, HANDLE_ATTR_MEM_MAP_ROUTE, &attrOrg);
        COND_PROC_RETURN_ERROR(
            error != RT_ERROR_NONE, error, (void)FreePhysical(handle),
            "Call MemHandleGetAttribute failed, handle=%p, type=HANDLE_ATTR_MEM_MAP_ROUTE(%d).", handle,
            HANDLE_ATTR_MEM_MAP_ROUTE);
        attrNew.memMapRoute = linkIdx;
        error = NpuDriver::MemHandleSetAttribute(handle, HANDLE_ATTR_MEM_MAP_ROUTE, attrNew);
        COND_PROC_RETURN_ERROR(
            error != RT_ERROR_NONE, error, (void)FreePhysical(handle),
            "Call MemHandleSetAttribute failed, handle=%p, type=HANDLE_ATTR_MEM_MAP_ROUTE(%d), linkIdx=%u, "
            "attrNew.memMapRoute=%u.",
            handle, HANDLE_ATTR_MEM_MAP_ROUTE, linkIdx, attrNew.memMapRoute);
        error = MapMem(virPtrNew, baseSize, 0, handle, 0);
        COND_PROC_RETURN_ERROR(
            error != RT_ERROR_NONE, error, (void)FreePhysical(handle),
            "Call MapMem failed, baseSize=%" PRIu64 ", ptr=%p.", baseSize, virPtrNew);
        error = NpuDriver::MemHandleSetAttribute(handle, HANDLE_ATTR_MEM_MAP_ROUTE, attrOrg);
        COND_PROC_RETURN_ERROR(
            error != RT_ERROR_NONE, error, (void)FreePhysical(handle),
            "Call MemHandleGetAttribute failed, handle=%p, type=HANDLE_ATTR_MEM_MAP_ROUTE(%d).", handle,
            HANDLE_ATTR_MEM_MAP_ROUTE);

        error = FreePhysical(handle);
        ERROR_RETURN(error, "Call FreePhysical failed, handle=%p.", handle);
        virPtrOld = (uint8_t*)virPtrOld + baseSize;
        virPtrNew = (uint8_t*)virPtrNew + baseSize;
        totalSize += baseSize;
    }
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::MemMapSetLink(rtDrvMemHandle handle, rtMemLinkType adviceLink)
{
    Runtime* rt = Runtime::Instance();
    std::unique_lock<std::mutex> lock(rt->GetMemMapSelectedLinkMutex_());

    rtHandleAttr attr;
    attr.memMapRoute = static_cast<uint32_t>(adviceLink);
    return NpuDriver::MemHandleSetAttribute(handle, HANDLE_ATTR_MEM_MAP_ROUTE, attr);
}

} // namespace runtime
} // namespace cce
