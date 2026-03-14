/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "stub_server_msg_impl.h"
#include "inc/version_verify.h"
#include "inc/internal_api.h"

namespace tsd {
void StubServerMsgImpl::DefaultVersionNegotiateMsgProc(struct drvHdcMsg *msg, HdcBufferInfo *buf,
    const HDCMessage &sendStoreMsg)
{
    HDCMessage rspMsg;
    VersionVerify tempVersionInfo;
    tempVersionInfo.ParseVersionInfo(sendStoreMsg.version_info());
    tempVersionInfo.SetVersionInfo(rspMsg);
    rspMsg.set_type(HDCMessage::TEST_HDC_RSP);
    StubServerMsgImpl::CovertProtoMsgToHdcMsg(msg, rspMsg, buf);
}

void StubServerMsgImpl::DefaultCapabilityGetMsgProc(struct drvHdcMsg *msg, HdcBufferInfo *buf,
    const HDCMessage &sendStoreMsg)
{
    HDCMessage rspMsg;
    rspMsg.set_type(HDCMessage::TSD_GET_SUPPORT_CAPABILITY_LEVEL_RSP);
    rspMsg.set_tsd_rsp_code(0U);
    rspMsg.set_real_device_id(sendStoreMsg.real_device_id());
    rspMsg.set_capability_level(0U);
    StubServerMsgImpl::CovertProtoMsgToHdcMsg(msg, rspMsg, buf);
}

void StubServerMsgImpl::CovertProtoMsgToHdcMsg(struct drvHdcMsg *msg, const HDCMessage &rspMsg, HdcBufferInfo *buf)
{
    const uint32_t msgSize = static_cast<uint32_t>(rspMsg.ByteSizeLong());
    buf->bufferLen = msgSize + 12U;
    buf->segCnt = 0;
    buf->type = 0;
    char *dstPtr = &(buf->buffer[0]);
    rspMsg.SerializePartialToArray(dstPtr, static_cast<int32_t>(msgSize));
    msg->bufList[0].pBuf = reinterpret_cast<char *>(buf);
    msg->bufList[0].len = static_cast<int32_t>(buf->bufferLen);
}

void StubServerMsgImpl::DefaultStartProcMsgProc(struct drvHdcMsg *msg, HdcBufferInfo *buf,
    const HDCMessage &sendStoreMsg)
{
    HDCMessage rspMsg;
    rspMsg.set_type(HDCMessage::TSD_START_PROC_RSP);
    rspMsg.set_tsd_rsp_code(0U);
    rspMsg.set_real_device_id(sendStoreMsg.real_device_id());
    StubServerMsgImpl::CovertProtoMsgToHdcMsg(msg, rspMsg, buf);
}

void StubServerMsgImpl::DefaultCloseProcMsgProc(struct drvHdcMsg *msg, HdcBufferInfo *buf,
    const HDCMessage &sendStoreMsg)
{
    HDCMessage rspMsg;
    rspMsg.set_type(HDCMessage::TSD_CLOSE_PROC_RSP);
    rspMsg.set_tsd_rsp_code(0U);
    rspMsg.set_real_device_id(sendStoreMsg.real_device_id());
    StubServerMsgImpl::CovertProtoMsgToHdcMsg(msg, rspMsg, buf);
}

void StubServerMsgImpl::DefaultUpdateProfilingModeMsgProc(struct drvHdcMsg *msg, HdcBufferInfo *buf,
    const HDCMessage &sendStoreMsg)
{
    HDCMessage rspMsg;
    rspMsg.set_type(HDCMessage::TSD_UPDATE_PROIFILING_RSP);
    rspMsg.set_tsd_rsp_code(0U);
    rspMsg.set_real_device_id(sendStoreMsg.real_device_id());
    StubServerMsgImpl::CovertProtoMsgToHdcMsg(msg, rspMsg, buf);
}

int32_t StubServerMsgImpl::StubMsProfReportCallBack(uint32_t moduleId, uint32_t type, void *data, uint32_t len)
{
    (void)(moduleId);
    (void)(type);
    (void)(data);
    (void)(len);
    return 0;
}

void StubServerMsgImpl::DefaultInitQsMsgProc(struct drvHdcMsg *msg, HdcBufferInfo *buf,
    const HDCMessage &sendStoreMsg)
{
    HDCMessage rspMsg;
    rspMsg.set_type(HDCMessage::TSD_START_PROC_RSP);
    rspMsg.set_tsd_rsp_code(0U);
    rspMsg.set_real_device_id(sendStoreMsg.real_device_id());
    StubServerMsgImpl::CovertProtoMsgToHdcMsg(msg, rspMsg, buf);
}

void StubServerMsgImpl::DefaultGetPidQosMsgProc(struct drvHdcMsg *msg, HdcBufferInfo *buf,
    const HDCMessage &sendStoreMsg)
{
    HDCMessage rspMsg;
    rspMsg.set_type(HDCMessage::TSD_GET_PID_QOS_RSP);
    rspMsg.set_tsd_rsp_code(0U);
    rspMsg.set_real_device_id(sendStoreMsg.real_device_id());
    rspMsg.set_pid_of_qos(1U);
    StubServerMsgImpl::CovertProtoMsgToHdcMsg(msg, rspMsg, buf);
}

void StubServerMsgImpl::DefaultSupportOmInnerDecMsgProc(struct drvHdcMsg *msg, HdcBufferInfo *buf,
    const HDCMessage &sendStoreMsg)
{
    HDCMessage rspMsg;
    rspMsg.set_type(HDCMessage::TSD_SUPPORT_OM_INNER_DEC_RSP);
    rspMsg.set_tsd_rsp_code(0U);
    rspMsg.set_real_device_id(sendStoreMsg.real_device_id());
    StubServerMsgImpl::CovertProtoMsgToHdcMsg(msg, rspMsg, buf);
}

void StubServerMsgImpl::DefaultOutGetSupportLevelMsgProc(struct drvHdcMsg *msg, HdcBufferInfo *buf,
    const HDCMessage &sendStoreMsg)
{
    HDCMessage rspMsg;
    rspMsg.set_type(HDCMessage::TSD_GET_SUPPORT_CAPABILITY_LEVEL_RSP);
    rspMsg.set_tsd_rsp_code(0U);
    rspMsg.set_real_device_id(sendStoreMsg.real_device_id());
    uint32_t curSupport = 0U;
    TSD_BITMAP_SET(curSupport, TSD_SUPPORT_ADPROF_BIT);
    TSD_BITMAP_SET(curSupport, TSD_SUPPORT_MUL_HCCP);
    TSD_BITMAP_SET(curSupport, TSD_SUPPORT_BUILTIN_UDF_BIT);
    TSD_BITMAP_SET(curSupport, TSD_SUPPORT_CLOSE_LIST_BIT);
    TSD_BITMAP_SET(curSupport, TSD_SUPPORT_HS_AISERVER_FEATURE_BIT);
    rspMsg.set_capability_level(curSupport);
    StubServerMsgImpl::CovertProtoMsgToHdcMsg(msg, rspMsg, buf);
}

void StubServerMsgImpl::DefaultRemoveFileMsgProc(struct drvHdcMsg *msg, HdcBufferInfo *buf,
    const HDCMessage &sendStoreMsg)
{
    HDCMessage rspMsg;
    rspMsg.set_type(HDCMessage::TSD_REMOVE_FILE_RSP);
    rspMsg.set_tsd_rsp_code(0U);
    rspMsg.set_real_device_id(sendStoreMsg.real_device_id());
    StubServerMsgImpl::CovertProtoMsgToHdcMsg(msg, rspMsg, buf);
}

void StubServerMsgImpl::DefaultLoadRuntimePkgMsgProc(struct drvHdcMsg *msg, HdcBufferInfo *buf,
    const HDCMessage &sendStoreMsg)
{
    HDCMessage rspMsg;
    rspMsg.set_type(HDCMessage::TSD_GET_DEVICE_RUNTIME_CHECKCODE_RSP);
    rspMsg.set_tsd_rsp_code(0U);
    rspMsg.set_real_device_id(sendStoreMsg.real_device_id());
    rspMsg.set_check_code(sendStoreMsg.check_code());
    StubServerMsgImpl::CovertProtoMsgToHdcMsg(msg, rspMsg, buf);
}

void StubServerMsgImpl::DefaultLoadDshapePkgMsgProc(struct drvHdcMsg *msg, HdcBufferInfo *buf,
    const HDCMessage &sendStoreMsg)
{
    HDCMessage rspMsg;
    rspMsg.set_type(HDCMessage::TSD_GET_DEVICE_DSHAPE_CHECKCODE_RSP);
    rspMsg.set_tsd_rsp_code(0U);
    rspMsg.set_real_device_id(sendStoreMsg.real_device_id());
    rspMsg.set_check_code(sendStoreMsg.check_code());
    StubServerMsgImpl::CovertProtoMsgToHdcMsg(msg, rspMsg, buf);
}

void StubServerMsgImpl::DefaultProcessOpenMsgProc(struct drvHdcMsg *msg, HdcBufferInfo *buf,
    const HDCMessage &sendStoreMsg)
{
    HDCMessage rspMsg;
    rspMsg.set_type(HDCMessage::TSD_OPEN_SUB_PROC_RSP);
    rspMsg.set_tsd_rsp_code(0U);
    rspMsg.set_real_device_id(sendStoreMsg.real_device_id());
    rspMsg.set_helper_sub_pid(getpid());
    StubServerMsgImpl::CovertProtoMsgToHdcMsg(msg, rspMsg, buf);
}
    
void StubServerMsgImpl::DefaultProcessCloseMsgProc(struct drvHdcMsg *msg, HdcBufferInfo *buf,
    const HDCMessage &sendStoreMsg)
{
    HDCMessage rspMsg;
    rspMsg.set_type(HDCMessage::TSD_CLOSE_SUB_PROC_RSP);
    rspMsg.set_tsd_rsp_code(0U);
    rspMsg.set_real_device_id(sendStoreMsg.real_device_id());
    StubServerMsgImpl::CovertProtoMsgToHdcMsg(msg, rspMsg, buf);
}        

void StubServerMsgImpl::DefaultGetStatusMsgProc(struct drvHdcMsg *msg, HdcBufferInfo *buf,
    const HDCMessage &sendStoreMsg)
{
    HDCMessage rspMsg;
    rspMsg.set_type(HDCMessage::TSD_GET_SUB_PROC_STATUS_RSP);
    rspMsg.set_tsd_rsp_code(0U);
    rspMsg.set_real_device_id(sendStoreMsg.real_device_id());
    for (auto index = 0; index < sendStoreMsg.sub_proc_status_list_size(); index++) {
        SubProcStatus *rspStatus = rspMsg.add_sub_proc_status_list();
        rspStatus->set_sub_proc_pid(sendStoreMsg.sub_proc_status_list(index).sub_proc_pid());
        rspStatus->set_proc_status(0U);
    }
    StubServerMsgImpl::CovertProtoMsgToHdcMsg(msg, rspMsg, buf);
}

void StubServerMsgImpl::DefaultCloseListMsgProc(struct drvHdcMsg *msg, HdcBufferInfo *buf,
    const HDCMessage &sendStoreMsg)
{
    HDCMessage rspMsg;
    rspMsg.set_type(HDCMessage::TSD_CLOSE_SUB_PROC_LIST_RSP);
    rspMsg.set_tsd_rsp_code(0U);
    rspMsg.set_real_device_id(sendStoreMsg.real_device_id());
    StubServerMsgImpl::CovertProtoMsgToHdcMsg(msg, rspMsg, buf);
}

}
