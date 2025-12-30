/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "profiling_manager.h"
#include "mmpa/mmpa_api.h"
#include "common/log_inner.h"
#include "common/prof_reporter.h"


namespace acl {
    const std::map<AclProfType, std::string> PROF_TYPE_TO_NAMES = {
        {AclProfType::AclmdlRIExecuteAsync,                     "aclmdlRIExecuteAsync"},
        {AclProfType::AclmdlRIDestroy,                          "aclmdlRIDestroy"},
        {AclProfType::AclmdlRICaptureBegin,                     "aclmdlRICaptureBegin"},
        {AclProfType::AclmdlRICaptureGetInfo,                   "aclmdlRICaptureGetInfo"},
        {AclProfType::AclmdlRICaptureEnd,                       "aclmdlRICaptureEnd"},
        {AclProfType::AclmdlRIDebugPrint,                       "aclmdlRIDebugPrint"},
        {AclProfType::AclmdlRIDebugJsonPrint,                   "aclmdlRIDebugJsonPrint"},
        {AclProfType::AclmdlRICaptureThreadExchangeMode,        "aclmdlRICaptureThreadExchangeMode"},
        {AclProfType::AclmdlRICaptureTaskGrpBegin,              "aclmdlRICaptureTaskGrpBegin"},
        {AclProfType::AclmdlRICaptureTaskGrpEnd,                "aclmdlRICaptureTaskGrpEnd"},
        {AclProfType::AclmdlRICaptureTaskUpdateBegin,           "aclmdlRICaptureTaskUpdateBegin"},
        {AclProfType::AclmdlRICaptureTaskUpdateEnd,             "aclmdlRICaptureTaskUpdateEnd"},
        {AclProfType::AclCreateDataBuffer,                      "aclCreateDataBuffer"},
        {AclProfType::AclrtLaunchCallback,                      "aclrtLaunchCallback"},
        {AclProfType::AclrtProcessReport,                       "aclrtProcessReport"},
        {AclProfType::AclrtCreateContext,                       "aclrtCreateContext"},
        {AclProfType::AclrtDestroyContext,                      "aclrtDestroyContext"},
        {AclProfType::AclrtSetCurrentContext,                   "aclrtSetCurrentContext"},
        {AclProfType::AclrtGetCurrentContext,                   "aclrtGetCurrentContext"},
        {AclProfType::AclrtSetDevice,                           "aclrtSetDevice"},
        {AclProfType::AclrtSetDeviceWithoutTsdVXX,              "aclrtSetDeviceWithoutTsdVXX"},
        {AclProfType::AclrtResetDevice,                         "aclrtResetDevice"},
        {AclProfType::AclrtResetDeviceForce,                    "aclrtResetDeviceForce"},
        {AclProfType::AclrtResetDeviceWithoutTsdVXX,            "aclrtResetDeviceWithoutTsdVXX"},
        {AclProfType::AclrtSynchronizeDevice,                   "aclrtSynchronizeDevice"},
        {AclProfType::AclrtSynchronizeDeviceWithTimeout,        "aclrtSynchronizeDeviceWithTimeout"},
        {AclProfType::AclrtSetTsDevice,                         "aclrtSetTsDevice"},
        {AclProfType::AclrtCreateEvent,                         "aclrtCreateEvent"},
        {AclProfType::AclrtCreateEventWithFlag,                 "aclrtCreateEventWithFlag"},
        {AclProfType::AclrtCreateEventExWithFlag,               "aclrtCreateEventExWithFlag"},
        {AclProfType::AclrtDestroyEvent,                        "aclrtDestroyEvent"},
        {AclProfType::AclrtRecordEvent,                         "aclrtRecordEvent"},
        {AclProfType::AclrtResetEvent,                          "aclrtResetEvent"},
        {AclProfType::AclrtQueryEvent,                          "aclrtQueryEvent"},
        {AclProfType::AclrtQueryEventStatus,                    "aclrtQueryEventStatus"},
        {AclProfType::AclrtQueryEventWaitStatus,                "aclrtQueryEventWaitStatus"},
        {AclProfType::AclrtSynchronizeEvent,                    "aclrtSynchronizeEvent"},
        {AclProfType::AclrtSetOpWaitTimeout,                    "aclrtSetOpWaitTimeout"},
        {AclProfType::AclrtSetOpExecuteTimeOut,                 "aclrtSetOpExecuteTimeOut"},
        {AclProfType::AclrtSetOpExecuteTimeOutWithMs,           "aclrtSetOpExecuteTimeOutWithMs"},
        {AclProfType::AclrtSetGroup,                            "aclrtSetGroup"},
        {AclProfType::AclrtGetGroupCount,                       "aclrtGetGroupCount"},
        {AclProfType::AclrtGetAllGroupInfo,                     "aclrtGetAllGroupInfo"},
        {AclProfType::AclrtGetGroupInfoDetail,                  "aclrtGetGroupInfoDetail"},
        {AclProfType::AclMallocMemInner,                        "aclMallocMemInner"},
        {AclProfType::AclrtMallocCached,                        "aclrtMallocCached"},
        {AclProfType::AclrtMemFlush,                            "aclrtMemFlush"},
        {AclProfType::AclrtMemInvalidate,                       "aclrtMemInvalidate"},
        {AclProfType::AclrtFree,                                "aclrtFree"},
        {AclProfType::AclrtMallocHost,                          "aclrtMallocHost"},
        {AclProfType::AclrtFreeHost,                            "aclrtFreeHost"},
        {AclProfType::AclrtMemcpy,                              "aclrtMemcpy"},
        {AclProfType::AclrtMemset,                              "aclrtMemset"},
        {AclProfType::AclrtMemcpyAsync,                         "aclrtMemcpyAsync"},
        {AclProfType::AclrtMemcpyAsyncWithCondition,            "aclrtMemcpyAsyncWithCondition"},
        {AclProfType::AclrtMemsetAsync,                         "aclrtMemsetAsync"},
        {AclProfType::AclrtDeviceCanAccessPeer,                 "aclrtDeviceCanAccessPeer"},
        {AclProfType::AclrtDeviceEnablePeerAccess,              "aclrtDeviceEnablePeerAccess"},
        {AclProfType::AclrtDeviceDisablePeerAccess,             "aclrtDeviceDisablePeerAccess"},
        {AclProfType::AclrtGetMemInfo,                          "aclrtGetMemInfo"},
        {AclProfType::AclrtMemcpy2d,                            "aclrtMemcpy2d"},
        {AclProfType::AclrtMemcpy2dAsync,                       "aclrtMemcpy2dAsync"},
        {AclProfType::AclrtCreateStream,                        "aclrtCreateStream"},
        {AclProfType::AclrtCreateStreamWithConfig,              "aclrtCreateStreamWithConfig"},
        {AclProfType::AclrtDestroyStream,                       "aclrtDestroyStream"},
        {AclProfType::AclrtDestroyStreamForce,                  "aclrtDestroyStreamForce"},
        {AclProfType::AclrtSynchronizeStream,                   "aclrtSynchronizeStream"},
        {AclProfType::AclrtSynchronizeStreamWithTimeout,        "aclrtSynchronizeStreamWithTimeout"},
        {AclProfType::AclrtStreamQuery,                         "aclrtStreamQuery"},
        {AclProfType::AclrtStreamGetPriority,                   "aclrtStreamGetPriority"},
        {AclProfType::AclrtStreamGetFlags,                      "aclrtStreamGetFlags"},
        {AclProfType::AclrtStreamWaitEvent,                     "aclrtStreamWaitEvent"},
        {AclProfType::AclrtStreamWaitEventWithTimeout,          "aclrtStreamWaitEventWithTimeout"},
        {AclProfType::AclrtAllocatorCreateDesc,                 "aclrtAllocatorCreateDesc"},
        {AclProfType::AclrtAllocatorDestroyDesc,                "aclrtAllocatorDestroyDesc"},
        {AclProfType::AclrtCtxGetSysParamOpt,                   "aclrtCtxGetSysParamOpt"},
        {AclProfType::AclrtCtxSetSysParamOpt,                   "aclrtCtxSetSysParamOpt"},
        {AclProfType::AclrtGetOverflowStatus,                   "aclrtGetOverflowStatus"},
        {AclProfType::AclrtResetOverflowStatus,                 "aclrtResetOverflowStatus"},
        {AclProfType::AclrtGetDeviceCount,                      "aclrtGetDeviceCount"},
        {AclProfType::AclrtGetDevice,                           "aclrtGetDevice"},
        {AclProfType::AclrtMalloc,                              "aclrtMalloc"},
        {AclProfType::AclrtSetStreamFailureMode,                "aclrtSetStreamFailureMode"},
        {AclProfType::AclrtQueryDeviceStatus,                   "aclrtQueryDeviceStatus"},
        {AclProfType::AclrtReserveMemAddress,                   "aclrtReserveMemAddress"},
        {AclProfType::AclrtReleaseMemAddress,                   "aclrtReleaseMemAddress"},
        {AclProfType::AclrtMallocPhysical,                      "aclrtMallocPhysical"},
        {AclProfType::AclrtFreePhysical,                        "aclrtFreePhysical"},
        {AclProfType::AclrtMapMem,                              "aclrtMapMem"},
        {AclProfType::AclrtUnmapMem,                            "aclrtUnmapMem"},
        {AclProfType::AclrtLaunchKernel,                        "aclrtLaunchKernel"},
        {AclProfType::AclrtMemGetAccess,                        "aclrtMemGetAccess"},
        {AclProfType::AclrtMemExportToShareableHandle,          "aclrtMemExportToShareableHandle"},
        {AclProfType::AclrtMemExportToShareableHandleV2,          "aclrtMemExportToShareableHandleV2"},
        {AclProfType::AclrtMemImportFromShareableHandle,        "aclrtMemImportFromShareableHandle"},
        {AclProfType::AclrtMemImportFromShareableHandleV2,      "aclrtMemImportFromShareableHandleV2"},
        {AclProfType::AclrtMemGetAllocationGranularity,         "aclrtMemGetAllocationGranularity"},
        {AclProfType::AclrtMemSetPidToShareableHandle,          "aclrtMemSetPidToShareableHandle"},
        {AclProfType::AclrtMemSetPidToShareableHandleV2,        "aclrtMemSetPidToShareableHandleV2"},
        {AclProfType::AclrtDeviceGetBareTgid,                   "aclrtDeviceGetBareTgid"},
        {AclProfType::AclrtGetMemUceInfo,                       "aclrtGetMemUceInfo"},
        {AclProfType::AclrtDeviceTaskAbort,                     "aclrtDeviceTaskAbort"},
        {AclProfType::AclrtMemUceRepair,                        "aclrtMemUceRepair"},
        {AclProfType::AclrtCmoAsync,                            "aclrtCmoAsync"},
        {AclProfType::AclrtStreamAbort,                         "aclrtStreamAbort"},
        {AclProfType::AclrtMemcpyAsyncWithDesc,                 "aclrtMemcpyAsyncWithDesc"},
        {AclProfType::AclrtBinaryLoadFromFile,                  "aclrtBinaryLoadFromFile"},
        {AclProfType::AclrtBinaryGetDevAddress,                 "aclrtBinaryGetDevAddress"},
        {AclProfType::AclrtLaunchKernelWithConfig,              "aclrtLaunchKernelWithConfig"},
        {AclProfType::AclrtKernelArgsAppend,                    "aclrtKernelArgsAppend"},
        {AclProfType::AclrtKernelArgsAppendPlaceHolder,         "aclrtKernelArgsAppendPlaceHolder"},
        {AclProfType::AclrtKernelArgsParaUpdate,                "aclrtKernelArgsParaUpdate"},
        {AclProfType::AclrtKernelArgsGetMemSize,                "aclrtKernelArgsGetMemSize"},
        {AclProfType::AclrtKernelArgsGetHandleMemSize,          "aclrtKernelArgsGetHandleMemSize"},
        {AclProfType::AclrtKernelArgsGetPlaceHolderBuffer,      "aclrtKernelArgsGetPlaceHolderBuffer"},
        {AclProfType::AclrtMallocWithCfg,                       "aclrtMallocWithCfg"},
        {AclProfType::AclrtMallocForTaskScheduler,              "aclrtMallocForTaskScheduler"},
        {AclProfType::AclrtMallocHostWithCfg,                   "aclrtMallocHostWithCfg"},
        {AclProfType::AclrtGetThreadLastTaskId,                 "aclrtGetThreadLastTaskId"},
        {AclProfType::AclrtStreamGetId,                         "aclrtStreamGetId"},
        {AclProfType::AclrtPointerGetAttributes,                "aclrtPointerGetAttributes"},
        {AclProfType::AclrtHostRegister,                        "aclrtHostRegister"},
        {AclProfType::AclrtHostUnregister,                      "aclrtHostUnregister"},
        {AclProfType::AclrtValueWrite,                          "aclrtValueWrite"},
        {AclProfType::AclrtValueWait,                           "aclrtValueWait"},
        {AclProfType::AclrtGetStreamAvailableNum,               "aclrtGetStreamAvailableNum"},
        {AclProfType::AclrtSetStreamAttribute,                  "aclrtSetStreamAttribute"},
        {AclProfType::AclrtGetStreamAttribute,                  "aclrtGetStreamAttribute"},
        {AclProfType::AclrtCreateNotify,                        "aclrtCreateNotify"},
        {AclProfType::AclrtDestroyNotify,                       "aclrtDestroyNotify"},
        {AclProfType::AclrtRecordNotify,                        "aclrtRecordNotify"},
        {AclProfType::AclrtWaitAndResetNotify,                  "aclrtWaitAndResetNotify"},
        {AclProfType::AclrtGetNotifyId,                         "aclrtGetNotifyId"},
        {AclProfType::AclrtGetEventId,                          "aclrtGetEventId"},
        {AclProfType::AclrtGetEventAvailNum,                    "aclrtGetEventAvailNum"},
        {AclProfType::AclrtGetDeviceInfo,                       "aclrtGetDeviceInfo"},
        {AclProfType::AclrtDeviceGetUuid,                       "aclrtDeviceGetUuid"},
        {AclProfType::AclrtDeviceGetStreamPriorityRange,        "aclrtDeviceGetStreamPriorityRange"},
        {AclProfType::AclrtGetDeviceCapability,                 "aclrtGetDeviceCapability"},
        {AclProfType::AclrtCtxGetCurrentDefaultStream,          "aclrtCtxGetCurrentDefaultStream"},
        {AclProfType::AclmdlRIBuildBegin,                       "aclmdlRIBuildBegin"},
        {AclProfType::AclmdlRIBindStream,                       "aclmdlRIBindStream"},
        {AclProfType::AclmdlRIEndTask,                          "aclmdlRIEndTask"},
        {AclProfType::AclmdlRIBuildEnd,                         "aclmdlRIBuildEnd"},
        {AclProfType::AclmdlRIUnbindStream,                     "aclmdlRIUnbindStream"},
        {AclProfType::AclmdlRIExecute,                          "aclmdlRIExecute"},
        {AclProfType::AclrtReduceAsync,                         "aclrtReduceAsync"},
        {AclProfType::AclrtGetDeviceResLimit,                   "aclrtGetDeviceResLimit"},
        {AclProfType::AclrtSetDeviceResLimit,                   "aclrtSetDeviceResLimit"},
        {AclProfType::AclrtResetDeviceResLimit,                 "aclrtResetDeviceResLimit"},
        {AclProfType::AclrtCreateLabel,                         "aclrtCreateLabel"},
        {AclProfType::AclrtSetLabel,                            "aclrtSetLabel"},
        {AclProfType::AclrtDestroyLabel,                        "aclrtDestroyLabel"},
        {AclProfType::AclrtCreateLabelList,                     "aclrtCreateLabelList"},
        {AclProfType::AclrtDestroyLabelList,                    "aclrtDestroyLabelList"},
        {AclProfType::AclrtSwitchLabelByIndex,                  "aclrtSwitchLabelByIndex"},
        {AclProfType::AclrtActiveStream,                        "aclrtActiveStream"},
        {AclProfType::AclrtSwitchStream,                        "aclrtSwitchStream"},
        {AclProfType::AclrtGetFunctionName,                     "aclrtGetFunctionName"},
        {AclProfType::AclmdlRISetName,                          "aclmdlRISetName"},
        {AclProfType::AclmdlRIGetName,                          "aclmdlRIGetName"},
        {AclProfType::AclrtGetBufFromChain,                     "aclrtGetBufFromChain"},
        {AclProfType::AclrtGetBufChainNum,                      "aclrtGetBufChainNum"},
        {AclProfType::AclrtAppendBufChain,                      "aclrtAppendBufChain"},
        {AclProfType::AclrtCopyBufRef,                          "aclrtCopyBufRef"},
        {AclProfType::AclrtGetBufUserData,                      "aclrtGetBufUserData"},
        {AclProfType::AclrtSetBufUserData,                      "aclrtSetBufUserData"},
        {AclProfType::AclrtGetBufData,                          "aclrtGetBufData"},
        {AclProfType::AclrtGetBufDataLen,                       "aclrtGetBufDataLen"},
        {AclProfType::AclrtSetBufDataLen,                       "aclrtSetBufDataLen"},
        {AclProfType::AclrtFreeBuf,                             "aclrtFreeBuf"},
        {AclProfType::AclrtAllocBuf,                            "aclrtAllocBuf"},
        {AclProfType::AclrtBinaryLoadFromData,                  "aclrtBinaryLoadFromData"},
        {AclProfType::AclrtRegisterCpuFunc,                     "aclrtRegisterCpuFunc"},
        {AclProfType::AclrtCmoAsyncWithBarrier,                 "aclrtCmoAsyncWithBarrier"},
        {AclProfType::AclrtCmoWaitBarrier,                      "aclrtCmoWaitBarrier"},
        {AclProfType::AclrtGetDevicesTopo,                      "aclrtGetDevicesTopo"},
        {AclProfType::AclrtMemcpyBatch,                         "aclrtMemcpyBatch"},
        {AclProfType::AclrtMemcpyBatchAsync,                    "aclrtMemcpyBatchAsync"},
        {AclProfType::AclrtIpcMemGetExportKey,                  "aclrtIpcMemGetExportKey"},
        {AclProfType::AclrtIpcMemClose,                         "aclrtIpcMemClose"},
        {AclProfType::AclrtIpcMemImportByKey,                   "aclrtIpcMemImportByKey"},
        {AclProfType::AclrtIpcMemSetImportPid,                  "aclrtIpcMemSetImportPid"},
        {AclProfType::AclrtNotifyBatchReset,                    "aclrtNotifyBatchReset"},
        {AclProfType::AclrtNotifyGetExportKey,                  "aclrtNotifyGetExportKey"},
        {AclProfType::AclrtNotifyImportByKey,                   "aclrtNotifyImportByKey"},
        {AclProfType::AclrtNotifySetImportPid,                  "aclrtNotifySetImportPid"},
        {AclProfType::AclrtGetStreamResLimit,                   "aclrtGetStreamResLimit"},
        {AclProfType::AclrtSetStreamResLimit,                   "aclrtSetStreamResLimit"},
        {AclProfType::AclrtResetStreamResLimit,                 "aclrtResetStreamResLimit"},
        {AclProfType::AclrtUseStreamResInCurrentThread,         "aclrtUseStreamResInCurrentThread"},
        {AclProfType::AclrtUnuseStreamResInCurrentThread,       "aclrtUnuseStreamResInCurrentThread"},
        {AclProfType::AclrtGetResInCurrentThread,               "aclrtGetResInCurrentThread"},
        {AclProfType::AclrtCheckMemType,                        "aclrtCheckMemType"},
        {AclProfType::AclrtGetLogicDevIdByUserDevId,            "aclrtGetLogicDevIdByUserDevId"},
        {AclProfType::AclrtGetUserDevIdByLogicDevId,            "aclrtGetUserDevIdByLogicDevId"},
        {AclProfType::AclrtGetLogicDevIdByPhyDevId,             "aclrtGetLogicDevIdByPhyDevId"},
        {AclProfType::AclrtGetPhyDevIdByLogicDevId,             "aclrtGetPhyDevIdByLogicDevId"},
        {AclProfType::AclrtProfTrace,                           "aclrtProfTrace"},
        {AclProfType::AclrtLaunchKernelV2,                      "aclrtLaunchKernelV2"},
        {AclProfType::AclrtLaunchKernelWithHostArgs,            "aclrtLaunchKernelWithHostArgs"},
        {AclProfType::AclrtCtxGetFloatOverflowAddr,             "aclrtCtxGetFloatOverflowAddr"},
        {AclProfType::AclrtGetFloatOverflowStatus,              "aclrtGetFloatOverflowStatus"},
        {AclProfType::AclrtResetFloatOverflowStatus,            "aclrtResetFloatOverflowStatus"},
        {AclProfType::AclrtNpuGetFloatOverFlowStatus,           "aclrtNpuGetFloatOverFlowStatus"},
        {AclProfType::AclrtNpuClearFloatOverFlowStatus,         "aclrtNpuClearFloatOverFlowStatus"},
        {AclProfType::AclrtLaunchHostFunc,                      "aclrtLaunchHostFunc"},
        {AclProfType::AclrtGetHardwareSyncAddr,                 "aclrtGetHardwareSyncAddr"},
        {AclProfType::AclrtRandomNumAsync,                      "aclrtRandomNumAsync"},
        {AclProfType::AclrtRegStreamStateCallback,              "aclrtRegStreamStateCallback"},
        {AclProfType::AclrtRegDeviceStateCallback,              "aclrtRegDeviceStateCallback"},
        {AclProfType::AclrtSetDeviceTaskAbortCallback,          "aclrtSetDeviceTaskAbortCallback"},
        {AclProfType::AclrtGetOpExecuteTimeout,                 "aclrtGetOpExecuteTimeout"},
        {AclProfType::AclrtDevicePeerAccessStatus,              "aclrtDevicePeerAccessStatus"},
        {AclProfType::AclrtStreamStop,                          "aclrtStreamStop"},
        {AclProfType::AclrtTaskUpdateAsync,                     "aclrtTaskUpdateAsync"},
        {AclProfType::AclrtCntNotifyCreate,                     "aclrtCntNotifyCreate"},
        {AclProfType::AclrtCntNotifyDestroy,                    "aclrtCntNotifyDestroy"},
        {AclProfType::AclrtIpcMemSetAttr,                       "aclrtIpcMemSetAttr"},
        {AclProfType::AclrtIpcMemImportPidInterServer,          "aclrtIpcMemIpmportPidInterServer"},
        {AclProfType::AclrtNotifySetImportPidInterServer,       "aclrtNotifySetImportPidInterServer"},
        {AclProfType::AclrtMemcpyAsyncWithOffset,               "aclrtMemcpyAsyncWithOffset"},
        {AclProfType::AclrtGetOpExecuteTimeOut,                 "aclrtGetOpExecuteTimeOut"},
        {AclProfType::AclrtCheckArchCompatibility,              "aclrtCheckArchCompatibility"},
        {AclProfType::AclrtCmoGetDescSize,                      "aclrtCmoGetDescSize"},
        {AclProfType::AclrtCmoSetDesc,                          "aclrtCmoSetDesc"},
        {AclProfType::AclrtCmoAsyncWithDesc,                    "aclrtCmoAsyncWithDesc"},
        {AclProfType::AclmdlRIAbort,                            "aclmdlRIAbort"},
        {AclProfType::AclrtCntNotifyRecord,                     "aclrtCntNotifyRecord"},
        {AclProfType::AclrtCntNotifyWaitWithTimeout,            "aclrtCntNotifyWaitWithTimeout"},
        {AclProfType::AclrtCntNotifyReset,                      "aclrtCntNotifyReset"},
        {AclProfType::AclrtCntNotifyGetId,                      "aclrtCntNotifyGetId"},
        {AclProfType::AclrtPersistentTaskClean,                 "aclrtPersistentTaskClean"},
        {AclProfType::AclrtGetErrorVerbose,                     "aclrtGetErrorVerbose"},
        {AclProfType::AclrtRepairError,                         "aclrtRepairError"},
        {AclProfType::AclrtMemSetAccess,                        "aclrtMemSetAccess"},
        {AclProfType::AclrtSetOpExecuteTimeOutV2,               "aclrtSetOpExecuteTimeOutV2"},
        {AclProfType::AclrtGetOpTimeOutInterval,                "aclrtGetOpTimeOutInterval"},
        {AclProfType::AclrtSnapShotProcessLock,                 "aclrtSnapShotProcessLock"},
        {AclProfType::AclrtSnapShotProcessUnlock,               "aclrtSnapShotProcessUnlock"},
        {AclProfType::AclrtSnapShotProcessBackup,               "aclrtSnapShotProcessBackup"},
        {AclProfType::AclrtSnapShotProcessRestore,              "aclrtSnapShotProcessRestore"},
        {AclProfType::AclrtFreeWithDevSync,                     "aclrtFreeWithDevSync"},
        {AclProfType::AclrtFreeHostWithDevSync,                 "aclrtFreeHostWithDevSync"},
        {AclProfType::AclrtCacheLastTaskOpInfo,                 "aclrtCacheLastTaskOpInfo"},
        {AclProfType::AclrtGetFunctionAttribute,                "aclrtGetFunctionAttribute"},
        {AclProfType::AclrtIpcGetEventHandle,                   "aclrtIpcGetEventHandle"},
        {AclProfType::AclrtIpcOpenEventHandle,                  "aclrtIpcOpenEventHandle"},
        {AclProfType::AclrtMemRetainAllocationHandle,           "aclrtMemRetainAllocationHandle"},
        {AclProfType::AclrtMemGetAllocationPropertiesFromHandle,"aclrtMemGetAllocationPropertiesFromHandle"},
        {AclProfType::AclrtGetMemUsageInfo,                     "aclrtGetMemUsageInfo"},
};

aclError RegisterType(const uint32_t index) {
    const AclProfType type = static_cast<AclProfType>(index);
    const auto iter = PROF_TYPE_TO_NAMES.find(type);
    if (iter != PROF_TYPE_TO_NAMES.cend()) {
        const auto ret = MsprofRegTypeInfo(MSPROF_REPORT_ACL_LEVEL, index, iter->second.c_str());
        if (ret != MSPROF_ERROR_NONE) {
            ACL_LOG_CALL_ERROR("Registered api type [%u] failed = %d", index, ret);
            return ACL_ERROR_PROFILING_FAILURE;
        }
    }
    return ACL_SUCCESS;
}
AclProfilingManager &AclProfilingManager::GetInstance()
{
    static AclProfilingManager profilingManager;
    return profilingManager;
}

aclError AclProfilingManager::Init()
{
    const std::lock_guard<std::mutex> lk(mutex_);
    const aclError reg_ret = RegisterProfilingType();
    if (reg_ret != 0) {
        ACL_LOG_INNER_ERROR("[Init][ProfEngine]init acl profiling reg failed, errorCode = %d", reg_ret);
        return reg_ret;
    }
    isProfiling_ = true;
    AclProfilingReporter::profRun = true;
    return ACL_SUCCESS;
}

aclError AclProfilingManager::UnInit()
{
    const std::lock_guard<std::mutex> lk(mutex_);
    isProfiling_ = false;
    AclProfilingReporter::profRun = false;
    return ACL_SUCCESS;
}

bool AclProfilingManager::IsDeviceListEmpty() const
{
    return deviceList_.empty();
}

aclError AclProfilingManager::AddDeviceList(const uint32_t *const deviceIdList, const uint32_t deviceNums)
{
    if (deviceNums == 0U) {
        return ACL_SUCCESS;
    }
    ACL_REQUIRES_NOT_NULL(deviceIdList);
    for (size_t devId = 0U; devId < deviceNums; devId++) {
        if (deviceList_.count(*(deviceIdList + devId)) == 0U) {
            (void)deviceList_.insert(*(deviceIdList + devId));
            ACL_LOG_INFO("device id %u is successfully added in acl profiling", *(deviceIdList + devId));
        }
    }
    return ACL_SUCCESS;
}

aclError AclProfilingManager::RemoveDeviceList(const uint32_t *const deviceIdList, const uint32_t deviceNums)
{
    if (deviceNums == 0U) {
        return ACL_SUCCESS;
    }
    ACL_REQUIRES_NOT_NULL(deviceIdList);
    for (size_t devId = 0U; devId < deviceNums; devId++) {
        const auto iter = deviceList_.find(*(deviceIdList + devId));
        if (iter != deviceList_.end()) {
            (void)deviceList_.erase(iter);
        }
    }
    return ACL_SUCCESS;
}

aclError AclProfilingManager::RegisterProfilingType() const
{
    for (uint32_t i = static_cast<uint32_t>(AclProfType::AclRtProfTypeStart) + 1U;
         i < static_cast<uint32_t>(AclProfType::AclRtProfTypeEnd); ++i) {
        const auto ret = RegisterType(i);
        if (ret != ACL_SUCCESS) {
            return ret;
        }
    }
    return ACL_SUCCESS;
}
}  // namespace acl
