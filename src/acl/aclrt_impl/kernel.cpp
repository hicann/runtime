/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "acl_rt_impl.h"
#include <map>
#include "runtime/kernel.h"
#include "runtime/rts/rts_kernel.h"
#include "runtime/rt_stars_define.h"
#include "runtime/rts/rts_stars.h"
#include "runtime/rts/rts_model.h"
#include "common/log_inner.h"
#include "common/error_codes_inner.h"
#include "common/prof_reporter.h"
#include "common/resource_statistics.h"
namespace {
static const std::map<aclDataType, rtRandomNumDataType> kMapDataType = {
    { ACL_INT32, RT_RANDOM_NUM_DATATYPE_INT32 },
    { ACL_INT64, RT_RANDOM_NUM_DATATYPE_INT64 },
    { ACL_UINT32, RT_RANDOM_NUM_DATATYPE_UINT32 },
    { ACL_UINT64, RT_RANDOM_NUM_DATATYPE_UINT64 },
    { ACL_BF16, RT_RANDOM_NUM_DATATYPE_BF16 },
    { ACL_FLOAT16, RT_RANDOM_NUM_DATATYPE_FP16 },
    { ACL_FLOAT, RT_RANDOM_NUM_DATATYPE_FP32 },
};
}

aclrtBinary aclrtCreateBinaryImpl(const void *data, size_t dataLen)
{
  ACL_ADD_APPLY_TOTAL_COUNT(acl::ACL_STATISTICS_CREATE_DESTROY_ALLOCATOR_BINARY_DESC);
  ACL_LOG_INFO("start to execute aclrtCreateBinary");
  ACL_REQUIRES_NOT_NULL_RET_NULL_INPUT_REPORT(data);

  rtDevBinary_t *binaryDesc = new(std::nothrow) rtDevBinary_t();
  ACL_CHECK_WITH_MESSAGE_AND_RETURN(binaryDesc != nullptr, nullptr, "Allocate memory for binaryDesc failed.");

  binaryDesc->magic = 0U;
  binaryDesc->version = 0U;
  binaryDesc->data = data;
  binaryDesc->length = static_cast<uint64_t>(dataLen);

  ACL_ADD_APPLY_SUCCESS_COUNT(acl::ACL_STATISTICS_CREATE_DESTROY_ALLOCATOR_BINARY_DESC);
  return binaryDesc;
}

aclError aclrtDestroyBinaryImpl(aclrtBinary binary)
{
  ACL_ADD_RELEASE_TOTAL_COUNT(acl::ACL_STATISTICS_CREATE_DESTROY_ALLOCATOR_BINARY_DESC);
  ACL_LOG_INFO("start to execute aclrtDestroyBinary");
  ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(binary);

  delete reinterpret_cast<rtDevBinary_t *>(binary);

  ACL_ADD_RELEASE_SUCCESS_COUNT(acl::ACL_STATISTICS_CREATE_DESTROY_ALLOCATOR_BINARY_DESC);
  return ACL_SUCCESS;
}

aclError aclrtBinaryLoadImpl(const aclrtBinary binary, aclrtBinHandle *binHandle)
{
  ACL_ADD_APPLY_TOTAL_COUNT(acl::ACL_STATISTICS_LOAD_UNLOAD_BINARY);
  ACL_LOG_INFO("start to execute aclrtBinaryLoad");
  ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(binary);
  ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(binHandle);
  rtDevBinary_t *bin = reinterpret_cast<rtDevBinary_t *>(binary);
  const rtError_t rtErr = rtBinaryLoadWithoutTilingKey(bin->data, bin->length, binHandle);
  if (rtErr != RT_ERROR_NONE) {
    ACL_LOG_CALL_ERROR("rtBinaryLoad failed, runtime result = %d.", rtErr);
    return ACL_GET_ERRCODE_RTS(rtErr);
  }

  ACL_ADD_APPLY_SUCCESS_COUNT(acl::ACL_STATISTICS_LOAD_UNLOAD_BINARY);
  return ACL_SUCCESS;
}

