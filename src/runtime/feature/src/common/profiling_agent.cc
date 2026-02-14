/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "profiling_agent.hpp"
#include "api.hpp"
#include "base.hpp"
#include "task.hpp"

namespace cce {
namespace runtime {
ProfilingAgent &ProfilingAgent::Instance()
{
    static ProfilingAgent insAgent;
    return insAgent;
}

void ProfilingAgent::SetMsprofReporterCallback(MsprofReporterCallback const callback)
{
    profReporterCallback_ = callback;
}

MsprofReporterCallback ProfilingAgent::GetMsprofReporterCallback() const
{
    return profReporterCallback_;
}

rtError_t ProfilingAgent::RegisterProfTypeInfo() const
{
    ProfTypeRegisterInfo registerInfo[] = {
        // task type, register task type and task name for parse, or profiling don't get task name
        {TS_TASK_TYPE_KERNEL_AICORE, "KERNEL_AICORE"},
        {TS_TASK_TYPE_KERNEL_MIX_AIC, "KERNEL_MIX_AIC"},
        {TS_TASK_TYPE_KERNEL_MIX_AIV, "KERNEL_MIX_AIV"}, 
        {TS_TASK_TYPE_KERNEL_AICPU, "KERNEL_AICPU"},
        {TS_TASK_TYPE_EVENT_RECORD, "EVENT_RECORD"},
        {TS_TASK_TYPE_STREAM_WAIT_EVENT, "EVENT_WAIT"},
        {TS_TASK_TYPE_FUSION_ISSUE, "KERNEL_FUSION"},
        {TS_TASK_TYPE_MEMCPY, "MEMCPY_ASYNC"},
        {TS_TASK_TYPE_MAINTENANCE, "MAINTENANCE"},
        {TS_TASK_TYPE_CREATE_STREAM, "CREATE_STREAM"},
        {TS_TASK_TYPE_DATA_DUMP, "reserve"}, // reserve but not support task type
        {TS_TASK_TYPE_REMOTE_EVENT_WAIT, "REMOTE_EVENT_WAIT"},
        {TS_TASK_TYPE_PCTRACE_ENABLE, "PC_TRACE"},
        {TS_TASK_TYPE_CREATE_L2_ADDR, "CREATE_L2_ADDR"},
        {TS_TASK_TYPE_MODEL_MAINTAINCE, "MODEL_MAINTAINCE"},
        {TS_TASK_TYPE_MODEL_EXECUTE, "MODEL_EXECUTE"},
        {TS_TASK_TYPE_NOTIFY_WAIT, "NOTIFY_WAIT"},
        {TS_TASK_TYPE_NOTIFY_RECORD, "NOTIFY_RECORD"},
        {TS_TASK_TYPE_RDMA_SEND, "RDMA_SEND"},
        {TS_TASK_TYPE_STREAM_SWITCH, "STREAM_SWITCH"},
        {TS_TASK_TYPE_STREAM_ACTIVE, "STREAM_ACTIVE"},
        {TS_TASK_TYPE_LABEL_SET, "LABEL_SET"},
        {TS_TASK_TYPE_LABEL_SWITCH, "LABEL_SWITCH"},
        {TS_TASK_TYPE_LABEL_GOTO, "LABEL_GOTO"},
        {TS_TASK_TYPE_PROFILER_TRACE, "PROFILER_TRACE"},
        {TS_TASK_TYPE_EVENT_RESET, "EVENT_RESET"},
        {TS_TASK_TYPE_RDMA_DB_SEND, "RDMA_DB_SEND"},
        {TS_TASK_TYPE_PROFILER_TRACE_EX, "PROFILER_TRACE_EX"},
        {TS_TASK_TYPE_STARS_COMMON, "STARS_COMMON"},
        {TS_TASK_TYPE_FFTS_PLUS, "FFTS_PLUS"},
        {TS_TASK_TYPE_CMO, "CMO"},
        {TS_TASK_TYPE_BARRIER, "BARRIER"},
        {TS_TASK_TYPE_WRITE_VALUE, "WriteValueTask"},
        {TS_TASK_TYPE_MULTIPLE_TASK, "MULTIPLE_TASK"},
        {TS_TASK_TYPE_PROFILING_ENABLE, "PROFILING_ENABLE"},
        {TS_TASK_TYPE_PROFILING_DISABLE, "PROFILING_DISABLE"},
        {TS_TASK_TYPE_KERNEL_AIVEC, "KERNEL_AIVEC"},
        {TS_TASK_TYPE_MODEL_END_GRAPH, "MODEL_END_GRAPH"},
        {TS_TASK_TYPE_MODEL_TO_AICPU, "MODEL_TO_AICPU"},
        {TS_TASK_TYPE_ACTIVE_AICPU_STREAM, "ACTIVE_AICPU_STREAM"},
        {TS_TASK_TYPE_DATADUMP_LOADINFO, "DATADUMP_LOADINFO"},
        {TS_TASK_TYPE_STREAM_SWITCH_N, "STREAM_SWITCH_N"},
        {TS_TASK_TYPE_HOSTFUNC_CALLBACK, "HOSTFUNC_CALLBACK"},
        {TS_TASK_TYPE_ONLINEPROF_START, "ONLINE_PROF_ENABLE"},
        {TS_TASK_TYPE_ONLINEPROF_STOP, "ONLINE_PROF_DISABLE"},
        {TS_TASK_TYPE_STREAM_LABEL_SWITCH_BY_INDEX, "STREAM_LABEL_SWITCH_BY_INDEX"},
        {TS_TASK_TYPE_STREAM_LABEL_GOTO, "STREAM_LABEL_GOTO"},
        {TS_TASK_TYPE_DEBUG_REGISTER, "DEBUG_REGISTER"},
        {TS_TASK_TYPE_DEBUG_UNREGISTER, "DEBUG_UNREGISTER"},
        {TS_TASK_TYPE_FUSIONDUMP_ADDR_SET, "FUSIONDUMP_ADDR_SET"},
        {TS_TASK_TYPE_MODEL_EXIT_GRAPH, "MODEL_EXIT_GRAPH"},
        {TS_TASK_TYPE_ADCPROF, "ADC_PROF"},
        {TS_TASK_TYPE_DEVICE_RINGBUFFER_CONTROL, "DEVICE_RINGBUFFER_CONTROL"},
        {TS_TASK_TYPE_DEBUG_REGISTER_FOR_STREAM, "DEBUG_REGISTER_FOR_STREAM"},
        {TS_TASK_TYPE_DEBUG_UNREGISTER_FOR_STREAM, "DEBUG_UNREGISTER_FOR_STREAM"},
        {TS_TASK_TYPE_TASK_TIMEOUT_SET, "TASK_TIMEOUT_SET"},
        {TS_TASK_TYPE_GET_DEVICE_MSG, "GET_DEVICE_MSG"},
        {TS_TASK_TYPE_NPU_GET_FLOAT_STATUS, "NPU_GET_FLOAT_STATUS"},
        {TS_TASK_TYPE_NPU_CLEAR_FLOAT_STATUS, "NPU_CLEAR_FLOAT_STATUS"},
        {TS_TASK_TYPE_MEMCPY_ASYNC_WITHOUT_SDMA, "reserve"}, // reserve but not support task type
        {TS_TASK_TYPE_SET_OVERFLOW_SWITCH, "OVERFLOW_SWTICH_SET"},
        {TS_TASK_TYPE_REDUCE_ASYNC_V2, "REDUCE_ASYNC_V2"},
        {TS_TASK_TYPE_SET_STREAM_GE_OP_TAG, "STREAM_TAG_SET"},
        {TS_TASK_TYPE_SET_STREAM_MODE, "SET_STREAM_MODE"},
        {TS_TASK_TYPE_IPCINT_NOTICE, "IPC_INT_NOTICE"},
        {TS_TASK_TYPE_MODEL_LOAD, "reserve"}, // reserve but not support task type
        {TS_TASK_TYPE_ALLOC_DSA_ADDR, "ALLOC_DSA_ADDR"},
        {TS_TASK_TYPE_FLIP, "FLIP_TASK"},
        {TS_TASK_TYPE_MODEL_TASK_UPDATE, "MODEL_TASK_UPDATE"},
        {TS_TASK_TYPE_AICPU_INFO_LOAD, "AICPU_LOADINFO"},
        {TS_TASK_TYPE_NOP, "NOP"},
        {TS_TASK_TYPE_GET_STARS_VERSION, "GET_STARS_VERSION"},
        {TS_TASK_TYPE_MEM_WRITE_VALUE, "MEM_WRITE_VALUE"},
        {TS_TASK_TYPE_MEM_WAIT_VALUE, "MEM_WAIT_VALUE"},
        {TS_TASK_TYPE_RDMA_PI_VALUE_MODIFY, "RDMA_PI_VALUE_MODIFY"},
        {TS_TASK_TYPE_DAVID_EVENT_RECORD, "DAVID_EVENT_RECORD"},
        {TS_TASK_TYPE_DAVID_EVENT_WAIT, "DAVID_EVENT_WAIT"},
        {TS_TASK_TYPE_DAVID_EVENT_RESET, "DAVID_EVENT_RESET"},
        {TS_TASK_TYPE_CCU_LAUNCH, "CCU_LAUNCH"},
        {TS_TASK_TYPE_FUSION_KERNEL, "KERNEL_FUSION"},
        {TS_TASK_TYPE_CAPTURE_RECORD, "CAPTURE_RECORD"},
        {TS_TASK_TYPE_CAPTURE_WAIT, "CAPTURE_WAIT"},
        {TS_TASK_TYPE_IPC_RECORD, "IPC_EVENT_RECORD"},
        {TS_TASK_TYPE_IPC_WAIT, "IPC_EVENT_WAIT"},
        {TS_TASK_TYPE_TASK_SQE_UPDATE, "TASK_SQE_UPDATE"},
        // memcpy info
        {RT_PROFILE_TYPE_MEMCPY_INFO, "memcpy_info"},

        // task track
        {RT_PROFILE_TYPE_TASK_TRACK, "task_track"},
        // capture stream info
        {RT_PROFILE_TYPE_CAPTURE_STREAM_INFO, "capture_stream_info"},
        // expand stream spec
        {RT_PROFILE_TYPE_SOFTWARE_SQ_ENABLE, "expand_stream_spec"},
        // capture last task op info
        {RT_PROFILE_TYPE_SHAPE_INFO, "capture_op_info"},

        // api, RT_PROFILE_TYPE_API_BEGIN + rtProfApiType_t
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_DEVBINARY_REGISTER), "DevBinaryRegister"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_ALLKERNEL_REGISTER), "RegisterAllKernel"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_DEVBINARY_UNREGISTER), "DevBinaryUnRegister"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_FUNCTION_REGISTER), "FunctionRegister"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_GET_FUNCTION_BY_NAME), "GetFunctionByName"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_QUERY_FUNCTION_REGISTERED), "QueryFunctionRegistered"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_KERNEL_FUSION_START), "KernelFusionStart"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_KERNEL_FUSION_END), "KernelFusionEnd"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_KERNEL_LAUNCH_HUGE), "KernelLaunch_Huge"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_KERNEL_LAUNCH_BIG), "KernelLaunch_Big"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_KERNEL_LAUNCH), "KernelLaunch"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_KERNEL_LAUNCH_FLOW_CTRL), "KernelLaunchFlowCtrl"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_KERNEL_LAUNCH_WITH_HANDLE_HUGE), "KernelLaunchWithHandle_Huge"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_KERNEL_LAUNCH_WITH_HANDLE_BIG), "KernelLaunchWithHandle_Big"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_KERNEL_LAUNCH_WITH_HANDLE), "KernelLaunchWithHandle"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_KERNEL_LAUNCH_WITH_HANDLE_FLOW_CTRL), "KernelLaunchWithHandleFlowCtrl"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_KERNEL_LAUNCH_EX), "KernelLaunchEx"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_CpuKernelLaunch), "CpuKernelLaunch"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_CpuKernelLaunch_EX), "CpuKernelLaunchEx"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_CpuKernelLaunch_EX_WITH_ARG), "CpuKernelLaunchExWithArgs"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_DATA_DUMP_INFO_LOAD), "DatadumpInfoLoad"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_STREAM_CREATE), "StreamCreate"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_STREAM_DESTROY), "StreamDestroy"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_STREAM_WAITEVENT), "StreamWaitEvent"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_STREAM_SYNCHRONIZE), "StreamSynchronize"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_STREAM_SET_MODE), "SetStreamMode"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_STREAM_GET_MODE), "GetStreamMode"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_EVENT_CREATE), "EventCreate"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_EVENT_CREATE_FOR_NOTIFY), "EventCreateForNotify"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_GetEventID), "GetEventID"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_EVENT_DESTROY), "EventDestroy"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_EVENT_RECORD), "EventRecord"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_EVENT_RECORD_FOR_NOTIFY), "EventRecordForNotify"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_EVENT_SYNCHRONIZE), "EventSynchronize"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_DEV_MALLOC), "DevMalloc"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_DEV_FREE), "DevFree"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_CAHCEDMEM_ALLOC), "DevMallocCached"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_DEV_DVPP_MALLOC), "DevDvppMalloc"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_DEV_DVPP_FREE), "DevDvppFree"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_MEM_ADVISE), "MemAdvise"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_HOST_MALLOC), "HostMalloc"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_HOST_FREE), "HostFree"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_MANAGEDMEM_ALLOC), "ManagedMemAlloc"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_MANAGEDMEM_FREE), "ManagedMemFree"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_MEM_CPY), "MemCopySync"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_MEMCPY_ASYNC_HUGE), "MemcpyAsync_Huge"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_MEMCPY_ASYNC), "MemcpyAsync"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_MEMCPY_ASYNC_BATCH), "MemcpyBatchAsync"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_LAUNCH_HOST_CALLBACK), "LaunchHostFunc"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_GET_EVENT_HANDLE), "IpcGetEventHandle"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_OPEN_EVENT_HANDLE), "IpcOpenEventHandle"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_MEMCPY_ASYNC_FLOW_CTRL), "MemcpyAsyncFlowCtrl"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_ReduceAsync), "ReduceAsync"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_REDUCE_ASYNC_V2), "ReduceAsyncV2"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_MEM_CPY2D), "MemCopy2DSync"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_MEM_CPY2D_ASYNC), "MemCopy2DAsync"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_HOST_TASK_MEMCPY), "MemcpyHostTask"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_SET_DEVICE), "SetDevice"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_DEVICE_RESET), "DeviceReset"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_DEVICE_SYNCHRONIZE), "DeviceSynchronize"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_CONTEXT_CREATE), "ContextCreate"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_CONTEXT_DESTROY), "ContextDestroy"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_CONTEXT_GET_CURRENT), "ContextGetCurrent"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_CONTEXT_SETCURRENT), "ContextSetCurrent"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_CONTEXT_SYNCHRONIZE), "ContextSynchronize"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_MODEL_CREATE), "ModelCreate"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_MODEL_SET_EXT_ID), "ModelSetExtId"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_MODEL_DESTROY), "ModelDestroy"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_MODEL_BIND_STREAM), "ModelBindStream"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_MODEL_UNBIND_STREAM), "ModelUnbindStream"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_MODEL_EXECUTE), "ModelExecute"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_RDMASend), "RDMASend"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_RdmaDbSend), "RdmaDbSend"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_NotifyCreate), "NotifyCreate"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_NotifyDestroy), "NotifyDestroy"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_NotifyRecord), "NotifyRecord"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_NotifyWait), "NotifyWait"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_IpcOpenNotify), "IpcOpenNotify"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_MODEL_SET_SCH_GROUP_ID), "ModelSetSchGroupId"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_rtSubscribeReport), "SubscribeReport"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_rtCallbackLaunch), "CallbackLaunch"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_rtProcessReport), "ProcessReport"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_rtUnSubscribeReport), "UnSubscribeReport"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_rtGetRunMode), "GetRunMode"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_LabelSwitchByIndex), "LabelSwitchByIndex"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_LabelGotoEx), "LabelGotoEx"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_Label2Content), "LabelListCpy"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_STARS_TASK_LAUNCH), "StarsTaskLaunch"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_FFTS_PLUS_TASK_LAUNCH), "FftsPlusTaskLaunch"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_LABELDESTROY), "LabelDestroy"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_CMO_TASK_LAUNCH), "CmoTaskLaunch"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_BARRIER_TASK_LAUNCH), "BarrierTaskLaunch"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_STREAM_SYNC_TASK_FINISH), "StreamSyncTaskFinish"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_GET_NOTIFY_ADDR), "GetNotifyAddress"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_BUFF_GET_INFO), "BuffGetInfo"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_BINARY_LOAD), "BinaryLoad"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_BINARY_GET_FUNCTION), "BinaryGetFunction"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_BINARY_UNLOAD), "BinaryUnLoad"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_LAUNCH_KERNEL), "LaunchKernel"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_CtxSetSysParamOpt), "CtxSetSysParamOpt"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_CtxGetSysParamOpt), "CtxGetSysParamOpt"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_CtxGetOverflowAddr), "CtxGetOverflowAddr"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_GetDeviceSatStatus), "GetDeviceSatStatus"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_CleanDeviceSatStatus), "CleanDeviceSatStatus"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_CpuKernelLaunch_EX_WITH_ARG_BIG), "CpuKernelLaunchExWithArgs_Big"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_CpuKernelLaunch_EX_WITH_ARG_HUGE), "CpuKernelLaunchExWithArgs_Huge"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_LAUNCH_KERNEL_HUGE), "LaunchKernel_Huge"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_LAUNCH_KERNEL_BIG), "LaunchKernel_Big"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_GET_DEV_ARG_ADDR), "GetDevArgsAddr"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_BINARY_GET_FUNCTION_BY_NAME), "BinaryGetFunctionByName"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_BINARY_LOAD_WITHOUT_TILING_KEY), "BinaryLoadWithoutTilingKey"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_CMO_ADDR_TASK_LAUNCH), "CmoAddrTaskLaunch"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_EVENT_CREATE_EX), "EventCreateEx"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_AI_CPU_INFO_LOAD), "AicpuInfoLoad"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_MODEL_TASK_UPDATE), "ModelTaskUpdate"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_STREAM_CLEAR), "StreamClear"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_NOTIFY_RESET), "NotifyReset"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_GetServerIDBySDID), "GetServerIDBySDID"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_KERNEL_LAUNCH_LARGE), "KernelLaunch_Large"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_KERNEL_LAUNCH_WITH_HANDLE_LARGE), "KernelLaunchWithHandle_Large"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_CpuKernelLaunch_EX_WITH_ARG_LARGE), "CpuKernelLaunchExWithArgs_Large"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_LAUNCH_KERNEL_LARGE), "LaunchKernel_Large"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_DEVICE_RESET_FORCE), "DeviceResetForce"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_MEM_CPY_ASYNC_PTR), "MemcpyAsyncPtr"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_USER_TO_LOGIC_ID), "GetLogicDevIdByUserDevId"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_LOGIC_TO_USER_ID), "GetUserDevIdByLogicDevId"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_BINARY_LOAD_FROM_FILE), "BinaryLoadFromFile"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_BINARY_LOAD_FROM_DATA), "BinaryLoadFromData"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_FUNC_GET_ADDR), "FuncGetAddr"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_LAUNCH_DVPP_TASK), "LaunchDvppTask"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_LAUNCH_RANDOM_NUM_TASK), "LaunchRandomNumTask"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_KERNEL_ARGS_INIT), "KernelArgsInit"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_KERNEL_ARGS_APEND_PLACE_HOLDER), "KernelArgsApendPlaceHolder"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_KERNEL_ARGS_GET_PLACE_HOLDER_BUFF), "KernelArgsGetPlaceHolderBuff"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_KERNEL_ARGS_GET_HANDLE_MEM_SIZE), "KernelArgsGetHandleMemSize"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_KERNEL_ARGS_FINALIZE), "KernelArgsFinalize"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_KERNEL_ARGS_GET_MEM_SIZE), "KernelArgsGetMemSize"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_KERNEL_ARGS_INIT_BY_USER_MEM), "KernleArgsInitByUserMem"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_KERNEL_ARGS_APEND), "KernelArgsApend"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_LAUNCH_KERNEL_V2), "LaunchKernelV2"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_BINARY_GET_FUNCTION_BY_ENTRY), "BinaryGetFunctionByEntry"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_UB_DB_SEND), "UbDbSend"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_UB_DIRECT_SEND), "UbDirectSend"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_MEMCPY_BATCH), "MemcpyBatch"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_GET_CMO_DESC_SIZE), "GetCmoDesc"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_SET_CMO_DESC), "SetCmoDesc"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_MODEL_EXECUTE_SYNC), "ModelExecuteSync"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_MODEL_EXECUTE_ASYNC), "ModelExecuteASync"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_MEM_WRITE_VALUE), "MemWriteValue"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_MEM_WAIT_VALUE), "MemWaitValue"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_GET_DEFAULT_CTX_STATE), "GetPrimaryCtxState"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_COUNT_NOTIFY_CREATE), "CntNotifyCreate"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_COUNT_NOTIFY_DESTROY), "CntNotifyDestroy"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_COUNT_NOTIFY_RECORD), "CntNotifyRecord"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_COUNT_NOTIFY_WAIT), "CntNotifyWaitWithTimeout"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_GET_COUNT_NOTIFY_ADDR), "GetCntNotifyAddress"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_GET_COUNT_NOTIFY_RESET), "CntNotifyReset"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_WRITE_VALUE), "WriteValue"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_FUSION_KERNEL_LAUNCH), "FusionLaunch"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_CCU_LAUNCH), "CCULaunch"},
        {static_cast<uint32_t>(RT_PROFILE_TYPE_API_BEGIN) + static_cast<uint32_t>(RT_PROF_API_CACHE_LAST_TASK_OP_INFO), "CacheLastTaskOpInfo"},
    };

    for (uint32_t i = 0U; i< sizeof(registerInfo) / sizeof(ProfTypeRegisterInfo); i++) {
        const int32_t ret = MsprofRegTypeInfo(MSPROF_REPORT_RUNTIME_LEVEL, registerInfo[i].type, registerInfo[i].name);
        if (ret != MSPROF_ERROR_NONE) {
            RT_LOG_CALL_MSG(ERR_MODULE_PROFILE, "Profiling register runtime task track failed, ret=%d.", ret);
            return RT_ERROR_PROF_OPER;
        }
    }

    return RT_ERROR_NONE;
}

