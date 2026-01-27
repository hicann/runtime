/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "core/aicpusd_interface_process.h"

namespace AicpuSchedule {
namespace {
}  // namespace
}  // namespace AicpuSchedule

/**
 * main of compute process.
 * @param  argc argv length
 * @param  argv arg values
 * @return 0:success, other:failed
 */
#ifndef aicpusd_UT

int32_t main(int32_t argc, char_t *argv[])
#else
int32_t ComputeProcessMain(int32_t argc, char_t *argv[])
#endif
{
    return AicpuSchedule::AicpuScheduleInterface::GetInstance().CustAicpuMainProcess(argc, argv);
}