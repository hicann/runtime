/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "api_error.hpp"
#include "osal.hpp"
#include "program.hpp"
#include "stream.hpp"
#include "event.hpp"
#include "elf.hpp"
#include "runtime/kernel.h"
#include "error_message_manage.hpp"
#include "runtime/mem.h"
#include "npu_driver.hpp"
#include "capture_model_utils.hpp"
#include "capture_adapt.hpp"
#include "para_convertor.hpp"
#include "global_state_manager.hpp"
#include "register_memory.hpp"
#include "starsv2_base.hpp"
namespace cce {
namespace runtime {
constexpr int16_t MODEL_SCH_GROUP_ID_MIN = 0;
constexpr int16_t MODEL_SCH_GROUP_ID_MAX = 4;
constexpr uint32_t TASK_ABORT_TIMEOUT_MAX = (36 * 60 * 1000U); // 36min
constexpr uint32_t HUGE1G_PAGE = 2U;
constexpr size_t MAX_SHAPE_INFO_SIZE = 1024U * 64U;
constexpr uint32_t DEVICE_TYPE = 1;
constexpr uint32_t NUMA_TYPE = 4;
constexpr uint32_t DRV_MEM_HOST_NUMA_SIDE = 2;
constexpr int32_t FEATURE_SVM_VMM_NORMAL_GRANULARITY = 6; // check drv is support alloc mem via numa id

ApiErrorDecorator::ApiErrorDecorator(Api * const impl) : ApiDecorator(impl)
{
}

rtError_t ApiErrorDecorator::DevBinaryRegister(const rtDevBinary_t * const bin, Program ** const prog)
{
    NULL_PTR_RETURN_MSG_OUTER(bin, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(prog, RT_ERROR_INVALID_VALUE);

    const rtError_t error = impl_->DevBinaryRegister(bin, prog);
    ERROR_RETURN(error, "Register binary failed.");
    RT_LOG(RT_LOG_DEBUG, "register binary success, magic=%#x.", bin->magic);
    return error;
}

rtError_t ApiErrorDecorator::GetNotifyAddress(Notify * const notify, uint64_t * const notifyAddress)
{
    NULL_PTR_RETURN_MSG_OUTER(notify, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(notifyAddress, RT_ERROR_INVALID_VALUE);
    const rtError_t error = impl_->GetNotifyAddress(notify, notifyAddress);
    ERROR_RETURN(error, "GetNotifyAddress failed.");
    RT_LOG(RT_LOG_DEBUG, "success.");
    return error;
}

rtError_t ApiErrorDecorator::RegisterAllKernel(const rtDevBinary_t * const bin, Program ** const prog)
{
    NULL_PTR_RETURN_MSG_OUTER(bin, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(prog, RT_ERROR_INVALID_VALUE);

    const uint32_t magic = bin->magic;
    const bool isElfProgram = ((magic == RT_DEV_BINARY_MAGIC_ELF) || (magic == RT_DEV_BINARY_MAGIC_ELF_AICUBE) ||
        (magic == RT_DEV_BINARY_MAGIC_ELF_AIVEC));
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_TBE, !isElfProgram, RT_ERROR_INVALID_VALUE,
        "Invalid magic, magic=%#x", magic);

    const rtError_t error = impl_->RegisterAllKernel(bin, prog);
    ERROR_RETURN(error, "Register binary failed.");
    RT_LOG(RT_LOG_DEBUG, "register binary success, magic=%#x.", bin->magic);
    return error;
}

rtError_t ApiErrorDecorator::BinaryRegisterToFastMemory(Program * const prog)
{
    NULL_PTR_RETURN_MSG_OUTER(prog, RT_ERROR_INVALID_VALUE);
    return impl_->BinaryRegisterToFastMemory(prog);
}

rtError_t ApiErrorDecorator::DevBinaryUnRegister(Program * const prog)
{
    NULL_PTR_RETURN_MSG_OUTER(prog, RT_ERROR_INVALID_VALUE);
    return impl_->DevBinaryUnRegister(prog);
}

rtError_t ApiErrorDecorator::MetadataRegister(Program * const prog, const char_t * const metadata)
{
    NULL_PTR_RETURN_MSG_OUTER(prog, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(metadata, RT_ERROR_INVALID_VALUE);
    return impl_->MetadataRegister(prog, metadata);
}

rtError_t ApiErrorDecorator::DependencyRegister(Program * const mProgram, Program * const sProgram)
{
    NULL_PTR_RETURN_MSG_OUTER(mProgram, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(sProgram, RT_ERROR_INVALID_VALUE);
    return impl_->DependencyRegister(mProgram, sProgram);
}

rtError_t ApiErrorDecorator::FunctionRegister(Program * const prog, const void * const stubFunc,
    const char_t * const stubName, const void * const kernelInfoExt, const uint32_t funcMode)
{
    NULL_PTR_RETURN_MSG_OUTER(prog, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(stubFunc, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(stubName, RT_ERROR_INVALID_VALUE);

    const rtError_t error = impl_->FunctionRegister(prog, stubFunc, stubName, kernelInfoExt, funcMode);
    COND_PROC((error == RT_ERROR_KERNEL_DUPLICATE), return error;);
    ERROR_RETURN(error, "Register function failed, funcName=%s.", ((stubName != nullptr) ? stubName : "(none)"));
    return error;
}

rtError_t ApiErrorDecorator::GetFunctionByName(const char_t * const stubName, void ** const stubFunc)
{
    NULL_PTR_RETURN_MSG_OUTER(stubFunc, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(stubName, RT_ERROR_INVALID_VALUE);
    const rtError_t error = impl_->GetFunctionByName(stubName, stubFunc);
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_GE, error != RT_ERROR_NONE, error, "Get stub function failed, name=%s.",
        ((stubName != nullptr) ? stubName : "(none)"));
    return error;
}

rtError_t ApiErrorDecorator::GetAddrByFun(const void * const stubFunc, void ** const addr)
{
    NULL_PTR_RETURN_MSG_OUTER(addr, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(stubFunc, RT_ERROR_INVALID_VALUE);
    const rtError_t error = impl_->GetAddrByFun(stubFunc, addr);
    ERROR_RETURN(error, "Get address failed.");
    return error;
}

rtError_t ApiErrorDecorator::GetAddrAndPrefCntWithHandle(void * const hdl, const void * const kernelInfoExt,
                                                         void ** const addr, uint32_t * const prefetchCnt)
{
    NULL_PTR_RETURN_MSG_OUTER(hdl, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(kernelInfoExt, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(addr, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(prefetchCnt, RT_ERROR_INVALID_VALUE);

    const auto name = reinterpret_cast<const char_t *>(kernelInfoExt);
    const auto len = strnlen(name, static_cast<size_t>(NAME_MAX_LENGTH));
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM(len >= NAME_MAX_LENGTH, RT_ERROR_INVALID_VALUE, len, 
        "less than " + std::to_string(NAME_MAX_LENGTH));

    const rtError_t error = impl_->GetAddrAndPrefCntWithHandle(hdl, kernelInfoExt, addr, prefetchCnt);
    ERROR_RETURN(error, "get addr and prefCnt failed");
    return error;
}

rtError_t ApiErrorDecorator::CheckArgs(const rtArgsEx_t * const argsInfo) const
{
    NULL_PTR_RETURN_MSG_OUTER(argsInfo, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(argsInfo->args, RT_ERROR_INVALID_VALUE);
    ZERO_RETURN_AND_MSG_OUTER(argsInfo->argsSize);
    RT_LOG(RT_LOG_DEBUG, "hostInputInfoNum=%hu, isNoNeedH2DCopy=%hhu, argsSize=%u, hasTiling=%hhu",
        argsInfo->hostInputInfoNum, argsInfo->isNoNeedH2DCopy, argsInfo->argsSize, argsInfo->hasTiling);
    if (argsInfo->isNoNeedH2DCopy == 0U) {
        if (argsInfo->hasTiling != 0U) {
            COND_RETURN_OUT_ERROR_MSG_CALL(argsInfo->tilingDataOffset >= argsInfo->argsSize, RT_ERROR_INVALID_VALUE,
                "Parameter argsInfo->tilingDataOffset should be less than parameter argsInfo->argsSize. "
                "Parameter argsInfo->tilingDataOffset = %u, parameter argsInfo->argsSize = %u.",
                argsInfo->tilingDataOffset, argsInfo->argsSize);
            COND_RETURN_OUT_ERROR_MSG_CALL(argsInfo->tilingAddrOffset >= argsInfo->argsSize, RT_ERROR_INVALID_VALUE, 
                "Parameter argsInfo->tilingAddrOffset should be less than parameter argsInfo->argsSize. "
                "Parameter argsInfo->tilingAddrOffset = %u, parameter argsInfo->argsSize = %u.",              
                argsInfo->tilingAddrOffset, argsInfo->argsSize);
        }

        if (argsInfo->hostInputInfoNum != 0U) {
            NULL_PTR_RETURN_MSG_OUTER(argsInfo->hostInputInfoPtr, RT_ERROR_INVALID_VALUE);
            for (uint16_t i = 0U; i < argsInfo->hostInputInfoNum; i++) {
                COND_RETURN_OUT_ERROR_MSG_CALL(
                    argsInfo->hostInputInfoPtr[i].addrOffset >= argsInfo->argsSize, RT_ERROR_INVALID_VALUE,
                    "Parameter argsInfo->hostInputInfoPtr[%hu].addrOffset should be less than parameter argsInfo->argsSize. "
                    "Parameter argsInfo->hostInputInfoPtr[%hu].addrOffset = %u, parameter argsInfo->argsSize = %u.",
                    i, i, argsInfo->hostInputInfoPtr[i].addrOffset, argsInfo->argsSize);
                COND_RETURN_OUT_ERROR_MSG_CALL(
                    argsInfo->hostInputInfoPtr[i].dataOffset >= argsInfo->argsSize, RT_ERROR_INVALID_VALUE,
                    "Parameter argsInfo->hostInputInfoPtr[%hu].dataOffset should be less than parameter argsInfo->argsSize. "
                    "Parameter argsInfo->hostInputInfoPtr[%hu].dataOffset = %u, parameter argsInfo->argsSize = %u.",
                    i, i, argsInfo->hostInputInfoPtr[i].dataOffset, argsInfo->argsSize);
            }
        }
    }
    return RT_ERROR_NONE;
}

rtError_t ApiErrorDecorator::CheckNonArgsHandle(const RtArgsHandle * const argsHandle) const
{
    NULL_PTR_RETURN_MSG_OUTER(argsHandle, RT_ERROR_INVALID_VALUE);
    // 如果Finalize后，再update，只有update完成后再次调用Finalize，isParamUpdating重置为0，表示更新完成
    COND_RETURN_OUT_ERROR_MSG_CALL((argsHandle->isFinalized == 0U) || (argsHandle->isParamUpdating == 1U),
        RT_ERROR_INVALID_VALUE,
        "args handle is not finalized,invalid param.isFinalized=%u,isParamUpdating=%u",
        argsHandle->isFinalized, argsHandle->isParamUpdating);
    NULL_PTR_RETURN_MSG_OUTER(argsHandle->buffer, RT_ERROR_INVALID_VALUE);
    ZERO_RETURN_AND_MSG_OUTER(argsHandle->argsSize);

    for (uint16_t i = 0U; i < argsHandle->realUserParamNum; i++) {
        if (argsHandle->para[i].type == 0U) { // 0 is Common param, 1 is place holder param
            continue;
        }
        COND_RETURN_OUT_ERROR_MSG_CALL(
            argsHandle->para[i].paraOffset >= argsHandle->argsSize, RT_ERROR_INVALID_VALUE,
            "Parameter argsHandle->para[%hu].paraOffset should be less than parameter argsHandle->argsSize. "
            "Parameter argsHandle->para[%hu].paraOffset = %zu, parameter argsHandle->argsSize = %zu.",
            i, i, argsHandle->para[i].paraOffset, argsHandle->argsSize);
        COND_RETURN_OUT_ERROR_MSG_CALL(
            argsHandle->para[i].dataOffset >= argsHandle->argsSize, RT_ERROR_INVALID_VALUE,
            "Parameter argsHandle->para[%hu].dataOffset should be less than parameter argsHandle->argsSize. "
            "Parameter argsHandle->para[%hu].dataOffset = %zu, parameter argsHandle->argsSize = %zu.",
            i, i, argsHandle->para[i].dataOffset, argsHandle->argsSize);
    }

    return RT_ERROR_NONE;
}

static rtError_t CheckCpuArgsInfo(const rtCpuKernelArgs_t * const argsInfo)
{
    NULL_PTR_RETURN_MSG_OUTER(argsInfo, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(argsInfo->baseArgs.args, RT_ERROR_INVALID_VALUE);
    ZERO_RETURN_AND_MSG_OUTER(argsInfo->baseArgs.argsSize);

    return RT_ERROR_NONE;
}

rtError_t ApiErrorDecorator::CheckArgsWithType(const RtArgsWithType * const argsWithType) const
{
    NULL_PTR_RETURN_MSG_OUTER(argsWithType, RT_ERROR_INVALID_VALUE);

    rtError_t error = RT_ERROR_NONE;
    switch (argsWithType->type) {
        case RT_ARGS_NON_CPU_EX:
            error = CheckArgs(argsWithType->args.nonCpuArgsInfo);
            break;
        case RT_ARGS_CPU_EX:
            error = CheckCpuArgsInfo(argsWithType->args.cpuArgsInfo);
            break;
        case RT_ARGS_HANDLE:
            error = CheckNonArgsHandle(argsWithType->args.argHandle);
            break;
        default:
            RT_LOG(RT_LOG_ERROR, "check args failed. type=%u", static_cast<uint32_t>(argsWithType->type));
            error = RT_ERROR_INVALID_VALUE;
            break;
    }

    return error;
}

rtError_t ApiErrorDecorator::CheckMemcpyCfg(const RtMemcpyCfgInfo* const configInfo, const bool isAsync) const
{
    if (isAsync) {
        COND_RETURN_AND_MSG_OUTER_WITH_PARAM((configInfo->checkBitmap >= NOT_CHECK_KIND_BUT_CHECK_PINNED), 
            RT_ERROR_INVALID_VALUE, configInfo->checkBitmap, "[0, 2]");
    } else {
        COND_RETURN_AND_MSG_OUTER_WITH_PARAM((configInfo->checkBitmap > NOT_CHECK_KIND_BUT_CHECK_PINNED), 
            RT_ERROR_INVALID_VALUE, configInfo->checkBitmap, "[0, 3]");
    }

    return RT_ERROR_NONE;
}

rtError_t ApiErrorDecorator::GetMemcpyConfigInfo(RtMemcpyCfgInfo* configInfo, const rtMemcpyConfig_t* const memcpyConfig,
    const bool isAsync)
{
    rtError_t error = RT_ERROR_NONE;
    NULL_PTR_RETURN_MSG_OUTER(memcpyConfig->attrs, RT_ERROR_INVALID_VALUE);
    for (uint32_t i = 0U; i < memcpyConfig->numAttrs; i++) {
        rtMemcpyAttribute_t* attr = &(memcpyConfig->attrs[i]);
        error = GetMemcpyConfigAttr(attr, configInfo);
        COND_RETURN_WITH_NOLOG((error != RT_ERROR_NONE), error);
    }

    error = CheckMemcpyCfg(configInfo, isAsync);
    return error;
}

rtError_t ApiErrorDecorator::GetMemcpyConfigAttr(rtMemcpyAttribute_t* attr, RtMemcpyCfgInfo* configInfo) const
{
    rtError_t error = RT_ERROR_NONE;
    NULL_PTR_RETURN_MSG_OUTER(attr, RT_ERROR_INVALID_VALUE);
    switch (attr->id) {
        case RT_MEMCPY_ATTRIBUTE_CHECK:
            configInfo->checkBitmap = attr->value.checkBitmap;
            break;
        default:
            RT_LOG_OUTER_MSG_INVALID_PARAM(attr->id, 1);
            error = RT_ERROR_INVALID_VALUE;
            break;
    }
    return error;
}

rtError_t ApiErrorDecorator::KernelGetAddrAndPrefCnt(void * const hdl, const uint64_t tilingKey,
                                                     const void * const stubFunc, const uint32_t flag,
                                                     void ** const addr, uint32_t * const prefetchCnt)
{
    NULL_PTR_RETURN_MSG_OUTER(addr, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(prefetchCnt, RT_ERROR_INVALID_VALUE);
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM((flag > RT_DYNAMIC_SHAPE_KERNEL), RT_ERROR_INVALID_VALUE, 
        flag, "[0, " + std::to_string(RT_DYNAMIC_SHAPE_KERNEL) + "]");

    if (flag == RT_STATIC_SHAPE_KERNEL) {
        NULL_PTR_RETURN_MSG_OUTER(stubFunc, RT_ERROR_INVALID_VALUE);
    } else {
        NULL_PTR_RETURN_MSG_OUTER(hdl, RT_ERROR_INVALID_VALUE);
    }

    const rtError_t error = impl_->KernelGetAddrAndPrefCnt(hdl, tilingKey, stubFunc, flag, addr, prefetchCnt);
    ERROR_RETURN_MSG_INNER(error, "get addr and prefCnt failed, tilingKey=%" PRIu64, tilingKey);
    return error;
}

rtError_t ApiErrorDecorator::KernelGetAddrAndPrefCntV2(void * const hdl, const uint64_t tilingKey,
                                                       const void * const stubFunc, const uint32_t flag,
                                                       rtKernelDetailInfo_t * const kernelInfo)
{
    bool invalidFlag = false;
    if (flag == RT_STATIC_SHAPE_KERNEL) {
        if (stubFunc == nullptr) {
            invalidFlag = true;
        }
    } else {
        if (hdl == nullptr) {
            invalidFlag = true;
        }
    }

    NULL_PTR_RETURN_MSG_OUTER(kernelInfo, RT_ERROR_INVALID_VALUE);
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM((flag > RT_DYNAMIC_SHAPE_KERNEL), 
        RT_ERROR_INVALID_VALUE, flag, "[0, " + std::to_string(RT_DYNAMIC_SHAPE_KERNEL) + "]");
    COND_RETURN_OUT_ERROR_MSG_CALL((invalidFlag == true), RT_ERROR_INVALID_VALUE, 
        "If parameter flag is equal to %u, parameter stubFunc cannot be nullptr; "
        "If parameter flag is not equal to %u, parameter hdl cannot be nullptr.", 
        RT_STATIC_SHAPE_KERNEL, RT_STATIC_SHAPE_KERNEL);

    const rtError_t error = impl_->KernelGetAddrAndPrefCntV2(hdl, tilingKey, stubFunc, flag, kernelInfo);
    ERROR_RETURN(error, "get addr and prefCnt failed, tilingKey=%" PRIu64, tilingKey);
    return error;
}

rtError_t ApiErrorDecorator::QueryFunctionRegistered(const char_t * const stubName)
{
    NULL_PTR_RETURN_MSG_OUTER(stubName, RT_ERROR_INVALID_VALUE);
    return impl_->QueryFunctionRegistered(stubName);
}

rtError_t ApiErrorDecorator::CheckCfg(const rtTaskCfgInfo_t * const cfgInfo) const
{
    if ((cfgInfo != nullptr) && (cfgInfo->schemMode >= RT_SCHEM_MODE_END)) {
        RT_LOG_OUTER_MSG_INVALID_PARAM(
           cfgInfo->schemMode,
           "[" + std::to_string(RT_SCHEM_MODE_NORMAL) + ", " + std::to_string(RT_SCHEM_MODE_END) + ")");
        return RT_ERROR_INVALID_VALUE;
    }
    return RT_ERROR_NONE;
}

rtError_t ApiErrorDecorator::AppendLaunchAddrInfo(rtLaunchArgs_t* const hdl, void * const addrInfo)
{
    NULL_PTR_RETURN_MSG_OUTER(hdl, RT_ERROR_INVALID_VALUE);
    /* addrInfo == nullptr is an empty tensor scenario. No error is returned. */
    if (addrInfo == nullptr) {
        RT_LOG(RT_LOG_WARNING, "addrInfo == nullptr.");
    }
    const uint32_t offset = static_cast<uint32_t>(hdl->argsAddrOffset + sizeof(uint64_t));
    COND_RETURN_OUT_ERROR_MSG_CALL(offset > hdl->argsDataOffset, RT_ERROR_INVALID_VALUE,
        "Parameter hdl->argsDataOffset should be greater than or equal to the sum of parameter hdl->argsAddrOffset and %zu. "
        "Parameter hdl->argsAddrOffset = %u, parameter hdl->argsDataOffset = %u.", sizeof(uint64_t), hdl->argsAddrOffset, hdl->argsDataOffset);

    return impl_->AppendLaunchAddrInfo(hdl, addrInfo);
}

rtError_t ApiErrorDecorator::AppendLaunchHostInfo(rtLaunchArgs_t* const hdl, size_t const hostInfoSize,
    void ** const hostInfo)
{
    NULL_PTR_RETURN_MSG_OUTER(hdl, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(hostInfo, RT_ERROR_INVALID_VALUE);
    COND_RETURN_OUT_ERROR_MSG_CALL(hdl->argsInfo.hostInputInfoNum >= hdl->hostInfoMaxNum, RT_ERROR_INVALID_VALUE, 
        "Parameter hdl->argsInfo.hostInputInfoNum should be less than parameter hdl->hostInfoMaxNum. " 
        "Parameter hdl->argsInfo.hostInputInfoNum = %u, parameter hdl->hostInfoMaxNum = %u.",
        hdl->argsInfo.hostInputInfoNum, hdl->hostInfoMaxNum);
    ZERO_RETURN_AND_MSG_OUTER(hostInfoSize);
    uint32_t currentDataOffset = static_cast<uint32_t>(hdl->argsHostInputOffset + hostInfoSize);
    COND_RETURN_OUT_ERROR_MSG_CALL(currentDataOffset > hdl->argsInfo.argsSize, RT_ERROR_INVALID_VALUE, 
        "Parameter hdl->argsInfo.argsSize should be greater than or equal to the sum of parameter hdl->argsHostInputOffset and parameter hostInfoSize. "
        "Parameter hdl->argsInfo.argsSize = %u, parameter hdl->argsHostInputOffset = %u, parameter hostInfoSize = %zu.",
        hdl->argsInfo.argsSize, hdl->argsHostInputOffset, hostInfoSize);

    return impl_->AppendLaunchHostInfo(hdl, hostInfoSize, hostInfo);
}

rtError_t ApiErrorDecorator::CalcLaunchArgsSize(size_t const argsSize, size_t const hostInfoTotalSize,
                                                size_t hostInfoNum, size_t * const launchArgsSize)
{
    NULL_PTR_RETURN_MSG_OUTER(launchArgsSize, RT_ERROR_INVALID_VALUE);
    ZERO_RETURN_AND_MSG_OUTER(argsSize);
    ZERO_RETURN_AND_MSG_OUTER(hostInfoTotalSize);
    COND_RETURN_ERROR_MSG_INNER(hostInfoNum == 0U || hostInfoNum > static_cast<size_t>(UINT16_MAX),
        RT_ERROR_INVALID_VALUE,
        "hostInfoNum [%zu] is invalid, valid range is [1, %d]",
        hostInfoNum,
        UINT16_MAX);

    return impl_->CalcLaunchArgsSize(argsSize, hostInfoTotalSize, hostInfoNum, launchArgsSize);
}

rtError_t ApiErrorDecorator::CreateLaunchArgs(size_t const argsSize, size_t const hostInfoTotalSize,
                                              size_t hostInfoNum, void * const argsData,
                                              rtLaunchArgs_t ** const argsHandle)
{
    NULL_PTR_RETURN_MSG_OUTER(argsData, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(argsHandle, RT_ERROR_INVALID_VALUE);
    ZERO_RETURN_AND_MSG_OUTER(argsSize);
    ZERO_RETURN_AND_MSG_OUTER(hostInfoTotalSize);
    COND_RETURN_ERROR_MSG_INNER(hostInfoNum == 0U || hostInfoNum > static_cast<size_t>(UINT16_MAX),
        RT_ERROR_INVALID_VALUE,
        "hostInfoNum [%zu] is invalid, valid range is [1, %d]",
        hostInfoNum,
        UINT16_MAX);
    const rtError_t error = impl_->CreateLaunchArgs(argsSize, hostInfoTotalSize, hostInfoNum, argsData, argsHandle);
    ERROR_RETURN(error, "CreateLaunchArgs, argsSize=%zu, hostInfoTotalSize=%zu, hostInfoNum=%zu, argsData=0x%x",
        argsSize, hostInfoTotalSize, hostInfoNum, argsData);
    return error;
}

rtError_t ApiErrorDecorator::DestroyLaunchArgs(rtLaunchArgs_t* argsHandle)
{
    NULL_PTR_RETURN_MSG_OUTER(argsHandle, RT_ERROR_INVALID_VALUE);
    return impl_->DestroyLaunchArgs(argsHandle);
}

rtError_t ApiErrorDecorator::ResetLaunchArgs(rtLaunchArgs_t* argsHandle)
{
    NULL_PTR_RETURN_MSG_OUTER(argsHandle, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(argsHandle->argsInfo.args, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(argsHandle->argsInfo.hostInputInfoPtr, RT_ERROR_INVALID_VALUE);
    const rtError_t error = impl_->ResetLaunchArgs(argsHandle);
    ERROR_RETURN(error, "ResetLaunchArgs argsHandle = 0x%x", argsHandle);
    return error;
}

rtError_t ApiErrorDecorator::BinaryLoad(const rtDevBinary_t * const bin, Program ** const prog)
{
    NULL_PTR_RETURN_MSG_OUTER(bin, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(prog, RT_ERROR_INVALID_VALUE);
    ZERO_RETURN_AND_MSG_OUTER(bin->length);
    NULL_PTR_RETURN_MSG_OUTER(bin->data, RT_ERROR_INVALID_VALUE);

    const uint32_t magic = bin->magic;
    const bool isElfProgram = ((magic == RT_DEV_BINARY_MAGIC_ELF) || (magic == RT_DEV_BINARY_MAGIC_ELF_AICUBE) ||
        (magic == RT_DEV_BINARY_MAGIC_ELF_AIVEC));
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_TBE, !isElfProgram, RT_ERROR_INVALID_VALUE,
        "Invalid magic, magic=%#x", magic);

    const rtError_t error = impl_->BinaryLoad(bin, prog);
    ERROR_RETURN(error, "BinaryLoad failed.");
    return error;
}

rtError_t ApiErrorDecorator::BinaryGetFunction(const Program * const prog, const uint64_t tilingKey,
                                               Kernel ** const funcHandle)
{
    NULL_PTR_RETURN_MSG_OUTER(prog, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(funcHandle, RT_ERROR_INVALID_VALUE);

    const rtError_t error = impl_->BinaryGetFunction(prog, tilingKey, funcHandle);
    ERROR_RETURN(error, "BinaryGetFunction failed.");
    return error;
}

rtError_t ApiErrorDecorator::BinaryLoadWithoutTilingKey(const void *data, const uint64_t length, Program ** const prog)
{
    NULL_PTR_RETURN_MSG_OUTER(data, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(prog, RT_ERROR_INVALID_VALUE);
    ZERO_RETURN_AND_MSG_OUTER(length);

    const rtError_t error = impl_->BinaryLoadWithoutTilingKey(data, length, prog);
    ERROR_RETURN(error, "BinaryLoadWithoutTilingKey failed.");
    return error;
}

rtError_t ApiErrorDecorator::BinaryGetFunctionByName(const Program * const binHandle, const char_t *kernelName,
                                                     Kernel ** const funcHandle)
{
    NULL_PTR_RETURN_MSG_OUTER(binHandle, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(kernelName, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(funcHandle, RT_ERROR_INVALID_VALUE);

    const rtError_t error = impl_->BinaryGetFunctionByName(binHandle, kernelName, funcHandle);
    ERROR_RETURN(error, "BinaryGetFunction failed.");
    return error;
}

rtError_t ApiErrorDecorator::BinaryGetFunctionByEntry(const Program * const binHandle, const uint64_t funcEntry,
                                                      Kernel ** const funcHandle)
{
    NULL_PTR_RETURN_MSG_OUTER(binHandle, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(funcHandle, RT_ERROR_INVALID_VALUE);
	const KernelRegisterType kernelRegType = binHandle->GetKernelRegType();
    COND_RETURN_AND_MSG_OUTER(kernelRegType != RT_KERNEL_REG_TYPE_NON_CPU, RT_ERROR_INVALID_VALUE, 
        ErrorCode::EE1006, __func__, "kernelRegType=" + std::to_string(kernelRegType));

    return impl_->BinaryGetFunctionByEntry(binHandle, funcEntry, funcHandle);
}

rtError_t ApiErrorDecorator::BinaryGetMetaInfo(Program * const binHandle, const rtBinaryMetaType type,
                                               void *data, const uint32_t length)
{
    NULL_PTR_RETURN_MSG_OUTER(binHandle, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(data, RT_ERROR_INVALID_VALUE);
    return impl_->BinaryGetMetaInfo(binHandle, type, data, length);
}

rtError_t ApiErrorDecorator::FunctionGetMetaInfo(const Kernel * const funcHandle, const rtFunctionMetaType type, 
                                                 void *data, const uint32_t length)
{
    NULL_PTR_RETURN_MSG_OUTER(funcHandle, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(data, RT_ERROR_INVALID_VALUE);
    return impl_->FunctionGetMetaInfo(funcHandle, type, data, length);
}  

rtError_t ApiErrorDecorator::RegisterCpuFunc(
    rtBinHandle binHandle, const char_t *const funcName, const char_t *const kernelName, rtFuncHandle *funcHandle)
{
    NULL_PTR_RETURN_MSG_OUTER(binHandle, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(funcName, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(kernelName, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(funcHandle, RT_ERROR_INVALID_VALUE);

    return impl_->RegisterCpuFunc(binHandle, funcName, kernelName, funcHandle);
}

rtError_t ApiErrorDecorator::BinaryUnLoad(Program * const binHandle)
{
    NULL_PTR_RETURN_MSG_OUTER(binHandle, RT_ERROR_INVALID_VALUE);

    const rtError_t error = impl_->BinaryUnLoad(binHandle);
    ERROR_RETURN(error, "BinaryUnLoad failed.");
    return error;
}

rtError_t ApiErrorDecorator::BinaryLoadFromFile(const char_t * const binPath,
                                                const rtLoadBinaryConfig_t * const optionalCfg,
                                                Program **handle)
{
    NULL_PTR_RETURN_MSG_OUTER(binPath, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(handle, RT_ERROR_INVALID_VALUE);

    const rtError_t error = impl_->BinaryLoadFromFile(binPath, optionalCfg, handle);
    ERROR_RETURN(error, "Binary load from file failed.");
    return error;
}

rtError_t ApiErrorDecorator::BinaryLoadFromData(const void * const data, const uint64_t length,
                                                const rtLoadBinaryConfig_t * const optionalCfg, Program **handle)
{
    NULL_PTR_RETURN_MSG_OUTER(data, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(handle, RT_ERROR_INVALID_VALUE);
    ZERO_RETURN_AND_MSG_OUTER(length);

    const rtError_t error = impl_->BinaryLoadFromData(data, length, optionalCfg, handle);
    ERROR_RETURN(error, "Binary load from data failed.");
    return error;
}

rtError_t ApiErrorDecorator::FuncGetAddr(const Kernel * const funcHandle, void ** const aicAddr, void ** const aivAddr)
{
    NULL_PTR_RETURN_MSG_OUTER(funcHandle, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(aicAddr, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(aivAddr, RT_ERROR_INVALID_VALUE);
    const KernelRegisterType kernelRegType = funcHandle->GetKernelRegisterType();
    COND_RETURN_AND_MSG_OUTER(kernelRegType != RT_KERNEL_REG_TYPE_NON_CPU, RT_ERROR_INVALID_VALUE, 
        ErrorCode::EE1006, __func__, "kernelRegType=" + std::to_string(kernelRegType));
    const rtError_t error = impl_->FuncGetAddr(funcHandle, aicAddr, aivAddr);
    ERROR_RETURN(error, "Get func addr by function handle failed.");
    return error;
}

rtError_t ApiErrorDecorator::LaunchKernel(Kernel * const kernel, uint32_t blockDim, const rtArgsEx_t * const argsInfo,
                                          Stream * const stm, const rtTaskCfgInfo_t * const cfgInfo)
{
    NULL_PTR_RETURN_MSG_OUTER(kernel, RT_ERROR_INVALID_VALUE);
    ZERO_RETURN_AND_MSG_OUTER(blockDim);
    rtError_t error = CheckArgs(argsInfo);
    ERROR_RETURN(error, "check argsInfo failed, retCode=%#x.", error);
    error = CheckCfg(cfgInfo);
    ERROR_RETURN(error, "check cfgInfo failed, retCode=%#x.", error);
    error = impl_->LaunchKernel(kernel, blockDim, argsInfo, stm, cfgInfo);
    ERROR_RETURN(error, "LaunchKernel failed.");
    return error;
}

static rtError_t CheckKernelLaunchCfg(const rtKernelLaunchCfg_t * const cfg, const Kernel * const kernel) 
{
    const rtChipType_t chipType = Runtime::Instance()->GetChipType();
    const uint8_t mixType = kernel->GetMixType();
    const KernelRegisterType kernelRegType = kernel->GetKernelRegisterType();
    const static bool isVectorCoreEnable = IS_SUPPORT_CHIP_FEATURE(chipType,
        RtOptionalFeatureType::RT_FEATURE_DEVICE_EXTRA_VECTOR_CORE);
    // CHIP_DC的MIX算子只用于Vector core使能，按照最新约束必须得有engineType和blockDimOffset，否则校验失败
    if (isVectorCoreEnable &&
        (kernelRegType != RT_KERNEL_REG_TYPE_CPU) && (mixType != NO_MIX)) {
        NULL_PTR_RETURN_MSG_OUTER(cfg, RT_ERROR_INVALID_VALUE);
        NULL_PTR_RETURN_MSG_OUTER(cfg->attrs, RT_ERROR_INVALID_VALUE);
        ZERO_RETURN_AND_MSG_OUTER(cfg->numAttrs); // numAttrs=0表示没有TV参数
    } else {
        // cfg support nullptr, no need process
        NULL_PTR_RETURN_NOLOG(cfg, RT_ERROR_NONE);
        NULL_PTR_RETURN_MSG_OUTER(cfg->attrs, RT_ERROR_INVALID_VALUE);
    }

    uint8_t schedMode = static_cast<uint8_t>(RT_SCHEM_MODE_NORMAL);
    uint8_t isDataDump = DATA_DUMP_DISABLE;
    uint8_t isBlockPrefetch= BLOCK_PREFETCH_DISABLE;
    bool blockDimOffsetExist = false;
    bool engineTypeExist = false;
    bool timeoutFlag = false;
    bool timeoutUsFlag = false;
    for (size_t idx = 0U; idx < cfg->numAttrs; idx++) {
        switch (cfg->attrs[idx].id) {
            case RT_LAUNCH_KERNEL_ATTR_SCHEM_MODE:
                schedMode = cfg->attrs[idx].value.schemMode;
                break;
            case RT_LAUNCH_KERNEL_ATTR_ENGINE_TYPE:
                engineTypeExist = true;
                break;
            case RT_LAUNCH_KERNEL_ATTR_BLOCKDIM_OFFSET:
                blockDimOffsetExist = true;
                break;
            case RT_LAUNCH_KERNEL_ATTR_BLOCK_TASK_PREFETCH:
                isBlockPrefetch = cfg->attrs[idx].value.isBlockTaskPrefetch; // 0: disable, 1: enable
                break;
            case RT_LAUNCH_KERNEL_ATTR_DATA_DUMP:
                isDataDump = cfg->attrs[idx].value.isDataDump; // 0: disable, 1: enable
                break;
            case RT_LAUNCH_KERNEL_ATTR_TIMEOUT:
                timeoutFlag = true;
                break;
            case RT_LAUNCH_KERNEL_ATTR_TIMEOUT_US:
                timeoutUsFlag = true;
                break;
            default:
                break;
        }
    }

    COND_RETURN_OUT_ERROR_MSG_CALL((timeoutFlag && timeoutUsFlag),
        RT_ERROR_INVALID_VALUE, 
        "The RT_LAUNCH_KERNEL_ATTR_TIMEOUT and RT_LAUNCH_KERNEL_ATTR_TIMEOUT_US attributes cannot be carried at the same time.");

    COND_RETURN_AND_MSG_OUTER_WITH_PARAM(schedMode >= static_cast<uint8_t>(RT_SCHEM_MODE_END),
        RT_ERROR_INVALID_VALUE, schedMode, "[0, " + std::to_string(RT_SCHEM_MODE_END) + ")");

    COND_RETURN_AND_MSG_OUTER_WITH_PARAM((isBlockPrefetch != BLOCK_PREFETCH_DISABLE) && (isBlockPrefetch != BLOCK_PREFETCH_ENABLE), 
        RT_ERROR_INVALID_VALUE, isBlockPrefetch, "[0, 1]");

    COND_RETURN_AND_MSG_OUTER_WITH_PARAM((isDataDump != DATA_DUMP_ENABLE) && (isDataDump != DATA_DUMP_DISABLE), 
        RT_ERROR_INVALID_VALUE, isDataDump, "[0, 1]");

    // 如果是CHIP_DC vector使能场景，需要校验如果有相应TV参数， 非CHIP_DC、CPU算子、非MIX场景不做校验
    COND_RETURN_WITH_NOLOG(!isVectorCoreEnable ||
        (kernelRegType == RT_KERNEL_REG_TYPE_CPU) || (mixType == NO_MIX), RT_ERROR_NONE);

    COND_RETURN_OUT_ERROR_MSG_CALL((!blockDimOffsetExist || !engineTypeExist), RT_ERROR_INVALID_VALUE,
        "Insufficient parameters in the vector core enabled scenario.");
    
    return RT_ERROR_NONE;
}

rtError_t ApiErrorDecorator::LaunchKernelV2(Kernel * const kernel, uint32_t blockDim, const RtArgsWithType * const argsWithType,
    Stream * const stm, const rtKernelLaunchCfg_t * const cfg)
{
    NULL_PTR_RETURN_MSG_OUTER(kernel, RT_ERROR_INVALID_VALUE);
    ZERO_RETURN_AND_MSG_OUTER(blockDim);

    rtError_t error = CheckArgsWithType(argsWithType);
    ERROR_RETURN(error, "check args with type failed, retCode=%#x.", error);
    error = CheckKernelLaunchCfg(cfg, kernel);
    ERROR_RETURN(error, "check cfgInfo failed, retCode=%#x.", error);
    error = impl_->LaunchKernelV2(kernel, blockDim, argsWithType, stm, cfg);
    COND_PROC((error == RT_ERROR_KERNEL_INVALID), return error;);
    ERROR_RETURN(error, "LaunchKernel failed.");
    return error;
}

rtError_t ApiErrorDecorator::LaunchKernelV3(Kernel * const kernel, const rtArgsEx_t * const argsInfo,
                                            Stream * const stm, const rtLaunchConfig_t * const launchConfig)
{
    NULL_PTR_RETURN_MSG_OUTER(kernel, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(launchConfig, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(launchConfig->attrs, RT_ERROR_INVALID_VALUE);
    const rtError_t error = CheckArgs(argsInfo);
    ERROR_RETURN(error, "check argsInfo failed, retCode=%#x.", error);
    return impl_->LaunchKernelV3(kernel, argsInfo, stm, launchConfig);
}

rtError_t ApiErrorDecorator::KernelLaunch(const void * const stubFunc, const uint32_t coreDim,
    const rtArgsEx_t * const argsInfo, rtL2Ctrl_t * const l2ctrl, Stream * const stm, const uint32_t flag,
    const rtTaskCfgInfo_t * const cfgInfo, const bool isLaunchVec)
{
    NULL_PTR_RETURN_MSG_OUTER(stubFunc, RT_ERROR_INVALID_VALUE);
    ZERO_RETURN_AND_MSG_OUTER(coreDim);
    // coreDim is defined uint16_t by sqe
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM(coreDim > static_cast<uint32_t>(UINT16_MAX), 
        RT_ERROR_INVALID_VALUE, coreDim, "less than or equal to " + std::to_string(UINT16_MAX));
    rtError_t error = CheckArgs(argsInfo);
    ERROR_RETURN(error, "check argsInfo failed, retCode=%#x.", error);
    error = CheckCfg(cfgInfo);
    ERROR_RETURN(error, "check cfgInfo failed, retCode=%#x.", error);
    error = impl_->KernelLaunch(stubFunc, coreDim, argsInfo, l2ctrl, stm, flag, cfgInfo, isLaunchVec);
    ERROR_RETURN(error, "Launch kernel failed, dim=%u.", coreDim);
    return error;
}

rtError_t ApiErrorDecorator::KernelLaunchWithHandle(void * const hdl, const uint64_t tilingKey,
    const uint32_t coreDim, const rtArgsEx_t * const argsInfo, rtL2Ctrl_t * const l2ctrl,
    Stream * const stm, const rtTaskCfgInfo_t * const cfgInfo, const bool isLaunchVec)
{
    ZERO_RETURN_AND_MSG_OUTER(coreDim);
    rtError_t error = CheckArgs(argsInfo);
    ERROR_RETURN(error, "check argsInfo failed, retCode=%#x.", error);
    error = CheckCfg(cfgInfo);
    ERROR_RETURN(error, "check cfgInfo failed, retCode=%#x.", error);
    error = impl_->KernelLaunchWithHandle(hdl, tilingKey, coreDim, argsInfo, l2ctrl, stm, cfgInfo, isLaunchVec);
    ERROR_RETURN(error, "Launch kernel with hdl failed, dim=%u.", coreDim);
    return error;
}

rtError_t ApiErrorDecorator::KernelLaunchEx(const char_t * const opName, const void * const args,
    const uint32_t argsSize, const uint32_t flags, Stream * const stm)
{
    NULL_PTR_RETURN_MSG_OUTER(opName, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(args, RT_ERROR_INVALID_VALUE);
    ZERO_RETURN_AND_MSG_OUTER(argsSize);

    const rtError_t error = impl_->KernelLaunchEx(opName, args, argsSize, flags, stm);
    ERROR_RETURN(error, "Launch kernel[extend] failed, opName=%s, argsSize=%u(bytes), flags=%u.",
        opName, argsSize, flags);
    return error;
}

rtError_t ApiErrorDecorator::CpuKernelLaunch(const rtKernelLaunchNames_t * const launchNames, const uint32_t coreDim,
    const rtArgsEx_t * const argsInfo, rtL2Ctrl_t * const l2ctrl, Stream * const stm, const uint32_t flag)
{
    // So name of control task is null. No need to check.
    NULL_PTR_RETURN_MSG_OUTER(launchNames, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(launchNames->opName, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(launchNames->kernelName, RT_ERROR_INVALID_VALUE);
    ZERO_RETURN_AND_MSG_OUTER(coreDim);
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM(coreDim >= 0x10000U, RT_ERROR_INVALID_VALUE, 
        coreDim, "less than or equal to 0xffff");    
    rtError_t error = CheckArgs(argsInfo);
    ERROR_RETURN_MSG_CALL(ERR_MODULE_GE, error, "check argsInfo failed, retCode=%#x.", static_cast<uint32_t>(error));

    error = impl_->CpuKernelLaunch(launchNames, coreDim, argsInfo, l2ctrl, stm, flag);
    const char_t *soName = (launchNames->soName == nullptr) ? "" : launchNames->soName;
    ERROR_RETURN(error, "Launch cpu kernel failed, soName=%s, kernel_name=%s, opName=%s, coreDim=%u,"
        " argsSize=%u(bytes), hostInputLen=%hu, flag=%u.", soName, launchNames->kernelName,
        launchNames->opName, coreDim, argsInfo->argsSize, argsInfo->hostInputInfoNum, flag);
    return error;
}

rtError_t ApiErrorDecorator::MultipleTaskInfoLaunch(const rtMultipleTaskInfo_t * const taskInfo, Stream * const stm,
    const uint32_t flag)
{
    NULL_PTR_RETURN_MSG_OUTER(taskInfo, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(taskInfo->taskDesc, RT_ERROR_INVALID_VALUE);
    ZERO_RETURN_AND_MSG_OUTER(taskInfo->taskNum);
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM((taskInfo->taskNum > MULTIPLE_TASK_MAX_NUM), RT_ERROR_INVALID_VALUE, 
        taskInfo->taskNum, "less than or equal to " + std::to_string(MULTIPLE_TASK_MAX_NUM));
    // MultipleTaskInfoLaunch only support RT_KERNEL_DEFAULT and RT_KERNEL_CMDLIST_NOT_FREE
    constexpr uint32_t permitFlag = (RT_KERNEL_DEFAULT | RT_KERNEL_CMDLIST_NOT_FREE);
    if ((flag & (~permitFlag)) != 0U) {
        RT_LOG(RT_LOG_ERROR, "unsupported flag : %u", flag);
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }
    for (size_t idx = 0U; idx < taskInfo->taskNum; idx++) {
        if (taskInfo->taskDesc[idx].type == RT_MULTIPLE_TASK_TYPE_DVPP) {
            const uint16_t type = taskInfo->taskDesc[idx].u.dvppTaskDesc.sqe.sqeHeader.type;
            COND_RETURN_OUT_ERROR_MSG_CALL(!IsDvppTask(type), RT_ERROR_INVALID_VALUE,
                "Failed to launch multiple tasks in case DVPP. Invalid sqe_type: %hu", type);
            const uint32_t pos = taskInfo->taskDesc[idx].u.dvppTaskDesc.aicpuTaskPos;
            COND_RETURN_OUT_ERROR_MSG_CALL(pos >= stm->GetSqDepth(),
                RT_ERROR_INVALID_VALUE,
                "Failed to launch multiple tasks in case DVPP. Invalid pos: %u, rtsqDepth : %u",
                pos, stm->GetSqDepth());
        } else if (taskInfo->taskDesc[idx].type == RT_MULTIPLE_TASK_TYPE_AICPU) {
            NULL_PTR_RETURN_MSG_OUTER(taskInfo->taskDesc[idx].u.aicpuTaskDesc.kernelLaunchNames.soName,
                RT_ERROR_INVALID_VALUE);
            NULL_PTR_RETURN_MSG_OUTER(taskInfo->taskDesc[idx].u.aicpuTaskDesc.kernelLaunchNames.opName,
                RT_ERROR_INVALID_VALUE);
            NULL_PTR_RETURN_MSG_OUTER(taskInfo->taskDesc[idx].u.aicpuTaskDesc.kernelLaunchNames.kernelName,
                RT_ERROR_INVALID_VALUE);
            const uint32_t coreDim = taskInfo->taskDesc[idx].u.aicpuTaskDesc.blockDim;
            ZERO_RETURN_AND_MSG_OUTER(coreDim);
            COND_RETURN_AND_MSG_OUTER_WITH_PARAM(coreDim > static_cast<uint32_t>(UINT16_MAX), 
                RT_ERROR_INVALID_VALUE, coreDim, "less than or equal to " + std::to_string(UINT16_MAX));
            const rtError_t error = CheckArgs(&(taskInfo->taskDesc[idx].u.aicpuTaskDesc.argsInfo));
            ERROR_RETURN_MSG_CALL(ERR_MODULE_GE, error, "check argsInfo failed, retCode=%#x.", static_cast<uint32_t>(error));
        } else if (taskInfo->taskDesc[idx].type == RT_MULTIPLE_TASK_TYPE_AICPU_BY_HANDLE) {
            Kernel *hdl = RtPtrToPtr<Kernel *>(taskInfo->taskDesc[idx].u.aicpuTaskDescByHandle.funcHdl);
            NULL_PTR_RETURN_MSG_OUTER(hdl, RT_ERROR_INVALID_VALUE);
            const uint32_t coreDim = taskInfo->taskDesc[idx].u.aicpuTaskDescByHandle.blockDim;
            ZERO_RETURN_AND_MSG_OUTER(coreDim);
            COND_RETURN_AND_MSG_OUTER_WITH_PARAM(coreDim > static_cast<uint32_t>(UINT16_MAX), 
                RT_ERROR_INVALID_VALUE, coreDim, "less than or equal to " + std::to_string(UINT16_MAX));
            const rtError_t error = CheckArgs(&(taskInfo->taskDesc[idx].u.aicpuTaskDescByHandle.argsInfo));
            ERROR_RETURN_MSG_CALL(ERR_MODULE_GE, error, "check argsInfo failed, retCode=%#x.", static_cast<uint32_t>(error));
        } else {
            RT_LOG_OUTER_MSG_WITH_FUNC(ErrorCode::EE1003,
                taskInfo->taskDesc[idx].type, "taskInfo->taskDesc[" + std::to_string(idx) +"].type",
                "[0, " + std::to_string(RT_MULTIPLE_TASK_TYPE_MAX) + ")");
            return RT_ERROR_INVALID_VALUE;
        }
    }
    const rtError_t error = impl_->MultipleTaskInfoLaunch(taskInfo, stm, flag);
    return error;
}

rtError_t ApiErrorDecorator::CpuKernelLaunchExWithArgs(const char_t * const opName, const uint32_t coreDim,
    const rtAicpuArgsEx_t * const argsInfo, rtL2Ctrl_t * const l2ctrl, Stream * const stm, const uint32_t flag,
    const uint32_t kernelType)
{
    // So name of control task is null. No need to check.
    NULL_PTR_RETURN_MSG_OUTER(opName, RT_ERROR_INVALID_VALUE);
    ZERO_RETURN_AND_MSG_OUTER(coreDim);
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM(coreDim >= 0x10000U, RT_ERROR_INVALID_VALUE, 
        coreDim, "less than or equal to 0xffff");   
    COND_RETURN_OUT_ERROR_MSG_CALL((stm != nullptr) &&
        ((stm->Flags() & RT_STREAM_CP_PROCESS_USE) != 0U),
        RT_ERROR_STREAM_INVALID,
        "Cpu kernel launch ex with args failed, the stm can not be coprocessor stream flag=%u",
        stm->Flags());
    NULL_PTR_RETURN_MSG_OUTER(argsInfo, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(argsInfo->args, RT_ERROR_INVALID_VALUE);
    ZERO_RETURN_AND_MSG_OUTER(argsInfo->argsSize);

    const rtError_t error = impl_->CpuKernelLaunchExWithArgs(opName, coreDim, argsInfo, l2ctrl, stm, flag, kernelType);
    ERROR_RETURN(error, "Launch cpu kernel ex failed, coreDim=%u,"
        " argsSize=%u(bytes), hostInputLen=%hu, flag=%u, kernelType=%u.",  coreDim, argsInfo->argsSize,
        argsInfo->hostInputInfoNum, flag, kernelType);
    return error;
}

rtError_t ApiErrorDecorator::DatadumpInfoLoad(const void * const dumpInfo, const uint32_t length, const uint32_t flag)
{
    NULL_PTR_RETURN_MSG_OUTER(dumpInfo, RT_ERROR_INVALID_VALUE);
    ZERO_RETURN_AND_MSG_OUTER(length);
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM(((flag != RT_KERNEL_DEFAULT) && (flag != RT_KERNEL_CUSTOM_AICPU)), RT_ERROR_INVALID_VALUE, 
        flag, std::to_string(RT_KERNEL_DEFAULT) + " or " + std::to_string(RT_KERNEL_CUSTOM_AICPU));

    const rtError_t error = impl_->DatadumpInfoLoad(dumpInfo, length, flag);
    ERROR_RETURN(error, "Load data dump info failed, length=%u, flag=%u.", length, flag);
    return error;
}

rtError_t ApiErrorDecorator::AicpuInfoLoad(const void * const aicpuInfo, const uint32_t length)
{
    NULL_PTR_RETURN_MSG_OUTER(aicpuInfo, RT_ERROR_INVALID_VALUE);
    ZERO_RETURN_AND_MSG_OUTER(length);

    const rtChipType_t chipType = Runtime::Instance()->GetChipType();
    if (!IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_KERNEL_TILING_KEY_SINK)) {
        RT_LOG(RT_LOG_WARNING, "unsupported chip type (%d)", chipType);
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }

    Context *curCtx = Runtime::Instance()->CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    const uint32_t tschVersion = curCtx->Device_()->GetTschVersion();
    const bool isSupport = curCtx->Device_()->CheckFeatureSupport(TS_FEATURE_TILING_KEY_SINK);
    if (!isSupport) {
        RT_LOG(RT_LOG_WARNING, "unsupported task type (AicpuInfoLoad) in current ts version, tschVersion=%u",
            tschVersion);
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }

    const rtError_t error = impl_->AicpuInfoLoad(aicpuInfo, length);
    ERROR_RETURN(error, "Load aicpu info failed, length=%u.", length);
    return error;
}

rtError_t ApiErrorDecorator::SetupArgument(const void * const setupArg, const uint32_t size, const uint32_t offset)
{
    NULL_PTR_RETURN_MSG_OUTER(setupArg, RT_ERROR_INVALID_VALUE);
    ZERO_RETURN_AND_MSG_OUTER(size);

    const rtError_t error = impl_->SetupArgument(setupArg, size, offset);
    ERROR_RETURN(error, "Setup argument failed, size=%u(bytes), offset=%u.", size, offset);
    return error;
}

rtError_t ApiErrorDecorator::KernelTransArgSet(const void * const ptr, const uint64_t size, const uint32_t flag,
    void ** const setupArg)
{
    NULL_PTR_RETURN_MSG_OUTER(ptr, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(setupArg, RT_ERROR_INVALID_VALUE);
    ZERO_RETURN_AND_MSG_OUTER(size);

    return impl_->KernelTransArgSet(ptr, size, flag, setupArg);
}

rtError_t ApiErrorDecorator::KernelFusionStart(Stream * const stm)
{
    const rtError_t error = impl_->KernelFusionStart(stm);
    ERROR_RETURN(error, "Start kernel fusion failed.");
    return error;
}

rtError_t ApiErrorDecorator::KernelFusionEnd(Stream * const stm)
{
    const rtError_t error = impl_->KernelFusionEnd(stm);
    ERROR_RETURN(error, "End kernel fusion failed.");
    return error;
}

rtError_t ApiErrorDecorator::StreamCreate(Stream ** const stm, const int32_t priority, const uint32_t flags,
    DvppGrp *grp)
{
    NULL_PTR_RETURN_MSG_OUTER(stm, RT_ERROR_INVALID_VALUE);

    const rtError_t ret = CheckStreamFlags(flags);
    if (ret != RT_ERROR_NONE) {
        return ret;
    }

    int32_t validPriority = priority;

    if (priority < RT_STREAM_GREATEST_PRIORITY) {
        validPriority = RT_STREAM_GREATEST_PRIORITY;
    } else if (priority > RT_STREAM_LEAST_PRIORITY) {
        validPriority = RT_STREAM_LEAST_PRIORITY;
    } else {
        // no operation
    }

    if (priority != validPriority) {
       RT_LOG(RT_LOG_INFO, "Input priority=%d is out of range [%d, %d], adjusted to %d",
            priority, RT_STREAM_GREATEST_PRIORITY, RT_STREAM_LEAST_PRIORITY, validPriority);
    }

    return impl_->StreamCreate(stm, validPriority, flags, grp);
}

rtError_t ApiErrorDecorator::CheckStreamFlags(const uint32_t flags) const
{
    const Runtime * const rtInstance = Runtime::Instance();
    const rtChipType_t chipType = rtInstance->GetChipType();
    if (!IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_STREAM_HUGE_DEPTH)) {
        COND_RETURN_AND_MSG_OUTER((flags & RT_STREAM_HUGE) != 0U, RT_ERROR_FEATURE_NOT_SUPPORT, 
            ErrorCode::EE1006, __func__, "flags=" + std::to_string(flags));
    }

    constexpr uint32_t maxFlags = (RT_STREAM_DEFAULT | RT_STREAM_PERSISTENT | RT_STREAM_FORCE_COPY |
        RT_STREAM_HUGE | RT_STREAM_AICPU | RT_STREAM_FORBIDDEN_DEFAULT | RT_STREAM_HEAD | RT_STREAM_OVERFLOW |
        RT_STREAM_FAST_LAUNCH | RT_STREAM_FAST_SYNC | RT_STREAM_CP_PROCESS_USE | RT_STREAM_VECTOR_CORE_USE|
        RT_STREAM_ACSQ_LOCK | RT_STREAM_DQS_CTRL | RT_STREAM_DQS_INTER_CHIP);
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM(flags > maxFlags, RT_ERROR_INVALID_VALUE, 
        flags, "[0, " + std::to_string(maxFlags) + "]");

    COND_RETURN_OUT_ERROR_MSG_CALL(((flags & static_cast<uint32_t>(RT_STREAM_CP_PROCESS_USE)) != 0U) &&
        (((flags | static_cast<uint32_t>(RT_STREAM_ACSQ_LOCK)) != (RT_STREAM_ACSQ_LOCK | RT_STREAM_CP_PROCESS_USE))),
        RT_ERROR_INVALID_VALUE, "Invalid flags:%u does not support OR with other flags.", flags);

    return RT_ERROR_NONE;
}

rtError_t ApiErrorDecorator::StreamDestroy(Stream * const stm, bool flag)
{
    NULL_PTR_RETURN_MSG_OUTER(stm, RT_ERROR_INVALID_VALUE);

    COND_RETURN_ERROR_MSG_INNER(stm->IsCapturing(), RT_ERROR_STREAM_CAPTURED,
        "stream is in capture mode, stream_id=%d.", stm->Id_());

    return impl_->StreamDestroy(stm, flag);
}

rtError_t ApiErrorDecorator::StreamWaitEvent(Stream * const stm, Event * const evt, const uint32_t timeout)
{
    NULL_PTR_RETURN_MSG_OUTER(evt, RT_ERROR_INVALID_VALUE);
    COND_RETURN_AND_MSG_OUTER(
        ((evt->GetEventFlag() == static_cast<uint32_t>(RT_EVENT_MC2)) ||
        (((evt->GetEventFlag() & static_cast<uint32_t>(RT_EVENT_MC2)) != 0U) &&
        ((evt->GetEventFlag() & (~static_cast<uint32_t>(RT_EVENT_MC2))) != 0U))),
        RT_ERROR_INVALID_VALUE, ErrorCode::EE1006, __func__, "evt.eventFlag_=" + std::to_string(evt->GetEventFlag()));
    COND_RETURN_WARN(((evt->GetEventFlag() == static_cast<uint32_t>(RT_EVENT_IPC)) && (stm != nullptr) &&
        (stm->IsCapturing())), RT_ERROR_FEATURE_NOT_SUPPORT, "Not support ipc event in capture stream flag");
    COND_RETURN_WARN(evt->IsEventWithoutWaitTask(), RT_ERROR_FEATURE_NOT_SUPPORT,
        "flag=%" PRIu64 " does not support, not need wait for event.", evt->GetEventFlag());
    return impl_->StreamWaitEvent(stm, evt, timeout);
}

rtError_t ApiErrorDecorator::StreamSynchronize(Stream * const stm, const int32_t timeout)
{
    // timeout >=-1, -1:no limited
    COND_RETURN_AND_MSG_OUTER((timeout < -1) || (timeout == 0), RT_ERROR_INVALID_VALUE, 
        ErrorCode::EE1006, __func__, "timeout=" + std::to_string(timeout) + "ms");
    COND_RETURN_OUT_ERROR_MSG_CALL((stm !=nullptr) &&
        ((stm->Flags() & (RT_STREAM_AICPU | RT_STREAM_CP_PROCESS_USE)) != 0U),
        RT_ERROR_STREAM_INVALID,
        "StreamSynchronize failed. The stm parameter cannot be the stream whose flag is %u.",
        stm->Flags());

    COND_RETURN_ERROR_MSG_INNER(((stm != nullptr) && (stm->IsCapturing())),
        RT_ERROR_STREAM_CAPTURED, "Not allow to synchronize captured-stream, stream_id=%d.", stm->Id_());

    int32_t streamId = 0;
    if (stm != nullptr) {
        streamId = stm->Id_();
    }
    RT_LOG(RT_LOG_DEBUG, "stream synchronize entry, stream_id=%d, timeout=%dms.", streamId, timeout);

    const rtError_t error = impl_->StreamSynchronize(stm, timeout);
    if ((error != RT_ERROR_END_OF_SEQUENCE) && (error != RT_ERROR_MODEL_ABORT_NORMAL) &&
        (error != RT_ERROR_TSFW_AICORE_OVER_FLOW_FAIL) && (error != RT_ERROR_TSFW_AIVEC_OVER_FLOW_FAIL) &&
        (error != RT_ERROR_TSFW_AICPU_OVER_FLOW_FAIL) && (error != RT_ERROR_TSFW_SDMA_OVER_FLOW_FAIL)) {
#ifndef CFG_DEV_PLATFORM_PC
        ERROR_RETURN(error, "Stream synchronize failed, stream_id=%d, timeout=%dms.", streamId, timeout);
#else
        return error;
#endif
    }

    RT_LOG(RT_LOG_INFO, "stream synchronize exit, stream_id=%d, result=0x%x", streamId, error);
    return error;
}

rtError_t ApiErrorDecorator::StreamQuery(Stream * const stm)
{
    COND_RETURN_ERROR_MSG_INNER(((stm != nullptr) && (stm->IsCapturing())),
        RT_ERROR_STREAM_CAPTURED, "Not allow to query captured-stream.");
    return impl_->StreamQuery(stm);
}

rtError_t ApiErrorDecorator::GetStreamId(Stream * const stm, int32_t * const streamId)
{
    NULL_PTR_RETURN_MSG_OUTER(streamId, RT_ERROR_INVALID_VALUE);
    return impl_->GetStreamId(stm, streamId);
}

rtError_t ApiErrorDecorator::GetSqId(Stream * const stm, uint32_t * const sqId)
{
    Stream *curStm = Runtime::Instance()->GetCurStream(stm);
    NULL_PTR_RETURN_MSG_OUTER(sqId, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(curStm, RT_ERROR_INVALID_VALUE);
    return impl_->GetSqId(curStm, sqId);
}

rtError_t ApiErrorDecorator::GetCqId(Stream * const stm, uint32_t * const cqId, uint32_t * const logicCqId)
{
    Stream *curStm = Runtime::Instance()->GetCurStream(stm);
    NULL_PTR_RETURN_MSG_OUTER(curStm, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(cqId, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(logicCqId, RT_ERROR_INVALID_VALUE);
    return impl_->GetCqId(curStm, cqId, logicCqId);
}

rtError_t ApiErrorDecorator::StreamGetPriority(Stream * const stm,  uint32_t * const priority)
{
    NULL_PTR_RETURN_MSG_OUTER(priority, RT_ERROR_INVALID_VALUE);
    return impl_->StreamGetPriority(stm, priority);
}

rtError_t ApiErrorDecorator::StreamGetFlags(Stream * const stm,  uint32_t * const flags)
{
    NULL_PTR_RETURN_MSG_OUTER(flags, RT_ERROR_INVALID_VALUE);
    return impl_->StreamGetFlags(stm, flags);
}

rtError_t ApiErrorDecorator::GetMaxStreamAndTask(const uint32_t streamType, uint32_t * const maxStrCount,
    uint32_t * const maxTaskCount)
{
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM((streamType != RT_NORMAL_STREAM) && (streamType != RT_HUGE_STREAM), 
        RT_ERROR_INVALID_VALUE, streamType, "[" + std::to_string(RT_NORMAL_STREAM) + ", " 
        + std::to_string(RT_HUGE_STREAM) + "]");
    NULL_PTR_RETURN_MSG_OUTER(maxStrCount, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(maxTaskCount, RT_ERROR_INVALID_VALUE);

    RT_LOG(RT_LOG_DEBUG, "streamType=%u.", streamType);
    const rtError_t error = impl_->GetMaxStreamAndTask(streamType, maxStrCount, maxTaskCount);
    COND_RETURN_ERROR((error != RT_ERROR_NONE) && (error != RT_ERROR_FEATURE_NOT_SUPPORT), error,
        "Get max stream and task failed, streamType=%u.", streamType);
    return error;
}

rtError_t ApiErrorDecorator::GetAvailStreamNum(const uint32_t streamType, uint32_t * const streamCount)
{
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM((streamType != RT_NORMAL_STREAM) && (streamType != RT_HUGE_STREAM), 
        RT_ERROR_INVALID_VALUE, streamType, "[" + std::to_string(RT_NORMAL_STREAM) + ", " 
        + std::to_string(RT_HUGE_STREAM) + "]");
    NULL_PTR_RETURN_MSG_OUTER(streamCount, RT_ERROR_INVALID_VALUE);
    const rtError_t error = impl_->GetAvailStreamNum(streamType, streamCount);
    ERROR_RETURN(error, "Get available stream failed, streamType=%u.", streamType);
    return error;
}

rtError_t ApiErrorDecorator::GetFreeStreamNum(uint32_t * const streamCount)
{
    NULL_PTR_RETURN_MSG_OUTER(streamCount, RT_ERROR_INVALID_VALUE);
    const rtError_t error = impl_->GetFreeStreamNum(streamCount);
    ERROR_RETURN(error, "Get free stream failed.");
    return error;
}

rtError_t ApiErrorDecorator::GetAvailEventNum(uint32_t * const eventCount)
{
    NULL_PTR_RETURN_MSG_OUTER(eventCount, RT_ERROR_INVALID_VALUE);
    const rtError_t error = impl_->GetAvailEventNum(eventCount);
    ERROR_RETURN(error, "Query event num failed.");
    return error;
}

rtError_t ApiErrorDecorator::GetTaskIdAndStreamID(uint32_t * const taskId, uint32_t * const streamId)
{
    NULL_PTR_RETURN_MSG_OUTER(taskId, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(streamId, RT_ERROR_INVALID_VALUE);
    return impl_->GetTaskIdAndStreamID(taskId, streamId);
}

rtError_t ApiErrorDecorator::SetDeviceFailureMode(uint64_t failureMode)
{
    return impl_->SetDeviceFailureMode(failureMode);
}

rtError_t ApiErrorDecorator::StreamSetMode(Stream * const stm, const uint64_t stmMode)
{
    Stream *curStm = Runtime::Instance()->GetCurStream(stm);
    NULL_PTR_RETURN_MSG_OUTER(curStm, RT_ERROR_INVALID_VALUE);
    COND_RETURN_WARN((curStm->Flags() & RT_STREAM_CP_PROCESS_USE) != 0U, RT_ERROR_FEATURE_NOT_SUPPORT,
                     "Not support coprocessor stream flag=%u", curStm->Flags());
#ifndef CFG_DEV_PLATFORM_PC
    const rtError_t error = impl_->StreamSetMode(curStm, stmMode);
    ERROR_RETURN(error, "set stream mode failed.");
    return error;
#else
    RT_LOG(RT_LOG_DEBUG, "no need set stream mode.");
    return RT_ERROR_NONE;
#endif
}

rtError_t ApiErrorDecorator::StreamGetMode(const Stream * const stm, uint64_t * const stmMode)
{
    Stream *curStm = Runtime::Instance()->GetCurStream(const_cast<Stream* const>(stm));
    NULL_PTR_RETURN_MSG_OUTER(curStm, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(stmMode, RT_ERROR_INVALID_VALUE);
    return impl_->StreamGetMode(curStm, stmMode);
}

rtError_t ApiErrorDecorator::GetMaxModelNum(uint32_t * const maxModelCount)
{
    NULL_PTR_RETURN_MSG_OUTER(maxModelCount, RT_ERROR_INVALID_VALUE);
    return impl_->GetMaxModelNum(maxModelCount);
}

rtError_t ApiErrorDecorator::EventCreate(Event ** const evt, const uint64_t flag)
{
    NULL_PTR_RETURN_MSG_OUTER(evt, RT_ERROR_INVALID_VALUE);

    constexpr uint32_t maxFlag = RT_EVENT_FLAG_MAX;
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM(((flag & maxFlag) == 0U) || (flag > maxFlag), 
        RT_ERROR_INVALID_VALUE, flag, "(0, " + std::to_string(maxFlag) + "]");

    constexpr uint64_t solelyFlag[] = {RT_EVENT_MC2, RT_EVENT_EXTERNAL};
    for (const uint64_t itemFlag : solelyFlag) {
        COND_RETURN_OUT_ERROR_MSG_CALL(
            (((flag & (itemFlag)) != 0UL) &&
            ((flag & (~itemFlag)) != 0UL)),
            RT_ERROR_INVALID_VALUE,
            "Invalid flag, current flag = %" PRIu64 ", "
            "the flag[%" PRIu64 "] does not support OR operations with other flags.",
            flag, itemFlag);
    }

    const rtError_t error = impl_->EventCreate(evt, flag);
    ERROR_RETURN(error, "Create event failed.");
    RT_LOG(RT_LOG_DEBUG, "event create success, flag = %" PRIu64 "", flag);
    return error;
}

rtError_t ApiErrorDecorator::EventCreateEx(Event ** const evt, const uint64_t flag)
{
    NULL_PTR_RETURN_MSG_OUTER(evt, RT_ERROR_INVALID_VALUE);
    const rtChipType_t chipType = Runtime::Instance()->GetChipType();
    constexpr uint64_t solelyFlag[] = {RT_EVENT_MC2, RT_EVENT_EXTERNAL, RT_EVENT_IPC};
    for (const uint64_t itemFlag : solelyFlag) {
        COND_RETURN_OUT_ERROR_MSG_CALL(
            (((flag & (itemFlag)) != 0UL) &&
            ((flag & (~itemFlag)) != 0UL)),
            RT_ERROR_INVALID_VALUE,
            "Invalid flag, current flag = %" PRIu64 ", "
            "the flag[%" PRIu64 "] does not support OR operations with other flags.",
            flag, itemFlag);
    }
    if ((flag == RT_EVENT_IPC) && (!IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_IPC_EVENT))) {
        RT_LOG(RT_LOG_WARNING, "chip type(%d) does not support ipc event.", static_cast<int32_t>(chipType));
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }
    constexpr uint32_t maxFlag = (RT_EVENT_DDSYNC_NS | RT_EVENT_STREAM_MARK | RT_EVENT_DDSYNC |
                                  RT_EVENT_TIME_LINE | RT_EVENT_IPC);
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM(((flag & maxFlag) == 0U) || (flag > maxFlag), 
        RT_ERROR_INVALID_VALUE, flag, "(0, " + std::to_string(maxFlag) + "]");

    const rtError_t error = impl_->EventCreateEx(evt, flag);
    ERROR_RETURN(error, "Create event failed.");
    RT_LOG(RT_LOG_DEBUG, "event create success, flag = %" PRIu64 "", flag);
    return error;
}

rtError_t ApiErrorDecorator::EventCreateForNotify(Event ** const evt)
{
    NULL_PTR_RETURN_MSG_OUTER(evt, RT_ERROR_INVALID_VALUE);
    return impl_->EventCreateForNotify(evt);
}

rtError_t ApiErrorDecorator::EventDestroy(Event *evt)
{
    NULL_PTR_RETURN_MSG_OUTER(evt, RT_ERROR_INVALID_VALUE);
    return impl_->EventDestroy(evt);
}

rtError_t ApiErrorDecorator::EventDestroySync(Event *evt)
{
    NULL_PTR_RETURN_MSG_OUTER(evt, RT_ERROR_INVALID_VALUE);
    COND_RETURN_WARN(evt->GetEventFlag() == static_cast<uint32_t>(RT_EVENT_IPC),
        RT_ERROR_FEATURE_NOT_SUPPORT, "Not support ipc event in rtEventDestroySync api");
    return impl_->EventDestroySync(evt);
}

rtError_t ApiErrorDecorator::EventRecord(Event * const evt, Stream * const stm)
{
    NULL_PTR_RETURN_MSG_OUTER(evt, RT_ERROR_INVALID_VALUE);
    COND_RETURN_AND_MSG_OUTER(
        ((evt->GetEventFlag() == static_cast<uint32_t>(RT_EVENT_MC2)) ||
        (((evt->GetEventFlag() & static_cast<uint32_t>(RT_EVENT_MC2)) != 0U) &&
        ((evt->GetEventFlag() & (~static_cast<uint32_t>(RT_EVENT_MC2))) != 0U))),
        RT_ERROR_INVALID_VALUE, ErrorCode::EE1006, __func__, "evt.eventFlag_=" + std::to_string(evt->GetEventFlag()));
    COND_RETURN_WARN(((evt->GetEventFlag() == static_cast<uint32_t>(RT_EVENT_IPC)) && (stm != nullptr) &&
        (stm->IsCapturing())), RT_ERROR_FEATURE_NOT_SUPPORT, "Not support ipc event in capture stream flag");
    const rtError_t error = impl_->EventRecord(evt, stm);
    COND_RETURN_ERROR((error != RT_ERROR_NONE) && (error != RT_ERROR_FEATURE_NOT_SUPPORT),
        error, "Record event failed.");
    return error;
}

rtError_t ApiErrorDecorator::EventRecordForNotify(Event * const evt, Stream * const stm)
{
    NULL_PTR_RETURN_MSG_OUTER(evt, RT_ERROR_INVALID_VALUE);
    return impl_->EventRecordForNotify(evt, stm);
}

rtError_t ApiErrorDecorator::GetEventID(Event * const evt, uint32_t * const evtId)
{
    NULL_PTR_RETURN_MSG_OUTER(evt, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(evtId, RT_ERROR_INVALID_VALUE);
    COND_RETURN_WARN(evt->GetEventFlag() == static_cast<uint32_t>(RT_EVENT_IPC),
        RT_ERROR_FEATURE_NOT_SUPPORT, "Not support ipc event in rtGetEventID api");
    return impl_->GetEventID(evt, evtId);
}

rtError_t ApiErrorDecorator::EventReset(Event * const evt, Stream * const stm)
{
    NULL_PTR_RETURN_MSG_OUTER(evt, RT_ERROR_INVALID_VALUE);
    COND_RETURN_AND_MSG_OUTER(
        ((evt->GetEventFlag() == static_cast<uint32_t>(RT_EVENT_MC2)) ||
        (((evt->GetEventFlag() & static_cast<uint32_t>(RT_EVENT_MC2)) != 0U) &&
        ((evt->GetEventFlag() & (~static_cast<uint32_t>(RT_EVENT_MC2))) != 0U))),
        RT_ERROR_INVALID_VALUE, ErrorCode::EE1006, __func__, "evt.eventFlag_=" + std::to_string(evt->GetEventFlag()));
    COND_RETURN_WARN(evt->GetEventFlag() == static_cast<uint32_t>(RT_EVENT_IPC),
        RT_ERROR_FEATURE_NOT_SUPPORT, "Not support ipc event in rtEventReset api");
    COND_RETURN_WARN(evt->IsEventWithoutWaitTask(), RT_ERROR_FEATURE_NOT_SUPPORT,
        "flag=%" PRIu64 " does not support, not need reset for event.", evt->GetEventFlag());
    const rtError_t error = impl_->EventReset(evt, stm);
    COND_RETURN_ERROR((error != RT_ERROR_NONE) && (error != RT_ERROR_FEATURE_NOT_SUPPORT),
        error, "Reset event failed.");
    return error;
}

rtError_t ApiErrorDecorator::EventSynchronize(Event * const evt, const int32_t timeout)
{
    // timeout >=-1, -1:no limited
    COND_RETURN_AND_MSG_OUTER((timeout < -1) || (timeout == 0), RT_ERROR_INVALID_VALUE, 
        ErrorCode::EE1006, __func__, "timeout=" + std::to_string(timeout));
    NULL_PTR_RETURN_MSG_OUTER(evt, RT_ERROR_INVALID_VALUE);
    COND_RETURN_WARN(evt->GetEventFlag() == RT_EVENT_EXTERNAL, RT_ERROR_FEATURE_NOT_SUPPORT,
        "The external event does not support synchronization.");
    COND_RETURN_ERROR_MSG_INNER(evt->IsCapturing(), RT_ERROR_EVENT_CAPTURED, "Not allow to synchronize captured-event.");
    return impl_->EventSynchronize(evt, timeout);
}

rtError_t ApiErrorDecorator::EventQuery(Event * const evt)
{
    NULL_PTR_RETURN_MSG_OUTER(evt, RT_ERROR_INVALID_VALUE);
    COND_RETURN_WARN(evt->IsNewMode(), RT_ERROR_FEATURE_NOT_SUPPORT,
        "Not support current mode, mode=%d", static_cast<int32_t>(evt->IsNewMode()));
    COND_RETURN_WARN(evt->GetEventFlag() == RT_EVENT_EXTERNAL, RT_ERROR_FEATURE_NOT_SUPPORT,
        "The external event does not support to query status.");
    COND_RETURN_WARN(evt->GetEventFlag() == static_cast<uint32_t>(RT_EVENT_IPC),
        RT_ERROR_FEATURE_NOT_SUPPORT, "Not support ipc event in rtEventQuery api");
    COND_RETURN_ERROR_MSG_INNER(evt->IsCapturing(), RT_ERROR_EVENT_CAPTURED, "Not allow to query captured-event.");
    return impl_->EventQuery(evt);
}

rtError_t ApiErrorDecorator::EventQueryStatus(Event * const evt, rtEventStatus_t * const status)
{
    NULL_PTR_RETURN_MSG_OUTER(evt, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(status, RT_ERROR_INVALID_VALUE);
    COND_RETURN_WARN(evt->GetEventFlag() == RT_EVENT_EXTERNAL, RT_ERROR_FEATURE_NOT_SUPPORT,
        "The external event does not support to query status.");
    COND_RETURN_ERROR_MSG_INNER(evt->IsCapturing(), RT_ERROR_EVENT_CAPTURED, "Not allow to query captured-event.");
    return impl_->EventQueryStatus(evt, status);
}

rtError_t ApiErrorDecorator::EventQueryWaitStatus(Event * const evt, rtEventWaitStatus_t * const status)
{
    NULL_PTR_RETURN_MSG_OUTER(evt, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(status, RT_ERROR_INVALID_VALUE);
    COND_RETURN_WARN(evt->IsNewMode(), RT_ERROR_FEATURE_NOT_SUPPORT,
        "Not support current mode, mode=%d", static_cast<int32_t>(evt->IsNewMode()));
    COND_RETURN_WARN(evt->GetEventFlag() == RT_EVENT_EXTERNAL, RT_ERROR_FEATURE_NOT_SUPPORT,
        "The external event does not support to query status.");
    COND_RETURN_WARN(evt->GetEventFlag() == static_cast<uint32_t>(RT_EVENT_IPC),
        RT_ERROR_FEATURE_NOT_SUPPORT, "Not support ipc event in rtEventQueryWaitStatus api");
    COND_RETURN_ERROR_MSG_INNER(evt->IsCapturing(), RT_ERROR_EVENT_CAPTURED, "Not allow to query captured-event.");
    return impl_->EventQueryWaitStatus(evt, status);
}

rtError_t ApiErrorDecorator::EventElapsedTime(float32_t * const retTime, Event * const startEvt, Event * const endEvt)
{
    NULL_PTR_RETURN_MSG_OUTER(retTime, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(startEvt, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(endEvt, RT_ERROR_INVALID_VALUE);
    COND_RETURN_ERROR_MSG_INNER((startEvt->IsCapturing() || endEvt->IsCapturing()),
                                RT_ERROR_EVENT_CAPTURED, "Not allow to query captured-event.");
    COND_RETURN_WARN((startEvt->GetEventFlag() == RT_EVENT_EXTERNAL || endEvt->GetEventFlag() == RT_EVENT_EXTERNAL),
        RT_ERROR_FEATURE_NOT_SUPPORT, "The external event does not support to get elapsed time.");
    COND_RETURN_WARN((startEvt->GetEventFlag() == static_cast<uint32_t>(RT_EVENT_IPC) ||
        endEvt->GetEventFlag() == static_cast<uint32_t>(RT_EVENT_IPC)),
        RT_ERROR_FEATURE_NOT_SUPPORT, "Not support ipc event in rtEventElapsedTime api");
    return impl_->EventElapsedTime(retTime, startEvt, endEvt);
}

rtError_t ApiErrorDecorator::EventGetTimeStamp(uint64_t * const retTime, Event * const evt)
{
    NULL_PTR_RETURN_MSG_OUTER(retTime, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(evt, RT_ERROR_INVALID_VALUE);
    COND_RETURN_WARN(evt->GetEventFlag() == RT_EVENT_EXTERNAL, RT_ERROR_FEATURE_NOT_SUPPORT,
        "The external event does not support to get timestamp.");
    COND_RETURN_WARN(evt->GetEventFlag() == static_cast<uint32_t>(RT_EVENT_IPC),
        RT_ERROR_FEATURE_NOT_SUPPORT, "Not support ipc event in rtEventGetTimeStamp api");
    COND_RETURN_ERROR_MSG_INNER(evt->IsCapturing(), RT_ERROR_EVENT_CAPTURED, "Not allow to query captured-event.");
    return impl_->EventGetTimeStamp(retTime, evt);
}

rtError_t ApiErrorDecorator::DevMallocCached(void ** const devPtr, const uint64_t size, const rtMemType_t type,
    const uint16_t moduleId)
{
    NULL_PTR_RETURN_MSG_OUTER(devPtr, RT_ERROR_INVALID_VALUE);
    ZERO_RETURN_AND_MSG_OUTER(size);
    const uint16_t moduleIdCov = (moduleId > DEFAULT_MODULEID) ? static_cast<uint16_t>(APP): moduleId;
    const rtError_t error = impl_->DevMallocCached(devPtr, size, type, moduleIdCov);
    ERROR_RETURN(error, "Device malloc cached failed, size=%" PRIu64 "(bytes), type=%u.", size, type);
    RT_LOG(RT_LOG_INFO, "dev cached memory alloc success, size=%" PRIu64 ", type=%u.", size, type);
    return error;
}

rtError_t ApiErrorDecorator::DevMalloc(void ** const devPtr, const uint64_t size, const rtMemType_t type,
    const uint16_t moduleId)
{
    NULL_PTR_RETURN_MSG_OUTER(devPtr, RT_ERROR_INVALID_VALUE);

    const uint16_t moduleIdCov = (moduleId > DEFAULT_MODULEID) ? static_cast<uint16_t>(APP): moduleId;
    const rtError_t error = impl_->DevMalloc(devPtr, size, type, moduleIdCov);
    RT_LOG(RT_LOG_INFO, "device malloc, size=%" PRIu64 "(bytes), type=%d, moduleId=%hu, start ptr=0x%llx, "
        "end ptr=0x%llx", size, type, moduleId, RtPtrToValue(*devPtr), (RtPtrToValue(*devPtr) + size));
    return error;
}

rtError_t ApiErrorDecorator::DevFree(void * const devPtr)
{
    NULL_PTR_RETURN_MSG_OUTER(devPtr, RT_ERROR_INVALID_VALUE);

    const rtError_t error = impl_->DevFree(devPtr);
    ERROR_RETURN(error, "Free device failed, mem=0x%llx", RtPtrToValue(devPtr));
    return error;
}

rtError_t ApiErrorDecorator::DevDvppMalloc(void ** const devPtr, const uint64_t size, const uint32_t flag,
    const uint16_t moduleId)
{
    NULL_PTR_RETURN_MSG_OUTER(devPtr, RT_ERROR_INVALID_VALUE);

    const uint16_t moduleIdCov = (moduleId > DEFAULT_MODULEID) ? static_cast<uint16_t>(APP): moduleId;
    return impl_->DevDvppMalloc(devPtr, size, flag, moduleIdCov);
}

rtError_t ApiErrorDecorator::DevDvppFree(void * const devPtr)
{
    NULL_PTR_RETURN_MSG_OUTER(devPtr, RT_ERROR_INVALID_VALUE);
    return impl_->DevDvppFree(devPtr);
}

rtError_t ApiErrorDecorator::HostMalloc(void ** const hostPtr, const uint64_t size, const uint16_t moduleId)
{
    NULL_PTR_RETURN_MSG_OUTER(hostPtr, RT_ERROR_INVALID_VALUE);
    ZERO_RETURN_AND_MSG_OUTER(size);
    const uint16_t moduleIdCov = (moduleId > DEFAULT_MODULEID) ? static_cast<uint16_t>(APP): moduleId;
    const rtError_t error = impl_->HostMalloc(hostPtr, size, moduleIdCov);
    ERROR_RETURN(error, "Host memory malloc failed, size=%" PRIu64 "(bytes), moduleId=%hu.", size, moduleId);
    RT_LOG(RT_LOG_INFO, "Host memory malloc succeed, size=%" PRIu64 ", moduleId=%hu, host addr=%#" PRIx64 ".",
        size, moduleId, RtPtrToValue(*hostPtr));
    return error;
}

rtError_t ApiErrorDecorator::HostMallocWithCfg(void ** const hostPtr, const uint64_t size,
    const rtMallocConfig_t *cfg)
{
    return impl_->HostMallocWithCfg(hostPtr, size, cfg);
}

rtError_t ApiErrorDecorator::HostFree(void * const hostPtr)
{
    NULL_PTR_RETURN_MSG_OUTER(hostPtr, RT_ERROR_INVALID_VALUE);

    const rtError_t error = impl_->HostFree(hostPtr);
    ERROR_RETURN(error, "Free host memory failed, host addr=%#" PRIx64 ".",
        RtPtrToValue(hostPtr));
    RT_LOG(RT_LOG_INFO, "Free host memory succeed, host addr=%#" PRIx64 ".",
        RtPtrToValue(hostPtr));
    return error;
}

rtError_t ApiErrorDecorator::MallocHostSharedMemory(rtMallocHostSharedMemoryIn * const in,
    rtMallocHostSharedMemoryOut * const out)
{
    NULL_PTR_RETURN_MSG_OUTER(in, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(out, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(in->name, RT_ERROR_INVALID_VALUE);
    ZERO_RETURN_AND_MSG_OUTER(in->size);

    const rtError_t error = impl_->MallocHostSharedMemory(in, out);
    ERROR_RETURN(error, "Malloc host shared memory failed, hostPtr=%s, sharedMemSize=%" PRIu64 "(bytes), flag=%u,"
        "fd=%u.", in->name, in->size, in->flag, out->fd);
    return error;
}

rtError_t ApiErrorDecorator::FreeHostSharedMemory(rtFreeHostSharedMemoryIn * const in)
{
    NULL_PTR_RETURN_MSG_OUTER(in, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(in->name, RT_ERROR_INVALID_VALUE);
    ZERO_RETURN_AND_MSG_OUTER(in->size);
    NULL_PTR_RETURN_MSG_OUTER(in->ptr, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(in->devPtr, RT_ERROR_INVALID_VALUE);

    const rtError_t error = impl_->FreeHostSharedMemory(in);
    ERROR_RETURN(error, "Free host shared memory failed, sharedMemName=%s, sharedMemSize=%" PRIu64 "(bytes), fd=%u.",
        in->name, in->size, in->fd);
    return error;
}

rtError_t ApiErrorDecorator::HostRegister(void *ptr, uint64_t size, rtHostRegisterType type, void **devPtr)
{
    NULL_PTR_RETURN_MSG_OUTER(ptr, RT_ERROR_INVALID_VALUE);
    ZERO_RETURN_AND_MSG_OUTER(size);
    constexpr uint32_t validFlags = RT_HOST_REGISTER_IOMEMORY | RT_HOST_REGISTER_READONLY;
    if ((static_cast<uint32_t>(type) & (~validFlags)) != 0U) {
        RT_LOG(RT_LOG_WARNING, "not support this type, current type=%u, valid flags are combinations of [%u, %u] or 0",
            type, RT_HOST_REGISTER_IOMEMORY, RT_HOST_REGISTER_READONLY);
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }
    NULL_PTR_RETURN_MSG_OUTER(devPtr, RT_ERROR_INVALID_VALUE);

    const rtError_t error = impl_->HostRegister(ptr, size, type, devPtr);
    ERROR_RETURN(error, "Malloc host memory failed, MemSize=%" PRIu64 "(bytes)", size);
    return error;
}

rtError_t ApiErrorDecorator::HostRegisterV2(void *ptr, uint64_t size, uint32_t flag)
{
    NULL_PTR_RETURN_MSG_OUTER(ptr, RT_ERROR_INVALID_VALUE);
    ZERO_RETURN_MSG_OUTER(size);
    constexpr uint32_t validFlags = RT_MEM_HOST_REGISTER_MAPPED | RT_MEM_HOST_REGISTER_PINNED;
 	const bool isValidFlag = ((flag & validFlags) != 0U) && ((flag & (~validFlags)) == 0U);
 	COND_RETURN_OUT_ERROR_MSG_CALL(!isValidFlag,
 	    RT_ERROR_INVALID_VALUE,
 	    "Invalid flag:%#x, valid flag range is %#x, %#x or %#x.", flag,
 	    RT_MEM_HOST_REGISTER_MAPPED,
        RT_MEM_HOST_REGISTER_PINNED,
 	    (RT_MEM_HOST_REGISTER_MAPPED | RT_MEM_HOST_REGISTER_PINNED));
    
    rtError_t error = CheckMemoryRangeRegistered(ptr, size);
 	COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);

    error = impl_->HostRegisterV2(ptr, size, flag);
    ERROR_RETURN(error, "Register host memory failed, MemSize=%" PRIu64 "(bytes), flag=%#x.", size, flag);
    return error;
}

rtError_t ApiErrorDecorator::HostUnregister(void *ptr)
{
    NULL_PTR_RETURN_MSG_OUTER(ptr, RT_ERROR_INVALID_VALUE);

    const rtError_t error = impl_->HostUnregister(ptr);
    ERROR_RETURN(error, "Malloc host memory failed.");
    return error;
}

rtError_t ApiErrorDecorator::HostGetDevicePointer(void *pHost, void **pDevice, uint32_t flag)
{
    NULL_PTR_RETURN_MSG_OUTER(pHost, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(pDevice, RT_ERROR_INVALID_VALUE);
    COND_RETURN_OUT_ERROR_MSG_CALL((flag != 0U), RT_ERROR_INVALID_VALUE, "flag must be 0.");

    const rtError_t error = impl_->HostGetDevicePointer(pHost, pDevice, flag);
    ERROR_RETURN(error, "Host get device memory failed.");
    return error;
}

rtError_t ApiErrorDecorator::HostMemMapCapabilities(uint32_t deviceId, rtHacType hacType, rtHostMemMapCapability *capabilities)
{
    NULL_PTR_RETURN_MSG_OUTER(capabilities, RT_ERROR_INVALID_VALUE);
    uint32_t realDeviceId;
    rtError_t error = Runtime::Instance()->ChgUserDevIdToDeviceId(deviceId, &realDeviceId);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "input error:drv devId %u is err:%#x", deviceId, static_cast<uint32_t>(error));

    error = CheckDeviceIdIsValid(static_cast<int32_t>(realDeviceId));
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, "Device ID is invalid, drv devId=%u, retCode=%#x",
        realDeviceId, static_cast<uint32_t>(error));

    COND_RETURN_OUT_ERROR_MSG_CALL(hacType >= RT_HAC_TYPE_MAX, RT_ERROR_INVALID_VALUE,
        "Invalid hacType, current hacType=%u, valid hacType range is [0, %u).",
        hacType, RT_HAC_TYPE_MAX);
    error = impl_->HostMemMapCapabilities(realDeviceId, hacType, capabilities);
    if (error == RT_ERROR_FEATURE_NOT_SUPPORT) {
        RT_LOG(RT_LOG_WARNING, "HostMemMapCapabilities not support on drv deviceId %u", realDeviceId);
    } else {
        ERROR_RETURN(error, "query host memory capabilities failed.");
    }   
    return error;
}

rtError_t ApiErrorDecorator::ManagedMemAlloc(void ** const ptr, const uint64_t size, const uint32_t flag,
    const uint16_t moduleId)
{
    NULL_PTR_RETURN_MSG_OUTER(ptr, RT_ERROR_INVALID_VALUE);
    ZERO_RETURN_AND_MSG_OUTER(size);
    const uint16_t moduleIdCov = (moduleId > DEFAULT_MODULEID) ? static_cast<uint16_t>(APP): moduleId;
    const rtError_t error = impl_->ManagedMemAlloc(ptr, size, flag, moduleIdCov);
    RT_LOG(RT_LOG_INFO, "managed memory alloc, size=%" PRIu64 "(bytes), flag=%u", size, flag);
    return error;
}

rtError_t ApiErrorDecorator::ManagedMemFree(const void * const ptr)
{
    NULL_PTR_RETURN_MSG_OUTER(ptr, RT_ERROR_INVALID_VALUE);
    const rtError_t error = impl_->ManagedMemFree(ptr);
    ERROR_RETURN(error, "Free managed memory failed");
    return error;
}

rtError_t ApiErrorDecorator::MemAdvise(void *devPtr, uint64_t count, uint32_t advise)
{
    NULL_PTR_RETURN_MSG_OUTER(devPtr, RT_ERROR_INVALID_VALUE);
    ZERO_RETURN_AND_MSG_OUTER(count);
    const rtError_t error = impl_->MemAdvise(devPtr, count, advise);
    ERROR_RETURN(error, "memory advise failed, count=%" PRIu64 ", advise=%u", count, advise);
    return error;
}

rtError_t ApiErrorDecorator::FlushCache(const uint64_t base, const size_t len)
{
    const rtError_t error =  impl_->FlushCache(base, len);
    ERROR_RETURN(error, "Flush cache failed, base=%" PRIu64 "(bytes), len=%zu(bytes)", base, len);
    return error;
}

rtError_t ApiErrorDecorator::InvalidCache(const uint64_t base, const size_t len)
{
    const rtError_t error =  impl_->InvalidCache(base, len);
    ERROR_RETURN(error, "Invalid cache failed, base=%" PRIu64 "(bytes), len=%zu(bytes).", base, len);
    return error;
}

rtError_t ApiErrorDecorator::MemCopySync(void * const dst, const uint64_t destMax, const void * const src,
    const uint64_t cnt, const rtMemcpyKind_t kind, const uint32_t checkKind)
{
    NULL_PTR_RETURN_MSG_OUTER(dst, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(src, RT_ERROR_INVALID_VALUE);
    ZERO_RETURN_AND_MSG_OUTER(destMax);
    ZERO_RETURN_AND_MSG_OUTER(cnt);

    COND_RETURN_AND_MSG_OUTER_WITH_PARAM(cnt > destMax, RT_ERROR_INVALID_VALUE, 
        cnt, "(0, " + std::to_string(destMax) + "]");
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM((kind >= RT_MEMCPY_RESERVED) ||
        (kind < RT_MEMCPY_HOST_TO_HOST), RT_ERROR_INVALID_VALUE,
        kind, "[" + std::to_string(RT_MEMCPY_HOST_TO_HOST) + ", " + std::to_string(RT_MEMCPY_RESERVED) + ")");
    COND_RETURN_WARN((dst == src), RT_ERROR_NONE, "The src and dst are the same, no need to copy, return.");

    const rtError_t error = impl_->MemCopySync(dst, destMax, src, cnt, kind, checkKind);
    COND_RETURN_ERROR((error != RT_ERROR_NONE) && (error != RT_ERROR_DRV_NOT_SUPPORT),
        error, "Memory copy sync failed, cnt=%" PRIu64 ", kind=%d.", cnt, static_cast<int32_t>(kind));
    return error;
}

rtError_t ApiErrorDecorator::MemCopySyncEx(void * const dst, const uint64_t destMax, const void * const src,
    const uint64_t cnt, const rtMemcpyKind_t kind)
{
    NULL_PTR_RETURN_MSG_OUTER(dst, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(src, RT_ERROR_INVALID_VALUE);
    ZERO_RETURN_AND_MSG_OUTER(destMax);
    ZERO_RETURN_AND_MSG_OUTER(cnt);

    COND_RETURN_AND_MSG_OUTER_WITH_PARAM(cnt > destMax, RT_ERROR_INVALID_VALUE, 
        cnt, "(0, " + std::to_string(destMax) + "]");
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM((kind >= RT_MEMCPY_RESERVED) ||
        (kind < RT_MEMCPY_HOST_TO_HOST), RT_ERROR_INVALID_VALUE,
        kind, "[" + std::to_string(RT_MEMCPY_HOST_TO_HOST) + ", " + std::to_string(RT_MEMCPY_RESERVED) + ")");
    COND_RETURN_WARN((dst == src), RT_ERROR_NONE, "The src and dst are the same, no need to copy, return.");

    const rtError_t error = impl_->MemCopySyncEx(dst, destMax, src, cnt, kind);
    COND_RETURN_ERROR((error != RT_ERROR_NONE) && (error != RT_ERROR_DRV_NOT_SUPPORT),
        error, "Memory copy sync failed, cnt=%" PRIu64 ", kind=%d.", cnt, static_cast<int32_t>(kind));
    return error;
}

rtError_t ApiErrorDecorator::MemcpyAsync(void *const dst, const uint64_t destMax, const void *const src,
    const uint64_t cnt, const rtMemcpyKind_t kind, Stream *const stm, const rtTaskCfgInfo_t * const cfgInfo,
    const rtD2DAddrCfgInfo_t * const addrCfg, bool checkKind, const rtMemcpyConfig_t * const memcpyConfig)
{
    NULL_PTR_RETURN_MSG_OUTER(dst, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(src, RT_ERROR_INVALID_VALUE);
    ZERO_RETURN_AND_MSG_OUTER(cnt);
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM(cnt > destMax, RT_ERROR_INVALID_VALUE, 
        cnt, "(0, " + std::to_string(destMax) + "]");    
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM((kind >= RT_MEMCPY_RESERVED) ||
        (kind < RT_MEMCPY_HOST_TO_HOST), RT_ERROR_INVALID_VALUE, 
        kind, "[" + std::to_string(RT_MEMCPY_HOST_TO_HOST) + ", " + std::to_string(RT_MEMCPY_RESERVED) + ")");
    COND_RETURN_OUT_ERROR_MSG_CALL(((kind == RT_MEMCPY_ADDR_DEVICE_TO_DEVICE) && (cnt > MAX_MEMCPY_SIZE_OF_D2D)),
        RT_ERROR_INVALID_VALUE, 
        "If parameter kind equals %d, the range of parameter cnt should be (0, %" PRIu64 "]. "
        "Parameter cnt = %" PRIu64 "(bytes)", kind, MAX_MEMCPY_SIZE_OF_D2D, cnt);
    rtError_t error = MemcpyAsyncCheckParam(kind, stm);
    ERROR_RETURN_MSG_CALL(ERR_MODULE_GE, error, "check memcpy async param failure, retCode=%#x.", static_cast<uint32_t>(error));
    if (addrCfg != nullptr) {
        error = MemcpyAsyncCheckAddrCfg(destMax, cnt, addrCfg);
        COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
    }
    
    const int32_t streamId = (stm != nullptr) ? stm->Id_() : -1;
    RtMemcpyCfgInfo configInfo;
    (void)memset_s(&configInfo, sizeof(RtMemcpyCfgInfo), 0, sizeof(RtMemcpyCfgInfo));
    if (memcpyConfig != nullptr) {
        error = GetMemcpyConfigInfo(&configInfo, memcpyConfig, true);
        COND_RETURN_OUT_ERROR_MSG_CALL(error != RT_ERROR_NONE, RT_ERROR_INVALID_VALUE,
            "MemcpyAsync get memcpyConfig failed, stream_id=%d.", streamId);
    }

    rtMemcpyKind_t copyKind = kind;
    checkKind = (configInfo.checkBitmap == WITHOUT_CHECK_KIND) ? false : checkKind;
    COND_RETURN_OUT_ERROR_MSG_CALL(!checkKind && (kind == RT_MEMCPY_DEFAULT),
        RT_ERROR_INVALID_VALUE, "If parameter checkKind is false, parameter kind cannot be %d.", RT_MEMCPY_DEFAULT);
    bool isD2HorH2DInvolvePageableMemory = false;
    if ((kind != RT_MEMCPY_HOST_TO_DEVICE_EX) && (kind != RT_MEMCPY_DEVICE_TO_HOST_EX)) { 
        const bool isUserRequireToCheckPinnedMem = (configInfo.checkBitmap == CHECK_MEMORY_PINNED);
        error = MemcpyAsyncCheckLocation(
            checkKind, copyKind, src, dst, isUserRequireToCheckPinnedMem, isD2HorH2DInvolvePageableMemory); /* 会更新copykind */
        COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
            "MemcpyAsync check src or dst location failed, stream_id=%d, checkKind=%d, copyKind=%d",
            streamId, checkKind, copyKind);
    }

    Context *curCtx = Runtime::Instance()->CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    NULL_PTR_RETURN_MSG(curCtx->Device_(), RT_ERROR_DEVICE_NULL);
    const uint32_t runMode = curCtx->Device_()->Driver_()->GetRunMode();
    COND_RETURN_WARN(((copyKind == RT_MEMCPY_HOST_TO_HOST) && (runMode == RT_RUN_MODE_ONLINE)),
        RT_ERROR_FEATURE_NOT_SUPPORT, "Not support h2h");
    COND_RETURN_WARN(((addrCfg == nullptr) && (dst == src)),    /* 在check kind/loc之后校验（校验顺序会影响return值） */
        RT_ERROR_NONE, "The src and dst are the same, no need to copy, return.");

    if (isD2HorH2DInvolvePageableMemory) {
        /* 把异步拷贝转化为隐式流同步 + 同步拷贝，以避免异步访问pageable内存引起的PA异常 */
        error = StreamSynchronize(stm, -1);
        COND_RETURN_ERROR(error != RT_ERROR_NONE, error, "StreamSynchronize failed, stream_id=%d.", streamId);

        error = impl_->MemCopySync(dst, destMax, src, cnt, copyKind);
    } else {
        error = impl_->MemcpyAsync(dst, destMax, src, cnt, copyKind, stm, cfgInfo, addrCfg, checkKind);
    }

    COND_RETURN_ERROR((error != RT_ERROR_NONE) && (error != RT_ERROR_FEATURE_NOT_SUPPORT),
        error, "Memcpy async failed, count=%" PRIu64 ", kind=%d, isInvolvePageableMemory=%d",
        cnt, static_cast<int32_t>(copyKind), isD2HorH2DInvolvePageableMemory);
    return error;
}

rtError_t ApiErrorDecorator::LaunchSqeUpdateTask(uint32_t streamId, uint32_t taskId, void *src, uint64_t cnt,
    Stream * const stm, bool needCpuTask)
{
    NULL_PTR_RETURN_MSG_OUTER(src, RT_ERROR_INVALID_VALUE);
    if (needCpuTask){
        COND_RETURN_OUT_ERROR_MSG_CALL(cnt != sizeof(rtRandomNumTaskInfo_t), RT_ERROR_INVALID_VALUE,
            "If parameter needCpuTask is equal to %u, the value of parameter cnt should be %" PRIu64 "(bytes). "
            "Parameter cnt = %" PRIu64 "(bytes)", needCpuTask, sizeof(rtRandomNumTaskInfo_t), cnt);
    } else{
        constexpr uint32_t dsaCopySize = 40U;
        COND_RETURN_OUT_ERROR_MSG_CALL(cnt != static_cast<uint64_t>(dsaCopySize), RT_ERROR_INVALID_VALUE,
            "If parameter needCpuTask is not equal to %u, the value of parameter cnt should be %u (bytes). "
            "Parameter cnt = %" PRIu64 "(bytes)", needCpuTask, dsaCopySize, cnt);
    }
    RT_LOG(RT_LOG_DEBUG, "update dsa sqe, cnt=%" PRIu64 "Byte, streamId=%u, taskId=%u", cnt, streamId, taskId);
    const rtError_t error = impl_->LaunchSqeUpdateTask(streamId, taskId, src, cnt, stm, needCpuTask);
    ERROR_RETURN(error, "update dsa failed, cnt=%" PRIu64 "Byte, streamId=%u, taskId=%u", cnt, streamId, taskId);
    return error;
}

rtError_t ApiErrorDecorator::MemcpyAsyncPtr(void * const memcpyAddrInfo, const uint64_t destMax,
    const uint64_t count, Stream *stm, const rtTaskCfgInfo_t * const cfgInfo, const bool isMemcpyDesc)
{
    NULL_PTR_RETURN_MSG(memcpyAddrInfo, RT_ERROR_INVALID_VALUE);
    ZERO_RETURN_MSG(count);
    COND_RETURN_ERROR_MSG_INNER(count > destMax, RT_ERROR_INVALID_VALUE,
        "Invalid count, current count=%" PRIu64 ", valid count range is (0, %" PRIu64 "]!", count, destMax);
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM((count > MAX_MEMCPY_SIZE_OF_D2D), RT_ERROR_INVALID_VALUE, 
        count, "(0, " + std::to_string(MAX_MEMCPY_SIZE_OF_D2D) + "]");
    COND_RETURN_ERROR_MSG_INNER((RtPtrToValue(memcpyAddrInfo) % 64ULL) != 0ULL,
        RT_ERROR_INVALID_VALUE, "Invalid address!");                // 64U for addr align

    if (isMemcpyDesc == false) {
        Context *curCtx = nullptr;

        rtError_t error = impl_->ContextGetCurrent(&curCtx);
        COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_GE, error != RT_ERROR_NONE, error,
            "Get current context failed, retCode=%#x", static_cast<uint32_t>(error));
        CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
        NULL_PTR_RETURN_MSG(curCtx, RT_ERROR_CONTEXT_NULL);
        if ((curCtx->Device_()->Driver_()->GetRunMode() == RT_RUN_MODE_ONLINE)) {
            rtPtrAttributes_t attributes;
            error = impl_->PtrGetAttributes(memcpyAddrInfo, &attributes);
            COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_GE, error != RT_ERROR_NONE, error,
                "Memory async ptr failed, get pointer attributes failed, retCode=%#x", static_cast<uint32_t>(error));
            const rtMemLocationType srcLocationType = attributes.location.type;
            COND_RETURN_AND_MSG_OUTER_WITH_PARAM(srcLocationType != RT_MEMORY_LOC_DEVICE, RT_ERROR_INVALID_VALUE, 
                srcLocationType, std::to_string(RT_MEMORY_LOC_DEVICE));
        }
    }
    const rtError_t error = impl_->MemcpyAsyncPtr(memcpyAddrInfo, destMax, count, stm, cfgInfo, isMemcpyDesc);
    ERROR_RETURN_MSG_INNER(error, "Memcpy async ptr failed, stream=%p, count=%" PRIu64 ".", stm, count);
    return error;
}

rtError_t ApiErrorDecorator::CheckMemcpyAttribute(const rtMemcpyKind kind, const void * const dst,
    const void * const src) const
{
    rtPtrAttributes_t srcAttributes = {};
    rtPtrAttributes_t destAttributes = {};
    rtError_t error = impl_->PtrGetAttributes(dst, &destAttributes);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "Get dst pointer attributes failed, retCode=%#x.", static_cast<uint32_t>(error));

    error = impl_->PtrGetAttributes(src, &srcAttributes);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "Get src pointer attributes failed, retCode=%#x.", static_cast<uint32_t>(error));

    COND_RETURN_ERROR_MSG_INNER((((kind == RT_MEMCPY_KIND_INNER_DEVICE_TO_DEVICE) &&
        (destAttributes.location.id != srcAttributes.location.id)) || 
        ((kind == RT_MEMCPY_KIND_INTER_DEVICE_TO_DEVICE) && (destAttributes.location.id == srcAttributes.location.id))),
        RT_ERROR_INVALID_VALUE, "DstAddr and srcAddr do not matched with the kind, kind=%u, dstAddr=%p, srcAddr=%p, "
        "dstAddr DeviceId=%u, srcAddr DeviceId=%u.", kind, dst, src, destAttributes.location.id, srcAttributes.location.id);

    return RT_ERROR_NONE;
}

rtError_t ApiErrorDecorator::RtsMemcpyAsync(void * const dst, const uint64_t destMax, const void * const src,
    const uint64_t cnt, const rtMemcpyKind kind, rtMemcpyConfig_t * const config, Stream * const stm)
{
    NULL_PTR_RETURN_MSG_OUTER(dst, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(src, RT_ERROR_INVALID_VALUE);

    rtError_t error = CheckMemcpyAttribute(kind, dst, src);
    ERROR_RETURN(error, "Check attributes failed.");

    RtMemcpyCfgInfo cfgInfo;
    (void)memset_s(&cfgInfo, sizeof(RtMemcpyCfgInfo), 0, sizeof(RtMemcpyCfgInfo));
    if (config != nullptr) {
        error = GetMemcpyConfigInfo(&cfgInfo, config, true);
        COND_RETURN_OUT_ERROR_MSG_CALL(error != RT_ERROR_NONE, RT_ERROR_INVALID_VALUE, "Get memcpyConfig failed.");
    }

    COND_RETURN_OUT_ERROR_MSG_CALL(((cfgInfo.checkBitmap == WITHOUT_CHECK_KIND) && (kind == RT_MEMCPY_KIND_DEFAULT)),
        RT_ERROR_INVALID_VALUE, "Kind is not checked, but kind cannot be default.");

    const rtMemcpyKind_t curKind = GetMemCpyKind(RT_MEMCPY_RESERVED, kind);
    if (cfgInfo.checkBitmap == INVALID_CHECK_KIND) {
        return MemcpyAsync(dst, destMax, src, cnt, curKind, stm, nullptr, nullptr, true);
    } else {
        return MemcpyAsync(dst, destMax, src, cnt, curKind, stm, nullptr, nullptr, true, config);
    }
}

rtError_t ApiErrorDecorator::RtsMemcpy(void * const dst, const uint64_t destMax, const void * const src,
    const uint64_t cnt, const rtMemcpyKind kind, rtMemcpyConfig_t * const config)
{
    NULL_PTR_RETURN_MSG_OUTER(dst, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(src, RT_ERROR_INVALID_VALUE);

    rtError_t error = CheckMemcpyAttribute(kind, dst, src);
    ERROR_RETURN(error, "Check memcpy attribute failed.");

    RtMemcpyCfgInfo cfgInfo;
    (void)memset_s(&cfgInfo, sizeof(RtMemcpyCfgInfo), 0, sizeof(RtMemcpyCfgInfo));
    if (config != nullptr) {
        error = GetMemcpyConfigInfo(&cfgInfo, config, false);
        COND_RETURN_OUT_ERROR_MSG_CALL(error != RT_ERROR_NONE, RT_ERROR_INVALID_VALUE, "Get memcpyConfig failed.");
    }

    const Runtime * const rtInstance = Runtime::Instance();
    const rtChipType_t chipType = rtInstance->GetChipType();
    COND_RETURN_WARN(((!IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_MEM_MBUF_COPY)) &&
        ((cfgInfo.checkBitmap == WITHOUT_CHECK_KIND) || (cfgInfo.checkBitmap == NOT_CHECK_KIND_BUT_CHECK_PINNED))),
        ACL_ERROR_RT_FEATURE_NOT_SUPPORT, "chip type(%d) not support mbuf copy, return.", static_cast<int32_t>(chipType));

    COND_RETURN_OUT_ERROR_MSG_CALL(((kind == RT_MEMCPY_KIND_DEFAULT) && 
        ((cfgInfo.checkBitmap == WITHOUT_CHECK_KIND) || (cfgInfo.checkBitmap == NOT_CHECK_KIND_BUT_CHECK_PINNED))),
        RT_ERROR_INVALID_VALUE, "Kind is not checked, but kind cannot be default.");

    const rtMemcpyKind_t curKind = GetMemCpyKind(RT_MEMCPY_RESERVED, kind);
    return MemCopySync(dst, destMax, src, cnt, curKind, cfgInfo.checkBitmap);
}

rtError_t ApiErrorDecorator::SetMemcpyDesc(rtMemcpyDesc_t desc, const void * const srcAddr, const void * const dstAddr,
    const size_t count, const rtMemcpyKind kind, rtMemcpyConfig_t * const config)
{
    COND_RETURN_WARN((kind != RT_MEMCPY_KIND_INNER_DEVICE_TO_DEVICE), RT_ERROR_FEATURE_NOT_SUPPORT,
        "Kind should be %u, but now is %u.", RT_MEMCPY_KIND_INNER_DEVICE_TO_DEVICE, kind);
    NULL_PTR_RETURN_MSG(srcAddr, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG(dstAddr, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG(desc, RT_ERROR_INVALID_VALUE);
    COND_RETURN_ERROR_MSG_INNER((config != nullptr), RT_ERROR_INVALID_VALUE,
        "Invalid config address, currently only null is supported.");
    ZERO_RETURN_MSG(count);
	COND_RETURN_AND_MSG_OUTER_WITH_PARAM((count > MAX_MEMCPY_SIZE_OF_D2D), RT_ERROR_INVALID_VALUE, 
        count, "(0, " + std::to_string(MAX_MEMCPY_SIZE_OF_D2D) + "]");
    COND_RETURN_ERROR_MSG_INNER((RtPtrToValue(desc) % 64ULL) != 0ULL,
        RT_ERROR_INVALID_VALUE, "Invalid address, desc should be a 64-byte aligned address"); // 64U for addr align
    rtPtrAttributes_t srcAttributes;
    rtPtrAttributes_t destAttributes;
    rtPtrAttributes_t descAttributes;
    rtError_t error = impl_->PtrGetAttributes(desc, &descAttributes);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "Get desc pointer attributes failed, retCode=%#x.", static_cast<uint32_t>(error));

    error = impl_->PtrGetAttributes(dstAddr, &destAttributes);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "Get dstAddr pointer attributes failed, retCode=%#x.", static_cast<uint32_t>(error));

    error = impl_->PtrGetAttributes(srcAddr, &srcAttributes);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "Get srcAddr pointer attributes failed, retCode=%#x.", static_cast<uint32_t>(error));

    COND_RETURN_ERROR_MSG_INNER(descAttributes.location.type != RT_MEMORY_LOC_DEVICE,
        RT_ERROR_INVALID_VALUE, "rtsSetMemcpyDesc failed, desc addr type=%d is invalid!", descAttributes.location.type);

    COND_RETURN_ERROR_MSG_INNER(((destAttributes.location.id != srcAttributes.location.id) ||
        (destAttributes.location.type != RT_MEMORY_LOC_DEVICE) ||
        (srcAttributes.location.type != RT_MEMORY_LOC_DEVICE)), RT_ERROR_INVALID_VALUE,
        "DstAddr and srcAddr do not matched with the kind, kind=%u, dstAddr=%p, srcAddr=%p, "
        "dstAddr DeviceId=%u, srcAddr DeviceId=%u, dstAddr type=%d, srcAddr type=%d.", kind, dstAddr, srcAddr,
        destAttributes.location.id, srcAttributes.location.id, destAttributes.location.type, srcAttributes.location.type);

    error = impl_->SetMemcpyDesc(desc, srcAddr, dstAddr, count, kind, config);
    ERROR_RETURN_MSG_INNER(error, "SetMemcpyDesc failed");
    return error;
}

rtError_t ApiErrorDecorator::MemcpyAsyncWithDesc(rtMemcpyDesc_t desc, Stream *stm, const rtMemcpyKind kind,
    rtMemcpyConfig_t * const config)
{
    COND_RETURN_WARN((kind != RT_MEMCPY_KIND_INNER_DEVICE_TO_DEVICE), RT_ERROR_FEATURE_NOT_SUPPORT,
        "Kind should be %u, but now is %u.", RT_MEMCPY_KIND_INNER_DEVICE_TO_DEVICE, kind);
    NULL_PTR_RETURN_MSG(desc, RT_ERROR_INVALID_VALUE);
    COND_RETURN_ERROR_MSG_INNER((config != nullptr), RT_ERROR_INVALID_VALUE,
        "Invalid config address, currently only null is supported.");

    rtPtrAttributes_t descAttributes;
    const rtError_t error = impl_->PtrGetAttributes(desc, &descAttributes);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "Get desc pointer attributes failed, retCode=%#x.", static_cast<uint32_t>(error));
    COND_RETURN_ERROR_MSG_INNER(descAttributes.location.type != RT_MEMORY_LOC_DEVICE, RT_ERROR_INVALID_VALUE,
        "rtsMemcpyAsyncWithDesc failed, desc addr type=%d is invalid!", descAttributes.location.type);

    rtTaskCfgInfo_t cfgInfo = {};
    (void)memset_s(&cfgInfo, sizeof(rtTaskCfgInfo_t), 0, sizeof(rtTaskCfgInfo_t));

     return MemcpyAsyncPtr(reinterpret_cast<rtMemcpyAddrInfo *>(desc), UINT32_MAX, UINT32_MAX, stm, &cfgInfo, true);
}

rtError_t ApiErrorDecorator::GetDevArgsAddr(Stream *stm, rtArgsEx_t *argsInfo, void **devArgsAddr, void **argsHandle)
{
    Stream *curStm = Runtime::Instance()->GetCurStream(stm);
    NULL_PTR_RETURN_MSG(curStm, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG(argsInfo, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG(devArgsAddr, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG(argsHandle, RT_ERROR_INVALID_VALUE);
    const rtError_t error = impl_->GetDevArgsAddr(curStm, argsInfo, devArgsAddr, argsHandle);
    ERROR_RETURN_MSG_INNER(error, "GetDevArgsAddr failed, stream_id=%d.", curStm->Id_());
    return error;
}

rtError_t ApiErrorDecorator::MemcpyAsyncCheckParam(const rtMemcpyKind_t kind, const Stream * const stm) const
{
    if ((kind == RT_MEMCPY_HOST_TO_DEVICE_EX) || (kind == RT_MEMCPY_DEVICE_TO_HOST_EX)) {
        if (stm != nullptr) {
            COND_RETURN_OUT_ERROR_MSG_CALL(stm->GetModelNum() != 0, RT_ERROR_INVALID_VALUE,
                "If stm is a model stream, parameter kind cannot be equal to %d for function MemcpyAsyncCheckParam.", kind);
        }
    }
    return RT_ERROR_NONE;
}

rtError_t ApiErrorDecorator::MemcpyAsyncCheckAddrCfg(const uint64_t destMax, const uint64_t cnt,
    const rtD2DAddrCfgInfo_t * const addrCfg) const
{
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM(addrCfg->srcOffset > 0xFFFFFFFFFFFFUL, RT_ERROR_INVALID_VALUE, 
        addrCfg->srcOffset, "less than or equal to 0xFFFFFFFFFFFFUL");

    COND_RETURN_AND_MSG_OUTER_WITH_PARAM(addrCfg->dstOffset > 0xFFFFFFFFFFFFUL, RT_ERROR_INVALID_VALUE, 
        addrCfg->dstOffset, "less than or equal to 0xFFFFFFFFFFFFUL");

	COND_RETURN_AND_MSG_OUTER_WITH_PARAM(addrCfg->dstOffset >= destMax, RT_ERROR_INVALID_VALUE, 
        addrCfg->dstOffset, "[0, " + std::to_string(destMax) + ")");

	COND_RETURN_AND_MSG_OUTER_WITH_PARAM(cnt > (destMax - addrCfg->dstOffset), RT_ERROR_INVALID_VALUE, 
        cnt, "(0, " + std::to_string(destMax - addrCfg->dstOffset) + "]");
    return RT_ERROR_NONE;
}

rtError_t ApiErrorDecorator::GetLocationType(const void *const src, const void *const dst,
    rtMemLocationType &srcLocationType, rtMemLocationType &srcRealLocation,
    rtMemLocationType &dstLocationType, rtMemLocationType &dstRealLocation) const
{
    rtError_t error = RT_ERROR_NONE;
    Context *curCtx = Runtime::Instance()->CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    NULL_PTR_RETURN_MSG(curCtx->Device_(), RT_ERROR_DEVICE_NULL);

    error = curCtx->Device_()->Driver_()->PtrGetRealLocation(src, srcLocationType, srcRealLocation);
    if (error == RT_ERROR_NONE) {
        error = curCtx->Device_()->Driver_()->PtrGetRealLocation(dst, dstLocationType, dstRealLocation);
    }   /* 在调用者打印异常信息 */
    return error;
}

// Helper inline function: check if vector contains element
static inline bool contains(const std::vector<rtMemcpyKind_t>& v, rtMemcpyKind_t k) {
    return std::find(v.begin(), v.end(), k) != v.end();
}

// helper: convert allowedKinds to comma list string (for logs)
static std::string allowed_list_to_string(const std::vector<rtMemcpyKind_t>& v)
{
    if (v.empty()) {
        return "{}";
    }
    std::ostringstream oss;
    oss << "{";
    for (size_t i = 0; i < v.size(); ++i) {
        oss << static_cast<int32_t>(v[i]);  
        if (i + 1U < v.size()) {        
            oss << ", ";
        }
    }
    oss << "}";
    return oss.str();
}

// ===============================================
// Define Key Structure for Hash Map Lookup
// ===============================================
class MemcpyKindKey {
public:
    rtMemLocationType src;
    rtMemLocationType dst;
};

static bool operator==(MemcpyKindKey lhs, MemcpyKindKey rhs) noexcept {
    return lhs.src == rhs.src && lhs.dst == rhs.dst;
}

// ===============================================
// Define Hash Function for MemcpyKindKey
// ===============================================
// ===== hash (single consistent implementation) =====
class MemcpyKindKeyHash {
public:
    std::size_t operator()(MemcpyKindKey k) const noexcept {
        // combine two small enums into a size_t deterministically
        // shift by 8 bits is safe because enum values are small
        return (static_cast<std::size_t>(k.src) << 8U) | static_cast<std::size_t>(k.dst);
    }
};

// ===== rule struct (as you requested) =====
// - expectKind == RT_MEMCPY_RESERVED -> no forced override
// - allowedKinds: allowed incoming kinds when not forced (include RT_MEMCPY_DEFAULT if allowed)
// - defaultKind: what to set when incoming is RT_MEMCPY_DEFAULT
class MemcpyKindReviseRule {
public:
    rtMemcpyKind_t expectKind;
    std::vector<rtMemcpyKind_t> allowedKinds;
    rtMemcpyKind_t defaultKind;
    // Constructor for MemcpyKindReviseRule
    MemcpyKindReviseRule(rtMemcpyKind_t expectKind_, const std::vector<rtMemcpyKind_t> &allowedKinds_, rtMemcpyKind_t defaultKind_)
        : expectKind(expectKind_), allowedKinds(allowedKinds_), defaultKind(defaultKind_) {}
};

static const std::unordered_map<MemcpyKindKey, MemcpyKindReviseRule, MemcpyKindKeyHash> MemcpyKindReviseMap = {
    // 1. Host -> Device
    { MemcpyKindKey{RT_MEMORY_LOC_HOST, RT_MEMORY_LOC_DEVICE},
      MemcpyKindReviseRule{RT_MEMCPY_HOST_TO_DEVICE, {}, RT_MEMCPY_HOST_TO_DEVICE} },

    // 2. Device -> Host
    { MemcpyKindKey{RT_MEMORY_LOC_DEVICE, RT_MEMORY_LOC_HOST},
      MemcpyKindReviseRule{RT_MEMCPY_DEVICE_TO_HOST, {}, RT_MEMCPY_DEVICE_TO_HOST} },

    // 3. Host -> Host
    { MemcpyKindKey{RT_MEMORY_LOC_HOST, RT_MEMORY_LOC_HOST},
      MemcpyKindReviseRule{RT_MEMCPY_HOST_TO_HOST, {}, RT_MEMCPY_HOST_TO_HOST} },

    // 4. Device -> Device
    { MemcpyKindKey{RT_MEMORY_LOC_DEVICE, RT_MEMORY_LOC_DEVICE},
      MemcpyKindReviseRule{RT_MEMCPY_DEVICE_TO_DEVICE, {}, RT_MEMCPY_DEVICE_TO_DEVICE} },

    // 5. Unregistered -> Device
    { MemcpyKindKey{RT_MEMORY_LOC_UNREGISTERED, RT_MEMORY_LOC_DEVICE},
      MemcpyKindReviseRule{RT_MEMCPY_RESERVED, {RT_MEMCPY_HOST_TO_DEVICE, RT_MEMCPY_DEVICE_TO_DEVICE}, RT_MEMCPY_HOST_TO_DEVICE} },

    // 6. Device -> Unregistered
    { MemcpyKindKey{RT_MEMORY_LOC_DEVICE, RT_MEMORY_LOC_UNREGISTERED},
      MemcpyKindReviseRule{RT_MEMCPY_RESERVED, {RT_MEMCPY_DEVICE_TO_HOST, RT_MEMCPY_DEVICE_TO_DEVICE}, RT_MEMCPY_DEVICE_TO_HOST} },

    // 7. Host -> Unregistered
    { MemcpyKindKey{RT_MEMORY_LOC_HOST, RT_MEMORY_LOC_UNREGISTERED},
      MemcpyKindReviseRule{RT_MEMCPY_RESERVED, {RT_MEMCPY_HOST_TO_HOST, RT_MEMCPY_HOST_TO_DEVICE}, RT_MEMCPY_HOST_TO_HOST} },

    // 8. Unregistered -> Host
    { MemcpyKindKey{RT_MEMORY_LOC_UNREGISTERED, RT_MEMORY_LOC_HOST},
      MemcpyKindReviseRule{RT_MEMCPY_RESERVED, {RT_MEMCPY_HOST_TO_HOST, RT_MEMCPY_DEVICE_TO_HOST}, RT_MEMCPY_HOST_TO_HOST} },

    // 9. Unregistered -> Unregistered
    { MemcpyKindKey{RT_MEMORY_LOC_UNREGISTERED, RT_MEMORY_LOC_UNREGISTERED},
      MemcpyKindReviseRule{RT_MEMCPY_RESERVED, {RT_MEMCPY_HOST_TO_HOST, RT_MEMCPY_HOST_TO_DEVICE, RT_MEMCPY_DEVICE_TO_HOST, RT_MEMCPY_DEVICE_TO_DEVICE}, RT_MEMCPY_HOST_TO_HOST} }
};

rtError_t ApiErrorDecorator::MemcpyKindAutoCorrect(const rtMemLocationType srcLocationType,
                                                   const rtMemLocationType dstLocationType,
                                                   rtMemcpyKind_t *kind) const 
{
    if (*kind!=RT_MEMCPY_HOST_TO_HOST && *kind!=RT_MEMCPY_HOST_TO_DEVICE && *kind!=RT_MEMCPY_DEVICE_TO_HOST && *kind!=RT_MEMCPY_DEVICE_TO_DEVICE && *kind!=RT_MEMCPY_DEFAULT){
        return RT_ERROR_NONE;
    }
    MemcpyKindKey key{srcLocationType, dstLocationType};
    auto it = MemcpyKindReviseMap.find(key);
    if (it == MemcpyKindReviseMap.end()) {
        // Uncovered combinations: return success, kind unchanged.
        RT_LOG(RT_LOG_INFO,
               "MemcpyKindAutoCorrect: undefined memory combination src=%d, dst=%d, kind=%d.",
               srcLocationType, dstLocationType, *kind);
        return RT_ERROR_NONE;
    }
    const MemcpyKindReviseRule &rule = it->second;
    // 1) Forced mapping (expectKind != RT_MEMCPY_RESERVED)
    if (rule.expectKind != RT_MEMCPY_RESERVED) {
        if (*kind != rule.expectKind) {
            RT_LOG(RT_LOG_INFO,
                   "MemcpyKindAutoCorrect: kind changed from %d to %d for src=%d,dst=%d.",
                   *kind, rule.expectKind, srcLocationType, dstLocationType);
            *kind = rule.expectKind;
        }
        return RT_ERROR_NONE;
    }
    // 2) If incoming is DEFAULT -> replace with defaultKind
    if (*kind == RT_MEMCPY_DEFAULT) {
        RT_LOG(RT_LOG_INFO,
               "MemcpyKindAutoCorrect: kind changed from %d to %d for src=%d,dst=%d (default case).",
               *kind, rule.defaultKind, srcLocationType, dstLocationType);
        *kind = rule.defaultKind;
        return RT_ERROR_NONE;
    }
    // 3) If kind is in allowedKinds -> accept
    if (contains(rule.allowedKinds, *kind)) {
        return RT_ERROR_NONE;
    }
    // 4) Otherwise illegal -> log expected set and return error
    std::string expected = allowed_list_to_string(rule.allowedKinds);
    RT_LOG(RT_LOG_ERROR,
           "MemcpyKindAutoCorrect: invalid kind=%d for src=%d,dst=%d; expected one of [%s], actual=%d.",
           *kind, srcLocationType, dstLocationType, expected.c_str(), *kind);
    return RT_ERROR_INVALID_VALUE;
}

static bool JudgeIsInvolvePageableMemory(bool checkKind, const rtMemcpyKind_t kind,
    rtMemLocationType srcLocationType, rtMemLocationType dstLocationType)
{
    /* 
     * 当device内存为mbuf（不是从svm申请）时，drvMemGetAttribute会返回为host内存，转化为同步拷贝后底软会异常
     * 使用mbuf的场景：checkKind = false
     */
    if (checkKind && (kind != RT_MEMCPY_HOST_TO_HOST) && (kind != RT_MEMCPY_DEVICE_TO_DEVICE) && 
        (kind != RT_MEMCPY_ADDR_DEVICE_TO_DEVICE) &&
        ((srcLocationType == RT_MEMORY_LOC_UNREGISTERED) || (dstLocationType == RT_MEMORY_LOC_UNREGISTERED))) {
        return true;
    }

    return false;
}

rtError_t ApiErrorDecorator::MemcpyAsyncCheckLocation(bool checkKind, rtMemcpyKind_t &copyKind,
    const void *const src, const void *const dst, bool isUserRequireToCheckPinnedMem,
    bool &isD2HorH2DInvolvePageableMemory) const
{
    Context *curCtx = Runtime::Instance()->CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    NULL_PTR_RETURN_MSG(curCtx->Device_(), RT_ERROR_DEVICE_NULL);
    const bool isSupportUserMem = curCtx->Device_()->IsSupportUserMem();
    if (!isSupportUserMem) {
        if (isUserRequireToCheckPinnedMem) {
            /* 用户指定CHECK_MEMORY_PINNED，如果驱动不支持GET_USER_MALLOC_ATTR，则返回特性不支持 */
            ERROR_RETURN(RT_ERROR_FEATURE_NOT_SUPPORT, 
                "Fail to check pinned memory that required by user because not support GET_USER_MALLOC_ATTR feature.");
        } else {
            /* 
             * 用户未指定CHECK_MEMORY_PINNED，如果驱动不支持GET_USER_MALLOC_ATTR，则打印Info，流程继续。
             * 如果用GetLocationType获取new/malloc内存的Location，drvMemGetAttribute会报错；因此无法校验该场景的Location。
             */
            RT_LOG(RT_LOG_INFO, "Not support GET_USER_MALLOC_ATTR feature, continue.");
            return RT_ERROR_NONE;
        }
    }

    rtError_t error = RT_ERROR_NONE;
    const rtMemcpyKind_t kind = copyKind;

    /* 1) get location type of src and dst ptr */
    rtMemLocationType srcLocationType = RT_MEMORY_LOC_MAX;
    rtMemLocationType dstLocationType = RT_MEMORY_LOC_MAX;
    rtMemLocationType srcRealLocation = RT_MEMORY_LOC_MAX;
    rtMemLocationType dstRealLocation = RT_MEMORY_LOC_MAX;
    error = GetLocationType(src, dst, srcLocationType, srcRealLocation, dstLocationType, dstRealLocation);
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_DRV, error != RT_ERROR_NONE, error,
        "GetLocationType Failed, retCode=%#x, src=%p, dst=%p", static_cast<uint32_t>(error), src, dst);
    
    /* 2) check memory copy kind and real location */
    const uint32_t runMode = curCtx->Device_()->Driver_()->GetRunMode();
    if ((checkKind) && (runMode == RT_RUN_MODE_ONLINE)) {
        error = MemcpyKindAutoCorrect(srcLocationType, dstLocationType, &copyKind);
        COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_GE, error != RT_ERROR_NONE, error,
            "Memory async check kind and loc failed, retCode=%#x, copyKind=%d, srcLoc=%d, dstLoc=%d",
            static_cast<uint32_t>(error), copyKind, srcLocationType, dstLocationType);
    }

    /* 3) check whether involve pageable host memory */
    isD2HorH2DInvolvePageableMemory = JudgeIsInvolvePageableMemory(checkKind, copyKind, srcLocationType, dstLocationType);

    RT_LOG(RT_LOG_INFO, "kind=%d, checkKind= %d, copyKind=%d, srcLocType=%d, srcRealLocType=%d, dstLocType=%d, "
        "dstRealLocType=%d, isSupportUserMem=%d, isD2HorH2DInvolvePageableMemory=%d.", kind, checkKind, copyKind,
        srcLocationType, srcRealLocation, dstLocationType, dstRealLocation, isSupportUserMem,
        isD2HorH2DInvolvePageableMemory);

    return error;
}

rtError_t ApiErrorDecorator::MemcpyKindAutoUpdate(const rtMemLocationType srcType, const rtMemLocationType dstType,
    rtMemcpyKind_t *kind) const
{
    // registered memory should be treated as host memory 
    if ((srcType == RT_MEMORY_LOC_HOST)) {
        if (dstType == RT_MEMORY_LOC_HOST) {
            *kind = RT_MEMCPY_HOST_TO_HOST;
        } else {
            *kind = RT_MEMCPY_HOST_TO_DEVICE;
        }
    } else {
        if (dstType == RT_MEMORY_LOC_HOST) {
            *kind = RT_MEMCPY_DEVICE_TO_HOST;
        } else {
            *kind = RT_MEMCPY_DEVICE_TO_DEVICE;
        }
    }
    RT_LOG(RT_LOG_DEBUG, "auto infer copy srcType=%d, dstType=%d, dir=%d", srcType, dstType, *kind);
    return RT_ERROR_NONE;
}

rtError_t ApiErrorDecorator::ReduceAsync(void * const dst, const void * const src, const uint64_t cnt,
    const rtRecudeKind_t kind, const rtDataType_t type, Stream * const stm,
    const rtTaskCfgInfo_t * const cfgInfo)
{
    NULL_PTR_RETURN_MSG_OUTER(dst, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(src, RT_ERROR_INVALID_VALUE);
    ZERO_RETURN_AND_MSG_OUTER(cnt);
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM((kind >= RT_RECUDE_KIND_END) ||
        (kind < RT_MEMCPY_SDMA_AUTOMATIC_ADD), RT_ERROR_INVALID_VALUE, 
        kind, "[" + std::to_string(RT_MEMCPY_SDMA_AUTOMATIC_ADD) + ", " + std::to_string(RT_RECUDE_KIND_END) + ")"); 
    COND_RETURN_OUT_ERROR_MSG_CALL((kind == RT_MEMCPY_SDMA_AUTOMATIC_ADD) && (cnt > MAX_MEMCPY_SIZE_OF_D2D), RT_ERROR_INVALID_VALUE, 
        "If parameter kind equals %d, the range of parameter cnt should be (0, %" PRIu64 "]. Parameter cnt = %" PRIu64,
        kind, MAX_MEMCPY_SIZE_OF_D2D, cnt);
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM((type >= RT_DATA_TYPE_END) ||
        (type < RT_DATA_TYPE_FP32), RT_ERROR_INVALID_VALUE, type, 
        "[" + std::to_string(RT_DATA_TYPE_FP32) + ", " + std::to_string(RT_DATA_TYPE_END) + ")");

    const rtError_t error = impl_->ReduceAsync(dst, src, cnt, kind, type, stm, cfgInfo);
    ERROR_RETURN(error, "Reduce async failed, count=%" PRIu64 ", kind=%d.", cnt, kind);
    return error;
}

rtError_t ApiErrorDecorator::ReduceAsyncV2(void * const dst, const void * const src, const uint64_t cnt,
    const rtRecudeKind_t kind, const rtDataType_t type, Stream * const stm, void * const overflowAddr)
{
    NULL_PTR_RETURN_MSG_OUTER(dst, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(src, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(overflowAddr, RT_ERROR_INVALID_VALUE);
    ZERO_RETURN_AND_MSG_OUTER(cnt);
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM((kind != RT_MEMCPY_SDMA_AUTOMATIC_ADD), RT_ERROR_INVALID_VALUE, 
        kind, std::to_string(RT_MEMCPY_SDMA_AUTOMATIC_ADD));
	COND_RETURN_AND_MSG_OUTER_WITH_PARAM((cnt > MAX_MEMCPY_SIZE_OF_D2D), RT_ERROR_INVALID_VALUE, 
        cnt, "(0, " + std::to_string(MAX_MEMCPY_SIZE_OF_D2D) + "]");
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM((type >= RT_DATA_TYPE_END) || (type < RT_DATA_TYPE_FP32), 
        RT_ERROR_INVALID_VALUE,
        type, "[" + std::to_string(RT_DATA_TYPE_FP32) + ", " + std::to_string(RT_DATA_TYPE_END) + ")");

    const rtError_t error = impl_->ReduceAsyncV2(dst, src, cnt, kind, type, stm, overflowAddr);
    ERROR_RETURN(error, "Reduce async v2 failed, count=%" PRIu64 ", kind=%d.", cnt, static_cast<int32_t>(kind));
    return error;
}

rtError_t ApiErrorDecorator::MemCopy2DCheckParam(const void * const dst, const uint64_t dstPitch,
    const void * const src, const uint64_t srcPitch, const uint64_t width, const uint64_t height,
    const rtMemcpyKind_t kind) const
{
    NULL_PTR_RETURN_MSG_OUTER(dst, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(src, RT_ERROR_INVALID_VALUE);
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM(height == 0U, RT_ERROR_INVALID_VALUE, height, "greater than 0");
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM(dstPitch == 0U, RT_ERROR_INVALID_VALUE, dstPitch, "greater than 0");
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM(srcPitch == 0U, RT_ERROR_INVALID_VALUE, srcPitch, "greater than 0");
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM(width == 0U, RT_ERROR_INVALID_VALUE, width, "greater than 0");
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM((width > dstPitch), RT_ERROR_INVALID_VALUE, 
        width, "less than or equal to dstPitch");  
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM((width > srcPitch), RT_ERROR_INVALID_VALUE, 
        width, "less than or equal to srcPitch");  
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM(height > RT_MAX_MEMCPY2D_HEIGHT, RT_ERROR_INVALID_VALUE, 
        height, "less than or equal to " + std::to_string(RT_MAX_MEMCPY2D_HEIGHT));  
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM(width > RT_MAX_MEMCPY2D_WIDTH, RT_ERROR_INVALID_VALUE, 
        width, "less than or equal to " + std::to_string(RT_MAX_MEMCPY2D_WIDTH)); 
    COND_RETURN_WARN(((kind != RT_MEMCPY_DEFAULT) && (kind != RT_MEMCPY_HOST_TO_DEVICE) &&
        (kind != RT_MEMCPY_DEVICE_TO_HOST) && (kind != RT_MEMCPY_DEVICE_TO_DEVICE)), RT_ERROR_FEATURE_NOT_SUPPORT,
        "this memcpy2d feature only support kind is host2device, device2host or device2device.");

    return RT_ERROR_NONE;
}

rtMemcpyKind_t ApiErrorDecorator::GetMemCpyKind(const rtMemcpyKind_t kind, const rtMemcpyKind newKind) const
{
    if (newKind == RT_MEMCPY_KIND_MAX) { // 如果新枚举没传或者传的是最大值，则使用老枚举
        return kind;
    }

    static const std::unordered_map<rtMemcpyKind, rtMemcpyKind_t> KIND_MAP = {
        {RT_MEMCPY_KIND_HOST_TO_HOST, RT_MEMCPY_HOST_TO_HOST},
        {RT_MEMCPY_KIND_HOST_TO_DEVICE, RT_MEMCPY_HOST_TO_DEVICE},
        {RT_MEMCPY_KIND_DEVICE_TO_HOST, RT_MEMCPY_DEVICE_TO_HOST},
        {RT_MEMCPY_KIND_DEVICE_TO_DEVICE, RT_MEMCPY_DEVICE_TO_DEVICE},
        {RT_MEMCPY_KIND_DEFAULT, RT_MEMCPY_DEFAULT},
        {RT_MEMCPY_KIND_HOST_TO_BUF_TO_DEVICE, RT_MEMCPY_HOST_TO_DEVICE_EX},
        {RT_MEMCPY_KIND_INNER_DEVICE_TO_DEVICE, RT_MEMCPY_DEVICE_TO_DEVICE},
        {RT_MEMCPY_KIND_INTER_DEVICE_TO_DEVICE, RT_MEMCPY_DEVICE_TO_DEVICE},
        {RT_MEMCPY_KIND_MAX, RT_MEMCPY_RESERVED}
    };
    const auto iter = KIND_MAP.find(newKind);
    if (iter != KIND_MAP.end()) {
        return iter->second;
    } else {
        return RT_MEMCPY_RESERVED;
    }
}

rtError_t ApiErrorDecorator::MemCopy2DSync(void * const dst, const uint64_t dstPitch, const void * const src,
    const uint64_t srcPitch, const uint64_t width, const uint64_t height,
    const rtMemcpyKind_t kind, const rtMemcpyKind newKind)
{
    const auto curKind = GetMemCpyKind(kind, newKind);
    rtError_t error = MemCopy2DCheckParam(dst, dstPitch, src, srcPitch, width, height, curKind);
    ERROR_RETURN_MSG_CALL(ERR_MODULE_GE, error, "check memcpy2d param failure, retCode=%#x.", static_cast<uint32_t>(error));
    COND_RETURN_WARN(((curKind != RT_MEMCPY_DEFAULT) && (curKind != RT_MEMCPY_HOST_TO_DEVICE) &&
        (curKind != RT_MEMCPY_DEVICE_TO_HOST)), RT_ERROR_FEATURE_NOT_SUPPORT,
        "this memcpy2d feature only support kind is host2device or device2host.");
    rtMemcpyKind_t copyKind = curKind;
    rtMemLocationType srcLocationType = RT_MEMORY_LOC_MAX;
    rtMemLocationType dstLocationType = RT_MEMORY_LOC_MAX;
    rtMemLocationType srcRealLocation = RT_MEMORY_LOC_MAX;
    rtMemLocationType dstRealLocation = RT_MEMORY_LOC_MAX;
    error = GetLocationType(src, dst, srcLocationType, srcRealLocation, dstLocationType, dstRealLocation);
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_DRV, error != RT_ERROR_NONE, error,
        "GetLocationType Failed, retCode=%#x, src=%p, dst=%p", static_cast<uint32_t>(error), src, dst);

    /* MemcpyKindAutoUpdate需使用realLocation */
    error = MemcpyKindAutoCorrect(srcLocationType, dstLocationType, &copyKind);
    COND_RETURN_OUT_ERROR_MSG_CALL((error != RT_ERROR_NONE) || ((copyKind != RT_MEMCPY_HOST_TO_DEVICE) &&
        (copyKind != RT_MEMCPY_DEVICE_TO_HOST)), RT_ERROR_INVALID_VALUE,
        "Memcpy2d sync only support h2d or d2h, srcLocType=%d, srcLocType=%d, dstLocType=%d, dstRealLocType=%d, copyKind=%d, "
        "is invalid in default kind!", srcLocationType, srcRealLocation, dstLocationType, dstRealLocation, copyKind);
    error = impl_->MemCopy2DSync(dst, dstPitch, src, srcPitch, width, height, copyKind);
    ERROR_RETURN(error, "Memcpy2d sync failed, dstPitch=%" PRIu64 ", srcPitch=%" PRIu64
                 ", width=%" PRIu64 ", height=%" PRIu64 ", kind=%d", dstPitch, srcPitch, width, height, copyKind);
    return error;
}

rtError_t ApiErrorDecorator::MemCopy2DAsync(void * const dst, const uint64_t dstPitch, const void * const src,
    const uint64_t srcPitch, const uint64_t width, const uint64_t height, Stream * const stm,
    const rtMemcpyKind_t kind, const rtMemcpyKind newKind)
{
    Stream *curStm = Runtime::Instance()->GetCurStream(stm);
    NULL_PTR_RETURN_MSG_OUTER(curStm, RT_ERROR_INVALID_VALUE);
    rtMemcpyKind_t copyKind = GetMemCpyKind(kind, newKind);
    rtError_t error = MemCopy2DCheckParam(dst, dstPitch, src, srcPitch, width, height, copyKind);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, RT_ERROR_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_MSG_CALL(ERR_MODULE_GE, error, "check memcpy2d param failure, retCode=%#x.", static_cast<uint32_t>(error));

    bool isD2HorH2DInvolvePageableMemory = false;
    error = MemcpyAsyncCheckLocation(true, copyKind, src, dst, false, isD2HorH2DInvolvePageableMemory);  /* 会更新copykind */
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "MemcpyAsync check src or dst location failed, stream_id=%d.", curStm->Id_());
    COND_RETURN_OUT_ERROR_MSG_CALL((error != RT_ERROR_NONE) ||
        ((copyKind != RT_MEMCPY_HOST_TO_DEVICE) &&
        (copyKind != RT_MEMCPY_DEVICE_TO_HOST) &&
        (copyKind != RT_MEMCPY_DEVICE_TO_DEVICE)),
        RT_ERROR_INVALID_VALUE,
        "Memcpy2d Async only support h2d, d2h or d2d, kind=%d, reviseKind=%d", kind, copyKind);

    COND_RETURN_WARN(((copyKind != RT_MEMCPY_HOST_TO_DEVICE) && (copyKind != RT_MEMCPY_DEVICE_TO_HOST) && (copyKind != RT_MEMCPY_DEVICE_TO_DEVICE)),
        RT_ERROR_FEATURE_NOT_SUPPORT, "only support h2d, d2h or d2d");

    if (isD2HorH2DInvolvePageableMemory ) {
        /* 把异步拷贝转化为隐式流同步 + 同步拷贝，以避免异步访问pageable内存引起的PA异常 */
        error = StreamSynchronize(curStm, -1);
        COND_RETURN_ERROR(error != RT_ERROR_NONE, error, "StreamSynchronize failed, stream_id=%d.", curStm->Id_());

        error = impl_->MemCopy2DSync(dst, dstPitch, src, srcPitch, width, height, copyKind, newKind);
    } else {
        error = impl_->MemCopy2DAsync(dst, dstPitch, src, srcPitch, width, height, curStm, copyKind, newKind);
    }

    ERROR_RETURN(error, "Memcpy2d async failed, dstPitch=%" PRIu64 ", srcPitch=%" PRIu64 ", width=%" PRIu64
        ", height=%" PRIu64 ", kind=%d, isInvolvePageableMemory=%d", dstPitch, srcPitch, width, height, copyKind,
        isD2HorH2DInvolvePageableMemory);
    return error;
}

rtError_t ApiErrorDecorator::MemSetSync(const void * const devPtr, const uint64_t destMax, const uint32_t val,
    const uint64_t cnt)
{
    NULL_PTR_RETURN_MSG_OUTER(devPtr, RT_ERROR_INVALID_VALUE);
    ZERO_RETURN_AND_MSG_OUTER(cnt);

    const rtError_t error = impl_->MemSetSync(devPtr, destMax, val, cnt);
    ERROR_RETURN(error, "Memset sync failed, destMax=%" PRIu64 ", value=%u, count=%" PRIu64, destMax, val, cnt);
    return error;
}

rtError_t ApiErrorDecorator::MemsetAsync(void * const ptr, const uint64_t destMax, const uint32_t val,
    const uint64_t cnt, Stream * const stm)
{
    NULL_PTR_RETURN_MSG_OUTER(ptr, RT_ERROR_INVALID_VALUE);
    ZERO_RETURN_AND_MSG_OUTER(cnt);
	COND_RETURN_AND_MSG_OUTER_WITH_PARAM(cnt > destMax, RT_ERROR_INVALID_VALUE, 
        cnt, "(0, " + std::to_string(destMax) + "]");    
    
    const rtError_t error = impl_->MemsetAsync(ptr, destMax, val, cnt, stm);
    ERROR_RETURN(error, "Memset async failed, destMax=%" PRIu64 ", value=%u, count=%" PRIu64 ".",
        destMax, val, cnt);
    return error;
}

rtError_t ApiErrorDecorator::MemGetInfo(size_t * const freeSize, size_t * const totalSize)
{
    NULL_PTR_RETURN_MSG_OUTER(freeSize, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(totalSize, RT_ERROR_INVALID_VALUE);

    const rtError_t error = impl_->MemGetInfo(freeSize, totalSize);
    ERROR_RETURN(error, "Get memory info failed, free=%zu, total=%zu.", *freeSize, *totalSize);
    return error;
}

rtError_t ApiErrorDecorator::MemGetInfoByType(const int32_t devId, const rtMemType_t type, rtMemInfo_t * const info)
{
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM((devId < 0), RT_ERROR_DEVICE_ID, devId, "greater than or equal to 0");
	COND_RETURN_AND_MSG_OUTER_WITH_PARAM((type >= RT_MEM_INFO_TYPE_MAX), RT_ERROR_INVALID_VALUE, 
        type, "[" + std::to_string(RT_MEM_INFO_TYPE_DDR_SIZE) + ", " + std::to_string(RT_MEM_INFO_TYPE_MAX) + ")");
    NULL_PTR_RETURN_MSG_OUTER(info, RT_ERROR_INVALID_VALUE);
    rtError_t error;
    int32_t realDeviceId;
    error = Runtime::Instance()->ChgUserDevIdToDeviceId(static_cast<uint32_t>(devId),
        RtPtrToPtr<uint32_t *>(&realDeviceId));
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, "Error input devId:%d is err:%#x",
        devId, static_cast<uint32_t>(error));
    error = CheckDeviceIdIsValid(realDeviceId);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, "Device ID is invalid, drv devId=%d, retCode=%#x",
        realDeviceId, static_cast<uint32_t>(error));
    error = impl_->MemGetInfoByType(realDeviceId, type, info);
    ERROR_RETURN(error, "Failed to get memory info by type, devId=%d, type=%u.", devId, type);
    return error;
}

rtError_t ApiErrorDecorator::MemGetInfoEx(const rtMemInfoType_t memInfoType, size_t * const freeSize,
    size_t * const totalSize)
{
    NULL_PTR_RETURN_MSG_OUTER(freeSize, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(totalSize, RT_ERROR_INVALID_VALUE);
    COND_RETURN_ERROR_MSG_INNER((memInfoType < RT_MEMORYINFO_DDR) || (memInfoType > RT_MEMORYINFO_HBM_P2P_HUGE1G),
        RT_ERROR_INVALID_MEMORY_TYPE, "Invalid memInfoType=%d.", memInfoType);
    const rtError_t error = impl_->MemGetInfoEx(memInfoType, freeSize, totalSize);
    ERROR_RETURN(error, "Get Memory extend info failed, memInfoType=%u, free=%zu, total=%zu.",
        memInfoType, *freeSize, *totalSize);
    return error;
}

rtError_t ApiErrorDecorator::PointerGetAttributes(rtPointerAttributes_t * const attributes, const void * const ptr)
{
    NULL_PTR_RETURN_MSG_OUTER(attributes, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(ptr, RT_ERROR_INVALID_VALUE);

    rtError_t error = impl_->PointerGetAttributes(attributes, ptr);
    ERROR_RETURN(error, "Get pointer attributes failed");
    RT_LOG(RT_LOG_DEBUG,
        "get memory attribute locationType=%d, memoryType=%d, [1:HOST,2:DEVICE,3:SVM,4:DVPP].",
        static_cast<int32_t>(attributes->locationType),
        static_cast<int32_t>(attributes->memoryType));
    if (attributes->locationType == RT_MEMORY_LOC_DEVICE) {
        const uint32_t drvDeviceId = attributes->deviceID;
        error = Runtime::Instance()->GetUserDevIdByDeviceId(drvDeviceId, &attributes->deviceID);
        ERROR_RETURN_MSG_INNER(error, "Conv drvDeviceId:%u is err:%#x", drvDeviceId, static_cast<uint32_t>(error));
    }
    return RT_ERROR_NONE;
}

rtError_t ApiErrorDecorator::PtrGetAttributes(const void * const ptr, rtPtrAttributes_t * const attributes)
{
    NULL_PTR_RETURN_MSG_OUTER(attributes, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(ptr, RT_ERROR_INVALID_VALUE);

    const rtError_t error = impl_->PtrGetAttributes(ptr, attributes);
    ERROR_RETURN(error, "Get pointer attributes failed");
    RT_LOG(RT_LOG_DEBUG,"get memory attribute locationType=%d, [0:HOST,1:DEVICE].",
        static_cast<int32_t>(attributes->location.type));
    return RT_ERROR_NONE;
}

rtError_t ApiErrorDecorator::MemPrefetchToDevice(const void * const devPtr, const uint64_t len, const int32_t devId)
{
    NULL_PTR_RETURN_MSG_OUTER(devPtr, RT_ERROR_INVALID_VALUE);
    ZERO_RETURN_AND_MSG_OUTER(len);
    // PS:这个接口不能做内外dev id的转换
    NULL_PTR_RETURN_MSG(Runtime::Instance()->driverFactory_.GetDriver(NPU_DRIVER), RT_ERROR_INVALID_VALUE);
    int32_t cnt = 1;
    rtError_t error = Runtime::Instance()->driverFactory_.GetDriver(NPU_DRIVER)->GetDeviceCount(&cnt);
    ERROR_RETURN_MSG_INNER(error, "GetDeviceCount failed, retCode=%#x", static_cast<uint32_t>(error));

    error = impl_->MemPrefetchToDevice(devPtr, len, devId);
    ERROR_RETURN(error, "Memory prefetch to device failed, len=%" PRIu64 "(bytes), devId=%d.", len, devId);
    return error;
}

rtError_t ApiErrorDecorator::GetDeviceIDs(uint32_t * const devId, const uint32_t len)
{
    NULL_PTR_RETURN_MSG_OUTER(devId, RT_ERROR_INVALID_VALUE);

    return impl_->GetDeviceIDs(devId, len);
}

rtError_t ApiErrorDecorator::OpenNetService(const rtNetServiceOpenArgs *args)
{
    NULL_PTR_RETURN_MSG_OUTER(args, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(args->extParamList, RT_ERROR_INVALID_VALUE);
	COND_RETURN_AND_MSG_OUTER_WITH_PARAM((args->extParamCnt <= 0U) || (args->extParamCnt > RT_EXT_PARAM_CNT_MAX), 
        RT_ERROR_INVALID_VALUE, args->extParamCnt, "(0, " + std::to_string(RT_EXT_PARAM_CNT_MAX) + "]");    

    return impl_->OpenNetService(args);
}

rtError_t ApiErrorDecorator::CloseNetService()
{
    return impl_->CloseNetService();
}

rtError_t ApiErrorDecorator::GetDeviceCount(int32_t * const cnt)
{
    NULL_PTR_RETURN_MSG_OUTER(cnt, RT_ERROR_INVALID_VALUE);

    return impl_->GetDeviceCount(cnt);
}

rtError_t ApiErrorDecorator::SetDevice(const int32_t devId)
{
    Runtime * const rt = Runtime::Instance();
    driverType_t rawDrvType = rt->GetDriverType();
    Driver * const rawDrv = rt->driverFactory_.GetDriver(rawDrvType);
    NULL_PTR_RETURN_MSG(rawDrv, RT_ERROR_DRV_NULL);
    int32_t deviceCnt;
    int32_t realDeviceId;

    rtError_t error = rt->ChgUserDevIdToDeviceId(static_cast<uint32_t>(devId),
        RtPtrToPtr<uint32_t *>(&realDeviceId), true);
    if (error != RT_ERROR_NONE) {
        RT_LOG_OUTER_MSG(RT_INVALID_ARGUMENT_ERROR,
            "Failed to set visible device. The invalid device is %d and the input visible device is %s.",
            devId,
            rt->inputDeviceStr);
        return RT_ERROR_DEVICE_ID;
    }

    error = rawDrv->GetDeviceCount(&deviceCnt);
    ERROR_RETURN_MSG_CALL(ERR_MODULE_DRV, error, "Get device cnt failed, retCode=%#x", static_cast<uint32_t>(error));
    if ((realDeviceId < 0) || (realDeviceId >= deviceCnt)) {
        RT_LOG_OUTER_MSG_WITH_FUNC(ErrorCode::EE1003, realDeviceId, "drv devId", "[0, " +std::to_string(deviceCnt) + ")");
        return RT_ERROR_DEVICE_ID;
    }

    error = impl_->SetDevice(realDeviceId);
    std::string inputSocVersion = GlobalContainer::GetUserSocVersion();
    ERROR_RETURN(error, "Set device failed, device_id=%d, the current input soc version is %s.",
        devId, inputSocVersion.empty() ? "null" : inputSocVersion.c_str());
    return error;
}

rtError_t ApiErrorDecorator::GetDevice(int32_t * const devId)
{
    NULL_PTR_RETURN_MSG_OUTER(devId, RT_ERROR_INVALID_VALUE);

    return impl_->GetDevice(devId);
}

rtError_t ApiErrorDecorator::GetDevicePhyIdByIndex(const uint32_t devIndex, uint32_t * const phyId)
{
    NULL_PTR_RETURN_MSG_OUTER(phyId, RT_ERROR_INVALID_VALUE);

    uint32_t realDeviceId;
    rtError_t error = Runtime::Instance()->ChgUserDevIdToDeviceId(devIndex, &realDeviceId);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "input error devIndex:%u is err:%#x", devIndex, static_cast<uint32_t>(error));
    error = impl_->GetDevicePhyIdByIndex(realDeviceId, phyId);
    ERROR_RETURN(error, "Get device physic id by index failed, index=%u.", devIndex);
    return error;
}

rtError_t ApiErrorDecorator::GetDeviceIndexByPhyId(const uint32_t phyId, uint32_t * const devIndex)
{
    NULL_PTR_RETURN_MSG_OUTER(devIndex, RT_ERROR_INVALID_VALUE);

    uint32_t realDeviceId = 0;
    rtError_t error = impl_->GetDeviceIndexByPhyId(phyId, &realDeviceId);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "Get device index by physic id failed, phyId:%u, realDeviceId=%u", phyId, realDeviceId);
        return error;
    }

    error = Runtime::Instance()->GetUserDevIdByDeviceId(realDeviceId, devIndex);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "get error: phyid:%u realDeviceId:%u is err:%#x", phyId, realDeviceId, static_cast<uint32_t>(error));
    RT_LOG(RT_LOG_DEBUG, "realDeviceId:%u, phyId=%u, devIndex=%u.", realDeviceId, phyId, (*devIndex));
    return RT_ERROR_NONE;
}

rtError_t ApiErrorDecorator::EnableP2P(const uint32_t devIdDes, const uint32_t phyIdSrc, const uint32_t flag)
{
    uint32_t realDeviceId;
    rtError_t error = Runtime::Instance()->ChgUserDevIdToDeviceId(devIdDes, &realDeviceId);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "input error:drv devId %u is err:%#x", realDeviceId, static_cast<uint32_t>(error));
    COND_RETURN_OUT_ERROR_MSG_CALL(realDeviceId >= RT_MAX_DEV_NUM, RT_ERROR_INVALID_VALUE,
        "Invalid drv devId, current drv devId=%u, valid drv devId range is [0, %u)", realDeviceId, RT_MAX_DEV_NUM);
	COND_RETURN_AND_MSG_OUTER_WITH_PARAM(phyIdSrc >= RT_MAX_DEV_NUM, RT_ERROR_INVALID_VALUE, 
        phyIdSrc, "[0, " + std::to_string(RT_MAX_DEV_NUM) + ")");

    error = impl_->EnableP2P(realDeviceId, phyIdSrc, flag);
    ERROR_RETURN(error, "Enable P2P failed, devIdDes=%u, phyIdSrc=%u.", devIdDes, phyIdSrc);
    return error;
}

rtError_t ApiErrorDecorator::DisableP2P(const uint32_t devIdDes, const uint32_t phyIdSrc)
{
    uint32_t realDeviceId;
    rtError_t error = Runtime::Instance()->ChgUserDevIdToDeviceId(devIdDes, &realDeviceId);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "input error:drv devId %u is err:%#x", realDeviceId, static_cast<uint32_t>(error));
    COND_RETURN_OUT_ERROR_MSG_CALL(realDeviceId >= RT_MAX_DEV_NUM, RT_ERROR_INVALID_VALUE,
        "Invalid drv devId, current drv devId=%u, valid drv devId range is [0, %u)", realDeviceId, RT_MAX_DEV_NUM);
	COND_RETURN_AND_MSG_OUTER_WITH_PARAM(phyIdSrc >= RT_MAX_DEV_NUM, RT_ERROR_INVALID_VALUE, 
        phyIdSrc, "[0, " + std::to_string(RT_MAX_DEV_NUM) + ")");
    error = impl_->DisableP2P(realDeviceId, phyIdSrc);
    ERROR_RETURN(error, "Disable P2P failed, dest deviceId=%u, src phyId=%u.", devIdDes, phyIdSrc);
    return error;
}

rtError_t ApiErrorDecorator::DeviceCanAccessPeer(int32_t * const canAccessPeer, const uint32_t devId,
    const uint32_t peerDevice)
{
    uint32_t realDeviceId;
    rtError_t error = Runtime::Instance()->ChgUserDevIdToDeviceId(devId, &realDeviceId);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "input error:devId %u is err:%#x", devId, static_cast<uint32_t>(error));
    COND_RETURN_OUT_ERROR_MSG_CALL(realDeviceId >= RT_MAX_DEV_NUM, RT_ERROR_INVALID_VALUE,
        "Invalid drv devId, current drv devId=%u, valid drv devId range is [0, %u)", realDeviceId, RT_MAX_DEV_NUM);
    NULL_PTR_RETURN_MSG_OUTER(canAccessPeer, RT_ERROR_INVALID_VALUE);
	COND_RETURN_AND_MSG_OUTER_WITH_PARAM(peerDevice >= RT_MAX_DEV_NUM, RT_ERROR_INVALID_VALUE, 
        peerDevice, "[0, " + std::to_string(RT_MAX_DEV_NUM) + ")");
    error = impl_->DeviceCanAccessPeer(canAccessPeer, realDeviceId, peerDevice);
    ERROR_RETURN(error, "Device can access peer failed, devId=%u, peerDevice=%u.", devId, peerDevice);
    return error;
}

rtError_t ApiErrorDecorator::GetP2PStatus(const uint32_t devIdDes, const uint32_t phyIdSrc, uint32_t * const status)
{
    uint32_t realDeviceId;
    rtError_t error = Runtime::Instance()->ChgUserDevIdToDeviceId(devIdDes, &realDeviceId);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "input error:devIdDes %u is err:%#x", devIdDes, static_cast<uint32_t>(error));
    COND_RETURN_OUT_ERROR_MSG_CALL(realDeviceId >= RT_MAX_DEV_NUM, RT_ERROR_INVALID_VALUE,
        "Invalid drv devId, current drv devId=%u, valid drv devId range is [0, %u).",
        realDeviceId, RT_MAX_DEV_NUM);
	COND_RETURN_AND_MSG_OUTER_WITH_PARAM(phyIdSrc >= RT_MAX_DEV_NUM, RT_ERROR_INVALID_VALUE, 
        phyIdSrc, "[0, " + std::to_string(RT_MAX_DEV_NUM) + ")");
    NULL_PTR_RETURN_MSG_OUTER(status, RT_ERROR_INVALID_VALUE);

    error = impl_->GetP2PStatus(realDeviceId, phyIdSrc, status);
    ERROR_RETURN(error, "Get P2P status failed, dest devId=%u, src phyId=%u.", devIdDes, phyIdSrc);
    return error;
}

rtError_t ApiErrorDecorator::DeviceGetBareTgid(uint32_t * const pid)
{
    NULL_PTR_RETURN_MSG_OUTER(pid, RT_ERROR_INVALID_VALUE);

    return impl_->DeviceGetBareTgid(pid);
}

rtError_t ApiErrorDecorator::DeviceReset(const int32_t devId, const bool isForceReset)
{
    int32_t realDeviceId;
    rtError_t error = Runtime::Instance()->ChgUserDevIdToDeviceId(static_cast<uint32_t>(devId),
        RtPtrToPtr<uint32_t *>(&realDeviceId), true);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, RT_ERROR_DEVICE_ID,
        "input error devId:%d is err:%#x", devId, static_cast<uint32_t>(RT_ERROR_DEVICE_ID));
    error = CheckDeviceIdIsValid(realDeviceId);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "drv devId is invalid, drv devId=%d, retCode=%#x", realDeviceId, static_cast<uint32_t>(error));

    error = impl_->DeviceReset(realDeviceId, isForceReset);
    ERROR_RETURN(error, "Device reset failed, device_id=%d.", devId);
    return error;
}

rtError_t ApiErrorDecorator::DeviceSetLimit(const int32_t devId, const rtLimitType_t type, const uint32_t val)
{
	COND_RETURN_AND_MSG_OUTER_WITH_PARAM((devId < 0) || (devId >= static_cast<int32_t>(RT_MAX_DEV_NUM)), 
        RT_ERROR_INVALID_VALUE, devId, "[0, " + std::to_string(RT_MAX_DEV_NUM) + ")");    
    int32_t realDeviceId;
    rtError_t error = Runtime::Instance()->ChgUserDevIdToDeviceId(static_cast<uint32_t>(devId),
        RtPtrToPtr<uint32_t *>(&realDeviceId));
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, "input error devId:%d is err:%#x", devId, static_cast<uint32_t>(error));
    error = impl_->DeviceSetLimit(realDeviceId, type, val);
    ERROR_RETURN(error, "Device set limit failed, device_id=%d, type=%d, value=%u.",
        devId, static_cast<int32_t>(type), val);
    return error;
}

rtError_t ApiErrorDecorator::DeviceSynchronize(const int32_t timeout)
{
    COND_RETURN_AND_MSG_OUTER((timeout < -1) || (timeout == 0), RT_ERROR_INVALID_VALUE, 
        ErrorCode::EE1006, __func__, "timeout=" + std::to_string(timeout));
    const rtError_t error = impl_->DeviceSynchronize(timeout);
    ERROR_RETURN(error, "Device synchronize failed.");
    return error;
}

rtError_t ApiErrorDecorator::DeviceTaskAbort(const int32_t devId, const uint32_t timeout)
{
    Runtime * const rt = Runtime::Instance();
    const driverType_t rawDrvType = rt->GetDriverType();
    Driver * const rawDrv = rt->driverFactory_.GetDriver(rawDrvType);
    NULL_PTR_RETURN_MSG(rawDrv, RT_ERROR_DRV_NULL);
    int32_t deviceCnt;
    int32_t realDeviceId;
    COND_RETURN_WITH_NOLOG(!IS_SUPPORT_CHIP_FEATURE(rt->GetChipType(), RtOptionalFeatureType::RT_FEATURE_DFX_FAST_RECOVER),
        ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
	COND_RETURN_AND_MSG_OUTER_WITH_PARAM((timeout > TASK_ABORT_TIMEOUT_MAX), RT_ERROR_INVALID_VALUE, 
        timeout, "[0, " + std::to_string(TASK_ABORT_TIMEOUT_MAX) + "]");

    rtError_t error = rt->ChgUserDevIdToDeviceId(static_cast<uint32_t>(devId),
        RtPtrToPtr<uint32_t *>(&realDeviceId));
    COND_RETURN_OUT_ERROR_MSG_CALL((error != RT_ERROR_NONE), RT_ERROR_DEVICE_ID,
        "Set visible device failed, invalid device=%d, input visible devices:%s", devId, rt->inputDeviceStr);

    error = rawDrv->GetDeviceCount(&deviceCnt);
    ERROR_RETURN_MSG_CALL(ERR_MODULE_DRV, error, "Get device cnt failed, retCode=%#x", static_cast<uint32_t>(error));
    COND_RETURN_OUT_ERROR_MSG_CALL(((realDeviceId < 0) || (realDeviceId >= deviceCnt)), RT_ERROR_DEVICE_ID,
        "invalid drv devId, set drv devId=%d, valid drv devId range is [0, %d)", realDeviceId, deviceCnt);

    return impl_->DeviceTaskAbort(realDeviceId, timeout);
}

rtError_t ApiErrorDecorator::SnapShotProcessLock()
{
    return impl_->SnapShotProcessLock();
}

rtError_t ApiErrorDecorator::SnapShotProcessUnlock()
{
    return impl_->SnapShotProcessUnlock();
}

rtError_t ApiErrorDecorator::SnapShotCallbackRegister(rtSnapShotStage stage, rtSnapShotCallBack callback, void *args)
{
    return impl_->SnapShotCallbackRegister(stage, callback, args);
}

rtError_t ApiErrorDecorator::SnapShotCallbackUnregister(rtSnapShotStage stage, rtSnapShotCallBack callback)
{
    return impl_->SnapShotCallbackUnregister(stage, callback);
}

rtError_t ApiErrorDecorator::SnapShotProcessBackup()
{
    GlobalStateManager &globalStateManagerInstance = GlobalStateManager::GetInstance();
    std::unique_lock<std::mutex> lock(globalStateManagerInstance.GetStateMtx());
    if (globalStateManagerInstance.GetCurrentState() != RT_PROCESS_STATE_LOCKED) {
        RT_LOG(RT_LOG_ERROR,
            "current state is not the locked state, current state is %s",
            GlobalStateManager::StateToString(globalStateManagerInstance.GetCurrentState()));
        return RT_ERROR_SNAPSHOT_BACKUP_FAILED;
    }
    return impl_->SnapShotProcessBackup();
}

rtError_t ApiErrorDecorator::SnapShotProcessRestore()
{
    GlobalStateManager &globalStateManagerInstance = GlobalStateManager::GetInstance();
    std::unique_lock<std::mutex> lock(globalStateManagerInstance.GetStateMtx());
    if (globalStateManagerInstance.GetCurrentState() != RT_PROCESS_STATE_BACKED_UP) {
        RT_LOG(RT_LOG_ERROR,
            "current state is not the RT_PROCESS_STATE_BACKED_UP state, current state is %s",
            GlobalStateManager::StateToString(globalStateManagerInstance.GetCurrentState()));
        return RT_ERROR_SNAPSHOT_RESTORE_FAILED;
    }
    return impl_->SnapShotProcessRestore();
}

rtError_t ApiErrorDecorator::DeviceGetStreamPriorityRange(int32_t * const leastPriority,
    int32_t * const greatestPriority)
{
    if (leastPriority == nullptr && greatestPriority == nullptr) {
        RT_LOG(RT_LOG_INFO, "Both leastPriority and greatestPriority are null. No values returned");
    }
    return impl_->DeviceGetStreamPriorityRange(leastPriority, greatestPriority);
}

rtError_t ApiErrorDecorator::GetDeviceInfo(const uint32_t deviceId, const int32_t moduleType, const int32_t infoType,
    int64_t * const val)
{
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM(moduleType == MODULE_TYPE_HOST_AICPU, RT_ERROR_INVALID_VALUE, 
        moduleType, "not equal to " + std::to_string(MODULE_TYPE_HOST_AICPU));
    uint32_t realDeviceId;
    rtError_t error = Runtime::Instance()->ChgUserDevIdToDeviceId(deviceId, &realDeviceId);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "input error:deviceId:%u is err:%#x", deviceId, static_cast<uint32_t>(error));
    NULL_PTR_RETURN_MSG_OUTER(val, RT_ERROR_INVALID_VALUE);
    const auto npuDrv = Runtime::Instance()->driverFactory_.GetDriver(NPU_DRIVER);
    NULL_PTR_RETURN_MSG(npuDrv, RT_ERROR_DRV_NULL);
    int32_t cnt = 1;
    error = npuDrv->GetDeviceCount(&cnt);
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_DRV, error != RT_ERROR_NONE, error,
        "Get device info failed, get device count failed, retCode=%#x", static_cast<uint32_t>(error));
    COND_RETURN_OUT_ERROR_MSG_CALL(realDeviceId >= static_cast<uint32_t>(cnt),
        RT_ERROR_INVALID_VALUE,
        "Get device info failed, invalid drv devId, current drv devId=%u , valid drv devId range is [0, %d)",
        realDeviceId, cnt);

    error = impl_->GetDeviceInfo(realDeviceId, moduleType, infoType, val);
    ERROR_RETURN(error, "Get device info failed, deviceId=%u.", deviceId);
    return error;
}

rtError_t ApiErrorDecorator::GetPhyDeviceInfo(const uint32_t phyId, const int32_t moduleType, const int32_t infoType,
    int64_t * const val)
{
    NULL_PTR_RETURN_MSG_OUTER(val, RT_ERROR_INVALID_VALUE);
    const auto npuDrv = Runtime::Instance()->driverFactory_.GetDriver(NPU_DRIVER);
    NULL_PTR_RETURN_MSG(npuDrv, RT_ERROR_DRV_NULL);

    const rtError_t error = impl_->GetPhyDeviceInfo(phyId, moduleType, infoType, val);
    ERROR_RETURN(error, "Get phy device info failed, phyId=%u.", phyId);
    return error;
}

rtError_t ApiErrorDecorator::DeviceSetTsId(const uint32_t tsId)
{
	COND_RETURN_AND_MSG_OUTER_WITH_PARAM(tsId > RT_MAX_TS_ID, RT_ERROR_INVALID_VALUE, 
        tsId, "[0, " + std::to_string(RT_MAX_TS_ID) + "]");    
    return impl_->DeviceSetTsId(tsId);
}

rtError_t ApiErrorDecorator::ContextCreate(Context ** const inCtx, const int32_t devId)
{
    uint32_t realDeviceId = static_cast<uint32_t>(devId);
    rtError_t error = Runtime::Instance()->ChgUserDevIdToDeviceId(static_cast<uint32_t>(devId), &realDeviceId);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, RT_ERROR_DEVICE_ID,
        "input error:devId %d is err:%#x", devId, static_cast<uint32_t>(error));

    NULL_PTR_RETURN_MSG_OUTER(inCtx, RT_ERROR_INVALID_VALUE);
    error = impl_->ContextCreate(inCtx, static_cast<int32_t>(realDeviceId));
    ERROR_RETURN(error, "Create context failed, devId=%d.", devId);
    RT_LOG(RT_LOG_DEBUG, "create context success.");
    return error;
}

rtError_t ApiErrorDecorator::ContextDestroy(Context * const inCtx)
{
    NULL_PTR_RETURN_MSG_OUTER(inCtx, RT_ERROR_INVALID_VALUE);

    const rtError_t error = impl_->ContextDestroy(inCtx);
    ERROR_RETURN(error, "Destroy context failed.");
    return error;
}

rtError_t ApiErrorDecorator::ContextSetCurrent(Context * const inCtx)
{
    NULL_PTR_RETURN_MSG_OUTER(inCtx, RT_ERROR_INVALID_VALUE);
    CHECK_CONTEXT_VALID_WITH_RETURN(inCtx, RT_ERROR_INVALID_VALUE);
    const rtError_t error = impl_->ContextSetCurrent(inCtx);
    ERROR_RETURN(error, "Set current context failed.");
    return error;
}

rtError_t ApiErrorDecorator::ContextGetCurrent(Context ** const inCtx)
{
    NULL_PTR_RETURN_MSG_OUTER(inCtx, RT_ERROR_INVALID_VALUE);

    return impl_->ContextGetCurrent(inCtx);
}

rtError_t ApiErrorDecorator::ContextGetDevice(int32_t * const devId)
{
    NULL_PTR_RETURN_MSG_OUTER(devId, RT_ERROR_INVALID_VALUE);

    return impl_->ContextGetDevice(devId);
}

rtError_t ApiErrorDecorator::NameStream(Stream * const stm, const char_t * const name)
{
    Stream *curStm = Runtime::Instance()->GetCurStream(stm);
    NULL_PTR_RETURN_MSG_OUTER(curStm, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(name, RT_ERROR_INVALID_VALUE);

    return impl_->NameStream(curStm, name);
}

rtError_t ApiErrorDecorator::NameEvent(Event * const evt, const char_t * const name)
{
    NULL_PTR_RETURN_MSG_OUTER(evt, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(name, RT_ERROR_INVALID_VALUE);

    return impl_->NameEvent(evt, name);
}

rtError_t ApiErrorDecorator::ProfilerStart(const uint64_t profConfig, const int32_t numsDev,
    uint32_t * const deviceList, const uint32_t cacheFlag, const uint64_t profSwitchHi)
{
    ZERO_RETURN_AND_MSG_OUTER(profConfig);
    COND_RETURN_OUT_ERROR_MSG_CALL((numsDev != -1) && (numsDev != 0) && (deviceList == nullptr),
        RT_ERROR_INVALID_VALUE,
        "deviceList can be null only when numsDev is -1 or 0 but numsDev is %d.", numsDev);
    return impl_->ProfilerStart(profConfig, numsDev, deviceList, cacheFlag, profSwitchHi);
}

rtError_t ApiErrorDecorator::ProfilerStop(const uint64_t profConfig, const int32_t numsDev,
    uint32_t * const deviceList, const uint64_t profSwitchHi)
{
    ZERO_RETURN_AND_MSG_OUTER(profConfig);
    COND_RETURN_OUT_ERROR_MSG_CALL((numsDev != -1) && (numsDev != 0) && (deviceList == nullptr),
        RT_ERROR_INVALID_VALUE,
        "deviceList can be null only when numsDev is -1 or 0 but numsDev is %d.", numsDev);
    return impl_->ProfilerStop(profConfig, numsDev, deviceList, profSwitchHi);
}

rtError_t ApiErrorDecorator::ProfilerTrace(const uint64_t id, const bool notifyFlag, const uint32_t flags,
    Stream * const stm)
{
    return impl_->ProfilerTrace(id, notifyFlag, flags, stm);
}

rtError_t ApiErrorDecorator::ProfilerTraceEx(const uint64_t id, const uint64_t modelId, const uint16_t tagId,
    Stream * const stm)
{
    return impl_->ProfilerTraceEx(id, modelId, tagId, stm);
}

rtError_t ApiErrorDecorator::StartOnlineProf(Stream * const stm, const uint32_t sampleNum)
{
    const rtError_t error = impl_->StartOnlineProf(stm, sampleNum);
    ERROR_RETURN(error, "Start online profiling failed, sample_num=%u.", sampleNum);
    return error;
}

rtError_t ApiErrorDecorator::StopOnlineProf(Stream * const stm)
{
    const rtError_t error = impl_->StopOnlineProf(stm);
    ERROR_RETURN(error, "Stop online profiling failed.");
    return error;
}

rtError_t ApiErrorDecorator::AdcProfiler(const uint64_t addr, const uint32_t length)
{
    return impl_->AdcProfiler(addr, length);
}

rtError_t ApiErrorDecorator::SetMsprofReporterCallback(const MsprofReporterCallback callback)
{
    NULL_PTR_RETURN_MSG_OUTER(callback, RT_ERROR_INVALID_VALUE);
    return impl_->SetMsprofReporterCallback(callback);
}

rtError_t ApiErrorDecorator::GetOnlineProfData(Stream * const stm, rtProfDataInfo_t * const pProfData,
    const uint32_t profDataNum)
{
    NULL_PTR_RETURN_MSG_OUTER(pProfData, RT_ERROR_INVALID_VALUE);
    const rtError_t error = impl_->GetOnlineProfData(stm, pProfData, profDataNum);
    ERROR_RETURN(error, "Get online profiling data failed, data number=%u.", profDataNum);
    return error;
}

rtError_t ApiErrorDecorator::IpcSetMemoryName(const void * const ptr, const uint64_t byteCount, char_t * const name,
    const uint32_t len, const uint64_t flags)
{
    NULL_PTR_RETURN_MSG_OUTER(ptr, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(name, RT_ERROR_INVALID_VALUE);
    ZERO_RETURN_AND_MSG_OUTER(byteCount);
    ZERO_RETURN_AND_MSG_OUTER(len);

    constexpr uint64_t maxFlag = RT_IPC_MEM_EXPORT_FLAG_DISABLE_PID_VALIDATION;
	COND_RETURN_AND_MSG_OUTER_WITH_PARAM((flags > maxFlag), RT_ERROR_INVALID_VALUE, 
        flags, "[0, " + std::to_string(maxFlag) + "]");    

    const rtError_t error = impl_->IpcSetMemoryName(ptr, byteCount, name, len, flags);
    ERROR_RETURN(error, "Ipc set memory name failed, name=%s, byteCount=%#" PRIx64 ", len=%u(bytes)",
        name, byteCount, len);
    return error;
}

rtError_t ApiErrorDecorator::IpcSetMemoryAttr(const char *name, uint32_t type, uint64_t attr)
{
    NULL_PTR_RETURN_MSG_OUTER(name, RT_ERROR_INVALID_VALUE);
    const uint32_t nameLen = strnlen(name, RT_IPC_MAX_NAME);
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM(nameLen >= RT_IPC_MAX_NAME, RT_ERROR_INVALID_VALUE, 
        nameLen, "[0, " + std::to_string(RT_IPC_MAX_NAME) + ")");
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM((type >= RT_ATTR_TYPE_MAX), RT_ERROR_INVALID_VALUE, 
        type, "[0, " + std::to_string(RT_ATTR_TYPE_MAX) + ")");
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM((attr >= RT_IPC_ATTR_MAX), RT_ERROR_INVALID_VALUE, 
        attr, "[0, " + std::to_string(RT_IPC_ATTR_MAX) + ")");
    return impl_->IpcSetMemoryAttr(name, type, attr);
}

rtError_t ApiErrorDecorator::NopTask(Stream * const stm)
{
    Stream *curStm = Runtime::Instance()->GetCurStream(stm);
    NULL_PTR_RETURN_MSG_OUTER(curStm, RT_ERROR_INVALID_VALUE);
    return impl_->NopTask(curStm);
}

rtError_t ApiErrorDecorator::IpcDestroyMemoryName(const char_t * const name)
{
    NULL_PTR_RETURN_MSG_OUTER(name, RT_ERROR_INVALID_VALUE);

    const rtError_t error = impl_->IpcDestroyMemoryName(name);
    ERROR_RETURN(error, "Ipc destroy memory name failed, name=%s.", name);
    return error;
}

rtError_t ApiErrorDecorator::SetIpcNotifyPid(const char_t * const name, int32_t pid[], const int32_t num)
{
    NULL_PTR_RETURN_MSG_OUTER(name, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(pid, RT_ERROR_INVALID_VALUE);
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM(num <= 0, RT_ERROR_INVALID_VALUE, 
        num, "(0, " + std::to_string(MAX_INT32_NUM) + "]");
    return impl_->SetIpcNotifyPid(name, pid, num);
}

rtError_t ApiErrorDecorator::SetIpcMemPid(const char_t * const name, int32_t pid[], const int32_t num)
{
    NULL_PTR_RETURN_MSG_OUTER(name, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(pid, RT_ERROR_INVALID_VALUE);
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM(num <= 0, RT_ERROR_INVALID_VALUE, 
        num, "(0, " + std::to_string(MAX_INT32_NUM) + "]");
    return impl_->SetIpcMemPid(name, pid, num);
}

rtError_t ApiErrorDecorator::IpcOpenMemory(void ** const ptr, const char_t * const name, const uint64_t flags)
{
    NULL_PTR_RETURN_MSG_OUTER(ptr, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(name, RT_ERROR_INVALID_VALUE);

    constexpr uint64_t maxFlag = RT_IPC_MEM_IMPORT_FLAG_ENABLE_PEER_ACCESS;
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM((flags > maxFlag), RT_ERROR_INVALID_VALUE, 
        flags, "[0, " + std::to_string(maxFlag) + "]");

    const rtError_t error = impl_->IpcOpenMemory(ptr, name, flags);
    ERROR_RETURN(error, "Ipc open memory failed, name=%s.", name);
    return error;
}

rtError_t ApiErrorDecorator::IpcCloseMemory(const void * const ptr)
{
    NULL_PTR_RETURN_MSG_OUTER(ptr, RT_ERROR_INVALID_VALUE);

    const rtError_t error = impl_->IpcCloseMemory(ptr);
    ERROR_RETURN(error, "Ipc close memory failed.");
    return error;
}

rtError_t ApiErrorDecorator::IpcCloseMemoryByName(const char_t * const name)
{
    NULL_PTR_RETURN_MSG_OUTER(name, RT_ERROR_INVALID_VALUE);

    const rtError_t error = impl_->IpcCloseMemoryByName(name);
    ERROR_RETURN(error, "Ipc close memory failed.");
    return error;
}

rtError_t ApiErrorDecorator::GetAiCoreCount(uint32_t * const aiCoreCnt)
{
    NULL_PTR_RETURN_MSG_OUTER(aiCoreCnt, RT_ERROR_INVALID_VALUE);

    return impl_->GetAiCoreCount(aiCoreCnt);
}

rtError_t ApiErrorDecorator::GetAiCpuCount(uint32_t * const aiCpuCnt)
{
    NULL_PTR_RETURN_MSG_OUTER(aiCpuCnt, RT_ERROR_INVALID_VALUE);

    return impl_->GetAiCpuCount(aiCpuCnt);
}

rtError_t ApiErrorDecorator::ModelCreate(Model ** const mdl, const uint32_t flag)
{
    NULL_PTR_RETURN_MSG_OUTER(mdl, RT_ERROR_INVALID_VALUE);

    const rtError_t error = impl_->ModelCreate(mdl, flag);
    ERROR_RETURN(error, "Create model failed, flag=%#x.", flag);
    RT_LOG(RT_LOG_INFO, "model create success, modelId=%d", (*mdl)->Id_());
    return error;
}

rtError_t ApiErrorDecorator::ModelSetExtId(Model * const mdl, const uint32_t extId)
{
    NULL_PTR_RETURN_MSG_OUTER(mdl, RT_ERROR_INVALID_VALUE);
    COND_RETURN_ERROR_MSG_INNER(mdl->GetModelType() == RT_MODEL_CAPTURE_MODEL, RT_ERROR_INVALID_VALUE,
        "capture model does not support set extId, modelType=%d .", mdl->GetModelType());

    return impl_->ModelSetExtId(mdl, extId);
}

rtError_t ApiErrorDecorator::ModelDestroy(Model * const mdl)
{
    NULL_PTR_RETURN_MSG_OUTER(mdl, RT_ERROR_INVALID_VALUE);
    const uint32_t modelId = mdl->Id_();
    RT_LOG(RT_LOG_INFO, "model id=%u.", modelId);

    const rtError_t error = impl_->ModelDestroy(mdl);
    ERROR_RETURN(error, "Destroy model failed, model id=%u.", modelId);
    return error;
}

rtError_t ApiErrorDecorator::ModelBindStream(Model * const mdl, Stream * const stm, const uint32_t flag)
{
    Stream *curStm = Runtime::Instance()->GetCurStream(stm);
    NULL_PTR_RETURN_MSG_OUTER(mdl, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(curStm, RT_ERROR_INVALID_VALUE);
    COND_RETURN_ERROR_MSG_INNER(mdl->GetModelType() == RT_MODEL_CAPTURE_MODEL, RT_ERROR_INVALID_VALUE,
        "capture model does not support bind stream, modelType=%d .", mdl->GetModelType());
    COND_RETURN_ERROR_MSG_INNER(curStm->IsCapturing(), RT_ERROR_STREAM_CAPTURED,
        "stream is in capture mode, stream_id=%d.", curStm->Id_());

    COND_RETURN_OUT_ERROR_MSG_CALL((curStm->Flags() & RT_STREAM_CP_PROCESS_USE) != 0U,
        RT_ERROR_STREAM_INVALID,
        "Failed to bind the model with the stream. The stm parameter cannot be the stream whose flag is %u.",
        curStm->Flags());
    COND_RETURN_ERROR_MSG_INNER(curStm->IsBindDvppGrp(), RT_ERROR_STREAM_BIND_GRP, "stream bind dvpp grp");
    COND_RETURN_ERROR_MSG_INNER(curStm->GetFailureMode() == STOP_ON_FAILURE, RT_ERROR_FEATURE_NOT_SUPPORT,
        "stream is already STOP mode");
    COND_RETURN_ERROR_MSG_INNER(curStm->GetFailureMode() == ABORT_ON_FAILURE, RT_ERROR_FEATURE_NOT_SUPPORT,
        "stream is already ABORT mode");

    COND_RETURN_ERROR_MSG_INNER((curStm->Flags() & RT_STREAM_FAST_LAUNCH) != 0, RT_ERROR_FEATURE_NOT_SUPPORT,
        "fast launch stream does not support bind model.");

    COND_RETURN_OUT_ERROR_MSG_CALL((curStm->Device_()->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_MODEL_STREAM_DOT_SYNC)) &&
        ((curStm->Flags() & (RT_STREAM_PERSISTENT | RT_STREAM_AICPU)) == 0),
        RT_ERROR_INVALID_VALUE, "Non-persistent stream cannot be bound to a model.");

    const uint32_t modelId = mdl->Id_();
    const int32_t streamId = curStm->Id_();
    RT_LOG(RT_LOG_EVENT, "model_id=%u, stream_id=%d, model_name=%s, flag=%u, group_id=%u.",
        modelId, streamId, mdl->GetName().c_str(), flag, curStm->GetGroupId());

    const rtError_t error = impl_->ModelBindStream(mdl, curStm, flag);
    ERROR_RETURN(error, "Bind model stream failed, model_id=%u, stream_id=%d, flag=%u.", modelId, streamId, flag);
    return error;
}

rtError_t ApiErrorDecorator::ModelUnbindStream(Model * const mdl, Stream * const stm)
{
    Stream *curStm = Runtime::Instance()->GetCurStream(stm);
    NULL_PTR_RETURN_MSG_OUTER(mdl, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(curStm, RT_ERROR_INVALID_VALUE);
    COND_RETURN_ERROR_MSG_INNER(mdl->GetModelType() == RT_MODEL_CAPTURE_MODEL, RT_ERROR_INVALID_VALUE,
        "capture model does not support unbind stream, modelType=%d .", mdl->GetModelType());
    COND_RETURN_ERROR_MSG_INNER(curStm->IsCapturing(), RT_ERROR_STREAM_CAPTURED,
        "stream is in capture mode, stream_id=%d.", curStm->Id_());
    
    const uint32_t modelId = mdl->Id_();
    const int32_t streamId = curStm->Id_();
    RT_LOG(RT_LOG_EVENT, "model_id=%u, stream_id=%d, model_name=%s, group_id=%u.",
        modelId, streamId, mdl->GetName().c_str(), curStm->GetGroupId());
    const rtError_t error = impl_->ModelUnbindStream(mdl, curStm);
    ERROR_RETURN(error, "Unbind model stream failed, model_id=%u, stream_id=%d.", modelId, streamId);
    return error;
}

rtError_t ApiErrorDecorator::ModelLoadComplete(Model * const mdl)
{
    COND_RETURN_ERROR_MSG_INNER((mdl != nullptr) && (mdl->GetModelType() == RT_MODEL_CAPTURE_MODEL),
        RT_ERROR_INVALID_VALUE,
        "capture model does not support load complete, modelType=%d .", mdl->GetModelType());

    const rtError_t error = impl_->ModelLoadComplete(mdl);
    ERROR_RETURN(error, "Load model complete failed.");
    return error;
}

rtError_t ApiErrorDecorator::ModelExecute(Model * const mdl, Stream * const stm, const uint32_t flag, int32_t timeout)
{
    // timeout >=-1, -1:no limited
    COND_RETURN_AND_MSG_OUTER((timeout < -1) || (timeout == 0), RT_ERROR_INVALID_VALUE, 
        ErrorCode::EE1006, __func__, "timeout=" + std::to_string(timeout));
    NULL_PTR_RETURN_MSG_OUTER(mdl, RT_ERROR_INVALID_VALUE);
    COND_RETURN_OUT_ERROR_MSG_CALL((stm != nullptr) && (stm->GetModelNum() != 0),
        RT_ERROR_INVALID_VALUE,
        "The current stream cannot be the same as the model stream.");
    COND_RETURN_ERROR_MSG_INNER((stm != nullptr) && (stm->IsCapturing()), RT_ERROR_STREAM_CAPTURED,
        "The stream cannot be used for model execution during the capture stage.");
    if ((stm != nullptr) && (stm->Device_()->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_MODEL_STREAM_DOT_SYNC))) {
        COND_RETURN_OUT_ERROR_MSG_CALL(
        ((stm->Flags() & (RT_STREAM_AICPU | RT_STREAM_PERSISTENT | RT_STREAM_CP_PROCESS_USE)) != 0),
        RT_ERROR_INVALID_VALUE, "The stream whose flag is %u cannot be used for model execution.", stm->Flags());
    }

    const rtError_t error = impl_->ModelExecute(mdl, stm, flag, timeout);
    ERROR_RETURN(error, "Execute model failed.");
    return error;
}

rtError_t ApiErrorDecorator::ModelExecuteSync(Model * const mdl, int32_t timeout)
{
    // timeout >=-1, -1:no limited
    COND_RETURN_AND_MSG_OUTER((timeout < -1) || (timeout == 0), RT_ERROR_INVALID_VALUE, 
        ErrorCode::EE1006, __func__, "timeout=" + std::to_string(timeout));
    NULL_PTR_RETURN_MSG_OUTER(mdl, RT_ERROR_INVALID_VALUE);

    COND_RETURN_ERROR_MSG_INNER(mdl->GetModelType() == RT_MODEL_CAPTURE_MODEL, RT_ERROR_INVALID_VALUE,
        "capture model does not support execute sync, modelType=%d .", mdl->GetModelType());

    const rtError_t error = impl_->ModelExecuteSync(mdl, timeout);
    ERROR_RETURN(error, "Execute model failed.");
    return error;
}

rtError_t ApiErrorDecorator::ModelExecuteAsync(Model * const mdl, Stream * const stm)
{
    NULL_PTR_RETURN_MSG_OUTER(mdl, RT_ERROR_INVALID_VALUE);
    COND_RETURN_OUT_ERROR_MSG_CALL((stm != nullptr) && (stm->GetModelNum() != 0),
        RT_ERROR_INVALID_VALUE,
        "The current stream cannot be the same as the model stream.");
    COND_RETURN_ERROR_MSG_INNER((stm != nullptr) && (stm->IsCapturing()), RT_ERROR_STREAM_CAPTURED,
        "The stream cannot be used for model execution during the capture stage.");

    const rtError_t error = impl_->ModelExecuteAsync(mdl, stm);
    ERROR_RETURN(error, "Execute model failed.");
    return error;
}

rtError_t ApiErrorDecorator::ModelGetTaskId(Model * const mdl, uint32_t * const taskId, uint32_t * const streamId)
{
    NULL_PTR_RETURN_MSG_OUTER(mdl, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(taskId, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(streamId, RT_ERROR_INVALID_VALUE);
    return impl_->ModelGetTaskId(mdl, taskId, streamId);
}

rtError_t ApiErrorDecorator::ModelGetId(Model * const mdl, uint32_t * const modelId)
{
    NULL_PTR_RETURN_MSG_OUTER(mdl, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(modelId, RT_ERROR_INVALID_VALUE);
    return impl_->ModelGetId(mdl, modelId);
}

rtError_t ApiErrorDecorator::DebugRegister(Model * const mdl, const uint32_t flag, const void * const addr,
    uint32_t * const streamId, uint32_t * const taskId)
{
    NULL_PTR_RETURN_MSG_OUTER(mdl, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(addr, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(streamId, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(taskId, RT_ERROR_INVALID_VALUE);

    const rtError_t error = impl_->DebugRegister(mdl, flag, addr, streamId, taskId);
    const uint32_t modelId = mdl->Id_();
    RT_LOG(RT_LOG_INFO, "model_id = %u, flag = %u, streamId = %u, taskId = %u", modelId, flag, *streamId, *taskId);
    ERROR_RETURN(error, "Debug register failed, model_id=%u, flag=%u, streamId=%u, taskId=%u.",
        modelId, flag, *streamId, *taskId);
    return error;
}

rtError_t ApiErrorDecorator::DebugUnRegister(Model * const mdl)
{
    NULL_PTR_RETURN_MSG_OUTER(mdl, RT_ERROR_INVALID_VALUE);
    const uint32_t modelId = mdl->Id_();
    RT_LOG(RT_LOG_INFO, "model_id=%u.", modelId);

    const rtError_t error = impl_->DebugUnRegister(mdl);
    ERROR_RETURN(error, "Unregister debug failed, model_id=%u.", modelId);
    return error;
}

rtError_t ApiErrorDecorator::DebugRegisterForStream(Stream * const stm, const uint32_t flag, const void * const addr,
    uint32_t * const streamId, uint32_t * const taskId)
{
    Stream *curStm = Runtime::Instance()->GetCurStream(stm);
    NULL_PTR_RETURN_MSG_OUTER(curStm, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(addr, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(streamId, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(taskId, RT_ERROR_INVALID_VALUE);

    const int32_t id = curStm->Id_();
    RT_LOG(RT_LOG_INFO, "stream_id = %d, flag = %u", id, flag);

    COND_RETURN_WARN(curStm->IsCapturing(), RT_ERROR_FEATURE_NOT_SUPPORT,
 	    "Debug registration for stream tasks cannot be delivered in capture mode.");

    const rtError_t error = impl_->DebugRegisterForStream(curStm, flag, addr, streamId, taskId);
    ERROR_RETURN(error, "Debug registration for stream failed, stream_id=%d, flag=%u, "
        "streamId=%u, taskId=%u.", id, flag, *streamId, *taskId);
    return error;
}

rtError_t ApiErrorDecorator::DebugUnRegisterForStream(Stream * const stm)
{
    Stream *curStm = Runtime::Instance()->GetCurStream(stm);
    NULL_PTR_RETURN_MSG_OUTER(curStm, RT_ERROR_INVALID_VALUE);
    const int32_t id = curStm->Id_();
    RT_LOG(RT_LOG_INFO, "stream_id=%d.", id);

    COND_RETURN_WARN(curStm->IsCapturing(), RT_ERROR_FEATURE_NOT_SUPPORT,
 	    "Debug unregistration for stream tasks cannot be delivered in capture mode.");

    const rtError_t error = impl_->DebugUnRegisterForStream(curStm);
    ERROR_RETURN(error, "Debug unregistration for stream failed, stream_id=%u.", id);
    return error;
}

rtError_t ApiErrorDecorator::ModelSetSchGroupId(Model * const mdl, const int16_t schGrpId)
{
    NULL_PTR_RETURN_MSG_OUTER(mdl, RT_ERROR_INVALID_VALUE);
    if ((schGrpId < MODEL_SCH_GROUP_ID_MIN) || (schGrpId > MODEL_SCH_GROUP_ID_MAX)) {
        RT_LOG_OUTER_MSG_INVALID_PARAM(schGrpId,
            "[" + std::to_string(MODEL_SCH_GROUP_ID_MIN) + ", " + std::to_string(MODEL_SCH_GROUP_ID_MAX) + "]");
        return RT_ERROR_INVALID_VALUE;
    }
    const rtError_t error = impl_->ModelSetSchGroupId(mdl, schGrpId);
    ERROR_RETURN(error, "ModelSetSchGroupId failed, schGrpId=%hd.", schGrpId);
    return error;
}

rtError_t ApiErrorDecorator::ModelTaskUpdate(Stream *desStm, uint32_t desTaskId, Stream *sinkStm,
                                             rtMdlTaskUpdateInfo_t *para)
{
    NULL_PTR_RETURN_MSG_OUTER(desStm, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(sinkStm, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(para, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(para->tilingKeyAddr, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(para->blockDimAddr, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(para->hdl, RT_ERROR_INVALID_VALUE);

    const rtChipType_t chipType = Runtime::Instance()->GetChipType();

    if (!sinkStm->Device_()->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_MODEL_UPDATE_SQE_TILING_KEY)) {
        RT_LOG(RT_LOG_WARNING, "unsupported chip type (%d)", chipType);
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }

    const uint32_t tschVersion = sinkStm->Device_()->GetTschVersion();
    const bool isSupport = sinkStm->Device_()->CheckFeatureSupport(TS_FEATURE_TILING_KEY_SINK);
    if (!isSupport) {
        RT_LOG(RT_LOG_WARNING, "unsupported task type (ModelTaskUpdate) in current ts version, tschVersion=%u",
            tschVersion);
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }

    if ((desStm->GetBindFlag() != true) || (sinkStm->GetBindFlag() != true)) {
        RT_LOG(RT_LOG_ERROR, "model update task does not support non-model scenario.");
        return RT_ERROR_STREAM_MODEL;
    }

    const rtError_t error = impl_->ModelTaskUpdate(desStm, desTaskId, sinkStm, para);
    ERROR_RETURN(error, "ModelTaskUpdate failed, desStm=%d.desTaskId=%u,sinkStm=%d",
        desStm->Id_(), desTaskId, sinkStm->Id_());
    return error;
}

rtError_t ApiErrorDecorator::ModelEndGraph(Model * const mdl, Stream * const stm, const uint32_t flags)
{
    Stream *curStm = Runtime::Instance()->GetCurStream(stm);
    NULL_PTR_RETURN_MSG_OUTER(mdl, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(curStm, RT_ERROR_INVALID_VALUE);
    COND_RETURN_ERROR_MSG_INNER(mdl->GetModelType() == RT_MODEL_CAPTURE_MODEL, RT_ERROR_INVALID_VALUE,
        "capture model does not support end graph, modelType=%d .", mdl->GetModelType());
    COND_RETURN_ERROR_MSG_INNER(curStm->IsCapturing(), RT_ERROR_STREAM_CAPTURED,
        "stream is in capture mode, stream_id=%d.", curStm->Id_());
    
    const rtError_t error = impl_->ModelEndGraph(mdl, curStm, flags);
    ERROR_RETURN(error, "Add model end graph failed, flags=%u.", flags);
    return error;
}

rtError_t ApiErrorDecorator::ModelExecutorSet(Model * const mdl, const uint8_t flags)
{
    NULL_PTR_RETURN_MSG_OUTER(mdl, RT_ERROR_INVALID_VALUE);
    COND_RETURN_ERROR_MSG_INNER(mdl->GetModelType() == RT_MODEL_CAPTURE_MODEL, RT_ERROR_INVALID_VALUE,
        "capture model does not support set executor, modelType=%d .", mdl->GetModelType());
	COND_RETURN_AND_MSG_OUTER_WITH_PARAM(!((flags == EXECUTOR_TS) || (flags == EXECUTOR_AICPU)), RT_ERROR_INVALID_VALUE, 
        flags, std::to_string(EXECUTOR_TS) + " or " + std::to_string(EXECUTOR_AICPU));
    const rtError_t error = impl_->ModelExecutorSet(mdl, flags);
    ERROR_RETURN(error, "Set model executor failed flags=%hhu.", flags);
    return error;
}

rtError_t ApiErrorDecorator::ModelAbort(Model * const mdl)
{
    NULL_PTR_RETURN_MSG_OUTER(mdl, RT_ERROR_INVALID_VALUE);
    const rtError_t error = impl_->ModelAbort(mdl);
    ERROR_RETURN(error, "Abort model failed.");
    return error;
}

rtError_t ApiErrorDecorator::ModelExit(Model * const mdl, Stream * const stm)
{
    Stream *curStm = Runtime::Instance()->GetCurStream(stm);
    NULL_PTR_RETURN_MSG_OUTER(mdl, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(curStm, RT_ERROR_INVALID_VALUE);
    const rtError_t error = impl_->ModelExit(mdl, curStm);
    if (error != RT_ERROR_MODEL_ABORT_NORMAL) {
        ERROR_RETURN(error, "Model exit report error.");
    }
    return error;
}

rtError_t ApiErrorDecorator::ModelBindQueue(Model * const mdl, const uint32_t queueId, const rtModelQueueFlag_t flag)
{
    NULL_PTR_RETURN_MSG_OUTER(mdl, RT_ERROR_INVALID_VALUE);
    COND_RETURN_ERROR_MSG_INNER(mdl->GetModelType() == RT_MODEL_CAPTURE_MODEL, RT_ERROR_INVALID_VALUE,
        "capture model does not support bind queue, modelType=%d .", mdl->GetModelType());
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM((flag != RT_MODEL_INPUT_QUEUE) && (flag != RT_MODEL_OUTPUT_QUEUE), 
        RT_ERROR_INVALID_VALUE, flag, std::to_string(RT_MODEL_INPUT_QUEUE) + " or " + std::to_string(RT_MODEL_OUTPUT_QUEUE));    
    const rtError_t error = impl_->ModelBindQueue(mdl, queueId, flag);
    ERROR_RETURN(error, "Model bind queue failed, queueId=%u, flag=%d.", queueId, static_cast<int32_t>(flag));
    return error;
}

rtError_t ApiErrorDecorator::NotifyCreate(const int32_t deviceId, Notify ** const retNotify, uint64_t flag)
{
    NULL_PTR_RETURN_MSG_OUTER(retNotify, RT_ERROR_INVALID_VALUE);

    int32_t realDeviceId;
    rtError_t error = Runtime::Instance()->ChgUserDevIdToDeviceId(static_cast<uint32_t>(deviceId),
        RtPtrToPtr<uint32_t *>(&realDeviceId));
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "input error deviceId:%d is error:%#x", deviceId, static_cast<uint32_t>(error));

    COND_RETURN_AND_MSG_OUTER_WITH_PARAM((flag & static_cast<uint32_t>(~static_cast<uint32_t>(RT_NOTIFY_FLAG_MAX))) != 0U, 
        RT_ERROR_INVALID_VALUE, flag, 
        std::to_string(RT_NOTIFY_FLAG_DEFAULT) + " , " 
        + std::to_string(RT_NOTIFY_FLAG_DOWNLOAD_TO_DEV) + " , "
        + std::to_string(RT_NOTIFY_FLAG_SHR_ID_SHADOW) + " or "
        + std::to_string(RT_NOTIFY_FLAG_MAX));

    error = impl_->NotifyCreate(realDeviceId, retNotify, flag);
    ERROR_RETURN(error, "Create notify failed, device id=%d.", deviceId);
    RT_LOG(RT_LOG_INFO, "notify create success");
    return error;
}

rtError_t ApiErrorDecorator::NotifyDestroy(Notify * const inNotify)
{
    NULL_PTR_RETURN_MSG_OUTER(inNotify, RT_ERROR_INVALID_VALUE);

    const rtError_t error = impl_->NotifyDestroy(inNotify);
    ERROR_RETURN(error, "Destroy notify failed.");
    return error;
}

rtError_t ApiErrorDecorator::NotifyRecord(Notify * const inNotify, Stream * const stm)
{
    NULL_PTR_RETURN_MSG_OUTER(inNotify, RT_ERROR_INVALID_VALUE);

    const rtError_t error = impl_->NotifyRecord(inNotify, stm);
    ERROR_RETURN(error, "Record notify failed.");
    return error;
}

rtError_t ApiErrorDecorator::NotifyReset(Notify * const inNotify)
{
    NULL_PTR_RETURN_MSG_OUTER(inNotify, RT_ERROR_INVALID_VALUE);

    const rtError_t error = impl_->NotifyReset(inNotify);
    ERROR_RETURN(error, "Reset notify failed.");
    return error;
}

rtError_t ApiErrorDecorator::ResourceClean(int32_t devId, rtIdType_t type)
{
    if (type != RT_NOTIFY_ID) {
        RT_LOG(RT_LOG_WARNING, "unsupported current type is %u, valid type is %u", type, RT_NOTIFY_ID);
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }
    Runtime * const rt = Runtime::Instance();
    const driverType_t rawDrvType = rt->GetDriverType();
    Driver * const rawDrv = rt->driverFactory_.GetDriver(rawDrvType);
    NULL_PTR_RETURN_MSG(rawDrv, RT_ERROR_DRV_NULL);
    COND_RETURN_WITH_NOLOG(!IS_SUPPORT_CHIP_FEATURE(rt->GetChipType(), 
        RtOptionalFeatureType::RT_FEATURE_DFX_FAST_RECOVER_DOT_RESOURCE_CLEAN), RT_ERROR_FEATURE_NOT_SUPPORT);
    int32_t deviceCnt;
    int32_t realDeviceId;
    rtError_t error = rt->ChgUserDevIdToDeviceId(static_cast<uint32_t>(devId),
        RtPtrToPtr<uint32_t *>(&realDeviceId));
    COND_RETURN_OUT_ERROR_MSG_CALL((error != RT_ERROR_NONE), RT_ERROR_DEVICE_ID,
        "input devId=%d, set fail drv devId=%d", devId, realDeviceId);

    error = rawDrv->GetDeviceCount(&deviceCnt);
    ERROR_RETURN_MSG_CALL(ERR_MODULE_DRV, error, "Get device cnt failed, retCode=%#x", static_cast<uint32_t>(error));
    COND_RETURN_OUT_ERROR_MSG_CALL(((realDeviceId < 0) || (realDeviceId >= deviceCnt)), RT_ERROR_DEVICE_ID,
        "invalid devId=%d, set drv devId=%d, valid drv devId range is [0, %d)", devId, realDeviceId, deviceCnt);

    error = impl_->ResourceClean(realDeviceId, type);
    ERROR_RETURN(error, "resource clean.");
    return error;
}

rtError_t ApiErrorDecorator::NotifyWait(Notify * const inNotify, Stream * const stm, const uint32_t timeOut)
{
    NULL_PTR_RETURN_MSG_OUTER(inNotify, RT_ERROR_INVALID_VALUE);
    const rtError_t error = impl_->NotifyWait(inNotify, stm, timeOut);
    ERROR_RETURN(error, "NotifyWait failed, timeout=%us", timeOut);
    return error;
}

rtError_t ApiErrorDecorator::GetNotifyID(Notify * const inNotify, uint32_t * const notifyID)
{
    NULL_PTR_RETURN_MSG_OUTER(inNotify, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(notifyID, RT_ERROR_INVALID_VALUE);

    const rtError_t error = impl_->GetNotifyID(inNotify, notifyID);
    ERROR_RETURN(error, "Get notify ID failed.");
    return error;
}

rtError_t ApiErrorDecorator::GetNotifyPhyInfo(Notify *const inNotify, rtNotifyPhyInfo *notifyInfo)
{
    NULL_PTR_RETURN_MSG_OUTER(inNotify, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(notifyInfo, RT_ERROR_INVALID_VALUE);

    return impl_->GetNotifyPhyInfo(inNotify, notifyInfo);
}

rtError_t ApiErrorDecorator::IpcSetNotifyName(Notify * const inNotify, char_t * const name, const uint32_t len, const uint64_t flag)
{
    NULL_PTR_RETURN_MSG_OUTER(inNotify, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(name, RT_ERROR_INVALID_VALUE);
    ZERO_RETURN_AND_MSG_OUTER(len);

    const Runtime *const rtInstance = Runtime::Instance();
    const rtChipType_t chipType = rtInstance->GetChipType();
    if (!IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_IPC_NOTIFY)) {
        RT_LOG(RT_LOG_WARNING, "chipType=%d does not support, return.", chipType);
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }

    COND_RETURN_AND_MSG_OUTER_WITH_PARAM(
        ((flag != RT_NOTIFY_EXPORT_FLAG_DISABLE_PID_VALIDATION) && (flag != RT_NOTIFY_FLAG_DEFAULT)), RT_ERROR_INVALID_VALUE, 
        flag, std::to_string(RT_NOTIFY_FLAG_DEFAULT) + " or " + std::to_string(RT_NOTIFY_EXPORT_FLAG_DISABLE_PID_VALIDATION));

    const rtError_t error = impl_->IpcSetNotifyName(inNotify, name, len, flag);
    ERROR_RETURN(error, "Ipc set notify name failed, name=%s, len=%u(bytes).", name, len);
    return error;
}

rtError_t ApiErrorDecorator::IpcOpenNotify(Notify ** const retNotify, const char_t * const name, uint32_t flag)
{
    NULL_PTR_RETURN_MSG_OUTER(retNotify, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(name, RT_ERROR_INVALID_VALUE);

    constexpr uint32_t maxFlag = (RT_NOTIFY_FLAG_DOWNLOAD_TO_DEV | RT_NOTIFY_IMPORT_FLAG_ENABLE_PEER_ACCESS);
	COND_RETURN_AND_MSG_OUTER_WITH_PARAM((flag > maxFlag), RT_ERROR_INVALID_VALUE, 
        flag, "[0, " + std::to_string(maxFlag) + "]");
    const rtError_t error = impl_->IpcOpenNotify(retNotify, name, flag);
    ERROR_RETURN(error, "Ipc open notify failed, name=%s.", name);
    return error;
}

rtError_t ApiErrorDecorator::NotifyGetAddrOffset(Notify * const inNotify, uint64_t * const devAddrOffset)
{
    NULL_PTR_RETURN_MSG_OUTER(inNotify, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(devAddrOffset, RT_ERROR_INVALID_VALUE);

    const rtError_t error = impl_->NotifyGetAddrOffset(inNotify, devAddrOffset);
    ERROR_RETURN(error, "Get notify address offset failed.");
    return error;
}

rtError_t ApiErrorDecorator::StreamSwitchEx(void * const ptr, const rtCondition_t condition, void * const valuePtr,
    Stream * const trueStream, Stream * const stm, const rtSwitchDataType_t dataType)
{
    Stream *curStm = Runtime::Instance()->GetCurStream(stm);
    NULL_PTR_RETURN_MSG_OUTER(ptr, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(valuePtr, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(trueStream, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(curStm, RT_ERROR_INVALID_VALUE);
	COND_RETURN_AND_MSG_OUTER_WITH_PARAM((condition > RT_LESS_OR_EQUAL) || (condition < 0), RT_ERROR_INVALID_VALUE, 
        condition, "[0, " + std::to_string(RT_LESS_OR_EQUAL) + "]");
	COND_RETURN_AND_MSG_OUTER_WITH_PARAM((dataType > RT_SWITCH_INT64) || (dataType < 0), RT_ERROR_INVALID_VALUE, 
        dataType, "[0, " + std::to_string(RT_SWITCH_INT64) + "]");
    const rtError_t error = impl_->StreamSwitchEx(ptr, condition, valuePtr, trueStream, curStm, dataType);
    ERROR_RETURN(error, "Stream switch[extend] failed, condition=%d, dataType=%d.",
        condition, static_cast<int32_t>(dataType));
    return error;
}

rtError_t ApiErrorDecorator::StreamSwitchN(void * const ptr, const uint32_t size, void * const valuePtr,
    Stream ** const trueStreamPtr, const uint32_t elementSize, Stream * const stm, const rtSwitchDataType_t dataType)
{
    Stream *curStm = Runtime::Instance()->GetCurStream(stm);
    NULL_PTR_RETURN_MSG_OUTER(ptr, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(valuePtr, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(trueStreamPtr, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(curStm, RT_ERROR_INVALID_VALUE);

    COND_RETURN_AND_MSG_OUTER_WITH_PARAM((size == 0U), RT_ERROR_INVALID_VALUE, size, "not equal to 0");
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM((elementSize == 0U), RT_ERROR_INVALID_VALUE, elementSize, "not equal to 0");
    COND_RETURN_OUT_ERROR_MSG_CALL(((UINT32_MAX / size) <= elementSize), RT_ERROR_INVALID_VALUE, 
        "StreamSwitchN failed. Parameter elementSize should be less than the quotient of %u and parameter size. "
        "Parameter size = %u, parameter elementSize = %u.", 
        UINT32_MAX, size, elementSize);

    for (uint32_t i = 0U; i < elementSize; i++) {
        NULL_PTR_RETURN_MSG_OUTER(trueStreamPtr[i], RT_ERROR_INVALID_VALUE);
    }

	COND_RETURN_AND_MSG_OUTER_WITH_PARAM((dataType > RT_SWITCH_INT64) || (dataType < 0), RT_ERROR_INVALID_VALUE, 
        dataType, "[0, " + std::to_string(RT_SWITCH_INT64) + "]");
    const rtError_t error = impl_->StreamSwitchN(ptr, size, valuePtr, trueStreamPtr, elementSize, curStm, dataType);
    ERROR_RETURN(error, "Stream switchN failed, size=%u(bytes), elementSize=%u(bytes) dataType=%d",
        size, elementSize, dataType);
    return error;
}

rtError_t ApiErrorDecorator::StreamActive(Stream * const activeStream, Stream * const stm)
{
    Stream *curStm = Runtime::Instance()->GetCurStream(stm);
    NULL_PTR_RETURN_MSG_OUTER(curStm, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(activeStream, RT_ERROR_INVALID_VALUE);
    const rtError_t error = impl_->StreamActive(activeStream, curStm);
    ERROR_RETURN(error, "Stream active failed.");
    return error;
}

rtError_t ApiErrorDecorator::LabelCreate(Label ** const lbl, Model * const mdl)
{
    NULL_PTR_RETURN_MSG_OUTER(lbl, RT_ERROR_INVALID_VALUE);
    COND_RETURN_ERROR_MSG_INNER((mdl != nullptr) && (mdl->GetModelType() == RT_MODEL_CAPTURE_MODEL),
        RT_ERROR_INVALID_VALUE,
        "capture model does not support create label, modelType=%d .", mdl->GetModelType());
    const rtError_t error = impl_->LabelCreate(lbl, mdl);
    ERROR_RETURN(error, "Label create failed.");
    RT_LOG(RT_LOG_DEBUG, "label create success, labelId = %hu", (*lbl)->Id_());
    return error;
}

rtError_t ApiErrorDecorator::LabelDestroy(Label * const lbl)
{
    NULL_PTR_RETURN_MSG_OUTER(lbl, RT_ERROR_INVALID_VALUE);

    const rtError_t error = impl_->LabelDestroy(lbl);
    ERROR_RETURN(error, "Label destroy failed.");
    return error;
}

rtError_t ApiErrorDecorator::LabelSet(Label * const lbl, Stream * const stm)
{
    Stream *curStm = Runtime::Instance()->GetCurStream(stm);
    NULL_PTR_RETURN_MSG_OUTER(lbl, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(curStm, RT_ERROR_INVALID_VALUE);
    const rtError_t error = impl_->LabelSet(lbl, curStm);
    ERROR_RETURN(error, "Set label failed.");
    return error;
}

rtError_t ApiErrorDecorator::LabelGoto(Label * const lbl, Stream * const stm)
{
    Stream *curStm = Runtime::Instance()->GetCurStream(stm);
    NULL_PTR_RETURN_MSG_OUTER(lbl, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(curStm, RT_ERROR_INVALID_VALUE);
    const rtError_t error = impl_->LabelSet(lbl, curStm);
    ERROR_RETURN(error, "Label goto failed.");
    return error;
}

rtError_t ApiErrorDecorator::SetExceptCallback(const rtErrorCallback callback)
{
    return impl_->SetExceptCallback(callback);
}

rtError_t ApiErrorDecorator::SetTaskAbortCallBack(const char *regName, void *callback, void *args,
    TaskAbortCallbackType type)
{
    NULL_PTR_RETURN_MSG_OUTER(regName, RT_ERROR_INVALID_VALUE);
    return impl_->SetTaskAbortCallBack(regName, callback, args, type);
}

rtError_t ApiErrorDecorator::RegDeviceStateCallback(const char_t *regName, void *callback, void *args,
    DeviceStateCallback type, rtDevCallBackDir_t notifyPos)
{
    NULL_PTR_RETURN_MSG_OUTER(regName, RT_ERROR_INVALID_VALUE);
    COND_RETURN_OUT_ERROR_MSG_CALL((type == DeviceStateCallback::RT_DEVICE_STATE_CALLBACK) &&
        ((notifyPos < DEV_CB_POS_FRONT) || (notifyPos >= DEV_CB_POS_END)), RT_ERROR_INVALID_VALUE, 
        "If parameter type equals %u, the range of parameter notifyPos should be [%d, %d).", 
        static_cast<uint32_t>(type), DEV_CB_POS_FRONT, DEV_CB_POS_END);
    return impl_->RegDeviceStateCallback(regName, callback, args, type, notifyPos);
}

rtError_t ApiErrorDecorator::RegProfCtrlCallback(const uint32_t moduleId, const rtProfCtrlHandle callback)
{
    return impl_->RegProfCtrlCallback(moduleId, callback);
}

rtError_t ApiErrorDecorator::GetL2CacheOffset(uint32_t deviceId, uint64_t *offset)
{
    COND_RETURN_ERROR((offset == nullptr), RT_ERROR_INVALID_VALUE, "offset is null");
    uint32_t realDeviceId = 0;
    rtError_t error = Runtime::Instance()->ChgUserDevIdToDeviceId(deviceId, &realDeviceId);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "input error devId:%u is error:%#x", deviceId, static_cast<uint32_t>(error));
    error = CheckDeviceIdIsValid(static_cast<int32_t>(realDeviceId));
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "drv devId is invalid, drv devId=%u, retCode=%#x", realDeviceId, static_cast<uint32_t>(error));

    error = impl_->GetL2CacheOffset(realDeviceId, offset);
    COND_RETURN_WARN(error == RT_ERROR_FEATURE_NOT_SUPPORT, RT_ERROR_FEATURE_NOT_SUPPORT,
        "Get L2Cache Offset fail deviceId=%u, drv devId=%u.", deviceId, realDeviceId);
    ERROR_RETURN(error, "get l2cache offset fail, deviceId=%u, drv devId=%u.", deviceId, realDeviceId);
    return error;
}

rtError_t ApiErrorDecorator::RegTaskFailCallbackByModule(const char_t *regName, void *callback, void *args,
    TaskFailCallbackType type)
{
    NULL_PTR_RETURN_MSG_OUTER(regName, RT_ERROR_INVALID_VALUE);

    return impl_->RegTaskFailCallbackByModule(regName, callback, args, type);
}

rtError_t ApiErrorDecorator::SubscribeReport(const uint64_t threadId, Stream * const stm)
{
    COND_RETURN_OUT_ERROR_MSG_CALL((stm != nullptr) && (stm->GetSubscribeFlag() == StreamSubscribeFlag::SUBSCRIBE_RUNTIME), RT_ERROR_SUBSCRIBE_STREAM,
        "The stream is in the host callback process and cannot call rtSubscribeReport. flag=SUBSCRIBE_RUNTIME, stream_id=%d", stm->Id_());
    return impl_->SubscribeReport(threadId, stm);
}

rtError_t ApiErrorDecorator::CallbackLaunch(const rtCallback_t callBackFunc, void * const fnData,
    Stream * const stm, const bool isBlock)
{
    NULL_PTR_RETURN_MSG_OUTER(callBackFunc, RT_ERROR_INVALID_VALUE);
    COND_RETURN_OUT_ERROR_MSG_CALL((stm != nullptr) && (stm->GetSubscribeFlag() == StreamSubscribeFlag::SUBSCRIBE_RUNTIME), RT_ERROR_SUBSCRIBE_STREAM,
        "The stream is in the host callback process and cannot call rtCallbackLaunch, flag=SUBSCRIBE_RUNTIME, stream_id=%d", stm->Id_());
    return impl_->CallbackLaunch(callBackFunc, fnData, stm, isBlock);
}

rtError_t ApiErrorDecorator::ProcessReport(const int32_t timeout, const bool noLog)
{
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM((timeout < -1) || (timeout == 0), RT_ERROR_INVALID_VALUE, 
        timeout, "-1 or (0, " + std::to_string(MAX_INT32_NUM) +  "]");

    return impl_->ProcessReport(timeout, noLog);
}

rtError_t ApiErrorDecorator::UnSubscribeReport(const uint64_t threadId, Stream * const stm)
{
    COND_RETURN_OUT_ERROR_MSG_CALL((stm != nullptr) && (stm->GetSubscribeFlag() == StreamSubscribeFlag::SUBSCRIBE_RUNTIME), RT_ERROR_SUBSCRIBE_STREAM,
        "The stream is in the host callback process and cannot call rtUnSubscribeReport, flag=SUBSCRIBE_RUNTIME, stream_id=%d", stm->Id_());
    return impl_->UnSubscribeReport(threadId, stm);
}

rtError_t ApiErrorDecorator::GetRunMode(rtRunMode * const runMode)
{
    NULL_PTR_RETURN_MSG_OUTER(runMode, RT_ERROR_INVALID_VALUE);

    return impl_->GetRunMode(runMode);
}

rtError_t ApiErrorDecorator::LabelSwitchByIndex(void * const ptr, const uint32_t maxVal, void * const labelInfoPtr,
    Stream * const stm)
{
    Stream *curStm = Runtime::Instance()->GetCurStream(stm);
    NULL_PTR_RETURN_MSG_OUTER(ptr, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(labelInfoPtr, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(curStm, RT_ERROR_INVALID_VALUE);

    return impl_->LabelSwitchByIndex(ptr, maxVal, labelInfoPtr, curStm);
}

rtError_t ApiErrorDecorator::LabelGotoEx(Label * const lbl, Stream * const stm)
{
    Stream *curStm = Runtime::Instance()->GetCurStream(stm);
    NULL_PTR_RETURN_MSG_OUTER(lbl, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(curStm, RT_ERROR_INVALID_VALUE);

    return impl_->LabelGotoEx(lbl, curStm);
}

rtError_t ApiErrorDecorator::LabelListCpy(Label ** const lbl, const uint32_t labelNumber, void * const dst,
    const uint32_t dstMax)
{
    NULL_PTR_RETURN_MSG_OUTER(lbl, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(dst, RT_ERROR_INVALID_VALUE);
    ZERO_RETURN_AND_MSG_OUTER(labelNumber);

    const uint64_t labelSize = sizeof(rtLabelDevInfo) * labelNumber;
    COND_RETURN_OUT_ERROR_MSG_CALL(labelSize != static_cast<uint64_t>(dstMax), RT_ERROR_INVALID_VALUE,
        "Parameter dstMax should equal to the product of parameter labelNumber and %zu. Parameter dstMax = %u, parameter labelNumber = %u.",
        sizeof(rtLabelDevInfo), dstMax, labelNumber);

    return impl_->LabelListCpy(lbl, labelNumber, dst, dstMax);
}

rtError_t ApiErrorDecorator::LabelCreateEx(Label ** const lbl, Model * const mdl, Stream * const stm)
{
    Stream *curStm = Runtime::Instance()->GetCurStream(stm);
    NULL_PTR_RETURN_MSG_OUTER(lbl, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(curStm, RT_ERROR_INVALID_VALUE);
    COND_RETURN_ERROR_MSG_INNER((mdl != nullptr) && (mdl->GetModelType() == RT_MODEL_CAPTURE_MODEL), RT_ERROR_INVALID_VALUE,
        "capture model does not support create label to stream, modelType=%d .", mdl->GetModelType());
    COND_RETURN_ERROR_MSG_INNER(curStm->IsCapturing(), RT_ERROR_STREAM_CAPTURED,
        "stream is in capture mode, stream_id=%d.", curStm->Id_());

    return impl_->LabelCreateEx(lbl, mdl, curStm);
}

rtError_t ApiErrorDecorator::LabelSwitchListCreate(Label ** const labels, const size_t num, void ** const labelList)
{
    NULL_PTR_RETURN_MSG_OUTER(labels, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(labelList, RT_ERROR_INVALID_VALUE);
	COND_RETURN_AND_MSG_OUTER_WITH_PARAM(((num == 0U) || (num > static_cast<size_t>(MAX_UINT16_NUM))), RT_ERROR_INVALID_VALUE, 
        num, "(0, " + std::to_string(MAX_UINT16_NUM) + "]");
    return impl_->LabelSwitchListCreate(labels, num, labelList);
}

rtError_t ApiErrorDecorator::GetAicpuDeploy(rtAicpuDeployType_t * const deployType)
{
    NULL_PTR_RETURN_MSG_OUTER(deployType, RT_ERROR_INVALID_VALUE);

    return impl_->GetAicpuDeploy(deployType);
}

rtError_t ApiErrorDecorator::GetPairDevicesInfo(const uint32_t devId, const uint32_t otherDevId, const int32_t infoType,
    int64_t * const val)
{
    NULL_PTR_RETURN_MSG_OUTER(val, RT_ERROR_INVALID_VALUE);
    uint32_t realDeviceId;
    rtError_t error = Runtime::Instance()->ChgUserDevIdToDeviceId(devId, &realDeviceId);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "input error devId:%u is err:%#x", devId, static_cast<uint32_t>(error));
    uint32_t readOtherDeviceId;
    error = Runtime::Instance()->ChgUserDevIdToDeviceId(otherDevId, &readOtherDeviceId);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "input error otherDevId:%u is err:%#x", otherDevId, static_cast<uint32_t>(error));
    return impl_->GetPairDevicesInfo(realDeviceId, readOtherDeviceId, infoType, val);
}

rtError_t ApiErrorDecorator::GetPairPhyDevicesInfo(const uint32_t devId, const uint32_t otherDevId, const int32_t infoType,
    int64_t * const val)
{
    NULL_PTR_RETURN_MSG_OUTER(val, RT_ERROR_INVALID_VALUE);
    RT_LOG(RT_LOG_INFO, "input physic devId=%u, input physic otherDevId=%u, infoType=%d", devId, otherDevId, infoType);
    return impl_->GetPairPhyDevicesInfo(devId, otherDevId, infoType, val);
}

rtError_t ApiErrorDecorator::GetRtCapability(const rtFeatureType_t featureType, const int32_t featureInfo,
    int64_t * const val)
{
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM(featureInfo < 0, RT_ERROR_INVALID_VALUE, featureInfo, "greater than or equal to 0");

    NULL_PTR_RETURN_MSG_OUTER(val, RT_ERROR_INVALID_VALUE);

    return impl_->GetRtCapability(featureType, featureInfo, val);
}

rtError_t GetModTaskUpIsSupport(int32_t * const val)
{
    const rtChipType_t chipType = Runtime::Instance()->GetChipType();
    *val = static_cast<int32_t>(RT_DEV_CAP_NOT_SUPPORT);
    if (!IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_MODEL_UPDATE_SQE_TILING_KEY)) {
        RT_LOG(RT_LOG_INFO, "chipType = %u", static_cast<uint32_t>(chipType));
        return RT_ERROR_NONE;
    }

    const bool isSupport = CheckSupportTilingKeyWhenCompile();
    if (isSupport) {
        *val = RT_DEV_CAP_SUPPORT;
    }

    RT_LOG(RT_LOG_INFO, "chipType = %u, *val=%d", static_cast<uint32_t>(chipType), *val);
    return RT_ERROR_NONE;
}

rtError_t ApiErrorDecorator::GetDeviceCapability(const int32_t deviceId,
                                                 const int32_t moduleType,
                                                 const int32_t featureType,
                                                 int32_t * const val)
{
    NULL_PTR_RETURN_MSG_OUTER(val, RT_ERROR_INVALID_VALUE);

    if ((featureType == static_cast<int32_t>(FEATURE_TYPE_MODEL_TASK_UPDATE)) &&
        (moduleType == static_cast<int32_t>(RT_MODULE_TYPE_TSCPU)) &&
        (deviceId == STUB_DEVICE_ID)) {
        // adapt to stub device，only consider Chip type
        return GetModTaskUpIsSupport(val);
    }
    int32_t realDeviceId;
    rtError_t error = Runtime::Instance()->ChgUserDevIdToDeviceId(static_cast<uint32_t>(deviceId),
        RtPtrToPtr<uint32_t *>(&realDeviceId));
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, RT_ERROR_DEVICE_ID,
        "input error deviceId:%d is err:%#x", deviceId, static_cast<uint32_t>(RT_ERROR_DEVICE_ID));
    error = CheckDeviceIdIsValid(realDeviceId);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "drv devId is invalid, drv devId=%d, retCode=%#x", realDeviceId, static_cast<uint32_t>(error));

    error = impl_->GetDeviceCapability(realDeviceId, moduleType, featureType, val);
    ERROR_RETURN(error, "Get device capability failed, deviceId=%d, moduleType=%d, featureType=%d.",
        deviceId, moduleType, featureType);
    return error;
}

rtError_t ApiErrorDecorator::GetFaultEvent(const int32_t deviceId, rtDmsEventFilter *filter,
    rtDmsFaultEvent *dmsEvent, uint32_t len, uint32_t *eventCount)
{
    COND_RETURN_ERROR((filter == nullptr), RT_ERROR_INVALID_VALUE, "input filter is null");
    Runtime * const rtInstance = Runtime::Instance();
    COND_RETURN_ERROR_MSG_INNER(rtInstance == nullptr, RT_ERROR_INSTANCE_NULL, "Runtime instance is null");
    const rtChipType_t chipType = rtInstance->GetChipType();
    if (!IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_DRIVER_GET_FAULT_EVENT)) {
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }
    int32_t realDeviceId = 0;
    rtError_t error = Runtime::Instance()->ChgUserDevIdToDeviceId(static_cast<uint32_t>(deviceId),
        RtPtrToPtr<uint32_t *>(&realDeviceId));
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "input error deviceId:%d is err:%#x", deviceId, static_cast<uint32_t>(error));
    error = CheckDeviceIdIsValid(realDeviceId);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "drv devId is invalid, drv devId=%d, retCode=%#x", realDeviceId, static_cast<uint32_t>(error));
    return impl_->GetFaultEvent(realDeviceId, filter, dmsEvent, len, eventCount);
}

rtError_t ApiErrorDecorator::GetMemUceInfo(const uint32_t deviceId, rtMemUceInfo *memUceInfo)
{
    COND_RETURN_ERROR((memUceInfo == nullptr), RT_ERROR_INVALID_VALUE, "input memUceInfo is null.");
    Runtime * const rtInstance = Runtime::Instance();
    COND_RETURN_ERROR_MSG_INNER(rtInstance == nullptr, RT_ERROR_INSTANCE_NULL, "Runtime instance is null.");
    const rtChipType_t chipType = rtInstance->GetChipType();
    if (!IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_DFX_FAST_RECOVER)) {
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }

    int32_t deviceCnt = 0;
    int32_t realDeviceId = 0;
    rtError_t error = rtInstance->ChgUserDevIdToDeviceId(static_cast<uint32_t>(deviceId),
        RtPtrToPtr<uint32_t *>(&realDeviceId));
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "input error deviceId:%u is error:%#x", deviceId, static_cast<uint32_t>(error));

    const driverType_t rawDrvType = rtInstance->GetDriverType();
    Driver * const rawDrv = rtInstance->driverFactory_.GetDriver(rawDrvType);
    error = rawDrv->GetDeviceCount(&deviceCnt);
    ERROR_RETURN_MSG_CALL(ERR_MODULE_DRV, error, "Get device cnt failed, retCode=%#x", static_cast<uint32_t>(error));
    COND_RETURN_OUT_ERROR_MSG_CALL(((realDeviceId < 0) || (realDeviceId >= deviceCnt)), RT_ERROR_DEVICE_ID,
        "invalid devId=%u, set drv devId=%d, valid drv devId range is [0, %d)", deviceId, realDeviceId, deviceCnt);

    error = impl_->GetMemUceInfo(static_cast<uint32_t>(realDeviceId), memUceInfo);
    ERROR_RETURN(error, "GetMemUceInfo failed");
    const uint32_t drvDeviceId = memUceInfo->devid;
    error = Runtime::Instance()->GetUserDevIdByDeviceId(drvDeviceId, &memUceInfo->devid);
    ERROR_RETURN_MSG_INNER(error, "Conv drvDeviceId:%u is error:%#x", drvDeviceId, static_cast<uint32_t>(error));
    return RT_ERROR_NONE;
}

rtError_t ApiErrorDecorator::MemUceRepair(const uint32_t deviceId, rtMemUceInfo *memUceInfo)
{
    COND_RETURN_ERROR((memUceInfo == nullptr), RT_ERROR_INVALID_VALUE, "input memUceInfo is null");
    Runtime * const rtInstance = Runtime::Instance();
    COND_RETURN_ERROR_MSG_INNER(rtInstance == nullptr, RT_ERROR_INSTANCE_NULL, "Runtime instance is null");
    const rtChipType_t chipType = rtInstance->GetChipType();
    if (!IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_DFX_FAST_RECOVER)) {
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }
    int32_t deviceCnt = 0;
    int32_t realDeviceId = 0;
    rtError_t error = Runtime::Instance()->ChgUserDevIdToDeviceId(static_cast<uint32_t>(deviceId),
        RtPtrToPtr<uint32_t *>(&realDeviceId));
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "input error deviceId:%u is error:%#x", deviceId, static_cast<uint32_t>(error));

    const driverType_t rawDrvType = rtInstance->GetDriverType();
    Driver * const rawDrv = rtInstance->driverFactory_.GetDriver(rawDrvType);
    error = rawDrv->GetDeviceCount(&deviceCnt);
    ERROR_RETURN_MSG_CALL(ERR_MODULE_DRV, error, "Get device cnt failed, retCode=%#x", static_cast<uint32_t>(error));
    COND_RETURN_OUT_ERROR_MSG_CALL(((realDeviceId < 0) || (realDeviceId >= deviceCnt)), RT_ERROR_DEVICE_ID,
        "invalid devId=%u, set drv devId=%d, valid device range is [0, %d)", deviceId, realDeviceId, deviceCnt);

    const uint32_t userDeviceId = memUceInfo->devid;
    error = Runtime::Instance()->ChgUserDevIdToDeviceId(userDeviceId, &memUceInfo->devid);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "input error deviceId:%u is error:%#x", userDeviceId, static_cast<uint32_t>(error));
    COND_RETURN_OUT_ERROR_MSG_CALL((memUceInfo->devid >= static_cast<uint32_t>(deviceCnt)), RT_ERROR_DEVICE_ID,
        "userDeviceId=%u, valid device range is [0, %d)", userDeviceId, deviceCnt);
    return impl_->MemUceRepair(realDeviceId, memUceInfo);
}

rtError_t ApiErrorDecorator::SetOpWaitTimeOut(const uint32_t timeout)
{
    const rtError_t error = impl_->SetOpWaitTimeOut(timeout);
    COND_RETURN_ERROR((error != RT_ERROR_NONE) && (error != RT_ERROR_FEATURE_NOT_SUPPORT),
        error, "Set op event wait timeout failed, timeout=%us", timeout);
    return error;
}

rtError_t ApiErrorDecorator::SetOpExecuteTimeOut(const uint32_t timeout, const RtTaskTimeUnitType timeUnitType)
{
    const rtError_t error = impl_->SetOpExecuteTimeOut(timeout, timeUnitType);
    ERROR_RETURN(error, "Set op execute timeout failed, timeout=%us.", timeout);
    return error;
}

rtError_t ApiErrorDecorator::GetOpExecuteTimeOut(uint32_t * const timeout)
{
    NULL_PTR_RETURN_MSG_OUTER(timeout, RT_ERROR_INVALID_VALUE);
    const rtError_t error = impl_->GetOpExecuteTimeOut(timeout);
    ERROR_RETURN(error, "Get op execute timeout failed, timeout=%us.", *timeout);
    return error;
}

rtError_t ApiErrorDecorator::GetOpExecuteTimeoutV2(uint32_t *const timeout)
{
    NULL_PTR_RETURN_MSG_OUTER(timeout, RT_ERROR_INVALID_VALUE);
    const rtError_t error = impl_->GetOpExecuteTimeoutV2(timeout);
    ERROR_RETURN(error, "Get op execute timeout failed.");
    return error;
}

rtError_t ApiErrorDecorator::CheckArchCompatibility(const char_t *omSocVersion, int32_t *canCompatible)
{
    NULL_PTR_RETURN_MSG_OUTER(omSocVersion, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(canCompatible, RT_ERROR_INVALID_VALUE);
    if (omSocVersion != nullptr && omSocVersion[0U] == '\0') {
        RT_LOG(RT_LOG_ERROR, "Input omSocVersion is null, please check.");
        return RT_ERROR_INVALID_VALUE;
    }
    const rtError_t error = impl_->CheckArchCompatibility(omSocVersion, canCompatible);
    ERROR_RETURN(error, "Check ArchType Compatibility failed, omSocVersion=%s.", omSocVersion);
    return error;
}

rtError_t ApiErrorDecorator::GetOpTimeOutInterval(uint64_t *interval)
{
    NULL_PTR_RETURN_MSG_OUTER(interval, RT_ERROR_INVALID_VALUE);
    return impl_->GetOpTimeOutInterval(interval);
}

rtError_t ApiErrorDecorator::SetOpExecuteTimeOutV2(uint64_t timeout, uint64_t *actualTimeout)
{
    NULL_PTR_RETURN_MSG_OUTER(actualTimeout, RT_ERROR_INVALID_VALUE);
    return impl_->SetOpExecuteTimeOutV2(timeout, actualTimeout);
}

rtError_t ApiErrorDecorator::SetGroup(const int32_t groupId)
{
    return impl_->SetGroup(groupId);
}

rtError_t ApiErrorDecorator::GetGroupCount(uint32_t * const cnt)
{
    NULL_PTR_RETURN_MSG_OUTER(cnt, RT_ERROR_INVALID_VALUE);

    return impl_->GetGroupCount(cnt);
}

rtError_t ApiErrorDecorator::GetGroupInfo(const int32_t groupId, rtGroupInfo_t * const groupInfo, const uint32_t cnt)
{
    NULL_PTR_RETURN_MSG_OUTER(groupInfo, RT_ERROR_INVALID_VALUE);

    return impl_->GetGroupInfo(groupId, groupInfo, cnt);
}

rtError_t ApiErrorDecorator::StarsTaskLaunch(const void * const sqe, const uint32_t sqeLen, Stream * const stm,
    const uint32_t flag)
{
    /* 1910b tiny not support dvpp accelerator */
    if (!stm->Device_()->GetDevProperties().isSupportDvppAccelerator) {
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }
    NULL_PTR_RETURN_MSG_OUTER(sqe, RT_ERROR_INVALID_VALUE);
    // StarsTaskLaunch only support RT_KERNEL_DEFAULT \ RT_KERNEL_DUMPFLAG \ RT_KERNEL_CMDLIST_NOT_FREE
    constexpr uint32_t permitFlag = (RT_KERNEL_DEFAULT | RT_KERNEL_DUMPFLAG | RT_KERNEL_CMDLIST_NOT_FREE);
    if ((flag & (~permitFlag)) != 0U) {
        RT_LOG(RT_LOG_ERROR, "unsupported flag : %u", flag);
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }

    const rtError_t error = impl_->StarsTaskLaunch(sqe, sqeLen, stm, flag);
    return error;
}

rtError_t ApiErrorDecorator::GetC2cCtrlAddr(uint64_t * const addr, uint32_t * const len)
{
    NULL_PTR_RETURN_MSG_OUTER(addr, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(len, RT_ERROR_INVALID_VALUE);

    const rtError_t error = impl_->GetC2cCtrlAddr(addr, len);
    ERROR_RETURN(error, "get c2c ctrl addr.");
    return error;
}

rtError_t ApiErrorDecorator::NpuGetFloatStatus(void * const outputAddrPtr, const uint64_t outputSize,
    const uint32_t checkMode, Stream * const stm)
{
    NULL_PTR_RETURN_MSG_OUTER(outputAddrPtr, RT_ERROR_INVALID_VALUE);
	COND_RETURN_AND_MSG_OUTER_WITH_PARAM(outputSize != OVERFLOW_OUTPUT_SIZE, RT_ERROR_INVALID_VALUE, 
        outputSize, std::to_string(OVERFLOW_OUTPUT_SIZE));

    return impl_->NpuGetFloatStatus(outputAddrPtr, outputSize, checkMode, stm);
}

rtError_t ApiErrorDecorator::NpuClearFloatStatus(const uint32_t checkMode, Stream * const stm)
{
    Stream *curStm = Runtime::Instance()->GetCurStream(stm);
    NULL_PTR_RETURN_MSG_OUTER(curStm, RT_ERROR_INVALID_VALUE);
    return impl_->NpuClearFloatStatus(checkMode, curStm);
}

rtError_t ApiErrorDecorator::NpuGetFloatDebugStatus(void * const outputAddrPtr, const uint64_t outputSize,
    const uint32_t checkMode, Stream * const stm)
{
    Stream *curStm = Runtime::Instance()->GetCurStream(stm);
    NULL_PTR_RETURN_MSG_OUTER(outputAddrPtr, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(curStm, RT_ERROR_INVALID_VALUE);

	COND_RETURN_AND_MSG_OUTER_WITH_PARAM(outputSize != OVERFLOW_OUTPUT_SIZE, RT_ERROR_INVALID_VALUE, 
        outputSize, std::to_string(OVERFLOW_OUTPUT_SIZE));

    return impl_->NpuGetFloatDebugStatus(outputAddrPtr, outputSize, checkMode, curStm);
}

rtError_t ApiErrorDecorator::NpuClearFloatDebugStatus(const uint32_t checkMode, Stream * const stm)
{
    Stream *curStm = Runtime::Instance()->GetCurStream(stm);
    NULL_PTR_RETURN_MSG_OUTER(curStm, RT_ERROR_INVALID_VALUE);
    return impl_->NpuClearFloatDebugStatus(checkMode, curStm);
}

rtError_t ApiErrorDecorator::GetDevMsg(const rtGetDevMsgType_t getMsgType, const rtGetMsgCallback callback)
{
    NULL_PTR_RETURN_MSG_OUTER(callback, RT_ERROR_INVALID_VALUE);
    const rtError_t error = impl_->GetDevMsg(getMsgType, callback);
    ERROR_RETURN(error, "GetDeviceMsg failed, getMsgType=%d.", static_cast<int32_t>(getMsgType));
    return error;
}

rtError_t ApiErrorDecorator::ContextSetINFMode(const bool infMode)
{
    return impl_->ContextSetINFMode(infMode);
}

rtError_t ApiErrorDecorator::MemQueueInitQS(const int32_t devId, const char_t * const grpName)
{
    int32_t realDeviceId;
    const rtError_t error = Runtime::Instance()->ChgUserDevIdToDeviceId(static_cast<uint32_t>(devId),
        RtPtrToPtr<uint32_t *>(&realDeviceId));
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "input error devId:%u is err:%#x", devId, static_cast<uint32_t>(error));
    return impl_->MemQueueInitQS(realDeviceId, grpName);
}

rtError_t ApiErrorDecorator::MemQueueInitFlowGw(const int32_t devId, const rtInitFlowGwInfo_t * const initInfo)
{
    NULL_PTR_RETURN_MSG_OUTER(initInfo, RT_ERROR_INVALID_VALUE);
    int32_t realDeviceId;
    const rtError_t error = Runtime::Instance()->ChgUserDevIdToDeviceId(static_cast<uint32_t>(devId),
        RtPtrToPtr<uint32_t *>(&realDeviceId));
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "input error devId:%u is err:%#x", devId, static_cast<uint32_t>(error));
    return impl_->MemQueueInitFlowGw(realDeviceId, initInfo);
}

static inline bool IsHostCpuDevId(const int32_t devId)
{
    return (devId == DEFAULT_HOSTCPU_USER_DEVICE_ID);
}

rtError_t ApiErrorDecorator::MemQueueCreate(const int32_t devId, const rtMemQueueAttr_t * const queAttr,
    uint32_t * const qid)
{
    NULL_PTR_RETURN_MSG_OUTER(queAttr, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(qid, RT_ERROR_INVALID_VALUE);
    int32_t realDeviceId = 0;
    if (IsHostCpuDevId(devId)) {
        realDeviceId = DEFAULT_HOSTCPU_LOGIC_DEVICE_ID;
    } else {
        const rtError_t error = Runtime::Instance()->ChgUserDevIdToDeviceId(static_cast<uint32_t>(devId),
            RtPtrToPtr<uint32_t *>(&realDeviceId));
        COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
            "input error devId:%d is err:%#x", devId, static_cast<uint32_t>(error));
    }
    return impl_->MemQueueCreate(realDeviceId, queAttr, qid);
}

rtError_t ApiErrorDecorator::MemQueueExport(const int32_t devId, const uint32_t qid, const int32_t peerDevId,
        const char * const shareName)
{
    NULL_PTR_RETURN_MSG_OUTER(shareName, RT_ERROR_INVALID_VALUE);
    const auto len = strnlen(shareName, SHARE_QUEUE_NAME_LEN);
	COND_RETURN_AND_MSG_OUTER_WITH_PARAM(len >= SHARE_QUEUE_NAME_LEN, RT_ERROR_INVALID_VALUE, 
        len, "less than " + std::to_string(SHARE_QUEUE_NAME_LEN));
	COND_RETURN_AND_MSG_OUTER_WITH_PARAM(IsHostCpuDevId(devId), RT_ERROR_INVALID_VALUE, 
        devId, "not equal to " + std::to_string(DEFAULT_HOSTCPU_USER_DEVICE_ID));
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM(IsHostCpuDevId(peerDevId), RT_ERROR_INVALID_VALUE, 
        peerDevId, "not equal to " + std::to_string(DEFAULT_HOSTCPU_USER_DEVICE_ID));
    COND_RETURN_OUT_ERROR_MSG_CALL(devId == peerDevId, RT_ERROR_INVALID_VALUE,
        "Parameter devId should not be equal to parameter peerDevId. Parameter devId = %d, parameter peerDevId = %d.",
        devId, peerDevId);   
    int32_t realDeviceId = 0;
    int32_t realPeerDeviceId = 0;
    rtError_t error = Runtime::Instance()->ChgUserDevIdToDeviceId(static_cast<uint32_t>(devId),
        RtPtrToPtr<uint32_t *>(&realDeviceId));
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "input error devId:%d is err:%#x", devId, static_cast<uint32_t>(error));    
    error = Runtime::Instance()->ChgUserDevIdToDeviceId(static_cast<uint32_t>(peerDevId),
        RtPtrToPtr<uint32_t *>(&realPeerDeviceId));
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "input error devId:%d is err:%#x", devId, static_cast<uint32_t>(error));    
    return impl_->MemQueueExport(realDeviceId, qid, realPeerDeviceId, shareName);
}

rtError_t ApiErrorDecorator::MemQueueUnExport(const int32_t devId, const uint32_t qid, const int32_t peerDevId,
        const char * const shareName)
{
    NULL_PTR_RETURN_MSG_OUTER(shareName, RT_ERROR_INVALID_VALUE);
    const auto len = strnlen(shareName, SHARE_QUEUE_NAME_LEN);
	COND_RETURN_AND_MSG_OUTER_WITH_PARAM(len >= SHARE_QUEUE_NAME_LEN, RT_ERROR_INVALID_VALUE, 
        len, "less than " + std::to_string(SHARE_QUEUE_NAME_LEN));
	COND_RETURN_AND_MSG_OUTER_WITH_PARAM(IsHostCpuDevId(devId), RT_ERROR_INVALID_VALUE, 
        devId, "not equal to " + std::to_string(DEFAULT_HOSTCPU_USER_DEVICE_ID));
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM(IsHostCpuDevId(peerDevId), RT_ERROR_INVALID_VALUE, 
        peerDevId, "not equal to " + std::to_string(DEFAULT_HOSTCPU_USER_DEVICE_ID));
    COND_RETURN_OUT_ERROR_MSG_CALL(devId == peerDevId, RT_ERROR_INVALID_VALUE,
        "Parameter devId should not be equal to parameter peerDevId. Parameter devId = %d, parameter peerDevId = %d.",
        devId, peerDevId);     
    int32_t realDeviceId = 0;
    int32_t realPeerDeviceId = 0;
    rtError_t error = Runtime::Instance()->ChgUserDevIdToDeviceId(static_cast<uint32_t>(devId),
        RtPtrToPtr<uint32_t *>(&realDeviceId));
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "input error devId:%d is err:%#x", devId, static_cast<uint32_t>(error));    
    error = Runtime::Instance()->ChgUserDevIdToDeviceId(static_cast<uint32_t>(peerDevId),
        RtPtrToPtr<uint32_t *>(&realPeerDeviceId));
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "input error devId:%d is err:%#x", devId, static_cast<uint32_t>(error));                     
    return impl_->MemQueueUnExport(realDeviceId, qid, realPeerDeviceId, shareName);
}

rtError_t ApiErrorDecorator::MemQueueImport(const int32_t devId, const int32_t peerDevId, const char * const shareName,
        uint32_t * const qid)
{
    NULL_PTR_RETURN_MSG_OUTER(shareName, RT_ERROR_INVALID_VALUE);
    const auto len = strnlen(shareName, SHARE_QUEUE_NAME_LEN);
	COND_RETURN_AND_MSG_OUTER_WITH_PARAM(len >= SHARE_QUEUE_NAME_LEN, RT_ERROR_INVALID_VALUE, 
        len, "less than " + std::to_string(SHARE_QUEUE_NAME_LEN));   
    NULL_PTR_RETURN_MSG_OUTER(qid, RT_ERROR_INVALID_VALUE);
	COND_RETURN_AND_MSG_OUTER_WITH_PARAM(IsHostCpuDevId(devId), RT_ERROR_INVALID_VALUE, 
        devId, "not equal to " + std::to_string(DEFAULT_HOSTCPU_USER_DEVICE_ID));
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM(IsHostCpuDevId(peerDevId), RT_ERROR_INVALID_VALUE, 
        peerDevId, "not equal to " + std::to_string(DEFAULT_HOSTCPU_USER_DEVICE_ID));  
    COND_RETURN_OUT_ERROR_MSG_CALL(devId == peerDevId, RT_ERROR_INVALID_VALUE,
        "Parameter devId should not be equal to parameter peerDevId. Parameter devId = %d, parameter peerDevId = %d.",
        devId, peerDevId);    
    int32_t realDeviceId = 0;
    int32_t realPeerDeviceId = 0;
    rtError_t error = Runtime::Instance()->ChgUserDevIdToDeviceId(static_cast<uint32_t>(devId),
        RtPtrToPtr<uint32_t *>(&realDeviceId));
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "input error devId:%d is err:%#x", devId, static_cast<uint32_t>(error));    
    error = Runtime::Instance()->ChgUserDevIdToDeviceId(static_cast<uint32_t>(peerDevId),
        RtPtrToPtr<uint32_t *>(&realPeerDeviceId));
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "input error peerDevId:%d is err:%#x", peerDevId, static_cast<uint32_t>(error));                     
    return impl_->MemQueueImport(realDeviceId, realPeerDeviceId, shareName, qid);
}

rtError_t ApiErrorDecorator::MemQueueUnImport(const int32_t devId, const uint32_t qid, const int32_t peerDevId, 
        const char * const shareName) 
{
    NULL_PTR_RETURN_MSG_OUTER(shareName, RT_ERROR_INVALID_VALUE);
    const auto len = strnlen(shareName, SHARE_QUEUE_NAME_LEN);
	COND_RETURN_AND_MSG_OUTER_WITH_PARAM(len >= SHARE_QUEUE_NAME_LEN, RT_ERROR_INVALID_VALUE, 
        len, "less than " + std::to_string(SHARE_QUEUE_NAME_LEN));
	COND_RETURN_AND_MSG_OUTER_WITH_PARAM(IsHostCpuDevId(devId), RT_ERROR_INVALID_VALUE, 
        devId, "not equal to " + std::to_string(DEFAULT_HOSTCPU_USER_DEVICE_ID));
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM(IsHostCpuDevId(peerDevId), RT_ERROR_INVALID_VALUE, 
        peerDevId, "not equal to " + std::to_string(DEFAULT_HOSTCPU_USER_DEVICE_ID));    
    COND_RETURN_OUT_ERROR_MSG_CALL(devId == peerDevId, RT_ERROR_INVALID_VALUE,
        "Parameter devId should not be equal to parameter peerDevId. Parameter devId = %d, parameter peerDevId = %d.",
        devId, peerDevId);    
    int32_t realDeviceId = 0;
    int32_t realPeerDeviceId = 0;
    rtError_t error = Runtime::Instance()->ChgUserDevIdToDeviceId(static_cast<uint32_t>(devId),
        RtPtrToPtr<uint32_t *>(&realDeviceId));
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "input error devId:%d is err:%#x", devId, static_cast<uint32_t>(error));    
    error = Runtime::Instance()->ChgUserDevIdToDeviceId(static_cast<uint32_t>(peerDevId),
        RtPtrToPtr<uint32_t *>(&realPeerDeviceId));
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "input error devId:%d is err:%#x", devId, static_cast<uint32_t>(error));                     
    return impl_->MemQueueUnImport(realDeviceId, qid, realPeerDeviceId, shareName);
}     

rtError_t ApiErrorDecorator::MemQueueSet(const int32_t devId, const rtMemQueueSetCmdType cmd,
    const rtMemQueueSetInputPara * const input)
{
    NULL_PTR_RETURN_MSG_OUTER(input, RT_ERROR_INVALID_VALUE);
    int32_t realDeviceId = 0;
    if (IsHostCpuDevId(devId)) {
        realDeviceId = DEFAULT_HOSTCPU_LOGIC_DEVICE_ID;
    } else {
        const rtError_t error = Runtime::Instance()->ChgUserDevIdToDeviceId(static_cast<uint32_t>(devId),
            RtPtrToPtr<uint32_t *>(&realDeviceId));
        COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
            "input error devId:%d is err:%#x", devId, static_cast<uint32_t>(error));
    }
    return impl_->MemQueueSet(realDeviceId, cmd, input);
}

rtError_t ApiErrorDecorator::MemQueueDestroy(const int32_t devId, const uint32_t qid)
{
    int32_t realDeviceId = 0;
    if (IsHostCpuDevId(devId)) {
        realDeviceId = DEFAULT_HOSTCPU_LOGIC_DEVICE_ID;
    } else {
        const rtError_t error = Runtime::Instance()->ChgUserDevIdToDeviceId(static_cast<uint32_t>(devId),
            RtPtrToPtr<uint32_t *>(&realDeviceId));
        COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
            "input error devId:%d is err:%#x", devId, static_cast<uint32_t>(error));
    }
    return impl_->MemQueueDestroy(realDeviceId, qid);
}

rtError_t ApiErrorDecorator::MemQueueInit(const int32_t devId)
{
    int32_t realDeviceId = 0;
    if (IsHostCpuDevId(devId)) {
        realDeviceId = DEFAULT_HOSTCPU_LOGIC_DEVICE_ID;
    } else {
        const rtError_t error = Runtime::Instance()->ChgUserDevIdToDeviceId(static_cast<uint32_t>(devId),
            RtPtrToPtr<uint32_t *>(&realDeviceId));
        COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
            "input error devId:%d is err:%#x", devId, static_cast<uint32_t>(error));
    }
    return impl_->MemQueueInit(realDeviceId);
}

rtError_t ApiErrorDecorator::MemQueueReset(const int32_t devId, const uint32_t qid)
{
    int32_t realDeviceId = 0;
    if (IsHostCpuDevId(devId)) {
        realDeviceId = DEFAULT_HOSTCPU_LOGIC_DEVICE_ID;
    } else {
        const rtError_t error = Runtime::Instance()->ChgUserDevIdToDeviceId(static_cast<uint32_t>(devId),
            RtPtrToPtr<uint32_t *>(&realDeviceId));
        COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
            "input error devId:%d is err:%#x", devId, static_cast<uint32_t>(error));
    }
    return impl_->MemQueueReset(realDeviceId, qid);
}

rtError_t ApiErrorDecorator::MemQueueEnQueue(const int32_t devId, const uint32_t qid, void * const enQBuf)
{
    NULL_PTR_RETURN_MSG_OUTER(enQBuf, RT_ERROR_INVALID_VALUE);
    int32_t realDeviceId = 0;
    if (IsHostCpuDevId(devId)) {
        realDeviceId = DEFAULT_HOSTCPU_LOGIC_DEVICE_ID;
    } else {
        const rtError_t error = Runtime::Instance()->ChgUserDevIdToDeviceId(static_cast<uint32_t>(devId),
            RtPtrToPtr<uint32_t *>(&realDeviceId));
        COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
            "input error devId:%d is err:%#x", devId, static_cast<uint32_t>(error));
    }
    return impl_->MemQueueEnQueue(realDeviceId, qid, enQBuf);
}

rtError_t ApiErrorDecorator::MemQueueDeQueue(const int32_t devId, const uint32_t qid, void ** const deQBuf)
{
    NULL_PTR_RETURN_MSG_OUTER(deQBuf, RT_ERROR_INVALID_VALUE);
    int32_t realDeviceId = 0;
    if (IsHostCpuDevId(devId)) {
        realDeviceId = DEFAULT_HOSTCPU_LOGIC_DEVICE_ID;
    } else {
        const rtError_t error = Runtime::Instance()->ChgUserDevIdToDeviceId(static_cast<uint32_t>(devId),
            RtPtrToPtr<uint32_t *>(&realDeviceId));
        COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
            "input error devId:%d is err:%#x", devId, static_cast<uint32_t>(error));
    }
    return impl_->MemQueueDeQueue(realDeviceId, qid, deQBuf);
}

rtError_t ApiErrorDecorator::MemQueuePeek(const int32_t devId, const uint32_t qid, size_t * const bufLen,
    const int32_t timeout)
{
    NULL_PTR_RETURN_MSG_OUTER(bufLen, RT_ERROR_INVALID_VALUE);
    int32_t realDeviceId = 0;
    if (IsHostCpuDevId(devId)) {
        realDeviceId = DEFAULT_HOSTCPU_LOGIC_DEVICE_ID;
    } else {
        const rtError_t error = Runtime::Instance()->ChgUserDevIdToDeviceId(static_cast<uint32_t>(devId),
            RtPtrToPtr<uint32_t *>(&realDeviceId));
        COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
            "input error devId:%d is err:%#x", devId, static_cast<uint32_t>(error));
    }
    return impl_->MemQueuePeek(realDeviceId, qid, bufLen, timeout);
}

rtError_t ApiErrorDecorator::MemQueueQueryInfo(const int32_t devId, const uint32_t qid,
    rtMemQueueInfo_t * const queryQueueInfo)
{
    NULL_PTR_RETURN_MSG_OUTER(queryQueueInfo, RT_ERROR_INVALID_VALUE);
    int32_t realDeviceId = 0;
    if (IsHostCpuDevId(devId)) {
        realDeviceId = DEFAULT_HOSTCPU_LOGIC_DEVICE_ID;
    } else {
        const rtError_t error = Runtime::Instance()->ChgUserDevIdToDeviceId(static_cast<uint32_t>(devId),
            RtPtrToPtr<uint32_t *>(&realDeviceId));
        COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
            "input error devId:%d is err:%#x", devId, static_cast<uint32_t>(error));
    }
    return impl_->MemQueueQueryInfo(realDeviceId, qid, queryQueueInfo);
}

rtError_t ApiErrorDecorator::MemQueueQuery(const int32_t devId, const rtMemQueueQueryCmd_t cmd,
    const void * const inBuff, const uint32_t inLen, void * const outBuff, uint32_t * const outLen)
{
    NULL_PTR_RETURN_MSG_OUTER(inBuff, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(outBuff, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(outLen, RT_ERROR_INVALID_VALUE);
    int32_t realDeviceId = 0;
    if (IsHostCpuDevId(devId)) {
        realDeviceId = DEFAULT_HOSTCPU_LOGIC_DEVICE_ID;
    } else {
        const rtError_t error = Runtime::Instance()->ChgUserDevIdToDeviceId(static_cast<uint32_t>(devId),
            RtPtrToPtr<uint32_t *>(&realDeviceId));
        COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
            "input error devId:%d is err:%#x", devId, static_cast<uint32_t>(error));
    }
    return impl_->MemQueueQuery(realDeviceId, cmd, inBuff, inLen, outBuff, outLen);
}

rtError_t ApiErrorDecorator::MemQueueGrant(const int32_t devId, const uint32_t qid, const int32_t pid,
    rtMemQueueShareAttr_t * const attr)
{
    NULL_PTR_RETURN_MSG_OUTER(attr, RT_ERROR_INVALID_VALUE);
    int32_t realDeviceId = 0;
    if (IsHostCpuDevId(devId)) {
        realDeviceId = DEFAULT_HOSTCPU_LOGIC_DEVICE_ID;
    } else {
        const rtError_t error = Runtime::Instance()->ChgUserDevIdToDeviceId(static_cast<uint32_t>(devId),
            reinterpret_cast<uint32_t *>(&realDeviceId));
        COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
            "input error devId:%d is err:%#x", devId, static_cast<uint32_t>(error));
    }
    return impl_->MemQueueGrant(realDeviceId, qid, pid, attr);
}

rtError_t ApiErrorDecorator::MemQueueAttach(const int32_t devId, const uint32_t qid, const int32_t timeOut)
{
    int32_t realDeviceId = 0;
    if (IsHostCpuDevId(devId)) {
        realDeviceId = DEFAULT_HOSTCPU_LOGIC_DEVICE_ID;
    } else {
        const rtError_t error = Runtime::Instance()->ChgUserDevIdToDeviceId(static_cast<uint32_t>(devId),
            RtPtrToPtr<uint32_t *>(&realDeviceId));
        COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
            "input error devId:%d is err:%#x", devId, static_cast<uint32_t>(error));
    }
    return impl_->MemQueueAttach(realDeviceId, qid, timeOut);
}

rtError_t ApiErrorDecorator::EschedSubmitEventSync(const int32_t devId, rtEschedEventSummary_t * const evt,
    rtEschedEventReply_t * const ack)
{
    NULL_PTR_RETURN_MSG_OUTER(evt, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(ack, RT_ERROR_INVALID_VALUE);
	COND_RETURN_AND_MSG_OUTER_WITH_PARAM(
        ((evt->eventId != RT_MQ_SCHED_EVENT_QS_MSG) && (evt->eventId != RT_MQ_SCHED_EVENT_DRV_CUSTOM_MSG)),
        RT_ERROR_FEATURE_NOT_SUPPORT, evt->eventId, std::to_string(RT_MQ_SCHED_EVENT_QS_MSG) 
        + " or " + std::to_string(RT_MQ_SCHED_EVENT_DRV_CUSTOM_MSG));    
    int32_t realDeviceId = 0;
    if (IsHostCpuDevId(devId)) {
        realDeviceId = DEFAULT_HOSTCPU_LOGIC_DEVICE_ID;
    } else {
        const rtError_t error = Runtime::Instance()->ChgUserDevIdToDeviceId(static_cast<uint32_t>(devId),
            RtPtrToPtr<uint32_t *>(&realDeviceId));
        COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
            "input error devId:%d is err:%#x", devId, static_cast<uint32_t>(error));
    }
    return impl_->EschedSubmitEventSync(realDeviceId, evt, ack);
}

rtError_t ApiErrorDecorator::MemQueueEnQueueBuff(const int32_t devId, const uint32_t qid,
    rtMemQueueBuff_t * const inBuf, const int32_t timeout)
{
    NULL_PTR_RETURN_MSG_OUTER(inBuf, RT_ERROR_INVALID_VALUE);
    COND_RETURN_OUT_ERROR_MSG_CALL((inBuf->buffCount > 0U) && (inBuf->buffInfo == nullptr),
        RT_ERROR_INVALID_VALUE, "buff count=%u, but buff address is null, devId=%d, qid=%u",
        inBuf->buffCount, devId, qid);
    int32_t realDeviceId = 0;
    if (IsHostCpuDevId(devId)) {
        realDeviceId = DEFAULT_HOSTCPU_LOGIC_DEVICE_ID;
    } else {
        const rtError_t error = Runtime::Instance()->ChgUserDevIdToDeviceId(static_cast<uint32_t>(devId),
            RtPtrToPtr<uint32_t *>(&realDeviceId));
        COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
            "input error devId:%d is err:%#x", devId, static_cast<uint32_t>(error));
    }
    return impl_->MemQueueEnQueueBuff(realDeviceId, qid, inBuf, timeout);
}

rtError_t ApiErrorDecorator::MemQueueDeQueueBuff(const int32_t devId, const uint32_t qid,
    rtMemQueueBuff_t * const outBuf, const int32_t timeout)
{
    NULL_PTR_RETURN_MSG_OUTER(outBuf, RT_ERROR_INVALID_VALUE);
    COND_RETURN_OUT_ERROR_MSG_CALL((outBuf->buffCount > 0U) && (outBuf->buffInfo == nullptr),
        RT_ERROR_INVALID_VALUE, "buff count=%u, but buff address is null, devId=%d, qid=%u",
        outBuf->buffCount, devId, qid);
    int32_t realDeviceId = 0;
    if (IsHostCpuDevId(devId)) {
        realDeviceId = DEFAULT_HOSTCPU_LOGIC_DEVICE_ID;
    } else {
        const rtError_t error = Runtime::Instance()->ChgUserDevIdToDeviceId(static_cast<uint32_t>(devId),
            RtPtrToPtr<uint32_t *>(&realDeviceId));
        COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
            "input error devId:%d is err:%#x", devId, static_cast<uint32_t>(error));
    }
    return impl_->MemQueueDeQueueBuff(realDeviceId, qid, outBuf, timeout);
}

rtError_t ApiErrorDecorator::QueueSubF2NFEvent(const int32_t devId, const uint32_t qId, const uint32_t groupId)
{
    int32_t realDeviceId = devId;
    if (IsHostCpuDevId(devId)) {
        realDeviceId = DEFAULT_HOSTCPU_LOGIC_DEVICE_ID;
    } else {
        rtError_t error = Runtime::Instance()->ChgUserDevIdToDeviceId(static_cast<uint32_t>(devId),
        RtPtrToPtr<uint32_t *>(&realDeviceId));
        COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, RT_ERROR_DEVICE_ID,
            "input error devId:%d is err:%#x", devId, static_cast<uint32_t>(RT_ERROR_DEVICE_ID));
        error = CheckDeviceIdIsValid(realDeviceId);
        COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
            "Device id is invalid, deviceId=%d, retCode=%#x", devId, static_cast<uint32_t>(error));
    }
    return impl_->QueueSubF2NFEvent(realDeviceId, qId, groupId);
}

rtError_t ApiErrorDecorator::QueueSubscribe(const int32_t devId, const uint32_t qId, const uint32_t groupId,
    const int32_t type)
{
    int32_t realDeviceId = devId;
    if (IsHostCpuDevId(devId)) {
        realDeviceId = DEFAULT_HOSTCPU_LOGIC_DEVICE_ID;
    } else {
        rtError_t error = Runtime::Instance()->ChgUserDevIdToDeviceId(static_cast<uint32_t>(devId),
        RtPtrToPtr<uint32_t *>(&realDeviceId));
        COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, RT_ERROR_DEVICE_ID,
            "input error devId:%d is err:%#x", devId, static_cast<uint32_t>(RT_ERROR_DEVICE_ID));
        error = CheckDeviceIdIsValid(realDeviceId);
        COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
            "Device id is invalid, deviceId=%d, retCode=%#x", devId, static_cast<uint32_t>(error));
    }

    return impl_->QueueSubscribe(realDeviceId, qId, groupId, type);
}

rtError_t ApiErrorDecorator::BufEventTrigger(const char_t * const name)
{
    NULL_PTR_RETURN_MSG_OUTER(name, RT_ERROR_INVALID_VALUE);
    return impl_->BufEventTrigger(name);
}

rtError_t ApiErrorDecorator::QueryDevPid(rtBindHostpidInfo_t * const info, int32_t * const devPid)
{
    NULL_PTR_RETURN_MSG_OUTER(info, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(devPid, RT_ERROR_INVALID_VALUE);

    uint32_t realDeviceId = 0U;
    const rtError_t error = Runtime::Instance()->ChgUserDevIdToDeviceId(info->chipId, &realDeviceId);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, "input error devId:%u, err:%#x", info->chipId, static_cast<uint32_t>(error));
    info->chipId = realDeviceId;
    return impl_->QueryDevPid(info, devPid);
}

rtError_t ApiErrorDecorator::BuffAlloc(const uint64_t size, void **buff)
{
    ZERO_RETURN_AND_MSG_OUTER(size);
    return impl_->BuffAlloc(size, buff);
}

rtError_t ApiErrorDecorator::BuffConfirm(void * const buff, const uint64_t size)
{
    NULL_PTR_RETURN_MSG_OUTER(buff, RT_ERROR_INVALID_VALUE);
    return impl_->BuffConfirm(buff, size);
}

rtError_t ApiErrorDecorator::BuffFree(void * const buff)
{
    NULL_PTR_RETURN_MSG_OUTER(buff, RT_ERROR_INVALID_VALUE);
    return impl_->BuffFree(buff);
}

rtError_t ApiErrorDecorator::MemGrpCreate(const char_t * const name, const rtMemGrpConfig_t * const cfg)
{
    NULL_PTR_RETURN_MSG_OUTER(name, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(cfg, RT_ERROR_INVALID_VALUE);
    return impl_->MemGrpCreate(name, cfg);
}

rtError_t ApiErrorDecorator::BuffGetInfo(const rtBuffGetCmdType type, const void * const inBuff, const uint32_t inLen,
    void * const outBuff, uint32_t * const outLen)
{
    NULL_PTR_RETURN_MSG_OUTER(inBuff, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(outBuff, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(outLen, RT_ERROR_INVALID_VALUE);
    return impl_->BuffGetInfo(type, inBuff, inLen, outBuff, outLen);
}

rtError_t ApiErrorDecorator::MemGrpCacheAlloc(const char_t *const name, const int32_t devId,
    const rtMemGrpCacheAllocPara *const para)
{
    NULL_PTR_RETURN_MSG_OUTER(name, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(para, RT_ERROR_INVALID_VALUE);
    int32_t realDeviceId;
    if (IsHostCpuDevId(devId)) {
        realDeviceId = DEFAULT_HOSTCPU_LOGIC_DEVICE_ID;
    } else {
        const rtError_t error = Runtime::Instance()->ChgUserDevIdToDeviceId(static_cast<uint32_t>(devId),
            RtPtrToPtr<uint32_t *>(&realDeviceId));
        COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
            "input error devId:%u is err:%#x", devId, static_cast<uint32_t>(error));
    }
    return impl_->MemGrpCacheAlloc(name, realDeviceId, para);
}

rtError_t ApiErrorDecorator::MemGrpAddProc(const char_t * const name, const int32_t pid,
    const rtMemGrpShareAttr_t * const attr)
{
    NULL_PTR_RETURN_MSG_OUTER(name, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(attr, RT_ERROR_INVALID_VALUE);
    return impl_->MemGrpAddProc(name, pid, attr);
}

rtError_t ApiErrorDecorator::MemGrpAttach(const char_t * const name, const int32_t timeout)
{
    NULL_PTR_RETURN_MSG_OUTER(name, RT_ERROR_INVALID_VALUE);
    return impl_->MemGrpAttach(name, timeout);
}

rtError_t ApiErrorDecorator::MemGrpQuery(rtMemGrpQueryInput_t * const input, rtMemGrpQueryOutput_t * const output)
{
    NULL_PTR_RETURN_MSG_OUTER(input, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(output, RT_ERROR_INVALID_VALUE);
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM(
        ((input->cmd <= RT_MEM_GRP_QUERY_GROUP) || (input->cmd >= RT_MEM_GRP_QUERY_CMD_MAX)), RT_ERROR_FEATURE_NOT_SUPPORT, 
        input->cmd, "(" + std::to_string(RT_MEM_GRP_QUERY_GROUP) + ", " + std::to_string(RT_MEM_GRP_QUERY_CMD_MAX) + ")");
    if (input->cmd == GRP_QUERY_GROUP_ADDR_INFO) {
        uint32_t realDeviceId = 0U;
        const uint32_t userDeviceId = input->grpQueryGroupAddrPara.devId;
        if (IsHostCpuDevId(static_cast<int32_t>(userDeviceId))) {
            realDeviceId = static_cast<uint32_t>(DEFAULT_HOSTCPU_LOGIC_DEVICE_ID);
        } else {
            rtError_t error = Runtime::Instance()->ChgUserDevIdToDeviceId(userDeviceId, &realDeviceId);
            COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
                "input error devId:%u is err:%#x", userDeviceId, static_cast<uint32_t>(error));
            error = CheckDeviceIdIsValid(static_cast<int32_t>(realDeviceId));
            COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
                "drv devId is invalid, drv devId=%u, retCode=%#x", realDeviceId, static_cast<uint32_t>(error));
        }
        input->grpQueryGroupAddrPara.devId = realDeviceId;
    }
    return impl_->MemGrpQuery(input, output);
}

rtError_t ApiErrorDecorator::MemQueueGetQidByName(const int32_t devId, const char_t * const name, uint32_t * const qId)
{
    NULL_PTR_RETURN_MSG_OUTER(name, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(qId, RT_ERROR_INVALID_VALUE);
    int32_t realDeviceId = 0;
    if (IsHostCpuDevId(devId)) {
        realDeviceId = DEFAULT_HOSTCPU_LOGIC_DEVICE_ID;
    } else {
        const rtError_t error = Runtime::Instance()->ChgUserDevIdToDeviceId(static_cast<uint32_t>(devId),
            RtPtrToPtr<uint32_t *>(&realDeviceId));
        COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
            "input error devId:%d is err:%#x", devId, static_cast<uint32_t>(error));
    }
    return impl_->MemQueueGetQidByName(realDeviceId, name, qId);
}

rtError_t ApiErrorDecorator::EschedAttachDevice(const uint32_t devId)
{
    uint32_t realDeviceId = 0U;
    /* HostCPU场景下, 底软三件套(Mbuff/队列调度/事件调度)接口无需对DeviceID做转换 */
    if (IsHostCpuDevId(static_cast<int32_t>(devId))) {
        realDeviceId = static_cast<uint32_t>(DEFAULT_HOSTCPU_LOGIC_DEVICE_ID);
    } else {
        const rtError_t error = Runtime::Instance()->ChgUserDevIdToDeviceId(devId, &realDeviceId);
        COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
            "input error devId:%u is err:%#x", devId, static_cast<uint32_t>(error));
    }
    return impl_->EschedAttachDevice(realDeviceId);
}

rtError_t ApiErrorDecorator::EschedDettachDevice(const uint32_t devId)
{
    uint32_t realDeviceId = 0U;
    if (IsHostCpuDevId(static_cast<int32_t>(devId))) {
        realDeviceId = static_cast<uint32_t>(DEFAULT_HOSTCPU_LOGIC_DEVICE_ID);
    } else {
        const rtError_t error = Runtime::Instance()->ChgUserDevIdToDeviceId(devId, &realDeviceId);
        COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
            "input error devId:%u is err:%#x", devId, static_cast<uint32_t>(error));
    }
    return impl_->EschedDettachDevice(realDeviceId);
}

rtError_t ApiErrorDecorator::EschedWaitEvent(const int32_t devId, const uint32_t grpId, const uint32_t threadId,
    const int32_t timeout, rtEschedEventSummary_t * const evt)
{
    NULL_PTR_RETURN_MSG_OUTER(evt, RT_ERROR_INVALID_VALUE);
    int32_t realDeviceId = 0;
    if (IsHostCpuDevId(devId)) {
        realDeviceId = DEFAULT_HOSTCPU_LOGIC_DEVICE_ID;
    } else {
        const rtError_t error = Runtime::Instance()->ChgUserDevIdToDeviceId(static_cast<uint32_t>(devId),
            RtPtrToPtr<uint32_t *>(&realDeviceId));
        COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
            "input error devId:%d is err:%#x", devId, static_cast<uint32_t>(error));
    }
    return impl_->EschedWaitEvent(realDeviceId, grpId, threadId, timeout, evt);
}

rtError_t ApiErrorDecorator::EschedCreateGrp(const int32_t devId, const uint32_t grpId, const rtGroupType_t type)
{
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM(
        (type < RT_GRP_TYPE_BIND_DP_CPU) || (type > RT_GRP_TYPE_BIND_DP_CPU_EXCLUSIVE), RT_ERROR_INVALID_VALUE, 
        type, "[" + std::to_string(RT_GRP_TYPE_BIND_DP_CPU) + ", " + std::to_string(RT_GRP_TYPE_BIND_DP_CPU_EXCLUSIVE) + "]");    

    int32_t realDeviceId = 0;
    if (IsHostCpuDevId(devId)) {
        realDeviceId = DEFAULT_HOSTCPU_LOGIC_DEVICE_ID;
    } else {
        const rtError_t error = Runtime::Instance()->ChgUserDevIdToDeviceId(static_cast<uint32_t>(devId),
            RtPtrToPtr<uint32_t *>(&realDeviceId));
        COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
            "input error devId:%d is err:%#x", devId, static_cast<uint32_t>(error));
    }
    return impl_->EschedCreateGrp(realDeviceId, grpId, type);
}

rtError_t ApiErrorDecorator::EschedSubmitEvent(const int32_t devId, rtEschedEventSummary_t * const evt)
{
    NULL_PTR_RETURN_MSG_OUTER(evt, RT_ERROR_INVALID_VALUE);
    int32_t realDeviceId = 0;
    if (IsHostCpuDevId(devId)) {
        realDeviceId = DEFAULT_HOSTCPU_LOGIC_DEVICE_ID;
    } else {
        const rtError_t error = Runtime::Instance()->ChgUserDevIdToDeviceId(static_cast<uint32_t>(devId),
            RtPtrToPtr<uint32_t *>(&realDeviceId));
        COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
            "input error devId:%d is err:%#x", devId, static_cast<uint32_t>(error));
    }
    return impl_->EschedSubmitEvent(realDeviceId, evt);
}

rtError_t ApiErrorDecorator::EschedSubscribeEvent(const int32_t devId, const uint32_t grpId,
    const uint32_t threadId, const uint64_t eventBitmap)
{
    int32_t realDeviceId = 0;
    if (IsHostCpuDevId(devId)) {
        realDeviceId = DEFAULT_HOSTCPU_LOGIC_DEVICE_ID;
    } else {
        const rtError_t error = Runtime::Instance()->ChgUserDevIdToDeviceId(static_cast<uint32_t>(devId),
            reinterpret_cast<uint32_t *>(&realDeviceId));
        COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
            "input error devId:%d is err:%#x", devId, static_cast<uint32_t>(error));
    }
    return impl_->EschedSubscribeEvent(realDeviceId, grpId, threadId, eventBitmap);
}

rtError_t ApiErrorDecorator::EschedAckEvent(const int32_t devId, const rtEventIdType_t evtId,
    const uint32_t subeventId, char_t * const msg, const uint32_t len)
{
    NULL_PTR_RETURN_MSG_OUTER(msg, RT_ERROR_INVALID_VALUE);
    int32_t realDeviceId = 0;
    if (IsHostCpuDevId(devId)) {
        realDeviceId = DEFAULT_HOSTCPU_LOGIC_DEVICE_ID;
    } else {
        const rtError_t error = Runtime::Instance()->ChgUserDevIdToDeviceId(static_cast<uint32_t>(devId),
            RtPtrToPtr<uint32_t *>(&realDeviceId));
        COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
            "input error devId:%d is err:%#x", devId, static_cast<uint32_t>(error));
    }
    return impl_->EschedAckEvent(realDeviceId, evtId, subeventId, msg, len);
}

rtError_t ApiErrorDecorator::CheckDeviceIdIsValid(const int32_t devId) const
{
    int32_t devCnt;
    Runtime * const rt = Runtime::Instance();
    Driver * const npuDrv = rt->driverFactory_.GetDriver(NPU_DRIVER);
    NULL_PTR_RETURN_MSG(npuDrv, RT_ERROR_DRV_NULL);
    const rtError_t error = npuDrv->GetDeviceCount(&devCnt);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, "Get device cnt failed, retCode=%#x", static_cast<uint32_t>(error));
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM((devId < 0) || ((devId >= devCnt) && (devCnt != 0)), RT_ERROR_DEVICE_ID, 
        devId, "[0, " + std::to_string(devCnt) + ")");    
    return RT_ERROR_NONE;
}

rtError_t ApiErrorDecorator::CmoTaskLaunch(const rtCmoTaskInfo_t * const taskInfo, Stream * const stm,
    const uint32_t flag)
{
    NULL_PTR_RETURN_MSG_OUTER(taskInfo, RT_ERROR_INVALID_VALUE);
    const rtChipType_t chipType = Runtime::Instance()->GetChipType();
    const rtCmoOpCode_t opCode = static_cast<rtCmoOpCode_t>(taskInfo->opCode);
    if (IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_TASK_CMO)) {
        COND_RETURN_ERROR_MSG_INNER(((opCode < RT_CMO_PREFETCH) || (opCode >= RT_CMO_RESERVED)), RT_ERROR_INVALID_VALUE,
            "Invalid opCode, the valid value range is [RT_CMO_PREFETCH, RT_CMO_RESERVED), current opCode=%u",
            taskInfo->opCode);
    }
    const rtError_t error = impl_->CmoTaskLaunch(taskInfo, stm, flag);
    COND_RETURN_ERROR(((error != RT_ERROR_NONE) && (error != RT_ERROR_FEATURE_NOT_SUPPORT)),
        error, "Cmo Task launch failed.");
    return error;
}

rtError_t ApiErrorDecorator::CmoAddrTaskLaunch(void *cmoAddrInfo, const uint64_t destMax,
    const rtCmoOpCode_t cmoOpCode, Stream * const stm, const uint32_t flag)
{
    NULL_PTR_RETURN_MSG_OUTER(cmoAddrInfo, RT_ERROR_INVALID_VALUE);
    COND_RETURN_ERROR_MSG_INNER(
        ((cmoOpCode < RT_CMO_PREFETCH) || (cmoOpCode >= RT_CMO_RESERVED)), RT_ERROR_INVALID_VALUE,
        "Invalid cmoOpCode, the valid value range is [RT_CMO_PREFETCH, RT_CMO_RESERVED), current cmoOpCode=%u",
        static_cast<uint8_t>(cmoOpCode));
    rtChipType_t chipType = Runtime::Instance()->GetChipType();
    DevProperties devProperty {};
    rtError_t error = GET_DEV_PROPERTIES(chipType, devProperty);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, RT_ERROR_DRV_INVALID_DEVICE,
        "Failed to get dev properties, chipType = %u", chipType);
    const uint64_t sizeMax = (devProperty.cmoAddrInfoType == CmoAddrInfoType::CMO_ADDR_INFO_TYPE_DAVID) ?
        sizeof(rtDavidCmoAddrInfo) : sizeof(rtCmoAddrInfo);
    COND_RETURN_ERROR_MSG_INNER(((destMax == 0) || (destMax > sizeMax)), RT_ERROR_INVALID_VALUE,
        "Invalid destMax, current destMax size = %" PRIu64 "(bytes). The valid value range is (0, %" PRIu64 "]",
        destMax, sizeMax);

    error = impl_->CmoAddrTaskLaunch(cmoAddrInfo, destMax, cmoOpCode, stm, flag);
    ERROR_RETURN(error, "CmoAddr Task launch failed.");
    return error;
}

rtError_t ApiErrorDecorator::BarrierTaskLaunch(const rtBarrierTaskInfo_t * const taskInfo, Stream * const stm,
    const uint32_t flag)
{
    NULL_PTR_RETURN_MSG_OUTER(taskInfo, RT_ERROR_INVALID_VALUE);
    ZERO_RETURN_MSG(taskInfo->logicIdNum);
    COND_RETURN_ERROR_MSG_INNER(taskInfo->logicIdNum > RT_CMO_MAX_BARRIER_NUM, RT_ERROR_INVALID_VALUE,
        "logicIdNum=%hhu is invalid, valid range is [1, %u]", taskInfo->logicIdNum, RT_CMO_MAX_BARRIER_NUM);

    const rtError_t error = impl_->BarrierTaskLaunch(taskInfo, stm, flag);
    ERROR_RETURN(error, "Barrier Task failed.");
    return error;
}

rtError_t ApiErrorDecorator::MemcpyHostTask(void * const dst, const uint64_t destMax, const void * const src,
    const uint64_t cnt, const rtMemcpyKind_t kind, Stream * const stm)
{
    NULL_PTR_RETURN_MSG_OUTER(dst, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(src, RT_ERROR_INVALID_VALUE);
    ZERO_RETURN_AND_MSG_OUTER(cnt);

    Context *curCtx = nullptr;
    rtError_t error = RT_ERROR_NONE;
    error = impl_->ContextGetCurrent(&curCtx);
    COND_RETURN_WITH_NOLOG((error != RT_ERROR_NONE), error);
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    const uint32_t devRunMode = curCtx->Device_()->Driver_()->GetRunMode();
    if ((devRunMode != RT_RUN_MODE_ONLINE) || ((kind != RT_MEMCPY_HOST_TO_DEVICE) &&
        (kind != RT_MEMCPY_DEVICE_TO_HOST))) {
        RT_LOG(RT_LOG_INFO, "unsupported MemcpyHostTask feature, kind = %d, run mode = %u", kind, devRunMode);
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }
    return impl_->MemcpyHostTask(dst, destMax, src, cnt, kind, stm);
}

rtError_t ApiErrorDecorator::SetDeviceSatMode(const rtFloatOverflowMode_t floatOverflowMode)
{
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM(
        (floatOverflowMode >= RT_OVERFLOW_MODE_UNDEF) || (floatOverflowMode < RT_OVERFLOW_MODE_SATURATION),
        RT_ERROR_INVALID_VALUE, floatOverflowMode, 
        "[" + std::to_string(RT_OVERFLOW_MODE_SATURATION) + ", " + std::to_string(RT_OVERFLOW_MODE_UNDEF) + ")");
    return impl_->SetDeviceSatMode(floatOverflowMode);
}

rtError_t ApiErrorDecorator::GetDeviceSatMode(rtFloatOverflowMode_t * const floatOverflowMode)
{
    NULL_PTR_RETURN_MSG_OUTER(floatOverflowMode, RT_ERROR_INVALID_VALUE);
    return impl_->GetDeviceSatMode(floatOverflowMode);
}

rtError_t ApiErrorDecorator::GetDeviceSatModeForStream(Stream * const stm,
    rtFloatOverflowMode_t * const floatOverflowMode)
{
    NULL_PTR_RETURN_MSG_OUTER(floatOverflowMode, RT_ERROR_INVALID_VALUE);
    return impl_->GetDeviceSatModeForStream(stm, floatOverflowMode);
}

rtError_t ApiErrorDecorator::SetStreamOverflowSwitch(Stream * const stm, const uint32_t flags)
{
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM(flags >= static_cast<uint32_t>(RT_OVERFLOW_MODE_UNDEF), 
        RT_ERROR_INVALID_VALUE, flags, 
        "[" + std::to_string(RT_OVERFLOW_MODE_SATURATION) + ", " + std::to_string(RT_OVERFLOW_MODE_UNDEF) + ")");    
    return impl_->SetStreamOverflowSwitch(stm, flags);
}
rtError_t ApiErrorDecorator::GetStreamOverflowSwitch(Stream * const stm, uint32_t * const flags)
{
    NULL_PTR_RETURN_MSG_OUTER(flags, RT_ERROR_INVALID_VALUE);
    return impl_->GetStreamOverflowSwitch(stm, flags);
}

rtError_t ApiErrorDecorator::DvppGroupCreate(DvppGrp **grp, const uint32_t flags)
{
    /* 1910b tiny not support dvpp accelerator */
    Runtime * const rtInstance = Runtime::Instance();
    const rtChipType_t chipType = rtInstance->GetChipType();
    if (!IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_STREAM_DVPP_GROUP)) {
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }
    NULL_PTR_RETURN_MSG_OUTER(grp, RT_ERROR_INVALID_VALUE);
    const rtError_t error = impl_->DvppGroupCreate(grp, flags);
    ERROR_RETURN(error, "Dvpp grp create failed.");
    return error;
}

rtError_t ApiErrorDecorator::DvppGroupDestory(DvppGrp *grp)
{
    NULL_PTR_RETURN_MSG_OUTER(grp, RT_ERROR_INVALID_VALUE);
    const rtError_t error = impl_->DvppGroupDestory(grp);
    ERROR_RETURN(error, "dvpp grp destroy failed.");
    return error;
}

rtError_t ApiErrorDecorator::DvppWaitGroupReport(DvppGrp * const grp, const  rtDvppGrpCallback callBackFunc,
    const int32_t timeout)
{
    NULL_PTR_RETURN_MSG_OUTER(grp, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(callBackFunc, RT_ERROR_INVALID_VALUE);

    COND_RETURN_AND_MSG_OUTER_WITH_PARAM(timeout < -1, RT_ERROR_INVALID_VALUE, 
        timeout, "[0, " + std::to_string(MAX_INT32_NUM) + "] or -1");
    const rtError_t err = impl_->DvppWaitGroupReport(grp, callBackFunc, timeout);
    if (err != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_DEBUG, "dvpp wait grp report timeout=%dms, ret=%u", timeout, err);
    }

    return err;
}

rtError_t ApiErrorDecorator::SetStreamTag(Stream * const stm, const uint32_t geOpTag)
{
    const rtError_t error = impl_->SetStreamTag(stm, geOpTag);
    ERROR_RETURN(error, "set stream geOpTag failed.");
    return error;
}

rtError_t ApiErrorDecorator::GetStreamTag(Stream * const stm, uint32_t * const geOpTag)
{
    NULL_PTR_RETURN_MSG_OUTER(geOpTag, RT_ERROR_INVALID_VALUE);
    const rtError_t error = impl_->GetStreamTag(stm, geOpTag);
    ERROR_RETURN(error, "get stream geOpTag failed.");
    return error;
}

rtError_t ApiErrorDecorator::GetVisibleDeviceIdByLogicDeviceId(const int32_t logicDeviceId,
    int32_t * const visibleDeviceId)
{
    Runtime * const rt = Runtime::Instance();
    Driver * const npuDrv = rt->driverFactory_.GetDriver(NPU_DRIVER);
    NULL_PTR_RETURN_MSG(npuDrv, RT_ERROR_DRV_NULL);
    int32_t deviceCnt;

    const rtError_t error = npuDrv->GetDeviceCount(&deviceCnt);
    ERROR_RETURN_MSG_CALL(ERR_MODULE_DRV, error, "Get device cnt failed, retCode=%#x", static_cast<uint32_t>(error));
    if ((logicDeviceId >= deviceCnt) || (logicDeviceId < 0)) {
        RT_LOG_OUTER_MSG_INVALID_PARAM(logicDeviceId, "[0, " + std::to_string(deviceCnt) + ')');
        return RT_ERROR_DEVICE_ID;
    }

    NULL_PTR_RETURN_MSG_OUTER(visibleDeviceId, RT_ERROR_INVALID_VALUE);
    return impl_->GetVisibleDeviceIdByLogicDeviceId(logicDeviceId, visibleDeviceId);
}

rtError_t ApiErrorDecorator::CtxSetSysParamOpt(const rtSysParamOpt configOpt, const int64_t configVal)
{
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM((configOpt >= SYS_OPT_RESERVED) || (configOpt < 0), RT_ERROR_INVALID_VALUE, 
        configOpt, "[0, " + std::to_string(SYS_OPT_RESERVED) + ")");
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM((configVal >= SYS_OPT_MAX) || (configVal < 0), RT_ERROR_INVALID_VALUE, 
        configVal, "[0, " + std::to_string(SYS_OPT_MAX) + ")");
    return impl_->CtxSetSysParamOpt(configOpt, configVal);
}

rtError_t ApiErrorDecorator::CtxGetSysParamOpt(const rtSysParamOpt configOpt, int64_t * const configVal)
{
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM((configOpt >= SYS_OPT_RESERVED) || (configOpt < 0), RT_ERROR_INVALID_VALUE, 
        configOpt, "[0, " + std::to_string(SYS_OPT_RESERVED) + ")");
    NULL_PTR_RETURN_MSG_OUTER(configVal, RT_ERROR_INVALID_VALUE);
    return impl_->CtxGetSysParamOpt(configOpt, configVal);
}

rtError_t ApiErrorDecorator::CtxGetOverflowAddr(void ** const overflowAddr)
{
    COND_RETURN_ERROR(overflowAddr == nullptr, RT_ERROR_INVALID_VALUE,
        "Check param failed, overflowAddr can not be null.");
    return impl_->CtxGetOverflowAddr(overflowAddr);
}

rtError_t ApiErrorDecorator::GetDeviceSatStatus(void * const outputAddrPtr, const uint64_t outputSize,
    Stream * const stm)
{
    COND_RETURN_ERROR(outputAddrPtr == nullptr, RT_ERROR_INVALID_VALUE,
        "Check param failed, outputAddrPtr can not be null.");
    COND_RETURN_ERROR(outputSize != OVERFLOW_OUTPUT_SIZE,
        RT_ERROR_INVALID_VALUE, "output size %lu is invalid, only support %lu bytes",
        outputSize, OVERFLOW_OUTPUT_SIZE);
    return impl_->GetDeviceSatStatus(outputAddrPtr, outputSize, stm);
}

rtError_t ApiErrorDecorator::CleanDeviceSatStatus(Stream * const stm)
{
    return impl_->CleanDeviceSatStatus(stm);
}

rtError_t ApiErrorDecorator::GetAllUtilizations(const int32_t devId, const rtTypeUtil_t kind, uint8_t * const util)
{
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM((kind >= RT_UTIL_TYPE_MAX) || (kind < 0), RT_ERROR_INVALID_VALUE, 
        kind, "[0, " + std::to_string(RT_UTIL_TYPE_MAX) + ")");
    NULL_PTR_RETURN_MSG_OUTER(util, RT_ERROR_INVALID_VALUE);
    int32_t realDeviceId;
    const rtError_t error = Runtime::Instance()->ChgUserDevIdToDeviceId(static_cast<uint32_t>(devId),
        RtPtrToPtr<uint32_t *>(&realDeviceId));
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, "input error devId:%u is err:%#x", devId, static_cast<uint32_t>(error));

    return impl_->GetAllUtilizations(realDeviceId, kind, util);
}

rtError_t ApiErrorDecorator::GetTaskBufferLen(const rtTaskBuffType_t type, uint32_t * const bufferLen)
{
    NULL_PTR_RETURN_MSG_OUTER(bufferLen, RT_ERROR_INVALID_VALUE);

    return impl_->GetTaskBufferLen(type, bufferLen);
}

rtError_t ApiErrorDecorator::TaskSqeBuild(const rtTaskInput_t * const taskInput, uint32_t * const taskLen)
{
    NULL_PTR_RETURN_MSG_OUTER(taskInput, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(taskLen, RT_ERROR_INVALID_VALUE);

    return impl_->TaskSqeBuild(taskInput, taskLen);
}

rtError_t ApiErrorDecorator::GetKernelBin(const char_t *const binFileName, char_t **const buffer,
                                          uint32_t *length)
{
    NULL_PTR_RETURN_MSG_OUTER(binFileName, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(buffer, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(length, RT_ERROR_INVALID_VALUE);

    return impl_->GetKernelBin(binFileName, buffer, length);
}

rtError_t ApiErrorDecorator::GetBinBuffer(const rtBinHandle binHandle, const rtBinBufferType_t type, void **bin,
                                          uint32_t *binSize)
{
    NULL_PTR_RETURN_MSG(binHandle, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG(bin, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG(binSize, RT_ERROR_INVALID_VALUE);
    return impl_->GetBinBuffer(binHandle, type, bin, binSize);
}

rtError_t ApiErrorDecorator::GetStackBuffer(const rtBinHandle binHandle, const uint32_t coreType,
    const uint32_t coreId, const void **stack, uint32_t *stackSize)
{
    NULL_PTR_RETURN_MSG_OUTER(binHandle, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(stack, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(stackSize, RT_ERROR_INVALID_VALUE);
    return impl_->GetStackBuffer(binHandle, coreType, coreId, stack, stackSize);
}

rtError_t ApiErrorDecorator::FreeKernelBin(char_t * const buffer)
{
    NULL_PTR_RETURN_MSG_OUTER(buffer, RT_ERROR_INVALID_VALUE);

    return impl_->FreeKernelBin(buffer);
}

rtError_t ApiErrorDecorator::EschedQueryInfo(const uint32_t devId, const rtEschedQueryType type,
    rtEschedInputInfo *inPut, rtEschedOutputInfo *outPut)
{
    NULL_PTR_RETURN_MSG(inPut, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG(outPut, RT_ERROR_INVALID_VALUE);
    uint32_t realDeviceId = 0U;
    if (IsHostCpuDevId(static_cast<int32_t>(devId))) {
        realDeviceId = static_cast<uint32_t>(DEFAULT_HOSTCPU_LOGIC_DEVICE_ID);
    } else {
        const rtError_t error = Runtime::Instance()->ChgUserDevIdToDeviceId(devId, &realDeviceId);
        COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
            "input error devId:%u is err:%#x", devId, static_cast<uint32_t>(error));
    }
    return impl_->EschedQueryInfo(realDeviceId, type, inPut, outPut);
}

rtError_t ApiErrorDecorator::ModelCheckArchVersion(const char_t *omArchVersion, const rtArchType_t archType)
{
    NULL_PTR_RETURN_MSG_OUTER(omArchVersion, RT_ERROR_INVALID_VALUE);
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM(static_cast<uint32_t>(archType) >= ARCH_END, RT_ERROR_INVALID_VALUE, 
        archType, "less than " + std::to_string(ARCH_END));
    return impl_->ModelCheckArchVersion(omArchVersion, archType);
}

rtError_t ApiErrorDecorator::ReserveMemAddress(void** devPtr, size_t size, size_t alignment, void *devAddr,
    uint64_t flags)
{
    NULL_PTR_RETURN_MSG(devPtr, RT_ERROR_INVALID_VALUE);
    return impl_->ReserveMemAddress(devPtr, size, alignment, devAddr, flags);
}

rtError_t ApiErrorDecorator::ReleaseMemAddress(void* devPtr)
{
    return impl_->ReleaseMemAddress(devPtr);
}

rtError_t ApiErrorDecorator::MallocPhysical(rtDrvMemHandle* handle, size_t size, rtDrvMemProp_t* prop,
    uint64_t flags)
{
    NULL_PTR_RETURN_MSG(prop, RT_ERROR_INVALID_VALUE);
    rtError_t error = RT_ERROR_NONE;
    // only device id need covert
    if (prop->side == DEVICE_TYPE) {
        const uint32_t userDeviceId = prop->devid;
        error = Runtime::Instance()->ChgUserDevIdToDeviceId(userDeviceId, &prop->devid);
        COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, RT_ERROR_DEVICE_ID,
            "input error devId:%u is err:%#x", userDeviceId, static_cast<uint32_t>(RT_ERROR_DEVICE_ID));
        error = CheckDeviceIdIsValid(static_cast<int32_t>(prop->devid));
        COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
            "drv devId is invalid, drv devId=%u, retCode=%#x", prop->devid, static_cast<uint32_t>(error));
    }
    // check feature is support
    if (prop->side == NUMA_TYPE) {
        Context *curCtx = Runtime::Instance()->CurrentContext();
        CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
        NULL_PTR_RETURN_MSG(curCtx->Device_(), RT_ERROR_DEVICE_NULL);
        COND_RETURN_WARN((!(NpuDriver::CheckIsSupportFeature(curCtx->Device_()->Id_(), FEATURE_SVM_VMM_NORMAL_GRANULARITY))), 
            RT_ERROR_DRV_NOT_SUPPORT, "[drv api] driver not support alloc mem via numa id feature.");
        // rt location type covert drv location type
        prop->side = DRV_MEM_HOST_NUMA_SIDE;
    }
    if (prop->pg_type == HUGE1G_PAGE) {
        error = NpuDriver::CheckIfSupport1GHugePage();
        COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
            "pageType does not support, pageType[%u], retCode=%#x", prop->pg_type, static_cast<uint32_t>(error));
    }
    return impl_->MallocPhysical(handle, size, prop, flags);
}

rtError_t ApiErrorDecorator::FreePhysical(rtDrvMemHandle handle)
{
    /* handle在上下文中作为一个整体使用, 内部的devid不用进行转换 */
    return impl_->FreePhysical(handle);
}

rtError_t ApiErrorDecorator::MapMem(void* devPtr, size_t size, size_t offset, rtDrvMemHandle handle, uint64_t flags)
{
    /* handle在上下文中作为一个整体使用, 内部的devid不用进行转换 */
    return impl_->MapMem(devPtr, size, offset, handle, flags);
}

rtError_t ApiErrorDecorator::UnmapMem(void* devPtr)
{
    return impl_->UnmapMem(devPtr);
}

rtError_t ApiErrorDecorator::MemSetAccess(void *virPtr, size_t size, rtMemAccessDesc *desc, size_t count)
{
    NULL_PTR_RETURN_MSG(virPtr, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG(desc, RT_ERROR_INVALID_VALUE);
    return impl_->MemSetAccess(virPtr, size, desc, count);
}

rtError_t ApiErrorDecorator::MemGetAccess(void *virPtr, rtMemLocation *location, uint64_t *flags)
{
    NULL_PTR_RETURN_MSG(virPtr, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG(location, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG(flags, RT_ERROR_INVALID_VALUE);
    return impl_->MemGetAccess(virPtr, location, flags);
}

rtError_t ApiErrorDecorator::ExportToShareableHandle(rtDrvMemHandle handle, rtDrvMemHandleType handleType,
    uint64_t flags, uint64_t *shareableHandle)
{
    constexpr uint64_t maxFlag = RT_VMM_EXPORT_FLAG_DISABLE_PID_VALIDATION;
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM((flags > maxFlag), RT_ERROR_INVALID_VALUE, flags, 
        "[0, " + std::to_string(maxFlag) + "]");
    /* handle在上下文中作为一个整体使用, 内部的devid不用进行转换 */
    return impl_->ExportToShareableHandle(handle, handleType, flags, shareableHandle);
}

rtError_t ApiErrorDecorator::ExportToShareableHandleV2(
    rtDrvMemHandle handle, rtMemSharedHandleType handleType, uint64_t flags, void *shareableHandle)
{
    NULL_PTR_RETURN_MSG(shareableHandle, RT_ERROR_INVALID_VALUE);
	COND_RETURN_AND_MSG_OUTER_WITH_PARAM(
        (handleType != RT_MEM_SHARE_HANDLE_TYPE_DEFAULT && handleType != RT_MEM_SHARE_HANDLE_TYPE_FABRIC), 
        RT_ERROR_INVALID_VALUE, handleType, std::to_string(RT_MEM_SHARE_HANDLE_TYPE_DEFAULT) 
        + " or " + std::to_string(RT_MEM_SHARE_HANDLE_TYPE_FABRIC));
    constexpr uint64_t maxFlag = RT_VMM_EXPORT_FLAG_DISABLE_PID_VALIDATION;
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM((flags > maxFlag), RT_ERROR_INVALID_VALUE, flags, 
        "[0, " + std::to_string(maxFlag) + "]");
    /* handle在上下文中作为一个整体使用, 内部的devid不用进行转换 */
    return impl_->ExportToShareableHandleV2(handle, handleType, flags, shareableHandle);
}

rtError_t ApiErrorDecorator::ImportFromShareableHandle(uint64_t shareableHandle, int32_t devId,
    rtDrvMemHandle* handle)
{
    NULL_PTR_RETURN_MSG(handle, RT_ERROR_INVALID_VALUE);
    int32_t realDeviceId = 0;
    rtError_t error = Runtime::Instance()->ChgUserDevIdToDeviceId(static_cast<uint32_t>(devId),
        RtPtrToPtr<uint32_t *>(&realDeviceId));
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "input error devId:%d is err:%#x", devId, static_cast<uint32_t>(error));
    error = CheckDeviceIdIsValid(realDeviceId);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "drv devId is invalid, drv devId=%d, retCode=%#x", realDeviceId, static_cast<uint32_t>(error));
    return impl_->ImportFromShareableHandle(shareableHandle, realDeviceId, handle);
}

rtError_t ApiErrorDecorator::ImportFromShareableHandleV2(const void *shareableHandle,
    rtMemSharedHandleType handleType, uint64_t flags, int32_t devId, rtDrvMemHandle *handle)
{
    NULL_PTR_RETURN_MSG(shareableHandle, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG(handle, RT_ERROR_INVALID_VALUE);
	COND_RETURN_AND_MSG_OUTER_WITH_PARAM(
        (handleType != RT_MEM_SHARE_HANDLE_TYPE_DEFAULT && handleType != RT_MEM_SHARE_HANDLE_TYPE_FABRIC), 
        RT_ERROR_INVALID_VALUE, handleType, std::to_string(RT_MEM_SHARE_HANDLE_TYPE_DEFAULT) 
        + " or " + std::to_string(RT_MEM_SHARE_HANDLE_TYPE_FABRIC));
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM((flags != 0U), RT_ERROR_INVALID_VALUE, flags, "0");
    int32_t realDeviceId = 0;
    rtError_t error = Runtime::Instance()->ChgUserDevIdToDeviceId(
        static_cast<uint32_t>(devId), RtPtrToPtr<uint32_t *>(&realDeviceId));
    COND_RETURN_ERROR_MSG_INNER(
        error != RT_ERROR_NONE, error, "input error devId:%d is err:%#x", devId, static_cast<uint32_t>(error));
    error = CheckDeviceIdIsValid(realDeviceId);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE,
        error,
        "Device id is invalid, drv deviceId=%d, retCode=%#x",
        realDeviceId,
        static_cast<uint32_t>(error));
    return impl_->ImportFromShareableHandleV2(shareableHandle, handleType, flags, realDeviceId, handle);
}

rtError_t ApiErrorDecorator::SetPidToShareableHandle(uint64_t shareableHandle, int32_t pid[], uint32_t pidNum)
{
    return impl_->SetPidToShareableHandle(shareableHandle, pid, pidNum);
}

rtError_t ApiErrorDecorator::SetPidToShareableHandleV2(
    const void *shareableHandle, rtMemSharedHandleType handleType, int32_t pid[], uint32_t pidNum)
{
    NULL_PTR_RETURN_MSG(shareableHandle, RT_ERROR_INVALID_VALUE);
	COND_RETURN_AND_MSG_OUTER_WITH_PARAM(
        (handleType != RT_MEM_SHARE_HANDLE_TYPE_DEFAULT && handleType != RT_MEM_SHARE_HANDLE_TYPE_FABRIC), 
        RT_ERROR_INVALID_VALUE, handleType, std::to_string(RT_MEM_SHARE_HANDLE_TYPE_DEFAULT) 
        + " or " + std::to_string(RT_MEM_SHARE_HANDLE_TYPE_FABRIC));    
    return impl_->SetPidToShareableHandleV2(shareableHandle, handleType, pid, pidNum);
}

rtError_t ApiErrorDecorator::GetAllocationGranularity(rtDrvMemProp_t *prop, rtDrvMemGranularityOptions option,
    size_t *granularity)
{
    NULL_PTR_RETURN_MSG(prop, RT_ERROR_INVALID_VALUE);
    uint32_t userDeviceId = prop->devid;
    rtError_t error = Runtime::Instance()->ChgUserDevIdToDeviceId(userDeviceId, &prop->devid);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, RT_ERROR_DEVICE_ID,
        "input error devId:%u is err:%#x", userDeviceId, static_cast<uint32_t>(RT_ERROR_DEVICE_ID));
    error = CheckDeviceIdIsValid(static_cast<int32_t>(prop->devid));
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "drv devId is invalid, drv devId=%u, retCode=%#x", prop->devid, static_cast<uint32_t>(error));
    return impl_->GetAllocationGranularity(prop, option, granularity);
}

rtError_t ApiErrorDecorator::DeviceStatusQuery(const uint32_t devId, rtDeviceStatus *deviceStatus)
{
    uint32_t realDeviceId = 0U;
    const Runtime * const rtInstance = Runtime::Instance();
    NULL_PTR_RETURN_MSG_OUTER(deviceStatus, RT_ERROR_INVALID_VALUE);
    rtError_t error = rtInstance->ChgUserDevIdToDeviceId(static_cast<uint32_t>(devId),
        RtPtrToPtr<uint32_t *>(&realDeviceId));
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, RT_ERROR_DEVICE_ID,
        "input error devId=%u is err:%#x", devId, static_cast<uint32_t>(RT_ERROR_DEVICE_ID));
    error = CheckDeviceIdIsValid(realDeviceId);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "drv devId is invalid, devId=%u, drv devId=%u, retCode=%#x", devId, realDeviceId, static_cast<uint32_t>(error));
    return impl_->DeviceStatusQuery(realDeviceId, deviceStatus);
}

rtError_t ApiErrorDecorator::BindHostPid(rtBindHostpidInfo info)
{
    return impl_->BindHostPid(info);
}

rtError_t ApiErrorDecorator::UnbindHostPid(rtBindHostpidInfo info)
{
    return impl_->UnbindHostPid(info);
}

rtError_t ApiErrorDecorator::QueryProcessHostPid(int32_t pid, uint32_t *chipId, uint32_t *vfId, uint32_t *hostPid,
    uint32_t *cpType)
{
    rtError_t error = impl_->QueryProcessHostPid(pid, chipId, vfId, hostPid, cpType);
    ERROR_RETURN(error, "QueryProcessHostPid failed");
    if (chipId != nullptr) {
        const uint32_t drvDeviceId = *chipId;
        error = Runtime::Instance()->GetUserDevIdByDeviceId(drvDeviceId, chipId);
        ERROR_RETURN_MSG_INNER(error, "Conv drvDeviceId=%u is err:%#x.", drvDeviceId, static_cast<uint32_t>(error));
    }
    return RT_ERROR_NONE;
}

rtError_t ApiErrorDecorator::SetStreamSqLockUnlock(Stream * const stm, bool isLock)
{
    Stream *curStm = Runtime::Instance()->GetCurStream(stm);
    NULL_PTR_RETURN_MSG_OUTER(curStm, RT_ERROR_INVALID_VALUE);
    return impl_->SetStreamSqLockUnlock(curStm, isLock);
}

rtError_t ApiErrorDecorator::ShrIdSetPodPid(const char *name, uint32_t sdid, int32_t pid)
{
    return impl_->ShrIdSetPodPid(name, sdid, pid);
}

rtError_t ApiErrorDecorator::ShmemSetPodPid(const char *name, uint32_t sdid, int32_t pid[], int32_t num)
{
    return impl_->ShmemSetPodPid(name, sdid, pid, num);
}

rtError_t ApiErrorDecorator::DevVA2PA(uint64_t devAddr, uint64_t len, Stream *stm, bool isAsync)
{
    return impl_->DevVA2PA(devAddr, len, stm, isAsync);
}

rtError_t ApiErrorDecorator::StreamClear(Stream * const stm, rtClearStep_t step)
{
    Stream *curStm = Runtime::Instance()->GetCurStream(stm);
    NULL_PTR_RETURN_MSG_OUTER(curStm, RT_ERROR_INVALID_VALUE);
    COND_RETURN_ERROR((step > RT_STREAM_CLEAR) || (step < RT_STREAM_STOP), RT_ERROR_INVALID_VALUE,
        "Invalid clearStop, current step=%d, valid range is [%d, %d].", step,
        RT_STREAM_STOP, RT_STREAM_CLEAR);
    const rtError_t ret = impl_->StreamClear(curStm, step);
    RT_LOG(RT_LOG_EVENT, "Clear stream_id=%d, step=%u, ret = %u", curStm->Id_(), step, static_cast<uint32_t>(ret));
    return ret;
}

rtError_t ApiErrorDecorator::StreamStop(Stream * const stm)
{
    NULL_PTR_RETURN_MSG_OUTER(stm, RT_ERROR_INVALID_VALUE);
    const rtError_t ret = impl_->StreamStop(stm);
    return ret;
}

rtError_t ApiErrorDecorator::StreamAbort(Stream * const stm)
{
    Stream *curStm = Runtime::Instance()->GetCurStream(stm);
    NULL_PTR_RETURN_MSG_OUTER(curStm, RT_ERROR_INVALID_VALUE);
    const rtError_t ret = impl_->StreamAbort(curStm);
    RT_LOG(RT_LOG_EVENT, "Abort stream_id=%d,ret = %u", curStm->Id_(), ret);
    return ret;
}

rtError_t ApiErrorDecorator::DebugSetDumpMode(const uint64_t mode)
{
    return impl_->DebugSetDumpMode(mode);
}

rtError_t ApiErrorDecorator::DebugGetStalledCore(rtDbgCoreInfo_t *const coreInfo)
{
    NULL_PTR_RETURN_MSG_OUTER(coreInfo, RT_ERROR_INVALID_VALUE);
    return impl_->DebugGetStalledCore(coreInfo);
}

rtError_t ApiErrorDecorator::DebugReadAICore(rtDebugMemoryParam_t *const param)
{
    NULL_PTR_RETURN_MSG_OUTER(param, RT_ERROR_INVALID_VALUE);
    return impl_->DebugReadAICore(param);
}

rtError_t ApiErrorDecorator::GetExceptionRegInfo(const rtExceptionInfo_t * const exceptionInfo,
    rtExceptionErrRegInfo_t **exceptionErrRegInfo, uint32_t *num)
{
    NULL_PTR_RETURN_MSG_OUTER(exceptionInfo, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(exceptionErrRegInfo, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(num, RT_ERROR_INVALID_VALUE);
    return impl_->GetExceptionRegInfo(exceptionInfo, exceptionErrRegInfo, num);
}

rtError_t ApiErrorDecorator::GetServerIDBySDID(
    uint32_t sdid, uint32_t *srvId)
{
    return impl_->GetServerIDBySDID(sdid, srvId);
}

rtError_t ApiErrorDecorator::ModelNameSet(Model * const mdl, const char_t * const name)
{
    NULL_PTR_RETURN_MSG_OUTER(mdl, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(name, RT_ERROR_INVALID_VALUE);
    const rtError_t error = impl_->ModelNameSet(mdl, name);
    ERROR_RETURN(error, "set model name failed");
    return error;
}

rtError_t ApiErrorDecorator::SetDefaultDeviceId(const int32_t deviceId)
{
    Runtime *rtInstance = Runtime::Instance();
    NULL_PTR_RETURN_MSG(rtInstance, RT_ERROR_INSTANCE_NULL);
    if (deviceId == DEFAULT_DEVICE_ID) {
        rtInstance->SetDefaultDeviceId(deviceId);
        return RT_ERROR_NONE;
    }

    int32_t realDeviceId;
    rtError_t error = rtInstance->ChgUserDevIdToDeviceId(static_cast<uint32_t>(deviceId),
        RtPtrToPtr<uint32_t *>(&realDeviceId), true);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, "input error deviceId:%u is err:%#x", deviceId, error);

    error = CheckDeviceIdIsValid(realDeviceId);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "drv devId is invalid, drv devId=%d, retCode=%#x", realDeviceId, error);
    return impl_->SetDefaultDeviceId(realDeviceId);
}

rtError_t ApiErrorDecorator::CtxGetCurrentDefaultStream(Stream ** const stm)
{
    NULL_PTR_RETURN_MSG(stm, RT_ERROR_INVALID_VALUE);
    return impl_->CtxGetCurrentDefaultStream(stm);
}

rtError_t ApiErrorDecorator::GetPrimaryCtxState(const int32_t devId, uint32_t *flags, int32_t *active)
{
    NULL_PTR_RETURN_MSG(flags, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG(active, RT_ERROR_INVALID_VALUE);
    int32_t realDeviceId;
    Runtime *rtInstance = Runtime::Instance();

    driverType_t const rawDrvType = rtInstance->GetDriverType();
    Driver * const rawDrv = rtInstance->driverFactory_.GetDriver(rawDrvType);
    NULL_PTR_RETURN_MSG(rawDrv, RT_ERROR_DRV_NULL);

    int32_t deviceCnt = 0;
    rtError_t error = rawDrv->GetDeviceCount(&deviceCnt);
    ERROR_RETURN_MSG_CALL(ERR_MODULE_DRV, error, "Get device cnt failed, retCode=%#x", static_cast<uint32_t>(error));

    error = rtInstance->ChgUserDevIdToDeviceId(static_cast<uint32_t>(devId),
        RtPtrToPtr<uint32_t *>(&realDeviceId), true);
    COND_RETURN_ERROR(error != RT_ERROR_NONE, error, "input error deviceId:%d is err:%#x", devId, error);
    COND_RETURN_ERROR(((realDeviceId < 0) || (realDeviceId >= deviceCnt)), RT_ERROR_DEVICE_ID,
        "Invalid devId=%d drv devId=%d, valid range is [0, %d).", devId, realDeviceId, deviceCnt);

    return impl_->GetPrimaryCtxState(realDeviceId, flags, active);
}
rtError_t ApiErrorDecorator::RegStreamStateCallback(const char_t *regName, void *callback, void *args,
    StreamStateCallback type)
{
    NULL_PTR_RETURN_MSG_OUTER(regName, RT_ERROR_INVALID_VALUE);
    return impl_->RegStreamStateCallback(regName, callback, args, type);
}

rtError_t ApiErrorDecorator::DeviceResetForce(const int32_t devId)
{
    int32_t realDeviceId;
    rtError_t error = Runtime::Instance()->ChgUserDevIdToDeviceId(static_cast<uint32_t>(devId),
        RtPtrToPtr<uint32_t *>(&realDeviceId));
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, RT_ERROR_DEVICE_ID,
        "input error devId:%u is err:%#x", devId, static_cast<uint32_t>(RT_ERROR_DEVICE_ID));
    error = CheckDeviceIdIsValid(realDeviceId);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "drv devId is invalid, drv devId=%d, retCode=%#x", realDeviceId, static_cast<uint32_t>(error));

    return impl_->DeviceResetForce(realDeviceId);
}

rtError_t ApiErrorDecorator::GetDeviceStatus(const int32_t devId, rtDevStatus_t * const status)
{
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM((devId < 0), RT_ERROR_DEVICE_ID, devId, "greater than or equal to 0");
    NULL_PTR_RETURN_MSG_OUTER(status, RT_ERROR_INVALID_VALUE);
    rtError_t error;
    int32_t realDeviceId;
    error = Runtime::Instance()->ChgUserDevIdToDeviceId(static_cast<uint32_t>(devId),
        RtPtrToPtr<uint32_t *>(&realDeviceId));
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, "Error input devId:%d is err:%#x",
        devId, static_cast<uint32_t>(error));
    error = CheckDeviceIdIsValid(realDeviceId);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, "Device ID is invalid, drv devId=%d, retCode=%#x",
        realDeviceId, static_cast<uint32_t>(error));
    return impl_->GetDeviceStatus(realDeviceId, status);
}

rtError_t ApiErrorDecorator::SetDeviceResLimit(const uint32_t devId, const rtDevResLimitType_t type, uint32_t value)
{
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM(static_cast<uint32_t>(type) >= RT_DEV_RES_TYPE_MAX, RT_ERROR_INVALID_VALUE, 
        type, "[0, " + std::to_string(RT_DEV_RES_TYPE_MAX) + ")");
    uint32_t drvDevId = 0;
    rtError_t error = Runtime::Instance()->ChgUserDevIdToDeviceId(devId, &drvDevId);
    COND_RETURN_ERROR_MSG_INNER(
        error != RT_ERROR_NONE, error, "Error input devId:%u is err:%#x", devId, static_cast<uint32_t>(error));
    error = CheckDeviceIdIsValid(static_cast<uint32_t>(drvDevId));
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE,
        error,
        "drv devId is invalid, drv devId=%u, retCode=%#x",
        drvDevId,
        static_cast<uint32_t>(error));
    return impl_->SetDeviceResLimit(drvDevId, type, value);
}

rtError_t ApiErrorDecorator::ResetDeviceResLimit(const uint32_t devId)
{
    uint32_t drvDevId = 0;
    rtError_t error = Runtime::Instance()->ChgUserDevIdToDeviceId(devId, &drvDevId);
    COND_RETURN_ERROR_MSG_INNER(
        error != RT_ERROR_NONE, error, "Error input devId:%u is err:%#x", devId, static_cast<uint32_t>(error));
    error = CheckDeviceIdIsValid(static_cast<uint32_t>(drvDevId));
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE,
        error,
        "drv devId is invalid, drv devId=%u, retCode=%#x",
        drvDevId,
        static_cast<uint32_t>(error));
    return impl_->ResetDeviceResLimit(drvDevId);
}

rtError_t ApiErrorDecorator::GetDeviceResLimit(const uint32_t devId, const rtDevResLimitType_t type, uint32_t *value)
{
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM(static_cast<uint32_t>(type) >= RT_DEV_RES_TYPE_MAX, RT_ERROR_INVALID_VALUE, 
        type, "[0, " + std::to_string(RT_DEV_RES_TYPE_MAX) + ")");
    NULL_PTR_RETURN_MSG_OUTER(value, RT_ERROR_INVALID_VALUE);
    uint32_t drvDevId = 0;
    rtError_t error = Runtime::Instance()->ChgUserDevIdToDeviceId(devId, &drvDevId);
    COND_RETURN_ERROR_MSG_INNER(
        error != RT_ERROR_NONE, error, "Error input devId:%u is err:%#x", devId, static_cast<uint32_t>(error));
    error = CheckDeviceIdIsValid(static_cast<uint32_t>(drvDevId));
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE,
        error,
        "drv devId is invalid, drv devId=%u, retCode=%#x",
        drvDevId,
        static_cast<uint32_t>(error));
    return impl_->GetDeviceResLimit(drvDevId, type, value);
}

rtError_t ApiErrorDecorator::SetStreamResLimit(Stream *const stm, const rtDevResLimitType_t type, const uint32_t value)
{
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM(static_cast<uint32_t>(type) >= RT_DEV_RES_TYPE_MAX, RT_ERROR_INVALID_VALUE, 
        type, "[0, " + std::to_string(RT_DEV_RES_TYPE_MAX) + ")");
    return impl_->SetStreamResLimit(stm, type, value);
}

rtError_t ApiErrorDecorator::ResetStreamResLimit(Stream *const stm)
{
    return impl_->ResetStreamResLimit(stm);
}

rtError_t ApiErrorDecorator::GetStreamResLimit(const Stream *const stm, const rtDevResLimitType_t type, uint32_t *const value)
{
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM(static_cast<uint32_t>(type) >= RT_DEV_RES_TYPE_MAX, RT_ERROR_INVALID_VALUE, 
        type, "[0, " + std::to_string(RT_DEV_RES_TYPE_MAX) + ")");
    NULL_PTR_RETURN_MSG_OUTER(value, RT_ERROR_INVALID_VALUE);
    return impl_->GetStreamResLimit(stm, type, value);
}

rtError_t ApiErrorDecorator::UseStreamResInCurrentThread(const Stream *const stm)
{
    return impl_->UseStreamResInCurrentThread(stm);
}

rtError_t ApiErrorDecorator::NotUseStreamResInCurrentThread(const Stream *const stm)
{
    return impl_->NotUseStreamResInCurrentThread(stm);
}

rtError_t ApiErrorDecorator::GetResInCurrentThread(const rtDevResLimitType_t type, uint32_t *const value)
{
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM(static_cast<uint32_t>(type) >= RT_DEV_RES_TYPE_MAX, RT_ERROR_INVALID_VALUE, 
        type, "[0, " + std::to_string(RT_DEV_RES_TYPE_MAX) + ")");
    NULL_PTR_RETURN_MSG_OUTER(value, RT_ERROR_INVALID_VALUE);
    return impl_->GetResInCurrentThread(type, value);
}

rtError_t ApiErrorDecorator::HdcServerCreate(const int32_t devId, const rtHdcServiceType_t type, rtHdcServer_t * const server)
{
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM((devId < 0), RT_ERROR_DEVICE_ID, devId, "greater than or equal to 0");
    NULL_PTR_RETURN_MSG_OUTER(server, RT_ERROR_INVALID_VALUE);
    rtError_t error;
    int32_t realDeviceId;
    error = Runtime::Instance()->ChgUserDevIdToDeviceId(static_cast<uint32_t>(devId),
        RtPtrToPtr<uint32_t *>(&realDeviceId));
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, "Error input devId:%d is err:%#x",
        devId, static_cast<uint32_t>(error));
    error = CheckDeviceIdIsValid(realDeviceId);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, "Device ID is invalid, drv devId=%d, retCode=%#x",
        realDeviceId, static_cast<uint32_t>(error));
    return impl_->HdcServerCreate(realDeviceId, type, server);
}

rtError_t ApiErrorDecorator::HdcServerDestroy(rtHdcServer_t const server)
{
    NULL_PTR_RETURN_MSG_OUTER(server, RT_ERROR_INVALID_VALUE);
    return impl_->HdcServerDestroy(server);
}

rtError_t ApiErrorDecorator::HdcSessionConnect(const int32_t peerNode, const int32_t peerDevId, rtHdcClient_t const client,
    rtHdcSession_t * const session)
{
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM((peerDevId < 0), RT_ERROR_DEVICE_ID, peerDevId, "greater than or equal to 0");
    NULL_PTR_RETURN_MSG_OUTER(client, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(session, RT_ERROR_INVALID_VALUE);
    rtError_t error;
    int32_t realDeviceId;
    error = Runtime::Instance()->ChgUserDevIdToDeviceId(static_cast<uint32_t>(peerDevId),
        RtPtrToPtr<uint32_t *>(&realDeviceId));
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, "Error input devId:%d is err:%#x",
        peerDevId, static_cast<uint32_t>(error));
    error = CheckDeviceIdIsValid(realDeviceId);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, "Device ID is invalid, drv devId=%d, retCode=%#x",
        realDeviceId, static_cast<uint32_t>(error));
    return impl_->HdcSessionConnect(peerNode, realDeviceId, client, session);
}

rtError_t ApiErrorDecorator::HdcSessionClose(rtHdcSession_t const session)
{
    NULL_PTR_RETURN_MSG_OUTER(session, RT_ERROR_INVALID_VALUE);
    return impl_->HdcSessionClose(session);
}

rtError_t ApiErrorDecorator::GetHostCpuDevId(int32_t * const devId)
{
    NULL_PTR_RETURN_MSG_OUTER(devId, RT_ERROR_INVALID_VALUE);
    return impl_->GetHostCpuDevId(devId);
}

rtError_t ApiErrorDecorator::GetLogicDevIdByUserDevId(const int32_t userDevId, int32_t * const logicDevId)
{
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM((userDevId < 0), RT_ERROR_DEVICE_ID, userDevId, "greater than or equal to 0");
    NULL_PTR_RETURN_MSG_OUTER(logicDevId, RT_ERROR_INVALID_VALUE);
    int32_t realDeviceId = 0;
    rtError_t error = impl_->GetLogicDevIdByUserDevId(userDevId, &realDeviceId);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, "Get logicDevId failed.");
    error = CheckDeviceIdIsValid(realDeviceId);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, "logicDevId is invalid, devId=%d, retCode=%#x",
        realDeviceId, static_cast<uint32_t>(error));
    *logicDevId = realDeviceId;
    return RT_ERROR_NONE;
}

rtError_t ApiErrorDecorator::GetUserDevIdByLogicDevId(const int32_t logicDevId, int32_t * const userDevId)
{
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM((logicDevId < 0), RT_ERROR_DEVICE_ID, logicDevId, "greater than or equal to 0");
    NULL_PTR_RETURN_MSG_OUTER(userDevId, RT_ERROR_INVALID_VALUE);
    const rtError_t error = CheckDeviceIdIsValid(logicDevId);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, "logicDevId is invalid, devId=%d, retCode=%#x",
        logicDevId, static_cast<uint32_t>(error));
    return impl_->GetUserDevIdByLogicDevId(logicDevId, userDevId);
}

rtError_t ApiErrorDecorator::GetDeviceUuid(const int32_t devId, rtUuid_t *uuid)
{
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM((devId < 0), RT_ERROR_DEVICE_ID, devId, "greater than or equal to 0");
    NULL_PTR_RETURN_MSG_OUTER(uuid, RT_ERROR_INVALID_VALUE);

    int32_t drvDeviceId;
    rtError_t error = Runtime::Instance()->ChgUserDevIdToDeviceId(static_cast<uint32_t>(devId),
        RtPtrToPtr<uint32_t*>(&drvDeviceId));
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, "Input devId is invalid, devId=%d, ErrorCode=%#x",
        devId, static_cast<uint32_t>(error));

    error = CheckDeviceIdIsValid(drvDeviceId);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, "drvDeviceId is invalid, drvDeviceId=%d, ErrorCode=%#x",
        drvDeviceId, static_cast<uint32_t>(error));

    return impl_->GetDeviceUuid(drvDeviceId, uuid);
}

rtError_t ApiErrorDecorator::StreamBeginCapture(Stream * const stm, const rtStreamCaptureMode mode)
{
    NULL_PTR_RETURN_MSG_OUTER(stm, RT_ERROR_INVALID_VALUE);
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM(((mode >= RT_STREAM_CAPTURE_MODE_MAX) || (mode < RT_STREAM_CAPTURE_MODE_GLOBAL)), 
        RT_ERROR_INVALID_VALUE, mode, "[" + std::to_string(RT_STREAM_CAPTURE_MODE_GLOBAL) + ", " 
        + std::to_string(RT_STREAM_CAPTURE_MODE_MAX) +")");  
    COND_RETURN_ERROR_MSG_INNER(!StreamFlagIsSupportCapture(stm->Flags()), RT_ERROR_STREAM_INVALID,
        "stream flag does not support capture to model, flag=%u.", stm->Flags());
    return impl_->StreamBeginCapture(stm, mode);
}

rtError_t ApiErrorDecorator::StreamEndCapture(Stream * const stm, Model ** const captureMdl)
{
    NULL_PTR_RETURN_MSG_OUTER(stm, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(captureMdl, RT_ERROR_INVALID_VALUE);
    COND_RETURN_ERROR_MSG_INNER(!StreamFlagIsSupportCapture(stm->Flags()), RT_ERROR_STREAM_INVALID,
        "stream flag does not support capture to model, flag=%u.", stm->Flags());

    return impl_->StreamEndCapture(stm, captureMdl);
}

rtError_t ApiErrorDecorator::StreamGetCaptureInfo(const Stream * const stm, rtStreamCaptureStatus * const status,
                                                  Model ** const captureMdl)
{
    NULL_PTR_RETURN_MSG_OUTER(stm, RT_ERROR_INVALID_VALUE);
    COND_RETURN_OUT_ERROR_MSG_CALL(((status == nullptr) && (captureMdl == nullptr)),
                                   RT_ERROR_INVALID_VALUE, "status and captureMdl cannot both be nullptr.");

    return impl_->StreamGetCaptureInfo(stm, status, captureMdl);
}

rtError_t ApiErrorDecorator::SetStreamCacheOpInfoSwitch(const Stream * const stm, uint32_t cacheOpInfoSwitch)
{
    Stream *curStm = Runtime::Instance()->GetCurStream(const_cast<Stream* const>(stm));
    NULL_PTR_RETURN_MSG_OUTER(curStm, RT_ERROR_INVALID_VALUE);
    if (cacheOpInfoSwitch != 0U && cacheOpInfoSwitch != 1U) {
        return RT_ERROR_INVALID_VALUE;
    }
    
    return impl_->SetStreamCacheOpInfoSwitch(curStm, cacheOpInfoSwitch);
}

rtError_t ApiErrorDecorator::GetStreamCacheOpInfoSwitch(const Stream * const stm, uint32_t * const cacheOpInfoSwitch)
{
    Stream *curStm = Runtime::Instance()->GetCurStream(const_cast<Stream* const>(stm));
    NULL_PTR_RETURN_MSG_OUTER(curStm, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(cacheOpInfoSwitch, RT_ERROR_INVALID_VALUE);
 
    return impl_->GetStreamCacheOpInfoSwitch(curStm, cacheOpInfoSwitch);
}

rtError_t ApiErrorDecorator::StreamBeginTaskUpdate(Stream * const stm, TaskGroup * handle)
{
    NULL_PTR_RETURN_MSG_OUTER(stm, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(handle, RT_ERROR_INVALID_VALUE);

    COND_RETURN_ERROR_MSG_INNER((stm->IsCapturing()),
        RT_ERROR_STREAM_CAPTURED, "the stream is capturing.");
    
    COND_RETURN_OUT_ERROR_MSG_CALL(stm->GetModelNum() != 0, RT_ERROR_STREAM_MODEL ,
        "only support single operator stream.");

    return impl_->StreamBeginTaskUpdate(stm, handle);
}

rtError_t ApiErrorDecorator::StreamEndTaskUpdate(Stream * const stm)
{
    NULL_PTR_RETURN_MSG_OUTER(stm, RT_ERROR_INVALID_VALUE);

    COND_RETURN_ERROR_MSG_INNER((stm->IsCapturing()),
        RT_ERROR_STREAM_CAPTURED, "the stream is capturing.");
    
    COND_RETURN_OUT_ERROR_MSG_CALL(stm->GetModelNum() != 0, RT_ERROR_STREAM_MODEL ,
        "only support single operator stream.");

    return impl_->StreamEndTaskUpdate(stm);
}

rtError_t ApiErrorDecorator::ModelGetNodes(const Model * const mdl, uint32_t * const num)
{
    NULL_PTR_RETURN_MSG_OUTER(mdl, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(num, RT_ERROR_INVALID_VALUE);

    return impl_->ModelGetNodes(mdl, num);
}

rtError_t ApiErrorDecorator::ModelDebugDotPrint(const Model * const mdl)
{
    NULL_PTR_RETURN_MSG_OUTER(mdl, RT_ERROR_INVALID_VALUE);

    return impl_->ModelDebugDotPrint(mdl);
}

rtError_t ApiErrorDecorator::ModelDebugJsonPrint(const Model * const mdl, const char* path, const uint32_t flags)
{
    NULL_PTR_RETURN_MSG_OUTER(mdl, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(path, RT_ERROR_INVALID_VALUE);

    return impl_->ModelDebugJsonPrint(mdl, path, flags);
}

rtError_t ApiErrorDecorator::StreamAddToModel(Stream * const stm, Model * const captureMdl)
{
    NULL_PTR_RETURN_MSG_OUTER(stm, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(captureMdl, RT_ERROR_INVALID_VALUE);
    COND_RETURN_ERROR_MSG_INNER(captureMdl->GetModelType() != RT_MODEL_CAPTURE_MODEL, RT_ERROR_INVALID_VALUE,
        "model does not support stream to model, modelType=%d .", captureMdl->GetModelType());
    
    COND_RETURN_ERROR_MSG_INNER(!StreamFlagIsSupportCapture(stm->Flags()), RT_ERROR_STREAM_INVALID,
        "stream flag does not support capture to model, flag=%u.", stm->Flags());

    return impl_->StreamAddToModel(stm, captureMdl);
}

rtError_t ApiErrorDecorator::ThreadExchangeCaptureMode(rtStreamCaptureMode * const mode)
{
    NULL_PTR_RETURN_MSG_OUTER(mode, RT_ERROR_INVALID_VALUE);
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM((static_cast<uint32_t>(*mode) >= RT_STREAM_CAPTURE_MODE_MAX), 
        RT_ERROR_INVALID_VALUE, *mode, "less than " + std::to_string(RT_STREAM_CAPTURE_MODE_MAX));

    return impl_->ThreadExchangeCaptureMode(mode);
}

rtError_t ApiErrorDecorator::StreamBeginTaskGrp(Stream * const stm)
{
    NULL_PTR_RETURN_MSG_OUTER(stm, RT_ERROR_INVALID_VALUE);
    COND_RETURN_ERROR_MSG_INNER((!stm->IsCapturing()),
        RT_ERROR_STREAM_NOT_CAPTURED, "the stream is not captured.");
    return impl_->StreamBeginTaskGrp(stm);
}

rtError_t ApiErrorDecorator::StreamEndTaskGrp(Stream * const stm, TaskGroup ** const handle)
{
    NULL_PTR_RETURN_MSG_OUTER(stm, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(handle, RT_ERROR_INVALID_VALUE);
    COND_RETURN_ERROR_MSG_INNER((!stm->IsCapturing()),
        RT_ERROR_STREAM_NOT_CAPTURED, "the stream is not captured.");
    return impl_->StreamEndTaskGrp(stm, handle);
}

rtError_t ApiErrorDecorator::DevMalloc(void ** const devPtr, const uint64_t size, rtMallocPolicy policy, rtMallocAdvise advise, 
                                       const rtMallocConfig_t * const cfg)
{
    NULL_PTR_RETURN_MSG_OUTER(devPtr, RT_ERROR_INVALID_VALUE);
    Runtime *rtInstance = Runtime::Instance();
    NULL_PTR_RETURN_MSG(rtInstance, RT_ERROR_INSTANCE_NULL);

    if (cfg != nullptr) {
        NULL_PTR_RETURN_MSG_OUTER(cfg->attrs, RT_ERROR_INVALID_VALUE);
    }
    const rtError_t error = impl_->DevMalloc(devPtr, size, policy, advise, cfg);
    RT_LOG(RT_LOG_INFO, "device malloc, size=%" PRIu64 "(bytes),  start ptr=0x%llx, end ptr=0x%llx",
        size, RtPtrToValue(*devPtr), (RtPtrToValue(*devPtr) + size));
    return error;
}

rtError_t ApiErrorDecorator::MemReserveAddress(void** virPtr, size_t size, rtMallocPolicy policy, void *expectAddr, rtMallocConfig_t *cfg)
{
    NULL_PTR_RETURN_MSG_OUTER(virPtr, RT_ERROR_INVALID_VALUE);
    ZERO_RETURN_AND_MSG_OUTER(size);
    COND_RETURN_ERROR_MSG_INNER((expectAddr != nullptr), RT_ERROR_INVALID_VALUE,
        "Invalid expectAddr, currently only null is supported.");
    COND_RETURN_ERROR_MSG_INNER((cfg != nullptr), RT_ERROR_INVALID_VALUE,
        "Invalid cfg, currently only null is supported.");
    return impl_->MemReserveAddress(virPtr, size, policy, expectAddr, cfg);
}
 
rtError_t ApiErrorDecorator::MemMallocPhysical(rtMemHandle* handle, size_t size, rtMallocPolicy policy, rtMallocConfig_t *cfg)
{
    ZERO_RETURN_AND_MSG_OUTER(size);

    if ((cfg != nullptr) && (cfg->attrs == nullptr)) {
        RT_LOG(RT_LOG_ERROR, "cfg is not nullptr, but attrs is nullptr");
        return RT_ERROR_INVALID_VALUE;
    }

    if (cfg == nullptr) { // only cfg is nullptr use default
        return impl_->MemMallocPhysical(handle, size, policy, cfg);
    }
 
    uint32_t deviceId = 0U;
    bool isSetDeviceId =false;
    for (uint32_t i = 0U; i < cfg->numAttrs; ++i) {
        if (cfg->attrs[i].attr == RT_MEM_MALLOC_ATTR_DEVICE_ID) {
            isSetDeviceId = true;
            deviceId = cfg->attrs[i].value.deviceId;
            break;
        }
    }
    if (isSetDeviceId == true) {
        const uint32_t userDeviceId = deviceId;
        rtError_t error = Runtime::Instance()->ChgUserDevIdToDeviceId(userDeviceId, &deviceId);
        COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, RT_ERROR_DEVICE_ID,
            "input error devId:%u is err:%#x", userDeviceId, static_cast<uint32_t>(RT_ERROR_DEVICE_ID));
        error = CheckDeviceIdIsValid(static_cast<int32_t>(deviceId));
        COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
            "drv devId is invalid, drv devId=%u, retCode=%#x", deviceId, static_cast<uint32_t>(error));
    }
    return impl_->MemMallocPhysical(handle, size, policy, cfg);
}

rtError_t ApiErrorDecorator::GetThreadLastTaskId(uint32_t * const taskId)
{
    NULL_PTR_RETURN_MSG_OUTER(taskId, RT_ERROR_INVALID_VALUE);

    return impl_->GetThreadLastTaskId(taskId);
}

rtError_t ApiErrorDecorator::LaunchDvppTask(const void * const sqe, const uint32_t sqeLen, Stream * const stm, rtDvppCfg_t *cfg)
{
    NULL_PTR_RETURN_MSG_OUTER(sqe, RT_ERROR_INVALID_VALUE);
    const rtError_t error = impl_->LaunchDvppTask(sqe, sqeLen, stm, cfg);
    ERROR_RETURN(error, "Stars launch dvpp task failed.");

    return error;
}

rtError_t ApiErrorDecorator::LaunchRandomNumTask(const rtRandomNumTaskInfo_t *taskInfo, Stream * const stm, void *reserve)
{
    NULL_PTR_RETURN_MSG_OUTER(taskInfo, RT_ERROR_INVALID_VALUE);
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM(reserve != nullptr, RT_ERROR_INVALID_VALUE, reserve, "nullptr");

    const rtError_t error = impl_->LaunchRandomNumTask(taskInfo, stm, reserve);
    ERROR_RETURN(error, "Stars launch dsa task failed.");

    return error;
}

rtError_t ApiErrorDecorator::KernelArgsInit(Kernel * const funcHandle, RtArgsHandle **argsHandle)
{
    NULL_PTR_RETURN_MSG_OUTER(funcHandle, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(argsHandle, RT_ERROR_INVALID_VALUE);

    const rtError_t error = impl_->KernelArgsInit(funcHandle, argsHandle);
    ERROR_RETURN(error, "kernel args init failed.");

    return error;
}

rtError_t ApiErrorDecorator::KernelArgsAppendPlaceHolder(RtArgsHandle *argsHandle, ParaDetail **paraHandle) 
{
    NULL_PTR_RETURN_MSG_OUTER(argsHandle, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(argsHandle->funcHandle, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(paraHandle, RT_ERROR_INVALID_VALUE);

    const rtError_t error = impl_->KernelArgsAppendPlaceHolder(argsHandle, paraHandle);
    ERROR_RETURN(error, "kernel args append ph failed.");

    return error;
}

rtError_t ApiErrorDecorator::KernelArgsGetPlaceHolderBuffer(RtArgsHandle *argsHandle, ParaDetail *paraHandle,
    size_t dataSize, void **bufferAddr)
{
    NULL_PTR_RETURN_MSG_OUTER(argsHandle, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(argsHandle->funcHandle, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(paraHandle, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(bufferAddr, RT_ERROR_INVALID_VALUE);
    ZERO_RETURN_AND_MSG_OUTER(dataSize);

    const rtError_t error = impl_->KernelArgsGetPlaceHolderBuffer(argsHandle, paraHandle, dataSize, bufferAddr);
    ERROR_RETURN(error, "kernel args get ph buffer failed.");

    return error;
}

rtError_t ApiErrorDecorator::KernelArgsGetHandleMemSize(Kernel * const funcHandle, size_t *memSize)
{
    NULL_PTR_RETURN_MSG_OUTER(funcHandle, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(memSize, RT_ERROR_INVALID_VALUE);

    const rtError_t error = impl_->KernelArgsGetHandleMemSize(funcHandle, memSize);
    ERROR_RETURN(error, "kernel args get handle mem size failed.");

    return error;
}

rtError_t ApiErrorDecorator::KernelArgsFinalize(RtArgsHandle *argsHandle)
{
    NULL_PTR_RETURN_MSG_OUTER(argsHandle, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(argsHandle->funcHandle, RT_ERROR_INVALID_VALUE);

    const rtError_t error = impl_->KernelArgsFinalize(argsHandle);
    ERROR_RETURN(error, "kernel args finalize failed.");

    return error;
}

rtError_t ApiErrorDecorator::KernelArgsInitByUserMem(Kernel * const funcHandle, RtArgsHandle *argsHandle, void *userHostMem,
        size_t actualArgsSize)
{
    NULL_PTR_RETURN_MSG_OUTER(funcHandle, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(argsHandle, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(userHostMem, RT_ERROR_INVALID_VALUE);
    ZERO_RETURN_AND_MSG_OUTER(actualArgsSize);

    const rtError_t error = impl_->KernelArgsInitByUserMem(funcHandle, argsHandle, userHostMem, actualArgsSize);
    ERROR_RETURN(error, "kernel args init by user mem failed.");

    return error;
}

rtError_t ApiErrorDecorator::KernelArgsGetMemSize(Kernel * const funcHandle, size_t userArgsSize, size_t *actualArgsSize)
{
    NULL_PTR_RETURN_MSG_OUTER(funcHandle, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(actualArgsSize, RT_ERROR_INVALID_VALUE);

    const rtError_t error = impl_->KernelArgsGetMemSize(funcHandle, userArgsSize, actualArgsSize);
    ERROR_RETURN(error, "kernel args get mem size failed.");
    return error;
}

rtError_t ApiErrorDecorator::KernelArgsAppend(RtArgsHandle *argsHandle, void *para, size_t paraSize, ParaDetail **paraHandle)
{
    NULL_PTR_RETURN_MSG_OUTER(argsHandle, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(para, RT_ERROR_INVALID_VALUE);
    ZERO_RETURN_AND_MSG_OUTER(paraSize);
    NULL_PTR_RETURN_MSG_OUTER(paraHandle, RT_ERROR_INVALID_VALUE);

    const rtError_t error = impl_->KernelArgsAppend(argsHandle, para, paraSize, paraHandle);
    ERROR_RETURN(error, "kernel args append failed.");
    return error;
}

rtError_t ApiErrorDecorator::MemWriteValue(const void * const devAddr, const uint64_t value, const uint32_t flag, Stream * const stm)
{
    NULL_PTR_RETURN_MSG_OUTER(devAddr, RT_ERROR_INVALID_VALUE);
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM((flag != 0U), RT_ERROR_INVALID_VALUE, flag, "0");

    rtError_t error = RT_ERROR_NONE;
    rtPtrAttributes_t attributes;
    error = impl_->PtrGetAttributes(devAddr, &attributes);
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_GE, error != RT_ERROR_NONE, error,
        "mem write value failed, get devAddr attributes failed, retCode=%#x", static_cast<uint32_t>(error));

    COND_RETURN_AND_MSG_OUTER_WITH_PARAM((attributes.location.type != RT_MEMORY_LOC_DEVICE), RT_ERROR_INVALID_VALUE, 
        attributes.location.type, std::to_string(RT_MEMORY_LOC_DEVICE));

    return impl_->MemWriteValue(devAddr, value, flag, stm);
}

rtError_t ApiErrorDecorator::MemWaitValue(const void * const devAddr, const uint64_t value, const uint32_t flag, Stream * const stm)
{
    NULL_PTR_RETURN_MSG_OUTER(devAddr, RT_ERROR_INVALID_VALUE);
	COND_RETURN_AND_MSG_OUTER_WITH_PARAM((flag >= static_cast<uint32_t>(MEM_WAIT_VALUE_TYPE_MAX)), RT_ERROR_INVALID_VALUE, 
        flag, "[0, " + std::to_string(static_cast<uint32_t>(MEM_WAIT_VALUE_TYPE_MAX)) + ")");    

    rtError_t error = RT_ERROR_NONE;
    rtPtrAttributes_t attributes;
    error = impl_->PtrGetAttributes(devAddr, &attributes);
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_GE, error != RT_ERROR_NONE, error,
        "mem wait value failed, get devAddr attributes failed, retCode=%#x", static_cast<uint32_t>(error));

    COND_RETURN_AND_MSG_OUTER_WITH_PARAM((attributes.location.type != RT_MEMORY_LOC_DEVICE), RT_ERROR_INVALID_VALUE, 
        attributes.location.type, std::to_string(RT_MEMORY_LOC_DEVICE));

    return impl_->MemWaitValue(devAddr, value, flag, stm);
}

rtError_t ApiErrorDecorator::MemcpyBatch(void **dsts, void **srcs, size_t *sizes, size_t count,
    rtMemcpyBatchAttr *attrs, size_t *attrsIdxs, size_t numAttrs, size_t *failIdx)
{
    NULL_PTR_RETURN_MSG_OUTER(failIdx, RT_ERROR_INVALID_VALUE);
    *failIdx = SIZE_MAX;
    NULL_PTR_RETURN_MSG_OUTER(dsts, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(srcs, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(sizes, RT_ERROR_INVALID_VALUE);
    ZERO_RETURN_AND_MSG_OUTER(count);
    NULL_PTR_RETURN_MSG_OUTER(attrs, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(attrsIdxs, RT_ERROR_INVALID_VALUE);
    ZERO_RETURN_AND_MSG_OUTER(numAttrs);
    COND_RETURN_OUT_ERROR_MSG_CALL((numAttrs > count), RT_ERROR_INVALID_VALUE,
        "Parameter numAttrs should be less than or equal to parameter count. Parameter numAttrs = %zu, parameter count = %zu.",
        numAttrs, count);
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM((count > static_cast<size_t>(DEVMM_MEMCPY_BATCH_MAX_COUNT)), 
        RT_ERROR_INVALID_VALUE, count, "less than or equal to " + std::to_string(static_cast<size_t>(DEVMM_MEMCPY_BATCH_MAX_COUNT)));
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM((attrsIdxs[0] != 0U), RT_ERROR_INVALID_VALUE, attrsIdxs[0], "0");
    for (size_t i = 1U; i < numAttrs; i++) {
        COND_RETURN_OUT_ERROR_MSG_CALL((attrsIdxs[i] <= attrsIdxs[i - 1U]),
            RT_ERROR_INVALID_VALUE, "Each entry in attrsIdxs must be greater than the previous entry. Parameter attrsIdxs[%zu] = %zu, attrsIdxs[%zu] = %zu.",
            i, attrsIdxs[i], i-1U, attrsIdxs[i - 1U]);
        COND_RETURN_OUT_ERROR_MSG_CALL((attrsIdxs[i] >= count),
            RT_ERROR_INVALID_VALUE, "Each entry in attrsIdxs must be less than the parameter count. Parameter attrsIdxs[%zu] = %zu, count = %zu.", 
            i, attrsIdxs[i], count);
    }

    const rtError_t error = impl_->MemcpyBatch(dsts, srcs, sizes, count, attrs, attrsIdxs, numAttrs, failIdx);
    COND_RETURN_ERROR((error != RT_ERROR_NONE) && (error != RT_ERROR_DRV_NOT_SUPPORT), error,
        "MemcpyBatch failed, retCode=%#x", error);
    return error;
}

rtError_t ApiErrorDecorator::MemcpyBatchAsync(void** const dsts, const size_t* const destMaxs, void** const srcs, const size_t* const sizes,
    const size_t count, const rtMemcpyBatchAttr* const attrs, const size_t* const attrsIdxs, const size_t numAttrs, size_t* const failIdx,
    Stream* const stm)
{
    NULL_PTR_RETURN_MSG_OUTER(failIdx, RT_ERROR_INVALID_VALUE);
    *failIdx = SIZE_MAX;
    NULL_PTR_RETURN_MSG_OUTER(dsts, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(destMaxs, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(srcs, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(sizes, RT_ERROR_INVALID_VALUE);
    ZERO_RETURN_AND_MSG_OUTER(count);
    NULL_PTR_RETURN_MSG_OUTER(attrs, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(attrsIdxs, RT_ERROR_INVALID_VALUE);
    ZERO_RETURN_AND_MSG_OUTER(numAttrs);

    COND_RETURN_OUT_ERROR_MSG_CALL((numAttrs > count), RT_ERROR_INVALID_VALUE,
        "Parameter numAttrs should be less than or equal to parameter count. Parameter numAttrs = %zd, parameter count = %zd.",
        numAttrs, count);

    COND_RETURN_AND_MSG_OUTER_WITH_PARAM((attrsIdxs[0] != 0U), RT_ERROR_INVALID_VALUE, attrsIdxs[0], "0");
    for (size_t i = 1U; i < numAttrs; i++) {
        COND_RETURN_OUT_ERROR_MSG_CALL((attrsIdxs[i] <= attrsIdxs[i - 1U]), RT_ERROR_INVALID_VALUE, 
            "Each entry in attrsIdxs must be greater than the previous entry. Parameter attrsIdxs[%zu] = %zu, attrsIdxs[%zu] = %zu.",
            i, attrsIdxs[i], i-1U, attrsIdxs[i - 1U]);
        COND_RETURN_OUT_ERROR_MSG_CALL((attrsIdxs[i] >= count), RT_ERROR_INVALID_VALUE, 
            "Each entry in attrsIdxs must be less than the parameter count. Parameter attrsIdxs[%zu] = %zu, count = %zu.", 
            i, attrsIdxs[i], count);
    }
    return impl_->MemcpyBatchAsync(dsts, destMaxs, srcs, sizes, count, attrs, attrsIdxs, numAttrs, failIdx, stm);
}

rtError_t ApiErrorDecorator::GetCmoDescSize(size_t *size)
{
    NULL_PTR_RETURN_MSG_OUTER(size, RT_ERROR_INVALID_VALUE);

    return impl_->GetCmoDescSize(size);
}

rtError_t ApiErrorDecorator::SetCmoDesc(rtCmoDesc_t cmoDesc, void *srcAddr, size_t srcLen)
{
    NULL_PTR_RETURN_MSG_OUTER(cmoDesc, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(srcAddr, RT_ERROR_INVALID_VALUE);
    ZERO_RETURN_AND_MSG_OUTER(srcLen);

    return impl_->SetCmoDesc(cmoDesc, srcAddr, srcLen);
}

rtError_t ApiErrorDecorator::ModelGetName(Model * const mdl, const uint32_t maxLen, char_t * const mdlName)
{
    NULL_PTR_RETURN_MSG_OUTER(mdl, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(mdlName, RT_ERROR_INVALID_VALUE);
    ZERO_RETURN_AND_MSG_OUTER(maxLen);
    const rtError_t error = impl_->ModelGetName(mdl, maxLen, mdlName);
    ERROR_RETURN(error, "get model name failed");
    return error;
}

rtError_t ApiErrorDecorator::FuncGetName(const Kernel * const kernel, const uint32_t maxLen, char_t * const name) 
{
    NULL_PTR_RETURN_MSG_OUTER(kernel, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(name, RT_ERROR_INVALID_VALUE);
    COND_RETURN_ERROR_MSG_INNER(maxLen < (kernel->Name_().length() + 1U), RT_ERROR_INVALID_VALUE,
        "the maxLen %u is smaller than func name length %zu", maxLen, kernel->Name_().length() + 1U);
    const rtError_t error = impl_->FuncGetName(kernel, maxLen, name);
    ERROR_RETURN(error, "get func name failed");
    return error;
}

rtError_t ApiErrorDecorator::GetErrorVerbose(const uint32_t deviceId, rtErrorInfo * const errorInfo)
{
    NULL_PTR_RETURN_MSG_OUTER(errorInfo, RT_ERROR_INVALID_VALUE);
    const Runtime * const rtInstance = Runtime::Instance();
    uint32_t realDeviceId = 0U;
    rtError_t error = rtInstance->ChgUserDevIdToDeviceId(deviceId, &realDeviceId);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "input error deviceId:%u is invalid, errcode=%#x", deviceId, static_cast<uint32_t>(error));
    
    int32_t deviceCnt = 0;
    const driverType_t rawDrvType = rtInstance->GetDriverType();
    Driver * const rawDrv = Runtime::Instance()->driverFactory_.GetDriver(rawDrvType);
    error = rawDrv->GetDeviceCount(&deviceCnt);
    ERROR_RETURN_MSG_CALL(ERR_MODULE_DRV, error, "Get device cnt failed, retCode=%#x", static_cast<uint32_t>(error));
    COND_RETURN_OUT_ERROR_MSG_CALL((realDeviceId >= static_cast<uint32_t>(deviceCnt)), RT_ERROR_DEVICE_ID,
        "invalid deviceId=%u, set drv devId=%u, valid device range is [0, %d)", deviceId, realDeviceId, deviceCnt);

    return impl_->GetErrorVerbose(realDeviceId, errorInfo);
}

rtError_t ApiErrorDecorator::RepairError(const uint32_t deviceId, const rtErrorInfo * const errorInfo)
{
    NULL_PTR_RETURN_MSG_OUTER(errorInfo, RT_ERROR_INVALID_VALUE);
    if (errorInfo->tryRepair == 0U) {
        RT_LOG(RT_LOG_ERROR, "Repair flag is invalid [%u], should be 1.", errorInfo->tryRepair);
        return RT_ERROR_INVALID_VALUE;
    }
    const Runtime * const rtInstance = Runtime::Instance();
    uint32_t realDeviceId = 0U;
    rtError_t error = rtInstance->ChgUserDevIdToDeviceId(deviceId, &realDeviceId);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "input error deviceId:%u is invalid, errcode=%#x", deviceId, static_cast<uint32_t>(error));
    
    int32_t deviceCnt = 0;
    const driverType_t rawDrvType = rtInstance->GetDriverType();
    Driver * const rawDrv = Runtime::Instance()->driverFactory_.GetDriver(rawDrvType);
    error = rawDrv->GetDeviceCount(&deviceCnt);
    ERROR_RETURN_MSG_CALL(ERR_MODULE_DRV, error, "Get device cnt failed, retCode=%#x", static_cast<uint32_t>(error));
    COND_RETURN_OUT_ERROR_MSG_CALL((realDeviceId >= static_cast<uint32_t>(deviceCnt)), RT_ERROR_DEVICE_ID,
        "invalid deviceId=%u, set drv devId=%u, valid device range is [0, %d)", deviceId, realDeviceId, deviceCnt);

    return impl_->RepairError(realDeviceId, errorInfo);
}

rtError_t ApiErrorDecorator::CheckMemType(void **addrs, uint32_t size, uint32_t memType, uint32_t *checkResult, uint32_t reserve)
{
    NULL_PTR_RETURN_MSG_OUTER(checkResult, RT_ERROR_INVALID_VALUE);
    *checkResult = 0U;
    NULL_PTR_RETURN_MSG_OUTER(addrs, RT_ERROR_INVALID_VALUE);
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM(reserve != 0U, RT_ERROR_INVALID_VALUE, reserve, "0");
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM(size <= 0U, RT_ERROR_INVALID_VALUE, size, "greater than 0");
    constexpr  uint32_t tmpMemType = RT_MEM_MASK_DEV_TYPE | RT_MEM_MASK_RSVD_TYPE | RT_MEM_MASK_DVPP_TYPE;
    COND_RETURN_OUT_ERROR_MSG_CALL((memType & ~tmpMemType) != 0U, RT_ERROR_INVALID_VALUE,
                        "Invalid memType. Only DEV(0x2), DVPP(0x8), RDSV(0x10), or a combination of them is supported. type=%u.", memType);
    return impl_->CheckMemType(addrs, size, memType, checkResult, reserve);
}

rtError_t ApiErrorDecorator::GetMemUsageInfo(const uint32_t deviceId, rtMemUsageInfo_t * const memUsageInfo,
                                             const size_t inputNum, size_t * const outputNum)
{
    NULL_PTR_RETURN_MSG_OUTER(outputNum, RT_ERROR_INVALID_VALUE);
    *outputNum = 0U;
    NULL_PTR_RETURN_MSG_OUTER(memUsageInfo, RT_ERROR_INVALID_VALUE);
    ZERO_RETURN_MSG_OUTER(inputNum);
    rtError_t error;
    uint32_t realDeviceId = 0U;
    error = Runtime::Instance()->ChgUserDevIdToDeviceId(deviceId, &realDeviceId);
    COND_RETURN_OUT_ERROR_MSG_CALL(error != RT_ERROR_NONE, error, "input error deviceId:%u, errCode:%#x",
        deviceId, static_cast<uint32_t>(error));
    error = CheckDeviceIdIsValid(realDeviceId);
    COND_RETURN_OUT_ERROR_MSG_CALL(error != RT_ERROR_NONE, error, "Device ID is invalid, drv devId=%u, retCode=%#x",
        realDeviceId, static_cast<uint32_t>(error));
    return impl_->GetMemUsageInfo(realDeviceId, memUsageInfo, inputNum, outputNum);
}

rtError_t ApiErrorDecorator::LaunchHostFunc(Stream * const stm, const rtCallback_t callBackFunc, void * const fnData)
{
    NULL_PTR_RETURN_MSG_OUTER(callBackFunc, RT_ERROR_INVALID_VALUE);
    COND_RETURN_OUT_ERROR_MSG_CALL((stm != nullptr) && (stm->GetSubscribeFlag() == StreamSubscribeFlag::SUBSCRIBE_USER), RT_ERROR_SUBSCRIBE_STREAM,
        "The stream is in the subscribe callback process and cannot call rtsLaunchHostFunc, flag=SUBSCRIBE_USER, stream_id=%d", stm->Id_());
    return impl_->LaunchHostFunc(stm, callBackFunc, fnData);
}

rtError_t ApiErrorDecorator::CacheLastTaskOpInfo(const void * const infoPtr, const size_t infoSize)
{
    NULL_PTR_RETURN_MSG_OUTER(infoPtr, RT_ERROR_INVALID_VALUE);
	COND_RETURN_AND_MSG_OUTER_WITH_PARAM((infoSize == 0U || infoSize > MAX_SHAPE_INFO_SIZE), RT_ERROR_INVALID_VALUE, 
        infoSize, "(0, " + std::to_string(MAX_SHAPE_INFO_SIZE) + "]");
    return impl_->CacheLastTaskOpInfo(infoPtr, infoSize);
}

rtError_t ApiErrorDecorator::FunctionGetAttribute(rtFuncHandle funcHandle, rtFuncAttribute attrType, int64_t *attrValue)
{
    NULL_PTR_RETURN_MSG_OUTER(funcHandle, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(attrValue, RT_ERROR_INVALID_VALUE);
	COND_RETURN_AND_MSG_OUTER_WITH_PARAM(((static_cast<uint32_t>(attrType) < RT_FUNCTION_ATTR_KERNEL_TYPE) ||
        (static_cast<uint32_t>(attrType) >= RT_FUNCTION_ATTR_MAX)), RT_ERROR_INVALID_VALUE, 
        attrType, "[" + std::to_string(RT_FUNCTION_ATTR_KERNEL_TYPE) + ", " + std::to_string(RT_FUNCTION_ATTR_MAX) + ")");

    return impl_->FunctionGetAttribute(funcHandle, attrType, attrValue);
}

rtError_t ApiErrorDecorator::MemRetainAllocationHandle(void* virPtr, rtDrvMemHandle *handle)
{
    NULL_PTR_RETURN_MSG_OUTER(virPtr, RT_ERROR_INVALID_VALUE);
    return impl_->MemRetainAllocationHandle(virPtr, handle);
}

rtError_t ApiErrorDecorator::MemGetAllocationPropertiesFromHandle(rtDrvMemHandle handle, rtDrvMemProp_t* prop)
{
    NULL_PTR_RETURN_MSG_OUTER(handle, RT_ERROR_INVALID_VALUE);
    return impl_->MemGetAllocationPropertiesFromHandle(handle, prop);
}

rtError_t ApiErrorDecorator::MemGetAddressRange(void *ptr, void **pbase, size_t *psize)
{
    NULL_PTR_RETURN_MSG_OUTER(ptr, RT_ERROR_INVALID_VALUE);
    COND_RETURN_OUT_ERROR_MSG_CALL((pbase == nullptr) && (psize == nullptr),
        RT_ERROR_INVALID_VALUE, 
        "pbase and psize cannot be null simultaneously.");
    return impl_->MemGetAddressRange(ptr, pbase, psize);
}

rtError_t ApiErrorDecorator::BinarySetExceptionCallback(Program *binHandle, void *callback, void *userData)
{
    NULL_PTR_RETURN_MSG_OUTER(binHandle, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(callback, RT_ERROR_INVALID_VALUE);
    /* userData为预留字段, 当前不进行非空校验 */
    return impl_->BinarySetExceptionCallback(binHandle, callback, userData);
}

rtError_t ApiErrorDecorator::GetFuncHandleFromExceptionInfo(const rtExceptionInfo_t *info, Kernel ** const funcHandle)
{
    NULL_PTR_RETURN_MSG_OUTER(info, RT_ERROR_INVALID_VALUE);
    return impl_->GetFuncHandleFromExceptionInfo(info, funcHandle);
}

}  // namespace runtime
}  // namespace cce
