/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "capture_model.hpp"
#include "context.hpp"
#include "task_info.h"
#include "stream_david.hpp"
#include "memory_task.h"
#include "task.hpp"

namespace cce {
namespace runtime {

rtError_t CaptureModel::BindSqCqAndSendSqe(void)
{
    rtError_t error = BindSqCq();
    ERROR_RETURN(error, "Failed to bind SQ and CQ, model_id=%u, retCode=%#x.", Id_(), static_cast<uint32_t>(error));

    error = SendSqe();
    ERROR_RETURN(error, "Failed to send SQE, model_id=%u, retCode=%#x.", Id_(), static_cast<uint32_t>(error));

    error = BindStreamToModel();
    ERROR_RETURN(error, "Failed to bind stream to model, model_id=%u, retCode=%#x.", Id_(), static_cast<uint32_t>(error));

    error = ConfigSqTail();
    ERROR_RETURN(error, "Failed to configure SQ tail, model_id=%u, retCode=%#x.", Id_(), static_cast<uint32_t>(error));

    return error;
}
} // namespace runtime
} // namespace cce
