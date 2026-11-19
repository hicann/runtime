/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "enum_log_impl.hpp"

#if RUNTIME_ENABLE_ENUM_LOG_NAMES
#include "../../inc/args/args_inner.h"
#include "../../inc/common/internal_error_define.hpp"
#include "../../inc/common/profiler_struct.hpp"
#include "../../inc/drv/driver.hpp"
#include "../../inc/event/event_david.hpp"
#include "../../inc/kernel/elf.hpp"
#include "../../inc/kernel/kernel.hpp"
#include "../../inc/printf.hpp"
#include "../../inc/runtime.hpp"
#include "../../inc/stars/stars_base.hpp"
#include "../../inc/task/task_base.hpp"
#include "../../inc/utils/capability.hpp"
#include "../../inc/utils/qos.hpp"
#include "../device/device.hpp"
#include "../event/event_state_callback_manager.hpp"
#include "../pool/h2d_copy_mgr.hpp"
#include "../pool/h2h_copy_mgr.hpp"
#include "../stream/stream.hpp"
#include "../../../feature/soma/stream_mem_pool.hpp"
#include "../../inc/common/driver_enum_desc.hpp"
#include "../../inc/device/device_enum_desc.hpp"
#include "../../inc/notify/notify_enum_desc.hpp"
#include "../../inc/cond_handle/cond_enum_desc.hpp"
#include "../../../feature/jetty/jetty_pool.h"

// Log metadata stays private to this translation unit; owner headers retain ordinary enum declarations.
#define RT_KERNEL_ARGS_TYPE_META(X)          \
    X(RT_ARGS_NON_CPU_EX, "ARGS_NON_CPU_EX") \
    X(RT_ARGS_CPU_EX, "ARGS_CPU_EX")         \
    X(RT_ARGS_HANDLE, "ARGS_HANDLE")         \
    X(RT_ARGS_ARRAY, "ARGS_ARRAY")           \
    X(RT_SIMT_ARGS_ARRAY, "SIMT_ARGS_ARRAY") \
    X(RT_SIMT_ARGS_HOST, "SIMT_ARGS_HOST")   \
    X(RT_ARGS_MAX, "UNKNOWN")

#define RT_DEVICE_FAULT_TYPE_META(X)                \
    X(L2_BUFFER_ERROR, "L2_BUFFER_ERROR")           \
    X(HBM_UCE_ERROR, "HBM_UCE_ERROR")               \
    X(AICORE_SW_ERROR, "AICORE_SW_ERROR")           \
    X(AICORE_HW_L_ERROR, "AICORE_HW_L_ERROR")       \
    X(AICORE_UNKNOWN_ERROR, "AICORE_UNKNOWN_ERROR") \
    X(LINK_ERROR, "LINK_ERROR")                     \
    X(L3_PORT_ERROR, "L3_PORT_ERROR")               \
    X(NO_ERROR, "NO_ERROR")

#define RT_PROFILE_RECORD_TYPE_META(X)                                                \
    X(PROFILE_RECORD_TYPE_SRART, "UNKNOWN")                                           \
    X(PROFILE_RECORD_TYPE_RT_CALL_RT, "PROFILE_RECORD_TYPE_RT_CALL_RT") /* runtime */ \
    X(PROFILE_RECORD_TYPE_RT_CALL_DRV, "PROFILE_RECORD_TYPE_RT_CALL_DRV")             \
    X(PROFILE_RECORD_TYPE_RT_ASYNC_INFO, "PROFILE_RECORD_TYPE_RT_ASYNC_INFO")         \
    X(PROFILE_RECORD_TYPE_RT_ASYNC_SEND, "PROFILE_RECORD_TYPE_RT_ASYNC_SEND")         \
    X(PROFILE_RECORD_TYPE_RT_ASYNC_RECV, "PROFILE_RECORD_TYPE_RT_ASYNC_RECV")         \
    X(PROFILE_RECORD_TYPE_TS_FORWARD, "PROFILE_RECORD_TYPE_TS_FORWARD") /* TS */      \
    X(PROFILE_RECORD_TYPE_TS_BACKWARD, "PROFILE_RECORD_TYPE_TS_BACKWARD")             \
    X(PROFILE_RECORD_TYPE_END, "UNKNOWN")

