/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "toolchain/prof_api.h"

int32_t MsprofRegisterCallback(uint32_t moduleId, ProfCommandHandle handle)
{
    return 0;
}
int32_t MsprofReportData(uint32_t moduleId, uint32_t type, void* data, uint32_t len)
{
    return 0;
}

int32_t MsprofNotifySetDevice(uint32_t chipId, uint32_t deviceId, bool isOpen)
{
    return 0;
}

uint64_t MsprofSysCycleTime()
{
    return 0;
}

int32_t MsprofRegTypeInfo(uint16_t level, uint32_t typeId, const char *typeName)
{
    return 0;
}

int32_t MsprofReportApi(uint32_t agingFlag, const MsprofApi *api)
{
    return 0;
}

int32_t MsprofReportCompactInfo(uint32_t agingFlag, const VOID_PTR data, uint32_t length)
{
    return 0;
}

uint64_t MsprofGetHashId(const char *hashInfo, size_t length)
{
    return 0U;
}

uint64_t MsprofStr2Id(const char *hashInfo, size_t length)
{
    return 0U;
}

int32_t MsprofReportAdditionalInfo(uint32_t nonPersistantFlag, const VOID_PTR data, uint32_t length)
{
    return 0;
}