/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef QUEUE_SCHEDULE_BQS_STATUS_H
#define QUEUE_SCHEDULE_BQS_STATUS_H
namespace bqs {
/**
 * buffer queue schedule status code
 */
enum BqsStatus {
    BQS_STATUS_OK = 0,
    BQS_STATUS_PARAM_INVALID = 1,
    BQS_STATUS_INNER_ERROR = 2,
    BQS_STATUS_DRIVER_ERROR = 3,
    BQS_STATUS_EASY_COMM_ERROR = 4,
    BQS_STATUS_PROTOBUF_ERROR = 5,
    BQS_STATUS_HCCL_ERROR = 6,
    BQS_STATUS_QUEUE_AHTU_ERROR = 7,
    BQS_STATUS_QUEUE_ID_ERROR = 8,
    BQS_STATUS_NOT_INIT = 9,
    BQS_STATUS_TIMEOUT = 10,
    BQS_STATUS_FAILED = 11,
    BQS_STATUS_GROUP_NOT_EXIST = 12,
    BQS_STATUS_GROUP_HAS_EXIST = 13,
    BQS_STATUS_ENTITY_EXIST = 14,
    BQS_STATUS_GROUP_EXIST_IN_ROUTE = 15,
    BQS_STATUS_ATTACH_GROUP_FALED = 16,
    BQS_STATUS_DYNAMIC_SCHEDULE_ERROR = 17,
    BQS_STATUS_ENDPOINT_MEM_TYPE_NOT_SUPPORT = 18,
    BQS_STATUS_NO_NEED_MEM_QUEUE_TRANSFORM = 19,
    BQS_STATUS_NOT_SUPPORT = 20,
    BQS_STATUS_WAIT = 21,
    BQS_STATUS_RETRY = 100,
};
}  // namespace bqs
#endif  // QUEUE_SCHEDULE_BQS_STATUS_H

