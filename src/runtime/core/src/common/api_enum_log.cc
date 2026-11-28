/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "api_enum_log.hpp"

#if RUNTIME_ENABLE_ENUM_LOG_NAMES
#include "enum_log_impl.hpp"
#include "runtime/rt_model.h"

// Public enums stay as ordinary declarations; log-only metadata is private to this translation unit.
#define RT_FUSION_SCHEM_MODE_META(X)             \
    X(RT_SCHEM_MODE_NORMAL, "SCHEM_MODE_NORMAL") \
    X(RT_SCHEM_MODE_BATCH, "SCHEM_MODE_BATCH")   \
    X(RT_SCHEM_MODE_END, "UNKNOWN")

#define RT_STREAM_SWITCH_DATA_TYPE_META(X) \
    X(RT_SWITCH_INT32, "SWITCH_INT32")     \
    X(RT_SWITCH_INT64, "SWITCH_INT64")

#define RT_EXCEPTION_EXPAND_TYPE_META(X)             \
    X(RT_EXCEPTION_INVALID, "EXCEPTION_INVALID")     \
    X(RT_EXCEPTION_FFTS_PLUS, "EXCEPTION_FFTS_PLUS") \
    X(RT_EXCEPTION_AICORE, "EXCEPTION_AICORE")       \
    X(RT_EXCEPTION_UB, "EXCEPTION_UB")               \
    X(RT_EXCEPTION_CCU, "EXCEPTION_CCU")             \
    X(RT_EXCEPTION_FUSION, "EXCEPTION_FUSION")       \
    X(RT_EXCEPTION_AICPU, "EXCEPTION_AICPU")

#define RT_DEVICE_MESSAGE_TYPE_META(X)                                               \
    X(RT_GET_DEV_ERROR_MSG, "GET_DEV_ERROR_MSG")                                     \
    X(RT_GET_DEV_RUNNING_STREAM_SNAPSHOT_MSG, "GET_DEV_RUNNING_STREAM_SNAPSHOT_MSG") \
    X(RT_GET_DEV_PID_SNAPSHOT_MSG, "GET_DEV_PID_SNAPSHOT_MSG")                       \
    X(RT_GET_DEV_MSG_RESERVE, "UNKNOWN")

#define RT_DQS_ZERO_COPY_TYPE_META(X)                                              \
    X(RT_DQS_ZERO_COPY_INPUT, "DQS_ZERO_COPY_INPUT")   /* 输入数据零拷贝 */ \
    X(RT_DQS_ZERO_COPY_OUTPUT, "DQS_ZERO_COPY_OUTPUT") /* 输出数据零拷贝 */

#define RT_FUSION_SUB_KERNEL_TYPE_META(X)    \
    X(RT_FUSION_HCOM_CPU, "FUSION_HCOM_CPU") \
    X(RT_FUSION_AICPU, "FUSION_AICPU")       \
    X(RT_FUSION_AICORE, "FUSION_AICORE")     \
    X(RT_FUSION_CCU, "FUSION_CCU")           \
    X(RT_FUSION_END, "UNKNOWN")

#define RT_BIN_BUFFER_TYPE_META(X)           \
    X(RT_BIN_HOST_ADDR, "BIN_HOST_ADDR")     \
    X(RT_BIN_DEVICE_ADDR, "BIN_DEVICE_ADDR") \
    X(RT_BIN_TYPE_MAX, "UNKNOWN")

#define RT_BUFFER_GET_COMMAND_META(X)                              \
    X(RT_BUFF_GET_MBUF_TIMEOUT_INFO, "BUFF_GET_MBUF_TIMEOUT_INFO") \
    X(RT_BUFF_GET_MBUF_USE_INFO, "BUFF_GET_MBUF_USE_INFO")         \
    X(RT_BUFF_GET_MBUF_TYPE_INFO, "BUFF_GET_MBUF_TYPE_INFO")       \
    X(RT_BUFF_GET_MBUF_BUILD_INFO, "BUFF_GET_MBUF_BUILD_INFO")     \
    X(RT_BUFF_GET_MAX, "UNKNOWN")

