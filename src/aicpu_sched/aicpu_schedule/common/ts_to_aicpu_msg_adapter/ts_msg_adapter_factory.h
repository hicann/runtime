/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef TS_MSG_ADAPTER_FACTORY_H
#define TS_MSG_ADAPTER_FACTORY_H
#include "ts_msg_adapter.h"
#include "ts_aicpu_sqe_adapter.h"
#include "ts_aicpu_msg_info_adapter.h"
namespace AicpuSchedule {
class TsMsgAdapterFactory {
public:
    std::unique_ptr<TsMsgAdapter> CreateAdapter(const char_t *msg) const;
    std::unique_ptr<TsMsgAdapter> CreateAdapter() const;
    TsMsgAdapterFactory(const TsMsgAdapterFactory&) = delete;
    TsMsgAdapterFactory(TsMsgAdapterFactory&&) = delete;
    TsMsgAdapterFactory& operator=(const TsMsgAdapterFactory&) = delete;
    TsMsgAdapterFactory& operator=(TsMsgAdapterFactory&&) = delete;
    TsMsgAdapterFactory() = default;
    ~TsMsgAdapterFactory() = default;
};
} // namespace AicpuSchedule
#endif
