/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "log_sys_get.h"
#include "ascend_hal.h"
#include "log_print.h"
#include "log_common.h"
#include "log_drv.h"
#include "log_session_manage.h"
#include "slogd_flush.h"
#include "log_communication.h"

#define MSG_STATUS_LONG_LINK    12

int32_t SysGetInit(void)
{
    return LOG_SUCCESS;
}

int32_t SysGetDestroy(void)
{
    return LOG_SUCCESS;
}

 /**
 * @brief       : send specified message to host
 * @param [in]  : handle     handle for communicating with the peer end
 * @param [in]  : msg        message to be sent
 * @param [in]  : len        length of message
 */
STATIC void SysGetReplyMsg(const CommHandle *handle, const char *msg, uint32_t len)
{
    if ((handle == NULL) || (msg == NULL)) {
        // need not send message this time
        return;
    }
    int32_t ret = AdxSendMsg(handle, msg, len);
    NO_ACT_ERR_LOG(ret != LOG_SUCCESS, "reply message to host failed, ret=%d, message=%s", ret, msg);
}

 /**
 * @brief       : check if peer end is docker by hdc interface
 * @param [in]  : handle     handle for communicating with the peer end
 * @return      : LOG_SUCCESS: not docker
 */
STATIC int32_t SysGetCheckContainer(const CommHandle *handle)
{
    int32_t runEnv = 0;
    int32_t ret = AdxGetAttrByCommHandle(handle, HDC_SESSION_ATTR_RUN_ENV, &runEnv);
    if (ret != LOG_SUCCESS) {
        SELF_LOG_ERROR("get run env failed, %d.", ret);
        return LOG_FAILURE;
    }
    if ((runEnv != RUN_ENV_PHYSICAL) && (runEnv != RUN_ENV_VIRTUAL)) {
        SysGetReplyMsg(handle, CONTAINER_NO_SUPPORT_MESSAGE, sizeof(CONTAINER_NO_SUPPORT_MESSAGE) + 1);
        SELF_LOG_WARN("prohibit container get log, runEnv=%d.", runEnv);
        return LOG_INVALID_PARAM;
    }
    return LOG_SUCCESS;
}

 /**
 * @brief       : single export process; add to session manager before flush, delete from session manager after flush
 * @param [in]  : handle     handle for communicating with the peer end
 * @return      : LOG_SUCCESS: success; others: fail
 */
STATIC int32_t SysGetSingleExport(const CommHandle *handle)
{
    SessionItem item;
    item.session = (void *)handle;
    item.type = SESSION_SINGLE_EXPORT;
    int32_t ret = SessionMgrAddSession(&item);
    if (ret == LOG_FAILURE) {
        SELF_LOG_ERROR("single export session overload.");
        return LOG_FAILURE;
    }

    SlogdFlushGet((void *)&item);

    if (SessionMgrDeleteSession(&item) == LOG_FAILURE) {
        SELF_LOG_ERROR("single export delete failed.");
        ret = LOG_FAILURE;
    }
    return ret;
}

 /**
 * @brief       : process messages sent from the peer end
 * @param [in]  : handle     handle for communicating with the peer end; destroy and free by the function
 * @param [in]  : value      structure containing the operation type
 * @param [in]  : len        length of value
 * @return      : LOG_SUCCESS: success; others: fail
 */
int32_t SysGetProcess(const CommHandle *handle, const void *value, uint32_t len)
{
    if (handle == NULL) {
        SELF_LOG_ERROR("invalid input, handle is null");
        return LOG_FAILURE;
    }
    if (value == NULL) {
        SELF_LOG_ERROR("invalid input, value is null");
        return LOG_FAILURE;
    }
    if  (len < sizeof(LogDataMsg)) {
        SELF_LOG_ERROR("invalid input, length of value is %u", len);
        return LOG_FAILURE;
    }

    int32_t ret = SysGetCheckContainer(handle);
    if (ret != LOG_SUCCESS) {
        if (ret == LOG_FAILURE) {
            return LOG_FAILURE;
        }
        return LOG_SUCCESS;
    }

    const LogDataMsg *msg = (const LogDataMsg *)value;
    const char *type = (const char *)msg->data;
    if (strncmp(type, SINGLE_EXPORT_LOG, strlen(SINGLE_EXPORT_LOG)) == 0) {
        ret = SysGetSingleExport(handle);
    } else {
        SELF_LOG_ERROR("invalid type input: %s", type);
        ret = LOG_FAILURE;
    }

    if (ret == LOG_SUCCESS) {
        SysGetReplyMsg(handle, HDC_END_MSG, strlen(HDC_END_MSG) + 1);
    }

    SELF_LOG_INFO("%s finished", type);
    return ret;
}