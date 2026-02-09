/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __CCE_RUNTIME_INTERNAL_ERROR_DEFINE_HPP__
#define __CCE_RUNTIME_INTERNAL_ERROR_DEFINE_HPP__

#include <stdint.h>

namespace cce {
namespace runtime {
constexpr uint32_t UINT32_BIT_NUM = 32U;
constexpr uint32_t UINT16_BIT_NUM = 16U;
constexpr uint32_t MASK_32_BIT = 0xFFFFFFFFU;
constexpr uint32_t MASK_17_BIT = 0x0001FFFFU;
constexpr uint32_t RT_MAX_STRING_LEN = 512U;
constexpr uint32_t RT_GENERAL_SQE_NUM = 3U;
constexpr uint8_t MEM_WAIT_SQE_NUM = 3U;
constexpr uint8_t MEM_WAIT_V2_SQE_NUM = 3U;

constexpr uint64_t RT_MEMCPYASYNC_SPLIT_SIZE = 67108864UL; // 64*1024*1024
constexpr uint64_t RT_MAX_MEMCPY2D_HEIGHT = 5242880UL; // 5*1024*1024
constexpr uint64_t RT_MAX_MEMCPY2D_WIDTH = 5000000UL;
constexpr uint64_t RT_MS_TO_NS = 1000000UL; // ms to ns
constexpr uint64_t RT_US_TO_MS = 1000UL; // us to ms
constexpr uint64_t RT_MS_PER_S = 1000UL; // 1s = 1000ms
static constexpr uint16_t DEFAULT_MODULEID = 255;
static constexpr uint16_t MODULEID_RUNTIME = 7U;
static constexpr uint32_t INVALID_COPY_MODULEID = 0xFFFFFFFFU;

/**
* @ingroup dvrt_base
* @brief runtime internel error numbers.
*/
constexpr int32_t RT_ERRORCODE_BASE                 = 0x07010000; // minimum inner errcode

constexpr int32_t RT_ERROR_DEVICE_BASE              = 0x07010000;
constexpr int32_t RT_ERROR_DEVICE_NULL              = 0x07010001;
constexpr int32_t RT_ERROR_DEVICE_NEW               = 0x07010002;
constexpr int32_t RT_ERROR_DEVICE_ID                = 0x07010003;
constexpr int32_t RT_ERROR_DEVICE_CHIPTYPE          = 0x07010004;
constexpr int32_t RT_ERROR_DEVICE_DEPLOY            = 0x07010005;
constexpr int32_t RT_ERROR_DEVICE_RETAIN            = 0x07010006;
constexpr int32_t RT_ERROR_DEVICE_PLATFORM          = 0x07010007;
constexpr int32_t RT_ERROR_DEVICE_LOADER            = 0x07010008;
constexpr int32_t RT_ERROR_DEVICE_LIMIT             = 0x07010009;
constexpr int32_t RT_ERROR_DEVICE_PROC_HANG_OUT     = 0x0701000A;
constexpr int32_t RT_ERROR_DEVICE_POWER_UP_FAIL     = 0x0701000B;
constexpr int32_t RT_ERROR_DEVICE_POWER_DOWN_FAIL   = 0x0701000C;
constexpr int32_t RT_ERROR_DEVICE_INVALID           = 0x0701000D;
constexpr int32_t RT_ERROR_DEVICE_RINGBUFFER_NOT_INIT  = 0x0701000E;
constexpr int32_t RT_ERROR_DEVICE_RINGBUFFER_NO_DATA   = 0x0701000F;
constexpr int32_t RT_ERROR_DEVICE_TASK_ABORT           = 0x07010010;
constexpr int32_t RT_ERROR_DEVICE_ABORT_SEND_TASK_FAIL = 0x07010011;
constexpr int32_t RT_ERROR_DEVICE_ABORT_SYNC_TASK_FAIL = 0x07010012;

constexpr int32_t RT_ERROR_DRV_BASE                 = 0x07020000;
constexpr int32_t RT_ERROR_DRV_NULL                 = 0x07020001;
constexpr int32_t RT_ERROR_DRV_NEW                  = 0x07020002;
constexpr int32_t RT_ERROR_DRV_MEMORY               = 0x07020003;
constexpr int32_t RT_ERROR_DRV_INPUT                = 0x07020004;
constexpr int32_t RT_ERROR_DRV_PTRNULL              = 0x07020005;
constexpr int32_t RT_ERROR_DRV_OPEN_AICPU           = 0x07020006;
constexpr int32_t RT_ERROR_DRV_CLOSE_AICPU          = 0x07020007;
constexpr int32_t RT_ERROR_DRV_SYM_AICPU            = 0x07020008;
constexpr int32_t RT_ERROR_DRV_OPEN_TSD             = 0x07020009;
constexpr int32_t RT_ERROR_DRV_CLOSE_TSD            = 0x0702000A;
constexpr int32_t RT_ERROR_DRV_SYM_TSD              = 0x0702000B;
constexpr int32_t RT_ERROR_DRV_SOURCE               = 0x0702000C;
constexpr int32_t RT_ERROR_DRV_REPORT               = 0x0702000D;
constexpr int32_t RT_ERROR_DRV_COMMAND              = 0x0702000E;
constexpr int32_t RT_ERROR_DRV_OCCUPY               = 0x0702000F;
constexpr int32_t RT_ERROR_DRV_ERR                  = 0x07020010;
constexpr int32_t RT_ERROR_DRV_TSD_ERR              = 0x07020011;
constexpr int32_t RT_ERROR_DRV_NO_DEVICE            = 0x07020012;
constexpr int32_t RT_ERROR_DRV_INVALID_DEVICE       = 0x07020013;
constexpr int32_t RT_ERROR_DRV_INVALID_HANDLE       = 0x07020014;
constexpr int32_t RT_ERROR_DRV_INVALID_MALLOC_TYPE  = 0x07020015;
constexpr int32_t RT_ERROR_DRV_OUT_MEMORY           = 0x07020016;
constexpr int32_t RT_ERROR_DRV_MALLOC_FAIL          = 0x07020017;
constexpr int32_t RT_ERROR_DRV_OPER_NOT_PERMITTED   = 0x07020018;
constexpr int32_t RT_ERROR_DRV_NO_EVENT_RESOURCES   = 0x07020019;
constexpr int32_t RT_ERROR_DRV_NO_STREAM_RESOURCES  = 0x0702001A;
constexpr int32_t RT_ERROR_DRV_NO_NOTIFY_RESOURCES  = 0x0702001B;
constexpr int32_t RT_ERROR_DRV_NO_MODEL_RESOURCES   = 0x0702001C;
constexpr int32_t RT_ERROR_DRV_NOT_SUPPORT          = 0x0702001D;
constexpr int32_t RT_ERROR_DRV_OVER_LIMIT           = 0x0702001E;
constexpr int32_t RT_ERROR_DRV_QUEUE_EMPTY          = 0x0702001F;
constexpr int32_t RT_ERROR_DRV_QUEUE_FULL           = 0x07020020;
constexpr int32_t RT_ERROR_DRV_REPEATED_INIT        = 0x07020021;
constexpr int32_t RT_ERROR_DRV_IOCTRL               = 0x07020022;
constexpr int32_t RT_ERROR_DRV_NO_RESOURCES         = 0x07020023;
constexpr int32_t RT_ERROR_DRV_COPY_USER_FAIL       = 0x07020024;
constexpr int32_t RT_ERROR_DRV_MEMORY_OPT_FAIL      = 0x07020025;
constexpr int32_t RT_ERROR_DRV_NOT_SUPPORT_UPDATE_OP = 0x07020026;
constexpr int32_t RT_ERROR_DEVICE_MEM_ERROR         = 0x07010026;
constexpr int32_t RT_ERROR_SDMA_POISON_ERROR        = 0x07010027;
constexpr int32_t RT_ERROR_MEM_RAS_ERROR            = 0x07010028;
constexpr int32_t RT_ERROR_DCACHE_MEM_ALLOC_FAIL    = 0x07010029;
constexpr int32_t RT_ERROR_SUSPECT_DEVICE_MEM_ERROR = 0x0701002A;
constexpr int32_t RT_ERROR_SUSPECT_REMOTE_ERROR     = 0x0701002B;
constexpr int32_t RT_ERROR_DEVICE_AICORE_ERROR_SW   = 0x0701002C;
constexpr int32_t RT_ERROR_DEVICE_AICORE_ERROR_HW_L = 0x0701002D;
constexpr int32_t RT_ERROR_DEVICE_SQCQ_POOL_RESOURCE_FULL = 0x0701002E;
constexpr int32_t RT_ERROR_LOCAL_MEM_ERROR          = 0x0701002F;
constexpr int32_t RT_ERROR_REMOTE_MEM_ERROR         = 0x07010030;
constexpr int32_t RT_ERROR_CCU_HCCL_MEM_ERROR       = 0x07010031;
constexpr int32_t RT_ERROR_CCU_HCCL_REMOTE_ERROR    = 0x07010032;
constexpr int32_t RT_ERROR_DEVICE_LINK_ERROR = 0x07010033;

constexpr int32_t RT_ERROR_STREAM_BASE              = 0x07030000;
constexpr int32_t RT_ERROR_STREAM_NULL              = 0x07030001;
constexpr int32_t RT_ERROR_STREAM_NEW               = 0x07030002;
constexpr int32_t RT_ERROR_STREAM_CONTEXT           = 0x07030003;
constexpr int32_t RT_ERROR_STREAM_INVALID           = 0x07030004;
constexpr int32_t RT_ERROR_STREAM_MODEL             = 0x07030005;
constexpr int32_t RT_ERROR_STREAM_FUSION            = 0x07030006;
constexpr int32_t RT_ERROR_STREAM_FULL              = 0x07030007;
constexpr int32_t RT_ERROR_STREAM_EMPTY             = 0x07030008;
constexpr int32_t RT_ERROR_STREAM_NOT_COMPLETE      = 0x07030009;
constexpr int32_t RT_ERROR_STREAM_SYNC              = 0x0703000A;
constexpr int32_t RT_ERROR_STREAM_NO_CB_REG         = 0x0703000B;
constexpr int32_t RT_ERROR_STREAM_DUPLICATE         = 0x0703000C;
constexpr int32_t RT_ERROR_STREAM_NOT_EXIST         = 0x0703000D;
constexpr int32_t RT_ERROR_SQ_NO_EXIST_SQ_TO_REUSE  = 0x0703000E;
constexpr int32_t RT_ERROR_SQID_FULL                = 0x0703000F;
constexpr int32_t RT_ERROR_STREAM_SYNC_TIMEOUT      = 0x07030010;
constexpr int32_t RT_ERROR_DVPP_GRP_NEW             = 0x07030011;
constexpr int32_t RT_ERROR_STREAM_BIND_GRP          = 0x07030012;
constexpr int32_t RT_ERROR_REMOTE_SQID_DUPLICATE    = 0x07030013;
constexpr int32_t RT_ERROR_STREAM_REUSE_LIMIT_MODEL_NUM = 0x07030014;
constexpr int32_t RT_ERROR_STREAM_ABORT             = 0x07030015;
constexpr int32_t RT_ERROR_STREAM_ABORT_SEND_TASK_FAIL = 0x07030016;
constexpr int32_t RT_ERROR_STREAM_ABORT_SYNC_TASK_FAIL = 0x07030017;
constexpr int32_t RT_ERROR_STREAM_CAPTURE_EXIT         = 0x07030018;
constexpr int32_t RT_ERROR_STREAM_CAPTURED             = 0x07030019;
constexpr int32_t RT_ERROR_STREAM_CAPTURE_INVALIDATED  = 0x0703001A;
constexpr int32_t RT_ERROR_STREAM_NOT_CAPTURED         = 0x0703001B;
constexpr int32_t RT_ERROR_STREAM_CAPTURE_MODE_NOT_SUPPORT = 0x0703001C;
constexpr int32_t RT_ERROR_STREAM_CAPTURE_IMPLICIT  = 0x0703001D;
constexpr int32_t RT_ERROR_STREAM_AICPU_ALLOC_FAIL  = 0x0703001E;
constexpr int32_t RT_ERROR_STREAM_UNJOINED          = 0x0703001F;
constexpr int32_t RT_ERROR_STREAM_CAPTURE_CONFLICT  = 0x07030020;
constexpr int32_t RT_ERROR_STREAM_TASKGRP_STATUS    = 0x07030021;
constexpr int32_t RT_ERROR_STREAM_TASKGRP_NULL      = 0x07030022;
constexpr int32_t RT_ERROR_STREAM_TASKGRP_INTR      = 0x07030023;
constexpr int32_t RT_ERROR_STREAM_TASKGRP_UPDATE    = 0x07030024;
constexpr int32_t RT_ERROR_STREAM_CAPTURE_UNMATCHED = 0x07030025;
constexpr int32_t RT_ERROR_STREAM_CAPTURE_WRONG_THREAD = 0x07030026;

constexpr int32_t RT_ERROR_MODEL_BASE               = 0x07040000;
constexpr int32_t RT_ERROR_MODEL_NULL               = 0x07040001;
constexpr int32_t RT_ERROR_MODEL_NEW                = 0x07040002;
constexpr int32_t RT_ERROR_MODEL_CONTEXT            = 0x07040003;
constexpr int32_t RT_ERROR_MODEL_ENDGRAPH           = 0x07040004;
constexpr int32_t RT_ERROR_MODEL_STREAM             = 0x07040005;
constexpr int32_t RT_ERROR_MODEL_EXECUTOR            = 0x07040006;
constexpr int32_t RT_ERROR_MODEL_SETUP              = 0x07040007;
constexpr int32_t RT_ERROR_MODEL_ID                 = 0x07040008;
constexpr int32_t RT_ERROR_MODEL_EXE_FAILED         = 0x07040009;
constexpr int32_t RT_ERROR_END_OF_SEQUENCE          = 0x0704000A;  // end of sequence
constexpr int32_t RT_ERROR_MODEL_EXIT               = 0x0704000B;
constexpr int32_t RT_ERROR_MODEL_EXIT_STREAM_UNBIND = 0x0704000C;
constexpr int32_t RT_ERROR_MODEL_EXIT_ID            = 0x0704000D;
constexpr int32_t RT_ERROR_MODEL_ABORT_NORMAL       = 0x0704000E;
constexpr int32_t RT_ERROR_MODEL_NOT_END            = 0x0704000F;
constexpr int32_t RT_ERROR_MODEL_CAPTURED           = 0x07040010;
constexpr int32_t RT_ERROR_MODEL_CAPTURE_STATUS     = 0x07040011;
constexpr int32_t RT_ERROR_MODEL_RUNNING            = 0x07040012;
constexpr int32_t RT_ERROR_MODEL_OP_CACHE_CLOSED    = 0x07040013;

constexpr int32_t RT_ERROR_EVENT_BASE               = 0x07050000;
constexpr int32_t RT_ERROR_EVENT_NULL               = 0x07050001;
constexpr int32_t RT_ERROR_EVENT_NEW                = 0x07050002;
constexpr int32_t RT_ERROR_EVENT_RECORDER_NULL      = 0x07050003;
constexpr int32_t RT_ERROR_EVENT_TIMESTAMP_INVALID  = 0x07050004;
constexpr int32_t RT_ERROR_EVENT_TIMESTAMP_REVERSAL = 0x07050005;
constexpr int32_t RT_ERROR_EVENT_NOT_COMPLETE       = 0x07050006;
constexpr int32_t RT_ERROR_EVENT_SYNC_TIMEOUT       = 0x07050007;
constexpr int32_t RT_ERROR_EVENT_CAPTURED           = 0x07050008;
constexpr int32_t RT_ERROR_CAPTURE_DEPENDENCY       = 0x07050009;
constexpr int32_t RT_ERROR_STREAM_CAPTURE_ISOLATION = 0x0705000A;

constexpr int32_t RT_ERROR_NOTIFY_BASE              = 0x07060000;
constexpr int32_t RT_ERROR_NOTIFY_NULL              = 0x07060001;
constexpr int32_t RT_ERROR_NOTIFY_NEW               = 0x07060002;
constexpr int32_t RT_ERROR_NOTIFY_TYPE              = 0x07060003;
constexpr int32_t RT_ERROR_NOTIFY_NOT_COMPLETE      = 0x07060004;

constexpr int32_t RT_ERROR_CONTEXT_BASE             = 0x07070000;
constexpr int32_t RT_ERROR_CONTEXT_NULL             = 0x07070001;
constexpr int32_t RT_ERROR_CONTEXT_NEW              = 0x07070002;
constexpr int32_t RT_ERROR_CONTEXT_DEL              = 0x07070003;
constexpr int32_t RT_ERROR_CONTEXT_DEFAULT_STREAM_NULL = 0x07070004;
constexpr int32_t RT_ERROR_CONTEXT_ONLINE_STREAM_NULL  = 0x07070005;
constexpr int32_t RT_ERROR_CONTEXT_ABORT_ON_FAILURE    = 0x07070006;
constexpr int32_t RT_ERROR_CONTEXT_MODE             = 0x07070007;

constexpr int32_t RT_ERROR_KERNEL_BASE              = 0x07080000;
constexpr int32_t RT_ERROR_KERNEL_NULL              = 0x07080001;
constexpr int32_t RT_ERROR_KERNEL_NEW               = 0x07080002;
constexpr int32_t RT_ERROR_KERNEL_LOOKUP            = 0x07080003;
constexpr int32_t RT_ERROR_KERNEL_NAME              = 0x07080004;
constexpr int32_t RT_ERROR_KERNEL_TYPE              = 0x07080005;
constexpr int32_t RT_ERROR_KERNEL_OFFSET            = 0x07080006;
constexpr int32_t RT_ERROR_KERNEL_DUPLICATE         = 0x07080007;
constexpr int32_t RT_ERROR_KERNEL_UNREGISTERING     = 0x07080008;
constexpr int32_t RT_ERROR_KERNEL_INVALID           = 0x07080009;

constexpr int32_t RT_ERROR_PROGRAM_BASE             = 0x07090000;
constexpr int32_t RT_ERROR_PROGRAM_NULL             = 0x07090001;
constexpr int32_t RT_ERROR_PROGRAM_NEW              = 0x07090002;
constexpr int32_t RT_ERROR_PROGRAM_DATA             = 0x07090003;
constexpr int32_t RT_ERROR_PROGRAM_SIZE             = 0x07090004;
constexpr int32_t RT_ERROR_PROGRAM_MEM_TYPE         = 0x07090005;
constexpr int32_t RT_ERROR_PROGRAM_MACHINE_TYPE     = 0x07090006;
constexpr int32_t RT_ERROR_PROGRAM_USEOUT           = 0x07090007;

constexpr int32_t RT_ERROR_MODULE_BASE              = 0x070A0000;
constexpr int32_t RT_ERROR_MODULE_NULL              = 0x070A0001;
constexpr int32_t RT_ERROR_MODULE_NEW               = 0x070A0002;

constexpr int32_t RT_ERROR_INSTANCE_BASE            = 0x070B0000;
constexpr int32_t RT_ERROR_INSTANCE_NULL            = 0x070B0001;
constexpr int32_t RT_ERROR_INSTANCE_NEW             = 0x070B0002;
constexpr int32_t RT_ERROR_INSTANCE_VERSION         = 0x070B0003;

constexpr int32_t RT_ERROR_API_BASE                 = 0x070C0000;
constexpr int32_t RT_ERROR_API_NULL                 = 0x070C0001;
constexpr int32_t RT_ERROR_API_NEW                  = 0x070C0002;

constexpr int32_t RT_ERROR_DATADUMP_BASE            = 0x070D0000;
constexpr int32_t RT_ERROR_DATADUMP_NULL            = 0x070D0001;
constexpr int32_t RT_ERROR_DATADUMP_NEW             = 0x070D0002;
constexpr int32_t RT_ERROR_DATADUMP_TIME            = 0x070D0003;
constexpr int32_t RT_ERROR_DATADUMP_FILE            = 0x070D0004;
constexpr int32_t RT_ERROR_DATADUMP_ADDRESS         = 0x070D0005;
constexpr int32_t RT_ERROR_DATADUMP_LOAD_FAILED     = 0x070D0006;
constexpr int32_t RT_ERROR_DUMP_ADDR_SET_FAILED     = 0x070D0007;

constexpr int32_t RT_ERROR_PROF_BASE                = 0x070E0000;
constexpr int32_t RT_ERROR_PROF_NULL                = 0x070E0001;
constexpr int32_t RT_ERROR_PROF_NEW                 = 0x070E0002;
constexpr int32_t RT_ERROR_PROF_START               = 0x070E0003;
constexpr int32_t RT_ERROR_PROF_DEVICE_MEM          = 0x070E0004;
constexpr int32_t RT_ERROR_PROF_HOST_MEM            = 0x070E0005;
constexpr int32_t RT_ERROR_PROF_SET_DIR             = 0x070E0006;
constexpr int32_t RT_ERROR_PROF_OPER                = 0x070E0007;
constexpr int32_t RT_ERROR_PROF_FULL                = 0x070E0008;
constexpr int32_t RT_ERROR_PROF_NAME                = 0x070E0009;
constexpr int32_t RT_ERROR_PROF_STATUS              = 0x070E000A;
constexpr int32_t RT_ERROR_PROF_FIND_FAIL           = 0x070E000B;

constexpr int32_t RT_ERROR_PCTRACE_BASE             = 0x070F0000;
constexpr int32_t RT_ERROR_PCTRACE_NULL             = 0x070F0001;
constexpr int32_t RT_ERROR_PCTRACE_NEW              = 0x070F0002;
constexpr int32_t RT_ERROR_PCTRACE_TIME             = 0x070F0003;
constexpr int32_t RT_ERROR_PCTRACE_FILE             = 0x070F0004;

constexpr int32_t RT_ERROR_TASK_BASE                = 0x07100000;
constexpr int32_t RT_ERROR_TASK_NULL                = 0x07100001;
constexpr int32_t RT_ERROR_TASK_NEW                 = 0x07100002;
constexpr int32_t RT_ERROR_TASK_NOT_SUPPORT         = 0x07100003;
constexpr int32_t RT_ERROR_TASK_ALLOCATOR           = 0x07100004;
constexpr int32_t RT_ERROR_TASK_MONITOR             = 0x07100005;
constexpr int32_t RT_ERROR_TASK_ID_ALLOCATION       = 0x07100006;
constexpr int32_t RT_ERROR_TASK_ID_INVALID          = 0x07100007;
constexpr int32_t RT_ERROR_TASK_OUT_OF_RANGE        = 0x07100008;

constexpr int32_t RT_ERROR_COMMON_BASE              = 0x07110000;
constexpr int32_t RT_ERROR_INVALID_VALUE            = 0x07110001; // RT_ERROR_INPUT_INVALID
constexpr int32_t RT_ERROR_MEMORY_ADDRESS_UNALIGNED = 0x07110002;
constexpr int32_t RT_ERROR_SEC_HANDLE               = 0x07110003;
constexpr int32_t RT_ERROR_OS_HANDLE                = 0x07110004;
constexpr int32_t RT_ERROR_MUTEX_LOCK               = 0x07110005;
constexpr int32_t RT_ERROR_MUTEX_UNLOCK             = 0x07110006;
constexpr int32_t RT_ERROR_CALLOC                   = 0x07110007;
constexpr int32_t RT_ERROR_POOL_RESOURCE            = 0x07110008;
constexpr int32_t RT_ERROR_TRANS_ARGS               = 0x07110009;
constexpr int32_t RT_ERROR_METADATA                 = 0x0711000A;
constexpr int32_t RT_ERROR_LOST_HEARTBEAT           = 0x0711000B;
constexpr int32_t RT_ERROR_REPORT_TIMEOUT           = 0x0711000C;
constexpr int32_t RT_ERROR_FEATURE_NOT_SUPPORT      = 0x0711000D;
constexpr int32_t RT_ERROR_MEMORY_ALLOCATION        = 0x0711000E;
constexpr int32_t RT_ERROR_MEMORY_FREE              = 0x0711000F;
constexpr int32_t RT_ERROR_INVALID_MEMORY_TYPE      = 0x07110010;
constexpr int32_t RT_ERROR_SOCKET_CLOSE             = 0x07110011;
constexpr int32_t RT_ERROR_DEVICE_OOM               = 0x07110012;
constexpr int32_t RT_ERROR_SEND_MSG                 = 0x07110013;
constexpr int32_t RT_ERROR_NOT_SET_SYSPARAMOPT      = 0x07110014;

constexpr int32_t RT_ERROR_DEBUG_BASE               = 0x07120000;
constexpr int32_t RT_ERROR_DEBUG_NULL               = 0x07120001;
constexpr int32_t RT_ERROR_DEBUG_NEW                = 0x07120002;
constexpr int32_t RT_ERROR_DEBUG_SIGNAL             = 0x07120003;
constexpr int32_t RT_ERROR_DEBUG_OPEN               = 0x07120004;
constexpr int32_t RT_ERROR_DEBUG_WRITE              = 0x07120005;
constexpr int32_t RT_ERROR_DEBUG_REGISTER_FAILED    = 0x07120006;
constexpr int32_t RT_ERROR_DEBUG_UNREGISTER_FAILED  = 0x07120007;

constexpr int32_t RT_ERROR_ENGINE_BASE              = 0x07130000;
constexpr int32_t RT_ERROR_ENGINE_NULL              = 0x07130001;
constexpr int32_t RT_ERROR_ENGINE_NEW               = 0x07130002;
constexpr int32_t RT_ERROR_ENGINE_THREAD            = 0x07130003;

constexpr int32_t RT_ERROR_LABEL_BASE               = 0x07140000;
constexpr int32_t RT_ERROR_LABEL_NULL               = 0x07140001;
constexpr int32_t RT_ERROR_LABEL_NEW                = 0x07140002;
constexpr int32_t RT_ERROR_LABEL_CONTEXT            = 0x07140003;
constexpr int32_t RT_ERROR_LABEL_STREAM             = 0x07140004;
constexpr int32_t RT_ERROR_LABEL_MODEL              = 0x07140005;
constexpr int32_t RT_ERROR_LABEL_ALLOCATOR          = 0x07140006;
constexpr int32_t RT_ERROR_LABEL_FREE               = 0x07140007;
constexpr int32_t RT_ERROR_LABEL_SET                = 0x07140008;
constexpr int32_t RT_ERROR_LABEL_ID                 = 0x07140009;
constexpr int32_t RT_ERROR_LABEL_MODEL_RELEASED     = 0x0714000A;
constexpr int32_t RT_ERROR_SAME_LABELS_IN_SWITCH    = 0x0714000B;
constexpr int32_t RT_ERROR_LABEL_PHY_ADDR_NULL      = 0x0714000C;

constexpr int32_t RT_ERROR_TSFW_BASE                                    = 0x07150000;
constexpr int32_t RT_ERROR_TSFW_UNKNOWN                                 = 0x07150001;
constexpr int32_t RT_ERROR_TSFW_NULL_PTR                                = 0x07150002;
constexpr int32_t RT_ERROR_TSFW_ILLEGAL_AI_CORE_ID                      = 0x07150003;
constexpr int32_t RT_ERROR_TSFW_ILLEGAL_PARAM                           = 0x07150004;
constexpr int32_t RT_ERROR_TSFW_TASK_CMD_QUEUE_FULL                     = 0x07150005;
constexpr int32_t RT_ERROR_TSFW_TASK_CMD_QUEUE_EMPTY                    = 0x07150006;
constexpr int32_t RT_ERROR_TSFW_TASK_REPORT_QUEUE_FULL                  = 0x07150007;
constexpr int32_t RT_ERROR_TSFW_TASK_REPORT_QUEUE_EMPTY                 = 0x07150008;
constexpr int32_t RT_ERROR_TSFW_TASK_NODE_BUFF_ALL_OCCUPIED             = 0x07150009;
constexpr int32_t RT_ERROR_TSFW_TASK_NODE_BUFF_ALL_FREED                = 0x0715000A;
constexpr int32_t RT_ERROR_TSFW_L2_MEM_INSUFFICIENT_SPACE               = 0x0715000B;
constexpr int32_t RT_ERROR_TSFW_L2_MALLOC_FAILED                        = 0x0715000C;
constexpr int32_t RT_ERROR_TSFW_DMA_CHANNEL_ALL_OCCUPIED                = 0x0715000D;
constexpr int32_t RT_ERROR_TSFW_MEMCPY_OP_FAILED                        = 0x0715000E;
constexpr int32_t RT_ERROR_TSFW_BS_SLOT_ALL_OCCUPIED                    = 0x0715000F;
constexpr int32_t RT_ERROR_TSFW_TBS_SLOT_REPEAT_FREE                    = 0x07150010;
constexpr int32_t RT_ERROR_TSFW_PRIORITY_TASK_LIST_FULL                 = 0x07150011;
constexpr int32_t RT_ERROR_TSFW_PRIORITY_TASK_LIST_EMPTY                = 0x07150012;
constexpr int32_t RT_ERROR_TSFW_NO_STREAM_LIST_NEED_TO_BE_PROCESSED     = 0x07150013;
constexpr int32_t RT_ERROR_TSFW_REPEAT_MARK_STREAM_NEED_SERVICE         = 0x07150014;
constexpr int32_t RT_ERROR_TSFW_SYS_DMA_CHANNEL_ALL_OCCUPIED          = 0x07150015;
constexpr int32_t RT_ERROR_TSFW_NO_HBML2TASKNODE_FOUND                  = 0x07150016;
constexpr int32_t RT_ERROR_TSFW_SQNODE_NODE_SLOT_ALL_OCCUPIED         = 0x07150017;
constexpr int32_t RT_ERROR_TSFW_CQNODE_NODE_SLOT_ALL_OCCUPIED         = 0x07150018;
constexpr int32_t RT_ERROR_TSFW_SQNODE_NOT_ENOUGH                       = 0x07150019;
constexpr int32_t RT_ERROR_TSFW_SQNODE_SLOT_REPEAT_FREE                 = 0x0715001A;
constexpr int32_t RT_ERROR_TSFW_CQNODE_SLOT_REPEAT_FREE                 = 0x0715001B;
constexpr int32_t RT_ERROR_TSFW_CQ_REPORT_FAILED                        = 0x0715001C;
constexpr int32_t RT_ERROR_TSFW_SYS_DMA_RESET_SUCCESS                   = 0x0715001D;
constexpr int32_t RT_ERROR_TSFW_SYS_DMA_RESET_FAILED                    = 0x0715001E;
constexpr int32_t RT_ERROR_TSFW_SYS_DMA_TRNSFER_FAILED                  = 0x0715001F;
constexpr int32_t RT_ERROR_TSFW_SYS_DMA_MEMADDRALIGN_FAILED             = 0x07150020;
constexpr int32_t RT_ERROR_TSFW_SYS_DMA_ERROR_QUEUE_FULL                = 0x07150021;
constexpr int32_t RT_ERROR_TSFW_SYS_DMA_ERROR_QUEUE_EMPTY               = 0x07150022;
constexpr int32_t RT_ERROR_TSFW_TIMER_EVENT_FULL                        = 0x07150023;
constexpr int32_t RT_ERROR_TSFW_TASK_L2_DESC_ENTRY_NOT_ENOUGH           = 0x07150024;
constexpr int32_t RT_ERROR_TSFW_AICORE_TIMEOUT                          = 0x07150025;
constexpr int32_t RT_ERROR_TSFW_AICORE_EXCEPTION                        = 0x07150026;
constexpr int32_t RT_ERROR_TSFW_AICORE_TRAP_EXCEPTION                   = 0x07150027;
constexpr int32_t RT_ERROR_TSFW_AICPU_TIMEOUT                           = 0x07150028;
constexpr int32_t RT_ERROR_TSFW_SDMA_L2_TO_DDR_MALLOC_FAIL              = 0x07150029;
constexpr int32_t RT_ERROR_TSFW_AICPU_EXCEPTION                         = 0x0715002A;
constexpr int32_t RT_ERROR_TSFW_AICPU_DATADUMP_RSP_ERR                  = 0x0715002B;
constexpr int32_t RT_ERROR_TSFW_AICPU_MODEL_RSP_ERR                     = 0x0715002C;
constexpr int32_t RT_ERROR_TSFW_REPEAT_ACTIVE_MODEL_STREAM              = 0x0715002D;
constexpr int32_t RT_ERROR_TSFW_REPEAT_NOTIFY_WAIT                      = 0x0715002E;
constexpr int32_t RT_ERROR_TSFW_DEBUG_INVALID_SQCQ                      = 0x0715002F;
constexpr int32_t RT_ERROR_TSFW_DEBUG_WRONG_COMMAND_TYPE                = 0x07150030;
constexpr int32_t RT_ERROR_TSFW_DEBUG_CMD_PROCESS                       = 0x07150031;
constexpr int32_t RT_ERROR_TSFW_DEBUG_INVALID_DEVICE_STATUS             = 0x07150032;
constexpr int32_t RT_ERROR_TSFW_DEBUG_NOT_IN_DEBUG_STATUS               = 0x07150033;
constexpr int32_t RT_ERROR_TSFW_DEBUG_INVALID_TASK_STATUS               = 0x07150034;
constexpr int32_t RT_ERROR_TSFW_DEBUG_TASK_EMPTY                        = 0x07150035;
constexpr int32_t RT_ERROR_TSFW_DEBUG_TASK_FULL                         = 0x07150036;
constexpr int32_t RT_ERROR_TSFW_DEBUG_TASK_NOT_EXIST                    = 0x07150037;
constexpr int32_t RT_ERROR_TSFW_DEBUG_AI_CORE_FULL                      = 0x07150038;
constexpr int32_t RT_ERROR_TSFW_DEBUG_AI_CORE_NOT_EXIST                 = 0x07150039;
constexpr int32_t RT_ERROR_TSFW_DEBUG_AI_CORE_EXCEPTION                 = 0x0715003A;
constexpr int32_t RT_ERROR_TSFW_DEBUG_AI_CORE_TIMEOUT                   = 0x0715003B;
constexpr int32_t RT_ERROR_TSFW_DEBUG_BREAKPOINT_FULL                   = 0x0715003C;
constexpr int32_t RT_ERROR_TSFW_DEBUG_READ_ERROR                        = 0x0715003D;
constexpr int32_t RT_ERROR_TSFW_DEBUG_WRITE_FAIL                        = 0x0715003E;
constexpr int32_t RT_ERROR_TSFW_QUEUE_FULL                              = 0x0715003F;
constexpr int32_t RT_ERROR_TSFW_QUEUE_EMPTY                             = 0x07150040;
constexpr int32_t RT_ERROR_TSFW_QUEUE_ALLOC_MEM_FAIL                    = 0x07150041;
constexpr int32_t RT_ERROR_TSFW_QUEUE_DATA_SIZE_UNMATCH                 = 0x07150042;
constexpr int32_t RT_ERROR_TSFW_PCIE_DMA_INVLD_CPY_TYPE                 = 0x07150043;
constexpr int32_t RT_ERROR_TSFW_INVLD_CPY_DIR                           = 0x07150044;
constexpr int32_t RT_ERROR_TSFW_PCIE_DMA_INVLD_CQ_DES                   = 0x07150045;
constexpr int32_t RT_ERROR_TSFW_PCIE_DMA_CPY_ERR                        = 0x07150046;
constexpr int32_t RT_ERROR_TSFW_PCIE_DMA_LNK_CHN_BUSY                   = 0x07150047;
constexpr int32_t RT_ERROR_TSFW_PROFILE_BUFF_FULL                       = 0x07150048;
constexpr int32_t RT_ERROR_TSFW_PROFILE_MODE_CONFLICT                   = 0x07150049;
constexpr int32_t RT_ERROR_TSFW_PROFILE_OTHER_PID_ON                    = 0x0715004A;
constexpr int32_t RT_ERROR_TSFW_SCHD_AIC_TASK_PRELOAD_FAILED            = 0x0715004B;
constexpr int32_t RT_ERROR_TSFW_TSCPU_CLOSE_FAILED                      = 0x0715004C;
constexpr int32_t RT_ERROR_TSFW_EXPECT_FAIL                             = 0x0715004D;
constexpr int32_t RT_ERROR_TSFW_REPEAT_MODEL_STREAM                     = 0x0715004E;
constexpr int32_t RT_ERROR_TSFW_STREAM_MODEL_UNBIND                     = 0x0715004F;
constexpr int32_t RT_ERROR_TSFW_MODEL_EXE_FAILED                        = 0x07150050;
constexpr int32_t RT_ERROR_TSFW_IPC_SEND_FAILED                         = 0x07150051;
constexpr int32_t RT_ERROR_TSFW_IPC_PROC_REG_FAILED                     = 0x07150052;
constexpr int32_t RT_ERROR_TSFW_STREAM_FULL                             = 0x07150053;
constexpr int32_t RT_ERROR_TSFW_END_OF_SEQUENCE                         = 0x07150054;
constexpr int32_t RT_ERROR_TSFW_SWITCH_STREAM_LABEL                     = 0x07150055;
constexpr int32_t RT_ERROR_TSFW_TRANS_SQE_FAIL                          = 0x07150056;
constexpr int32_t RT_ERROR_TSFW_TASK_EXCEPTION                          = 0x07150057;
constexpr int32_t RT_ERROR_TSFW_TASK_TRAP                               = 0x07150058;
constexpr int32_t RT_ERROR_TSFW_TASK_TIMEOUT                            = 0x07150059;
constexpr int32_t RT_ERROR_TSFW_TASK_SQE_ERROR                          = 0x0715005A;
constexpr int32_t RT_ERROR_TSFW_AICORE_OVER_FLOW_FAIL                   = 0x0715005B;
constexpr int32_t RT_ERROR_TSFW_VF_SLOT_ALLOC_FAIL                      = 0x0715005C;
constexpr int32_t RT_ERROR_TSFW_VECTOR_CORE_TIMEOUT                     = 0x0715005D;
constexpr int32_t RT_ERROR_TSFW_VECTOR_CORE_EXCEPTION                   = 0x0715005E;
constexpr int32_t RT_ERROR_TSFW_VECTOR_CORE_TRAP_EXCEPTION              = 0x0715005F;
constexpr int32_t RT_ERROR_TSFW_DEBUG_REGISTER_CONFLICT                 = 0x07150060;
constexpr int32_t RT_ERROR_TSFW_AIVEC_OVER_FLOW_FAIL                    = 0x07150061;
constexpr int32_t RT_ERROR_TSFW_RESERVED                                = 0x07150062;
constexpr int32_t RT_ERROR_TSFW_SDMA_COPY_ERROR                         = 0x07150063;
constexpr int32_t RT_ERROR_TSFW_SDMA_REDUCE_ERROR                       = 0x07150064;
constexpr int32_t RT_ERROR_TSFW_AICPU_OVER_FLOW_FAIL                    = 0x07150065;
constexpr int32_t RT_ERROR_TSFW_SDMA_OVER_FLOW_FAIL                     = 0x07150066;
constexpr int32_t RT_ERROR_TSFW_AIC_TRAP_RD_OVERFLOW                    = 0x07150067;
constexpr int32_t RT_ERROR_TSFW_AIC_TRAP_WR_OVERFLOW                    = 0x07150068;
constexpr int32_t RT_ERROR_TSFW_AIV_TRAP_RD_OVERFLOW                    = 0x07150069;
constexpr int32_t RT_ERROR_TSFW_AIV_TRAP_WR_OVERFLOW                    = 0x0715006A;
constexpr int32_t RT_ERROR_TSFW_FFTS_PLUS_TIMEOUT                       = 0x0715006B;
constexpr int32_t RT_ERROR_TSFW_FFTS_PLUS_EXCEPTION                     = 0x0715006C;
constexpr int32_t RT_ERROR_TSFW_FFTS_PLUS_TRAP_EXCEPTION                = 0x0715006D;
constexpr int32_t RT_ERROR_TSFW_TS_CLOSED                               = 0x0715006E;
constexpr int32_t RT_ERROR_TSFW_AICPU_INFO_LOAD_RSP_ERR                 = 0x0715006F;
constexpr int32_t RT_ERROR_TSFW_TASK_BUS_ERROR                          = 0x07150070;
constexpr int32_t RT_ERROR_TSFW_TASK_RES_CONFLICT_ERROR                 = 0x07150071;
constexpr int32_t RT_ERROR_TSFW_TASK_SW_STATUS_ERROR                    = 0x07150072;
constexpr int32_t RT_ERROR_TSFW_TASK_ABORT_STOP                         = 0x07150073;

constexpr int32_t RT_ERROR_SUBSCRIBE_BASE                               = 0x07160000;
constexpr int32_t RT_ERROR_SUBSCRIBE_NULL                               = 0x07160001;
constexpr int32_t RT_ERROR_SUBSCRIBE_NEW                                = 0x07160002;
constexpr int32_t RT_ERROR_SUBSCRIBE_STREAM                             = 0x07160003;
constexpr int32_t RT_ERROR_SUBSCRIBE_THREAD                             = 0x07160004;
constexpr int32_t RT_ERROR_SUBSCRIBE_GROUP                              = 0x07160005;

constexpr int32_t RT_ERROR_GROUP_BASE                                   = 0x07170000;
constexpr int32_t RT_ERROR_GROUP_NOT_SET                                = 0x07170001;
constexpr int32_t RT_ERROR_GROUP_NOT_CREATE                             = 0x07170002;

constexpr int32_t RT_ERROR_AICPU_BASE                                   = 0x07180000;
constexpr int32_t RT_ERROR_AICPU_INTERNAL_ERROR                         = 0x07180001;
constexpr int32_t RT_ERROR_AICPU_HCCL_OP_RETRY_FAILED                   = 0x07180002;

constexpr int32_t RT_ERROR_CDQ_BASE                                    = 0x07190000;
constexpr int32_t RT_ERROR_CDQ_DUPLICATE_CREATION                      = 0x07190001;
constexpr int32_t RT_ERROR_CDQ_NOT_EXIST                               = 0x07190002;
constexpr int32_t RT_ERROR_CDQ_NAME_LEN_EXCEED                         = 0x07190003;
constexpr int32_t RT_ERROR_CDQ_ALLOC_BATCH_TIME_OUT                    = 0x07190004;
constexpr int32_t RT_ERROR_CDQ_NO_RESOURCES                            = 0x07190005;
constexpr int32_t RT_ERROR_CDQ_CDQE_INDEX_EXCEED                       = 0x07190006;
constexpr int32_t RT_ERROR_CDQ_NULL                                    = 0x07190007;
constexpr int32_t RT_ERROR_CDQ_NEW                                     = 0x07190008;
constexpr int32_t RT_ERROR_CDQ_DATA_SIZE_EXCEED                        = 0x07190009;
constexpr int32_t RT_ERROR_CDQ_BATCH_ABNORMAL                          = 0x0719000A;

constexpr int32_t RT_ERROR_WAIT_TIMEOUT                                = 0x071A0000;
constexpr int32_t RT_ERROR_NOT_FOUND                                   = 0x071A0001;

constexpr int32_t RT_ERROR_TASKRES_BASE                                = 0x071C0000;
constexpr int32_t RT_ERROR_TASKRES_QUEUE_FULL                          = 0x071C0001;

constexpr int32_t RT_ERROR_SNAPSHOT_LOCK_TIMEOUT                       = 0x071D0000;
constexpr int32_t RT_ERROR_SNAPSHOT_LOCK_FAILED                        = 0x071D0001;
constexpr int32_t RT_ERROR_SNAPSHOT_UNLOCK_FAILED                      = 0x071D0002;
constexpr int32_t RT_ERROR_SNAPSHOT_BACKUP_FAILED                      = 0x071D0003;
constexpr int32_t RT_ERROR_SNAPSHOT_RESTORE_FAILED                     = 0x071D0004;
// It could be either an internal error or an external error
constexpr int32_t RT_ERROR_SNAPSHOT_CALLBACK_FAILED                    = 0x071D0005;
constexpr int32_t RT_ERROR_SNAPSHOT_REGISTER_CALLBACK_FAILED           = 0x071D0006;

constexpr int32_t RT_ERROR_HOST_MEMORY_ALREADY_REGISTERED              = 0x071E0001;
constexpr int32_t RT_ERROR_HOST_MEMORY_NOT_REGISTERED                  = 0x071E0002;

constexpr int32_t RT_ERROR_PLATFORM_PARSE_FILE_FAILED                  = 0x071F0001;

enum class DeviceFaultType : uint8_t {
    L2_BUFFER_ERROR,
    HBM_UCE_ERROR,
    AICORE_SW_ERROR,
    AICORE_HW_L_ERROR,
    AICORE_UNKNOWN_ERROR,
    LINK_ERROR,
    NO_ERROR
};

}
}
#endif // __CCE_RUNTIME_INTERNAL_ERROR_DEFINE_HPP__
