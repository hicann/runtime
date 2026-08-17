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

#include <dlfcn.h>

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

using CreateStreamConfigHandleFunc = aclrtStreamConfigHandle* (*)();
using DestroyStreamConfigHandleFunc = aclError (*)(aclrtStreamConfigHandle*);
using SetStreamConfigOptFunc = aclError (*)(aclrtStreamConfigHandle*, aclrtStreamConfigAttr, const void*, size_t);
using CreateStreamV2Func = aclError (*)(aclrtStream*, const aclrtStreamConfigHandle*);

struct StreamConfigApi {
    CreateStreamConfigHandleFunc createConfigHandle;
    DestroyStreamConfigHandleFunc destroyConfigHandle;
    SetStreamConfigOptFunc setConfigOpt;
    CreateStreamV2Func createStreamV2;
};

class StreamConfigHandleGuard {
public:
    StreamConfigHandleGuard(const StreamConfigApi& api, aclrtStreamConfigHandle* handle) : api_(api), handle_(handle) {}

    ~StreamConfigHandleGuard()
    {
        if (handle_ != nullptr) {
            CHECK_ERROR_WITHOUT_RETURN(api_.destroyConfigHandle(handle_));
        }
    }

    StreamConfigHandleGuard(const StreamConfigHandleGuard&) = delete;
    StreamConfigHandleGuard& operator=(const StreamConfigHandleGuard&) = delete;

    aclError Destroy()
    {
        if (handle_ == nullptr) {
            return ACL_SUCCESS;
        }

        aclError ret = api_.destroyConfigHandle(handle_);
        if (ret == ACL_SUCCESS) {
            handle_ = nullptr;
        }
        return ret;
    }

private:
    const StreamConfigApi& api_;
    aclrtStreamConfigHandle* handle_;
};

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

template <typename Func>
bool LoadSymbol(void* handle, const char* name, Func* func)
{
    *func = reinterpret_cast<Func>(dlsym(handle, name));
    if (*func == nullptr) {
        WARN_LOG("Symbol %s is not exported by the current Runtime library.", name);
        return false;
    }
    return true;
}

bool LoadStreamConfigApi(StreamConfigApi* api)
{
    bool ok = true;
    ok = LoadSymbol(RTLD_DEFAULT, "aclrtCreateStreamConfigHandle", &api->createConfigHandle) && ok;
    ok = LoadSymbol(RTLD_DEFAULT, "aclrtDestroyStreamConfigHandle", &api->destroyConfigHandle) && ok;
    ok = LoadSymbol(RTLD_DEFAULT, "aclrtSetStreamConfigOpt", &api->setConfigOpt) && ok;
    ok = LoadSymbol(RTLD_DEFAULT, "aclrtCreateStreamV2", &api->createStreamV2) && ok;
    return ok;
}

int SetStreamConfigOptions(const StreamConfigApi& api, aclrtStreamConfigHandle* configHandle)
{
    if (CheckAcl(
            api.setConfigOpt(configHandle, ACL_RT_STREAM_FLAG, &kStreamFlags, sizeof(kStreamFlags)),
            "aclrtSetStreamConfigOpt(ACL_RT_STREAM_FLAG)") != 0) {
        return -1;
    }
    if (CheckAcl(
            api.setConfigOpt(configHandle, ACL_RT_STREAM_PRIORITY, &kStreamPriority, sizeof(kStreamPriority)),
            "aclrtSetStreamConfigOpt(ACL_RT_STREAM_PRIORITY)") != 0) {
        return -1;
    }
    INFO_LOG("Set stream config flags=%u priority=%u", kStreamFlags, kStreamPriority);
    return 0;
}

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
    return 0;
}

int RunStreamConfigQuerySample()
{
    StreamConfigApi api = {};
    if (!LoadStreamConfigApi(&api)) {
        INFO_LOG("[SKIP] Stream config query sample skipped because the current Runtime library does not export all "
                 "stream config APIs.");
        return 0;
    }

    aclrtStreamConfigHandle* configHandle = api.createConfigHandle();
    if (configHandle == nullptr) {
        INFO_LOG("[SKIP] Stream config query sample skipped because aclrtCreateStreamConfigHandle returned nullptr.");
        return 0;
    }
    StreamConfigHandleGuard configHandleGuard(api, configHandle);
    INFO_LOG("Create stream config handle successfully");

    if (SetStreamConfigOptions(api, configHandle) != 0) {
        return -1;
    }

    aclrtStream stream = nullptr;
    if (CheckAcl(api.createStreamV2(&stream, configHandle), "aclrtCreateStreamV2") != 0) {
        return -1;
    }
    StreamGuard streamGuard(stream);
    INFO_LOG("Create stream with config successfully");

    if (QueryStreamInfo(stream) != 0) {
        return -1;
    }

    if (CheckAcl(aclrtSynchronizeStream(stream), "aclrtSynchronizeStream") != 0) {
        return -1;
    }
    if (CheckAcl(streamGuard.Destroy(), "aclrtDestroyStream") != 0) {
        return -1;
    }
    if (CheckAcl(configHandleGuard.Destroy(), "aclrtDestroyStreamConfigHandle") != 0) {
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
