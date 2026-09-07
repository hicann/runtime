/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef TSD_ENUM_NAME_H
#define TSD_ENUM_NAME_H

#include <string>

#include "basic_define.h"
#include "enum_name_registry.h"
#include "tsd/tsd_client.h"

namespace enum_name {
template <>
struct EnumNameTable<tsd::PackageWorkerType> {
    static const EnumNameMap<tsd::PackageWorkerType>& Get()
    {
        static const EnumNameMap<tsd::PackageWorkerType> table = {
            {tsd::PackageWorkerType::PACKAGE_WORKER_AICPU_PROCESS, "PACKAGE_WORKER_AICPU_PROCESS"},
            {tsd::PackageWorkerType::PACKAGE_WORKER_EXTEND_PROCESS, "PACKAGE_WORKER_EXTEND_PROCESS"},
            {tsd::PackageWorkerType::PACKAGE_WORKER_AICPU_THREAD, "PACKAGE_WORKER_AICPU_THREAD"},
            {tsd::PackageWorkerType::PACKAGE_WORKER_EXTEND_THREAD, "PACKAGE_WORKER_EXTEND_THREAD"},
            {tsd::PackageWorkerType::PACKAGE_WORKER_RUNTIME, "PACKAGE_WORKER_RUNTIME"},
            {tsd::PackageWorkerType::PACKAGE_WORKER_OM, "PACKAGE_WORKER_OM"},
            {tsd::PackageWorkerType::PACKAGE_WORKER_DSHAPE, "PACKAGE_WORKER_DSHAPE"},
            {tsd::PackageWorkerType::PACKAGE_WORKER_DRIVER_EXTEND, "PACKAGE_WORKER_DRIVER_EXTEND"},
            {tsd::PackageWorkerType::PACKAGE_WORKER_ASCENDCPP_PROCESS, "PACKAGE_WORKER_ASCENDCPP_PROCESS"},
            {tsd::PackageWorkerType::PACKAGE_WORKER_COMMON_SINK, "PACKAGE_WORKER_COMMON_SINK"},
            {tsd::PackageWorkerType::PACKAGE_WORKER_MAX, "PACKAGE_WORKER_MAX"},
        };
        return table;
    }
};

template <>
struct EnumNameTable<SubProcType> {
    static const EnumNameMap<SubProcType>& Get()
    {
        static const EnumNameMap<SubProcType> table = {
            {TSD_SUB_PROC_HCCP, "TSD_SUB_PROC_HCCP"},
            {TSD_SUB_PROC_COMPUTE, "TSD_SUB_PROC_COMPUTE"},
            {TSD_SUB_PROC_CUSTOM_COMPUTE, "TSD_SUB_PROC_CUSTOM_COMPUTE"},
            {TSD_SUB_PROC_QUEUE_SCHEDULE, "TSD_SUB_PROC_QUEUE_SCHEDULE"},
            {TSD_SUB_PROC_UDF, "TSD_SUB_PROC_UDF"},
            {TSD_SUB_PROC_NPU, "TSD_SUB_PROC_NPU"},
            {TSD_SUB_PROC_PROXY, "TSD_SUB_PROC_PROXY"},
            {TSD_SUB_PROC_BUILTIN_UDF, "TSD_SUB_PROC_BUILTIN_UDF"},
            {TSD_SUB_PROC_ADPROF, "TSD_SUB_PROC_ADPROF"},
            {TSD_SUB_PROC_MAX, "TSD_SUB_PROC_MAX"},
        };
        return table;
    }
};

template <>
struct EnumNameTable<TsdCapabilityType> {
    static const EnumNameMap<TsdCapabilityType>& Get()
    {
        static const EnumNameMap<TsdCapabilityType> table = {
            {TSD_CAPABILITY_PIDQOS, "TSD_CAPABILITY_PIDQOS"},
            {TSD_CAPABILITY_LEVEL, "TSD_CAPABILITY_LEVEL"},
            {TSD_CAPABILITY_OM_INNER_DEC, "TSD_CAPABILITY_OM_INNER_DEC"},
            {TSD_CAPABILITY_BUILTIN_UDF, "TSD_CAPABILITY_BUILTIN_UDF"},
            {TSD_CAPABILITY_DRIVER_VERSION, "TSD_CAPABILITY_DRIVER_VERSION"},
            {TSD_CAPABILITY_ADPROF, "TSD_CAPABILITY_ADPROF"},
            {TSD_CAPABILITY_MUTIPLE_HCCP, "TSD_CAPABILITY_MUTIPLE_HCCP"},
            {TSD_CAPABILITY_BUT, "TSD_CAPABILITY_BUT"},
        };
        return table;
    }
};
} // namespace enum_name

namespace tsd {
template <typename Enum>
inline std::string GetEnumName(const Enum value)
{
    return enum_name::GetEnumName(value);
}
} // namespace tsd

#endif // TSD_ENUM_NAME_H