#define RT_MANAGED_MEMORY_FLAG_META(X)  \
    X(MANAGED_MEM_RW, "MANAGED_MEM_RW") \
    X(MANAGED_MEM_EX, "MANAGED_MEM_EX") \
    X(MANAGED_MEM_UVM, "MANAGED_MEM_UVM")

#define RT_DAVID_EVENT_STATE_META(X)        \
    X(EVT_NOT_RECORDED, "EVT_NOT_RECORDED") \
    X(EVT_RECORDED, "EVT_RECORDED")

#define RT_KERNEL_RATIO_META(X)                                 \
    X(RATION_TYPE_ONE_RATIO_TWO, "RATION_TYPE_ONE_RATIO_TWO")   \
    X(RATION_TYPE_TWO_RATIO_ONE, "RATION_TYPE_TWO_RATIO_ONE")   \
    X(RATION_TYPE_ONE_RATIO_ONE, "RATION_TYPE_ONE_RATIO_ONE")   \
    X(RATION_TYPE_ONE_RATIO_ZERO, "RATION_TYPE_ONE_RATIO_ZERO") \
    X(RATION_TYPE_ZERO_RATIO_ONE, "RATION_TYPE_ZERO_RATIO_ONE") \
    X(RATION_TYPE_MAX, "UNKNOWN")

#define RT_KERNEL_FUNCTION_ENTRY_TYPE_META(X)                                                                \
    X(KERNEL_TYPE_TILING_KEY, "KERNEL_TYPE_TILING_KEY")         /* legacy tiling key flow */                 \
    X(KERNEL_TYPE_FUNCTION_ENTRY, "KERNEL_TYPE_FUNCTION_ENTRY") /* replace tiling key with function entry */ \
    X(KERNEL_TYPE_NOT_SUPPORT_FUNCTION_ENTRY,                                                                \
      "KERNEL_TYPE_NOT_SUPPORT_FUNCTION_ENTRY")                 /* neither function-entry nor tiling-key supported */

#define RT_KERNEL_REGISTER_TYPE_META(X)              \
    X(RT_KERNEL_REG_TYPE_CPU, "KERNEL_REG_TYPE_CPU") \
    X(RT_KERNEL_REG_TYPE_NON_CPU, "KERNEL_REG_TYPE_NON_CPU")

#define RT_PRINT_DUMP_TYPE_META(X)          \
    X(DUMP_DEFAULT, "DUMP_DEFAULT")         \
    X(DUMP_SCALAR, "DUMP_SCALAR")           \
    X(DUMP_TENSOR, "DUMP_TENSOR")           \
    X(DUMP_SHAPE, "DUMP_SHAPE")             \
    X(DUMP_ASSERT, "DUMP_ASSERT")           \
    X(DUMP_META, "DUMP_META")               \
    X(DUMP_TIMESTAMP, "DUMP_TIMESTAMP")     \
    X(DUMP_SIMT, "DUMP_SIMT")               \
    X(DUMP_BUFI, "DUMP_BUFI")               \
    X(DUMP_BUFO, "DUMP_BUFO")               \
    X(DUMP_SKIP, "DUMP_SKIP")               \
    X(DUMP_AICPU, "DUMP_AICPU")             \
    X(DUMP_SIMT_ASSERT, "DUMP_SIMT_ASSERT") \
    X(DUMP_SIMT_PRINTF, "DUMP_SIMT_PRINTF") \
    X(DUMP_WAIT, "DUMP_WAIT")