rtError_t ProfilingAgent::Init() const
{
    int32_t initRet = MsprofReportData(MSPROF_MODULE_RUNTIME, MSPROF_REPORTER_INIT, nullptr, 0U);
    if (initRet != MSPROF_ERROR_NONE) {
        RT_LOG_CALL_MSG(ERR_MODULE_PROFILE, "Profiling reporter init failed, ret=%d.", initRet);
        return RT_ERROR_PROF_OPER;
    }

    initRet = RegisterProfTypeInfo();
    if (initRet != RT_ERROR_NONE) {
        RT_LOG_CALL_MSG(ERR_MODULE_PROFILE, "Register profiling type info failed, ret=%d.", initRet);
        return RT_ERROR_PROF_OPER;
    }
    RT_LOG(RT_LOG_INFO, "Profiling reporter init success.");
    return RT_ERROR_NONE;
}

rtError_t ProfilingAgent::UnInit() const
{
    const int32_t initRet = MsprofReportData(MSPROF_MODULE_RUNTIME, MSPROF_REPORTER_UNINIT, nullptr, 0U);
    if (initRet != MSPROF_ERROR_NONE) {
        RT_LOG_CALL_MSG(ERR_MODULE_PROFILE, "Profiling reporter uninit failed, ret=%d.", initRet);
        return RT_ERROR_PROF_OPER;
    }
    RT_LOG(RT_LOG_INFO, "Profiling reporter uninit success.");
    return RT_ERROR_NONE;
}

