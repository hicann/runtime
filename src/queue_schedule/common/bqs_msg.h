/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef QUEUE_SCHEDULE_BQS_MSG_H
#define QUEUE_SCHEDULE_BQS_MSG_H

#include <cstdint>
#include <vector>
#include <string>
#include "common/type_def.h"

namespace bqs {
// message header length 4 bytes
// msg size(4) + msgid size(4)
constexpr const uint32_t BQS_MSG_HEAD_SIZE(4U);
// max queue id created by drv range is [0-8K)
constexpr const uint32_t MAX_QUEUE_ID_NUM = 8192U;
// Maximum waiting time for message processing notification in milliseconds.
constexpr const uint32_t MAX_WAITING_NOTIFY = 10000U;
// qs run mode
enum class QueueSchedulerRunMode {
    SINGLE_PROCESS = 0,
    MULTI_PROCESS,
    MULTI_THREAD,
};
// qs operation type
enum class QsOperType {
    BIND_INIT = 0,
    QUERY_NUM,
    RELATION_PROCESS,
    CREATE_HCOM_HANDLE,
    CREATE_HCOM_TAG,
    DESTROY_HCOM_TAG,
    DESTROY_HCOM_HANDLE,
    UPDATE_CONFIG,
    QUERY_CONFIG_NUM,
    QUERY_CONFIG,
    BIND_HOST_PID,
    QUERY_LINKSTATUS,
    QUERY_LINKSTATUS_V2,
};

enum class QsStartType {
    START_BY_TSD = 0,
    START_BY_DEPLOYER,
};

struct InitQsParams {
    uint32_t deviceId;
    uint32_t enqueGroupId;
    uint32_t f2nfGroupId;
    uint32_t reschedInterval;
    QueueSchedulerRunMode runMode;
    uint32_t pid;
    uint32_t vfId;
    std::string pidSign;
    std::string qsInitGrpName;
    uint64_t schedPolicy;
    QsStartType starter;
    std::string profCfgData;
    uint32_t abnormalInterVal;
    bool profFlag;
    uint32_t enqueGroupIdExtra;
    uint32_t f2nfGroupIdExtra;
    uint32_t deviceIdExtra;
    bool numaFlag;
    std::vector<uint32_t> devIdVec;
    bool needAttachGroup;
};
}  // namespace bqs

#endif  // QUEUE_SCHEDULE_BQS_MSG_H