#define RT_KERNEL_MIX_TYPE_META(X)                  \
    X(NO_MIX, "NO_MIX")                             \
    X(MIX_AIC, "MIX_AIC") /* faked mix, c:v=1:0 */  \
    X(MIX_AIV, "MIX_AIV") /* faked mix, c:v=0:1 */  \
    X(MIX_AIC_AIV_MAIN_AIC, "MIX_AIC_AIV_MAIN_AIC") \
    X(MIX_AIC_AIV_MAIN_AIV, "MIX_AIC_AIV_MAIN_AIV")

#define RT_TASK_TIME_UNIT_META(X)                                  \
    X(RT_TIME_UNIT_TYPE_S, "TIME_UNIT_TYPE_S")   /* second */      \
    X(RT_TIME_UNIT_TYPE_MS, "TIME_UNIT_TYPE_MS") /* millisecond */ \
    X(RT_TIME_UNIT_TYPE_US, "TIME_UNIT_TYPE_US") /* us */

#define RT_STARS_INTERRUPT_DIRECTION_META(X)                                                   \
    X(RT_STARS_SQE_INT_DIR_NO, "STARS_SQE_INT_DIR_NO")                 /* send no interrupt */ \
    X(RT_STARS_SQE_INT_DIR_TO_TSCPU, "STARS_SQE_INT_DIR_TO_TSCPU")     /* to tscpu */          \
    X(RT_STARS_SQE_INT_DIR_TO_CTRLCPU, "STARS_SQE_INT_DIR_TO_CTRLCPU") /* to ctrlcpu */        \
    X(RT_STARS_SQE_INT_DIR_TO_HOST, "STARS_SQE_INT_DIR_TO_HOST")       /* to host */           \
    X(RT_STARS_SQE_INT_DIR_END, "UNKNOWN")

#define RT_AICPU_TOPIC_TYPE_META(X)                                       \
    X(TOPIC_TYPE_DEVICE_AICPU_ONLY, "TOPIC_TYPE_DEVICE_AICPU_ONLY")       \
    X(TOPIC_TYPE_DEVICE_AICPU_FIRST, "TOPIC_TYPE_DEVICE_AICPU_FIRST")     \
    X(TOPIC_TYPE_HOST_AICPU_ONLY, "TOPIC_TYPE_HOST_AICPU_ONLY")           \
    X(TOPIC_TYPE_HOST_AICPU_FIRST, "TOPIC_TYPE_HOST_AICPU_FIRST")         \
    X(TOPIC_TYPE_HOST_CTRL_CPU, "TOPIC_TYPE_HOST_CTRL_CPU")               \
    X(TOPIC_TYPE_DATA_CPU, "TOPIC_TYPE_DATA_CPU")                         \
    X(TOPIC_TYPE_DEVICE_CTRL_CPU, "TOPIC_TYPE_DEVICE_CTRL_CPU")           \
    X(TOPIC_TYPE_TS_CPU, "TOPIC_TYPE_TS_CPU")                             \
    X(TOPIC_TYPE_DVPP_CPU, "TOPIC_TYPE_DVPP_CPU")                         \
    X(TOPIC_TYPE_DEVICE_HOST_CTRL_CPU, "TOPIC_TYPE_DEVICE_HOST_CTRL_CPU") \
    X(TOPIC_TYPE_DEVICE_AICPU_SRC_PID, "TOPIC_TYPE_DEVICE_AICPU_SRC_PID")

#define RT_MODEL_EXECUTOR_TYPE_META(X)                    \
    X(MODEL_EXECUTOR_TS, "MODEL_EXECUTOR_TS")             \
    X(MODEL_EXECUTOR_AICPU, "MODEL_EXECUTOR_AICPU")       \
    X(MODEL_EXECUTOR_RESERVED, "MODEL_EXECUTOR_RESERVED") \
    X(MODEL_EXECUTOR_CAPTURE, "MODEL_EXECUTOR_CAPTURE")

