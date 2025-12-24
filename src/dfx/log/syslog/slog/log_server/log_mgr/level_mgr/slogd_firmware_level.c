/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "slogd_firmware_level.h"
#include "operate_loglevel.h"
#include "ascend_hal.h"
#include "log_level_parse.h"
#include "log_print.h"

#ifdef OS_SLOG

#include <sys/ioctl.h>
#define LEVEL_CONFIG_BUF_SIZE   56U
#define MODULE_ID_NUM           64U
#define SET_CONFIG_RES_SIZE     12U

struct SlogSetConfig{
    uint32_t level;
    uint32_t levelMagic;
    uint32_t res[SET_CONFIG_RES_SIZE];
};

struct SlogConfigMsg{
    uint32_t modId;
    uint32_t configSize;
    char configBuf[LEVEL_CONFIG_BUF_SIZE];
};

struct SlogDevBufInfo{
    uint32_t bufNum;
    uint32_t modId[MODULE_ID_NUM];
};

enum SlogIoctlCmd{
	IOCTL_USER_READ_INF = 1,
	IOCTL_USER_WRITE_CFG = 2,
	IOCTL_USER_READ_CFG = 3
};

#define PROC_SLOG_LEVEL_PATH    "/proc/slog/loglevel"
#define SLOG_IOC_MAGIC           'S'
#define SLOG_IOC_RINF             _IOR(SLOG_IOC_MAGIC, IOCTL_USER_READ_INF, struct SlogDevBufInfo)
#define SLOG_IOC_RCFG             _IOR(SLOG_IOC_MAGIC, IOCTL_USER_READ_CFG, struct SlogConfigMsg)
#define SLOG_IOC_WCFG             _IOW(SLOG_IOC_MAGIC, IOCTL_USER_WRITE_CFG, struct SlogConfigMsg)

LogRt SetDlogLevel(int32_t devId)
{
    (void)devId;
    int32_t fd = open(PROC_SLOG_LEVEL_PATH, O_RDONLY);
    if (fd < 0) {
        SELF_LOG_ERROR("open %s failed, errno=%d.", PROC_SLOG_LEVEL_PATH, errno);
        return SET_LEVEL_ERR;
    }

    struct SlogDevBufInfo info = {0};
    if (ioctl(fd, SLOG_IOC_RINF, &info) < 0) {
        SELF_LOG_ERROR("get module id failed, errno=%d.", errno);
        close(fd);
        return SET_LEVEL_ERR;
    }

    for (uint32_t i = 0; i < info.bufNum; i++) {
        int32_t level = SlogdGetModuleLevel((int32_t)info.modId[i], DEBUG_LOG_MASK);
        if (level > LOG_MAX_LEVEL) {
            level = SlogdGetGlobalLevel(DEBUG_LOG_MASK);
        }
        struct SlogSetConfig setConfig = {0};
        setConfig.level = (uint32_t)level;
        struct SlogConfigMsg msg = {0};
        msg.modId = info.modId[i];
        msg.configSize = sizeof(uint32_t);
        errno_t err = memcpy_s(msg.configBuf, LEVEL_CONFIG_BUF_SIZE, &setConfig, sizeof(setConfig));
        TWO_ACT_ERR_LOG(err != EOK, close(fd), return SET_LEVEL_ERR, "memcpy failed, set level failed.");
        if (ioctl(fd, SLOG_IOC_WCFG, &msg) < 0) {
            SELF_LOG_ERROR("set module %u level failed, errno=%d.", info.modId[i], errno);
            close(fd);
            return SET_LEVEL_ERR;
        }
    }
    close(fd);
    return SUCCESS;
}
#else

