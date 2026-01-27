/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "hal_dsmi.h"
#include "inttypes.h"
#include "osal/osal.h"
#include "ascend_hal.h"
#include "errno/error_code.h"
#include "logger/logger.h"

typedef struct {
    int32_t moduleType;
    int32_t infoType;
    int64_t defaultValue;
    char message[MAX_INFO_MESSAGE_LEN];
} DeviceInfo;

static DeviceInfo g_deviceInfo[MAX_DEVICE_INFO_TYPE] = {
    {MODULE_TYPE_SYSTEM,       INFO_TYPE_SYS_COUNT,           0, "get device sys count"},
    {MODULE_TYPE_SYSTEM,       INFO_TYPE_HOST_OSC_FREQUE,     0, "get host osc frequency"},
    {MODULE_TYPE_SYSTEM,       INFO_TYPE_DEV_OSC_FREQUE,      0, "get device osc frequency"},
    /* 获取芯片形态, 用于区分芯片读取PMU值不同等 */
    {MODULE_TYPE_SYSTEM,       INFO_TYPE_VERSION,             0, "get device chip version"},
    /* 获取device的环境: 0: FPGA; 1: EMU; 2: ESL */
    {MODULE_TYPE_SYSTEM,       INFO_TYPE_ENV,                 0, "get device env type"},
    /* 获取Ctrl Cpu 编号, 做芯片型号映射使用, 如： ARMv8_Cortext_A55 */
    {MODULE_TYPE_CCPU,         INFO_TYPE_ID,                  0, "get ctrl cpu id"},
    {MODULE_TYPE_CCPU,         INFO_TYPE_CORE_NUM,            0, "get ctrl cpu core number"},
    {MODULE_TYPE_CCPU,         INFO_TYPE_ENDIAN,              0, "get ctrl cpu little-endian"},
    {MODULE_TYPE_AICPU,        INFO_TYPE_CORE_NUM,            0, "get ai cpu core number"},
    {MODULE_TYPE_AICPU,        INFO_TYPE_ID,                  0, "get ai cpu id"},
    {MODULE_TYPE_AICPU,        INFO_TYPE_OCCUPY,              0, "get ai cpu occupy bitmap"},
    {MODULE_TYPE_TSCPU,        INFO_TYPE_CORE_NUM,            0, "get ts cpu core number"},
    {MODULE_TYPE_AICORE,       INFO_TYPE_ID,                  0, "get ai core id"},
    {MODULE_TYPE_AICORE,       INFO_TYPE_CORE_NUM,            0, "get ai core number"},
    {MODULE_TYPE_AICORE,       INFO_TYPE_FREQUE,              0, "get ai core frequency"},
    {MODULE_TYPE_VECTOR_CORE,  INFO_TYPE_CORE_NUM,            0, "get ai vector core number"},
    {MODULE_TYPE_VECTOR_CORE,  INFO_TYPE_FREQUE,              0, "get ai vector core frequency"},
};

/*
 * 描  述：驱动版本接口, 用于判断当前版本支持功能的情况。
 *        0x071905版本：开始支持获取的host、device系统频率
 * 入  参：无
 * 出  参：无
 * 返回值：0：获取版本号失败, 其他：获取到的对应版本号值
 */
uint32_t HalGetApiVersion(void)
{
    int32_t ver = 0;
    drvError_t ret = halGetAPIVersion(&ver);
    if (ret == DRV_ERROR_NONE) {
        MSPROF_EVENT("Succeeded to DrvGetApiVersion version: 0x%x", ver);
        return (uint32_t)ver;
    }
    return 0;
}

/*
 * 描  述：获取平台信息, 用于判断该平台是否是SOC场景。
 * 入  参：无
 * 出  参：platformInfo - device类型平台还是非device类型平台
 * 返回值：PROFILING_SUCCESS：获取成功, others：获取失败
 */
