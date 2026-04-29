/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "api_c.h"
#include "api.hpp"
#include "api_handle_guard.h"
#include "base.hpp"
#include "error_message_manage.hpp"
#include "errcode_manage.hpp"
#include "error_code.h"
#include "inner.hpp"
#include "osal.hpp"
#include "notify.hpp"
#include "count_notify.hpp"
#include "runtime.hpp"
#include "thread_local_container.hpp"
#include "global_state_manager.hpp"

using namespace cce::runtime;

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

VISIBILITY_DEFAULT
rtError_t rtCntNotifyCreate(const int32_t deviceId, rtCntNotify_t * const cntNotify)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->CntNotifyCreate(deviceId, RtPtrToPtr<CountNotify **>(cntNotify));
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    CountNotify *realCountNotify = RtPtrToPtr<CountNotify *>(*cntNotify);
    *cntNotify = ExportEmbeddedHandle<rtCntNotify_t>(realCountNotify);
    return error;
}

VISIBILITY_DEFAULT
rtError_t rtCntNotifyCreateWithFlag(const int32_t deviceId, rtCntNotify_t * const cntNotify, const uint32_t flags)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->CntNotifyCreate(deviceId, RtPtrToPtr<CountNotify **>(cntNotify), flags);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    CountNotify *realCountNotify = RtPtrToPtr<CountNotify *>(*cntNotify);
    *cntNotify = ExportEmbeddedHandle<rtCntNotify_t>(realCountNotify);
    return error;
}

VISIBILITY_DEFAULT
rtError_t rtCntNotifyRecord(rtCntNotify_t const inCntNotify, rtStream_t const stm,
                            const rtCntNtyRecordInfo_t * const info)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    RT_VALIDATE_AND_UNWRAP_OBJECT(inCntNotify, CountNotify, notifyPtr);
    RT_VALIDATE_AND_UNWRAP_OBJECT(stm, Stream, exeStream);
    const rtError_t error = apiInstance->CntNotifyRecord(notifyPtr, exeStream, info);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);

    return error;
}

VISIBILITY_DEFAULT
rtError_t rtCntNotifyWaitWithTimeout(rtCntNotify_t const inCntNotify, rtStream_t const stm,
                                     const rtCntNtyWaitInfo_t * const info)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    RT_VALIDATE_AND_UNWRAP_OBJECT(inCntNotify, CountNotify, notifyPtr);
    RT_VALIDATE_AND_UNWRAP_OBJECT(stm, Stream, exeStream);
    const rtError_t error = apiInstance->CntNotifyWaitWithTimeout(notifyPtr, exeStream, info);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);

    return error;
}

VISIBILITY_DEFAULT
rtError_t rtCntNotifyReset(rtCntNotify_t const inCntNotify, rtStream_t const stm)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    RT_VALIDATE_AND_UNWRAP_OBJECT(inCntNotify, CountNotify, notifyPtr);
    RT_VALIDATE_AND_UNWRAP_OBJECT(stm, Stream, exeStream);
    const rtError_t error = apiInstance->CntNotifyReset(notifyPtr, exeStream);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);

    return error;
}

VISIBILITY_DEFAULT
rtError_t rtCntNotifyDestroy(rtCntNotify_t const inCntNotify)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    RT_VALIDATE_AND_UNWRAP_OBJECT(inCntNotify, CountNotify, notifyPtr);
    const rtError_t error = apiInstance->CntNotifyDestroy(notifyPtr);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);

    return error;
}

VISIBILITY_DEFAULT
rtError_t rtGetCntNotifyAddress(rtCntNotify_t const inCntNotify, uint64_t * const cntNotifyAddress,
                                rtNotifyType_t const regType)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    RT_VALIDATE_AND_UNWRAP_OBJECT(inCntNotify, CountNotify, notifyPtr);
    const rtError_t error = apiInstance->GetCntNotifyAddress(notifyPtr, cntNotifyAddress, regType);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);

    return error;
}

VISIBILITY_DEFAULT
rtError_t rtGetCntNotifyId(rtCntNotify_t inCntNotify, uint32_t * const notifyId)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    RT_VALIDATE_AND_UNWRAP_OBJECT(inCntNotify, CountNotify, notifyPtr);
    const rtError_t error = apiInstance->GetCntNotifyId(notifyPtr, notifyId);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);

    return error;
}

