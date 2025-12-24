/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <vector>
#include <string>
#include "acl_stub.h"

namespace {
    std::string STAGES_STR = "[TEST][TEST]";
}

uint32_t aclStub::InitializePlatformInfo()
{
    return 0;
}

uint32_t aclStub::GetPlatformInfos(
    const std::string SoCVersion, fe::PlatFormInfos &platformInfo, fe::OptionalInfos &optionalInfo)
{
    return 0;
}

uint32_t aclStub::InitRuntimePlatformInfos(const std::string &SoCVersion)
{
    return 0;
}

uint32_t aclStub::GetRuntimePlatformInfosByDevice(const uint32_t &device_id, fe::PlatFormInfos &platform_infos) {
    return 0;
}

bool aclStub::GetPlatformResWithLock(const std::string &label, std::map<std::string, std::string> &res) {
    return true;
}

bool aclStub::GetPlatformResWithLock(const string &label, const string &key, string &val)
{
    return true;
}

uint32_t aclStub::UpdateRuntimePlatformInfosByDevice(const uint32_t &device_id, fe::PlatFormInfos &platform_infos) {
    return 0;
}

std::unique_ptr<const char_t[]> aclStub::GetErrMgrErrorMessage()
{
    const char *str = "default";
    std::unique_ptr<const char[]> errMsg(new char[std::strlen(str) + 1]);
    std::strcpy(const_cast<char*>(errMsg.get()), str);
    return errMsg;
}

int aclStub::Init()
{
    return 0;
}

int error_message::ErrMgrInit(error_message::ErrorMessageMode error_mode)
{
    (void)error_mode;
    return MockFunctionTest::aclStubInstance().Init();
}

std::unique_ptr<const char_t[]> error_message::GetErrMgrErrorMessage()
{
    return MockFunctionTest::aclStubInstance().GetErrMgrErrorMessage();
}

int32_t error_message::ReportPredefinedErrMsg(const char *error_code) {
    return 0;
}

int32_t error_message::ReportPredefinedErrMsg(const char *error_code, const std::vector<const char *> &key,
                               const std::vector<const char *> &value)
{
    return 0;
}

int32_t error_message::ReportInnerErrMsg(const char *file_name, const char *func, uint32_t line, const char *error_code,
                          const char *format, ...)
{
    return 0;
}

namespace fe {
    PlatformInfoManager::PlatformInfoManager() : init_flag_(false) {}

    PlatformInfoManager::~PlatformInfoManager() {}

    PlatformInfoManager &PlatformInfoManager::GeInstance() {
        static PlatformInfoManager ge_platform_info;
        return ge_platform_info;
    }

    uint32_t PlatformInfoManager::InitRuntimePlatformInfos(const std::string &SoCVersion) {
        return MockFunctionTest::aclStubInstance().InitRuntimePlatformInfos(SoCVersion);
    }

    uint32_t PlatformInfoManager::GetRuntimePlatformInfosByDevice(const uint32_t &device_id,
                                                                  PlatFormInfos &platform_infos,
                                                                  bool need_deep_copy) {
        (void) need_deep_copy;
        return MockFunctionTest::aclStubInstance().GetRuntimePlatformInfosByDevice(device_id, platform_infos);
    }

    uint32_t PlatformInfoManager::UpdateRuntimePlatformInfosByDevice(const uint32_t &device_id,
                                                                     PlatFormInfos &platform_infos) {
        return MockFunctionTest::aclStubInstance().UpdateRuntimePlatformInfosByDevice(device_id, platform_infos);
    }

    uint32_t fe::PlatformInfoManager::InitializePlatformInfo()
    {
        return MockFunctionTest::aclStubInstance().InitializePlatformInfo();
    }

    uint32_t fe::PlatformInfoManager::GetPlatformInfos(
        const std::string SoCVersion, fe::PlatFormInfos &platformInfo, fe::OptionalInfos &optionalInfo)
    {
        return MockFunctionTest::aclStubInstance().GetPlatformInfos(SoCVersion, platformInfo, optionalInfo);
    }

    bool PlatFormInfos::GetPlatformResWithLock(const std::string &label, std::map<std::string, std::string> &res) {
        return MockFunctionTest::aclStubInstance().GetPlatformResWithLock(label, res);
    }

    bool PlatFormInfos::GetPlatformResWithLock(const string &label, const string &key, string &val)
    {
        return MockFunctionTest::aclStubInstance().GetPlatformResWithLock(label, key, val);
    }

    void PlatFormInfos::SetPlatformResWithLock(const std::string &label, std::map<std::string, std::string> &res) {
        return;
    }
}


MockFunctionTest::MockFunctionTest()
{
    ResetToDefaultMock();
}

MockFunctionTest& MockFunctionTest::aclStubInstance()
{
    static MockFunctionTest stub;
    return stub;
};

void  MockFunctionTest::ResetToDefaultMock() {
    // delegates the default actions of the RTS methods to aclStub
    ON_CALL(*this, rtDvppMallocWithFlag)
        .WillByDefault([this](void **devPtr, uint64_t size, uint32_t flag, uint16_t moduleId) {
          return aclStub::rtDvppMallocWithFlag(devPtr, size, flag, moduleId);
        });
    ON_CALL(*this, rtDvppMalloc).WillByDefault([this](void **devPtr, uint64_t size, uint16_t moduleId) {
      return aclStub::rtDvppMalloc(devPtr, size, moduleId);
    });
    ON_CALL(*this, rtDvppFree).WillByDefault([this](void *devPtr) {
      return aclStub::rtDvppFree(devPtr);
    });
    ON_CALL(*this, rtMalloc).WillByDefault([this](void **devPtr, uint64_t size, rtMemType_t type, uint16_t moduleId) {
      return aclStub::rtMalloc(devPtr, size, type, moduleId);
    });
    ON_CALL(*this, rtFree).WillByDefault([this](void *devPtr) {
      return aclStub::rtFree(devPtr);
    });
    ON_CALL(*this, rtMallocHost).WillByDefault([this](void **hostPtr, uint64_t size, uint16_t moduleId) {
      return aclStub::rtMallocHost(hostPtr, size, moduleId);
    });
    ON_CALL(*this, rtFreeHost).WillByDefault([this](void *devPtr) {
      return aclStub::rtFreeHost(devPtr);
    });
    ON_CALL(*this, rtFreeWithDevSync).WillByDefault([this](void *devPtr) {
      return aclStub::rtFreeWithDevSync(devPtr);
    });
    ON_CALL(*this, rtFreeHostWithDevSync).WillByDefault([this](void *hostPtr) {
      return aclStub::rtFreeHostWithDevSync(hostPtr);
    });
    ON_CALL(*this, rtMallocCached)
        .WillByDefault([this](void **devPtr, uint64_t size, rtMemType_t type, uint16_t moduleId) {
          return aclStub::rtMallocCached(devPtr, size, type, moduleId);
        });
    ON_CALL(*this, rtMemcpy)
        .WillByDefault([this](void *dst, uint64_t destMax, const void *src, uint64_t count, rtMemcpyKind_t kind) {
          return aclStub::rtMemcpy(dst, destMax, src, count, kind);
        });
    ON_CALL(*this, GetErrMgrErrorMessage)
        .WillByDefault([this]() {
          return aclStub::GetErrMgrErrorMessage();
        });
}


