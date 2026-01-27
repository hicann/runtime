/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "profile_param.h"
#include "securec.h"
#include "errno/error_code.h"
#include "osal/osal.h"
#include "json/json_parser.h"
#include "json/json_generator.h"
#include "logger/logger.h"
#include "toolchain/prof_data_config.h"
#include "toolchain/prof_api.h"
#include "platform/platform.h"
#include "osal/osal_mem.h"

static const char* g_aclJson[] = {
    "switch",
    "output",
    "aic_metrics",
    "aicpu",
    "l2",
    "storage_limit",
    "hccl",
    "msproftx",
    "instr_profiling",
    "instr_profiling_freq",
    "task_tsfw",
    "task_framework",
    "ascendcl",
    "task_trace",
    "runtime_api",
    "fwk_schedule",
    "sys_hardware_mem_freq",
    "llc_profiling",
    "sys_io_sampling_freq",
    "sys_interconnection_freq",
    "dvpp_freq",
    "host_sys",
    "host_sys_usage",
    "host_sys_usage_freq"
};

static const char* g_switchList[] = {
    "switch",
    "task_trace"
};

CHAR* Slice(const CHAR* str, uint64_t start, uint64_t end)
{
    const char *p = str + start;
    char *slice = (char *)OsalCalloc((size_t)(end - start + 2U));
    PROF_CHK_EXPR_ACTION(slice == NULL, return NULL, "Slice char failed.");
    for (uint32_t idx = 0; idx < end - start + 1U; idx++) {
        slice[idx] = *p;
        p++;
    }
    slice[end - start + 1U] = '\0';
    return slice;
}

static bool IsSwitchChar(const char* key)
{
    PROF_CHK_EXPR_ACTION(key == NULL, return false, "Input key is empty.");
    for (uint32_t idx = 0; idx < sizeof(g_switchList) / sizeof(g_switchList[0]); idx++) {
        if (strcmp(key, g_switchList[idx]) == 0) {
            return true;
        }
    }
    return false;
}

static bool IsValidSwitch(const char* key, const char* val)
{
    // 判断是否是开关类型
    if (val == NULL || key == NULL) {
        MSPROF_LOGE("Param %s config is empty.", key);
        return false;
    }
    if (!IsSwitchChar(key)) {
        return true;
    }
    if (strcmp(val, "on") == 0 || strcmp(val, "off") == 0) {
        return true;
    }
    if (strcmp(key, "task_trace") == 0 || strcmp(key, "fwk_schedule") == 0) {
        if (strcmp(val, "l0") == 0 || strcmp(val, "l1") == 0 || strcmp(val, "l2") == 0) {
            return true;
        }
    }
    MSPROF_LOGE("Param %s config [%s] is invalid, please enter the correct configuration.", key, val);
    return false;
}

static bool IsSwitch(PlatformFeature feature)
{
    for (uint32_t i = 0; i < sizeof(featureList) / sizeof(featureList[0]); i++) {
        if (feature == featureList[i]) {
            return true;
        }
    }
    return false;
}

static bool CheckAcljsonParam(JsonObj* jsonObj)
{
    // 检查入参是否是acljson适用的
    bool checkPoint;
    for (size_t idx = 0; idx < jsonObj->GetSize(jsonObj); idx++) {
        checkPoint = false;
        JsonKeyObj* kvObj = jsonObj->KeyValuePairAt(jsonObj, idx);
        for (uint32_t cursors = 0; cursors < sizeof(g_aclJson) / sizeof(g_aclJson[0]); cursors++) {
            if (strcmp(kvObj->key, g_aclJson[cursors]) == 0) {
                checkPoint = true;
                break;
            }
        }
        if (!checkPoint) {
            MSPROF_LOGE("Param %s is invalid for acljson.", kvObj->key);
            return false;
        }
    }
    return true;
}

