/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "ascend_hal.h"
#include "ide_daemon_monitor.h"

void appmon_client_exit(client_info_t *clnt)
{
    return;
}

int appmon_client_init(client_info_t *clnt, const char *serv_addr)
{
    return 0;
}

int appmon_client_deregister(client_info_t *clnt, const char *reason)
{
    return 0;
}

static int flag = 0;
int appmon_client_register(client_info_t *clnt, unsigned long timeout, const char *timeout_action)
{
    if (flag == 0) {
        flag++;
        return -1;
    } 

    return 0;
}

static int heartbeat = 0;
int appmon_client_heartbeat(client_info_t *clnt)
{
    heartbeat++;
    if (heartbeat <= 2) {
        return 0;
    }
    return 0;
}

