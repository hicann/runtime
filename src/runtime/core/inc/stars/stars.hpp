/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef __CCE_RUNTIME_STARS_HPP__
#define __CCE_RUNTIME_STARS_HPP__

#include "stars_cond_isa_define.hpp"
#include "task_info.hpp"
#include "stars_base.hpp"
#include "stars_sqe.hpp"

namespace cce {
namespace runtime {
constexpr uint8_t RT_STARS_AS31XM1X_DEFAULT_KERNEL_CREDIT = 3U; // The TS reference time is 33.5 ms.
constexpr float32_t RT_STARS_AS31XM1X_TASK_KERNEL_CREDIT_SCALE = 33.5F; // 2^24 / 500M *1000(ms)
constexpr uint8_t RT_STARS_FFTSPLUS_SUBTYPE_MIX = 0x1U;
constexpr uint8_t RT_STARS_FFTSPLUS_HCCL_WITHOUT_AICAIV_FLAG = 0x5AU;
constexpr uint8_t RT_STARS_FFTSPLUS_HCCL_WITH_AICAIV_FLAG = 0x5BU;

constexpr uint16_t TS_FFTS_TYPE_AIC_ONLY = 0U;
constexpr uint16_t TS_FFTS_TYPE_AIV_ONLY = 1U;
constexpr uint16_t TS_FFTS_TYPE_AIC_AIV_MIX = 5U;
constexpr uint8_t RT_STARS_DCACHE_LOCK_OP = 0x0AU;
constexpr uint8_t RT_STARS_SQE_LEN = 64U;


enum rtStarsCqeErrorCodeType {
    RT_STARS_CQE_ERR_TYPE_EXCEPTION        = (1ULL << 0U),
    RT_STARS_CQE_ERR_TYPE_TRAP             = (1ULL << 1U),
    RT_STARS_CQE_ERR_TYPE_TASK_TIMEOUT     = (1ULL << 2U),
    RT_STARS_CQE_ERR_TYPE_SQE_ERROR        = (1ULL << 3U),
    RT_STARS_CQE_ERR_TYPE_RES_CONFLICT     = (1ULL << 4U),
    RT_STARS_CQE_ERR_TYPE_SW_STATUS        = (1ULL << 5U)
};

#pragma pack(push)
#pragma pack (1)

constexpr uint16_t RT_FLIP_TASK_STREAM_ID = 1U; 
constexpr uint8_t STARS_CALLBACK_EVENT_RECORD_CMDTYPE = 15U;
constexpr uint32_t STARS_CDQM_CDQE_SIZE = 15;

/**
* @ingroup
* @brief the struct define of cqe when task is completed
*/
struct rtStarsCqeSysCnt_t {
    uint32_t syscnt_low;
    uint32_t syscnt_high;
};

struct rtStarsModelExecuteError_t {
    uint16_t task_id;
    uint16_t stream_id : 12; /* 0~4096 for stream_id */
    uint16_t result : 4;
};

/* used for stream expand spec */
struct rtStarsModelExecuteErrorEx_t {
    uint16_t task_id;
    uint16_t sq_id : 12; /* sq_id */
    uint16_t result : 4;
};

union rtStarsCqeSwStatus_t {
    rtStarsModelExecuteError_t model_exec;
    rtStarsModelExecuteErrorEx_t model_exec_ex;
    uint32_t value;
};

struct rtStarsCqeErrorInfo_t {
    uint8_t error_code;
    uint8_t drop_flag; /* software define, means drop hw cqe and no dispatch to logic cq */
    uint8_t res0 : 1;
    uint8_t sqe_type : 6;
    uint16_t sqe_index;
    rtStarsCqeSwStatus_t sq_sw_status;
};

union rtStarsCqeStatus_t {
    rtStarsCqeSysCnt_t sysCnt;
    rtStarsCqeErrorInfo_t errorInfo;
};

struct rtStarsCqe_t {
    uint16_t phase : 1;
    uint16_t warn : 1; /* process warning */
    uint16_t evt : 1;  /* event record flag */
    uint16_t place_hold : 1;
    uint16_t SQ_id : 11;
    uint16_t error_bit : 1;
    uint16_t SQ_head;

    uint16_t streamID;
    uint16_t taskID;

    rtStarsCqeStatus_t cqe_status;
};

#pragma pack(pop)

void ToConstructSqe(TaskInfo *taskInfo, rtStarsSqe_t *const command);
void PrintSqe(const rtStarsSqe_t * const sqe, const char *desc);
void ConstructPcieDmaSqe(TaskInfo * const taskInfo, rtStarsSqe_t *const command);

}  // namespace runtime
}  // namespace cce
#endif  // __CCE_RUNTIME_STARS_HPP__