static bool CheckDataType(uint32_t dataType, JsonObj* jsonObj)
{
    // 该部分需要替换各种启动类型
    if (jsonObj == NULL) {
        MSPROF_LOGE("Init jsonObj is nullptr, pleace check.");
        return false;
    }
    bool ret = false;
    switch (dataType) {
        case MSPROF_CTRL_INIT_ACL_JSON:
            ret = CheckAcljsonParam(jsonObj);
            break;
        case MSPROF_CTRL_INIT_GE_OPTIONS:
            // 检查geoption可用参数
            ret = true;
            break;
        case MSPROF_CTRL_INIT_HELPER:
            // 检查helper可用参数
            ret = true;
            break;
        case MSPROF_CTRL_INIT_PURE_CPU:
            // 检查purecpu可用参数
            ret = true;
            break;
        default:
            MSPROF_LOGE("Invalid MsprofCtrlCallback type: %u", dataType);
            break;
    }
    return ret;
}

static bool CheckStorageLimit(const char* value)
{
    if (value == NULL) {
        MSPROF_LOGE("Param storage_limit configuration is empty.");
        return false;
    }
    size_t valueLen = strlen(value);
    if (valueLen < STORAGE_MINIMUM_LENGTH) {
        MSPROF_LOGE("Param storage_limit configuration len is not right,"
            "please input in the range of 200MB~4294967295MB.");
        return false;
    }
    char* mb = Slice(value, valueLen - 2U, valueLen - 1U);
    PROF_CHK_EXPR_ACTION(mb == NULL, return false, "Slice storage limit char failed.");
    if (strcmp(mb, "MB") != 0) {
        OsalFree(mb);
        mb = NULL;
        MSPROF_LOGE("Param storage_limit config is invalid, please add MB at the end.");
        return false;
    }
    OsalFree(mb);
    mb = NULL;
    char* numStr = Slice(value, 0, valueLen - 3U);
    PROF_CHK_EXPR_ACTION(numStr == NULL, return false, "Slice storage limit char failed.");
    if (!CheckIsUIntNum(numStr)) {
        OsalFree(numStr);
        numStr = NULL;
        MSPROF_LOGE("Param storage_limit configuration is non-negative integer.");
        return false;
    }
    OsalFree(numStr);
    numStr = NULL;
    return true;
}

static bool CheckParamValidation(JsonObj* jsonObj)
{
    for (size_t idx = 0; idx < jsonObj->GetSize(jsonObj); idx++) {
        JsonKeyObj *kvObj = jsonObj->KeyValuePairAt(jsonObj, idx);
        if (!IsSupportSwitch(kvObj->key)) {
            MSPROF_LOGE("Current platform is not support %s.", kvObj->key);
            return false;
        }
    }
    for (size_t idx = 0; idx < jsonObj->GetSize(jsonObj); idx++) {
        JsonKeyObj *kvObj = jsonObj->KeyValuePairAt(jsonObj, idx);
        const char *value = kvObj->value.value.stringValue;
        if (!IsValidSwitch(kvObj->key, value)) {
            MSPROF_LOGE("Invalid config [%s] for switch %s.", value, kvObj->key);
            return false;
        }
        if (strcmp(kvObj->key, "storage_limit") == 0) {
            // 检查storage limit
            if (!CheckStorageLimit(value)) {
                MSPROF_LOGE("Storage limit config is invalid.");
                return false;
            }
            continue;
        }
        if (strcmp(kvObj->key, "aic_metrics") == 0) {
            if (!IsSupportSwitch(value)) {
                MSPROF_LOGE("Invalid value %s for %s.", value, kvObj->key);
                return false;
            }
        }
    }
    return true;
}

static bool MsprofResultDirAdapter(const char* dir, char* resultDir, size_t len)
{
#ifdef LITE_OS
    errno_t ret = strcpy_s(resultDir, len, dir);
    PROF_CHK_EXPR_ACTION(ret != EOK, return false, "strcpy_s failed for result dir %s.", dir);
#else
    // 如果有配置dir
    if (dir == NULL || resultDir == NULL || strlen(dir) == 0) {
        MSPROF_LOGW("Input path is null or not exists.");
        return false;
    }
    PROF_CHK_WARN_ACTION(!RelativePathToAbsolutePath(dir, resultDir, len), return false,
        "Unable to process the path %s.", resultDir);

    PROF_CHK_WARN_ACTION(!CreateDirectory(resultDir), return false,
        "Directory %s did not create successfully.", resultDir);

    if (!IsDirAccessible(resultDir)) {
        // 无法访问到时为确保安全，将路径刷空
        MSPROF_LOGW("Result path is not accessible: %s", resultDir);
        (void)memset_s(resultDir, len, 0, len);
        return false;
    }
    MSPROF_LOGI("MsprofResultDirAdapter result path: %s", resultDir);
#endif
    return true;
}

