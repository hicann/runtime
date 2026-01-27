/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "transport.h"
#include "file_transport.h"
#include "flash_transport.h"
#include "logger/logger.h"
#include "utils/utils.h"

int32_t CreateUploaderTransport(uint32_t deviceId, TransportType type, Transport* transport,
    const char *flushDir)
{
    int32_t ret = PROFILING_FAILED;
    switch (type) {
        case FILE_TRANSPORT:
#ifndef LITE_OS
            ret = FileInitTransport(deviceId, transport, flushDir);
#endif
            break;
        case FLSH_TRANSPORT:
            ret = FlashInitTransport(transport);
            break;
        default:
            MSPROF_LOGE("Failed to find tranport type.");
            ret = PROFILING_FAILED;
            break;
    }

    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to create uploader transport, type: %d", type);
        return PROFILING_FAILED;
    }

    return PROFILING_SUCCESS;
}