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
#include "acl/acl.h"
#include "acl/acl_tdt_queue.h"
#include "2_advanced_features/tdt_common_utils.h"
#include "utils.h"

int main()
{
    const int32_t deviceId = 0;
    const char queueName[] = "simple_queue";
    const char* queueNamePtr = queueName;
    constexpr size_t kQueueNamePtrSize = sizeof(const char*);
    const uint32_t depth = 4;

    uint32_t qid = 0;
    acltdtQueueAttr* attr = nullptr;
    bool aclInitialized = false;
    bool deviceSet = false;
    bool queueCreated = false;

    const int32_t result = [&]() -> int32_t {
        CHECK_ERROR(aclInit(nullptr));
        aclInitialized = true;
        CHECK_ERROR(aclrtSetDevice(deviceId));
        deviceSet = true;

        attr = acltdtCreateQueueAttr();
        if (!tdt::CheckNotNull(attr, "acltdtCreateQueueAttr")) {
            return -1;
        }

        CHECK_ERROR(acltdtSetQueueAttr(attr, ACL_TDT_QUEUE_NAME_PTR, kQueueNamePtrSize, &queueNamePtr));
        CHECK_ERROR(acltdtSetQueueAttr(attr, ACL_TDT_QUEUE_DEPTH_UINT32, sizeof(depth), &depth));

        const char* queriedName = nullptr;
        uint32_t queriedDepth = 0;
        size_t realLen = 0;
        CHECK_ERROR(acltdtGetQueueAttr(attr, ACL_TDT_QUEUE_NAME_PTR, kQueueNamePtrSize, &realLen, &queriedName));
        CHECK_ERROR(
            acltdtGetQueueAttr(attr, ACL_TDT_QUEUE_DEPTH_UINT32, sizeof(queriedDepth), &realLen, &queriedDepth));
        INFO_LOG("QueueAttr name=%s, depth=%u", queriedName == nullptr ? "<null>" : queriedName, queriedDepth);

        CHECK_ERROR(acltdtCreateQueue(attr, &qid));
        queueCreated = true;
        INFO_LOG("Created queue id=%u", qid);
        return 0;
    }();

    int32_t finalResult = result;
    if (queueCreated) {
        tdt::UpdateFinalResultOnError("acltdtDestroyQueue(qid)", acltdtDestroyQueue(qid), finalResult);
    }
    if (attr != nullptr) {
        tdt::UpdateFinalResultOnError("acltdtDestroyQueueAttr(attr)", acltdtDestroyQueueAttr(attr), finalResult);
    }
    if (deviceSet) {
        tdt::UpdateFinalResultOnError("aclrtResetDeviceForce(deviceId)", aclrtResetDeviceForce(deviceId), finalResult);
    }
    if (aclInitialized) {
        tdt::UpdateFinalResultOnError("aclFinalize()", aclFinalize(), finalResult);
    }
    if (finalResult == 0) {
        INFO_LOG("Run the simple_queue sample successfully.");
    }
    return finalResult;
}