static bool DefaultResultDirAdapter(char* resultDir)
{
    // 使用app目录
    PROF_CHK_EXPR_ACTION(resultDir == NULL, return false, "Input resultDir is empty.");
    MSPROF_LOGI("No output set or is not accessible, use app dir instead.");
    if (!GetSelfPath(resultDir)) {
        MSPROF_LOGW("DefaultResultDirAdapter cannot get result path.");
        return false;
    }
    MSPROF_LOGI("DefaultResultDirAdapter result path: %s", resultDir);
    return true;
}

static bool SetBitMap(ParmasList *param, PlatformFeature enumValue)
{
    uint32_t feature = (uint32_t)enumValue;
    uint32_t mapIndex = feature / DEFAULT_MAX_BYTE_LENGTH;
    feature -= mapIndex * DEFAULT_MAX_BYTE_LENGTH;
    PROF_CHK_EXPR_ACTION(mapIndex >= DEFAULT_FEATURES_BYTE_MAP, return false,
        "The value of [%u] exceeds byte map upper limit [%d].", feature, DEFAULT_FEATURES_BYTE_MAP);
    param->features[mapIndex] |= (uint32_t)(1UL << feature);
    return true;
}

static int32_t SetTaskTraceConfig(ParmasList *param, const char* taskTrace, const char* profLevel)
{
    int32_t ret = strcpy_s(param->taskTrace, sizeof(param->taskTrace), taskTrace);
    PROF_CHK_EXPR_ACTION(ret != EOK, return ret, "strcpy_s taskTrace failed.");
    ret = strcpy_s(param->profLevel, sizeof(param->profLevel), profLevel);
    PROF_CHK_EXPR_ACTION(ret != EOK, return ret, "strcpy_s profLevel failed.");
    return PROFILING_SUCCESS;
}

/*
 * 描述:卸载bit map中的配置，即将对应位置的1置为0
 * 参数: PlatformFeature bitTarget -- 输入比特类型
 * 返回值:执行返回翻转码用于与或
 */
static inline uint32_t UnloadBitMap(PlatformFeature bitTarget)
{
    return ~((uint32_t)1U << (uint32_t)bitTarget);
}

static bool ProcessTaskTrace(ParmasList *param, const char* taskStatus)
{
    PROF_CHK_EXPR_ACTION(taskStatus == NULL, return false, "Input task char is empty.");
    int32_t ret = PROFILING_FAILED;
    if (strcmp(taskStatus, "off") == 0) {
        param->features[0] &= UnloadBitMap(PLATFORM_TASK_TS_TIMELINE);
        param->features[0] &= UnloadBitMap(PLATFORM_TASK_STARS_ACSQ);
        param->features[0] &= UnloadBitMap(PLATFORM_TASK_AIC_HWTS);
        param->features[0] &= UnloadBitMap(PLATFORM_TASK_RUNTIME_TRACE);
        ret = SetTaskTraceConfig(param, "off", "off");
    } else if (strcmp(taskStatus, "l0") == 0) {
        ret = SetTaskTraceConfig(param, "l0", "level0");
    } else if (strcmp(taskStatus, "l2") == 0) {
        ret = SetTaskTraceConfig(param, "l2", "level2");
    } else {
        ret = PROFILING_SUCCESS;
    }
    PROF_CHK_EXPR_ACTION(ret != PROFILING_SUCCESS, return false, "Process param task trace failed.");
    return true;
}