aclError aclrtBinaryUnLoadImpl(aclrtBinHandle binHandle)
{
  ACL_ADD_RELEASE_TOTAL_COUNT(acl::ACL_STATISTICS_LOAD_UNLOAD_BINARY);
  ACL_LOG_INFO("start to execute aclrtBinaryUnLoad");
  ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(binHandle);

  const rtError_t rtErr = rtBinaryUnLoad(binHandle);
  if (rtErr != RT_ERROR_NONE) {
    ACL_LOG_CALL_ERROR("rtBinaryUnLoad failed, runtime result = %d.", rtErr);
    return ACL_GET_ERRCODE_RTS(rtErr);
  }

  ACL_ADD_RELEASE_SUCCESS_COUNT(acl::ACL_STATISTICS_LOAD_UNLOAD_BINARY);
  return ACL_SUCCESS;
}

aclError aclrtBinaryGetFunctionImpl(const aclrtBinHandle binHandle, const char *kernelName, aclrtFuncHandle *funcHandle)
{
  ACL_LOG_INFO("start to execute aclrtBinaryGetFunction");
  ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(binHandle);
  ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(kernelName);
  ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(funcHandle);

  // currently not support multi kernel, so tilingKey always use 0
  const rtError_t rtErr = rtsFuncGetByName(binHandle, kernelName, funcHandle);
  if (rtErr != RT_ERROR_NONE) {
    ACL_LOG_CALL_ERROR("rtBinaryGetFunction failed, runtime result = %d.", rtErr);
    return ACL_GET_ERRCODE_RTS(rtErr);
  }

  return ACL_SUCCESS;
}

aclError aclrtLaunchKernelImpl(aclrtFuncHandle funcHandle, uint32_t numBlocks, const void *argsData,
                               size_t argsSize, aclrtStream stream)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtLaunchKernel);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(funcHandle);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(argsData);

    rtArgsEx_t argsInfo = {};
    argsInfo.args = const_cast<void *>(argsData);
    argsInfo.argsSize = static_cast<uint32_t>(argsSize);
    argsInfo.isNoNeedH2DCopy = 1U;

    const rtError_t rtErr = rtLaunchKernelByFuncHandleV3(funcHandle, numBlocks, &argsInfo, stream, nullptr);
    if (rtErr != RT_ERROR_NONE) {
        if (rtErr == ACL_ERROR_RT_INVALID_HANDLE) {
            ACL_LOG_WARN("rtLaunchKernelByFuncHandleV3 funHandle is invalid, runtime result = %d.", rtErr);
            return ACL_ERROR_RT_INVALID_HANDLE;
        } else {
            ACL_LOG_CALL_ERROR("rtLaunchKernelByFuncHandleV3 failed, runtime result = %d.", rtErr);
            return ACL_GET_ERRCODE_RTS(rtErr);
        }
    }
  return ACL_SUCCESS;
}

aclError aclrtBinaryLoadFromFileImpl(const char* binPath, aclrtBinaryLoadOptions *options, aclrtBinHandle *binHandle)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtBinaryLoadFromFile);
    ACL_LOG_INFO("start to execute aclrtBinaryLoadFromFile, binPath[%s]", binPath);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(binPath);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(binHandle);
    const rtLoadBinaryConfig_t *rt_options = nullptr;
    if (options != nullptr) {
       rt_options = reinterpret_cast<rtLoadBinaryConfig_t *>(options);
    }
    const auto rtErr = rtsBinaryLoadFromFile(binPath, rt_options, binHandle);
    if (rtErr != RT_ERROR_NONE) {
       ACL_LOG_CALL_ERROR("Binary load from file Failed, runtime result = %d", rtErr);
       return ACL_GET_ERRCODE_RTS(rtErr);
    }
    return ACL_SUCCESS;
}

aclError aclrtBinaryGetDevAddressImpl(const aclrtBinHandle binHandle, void **binAddr, size_t *binSize)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtBinaryGetDevAddress);
    ACL_LOG_INFO("start to execute aclrtBinaryGetDevAddress");
    ACL_REQUIRES_NOT_NULL_WITH_INNER_REPORT(binHandle);
    uint32_t tempBinSize = 0U;

    const auto rtErr = rtsBinaryGetDevAddress(binHandle, binAddr, &tempBinSize);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_INFO("get bin address failed, runtime result = %d", rtErr);
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    *binSize = static_cast<size_t>(tempBinSize);
    ACL_LOG_INFO("successfully execute aclrtBinaryGetDevAddress");
    return ACL_SUCCESS;
}

