/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "thread_local_container.hpp"

namespace cce {
namespace runtime {
__THREAD_LOCAL__ LaunchArgment ThreadLocalContainer::launchArg_ = {};
__THREAD_LOCAL__ char_t ThreadLocalContainer::taskTag_[TASK_TAG_MAX_LEN] = {};
__THREAD_LOCAL__ uint32_t ThreadLocalContainer::envFlags_ = 0U;
__THREAD_LOCAL__ rtArgsSizeInfo_t ThreadLocalContainer::argsSize_ = {nullptr, 0};
__THREAD_LOCAL__ AwdHandle ThreadLocalContainer::watchDogHandle_ = AWD_INVALID_HANDLE;
LaunchArgment& ThreadLocalContainer::GetLaunchArg(void)
{
    return launchArg_;
}

void ThreadLocalContainer::GetTaskTag(std::string &outTaskTag)
{
    outTaskTag = taskTag_;
}

rtError_t ThreadLocalContainer::SetTaskTag(const char_t * const inTaskTag)
{
    if (inTaskTag == nullptr) {
        RT_LOG(RT_LOG_ERROR, "inTaskTag is null");
        return RT_ERROR_INVALID_VALUE;
    }
    size_t tagLen = strnlen(inTaskTag, TASK_TAG_MAX_LEN);
    if (tagLen == 0UL) {
        RT_LOG(RT_LOG_ERROR, "inTaskTag is empty");
        return RT_ERROR_INVALID_VALUE;
    }

    if (tagLen == TASK_TAG_MAX_LEN) {
        RT_LOG(RT_LOG_WARNING, "inTaskTag must be less than %u, trunk it", TASK_TAG_MAX_LEN);
        --tagLen;
    }

    // if over len, trunk it.
    const errno_t ret = strncpy_s(taskTag_, sizeof(taskTag_), inTaskTag, tagLen);
    if (ret != EOK) {
        RT_LOG(RT_LOG_ERROR, "strncpy_s failed, tagLen=%zu, destMax=%zu, ret=%d.", tagLen, sizeof(taskTag_), ret);
        return RT_ERROR_SEC_HANDLE;
    }
    RT_LOG(RT_LOG_DEBUG, "Set task tag end, tag=%s.", taskTag_);
    return RT_ERROR_NONE;
}

void ThreadLocalContainer::ResetTaskTag(void)
{
    if (taskTag_[0] != '\0') {
        RT_LOG(RT_LOG_DEBUG, "reset task tag, tag=%s.", taskTag_);
        taskTag_[0] = '\0';
    }
}

bool ThreadLocalContainer::IsTaskTagValid(void)
{
    // if taskTag_ is not empty, means task tag is valid
    return taskTag_[0] != '\0';
}

uint32_t ThreadLocalContainer::GetEnvFlags(void)
{
    return envFlags_;
}
void ThreadLocalContainer::SetEnvFlags(const uint32_t inEnvFlags)
{
    envFlags_ = inEnvFlags;
}

rtArgsSizeInfo_t& ThreadLocalContainer::GetArgsSizeInfo(void)
{
    return argsSize_;
}

AwdHandle ThreadLocalContainer::GetOrCreateWatchDogHandle(void)
{
    if (watchDogHandle_ == AWD_INVALID_HANDLE) {
        constexpr uint32_t runtimeWatchDogTimeout = 300;  // 300s
        watchDogHandle_ = AwdCreateThreadWatchdog(DEFINE_THREAD_WATCHDOG_ID(RUNTIME), runtimeWatchDogTimeout, nullptr);
    }
    return watchDogHandle_;
}

uint8_t GlobalContainer::eventWorkMode_ = 0;
uint64_t GlobalContainer::eventModeSetRefCount = 0;
rtChipType_t GlobalContainer::chipType_ = CHIP_BEGIN;
rtSocType_t  GlobalContainer::socType_ = SOC_BEGIN;
rtArchType_t GlobalContainer::archType_ = ARCH_BEGIN;
rtChipType_t GlobalContainer::hardwareChipType_ = CHIP_END;
std::string GlobalContainer::userSocVersion_;
std::mutex GlobalContainer::socVersionMutex_;
std::mutex GlobalContainer::uceMutex_;
std::mutex GlobalContainer::eventWorkMutex;
std::unordered_map<uint32_t, rtMemUceInfo> GlobalContainer::memUceInfoMap_;

rtChipType_t GlobalContainer::GetRtChipType(void)
{
    return chipType_;
}
void GlobalContainer::SetRtChipType(const rtChipType_t inChipType)
{
    chipType_ = inChipType;
}

rtSocType_t GlobalContainer::GetSocType(void)
{
    return socType_;
}
void GlobalContainer::SetSocType(const rtSocType_t inSocType)
{
    socType_ = inSocType;
}

rtArchType_t GlobalContainer::GetArchType(void)
{
    return archType_;
}
void GlobalContainer::SetArchType(const rtArchType_t inArchType)
{
    archType_ = inArchType;
}

rtChipType_t GlobalContainer::GetHardwareChipType(void)
{
    return hardwareChipType_;
}

void GlobalContainer::SetHardwareChipType(const rtChipType_t chipType)
{
    hardwareChipType_ = chipType;
}

std::string GlobalContainer::GetUserSocVersion(void)
{
    const std::lock_guard<std::mutex> lock(socVersionMutex_);
    return userSocVersion_;
}

void GlobalContainer::SetUserSocVersion(const std::string &inSocVersion)
{
    const std::lock_guard<std::mutex> lock(socVersionMutex_);
    userSocVersion_ = inSocVersion;
}

void GlobalContainer::UceMutexLock(void)
{
    uceMutex_.lock();
}
void GlobalContainer::UceMutexUnlock(void)
{
    uceMutex_.unlock();
}
bool GlobalContainer::FindMemUceInfo(const uint32_t deviceId)
{
    return memUceInfoMap_.find(deviceId) != memUceInfoMap_.end();
}
void GlobalContainer::InsertMemUceInfo(const uint32_t deviceId, const rtMemUceInfo * const memUceInfo)
{
    memUceInfoMap_[deviceId] = *memUceInfo;
}
void GlobalContainer::DeleteMemUceInfo(const uint32_t deviceId)
{
    memUceInfoMap_.erase(deviceId);
}
rtMemUceInfo *GlobalContainer::GetMemUceInfo(const uint32_t deviceId)
{
    return &memUceInfoMap_[deviceId];
}
uint8_t GlobalContainer::GetEventWorkMode(void)
{
    return eventWorkMode_;
}
bool GlobalContainer::IsEventHardMode(void)
{
    return (eventWorkMode_ == static_cast<uint8_t>(CaptureEventModeType::HARDWARE_MODE));
}
void GlobalContainer::SetEventWorkMode(const uint8_t mode)
{
    eventWorkMode_ = mode;
}
uint64_t GlobalContainer::GetEventModeRefCount()
{
    return eventModeSetRefCount;
}
void GlobalContainer::SetEventModeRefCount(uint8_t value)
{
    eventModeSetRefCount = value;
}

bool IsProcessTimeout(const mmTimespec &beginTime, int32_t timeout, int32_t *remainTime)
{
    if (timeout < 0) {// never timeout
        if (remainTime != nullptr) {
            *remainTime = timeout;
        }
        return false;
    }
    uint64_t count = 0ULL;
    count = GetTimeInterval(beginTime);
    if (count >= static_cast<uint64_t>(timeout)) {
        return true;
    }

    if (remainTime != nullptr) {
        *remainTime = timeout - static_cast<int32_t>(count);
    }
    return false;
}

}
}