#define RT_MALLOC_ADVICE_META(X)             \
    X(RT_MEM_ADVISE_NONE, "MEM_ADVISE_NONE") \
    X(RT_MEM_ADVISE_DVPP, "MEM_ADVISE_DVPP") \
    X(RT_MEM_ADVISE_TS, "MEM_ADVISE_TS")     \
    X(RT_MEM_ADVISE_CACHED, "MEM_ADVISE_CACHED")

#define RT_QUEUE_QUERY_COMMAND_META(X)                                                             \
    X(RT_MQ_QUERY_QUE_ATTR_OF_CUR_PROC,                                                            \
      "MQ_QUERY_QUE_ATTR_OF_CUR_PROC") /* input is qid(4bytes), output is rtMemQueueShareAttr_t */ \
    X(RT_MQ_QUERY_QUES_OF_CUR_PROC, "MQ_QUERY_QUES_OF_CUR_PROC")                                   \
    X(RT_MQ_QUERY_QUES_ATTR_ENTITY_TYPE, "MQ_QUERY_QUES_ATTR_ENTITY_TYPE")                         \
    X(RT_MQ_QUERY_CMD_MAX, "UNKNOWN")

#define RT_MEMCPY_OR_REDUCE_KIND_META(X)                                                                       \
    X(RT_MEMCPY_HOST_TO_HOST, "MEMCPY_HOST_TO_HOST")           /* host to host */                              \
    X(RT_MEMCPY_HOST_TO_DEVICE, "MEMCPY_HOST_TO_DEVICE")       /* host to device */                            \
    X(RT_MEMCPY_DEVICE_TO_HOST, "MEMCPY_DEVICE_TO_HOST")       /* device to host */                            \
    X(RT_MEMCPY_DEVICE_TO_DEVICE, "MEMCPY_DEVICE_TO_DEVICE")   /* device to device, 1P && P2P */               \
    X(RT_MEMCPY_MANAGED, "MEMCPY_MANAGED")                     /* managed memory */                            \
    X(RT_MEMCPY_ADDR_DEVICE_TO_DEVICE, "MEMCPY_ADDR_DEVICE_TO_DEVICE")                                         \
    X(RT_MEMCPY_HOST_TO_DEVICE_EX, "MEMCPY_HOST_TO_DEVICE_EX") /* host to device ex (only used for 8 bytes) */ \
    X(RT_MEMCPY_DEVICE_TO_HOST_EX, "MEMCPY_DEVICE_TO_HOST_EX") /* device to host ex */                         \
    X(RT_MEMCPY_DEFAULT, "MEMCPY_DEFAULT")                     /* auto infer copy dir */                       \
    X(RT_MEMCPY_RESERVED, "UNKNOWN")

#define RT_MODEL_QUEUE_FLAG_META(X)              \
    X(RT_MODEL_INPUT_QUEUE, "MODEL_INPUT_QUEUE") \
    X(RT_MODEL_OUTPUT_QUEUE, "MODEL_OUTPUT_QUEUE")

#define RT_TS_AICPU_MODEL_CMD_META(X)                   \
    X(TS_AICPU_MODEL_LOAD, "TS_AICPU_MODEL_LOAD")       \
    X(TS_AICPU_MODEL_EXECUTE, "TS_AICPU_MODEL_EXECUTE") \
    X(TS_AICPU_MODEL_DESTROY, "TS_AICPU_MODEL_DESTROY") \
    X(TS_AICPU_MODEL_ABORT, "TS_AICPU_MODEL_ABORT")     \
    X(TS_AICPU_MODEL_RESERVED, "UNKNOWN")

#define RT_TASK_BUFFER_TYPE_META(X)                                          \
    X(HWTS_STATIC_TASK_DESC, "HWTS_STATIC_TASK_DESC")   /**< static task */  \
    X(HWTS_DYNAMIC_TASK_DESC, "HWTS_DYNAMIC_TASK_DESC") /**< dynamic task */ \
    X(PARAM_TASK_INFO_DESC, "PARAM_TASK_INFO_DESC")     /**< task param */   \
    X(MAX_TASK, "UNKNOWN")

