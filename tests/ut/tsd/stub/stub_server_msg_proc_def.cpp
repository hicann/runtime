/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "tsd/status.h"
#include "proto/tsd_message.pb.h"
#include "stub_server_msg_impl.h"
#include "stub_server_reply.h"
#include "stub_server_msg_proc_def.h"

namespace tsd {
void StubServerMsgProcDef::RegisterTsdOpenMsgDefaultCallBack()
{
    StubServerReply* subReply = StubServerReply::GetInstance();
    subReply->RegisterCallBack(HDCMessage::TEST_HDC_SEND, &StubServerMsgImpl::DefaultVersionNegotiateMsgProc);
    subReply->RegisterCallBack(HDCMessage::TSD_GET_SUPPORT_CAPABILITY_LEVEL,
        &StubServerMsgImpl::DefaultCapabilityGetMsgProc);
    subReply->RegisterCallBack(HDCMessage::TSD_START_PROC_MSG, &StubServerMsgImpl::DefaultStartProcMsgProc);
    subReply->RegisterCallBack(HDCMessage::TSD_CLOSE_PROC_MSG, &StubServerMsgImpl::DefaultCloseProcMsgProc);
}

void StubServerMsgProcDef::RegisterUpdateProfilingModeMsgDefaultCallBack()
{
    StubServerReply* subReply = StubServerReply::GetInstance();
    subReply->RegisterCallBack(HDCMessage::TEST_HDC_SEND, &StubServerMsgImpl::DefaultVersionNegotiateMsgProc);
    subReply->RegisterCallBack(HDCMessage::TSD_GET_SUPPORT_CAPABILITY_LEVEL,
        &StubServerMsgImpl::DefaultCapabilityGetMsgProc);
    subReply->RegisterCallBack(HDCMessage::TSD_START_PROC_MSG, &StubServerMsgImpl::DefaultStartProcMsgProc);
    subReply->RegisterCallBack(HDCMessage::TSD_CLOSE_PROC_MSG, &StubServerMsgImpl::DefaultCloseProcMsgProc);
    subReply->RegisterCallBack(HDCMessage::TSD_UPDATE_PROIFILING_MSG, &StubServerMsgImpl::DefaultUpdateProfilingModeMsgProc);
}

void StubServerMsgProcDef::RegisterTsdInitQsMsgDefaultCallBack()
{
    StubServerReply* subReply = StubServerReply::GetInstance();
    subReply->RegisterCallBack(HDCMessage::TEST_HDC_SEND, &StubServerMsgImpl::DefaultVersionNegotiateMsgProc);
    subReply->RegisterCallBack(HDCMessage::TSD_GET_SUPPORT_CAPABILITY_LEVEL,
        &StubServerMsgImpl::DefaultCapabilityGetMsgProc);
    subReply->RegisterCallBack(HDCMessage::TSD_START_QS_MSG, &StubServerMsgImpl::DefaultInitQsMsgProc);
    subReply->RegisterCallBack(HDCMessage::TSD_CLOSE_PROC_MSG, &StubServerMsgImpl::DefaultCloseProcMsgProc);
}

void StubServerMsgProcDef::RegisterGetPidQosMsgDefaultCallBack()
{
    StubServerReply* subReply = StubServerReply::GetInstance();
    subReply->RegisterCallBack(HDCMessage::TEST_HDC_SEND, &StubServerMsgImpl::DefaultVersionNegotiateMsgProc);
    subReply->RegisterCallBack(HDCMessage::TSD_GET_PID_QOS, &StubServerMsgImpl::DefaultGetPidQosMsgProc);
    subReply->RegisterCallBack(HDCMessage::TSD_START_PROC_MSG, &StubServerMsgImpl::DefaultStartProcMsgProc);
    subReply->RegisterCallBack(HDCMessage::TSD_CLOSE_PROC_MSG, &StubServerMsgImpl::DefaultCloseProcMsgProc);
}

void StubServerMsgProcDef::RegisterGetOmInnerDecMsgDefaultCallBack()
{
    StubServerReply* subReply = StubServerReply::GetInstance();
    subReply->RegisterCallBack(HDCMessage::TEST_HDC_SEND, &StubServerMsgImpl::DefaultVersionNegotiateMsgProc);
    subReply->RegisterCallBack(HDCMessage::TSD_SUPPORT_OM_INNER_DEC,
        &StubServerMsgImpl::DefaultSupportOmInnerDecMsgProc);
    subReply->RegisterCallBack(HDCMessage::TSD_START_PROC_MSG, &StubServerMsgImpl::DefaultStartProcMsgProc);
    subReply->RegisterCallBack(HDCMessage::TSD_CLOSE_PROC_MSG, &StubServerMsgImpl::DefaultCloseProcMsgProc);
}

void StubServerMsgProcDef::RegisterGetCapabilityLevelMsgDefaultCallBack()
{
    StubServerReply* subReply = StubServerReply::GetInstance();
    subReply->RegisterCallBack(HDCMessage::TEST_HDC_SEND, &StubServerMsgImpl::DefaultVersionNegotiateMsgProc);
    subReply->RegisterCallBack(HDCMessage::TSD_GET_SUPPORT_CAPABILITY_LEVEL,
        &StubServerMsgImpl::DefaultOutGetSupportLevelMsgProc);
    subReply->RegisterCallBack(HDCMessage::TSD_START_PROC_MSG, &StubServerMsgImpl::DefaultStartProcMsgProc);
    subReply->RegisterCallBack(HDCMessage::TSD_CLOSE_PROC_MSG, &StubServerMsgImpl::DefaultCloseProcMsgProc);
}

void StubServerMsgProcDef::RegisterTsdFileLoadAndUnLoadMsgDefaultCallBack()
{
    StubServerReply* subReply = StubServerReply::GetInstance();
    subReply->RegisterCallBack(HDCMessage::TEST_HDC_SEND, &StubServerMsgImpl::DefaultVersionNegotiateMsgProc);
    subReply->RegisterCallBack(HDCMessage::TSD_GET_SUPPORT_CAPABILITY_LEVEL,
        &StubServerMsgImpl::DefaultOutGetSupportLevelMsgProc);
    subReply->RegisterCallBack(HDCMessage::TSD_REMOVE_FILE, &StubServerMsgImpl::DefaultRemoveFileMsgProc);
    subReply->RegisterCallBack(HDCMessage::TSD_GET_DEVICE_RUNTIME_CHECKCODE,
        &StubServerMsgImpl::DefaultLoadRuntimePkgMsgProc);
    subReply->RegisterCallBack(HDCMessage::TSD_GET_DEVICE_DSHAPE_CHECKCODE,
        &StubServerMsgImpl::DefaultLoadDshapePkgMsgProc);
}

void StubServerMsgProcDef::RegisterTsdProcessOpenQueryCloseMsgDefaultCallBack()
{
    StubServerReply* subReply = StubServerReply::GetInstance();
    subReply->RegisterCallBack(HDCMessage::TEST_HDC_SEND, &StubServerMsgImpl::DefaultVersionNegotiateMsgProc);
    subReply->RegisterCallBack(HDCMessage::TSD_GET_SUPPORT_CAPABILITY_LEVEL,
        &StubServerMsgImpl::DefaultOutGetSupportLevelMsgProc);
    subReply->RegisterCallBack(HDCMessage::TSD_OPEN_SUB_PROC, &StubServerMsgImpl::DefaultProcessOpenMsgProc);
    subReply->RegisterCallBack(HDCMessage::TSD_CLOSE_SUB_PROC, &StubServerMsgImpl::DefaultProcessCloseMsgProc);
    subReply->RegisterCallBack(HDCMessage::TSD_GET_SUB_PROC_STATUS, &StubServerMsgImpl::DefaultGetStatusMsgProc);
}

void StubServerMsgProcDef::RegisterTsdProcessListOpenQueryCloseMsgDefaultCallBack()
{
    StubServerReply* subReply = StubServerReply::GetInstance();
    subReply->RegisterCallBack(HDCMessage::TEST_HDC_SEND, &StubServerMsgImpl::DefaultVersionNegotiateMsgProc);
    subReply->RegisterCallBack(HDCMessage::TSD_GET_SUPPORT_CAPABILITY_LEVEL,
        &StubServerMsgImpl::DefaultOutGetSupportLevelMsgProc);
    subReply->RegisterCallBack(HDCMessage::TSD_OPEN_SUB_PROC, &StubServerMsgImpl::DefaultProcessOpenMsgProc);
    subReply->RegisterCallBack(HDCMessage::TSD_CLOSE_SUB_PROC_LIST, &StubServerMsgImpl::DefaultCloseListMsgProc);
    subReply->RegisterCallBack(HDCMessage::TSD_GET_SUB_PROC_STATUS, &StubServerMsgImpl::DefaultGetStatusMsgProc);
}
}