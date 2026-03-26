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
#include "utils.h"

int main()
{
    const int32_t deviceId = 0;
    acltdtBuf headBuf = nullptr;
    acltdtBuf tailBuf = nullptr;
    acltdtBuf refBuf = nullptr;
    acltdtBuf chainItem = nullptr;

    CHECK_ERROR(aclInit(nullptr));
    CHECK_ERROR(aclrtSetDevice(deviceId));
    CHECK_ERROR(acltdtAllocBuf(64, ACL_TDT_NORMAL_MEM, &headBuf));
    CHECK_ERROR(acltdtAllocBuf(64, ACL_TDT_NORMAL_MEM, &tailBuf));

    void *headPtr = nullptr;
    size_t headCapacity = 0;
    CHECK_ERROR(acltdtGetBufData(headBuf, &headPtr, &headCapacity));

    const char *headPayload = "head-buffer";
    const size_t headPayloadLen = std::strlen(headPayload) + 1;
    if (headPtr == nullptr || headPayloadLen > headCapacity) {
        ERROR_LOG(
            "Invalid head buffer: ptr=%p, capacity=%zu, required=%zu",
            headPtr,
            headCapacity,
            headPayloadLen);
        return -1;
    }
    std::copy_n(headPayload, headPayloadLen, static_cast<char *>(headPtr));
    CHECK_ERROR(acltdtSetBufDataLen(headBuf, headPayloadLen));

    void *tailPtr = nullptr;
    size_t tailCapacity = 0;
    CHECK_ERROR(acltdtGetBufData(tailBuf, &tailPtr, &tailCapacity));

    const char *tailPayload = "tail-buffer";
    const size_t tailPayloadLen = std::strlen(tailPayload) + 1;
    if (tailPtr == nullptr || tailPayloadLen > tailCapacity) {
        ERROR_LOG(
            "Invalid tail buffer: ptr=%p, capacity=%zu, required=%zu",
            tailPtr,
            tailCapacity,
            tailPayloadLen);
        return -1;
    }
    std::copy_n(tailPayload, tailPayloadLen, static_cast<char *>(tailPtr));
    CHECK_ERROR(acltdtSetBufDataLen(tailBuf, tailPayloadLen));

    size_t headLen = 0;
    CHECK_ERROR(acltdtGetBufDataLen(headBuf, &headLen));
    INFO_LOG("Head buffer capacity=%zu, dataLen=%zu", headCapacity, headLen);

    const uint32_t userTag = 7;
    uint32_t queriedUserTag = 0;
    CHECK_ERROR(acltdtSetBufUserData(headBuf, &userTag, sizeof(userTag), 0));
    CHECK_ERROR(acltdtGetBufUserData(headBuf, &queriedUserTag, sizeof(queriedUserTag), 0));
    INFO_LOG("Queried user tag=%u", queriedUserTag);

    CHECK_ERROR(acltdtCopyBufRef(headBuf, &refBuf));
    CHECK_ERROR(acltdtAppendBufChain(headBuf, tailBuf));

    uint32_t chainNum = 0;
    CHECK_ERROR(acltdtGetBufChainNum(headBuf, &chainNum));
    CHECK_ERROR(acltdtGetBufFromChain(headBuf, 1, &chainItem));

    void *chainPtr = nullptr;
    size_t chainCapacity = 0;
    size_t chainLen = 0;
    CHECK_ERROR(acltdtGetBufData(chainItem, &chainPtr, &chainCapacity));
    CHECK_ERROR(acltdtGetBufDataLen(chainItem, &chainLen));
    INFO_LOG(
        "Chain num=%u, second payload=%s, secondLen=%zu",
        chainNum,
        chainPtr == nullptr ? "<null>" : static_cast<char *>(chainPtr),
        chainLen);

    CHECK_ERROR(acltdtFreeBuf(refBuf));
    CHECK_ERROR(acltdtFreeBuf(headBuf));
    CHECK_ERROR(aclrtResetDeviceForce(deviceId));
    CHECK_ERROR(aclFinalize());
    return 0;
}