static bool ProcessAiMetrics(ParmasList *param, const char* aiValue)
{
    PROF_CHK_EXPR_ACTION(aiValue == NULL, return false, "Input ai metrics value is empty.");
    int32_t ret = strcpy_s(param->aiCoreMetrics, sizeof(param->aiCoreMetrics), aiValue);
    PROF_CHK_EXPR_ACTION(ret != EOK, return false, "strcpy_s aiCoreMetrics failed.");
    if (!PlatformGetMetricsEvents(aiValue, param->aicEvents, sizeof(param->aicEvents))) {
        MSPROF_LOGE("Failed to get aicore metrics events, metrics: %s.", aiValue);
        return false;
    }
    ret = strcpy_s(param->aiVectMetrics, sizeof(param->aiVectMetrics), aiValue);
    PROF_CHK_EXPR_ACTION(ret != EOK, return false, "strcpy_s aiVectMetrics failed.");
    if (!PlatformGetMetricsEvents(aiValue, param->aivEvents, sizeof(param->aivEvents))) {
        MSPROF_LOGE("Failed to get aicore metrics events, metrics: %s.", aiValue);
        return false;
    }
    return true;
}

static bool SetConfigToProfileParam(JsonObj* jsonObj, ParmasList *param)
{
    int32_t ret = 0;
    bool result = false;
    for (size_t i = 0; i < jsonObj->GetSize(jsonObj); i++) {
        JsonKeyObj *kvObj = jsonObj->KeyValuePairAt(jsonObj, i);
        const char *key = kvObj->key;
        const char *value = kvObj->value.value.stringValue;
        if (strcmp(key, "switch") == 0 && strcmp(value, "on") == 0) {
            result = SetBitMap(param, PLATFORM_TASK_SWITCH);
            PROF_CHK_EXPR_ACTION(!result, return false, "Set byte map TASK_SWITCH failed.");
        } else if (strcmp(key, "task_trace") == 0) {
            result = ProcessTaskTrace(param, value);
            PROF_CHK_EXPR_ACTION(!result, return false, "Save taskTrace failed.");
        } else if (strcmp(key, "aic_metrics") == 0) {
            char* defaultMetrics = PlatformGetDefaultMetrics();
            PROF_CHK_EXPR_ACTION(defaultMetrics == NULL, return false, "Null value received from default metrics.");
            if (strcmp(value, defaultMetrics) == 0) {
                continue;
            }
            result = ProcessAiMetrics(param, value);
            PROF_CHK_EXPR_ACTION(!result, return false, "Save aicore aivector metrics failed.");
        } else if (strcmp(key, "output") == 0) {
            PROF_CHK_WARN_NO_ACTION(!MsprofResultDirAdapter(value, param->resultDir, sizeof(param->resultDir)),
                "MsprofResultDirAdapter did not complete successfully.");
        } else if (strcmp(key, "storage_limit") == 0) {
            ret = strcpy_s(param->storageLimit, sizeof(param->storageLimit), value);
            PROF_CHK_EXPR_ACTION(ret != EOK, return false, "strcpy_s storageLimit failed.");
        } else {
            continue;
        }
    }

    if (strlen(param->resultDir) == 0 && !DefaultResultDirAdapter(param->resultDir)) {
        MSPROF_LOGE("Config output path failed.");
        return false;
    }
    return true;
}

static void UpdateDataTypeConfigBySwitch(ProfileParam *param, PlatformFeature feature,  const uint64_t dataTypeConfig)
{
    if (IsEnable(&param->config, feature)) {
        param->dataTypeConfig |= dataTypeConfig;
    }
}

static void SetConfigToDataType(ProfileParam *param)
{
    param->dataTypeConfig |= PROF_AICPU_MODEL;
    if (strcmp(param->config.profLevel, "level2") == 0) {
        param->dataTypeConfig |= PROF_TASK_TIME_L2 | PROF_TASK_TIME_L1 | PROF_TASK_TIME;
    }
    if (strcmp(param->config.profLevel, "level1") == 0) {
        param->dataTypeConfig |= PROF_TASK_TIME_L1 | PROF_TASK_TIME;
    }
    if (strcmp(param->config.profLevel, "level0") == 0) {
        param->dataTypeConfig |= PROF_TASK_TIME;
    }
    UpdateDataTypeConfigBySwitch(param, PLATFORM_TASK_TS_TIMELINE, PROF_SCHEDULE_TIMELINE | PROF_TASK_TIME);
    UpdateDataTypeConfigBySwitch(param, PLATFORM_TASK_ASCENDCL, PROF_ACL_API);
    UpdateDataTypeConfigBySwitch(param, PLATFORM_TASK_AIC_METRICS, PROF_AICORE_METRICS);
    UpdateDataTypeConfigBySwitch(param, PLATFORM_TASK_AIV_METRICS, PROF_AIVECTORCORE_METRICS);
    UpdateDataTypeConfigBySwitch(param, PLATFORM_TASK_RUNTIME_TRACE, PROF_RUNTIME_TRACE);
    UpdateDataTypeConfigBySwitch(param, PLATFORM_TASK_TS_KEYPOINT, PROF_TRAINING_TRACE);
    UpdateDataTypeConfigBySwitch(param, PLATFORM_TASK_RUNTIME_API, PROF_RUNTIME_API);
    MSPROF_LOGI("Set dataTypeConfig is 0x%llx", param->dataTypeConfig);
}

