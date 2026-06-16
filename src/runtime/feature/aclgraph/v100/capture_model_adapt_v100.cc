/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "capture_model.hpp"
#include "context.hpp"

namespace cce {
namespace runtime {

rtError_t CaptureModel::BindSqCqAndSendSqe(void)
{
    rtError_t error = SendSqe();
    ERROR_RETURN_MSG_INNER(error, "Send sqe failed, model_id=%u, retCode=%#x.", Id_(), static_cast<uint32_t>(error));

    error = BindSqCq();
    ERROR_RETURN_MSG_INNER(error, "Bind sq cq failed, model_id=%u, retCode=%#x.", Id_(), static_cast<uint32_t>(error));

    error = BindStreamToModel();
    ERROR_RETURN_MSG_INNER(error, "Bind stream to model failed, model_id=%u, retCode=%#x.", Id_(), static_cast<uint32_t>(error));
    
    error = ConfigSqTail();
    ERROR_RETURN_MSG_INNER(error, "Config sq tail failed, model_id=%u, retCode=%#x.", Id_(), static_cast<uint32_t>(error));
    return error;
}

rtError_t CaptureModel::BindJettyForUbdma()
{
    return RT_ERROR_NONE;
}

rtError_t CaptureModel::RecycleAllJetty(uint32_t &h2dCount, uint32_t &d2dCount)
{
    h2dCount = 0;
    d2dCount = 0;
    return RT_ERROR_NONE;
}

rtError_t CaptureModel::ReleaseAllJetty()
{
    return RT_ERROR_NONE;
}
} // namespace runtime
} // namespace cce
