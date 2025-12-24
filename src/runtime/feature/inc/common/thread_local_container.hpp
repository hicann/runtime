/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef RUNTIME_THREAD_LOCAL_CONTAINER_HPP
#define RUNTIME_THREAD_LOCAL_CONTAINER_HPP

#include "base.hpp"
#include "osal.hpp"
#include "api.hpp"
#include "awatchdog.h"

namespace cce {
namespace runtime {
class ThreadLocalContainer {
public:
    static LaunchArgment& GetLaunchArg(void);

    static rtError_t SetTaskTag(const char_t * const inTaskTag);
    static void ResetTaskTag(void);
    static void GetTaskTag(std::string &outTaskTag);
    static bool IsTaskTagValid(void);
    static uint32_t GetEnvFlags(void);
    static void SetEnvFlags(const uint32_t inEnvFlags);
    static rtArgsSizeInfo_t& GetArgsSizeInfo(void);
    static AwdHandle GetOrCreateWatchDogHandle(void);
private:
    // always end with '\0', if first is '\0', means not set.
    static __THREAD_LOCAL__ LaunchArgment launchArg_;
    static __THREAD_LOCAL__ char_t taskTag_[TASK_TAG_MAX_LEN];
    static __THREAD_LOCAL__ uint32_t envFlags_;
    static __THREAD_LOCAL__ rtArgsSizeInfo_t argsSize_;
    static __THREAD_LOCAL__ AwdHandle watchDogHandle_;
};

enum class CaptureEventModeType : uint8_t {
    SOFTWARE_MODE = 0,
    HARDWARE_MODE,
};

class GlobalContainer {
public:
    static rtChipType_t GetRtChipType(void);
    static void SetRtChipType(const rtChipType_t inChipType);

    static rtSocType_t GetSocType(void);
    static void SetSocType(const rtSocType_t inSocType);

    static rtArchType_t GetArchType(void);
    static void SetArchType(const rtArchType_t inArchType);

    static rtChipType_t GetHardwareChipType(void);
    static void SetHardwareChipType(const rtChipType_t chipType);

    static std::string GetUserSocVersion(void);
    static void SetUserSocVersion(const std::string &inSocVersion);

    static void UceMutexLock(void);
    static void UceMutexUnlock(void);

    static bool FindMemUceInfo(const uint32_t deviceId);
    static void InsertMemUceInfo(const uint32_t deviceId, const rtMemUceInfo * const memUceInfo);
    static void DeleteMemUceInfo(const uint32_t deviceId);
    static rtMemUceInfo *GetMemUceInfo(const uint32_t deviceId);
    static uint8_t GetEventWorkMode(void);
    static bool IsEventHardMode(void);
    static void SetEventWorkMode(const uint8_t mode);
    static uint64_t GetEventModeRefCount();
    static void SetEventModeRefCount(uint8_t value);
    static std::mutex uceMutex_;
    static std::mutex eventWorkMutex;
    static std::unordered_map<uint32_t, rtMemUceInfo> memUceInfoMap_;

private:
    static uint8_t eventWorkMode_;
    static uint64_t eventModeSetRefCount;
    static rtChipType_t chipType_;
    static rtSocType_t socType_;
    static rtArchType_t archType_;
    static rtChipType_t hardwareChipType_;
    static std::string userSocVersion_;
    static std::mutex socVersionMutex_;
};
bool IsProcessTimeout(const mmTimespec &beginTime, int32_t totalTime);

}  // namespace runtime
}  // namespace cce

#endif // RUNTIME_THREAD_LOCAL_CONTAINER_HPP
