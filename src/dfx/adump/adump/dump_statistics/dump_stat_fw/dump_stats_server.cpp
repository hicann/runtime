/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "dump_stats_server.h"

namespace kfc_dump_stats {
uint64_t g_kfcDumpWaitTimeout = DEFAULT_KFC_DUMP_WAIT_TIMEOUT;

void KfcDumpStatsServer::Init(uint64_t workSpaceAddr)
{
    msgBody_ = reinterpret_cast<KfcDumpMsgBody*>(workSpaceAddr);
    rcvMsgPos_ = 0;
    sndMsgPos_ = 0;
}

#pragma GCC push_options
#pragma GCC optimize("O0")

KfcDumpResult KfcDumpStatsServer::PostMsg(KfcDumpStatsMsg* rMsg)
{
    auto pos = sndMsgPos_;
    auto* msg = &msgBody_->msgSndArea[pos];
    uint64_t startPostTime = GetCurCpuTimestamp();
    while (msg->valid == DUMP_MSG_VALID_MASK) {
        if (GetCurCpuTimestamp() - startPostTime >= g_kfcDumpWaitTimeout) {
            IDE_LOGE("Failed to post kfc dump message, wait for free message slot timeout");
            return KFC_DUMP_E_TIMEOUT;
        }
    }

    IDE_LOGI("Post kfc dump message to global memory address[%p]", msg);
    errno_t ret = memcpy_s(msg, sizeof(KfcDumpStatsMsg), rMsg, sizeof(KfcDumpStatsMsg));
    if (ret != EOK) {
        IDE_LOGE("Failed to copy kfc dump message to send area, ret[%d]", ret);
        return KFC_DUMP_E_MEMORY;
    }
    // ARM弱序：此屏障保证msg其他字段先于valid字段对AIV可见，使AIV侧见valid字段即msg就绪，不可删除。
#ifdef __aarch64__
    __asm__ __volatile__("dsb st" : : : "memory");
#endif
    msg->valid = DUMP_MSG_VALID_MASK;
    // 此屏障保证valid字段尽快排出store buffer对AIV可见，减少AIV的轮询等待。
#ifdef __aarch64__
    __asm__ __volatile__("dsb st" : : : "memory");
#endif
    IDE_LOGI(
        "Post kfc dump message done. position=%u, sndAddr=%p, msgType=%u, dataType=%u, dataCount=%lu, "
        "dataAddr=0x%lx, dumpStatClass=%lu, outputAddr=0x%lx, outputAddrSize=%lu, valid=0x%x, result=%u",
        pos, static_cast<void*>(msg), static_cast<uint32_t>(msg->msgType), msg->dataType, msg->dataCount, msg->dataAddr,
        msg->dumpStatClass, msg->outputAddr, msg->outputAddrSize, msg->valid, msg->result);
    pos = (pos + 1) % DUMP_MSG_CNT;
    sndMsgPos_ = pos;
    return KFC_DUMP_SUCCESS;
}

KfcDumpResult KfcDumpStatsServer::RcvMsg(KfcDumpStatsMsg* rMsg)
{
    if (rMsg == nullptr) {
        return KFC_DUMP_E_PARA;
    }
    auto pos = rcvMsgPos_;
    auto msg = &msgBody_->msgRcvArea[pos];
    IDE_LOGD("Waiting for kfc dump message response, receive position[%u]", pos);
    auto startWaitTime = GetCurCpuTimestamp();
    do {
        if (CheckTimeOut(startWaitTime) != KFC_DUMP_SUCCESS) {
            IDE_LOGE("Failed to receive kfc dump message, wait for response timeout");
            return KFC_DUMP_E_TIMEOUT;
        }
    } while (!ReadValidMsg(rMsg, msg));
    IDE_LOGI(
        "Receive kfc dump message done. position=%u, sndAddr=%p, msgType=%u, dataType=%u, dataCount=%lu, "
        "dataAddr=0x%lx, dumpStatClass=%lu, outputAddr=0x%lx, outputAddrSize=%lu, valid=0x%x, result=%u",
        pos, static_cast<void*>(msg), static_cast<uint32_t>(msg->msgType), msg->dataType, msg->dataCount, msg->dataAddr,
        msg->dumpStatClass, msg->outputAddr, msg->outputAddrSize, msg->valid, msg->result);
    pos = (pos + 1) % DUMP_MSG_CNT;
    rcvMsgPos_ = pos;
    return KFC_DUMP_SUCCESS;
}

bool KfcDumpStatsServer::ReadValidMsg(KfcDumpStatsMsg* rMsg, KfcDumpStatsMsg* msg)
{
    // 见valid字段即msg就绪，AIV写完全部字段后才刷出msg(单cache line 64B)，valid字段和msg其他字段同时可见。
    if (msg->valid != DUMP_MSG_VALID_MASK) {
        return false;
    }
    errno_t ret = memcpy_s(rMsg, sizeof(KfcDumpStatsMsg), msg, sizeof(KfcDumpStatsMsg));
    if (ret != EOK) {
        IDE_LOGE("Failed to copy kfc dump message from receive area, ret[%d]", ret);
        return false;
    }
    msg->valid = ~DUMP_MSG_VALID_MASK;
    return true;
}

KfcDumpResult KfcDumpStatsServer::CheckDumpResult(KfcDumpStatsMsg* rMsg)
{
    if (rMsg->result != 0) {
        IDE_LOGW("Statistics are not supported for tensor data type[%u]", rMsg->dataType);
    }
    return KFC_DUMP_SUCCESS;
}

#pragma GCC pop_options
} // namespace kfc_dump_stats