aclError aclrtBinaryGetFunctionByEntryImpl(aclrtBinHandle binHandle, uint64_t funcEntry, aclrtFuncHandle *funcHandle)
{
    ACL_LOG_INFO("start to execute aclrtBinaryGetFunctionByEntry");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(binHandle);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(funcHandle);

    const auto rtErr = rtsFuncGetByEntry(binHandle, funcEntry, funcHandle);
    if (rtErr != RT_ERROR_NONE) {
       ACL_LOG_CALL_ERROR("Binary get function by entry Failed, runtime result = %d", rtErr);
       return ACL_GET_ERRCODE_RTS(rtErr);
    }
    return ACL_SUCCESS;
}

aclError aclrtGetFunctionAddrImpl(aclrtFuncHandle funcHandle, void **aicAddr, void **aivAddr)
{
    ACL_LOG_INFO("start to execute aclrtGetFunctionAddr");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(funcHandle);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(aicAddr);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(aivAddr);

    const auto rtErr = rtsFuncGetAddr(funcHandle, aicAddr, aivAddr);
    if (rtErr != RT_ERROR_NONE) {
       ACL_LOG_CALL_ERROR("Get function addr Failed, runtime result = %d", rtErr);
       return ACL_GET_ERRCODE_RTS(rtErr);
    }
    return ACL_SUCCESS;
}

aclError aclrtLaunchKernelWithConfigImpl(aclrtFuncHandle funcHandle, uint32_t numBlocks, aclrtStream stream,
                                         aclrtLaunchKernelCfg *cfg, aclrtArgsHandle argsHandle, void *reserve)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtLaunchKernelWithConfig);
    ACL_LOG_INFO("Start to execute aclrtLaunchKernelWithConfig");
    ACL_REQUIRES_NOT_NULL_WITH_INNER_REPORT(funcHandle);
    ACL_REQUIRES_POSITIVE_WITH_INPUT_REPORT(numBlocks);
    ACL_REQUIRES_NOT_NULL_WITH_INNER_REPORT(argsHandle);
    if (reserve != nullptr) {
        ACL_LOG_ERROR("[Check][reserve]param is reserved and only support currently nullptr.");
        return ACL_ERROR_INVALID_PARAM;
    }

    rtKernelLaunchCfg_t *rt_cfg = nullptr;
    if (cfg != nullptr ) {
        rt_cfg = reinterpret_cast<rtKernelLaunchCfg_t *>(cfg);
    }
    const auto rtErr = rtsLaunchKernelWithConfig(funcHandle, numBlocks, stream, rt_cfg, argsHandle, reserve);
    if (rtErr != RT_ERROR_NONE) {
        if (rtErr == ACL_ERROR_RT_INVALID_HANDLE) {
            ACL_LOG_WARN("Launch kernel with config funHandle is invalid, runtime result = %d.", rtErr);
            return ACL_ERROR_RT_INVALID_HANDLE;
        } else {
            ACL_LOG_CALL_ERROR("Launch kernel with config failed, runtime result = %d.", rtErr);
            return ACL_GET_ERRCODE_RTS(rtErr);
        }
    }
    return ACL_SUCCESS;
}

aclError aclrtKernelArgsInitImpl(aclrtFuncHandle funcHandle, aclrtArgsHandle *argsHandle)
{
    ACL_LOG_INFO("Start to execute aclrtKernelArgsInit");
    ACL_REQUIRES_NOT_NULL_WITH_INNER_REPORT(funcHandle);
    ACL_REQUIRES_NOT_NULL_WITH_INNER_REPORT(argsHandle);

    const auto rtErr = rtsKernelArgsInit(funcHandle, argsHandle);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("Initialize kernel args Failed, runtime result = %d", rtErr);
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    return ACL_SUCCESS;
}

