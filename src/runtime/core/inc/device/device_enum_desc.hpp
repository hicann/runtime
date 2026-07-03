/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CCE_RUNTIME_DEVICE_ENUM_DESC_HPP
#define CCE_RUNTIME_DEVICE_ENUM_DESC_HPP

#include <cstdint>
#include <string>
#include "runtime/config.h"
#include "device.hpp"
#include "soc/soc_define.hpp"
#include "rt_log.h"

namespace cce {
namespace runtime {

static inline std::string DevResTypeToString(const rtDevResType_t type)
{
    std::string desc;
    switch (type) {
        case RT_RES_TYPE_STARS_NOTIFY_RECORD: desc = "STARS_NOTIFY_RECORD(0)"; break;
        case RT_RES_TYPE_STARS_CNT_NOTIFY_RECORD: desc = "STARS_CNT_NOTIFY_RECORD(1)"; break;
        case RT_RES_TYPE_STARS_RTSQ: desc = "STARS_RTSQ(2)"; break;
        case RT_RES_TYPE_CCU_CKE: desc = "CCU_CKE(3)"; break;
        case RT_RES_TYPE_CCU_XN: desc = "CCU_XN(4)"; break;
        case RT_RES_TYPE_STARS_CNT_NOTIFY_BIT_WR: desc = "STARS_CNT_NOTIFY_BIT_WR(5)"; break;
        case RT_RES_TYPE_STARS_CNT_NOTIFY_ADD: desc = "STARS_CNT_NOTIFY_ADD(6)"; break;
        case RT_RES_TYPE_STARS_CNT_NOTIFY_BIT_CLR: desc = "STARS_CNT_NOTIFY_BIT_CLR(7)"; break;
        default: desc = RtFmtMsg("UNKNOWN(%d)", static_cast<int32_t>(type)); break;
    }
    return desc;
}

static inline std::string DevResProcTypeToString(const rtDevResProcType_t type)
{
    std::string desc;
    switch (type) {
        case RT_PROCESS_CP1: desc = "CP1(0)"; break;
        case RT_PROCESS_CP2: desc = "CP2(1)"; break;
        case RT_PROCESS_DEV_ONLY: desc = "DEV_ONLY(2)"; break;
        case RT_PROCESS_QS: desc = "QS(3)"; break;
        case RT_PROCESS_HCCP: desc = "HCCP(4)"; break;
        case RT_PROCESS_USER: desc = "USER(5)"; break;
        default: desc = RtFmtMsg("UNKNOWN(%d)", static_cast<int32_t>(type)); break;
    }
    return desc;
}

static inline std::string UbDevQueryCmdToString(const rtUbDevQueryCmd cmd)
{
    std::string desc;
    switch (cmd) {
        case QUERY_PROCESS_TOKEN: desc = "QUERY_PROCESS_TOKEN(0)"; break;
        case QUERY_TYPE_BUFF: desc = "QUERY_TYPE_BUFF(1)"; break;
        default: desc = RtFmtMsg("UNKNOWN(%d)", static_cast<int32_t>(cmd)); break;
    }
    return desc;
}

static inline std::string InfoTypeToString(const uint32_t infoType)
{
    std::string desc;
    switch (infoType) {
        case static_cast<uint32_t>(INFO_TYPE_ENV): desc = "ENV(0)"; break;
        case static_cast<uint32_t>(INFO_TYPE_VERSION): desc = "VERSION(1)"; break;
        case static_cast<uint32_t>(INFO_TYPE_MASTERID): desc = "MASTERID(2)"; break;
        case static_cast<uint32_t>(INFO_TYPE_CORE_NUM): desc = "CORE_NUM(3)"; break;
        case static_cast<uint32_t>(INFO_TYPE_FREQUE): desc = "FREQUE(4)"; break;
        case static_cast<uint32_t>(INFO_TYPE_WORK_MODE): desc = "WORK_MODE(22)"; break;
        case static_cast<uint32_t>(INFO_TYPE_UTILIZATION): desc = "UTILIZATION(23)"; break;
        case static_cast<uint32_t>(INFO_TYPE_CORE_NUM_LEVEL): desc = "CORE_NUM_LEVEL(15)"; break;
        default: desc = RtFmtMsg("UNKNOWN(%u)", static_cast<uint64_t>(infoType)); break;
    }
    return desc;
}

static inline std::string ModuleTypeToString(const int32_t moduleType)
{
    std::string desc;
    switch (moduleType) {
        case RT_MODULE_TYPE_SYSTEM: desc = "SYSTEM(0)"; break;
        case RT_MODULE_TYPE_AICPU: desc = "AICPU(1)"; break;
        case RT_MODULE_TYPE_CCPU: desc = "CCPU(2)"; break;
        case RT_MODULE_TYPE_DCPU: desc = "DCPU(3)"; break;
        case RT_MODULE_TYPE_AICORE: desc = "AICORE(4)"; break;
        case RT_MODULE_TYPE_TSCPU: desc = "TSCPU(5)"; break;
        case RT_MODULE_TYPE_PCIE: desc = "PCIE(6)"; break;
        case RT_MODULE_TYPE_VECTOR_CORE: desc = "VECTOR_CORE(7)"; break;
        case RT_MODULE_TYPE_HOST_AICPU: desc = "HOST_AICPU(8)"; break;
        case RT_MODULE_TYPE_QOS: desc = "QOS(9)"; break;
        case RT_MODULE_TYPE_MEMORY: desc = "MEMORY(10)"; break;
        default: desc = RtFmtMsg("UNKNOWN(%d)", static_cast<int64_t>(moduleType)); break;
    }
    return desc;
}

static inline std::string DeviceStateCallbackToString(const DeviceStateCallback type)
{
    std::string desc;
    switch (type) {
        case DeviceStateCallback::RT_DEVICE_STATE_CALLBACK: desc = "DEVICE_STATE_CALLBACK(0)"; break;
        case DeviceStateCallback::RTS_DEVICE_STATE_CALLBACK: desc = "RTS_DEVICE_STATE_CALLBACK(1)"; break;
        default: desc = RtFmtMsg("UNKNOWN(%d)", static_cast<int32_t>(type)); break;
    }
    return desc;
}

static inline std::string DevFeatureTypeToString(const int32_t devFeatureType)
{
    std::string desc;
    switch (devFeatureType) {
        case RT_FEATURE_TSCPU_TASK_UPDATE_SUPPORT_AIC_AIV: desc = "FEATURE_TSCPU_TASK_UPDATE_SUPPORT_AIC_AIV(1)"; break;
        case RT_FEATURE_SYSTEM_MEMQ_EVENT_CROSS_DEV: desc = "FEATURE_SYSTEM_MEMQ_EVENT_CROSS_DEV(21)"; break;
        case RT_FEATURE_AICPU_SCHEDULE_TYPE: desc = "FEATURE_AICPU_SCHEDULE_TYPE(10001)"; break;
        case RT_FEATURE_SYSTEM_TASKID_BIT_WIDTH: desc = "FEATURE_SYSTEM_TASKID_BIT_WIDTH(20001)"; break;
        default: desc = RtFmtMsg("UNKNOWN(%d)", static_cast<int64_t>(devFeatureType)); break;
    }
    return desc;
}

} // namespace runtime
} // namespace cce

#endif // CCE_RUNTIME_DEVICE_ENUM_DESC_HPP
