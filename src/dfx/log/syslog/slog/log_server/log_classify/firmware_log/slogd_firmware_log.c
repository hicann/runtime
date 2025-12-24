/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "slogd_firmware_log.h"
#include "log_recv.h"
#include "log_print.h"
#include "slogd_recv_core.h"
#include "slogd_flush.h"

static LogStatus SlogdFirmwareLogRegister(void)
{
    LogStatus ret = 0;
    LogReceiveNode recvNode = {FIRMWARE_LOG_PRIORITY, SlogdFirmwareLogReceive};
    ret = SlogdDevReceiveRegister(&recvNode);
    ONE_ACT_ERR_LOG(ret != LOG_SUCCESS, return LOG_FAILURE, "firm log register receive node failed, ret=%d.", ret);

    LogFlushNode flushNode = {DEVICE_THREAD_TYPE, FIRMWARE_LOG_PRIORITY, SlogdFirmwareLogFlush, SlogdFirmwareLogGet};
    ret = SlogdFlushRegister(&flushNode);
    ONE_ACT_ERR_LOG(ret != LOG_SUCCESS, return LOG_FAILURE, "firm log register flush node failed, ret=%d.", ret);

    return LOG_SUCCESS;
}

/**
 * @brief       : enable firmware log function
 * @return      : LOG_SUCCESS success; LOG_FAILURE failure
 */
LogStatus SlogdFirmwareLogInit(int32_t devId, bool isDocker)
{
    if (isDocker || (devId != -1)) {
        return LOG_SUCCESS;
    }
#ifdef GROUP_LOG
    InitChId2ModIdMapping();
#endif
    LogStatus ret = SlogdFirmwareLogResInit();
    if (ret != LOG_SUCCESS) {
        return LOG_FAILURE;
    }
    ret = SlogdFirmwareLogRegister();
    if (ret != LOG_SUCCESS) {
        return LOG_FAILURE;
    }
    return LOG_SUCCESS;
}

/**
 * @brief       : clear firmware log resource
 * @return      : NA
 */
void SlogdFirmwareLogExit(void)
{
    // nonexistent device will be ignored since there DeviceRes has been initialised to NULL
    SlogdFirmwareLogResExit();
    SELF_LOG_ERROR("quit firmware log");
}