aclError aclrtKernelArgsInitByUserMemImpl(aclrtFuncHandle funcHandle, aclrtArgsHandle argsHandle, void *userHostMem,
                                          size_t actualArgsSize)
{
    ACL_LOG_INFO("Start to execute aclrtKernelArgsInitByUserMem");
    ACL_REQUIRES_NOT_NULL_WITH_INNER_REPORT(funcHandle);
    ACL_REQUIRES_NOT_NULL_WITH_INNER_REPORT(argsHandle);
    ACL_REQUIRES_NOT_NULL_WITH_INNER_REPORT(userHostMem);
    ACL_REQUIRES_POSITIVE_WITH_INPUT_REPORT(actualArgsSize);

    const auto rtErr = rtsKernelArgsInitByUserMem(funcHandle, argsHandle, userHostMem, actualArgsSize);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("Initialize kernel args by user mem Failed, runtime result = %d", rtErr);
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    return ACL_SUCCESS;
}

aclError aclrtKernelArgsGetMemSizeImpl(aclrtFuncHandle funcHandle, size_t userArgsSize, size_t *actualArgsSize)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtKernelArgsGetMemSize);
    ACL_LOG_INFO("Start to execute aclrtKernelArgsGetMemSize");
    ACL_REQUIRES_NOT_NULL_WITH_INNER_REPORT(funcHandle);
    ACL_REQUIRES_NOT_NULL_WITH_INNER_REPORT(actualArgsSize);

    const auto rtErr = rtsKernelArgsGetMemSize(funcHandle, userArgsSize, actualArgsSize);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("Get kernel args mem size Failed, runtime result = %d", rtErr);
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    return ACL_SUCCESS;
}

aclError aclrtKernelArgsGetHandleMemSizeImpl(aclrtFuncHandle funcHandle, size_t *memSize)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtKernelArgsGetHandleMemSize);
    ACL_LOG_INFO("Start to execute aclrtKernelArgsGetHandleMemSize");
    ACL_REQUIRES_NOT_NULL_WITH_INNER_REPORT(funcHandle);
    ACL_REQUIRES_NOT_NULL_WITH_INNER_REPORT(memSize);

    const auto rtErr = rtsKernelArgsGetHandleMemSize(funcHandle, memSize);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("Get kernel args handle mem size Failed, runtime result = %d", rtErr);
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    return ACL_SUCCESS;
}

aclError aclrtKernelArgsAppendImpl(aclrtArgsHandle argsHandle, void *param, size_t paramSize,
                                   aclrtParamHandle *paramHandle)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtKernelArgsAppend);
    ACL_LOG_INFO("Start to execute aclrtKernelArgsAppend");
    ACL_REQUIRES_NOT_NULL_WITH_INNER_REPORT(argsHandle);
    ACL_REQUIRES_NOT_NULL_WITH_INNER_REPORT(param);
    ACL_REQUIRES_POSITIVE_WITH_INPUT_REPORT(paramSize);
    ACL_REQUIRES_NOT_NULL_WITH_INNER_REPORT(paramHandle);

    const auto rtErr = rtsKernelArgsAppend(argsHandle, param, paramSize, paramHandle);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("Append kernel args Failed, runtime result = %d", rtErr);
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    return ACL_SUCCESS;
}

aclError aclrtKernelArgsAppendPlaceHolderImpl(aclrtArgsHandle argsHandle, aclrtParamHandle *paramHandle)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtKernelArgsAppendPlaceHolder);
    ACL_LOG_INFO("Start to execute aclrtKernelArgsAppendPlaceHolder");
    ACL_REQUIRES_NOT_NULL_WITH_INNER_REPORT(argsHandle);
    ACL_REQUIRES_NOT_NULL_WITH_INNER_REPORT(paramHandle);

    const auto rtErr = rtsKernelArgsAppendPlaceHolder(argsHandle, paramHandle);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("Append kernel args placeholder Failed, runtime result = %d", rtErr);
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    return ACL_SUCCESS;
}