#define RT_PRELOAD_TASK_TYPE_META(X)                                                   \
    X(RT_TASK_TYPE_KERNEL_AICORE, "TASK_TYPE_KERNEL_AICORE")                           \
    X(RT_TASK_TYPE_KERNEL_AICPU, "TASK_TYPE_KERNEL_AICPU")                             \
    X(RT_TASK_TYPE_KERNEL_NANO_AICORE, "TASK_TYPE_KERNEL_NANO_AICORE")                 \
    X(RT_TASK_TYPE_KERNEL_NANO_AICPU_HOSTFUNC, "TASK_TYPE_KERNEL_NANO_AICPU_HOSTFUNC") \
    X(RT_TASK_TYPE_MAX, "UNKNOWN")

#define RT_UTILIZATION_TYPE_META(X)                \
    X(RT_UTIL_TYPE_AICORE, "UTIL_TYPE_AICORE")     \
    X(RT_UTIL_TYPE_AIVECTOR, "UTIL_TYPE_AIVECTOR") \
    X(RT_UTIL_TYPE_AICPU, "UTIL_TYPE_AICPU")       \
    X(RT_UTIL_TYPE_MAX, "UNKNOWN")

#define RT_DEVICE_CALLBACK_DIRECTION_META(X) \
    X(DEV_CB_POS_FRONT, "DEV_CB_POS_FRONT")  \
    X(DEV_CB_POS_BACK, "DEV_CB_POS_BACK")    \
    X(DEV_CB_POS_END, "DEV_CB_POS_END")

#define RT_DEVICE_CAPABILITY_META(X)                                                                        \
    X(RT_SCHEDULE_SOFTWARE, "SCHEDULE_SOFTWARE") /* Software Schedule */                                    \
    X(RT_SCHEDULE_SOFTWARE_OPT, "SCHEDULE_SOFTWARE_OPT")                                                    \
    X(RT_SCHEDULE_HARDWARE, "SCHEDULE_HARDWARE") /* HWTS Schedule */                                        \
    X(RT_AICPU_BLOCKING_OP_NOT_SUPPORT, "AICPU_BLOCKING_OP_NOT_SUPPORT")                                    \
    X(RT_AICPU_BLOCKING_OP_SUPPORT,                                                                         \
      "AICPU_BLOCKING_OP_SUPPORT")                   /* 1910/1980/51 ts support AICPU blocking operation */ \
    X(RT_MODE_NO_FFTS, "MODE_NO_FFTS")               /* no ffts */                                          \
    X(RT_MODE_FFTS, "MODE_FFTS")                     /* 81 get ffts work mode, ffts */                      \
    X(RT_MODE_FFTS_PLUS, "MODE_FFTS_PLUS")           /* 81 get ffts work mode, ffts plus */                 \
    X(RT_DEV_CAP_SUPPORT, "DEV_CAP_SUPPORT")         /* Capability Support */                               \
    X(RT_DEV_CAP_NOT_SUPPORT, "DEV_CAP_NOT_SUPPORT") /* Capability not support */

#define RT_TASK_TIMEOUT_TYPE_META(X)                   \
    X(RT_TIMEOUT_TYPE_OP_WAIT, "TIMEOUT_TYPE_OP_WAIT") \
    X(RT_TIMEOUT_TYPE_OP_EXECUTE, "TIMEOUT_TYPE_OP_EXECUTE")

#define RT_RUN_MODE_META(X)                            \
    X(RT_RUN_MODE_OFFLINE, "RUN_MODE_OFFLINE")         \
    X(RT_RUN_MODE_ONLINE, "RUN_MODE_ONLINE")           \
    X(RT_RUN_MODE_AICPU_SCHED, "RUN_MODE_AICPU_SCHED") \
    X(RT_RUN_MODE_RESERVED, "UNKNOWN")

