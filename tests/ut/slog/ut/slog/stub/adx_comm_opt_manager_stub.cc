/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "adx_comm_opt_manager.h"
#include "adx_service_config.h"
using  namespace Adx;
namespace Adx {
AdxCommOptManager::~AdxCommOptManager()
{

}

int32_t AdxCommOptManager::Close(CommHandle &handle) const
{
    return 0;
}

int32_t IdeGetDevIdBySession(void *session, int *id)
{
    return 0;
}

int32_t IdeGetPidBySession(void *session, int *id)
{
    return 0;
}
}