aclError aclrtKernelArgsGetPlaceHolderBufferImpl(aclrtArgsHandle argsHandle, aclrtParamHandle paramHandle,
                                                 size_t dataSize, void **bufferAddr)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtKernelArgsGetPlaceHolderBuffer);
    ACL_LOG_INFO("Start to execute aclrtKernelArgsGetPlaceHolderBuffer");
    ACL_REQUIRES_NOT_NULL_WITH_INNER_REPORT(argsHandle);
    ACL_REQUIRES_NOT_NULL_WITH_INNER_REPORT(paramHandle);
    ACL_REQUIRES_POSITIVE_WITH_INPUT_REPORT(dataSize);
    ACL_REQUIRES_NOT_NULL_WITH_INNER_REPORT(bufferAddr);

    const auto rtErr = rtsKernelArgsGetPlaceHolderBuffer(argsHandle, paramHandle, dataSize, bufferAddr);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("Get kernel args placeholder buffer Failed, runtime result = %d", rtErr);
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    return ACL_SUCCESS;
}

aclError aclrtKernelArgsParaUpdateImpl(aclrtArgsHandle argsHandle, aclrtParamHandle paramHandle, void *param,
                                       size_t paramSize)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtKernelArgsParaUpdate);
    ACL_LOG_INFO("Start to execute aclrtKernelArgsParaUpdate");
    ACL_REQUIRES_NOT_NULL_WITH_INNER_REPORT(argsHandle);
    ACL_REQUIRES_NOT_NULL_WITH_INNER_REPORT(paramHandle);
    ACL_REQUIRES_NOT_NULL_WITH_INNER_REPORT(param);
    ACL_REQUIRES_POSITIVE_WITH_INPUT_REPORT(paramSize);

    const auto rtErr = rtsKernelArgsParaUpdate(argsHandle, paramHandle, param, paramSize);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("Update kernel args placeholder Failed, runtime result = %d", rtErr);
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    return ACL_SUCCESS;
}

aclError aclrtKernelArgsFinalizeImpl(aclrtArgsHandle argsHandle)
{
    ACL_LOG_INFO("Start to execute aclrtKernelArgsFinalize");
    ACL_REQUIRES_NOT_NULL_WITH_INNER_REPORT(argsHandle);

    const auto rtErr = rtsKernelArgsFinalize(argsHandle);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("Finalize kernel args Failed, runtime result = %d", rtErr);
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    return ACL_SUCCESS;
}

aclError aclrtGetThreadLastTaskIdImpl(uint32_t *taskId)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtGetThreadLastTaskId);
    ACL_LOG_DEBUG("start to execute aclrtGetThreadLastTaskId");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(taskId);
    const rtError_t rtErr = rtsGetThreadLastTaskId(taskId);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("call rtsGetThreadLastTaskId failed, runtime result = %d", rtErr);
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    return ACL_SUCCESS;
}

aclError aclrtGetFunctionNameImpl(aclrtFuncHandle funcHandle, uint32_t maxLen, char *name)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtGetFunctionName);
    ACL_LOG_DEBUG("start to execute aclrtGetFunctionName, maxLen is [%u]", maxLen);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(name);
    const rtError_t rtErr = rtsFuncGetName(static_cast<rtFuncHandle>(funcHandle), maxLen, name);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("call rtsFuncGetName failed, runtime result = %d", rtErr);
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    return ACL_SUCCESS;
}

aclError aclrtBinaryLoadFromDataImpl(const void *data, size_t length,
    const aclrtBinaryLoadOptions *options, aclrtBinHandle *binHandle)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtBinaryLoadFromData);
    ACL_LOG_DEBUG("start to execute aclrtBinaryLoadFromData, length is [%zu]", length);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(data);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(binHandle);
    const rtError_t rtErr = rtsBinaryLoadFromData(data, length,
        reinterpret_cast<const rtLoadBinaryConfig_t*>(options), static_cast<rtBinHandle*>(binHandle));
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("call rtsBinaryLoadFromData failed, runtime result = %d", rtErr);
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    return ACL_SUCCESS;
}

