/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "model_c.hpp"
#include "model_serial_sched_task.hpp"
#include "model.hpp"

namespace cce {
namespace runtime {
constexpr uint32_t MC32_CORE_NUM_PER_DIE = 4U;

rtError_t ModelSerialSchedPreProc(Stream* const stm, Notify* const notify, Model* const model)
{
    NULL_PTR_RETURN(notify, RT_ERROR_INVALID_VALUE);
    if (stm->Device_()->GetDevProperties().aivNumPerDie == MC32_CORE_NUM_PER_DIE) {
        return RT_ERROR_NONE;
    }

    ModelSerialSchedTaskParam param = {stm, notify, model};

    rtError_t error = LaunchModelSerialSchedTaskByType(stm, TS_TASK_TYPE_MODEL_SERIAL_SCHED_PREPROC, &param);
    COND_RETURN_ERROR(
        (error != RT_ERROR_NONE), error, "Launch model serial sched preproc task failed, retCode=%#x",
        static_cast<uint32_t>(error));

    error = LaunchModelSerialSchedTaskByType(stm, TS_TASK_TYPE_MODEL_SERIAL_SCHED_NOTIFY_WAIT, &param);
    COND_RETURN_ERROR(
        (error != RT_ERROR_NONE), error, "Launch model serial sched notify wait task failed, retCode=%#x",
        static_cast<uint32_t>(error));

    return error;
}

rtError_t ModelSerialSchedPostProc(Stream* const stm, Notify* const notify, Model* const model)
{
    NULL_PTR_RETURN(notify, RT_ERROR_INVALID_VALUE);
    if (stm->Device_()->GetDevProperties().aivNumPerDie == MC32_CORE_NUM_PER_DIE) {
        return RT_ERROR_NONE;
    }

    ModelSerialSchedTaskParam param = {stm, notify, model};

    rtError_t error = LaunchModelSerialSchedTaskByType(stm, TS_TASK_TYPE_MODEL_SERIAL_SCHED_POSTPROC, &param);
    COND_RETURN_ERROR(
        (error != RT_ERROR_NONE), error, "Launch model serial sched postproc task failed, retCode=%#x",
        static_cast<uint32_t>(error));
    return error;
}

} // namespace runtime
} // namespace cce