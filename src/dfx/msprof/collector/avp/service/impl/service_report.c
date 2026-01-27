/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "service_report.h"
#include "osal/osal_mem.h"
#include "logger/logger.h"
#include "errno/error_code.h"
#include "report/hash_dic.h"
#include "report/report_buffer_mgr.h"
#include "report/report_manager.h"

int32_t ServiceReportApiPush(uint8_t aging, const struct MsprofApi *data)
{
    if (data == NULL) {
        MSPROF_LOGW("Ring buffer api_event received NULL data.");
        return PROFILING_FAILED;
    }
    return ReportApiPush(aging, data);
}

int32_t ServiceReportCompactPush(uint8_t aging, const struct MsprofCompactInfo *data, uint32_t length)
{
    if (data == NULL || length == 0) {
        MSPROF_LOGW("Ring buffer compact received unexpected report data.");
        return PROFILING_FAILED;
    }
    return ReportCompactPush(aging, data);
}

int32_t ServiceReportAdditionalPush(uint8_t aging, const struct MsprofAdditionalInfo *data, uint32_t length)
{
    if (data == NULL || length == 0) {
        MSPROF_LOGW("Ring buffer additional received unexpected report data.");
        return PROFILING_FAILED;
    }
    return ReportAdditionalPush(aging, data);
}

int32_t RegisterTypeInfo(uint16_t level, uint32_t typeId, const char *typeName)
{
    if (level == 0 || typeName == NULL) {
        MSPROF_LOGI("Register type info is invalid, level: [%u], type name %s", level, typeName);
        return PROFILING_FAILED;
    }
    MSPROF_LOGI("Register type info of reporter[%u], type id %u, type name %s", level, typeId, typeName);
    return RegReportTypeInfo(level, typeId, typeName);
}

uint64_t ServiceHashId(const char *hashInfo, size_t length)
{
    if (hashInfo == NULL || length == 0) {
        MSPROF_LOGE("HashData hashInfo is empty.");
        return UINT64_MAX;
    }
    return GeneratedHashId(hashInfo);
}