void ProfilingAgent::ReportProfApi(const uint32_t devId, RuntimeProfApiData &profApiData) const
{
    // for api
    MsprofApi apiInfo{};
    apiInfo.level = MSPROF_REPORT_RUNTIME_LEVEL;
    apiInfo.type = profApiData.profileType + RT_PROFILE_TYPE_API_BEGIN;
    apiInfo.beginTime = profApiData.entryTime;
    apiInfo.endTime = profApiData.exitTime;
    apiInfo.threadId = profApiData.threadId;
    const int32_t ret = MsprofReportApi(true, &apiInfo);
    if (ret != MSPROF_ERROR_NONE) {
        RT_LOG_CALL_MSG(ERR_MODULE_PROFILE, "Profiling reporter report api failed, devId=%u,ret=%d.", devId, ret);
        return;
    }

    if (profApiData.dataSize != 0) {
        // for memcpy info,use MsprofReportCompactInfo
        MsprofCompactInfo compactInfo{};
        compactInfo.level = MSPROF_REPORT_RUNTIME_LEVEL;
        compactInfo.type = RT_PROFILE_TYPE_MEMCPY_INFO; // memcpy info
        compactInfo.threadId = profApiData.threadId;
        compactInfo.timeStamp = profApiData.entryTime + 1;
        compactInfo.dataLen = static_cast<uint32_t>(sizeof(RuntimeMemcpyInfo));
        RtPtrToPtr<RuntimeMemcpyInfo *>(compactInfo.data.info)->dateSize = profApiData.dataSize;
        RtPtrToPtr<RuntimeMemcpyInfo *>(compactInfo.data.info)->maxSize = profApiData.maxSize;
        RtPtrToPtr<RuntimeMemcpyInfo *>(compactInfo.data.info)->direction = profApiData.memcpyDirection;

        const int32_t res =
            MsprofReportCompactInfo(true, &compactInfo, static_cast<uint32_t>(sizeof(MsprofCompactInfo)));
        if (res != MSPROF_ERROR_NONE) {
            RT_LOG_CALL_MSG(ERR_MODULE_PROFILE, "Profiling reporter report memcpy info failed, ret=%d.", ret);
            return;
        }
    }
}

RuntimeProfApiData &ProfilerGetProfApiData(void)
{
    static thread_local RuntimeProfApiData profApiData{};
    return profApiData;
}

TaskTrackInfo &ProfilerGetProfTaskTrackData(void)
{
    static thread_local TaskTrackInfo taskInfo{};
    return taskInfo;
}
}
}
