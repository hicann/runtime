/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "plog_core.h"
#include "log_error_code.h"
#include "log_platform.h"
#include "plog_drv.h"
#include "log_print.h"
#include "dlog_common.h"
#include "dlog_attr.h"
#include "plog_driver_log.h"
#include "plog_host_log.h"
#include "plog_device_log.h"
#include "plog_file_mgr.h"
#include "plog_to_dlog.h"

#ifdef __cplusplus
extern "C" {
#endif

STATIC bool g_isWorkerMachine = false;

/**
 * @brief       : init resource for host log(plog)
 * @param [in]  : isDrvExist        driver need to printf log by plog or not
 * @return      : LOG_SUCCESS  success; other  failed
 */
STATIC LogStatus PlogInitHostLog(bool isDrvExist)
{
    LogStatus ret = PlogFileMgrInit();
    ONE_ACT_ERR_LOG(ret != LOG_SUCCESS, return LOG_FAILURE, "init plog file list failed, ret=%d.", ret);
    ret = PlogHostMgrInit();
    ONE_ACT_ERR_LOG(ret != LOG_SUCCESS, return LOG_FAILURE, "init plog host resource failed, ret=%d.", ret);

    if (isDrvExist) {
        PlogRegisterDriverLog(); // register DlogInner function to Hal
    }

    return LOG_SUCCESS;
}

/**
 * @brief       : free resource for host log
 * @param [in]  : isDrvExist        driver need to printf log by plog or not
 */
STATIC void PlogFreeHostLog(bool isDrvExist)
{
    if (isDrvExist) {
        PlogUnregisterDriverLog(); // unregister DlogInner function to Hal
    }

    PlogHostMgrExit();
    PlogFileMgrExit();
}

/**
 * @brief       : check platform is real host or not
 * @return      : true  EP_HOST; false  not EP_HOST
 */
STATIC bool PlogCheckRealHost(void)
{
    uint32_t num = 0;
    int32_t ret = DrvGetDevNum(&num);
    return ((ret == 0) && (num != 0)) ? true : false;
}

/**
 * @brief       : init resource when platform is HOST_SIDE
 * @return      : 0  success; other  failed
 */
STATIC int32_t PlogInitForPlatformHost(void)
{
    if (PlogCheckRealHost()) {
        // EP host
        LogStatus ret = PlogInitHostLog(true);
        TWO_ACT_ERR_LOG(ret != LOG_SUCCESS, PlogFreeHostLog(true), return -1, "init host log failed, ret=%d.", ret);
        ret = PlogDeviceMgrInit();
        if (ret != LOG_SUCCESS) {
            PlogDeviceMgrExit();
            PlogFreeHostLog(true);
            SELF_LOG_ERROR("init device log failed, ret=%d.", ret);
            return -1;
        }
        SELF_LOG_INFO("Log init finished for process, platform is host, init host and device.");
    } else {
        // 51helper、headfwk、pooling
        LogStatus ret = PlogInitHostLog(true);
        TWO_ACT_ERR_LOG(ret != LOG_SUCCESS, PlogFreeHostLog(true), return -1, "init host log failed, ret=%d.", ret);
        SELF_LOG_INFO("Log init finished for process, platform is host, only init host.");
    }

    return 0;
}

/**
 * @brief ProcessLogInit: init log file list, register callback, create hdc client
 * @return 0: succeed; -1: failed
 *    if return failed, the function will release init resource before return
 */
CONSTRUCTOR int32_t ProcessLogInit(void)
{
    if (PlogTransferToUnifiedlog() == LOG_SUCCESS) {
        return 0;
    }
    // 1. dlopen libascend_hal.so
    if (DrvFunctionsInit() != 0) {
        SELF_LOG_WARN("can not load driver library, treat as worker machine");
        g_isWorkerMachine = true;

        int32_t ret = PlogInitHostLog(false);
        TWO_ACT_ERR_LOG(ret != LOG_SUCCESS, PlogFreeHostLog(false), return -1, "init host log failed, ret=%d.", ret);
        SELF_LOG_INFO("Log init finished for process, without driver library.");
        return 0;
    }

    // 2. get platform info by driver, base on platform to init
    uint32_t platform = PLATFORM_INVALID_VALUE;
    ONE_ACT_ERR_LOG(DrvGetPlatformInfo(&platform) != 0, return -1, "get platform info failed.");

    if (platform == DEVICE_SIDE) {
        SELF_LOG_INFO("Log init finished for process, platform is device, init nothing.");
    } else if (platform == HOST_SIDE) {
        return PlogInitForPlatformHost();
    } else {
        // compiler machine
        int32_t ret = PlogInitHostLog(true);
        TWO_ACT_ERR_LOG(ret != LOG_SUCCESS, PlogFreeHostLog(true), return -1, "init host log failed, ret=%d.", ret);
        SELF_LOG_INFO("Log init finished for process, platform is [%u], only init host log.", platform);
    }

    return 0;
}

/**
 * @brief ProcessLogFree: free log file list, close hdc client
 * @return 0: succeed; -1: failed
 */
DESTRUCTOR int32_t ProcessLogFree(void)
{
    if (PlogCloseUnifiedlog() == LOG_SUCCESS) {
        return 0;
    }
    if (g_isWorkerMachine) {
        PlogFreeHostLog(false);
        SELF_LOG_INFO("Log uninit finished, without driver library.");
        return 0;
    }

    uint32_t platform = PLATFORM_INVALID_VALUE;
    TWO_ACT_ERR_LOG(DrvGetPlatformInfo(&platform) != 0,
                    (void)DrvFunctionsUninit(), return -1, "get platform info failed.");
    TWO_ACT_INFO_LOG((platform != PLATFORM_INVALID_VALUE) && (platform != HOST_SIDE), (void)DrvFunctionsUninit(),
                     return 0, "can't support platform[%u], only support host.", platform);

    // call PlogUnregisterDriverLog before free device resources,
    // avoid HDC print ERROR log to /root/ascend/plog when process destructor
    PlogUnregisterDriverLog();
    PlogDeviceMgrExit();
    PlogFreeHostLog(false);
    (void)DrvFunctionsUninit();
    SELF_LOG_INFO("Log uninit finished.");
    return 0;
}

#ifdef __cplusplus
}
#endif