/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "host_task.hpp"
#include "npu_driver.hpp"
#include "error_message_manage.hpp"

namespace cce {
namespace runtime {
TIMESTAMP_EXTERN(rtMemcpyHostTask_MemCopyAsync);
rtError_t HostTaskMemCpy::AsyncCall()
{
    TIMESTAMP_BEGIN(rtMemcpyHostTask_MemCopyAsync);
    const rtError_t retCode = drv_->MemCopyAsync(dst_, destMax_, src_, cnt_, kind_, copyFd_);
    TIMESTAMP_END(rtMemcpyHostTask_MemCopyAsync);
    ERROR_RETURN_MSG_INNER(retCode, "Asynchronous memcpy failed, kind = %d, retCode = %#x.",
                           static_cast<int32_t>(RT_MEMCPY_HOST_TO_DEVICE), static_cast<uint32_t>(retCode));
    RT_LOG(RT_LOG_INFO, "HostTaskMemCpy AsyncCall success. destMax=%" PRIu64 ", size=%" PRIu64
        ", kind=%u copyFd_=%" PRIu64, destMax_, cnt_, static_cast<uint32_t>(kind_), copyFd_);

    return RT_ERROR_NONE;
}

rtError_t HostTaskMemCpy::WaitFinish()
{
    const rtError_t retCode = drv_->MemCopyAsyncWaitFinish(copyFd_);
    ERROR_RETURN_MSG_INNER(retCode, "MemCopyAsyncWaitFinish for memcpyHost result failed, retCode = %#x.",
                           static_cast<uint32_t>(retCode));
    copyFd_ = 0ULL;
    return RT_ERROR_NONE;
}
}
}