#define RT_MEMCPY_DIRECTION_META(X)                                                                             \
    X(RT_MEMCPY_DIR_H2D, "MEMCPY_DIR_H2D")                                                                      \
    X(RT_MEMCPY_DIR_D2H, "MEMCPY_DIR_D2H")                                                                      \
    X(RT_MEMCPY_DIR_D2D_SDMA, "MEMCPY_DIR_D2D_SDMA")                     /* D2D, 1P, P2P */                     \
    X(RT_MEMCPY_DIR_D2D_HCCs, "MEMCPY_DIR_D2D_HCCs")                     /* D2D, between devices */             \
    X(RT_MEMCPY_DIR_D2D_PCIe, "MEMCPY_DIR_D2D_PCIe")                     /* D2D, between devices */             \
    X(RT_MEMCPY_ADDR_D2D_SDMA, "MEMCPY_ADDR_D2D_SDMA")                   /* D2D, zero-cpy used */               \
    X(RT_MEMCPY_DIR_D2D_UB, "MEMCPY_DIR_D2D_UB")                         /* D2D, between devices UB */          \
    X(RT_MEMCPY_DIR_SDMA_AUTOMATIC_ADD, "MEMCPY_DIR_SDMA_AUTOMATIC_ADD") /* SDMA inline reduce automatic add */ \
    X(RT_MEMCPY_DIR_SDMA_AUTOMATIC_MAX, "MEMCPY_DIR_SDMA_AUTOMATIC_MAX")                                        \
    X(RT_MEMCPY_DIR_SDMA_AUTOMATIC_MIN, "MEMCPY_DIR_SDMA_AUTOMATIC_MIN")                                        \
    X(RT_MEMCPY_DIR_SDMA_AUTOMATIC_EQUAL, "MEMCPY_DIR_SDMA_AUTOMATIC_EQUAL")

#define RT_REPORT_PACKAGE_TYPE_META(X)                                                                              \
    X(RT_PACKAGE_TYPE_TASK_REPORT, "PACKAGE_TYPE_TASK_REPORT")                                                      \
    X(RT_PACKAGE_TYPE_ERROR_REPORT, "PACKAGE_TYPE_ERROR_REPORT") /* used for error report */                        \
    X(RT_PACKAGE_TYPE_RECYCLE_SQ_FINISHED,                                                                          \
      "PACKAGE_TYPE_RECYCLE_SQ_FINISHED")                        /* recycle sq report(used by ts and drv) */        \
    X(RT_PACKAGE_TYPE_RECYCLE_STREAM_FINISHED,                                                                      \
      "PACKAGE_TYPE_RECYCLE_STREAM_FINISHED")                    /* recycle stream id report(used by ts and drv) */ \
    X(RT_PACKAGE_TYPE_RECYCLE_NOTIFY_FINISHED,                                                                      \
      "PACKAGE_TYPE_RECYCLE_NOTIFY_FINISHED")                    /* recycle notify id report(used by ts and drv) */ \
    X(RT_PACKAGE_TYPE_RECYCLE_EVENT_FINISHED,                                                                       \
      "PACKAGE_TYPE_RECYCLE_EVENT_FINISHED")                     /* recycle event id report(used by ts and drv) */  \
    X(RT_PACKAGE_TYPE_RECYCLE_CQ_FINISHED,                                                                          \
      "PACKAGE_TYPE_RECYCLE_CQ_FINISHED")                        /* recycle cq report(used by ts and drv) */        \
    X(RT_PACKAGE_TYPE_BUTT, "UNKNOWN")

