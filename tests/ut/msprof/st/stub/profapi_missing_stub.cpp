/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

// Stub implementations for profapi C-level symbols not provided by msprofiler_adaptor.cpp.
// These are no-op stubs used in test builds where libprofimpl.so is mock-dlopen'd.

#include <stdint.h>
#include <stddef.h>
#include <string>

extern "C" {

uint64_t MsprofSysCycleTime() { return 0; }

// aclrtStream is typedef void*, aclError is typedef int
int aclprofMarkEx(const char*, size_t, void*) { return 0; }

void* aclprofCreateStamp() { return nullptr; }

int32_t MsprofRegTypeInfo(uint16_t, uint32_t, const char*) { return 0; }

int32_t MsprofReportCompactInfo(uint32_t, const void*, uint32_t) { return 0; }

int32_t MsprofReportApi(uint32_t, const void*) { return 0; }

int32_t MsprofReportEvent(uint32_t, const void*) { return 0; }

int32_t MsprofReportAdditionalInfo(uint32_t, const void*, uint32_t) { return 0; }

} // extern "C"

// C++ linkage stub for ProfImplReportGetHashId (loaded via dlopen in prod, stubbed in tests)
uint64_t ProfImplReportGetHashId(const std::string &) { return 0; }