int32_t HalGetPlatformInfo(uint32_t* platformInfo)
{
    drvError_t ret = drvGetPlatformInfo(platformInfo);
    if (ret != DRV_ERROR_NONE && ret != DRV_ERROR_NOT_SUPPORT) {
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

/*
 * 描  述：获取平台device个数
 * 入  参：无
 * 出  参：无
 * 返回值：0：获取失败或没有device, others：获取到的device数量
 */
uint32_t HalGetDeviceNumber(void)
{
    uint32_t devNum = 0;
    drvError_t ret = drvGetDevNum(&devNum);
    if (ret != DRV_ERROR_NONE || devNum > MAX_DEVICE_NUMS) {
        MSPROF_LOGE("Failed to get device number[%u], ret=%d.", devNum, (int32_t)ret);
        return 0;
    }

    MSPROF_LOGI("Succeeded to get device number[%u]", devNum);
    return devNum;
}

/*
 * 描  述：按照平台device个数，获取device id
 * 入  参：devNum - device个数
 *        devIdsLen - 存放缓冲区大小
 * 出  参：devIds - device Id存放缓冲区
 * 返回值：>0：获取device id成功, others：获取到的device id失败
 */
uint32_t HalGetDeviceIds(uint32_t devNum, uint32_t *devIds, uint32_t devIdsLen)
{
    if (devNum == 0 || devNum > MAX_DEVICE_NUMS || devIds == NULL || devIdsLen < MAX_DEVICE_NUMS) {
        MSPROF_LOGE("the parameter of input is invalid, device number is %u.", devNum);
        return 0;
    }

    drvError_t ret = drvGetDevIDs(devIds, devNum);
    if (ret != DRV_ERROR_NONE) {
        MSPROF_LOGE("Failed to get device id, ret=%d", (int32_t)(ret));
        return 0;
    }

    MSPROF_LOGI("Succeeded to get device id, device number is %u.", devNum);
    return devNum;
}

/*
 * 描  述： 获取device系统信息, 用于统一接口, 统一打印。
 * 入  参： type - 需要获取device信息类型
 *         deviceId - 待获取device信息的device id
 * 出  参： value - device信息值
 * 返回值：0：获取成功, -1：获取失败
 */
int32_t HalGetDeviceInfo(DeviceInfoType type, uint32_t deviceId, int64_t *value)
{
    *value = g_deviceInfo[type].defaultValue;
    drvError_t ret = halGetDeviceInfo(deviceId, g_deviceInfo[type].moduleType, g_deviceInfo[type].infoType, value);
    if (ret == DRV_ERROR_NONE) {
        MSPROF_LOGI("Succeeded to %s, deviceId=%u, value=%lld.", g_deviceInfo[type].message, deviceId, *value);
        return PROFILING_SUCCESS;
    } else if (ret == DRV_ERROR_NOT_SUPPORT) {
        MSPROF_LOGW("Driver doesn't support to %s by halGetDeviceInfo interface, "
            "deviceId=%u, ret=%d.", g_deviceInfo[type].message, deviceId, ret);
        return PROFILING_SUCCESS;
    } else {
        MSPROF_LOGE("Failed to %s, deviceId=%u, ret=%d.", g_deviceInfo[type].message, deviceId, ret);
        return PROFILING_FAILED;
    }
}

/*
 * 描  述： 获取device时间信息, 用于统一接口, 统一打印。
 * 入  参： deviceId - 待获取device信息的device id
 * 出  参： cntvct - device对应的时间信息值
 * 返回值： 0(PROFILING_SUCCESS)：获取成功, -1(PROFILING_FAILED)：获取失败
 */
int32_t HalGetDeviceTime(uint32_t deviceId, uint64_t *cntvct)
{
    PROF_CHK_EXPR_ACTION(cntvct == NULL, return PROFILING_FAILED, "Param cntvct is null.");
    int64_t deviceTime = 0;
    drvError_t ret = halGetDeviceInfo(deviceId, MODULE_TYPE_SYSTEM, INFO_TYPE_SYS_COUNT, &deviceTime);
    if (ret == DRV_ERROR_NONE && deviceTime >= 0) {
        *cntvct = (uint64_t)deviceTime;
        MSPROF_LOGI("Succeeded to HalGetDeviceTime cntvct, devId=%u, cntvct=%" PRIu64 ".", deviceId, *cntvct);
    } else if (ret == DRV_ERROR_NOT_SUPPORT) {
        MSPROF_LOGW("Driver doesn't support HalGetDeviceTime cntvct by halGetDeviceInfo interface, "
            "deviceId=%u, ret=%d", deviceId, ret);
    } else {
        MSPROF_LOGE("Failed to HalGetDeviceTime cntvct, deviceId=%u, ret=%d", deviceId, ret);
        return PROFILING_FAILED;
    }

    return PROFILING_SUCCESS;
}

/*
 * 描  述：获取系统host侧频率, 用于判断是否启动host的syscnt打点, 单位KHZ。
 * 入  参：无
 * 出  参：无
 * 返回值：0：表示获取host侧频率失败
 */
uint64_t HalGetHostFreq(void)
{
    int64_t hostFreq = 0;
    int32_t ret = HalGetDeviceInfo(SYSTEM_HOST_OSC_FREQUE, 0, &hostFreq);
    if (ret == PROFILING_SUCCESS && hostFreq > 0) {
        return (uint64_t)hostFreq;
    }

    return 0;
}

/*
 * 描  述：获取系统device侧频率, 单位KHZ。
 * 入  参：deviceId： device id
 * 出  参：无
 * 返回值：0：表示获取device侧频率失败
 */
uint64_t HalGetDeviceFreq(uint32_t deviceId)
{
    int64_t deviceFreq = 0;
    int32_t ret = HalGetDeviceInfo(SYSTEM_DEV_OSC_FREQUE, deviceId, &deviceFreq);
    if (ret == PROFILING_SUCCESS && deviceFreq > 0) {
        return (uint64_t)deviceFreq;
    }

    return 0;
}

/*
 * 描  述：获取平台型号, 用于判断该平台支持的功能特性等。
 * 入  参：无
 * 出  参：无
 * 返回值：0：表示获取chip版本失败
 */
uint32_t HalGetChipVersion(void)
{
    int64_t versionInfo = 0;
    (void)HalGetDeviceInfo(SYSTEM_VERSION, 0, &versionInfo);
    if (versionInfo < 0) {
        return 0;
    }

    return (uint32_t)(((uint64_t)versionInfo >> (uint64_t)MAX_CHIP_VERSION) & 0xffULL);
}

/*
 * 描  述：获取device环境类型
 * 入  参：deviceId： device id
 * 出  参：无
 * 返回值：0：表示获取device环境类型失败
 */
int64_t HalGetEnvType(uint32_t deviceId)
{
    int64_t envType = 0;
    int32_t ret = HalGetDeviceInfo(SYSTEM_ENV, deviceId, &envType);
    if (ret == PROFILING_SUCCESS) {
        return envType;
    }

    return PROFILING_FAILED;
}

/*
 * 描  述：获取Ctrl Cpu的id
 * 入  参：deviceId： device id
 * 出  参：无
 * 返回值：0：表示获取Ctrl Cpu Id失败
 */
int64_t HalGetCtrlCpuId(uint32_t deviceId)
{
    int64_t ctrlCpuId = 0;
    int32_t ret = HalGetDeviceInfo(CCPU_ID, deviceId, &ctrlCpuId);
    if (ret == PROFILING_SUCCESS) {
        return ctrlCpuId;
    }

    return PROFILING_FAILED;
}

/*
 * 描  述：获取Ctrl Cpu的核数量
 * 入  参：deviceId： device id
 * 出  参：无
 * 返回值：0：表示获取Ctrl Cpu的core数量失败
 */
int64_t HalGetCtrlCpuCoreNum(uint32_t deviceId)
{
    int64_t ctrlCpuCoreNum = 0;
    int32_t ret = HalGetDeviceInfo(CCPU_CORE_NUM, deviceId, &ctrlCpuCoreNum);
    if (ret == PROFILING_SUCCESS) {
        return ctrlCpuCoreNum;
    }

    return PROFILING_FAILED;
}

/*
 * 描  述：获取Ctrl Cpu的大小端模式
 * 入  参：deviceId： device id
 * 出  参：无
 * 返回值：0：表示获取Ctrl Cpu的大小端模式失败
 */
int64_t HalGetCtrlCpuEndianLittle(uint32_t deviceId)
{
    int64_t ctrlCpuEndianLittle = 0;
    int32_t ret = HalGetDeviceInfo(CCPU_ENDIAN, deviceId, &ctrlCpuEndianLittle);
    if (ret == PROFILING_SUCCESS) {
        return ctrlCpuEndianLittle;
    }

    return PROFILING_FAILED;
}

/*
 * 描  述：获取aicpu的核数量
 * 入  参：deviceId： device id
 * 出  参：无
 * 返回值：0：表示获取aicpu的核数量失败
 */
int64_t HalGetAiCpuCoreNum(uint32_t deviceId)
{
    int64_t aiCpuCoreNum = 0;
    int32_t ret = HalGetDeviceInfo(AICPU_CORE_NUM, deviceId, &aiCpuCoreNum);
    if (ret == PROFILING_SUCCESS) {
        return aiCpuCoreNum;
    }

    return PROFILING_FAILED;
}

/*
 * 描  述：获取aicpu的核id
 * 入  参：deviceId： device id
 * 出  参：无
 * 返回值：0：表示获取aicpu的核id失败
 */
int64_t HalGetAiCpuCoreId(uint32_t deviceId)
{
    int64_t aiCpuCoreId = 0;
    int32_t ret = HalGetDeviceInfo(AICPU_ID, deviceId, &aiCpuCoreId);
    if (ret == PROFILING_SUCCESS) {
        return aiCpuCoreId;
    }

    return PROFILING_FAILED;
}

/*
 * 描  述：获取aicpu的占用比特
 * 入  参：deviceId： device id
 * 出  参：无
 * 返回值：0：表示获取aicpu的占用比特失败
 */
int64_t HalGetAiCpuOccupyBitmap(uint32_t deviceId)
{
    int64_t aiCpuOccupyBitmap = 0;
    int32_t ret = HalGetDeviceInfo(AICPU_OCCUPY, deviceId, &aiCpuOccupyBitmap);
    if (ret == PROFILING_SUCCESS) {
        return aiCpuOccupyBitmap;
    }

    return PROFILING_FAILED;
}

/*
 * 描  述：获取ts cpu的核数量
 * 入  参：deviceId： device id
 * 出  参：无
 * 返回值：0：表示获取ts cpu的核数量失败
 */
int64_t HalGetTsCpuCoreNum(uint32_t deviceId)
{
    int64_t tsCpuCoreNum = 0;
    int32_t ret = HalGetDeviceInfo(TSCPU_CORE_NUM, deviceId, &tsCpuCoreNum);
    if (ret == PROFILING_SUCCESS) {
        return tsCpuCoreNum;
    }

    return PROFILING_FAILED;
}

/*
 * 描  述：获取ai core的id
 * 入  参：deviceId： device id
 * 出  参：无
 * 返回值：0：表示获取ai core的id失败
 */
int64_t HalGetAiCoreId(uint32_t deviceId)
{
    int64_t aiCoreId = 0;
    int32_t ret = HalGetDeviceInfo(AICORE_ID, deviceId, &aiCoreId);
    if (ret == PROFILING_SUCCESS) {
        return aiCoreId;
    }

    return PROFILING_FAILED;
}

/*
 * 描  述：获取ai core的数量
 * 入  参：deviceId： device id
 * 出  参：无
 * 返回值：0：表示获取ai core的数量失败
 */
int64_t HalGetAiCoreNum(uint32_t deviceId)
{
    int64_t aiCoreNum = 0;
    int32_t ret = HalGetDeviceInfo(AICORE_CORE_NUM, deviceId, &aiCoreNum);
    if (ret == PROFILING_SUCCESS) {
        return aiCoreNum;
    }

    return PROFILING_FAILED;
}

/*
 * 描  述：获取ai core的频率，单位KHZ
 * 入  参：deviceId： device id
 * 出  参：无
 * 返回值：0：表示获取ai core的频率失败
 */
int64_t HalGetAicFrq(uint32_t deviceId)
{
    int64_t freq = 0;
    int32_t ret = HalGetDeviceInfo(AICORE_FREQUE, deviceId, &freq);
    if (ret == PROFILING_SUCCESS) {
        return freq;
    }

    return PROFILING_FAILED;
}

/*
 * 描  述：获取ai vector core的数量
 * 入  参：deviceId： device id
 * 出  参：无
 * 返回值：0：表示获取ai vector core的数量失败
 */
int64_t HalGetAiVectorCoreNum(uint32_t deviceId)
{
    int64_t aivNum = 0;
    int32_t ret = HalGetDeviceInfo(VECTOR_CORE_CORE_NUM, deviceId, &aivNum);
    if (ret == PROFILING_SUCCESS) {
        return aivNum;
    }

    return PROFILING_FAILED;
}

/*
 * 描  述：获取ai vector core的频率，单位KHZ
 * 入  参：deviceId： device id
 * 出  参：无
 * 返回值：0：表示获取ai vector core的频率失败
 */
int64_t HalGetAivFeq(uint32_t deviceId)
{
    int64_t aivFreq = 0;
    int32_t ret = HalGetDeviceInfo(VECTOR_CORE_FREQUE, deviceId, &aivFreq);
    if (ret == PROFILING_SUCCESS) {
        return aivFreq;
    }

    return PROFILING_FAILED;
}