#define RT_HDC_SERVICE_TYPE_META(X)                                          \
    X(RT_HDC_SERVICE_TYPE_DMP, "HDC_SERVICE_TYPE_DMP")                       \
    X(RT_HDC_SERVICE_TYPE_PROFILING, "HDC_SERVICE_TYPE_PROFILING")           \
    X(RT_HDC_SERVICE_TYPE_IDE1, "HDC_SERVICE_TYPE_IDE1")                     \
    X(RT_HDC_SERVICE_TYPE_FILE_TRANS, "HDC_SERVICE_TYPE_FILE_TRANS")         \
    X(RT_HDC_SERVICE_TYPE_IDE2, "HDC_SERVICE_TYPE_IDE2")                     \
    X(RT_HDC_SERVICE_TYPE_LOG, "HDC_SERVICE_TYPE_LOG")                       \
    X(RT_HDC_SERVICE_TYPE_RDMA, "HDC_SERVICE_TYPE_RDMA")                     \
    X(RT_HDC_SERVICE_TYPE_BBOX, "HDC_SERVICE_TYPE_BBOX")                     \
    X(RT_HDC_SERVICE_TYPE_FRAMEWORK, "HDC_SERVICE_TYPE_FRAMEWORK")           \
    X(RT_HDC_SERVICE_TYPE_TSD, "HDC_SERVICE_TYPE_TSD")                       \
    X(RT_HDC_SERVICE_TYPE_TDT, "HDC_SERVICE_TYPE_TDT")                       \
    X(RT_HDC_SERVICE_TYPE_PROF, "HDC_SERVICE_TYPE_PROF")                     \
    X(RT_HDC_SERVICE_TYPE_IDE_FILE_TRANS, "HDC_SERVICE_TYPE_IDE_FILE_TRANS") \
    X(RT_HDC_SERVICE_TYPE_DUMP, "HDC_SERVICE_TYPE_DUMP")                     \
    X(RT_HDC_SERVICE_TYPE_USER3, "HDC_SERVICE_TYPE_USER3")                   \
    X(RT_HDC_SERVICE_TYPE_DVPP, "HDC_SERVICE_TYPE_DVPP")                     \
    X(RT_HDC_SERVICE_TYPE_QUEUE, "HDC_SERVICE_TYPE_QUEUE")                   \
    X(RT_HDC_SERVICE_TYPE_UPGRADE, "HDC_SERVICE_TYPE_UPGRADE")               \
    X(RT_HDC_SERVICE_TYPE_RDMA_V2, "HDC_SERVICE_TYPE_RDMA_V2")               \
    X(RT_HDC_SERVICE_TYPE_TEST, "HDC_SERVICE_TYPE_TEST")                     \
    X(RT_HDC_SERVICE_TYPE_USER_START, "HDC_SERVICE_TYPE_USER_START")         \
    X(RT_HDC_SERVICE_TYPE_USER_END, "HDC_SERVICE_TYPE_USER_END")             \
    X(RT_HDC_SERVICE_TYPE_MAX, "UNKNOWN")

#define RT_EVENT_STATUS_META(X)    \
    X(RT_EVENT_INIT, "EVENT_INIT") \
    X(RT_EVENT_RECORDED, "EVENT_RECORDED")

#define RT_LAUNCH_KERNEL_TYPE_META(X)                       \
    X(KERNEL_TYPE_CCE, "KERNEL_TYPE_CCE")                   \
    X(KERNEL_TYPE_FWK, "KERNEL_TYPE_FWK")                   \
    X(KERNEL_TYPE_AICPU, "KERNEL_TYPE_AICPU")               \
    X(KERNEL_TYPE_AICPU_CUSTOM, "KERNEL_TYPE_AICPU_CUSTOM") \
    X(KERNEL_TYPE_AICPU_KFC, "KERNEL_TYPE_AICPU_KFC")       \
    X(KERNEL_TYPE_CUSTOM_KFC, "KERNEL_TYPE_CUSTOM_KFC")     \
    X(KERNEL_TYPE_HWTS, "KERNEL_TYPE_HWTS")                 \
    X(KERNEL_TYPE_RESERVED, "KERNEL_TYPE_RESERVED")

#define RT_POINTER_MEMORY_TYPE_META(X)             \
    X(RT_MEMORY_TYPE_HOST, "MEMORY_TYPE_HOST")     \
    X(RT_MEMORY_TYPE_DEVICE, "MEMORY_TYPE_DEVICE") \
    X(RT_MEMORY_TYPE_SVM, "MEMORY_TYPE_SVM")       \
    X(RT_MEMORY_TYPE_DVPP, "MEMORY_TYPE_DVPP")     \
    X(RT_MEMORY_TYPE_USER, "MEMORY_TYPE_USER")

