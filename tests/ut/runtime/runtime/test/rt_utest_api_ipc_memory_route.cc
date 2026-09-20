/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "rt_utest_api.hpp"

#include "api_ipc_memory.hpp"
#include "dev_info_manage.h"
#include "runtime/rts/rts_mem.h"

using namespace cce::runtime;
using namespace testing;

namespace {
class ApiIpcMemoryRouteStub : public ApiIpcMemory {
public:
    rtError_t IpcSetMemoryName(
        const void* const ptr, const uint64_t byteCount, char_t* const name, const uint32_t len,
        const uint64_t flags) override
    {
        ++setNameCount_;
        setNamePtr_ = ptr;
        setNameByteCount_ = byteCount;
        setNameName_ = name;
        setNameLen_ = len;
        setNameFlags_ = flags;
        return setNameRet_;
    }

    rtError_t IpcOpenMemory(void** const ptr, const char_t* const name, const uint64_t flags) override
    {
        ++openCount_;
        openPtr_ = ptr;
        openName_ = name;
        openFlags_ = flags;
        if (ptr != nullptr) {
            *ptr = importedPtr_;
        }
        return openRet_;
    }

    rtError_t IpcCloseMemory(const void* const ptr) override
    {
        ++closeCount_;
        closePtr_ = ptr;
        return closeRet_;
    }

    rtError_t IpcCloseMemoryByName(const char_t* const name) override
    {
        ++closeByNameCount_;
        closeByNameName_ = name;
        return closeByNameRet_;
    }

    rtError_t IpcDestroyMemoryName(const char_t* const name) override
    {
        ++destroyNameCount_;
        destroyNameName_ = name;
        return destroyNameRet_;
    }

    rtError_t SetIpcMemPid(const char_t* const name, int32_t pid[], const int32_t num) override
    {
        ++setPidCount_;
        setPidName_ = name;
        setPidPid_ = pid;
        setPidNum_ = num;
        return setPidRet_;
    }

    rtError_t ShmemSetPodPid(const char* const name, const uint32_t sdid, int32_t pid[], const int32_t num) override
    {
        ++shmemSetPidCount_;
        shmemSetPidName_ = name;
        shmemSetPidSdid_ = sdid;
        shmemSetPidPid_ = pid;
        shmemSetPidNum_ = num;
        return shmemSetPidRet_;
    }

    uint32_t setNameCount_ = 0U;
    uint32_t openCount_ = 0U;
    uint32_t closeCount_ = 0U;
    uint32_t closeByNameCount_ = 0U;
    uint32_t destroyNameCount_ = 0U;
    uint32_t setPidCount_ = 0U;
    uint32_t shmemSetPidCount_ = 0U;

    const void* setNamePtr_ = nullptr;
    uint64_t setNameByteCount_ = 0U;
    char_t* setNameName_ = nullptr;
    uint32_t setNameLen_ = 0U;
    uint64_t setNameFlags_ = 0U;
    void** openPtr_ = nullptr;
    const char_t* openName_ = nullptr;
    uint64_t openFlags_ = 0U;
    const void* closePtr_ = nullptr;
    const char_t* closeByNameName_ = nullptr;
    const char_t* destroyNameName_ = nullptr;
    const char_t* setPidName_ = nullptr;
    int32_t* setPidPid_ = nullptr;
    int32_t setPidNum_ = 0;
    const char* shmemSetPidName_ = nullptr;
    uint32_t shmemSetPidSdid_ = 0U;
    int32_t* shmemSetPidPid_ = nullptr;
    int32_t shmemSetPidNum_ = 0;
    void* importedPtr_ = reinterpret_cast<void*>(0x1234UL);

