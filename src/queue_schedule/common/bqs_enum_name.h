/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef BQS_ENUM_NAME_H
#define BQS_ENUM_NAME_H

#include <string>

#include "dgw_client.h"
#include "driver/ascend_hal_external.h"
#include "enum_name_registry.h"

namespace enum_name {
template <>
struct EnumNameTable<bqs::ConfigCmd> {
    static const EnumNameMap<bqs::ConfigCmd>& Get()
    {
        static const EnumNameMap<bqs::ConfigCmd> table = {
            {bqs::ConfigCmd::DGW_CFG_CMD_BIND_ROUTE, "DGW_CFG_CMD_BIND_ROUTE"},
            {bqs::ConfigCmd::DGW_CFG_CMD_UNBIND_ROUTE, "DGW_CFG_CMD_UNBIND_ROUTE"},
            {bqs::ConfigCmd::DGW_CFG_CMD_QRY_ROUTE, "DGW_CFG_CMD_QRY_ROUTE"},
            {bqs::ConfigCmd::DGW_CFG_CMD_ADD_GROUP, "DGW_CFG_CMD_ADD_GROUP"},
            {bqs::ConfigCmd::DGW_CFG_CMD_DEL_GROUP, "DGW_CFG_CMD_DEL_GROUP"},
            {bqs::ConfigCmd::DGW_CFG_CMD_QRY_GROUP, "DGW_CFG_CMD_QRY_GROUP"},
            {bqs::ConfigCmd::DGW_CFG_CMD_RESERVED, "DGW_CFG_CMD_RESERVED"},
            {bqs::ConfigCmd::DGW_CFG_CMD_UPDATE_PROFILING, "DGW_CFG_CMD_UPDATE_PROFILING"},
            {bqs::ConfigCmd::DGW_CFG_CMD_SET_HCCL_PROTOCOL, "DGW_CFG_CMD_SET_HCCL_PROTOCOL"},
            {bqs::ConfigCmd::DGW_CFG_CMD_INIT_DYNAMIC_SCHEDULE, "DGW_CFG_CMD_INIT_DYNAMIC_SCHEDULE"},
            {bqs::ConfigCmd::DGW_CFG_CMD_STOP_SCHEDULE, "DGW_CFG_CMD_STOP_SCHEDULE"},
            {bqs::ConfigCmd::DGW_CFG_CMD_CLEAR_AND_RESTART_SCHEDULE, "DGW_CFG_CMD_CLEAR_AND_RESTART_SCHEDULE"},
        };
        return table;
    }
};

template <>
struct EnumNameTable<bqs::QueryMode> {
    static const EnumNameMap<bqs::QueryMode>& Get()
    {
        static const EnumNameMap<bqs::QueryMode> table = {
            {bqs::QueryMode::DGW_QUERY_MODE_SRC_ROUTE, "DGW_QUERY_MODE_SRC_ROUTE"},
            {bqs::QueryMode::DGW_QUERY_MODE_DST_ROUTE, "DGW_QUERY_MODE_DST_ROUTE"},
            {bqs::QueryMode::DGW_QUERY_MODE_SRC_DST_ROUTE, "DGW_QUERY_MODE_SRC_DST_ROUTE"},
            {bqs::QueryMode::DGW_QUERY_MODE_ALL_ROUTE, "DGW_QUERY_MODE_ALL_ROUTE"},
            {bqs::QueryMode::DGW_QUERY_MODE_GROUP, "DGW_QUERY_MODE_GROUP"},
            {bqs::QueryMode::DGW_QUERY_MODE_RESERVED, "DGW_QUERY_MODE_RESERVED"},
        };
        return table;
    }
};

template <>
struct EnumNameTable<bqs::GroupPolicy> {
    static const EnumNameMap<bqs::GroupPolicy>& Get()
    {
        static const EnumNameMap<bqs::GroupPolicy> table = {
            {bqs::GroupPolicy::HASH, "HASH"},
            {bqs::GroupPolicy::BROADCAST, "BROADCAST"},
            {bqs::GroupPolicy::DYNAMIC, "DYNAMIC"},
        };
        return table;
    }
};

template <>
struct EnumNameTable<QUEUE_EVENT_TYPE> {
    static const EnumNameMap<QUEUE_EVENT_TYPE>& Get()
    {
        static const EnumNameMap<QUEUE_EVENT_TYPE> table = {
            {QUEUE_ENQUE_EVENT, "QUEUE_ENQUE_EVENT"},
            {QUEUE_F2NF_EVENT, "QUEUE_F2NF_EVENT"},
            {QUEUE_EVENT_TYPE_MAX, "QUEUE_EVENT_TYPE_MAX"},
        };
        return table;
    }
};
} // namespace enum_name

namespace bqs {
template <typename Enum>
inline std::string GetEnumName(const Enum value)
{
    return enum_name::GetEnumName(value);
}
} // namespace bqs

#endif // BQS_ENUM_NAME_H