static bool DefaultSwitchConfig(ParmasList *param)
{
    bool res = false;
    for (uint32_t idx = 0; idx < sizeof(DefaultSwitchList) / sizeof(DefaultSwitchList[0]); idx++) {
        if ((DefaultSwitchList[idx] == PLATFORM_TASK_AIC_HWTS && !IsSupportFeature(PLATFORM_TASK_AIC_HWTS)) ||
            (DefaultSwitchList[idx] == PLATFORM_TASK_STARS_ACSQ && !IsSupportFeature(PLATFORM_TASK_STARS_ACSQ))) {
            continue;
        }
        res = SetBitMap(param, DefaultSwitchList[idx]);
        PROF_CHK_EXPR_ACTION(!res, return false, "Set Switch byte map failed.");
    }
    return true;
}

static bool DefaultConfig(ParmasList *param)
{
    // 设置默认参数，strcpy_s需要做返回值检查
    param->hostPid = OsalGetPid();
    param->aicSamplingInterval = DEFAULT_PROFILING_INTERVAL_10MS;
    param->aivSamplingInterval = DEFAULT_PROFILING_INTERVAL_10MS;
    param->jobId = -1;
    (void)memset_s(param->resultDir, sizeof(param->resultDir), 0, sizeof(param->resultDir));
    (void)memset_s(param->storageLimit, sizeof(param->storageLimit), 0, sizeof(param->storageLimit));
    int32_t ret = strcpy_s(param->taskTrace, sizeof(param->taskTrace), "on");
    PROF_CHK_EXPR_ACTION(ret != EOK, return false, "strcpy_s taskTrace failed.");
    ret = strcpy_s(param->profLevel, sizeof(param->profLevel), "level1");
    PROF_CHK_EXPR_ACTION(ret != EOK, return false, "strcpy_s profLevel failed.");
    // 获取默认aic信息
    char* defaultMetrics = PlatformGetDefaultMetrics();
    PROF_CHK_EXPR_ACTION(defaultMetrics == NULL, return false, "Null value received from default metrics.");
    ret = strcpy_s(param->aiCoreMetrics, sizeof(param->aiCoreMetrics), defaultMetrics);
    PROF_CHK_EXPR_ACTION(ret != EOK, return false, "strcpy_s aiCoreMetrics failed.");
    if (!PlatformGetMetricsEvents(defaultMetrics, param->aicEvents, sizeof(param->aicEvents))) {
        MSPROF_LOGE("Failed to get default aicore metrics events PipeUtilization.");
        return false;
    }
    ret = strcpy_s(param->aiCoreProfilingMode, sizeof(param->aiCoreProfilingMode), "task-based");
    PROF_CHK_EXPR_ACTION(ret != EOK, return false, "strcpy_s aiCoreProfilingMode failed.");
    ret = strcpy_s(param->aiVectMetrics, sizeof(param->aiVectMetrics), defaultMetrics);
    PROF_CHK_EXPR_ACTION(ret != EOK, return false, "strcpy_s aiVectMetrics failed.");
    if (!PlatformGetMetricsEvents(defaultMetrics, param->aivEvents, sizeof(param->aivEvents))) {
        MSPROF_LOGE("Failed to get default aivector core metrics events PipeUtilization.");
        return false;
    }
    ret = strcpy_s(param->aiVectProfilingMode, sizeof(param->aiVectProfilingMode), "task-based");
    PROF_CHK_EXPR_ACTION(ret != EOK, return false, "strcpy_s aiVectProfilingMode failed.");
    // 设置默认开关
    bool res = DefaultSwitchConfig(param);
    PROF_CHK_EXPR_ACTION(!res, return false, "Set byte map failed.");
    return true;
}