    rtError_t setNameRet_ = RT_ERROR_NONE;
    rtError_t openRet_ = RT_ERROR_NONE;
    rtError_t closeRet_ = RT_ERROR_NONE;
    rtError_t closeByNameRet_ = RT_ERROR_NONE;
    rtError_t destroyNameRet_ = RT_ERROR_NONE;
    rtError_t setPidRet_ = RT_ERROR_NONE;
    rtError_t shmemSetPidRet_ = RT_ERROR_NONE;
};

class ApiIpcMemoryRouteTest : public Test {
protected:
    void SetUp() override
    {
        runtime_ = Runtime::Instance();
        ASSERT_NE(runtime_, nullptr);
        oldApi_ = runtime_->api_;
        oldApiIpcMemory_ = runtime_->apiIpcMemory_;
        oldEnvFlags_ = ThreadLocalContainer::GetEnvFlags();
        oldRuntimeChipType_ = runtime_->chipType_;
        oldGlobalChipType_ = GlobalContainer::GetRtChipType();
        runtime_->api_ = nullptr;
        runtime_->apiIpcMemory_ = &apiIpcMemory_;
        SetChipType(CHIP_910_B_93);
        ThreadLocalContainer::SetEnvFlags(API_ENV_FLAGS_NO_TSD);
    }

    void TearDown() override
    {
        runtime_->api_ = oldApi_;
        runtime_->apiIpcMemory_ = oldApiIpcMemory_;
        runtime_->SetChipType(oldRuntimeChipType_);
        GlobalContainer::SetRtChipType(oldGlobalChipType_);
        ThreadLocalContainer::SetEnvFlags(oldEnvFlags_);
        GlobalMockObject::verify();
    }

    void SetChipType(const rtChipType_t chipType)
    {
        runtime_->SetChipType(chipType);
        GlobalContainer::SetRtChipType(chipType);
    }

    Runtime* runtime_ = nullptr;
    Api* oldApi_ = nullptr;
    ApiIpcMemory* oldApiIpcMemory_ = nullptr;
    uint32_t oldEnvFlags_ = API_ENV_FLAGS_DEFAULT;
    rtChipType_t oldRuntimeChipType_ = CHIP_BEGIN;
    rtChipType_t oldGlobalChipType_ = CHIP_BEGIN;
    ApiIpcMemoryRouteStub apiIpcMemory_;
};
} // namespace

