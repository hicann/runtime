/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_CC_UTILS_H
#define CCE_RUNTIME_CC_UTILS_H

#include <chrono>
#include <cstddef>
#include <cstdint>
#include <cstdlib>
#include <fstream>
#include <string>

namespace cce {
namespace runtime {

constexpr uint64_t CC_SPIN_WAIT_YIELD_US = 10U;
constexpr uint64_t CC_SPIN_WAIT_MAX_SLEEP_US = 100U;

void CCSpinWait(const std::chrono::steady_clock::time_point start);

// 任意对齐，允许 output 与任一输入相同；空指针或零长度时直接返回。
void XorBytesOptimized(const uint8_t* inputA, const uint8_t* inputB, uint8_t* output, size_t length);

constexpr const char* CC_SYSFS_CVM_ROOT_DEFAULT = "/sys/kernel/security/cvm_guest";
constexpr const char* CC_SYSFS_CVM_ROOT_ENV = "RT_CC_SYSFS_CVM_ROOT";
constexpr const char* CC_SYSFS_MEM_ENCRYPT_ENABLE = "mem_encrypt_enable";
constexpr const char* CC_SYSFS_MEM_ENCRYPT_ALG = "mem_encrypt_alg";
constexpr const char* CC_SYSFS_MEM_ENCRYPT_MODE_CTR = "AES_CTR";
constexpr const char* CC_SYSFS_MEM_ENCRYPT_MODE_GCM = "AES_GCM";

inline bool ReadCcSysfsNode(const char* const name, std::string& value)
{
    const char* const root = std::getenv(CC_SYSFS_CVM_ROOT_ENV);
    const std::string dir = ((root != nullptr) && (root[0] != '\0')) ? root : CC_SYSFS_CVM_ROOT_DEFAULT;
    std::ifstream node(dir + "/" + name);
    return static_cast<bool>(node >> value);
}

inline bool ReadCcSysfsU32(const char* const name, uint32_t& value)
{
    std::string text;
    if (!ReadCcSysfsNode(name, text)) {
        return false;
    }
    char* end = nullptr;
    const unsigned long parsed = std::strtoul(text.c_str(), &end, 10);
    if ((end == nullptr) || (*end != '\0')) {
        return false;
    }
    value = static_cast<uint32_t>(parsed);
    return true;
}

inline bool ReadCcEncryptMode(std::string& mode)
{
    return ReadCcSysfsNode(CC_SYSFS_MEM_ENCRYPT_ALG, mode) &&
           ((mode == CC_SYSFS_MEM_ENCRYPT_MODE_CTR) || (mode == CC_SYSFS_MEM_ENCRYPT_MODE_GCM));
}

} // namespace runtime
} // namespace cce

#endif // CCE_RUNTIME_CC_UTILS_H