#define RT_MODEL_MAINTENANCE_TYPE_META(X)                   \
    X(MMT_STREAM_ADD, "MMT_STREAM_ADD")                     \
    X(MMT_STREAM_DEL, "MMT_STREAM_DEL")                     \
    X(MMT_MODEL_LOAD_COMPLETE, "MMT_MODEL_LOAD_COMPLETE")   \
    X(MMT_MODEL_DESTROY, "MMT_MODEL_DESTROY")               \
    X(MMT_MODEL_PRE_PROC, "MMT_MODEL_PRE_PROC")             \
    X(MMT_STREAM_LOAD_COMPLETE, "MMT_STREAM_LOAD_COMPLETE") \
    X(MMT_MODEL_ABORT, "MMT_MODEL_ABORT")                   \
    X(MMT_RESERVED, "UNKNOWN")

#define RT_MODEL_AICPU_KERNEL_TYPE_META(X)                                        \
    X(TS_AICPU_KERNEL_CCE, "TS_AICPU_KERNEL_CCE") /* AI cpu cce kernel */         \
    X(TS_AICPU_KERNEL_FMK, "TS_AICPU_KERNEL_FMK") /* AI cpu fmk kernel */         \
    X(TS_AICPU_KERNEL_AICPU, "TS_AICPU_KERNEL_AICPU")                             \
    X(TS_AICPU_KERNEL_DATADUMP, "TS_AICPU_KERNEL_DATADUMP")                       \
    X(TS_AICPU_KERNEL_CUSTOM_AICPU, "TS_AICPU_KERNEL_CUSTOM_AICPU")               \
    X(TS_AICPU_KERNEL_AICPU_KFC, "TS_AICPU_KERNEL_AICPU_KFC")                     \
    X(TS_AICPU_KERNEL_NON, "TS_AICPU_KERNEL_NON") /* for callback launch topic */ \
    X(TS_AICPU_KERNEL_RESERVED, "UNKNOWN")

#define RT_RUNTIME_FEATURE_META(X)                                                     \
    X(RT_FEATURE_STARS_COMPATIBILITY, "FEATURE_STARS_COMPATIBILITY")                   \
    X(RT_FEATURE_IPC_NOTICE_DC, "FEATURE_IPC_NOTICE_DC")                               \
    X(RT_FEATURE_FFTSPLUS_TASKID_SAME_FIX, "FEATURE_FFTSPLUS_TASKID_SAME_FIX")         \
    X(RT_FEATURE_OVER_FLOW_DEBUG, "FEATURE_OVER_FLOW_DEBUG")                           \
    X(RT_FEATURE_D2D_ADDR_ASYNC, "FEATURE_D2D_ADDR_ASYNC")                             \
    X(RT_FEATURE_FLIPTASK, "FEATURE_FLIPTASK")                                         \
    X(RT_FEATURE_FFTSPLUS_TIMEOUT, "FEATURE_FFTSPLUS_TIMEOUT")                         \
    X(RT_FEATURE_MC2_RTS_SUPPORT_HCCL, "FEATURE_MC2_RTS_SUPPORT_HCCL")                 \
    X(RT_FEATURE_IPC_NOTICE_CLOUD_V2, "FEATURE_IPC_NOTICE_CLOUD_V2")                   \
    X(RT_FEATURE_MC2_RTS_SUPPORT_HCCL_DC, "FEATURE_MC2_RTS_SUPPORT_HCCL_DC")           \
    X(RT_FEATURE_SUPPORT_REDUCEASYNC_V2_DC, "FEATURE_SUPPORT_REDUCEASYNC_V2_DC")       \
    X(RT_FEATURE_TILING_KEY_SINK, "FEATURE_TILING_KEY_SINK")                           \
    X(RT_FEATURE_MC2_ENHANCE, "FEATURE_MC2_ENHANCE")                                   \
    X(RT_FEATURE_FFTSPLUS_TASKID_SAME_FOR_ALL, "FEATURE_FFTSPLUS_TASKID_SAME_FOR_ALL") \
    X(RT_FEATURE_TASK_ABORT, "FEATURE_TASK_ABORT")                                     \
    X(RT_FEATURE_MAX, "UNKNOWN")