#define RT_ADVISE_MEMORY_TYPE_META(X)                        \
    X(RT_ADVISE_PERSISTENT, "ADVISE_PERSISTENT")             \
    X(RT_ADVISE_DEV_MEM, "ADVISE_DEV_MEM")                   \
    X(RT_ADVISE_ACCESS_READONLY, "ADVISE_ACCESS_READONLY")   \
    X(RT_ADVISE_ACCESS_READWRITE, "ADVISE_ACCESS_READWRITE") \
    X(RT_ADVISE_TYPE_MAX, "UNKNOWN")

#define RT_POINTER_LOCATION_META(X)                          \
    X(RT_MEMORY_LOC_HOST, "MEMORY_LOC_HOST")                 \
    X(RT_MEMORY_LOC_DEVICE, "MEMORY_LOC_DEVICE")             \
    X(RT_MEMORY_LOC_UNREGISTERED, "MEMORY_LOC_UNREGISTERED") \
    X(RT_MEMORY_LOC_MANAGED, "MEMORY_LOC_MANAGED")           \
    X(RT_MEMORY_LOC_HOST_NUMA, "MEMORY_LOC_HOST_NUMA")       \
    X(RT_MEMORY_LOC_MAX, "UNKNOWN")

#define RT_REDUCE_KIND_META(X)                                                                                     \
    X(RT_MEMCPY_SDMA_AUTOMATIC_ADD, "MEMCPY_SDMA_AUTOMATIC_ADD") /* D2D, SDMA inline reduce, include 1P and P2P */ \
    X(RT_MEMCPY_SDMA_AUTOMATIC_MAX, "MEMCPY_SDMA_AUTOMATIC_MAX")                                                   \
    X(RT_MEMCPY_SDMA_AUTOMATIC_MIN, "MEMCPY_SDMA_AUTOMATIC_MIN")                                                   \
    X(RT_MEMCPY_SDMA_AUTOMATIC_EQUAL, "MEMCPY_SDMA_AUTOMATIC_EQUAL")                                               \
    X(RT_RECUDE_KIND_END, "UNKNOWN")

RT_ENUM_STRING_IMPL(
    RtBinBufferTypeToString, rtBinBufferType_t, RT_BIN_BUFFER_TYPE_META, RT_ENUM_STRING_CASE, int32_t, "UNKNOWN")

RT_ENUM_STRING_IMPL(
    RtDevCallBackDirToString, rtDevCallBackDir_t, RT_DEVICE_CALLBACK_DIRECTION_META, RT_ENUM_STRING_CASE, int32_t,
    "UNKNOWN")

RT_ENUM_STRING_IMPL(RtRunModeToString, rtRunMode, RT_RUN_MODE_META, RT_ENUM_STRING_CASE, uint32_t, "UNKNOWN")

RT_ENUM_STRING_FROM_VALUE(RtRunModeToString, rtRunMode, RT_RUN_MODE_META, uint32_t)

RT_ENUM_STRING_IMPL(
    RtEventStatusToString, rtEventStatus_t, RT_EVENT_STATUS_META, RT_ENUM_STRING_CASE, int32_t, "UNKNOWN")

RT_ENUM_STRING_IMPL(
    RtKernelTypeToString, rtKernelType_t, RT_LAUNCH_KERNEL_TYPE_META, RT_ENUM_STRING_CASE, uint32_t, "UNKNOWN")

const char* ExecutableKernelTypeToString(rtKernelType_t value) noexcept
{
    // RESERVED is not an executable task kernel type.
    return (value == KERNEL_TYPE_RESERVED) ? "UNKNOWN" : RtKernelTypeToString(value);
}

const char* ExecutableKernelTypeToString(uint32_t value) noexcept
{
    return (value < KERNEL_TYPE_RESERVED) ? RtKernelTypeToString(static_cast<rtKernelType_t>(value)) : "UNKNOWN";
}

RT_ENUM_STRING_IMPL(
    RtAdviseMemTypeToString, rtAdviseMemType, RT_ADVISE_MEMORY_TYPE_META, RT_ENUM_STRING_CASE, int32_t, "UNKNOWN")