VISIBILITY_DEFAULT
rtError_t rtCntNotifyCreateServer(rtCntNotify_t * const cntNotify, uint64_t flags)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    COND_RETURN_EXT_ERRCODE_AND_MSG_OUTER_WITH_PARAM(flags != 0ULL, RT_ERROR_INVALID_VALUE, flags, "0");
    int32_t deviceId = 0;
    const rtError_t rtRet = rtGetDevice(&deviceId);
    if (unlikely((rtRet) != ACL_RT_SUCCESS)) {
        return rtRet;
    }
 
    return rtCntNotifyCreateWithFlag(deviceId, cntNotify, static_cast<uint32_t>(flags));
}

VISIBILITY_DEFAULT
rtError_t rtsCntNotifyRecord(rtCntNotify_t cntNotify, rtStream_t stm, rtCntNotifyRecordInfo_t *info)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    RT_VALIDATE_AND_UNWRAP_OBJECT(cntNotify, CountNotify, notifyPtr);
    RT_VALIDATE_AND_UNWRAP_OBJECT(stm, Stream, exeStream);
    const rtError_t error = apiInstance->CntNotifyRecord(notifyPtr,
        exeStream, RtPtrToPtr<rtCntNtyRecordInfo_t *>(info));
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return error;
}

VISIBILITY_DEFAULT
rtError_t rtsCntNotifyWaitWithTimeout(rtCntNotify_t cntNotify, rtStream_t stm,
                                      rtCntNotifyWaitInfo_t *info)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    RT_VALIDATE_AND_UNWRAP_OBJECT(cntNotify, CountNotify, notifyPtr);
    RT_VALIDATE_AND_UNWRAP_OBJECT(stm, Stream, exeStream);
    const rtError_t error = apiInstance->CntNotifyWaitWithTimeout(notifyPtr,
        exeStream, RtPtrToPtr<rtCntNtyWaitInfo_t *>(info));
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return error;
}

VISIBILITY_DEFAULT
rtError_t rtsCntNotifyReset(rtCntNotify_t cntNotify, rtStream_t stm)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    RT_VALIDATE_AND_UNWRAP_OBJECT(cntNotify, CountNotify, notifyPtr);
    RT_VALIDATE_AND_UNWRAP_OBJECT(stm, Stream, exeStream);
    const rtError_t error = apiInstance->CntNotifyReset(notifyPtr, exeStream);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return error;
}

VISIBILITY_DEFAULT
rtError_t rtsCntNotifyGetId(rtCntNotify_t cntNotify, uint32_t *notifyId)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    RT_VALIDATE_AND_UNWRAP_OBJECT(cntNotify, CountNotify, notifyPtr);
    const rtError_t error = apiInstance->GetCntNotifyId(notifyPtr, notifyId);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return error;
}

VISIBILITY_DEFAULT
rtError_t rtUbDbSend(rtUbDbInfo_t *dbInfo,  rtStream_t stm)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    RT_VALIDATE_AND_UNWRAP_OBJECT(stm, Stream, exeStream);
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->UbDbSend(dbInfo, exeStream);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return error;
}

VISIBILITY_DEFAULT
rtError_t rtUbDirectSend(rtUbWqeInfo_t *wqeInfo, rtStream_t stm)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    RT_VALIDATE_AND_UNWRAP_OBJECT(stm, Stream, exeStream);
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->UbDirectSend(wqeInfo, exeStream);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return error;
}

VISIBILITY_DEFAULT
rtError_t rtFusionLaunch(void * const fusionInfo, rtStream_t const stm, rtFusionArgsEx_t *argsInfo)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    RT_VALIDATE_AND_UNWRAP_OBJECT(stm, Stream, exeStream);
    const rtError_t error = apiInstance->FusionLaunch(fusionInfo, exeStream, argsInfo);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtCCULaunch(rtCcuTaskInfo_t *taskInfo,  rtStream_t const stm)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    RT_VALIDATE_AND_UNWRAP_OBJECT(stm, Stream, exeStream);
    const rtError_t error = apiInstance->CCULaunch(taskInfo, exeStream);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);

    return error;
}

VISIBILITY_DEFAULT
rtError_t rtUbDevQueryInfo(rtUbDevQueryCmd cmd, void * devInfo)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->UbDevQueryInfo(cmd, devInfo);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);

    return error;
}

VISIBILITY_DEFAULT
rtError_t rtGetDevResAddress(rtDevResInfo * const resInfo, rtDevResAddrInfo * const addrInfo)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->GetDevResAddress(resInfo, addrInfo);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);

    return error;
}

VISIBILITY_DEFAULT
rtError_t rtReleaseDevResAddress(rtDevResInfo * const resInfo)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->ReleaseDevResAddress(resInfo);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);

    return error;
}

#ifdef __cplusplus
}
#endif // __cplusplus
