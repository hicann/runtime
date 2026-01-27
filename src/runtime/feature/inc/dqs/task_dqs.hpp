/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CCE_RUNTIME_TASK_DQS_HPP
#define CCE_RUNTIME_TASK_DQS_HPP

#include "rts_dqs.h"
#include <cstdint>

namespace cce {
namespace runtime {

union DqsTaskConfig {
    rtDqsSchedCfg_t *dqsSchedCfg;
    rtDqsZeroCopyCfg_t *zeroCopyCfg;
    rtDqsAdspcTaskCfg_t *adspcCfg;
    rtDqsConditionCopyCfg_t *condCopyCfg;
};

constexpr uint32_t DQS_INTER_CHIP_GROUP_MAX = 255U;
constexpr uint64_t DQS_CONDITION_COPY_SIZE_MAX = 512ULL;

enum class DqsInterChipTaskType : int32_t {
    DQS_INTER_CHIP_TASK_PREPROC = 0,
    DQS_INTER_CHIP_TASK_MEMCPY_MBUF_HEAD,
    DQS_INTER_CHIP_TASK_MEMCPY_MBUF_DATA,
    DQS_INTER_CHIP_TASK_POSTPROC
};

}  // namespace runtime
}  // namespace cce

#endif // CCE_RUNTIME_TASK_DQS_HPP