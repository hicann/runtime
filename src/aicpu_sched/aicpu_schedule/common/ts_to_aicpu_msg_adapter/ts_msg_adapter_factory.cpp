/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "ts_msg_adapter_factory.h"
#include "ts_msg_adapter_common.h"
namespace AicpuSchedule {
std::unique_ptr<TsMsgAdapter> TsMsgAdapterFactory::CreateAdapter(const char_t *msg) const
{
    if (msg == nullptr) {
        aicpusd_err("Create adapter failed: input_message=null.");
        return nullptr;
    }
    const uint8_t version = FeatureCtrl::GetTsMsgVersion();
    switch (version) {
        case VERSION_0: {
            const TsAicpuSqe* const sqe = PtrToPtr<const char_t, const TsAicpuSqe>(msg);
            return std::make_unique<TsAicpuSqeAdapter>(*sqe);
        }
        case VERSION_1: {
            const TsAicpuMsgInfo * const msgInfo = PtrToPtr<const char_t, const TsAicpuMsgInfo>(msg);
            return std::make_unique<TsAicpuMsgInfoAdapter>(*msgInfo);
        }
        default:
            aicpusd_err("Create adapter failed: unsupported_version=%u.", version);
    }
    return nullptr;
}

std::unique_ptr<TsMsgAdapter> TsMsgAdapterFactory::CreateAdapter() const
{
    const uint8_t version = FeatureCtrl::GetTsMsgVersion();
    switch (version) {
        case VERSION_0: {
            return std::make_unique<TsAicpuSqeAdapter>();
        }
        case VERSION_1: {
            return std::make_unique<TsAicpuMsgInfoAdapter>();
        }
        default:
            aicpusd_err("Create adapter failed: unsupported_version=%u.", version);
    }
    return nullptr;
}
} // namespace AicpuSchedule
