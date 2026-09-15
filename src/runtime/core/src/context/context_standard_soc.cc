/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "context.hpp"
#include "notify.hpp"

namespace cce {
namespace runtime {

rtError_t Context::CreateNotify(Notify** notify, uint32_t flag)
{
    const uint32_t deviceId = device_->Id_();
    *notify = new (std::nothrow) Notify(deviceId, device_->DevGetTsId());
    COND_RETURN_AND_MSG_OUTER(*notify == nullptr, RT_ERROR_NOTIFY_NEW, ErrorCode::EE1013, sizeof(Notify), "new");

    (*notify)->SetNotifyFlag(flag);
    const rtError_t error = (*notify)->Setup();
    if (error != RT_ERROR_NONE) {
        RT_LOG(
            RT_LOG_ERROR, "Notify create failed, setup failed, device_id=%d, retCode=%#x", deviceId,
            static_cast<uint32_t>(error));
        if ((error == RT_ERROR_DRV_NO_NOTIFY_RESOURCES) || (error == RT_ERROR_DRV_NO_RESOURCES)) {
            RT_LOG_OUTER_MSG_IMPL(
                ErrorCode::EE1023, "Alloc Notify resource", "Too many ACL graphs are executed concurrently");
        }
        DELETE_O(*notify);
        return error;
    }

    return RT_ERROR_NONE;
}

rtError_t Context::GetNotifyAddress(Notify* const notify, uint64_t& addr, Stream* const stm)
{
    const rtError_t error = notify->GetNotifyAddress(stm, addr);
    ERROR_RETURN_MSG_INNER(error, "Failed to get notify address, retCode=%#x.", error);
    return error;
}

} // namespace runtime
} // namespace cce