TEST_F(ApiIpcMemoryRouteTest, RoutesAllApisToApiIpcMemory)
{
    char_t name[] = "ipc_key";
    char_t exportKey[] = "export_key";
    int32_t pid[] = {1};
    int32_t value = 0;
    const void* ptr = &value;
    void* openedPtr = nullptr;
    void* importedByKeyPtr = nullptr;

    MOCKER_CPP(&DevInfoManage::IsSupportChipFeature).expects(once()).will(returnValue(true));

    EXPECT_EQ(rtIpcSetMemoryName(ptr, 64U, name, sizeof(name)), ACL_RT_SUCCESS);
    EXPECT_EQ(rtIpcDestroyMemoryName(name), ACL_RT_SUCCESS);
    EXPECT_EQ(rtIpcOpenMemory(&openedPtr, name), ACL_RT_SUCCESS);
    EXPECT_EQ(openedPtr, apiIpcMemory_.importedPtr_);
    EXPECT_EQ(rtIpcCloseMemory(ptr), ACL_RT_SUCCESS);
    EXPECT_EQ(rtSetIpcMemPid(name, pid, 1), ACL_RT_SUCCESS);
    EXPECT_EQ(rtSetIpcMemorySuperPodPid(name, 2U, pid, 1), ACL_RT_SUCCESS);
    EXPECT_EQ(
        rtsIpcMemGetExportKey(ptr, 128U, exportKey, sizeof(exportKey), RT_IPC_MEM_EXPORT_FLAG_DISABLE_PID_VALIDATION),
        ACL_RT_SUCCESS);
    EXPECT_EQ(rtsIpcMemImportByKey(&importedByKeyPtr, name, RT_IPC_MEM_IMPORT_FLAG_ENABLE_PEER_ACCESS), ACL_RT_SUCCESS);
    EXPECT_EQ(importedByKeyPtr, apiIpcMemory_.importedPtr_);
    EXPECT_EQ(rtsIpcMemClose(name), ACL_RT_SUCCESS);
    EXPECT_EQ(rtsIpcMemSetImportPid(name, pid, 1), ACL_RT_SUCCESS);

    EXPECT_EQ(apiIpcMemory_.setNameCount_, 2U);
    EXPECT_EQ(apiIpcMemory_.setNamePtr_, ptr);
    EXPECT_EQ(apiIpcMemory_.setNameByteCount_, 128U);
    EXPECT_EQ(apiIpcMemory_.setNameName_, exportKey);
    EXPECT_EQ(apiIpcMemory_.setNameLen_, sizeof(exportKey));
    EXPECT_EQ(apiIpcMemory_.setNameFlags_, RT_IPC_MEM_EXPORT_FLAG_DISABLE_PID_VALIDATION);
    EXPECT_EQ(apiIpcMemory_.destroyNameCount_, 1U);
    EXPECT_EQ(apiIpcMemory_.destroyNameName_, name);
    EXPECT_EQ(apiIpcMemory_.openCount_, 2U);
    EXPECT_EQ(apiIpcMemory_.openPtr_, &importedByKeyPtr);
    EXPECT_EQ(apiIpcMemory_.openName_, name);
    EXPECT_EQ(apiIpcMemory_.openFlags_, RT_IPC_MEM_IMPORT_FLAG_ENABLE_PEER_ACCESS);
    EXPECT_EQ(apiIpcMemory_.closeCount_, 1U);
    EXPECT_EQ(apiIpcMemory_.closePtr_, ptr);
    EXPECT_EQ(apiIpcMemory_.closeByNameCount_, 1U);
    EXPECT_EQ(apiIpcMemory_.closeByNameName_, name);
    EXPECT_EQ(apiIpcMemory_.setPidCount_, 2U);
    EXPECT_EQ(apiIpcMemory_.setPidName_, name);
    EXPECT_EQ(apiIpcMemory_.setPidPid_, pid);
    EXPECT_EQ(apiIpcMemory_.setPidNum_, 1);
    EXPECT_EQ(apiIpcMemory_.shmemSetPidCount_, 1U);
    EXPECT_EQ(apiIpcMemory_.shmemSetPidName_, name);
    EXPECT_EQ(apiIpcMemory_.shmemSetPidSdid_, 2U);
    EXPECT_EQ(apiIpcMemory_.shmemSetPidPid_, pid);
    EXPECT_EQ(apiIpcMemory_.shmemSetPidNum_, 1);
    EXPECT_EQ(ThreadLocalContainer::GetEnvFlags(), API_ENV_FLAGS_NO_TSD);
}

