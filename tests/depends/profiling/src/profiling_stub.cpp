/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "aprof_pub.h"
#include "acl_stub.h"

int32_t MsprofRegisterCallback(uint32_t moduleId, ProfCommandHandle handle) { return 1; }

int32_t MsprofUnRegisterCallback(uint32_t moduleId, ProfCommandHandle handle) { return 1; }

int32_t ProfAclCfgToSampleCfg(const std::string& aclCfg, std::string& sampleCfg) { return 0; }

int32_t aclStub::MsprofFinalize() { return 0; }

int32_t aclStub::MsprofInit(uint32_t aclDataType, void* data, uint32_t dataLen) { return 0; }

int32_t aclStub::MsprofRegTypeInfo(uint16_t level, uint32_t typeId, const char* typeName) { return 0; }

int32_t MsprofFinalize() { return MockFunctionTest::aclStubInstance().MsprofFinalize(); }

int32_t MsprofInit(uint32_t aclDataType, void* data, uint32_t dataLen)
{
    return MockFunctionTest::aclStubInstance().MsprofInit(aclDataType, data, dataLen);
}

MsprofApi g_lastReportedProfApi{};
uint32_t g_profReportApiCount = 0;

int32_t MsprofReportApi(uint32_t agingFlag, const MsprofApi* api)
{
    (void)agingFlag;
    if (api == nullptr) {
        return 1;
    }
    // Copy the record: the caller's local MsprofApi expires after reporting.
    g_lastReportedProfApi = *api;
    ++g_profReportApiCount;
    return 0;
}

int32_t MsprofRegTypeInfo(uint16_t level, uint32_t typeId, const char* typeName)
{
    return MockFunctionTest::aclStubInstance().MsprofRegTypeInfo(level, typeId, typeName);
}

uint64_t MsprofSysCycleTime() { return 1000; }

int32_t MsprofReportEvent(uint32_t agingFlag, const MsprofEvent* event) { return 0; }

int32_t MsprofSetInjectionFunc(uint32_t funcType, void* func)
{
    (void)funcType;
    (void)func;
    return 1;
}

int32_t MsprofInjectionInitialize() { return 1; }

uint64_t MsprofStr2Id(const char* hashInfo, size_t length)
{
    (void)hashInfo;
    (void)length;
    // Keep this nonzero value stable across tests because the reporter caches it.
    return 12345ULL;
}
