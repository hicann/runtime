/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef AICPU_ENUM_NAME_H
#define AICPU_ENUM_NAME_H

#include <string>

#include "aicpu_sched/aicpu_schedule/aicpu_context.h"
#include "aicpu_sched/aicpu_schedule/aicpusd_info.h"
#include "enum_name_registry.h"

namespace enum_name {
template <>
struct EnumNameTable<aicpu::AicpuRunMode> {
    static const EnumNameMap<aicpu::AicpuRunMode>& Get()
    {
        static const EnumNameMap<aicpu::AicpuRunMode> table = {
            {aicpu::PROCESS_PCIE_MODE, "PROCESS_PCIE_MODE"},
            {aicpu::PROCESS_SOCKET_MODE, "PROCESS_SOCKET_MODE"},
            {aicpu::THREAD_MODE, "THREAD_MODE"},
            {aicpu::INVALID_MODE, "INVALID_MODE"},
        };
        return table;
    }
};

template <>
struct EnumNameTable<aicpu::AicpuDvppChlType> {
    static const EnumNameMap<aicpu::AicpuDvppChlType>& Get()
    {
        static const EnumNameMap<aicpu::AicpuDvppChlType> table = {
            {aicpu::AICPU_DVPP_CHL_VPC, "AICPU_DVPP_CHL_VPC"},
            {aicpu::AICPU_DVPP_CHL_VDEC, "AICPU_DVPP_CHL_VDEC"},
            {aicpu::AICPU_DVPP_CHL_BUTT, "AICPU_DVPP_CHL_BUTT"},
        };
        return table;
    }
};

template <>
struct EnumNameTable<aicpu::CtxType> {
    static const EnumNameMap<aicpu::CtxType>& Get()
    {
        static const EnumNameMap<aicpu::CtxType> table = {
            {aicpu::CTX_DEFAULT, "CTX_DEFAULT"},
            {aicpu::CTX_PROF, "CTX_PROF"},
            {aicpu::CTX_DEBUG, "CTX_DEBUG"},
        };
        return table;
    }
};

template <>
struct EnumNameTable<AicpuSchedMode> {
    static const EnumNameMap<AicpuSchedMode>& Get()
    {
        static const EnumNameMap<AicpuSchedMode> table = {
            {SCHED_MODE_INTERRUPT, "SCHED_MODE_INTERRUPT"},
            {SCHED_MODE_MSGQ, "SCHED_MODE_MSGQ"},
            {SCHED_MODE_INVALID, "SCHED_MODE_INVALID"},
        };
        return table;
    }
};
} // namespace enum_name

namespace aicpu {
template <typename Enum>
inline std::string GetEnumName(const Enum value)
{
    return enum_name::GetEnumName(value);
}
} // namespace aicpu

inline std::string GetEnumName(const AicpuSchedMode mode) { return enum_name::GetEnumName(mode); }

#endif // AICPU_ENUM_NAME_H
