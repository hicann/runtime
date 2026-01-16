/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "inner.hpp"
#include "error_message_manage.hpp"
#include "runtime/mem.h"
#include "runtime/rt_ffts_plus.h"
#include "runtime/kernel.h"
#include "rt_stars.h"
#include "api_c.h"
#include "global_state_manager.hpp"

using namespace cce::runtime;

namespace cce {
namespace runtime {

// general ctrl num
enum rtGeneralCtrlNum_t {
    RT_GNL_CTRL_NUM_MEMCPY_ASYNC_CFG = 7U,
    RT_GNL_CTRL_NUM_REDUCE_ASYNC_CFG = 8U,
    RT_GNL_CTRL_NUM_FFTS_PLUS_FLAG = 3U,
    RT_GNL_CTRL_NUM_FFTS_PLUS = 2U,
    RT_GNL_CTRL_NUM_NPU_GET_FLOAT_STATUS = 4U,
    RT_GNL_CTRL_NUM_NPU_CLEAR_FLOAT_STATUS = 2U,
    RT_GNL_CTRL_NUM_STARS_TSK = 3U,
    RT_GNL_CTRL_NUM_CMO_TSK = 3U,
    RT_GNL_CTRL_NUM_BARRIER_TSK = 3U,
    RT_GNL_CTRL_NUM_MULTIPLE_TSK_FLAG = 3U,
    RT_GNL_CTRL_NUM_STARS_TSK_FLAG = 4U,
    RT_GNL_CTRL_NUM_SET_STREAM_TAG_TSK = 2U,
    RT_GNL_CTRL_NUM_MULTIPLE_TSK = 2U,
    RT_GNL_CTRL_NUM_INVALID = 0U,
} ;

constexpr uint32_t GNL_CTRL_PARAM_0 = 0U;
constexpr uint32_t GNL_CTRL_PARAM_1 = 1U;
constexpr uint32_t GNL_CTRL_PARAM_2 = 2U;
constexpr uint32_t GNL_CTRL_PARAM_3 = 3U;
constexpr uint32_t GNL_CTRL_PARAM_4 = 4U;
constexpr uint32_t GNL_CTRL_PARAM_5 = 5U;
constexpr uint32_t GNL_CTRL_PARAM_6 = 6U;
constexpr uint32_t GNL_CTRL_PARAM_7 = 7U;

rtError_t rtMemcpyAsyncWithCfgCtrl(uintptr_t * const ctl, const uint32_t num)
{
    UNUSED(num);
    return rtMemcpyAsyncWithCfg(RtPtrToPtr<void *>(ctl[GNL_CTRL_PARAM_0]),
                                static_cast<uint64_t>(ctl[GNL_CTRL_PARAM_1]),
                                RtPtrToPtr<const void *>(ctl[GNL_CTRL_PARAM_2]),
                                static_cast<uint64_t>(ctl[GNL_CTRL_PARAM_3]),
                                static_cast<rtMemcpyKind_t>(ctl[GNL_CTRL_PARAM_4]),
                                RtPtrToPtr<rtStream_t>(ctl[GNL_CTRL_PARAM_5]),
                                static_cast<uint32_t>(ctl[GNL_CTRL_PARAM_6]));
}

rtError_t rtReduceAsyncWithCfgCtrl(uintptr_t * const ctl, const uint32_t num)
{
    UNUSED(num);
    return rtReduceAsyncWithCfg(RtPtrToPtr<void *>(ctl[GNL_CTRL_PARAM_0]),
                                static_cast<uint64_t>(ctl[GNL_CTRL_PARAM_1]),
                                RtPtrToPtr<const void *>(ctl[GNL_CTRL_PARAM_2]),
                                static_cast<uint64_t>(ctl[GNL_CTRL_PARAM_3]),
                                static_cast<rtRecudeKind_t>(ctl[GNL_CTRL_PARAM_4]),
                                static_cast<rtDataType_t>(ctl[GNL_CTRL_PARAM_5]),
                                RtPtrToPtr<rtStream_t>(ctl[GNL_CTRL_PARAM_6]),
                                static_cast<uint32_t>(ctl[GNL_CTRL_PARAM_7]));
}

rtError_t rtFftsPlusTaskLaunchWithFlagCtrl(uintptr_t * const ctl, const uint32_t num)
{
    UNUSED(num);
    return rtFftsPlusTaskLaunchWithFlag(RtPtrToPtr<rtFftsPlusTaskInfo_t *>(ctl[GNL_CTRL_PARAM_0]),
                                        RtPtrToPtr<rtStream_t>(ctl[GNL_CTRL_PARAM_1]),
                                        static_cast<uint32_t>(ctl[GNL_CTRL_PARAM_2]));
}

rtError_t rtFftsPlusTaskLaunchCtrl(uintptr_t * const ctl, const uint32_t num)
{
    UNUSED(num);
    return rtFftsPlusTaskLaunch(RtPtrToPtr<rtFftsPlusTaskInfo_t *>(ctl[GNL_CTRL_PARAM_0]),
                                RtPtrToPtr<rtStream_t>(ctl[GNL_CTRL_PARAM_1]));
}

rtError_t rtNpuGetFloatStatusCtrl(uintptr_t * const ctl, const uint32_t num)
{
    UNUSED(num);
    return rtNpuGetFloatStatus(RtPtrToPtr<void *>(ctl[GNL_CTRL_PARAM_0]),
                               static_cast<uint64_t>(ctl[GNL_CTRL_PARAM_1]),
                               static_cast<uint32_t>(ctl[GNL_CTRL_PARAM_2]),
                               RtPtrToPtr<rtStream_t>(ctl[GNL_CTRL_PARAM_3]));
}

rtError_t rtNpuClearFloatStatusCtrl(uintptr_t * const ctl, const uint32_t num)
{
    UNUSED(num);
    return rtNpuClearFloatStatus(static_cast<uint32_t>(ctl[GNL_CTRL_PARAM_0]),
                                 RtPtrToPtr<rtStream_t>(ctl[GNL_CTRL_PARAM_1]));
}

rtError_t rtNpuGetFloatDebugStatusCtrl(uintptr_t * const ctl, const uint32_t num)
{
    UNUSED(num);
    return rtNpuGetFloatDebugStatus(RtPtrToPtr<void *>(ctl[GNL_CTRL_PARAM_0]),
                                    static_cast<uint64_t>(ctl[GNL_CTRL_PARAM_1]),
                                    static_cast<uint32_t>(ctl[GNL_CTRL_PARAM_2]),
                                    RtPtrToPtr<rtStream_t>(ctl[GNL_CTRL_PARAM_3]));
}

rtError_t rtNpuClearFloatDebugStatusCtrl(uintptr_t * const ctl, const uint32_t num)
{
    UNUSED(num);
    return rtNpuClearFloatDebugStatus(static_cast<uint32_t>(ctl[GNL_CTRL_PARAM_0]),
                                      RtPtrToPtr<rtStream_t>(ctl[GNL_CTRL_PARAM_1]));
}

rtError_t rtStarsTaskLaunchCtrl(uintptr_t * const ctl, uint32_t const num)
{
    UNUSED(num);
    return rtStarsTaskLaunch(RtPtrToPtr<const void *>(ctl[GNL_CTRL_PARAM_0]),
                             static_cast<uint32_t>(ctl[GNL_CTRL_PARAM_1]),
                             RtPtrToPtr<rtStream_t>(ctl[GNL_CTRL_PARAM_2]));
}

rtError_t rtCmoTaskLaunchCtrl(uintptr_t * const ctl, const uint32_t num)
{
    UNUSED(num);
    return rtCmoTaskLaunch(RtPtrToPtr<rtCmoTaskInfo_t *>(ctl[GNL_CTRL_PARAM_0]),
                           RtPtrToPtr<rtStream_t>(ctl[GNL_CTRL_PARAM_1]),
                           static_cast<uint32_t>(ctl[GNL_CTRL_PARAM_2]));
}

rtError_t rtBarrierTaskLaunchCtrl(uintptr_t * const ctl, const uint32_t num)
{
    UNUSED(num);
    return rtBarrierTaskLaunch(RtPtrToPtr<rtBarrierTaskInfo_t *>(ctl[GNL_CTRL_PARAM_0]),
                               RtPtrToPtr<rtStream_t>(ctl[GNL_CTRL_PARAM_1]),
                               static_cast<uint32_t>(ctl[GNL_CTRL_PARAM_2]));
}

rtError_t rtStarsTaskLaunchWithFlagCtrl(uintptr_t * const ctl, const uint32_t num)
{
    UNUSED(num);
    return rtStarsTaskLaunchWithFlag(RtPtrToPtr<const void *>(ctl[GNL_CTRL_PARAM_0]),
                                     static_cast<uint32_t>(ctl[GNL_CTRL_PARAM_1]),
                                     RtPtrToPtr<rtStream_t>(ctl[GNL_CTRL_PARAM_2]),
                                     static_cast<uint32_t>(ctl[GNL_CTRL_PARAM_3]));
}

rtError_t rtSetStreamTagCtrl(uintptr_t * const ctl, const uint32_t num)
{
    UNUSED(num);
    return rtSetStreamTag(RtPtrToPtr<rtStream_t>(ctl[GNL_CTRL_PARAM_0]),
                          static_cast<uint32_t>(ctl[GNL_CTRL_PARAM_1]));
}

rtError_t rtMultipleTaskInfoLaunchCtrl(uintptr_t * const ctl, const uint32_t num)
{
    UNUSED(num);
    return rtMultipleTaskInfoLaunch(RtPtrToPtr<const void *>(ctl[GNL_CTRL_PARAM_0]),
                                    RtPtrToPtr<rtStream_t>(ctl[GNL_CTRL_PARAM_1]));
}

rtError_t rtMultipleTaskInfoLaunchWithFlagCtrl(uintptr_t * const ctl, const uint32_t num)
{
    UNUSED(num);
    return rtMultipleTaskInfoLaunchWithFlag(RtPtrToPtr<const void *>(ctl[GNL_CTRL_PARAM_0]),
                                            RtPtrToPtr<rtStream_t>(ctl[GNL_CTRL_PARAM_1]),
                                            static_cast<uint32_t>(ctl[GNL_CTRL_PARAM_2]));
}

typedef rtError_t (*rtGeneralCtrlFuncPtr)(uintptr_t *ctl, uint32_t num);


typedef struct rtGeneralCtrlFuncInfo {
    rtGeneralCtrlFuncPtr funcCall;
    rtGeneralCtrlNum_t num;
} rtGeneralCtrlFunc;

static rtGeneralCtrlFunc g_genCtrPro[] = {
    {rtMemcpyAsyncWithCfgCtrl, RT_GNL_CTRL_NUM_MEMCPY_ASYNC_CFG},
    {rtReduceAsyncWithCfgCtrl, RT_GNL_CTRL_NUM_REDUCE_ASYNC_CFG},
    {rtFftsPlusTaskLaunchWithFlagCtrl, RT_GNL_CTRL_NUM_FFTS_PLUS_FLAG},
    {rtFftsPlusTaskLaunchCtrl, RT_GNL_CTRL_NUM_FFTS_PLUS},
    {rtNpuGetFloatStatusCtrl, RT_GNL_CTRL_NUM_NPU_GET_FLOAT_STATUS},
    {rtNpuClearFloatStatusCtrl, RT_GNL_CTRL_NUM_NPU_CLEAR_FLOAT_STATUS},
    {rtStarsTaskLaunchCtrl, RT_GNL_CTRL_NUM_STARS_TSK},
    {nullptr, RT_GNL_CTRL_NUM_INVALID},
    {nullptr, RT_GNL_CTRL_NUM_INVALID},
    {rtCmoTaskLaunchCtrl, RT_GNL_CTRL_NUM_CMO_TSK},
    {rtBarrierTaskLaunchCtrl, RT_GNL_CTRL_NUM_BARRIER_TSK},
    {rtStarsTaskLaunchWithFlagCtrl, RT_GNL_CTRL_NUM_STARS_TSK_FLAG},
    {rtSetStreamTagCtrl, RT_GNL_CTRL_NUM_SET_STREAM_TAG_TSK},
    {rtMultipleTaskInfoLaunchCtrl, RT_GNL_CTRL_NUM_MULTIPLE_TSK},
    {rtNpuGetFloatDebugStatusCtrl, RT_GNL_CTRL_NUM_NPU_GET_FLOAT_STATUS},
    {rtNpuClearFloatDebugStatusCtrl, RT_GNL_CTRL_NUM_NPU_CLEAR_FLOAT_STATUS},
    {rtMultipleTaskInfoLaunchWithFlagCtrl, RT_GNL_CTRL_NUM_MULTIPLE_TSK_FLAG},
};

rtError_t rtGeneralCtrlInner(uintptr_t *ctl, uint32_t num, uint32_t type)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    PARAM_NULL_RETURN_ERROR_WITH_EXT_ERRCODE(ctl, RT_ERROR_INVALID_VALUE);
    COND_RETURN_EXT_ERRCODE_AND_MSG_OUTER_WITH_PARAM((type >= static_cast<uint32_t>(RT_GNL_CTRL_TYPE_MAX)), RT_ERROR_INVALID_VALUE, 
        type, "less than " + std::to_string(RT_GNL_CTRL_TYPE_MAX));

    COND_RETURN_EXT_ERRCODE_AND_MSG_OUTER((g_genCtrPro[type].funcCall == nullptr), RT_ERROR_INVALID_VALUE,
        ErrorCode::EE1001, "current type[" + std::to_string(type) + "] func call is nullptr.");

    COND_RETURN_EXT_ERRCODE_AND_MSG_OUTER_WITH_PARAM((num != static_cast<uint32_t>(g_genCtrPro[type].num)), RT_ERROR_INVALID_VALUE, 
        num, std::to_string(g_genCtrPro[type].num));
    return g_genCtrPro[type].funcCall(ctl, num);
}

}  // namespace runtime
}  // namespace cce