#define RT_QOS_MASTER_TYPE_META(X)            \
    X(MASTER_DVPP_ALL, "MASTER_DVPP_ALL")     \
    X(MASTER_DVPP_VPC, "MASTER_DVPP_VPC")     \
    X(MASTER_DVPP_VDEC, "MASTER_DVPP_VDEC")   \
    X(MASTER_DVPP_JPEGE, "MASTER_DVPP_JPEGE") \
    X(MASTER_DVPP_JPEGD, "MASTER_DVPP_JPEGD") \
    X(MASTER_ROCE, "MASTER_ROCE")             \
    X(MASTER_NIC, "MASTER_NIC")               \
    X(MASTER_PCIE, "MASTER_PCIE")             \
    X(MASTER_AICPU, "MASTER_AICPU")           \
    X(MASTER_AIC_DAT, "MASTER_AIC_DAT")       \
    X(MASTER_AIC_INS, "MASTER_AIC_INS")       \
    X(MASTER_AIV_DAT, "MASTER_AIV_DAT")       \
    X(MASTER_AIV_INS, "MASTER_AIV_INS")       \
    X(MASTER_SDMA, "MASTER_SDMA")             \
    X(MASTER_STARS, "MASTER_STARS")           \
    X(MASTER_INVALID, "UNKNOWN")

#define RT_EVENT_STATE_PERIOD_META(X)                           \
    X(EVENT_STATE_PERIOD_RECORD, "EVENT_STATE_PERIOD_RECORD")   \
    X(EVENT_STATE_PERIOD_WAIT, "EVENT_STATE_PERIOD_WAIT")       \
    X(EVENT_STATE_PERIOD_DESTROY, "EVENT_STATE_PERIOD_DESTROY") \
    X(EVENT_STATE_PERIOD_TYPE_MAX, "UNKNOWN")

#define RT_H2D_COPY_POLICY_META(X)                              \
    X(COPY_POLICY_DEFAULT, "COPY_POLICY_DEFAULT")               \
    X(COPY_POLICY_PCIE_BAR, "COPY_POLICY_PCIE_BAR")             \
    X(COPY_POLICY_ASYNC_PCIE_DMA, "COPY_POLICY_ASYNC_PCIE_DMA") \
    X(COPY_POLICY_SYNC, "COPY_POLICY_SYNC")                     \
    X(COPY_POLICY_UB, "COPY_POLICY_UB")                         \
    X(COPY_POLICY_MAX, "UNKNOWN")

#define RT_H2H_COPY_POLICY_META(X)              \
    X(H2H_POLICY_DEFAULT, "H2H_POLICY_DEFAULT") \
    X(H2H_COPY_POLICY_SYNC, "H2H_COPY_POLICY_SYNC")

#define RT_STREAM_STATE_CALLBACK_TYPE_META(X)                 \
    X(RT_STREAM_STATE_CALLBACK, "STREAM_STATE_CALLBACK")      \
    X(RTS_STREAM_STATE_CALLBACK, "RTS_STREAM_STATE_CALLBACK") \
    X(STREAM_CALLBACK_TYPE_MAX, "UNKNOWN")

#define RT_STREAM_SUBSCRIBE_FLAG_META(X) \
    X(SUBSCRIBE_NONE, "SUBSCRIBE_NONE")  \
    X(SUBSCRIBE_USER, "SUBSCRIBE_USER")  \
    X(SUBSCRIBE_RUNTIME, "SUBSCRIBE_RUNTIME")

#define RT_SOMA_REUSE_FLAG_META(X)                \
    X(REUSE_FLAG_STANDARD, "REUSE_FLAG_STANDARD") \
    X(REUSE_FLAG_INTERNAL, "REUSE_FLAG_INTERNAL") \
    X(REUSE_FLAG_NONE, "REUSE_FLAG_NONE")         \
    X(REUSE_FLAG_INVALID, "UNKNOWN")

