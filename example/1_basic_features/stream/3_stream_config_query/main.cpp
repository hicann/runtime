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
#include <cstdio>

#include "acl/acl.h"
#include "utils.h"

namespace {
constexpr int32_t kDeviceId = 0;
constexpr uint32_t kStreamFlags = 0;
constexpr uint32_t kStreamPriority = 0;

int CheckAcl(aclError ret, const char* expr)
{
    if (ret != ACL_SUCCESS) {
        fprintf(stderr, "[ERROR]  Operation failed: %s returned error code %d\n", expr, static_cast<int32_t>(ret));
        fflush(stderr);
        return -1;
    }
    return 0;
}

class StreamGuard {
public:
    explicit StreamGuard(aclrtStream stream) : stream_(stream) {}

    ~StreamGuard()
    {
        if (stream_ != nullptr) {
            CHECK_ERROR_WITHOUT_RETURN(aclrtDestroyStream(stream_));
        }
    }

    StreamGuard(const StreamGuard&) = delete;
    StreamGuard& operator=(const StreamGuard&) = delete;

    aclError Destroy()
    {
        if (stream_ == nullptr) {
            return ACL_SUCCESS;
        }

        aclError ret = aclrtDestroyStream(stream_);
        if (ret == ACL_SUCCESS) {
            stream_ = nullptr;
        }
        return ret;
    }

private:
    aclrtStream stream_;
};

int QueryStreamInfo(aclrtStream stream)
{
    int32_t streamId = -1;
    if (CheckAcl(aclrtStreamGetId(stream, &streamId), "aclrtStreamGetId") != 0) {
        return -1;
    }
    INFO_LOG("Stream id: %d", streamId);

    uint32_t flags = 0;
    if (CheckAcl(aclrtStreamGetFlags(stream, &flags), "aclrtStreamGetFlags") != 0) {
        return -1;
    }
    INFO_LOG("Stream flags: %u", flags);

    uint32_t priority = 0;
    if (CheckAcl(aclrtStreamGetPriority(stream, &priority), "aclrtStreamGetPriority") != 0) {
        return -1;
    }
    INFO_LOG("Stream priority: %u", priority);

    if ((flags != kStreamFlags) || (priority != kStreamPriority)) {
        ERROR_LOG(
            "Unexpected stream attributes: flags=%u, priority=%u; expected flags=%u, priority=%u", flags, priority,
            kStreamFlags, kStreamPriority);
        return -1;
    }
    return 0;
}

int RunStreamConfigQuerySample()
{
    aclrtStream stream = nullptr;
    if (CheckAcl(aclrtCreateStreamWithConfig(&stream, kStreamPriority, kStreamFlags), "aclrtCreateStreamWithConfig") !=
        0) {
        return -1;
    }
    StreamGuard streamGuard(stream);
    INFO_LOG("Create stream with priority=%u flags=%u successfully", kStreamPriority, kStreamFlags);

    if (QueryStreamInfo(stream) != 0) {
        return -1;
    }

    if (CheckAcl(aclrtSynchronizeStream(stream), "aclrtSynchronizeStream") != 0) {
        return -1;
    }
    if (CheckAcl(streamGuard.Destroy(), "aclrtDestroyStream") != 0) {
        return -1;
    }
    INFO_LOG("[SUCCESS] Stream config query sample completed successfully");
    return 0;
}
} // namespace

int32_t main()
{
    if (CheckAcl(aclInit(nullptr), "aclInit") != 0) {
        return -1;
    }
    if (CheckAcl(aclrtSetDevice(kDeviceId), "aclrtSetDevice") != 0) {
        CHECK_ERROR(aclFinalize());
        return -1;
    }

    int ret = RunStreamConfigQuerySample();

    CHECK_ERROR(aclrtResetDeviceForce(kDeviceId));
    CHECK_ERROR(aclFinalize());
    return ret;
}