TEST_F(ApiIpcMemoryRouteTest, MapsFeatureNotSupportForRtsApis)
{
    char_t name[] = "ipc_key";
    char_t exportKey[] = "export_key";
    int32_t pid[] = {1};
    int32_t value = 0;
    const void* ptr = &value;
    void* importedByKeyPtr = nullptr;

    apiIpcMemory_.setNameRet_ = RT_ERROR_FEATURE_NOT_SUPPORT;
    EXPECT_EQ(
        rtsIpcMemGetExportKey(ptr, 128U, exportKey, sizeof(exportKey), RT_IPC_MEM_EXPORT_FLAG_DISABLE_PID_VALIDATION),
        ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(apiIpcMemory_.setNameCount_, 1U);

    apiIpcMemory_.openRet_ = RT_ERROR_FEATURE_NOT_SUPPORT;
    EXPECT_EQ(
        rtsIpcMemImportByKey(&importedByKeyPtr, name, RT_IPC_MEM_IMPORT_FLAG_ENABLE_PEER_ACCESS),
        ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(apiIpcMemory_.openCount_, 1U);

    apiIpcMemory_.shmemSetPidRet_ = RT_ERROR_FEATURE_NOT_SUPPORT;
    EXPECT_EQ(rtSetIpcMemorySuperPodPid(name, 2U, pid, 1), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(apiIpcMemory_.shmemSetPidCount_, 1U);
}

TEST_F(ApiIpcMemoryRouteTest, ImportPidInterServerValidatesParameters)
{
    char_t name[] = "ipc_key";
    int32_t pid[] = {1};
    rtServerPid serverPids[1] = {};
    serverPids[0].sdid = 2U;
    serverPids[0].pid = pid;
    serverPids[0].num = 1U;

    EXPECT_EQ(rtIpcMemImportPidInterServer(nullptr, serverPids, 1U), ACL_ERROR_RT_PARAM_INVALID);
    EXPECT_EQ(rtIpcMemImportPidInterServer(name, nullptr, 1U), ACL_ERROR_RT_PARAM_INVALID);
    EXPECT_EQ(rtIpcMemImportPidInterServer(name, serverPids, 0U), ACL_ERROR_RT_PARAM_INVALID);

    serverPids[0].pid = nullptr;
    EXPECT_EQ(rtIpcMemImportPidInterServer(name, serverPids, 1U), ACL_ERROR_RT_PARAM_INVALID);

    serverPids[0].pid = pid;
    serverPids[0].num = static_cast<size_t>(INT32_MAX) + 1U;
    EXPECT_EQ(rtIpcMemImportPidInterServer(name, serverPids, 1U), ACL_ERROR_RT_PARAM_INVALID);
    EXPECT_EQ(apiIpcMemory_.shmemSetPidCount_, 0U);
}

TEST_F(ApiIpcMemoryRouteTest, ImportPidInterServerRoutesEveryServerPid)
{
    char_t name[] = "ipc_key";
    int32_t pid0[] = {1, 2};
    int32_t pid1[] = {3};
    rtServerPid serverPids[2] = {};
    serverPids[0].sdid = 2U;
    serverPids[0].pid = pid0;
    serverPids[0].num = 2U;
    serverPids[1].sdid = 3U;
    serverPids[1].pid = pid1;
    serverPids[1].num = 1U;

    EXPECT_EQ(rtIpcMemImportPidInterServer(name, serverPids, 2U), ACL_RT_SUCCESS);

    EXPECT_EQ(apiIpcMemory_.shmemSetPidCount_, 2U);
    EXPECT_EQ(apiIpcMemory_.shmemSetPidName_, name);
    EXPECT_EQ(apiIpcMemory_.shmemSetPidSdid_, 3U);
    EXPECT_EQ(apiIpcMemory_.shmemSetPidPid_, pid1);
    EXPECT_EQ(apiIpcMemory_.shmemSetPidNum_, 1);
}

TEST_F(ApiIpcMemoryRouteTest, ReturnsFeatureNotSupportBeforeRouteWhenChipUnsupported)
{
    char_t name[] = "ipc_key";

    SetChipType(CHIP_CLOUD);
    MOCKER_CPP(&DevInfoManage::IsSupportChipFeature).expects(once()).will(returnValue(false));

    EXPECT_EQ(rtsIpcMemClose(name), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(apiIpcMemory_.closeByNameCount_, 0U);
}

TEST_F(ApiIpcMemoryRouteTest, ReturnsInternalErrorWhenApiIpcMemoryMissing)
{
    char_t name[] = "ipc_key";
    void* openedPtr = nullptr;

    runtime_->apiIpcMemory_ = nullptr;

    EXPECT_EQ(rtIpcOpenMemory(&openedPtr, name), ACL_ERROR_RT_INTERNAL_ERROR);
    EXPECT_EQ(apiIpcMemory_.openCount_, 0U);
    EXPECT_EQ(ThreadLocalContainer::GetEnvFlags(), API_ENV_FLAGS_NO_TSD);
}