#define RT_DEVICE_STATE_CALLBACK_TYPE_META(X)                 \
    X(RT_DEVICE_STATE_CALLBACK, "DEVICE_STATE_CALLBACK")      \
    X(RTS_DEVICE_STATE_CALLBACK, "RTS_DEVICE_STATE_CALLBACK") \
    X(DEVICE_CALLBACK_TYPE_MAX, "UNKNOWN")

#define RT_NOTIFY_WAIT_MODE_META(X)                           \
    X(WAIT_LESS_MODE, "WAIT_LESS_MODE")                       \
    X(WAIT_EQUAL_MODE, "WAIT_EQUAL_MODE")                     \
    X(WAIT_BIGGER_MODE, "WAIT_BIGGER_MODE")                   \
    X(WAIT_BIGGER_OR_EQUAL_MODE, "WAIT_BIGGER_OR_EQUAL_MODE") \
    X(WAIT_BITMAP_MODE, "WAIT_BITMAP_MODE")                   \
    X(WAIT_MODE_MAX, "UNKNOWN")

#define RT_COND_TASK_TYPE_META(X)                        \
    X(RT_COND_TASK_TYPE_IF, "COND_TASK_TYPE_IF")         \
    X(RT_COND_TASK_TYPE_WHILE, "COND_TASK_TYPE_WHILE")   \
    X(RT_COND_TASK_TYPE_SWITCH, "COND_TASK_TYPE_SWITCH") \
    X(RT_COND_TASK_TYPE_MAX, "UNKNOWN")

