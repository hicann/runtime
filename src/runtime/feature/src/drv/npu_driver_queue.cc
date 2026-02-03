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
#include "driver/ascend_inpackage_hal.h"
#include "errcode_manage.hpp"
#include "error_message_manage.hpp"

namespace {
    constexpr int32_t MEMQ_EVENT_CROSS_DEV_VERSION = 0x72316; // MAJOR:0x07, MINOR:0x23, PATCH:0x16
    constexpr uint32_t MEM_QUEUE_SUPPORT_VERSION = 0x06U;
    constexpr uint32_t MAJOR_VERSION_OFFSET = 16U;
    constexpr uint32_t MAJOR_VERSION_MASK = 0x00FF0000U;
    constexpr int32_t EVENT_SYNC_TIMEOUT = -1;
    constexpr uint32_t MAX_BUF_CNT = 128U;
    uint32_t g_maxBufCnt = MAX_BUF_CNT;
}

/******************************************************************************
 * Core Category: Queue related
 ******************************************************************************/

namespace cce {
namespace runtime {

/* ========================================================
 * Subcategory: Normal Buf
 * ======================================================== */

rtError_t NpuDriver::BuffAlloc(const uint64_t size, void **buff)
{
    RT_LOG(RT_LOG_INFO, "alloc buff, size=%" PRIu64, size);
    COND_RETURN_WARN(&halBuffAlloc == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halBuffAlloc does not exist.");
    const drvError_t drvRet = static_cast<drvError_t>(halBuffAlloc(size, buff));
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halBuffAlloc failed: size=%" PRIu64 "(bytes), drvRetCode=%d.", size,
            static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    return RT_ERROR_NONE;
}

rtError_t NpuDriver::BuffFree(void * const buff)
{
    RT_LOG(RT_LOG_INFO, "free buff");
    COND_RETURN_WARN(&halBuffFree == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halBuffFree does not exist.");
    const drvError_t drvRet = static_cast<drvError_t>(halBuffFree(buff));
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halBuffFree failed: drvRetCode=%d.", static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    return RT_ERROR_NONE;
}

rtError_t NpuDriver::BuffConfirm(void * const buff, const uint64_t size)
{
    RT_LOG(RT_LOG_INFO, "determine whether buff is shared memory");
    COND_RETURN_WARN(&halBuffGet == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halBuffGet does not exist.");
    const drvError_t drvRet = static_cast<drvError_t>(halBuffGet(nullptr, buff, size));
    if (drvRet != DRV_ERROR_NONE) {
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    COND_RETURN_WARN(&halBuffPut == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halBuffPut does not exist.");
    halBuffPut(nullptr, buff);

    return RT_ERROR_NONE;
}

rtError_t NpuDriver::BuffGetInfo(const rtBuffGetCmdType type, const void * const inBuff, const uint32_t inLen,
    void * const outBuff, uint32_t * const outLen)
{
    RT_LOG(RT_LOG_INFO, "buff get info, type=%d.", static_cast<int32_t>(type));

    COND_RETURN_WARN(&halBuffGetInfo == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halBuffGetInfo does not exist.");
    const BuffGetCmdType drvType = static_cast<BuffGetCmdType>(type);
    void * const drvInBuff = const_cast<void *>(inBuff);

    const drvError_t drvRet = static_cast<drvError_t>(halBuffGetInfo(drvType, drvInBuff, inLen, outBuff, outLen));
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halBuffGetInfo failed: type=%d.", static_cast<int32_t>(drvType));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    return RT_ERROR_NONE;
}

/* ========================================================
 * Subcategory: MBuf
 * ======================================================== */

rtError_t NpuDriver::MbufInit(rtMemBuffCfg_t * const cfg)
{
    RT_LOG(RT_LOG_INFO, "init device mem buff.");

    COND_RETURN_WARN(&halBuffInit == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halBuffInit does not exist.");
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
        DRV_ERROR_PROCESS(drvRet, "[drv api] halBuffInit failed: drvRetCode=%d.", static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MbufAlloc(rtMbufPtr_t * const mbufPtr, const uint64_t size)
{
    RT_LOG(RT_LOG_INFO, "alloc mbuf, size=%" PRIu64, size);
    COND_RETURN_WARN(&halMbufAlloc == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halMbufAlloc does not exist.");
    const drvError_t drvRet = static_cast<drvError_t>(halMbufAlloc(size, RtPtrToPtr<Mbuf **>(mbufPtr)));
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halMbufAlloc failed: size=%" PRIu64 "(bytes), drvRetCode=%d.", size,
            static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MbufAllocEx(rtMbufPtr_t * const mbufPtr, const uint64_t size,
    const uint64_t flag, const int32_t grpId)
{
    RT_LOG(RT_LOG_INFO, "alloc mbuf, size=%" PRIu64, size);
    if (flag == NORMAL_MEM) {
        COND_RETURN_WARN(&halMbufAlloc == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
            "[drv api] halMbufAlloc does not exist.");
        const drvError_t drvRet = static_cast<drvError_t>(halMbufAlloc(size, RtPtrToPtr<Mbuf **>(mbufPtr)));
        if (drvRet != DRV_ERROR_NONE) {
            DRV_ERROR_PROCESS(drvRet, "[drv api] halMbufAlloc failed: size=%" PRIu64 "(bytes), drvRetCode=%d.", size,
                static_cast<int32_t>(drvRet));
            return RT_GET_DRV_ERRCODE(drvRet);
        }
    } else if (flag == DVPP_MEM) {
        COND_RETURN_WARN(&halMbufAllocEx == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
            "[drv api] halMbufAlloc does not exist.");
        constexpr uint32_t align = 128U; // dvpp default 128-bit alignment
        const drvError_t drvRet = static_cast<drvError_t>(halMbufAllocEx(size, align,
            static_cast<unsigned long>(BUFF_SP_DVPP | BUFF_SP_HUGEPAGE_PRIOR), grpId,
            RtPtrToPtr<Mbuf **>(mbufPtr)));
        if (drvRet != DRV_ERROR_NONE) {
            DRV_ERROR_PROCESS(drvRet, "[drv api] halMbufAllocEx failed: size=%" PRIu64 "(bytes), drvRetCode=%d.",
                size, static_cast<int32_t>(drvRet));
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
    COND_RETURN_WARN(&halMbufFree == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halMbufFree does not exist.");
    const drvError_t drvRet = static_cast<drvError_t>(halMbufFree(RtPtrToPtr<Mbuf *>(memBuf)));
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halMbufFree failed: drvRetCode=%d.", static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MbufBuild(void * const buff, const uint64_t size, rtMbufPtr_t *mbufPtr)
{
    RT_LOG(RT_LOG_INFO, "use buff to alloc mbuf, size=%" PRIu64, size);
    COND_RETURN_WARN(&halMbufBuild == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halMbufBuild does not exist.");
    const drvError_t drvRet = static_cast<drvError_t>(halMbufBuild(buff, size, RtPtrToPtr<Mbuf **>(mbufPtr)));
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halMbufBuild failed: size=%" PRIu64 "(bytes), drvRetCode=%d.", size,
            static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MbufUnBuild(const rtMbufPtr_t mbufPtr, void ** const buff, uint64_t * const size)
{
    RT_LOG(RT_LOG_INFO, "unBuild the head of mbufPtr, and free the head");
    COND_RETURN_WARN(&halMbufUnBuild == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halMbufUnBuild does not exist.");
    const drvError_t drvRet = static_cast<drvError_t>(halMbufUnBuild(RtPtrToPtr<Mbuf *>(mbufPtr), buff, size));
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halMbufUnBuild failed: size=%" PRIu64 "(bytes), drvRetCode=%d.",
            (*size), static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MbufGet(const rtMbufPtr_t mbufPtr, void * const buff, const uint64_t size)
{
    RT_LOG(RT_LOG_INFO, "get mbufPtr");
    COND_RETURN_WARN(&halBuffGet == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halBuffGet does not exist.");
    const drvError_t drvRet = static_cast<drvError_t>(halBuffGet(RtPtrToPtr<Mbuf *>(mbufPtr), buff, size));
    if (drvRet != DRV_ERROR_NONE) {
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MbufPut(const rtMbufPtr_t mbufPtr, void * const buff)
{
    RT_LOG(RT_LOG_INFO, "put mbufPtr");
    COND_RETURN_WARN(&halBuffPut == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halBuffPut does not exist.");
    halBuffPut(RtPtrToPtr<Mbuf *>(mbufPtr), buff);

    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MbufSetDataLen(const rtMbufPtr_t mbufPtr, const uint64_t len)
{
    RT_LOG(RT_LOG_INFO, "set mbuf data len.");

    if (&halMbufSetDataLen == nullptr) {
        return RT_GET_DRV_ERRCODE(DRV_ERROR_NOT_SUPPORT);
    }
    const drvError_t drvRet = static_cast<drvError_t>(halMbufSetDataLen(RtPtrToPtr<Mbuf *>(mbufPtr), len));
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halMbufSetDataLen failed: drvRetCode=%d.", static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MbufGetDataLen(const rtMbufPtr_t mbufPtr, uint64_t *len)
{
    RT_LOG(RT_LOG_INFO, "get mbuf data len.");
    COND_RETURN_WARN(&halMbufGetDataLen == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halMbufGetDataLen does not exist.");
    const drvError_t drvRet = static_cast<drvError_t>(halMbufGetDataLen(RtPtrToPtr<Mbuf *>(mbufPtr), len));
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halMbufGetDataLen failed: drvRetCode=%d.", static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MbufGetBuffSize(const rtMbufPtr_t memBuf, uint64_t * const totalSize)
{
    RT_LOG(RT_LOG_INFO, "get size address from mbuf, device_id=0.");
    COND_RETURN_WARN(&halMbufGetBuffSize == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halMbufGetBuffSize does not exist.");
    const drvError_t drvRet = static_cast<drvError_t>(halMbufGetBuffSize(RtPtrToPtr<Mbuf *>(memBuf), totalSize));
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halMbufGetBuffSize failed: device_id=0, drvRetCode=%d.",
            static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MbufGetBuffAddr(const rtMbufPtr_t memBuf, void ** const buf)
{
    RT_LOG(RT_LOG_INFO, "get buff address from mbuf, device_id=0.");
    COND_RETURN_WARN(&halMbufGetBuffAddr == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halMbufGetBuffAddr does not exist.");
    const drvError_t drvRet = static_cast<drvError_t>(halMbufGetBuffAddr(RtPtrToPtr<Mbuf *>(memBuf), buf));
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halMbufGetBuffAddr failed: device_id=0, drvRetCode=%d.",
            static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MbufGetPrivInfo(const rtMbufPtr_t memBuf,  void ** const priv, uint64_t * const size)
{
    RT_LOG(RT_LOG_INFO, "get private info from mbuf.");
    COND_RETURN_WARN(&halMbufGetPrivInfo == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halMbufGetPrivInfo does not exist.");
    uint32_t privSize = 0U;
    const drvError_t drvRet = static_cast<drvError_t>(halMbufGetPrivInfo(RtPtrToPtr<Mbuf *>(memBuf), priv,
                                                                         &privSize));
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halMbufGetPrivInfo failed: drvRetCode=%d.", static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    *size = privSize;
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MbufCopyBufRef(const rtMbufPtr_t mbufPtr, rtMbufPtr_t * const newMbufPtr)
{
    RT_LOG(RT_LOG_INFO, "copy buf ref.");
    COND_RETURN_WARN(&halMbufCopyRef == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halMbufCopyRef does not exist.");
    const drvError_t drvRet = static_cast<drvError_t>(
        halMbufCopyRef(RtPtrToPtr<Mbuf *>(mbufPtr), RtPtrToPtr<Mbuf **>(newMbufPtr)));
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halMbufCopyRef failed: drvRetCode=%d.", static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MbufChainAppend(const rtMbufPtr_t memBufChainHead, rtMbufPtr_t memBuf)
{
    RT_LOG(RT_LOG_INFO, "append mbuf chain.");
    COND_RETURN_WARN(&halMbufChainAppend == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halMbufChainAppend does not exist.");
    const drvError_t drvRet = static_cast<drvError_t>(
        halMbufChainAppend(RtPtrToPtr<Mbuf *>(memBufChainHead), RtPtrToPtr<Mbuf *>(memBuf)));
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halMbufChainAppend failed: drvRetCode=%d.", static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MbufChainGetMbuf(rtMbufPtr_t const memBufChainHead, const uint32_t index,
    rtMbufPtr_t * const memBuf)
{
    RT_LOG(RT_LOG_INFO, "get mbuf chain mbuf index is %u.", index);
    COND_RETURN_WARN(&halMbufChainGetMbuf == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halMbufChainGetMbuf does not exist.");
    const drvError_t drvRet = static_cast<drvError_t>(
        halMbufChainGetMbuf(RtPtrToPtr<Mbuf *>(memBufChainHead), index, RtPtrToPtr<Mbuf **>(memBuf)));
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halMbufChainGetMbuf failed: drvRetCode=%d.", static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MbufChainGetMbufNum(const rtMbufPtr_t memBufChainHead, uint32_t *num)
{
    RT_LOG(RT_LOG_INFO, "get mbuf chain num.");
    COND_RETURN_WARN(&halMbufChainGetMbufNum == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halMbufChainGetMbufNum does not exist.");
    const drvError_t drvRet = static_cast<drvError_t>(
        halMbufChainGetMbufNum(RtPtrToPtr<Mbuf *>(memBufChainHead), num));
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halMbufChainGetMbufNum failed: drvRetCode=%d.",
            static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

/* ========================================================
 * Subcategory: Memory Group
 * ======================================================== */

rtError_t NpuDriver::MemGrpCreate(const char_t * const name, const rtMemGrpConfig_t * const cfg)
{
    RT_LOG(RT_LOG_INFO, "create mem group, deviceId=0.");

    COND_RETURN_WARN(&halGrpCreate == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halGrpCreate does not exist.");
    GroupCfg drvCfg = {};
    drvCfg.maxMemSize = cfg->maxMemSize;
    drvCfg.cacheAllocFlag = cfg->cacheAllocFlag;
    drvCfg.privMbufFlag = BUFF_ENABLE_PRIVATE_MBUF; // judge priv for compatibility after C85
    drvCfg.addGrpTimeout = cfg->addGrpTimeout;
    const drvError_t drvRet = static_cast<drvError_t>(halGrpCreate(name, &drvCfg));
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halGrpCreate failed: device_id=0, drvRetCode=%d.",
            static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MemGrpCacheAlloc(const char_t *const name, const int32_t devId,
    const rtMemGrpCacheAllocPara *const para)
{
    RT_LOG(RT_LOG_INFO, "group mem pre alloc, drv devId=%d, group=%s.", devId, name);

    COND_RETURN_WARN(&halGrpCacheAlloc == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halGrpCacheAlloc does not exist.");
    GrpCacheAllocPara drvPara = {};
    drvPara.memSize = para->memSize;
    drvPara.memFlag = para->memFlag;

    const drvError_t drvRet = static_cast<drvError_t>(halGrpCacheAlloc(name, static_cast<uint32_t>(devId), &drvPara));
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halGrpCacheAlloc failed: drv devId=%d, group=%s, drvRetCode=%d.",
            devId, name, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MemGrpAddProc(const char_t * const name, const int32_t pid,
                                   const rtMemGrpShareAttr_t * const attr)
{
    RT_LOG(RT_LOG_INFO, "add process for mem group, deviceId=0.");

    COND_RETURN_WARN(&halGrpAddProc == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halGrpAddProc does not exist.");
    GroupShareAttr drvAttr = {};
    drvAttr.admin = attr->admin;
    drvAttr.read = attr->read;
    drvAttr.write = attr->write;
    drvAttr.alloc = attr->alloc;
    const drvError_t drvRet = static_cast<drvError_t>(halGrpAddProc(name, pid, drvAttr));
    COND_RETURN_WARN(drvRet == DRV_ERROR_REPEATED_INIT, RT_GET_DRV_ERRCODE(drvRet), "repeated init"); // special state
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halGrpAddProc failed: device_id=0, drvRetCode=%d.",
            static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    return RT_ERROR_NONE;
}

static rtError_t MemGrpQueryGroupsOfProcess(const rtMemGrpQueryInput_t * const input,
    rtMemGrpQueryOutput_t * const output)
{
    GroupQueryInput drvInput;
    errno_t ret = memset_s(&drvInput, sizeof(drvInput), 0, sizeof(drvInput));
    COND_LOG_ERROR(ret != EOK, "memset_s failed, size=%zu(bytes), retCode=%d!", sizeof(drvInput), ret);
    drvInput.grpQueryGroupsOfProc.pid = input->grpQueryByProc.pid;
    const uint32_t drvInputLen = static_cast<uint32_t>(sizeof(drvInput));

    const std::unique_ptr<GroupQueryOutput> drvOutputUniquePtr(new (std::nothrow)(GroupQueryOutput));
    COND_RETURN_ERROR(drvOutputUniquePtr == nullptr, RT_ERROR_MEMORY_ALLOCATION, "malloc failed");
    GroupQueryOutput * const drvOutput = drvOutputUniquePtr.get();

    ret = memset_s(RtPtrToPtr<void *>(drvOutput), sizeof(GroupQueryOutput), 0, sizeof(GroupQueryOutput));
    COND_LOG_ERROR(ret != EOK, "memset_s failed, size=%zu(bytes), retCode=%d!", sizeof(GroupQueryOutput), ret);
    uint32_t drvOutputLen = static_cast<uint32_t>(sizeof(GroupQueryOutput));

    const drvError_t drvRet = static_cast<drvError_t>(halGrpQuery(GRP_QUERY_GROUPS_OF_PROCESS,
        &drvInput, drvInputLen, drvOutput, &drvOutputLen));
    COND_RETURN_ERROR(drvRet != DRV_ERROR_NONE, RT_GET_DRV_ERRCODE(drvRet),
        "[drv api] halQueueQuery failed: device_id=0, drvRetCode=%d.", static_cast<int32_t>(drvRet));

    // only GRP_QUERY_GROUPS_OF_PROCESS
    output->resultNum = (static_cast<size_t>(drvOutputLen)) / sizeof(GrpQueryGroupsOfProcInfo);
    if ((output->groupsOfProc == nullptr) || (output->maxNum == 0ULL)) {
        return RT_ERROR_NONE;
    }
    output->resultNum = (output->resultNum <= output->maxNum) ? output->resultNum : output->maxNum;
    if (output->resultNum > static_cast<size_t>(BUFF_GRP_MAX_NUM)) {
        output->resultNum = static_cast<size_t>(BUFF_GRP_MAX_NUM);
    }
    for (size_t i = 0U; i < output->resultNum; ++i) {
        output->groupsOfProc[i].attr.admin = drvOutput->grpQueryGroupsOfProcInfo[i].attr.admin;
        output->groupsOfProc[i].attr.read = drvOutput->grpQueryGroupsOfProcInfo[i].attr.read;
        output->groupsOfProc[i].attr.write = drvOutput->grpQueryGroupsOfProcInfo[i].attr.write;
        output->groupsOfProc[i].attr.alloc = drvOutput->grpQueryGroupsOfProcInfo[i].attr.alloc;

        ret = strcpy_s(output->groupsOfProc[i].groupName, sizeof(output->groupsOfProc[i].groupName),
            drvOutput->grpQueryGroupsOfProcInfo[i].groupName);
        COND_RETURN_ERROR(ret != EOK, RT_ERROR_SEC_HANDLE, "strcpy_s failed, retCode=%d!", ret);
    }
    return RT_ERROR_NONE;
}

static rtError_t MemGrpQueryGroupId(const rtMemGrpQueryInput_t * const input, rtMemGrpQueryOutput_t * const output)
{
    GroupQueryInput drvInput;
    errno_t ret = memset_s(&drvInput, sizeof(drvInput), 0, sizeof(drvInput));
    COND_LOG_ERROR(ret != EOK, "memset_s failed, size=%zu(bytes), retCode=%d!", sizeof(drvInput), ret);

    ret = strcpy_s(drvInput.grpQueryGroupId.grpName, sizeof(drvInput.grpQueryGroupId.grpName),
        input->grpQueryGroupId.grpName);
    COND_RETURN_ERROR(ret != EOK, RT_ERROR_SEC_HANDLE, "strcpy_s failed, retCode=%d!", ret);
    const uint32_t drvInputLen = static_cast<uint32_t>(sizeof(drvInput));

    const std::unique_ptr<GroupQueryOutput> drvOutputUniquePtr(new (std::nothrow)(GroupQueryOutput));
    COND_RETURN_ERROR(drvOutputUniquePtr == nullptr, RT_ERROR_MEMORY_ALLOCATION, "malloc failed");
    GroupQueryOutput * const drvOutput = drvOutputUniquePtr.get();

    ret = memset_s(RtPtrToPtr<void *>(drvOutput), sizeof(GroupQueryOutput), 0, sizeof(GroupQueryOutput));
    COND_LOG_ERROR(ret != EOK, "memset_s failed, size=%zu(bytes), retCode=%d!", sizeof(GroupQueryOutput), ret);
    uint32_t drvOutputLen = static_cast<uint32_t>(sizeof(GroupQueryOutput));

    const drvError_t drvRet = static_cast<drvError_t>(halGrpQuery(GRP_QUERY_GROUP_ID,
        &drvInput, drvInputLen, drvOutput, &drvOutputLen));
    COND_RETURN_ERROR(drvRet != DRV_ERROR_NONE, RT_GET_DRV_ERRCODE(drvRet),
        "[drv api] halQueueQuery failed: device_id=0, drvRetCode=%d.", static_cast<int32_t>(drvRet));

    // only GRP_QUERY_GROUP_ID
    if (output->groupIdInfo == nullptr) {
        RT_LOG(RT_LOG_ERROR, "group id info is nullptr, please check.");
        return RT_ERROR_INVALID_VALUE;
    }
    output->groupIdInfo->groupId = drvOutput->grpQueryGroupIdInfo.groupId;
    return RT_ERROR_NONE;
}

static rtError_t MemGrpGrpQueryGroupAddrInfo(const rtMemGrpQueryInput_t * const input,
    rtMemGrpQueryOutput_t * const output)
{
    COND_RETURN_ERROR((output->groupAddrInfo == nullptr), RT_ERROR_INVALID_VALUE, "invalid output nullptr");
    COND_RETURN_ERROR((output->maxNum == 0ULL),
        RT_ERROR_INVALID_VALUE, "invalid output, maxNum=%u.", output->maxNum);

    GroupQueryInput drvInput;
    errno_t ret = memset_s(&drvInput, sizeof(drvInput), 0, sizeof(drvInput));
    COND_RETURN_ERROR(ret != EOK, RT_ERROR_SEC_HANDLE,
        "memset_s failed, size=%zu(bytes), retCode=%d!", sizeof(drvInput), ret);
    ret = strcpy_s(drvInput.grpQueryGroupAddrPara.grpName, sizeof(drvInput.grpQueryGroupAddrPara.grpName),
        input->grpQueryGroupAddrPara.grpName);
    COND_RETURN_ERROR(ret != EOK, RT_ERROR_SEC_HANDLE, "strcpy_s failed, retCode=%d!", ret);
    drvInput.grpQueryGroupAddrPara.devId = input->grpQueryGroupAddrPara.devId;

    const std::unique_ptr<GroupQueryOutput> drvOutputUniquePtr(new (std::nothrow)(GroupQueryOutput));
    COND_RETURN_ERROR(drvOutputUniquePtr == nullptr, RT_ERROR_MEMORY_ALLOCATION, "malloc failed");
    GroupQueryOutput * const drvOutput = drvOutputUniquePtr.get();
    ret = memset_s(RtPtrToPtr<void *>(drvOutput), sizeof(GroupQueryOutput), 0, sizeof(GroupQueryOutput));
    COND_RETURN_ERROR(ret != EOK, RT_ERROR_SEC_HANDLE,
        "memset_s failed, size=%zu(bytes), retCode=%d!", sizeof(GroupQueryOutput), ret);
    uint32_t drvOutputLen = static_cast<uint32_t>(sizeof(GroupQueryOutput));
    const drvError_t drvRet = static_cast<drvError_t>(halGrpQuery(GRP_QUERY_GROUP_ADDR_INFO,
        &drvInput, static_cast<uint32_t>(sizeof(drvInput)), drvOutput, &drvOutputLen));
    COND_RETURN_ERROR(drvRet != DRV_ERROR_NONE, RT_GET_DRV_ERRCODE(drvRet), "[drv api] halGrpQuery failed:"
        "device_id=%u, drvRetCode=%d.", input->grpQueryGroupAddrPara.devId, static_cast<int32_t>(drvRet));

    // only GRP_QUERY_GROUP_ADDR_INFO
    output->resultNum = (static_cast<size_t>(drvOutputLen)) / sizeof(GrpQueryGroupAddrInfo);
    output->resultNum = (output->resultNum <= output->maxNum) ? output->resultNum : output->maxNum;
    if (output->resultNum > static_cast<size_t>(BUFF_GRP_MAX_NUM)) {
        output->resultNum = static_cast<size_t>(BUFF_GRP_MAX_NUM);
    }
    for (size_t i = 0U; i < output->resultNum; ++i) {
        output->groupAddrInfo[i].addr = drvOutput->grpQueryGroupAddrInfo[i].addr;
        output->groupAddrInfo[i].size = drvOutput->grpQueryGroupAddrInfo[i].size;
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MemGrpQuery(const rtMemGrpQueryInput_t * const input, rtMemGrpQueryOutput_t * const output)
{
    RT_LOG(RT_LOG_INFO, "query mem group, deviceId=0.");

    COND_RETURN_WARN(&halGrpQuery == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halGrpQuery does not exist.");
    rtError_t ret = RT_ERROR_NONE;
    const GroupQueryCmdType drvCmd = static_cast<GroupQueryCmdType>(input->cmd);
    switch (drvCmd) {
        case GRP_QUERY_GROUPS_OF_PROCESS: {
            ret = MemGrpQueryGroupsOfProcess(input, output);
            break;
        }
        case GRP_QUERY_GROUP_ID: {
            ret = MemGrpQueryGroupId(input, output);
            break;
        }
        case GRP_QUERY_GROUP_ADDR_INFO: {
            ret = MemGrpGrpQueryGroupAddrInfo(input, output);
            break;
        }
        default: {
            RT_LOG(RT_LOG_ERROR, "invalid cmd=%d.", input->cmd);
            ret = RT_ERROR_INVALID_VALUE;
        }
    }
    return ret;
}

rtError_t NpuDriver::MemGrpAttach(const char_t * const name, const int32_t timeout)
{
    RT_LOG(RT_LOG_INFO, "attach mem group, deviceId=0.");

    COND_RETURN_WARN(&halGrpAttach == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halGrpAttach does not exist.");

    const drvError_t drvRet = static_cast<drvError_t>(halGrpAttach(name, timeout));
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halGrpAttach failed: device_id=0, drvRetCode=%d.",
            static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    return RT_ERROR_NONE;
}

rtError_t NpuDriver::BufEventTrigger(const char_t * const name)
{
    RT_LOG(RT_LOG_INFO, "BufEventTrigger begin.");
    COND_RETURN_WARN(&halBufEventReport == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halBufEventReport does not exist.");

    const drvError_t drvRet = halBufEventReport(name);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halBufEventReport failed: drvRetCode=%d.", static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

/* ========================================================
 * Subcategory: Memory Queue
 * ======================================================== */

 rtError_t NpuDriver::MemQueueCreate(const int32_t devId, const rtMemQueueAttr_t * const queAttr, uint32_t * const qid)
{
    COND_RETURN_WARN(&halQueueCreate == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halQueueCreate does not exist.");
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_DRV, queAttr->depth < RT_MQ_DEPTH_MIN, RT_ERROR_INVALID_VALUE,
        "mem queue depth=%u, it can't be less than %u, name=%s.",
        queAttr->depth, RT_MQ_DEPTH_MIN, queAttr->name);

    QueueAttr attr = {};
    const errno_t ret = strcpy_s(attr.name, sizeof(attr.name), queAttr->name);
    COND_LOG_ERROR(ret != EOK, "strcpy_s failed, size=%zu(bytes), retCode=%d!", sizeof(attr.name), ret);
    attr.depth = queAttr->depth;
    attr.workMode = queAttr->workMode;
    attr.flowCtrlFlag = queAttr->flowCtrlFlag;
    attr.flowCtrlDropTime = queAttr->flowCtrlDropTime;
    attr.overWriteFlag = queAttr->overWriteFlag;
    attr.deploy_type = queAttr->deployType;
    TIMESTAMP_NAME(__func__);
    RT_LOG(RT_LOG_INFO, "create mem queue, drv devId=%d, name=%s.", devId, attr.name);

    const drvError_t drvRet = halQueueCreate(static_cast<uint32_t>(devId), &attr, qid);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halQueueCreate failed: device_id=%d, name=%s, drvRetCode=%d.",
            devId, attr.name, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MemQueueDestroy(const int32_t devId, const uint32_t qid)
{
    RT_LOG(RT_LOG_INFO, "drv devId=%d, qid=%u.", devId, qid);
    COND_RETURN_WARN(&halQueueDestroy == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halQueueDestroy does not exist.");
    const drvError_t drvRet = halQueueDestroy(static_cast<uint32_t>(devId), qid);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halQueueDestroy failed: drv devId=%d, qid=%u, drvRetCode=%d.",
            devId, qid, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

static rtError_t CheckMemQueueSupported(bool &isSupported)
{
    int32_t halAPIVersion = 0;
    const drvError_t drvRet = halGetAPIVersion(&halAPIVersion);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halGetAPIVersion failed, drvRetCode=%d.", static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    const uint32_t majorVersion = ((static_cast<uint32_t>(halAPIVersion) & MAJOR_VERSION_MASK) >> MAJOR_VERSION_OFFSET);
    RT_LOG(RT_LOG_INFO, "get majorVersion %u", majorVersion);
    if (majorVersion < MEM_QUEUE_SUPPORT_VERSION) {
        isSupported = false;
    } else {
        isSupported = true;
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MemQueueInit(const int32_t devId)
{
    RT_LOG(RT_LOG_INFO, "init mem queue, drv devId=%d.", devId);
    COND_RETURN_WARN(&halQueueInit == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halQueueInit does not exist.");
    bool isSupported = true;
    const rtError_t ret = CheckMemQueueSupported(isSupported);
    COND_RETURN_ERROR(ret != RT_ERROR_NONE, ret, "CheckMemQueueSupported failed");
    if (!isSupported) {
        RT_LOG(RT_LOG_INFO, "mem queue feature is not supported, drv devId=%d.", devId);
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }
    drvError_t drvRet = halQueueInit(static_cast<uint32_t>(devId));
    COND_RETURN_WARN(drvRet == DRV_ERROR_REPEATED_INIT, RT_GET_DRV_ERRCODE(drvRet), "repeated init"); // special state
    COND_RETURN_WARN(drvRet == DRV_ERROR_NOT_SUPPORT, RT_GET_DRV_ERRCODE(drvRet), "not support"); // special state
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halQueueInit failed: device_id=%d, drvRetCode=%d.",
            devId, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    // get max mbuf cnt in queue init
    QueueQueryCmdType drvCmd = QUEUE_QUERY_MAX_IOVEC_NUM;
    QueueQueryInputPara inputPara = {nullptr, 0U};

    const std::unique_ptr<QueueQueryOutput> outputUniquePtr(new (std::nothrow)(QueueQueryOutput));
    COND_RETURN_ERROR(outputUniquePtr == nullptr, RT_ERROR_MEMORY_ALLOCATION, "malloc failed");
    QueueQueryOutput * const output = outputUniquePtr.get();

    const errno_t rc = memset_s(RtPtrToPtr<void *>(output), sizeof(QueueQueryOutput), 0,
        sizeof(QueueQueryOutput));
    COND_LOG_ERROR(rc != EOK, "memset_s failed, size=%zu(bytes), retCode=%d!", sizeof(QueueQueryOutput), rc);
    QueueQueryOutputPara outputPara = {output, static_cast<uint32_t>(sizeof(QueueQueryOutput))};

    drvRet = halQueueQuery(static_cast<uint32_t>(devId), drvCmd, &inputPara, &outputPara);
    COND_RETURN_ERROR(((drvRet != DRV_ERROR_NONE) && (drvRet != DRV_ERROR_NOT_SUPPORT)),
        RT_GET_DRV_ERRCODE(drvRet), "query max queue num failed"); // special state
    // only success g_maxBufCnt can be replaced
    if (drvRet == DRV_ERROR_NONE) {
        g_maxBufCnt = output->queQueryMaxIovecNum.count;
    }
    RT_LOG(RT_LOG_INFO, "get max queue cnt %u success.", g_maxBufCnt);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MemQueueSet(const int32_t devId, const rtMemQueueSetCmdType cmd,
    const rtMemQueueSetInputPara * const input)
{
    COND_RETURN_WARN(&halQueueSet == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halQueueSet does not exist.");
    COND_RETURN_ERROR(input == nullptr, RT_ERROR_DRV_INPUT, "input is nullptr");

    QueueSetCmdType const type = static_cast<QueueSetCmdType>(cmd);
    QueueSetInputPara para;
    para.inBuff = input->inBuff;
    para.inLen = input->inLen;
    TIMESTAMP_NAME(__func__);
    RT_LOG(RT_LOG_INFO, "drv devId=%d, type=%d.", devId, static_cast<int32_t>(cmd));

    const drvError_t drvRet = halQueueSet(static_cast<uint32_t>(devId), type, &para);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halQueueSet failed: drv devId=%d, type=%d, drvRetCode=%d.",
            devId, static_cast<int32_t>(cmd), static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MemQueueEnQueue(const int32_t devId, const uint32_t qid, void * const memBuf)
{
    RT_LOG(RT_LOG_INFO, "Enqueue, drv devId=%d, qid=%u.", devId, qid);
    COND_RETURN_WARN(&halQueueEnQueue == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halQueueEnQueue does not exist.");
    const drvError_t drvRet = halQueueEnQueue(static_cast<uint32_t>(devId), qid, memBuf);
    COND_RETURN_WARN(drvRet == DRV_ERROR_QUEUE_FULL, RT_GET_DRV_ERRCODE(drvRet), "queue full"); // special state
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halQueueEnQueue failed: drv devId=%d, qid=%u, drvRetCode=%d.",
            devId, qid, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MemQueueDeQueue(const int32_t devId, const uint32_t qid, void ** const memBuf)
{
    RT_LOG(RT_LOG_INFO, "dequeue, drv devId=%d, qid=%u.", devId, qid);
    COND_RETURN_WARN(&halQueueDeQueue == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halQueueDeQueue does not exist.");
    const drvError_t drvRet = halQueueDeQueue(static_cast<uint32_t>(devId), qid, memBuf);
    COND_RETURN_WARN(drvRet == DRV_ERROR_QUEUE_EMPTY, RT_GET_DRV_ERRCODE(drvRet), "queue empty"); // special state
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halQueueDeQueue failed: drv devId=%d, qid=%u, drvRetCode=%d.", devId, qid,
            static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

static rtError_t GetBuffIovec(struct buff_iovec * const vec, const rtMemQueueBuff_t * const inBuf,
    bool &baseNeedFree)
{
    baseNeedFree = false;
    if (vec->count == inBuf->buffCount) {
        for (uint32_t i = 0U; i < inBuf->buffCount; ++i) {
            vec->ptr[i].iovec_base = inBuf->buffInfo[i].addr;
            vec->ptr[i].len = inBuf->buffInfo[i].len;
        }
        return RT_ERROR_NONE;
    }

    size_t len = 0U;
    for (uint32_t i = 0U; i < inBuf->buffCount; ++i) {
        COND_RETURN_ERROR(len > (SIZE_MAX - inBuf->buffInfo[i].len), RT_ERROR_INVALID_VALUE,
            "Overflow occur when calculate total size, current len is %zu, added len is %zu.",
            len, inBuf->buffInfo[i].len);
        len += inBuf->buffInfo[i].len;
    }
    COND_RETURN_ERROR(len == 0U, RT_ERROR_INVALID_VALUE, "malloc len can not be 0");
    char_t *tempBuff = new (std::nothrow)char_t[len];
    COND_RETURN_ERROR(tempBuff == nullptr, RT_ERROR_MEMORY_ALLOCATION, "malloc failed");
    size_t offset = 0U;
    for (uint32_t i = 0U; i < inBuf->buffCount; ++i) {
        const drvError_t drvRet = drvMemcpy(static_cast<DVdeviceptr>(RtPtrToPtr<uintptr_t>(tempBuff) + offset),
            (len - offset), RtPtrToPtr<DVdeviceptr>((inBuf->buffInfo[i].addr)),
            inBuf->buffInfo[i].len);
        if (drvRet != DRV_ERROR_NONE) {
            delete [] tempBuff;
            tempBuff = nullptr;
            DRV_ERROR_PROCESS(drvRet, "[drv api] drvMemcpy failed, copy size is %zu, drvRetCode=%d.",
                inBuf->buffInfo[i].len, static_cast<int32_t>(drvRet));
            return RT_GET_DRV_ERRCODE(drvRet);
        }
        offset += inBuf->buffInfo[i].len;
    }
    baseNeedFree = true;
    vec->ptr[0].iovec_base = tempBuff; // array count is 1
    vec->ptr[0].len = len;
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MemQueueEnQueueBuff(const int32_t devId, const uint32_t qid,
                                         const rtMemQueueBuff_t * const inBuf, const int32_t timeout)
{
    RT_LOG(RT_LOG_INFO, "drv devId=%d, qid=%u, timeout=%dms, maxBufCnt is %u.", devId, qid, timeout, g_maxBufCnt);

    COND_RETURN_WARN(&halQueueEnQueueBuff == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halQueueEnQueueBuff does not exist.");

    uint32_t buffCnt = inBuf->buffCount;
    if (buffCnt > g_maxBufCnt) {
        RT_LOG(RT_LOG_WARNING, "buffCount %u larger than %u", inBuf->buffCount, g_maxBufCnt);
        buffCnt = 1U;
    }

    const size_t totalLen = sizeof(struct buff_iovec) + (buffCnt * sizeof(struct iovec_info));
    const std::unique_ptr<char_t[]> vecUniquePtr(new (std::nothrow)char_t[totalLen]);
    COND_RETURN_ERROR(vecUniquePtr == nullptr, RT_ERROR_MEMORY_ALLOCATION, "malloc failed");
    struct buff_iovec * const vec = RtPtrToPtr<buff_iovec *>(vecUniquePtr.get());

    vec->context_base = inBuf->contextAddr;
    vec->context_len = inBuf->contextLen;
    vec->count = buffCnt;
    bool baseNeedFree = false;
    const rtError_t ret = GetBuffIovec(vec, inBuf, baseNeedFree);
    COND_RETURN_ERROR(ret != RT_ERROR_NONE, ret, "GetBuffIovec failed");

    const drvError_t drvRet = halQueueEnQueueBuff(static_cast<uint32_t>(devId), qid, vec, timeout);
    if (baseNeedFree) {
        delete [] RtPtrToPtr<char_t *>(vec->ptr[0].iovec_base);
        vec->ptr[0].iovec_base = nullptr;
    }
    COND_RETURN_WARN(drvRet == DRV_ERROR_QUEUE_FULL, RT_GET_DRV_ERRCODE(drvRet), "queue full"); // special state
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet,
            "[drv api] halQueueEnQueueBuff failed: drv devId=%d, qid=%u, timeout=%dms, drvRetCode=%d.", devId, qid,
            timeout, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MemQueueDeQueueBuff(const int32_t devId, const uint32_t qid,
                                         const rtMemQueueBuff_t * const outBuf, const int32_t timeout)
{
    RT_LOG(RT_LOG_INFO, "DeQueueBuff, drv devId=%d, qid=%u, timeout=%dms.", devId, qid, timeout);

    COND_RETURN_WARN(&halQueueDeQueueBuff == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halQueueDeQueueBuff does not exist.");

    const size_t totalLen = sizeof(struct buff_iovec) + (outBuf->buffCount * sizeof(struct iovec_info));
    const std::unique_ptr<char_t[]> vecUniquePtr(new (std::nothrow)char_t[totalLen]);
    COND_RETURN_ERROR(vecUniquePtr == nullptr, RT_ERROR_MEMORY_ALLOCATION, "malloc failed");
    struct buff_iovec * const vec = RtPtrToPtr<buff_iovec *>(vecUniquePtr.get());

    vec->context_base = outBuf->contextAddr;
    vec->context_len = outBuf->contextLen;
    vec->count = outBuf->buffCount;
    for (uint32_t i = 0U; i < outBuf->buffCount; ++i) {
        vec->ptr[i].iovec_base = outBuf->buffInfo[i].addr;
        vec->ptr[i].len = outBuf->buffInfo[i].len;
    }

    const drvError_t drvRet = halQueueDeQueueBuff(static_cast<uint32_t>(devId), qid, vec, timeout);
    COND_RETURN_WARN(drvRet == DRV_ERROR_QUEUE_EMPTY, RT_GET_DRV_ERRCODE(drvRet), "queue empty"); // special state
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet,
            "[drv api] halQueueDeQueueBuff failed: drv devId=%d, qid=%u, timeout=%dms, drvRetCode=%d.", devId, qid,
            timeout, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MemQueuePeek(const int32_t devId, const uint32_t qid, size_t * const bufLen, const int32_t timeout)
{
    RT_LOG(RT_LOG_INFO, "peek mem queue, drv devId=%d, qid=%u, timeout=%dms.", devId, qid, timeout);

    COND_RETURN_WARN(&halQueuePeek == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halQueuePeek does not exist.");

    uint64_t len = 0ULL;

    const drvError_t drvRet = halQueuePeek(static_cast<uint32_t>(devId), qid, &len, timeout);
    COND_RETURN_WARN(drvRet == DRV_ERROR_QUEUE_EMPTY, RT_GET_DRV_ERRCODE(drvRet), "queue empty"); // special state
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halQueuePeek failed: drv devId=%d, qid=%u, timeout=%dms, drvRetCode=%d.",
            devId, qid, timeout, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    *bufLen = static_cast<size_t>(len);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MemQueueQuery(const int32_t devId, const rtMemQueueQueryCmd_t cmd,
                                   const void * const inBuff, const uint32_t inLen,
                                   void * const outBuff, const uint32_t * const outLen)
{
    RT_LOG(RT_LOG_INFO, "query mem queue, drv devId=%d, cmd=%d.", devId, static_cast<int32_t>(cmd));

    COND_RETURN_WARN(&halQueueQuery == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halQueueQuery does not exist.");
    COND_RETURN_WARN(cmd != RT_MQ_QUERY_QUE_ATTR_OF_CUR_PROC, RT_ERROR_INVALID_VALUE,
        "[drv api] cmd=%d is not supported.", static_cast<int32_t>(cmd));
    COND_RETURN_WARN(static_cast<size_t>(inLen) < sizeof(int32_t), RT_ERROR_INVALID_VALUE,
        "[drv api] outputLen=%u(bytes) < %zu(bytes).", inLen, sizeof(int32_t));
    COND_RETURN_WARN(static_cast<size_t>(*outLen) < sizeof(rtMemQueueShareAttr_t), RT_ERROR_INVALID_VALUE,
        "[drv api] outputLen=%u(bytes) < %zu(bytes).", inLen, sizeof(rtMemQueueShareAttr_t));

    const QueueQueryCmdType drvCmd = static_cast<QueueQueryCmdType>(cmd);

    // input
    QueueQueryInput input;
    errno_t ret = memset_s(&input, sizeof(input), 0, sizeof(input));
    COND_LOG_ERROR(ret != EOK, "memset_s failed, size=%zu(bytes), retCode=%d!", sizeof(input), ret);
    input.queQueryQueueAttr.qid = *(RtPtrToPtr<const int32_t *>(inBuff));
    QueueQueryInputPara inputPara = {&input, static_cast<uint32_t>(sizeof(input))};

    // output, the length is too large, malloc is required.
    const std::unique_ptr<QueueQueryOutput> outputUniquePtr(new (std::nothrow)(QueueQueryOutput));
    COND_RETURN_ERROR(outputUniquePtr == nullptr, RT_ERROR_MEMORY_ALLOCATION, "malloc failed");
    QueueQueryOutput * const output = outputUniquePtr.get();

    ret = memset_s(RtPtrToPtr<void *>(output), sizeof(QueueQueryOutput), 0, sizeof(QueueQueryOutput));
    COND_LOG_ERROR(ret != EOK, "memset_s failed, size=%zu(bytes), retCode=%d!", sizeof(QueueQueryOutput), ret);
    QueueQueryOutputPara outputPara = {output, static_cast<uint32_t>(sizeof(QueueQueryOutput))};

    const drvError_t drvRet = halQueueQuery(static_cast<uint32_t>(devId), drvCmd, &inputPara, &outputPara);
    COND_RETURN_ERROR(drvRet != DRV_ERROR_NONE, RT_GET_DRV_ERRCODE(drvRet),
        "[drv api] halQueueQuery failed: drv devId=%d, drvRetCode=%d.", devId, static_cast<int32_t>(drvRet));
    rtMemQueueShareAttr_t * const rtsAttr = RtPtrToPtr<rtMemQueueShareAttr_t *>(outBuff);
    rtsAttr->manage = output->queQueryQueueAttrInfo.attr.manage;
    rtsAttr->read = output->queQueryQueueAttrInfo.attr.read;
    rtsAttr->write = output->queQueryQueueAttrInfo.attr.write;
    rtsAttr->rsv = output->queQueryQueueAttrInfo.attr.rsv;
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MemQueueGetQidByName(const int32_t devId, const char_t * const name, uint32_t * const qId)
{
    TIMESTAMP_NAME(__func__);
    RT_LOG(RT_LOG_INFO, "Esched attach device, drv devId=%d.", devId);

    COND_RETURN_WARN(&halQueueGetQidbyName == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halQueueGetQidbyName does not exist.");

    const drvError_t drvRet = halQueueGetQidbyName(static_cast<uint32_t>(devId), name, qId);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halQueueGetQidbyName failed: drv devId=%d, drvRetCode=%d.", devId,
            static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MemQueueAttach(const int32_t devId, const uint32_t qid, const int32_t timeout)
{
    RT_LOG(RT_LOG_INFO, "attach mem queue, drv devId=%d, qid=%u, timeout=%dms.", devId, qid, timeout);

    COND_RETURN_WARN(&halQueueAttach == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halQueueAttach does not exist.");

    const drvError_t drvRet = halQueueAttach(static_cast<uint32_t>(devId), qid, timeout);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halQueueAttach failed: drv devId=%d, qid=%u, timeout=%dms, drvRetCode=%d.",
            devId, qid, timeout, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MemQEventCrossDevSupported(int32_t * const isSupported)
{
    int32_t halAPIVersion = 0;
    const drvError_t drvRet = halGetAPIVersion(&halAPIVersion);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halGetAPIVersion failed, drvRetCode=%d.", static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    RT_LOG(RT_LOG_INFO, "get halAPIVersion %d", halAPIVersion);
    if (halAPIVersion < MEMQ_EVENT_CROSS_DEV_VERSION) {
        *isSupported = static_cast<int32_t>(false);
    } else {
        *isSupported = static_cast<int32_t>(true);
    }
    return RT_ERROR_NONE;
}

/* ========================================================
 * Subcategory: Event Sched
 * ======================================================== */

rtError_t NpuDriver::EschedSubmitEvent(const int32_t devId, const rtEschedEventSummary_t * const evt)
{
    RT_LOG(RT_LOG_INFO, "Esched create group, drv devId=%d.", devId);

    COND_RETURN_WARN(&halEschedSubmitEvent == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halEschedSubmitEvent does not exist.");

    struct event_summary drv_event_summary;
    drv_event_summary.pid = evt->pid;
    drv_event_summary.grp_id = evt->grpId;
    drv_event_summary.event_id = static_cast<EVENT_ID>(evt->eventId);
    drv_event_summary.subevent_id = evt->subeventId;
    drv_event_summary.msg_len = evt->msgLen;
    drv_event_summary.msg = evt->msg;
    drv_event_summary.dst_engine = evt->dstEngine;
    drv_event_summary.policy = static_cast<SCHEDULE_POLICY>(evt->policy);
    const drvError_t drvRet = halEschedSubmitEvent(static_cast<uint32_t>(devId), &drv_event_summary);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halEschedSubmitEvent failed: drv devId=%d, drvRetCode=%d.", devId,
            static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::EschedSubmitEventSync(const int32_t devId, rtEschedEventSummary_t * const evt,
                                           rtEschedEventReply_t * const ack)
{
    TIMESTAMP_NAME(__func__);
    RT_LOG(RT_LOG_INFO, "submit event, drv devId=%d.", devId);

    COND_RETURN_WARN(&halEschedSubmitEventSync == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halEschedSubmitEventSync does not exist.");
    struct event_summary drvEvent = {};
    drvEvent.pid = evt->pid;
    drvEvent.grp_id = evt->grpId;
    drvEvent.event_id = static_cast<EVENT_ID>(evt->eventId);
    drvEvent.subevent_id = evt->subeventId;
    drvEvent.msg_len = evt->msgLen;
    drvEvent.msg = evt->msg;
    drvEvent.dst_engine = evt->dstEngine;
    drvEvent.policy = static_cast<SCHEDULE_POLICY>(evt->policy);

    struct event_reply drvAck = {};
    drvAck.buf = ack->buf;
    drvAck.buf_len = ack->bufLen;
    const drvError_t drvRet = halEschedSubmitEventSync(static_cast<uint32_t>(devId),
        &drvEvent, EVENT_SYNC_TIMEOUT, &drvAck);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halEschedSubmitEventSync failed: drv devId=%d, drvRetCode=%d.", devId,
            static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    ack->replyLen = drvAck.reply_len;
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::EschedAttachDevice(const uint32_t devId)
{
    RT_LOG(RT_LOG_INFO, "Esched attach device, drv devId=%u.", devId);

    COND_RETURN_WARN(&halEschedAttachDevice == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halEschedAttachDevice does not exist.");

    const drvError_t drvRet = halEschedAttachDevice(devId);
    if ((drvRet != DRV_ERROR_NONE) && (drvRet != DRV_ERROR_PROCESS_REPEAT_ADD)) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halEschedAttachDevice failed: drv devId=%u, drvRetCode=%d.", devId,
            static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::EschedDettachDevice(const uint32_t devId)
{
    RT_LOG(RT_LOG_INFO, "Esched dettach device, drv devId=%u.", devId);

    COND_RETURN_WARN(&halEschedDettachDevice == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halEschedDettachDevice does not exist.");

    const drvError_t drvRet = halEschedDettachDevice(devId);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halEschedDettachDevice failed: drv devId=%u, drvRetCode=%d.", devId,
            static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::EschedCreateGrp(const int32_t devId, const uint32_t grpId, const rtGroupType_t type)
{
    RT_LOG(RT_LOG_INFO, "Esched create group, drv devId=%d, grpId=%u, type=%u.",
           devId, grpId, static_cast<uint32_t>(type));

    COND_RETURN_WARN(&halEschedCreateGrp == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halEschedCreateGrp does not exist.");

    const drvError_t drvRet = halEschedCreateGrp(static_cast<uint32_t>(devId), grpId, static_cast<GROUP_TYPE>(type));
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halEschedCreateGrp failed: drv devId=%d, grpId=%u, type=%u, "
            "drvRetCode=%d.", devId, grpId, static_cast<uint32_t>(type), static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::EschedCreateGrpEx(const uint32_t devId, const uint32_t maxThreadNum,
                                       uint32_t * const grpId)
{
    COND_RETURN_WARN(&halEschedCreateGrpEx == nullptr, RT_ERROR_DRV_NOT_SUPPORT,
        "[drv api] halEschedCreateGrpEx does not exist");
    struct esched_grp_para grpPara = {};
    errno_t rc = memset_s(&grpPara, sizeof(esched_grp_para), 0, sizeof(esched_grp_para));
    COND_LOG(rc != EOK, "memset_s failed, size=%zu(bytes), retCode=%d!", sizeof(esched_grp_para), rc);
    grpPara.type = GRP_TYPE_BIND_DP_CPU;
    grpPara.threadNum = maxThreadNum;
    rc = strcpy_s(grpPara.grp_name, sizeof(grpPara.grp_name), "stmSyncEGrp");
    COND_LOG_ERROR(rc != EOK, "strcpy_s failed, max size=%zu(bytes), retCode=%d!",
                   sizeof(grpPara.grp_name), rc);
    const drvError_t drvRet = halEschedCreateGrpEx(devId, &grpPara, grpId);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "Esched create grp failed, devid(%u), drvRetCode(%d).",
            devId, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    RT_LOG(RT_LOG_INFO, "process EschedCreateGrpEx, grpId=%u.", *grpId);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::EschedSubscribeEvent(const int32_t devId, const uint32_t grpId,
                                          const uint32_t threadId, const uint64_t eventBitmap)
{
    RT_LOG(RT_LOG_INFO, "Esched subscribe event, drv devId=%d, grpId=%u, "
        "threadId=%u, eventBitmap=%" PRIu64, devId, grpId, threadId, eventBitmap);

    COND_RETURN_WARN(&halEschedSubscribeEvent == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halEschedSubscribeEvent does not exist.");

    const drvError_t drvRet = halEschedSubscribeEvent(static_cast<uint32_t>(devId),
        grpId, threadId, static_cast<UINT64>(eventBitmap));
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halEschedSubscribeEvent failed: drv devId=%d, grpId=%u, drvRetCode=%d.",
            devId, grpId, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::EschedWaitEvent(const int32_t devId, const uint32_t grpId, const uint32_t threadId,
                                     const int32_t timeout, rtEschedEventSummary_t * const evt)
{
    RT_LOG(RT_LOG_INFO, "Esched wait event, drv devId=%d, grpId=%u, threadId=%u, timeout=%dms.",
        devId, grpId, threadId, timeout);

    COND_RETURN_WARN(&halEschedWaitEvent == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halEschedWaitEvent does not exist.");

    struct event_info evtInfo = {};
    const drvError_t drvRet = halEschedWaitEvent(static_cast<uint32_t>(devId), grpId, threadId, timeout, &evtInfo);
    COND_RETURN_WARN(drvRet != DRV_ERROR_NONE, RT_GET_DRV_ERRCODE(drvRet),
        "[drv api] halEschedWaitEvent failed: drv devId=%d, eventId=%d,"
        "subeventId=%u, grpId=%u, pid=%u, drvRetCode=%d.",
        devId, evt->eventId, evt->subeventId, evt->grpId, evt->pid, static_cast<int32_t>(drvRet));
    evt->eventId = static_cast<int32_t>(evtInfo.comm.event_id);
    evt->subeventId = evtInfo.comm.subevent_id;
    evt->pid = evtInfo.comm.pid;
    evt->grpId = evtInfo.comm.grp_id;
    if ((evt->msg != nullptr) && (evt->msgLen > 0)) {
        const errno_t ret = memcpy_s(evt->msg, evt->msgLen,
                                     evtInfo.priv.msg, static_cast<size_t>(evtInfo.priv.msg_len));
        COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, ret != EOK, RT_ERROR_SEC_HANDLE,
                                   "Call memcpy_s failed, dst length=%u, src length=%u, retCode=%d!",
                                   evt->msgLen, evtInfo.priv.msg_len, ret);
        evt->msgLen = evtInfo.priv.msg_len;
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::EschedAckEvent(const int32_t devId, const rtEventIdType_t evtId,
                                    const uint32_t subeventId, char_t * const msg, const uint32_t len)
{
    RT_LOG(RT_LOG_INFO, "Esched subscribe event, drv devId=%d, grpevent_idId=%u, "
        "subevent_id=%u, len=%u.", devId, static_cast<uint32_t>(evtId), subeventId, len);

    COND_RETURN_WARN(&halEschedAckEvent == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halEschedAckEvent does not exist.");

    const drvError_t drvRet = halEschedAckEvent(static_cast<uint32_t>(devId),
        static_cast<EVENT_ID>(evtId), subeventId, msg, len);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet,
            "[drv api] halEschedSubscribeEvent failed: drv devId=%d, eventId=%u, subeventId=%u,"
            "len=%u(bytes), drvRetCode=%d.", devId, static_cast<uint32_t>(evtId), subeventId, len,
            static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::EschedQueryInfo(const uint32_t devId, const rtEschedQueryType type,
    rtEschedInputInfo *inPut, rtEschedOutputInfo *outPut)
{
    RT_LOG(RT_LOG_INFO, "EschedQueryInfo, drv devId=%u, type=%d,", devId, type);
    COND_RETURN_WARN(&halEschedQueryInfo == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halEschedQueryInfo does not exist.");

    const drvError_t drvRet = halEschedQueryInfo(devId, static_cast<ESCHED_QUERY_TYPE>(type),
        RtPtrToPtr<esched_input_info *>(inPut), RtPtrToPtr<esched_output_info *>(outPut));
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "[drv api] halEschedQueryInfo failed: drv devId=%u, type=%d, drvRetCode=%d.",
            devId, type, static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

static uint64_t GetTimeInterval(const mmTimespec &beginTime, const mmTimespec &endTime)
{
    const uint64_t beginCnt = static_cast<uint64_t>(beginTime.tv_sec) * RT_MS_PER_S +
                              static_cast<uint64_t>(beginTime.tv_nsec) / RT_MS_TO_NS;
    const uint64_t endCnt = static_cast<uint64_t>(endTime.tv_sec) * RT_MS_PER_S +
                            static_cast<uint64_t>(endTime.tv_nsec) / RT_MS_TO_NS;
    uint64_t count = (endCnt > beginCnt) ? (endCnt - beginCnt) : 0ULL;
    return count;
}

drvError_t NpuDriver::DrvEschedManage(const uint32_t devId, const int32_t timeout, const uint32_t eschedTid,
                                      const uint32_t grpId, struct halReportRecvInfo *info)
{
    RT_LOG(RT_LOG_INFO, "process DrvEschedManage, deviceId=%u, timeout=%ums, eschedTid=%u, grpId=%u.",
        devId, timeout, eschedTid, grpId);
    drvError_t drvRet = DRV_ERROR_NONE;
    uint64_t count = 0LL;
    int32_t timeoutLeft = timeout;
    mmTimespec lastTimeSpec = mmGetTickCount();
    info->report_cqe_num = 0U;
    while (info->report_cqe_num == 0U) {
        drvRet = halEschedThreadSwapout(devId, MAX_UINT32_NUM, MAX_UINT32_NUM);
        if (drvRet != DRV_ERROR_NONE) {
            DRV_ERROR_PROCESS(drvRet, "Call halEschedThreadSwapout failed, "
                "(devId=%u, grpId=%u, tid=%u, drvRetCode=%d).",
                devId, grpId, eschedTid, static_cast<int32_t>(drvRet));
            return drvRet;
        }

        if (timeoutLeft > 0) {
            mmTimespec curTimeSpec = mmGetTickCount();
            count = GetTimeInterval(lastTimeSpec, curTimeSpec);
            lastTimeSpec = curTimeSpec;
            if (count >= static_cast<uint64_t>(timeoutLeft)) {
                RT_LOG(RT_LOG_ERROR, "Stream sync timeout, time=%lums, total timeout=%dms", count, timeout);
                return DRV_ERROR_WAIT_TIMEOUT;
            }
            timeoutLeft = (timeoutLeft - static_cast<int32_t>(count));
        }

        RT_LOG(RT_LOG_DEBUG, "timeoutLeft=%u", timeoutLeft);

        struct event_info back_event_info = {};
        drvRet = halEschedWaitEvent(devId, grpId, eschedTid, timeoutLeft, &back_event_info);
        if (drvRet != DRV_ERROR_NONE) {
            DRV_ERROR_PROCESS(drvRet, "Wait event failed. (devId=%u, grpId=%u, tid=%u; drvRetCode=%d)",
                devId, grpId, eschedTid, static_cast<int32_t>(drvRet));
            return drvRet;
        }

        drvRet = halCqReportRecv(devId, info);
        if (drvRet != DRV_ERROR_NONE) {
            DRV_ERROR_PROCESS(drvRet, "call halCqReportRecv failed, drvRetCode=%d, device_id=%u",
                static_cast<int32_t>(drvRet), devId);
            return drvRet;
        }

        RT_LOG(RT_LOG_DEBUG, "info->report_cqe_num=%u", info->report_cqe_num);
    }

    return drvRet;
}

}  // namespace runtime
}  // namespace cce
