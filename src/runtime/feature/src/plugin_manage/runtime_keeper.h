/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_KEEPER_H
#define CCE_RUNTIME_KEEPER_H
#include <thread>
#include "base.hpp"
#include "runtime.hpp"
namespace cce {
namespace runtime {
class RuntimeKeeper : public NoCopy {
public:
    static constexpr uint32_t BOOT_INIT = 0U;
    static constexpr uint32_t BOOT_ON   = 1U;
    static constexpr uint32_t BOOT_DONE = 2U;

    RuntimeKeeper();
    ~RuntimeKeeper() override;

    Runtime *BootRuntime();

private:
#ifndef CFG_DEV_PLATFORM_PC
    static ErrorManager &errManager_;
#endif
    Runtime *runtime_;
    Atomic<uint32_t> bootStage_{BOOT_INIT};
    void* soHandle_{nullptr};
};

struct RtChipTypeEntry {
    rtChipType_t type;
    const char *libSoName;
    constexpr RtChipTypeEntry() noexcept : type(rtChipType_t::CHIP_END), libSoName("") {}
    constexpr RtChipTypeEntry(rtChipType_t type, const char* name) noexcept : type(type), libSoName(name) {}
};

bool IsRuntimeKeeperExiting(void);
rtError_t GetDeviceType(int64_t *hwVersion);
} // namespace runtime
} // namespace cce

#if defined(__cplusplus)
extern "C" {
#endif

cce::runtime::Runtime* ConstructRuntimeImpl();
void DestructorRuntimeImpl(cce::runtime::Runtime *rt);

#if defined(__cplusplus)
}
#endif

#endif