static void PrintParam(ProfileParam *param)
{
    MSPROF_LOGI("Param dataTypeConfig = [0x%llx]", param->dataTypeConfig);
    MSPROF_LOGI("Param aicEvents = [%s]", param->config.aicEvents);
    MSPROF_LOGI("Param aiCoreMetrics = [%s]", param->config.aiCoreMetrics);
    MSPROF_LOGI("Param aiCoreProfilingMode = [%s]", param->config.aiCoreProfilingMode);
    MSPROF_LOGI("Param aicSamplingInterval = [%d]", param->config.aicSamplingInterval);
    MSPROF_LOGI("Param aiVectMetrics = [%s]", param->config.aiVectMetrics);
    MSPROF_LOGI("Param aiVectProfilingMode = [%s]", param->config.aiVectProfilingMode);
    MSPROF_LOGI("Param aivEvents = [%s]", param->config.aivEvents);
    MSPROF_LOGI("Param aivSamplingInterval = [%d]", param->config.aivSamplingInterval);
    MSPROF_LOGI("Param features = [%02x]", param->config.features[0]);
    MSPROF_LOGI("Param hostPid = [%d]", param->config.hostPid);
    MSPROF_LOGI("Param jobId = [%d]", param->config.jobId);
    MSPROF_LOGI("Param profLevel = [%s]", param->config.profLevel);
    MSPROF_LOGI("Param resultDir = [%s]", param->config.resultDir);
    MSPROF_LOGI("Param storageLimit = [%s]", param->config.storageLimit);
    MSPROF_LOGI("Param taskTrace = [%s]", param->config.taskTrace);
}

int32_t GenProfileParam(uint32_t dataType, OsalVoidPtr data, uint32_t dataLength, ProfileParam *param)
{
    if (data == NULL || param == NULL || dataLength == 0) {
        MSPROF_LOGE("Init param failed, the data or param is empty");
        return PROFILING_FAILED;
    }
    // 默认值赋予
    param->hostProfiling = false;
    param->deviceProfiling = false;
    param->dataTypeConfig = PROF_AICPU_MODEL;
    if (!DefaultConfig(&param->config)) {
        MSPROF_LOGE("Set default config failed.");
        return PROFILING_FAILED;
    }
    // 参数解读
    JsonObj *jsonObj = JsonParse(data);
    if (jsonObj == NULL || !JsonIsObj(jsonObj)) {
        MSPROF_LOGE("Parse json failed.");
        return PROFILING_FAILED;
    }
    // 参数检查
    if (!CheckDataType(dataType, jsonObj)) {
        MSPROF_LOGE("Check dataType failed, the type or params is invalid.");
        JsonFree(jsonObj);
        return PROFILING_FAILED;
    }
    if (!CheckParamValidation(jsonObj)) {
        MSPROF_LOGE("Check param failed, the data is invalid.");
        JsonFree(jsonObj);
        return PROFILING_FAILED;
    }
    // 参数赋值
    if (!SetConfigToProfileParam(jsonObj, &param->config)) {
        MSPROF_LOGE("Set param failed.");
        JsonFree(jsonObj);
        return PROFILING_FAILED;
    };

    // 配置回调dataType
    SetConfigToDataType(param);

    JsonFree(jsonObj);
    PrintParam(param);
    return PROFILING_SUCCESS;
}

bool IsEnable(ParmasList *param, PlatformFeature enumValue)
{
    uint32_t feature = (uint32_t)enumValue;
    if (!IsSwitch(enumValue)) {
        MSPROF_LOGE("The value of [%u] is not a switch.", feature);
        return false;
    }
    uint32_t mapIndex = feature / DEFAULT_MAX_BYTE_LENGTH;
    feature -= mapIndex * DEFAULT_MAX_BYTE_LENGTH;
    PROF_CHK_EXPR_ACTION(mapIndex >= DEFAULT_FEATURES_BYTE_MAP, return false,
        "The value of [%u] exceeds byte map upper limit [%d].", feature, DEFAULT_FEATURES_BYTE_MAP);
    uint32_t bitValue = (param->features[mapIndex] >> feature) & 1U;
    return bitValue == 1U;
}
