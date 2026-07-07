/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef ACL_UTILS_DATA_TYPE_UTILS_H
#define ACL_UTILS_DATA_TYPE_UTILS_H

#include <unordered_map>
#include <memory>
#include <string>
#include "securec.h"
#include "acl/acl_base.h"
#include "acl/acl_rt.h"
#include "acl/acl_tdt_queue.h"
#include "runtime/base.h"
#include "acl/acl_tdt.h"
#include "tdt/data_common.h"
#include "acl_tdt_channel/tensor_data_transfer.h"

namespace acl {

inline const char* GetDataTypeDesc(aclDataType type) {
    static const std::unordered_map<aclDataType, const char*> dataTypeDescMap = {
        {ACL_DT_UNDEFINED,  "DT_UNDEFINED(-1)"},
        {ACL_FLOAT,         "FLOAT(0)"},
        {ACL_FLOAT16,       "FLOAT16(1)"},
        {ACL_INT8,          "INT8(2)"},
        {ACL_INT32,         "INT32(3)"},
        {ACL_UINT8,         "UINT8(4)"},
        {ACL_INT16,         "INT16(6)"},
        {ACL_UINT16,        "UINT16(7)"},
        {ACL_UINT32,        "UINT32(8)"},
        {ACL_INT64,         "INT64(9)"},
        {ACL_UINT64,        "UINT64(10)"},
        {ACL_DOUBLE,        "DOUBLE(11)"},
        {ACL_BOOL,          "BOOL(12)"},
        {ACL_STRING,        "STRING(13)"},
        {ACL_COMPLEX64,     "COMPLEX64(16)"},
        {ACL_COMPLEX128,    "COMPLEX128(17)"},
        {ACL_BF16,          "BF16(27)"},
        {ACL_INT4,          "INT4(29)"},
        {ACL_UINT1,         "UINT1(30)"},
        {ACL_COMPLEX32,     "COMPLEX32(33)"},
        {ACL_HIFLOAT8,      "HIFLOAT8(34)"},
        {ACL_FLOAT8_E5M2,   "FLOAT8_E5M2(35)"},
        {ACL_FLOAT8_E4M3FN, "FLOAT8_E4M3FN(36)"},
        {ACL_FLOAT8_E8M0,   "FLOAT8_E8M0(37)"},
        {ACL_FLOAT6_E3M2,   "FLOAT6_E3M2(38)"},
        {ACL_FLOAT6_E2M3,   "FLOAT6_E2M3(39)"},
        {ACL_FLOAT4_E2M1,   "FLOAT4_E2M1(40)"},
        {ACL_FLOAT4_E1M2,   "FLOAT4_E1M2(41)"},
    };

    auto it = dataTypeDescMap.find(type);
    if (it != dataTypeDescMap.end()) { return it->second; }
    static thread_local char enumBuf[32];
    (void)snprintf_s(enumBuf, sizeof(enumBuf), sizeof(enumBuf) - 1, "UNKNOWN(%d)", static_cast<int32_t>(type));
    return enumBuf;
}

inline const char* GetMemcpyKindDesc(aclrtMemcpyKind kind) {
    static const std::unordered_map<aclrtMemcpyKind, const char*> memcpyKindDescMap = {
        {ACL_MEMCPY_HOST_TO_HOST,         "MEMCPY_HOST_TO_HOST(0)"},
        {ACL_MEMCPY_HOST_TO_DEVICE,       "MEMCPY_HOST_TO_DEVICE(1)"},
        {ACL_MEMCPY_DEVICE_TO_HOST,       "MEMCPY_DEVICE_TO_HOST(2)"},
        {ACL_MEMCPY_DEVICE_TO_DEVICE,     "MEMCPY_DEVICE_TO_DEVICE(3)"},
        {ACL_MEMCPY_DEFAULT,              "MEMCPY_DEFAULT(4)"},
        {ACL_MEMCPY_HOST_TO_BUF_TO_DEVICE, "MEMCPY_HOST_TO_BUF_TO_DEVICE(5)"},
        {ACL_MEMCPY_INNER_DEVICE_TO_DEVICE, "MEMCPY_INNER_DEVICE_TO_DEVICE(6)"},
        {ACL_MEMCPY_INTER_DEVICE_TO_DEVICE, "MEMCPY_INTER_DEVICE_TO_DEVICE(7)"},
    };

    auto it = memcpyKindDescMap.find(kind);
    if (it != memcpyKindDescMap.end()) { return it->second; }
    static thread_local char enumBuf[32];
    (void)snprintf_s(enumBuf, sizeof(enumBuf), sizeof(enumBuf) - 1, "UNKNOWN(%d)", static_cast<int32_t>(kind));
    return enumBuf;
}

inline const char* GetExceptionExpandTypeDesc(rtExceptionExpandType_t type) {
    static const std::unordered_map<rtExceptionExpandType_t, const char*> exceptionExpandTypeDescMap = {
        {RT_EXCEPTION_INVALID,   "EXCEPTION_INVALID(0)"},
        {RT_EXCEPTION_FFTS_PLUS, "EXCEPTION_FFTS_PLUS(1)"},
        {RT_EXCEPTION_AICORE,    "EXCEPTION_AICORE(2)"},
        {RT_EXCEPTION_UB,        "EXCEPTION_UB(3)"},
        {RT_EXCEPTION_CCU,       "EXCEPTION_CCU(4)"},
        {RT_EXCEPTION_FUSION,    "EXCEPTION_FUSION(5)"},
    };

    auto it = exceptionExpandTypeDescMap.find(type);
    if (it != exceptionExpandTypeDescMap.end()) { return it->second; }
    static thread_local char enumBuf[32];
    (void)snprintf_s(enumBuf, sizeof(enumBuf), sizeof(enumBuf) - 1, "UNKNOWN(%d)", static_cast<int32_t>(type));
    return enumBuf;
}

inline const char* GetGroupAttrDesc(aclrtGroupAttr attr) {
    static const std::unordered_map<aclrtGroupAttr, const char*> groupAttrDescMap = {
        {ACL_GROUP_AICORE_INT,  "GROUP_AICORE_INT(0)"},
        {ACL_GROUP_AIV_INT,     "GROUP_AIV_INT(1)"},
        {ACL_GROUP_AIC_INT,     "GROUP_AIC_INT(2)"},
        {ACL_GROUP_SDMANUM_INT, "GROUP_SDMANUM_INT(3)"},
        {ACL_GROUP_ASQNUM_INT,  "GROUP_ASQNUM_INT(4)"},
        {ACL_GROUP_GROUPID_INT, "GROUP_GROUPID_INT(5)"},
    };

    auto it = groupAttrDescMap.find(attr);
    if (it != groupAttrDescMap.end()) { return it->second; }
    static thread_local char enumBuf[32];
    (void)snprintf_s(enumBuf, sizeof(enumBuf), sizeof(enumBuf) - 1, "UNKNOWN(%d)", static_cast<int32_t>(attr));
    return enumBuf;
}

inline const char* GetTsIdDesc(aclrtTsId tsId) {
    static const std::unordered_map<aclrtTsId, const char*> tsIdDescMap = {
        {ACL_TS_ID_AICORE,   "TS_ID_AICORE(0)"},
        {ACL_TS_ID_AIVECTOR, "TS_ID_AIVECTOR(1)"},
        {ACL_TS_ID_RESERVED, "TS_ID_RESERVED(2)"},
    };

    auto it = tsIdDescMap.find(tsId);
    if (it != tsIdDescMap.end()) { return it->second; }
    static thread_local char enumBuf[32];
    (void)snprintf_s(enumBuf, sizeof(enumBuf), sizeof(enumBuf) - 1, "UNKNOWN(%d)", static_cast<int32_t>(tsId));
    return enumBuf;
}

inline const char* GetQueueRouteQueryModeDesc(acltdtQueueRouteQueryMode mode) {
    static const std::unordered_map<acltdtQueueRouteQueryMode, const char*> queueRouteQueryModeDescMap = {
        {ACL_TDT_QUEUE_ROUTE_QUERY_SRC,       "TDT_QUEUE_ROUTE_QUERY_SRC(0)"},
        {ACL_TDT_QUEUE_ROUTE_QUERY_DST,       "TDT_QUEUE_ROUTE_QUERY_DST(1)"},
        {ACL_TDT_QUEUE_ROUTE_QUERY_SRC_AND_DST, "TDT_QUEUE_ROUTE_QUERY_SRC_AND_DST(2)"},
        {ACL_TDT_QUEUE_ROUTE_QUERY_ABNORMAL,  "TDT_QUEUE_ROUTE_QUERY_ABNORMAL(100)"},
    };

    auto it = queueRouteQueryModeDescMap.find(mode);
    if (it != queueRouteQueryModeDescMap.end()) { return it->second; }
    static thread_local char enumBuf[32];
    (void)snprintf_s(enumBuf, sizeof(enumBuf), sizeof(enumBuf) - 1, "UNKNOWN(%d)", static_cast<int32_t>(mode));
    return enumBuf;
}

inline const char* GetQueueAttrTypeDesc(acltdtQueueAttrType type) {
    static const std::unordered_map<acltdtQueueAttrType, const char*> queueAttrTypeDescMap = {
        {ACL_TDT_QUEUE_NAME_PTR,    "TDT_QUEUE_NAME_PTR(0)"},
        {ACL_TDT_QUEUE_DEPTH_UINT32, "TDT_QUEUE_DEPTH_UINT32(1)"},
    };

    auto it = queueAttrTypeDescMap.find(type);
    if (it != queueAttrTypeDescMap.end()) { return it->second; }
    static thread_local char enumBuf[32];
    (void)snprintf_s(enumBuf, sizeof(enumBuf), sizeof(enumBuf) - 1, "UNKNOWN(%d)", static_cast<int32_t>(type));
    return enumBuf;
}

inline const char* GetQueueRouteParamTypeDesc(acltdtQueueRouteParamType type) {
    static const std::unordered_map<acltdtQueueRouteParamType, const char*> queueRouteParamTypeDescMap = {
        {ACL_TDT_QUEUE_ROUTE_SRC_UINT32,   "TDT_QUEUE_ROUTE_SRC_UINT32(0)"},
        {ACL_TDT_QUEUE_ROUTE_DST_UINT32,   "TDT_QUEUE_ROUTE_DST_UINT32(1)"},
        {ACL_TDT_QUEUE_ROUTE_STATUS_INT32, "TDT_QUEUE_ROUTE_STATUS_INT32(2)"},
    };

    auto it = queueRouteParamTypeDescMap.find(type);
    if (it != queueRouteParamTypeDescMap.end()) { return it->second; }
    static thread_local char enumBuf[32];
    (void)snprintf_s(enumBuf, sizeof(enumBuf), sizeof(enumBuf) - 1, "UNKNOWN(%d)", static_cast<int32_t>(type));
    return enumBuf;
}

inline const char* GetQueueRouteQueryInfoParamTypeDesc(acltdtQueueRouteQueryInfoParamType type) {
    static const std::unordered_map<acltdtQueueRouteQueryInfoParamType, const char*> queueRouteQueryInfoParamTypeDescMap = {
        {ACL_TDT_QUEUE_ROUTE_QUERY_MODE_ENUM,    "TDT_QUEUE_ROUTE_QUERY_MODE_ENUM(0)"},
        {ACL_TDT_QUEUE_ROUTE_QUERY_SRC_ID_UINT32, "TDT_QUEUE_ROUTE_QUERY_SRC_ID_UINT32(1)"},
        {ACL_TDT_QUEUE_ROUTE_QUERY_DST_ID_UINT32, "TDT_QUEUE_ROUTE_QUERY_DST_ID_UINT32(2)"},
    };

    auto it = queueRouteQueryInfoParamTypeDescMap.find(type);
    if (it != queueRouteQueryInfoParamTypeDescMap.end()) { return it->second; }
    static thread_local char enumBuf[32];
    (void)snprintf_s(enumBuf, sizeof(enumBuf), sizeof(enumBuf) - 1, "UNKNOWN(%d)", static_cast<int32_t>(type));
    return enumBuf;
}

inline const char* GetAllocBufTypeDesc(acltdtAllocBufType type) {
    static const std::unordered_map<acltdtAllocBufType, const char*> allocBufTypeDescMap = {
        {ACL_TDT_NORMAL_MEM, "TDT_NORMAL_MEM(0)"},
        {ACL_TDT_DVPP_MEM,   "TDT_DVPP_MEM(1)"},
    };

    auto it = allocBufTypeDescMap.find(type);
    if (it != allocBufTypeDescMap.end()) { return it->second; }
    static thread_local char enumBuf[32];
    (void)snprintf_s(enumBuf, sizeof(enumBuf), sizeof(enumBuf) - 1, "UNKNOWN(%d)", static_cast<int32_t>(type));
    return enumBuf;
}

inline const char* GetTensorTypeDesc(acltdtTensorType type) {
    static const std::unordered_map<acltdtTensorType, const char*> tensorTypeDescMap = {
        {ACL_TENSOR_DATA_UNDEFINED,    "TENSOR_DATA_UNDEFINED(-1)"},
        {ACL_TENSOR_DATA_TENSOR,       "TENSOR_DATA_TENSOR(0)"},
        {ACL_TENSOR_DATA_END_OF_SEQUENCE, "TENSOR_DATA_END_OF_SEQUENCE(1)"},
        {ACL_TENSOR_DATA_ABNORMAL,     "TENSOR_DATA_ABNORMAL(2)"},
        {ACL_TENSOR_DATA_SLICE_TENSOR, "TENSOR_DATA_SLICE_TENSOR(3)"},
        {ACL_TENSOR_DATA_END_TENSOR,   "TENSOR_DATA_END_TENSOR(4)"},
    };

    auto it = tensorTypeDescMap.find(type);
    if (it != tensorTypeDescMap.end()) { return it->second; }
    static thread_local char enumBuf[32];
    (void)snprintf_s(enumBuf, sizeof(enumBuf), sizeof(enumBuf) - 1, "UNKNOWN(%d)", static_cast<int32_t>(type));
    return enumBuf;
}

inline const char* GetSysParamOptDesc(aclSysParamOpt opt) {
    static const std::unordered_map<aclSysParamOpt, const char*> sysParamOptDescMap = {
        {ACL_OPT_DETERMINISTIC,       "OPT_DETERMINISTIC(0)"},
        {ACL_OPT_ENABLE_DEBUG_KERNEL, "OPT_ENABLE_DEBUG_KERNEL(1)"},
        {ACL_OPT_STRONG_CONSISTENCY,  "OPT_STRONG_CONSISTENCY(2)"},
    };

    auto it = sysParamOptDescMap.find(opt);
    if (it != sysParamOptDescMap.end()) { return it->second; }
    static thread_local char enumBuf[32];
    (void)snprintf_s(enumBuf, sizeof(enumBuf), sizeof(enumBuf) - 1, "UNKNOWN(%d)", static_cast<int32_t>(opt));
    return enumBuf;
}

inline const char* GetCallbackBlockTypeDesc(aclrtCallbackBlockType type) {
    static const std::unordered_map<aclrtCallbackBlockType, const char*> callbackBlockTypeDescMap = {
        {ACL_CALLBACK_NO_BLOCK, "CALLBACK_NO_BLOCK(0)"},
        {ACL_CALLBACK_BLOCK,    "CALLBACK_BLOCK(1)"},
    };

    auto it = callbackBlockTypeDescMap.find(type);
    if (it != callbackBlockTypeDescMap.end()) { return it->second; }
    static thread_local char enumBuf[32];
    (void)snprintf_s(enumBuf, sizeof(enumBuf), sizeof(enumBuf) - 1, "UNKNOWN(%d)", static_cast<int32_t>(type));
    return enumBuf;
}

inline const char* GetMemLocationTypeDesc(aclrtMemLocationType type) {
    static const std::unordered_map<aclrtMemLocationType, const char*> memLocationTypeDescMap = {
        {ACL_MEM_LOCATION_TYPE_HOST,         "MEM_LOCATION_TYPE_HOST(0)"},
        {ACL_MEM_LOCATION_TYPE_DEVICE,       "MEM_LOCATION_TYPE_DEVICE(1)"},
        {ACL_MEM_LOCATION_TYPE_UNREGISTERED, "MEM_LOCATION_TYPE_UNREGISTERED(2)"},
        {ACL_MEM_LOCATION_TYPE_HOST_NUMA,    "MEM_LOCATION_TYPE_HOST_NUMA(4)"},
    };

    auto it = memLocationTypeDescMap.find(type);
    if (it != memLocationTypeDescMap.end()) { return it->second; }
    static thread_local char enumBuf[32];
    (void)snprintf_s(enumBuf, sizeof(enumBuf), sizeof(enumBuf) - 1, "UNKNOWN(%d)", static_cast<int32_t>(type));
    return enumBuf;
}

inline const char* GetMemAllocationTypeDesc(aclrtMemAllocationType type) {
    static const std::unordered_map<aclrtMemAllocationType, const char*> memAllocationTypeDescMap = {
        {ACL_MEM_ALLOCATION_TYPE_PINNED, "MEM_ALLOCATION_TYPE_PINNED(0)"},
    };

    auto it = memAllocationTypeDescMap.find(type);
    if (it != memAllocationTypeDescMap.end()) { return it->second; }
    static thread_local char enumBuf[32];
    (void)snprintf_s(enumBuf, sizeof(enumBuf), sizeof(enumBuf) - 1, "UNKNOWN(%d)", static_cast<int32_t>(type));
    return enumBuf;
}

inline const char* GetTdtDataTypeDesc(tdt::TdtDataType type) {
    static const std::unordered_map<tdt::TdtDataType, const char*> tdtDataTypeDescMap = {
        {tdt::TDT_IMAGE_LABEL,      "TDT_IMAGE_LABEL(0)"},
        {tdt::TDT_TFRECORD,         "TDT_TFRECORD(1)"},
        {tdt::TDT_DATA_LABEL,       "TDT_DATA_LABEL(2)"},
        {tdt::TDT_END_OF_SEQUENCE,  "TDT_END_OF_SEQUENCE(3)"},
        {tdt::TDT_TENSOR,           "TDT_TENSOR(4)"},
        {tdt::TDT_ABNORMAL,         "TDT_ABNORMAL(5)"},
        {tdt::TDT_DATATYPE_MAX,     "TDT_DATATYPE_MAX(6)"},
    };

    auto it = tdtDataTypeDescMap.find(type);
    if (it != tdtDataTypeDescMap.end()) { return it->second; }
    static thread_local char enumBuf[32];
    (void)snprintf_s(enumBuf, sizeof(enumBuf), sizeof(enumBuf) - 1, "UNKNOWN(%d)", static_cast<int32_t>(type));
    return enumBuf;
}

inline const char* GetTdtDataTypeDescV2(int32_t type) {
    static constexpr int32_t TDT_V2_TENSOR = 0;
    static constexpr int32_t TDT_V2_END_OF_SEQUENCE = 1;
    static constexpr int32_t TDT_V2_ABNORMAL = 2;
    static constexpr int32_t TDT_V2_SLICE_TENSOR = 3;
    static constexpr int32_t TDT_V2_END_TENSOR = 4;
    static const std::unordered_map<int32_t, const char*> tdtDataTypeDescV2Map = {
        {TDT_V2_TENSOR,           "TDT_V2_TENSOR(0)"},
        {TDT_V2_END_OF_SEQUENCE,  "TDT_V2_END_OF_SEQUENCE(1)"},
        {TDT_V2_ABNORMAL,         "TDT_V2_ABNORMAL(2)"},
        {TDT_V2_SLICE_TENSOR,     "TDT_V2_SLICE_TENSOR(3)"},
        {TDT_V2_END_TENSOR,       "TDT_V2_END_TENSOR(4)"},
    };

    auto it = tdtDataTypeDescV2Map.find(type);
    if (it != tdtDataTypeDescV2Map.end()) { return it->second; }
    static thread_local char enumBuf[32];
    (void)snprintf_s(enumBuf, sizeof(enumBuf), sizeof(enumBuf) - 1, "UNKNOWN(%d)", type);
    return enumBuf;
}

inline const char* GetRunModeDesc(aclrtRunMode mode) {
    static const std::unordered_map<aclrtRunMode, const char*> runModeDescMap = {
        {ACL_DEVICE, "DEVICE(0)"},
        {ACL_HOST,   "HOST(1)"},
    };

    auto it = runModeDescMap.find(mode);
    if (it != runModeDescMap.end()) { return it->second; }
    static thread_local char enumBuf[32];
    (void)snprintf_s(enumBuf, sizeof(enumBuf), sizeof(enumBuf) - 1, "UNKNOWN(%d)", static_cast<int32_t>(mode));
    return enumBuf;
}

inline const char* GetCaptureModeDesc(aclmdlRICaptureMode mode) {
    static const std::unordered_map<aclmdlRICaptureMode, const char*> captureModeDescMap = {
        {ACL_MODEL_RI_CAPTURE_MODE_GLOBAL,       "MODEL_RI_CAPTURE_MODE_GLOBAL(0)"},
        {ACL_MODEL_RI_CAPTURE_MODE_THREAD_LOCAL, "MODEL_RI_CAPTURE_MODE_THREAD_LOCAL(1)"},
        {ACL_MODEL_RI_CAPTURE_MODE_RELAXED,      "MODEL_RI_CAPTURE_MODE_RELAXED(2)"},
    };

    auto it = captureModeDescMap.find(mode);
    if (it != captureModeDescMap.end()) { return it->second; }
    static thread_local char enumBuf[32];
    (void)snprintf_s(enumBuf, sizeof(enumBuf), sizeof(enumBuf) - 1, "UNKNOWN(%d)", static_cast<int32_t>(mode));
    return enumBuf;
}

inline const char* GetLastErrLevelDesc(aclrtLastErrLevel level) {
    static const std::unordered_map<aclrtLastErrLevel, const char*> lastErrLevelDescMap = {
        {ACL_RT_THREAD_LEVEL, "THREAD_LEVEL(0)"},
    };

    auto it = lastErrLevelDescMap.find(level);
    if (it != lastErrLevelDescMap.end()) { return it->second; }
    static thread_local char enumBuf[32];
    (void)snprintf_s(enumBuf, sizeof(enumBuf), sizeof(enumBuf) - 1, "UNKNOWN(%d)", static_cast<int32_t>(level));
    return enumBuf;
}

inline const char* GetDeviceInfoDesc(aclDeviceInfo info) {
    static const std::unordered_map<aclDeviceInfo, const char*> deviceInfoDescMap = {
        {ACL_DEVICE_INFO_UNDEFINED,     "DEVICE_INFO_UNDEFINED(-1)"},
        {ACL_DEVICE_INFO_AI_CORE_NUM,   "DEVICE_INFO_AI_CORE_NUM(0)"},
        {ACL_DEVICE_INFO_VECTOR_CORE_NUM, "DEVICE_INFO_VECTOR_CORE_NUM(1)"},
        {ACL_DEVICE_INFO_L2_SIZE,       "DEVICE_INFO_L2_SIZE(2)"},
    };

    auto it = deviceInfoDescMap.find(info);
    if (it != deviceInfoDescMap.end()) { return it->second; }
    static thread_local char enumBuf[32];
    (void)snprintf_s(enumBuf, sizeof(enumBuf), sizeof(enumBuf) - 1, "UNKNOWN(%d)", static_cast<int32_t>(info));
    return enumBuf;
}

inline const char* GetMemAttrDesc(aclrtMemAttr attr) {
    static const std::unordered_map<aclrtMemAttr, const char*> memAttrDescMap = {
        {ACL_DDR_MEM,              "DDR_MEM(0)"},
        {ACL_HBM_MEM,              "HBM_MEM(1)"},
        {ACL_DDR_MEM_HUGE,         "DDR_MEM_HUGE(2)"},
        {ACL_DDR_MEM_NORMAL,       "DDR_MEM_NORMAL(3)"},
        {ACL_HBM_MEM_HUGE,         "HBM_MEM_HUGE(4)"},
        {ACL_HBM_MEM_NORMAL,       "HBM_MEM_NORMAL(5)"},
        {ACL_DDR_MEM_P2P_HUGE,     "DDR_MEM_P2P_HUGE(6)"},
        {ACL_DDR_MEM_P2P_NORMAL,   "DDR_MEM_P2P_NORMAL(7)"},
        {ACL_HBM_MEM_P2P_HUGE,     "HBM_MEM_P2P_HUGE(8)"},
        {ACL_HBM_MEM_P2P_NORMAL,   "HBM_MEM_P2P_NORMAL(9)"},
        {ACL_HBM_MEM_HUGE1G,       "HBM_MEM_HUGE1G(10)"},
        {ACL_HBM_MEM_P2P_HUGE1G,   "HBM_MEM_P2P_HUGE1G(11)"},
        {ACL_MEM_NORMAL,           "MEM_NORMAL(12)"},
        {ACL_MEM_HUGE,             "MEM_HUGE(13)"},
        {ACL_MEM_HUGE1G,           "MEM_HUGE1G(14)"},
        {ACL_MEM_P2P_NORMAL,       "MEM_P2P_NORMAL(15)"},
        {ACL_MEM_P2P_HUGE,         "MEM_P2P_HUGE(16)"},
        {ACL_MEM_P2P_HUGE1G,       "MEM_P2P_HUGE1G(17)"},
    };

    auto it = memAttrDescMap.find(attr);
    if (it != memAttrDescMap.end()) { return it->second; }
    static thread_local char enumBuf[32];
    (void)snprintf_s(enumBuf, sizeof(enumBuf), sizeof(enumBuf) - 1, "UNKNOWN(%d)", static_cast<int32_t>(attr));
    return enumBuf;
}

static inline std::string DatasetMemTypeToString(const datasetMemType type)
{
    std::string result;
    switch (type) {
        case MEM_UNKNOWN:
            result = "MEM_UNKNOWN(0)";
            break;
        case MEM_HOST:
            result = "MEM_HOST(1)";
            break;
        case MEM_DEVICE:
            result = "MEM_DEVICE(2)";
            break;
        default:
            result = "UNKNOWN(" + std::to_string(static_cast<int32_t>(type)) + ")";
            break;
    }
    return result;
}

} // namespace acl

#endif // ACL_UTILS_DATA_TYPE_UTILS_H
