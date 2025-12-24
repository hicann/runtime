/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "slogd_communication.h"
#include "slogd_recv_msg.h"
#include "log_print.h"


LogStatus SlogdCommunicationInit(void)
{
    LogStatus ret = SlogdInitGlobals();
    if (ret != LOG_SUCCESS) {
        return LOG_FAILURE;
    }

    // init communication server
    ret = SlogdRmtServerInit();
    if (ret != LOG_SUCCESS) {
        return LOG_FAILURE;
    }
    return LOG_SUCCESS;
}

void SlogdCommunicationExit(void)
{
    SlogdRmtServerExit();
    SlogdFreeGlobals();
}
