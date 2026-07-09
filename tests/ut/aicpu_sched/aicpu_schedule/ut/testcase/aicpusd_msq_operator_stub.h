/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef TESTS_UT_AICPU_SCHED_AICPU_SCHEDULE_UT_TESTCASE_AICPUSD_MSQ_OPERATOR_STUB_H_
#define TESTS_UT_AICPU_SCHED_AICPU_SCHEDULE_UT_TESTCASE_AICPUSD_MSQ_OPERATOR_STUB_H_

#include <climits>
#include <cstdint>
#include <cstring>
#include <mutex>
#include <string>
#include <securec.h>
#include "aicpusd_message_queue.h"
#include "ae_so_manager.hpp"

namespace AicpuScheduleUtStub {
constexpr uintptr_t kMsqOperatorHandle = 0x20260601;
constexpr uintptr_t kKernelSoHandle = 0x20260708;

inline std::mutex& GetMockMutex()
{
    static std::mutex m;
    return m;
}

using KernelDlsymRouter = void* (*)(const char* funcName);
inline KernelDlsymRouter g_kernelDlsymRouter = nullptr;

inline void SetDlsymRouter(KernelDlsymRouter fn)
{
    std::lock_guard<std::mutex> lock(GetMockMutex());
    g_kernelDlsymRouter = fn;
}

inline aeStatus_t SingleSoManagerGetFuncStub(void* soHandle, const char* funcName, void** retFuncAddr)
{
    std::lock_guard<std::mutex> lock(GetMockMutex());
    if ((soHandle == nullptr) || (funcName == nullptr) || (retFuncAddr == nullptr)) {
        return AE_STATUS_GET_KERNEL_NAME_FAILED;
    }
    const auto h = reinterpret_cast<uintptr_t>(soHandle);
    if (g_kernelDlsymRouter != nullptr) {
        void* addr = g_kernelDlsymRouter(funcName);
        if (addr == nullptr) {
            return AE_STATUS_GET_KERNEL_NAME_FAILED;
        }
        *retFuncAddr = addr;
        return AE_STATUS_SUCCESS;
    }
    return AE_STATUS_GET_KERNEL_NAME_FAILED;
}

inline aeStatus_t SingleSoManagerOpenSoStub(cce::SingleSoManager*, const std::string& soFile, void** retHandle)
{
    std::lock_guard<std::mutex> lock(GetMockMutex());
    if ((soFile.empty()) || (retHandle == nullptr)) {
        return AE_STATUS_OPEN_SO_FAILED;
    }
    if (soFile.find("libSimTest.so") != std::string::npos) {
        *retHandle = reinterpret_cast<void*>(kKernelSoHandle);
        return AE_STATUS_SUCCESS;
    }
    if (soFile.find("libaicpu_msq_operator.so") != std::string::npos) {
        *retHandle = reinterpret_cast<void*>(kMsqOperatorHandle);
        return AE_STATUS_SUCCESS;
    }
    return AE_STATUS_OPEN_SO_FAILED;
}

inline void MsqOperatorResetStub() {}

inline AicpuSchedule::MsqStatus MsqOperatorReadStatusStub()
{
    AicpuSchedule::MsqStatus status = {};
    status.valid = 0U;
    status.size = 0U;
    status.comp = 0U;
    return status;
}

inline void MsqOperatorReadDataStub(uint32_t, AicpuSchedule::MsqDatas* datas)
{
    if (datas == nullptr) {
        return;
    }
    *datas = {};
}

inline void MsqOperatorSendRspStub() {}

inline void MsqOperatorWaitStub() {}

inline char* RealpathStub(const char* path, char* resolved)
{
    std::lock_guard<std::mutex> lock(GetMockMutex());
    if ((path == nullptr) || (resolved == nullptr)) {
        return nullptr;
    }
    const size_t len = std::strlen(path);
    if (len >= static_cast<size_t>(PATH_MAX)) {
        return nullptr;
    }
    if (memcpy_s(resolved, PATH_MAX, path, len + 1) != EOK) {
        return nullptr;
    }
    return resolved;
}

inline void* DlopenMsqOperatorStub(const char* filename, int)
{
    std::lock_guard<std::mutex> lock(GetMockMutex());
    if (filename == nullptr) {
        return nullptr;
    }
    if (std::strcmp(filename, "libaicpu_msq_operator.so") == 0) {
        return reinterpret_cast<void*>(kMsqOperatorHandle);
    }
    if (std::strstr(filename, "libSimTest.so") != nullptr) {
        return reinterpret_cast<void*>(kKernelSoHandle);
    }
    return nullptr;
}

inline void* DlsymMsqOperatorStub(void* handle, const char* symbol)
{
    std::lock_guard<std::mutex> lock(GetMockMutex());
    if ((handle == nullptr) || (symbol == nullptr)) {
        return nullptr;
    }
    const auto h = reinterpret_cast<uintptr_t>(handle);
    if (h == kMsqOperatorHandle) {
        if ((std::strcmp(symbol, "MsqV1ResetT0Status") == 0) || (std::strcmp(symbol, "MsqV1ResetT1Status") == 0) ||
            (std::strcmp(symbol, "MsqV2ResetT0Status") == 0) || (std::strcmp(symbol, "MsqV2ResetT1Status") == 0)) {
            return reinterpret_cast<void*>(&MsqOperatorResetStub);
        }
        if ((std::strcmp(symbol, "MsqV1ReadT0Status") == 0) || (std::strcmp(symbol, "MsqV1ReadT1Status") == 0) ||
            (std::strcmp(symbol, "MsqV2ReadT1Status") == 0)) {
            return reinterpret_cast<void*>(&MsqOperatorReadStatusStub);
        }
        if ((std::strcmp(symbol, "MsqV1ReadT0Data") == 0) || (std::strcmp(symbol, "MsqV1ReadT1Data") == 0) ||
            (std::strcmp(symbol, "MsqV2ReadT1Data") == 0)) {
            return reinterpret_cast<void*>(&MsqOperatorReadDataStub);
        }
        if ((std::strcmp(symbol, "MsqV1SendT0Response") == 0) || (std::strcmp(symbol, "MsqV1SendT1Response") == 0) ||
            (std::strcmp(symbol, "MsqV2SendT1Response") == 0)) {
            return reinterpret_cast<void*>(&MsqOperatorSendRspStub);
        }
        if (std::strcmp(symbol, "Wait") == 0) {
            return reinterpret_cast<void*>(&MsqOperatorWaitStub);
        }
        return nullptr;
    }
    if ((h == kKernelSoHandle) && (g_kernelDlsymRouter != nullptr)) {
        return g_kernelDlsymRouter(symbol);
    }
    return nullptr;
}
} // namespace AicpuScheduleUtStub

#endif