aclError aclrtRegisterCpuFuncImpl(const aclrtBinHandle handle, const char *funcName,
    const char *kernelName, aclrtFuncHandle *funcHandle)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtRegisterCpuFunc);
    ACL_LOG_DEBUG("start to execute aclrtRegisterCpuFunc");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(handle);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(funcName);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(kernelName);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(funcHandle);
    const rtError_t rtErr = rtsRegisterCpuFunc(static_cast<rtBinHandle>(handle), funcName, kernelName,
        static_cast<rtFuncHandle*>(funcHandle));
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("call rtsRegisterCpuFunc failed, runtime result = %d", rtErr);
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    return ACL_SUCCESS;
}

aclError aclrtCmoWaitBarrierImpl(aclrtBarrierTaskInfo *taskInfo, aclrtStream stream, uint32_t flag)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtCmoWaitBarrier);
    ACL_LOG_DEBUG("start to execute aclrtCmoWaitBarrier, flag is [%u]", flag);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(taskInfo);
    if ((taskInfo->barrierNum == 0U) || (taskInfo->barrierNum > ACL_RT_CMO_MAX_BARRIER_NUM)) {
        ACL_LOG_ERROR("[Check][taskInfo]param taskInfo is invalid, taskInfo->barrierNum must be in range (0, 6]");
        return ACL_ERROR_INVALID_PARAM;
    }
    rtBarrierTaskInfo_t rtTaskInfo;
    rtTaskInfo.logicIdNum = taskInfo->barrierNum;
    for (size_t i = 0U; i < taskInfo->barrierNum; i++) {
        rtTaskInfo.cmoInfo[i].cmoType = static_cast<uint16_t>(taskInfo->cmoInfo[i].cmoType) +
            (static_cast<uint16_t>(RT_CMO_PREFETCH) - static_cast<uint16_t>(ACL_RT_CMO_TYPE_PREFETCH));
        rtTaskInfo.cmoInfo[i].logicId = taskInfo->cmoInfo[i].barrierId;
    }
    const rtError_t rtErr = rtsLaunchBarrierTask(&rtTaskInfo, static_cast<rtStream_t>(stream), flag);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("call rtsLaunchBarrierTask failed, runtime result = %d", rtErr);
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    return ACL_SUCCESS;
}

aclError aclrtLaunchKernelV2Impl(aclrtFuncHandle funcHandle, uint32_t numBlocks, const void *argsData,
                                 size_t argsSize, aclrtLaunchKernelCfg *cfg, aclrtStream stream)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtLaunchKernelV2);
    ACL_LOG_INFO("Start to execute aclrtLaunchKernelV2");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(funcHandle);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(argsData);

    rtKernelLaunchCfg_t *rt_cfg = nullptr;
    if (cfg != nullptr ) {
        rt_cfg = reinterpret_cast<rtKernelLaunchCfg_t *>(cfg);
    }

    const rtError_t rtErr = rtsLaunchKernelWithDevArgs(funcHandle, numBlocks, stream, rt_cfg,
        argsData, static_cast<uint32_t>(argsSize), nullptr);
    if (rtErr != RT_ERROR_NONE) {
        if (rtErr == ACL_ERROR_RT_INVALID_HANDLE) {
            ACL_LOG_WARN("rtsLaunchKernelWithDevArgs funHandle is invalid, runtime result = %d.", rtErr);
            return ACL_ERROR_RT_INVALID_HANDLE;
        } else {
            ACL_LOG_CALL_ERROR("rtsLaunchKernelWithDevArgs failed, runtime result = %d.", rtErr);
            return ACL_GET_ERRCODE_RTS(rtErr);
        }
    }

    return ACL_SUCCESS;
}

