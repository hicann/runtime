/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef __KFC_DUMP_SERVER_H__
#define __KFC_DUMP_SERVER_H__

#include "kfc_dump_param.h"

namespace KfcDumpStat {
class KfcDumpServer {
public:
    __aicore__ inline KfcDumpServer() = default;

    __aicore__ inline ~KfcDumpServer() = default;

    __aicore__ inline void Init(uint64_t workspaceAddr)
    {
        msgBody_ = (__gm__ KfcDumpMsgBody*)workspaceAddr;
        msgRcvArea_ = msgBody_->msgRcvArea;
        msgSndArea_ = msgBody_->msgSndArea;
        rcvMsgPos_ = 0;
        sndMsgPos_ = 0;
    }

    __aicore__ inline __gm__ KfcDumpStatMsg* GetSndMsg()
    {
        GlobalTensor<uint32_t> sndMsgGm;
        __gm__ KfcDumpStatMsg* msg = &(msgBody_->msgSndArea[sndMsgPos_]);
        sndMsgGm.SetGlobalBuffer((__gm__ uint32_t*)msg);
#if KFC_DUMP_ARCH_DAVID
        DataCacheCleanAndInvalid<uint32_t, CacheLine::SINGLE_CACHE_LINE, DcciDst::CACHELINE_OUT>(sndMsgGm);
#else
        DataCacheCleanAndInvalid<uint32_t, CacheLine::SINGLE_CACHE_LINE>(sndMsgGm);
#endif
        return msg;
    }

    __aicore__ inline __gm__ KfcDumpStatMsg* GetRcvMsg()
    {
        GlobalTensor<uint32_t> rcvMsgGm;
        __gm__ KfcDumpStatMsg* msg = &(msgBody_->msgRcvArea[rcvMsgPos_]);
        rcvMsgGm.SetGlobalBuffer((__gm__ uint32_t*)msg);
#if KFC_DUMP_ARCH_DAVID
        DataCacheCleanAndInvalid<uint32_t, CacheLine::SINGLE_CACHE_LINE, DcciDst::CACHELINE_OUT>(rcvMsgGm);
#else
        DataCacheCleanAndInvalid<uint32_t, CacheLine::SINGLE_CACHE_LINE>(rcvMsgGm);
#endif
        return msg;
    }

    __aicore__ inline void IncreaseRcv() { rcvMsgPos_ = (rcvMsgPos_ + 1) % DUMP_MSG_CNT; }

    __aicore__ inline void IncreaseSnd() { sndMsgPos_ = (sndMsgPos_ + 1) % DUMP_MSG_CNT; }

    __aicore__ inline uint32_t GetSendPos() { return sndMsgPos_; }

    __aicore__ inline uint32_t GetRcvPos() { return rcvMsgPos_; }

    __aicore__ inline uint64_t GetMsgBody() { return reinterpret_cast<uint64_t>(msgBody_); }

private:
    __gm__ KfcDumpMsgBody* msgBody_ = nullptr;
    __gm__ KfcDumpStatMsg* msgSndArea_ = nullptr;
    __gm__ KfcDumpStatMsg* msgRcvArea_ = nullptr;

    // 记录每个消息队列的位置
    uint32_t rcvMsgPos_ = 0;
    uint32_t sndMsgPos_ = 0;
};

} // namespace KfcDumpStat

#endif // __KFC_DUMP_SERVER_H__