namespace cce {
namespace runtime {

RT_ENUM_STRING_TO_STRING(RtGetDevMsgTypeToString, rtGetDevMsgType_t, RT_DEVICE_MESSAGE_TYPE_META)

RT_ENUM_STRING_TO_STRING_U32(RtDqsZeroCopyTypeToString, rtDqsZeroCopyType, RT_DQS_ZERO_COPY_TYPE_META)

RT_ENUM_STRING_TO_STRING_U32(RtFusionTypeToString, rtFusionType_t, RT_FUSION_SUB_KERNEL_TYPE_META)

RT_ENUM_STRING_TO_STRING(RtBuffGetCmdTypeToString, rtBuffGetCmdType, RT_BUFFER_GET_COMMAND_META)

RT_ENUM_STRING_TO_STRING_U32(RtMallocAdviseToString, rtMallocAdvise, RT_MALLOC_ADVICE_META)

RT_ENUM_STRING_TO_STRING(RtMemQueueQueryCmdToString, rtMemQueueQueryCmd_t, RT_QUEUE_QUERY_COMMAND_META)

RT_ENUM_STRING_TO_STRING_U32(RtMemcpyKindToString, rtMemcpyKind_t, RT_MEMCPY_OR_REDUCE_KIND_META)

RT_ENUM_STRING_TO_STRING(RtModelQueueFlagToString, rtModelQueueFlag_t, RT_MODEL_QUEUE_FLAG_META)

RT_ENUM_STRING_FROM_VALUE(TsAicpuModelCmdToString, tsAicpuModelCmd, RT_TS_AICPU_MODEL_CMD_META, uint32_t)

RT_ENUM_STRING_TO_STRING(RtTaskBuffTypeToString, rtTaskBuffType_t, RT_TASK_BUFFER_TYPE_META)

RT_ENUM_STRING_TO_STRING_U32(RtTaskTypeToString, rtTaskType_t, RT_PRELOAD_TASK_TYPE_META)

RT_ENUM_STRING_TO_STRING(RtExceptionExpandTypeToString, rtExceptionExpandType_t, RT_EXCEPTION_EXPAND_TYPE_META)

RT_ENUM_STRING_TO_STRING_U32(RtSchemModeTypeToString, rtschemModeType_t, RT_FUSION_SCHEM_MODE_META)

RT_ENUM_STRING_FROM_VALUE(RtSchemModeTypeToString, rtschemModeType_t, RT_FUSION_SCHEM_MODE_META, uint32_t)

RT_ENUM_STRING_TO_STRING(RtTypeUtilToString, rtTypeUtil_t, RT_UTILIZATION_TYPE_META)

RT_ENUM_STRING_TO_STRING(RtDeviceCapabilityTypeToString, rtDeviceCapabilityType, RT_DEVICE_CAPABILITY_META)

RT_ENUM_STRING_TO_STRING(RtTaskTimeoutTypeToString, rtTaskTimeoutType_t, RT_TASK_TIMEOUT_TYPE_META)

RT_ENUM_STRING_IMPL(
    RtHdcServiceTypeToString, rtHdcServiceType_t, RT_HDC_SERVICE_TYPE_META, RT_ENUM_STRING_CASE, int32_t,
    ((value > RT_HDC_SERVICE_TYPE_USER_START && value < RT_HDC_SERVICE_TYPE_USER_END) ? "HDC_SERVICE_TYPE_USER" :
                                                                                        "UNKNOWN"))

RT_ENUM_STRING_TO_STRING(RtMemoryTypeToString, rtMemoryType_t, RT_POINTER_MEMORY_TYPE_META)

RT_ENUM_STRING_TO_STRING(RtMemLocationTypeToString, rtMemLocationType, RT_POINTER_LOCATION_META)

RT_ENUM_STRING_TO_STRING_U32(RtRecudeKindToString, rtRecudeKind_t, RT_REDUCE_KIND_META)

RT_ENUM_STRING_TO_STRING_U32(RtSwitchDataTypeToString, rtSwitchDataType_t, RT_STREAM_SWITCH_DATA_TYPE_META)

const char* MemcpyOrReduceKindToString(uint32_t value) noexcept
{
    if (value < static_cast<uint32_t>(RT_MEMCPY_RESERVED)) {
        return RtMemcpyKindToString(static_cast<rtMemcpyKind_t>(value));
    }
    if (value > static_cast<uint32_t>(RT_RECUDE_KIND_END)) {
        return "UNKNOWN";
    }
    return RtRecudeKindToString(static_cast<rtRecudeKind_t>(value));
}

} // namespace runtime
} // namespace cce

#endif // RUNTIME_ENABLE_ENUM_LOG_NAMES