STATIC int32_t GetLevelByChnl(int32_t devId, int32_t channelType)
{
    int32_t level;
    switch (channelType) {
        case LOG_CHANNEL_TYPE_TS:
            level = SlogdGetModuleLevelByDevId(devId, TS, DEBUG_LOG_MASK);
            break;
        case LOG_CHANNEL_TYPE_MCU_DUMP:
            level = SlogdGetModuleLevelByDevId(devId, TSDUMP, DEBUG_LOG_MASK);
            break;
        case LOG_CHANNEL_TYPE_LPM3:
            level = SlogdGetModuleLevelByDevId(devId, LP, DEBUG_LOG_MASK);
            break;
        case LOG_CHANNEL_TYPE_IMU:
            level = SlogdGetModuleLevelByDevId(devId, IMU, DEBUG_LOG_MASK);
            break;
        case LOG_CHANNEL_TYPE_IMP:
            level = SlogdGetModuleLevelByDevId(devId, IMP, DEBUG_LOG_MASK);
            break;
        case LOG_CHANNEL_TYPE_ISP:
            level = SlogdGetModuleLevelByDevId(devId, ISP, DEBUG_LOG_MASK);
            break;
        case LOG_CHANNEL_TYPE_SIS:
            level = SlogdGetModuleLevelByDevId(devId, SIS, DEBUG_LOG_MASK);
            break;
        case LOG_CHANNEL_TYPE_SIS_BIST:
            level = SlogdGetModuleLevelByDevId(devId, SIS, DEBUG_LOG_MASK);
            break;
        case LOG_CHANNEL_TYPE_HSM:
            level = SlogdGetModuleLevelByDevId(devId, HSM, DEBUG_LOG_MASK);
            break;
        case LOG_CHANNEL_TYPE_RTC:
            level = SlogdGetModuleLevelByDevId(devId, RTC, DEBUG_LOG_MASK);
            break;
        default:
            level = SlogdGetGlobalLevel(SLOGD_GLOBAL_TYPE_MASK);
            break;
    }
    return level;
}

/**
 * @brief       : set level to firmware
 * @param [in]  : devId                 device physics id
 * @return      : SUCCESS               set level succeed;
 *                GET_DEVICE_ID_ERR     get device id failed;
 *                SET_LEVEL_ERR         set level failed
 */
LogRt SetDlogLevel(int32_t devId)
{
    int32_t deviceId[LOG_DEVICE_ID_MAX] = { 0 };
    int32_t deviceChnlType[LOG_CHANNEL_NUM_MAX] = { 0 };
    int32_t deviceNum = 0;
    int32_t channelTypeNum = 0;
 
    int32_t ret = log_get_device_id(deviceId, &deviceNum, LOG_DEVICE_ID_MAX);
    if ((ret != SYS_OK) || (deviceNum > LOG_DEVICE_ID_MAX)) {
        SELF_LOG_ERROR("get device id failed, result=%d, device_number=%d, max_device_id=%d.",
                       ret, deviceNum, LOG_DEVICE_ID_MAX);
        return GET_DEVICE_ID_ERR;
    }

    LogRt res = SUCCESS;
    for (int32_t i = 0; i < deviceNum; i++) {
        // -1 means iterate all device
        if ((deviceId[i] != devId) && (devId != -1)) {
            continue;
        }
        ret = log_get_channel_type(deviceId[i], deviceChnlType, &channelTypeNum, LOG_CHANNEL_NUM_MAX);
        if ((ret != SYS_OK) || (channelTypeNum > LOG_CHANNEL_NUM_MAX)) {
            SELF_LOG_ERROR("get device channel type failed, result=%d, device_id=%d, " \
                           "channel_type_number=%d, max_channel_number=%d.",
                           ret, deviceId[i], channelTypeNum, LOG_CHANNEL_NUM_MAX);
            res = SET_LEVEL_ERR;
            continue;
        }
        for (int32_t j = 0; j < channelTypeNum; j++) {
            if (deviceChnlType[j] >= (int32_t)LOG_CHANNEL_TYPE_MAX) {
                continue;
            }
            // get level by channel type
            int32_t level = GetLevelByChnl(deviceId[i], deviceChnlType[j]);
            // level is unsigned value
            if (level > LOG_MAX_LEVEL) {
                level = SlogdGetGlobalLevel(SLOGD_GLOBAL_TYPE_MASK);
            }
            ret = log_set_level(deviceId[i], deviceChnlType[j], (unsigned int)level);
            if (ret != SYS_OK) {
                SELF_LOG_ERROR("set device level failed, result=%d, device_id=%d, channel_type=%d, level=%s.",
                               ret, deviceId[i], deviceChnlType[j], GetBasicLevelNameById(level));
                res = SET_LEVEL_ERR;
            }
        }
    }
    SELF_LOG_INFO("Set device level finished, result=%d", (int32_t)res);
    return res;
}

#endif
