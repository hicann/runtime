/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "log_hdc.h"
#include "mmpa_api.h"
#include "hdc_api.h"
#include "file_utils.h"
#include "log_session_manage.h"
#include "log_print.h"
#include "adcore_api.h"
namespace Adx {
static const std::string INSERT_MSG = "###[HDC_MSG]_DEVICE_FRAMEWORK_START_###";
static const std::string DELETE_MSG = "###[HDC_MSG]_DEVICE_FRAMEWORK_END_###";

int32_t LogHdc::Init()
{
    return SYS_OK;
}

int32_t LogHdc::Process(const CommHandle &handle, const SharedPtr<MsgProto> &proto)
{
    AdxCommHandle adxHandle = const_cast<AdxCommHandle>(&handle);
    TWO_ACT_ERR_LOG(proto->msgType != MsgType::MSG_DATA, AdxDestroyCommHandle(adxHandle),
        return SYS_OK, "receive non data message");
    TWO_ACT_ERR_LOG(handle.session == ADX_OPT_INVALID_HANDLE, AdxDestroyCommHandle(adxHandle),
        return SYS_ERROR, "handle or handle.session invalid");
    LogNotifyMsg *msg = reinterpret_cast<LogNotifyMsg *>(proto->data);
    std::string actionType((IdeString)msg->data);

    int32_t devId = 0;
    int32_t err = IdeGetDevIdBySession(reinterpret_cast<HDC_SESSION>(handle.session), &devId);
    if (err != SYS_OK) {
        AdxDestroyCommHandle(adxHandle);
        SELF_LOG_ERROR("get device id failed, %d", err);
        return SYS_ERROR;
    }

    // get pid from session
    int32_t pid = 0;
    err = IdeGetPidBySession(reinterpret_cast<HDC_SESSION>(handle.session), &pid);
    if (err != SYS_OK) {
        AdxDestroyCommHandle(adxHandle);
        SELF_LOG_ERROR("get pid failed, %d", err);
        return SYS_ERROR;
    }

    // update session-devId-pid data struct
    if (actionType == INSERT_MSG) {
        SELF_LOG_INFO("insert log session, pid %d devid %d", pid, devId);
        ONE_ACT_ERR_LOG(InsertSessionNode(handle.session, pid, devId) != SYS_OK, return SYS_ERROR,
            "insert log session node failed");
    } else if (actionType == DELETE_MSG) {
        SELF_LOG_INFO("delete log session, pid %d devid %d", pid, devId);
        int32_t flag = SYS_OK;
        SessionNode *node = GetSessionNode(pid, devId);
        if (node == NULL) {
            ONE_ACT_WARN_LOG(!IsSessionNodeListNull(), flag = SYS_ERROR, "get session node failed");
        } else {
            node->timeout = msg->timeout;
            ONE_ACT_ERR_LOG(DeleteSessionNode(node->session, pid, devId) != SYS_OK,
                flag = SYS_ERROR, "delete log session node failed");
        }
        AdxDestroyCommHandle(adxHandle);
        return flag;
    } else {
        AdxDestroyCommHandle(adxHandle);
        SELF_LOG_ERROR("invalid session node operate type, %s", actionType.c_str());
        return SYS_ERROR;
    }
    return SYS_OK;
}

int32_t LogHdc::UnInit()
{
    return SYS_OK;
}
}
