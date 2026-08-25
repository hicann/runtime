/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "log/adx_log.h"
#include "adx_dump_process.h"
#include "extra_config.h"
#include "acl_dump.h"
#include "adump_error_manager.h"
#include "str_utils.h"

namespace Adx {
int32_t AdxRegDumpProcessCallBack(int32_t (*const messageCallback)(const Adx::DumpChunk*, int32_t))
{
    if (messageCallback == nullptr) {
        IDE_LOGE("The param MessageCallback is null, please check it!");
        return IDE_DAEMON_ERROR;
    }
    Adx::AdxDumpProcess::Instance().MessageCallbackRegister(messageCallback);
    IDE_LOGI("MessageCallback registered success!");
    return IDE_DAEMON_OK;
}

void AdxUnRegDumpProcessCallBack()
{
    Adx::AdxDumpProcess::Instance().MessageCallbackUnRegister();
    IDE_LOGI("MessageCallback unregistered success!");
}
} // namespace Adx

/**
 * @param messageCallback : record file Path
 * @param flag :  0 not save other is invalid
 * @return
 *
 * @retval ACL_SUCCESS The function is successfully executed.
 * @retval OtherValues Failure
 */
aclError acldumpRegCallback(int32_t (*const messageCallback)(const acldumpChunk*, int32_t), int32_t flag)
{
    if (messageCallback == nullptr) {
        REPORT_EP0007_NULL_POINTER(Adx::FUNC_NAME_ACL_DUMP_REG_CALLBACK, Adx::FUNC_ACL_DUMP_REG_CALLBACK_PARAM_CLBK);
        return ACL_ERROR_FAILURE;
    }

    if (flag != 0) {
        std::string flagStr = std::to_string(flag);
        std::string reason = Adx::StrUtils::Format(Adx::ADUMP_REASON_RESERVED_PARAM_MUST_EQUAL, "0");
        REPORT_EP0006_INVALID_ARGUMENT(
            Adx::FUNC_NAME_ACL_DUMP_REG_CALLBACK, flagStr, Adx::FUNC_ACL_DUMP_REG_CALLBACK_PARAM_FLAG, reason);
        return ACL_ERROR_FAILURE;
    }

    Adx::MessageCallback adxMessageCallback = reinterpret_cast<Adx::MessageCallback>(messageCallback);
    int32_t ret = Adx::AdxRegDumpProcessCallBack(adxMessageCallback);
    if (ret != IDE_DAEMON_OK) {
        return ACL_ERROR_FAILURE;
    }

    return ACL_SUCCESS;
}

void acldumpUnregCallback() { Adx::AdxUnRegDumpProcessCallBack(); }