/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "aicpusd_op_executor.h"
#include <cstring>
#include <securec.h>
#include "aicpusd_info.h"
#include "aicpu_engine.h"
#include "aicpu_context.h"
#include "aicpusd_monitor.h"
#include "aicpusd_status.h"
namespace AicpuSchedule {
CustomOpExecutor &CustomOpExecutor::GetInstance()
{
    static CustomOpExecutor instance;
    return instance;
}

void CustomOpExecutor::InitOpExecutor(const pid_t pid, const std::string &custSoPath)
{
    hostPid_ = pid;
    aicpusd_run_info("Cust so path is %s.", custSoPath.c_str());
}

int32_t CustomOpExecutor::OpenKernelSo(const event_info_priv &privEventInfo) const
{
    const uint32_t soNameLen = privEventInfo.msg_len;
    if ((soNameLen == 0U) || (soNameLen > MAX_CUST_SO_NAME_LEN)) {
        aicpusd_err("Input param custom so name length is zero or max reached(%u), soNameBufLen=%u.",
                    MAX_CUST_SO_NAME_LEN, soNameLen);
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }

    // custom so name
    const std::string customSoName(privEventInfo.msg, static_cast<size_t>(soNameLen));
    // load so
    const uint32_t loadSoCnt = 1U;
    const char_t *soNames[loadSoCnt] = {customSoName.c_str()};
    const aeStatus_t ret = aeBatchLoadKernelSo(static_cast<uint32_t>(aicpu::KERNEL_TYPE_AICPU_CUSTOM),
                                               loadSoCnt, &(soNames[0]));
    if (ret != AE_STATUS_SUCCESS) {
        aicpusd_err("Failed to OpenSingleSo, customSoName[%s].", customSoName.c_str());
        return static_cast<int32_t>(ret);
    }
    aicpusd_info("Open custom so handle success, customSoName=%s.", customSoName.c_str());
    return AICPU_SCHEDULE_OK;
}

int32_t CustomOpExecutor::OpenKernelSoByAicpuEvent(const struct TsdSubEventInfo * const msg)
{
    if (msg == nullptr) {
        aicpusd_err("open custom so msg is null");
        return AicpuSchedule::AICPU_SCHEDULE_ERROR_INNER_ERROR;
    }
    event_info_priv privEventInfo = { };
    const errno_t errRet = strcpy_s(privEventInfo.msg, EVENT_MAX_MSG_LEN, msg->priMsg);
    if (errRet != EOK) {
        aicpusd_err("Copy %s failed, error[%d]", msg->priMsg, errRet);
        return AicpuSchedule::AICPU_SCHEDULE_ERROR_INNER_ERROR;
    }
    privEventInfo.msg_len = strnlen(privEventInfo.msg, MAX_CUST_SO_NAME_LEN);
    return CustomOpExecutor::GetInstance().OpenKernelSo(privEventInfo);
}

int32_t CustomOpExecutor::ExecuteKernel(aicpu::HwtsTsKernel &tsKernelInfo) const
{
    const auto ret = aeCallInterface(&tsKernelInfo);
    if ((ret == AE_STATUS_SUCCESS) ||
        (ret == AE_STATUS_END_OF_SEQUENCE) ||
        (ret == AE_STATUS_TASK_WAIT)) {
        aicpusd_info("Aicpu cust engine process success.");
    } else {
        aicpusd_err("Aicpu cust engine process failed, result[%d].", static_cast<int32_t>(ret));
    }
    return static_cast<int32_t>(ret);
}
}