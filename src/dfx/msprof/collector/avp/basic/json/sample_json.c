/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "sample_json.h"
#include "json_generator.h"
#include "logger/logger.h"
#include "transport/transport.h"
#include "transport/uploader.h"

JsonObj *g_sampleJson = NULL;

/**
 * @brief      Send string to uploader
 * @param [in] deviceId: device id
 * @param [in] content: string data of sample json
 * @return     success: PROFILING_SUCCESS
 *             failed : PROFILING_FAILED
 */
static int32_t UploadSampleJson(uint32_t deviceId, char* content, size_t contentLen)
{
    PROF_CHK_EXPR_ACTION(content == NULL, return PROFILING_FAILED, "UploadSampleJson failed with null content.");
    PROF_CHK_EXPR_ACTION_TWICE(deviceId > DEFAULT_HOST_ID, OSAL_MEM_FREE(content), return PROFILING_FAILED,
        "UploadSampleJson failed with device id %u.", deviceId);
    ProfFileChunk *chunk = (ProfFileChunk*)OsalMalloc(sizeof(ProfFileChunk));
    if (chunk == NULL) {
        OSAL_MEM_FREE(content);
        MSPROF_LOGE("Failed to malloc chunk for UploadSampleJson.");
        return PROFILING_FAILED;
    }
    chunk->chunk = (uint8_t*)content;
    chunk->deviceId = (uint8_t)deviceId;
    chunk->chunkSize = contentLen;
    chunk->chunkType = PROF_CTRL_DATA;
    chunk->isLastChunk = false;
    chunk->offset = -1;
    errno_t result = strcpy_s(chunk->fileName, sizeof(chunk->fileName), "sample.json");
    PROF_CHK_EXPR_ACTION(result != EOK, break, "strcpy_s name sample.json to chunk failed.");
    int32_t ret = UploaderUploadData(chunk);
    PROF_CHK_EXPR_ACTION(ret != PROFILING_SUCCESS, return PROFILING_FAILED, "Failed to upload sample json data.");
    return PROFILING_SUCCESS;
}

/**
 * @brief      Create sample json string and send it to uploader.
 * @param [in] params: ProfileParam
 * @param [in] deviceId: device id
 * @return     success: PROFILING_SUCCESS
 *             failed : NPROFILING_FAILEDULL
 */
int32_t CreateSampleJson(ProfileParam *params, uint32_t deviceId)
{
    PROF_CHK_EXPR_ACTION(params == NULL, return PROFILING_FAILED, "Params is null, please check contexts log.");
    g_sampleJson = JsonInit();
    PROF_CHK_EXPR_ACTION(g_sampleJson == NULL, return PROFILING_FAILED, "Init sample json file failed.");
    char *devIdStr = TransferUint32ToString(deviceId);
    g_sampleJson->SetValueByKey(g_sampleJson, "stream_enabled",
        (JsonObj){{.stringValue = "on"}, .type = CJSON_STRING})
        ->SetValueByKey(g_sampleJson, "host_sys_pid",
        (JsonObj){{.intValue = params->config.hostPid}, .type = CJSON_INT})
        ->SetValueByKey(g_sampleJson, "prof_level",
        (JsonObj){{.stringValue = params->config.profLevel}, .type = CJSON_STRING})
        ->SetValueByKey(g_sampleJson, "result_dir",
        (JsonObj){{.stringValue = params->config.resultDir}, .type = CJSON_STRING})
        ->SetValueByKey(g_sampleJson, "devices",
        (JsonObj){{.stringValue = devIdStr}, .type = CJSON_STRING})
        ->SetValueByKey(g_sampleJson, "aicore_sampling_interval",
        (JsonObj){{.intValue = params->config.aicSamplingInterval}, .type = CJSON_INT})
        ->SetValueByKey(g_sampleJson, "aiv_sampling_interval",
        (JsonObj){{.intValue = params->config.aivSamplingInterval}, .type = CJSON_INT})
        ->SetValueByKey(g_sampleJson, "ai_core_profiling_mode",
        (JsonObj){{.stringValue = params->config.aiCoreProfilingMode}, .type = CJSON_STRING})
        ->SetValueByKey(g_sampleJson, "aiv_profiling_mode",
        (JsonObj){{.stringValue = params->config.aiVectProfilingMode}, .type = CJSON_STRING})
        ->SetValueByKey(g_sampleJson, "ai_core_metrics",
        (JsonObj){{.stringValue = params->config.aiCoreMetrics}, .type = CJSON_STRING})
        ->SetValueByKey(g_sampleJson, "aiv_metrics",
        (JsonObj){{.stringValue = params->config.aiVectMetrics}, .type = CJSON_STRING})
        ->SetValueByKey(g_sampleJson, "ai_core_profiling_events",
        (JsonObj){{.stringValue = params->config.aicEvents}, .type = CJSON_STRING})
        ->SetValueByKey(g_sampleJson, "aiv_profiling_events",
        (JsonObj){{.stringValue = params->config.aivEvents}, .type = CJSON_STRING});
    if (IsEnable(&params->config, PLATFORM_TASK_AIC_METRICS)) {
        g_sampleJson->SetValueByKey(g_sampleJson, "ai_core_profiling",
            (JsonObj){{.stringValue = "on"}, .type = CJSON_STRING});
        g_sampleJson->SetValueByKey(g_sampleJson, "aiv_profiling",
            (JsonObj){{.stringValue = "on"}, .type = CJSON_STRING});
    } else {
        g_sampleJson->SetValueByKey(g_sampleJson, "ai_core_profiling",
            (JsonObj){{.stringValue = "off"}, .type = CJSON_STRING});
        g_sampleJson->SetValueByKey(g_sampleJson, "aiv_profiling",
            (JsonObj){{.stringValue = "off"}, .type = CJSON_STRING});
    }
    OSAL_MEM_FREE(devIdStr);
    char *sampleString = JsonToString(g_sampleJson);
    PROF_CHK_EXPR_ACTION_TWICE(sampleString == NULL, JsonFree(g_sampleJson), return PROFILING_FAILED,
        "CreateSampleJson failed with null string.");
    int32_t ret = UploadSampleJson(deviceId, sampleString, strlen(sampleString));
    JsonFree(g_sampleJson);
    return ret;
}