/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <algorithm>
#include <cstdint>
#include <cstring>
#include "acl/acl.h"
#include "acl/acl_tdt_queue.h"
#include "2_advanced_features/tdt_common_utils.h"
#include "utils.h"

int main()
{
    const int32_t deviceId = 0;
    const char queueName[] = "simple_queue";
    const uint32_t depth = 4;

    uint32_t qid = 0;
    acltdtBuf outputBuf = nullptr;

    CHECK_ERROR(aclInit(nullptr));
    CHECK_ERROR(aclrtSetDevice(deviceId));

    acltdtQueueAttr *attr = acltdtCreateQueueAttr();
    if (!tdt::CheckNotNull(attr, "acltdtCreateQueueAttr")) {
        return -1;
    }

    CHECK_ERROR(acltdtSetQueueAttr(attr, ACL_TDT_QUEUE_NAME_PTR, sizeof(queueName), queueName));
    CHECK_ERROR(acltdtSetQueueAttr(attr, ACL_TDT_QUEUE_DEPTH_UINT32, sizeof(depth), &depth));

    char queriedName[64] = {0};
    uint32_t queriedDepth = 0;
    size_t realLen = 0;
    CHECK_ERROR(acltdtGetQueueAttr(attr, ACL_TDT_QUEUE_NAME_PTR, sizeof(queriedName), &realLen, queriedName));
    CHECK_ERROR(acltdtGetQueueAttr(attr, ACL_TDT_QUEUE_DEPTH_UINT32, sizeof(queriedDepth), &realLen, &queriedDepth));
    INFO_LOG("QueueAttr name=%s, depth=%u", queriedName, queriedDepth);

    CHECK_ERROR(acltdtCreateQueue(attr, &qid));
    INFO_LOG("Created queue id=%u", qid);

    acltdtBuf inputBuf = nullptr;
    CHECK_ERROR(acltdtAllocBuf(64, ACL_TDT_NORMAL_MEM, &inputBuf));

    void *inputPtr = nullptr;
    size_t inputCapacity = 0;
    CHECK_ERROR(acltdtGetBufData(inputBuf, &inputPtr, &inputCapacity));

    const char *payload = "hello queue";
    const size_t payloadLen = std::strlen(payload) + 1;
    if (inputPtr == nullptr || payloadLen > inputCapacity) {
        ERROR_LOG(
            "Invalid input buffer: ptr=%p, capacity=%zu, required=%zu",
            inputPtr,
            inputCapacity,
            payloadLen);
        return -1;
    }
    std::copy_n(payload, payloadLen, static_cast<char *>(inputPtr));

    CHECK_ERROR(acltdtSetBufDataLen(inputBuf, payloadLen));
    CHECK_ERROR(acltdtEnqueue(qid, inputBuf, 1000));

    CHECK_ERROR(acltdtDequeue(qid, &outputBuf, 1000));

    void *outputPtr = nullptr;
    size_t outputCapacity = 0;
    size_t outputLen = 0;
    CHECK_ERROR(acltdtGetBufData(outputBuf, &outputPtr, &outputCapacity));
    CHECK_ERROR(acltdtGetBufDataLen(outputBuf, &outputLen));
    INFO_LOG(
        "Dequeued buffer: capacity=%zu, dataLen=%zu, payload=%s",
        outputCapacity,
        outputLen,
        outputPtr == nullptr ? "<null>" : static_cast<char *>(outputPtr));

    CHECK_ERROR(acltdtFreeBuf(outputBuf));
    CHECK_ERROR(acltdtDestroyQueue(qid));
    CHECK_ERROR(acltdtDestroyQueueAttr(attr));
    CHECK_ERROR(aclrtResetDeviceForce(deviceId));
    CHECK_ERROR(aclFinalize());
    return 0;
}