aclError aclrtLaunchKernelWithHostArgsImpl(aclrtFuncHandle funcHandle, uint32_t numBlocks, aclrtStream stream,
                                           aclrtLaunchKernelCfg *cfg, void *hostArgs, size_t argsSize,
                                           aclrtPlaceHolderInfo *placeHolderArray, size_t placeHolderNum)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtLaunchKernelWithHostArgs);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(funcHandle);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(hostArgs);

    rtKernelLaunchCfg_t *rt_cfg = nullptr;
    rtPlaceHolderInfo_t *rt_placeHolderArray = nullptr;
    if (cfg != nullptr ) {
        rt_cfg = reinterpret_cast<rtKernelLaunchCfg_t *>(cfg);
    }

    if (placeHolderArray != nullptr ) {
        rt_placeHolderArray = reinterpret_cast<rtPlaceHolderInfo_t *>(placeHolderArray);
    }

    const rtError_t rtErr = rtsLaunchKernelWithHostArgs(funcHandle, numBlocks, stream, rt_cfg,
        hostArgs, static_cast<uint32_t>(argsSize), rt_placeHolderArray, placeHolderNum);
    if (rtErr != RT_ERROR_NONE) {
        if (rtErr == ACL_ERROR_RT_INVALID_HANDLE) {
            ACL_LOG_WARN("rtsLaunchKernelWithHostArgs funHandle is invalid, runtime result = %d.", rtErr);
            return ACL_ERROR_RT_INVALID_HANDLE;
        } else {
            ACL_LOG_CALL_ERROR("rtsLaunchKernelWithHostArgs failed, runtime result = %d.", rtErr);
            return ACL_GET_ERRCODE_RTS(rtErr);
        }
    }

    return ACL_SUCCESS;
}

aclError aclrtGetFloatOverflowStatusImpl(void *outputAddr, uint64_t outputSize, aclrtStream stream)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtGetFloatOverflowStatus);
    ACL_LOG_INFO("start to execute aclrtGetFloatOverflowStatus, outputSize = %lu", outputSize);
    const rtError_t rtErr = rtsGetFloatOverflowStatus(outputAddr, outputSize, static_cast<rtStream_t>(stream));
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("rtsGetFloatOverflowStatus failed, runtime result = %d.", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    ACL_LOG_INFO("successfully execute aclrtGetFloatOverflowStatus");
    return ACL_SUCCESS;
}

aclError aclrtResetFloatOverflowStatusImpl(aclrtStream stream)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtResetFloatOverflowStatus);
    ACL_LOG_INFO("start to execute aclrtResetFloatOverflowStatus");
    const rtError_t rtErr = rtsResetFloatOverflowStatus(static_cast<rtStream_t>(stream));
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("rtsResetFloatOverflowStatus failed, runtime result = %d.", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    ACL_LOG_INFO("successfully execute aclrtResetFloatOverflowStatus");
    return ACL_SUCCESS;
}

aclError aclrtNpuGetFloatOverFlowStatusImpl(void *outputAddr, uint64_t outputSize, uint32_t checkMode, aclrtStream stream)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtNpuGetFloatOverFlowStatus);
    ACL_LOG_INFO("start to execute aclrtNpuGetFloatOverFlowStatus, outputSize = %lu", outputSize);
    const rtError_t rtErr = rtsNpuGetFloatOverFlowStatus(outputAddr, outputSize, checkMode, static_cast<rtStream_t>(stream));
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("rtsNpuGetFloatOverFlowStatus failed, runtime result = %d.", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    ACL_LOG_INFO("successfully execute aclrtNpuGetFloatOverFlowStatus");
    return ACL_SUCCESS;
}

aclError aclrtNpuClearFloatOverFlowStatusImpl(uint32_t checkMode, aclrtStream stream)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtNpuClearFloatOverFlowStatus);
    ACL_LOG_INFO("start to execute aclrtNpuClearFloatOverFlowStatus");
    const rtError_t rtErr = rtsNpuClearFloatOverFlowStatus(checkMode, static_cast<rtStream_t>(stream));
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("rtsNpuClearFloatOverFlowStatus failed, runtime result = %d.", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    ACL_LOG_INFO("successfully execute aclrtNpuClearFloatOverFlowStatus");
    return ACL_SUCCESS;
}

aclError aclrtGetHardwareSyncAddrImpl(void **addr)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtGetHardwareSyncAddr);
    const rtError_t rtErr = rtsGetHardwareSyncAddr(addr);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("call rtsGetHardwareSyncAddr failed, runtime result = %d.", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    return ACL_SUCCESS;
}

