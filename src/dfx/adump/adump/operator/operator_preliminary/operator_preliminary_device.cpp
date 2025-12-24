/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "operator_preliminary.h"

#include "log/adx_log.h"

namespace Adx {
const std::map<PlatformType, std::string> BIN_NAME_MAP = {};

OperatorPreliminary::OperatorPreliminary(const DumpSetting &setting, const uint32_t deviceId)
    : deviceId_(deviceId), setting_(setting)
{
}

OperatorPreliminary::~OperatorPreliminary()
{
}

int32_t OperatorPreliminary::OperatorInit()
{
    IDE_LOGW("Start to destroy rt api resources on device %u.", deviceId_);
    return ADUMP_SUCCESS;
}
}
