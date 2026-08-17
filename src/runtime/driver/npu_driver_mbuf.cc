/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "npu_driver.hpp"
#include "driver/ascend_hal.h"
#include "driver/ascend_inpackage_hal.h"
#include "errcode_manage.hpp"
#include "error_message_manage.hpp"
#include "rt_log.h"

namespace cce {
namespace runtime {

rtError_t NpuDriver::MbufInit(rtMemBuffCfg_t* const cfg)
{
    RT_LOG(RT_LOG_INFO, "init device mem buff.");

    COND_RETURN_WARN(&halBuffInit == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT, "[drv api] halBuffInit does not exist.");
    drvError_t drvRet;
    if (cfg != nullptr) {
        BuffCfg bufCfg = {};
        for (int32_t i = 0; i < RT_MEM_BUFF_MAX_CFG_NUM; ++i) {
            bufCfg.cfg[i].cfg_id = cfg->cfg[i].cfgId;
            bufCfg.cfg[i].total_size = cfg->cfg[i].totalSize;
            bufCfg.cfg[i].blk_size = cfg->cfg[i].blkSize;
            bufCfg.cfg[i].max_buf_size = cfg->cfg[i].maxBufSize;
            bufCfg.cfg[i].page_type = cfg->cfg[i].pageType;

            bufCfg.cfg[i].elasticEnable = cfg->cfg[i].elasticEnable;
            bufCfg.cfg[i].elasticRate = cfg->cfg[i].elasticRate;
            bufCfg.cfg[i].elasticRateMax = cfg->cfg[i].elasticRateMax;
            bufCfg.cfg[i].elasticHighLevel = cfg->cfg[i].elasticHighLevel;
            bufCfg.cfg[i].elasticLowLevel = cfg->cfg[i].elasticLowLevel;
        }
        drvRet = static_cast<drvError_t>(halBuffInit(&bufCfg));
    } else {
        drvRet = static_cast<drvError_t>(halBuffInit(nullptr));
    }

    COND_RETURN_WARN(drvRet == DRV_ERROR_REPEATED_INIT, RT_GET_DRV_ERRCODE(drvRet), "repeated init"); // special state
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "Call driver api halBuffInit failed, drvRetCode=%d.", static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MbufAlloc(rtMbufPtr_t* const mbufPtr, const uint64_t size)
{
    RT_LOG(RT_LOG_INFO, "alloc mbuf, size=%" PRIu64, size);
    COND_RETURN_WARN(&halMbufAlloc == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT, "[drv api] halMbufAlloc does not exist.");
    const drvError_t drvRet = static_cast<drvError_t>(halMbufAlloc(size, RtPtrToPtr<Mbuf**>(mbufPtr)));
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(
            drvRet, "Call driver api halMbufAlloc failed, drvRetCode=%d, size=%" PRIu64 "(bytes).",
            static_cast<int32_t>(drvRet), size);
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MbufAllocEx(
    rtMbufPtr_t* const mbufPtr, const uint64_t size, const uint64_t flag, const int32_t grpId)
{
    RT_LOG(RT_LOG_INFO, "alloc mbuf, size=%" PRIu64, size);
    if (flag == NORMAL_MEM) {
        COND_RETURN_WARN(
            &halMbufAlloc == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT, "[drv api] halMbufAlloc does not exist.");
        const drvError_t drvRet = static_cast<drvError_t>(halMbufAlloc(size, RtPtrToPtr<Mbuf**>(mbufPtr)));
        if (drvRet != DRV_ERROR_NONE) {
            DRV_ERROR_PROCESS(
                drvRet, "Call driver api halMbufAlloc failed, drvRetCode=%d, size=%" PRIu64 "(bytes).",
                static_cast<int32_t>(drvRet), size);
            return RT_GET_DRV_ERRCODE(drvRet);
        }
    } else if (flag == DVPP_MEM) {
        COND_RETURN_WARN(
            &halMbufAllocEx == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT, "[drv api] halMbufAlloc does not exist.");
        constexpr uint32_t align = 128U; // dvpp default 128-bit alignment
        const drvError_t drvRet = static_cast<drvError_t>(halMbufAllocEx(
            size, align, static_cast<unsigned long>(BUFF_SP_DVPP | BUFF_SP_HUGEPAGE_PRIOR), grpId,
            RtPtrToPtr<Mbuf**>(mbufPtr)));
        if (drvRet != DRV_ERROR_NONE) {
            DRV_ERROR_PROCESS(
                drvRet, "Call driver api halMbufAllocEx failed, drvRetCode=%d, size=%" PRIu64 "(bytes).",
                static_cast<int32_t>(drvRet), size);
            return RT_GET_DRV_ERRCODE(drvRet);
        }
    } else {
        RT_LOG_OUTER_MSG_INVALID_PARAM(flag, "[0, 1]");
        return RT_ERROR_INVALID_VALUE;
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MbufFree(rtMbufPtr_t const memBuf)
{
    RT_LOG(RT_LOG_INFO, "free mbuf");
    COND_RETURN_WARN(&halMbufFree == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT, "[drv api] halMbufFree does not exist.");
    const drvError_t drvRet = static_cast<drvError_t>(halMbufFree(RtPtrToPtr<Mbuf*>(memBuf)));
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "Call driver api halMbufFree failed, drvRetCode=%d.", static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MbufBuild(void* const buff, const uint64_t size, rtMbufPtr_t* mbufPtr)
{
    RT_LOG(RT_LOG_INFO, "use buff to alloc mbuf, size=%" PRIu64, size);
    COND_RETURN_WARN(&halMbufBuild == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT, "[drv api] halMbufBuild does not exist.");
    const drvError_t drvRet = static_cast<drvError_t>(halMbufBuild(buff, size, RtPtrToPtr<Mbuf**>(mbufPtr)));
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(
            drvRet, "Call driver api halMbufBuild failed, drvRetCode=%d, size=%" PRIu64 "(bytes).",
            static_cast<int32_t>(drvRet), size);
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MbufUnBuild(const rtMbufPtr_t mbufPtr, void** const buff, uint64_t* const size)
{
    RT_LOG(RT_LOG_INFO, "unBuild the head of mbufPtr, and free the head");
    COND_RETURN_WARN(
        &halMbufUnBuild == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT, "[drv api] halMbufUnBuild does not exist.");
    const drvError_t drvRet = static_cast<drvError_t>(halMbufUnBuild(RtPtrToPtr<Mbuf*>(mbufPtr), buff, size));
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(
            drvRet, "Call driver api halMbufUnBuild failed, drvRetCode=%d, size=%" PRIu64 "(bytes).",
            static_cast<int32_t>(drvRet), (*size));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MbufGet(const rtMbufPtr_t mbufPtr, void* const buff, const uint64_t size)
{
    RT_LOG(RT_LOG_INFO, "get mbufPtr");
    COND_RETURN_WARN(&halBuffGet == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT, "[drv api] halBuffGet does not exist.");
    const drvError_t drvRet = static_cast<drvError_t>(halBuffGet(RtPtrToPtr<Mbuf*>(mbufPtr), buff, size));
    if (drvRet != DRV_ERROR_NONE) {
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MbufPut(const rtMbufPtr_t mbufPtr, void* const buff)
{
    RT_LOG(RT_LOG_INFO, "put mbufPtr");
    COND_RETURN_WARN(&halBuffPut == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT, "[drv api] halBuffPut does not exist.");
    halBuffPut(RtPtrToPtr<Mbuf*>(mbufPtr), buff);

    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MbufSetDataLen(const rtMbufPtr_t mbufPtr, const uint64_t len)
{
    RT_LOG(RT_LOG_INFO, "set mbuf data len.");

    if (&halMbufSetDataLen == nullptr) {
        return RT_GET_DRV_ERRCODE(DRV_ERROR_NOT_SUPPORT);
    }
    const drvError_t drvRet = static_cast<drvError_t>(halMbufSetDataLen(RtPtrToPtr<Mbuf*>(mbufPtr), len));
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(
            drvRet, "Call driver api halMbufSetDataLen failed, drvRetCode=%d.", static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MbufGetDataLen(const rtMbufPtr_t mbufPtr, uint64_t* len)
{
    RT_LOG(RT_LOG_INFO, "get mbuf data len.");
    COND_RETURN_WARN(
        &halMbufGetDataLen == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT, "[drv api] halMbufGetDataLen does not exist.");
    const drvError_t drvRet = static_cast<drvError_t>(halMbufGetDataLen(RtPtrToPtr<Mbuf*>(mbufPtr), len));
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(
            drvRet, "Call driver api halMbufGetDataLen failed, drvRetCode=%d.", static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MbufGetBuffSize(const rtMbufPtr_t memBuf, uint64_t* const totalSize)
{
    RT_LOG(RT_LOG_INFO, "get size address from mbuf, device_id=0.");
    COND_RETURN_WARN(
        &halMbufGetBuffSize == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT, "[drv api] halMbufGetBuffSize does not exist.");
    const drvError_t drvRet = static_cast<drvError_t>(halMbufGetBuffSize(RtPtrToPtr<Mbuf*>(memBuf), totalSize));
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(
            drvRet, "Call driver api halMbufGetBuffSize failed, drvRetCode=%d, drvDevId=0.",
            static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MbufGetBuffAddr(const rtMbufPtr_t memBuf, void** const buf)
{
    RT_LOG(RT_LOG_INFO, "get buff address from mbuf, device_id=0.");
    COND_RETURN_WARN(
        &halMbufGetBuffAddr == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT, "[drv api] halMbufGetBuffAddr does not exist.");
    const drvError_t drvRet = static_cast<drvError_t>(halMbufGetBuffAddr(RtPtrToPtr<Mbuf*>(memBuf), buf));
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(
            drvRet, "Call driver api halMbufGetBuffAddr failed, drvRetCode=%d, drvDevId=0.",
            static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MbufGetPrivInfo(const rtMbufPtr_t memBuf, void** const priv, uint64_t* const size)
{
    RT_LOG(RT_LOG_INFO, "get private info from mbuf.");
    COND_RETURN_WARN(
        &halMbufGetPrivInfo == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT, "[drv api] halMbufGetPrivInfo does not exist.");
    uint32_t privSize = 0U;
    const drvError_t drvRet = static_cast<drvError_t>(halMbufGetPrivInfo(RtPtrToPtr<Mbuf*>(memBuf), priv, &privSize));
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(
            drvRet, "Call driver api halMbufGetPrivInfo failed, drvRetCode=%d.", static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    *size = privSize;
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MbufCopyBufRef(const rtMbufPtr_t mbufPtr, rtMbufPtr_t* const newMbufPtr)
{
    RT_LOG(RT_LOG_INFO, "copy buf ref.");
    COND_RETURN_WARN(
        &halMbufCopyRef == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT, "[drv api] halMbufCopyRef does not exist.");
    const drvError_t drvRet =
        static_cast<drvError_t>(halMbufCopyRef(RtPtrToPtr<Mbuf*>(mbufPtr), RtPtrToPtr<Mbuf**>(newMbufPtr)));
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(
            drvRet, "Call driver api halMbufCopyRef failed, drvRetCode=%d.", static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MbufChainAppend(const rtMbufPtr_t memBufChainHead, rtMbufPtr_t memBuf)
{
    RT_LOG(RT_LOG_INFO, "append mbuf chain.");
    COND_RETURN_WARN(
        &halMbufChainAppend == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT, "[drv api] halMbufChainAppend does not exist.");
    const drvError_t drvRet =
        static_cast<drvError_t>(halMbufChainAppend(RtPtrToPtr<Mbuf*>(memBufChainHead), RtPtrToPtr<Mbuf*>(memBuf)));
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(
            drvRet, "Call driver api halMbufChainAppend failed, drvRetCode=%d.", static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MbufChainGetMbuf(
    rtMbufPtr_t const memBufChainHead, const uint32_t index, rtMbufPtr_t* const memBuf)
{
    RT_LOG(RT_LOG_INFO, "get mbuf chain mbuf index is %u.", index);
    COND_RETURN_WARN(
        &halMbufChainGetMbuf == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT, "[drv api] halMbufChainGetMbuf does not exist.");
    const drvError_t drvRet = static_cast<drvError_t>(
        halMbufChainGetMbuf(RtPtrToPtr<Mbuf*>(memBufChainHead), index, RtPtrToPtr<Mbuf**>(memBuf)));
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(
            drvRet, "Call driver api halMbufChainGetMbuf failed, drvRetCode=%d.", static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MbufChainGetMbufNum(const rtMbufPtr_t memBufChainHead, uint32_t* num)
{
    RT_LOG(RT_LOG_INFO, "get mbuf chain num.");
    COND_RETURN_WARN(
        &halMbufChainGetMbufNum == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halMbufChainGetMbufNum does not exist.");
    const drvError_t drvRet = static_cast<drvError_t>(halMbufChainGetMbufNum(RtPtrToPtr<Mbuf*>(memBufChainHead), num));
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(
            drvRet, "Call driver api halMbufChainGetMbufNum failed, drvRetCode=%d.", static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

} // namespace runtime
} // namespace cce
