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

namespace cce {
namespace runtime {

constexpr int32_t EVENT_SYNC_TIMEOUT = -1;

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
        RT_LOG_OUTER_MSG(RT_INVALID_ARGUMENT_ERROR, "flag=%" PRIu64 " invalid, flag range [0, 1].", flag);
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

}  // namespace runtime
}  // namespace cce
