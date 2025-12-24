/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "log_pm_sr.h"

#ifdef SR_MONITOR
#include <sys/eventfd.h>
#include <stdatomic.h>
#include "iam.h"
#include "log_platform.h"
#include "log_print.h"
#include "log_system_api.h"
#ifndef AOS_PM_STATUS_FILE
#define AOS_PM_STATUS_FILE      "/proc/aos_pm/aos_suspend"
#endif
#define LPM_IOCTL_PASS_FD       0xfff2
#define TWO_HUNDRED_MILLISECOND 200 // 200ms

STATIC _Atomic enum SystemState g_systemState = OFF;

STATIC void SlogSysStateHandler(int32_t state)
{
    g_systemState = (enum SystemState)state;
    if (g_systemState == SLEEP) {
        (void)sync();
    }
}

int32_t RegisterSRNotifyCallback(void)
{
    return IamRegisterSystemService(SlogSysStateHandler);
}

enum SystemState GetSystemState(void)
{
    return g_systemState;
}

/**
 * @brief       : subscribe to wakeup event of aos and iam
 * @return      : NA
 */
void SlogdSubscribeToWakeUpState(void)
{
    static bool isSubscribed = false;
    if (!__sync_bool_compare_and_swap(&isSubscribed, false, true)) {
        return; // already subscribed
    }
    SELF_LOG_INFO("subscribe to wake up event start.");
    int32_t efd = -1;
    efd = eventfd(0U, EFD_NONBLOCK);
    TWO_ACT_ERR_LOG((efd < 0), ((void)__sync_lock_test_and_set(&isSubscribed, false)), return, "eventfd failed.");

    int32_t eventControl = ToolOpen(AOS_PM_STATUS_FILE, O_RDONLY);
    if ((eventControl < 0) || (ioctl(eventControl, LPM_IOCTL_PASS_FD, &efd) != 0)) {
        SELF_LOG_ERROR("pass the efd failed.");
        (void)ToolClose(efd);
        (void)ToolClose(eventControl);
        (void)ToolSleep(TWO_HUNDRED_MILLISECOND);
        (void)__sync_lock_test_and_set(&isSubscribed, false);
        return;
    }
    // receive wakeup from IAM, or receive wakeup from aos, break the loop
    while (g_systemState == SLEEP) {
        uint64_t eftdCtr = 0;
        int32_t ret = ToolRead(efd, &eftdCtr, (uint32_t)sizeof(uint64_t));
        if (ret == SYS_ERROR) {
            // read is interrupted by signal
            if (ToolGetErrorCode() == EINTR) {
                continue;
            }
            // no event, retry
            if (ToolGetErrorCode() == EAGAIN) {
                (void)ToolSleep(TWO_HUNDRED_MILLISECOND);
                continue;
            }
            SELF_LOG_ERROR("cannot read from eventfd: efd = %d, strerr = %s.", efd, strerror(ToolGetErrorCode()));
            break;
        }
        SELF_LOG_INFO("receive lpm notify.");
        g_systemState = WORKING;
        break;
    }
    LOG_CLOSE_FD(eventControl);
    LOG_CLOSE_FD(efd);
    (void)__sync_lock_test_and_set(&isSubscribed, false);
    SELF_LOG_INFO("subscribe to wake up event end.");
}
#else
int32_t RegisterSRNotifyCallback(void)
{
    return 0;
}

enum SystemState GetSystemState(void)
{
    return WORKING;
}

void SlogdSubscribeToWakeUpState(void)
{
    return;
}
#endif