aclError aclrtRandomNumAsyncImpl(const aclrtRandomNumTaskInfo *taskInfo, const aclrtStream stream, void *reserve)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtRandomNumAsync);
    ACL_LOG_INFO("start to execute aclrtRandomNumAsync");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(taskInfo);
    aclDataType type = taskInfo->dataType;
    if (kMapDataType.count(type) == 0) {
         ACL_LOG_ERROR("[Check][param]param dataType [%d] is invalid.", static_cast<int32_t>(type));
        return ACL_ERROR_INVALID_PARAM;
    }
    rtRandomNumTaskInfo_t *rtTaskInfo = const_cast<rtRandomNumTaskInfo_t *>(reinterpret_cast<const rtRandomNumTaskInfo_t *>(taskInfo));
    rtTaskInfo->dataType = kMapDataType.at(type);
    const rtError_t rtErr = rtsLaunchRandomNumTask(
        rtTaskInfo,
        static_cast<rtStream_t>(stream), reserve);
    if (rtErr != RT_ERROR_NONE) {
      ACL_LOG_CALL_ERROR(
          "call rtsLaunchRandomNumTask failed, runtime result = %d.",
          static_cast<int32_t>(rtErr));
      return ACL_GET_ERRCODE_RTS(rtErr);
    }
    ACL_LOG_INFO("successfully execute aclrtRandomNumAsync");
    return ACL_SUCCESS;
}

aclError aclrtTaskUpdateAsyncImpl(aclrtStream taskStream, uint32_t taskId, aclrtTaskUpdateInfo *info, aclrtStream execStream)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtTaskUpdateAsync);
    ACL_LOG_INFO("start to execute aclrtTaskUpdateAsync");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(info);
    const rtError_t rtErr =
        rtsLaunchUpdateTask(static_cast<rtStream_t>(taskStream), taskId,
                            static_cast<rtStream_t>(execStream),
                            reinterpret_cast<rtTaskUpdateCfg_t *>(info));
    if (rtErr != RT_ERROR_NONE) {
      ACL_LOG_CALL_ERROR(
          "call rtsLaunchUpdateTask failed, runtime result = %d.",
          static_cast<int32_t>(rtErr));
      return ACL_GET_ERRCODE_RTS(rtErr);
    }
    ACL_LOG_INFO("successfully execute aclrtTaskUpdateAsync");
    return ACL_SUCCESS;
}

aclError aclrtCacheLastTaskOpInfoImpl(const void * const infoPtr, const size_t infoSize)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtCacheLastTaskOpInfo);
    ACL_LOG_INFO("start to execute aclrtCacheLastTaskOpInfo");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(infoPtr);
    ACL_REQUIRES_POSITIVE_WITH_INPUT_REPORT(infoSize);

    const rtError_t rtErr = rtCacheLastTaskOpInfo(infoPtr, infoSize);
    if (rtErr != RT_ERROR_NONE) {
        if (rtErr == ACL_ERROR_RT_FEATURE_NOT_SUPPORT) {
            ACL_LOG_WARN("rtCacheLastTaskOpInfo unsupport, runtime result = %d", static_cast<int32_t>(rtErr));
        } else {
            ACL_LOG_CALL_ERROR("call rtCacheLastTaskOpInfo failed, runtime result = %d.", static_cast<int32_t>(rtErr));
        }
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    ACL_LOG_INFO("successfully execute aclrtCacheLastTaskOpInfo");
    return ACL_SUCCESS;
}

aclError aclrtGetFunctionAttributeImpl(aclrtFuncHandle funcHandle, aclrtFuncAttribute attrType, int64_t *attrValue)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtGetFunctionAttribute);
    ACL_LOG_INFO("start to execute aclrtGetFunctionAttribute");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(funcHandle);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(attrValue);

    const rtError_t rtErr = rtFunctionGetAttribute(funcHandle, static_cast<rtFuncAttribute>(attrType), attrValue);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("call rtFunctionGetAttribute failed, runtime result = %d.", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }

    ACL_LOG_INFO("successfully execute aclrtGetFunctionAttribute");
    return ACL_SUCCESS;
}