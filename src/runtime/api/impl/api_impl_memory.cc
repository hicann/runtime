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
#include "rt_inner_mem.h"
#include "runtime.hpp"
#include "stream.hpp"
#include "utils.h"

#define NULL_STREAM_PTR_RETURN_MSG(STREAM) NULL_PTR_RETURN_MSG((STREAM), RT_ERROR_STREAM_NULL)

namespace {
constexpr uint32_t MEM_POLICY_MASK = 0xFFU;
constexpr uint32_t MEM_TYPE_MASK = 0xFF00U;
} // namespace

namespace cce {
namespace runtime {

TIMESTAMP_EXTERN(MemCopy2D);

rtError_t ApiImpl::MemCopySyncEx(
    void* const dst, const uint64_t destMax, const void* const src, const uint64_t cnt, const rtMemcpyKind_t kind)
{
    RT_LOG(RT_LOG_DEBUG, "memcpy sync, cnt=%" PRIu64 ", kind=%s.", cnt, MemcpyKindToStr(kind));
    Context* const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    Device* device = curCtx->Device_();
    NULL_PTR_RETURN_MSG(device, RT_ERROR_INVALID_VALUE);
    const rtError_t error = device->GetDeviceStatus();
    COND_PROC((error == RT_ERROR_DEVICE_TASK_ABORT), return error);
    CHECK_CAPTURE_MODE_SUPPORT_AND_RETURN_WITH_FUNC_DESC(curCtx, "Synchronous memory copy");

    Driver* driver = device->Driver_();
    NULL_PTR_RETURN_MSG(driver, RT_ERROR_INVALID_VALUE);
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
    return cce::runtime::SetMemcpyDesc(desc, srcAddr, dstAddr, count, curCtx->Device_());
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
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

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
        COND_RETURN_ERROR(
            error != RT_ERROR_NONE, error, "Parse rtMallocConfig failed, error=%#x.", static_cast<uint32_t>(error));
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
    DevMemAllocConfig allocConfig = {};
    return (curCtx->Device_()->Driver_())
        ->DevMemAlloc(devPtr, tmpSize, type, realDeviceId, cfgVal.moduleId, true, allocConfig, true);
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

} // namespace runtime
} // namespace cce