namespace cce {
namespace runtime {

RT_ENUM_STRING_TO_STRING_U32(RtTopicTypeToString, RtTopicType, RT_AICPU_TOPIC_TYPE_META)

RT_ENUM_STRING_TO_STRING_U32(ArgsTypeToString, ArgsType, RT_KERNEL_ARGS_TYPE_META)

RT_ENUM_STRING_IMPL(
    DavidEventStateToString, DavidEventState_t, RT_DAVID_EVENT_STATE_META, RT_ENUM_STRING_SCOPED_CASE, int32_t,
    "UNKNOWN")

RT_ENUM_STRING_TO_STRING_SCOPED(DeviceFaultTypeToString, DeviceFaultType, RT_DEVICE_FAULT_TYPE_META)

RT_ENUM_STRING_IMPL(
    EventStatePeriodToString, EventStatePeriod, RT_EVENT_STATE_PERIOD_META, RT_ENUM_STRING_SCOPED_CASE, uint32_t,
    "UNKNOWN")

RT_ENUM_STRING_TO_STRING(RtFeatureToString, rtFeature, RT_RUNTIME_FEATURE_META)

RT_ENUM_STRING_IMPL(
    H2DCopyPolicyToString, H2DCopyPolicy, RT_H2D_COPY_POLICY_META, RT_ENUM_STRING_CASE, int32_t, "UNKNOWN")

RT_ENUM_STRING_IMPL(
    H2HCopyPolicyToString, H2HCopyPolicy, RT_H2H_COPY_POLICY_META, RT_ENUM_STRING_SCOPED_CASE, uint64_t, "UNKNOWN")

RT_ENUM_STRING_IMPL(
    KernelFunctionEntryTypeToString, KernelFunctionEntryType, RT_KERNEL_FUNCTION_ENTRY_TYPE_META,
    RT_ENUM_STRING_SCOPED_CASE, uint32_t, "UNKNOWN")

RT_ENUM_STRING_TO_STRING_U32(RtMixTypeToString, RtMixType, RT_KERNEL_MIX_TYPE_META)

RT_ENUM_STRING_IMPL(RatioToString, Ratio, RT_KERNEL_RATIO_META, RT_ENUM_STRING_CASE, uint32_t, "UNKNOWN")

RT_ENUM_STRING_TO_STRING(KernelRegisterTypeToString, KernelRegisterType, RT_KERNEL_REGISTER_TYPE_META)

RT_ENUM_STRING_IMPL(
    Driver::ManagedMemFlagToString, Driver::ManagedMemFlag, RT_MANAGED_MEMORY_FLAG_META, RT_ENUM_STRING_SCOPED_CASE,
    int32_t, "UNKNOWN")

RT_ENUM_STRING_TO_STRING_U32(RtMemCopyAsyncDirectToString, rtMemCopyAsyncDirect, RT_MEMCPY_DIRECTION_META)

RT_ENUM_STRING_TO_STRING_U32(TsAicpuKernelTypeToString, tsAicpuKernelType, RT_MODEL_AICPU_KERNEL_TYPE_META)

RT_ENUM_STRING_IMPL(
    RtModelExecutorFlagToString, RtModelExecutorFlag, RT_MODEL_EXECUTOR_TYPE_META, RT_ENUM_STRING_CASE, uint32_t,
    "UNKNOWN")

RT_ENUM_STRING_IMPL(MmtTypeToString, MmtType, RT_MODEL_MAINTENANCE_TYPE_META, RT_ENUM_STRING_CASE, int32_t, "UNKNOWN")

RT_ENUM_STRING_IMPL(
    DumpTypeToString, DumpType, RT_PRINT_DUMP_TYPE_META, RT_ENUM_STRING_SCOPED_CASE, uint32_t, "UNKNOWN")

RT_ENUM_STRING_IMPL(
    RtProfileRecordTypeToString, rtProfileRecordType_t, RT_PROFILE_RECORD_TYPE_META, RT_ENUM_STRING_CASE, uint32_t,
    "UNKNOWN")

RT_ENUM_STRING_IMPL(
    QosMasterTypeToString, QosMasterType, RT_QOS_MASTER_TYPE_META, RT_ENUM_STRING_SCOPED_CASE, uint32_t, "UNKNOWN")

RT_ENUM_STRING_IMPL(
    RtReportPackageTypeToString, rtReportPackageType, RT_REPORT_PACKAGE_TYPE_META, RT_ENUM_STRING_CASE, uint32_t,
    "UNKNOWN")

RT_ENUM_STRING_TO_STRING_SCOPED(ReuseFlagToString, ReuseFlag, RT_SOMA_REUSE_FLAG_META)

RT_ENUM_STRING_TO_STRING_U32(RtStarsSqeIntDirTypeToString, RtStarsSqeIntDirType, RT_STARS_INTERRUPT_DIRECTION_META)

RT_ENUM_STRING_IMPL(
    StreamStateCallbackToString, StreamStateCallback, RT_STREAM_STATE_CALLBACK_TYPE_META, RT_ENUM_STRING_SCOPED_CASE,
    uint32_t, "UNKNOWN")

RT_ENUM_STRING_TO_STRING_SCOPED(StreamSubscribeFlagToString, StreamSubscribeFlag, RT_STREAM_SUBSCRIBE_FLAG_META)

RT_ENUM_STRING_TO_STRING(RtTaskTimeUnitTypeToString, RtTaskTimeUnitType, RT_TASK_TIME_UNIT_META)

RT_ENUM_STRING_TO_STRING_SCOPED(DeviceStateCallbackLogToString, DeviceStateCallback, RT_DEVICE_STATE_CALLBACK_TYPE_META)

RT_ENUM_STRING_TO_STRING_U32(RtCntNotifyWaitModeToString, rtCntNotifyWaitMode_t, RT_NOTIFY_WAIT_MODE_META)

RT_ENUM_STRING_TO_STRING(RtCondTaskTypeToString, rtCondTaskType_t, RT_COND_TASK_TYPE_META)

const char* JettyTypeToString(const JettyType value) noexcept
{
    return (value == JettyType::JETTY_TYPE_MAX) ? "UNKNOWN" : JettyTypeName(value);
}

} // namespace runtime
} // namespace cce

#endif // RUNTIME_ENABLE_ENUM_LOG_NAMES
