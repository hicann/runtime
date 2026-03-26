/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <cstdint>
#include <cstring>
#include <unistd.h>
#include "acl/acl.h"
#include "acl/acl_tdt_queue.h"
#include "2_advanced_features/tdt_common_utils.h"
#include "utils.h"

int main()
{
    const int32_t deviceId = 0;
    const char queueName[] = "grant_attach_queue";
    const uint32_t depth = 4;
    const uint32_t permissionMask = ACL_TDT_QUEUE_PERMISSION_MANAGE |
                                    ACL_TDT_QUEUE_PERMISSION_DEQUEUE |
                                    ACL_TDT_QUEUE_PERMISSION_ENQUEUE;

    uint32_t qid = 0;
    uint32_t attachedPermission = 0;

    CHECK_ERROR(aclInit(nullptr));
    CHECK_ERROR(aclrtSetDevice(deviceId));

    acltdtQueueAttr *attr = acltdtCreateQueueAttr();
    if (!tdt::CheckNotNull(attr, "acltdtCreateQueueAttr")) {
        return -1;
    }

    CHECK_ERROR(acltdtSetQueueAttr(attr, ACL_TDT_QUEUE_NAME_PTR, sizeof(queueName), queueName));
    CHECK_ERROR(acltdtSetQueueAttr(attr, ACL_TDT_QUEUE_DEPTH_UINT32, sizeof(depth), &depth));
    CHECK_ERROR(acltdtCreateQueue(attr, &qid));

    CHECK_ERROR(acltdtGrantQueue(qid, static_cast<int32_t>(getpid()), permissionMask, 1000));
    CHECK_ERROR(acltdtAttachQueue(qid, 1000, &attachedPermission));
    INFO_LOG("Attached permission mask: %u", attachedPermission);

    const char *payload = "queue grant attach";
    const uint32_t userData = 2026;
    CHECK_ERROR(acltdtEnqueueData(
        qid,
        payload,
        std::strlen(payload) + 1,
        &userData,
        sizeof(userData),
        1000,
        0));

    char recvData[64] = {0};
    uint32_t recvUserData = 0;
    size_t recvDataSize = 0;
    CHECK_ERROR(acltdtDequeueData(
        qid,
        recvData,
        sizeof(recvData),
        &recvDataSize,
        &recvUserData,
        sizeof(recvUserData),
        1000));
    INFO_LOG("Dequeued payload=%s, payloadSize=%zu, userData=%u", recvData, recvDataSize, recvUserData);

    CHECK_ERROR(acltdtDestroyQueue(qid));
    CHECK_ERROR(acltdtDestroyQueueAttr(attr));
    CHECK_ERROR(aclrtResetDeviceForce(deviceId));
    CHECK_ERROR(aclFinalize());
    return 0;
}
