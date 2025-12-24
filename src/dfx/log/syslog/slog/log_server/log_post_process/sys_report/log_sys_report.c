/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "log_sys_report.h"
#include "ascend_hal.h"
#include "log_print.h"
#include "log_common.h"
#include "log_drv.h"
#include "log_session_manage.h"
#include "slogd_flush.h"
#include "log_communication.h"

#define MSG_STATUS_LONG_LINK    12

#define CONTAINER_NO_SUPPORT_MESSAGE        "not support container environment"
#define CONNECT_OCCUPIED_MESSAGE            "The connection is occupied"
#define SERVER_RESULT_SUCCESS               0
#define SERVER_RESULT_CONTAINER             1
#define SERVER_RESULT_UNREGISTERED          2
#define SERVER_RESULT_OVERLOAD              3
#define SERVER_RESULT_EXECUTION_ERROR       4

int32_t SysReportInit(void)
{
    return LOG_SUCCESS;
}

int32_t SysReportDestroy(void)
{
    return LOG_SUCCESS;
}

 /**
 * @brief       : send specified message to host
 * @param [in]  : handle     handle for communicating with the peer end
 * @param [in]  : msg        message to be sent
 * @param [in]  : len        length of message
 */
STATIC void SysReportReplyMsg(const CommHandle *handle, const char *msg, uint32_t len)
{
    if ((handle == NULL) || (msg == NULL)) {
        // need not send message this time
        return;
    }
    int32_t ret = AdxSendMsg(handle, msg, len);
    NO_ACT_ERR_LOG(ret != LOG_SUCCESS, "reply message to host failed, ret=%d, message=%s", ret, msg);
}

 /**
 * @brief       : destroy handle by adx function
 * @param [in]  : handle     handle for communicating with the peer end
 */
STATIC void SysDestroyCommHandle(const CommHandle *handle)
{
    AdxDestroyCommHandle((CommHandle *)handle);
}

 /**
 * @brief       : check if peer end is docker by hdc interface
 * @param [in]  : handle     handle for communicating with the peer end
 * @return      : LOG_SUCCESS: not docker
 */
STATIC int32_t SysReportCheckContainer(const CommHandle *handle)
{
    int32_t runEnv = 0;
    int32_t ret = AdxGetAttrByCommHandle(handle, HDC_SESSION_ATTR_RUN_ENV, &runEnv);
    if (ret != LOG_SUCCESS) {
        SELF_LOG_ERROR("get run env failed, %d.", ret);
        return LOG_FAILURE;
    }
    if ((runEnv != RUN_ENV_PHYSICAL) && (runEnv != RUN_ENV_VIRTUAL)) {
        SysReportReplyMsg(handle, CONTAINER_NO_SUPPORT_MESSAGE, sizeof(CONTAINER_NO_SUPPORT_MESSAGE) + 1);
        SELF_LOG_WARN("prohibit container get log, runEnv=%d.", runEnv);
        return LOG_INVALID_PARAM;
    }
    return LOG_SUCCESS;
}

 /**
 * @brief       : continuous export process; add to session manager
 * @param [in]  : handle     handle for communicating with the peer end
 * @return      : LOG_SUCCESS: success; others: fail
 */
STATIC int32_t SysReportContinuousExport(const CommHandle *handle)
{
    SessionItem item;
    item.session = (void *)handle;
    item.type = SESSION_CONTINUES_EXPORT;
    int32_t ret = SessionMgrAddSession(&item);
    if (ret == LOG_FAILURE) {
        SELF_LOG_ERROR("add continuous export session failed.");
        return LOG_FAILURE;
    }
    return LOG_SUCCESS;
}

 /**
 * @brief       : process messages sent from the peer end
 * @param [in]  : handle     handle for communicating with the peer end; destroy and free by the function
 * @param [in]  : value      structure containing the operation type
 * @param [in]  : len        length of value
 * @return      : LOG_SUCCESS: success; others: fail
 */
int32_t SysReportProcess(const CommHandle *handle, const void *value, uint32_t len)
{
    if (handle == NULL) {
        SELF_LOG_ERROR("invalid input, handle is null");
        SysDestroyCommHandle(handle);
        return LOG_FAILURE;
    }
    if (value == NULL) {
        SELF_LOG_ERROR("invalid input, value is null");
        SysDestroyCommHandle(handle);
        return LOG_FAILURE;
    }
    if  (len < sizeof(LogDataMsg)) {
        SELF_LOG_ERROR("invalid input, length of value is %u", len);
        SysDestroyCommHandle(handle);
        return LOG_FAILURE;
    }

    int32_t ret = SysReportCheckContainer(handle);
    if (ret != LOG_SUCCESS) {
        SysDestroyCommHandle(handle);
        if (ret == LOG_FAILURE) {
            return LOG_FAILURE;
        }
        return LOG_SUCCESS;
    }

    const LogDataMsg *msg = (const LogDataMsg *)value;
    const char *type = (const char *)msg->data;
    if (msg->status == MSG_STATUS_LONG_LINK) {
        ret = SysReportContinuousExport(handle);
    } else {
        SELF_LOG_ERROR("invalid type input: %s", type);
        ret = LOG_FAILURE;
    }

    // the handle will not be used after it is successfully stored
    if (ret != LOG_SUCCESS) {
        SysReportReplyMsg(handle, CONNECT_OCCUPIED_MESSAGE, strlen(CONNECT_OCCUPIED_MESSAGE) + 1);
        SysDestroyCommHandle(handle);
    }

    SELF_LOG_INFO("%s finished", type);
    return ret;
}