/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "adump_device_pub.h"

ADX_API extern IDE_SESSION IdeDumpStart(const char *connectInfo)
{
    return 0;
}

ADX_API extern IdeErrorT IdeDumpData(IDE_SESSION session, const struct IdeDumpChunk *dumpChunk)
{
    return IDE_DAEMON_NONE_ERROR;
}

ADX_API extern IdeErrorT IdeDumpEnd(IDE_SESSION session)
{
    return IDE_DAEMON_NONE_ERROR;
}

