/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef SERVICE_IMPL_SERVICE_REPORT_H
#define SERVICE_IMPL_SERVICE_REPORT_H
#include "toolchain/prof_api.h"

int32_t ServiceReportInitialize(uint32_t index, uint32_t length);
int32_t ServiceReportApiPush(uint8_t aging, const struct MsprofApi *data);
int32_t ServiceReportCompactPush(uint8_t aging, const struct MsprofCompactInfo *data, uint32_t length);
int32_t ServiceReportAdditionalPush(uint8_t aging, const struct MsprofAdditionalInfo *data, uint32_t length);
int32_t RegisterTypeInfo(uint16_t level, uint32_t typeId, const char *typeName);
uint64_t ServiceHashId(const char *hashInfo, size_t length);

#endif