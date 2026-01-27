/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef QUEUE_SCHEDULE_BQS_UTIL_H
#define QUEUE_SCHEDULE_BQS_UTIL_H

#include <cstdint>
#include <atomic>
#include <functional>
#include <unordered_map>
#include <string>
#include <cstring>
namespace bqs {
constexpr uint32_t LOCAL_Q = 0;
constexpr uint32_t CLIENT_Q = 1;
constexpr int32_t MAX_ENV_CHAR_NUM = 1024;

enum class RunContext {
    DEVICE = 0,
    HOST,
};

RunContext GetRunContext();

/**
 * it is used to get current time
 * @return uint64_t tick
 */
uint64_t GetNowTime();

/**
 * @ingroup
 * @brief read env value
 * @param [in] envName : env to get
 * @param [out] envValue : result
 * @return : bool，Whether get the env success
 */
static inline void GetEnvVal(const std::string &env, std::string &val)
{
    const char *const tmpVal = std::getenv(env.c_str());
    if ((tmpVal == nullptr) || (strnlen(tmpVal, MAX_ENV_CHAR_NUM) >= MAX_ENV_CHAR_NUM)) {
        val = "";
    } else {
        val = tmpVal;
    }
}

static inline bool TransStrToInt(const std::string &para, int32_t &value)
{
    try {
        value = std::stoi(para);
    } catch (...) {
        return false;
    }

    return true;
}

static inline bool TransStrToull(const std::string &para, uint64_t &value)
{
    try {
        value = std::stoull(para);
    } catch (...) {
        return false;
    }

    return true;
}

// scope guard
class ScopeGuard {
public:
    explicit ScopeGuard(const std::function<void()> exitScope)
        : exitScope_(exitScope)
    {}

    ~ScopeGuard()
    {
        exitScope_();
    }

private:
    ScopeGuard(ScopeGuard const&) = delete;
    ScopeGuard& operator=(ScopeGuard const&) = delete;
    ScopeGuard(ScopeGuard&&) = delete;
    ScopeGuard& operator=(ScopeGuard&&) = delete;

    std::function<void()> exitScope_;
};

// spin lock
class SpinLock {
public:
    SpinLock() = default;

    ~SpinLock() = default;

    void Lock()
    {
        while (lock_.test_and_set()) {}
    }

    void Unlock()
    {
        lock_.clear();
    }

private:
    SpinLock(SpinLock const&) = delete;
    SpinLock& operator=(SpinLock const&) = delete;
    SpinLock(SpinLock&&) = delete;
    SpinLock& operator=(SpinLock&&) = delete;

    std::atomic_flag lock_ = ATOMIC_FLAG_INIT;
};

class GlobalCfg {
public:
    explicit GlobalCfg() = default;
    virtual ~GlobalCfg() = default;
    inline static GlobalCfg &GetInstance()
    {
        static GlobalCfg globalCfg;
        return globalCfg;
    }

    inline void SetNumaFlag(const bool numaFlag)
    {
        numaFlag_ = numaFlag;
    }

    inline bool const GetNumaFlag() const
    {
        return numaFlag_;
    }

    inline void RecordDeviceId(const uint32_t deviceId, const uint32_t resIndex, const uint32_t groupId)
    {
        deviceIdToResIndex_[deviceId] = std::make_pair(resIndex, groupId);
    }

    inline uint32_t GetResIndexByDeviceId(const uint32_t deviceId)
    {
        return deviceIdToResIndex_[deviceId].first;
    }

    inline uint32_t GetGroupIdByDeviceId(const uint32_t deviceId)
    {
        return deviceIdToResIndex_[deviceId].second;
    }

private:
    bool numaFlag_{false};
    std::unordered_map<uint32_t, std::pair<uint32_t, uint32_t>> deviceIdToResIndex_;
};

}  // namespace bqs
#endif  // QUEUE_SCHEDULE_BQS_STATUS_H