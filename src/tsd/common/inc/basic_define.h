/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef TSD_BASIC_DEFINE_H
#define TSD_BASIC_DEFINE_H

#include <cstdint>

namespace tsd {
enum class HDCServiceType : uint32_t {
    FRAMEWORK,
    TDT,
    TSD,
    HDC_SERVICE_TYPE_TOTAL_NUM
};

enum class ModeType : uint32_t{
    OFFLINE = 0,
    ONLINE,
    INVALID_MODE_TYPE
};

// max number of each device can split
constexpr uint32_t DEVICE_MAX_SPLIT_NUM = 16U;
constexpr int32_t INVALID_PID = -1;

enum class PackageWorkerType : uint32_t {
    PACKAGE_WORKER_AICPU_PROCESS = 0U,
    PACKAGE_WORKER_EXTEND_PROCESS = 1U,
    PACKAGE_WORKER_AICPU_THREAD = 2U,
    PACKAGE_WORKER_EXTEND_THREAD = 3U,
    PACKAGE_WORKER_RUNTIME = 4U,
    PACKAGE_WORKER_OM = 5U,
    PACKAGE_WORKER_DSHAPE = 6U,
    PACKAGE_WORKER_DRIVER_EXTEND = 7U,
    PACKAGE_WORKER_ASCENDCPP_PROCESS = 8U,
    PACKAGE_WORKER_COMMON_SINK = 9U,
    PACKAGE_WORKER_MAX = 32U
};

enum class TsdLoadPackageType : uint32_t {
    TSD_PKG_TYPE_AICPU_KERNEL = 0U,
    TSD_PKG_TYPE_AICPU_EXTEND_KERNEL = 1U,
    TSD_PKG_TYPE_DSHAPE = 2U,
    TSD_PKG_TYPE_RUNTIME = 3U,
    TSD_PKG_TYPE_OMFILE = 4U,
    TSD_PKG_TYPE_DRIVER_EXTEND = 5U,
    TSD_PKG_TYPE_ASCENDCPP = 6U,
    TSD_PKG_TYPE_COMMON_SINK = 7U,
    TSD_PKG_TYPE_MAX = 32U
};

struct BaseInfo {
    uint32_t deviceId;
    uint32_t hostPid;
    uint32_t vfId;
    uint32_t uniqueVfId;

    BaseInfo() : BaseInfo(0U, 0U, 0U, 0U) {}
    BaseInfo(const uint32_t devId, const uint32_t pid,
             const uint32_t vfid, const uint32_t uniqueVfid) : deviceId(devId), hostPid(pid), vfId(vfid),
                                                               uniqueVfId(uniqueVfid) {};
};
}

#endif // TSD_BASIC_DEFINE_H
