/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "errcode_manage.hpp"
#include <iostream>
#include <sstream>

namespace cce {
namespace runtime {
ErrorcodeManage::ErrorcodeManage()
{
    InitRtErrCodeMap();
    InitDrvErrCodeMap();
}

ErrorcodeManage& ErrorcodeManage::Instance()
{
    static ErrorcodeManage errorcodeInstance;
    return errorcodeInstance;
}

void ErrorcodeManage::InitRtErrCodeMap()
{
    // success
    rtErrMap_[RT_ERROR_NONE] = {ACL_RT_SUCCESS, "SUCCESS"};

    // device error
    rtErrMap_[RT_ERROR_DEVICE_BASE] = {ACL_ERROR_RT_INTERNAL_ERROR, "device base error"};
    rtErrMap_[RT_ERROR_DEVICE_NULL] = {ACL_ERROR_RT_DEV_SETUP_ERROR, "device pointer null"};
    rtErrMap_[RT_ERROR_DEVICE_NEW] = {ACL_ERROR_RT_MEMORY_ALLOCATION, "device new memory error"};
    rtErrMap_[RT_ERROR_DEVICE_ID] = {ACL_ERROR_RT_INVALID_DEVICEID, "device id error"};
    rtErrMap_[RT_ERROR_DEVICE_CHIPTYPE] = {ACL_ERROR_RT_INTERNAL_ERROR, "device chiptype error"};
    rtErrMap_[RT_ERROR_DEVICE_DEPLOY] = {ACL_ERROR_RT_INTERNAL_ERROR, "device deploy error"};
    rtErrMap_[RT_ERROR_DEVICE_RETAIN] = {ACL_ERROR_RT_DEV_SETUP_ERROR, "device retain error"};
    rtErrMap_[RT_ERROR_DEVICE_PLATFORM] = {ACL_ERROR_RT_INTERNAL_ERROR, "device platform error"};
    rtErrMap_[RT_ERROR_DEVICE_LOADER] = {ACL_ERROR_RT_INTERNAL_ERROR, "device loader error"};
    rtErrMap_[RT_ERROR_DEVICE_LIMIT] = {ACL_ERROR_RT_INTERNAL_ERROR, "device param over limit"};
    rtErrMap_[RT_ERROR_DEVICE_PROC_HANG_OUT] = {ACL_ERROR_RT_INTERNAL_ERROR, "device proc hang out error"};
    rtErrMap_[RT_ERROR_DEVICE_POWER_UP_FAIL] = {ACL_ERROR_RT_INTERNAL_ERROR, "device power up fail"};
    rtErrMap_[RT_ERROR_DEVICE_POWER_DOWN_FAIL] = {ACL_ERROR_RT_INTERNAL_ERROR, "device power down fail"};
    rtErrMap_[RT_ERROR_DEVICE_INVALID] = {ACL_ERROR_RT_INTERNAL_ERROR, "device id invalid"};
    rtErrMap_[RT_ERROR_DEVICE_RINGBUFFER_NOT_INIT] = {ACL_ERROR_RT_RINGBUFFER_NOT_INIT, "ringbuffer not init"};
    rtErrMap_[RT_ERROR_DEVICE_RINGBUFFER_NO_DATA] = {ACL_ERROR_RT_RINGBUFFER_NO_DATA, "ringbuffer no data"};
    rtErrMap_[RT_ERROR_DEVICE_OOM] = {ACL_ERROR_RT_DEVICE_OOM, "device oom"};
    rtErrMap_[RT_ERROR_SEND_MSG] = {ACL_ERROR_RT_SEND_MSG, "hdc send msg fail"};
    rtErrMap_[RT_ERROR_DEVICE_TASK_ABORT] = {ACL_ERROR_RT_DEVICE_TASK_ABORT, "device task abort"};
    rtErrMap_[RT_ERROR_DEVICE_ABORT_SEND_TASK_FAIL] = {ACL_ERROR_RT_DEVICE_TASK_ABORT, "device task abort"};
    rtErrMap_[RT_ERROR_DEVICE_ABORT_SYNC_TASK_FAIL] = {ACL_ERROR_RT_DEVICE_TASK_ABORT, "device task abort"};

    rtErrMap_[RT_ERROR_DRV_BASE] = {ACL_ERROR_RT_INTERNAL_ERROR, "driver base error"};
    rtErrMap_[RT_ERROR_DRV_NULL] = {ACL_ERROR_RT_INTERNAL_ERROR, "driver pointer null"};
    rtErrMap_[RT_ERROR_DRV_NEW] = {ACL_ERROR_RT_MEMORY_ALLOCATION, "driver new memory error"};
    rtErrMap_[RT_ERROR_DRV_MEMORY] = {ACL_ERROR_RT_INTERNAL_ERROR, "driver handle memory error"};
    rtErrMap_[RT_ERROR_DRV_PTRNULL] = {ACL_ERROR_RT_INTERNAL_ERROR, "parameter pointer null"};
    rtErrMap_[RT_ERROR_DRV_OPEN_AICPU] = {ACL_ERROR_RT_INTERNAL_ERROR, "open aicpu error"};
    rtErrMap_[RT_ERROR_DRV_CLOSE_AICPU] = {ACL_ERROR_RT_INTERNAL_ERROR, "close aicpu error"};
    rtErrMap_[RT_ERROR_DRV_SYM_AICPU] = {ACL_ERROR_RT_INTERNAL_ERROR, "aicpu symbol error"};
    rtErrMap_[RT_ERROR_DRV_OPEN_TSD] = {ACL_ERROR_RT_INTERNAL_ERROR, "open tsd error"};
    rtErrMap_[RT_ERROR_DRV_CLOSE_TSD] = {ACL_ERROR_RT_INTERNAL_ERROR, "close tsd error"};
    rtErrMap_[RT_ERROR_DRV_SYM_TSD] = {ACL_ERROR_RT_INTERNAL_ERROR, "tsd symbol error"};
    rtErrMap_[RT_ERROR_DRV_SOURCE] = {ACL_ERROR_RT_INTERNAL_ERROR, "driver source error"};
    rtErrMap_[RT_ERROR_DRV_REPORT] = {ACL_ERROR_RT_INTERNAL_ERROR, "driver report error"};
    rtErrMap_[RT_ERROR_DRV_COMMAND] = {ACL_ERROR_RT_INTERNAL_ERROR, "driver command error"};
    rtErrMap_[RT_ERROR_DRV_OCCUPY] = {ACL_ERROR_RT_INTERNAL_ERROR, "driver occupy error"};
    rtErrMap_[RT_ERROR_DRV_TSD_ERR] = {ACL_ERROR_RT_INTERNAL_ERROR, "tsd return error"};
    rtErrMap_[RT_ERROR_DRV_OVER_LIMIT] = {ACL_ERROR_RT_OVER_LIMIT, "over limit"};
    rtErrMap_[RT_ERROR_DRV_QUEUE_EMPTY] = {ACL_ERROR_RT_QUEUE_EMPTY, "queue empty"};
    rtErrMap_[RT_ERROR_DRV_QUEUE_FULL] = {ACL_ERROR_RT_QUEUE_FULL, "queue full"};
    rtErrMap_[RT_ERROR_DRV_REPEATED_INIT] = {ACL_ERROR_RT_REPEATED_INIT, "repeated init"};
    rtErrMap_[RT_ERROR_DRV_MEMORY_OPT_FAIL] = {ACL_ERROR_RT_PARAM_INVALID, "invalid value"};

    // drv error(mapping drv errorcode)
    rtErrMap_[RT_ERROR_DRV_ERR] = {ACL_ERROR_RT_DRV_INTERNAL_ERROR, "driver error:internal error"};
    rtErrMap_[RT_ERROR_DRV_IOCTRL] = {ACL_ERROR_RT_DRV_INTERNAL_ERROR, "driver error:internal error"};
    rtErrMap_[RT_ERROR_DRV_NO_DEVICE] = {ACL_ERROR_RT_NO_DEVICE, "driver error:no valid device"};
    rtErrMap_[RT_ERROR_DRV_INVALID_DEVICE] = {ACL_ERROR_RT_INVALID_DEVICEID, "driver error:invalid device"};
    rtErrMap_[RT_ERROR_DRV_INPUT] = {ACL_ERROR_RT_PARAM_INVALID, "driver error:invalid value"};
    rtErrMap_[RT_ERROR_DRV_INVALID_HANDLE] = {ACL_ERROR_RT_INVALID_HANDLE, "driver error:invalid handle"};
    rtErrMap_[RT_ERROR_DRV_INVALID_MALLOC_TYPE] = {ACL_ERROR_RT_INVALID_MALLOC_TYPE,
                                                   "driver error:invalid malloc type"};
    rtErrMap_[RT_ERROR_DRV_OUT_MEMORY] = {ACL_ERROR_RT_MEMORY_ALLOCATION, "driver error:out of memory"};
    rtErrMap_[RT_ERROR_DRV_MALLOC_FAIL] = {ACL_ERROR_RT_RESOURCE_ALLOC_FAIL, "driver error:resource alloc fail"};
    rtErrMap_[RT_ERROR_DRV_OPER_NOT_PERMITTED] = {ACL_ERROR_RT_NO_PERMISSION, "driver error:operation no permitted"};
    rtErrMap_[RT_ERROR_DRV_NO_EVENT_RESOURCES] = {ACL_ERROR_RT_NO_EVENT_RESOURCE, "driver error:no event resource"};
    rtErrMap_[RT_ERROR_DRV_NO_STREAM_RESOURCES] = {ACL_ERROR_RT_NO_STREAM_RESOURCE, "driver error:no stream resource"};
    rtErrMap_[RT_ERROR_DRV_NO_NOTIFY_RESOURCES] = {ACL_ERROR_RT_NO_NOTIFY_RESOURCE, "driver error:no notify resource"};
    rtErrMap_[RT_ERROR_DRV_NO_MODEL_RESOURCES] = {ACL_ERROR_RT_NO_MODEL_RESOURCE, "driver error:no model resource"};
    rtErrMap_[RT_ERROR_DRV_NOT_SUPPORT] = {ACL_ERROR_RT_FEATURE_NOT_SUPPORT, "driver error:feature not support"};
    rtErrMap_[RT_ERROR_DRV_NOT_SUPPORT_UPDATE_OP] = {ACL_ERROR_RT_FEATURE_NOT_SUPPORT_UPDATE_OP,
        "driver error:current driver version does not support to update this op, please upgrade the driver"};
    rtErrMap_[RT_ERROR_DRV_NO_RESOURCES] = {ACL_ERROR_RT_RESOURCE_ALLOC_FAIL, "driver error:resource alloc fail"};
    rtErrMap_[RT_ERROR_DRV_COPY_USER_FAIL] = {ACL_ERROR_RT_COPY_DATA, "driver error:copy data fail"};
    rtErrMap_[RT_ERROR_DEVICE_MEM_ERROR] = {ACL_ERROR_RT_DEVICE_MEM_ERROR, "device mem error"};
    rtErrMap_[RT_ERROR_SDMA_POISON_ERROR] = {ACL_ERROR_RT_DEVICE_MEM_ERROR, "device mem error"};
    rtErrMap_[RT_ERROR_MEM_RAS_ERROR] = {ACL_ERROR_RT_HBM_MULTI_BIT_ECC_ERROR, "hbm Multi-bit ECC error"};
    rtErrMap_[RT_ERROR_SUSPECT_DEVICE_MEM_ERROR] = {ACL_ERROR_RT_SUSPECT_DEVICE_MEM_ERROR, "suspect device mem error"};
    rtErrMap_[RT_ERROR_SUSPECT_REMOTE_ERROR] = {ACL_ERROR_RT_SUSPECT_REMOTE_ERROR, "suspect remote error"};

    // stream error
    rtErrMap_[RT_ERROR_STREAM_BASE] = {ACL_ERROR_RT_INTERNAL_ERROR, "stream base error"};
    rtErrMap_[RT_ERROR_STREAM_NULL] = {ACL_ERROR_RT_INTERNAL_ERROR, "stream pointer null"};
    rtErrMap_[RT_ERROR_STREAM_NEW] = {ACL_ERROR_RT_MEMORY_ALLOCATION, "stream new memory error"};
    rtErrMap_[RT_ERROR_STREAM_CONTEXT] = {ACL_ERROR_RT_STREAM_CONTEXT, "stream not in current context"};
    rtErrMap_[RT_ERROR_STREAM_INVALID] = {ACL_ERROR_RT_INTERNAL_ERROR, "stream invalid"};
    rtErrMap_[RT_ERROR_STREAM_MODEL] = {ACL_ERROR_RT_STREAM_MODEL,
                                        "the relationship between the model and stream is incorrect."};
    rtErrMap_[RT_ERROR_STREAM_FUSION] = {ACL_ERROR_RT_INTERNAL_ERROR, "stream fusion error"};
    rtErrMap_[RT_ERROR_STREAM_FULL] = {ACL_ERROR_RT_STREAM_TASK_FULL, "stream task buffer full"};
    rtErrMap_[RT_ERROR_STREAM_EMPTY] = {ACL_ERROR_RT_STREAM_TASK_EMPTY, "stream task buffer empty"};
    rtErrMap_[RT_ERROR_STREAM_NOT_COMPLETE] = {ACL_ERROR_RT_STREAM_NOT_COMPLETE, "stream not complete"};
    rtErrMap_[RT_ERROR_STREAM_SYNC] = {ACL_ERROR_RT_INTERNAL_ERROR, "stream sync error"};
    rtErrMap_[RT_ERROR_STREAM_NO_CB_REG] = {ACL_ERROR_RT_STREAM_NO_CB_REG, "stream not registered"};
    rtErrMap_[RT_ERROR_STREAM_DUPLICATE] = {ACL_ERROR_RT_INTERNAL_ERROR, "stream id map repeatedly"};
    rtErrMap_[RT_ERROR_STREAM_NOT_EXIST] = {ACL_ERROR_RT_INTERNAL_ERROR, "stream id not exist"};
    rtErrMap_[RT_ERROR_SQ_NO_EXIST_SQ_TO_REUSE] = {ACL_ERROR_RT_INTERNAL_ERROR, "no exist sq to reuse"};
    rtErrMap_[RT_ERROR_SQID_FULL] = {ACL_ERROR_RT_INTERNAL_ERROR, "sq id full"};
    rtErrMap_[RT_ERROR_STREAM_SYNC_TIMEOUT] = {ACL_ERROR_RT_STREAM_SYNC_TIMEOUT, "stream sync timeout"};
    rtErrMap_[RT_ERROR_DVPP_GRP_NEW] = {ACL_ERROR_RT_INTERNAL_ERROR, "create dvpp grp fail"};
    rtErrMap_[RT_ERROR_STREAM_BIND_GRP] = {ACL_ERROR_RT_PARAM_INVALID, "stream bind to dvpp grp"};
    rtErrMap_[RT_ERROR_REMOTE_SQID_DUPLICATE] = {ACL_ERROR_RT_INTERNAL_ERROR, "remote sq id repeatedly"};
    rtErrMap_[RT_ERROR_STREAM_REUSE_LIMIT_MODEL_NUM] = {ACL_ERROR_RT_STREAM_MODEL,
                                                        "models number exceeds the upper limit 256"};
    rtErrMap_[RT_ERROR_STREAM_ABORT] = {ACL_ERROR_RT_STREAM_ABORT,"stream abort"};
    rtErrMap_[RT_ERROR_STREAM_ABORT_SEND_TASK_FAIL] = {ACL_ERROR_RT_STREAM_ABORT, "stream abort"};
    rtErrMap_[RT_ERROR_STREAM_ABORT_SYNC_TASK_FAIL] = {ACL_ERROR_RT_STREAM_ABORT, "stream abort"};
    rtErrMap_[RT_ERROR_STREAM_CAPTURED] = {ACL_ERROR_RT_STREAM_CAPTURED, "stream is captured"};
    rtErrMap_[RT_ERROR_STREAM_CAPTURE_INVALIDATED] = {ACL_ERROR_RT_STREAM_CAPTURE_INVALIDATED,
                                                      "an error has invalidated the stream capture sequence"};
    rtErrMap_[RT_ERROR_STREAM_NOT_CAPTURED] = {ACL_ERROR_RT_STREAM_NOT_CAPTURED, "stream is not in capture status"};
    rtErrMap_[RT_ERROR_STREAM_CAPTURE_MODE_NOT_SUPPORT] = {ACL_ERROR_RT_CAPTURE_MODE_NOT_SUPPORT,
                                                           "the current capture mode does not support this operation"};
    rtErrMap_[RT_ERROR_STREAM_CAPTURE_IMPLICIT] = {ACL_ERROR_RT_STREAM_CAPTURE_IMPLICIT,
                                                   "a disallowed implicit dependency from default stream"};
    rtErrMap_[RT_ERROR_STREAM_AICPU_ALLOC_FAIL] = {ACL_ERROR_RT_RESOURCE_ALLOC_FAIL,
                                                   "aicpu id alloc failed"};
    rtErrMap_[RT_ERROR_STREAM_CAPTURE_CONFLICT] = {ACL_ERROR_STREAM_CAPTURE_CONFLICT, "stream begin capture conflict"};
    rtErrMap_[RT_ERROR_STREAM_TASKGRP_STATUS] = {ACL_ERROR_STREAM_TASK_GROUP_STATUS, "task group status error"};
    rtErrMap_[RT_ERROR_STREAM_TASKGRP_NULL] = {ACL_ERROR_RT_INTERNAL_ERROR, "task group handle null"};
    rtErrMap_[RT_ERROR_STREAM_TASKGRP_INTR] = {ACL_ERROR_STREAM_TASK_GROUP_INTR, "task group interrupted"};
    rtErrMap_[RT_ERROR_STREAM_TASKGRP_UPDATE] = {ACL_ERROR_RT_INTERNAL_ERROR, "task group update error"};
    rtErrMap_[RT_ERROR_STREAM_CAPTURE_UNMATCHED] = {ACL_ERROR_RT_STREAM_CAPTURE_UNMATCHED,
                                                    "the capture was not initiated in this stream"};
    rtErrMap_[RT_ERROR_STREAM_CAPTURE_WRONG_THREAD] = {ACL_ERROR_RT_STREAM_CAPTURE_WRONG_THREAD,
                                                       "end capture in the wrong thread"};

    // model error
    rtErrMap_[RT_ERROR_MODEL_BASE] = {ACL_ERROR_RT_INTERNAL_ERROR, "model base error"};
    rtErrMap_[RT_ERROR_MODEL_NULL] = {ACL_ERROR_RT_INTERNAL_ERROR, "model pointer null"};
    rtErrMap_[RT_ERROR_MODEL_NEW] = {ACL_ERROR_RT_MEMORY_ALLOCATION, "model new memory error"};
    rtErrMap_[RT_ERROR_MODEL_CONTEXT] = {ACL_ERROR_RT_MODEL_CONTEXT, "model not in current ctx"};
    rtErrMap_[RT_ERROR_MODEL_ENDGRAPH] = {ACL_ERROR_RT_INTERNAL_ERROR, "model endgraph num error"};
    rtErrMap_[RT_ERROR_MODEL_STREAM] = {ACL_ERROR_RT_STREAM_MODEL, "model empty"};
    rtErrMap_[RT_ERROR_MODEL_EXECUTOR] = {ACL_ERROR_RT_INTERNAL_ERROR, "model execute error"};
    rtErrMap_[RT_ERROR_MODEL_SETUP] = {ACL_ERROR_RT_INTERNAL_ERROR, "model setup error"};
    rtErrMap_[RT_ERROR_MODEL_ID] = {ACL_ERROR_RT_INTERNAL_ERROR, "model id error"};
    rtErrMap_[RT_ERROR_MODEL_EXE_FAILED] = {ACL_ERROR_RT_MODEL_EXECUTE, "model execute failed"};
    rtErrMap_[RT_ERROR_END_OF_SEQUENCE] = {ACL_ERROR_RT_END_OF_SEQUENCE, "end of sequence"};
    rtErrMap_[RT_ERROR_MODEL_EXIT] = {ACL_ERROR_RT_INTERNAL_ERROR, "model exit error"};
    rtErrMap_[RT_ERROR_MODEL_EXIT_STREAM_UNBIND] = {ACL_ERROR_RT_STREAM_MODEL, "model stream unbind error"};
    rtErrMap_[RT_ERROR_MODEL_EXIT_ID] = {ACL_ERROR_RT_STREAM_MODEL, "stream is not belong to the model"};
    rtErrMap_[RT_ERROR_MODEL_ABORT_NORMAL] = {ACL_ERROR_RT_MODEL_ABORT_NORMAL, "model abort normal"};
    rtErrMap_[RT_ERROR_MODEL_NOT_END] = {ACL_ERROR_RT_MODEL_EXECUTE, "end graph must be called before execution"};

    // event error
    rtErrMap_[RT_ERROR_EVENT_BASE] = {ACL_ERROR_RT_INTERNAL_ERROR, "event base error"};
    rtErrMap_[RT_ERROR_EVENT_NULL] = {ACL_ERROR_RT_INTERNAL_ERROR, "event pointer null"};
    rtErrMap_[RT_ERROR_EVENT_NEW] = {ACL_ERROR_RT_MEMORY_ALLOCATION, "event new memory error"};
    rtErrMap_[RT_ERROR_EVENT_RECORDER_NULL] = {ACL_ERROR_RT_INTERNAL_ERROR, "event recorder null"};
    rtErrMap_[RT_ERROR_EVENT_TIMESTAMP_INVALID] = {ACL_ERROR_RT_EVENT_TIMESTAMP_INVALID, "event timestamp invalid"};
    rtErrMap_[RT_ERROR_EVENT_TIMESTAMP_REVERSAL] = {ACL_ERROR_RT_EVENT_TIMESTAMP_REVERSAL,
                                                    "event timestamp reversal"};
    rtErrMap_[RT_ERROR_EVENT_NOT_COMPLETE] = {ACL_ERROR_RT_EVENT_NOT_COMPLETE, "event not complete"};
    rtErrMap_[RT_ERROR_EVENT_SYNC_TIMEOUT] = {ACL_ERROR_RT_EVENT_SYNC_TIMEOUT, "event sync timeout"};
    rtErrMap_[RT_ERROR_EVENT_CAPTURED] = {ACL_ERROR_RT_EVENT_CAPTURED, "event is captured"};
    rtErrMap_[RT_ERROR_CAPTURE_DEPENDENCY] = {ACL_ERROR_RT_CAPTURE_DEPENDENCY,
                                              "dependency created on uncaptured work in another stream"};
    rtErrMap_[RT_ERROR_STREAM_CAPTURE_ISOLATION] = {ACL_ERROR_RT_CAPTURE_DEPENDENCY,
                                                    "in the model capture scenario, the event wait task has no corresponding event record task"};
    // notify error
    rtErrMap_[RT_ERROR_NOTIFY_BASE] = {ACL_ERROR_RT_INTERNAL_ERROR, "notify base error"};
    rtErrMap_[RT_ERROR_NOTIFY_NULL] = {ACL_ERROR_RT_INTERNAL_ERROR, "notify pointer null"};
    rtErrMap_[RT_ERROR_NOTIFY_NEW] = {ACL_ERROR_RT_MEMORY_ALLOCATION, "notify new memory error"};
    rtErrMap_[RT_ERROR_NOTIFY_TYPE] = {ACL_ERROR_RT_INTERNAL_ERROR, "notify type error"};
    rtErrMap_[RT_ERROR_NOTIFY_NOT_COMPLETE] = {ACL_ERROR_RT_INTERNAL_ERROR, "notify not complete"};

    // context error
    rtErrMap_[RT_ERROR_CONTEXT_BASE] = {ACL_ERROR_RT_INTERNAL_ERROR, "context base error"};
    rtErrMap_[RT_ERROR_CONTEXT_NULL] = {ACL_ERROR_RT_CONTEXT_NULL, "context pointer null"};
    rtErrMap_[RT_ERROR_CONTEXT_NEW] = {ACL_ERROR_RT_MEMORY_ALLOCATION, "context new memory error"};
    rtErrMap_[RT_ERROR_CONTEXT_DEL] = {ACL_ERROR_RT_CONTEXT_RELEASE_ERROR, "context release error"};
    rtErrMap_[RT_ERROR_CONTEXT_DEFAULT_STREAM_NULL] = {ACL_ERROR_RT_INTERNAL_ERROR,
                                                       "default stream in current context is null"};
    rtErrMap_[RT_ERROR_CONTEXT_ONLINE_STREAM_NULL] = {ACL_ERROR_RT_INTERNAL_ERROR, "online stream is null"};
    rtErrMap_[RT_ERROR_CONTEXT_MODE] = {ACL_ERROR_RT_INTERNAL_ERROR, "the current context mode is incorrect"};

    // kernel error
    rtErrMap_[RT_ERROR_KERNEL_BASE] = {ACL_ERROR_RT_INTERNAL_ERROR, "kernel base error"};
    rtErrMap_[RT_ERROR_KERNEL_NULL] = {ACL_ERROR_RT_INTERNAL_ERROR, "kernel pointer null"};
    rtErrMap_[RT_ERROR_KERNEL_NEW] = {ACL_ERROR_RT_MEMORY_ALLOCATION, "kernel new memory error"};
    rtErrMap_[RT_ERROR_KERNEL_LOOKUP] = {ACL_ERROR_RT_KERNEL_LOOKUP, "kernel lookup error"};
    rtErrMap_[RT_ERROR_KERNEL_NAME] = {ACL_ERROR_RT_INTERNAL_ERROR, "kernel name error"};
    rtErrMap_[RT_ERROR_KERNEL_TYPE] = {ACL_ERROR_RT_INTERNAL_ERROR, "kernel type error"};
    rtErrMap_[RT_ERROR_KERNEL_OFFSET] = {ACL_ERROR_RT_INTERNAL_ERROR, "kernel offset error"};
    rtErrMap_[RT_ERROR_KERNEL_DUPLICATE] = {ACL_ERROR_RT_KERNEL_DUPLICATE, "kernel duplicate"};
    rtErrMap_[RT_ERROR_KERNEL_UNREGISTERING] = {ACL_ERROR_RT_KERNEL_UNREGISTERING, "kernel unregistering"};

    // program error
    rtErrMap_[RT_ERROR_PROGRAM_BASE] = {ACL_ERROR_RT_INTERNAL_ERROR, "program base error"};
    rtErrMap_[RT_ERROR_PROGRAM_NULL] = {ACL_ERROR_RT_INTERNAL_ERROR, "program pointer null"};
    rtErrMap_[RT_ERROR_PROGRAM_NEW] = {ACL_ERROR_RT_MEMORY_ALLOCATION, "program new memory error"};
    rtErrMap_[RT_ERROR_PROGRAM_DATA] = {ACL_ERROR_RT_INTERNAL_ERROR, "program data error"};
    rtErrMap_[RT_ERROR_PROGRAM_SIZE] = {ACL_ERROR_RT_INTERNAL_ERROR, "program size error"};
    rtErrMap_[RT_ERROR_PROGRAM_MEM_TYPE] = {ACL_ERROR_RT_INTERNAL_ERROR, "program mem type error"};
    rtErrMap_[RT_ERROR_PROGRAM_MACHINE_TYPE] = {ACL_ERROR_RT_INTERNAL_ERROR, "program machine type error"};
    rtErrMap_[RT_ERROR_PROGRAM_USEOUT] = {ACL_ERROR_RT_PROGRAM_USE_OUT, "program register num out of use"};

    // module error
    rtErrMap_[RT_ERROR_MODULE_BASE] = {ACL_ERROR_RT_INTERNAL_ERROR, "module error base"};
    rtErrMap_[RT_ERROR_MODULE_NULL] = {ACL_ERROR_RT_INTERNAL_ERROR, "module pointer null"};
    rtErrMap_[RT_ERROR_MODULE_NEW] = {ACL_ERROR_RT_MEMORY_ALLOCATION, "module new memory error"};
    rtErrMap_[RT_ERROR_STREAM_UNJOINED] = {ACL_ERROR_RT_STREAM_UNJOINED,
        "capture model contains a stream that was not joined to the original stream"};
    rtErrMap_[RT_ERROR_MODEL_CAPTURED] = {ACL_ERROR_RT_MODEL_CAPTURED, "model is captured"};
    rtErrMap_[RT_ERROR_MODEL_CAPTURE_STATUS] = {ACL_ERROR_RT_INTERNAL_ERROR, "model status error"};
    rtErrMap_[RT_ERROR_MODEL_RUNNING] = {ACL_ERROR_RT_MODEL_RUNNING, "model is running"};
    rtErrMap_[RT_ERROR_MODEL_OP_CACHE_CLOSED] = {ACL_ERROR_RT_INTERNAL_ERROR, "model cache op info switch is closed"};

    // instance error
    rtErrMap_[RT_ERROR_INSTANCE_BASE] = {ACL_ERROR_RT_INTERNAL_ERROR, "instance base error"};
    rtErrMap_[RT_ERROR_INSTANCE_NULL] = {ACL_ERROR_RT_INTERNAL_ERROR, "instance pointer null"};
    rtErrMap_[RT_ERROR_INSTANCE_NEW] = {ACL_ERROR_RT_MEMORY_ALLOCATION, "instance new error"};
    rtErrMap_[RT_ERROR_INSTANCE_VERSION] = {ACL_ERROR_RT_SOC_VERSION, "soc version error"};

    // api error
    rtErrMap_[RT_ERROR_API_BASE] = {ACL_ERROR_RT_INTERNAL_ERROR, "api error base"};
    rtErrMap_[RT_ERROR_API_NULL] = {ACL_ERROR_RT_INTERNAL_ERROR, "api pointer null"};
    rtErrMap_[RT_ERROR_API_NEW] = {ACL_ERROR_RT_MEMORY_ALLOCATION, "api new memory error"};

    // datadump error
    rtErrMap_[RT_ERROR_DATADUMP_BASE] = {ACL_ERROR_RT_INTERNAL_ERROR, "datadump base error"};
    rtErrMap_[RT_ERROR_DATADUMP_NULL] = {ACL_ERROR_RT_INTERNAL_ERROR, "datadump pointer null"};
    rtErrMap_[RT_ERROR_DATADUMP_NEW] = {ACL_ERROR_RT_MEMORY_ALLOCATION, "datadump new memory error"};
    rtErrMap_[RT_ERROR_DATADUMP_TIME] = {ACL_ERROR_RT_INTERNAL_ERROR, "datadump time error"};
    rtErrMap_[RT_ERROR_DATADUMP_FILE] = {ACL_ERROR_RT_FILE_WRITE, "datadump file error"};
    rtErrMap_[RT_ERROR_DATADUMP_ADDRESS] = {ACL_ERROR_RT_INTERNAL_ERROR, "datadump address error"};
    rtErrMap_[RT_ERROR_DATADUMP_LOAD_FAILED] = {ACL_ERROR_RT_INTERNAL_ERROR, "datadump load fail"};
    rtErrMap_[RT_ERROR_DUMP_ADDR_SET_FAILED] = {ACL_ERROR_RT_INTERNAL_ERROR, "l1 fusion dump addr set fail "};

    // prof error
    rtErrMap_[RT_ERROR_PROF_BASE] = {ACL_ERROR_RT_INTERNAL_ERROR, "profiler base error"};
    rtErrMap_[RT_ERROR_PROF_NULL] = {ACL_ERROR_RT_INTERNAL_ERROR, "profiler pointer null"};
    rtErrMap_[RT_ERROR_PROF_NEW] = {ACL_ERROR_RT_MEMORY_ALLOCATION, "profiler new memory error"};
    rtErrMap_[RT_ERROR_PROF_START] = {ACL_ERROR_RT_INTERNAL_ERROR, "profiler start error"};
    rtErrMap_[RT_ERROR_PROF_DEVICE_MEM] = {ACL_ERROR_RT_INTERNAL_ERROR, "profiler device memory error"};
    rtErrMap_[RT_ERROR_PROF_HOST_MEM] = {ACL_ERROR_RT_INTERNAL_ERROR, "profiler host memory error"};
    rtErrMap_[RT_ERROR_PROF_SET_DIR] = {ACL_ERROR_RT_INTERNAL_ERROR, "profiler set dir error"};
    rtErrMap_[RT_ERROR_PROF_OPER] = {ACL_ERROR_RT_INTERNAL_ERROR, "profiler operate fail"};
    rtErrMap_[RT_ERROR_PROF_FULL] = {ACL_ERROR_RT_INTERNAL_ERROR, "profiler data full"};
    rtErrMap_[RT_ERROR_PROF_NAME] = {ACL_ERROR_RT_PARAM_INVALID, "profiler name error"};

    // pctrace error
    rtErrMap_[RT_ERROR_PCTRACE_BASE] = {ACL_ERROR_RT_INTERNAL_ERROR, "pctrace base error"};
    rtErrMap_[RT_ERROR_PCTRACE_NULL] = {ACL_ERROR_RT_INTERNAL_ERROR, "pctrace pointer null"};
    rtErrMap_[RT_ERROR_PCTRACE_NEW] = {ACL_ERROR_RT_MEMORY_ALLOCATION, "pctrace new memory error"};
    rtErrMap_[RT_ERROR_PCTRACE_TIME] = {ACL_ERROR_RT_INTERNAL_ERROR, "pctrace time error"};
    rtErrMap_[RT_ERROR_PCTRACE_FILE] = {ACL_ERROR_RT_INTERNAL_ERROR, "pctrace file error"};

    // task error
    rtErrMap_[RT_ERROR_TASK_BASE] = {ACL_ERROR_RT_INTERNAL_ERROR, "task base error"};
    rtErrMap_[RT_ERROR_TASK_NULL] = {ACL_ERROR_RT_INTERNAL_ERROR, "task pointer null"};
    rtErrMap_[RT_ERROR_TASK_NEW] = {ACL_ERROR_RT_MEMORY_ALLOCATION, "task new memory error"};
    rtErrMap_[RT_ERROR_TASK_NOT_SUPPORT] = {ACL_ERROR_RT_TASK_TYPE_NOT_SUPPORT, "task not supported"};
    rtErrMap_[RT_ERROR_TASK_ALLOCATOR] = {ACL_ERROR_RT_INTERNAL_ERROR, "task allocator error"};

    // common error
    rtErrMap_[RT_ERROR_COMMON_BASE] = {ACL_ERROR_RT_INTERNAL_ERROR, "common base error"};
    rtErrMap_[RT_ERROR_INVALID_VALUE] = {ACL_ERROR_RT_PARAM_INVALID, "invalid value"};
    rtErrMap_[RT_ERROR_MEMORY_ADDRESS_UNALIGNED] = {ACL_ERROR_RT_ADDR_UNALIGNED, "memory address unaligned"};
    rtErrMap_[RT_ERROR_SEC_HANDLE] = {ACL_ERROR_RT_INTERNAL_ERROR, "execute safe func error"};
    rtErrMap_[RT_ERROR_OS_HANDLE] = {ACL_ERROR_RT_INTERNAL_ERROR, "os handle error"};
    rtErrMap_[RT_ERROR_MUTEX_LOCK] = {ACL_ERROR_RT_INTERNAL_ERROR, "mutex lock error"};
    rtErrMap_[RT_ERROR_MUTEX_UNLOCK] = {ACL_ERROR_RT_INTERNAL_ERROR, "mutex unlock error"};
    rtErrMap_[RT_ERROR_CALLOC] = {ACL_ERROR_RT_INTERNAL_ERROR, "calloc error"};
    rtErrMap_[RT_ERROR_POOL_RESOURCE] = {ACL_ERROR_RT_INTERNAL_ERROR, "error pool resource"};
    rtErrMap_[RT_ERROR_TRANS_ARGS] = {ACL_ERROR_RT_INTERNAL_ERROR, "trans args error"};
    rtErrMap_[RT_ERROR_METADATA] = {ACL_ERROR_RT_PARAM_INVALID, "metadata error"};
    rtErrMap_[RT_ERROR_SOCKET_CLOSE] = {ACL_ERROR_RT_SOCKET_CLOSE, "hdc disconnect"};
    rtErrMap_[RT_ERROR_LOST_HEARTBEAT] = {ACL_ERROR_RT_LOST_HEARTBEAT, "lost heartbeat"};
    rtErrMap_[RT_ERROR_REPORT_TIMEOUT] = {ACL_ERROR_RT_REPORT_TIMEOUT, "report timeout"};
    rtErrMap_[RT_ERROR_FEATURE_NOT_SUPPORT] = {ACL_ERROR_RT_FEATURE_NOT_SUPPORT, "feature not support"};
    rtErrMap_[RT_ERROR_MEMORY_ALLOCATION] = {ACL_ERROR_RT_MEMORY_ALLOCATION, "alloc memory error"};
    rtErrMap_[RT_ERROR_MEMORY_FREE] = {ACL_ERROR_RT_MEMORY_FREE, "free memory error"};
    rtErrMap_[RT_ERROR_INVALID_MEMORY_TYPE] = {ACL_ERROR_RT_INVALID_MEMORY_TYPE, "invalid memory type"};
    rtErrMap_[RT_ERROR_NOT_SET_SYSPARAMOPT] = {ACL_ERROR_RT_SYSPARAMOPT_NOT_SET, "not set sysparamopt"};

    // debug error
    rtErrMap_[RT_ERROR_DEBUG_BASE] = {ACL_ERROR_RT_INTERNAL_ERROR, "debug base error"};
    rtErrMap_[RT_ERROR_DEBUG_NULL] = {ACL_ERROR_RT_INTERNAL_ERROR, "debug pointer null"};
    rtErrMap_[RT_ERROR_DEBUG_NEW] = {ACL_ERROR_RT_MEMORY_ALLOCATION, "debug new memory error"};
    rtErrMap_[RT_ERROR_DEBUG_SIGNAL] = {ACL_ERROR_RT_INTERNAL_ERROR, "debug signal error"};
    rtErrMap_[RT_ERROR_DEBUG_OPEN] = {ACL_ERROR_RT_FILE_OPEN, "open file failed"};
    rtErrMap_[RT_ERROR_DEBUG_WRITE] = {ACL_ERROR_RT_FILE_WRITE, "write file failed"};
    rtErrMap_[RT_ERROR_DEBUG_REGISTER_FAILED] = {ACL_ERROR_RT_DEBUG_REGISTER_FAIL, "debug register failed"};
    rtErrMap_[RT_ERROR_DEBUG_UNREGISTER_FAILED] = {ACL_ERROR_RT_DEBUG_UNREGISTER_FAIL, "debug unregister failed"};

    // engine error
    rtErrMap_[RT_ERROR_ENGINE_BASE] = {ACL_ERROR_RT_INTERNAL_ERROR, "engine base error"};
    rtErrMap_[RT_ERROR_ENGINE_NULL] = {ACL_ERROR_RT_INTERNAL_ERROR, "engine pointer null"};
    rtErrMap_[RT_ERROR_ENGINE_NEW] = {ACL_ERROR_RT_MEMORY_ALLOCATION, "engine new memory error"};
    rtErrMap_[RT_ERROR_ENGINE_THREAD] = {ACL_ERROR_RT_INTERNAL_ERROR, "error engine thread"};

    // label error
    rtErrMap_[RT_ERROR_LABEL_BASE] = {ACL_ERROR_RT_INTERNAL_ERROR, "label base error"};
    rtErrMap_[RT_ERROR_LABEL_NULL] = {ACL_ERROR_RT_INTERNAL_ERROR, "label pointer null"};
    rtErrMap_[RT_ERROR_LABEL_NEW] = {ACL_ERROR_RT_MEMORY_ALLOCATION, "label new memory error"};
    rtErrMap_[RT_ERROR_LABEL_CONTEXT] = {ACL_ERROR_RT_LABEL_CONTEXT, "label not in current ctx"};
    rtErrMap_[RT_ERROR_LABEL_STREAM] = {ACL_ERROR_RT_INTERNAL_ERROR, "label stream error"};
    rtErrMap_[RT_ERROR_LABEL_MODEL] = {ACL_ERROR_RT_INTERNAL_ERROR, "label not in current model"};
    rtErrMap_[RT_ERROR_LABEL_ALLOCATOR] = {ACL_ERROR_RT_INTERNAL_ERROR, "label allocator error"};
    rtErrMap_[RT_ERROR_LABEL_FREE] = {ACL_ERROR_RT_INTERNAL_ERROR, "label free error"};
    rtErrMap_[RT_ERROR_LABEL_SET] = {ACL_ERROR_RT_INTERNAL_ERROR, "label set error"};
    rtErrMap_[RT_ERROR_LABEL_ID] = {ACL_ERROR_RT_INTERNAL_ERROR, "label id error"};
    rtErrMap_[RT_ERROR_LABEL_MODEL_RELEASED] = {ACL_ERROR_RT_INTERNAL_ERROR, "bind label model released"};
    rtErrMap_[RT_ERROR_SAME_LABELS_IN_SWITCH] = {ACL_ERROR_RT_INTERNAL_ERROR, "have same labels in switch task"};
    rtErrMap_[RT_ERROR_LABEL_PHY_ADDR_NULL] = {ACL_ERROR_RT_INTERNAL_ERROR, "label phy addr null"};

    // tsfw error
    rtErrMap_[RT_ERROR_TSFW_BASE] = {ACL_ERROR_RT_TS_ERROR, "tsfw base error"};
    rtErrMap_[RT_ERROR_TSFW_UNKNOWN] = {ACL_ERROR_RT_TS_ERROR, "tsfw unknown error"};
    rtErrMap_[RT_ERROR_TSFW_NULL_PTR] = {ACL_ERROR_RT_TS_ERROR, "tsfw pointer null"};
    rtErrMap_[RT_ERROR_TSFW_ILLEGAL_AI_CORE_ID] = {ACL_ERROR_RT_TS_ERROR, "tsfw illegal aicore id"};
    rtErrMap_[RT_ERROR_TSFW_ILLEGAL_PARAM] = {ACL_ERROR_RT_TS_ERROR, "tsfw param illegal"};
    rtErrMap_[RT_ERROR_TSFW_TASK_CMD_QUEUE_FULL] = {ACL_ERROR_RT_TS_ERROR, "tsfw task command queue is full"};
    rtErrMap_[RT_ERROR_TSFW_TASK_CMD_QUEUE_EMPTY] = {ACL_ERROR_RT_TS_ERROR, "tsfw task command queue is empty"};
    rtErrMap_[RT_ERROR_TSFW_TASK_REPORT_QUEUE_FULL] = {ACL_ERROR_RT_TS_ERROR, "tsfw task report queue is full"};
    rtErrMap_[RT_ERROR_TSFW_TASK_REPORT_QUEUE_EMPTY] = {ACL_ERROR_RT_TS_ERROR, "tsfw task report queue is empty"};
    rtErrMap_[RT_ERROR_TSFW_TASK_NODE_BUFF_ALL_OCCUPIED] = {ACL_ERROR_RT_TS_ERROR,
                                                            "all the nodes of public task buff are occupied"};
    rtErrMap_[RT_ERROR_TSFW_TASK_NODE_BUFF_ALL_FREED] = {ACL_ERROR_RT_TS_ERROR,
                                                         "all the node of public task buff are free"};
    rtErrMap_[RT_ERROR_TSFW_L2_MEM_INSUFFICIENT_SPACE] = {ACL_ERROR_RT_TS_ERROR,
                                                          "there is not enough space on l2 memory"};
    rtErrMap_[RT_ERROR_TSFW_L2_MALLOC_FAILED] = {ACL_ERROR_RT_TS_ERROR, "malloc l2 memory failed"};
    rtErrMap_[RT_ERROR_TSFW_DMA_CHANNEL_ALL_OCCUPIED] = {ACL_ERROR_RT_TS_ERROR, "all the DMA channel are occupied"};
    rtErrMap_[RT_ERROR_TSFW_MEMCPY_OP_FAILED] = {ACL_ERROR_RT_TS_ERROR, "memcpy failed"};
    rtErrMap_[RT_ERROR_TSFW_BS_SLOT_ALL_OCCUPIED] = {ACL_ERROR_RT_TS_ERROR, "bs slot is not enough for new task"};
    rtErrMap_[RT_ERROR_TSFW_TBS_SLOT_REPEAT_FREE] = {ACL_ERROR_RT_TS_ERROR, "bs slot cannot be freed again"};
    rtErrMap_[RT_ERROR_TSFW_PRIORITY_TASK_LIST_FULL] = {ACL_ERROR_RT_TS_ERROR, "the priority list is full"};
    rtErrMap_[RT_ERROR_TSFW_PRIORITY_TASK_LIST_EMPTY] = {ACL_ERROR_RT_TS_ERROR, "the priority list is empty"};
    rtErrMap_[RT_ERROR_TSFW_NO_STREAM_LIST_NEED_TO_BE_PROCESSED] = {ACL_ERROR_RT_TS_ERROR,
                                                                    "there is no stream list need service"};
    rtErrMap_[RT_ERROR_TSFW_REPEAT_MARK_STREAM_NEED_SERVICE] = {ACL_ERROR_RT_TS_ERROR,
                                                                "repeat mark the stream list need service"};
    rtErrMap_[RT_ERROR_TSFW_SYS_DMA_CHANNEL_ALL_OCCUPIED] = {ACL_ERROR_RT_TS_ERROR,
                                                               "system dma channel all occupied"};
    rtErrMap_[RT_ERROR_TSFW_NO_HBML2TASKNODE_FOUND] = {ACL_ERROR_RT_TS_ERROR, "no hbm l2 task node found"};
    rtErrMap_[RT_ERROR_TSFW_SQNODE_NODE_SLOT_ALL_OCCUPIED] = {ACL_ERROR_RT_TS_ERROR,
                                                                "all the node of the current sq are occupied"};
    rtErrMap_[RT_ERROR_TSFW_CQNODE_NODE_SLOT_ALL_OCCUPIED] = {ACL_ERROR_RT_TS_ERROR,
                                                                "all the node of the current cq are occupied"};
    rtErrMap_[RT_ERROR_TSFW_SQNODE_NOT_ENOUGH] = {ACL_ERROR_RT_TS_ERROR, "the sq node is not enough for data transfer"};
    rtErrMap_[RT_ERROR_TSFW_SQNODE_SLOT_REPEAT_FREE] = {ACL_ERROR_RT_TS_ERROR, "sq node slot repeat free"};
    rtErrMap_[RT_ERROR_TSFW_CQNODE_SLOT_REPEAT_FREE] = {ACL_ERROR_RT_TS_ERROR, "cq node slot repeat free"};
    rtErrMap_[RT_ERROR_TSFW_CQ_REPORT_FAILED] = {ACL_ERROR_RT_TS_ERROR, "cq report failed"};
    rtErrMap_[RT_ERROR_TSFW_SYS_DMA_RESET_SUCCESS] = {ACL_ERROR_RT_SYS_DMA, "sys dma reset success"};
    rtErrMap_[RT_ERROR_TSFW_SYS_DMA_RESET_FAILED] = {ACL_ERROR_RT_SYS_DMA, "sys dma reset failed"};
    rtErrMap_[RT_ERROR_TSFW_SYS_DMA_TRNSFER_FAILED] = {ACL_ERROR_RT_SYS_DMA, "sys dma transfer failed"};
    rtErrMap_[RT_ERROR_TSFW_SYS_DMA_MEMADDRALIGN_FAILED] = {ACL_ERROR_RT_SYS_DMA, "sys dma mem address align failed"};
    rtErrMap_[RT_ERROR_TSFW_SYS_DMA_ERROR_QUEUE_FULL] = {ACL_ERROR_RT_SYS_DMA, "sys dma queue full"};
    rtErrMap_[RT_ERROR_TSFW_SYS_DMA_ERROR_QUEUE_EMPTY] = {ACL_ERROR_RT_SYS_DMA, "sys dma queue empty"};
    rtErrMap_[RT_ERROR_TSFW_TIMER_EVENT_FULL] = {ACL_ERROR_RT_TS_ERROR, "timer event full"};
    rtErrMap_[RT_ERROR_TSFW_TASK_L2_DESC_ENTRY_NOT_ENOUGH] = {ACL_ERROR_RT_TS_ERROR, "l2 description enter not enough"};
    rtErrMap_[RT_ERROR_TSFW_AICORE_TIMEOUT] = {ACL_ERROR_RT_AICORE_TIMEOUT, "aicore timeout"};
    rtErrMap_[RT_ERROR_TSFW_AICORE_EXCEPTION] = {ACL_ERROR_RT_AICORE_EXCEPTION, "aicore exception"};
    rtErrMap_[RT_ERROR_TSFW_AICORE_TRAP_EXCEPTION] = {ACL_ERROR_RT_AICORE_TRAP_EXCEPTION, "aicore trap exception"};
    rtErrMap_[RT_ERROR_TSFW_VECTOR_CORE_TIMEOUT] = {ACL_ERROR_RT_VECTOR_CORE_TIMEOUT, "vector core timeout"};
    rtErrMap_[RT_ERROR_TSFW_VECTOR_CORE_EXCEPTION] = {ACL_ERROR_RT_VECTOR_CORE_EXCEPTION, "vector core exception"};
    rtErrMap_[RT_ERROR_TSFW_VECTOR_CORE_TRAP_EXCEPTION] = {ACL_ERROR_RT_VECTOR_CORE_TRAP_EXCEPTION,
                                                           "vector core trap exception"};
    rtErrMap_[RT_ERROR_TSFW_AICPU_TIMEOUT] = {ACL_ERROR_RT_AICPU_TIMEOUT, "aicpu timeout"};
    rtErrMap_[RT_ERROR_TSFW_SDMA_L2_TO_DDR_MALLOC_FAIL] = {ACL_ERROR_RT_TS_ERROR, "sdma move l2 to ddr malloc failed"};
    rtErrMap_[RT_ERROR_TSFW_AICPU_EXCEPTION] = {ACL_ERROR_RT_AICPU_EXCEPTION, "aicpu exception"};
    rtErrMap_[RT_ERROR_TSFW_AICPU_DATADUMP_RSP_ERR] = {ACL_ERROR_RT_AICPU_DATADUMP_RSP_ERR,
                                                       "aicpu datadump response error"};
    rtErrMap_[RT_ERROR_TSFW_AICPU_INFO_LOAD_RSP_ERR] = {ACL_ERROR_RT_AICPU_INFO_LOAD_RSP_ERR,
                                                       "aicpu info load response error"};
    rtErrMap_[RT_ERROR_TSFW_AICPU_MODEL_RSP_ERR] = {ACL_ERROR_RT_AICPU_MODEL_RSP_ERR,
                                                    "aicpu model operate response error"};
    rtErrMap_[RT_ERROR_TSFW_REPEAT_ACTIVE_MODEL_STREAM] = {ACL_ERROR_RT_TS_ERROR, "active stream already in running"};
    rtErrMap_[RT_ERROR_TSFW_REPEAT_NOTIFY_WAIT] = {ACL_ERROR_RT_TS_ERROR, "repeat stream notify wait"};
    rtErrMap_[RT_ERROR_TSFW_DEBUG_INVALID_SQCQ] = {ACL_ERROR_RT_TS_ERROR, "debug invalid sqcq"};
    rtErrMap_[RT_ERROR_TSFW_DEBUG_WRONG_COMMAND_TYPE] = {ACL_ERROR_RT_TS_ERROR, "debug wrong command type"};
    rtErrMap_[RT_ERROR_TSFW_DEBUG_CMD_PROCESS] = {ACL_ERROR_RT_TS_ERROR, "dbg cmd process"};
    rtErrMap_[RT_ERROR_TSFW_DEBUG_INVALID_DEVICE_STATUS] = {ACL_ERROR_RT_TS_ERROR, "debug invalid device status"};
    rtErrMap_[RT_ERROR_TSFW_DEBUG_NOT_IN_DEBUG_STATUS] = {ACL_ERROR_RT_TS_ERROR, "debug not in debug status"};
    rtErrMap_[RT_ERROR_TSFW_DEBUG_INVALID_TASK_STATUS] = {ACL_ERROR_RT_TS_ERROR, "debug invalid task status"};
    rtErrMap_[RT_ERROR_TSFW_DEBUG_TASK_EMPTY] = {ACL_ERROR_RT_TS_ERROR, "debug task empty"};
    rtErrMap_[RT_ERROR_TSFW_DEBUG_TASK_FULL] = {ACL_ERROR_RT_TS_ERROR, "debug task full"};
    rtErrMap_[RT_ERROR_TSFW_DEBUG_TASK_NOT_EXIST] = {ACL_ERROR_RT_TS_ERROR, "debug task not exist"};
    rtErrMap_[RT_ERROR_TSFW_DEBUG_AI_CORE_FULL] = {ACL_ERROR_RT_TS_ERROR, "debug aicore full"};
    rtErrMap_[RT_ERROR_TSFW_DEBUG_AI_CORE_NOT_EXIST] = {ACL_ERROR_RT_TS_ERROR, "debug aicore not exist"};
    rtErrMap_[RT_ERROR_TSFW_DEBUG_AI_CORE_EXCEPTION] = {ACL_ERROR_RT_TS_ERROR, "debug aicore exception"};
    rtErrMap_[RT_ERROR_TSFW_DEBUG_AI_CORE_TIMEOUT] = {ACL_ERROR_RT_TS_ERROR, "debug aicore timeout"};
    rtErrMap_[RT_ERROR_TSFW_DEBUG_BREAKPOINT_FULL] = {ACL_ERROR_RT_TS_ERROR, "debug breakpoint full"};
    rtErrMap_[RT_ERROR_TSFW_DEBUG_READ_ERROR] = {ACL_ERROR_RT_TS_ERROR, "debug read error"};
    rtErrMap_[RT_ERROR_TSFW_DEBUG_WRITE_FAIL] = {ACL_ERROR_RT_TS_ERROR, "debug write fail"};
    rtErrMap_[RT_ERROR_TSFW_DEBUG_REGISTER_CONFLICT] = {ACL_ERROR_RT_TS_ERROR,
        "debug register conflict, only one pid can be registered at the same time"};
    rtErrMap_[RT_ERROR_TSFW_QUEUE_FULL] = {ACL_ERROR_RT_TS_ERROR, "ts queue full"};
    rtErrMap_[RT_ERROR_TSFW_QUEUE_EMPTY] = {ACL_ERROR_RT_TS_ERROR, "ts queue empty"};
    rtErrMap_[RT_ERROR_TSFW_QUEUE_ALLOC_MEM_FAIL] = {ACL_ERROR_RT_TS_ERROR, "ts queue alloc mem fail"};
    rtErrMap_[RT_ERROR_TSFW_QUEUE_DATA_SIZE_UNMATCH] = {ACL_ERROR_RT_TS_ERROR, "ts queue data size unmatch"};
    rtErrMap_[RT_ERROR_TSFW_PCIE_DMA_INVLD_CPY_TYPE] = {ACL_ERROR_RT_TS_ERROR, "pcie dma invalid copy type"};
    rtErrMap_[RT_ERROR_TSFW_INVLD_CPY_DIR] = {ACL_ERROR_RT_TS_ERROR, "copy dir invalid"};
    rtErrMap_[RT_ERROR_TSFW_PCIE_DMA_INVLD_CQ_DES] = {ACL_ERROR_RT_TS_ERROR, "pcie dma invalid cq des"};
    rtErrMap_[RT_ERROR_TSFW_PCIE_DMA_CPY_ERR] = {ACL_ERROR_RT_TS_ERROR, "pcie dma copy error"};
    rtErrMap_[RT_ERROR_TSFW_PCIE_DMA_LNK_CHN_BUSY] = {ACL_ERROR_RT_TS_ERROR, "pcie dma link channal busy"};
    rtErrMap_[RT_ERROR_TSFW_PROFILE_BUFF_FULL] = {ACL_ERROR_RT_PROFILING_ERROR, "profile buff full"};
    rtErrMap_[RT_ERROR_TSFW_PROFILE_MODE_CONFLICT] = {ACL_ERROR_RT_PROFILING_ERROR, "profile mode conflict"};
    rtErrMap_[RT_ERROR_TSFW_PROFILE_OTHER_PID_ON] = {ACL_ERROR_RT_PROFILING_ERROR, "profile other pid on"};
    rtErrMap_[RT_ERROR_TSFW_SCHD_AIC_TASK_PRELOAD_FAILED] = {ACL_ERROR_RT_TS_ERROR, "sched aic task preload failed"};
    rtErrMap_[RT_ERROR_TSFW_TSCPU_CLOSE_FAILED] = {ACL_ERROR_RT_TS_ERROR, "tscpu close failed"};
    rtErrMap_[RT_ERROR_TSFW_EXPECT_FAIL] = {ACL_ERROR_RT_TS_ERROR, "expect failed"};
    rtErrMap_[RT_ERROR_TSFW_REPEAT_MODEL_STREAM] = {ACL_ERROR_RT_TS_ERROR, "repeat model stream"};
    rtErrMap_[RT_ERROR_TSFW_STREAM_MODEL_UNBIND] = {ACL_ERROR_RT_TS_ERROR, "the model stream unbind failed"};
    rtErrMap_[RT_ERROR_TSFW_MODEL_EXE_FAILED] = {ACL_ERROR_RT_MODEL_EXECUTE, "the model stream execute failed"};
    rtErrMap_[RT_ERROR_TSFW_IPC_SEND_FAILED] = {ACL_ERROR_RT_IPC_ERROR, "ipc send failed"};
    rtErrMap_[RT_ERROR_TSFW_IPC_PROC_REG_FAILED] = {ACL_ERROR_RT_IPC_ERROR, "ipc process register failed"};
    rtErrMap_[RT_ERROR_TSFW_STREAM_FULL] = {ACL_ERROR_RT_STREAM_TASK_FULL, "stream sq full"};
    rtErrMap_[RT_ERROR_TSFW_END_OF_SEQUENCE] = {ACL_ERROR_RT_END_OF_SEQUENCE, "end of sequence"};
    rtErrMap_[RT_ERROR_TSFW_SWITCH_STREAM_LABEL] = {ACL_ERROR_RT_TS_ERROR, "switch stream label failed"};
    rtErrMap_[RT_ERROR_TSFW_TRANS_SQE_FAIL] = {ACL_ERROR_RT_TS_ERROR, "translate sqe fail"};
    rtErrMap_[RT_ERROR_TSFW_TASK_EXCEPTION] = {ACL_ERROR_RT_TS_ERROR, "task exception"};
    rtErrMap_[RT_ERROR_TSFW_TASK_TRAP] = {ACL_ERROR_RT_TS_ERROR, "task trap exception"};
    rtErrMap_[RT_ERROR_TSFW_TASK_TIMEOUT] = {ACL_ERROR_RT_TASK_TIMEOUT, "task timeout"};
    rtErrMap_[RT_ERROR_TSFW_TASK_SQE_ERROR] = {ACL_ERROR_RT_TS_ERROR, "task sqe error"};
    rtErrMap_[RT_ERROR_TSFW_TASK_BUS_ERROR] = {ACL_ERROR_RT_TS_ERROR, "task bus error"};
    rtErrMap_[RT_ERROR_TSFW_TASK_RES_CONFLICT_ERROR] = {ACL_ERROR_RT_TS_ERROR, "task res conflict error"};
    rtErrMap_[RT_ERROR_TSFW_TASK_SW_STATUS_ERROR] = {ACL_ERROR_RT_TS_ERROR, "task sw status error"};
    rtErrMap_[RT_ERROR_TSFW_AICORE_OVER_FLOW_FAIL] = {ACL_ERROR_RT_AICORE_OVER_FLOW, "aicore overflow"};
    rtErrMap_[RT_ERROR_TSFW_AIVEC_OVER_FLOW_FAIL] = {ACL_ERROR_RT_AIVEC_OVER_FLOW, "aivec overflow"};
    rtErrMap_[RT_ERROR_TSFW_AICPU_OVER_FLOW_FAIL] = {ACL_ERROR_RT_OVER_FLOW, "aicpu overflow"};
    rtErrMap_[RT_ERROR_TSFW_SDMA_OVER_FLOW_FAIL] = {ACL_ERROR_RT_OVER_FLOW, "sdma overflow"};
    rtErrMap_[RT_ERROR_TSFW_RESERVED] = {ACL_ERROR_RT_TS_ERROR, "tsfw unknown error"};
    rtErrMap_[RT_ERROR_TSFW_SDMA_COPY_ERROR] = {ACL_ERROR_RT_SYS_DMA, "sdma copy error"};
    rtErrMap_[RT_ERROR_TSFW_SDMA_REDUCE_ERROR] = {ACL_ERROR_RT_SYS_DMA, "sdma reduce error"};
    rtErrMap_[RT_ERROR_TSFW_AIC_TRAP_RD_OVERFLOW] = {ACL_ERROR_RT_AICORE_TRAP_READ_OVERFLOW,
        "aicore trap read overflow"};
    rtErrMap_[RT_ERROR_TSFW_AIC_TRAP_WR_OVERFLOW] = {ACL_ERROR_RT_AICORE_TRAP_WRITE_OVERFLOW,
        "aicore trap write overflow"};
    rtErrMap_[RT_ERROR_TSFW_AIV_TRAP_RD_OVERFLOW] = {ACL_ERROR_RT_VECTOR_CORE_TRAP_READ_OVERFLOW,
        "vector core trap read overflow"};
    rtErrMap_[RT_ERROR_TSFW_AIV_TRAP_WR_OVERFLOW] = {ACL_ERROR_RT_VECTOR_CORE_TRAP_WRITE_OVERFLOW,
        "vector core trap write overflow"};
    rtErrMap_[RT_ERROR_TSFW_FFTS_PLUS_TIMEOUT] = {ACL_ERROR_RT_FFTS_PLUS_TIMEOUT, "fftsplus timeout"};
    rtErrMap_[RT_ERROR_TSFW_FFTS_PLUS_EXCEPTION] = {ACL_ERROR_RT_FFTS_PLUS_EXCEPTION, "fftsplus exception"};
    rtErrMap_[RT_ERROR_TSFW_FFTS_PLUS_TRAP_EXCEPTION] = {ACL_ERROR_RT_FFTS_PLUS_TRAP_EXCEPTION,
        "fftsplus trap exception"};
    rtErrMap_[RT_ERROR_TSFW_TS_CLOSED] = {ACL_ERROR_RT_TS_ERROR, "In sentinel mode, tsfw is closed"};
    rtErrMap_[RT_ERROR_TSFW_TASK_ABORT_STOP] = {ACL_ERROR_RT_TASK_ABORT_STOP, "stream abort stop before post process"};
    // subscribe error
    rtErrMap_[RT_ERROR_SUBSCRIBE_BASE] = {ACL_ERROR_RT_INTERNAL_ERROR, "subscribe base error"};
    rtErrMap_[RT_ERROR_SUBSCRIBE_NULL] = {ACL_ERROR_RT_INTERNAL_ERROR, "subscribe pointer null"};
    rtErrMap_[RT_ERROR_SUBSCRIBE_NEW] = {ACL_ERROR_RT_MEMORY_ALLOCATION, "subscribe new memory error"};
    rtErrMap_[RT_ERROR_SUBSCRIBE_STREAM] = {ACL_ERROR_RT_STREAM_SUBSCRIBE, "subscribe stream error"};
    rtErrMap_[RT_ERROR_SUBSCRIBE_THREAD] = {ACL_ERROR_RT_THREAD_SUBSCRIBE, "subscribe thread error"};
    rtErrMap_[RT_ERROR_SUBSCRIBE_GROUP] = {ACL_ERROR_RT_INTERNAL_ERROR, "subscribe group error"};

    // group error
    rtErrMap_[RT_ERROR_GROUP_BASE] = {ACL_ERROR_RT_INTERNAL_ERROR, "group base error"};
    rtErrMap_[RT_ERROR_GROUP_NOT_SET] = {ACL_ERROR_RT_GROUP_NOT_SET, "group not set"};
    rtErrMap_[RT_ERROR_GROUP_NOT_CREATE] = {ACL_ERROR_RT_GROUP_NOT_CREATE, "group not create"};

    // aicpu error
    rtErrMap_[RT_ERROR_AICPU_BASE] = {ACL_ERROR_RT_INTERNAL_ERROR, "aicpu error base"};
    rtErrMap_[RT_ERROR_AICPU_INTERNAL_ERROR] = {ACL_ERROR_RT_AICPU_INTERNAL_ERROR, "aicpu internal error"};

    // cdq error
    rtErrMap_[RT_ERROR_CDQ_DUPLICATE_CREATION] = {ACL_ERROR_RT_PARAM_INVALID, "cdq duplicate create error"};
    rtErrMap_[RT_ERROR_CDQ_NOT_EXIST] = {ACL_ERROR_RT_PARAM_INVALID, "cdq not exist error"};
    rtErrMap_[RT_ERROR_CDQ_NAME_LEN_EXCEED] = {ACL_ERROR_RT_PARAM_INVALID, "cdq name length exceed limit"};
    rtErrMap_[RT_ERROR_CDQ_ALLOC_BATCH_TIME_OUT] = {ACL_ERROR_RT_WAIT_TIMEOUT, "cdq alloc batch timeout"};
    rtErrMap_[RT_ERROR_CDQ_NO_RESOURCES] = {ACL_ERROR_RT_NO_CDQ_RESOURCE, "cdq resources reach the maximum limit"};
    rtErrMap_[RT_ERROR_CDQ_CDQE_INDEX_EXCEED] = {ACL_ERROR_RT_PARAM_INVALID, "cdq cdqe index exceed limit"};
    rtErrMap_[RT_ERROR_CDQ_NULL] = {ACL_ERROR_RT_INTERNAL_ERROR, "cdq pointer is nullptr"};
    rtErrMap_[RT_ERROR_CDQ_NEW] = {ACL_ERROR_RT_INTERNAL_ERROR, "cdq new memory error"};
    rtErrMap_[RT_ERROR_CDQ_DATA_SIZE_EXCEED] = {ACL_ERROR_RT_PARAM_INVALID, "cdqe data length exceeds limit"};
    rtErrMap_[RT_ERROR_CDQ_BATCH_ABNORMAL] = {ACL_ERROR_RT_CDQ_BATCH_ABNORMAL, "cdq alloc batch abnormal"};

    /* wait timeout */
    rtErrMap_[RT_ERROR_WAIT_TIMEOUT] = {ACL_ERROR_RT_WAIT_TIMEOUT, "wait timeout"};

    // hccl op retry failed
    rtErrMap_[RT_ERROR_AICPU_HCCL_OP_RETRY_FAILED] = {ACL_ERROR_RT_COMM_OP_RETRY_FAIL, "hccl op retry failed"};

    // snapshot
    rtErrMap_[RT_ERROR_SNAPSHOT_LOCK_TIMEOUT] = {ACL_ERROR_SNAPSHOT_LOCK_TIMEOUT, "snapshot lock timeout"};
    rtErrMap_[RT_ERROR_SNAPSHOT_LOCK_FAILED] = {ACL_ERROR_SNAPSHOT_LOCK_FAILED, "snapshot lock failed"};
    rtErrMap_[RT_ERROR_SNAPSHOT_UNLOCK_FAILED] = {ACL_ERROR_SNAPSHOT_UNLOCK_FAILED, "snapshot unlock failed"};
    rtErrMap_[RT_ERROR_SNAPSHOT_BACKUP_FAILED] = {ACL_ERROR_SNAPSHOT_BACKUP_FAILED, "snapshot backup failed"};
    rtErrMap_[RT_ERROR_SNAPSHOT_RESTORE_FAILED] = {ACL_ERROR_SNAPSHOT_RESTORE_FAILED, "snapshot restore failed"};

    // register memory
    rtErrMap_[RT_ERROR_HOST_MEMORY_ALREADY_REGISTERED] = {ACL_ERROR_HOST_MEMORY_ALREADY_REGISTERED,
        "host memory range already registered"};
    rtErrMap_[RT_ERROR_HOST_MEMORY_NOT_REGISTERED] = {ACL_ERROR_HOST_MEMORY_NOT_REGISTERED,
        "host memory has not been registered"};  
}

void ErrorcodeManage::InitDrvErrCodeMap()
{
    drvErrMap_[DRV_ERROR_NONE] = RT_ERROR_NONE;
    drvErrMap_[DRV_ERROR_NO_DEVICE] = RT_ERROR_DRV_NO_DEVICE;
    drvErrMap_[DRV_ERROR_INVALID_DEVICE] = RT_ERROR_DRV_INVALID_DEVICE;
    drvErrMap_[DRV_ERROR_INVALID_VALUE] = RT_ERROR_DRV_INPUT;
    drvErrMap_[DRV_ERROR_INVALID_HANDLE] = RT_ERROR_DRV_INVALID_HANDLE;
    drvErrMap_[DRV_ERROR_INVALID_MALLOC_TYPE] = RT_ERROR_DRV_INVALID_MALLOC_TYPE;
    drvErrMap_[DRV_ERROR_OUT_OF_MEMORY] = RT_ERROR_DRV_OUT_MEMORY;
    drvErrMap_[DRV_ERROR_WAIT_TIMEOUT] = RT_ERROR_REPORT_TIMEOUT; // special for inner logic
    drvErrMap_[DRV_ERROR_SOCKET_CLOSE] = RT_ERROR_SOCKET_CLOSE;
    drvErrMap_[DRV_ERROR_SEND_MESG] = RT_ERROR_SEND_MSG;
    drvErrMap_[DRV_ERROR_BUS_DOWN] = RT_ERROR_LOST_HEARTBEAT; // special for inner logic
    drvErrMap_[DRV_ERROR_DEV_PROCESS_HANG] = RT_ERROR_DEVICE_PROC_HANG_OUT;
    drvErrMap_[DRV_ERROR_MALLOC_FAIL] = RT_ERROR_DRV_MALLOC_FAIL;
    drvErrMap_[DRV_ERROR_OPER_NOT_PERMITTED] = RT_ERROR_DRV_OPER_NOT_PERMITTED;
    drvErrMap_[DRV_ERROR_NO_EVENT_RESOURCES] = RT_ERROR_DRV_NO_EVENT_RESOURCES;
    drvErrMap_[DRV_ERROR_NO_STREAM_RESOURCES] = RT_ERROR_DRV_NO_STREAM_RESOURCES;
    drvErrMap_[DRV_ERROR_NO_NOTIFY_RESOURCES] = RT_ERROR_DRV_NO_NOTIFY_RESOURCES;
    drvErrMap_[DRV_ERROR_NO_MODEL_RESOURCES] = RT_ERROR_DRV_NO_MODEL_RESOURCES;
    drvErrMap_[DRV_ERROR_NOT_SUPPORT] = RT_ERROR_DRV_NOT_SUPPORT;
    drvErrMap_[DRV_ERROR_NO_CDQ_RESOURCES] = RT_ERROR_CDQ_NO_RESOURCES;
    drvErrMap_[DRV_ERROR_CDQ_NOT_EXIST] = RT_ERROR_CDQ_NOT_EXIST;
    drvErrMap_[DRV_ERROR_CDQ_ABNORMAL] = RT_ERROR_CDQ_BATCH_ABNORMAL;
    drvErrMap_[DRV_ERROR_OVER_LIMIT] = RT_ERROR_DRV_OVER_LIMIT;
    drvErrMap_[DRV_ERROR_QUEUE_EMPTY] = RT_ERROR_DRV_QUEUE_EMPTY;
    drvErrMap_[DRV_ERROR_QUEUE_FULL] = RT_ERROR_DRV_QUEUE_FULL;
    drvErrMap_[DRV_ERROR_REPEATED_INIT] = RT_ERROR_DRV_REPEATED_INIT;
    drvErrMap_[DRV_ERROR_IOCRL_FAIL] = RT_ERROR_DRV_IOCTRL;
    drvErrMap_[DRV_ERROR_NO_RESOURCES] = RT_ERROR_DRV_NO_RESOURCES;
    drvErrMap_[DRV_ERROR_COPY_USER_FAIL] = RT_ERROR_DRV_COPY_USER_FAIL;
    drvErrMap_[DRV_ERROR_MEMORY_OPT_FAIL] = RT_ERROR_DRV_MEMORY_OPT_FAIL;
}

RtInnerErrcodeType ErrorcodeManage::GetDrvErrCode(const DrvErrcodeType drvErrcode)
{
    const auto it = drvErrMap_.find(drvErrcode);
    if (it == drvErrMap_.end()) {
        return RT_ERROR_DRV_ERR;
    }

    return it->second;
}

RtExtErrcodeType ErrorcodeManage::GetRtExtErrCode(const RtInnerErrcodeType errcode)
{
    RtExtErrcodeType ret;
    if ((errcode == RT_ERROR_NONE) || (errcode == ACL_RT_SUCCESS)) {
        return ACL_RT_SUCCESS;
    }

    const auto it = rtErrMap_.find(errcode);
    if (it == rtErrMap_.end()) {
        if (errcode >= RT_ERRORCODE_BASE) {
            ret = ACL_ERROR_RT_INTERNAL_ERROR;
            return ret;
        } else {
            ret = errcode;
            return ret;  // protect for externel errorcode,in callback situation
        }
    }
    ret = it->second.first;
    return ret;
}

RtExtErrcodeType ErrorcodeManage::TransExtErrCode(const RtInnerErrcodeType errcode)
{
    if ((errcode == RT_ERROR_NONE) || (errcode == ACL_RT_SUCCESS)) {
        return ACL_RT_SUCCESS;
    }
    const auto it = rtErrMap_.find(errcode);
    if (it == rtErrMap_.end()) {
        if (errcode >= RT_ERRORCODE_BASE) {
            return ACL_ERROR_RT_INTERNAL_ERROR;
        } else {
            return errcode;  // protect for externel errorcode,in callback situation
        }
    }
    return it->second.first;
}

std::string ErrorcodeManage::GetErrorDesc(const RtInnerErrcodeType errcode)
{
    std::stringstream ss;
    const auto it = rtErrMap_.find(errcode);
    if (it == rtErrMap_.end()) {
        if (errcode >= RT_ERRORCODE_BASE) {
            ss << "ErrCode=";
            ss << ACL_ERROR_RT_INTERNAL_ERROR;
            ss << ", desc=[runtime internel error]";
            ss << ", InnerCode=0x";
            ss << std::hex << errcode;
            return ss.str();
        } else {
            ss << "ErrCode=";
            ss << errcode;
            ss << ", desc=[callback error]";
            return ss.str();  // protect for externel errorcode,in callback situation
        }
    }

    ss << "ErrCode=";
    ss << it->second.first;
    ss << ", desc=[";
    ss << it->second.second;
    ss << "], InnerCode=0x";
    ss << std::hex << errcode;
    return ss.str();
}

std::string ErrorcodeManage::GetErrorReason(const RtInnerErrcodeType errcode)
{
    std::stringstream ss;
    const auto it = rtErrMap_.find(errcode);
    if (it == rtErrMap_.end()) {
        if (errcode >= RT_ERRORCODE_BASE) {
            ss << "[runtime internel error]";
            return ss.str();
        } else {
            ss << "[callback error]";
            return ss.str();  // protect for externel errorcode,in callback situation
        }
    }
    ss << "[" << it->second.second << "]";
    return ss.str();
}
}
}
