/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef TSD_STUB_SERVER_MSG_IMPL_H
#define TSD_STUB_SERVER_MSG_IMPL_H

#include "tsd/status.h"
#include "proto/tsd_message.pb.h"
#include "driver/ascend_hal.h"

namespace tsd {

const uint32_t DEFAULT_HDC_BUFFER_CNT = 5 *1024U;
struct HdcBufferInfo {
    uint32_t bufferLen;
    int32_t segCnt;
    uint32_t type;
    char buffer[DEFAULT_HDC_BUFFER_CNT];
};

class StubServerMsgImpl {
public:
    StubServerMsgImpl() = default;
    
    virtual ~StubServerMsgImpl() = default;
    
    StubServerMsgImpl(const StubServerMsgImpl&) = delete;

    StubServerMsgImpl(StubServerMsgImpl&&) = delete;

    StubServerMsgImpl& operator=(const StubServerMsgImpl&) = delete;
    
    StubServerMsgImpl& operator=(StubServerMsgImpl&) = delete;

    StubServerMsgImpl& operator=(StubServerMsgImpl&&) = delete;

    static void DefaultVersionNegotiateMsgProc(struct drvHdcMsg *msg, HdcBufferInfo *buf,
        const HDCMessage &sendStoreMsg);

    static void DefaultCapabilityGetMsgProc(struct drvHdcMsg *msg, HdcBufferInfo *buf,
        const HDCMessage &sendStoreMsg);

    static void DefaultStartProcMsgProc(struct drvHdcMsg *msg, HdcBufferInfo *buf,
        const HDCMessage &sendStoreMsg);

    static void DefaultCloseProcMsgProc(struct drvHdcMsg *msg, HdcBufferInfo *buf,
        const HDCMessage &sendStoreMsg);

    static void DefaultUpdateProfilingModeMsgProc(struct drvHdcMsg *msg, HdcBufferInfo *buf,
        const HDCMessage &sendStoreMsg);

    static int32_t StubMsProfReportCallBack(uint32_t moduleId, uint32_t type, void *data, uint32_t len);

    static void DefaultInitQsMsgProc(struct drvHdcMsg *msg, HdcBufferInfo *buf,
        const HDCMessage &sendStoreMsg);

    static void DefaultGetPidQosMsgProc(struct drvHdcMsg *msg, HdcBufferInfo *buf,
        const HDCMessage &sendStoreMsg);

    static void DefaultSupportOmInnerDecMsgProc(struct drvHdcMsg *msg, HdcBufferInfo *buf,
        const HDCMessage &sendStoreMsg);
    
    static void DefaultOutGetSupportLevelMsgProc(struct drvHdcMsg *msg, HdcBufferInfo *buf,
        const HDCMessage &sendStoreMsg);
    
    static void DefaultRemoveFileMsgProc(struct drvHdcMsg *msg, HdcBufferInfo *buf,
        const HDCMessage &sendStoreMsg);

    static void DefaultLoadRuntimePkgMsgProc(struct drvHdcMsg *msg, HdcBufferInfo *buf,
        const HDCMessage &sendStoreMsg);

    static void DefaultLoadDshapePkgMsgProc(struct drvHdcMsg *msg, HdcBufferInfo *buf,
        const HDCMessage &sendStoreMsg);

    static void DefaultProcessOpenMsgProc(struct drvHdcMsg *msg, HdcBufferInfo *buf,
        const HDCMessage &sendStoreMsg);
    
    static void DefaultProcessCloseMsgProc(struct drvHdcMsg *msg, HdcBufferInfo *buf,
        const HDCMessage &sendStoreMsg);

    static void DefaultGetStatusMsgProc(struct drvHdcMsg *msg, HdcBufferInfo *buf,
        const HDCMessage &sendStoreMsg);
    
    static void DefaultCloseListMsgProc(struct drvHdcMsg *msg, HdcBufferInfo *buf,
        const HDCMessage &sendStoreMsg);
private:
    static void CovertProtoMsgToHdcMsg(struct drvHdcMsg *msg, const HDCMessage &rspMsg, HdcBufferInfo *buf);
};
}
#endif