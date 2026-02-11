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

#include "runtime/event.h"
#include "runtime/base.h"
#include "runtime/rts/rts_event.h"

#include "common/log_inner.h"
#include "common/error_codes_inner.h"
#include "common/prof_reporter.h"

aclError aclrtCreateNotifyImpl(aclrtNotify *notify, uint64_t flag)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtCreateNotify);
    ACL_LOG_INFO("start to execute aclrtCreateNotify, flag is [%lu]", flag);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(notify);

    const rtError_t rtErr = rtsNotifyCreate(static_cast<rtNotify_t*>(notify), flag);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("call rtsNotifyCreate failed, runtime result = %d", rtErr);
        return ACL_GET_ERRCODE_RTS(rtErr);
    }

    ACL_LOG_INFO("successfully execute aclrtCreateNotify");
    return ACL_SUCCESS;
}

aclError aclrtDestroyNotifyImpl(aclrtNotify notify)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtDestroyNotify);
    ACL_LOG_INFO("start to execute aclrtDestroyNotify");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(notify);

    const rtError_t rtErr = rtsNotifyDestroy(static_cast<rtNotify_t>(notify));
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("call rtsNotifyDestroy failed, runtime result = %d", rtErr);
        return ACL_GET_ERRCODE_RTS(rtErr);
    }

    ACL_LOG_INFO("successfully execute aclrtDestroyNotify");
    return ACL_SUCCESS;
}

aclError aclrtRecordNotifyImpl(aclrtNotify notify, aclrtStream stream)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtRecordNotify);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(notify);

    const rtError_t rtErr = rtsNotifyRecord(static_cast<rtNotify_t>(notify), static_cast<rtStream_t>(stream));
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("call rtsNotifyRecord failed, runtime result = %d", rtErr);
        return ACL_GET_ERRCODE_RTS(rtErr);
    }

    return ACL_SUCCESS;
}

aclError aclrtWaitAndResetNotifyImpl(aclrtNotify notify, aclrtStream stream, uint32_t timeout)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtWaitAndResetNotify);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(notify);

    const rtError_t rtErr = rtsNotifyWaitAndReset(static_cast<rtNotify_t>(notify),
        static_cast<rtStream_t>(stream), timeout);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("call rtsNotifyWaitAndReset failed, runtime result = %d", rtErr);
        return ACL_GET_ERRCODE_RTS(rtErr);
    }

    return ACL_SUCCESS;
}

aclError aclrtGetNotifyIdImpl(aclrtNotify notify, uint32_t *notifyId)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtGetNotifyId);
    ACL_LOG_INFO("start to execute aclrtGetNotifyId");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(notify);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(notifyId);

    const rtError_t rtErr = rtsNotifyGetId(static_cast<rtNotify_t>(notify), notifyId);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("call rtsNotifyGetId failed, runtime result = %d", rtErr);
        return ACL_GET_ERRCODE_RTS(rtErr);
    }

    ACL_LOG_INFO("successfully execute aclrtGetNotifyId");
    return ACL_SUCCESS;
}

aclError aclrtNotifyBatchResetImpl(aclrtNotify *notifies, size_t num)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtNotifyBatchReset);
    ACL_LOG_INFO("start to execute aclrtNotifyBatchReset, num is [%zu]", num);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(notifies);

    const rtError_t rtErr = rtsNotifyBatchReset(notifies, static_cast<uint32_t>(num));
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("call rtsNotifyBatchReset failed, runtime result = %d", rtErr);
        return ACL_GET_ERRCODE_RTS(rtErr);
    }

    ACL_LOG_INFO("successfully execute aclrtNotifyBatchReset");
    return ACL_SUCCESS;
}

aclError aclrtNotifyGetExportKeyImpl(aclrtNotify notify, char *key, size_t len, uint64_t flags)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtNotifyGetExportKey);
    ACL_LOG_INFO("start to execute aclrtNotifyGetExportKey, len is [%zu], flags is [%lu]", len, flags);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(notify);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(key);

    const rtError_t rtErr = rtsNotifyGetExportKey(notify, key, static_cast<uint32_t>(len), flags);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("call rtsNotifyGetExportKey failed, runtime result = %d", rtErr);
        return ACL_GET_ERRCODE_RTS(rtErr);
    }

    ACL_LOG_INFO("successfully execute aclrtNotifyGetExportKey");
    return ACL_SUCCESS;
}

aclError aclrtNotifyImportByKeyImpl(aclrtNotify *notify, const char *key, uint64_t flags)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtNotifyImportByKey);
    ACL_LOG_INFO("start to execute aclrtNotifyImportByKey, flags is [%lu]", flags);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(notify);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(key);
    if (flags > ACL_NOTIFY_DEVICE_USE_ONLY) {
        ACL_LOG_ERROR("param flag must be [0,%u] currently.", ACL_NOTIFY_DEVICE_USE_ONLY);
        return ACL_ERROR_INVALID_PARAM;
    }

    const rtError_t rtErr = rtsNotifyImportByKey(notify, key, flags);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("call rtsNotifyImportByKey failed, runtime result = %d", rtErr);
        return ACL_GET_ERRCODE_RTS(rtErr);
    }

    ACL_LOG_INFO("successfully execute aclrtNotifyImportByKey");
    return ACL_SUCCESS;
}

aclError aclrtNotifySetImportPidImpl(aclrtNotify notify, int32_t *pid, size_t num)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtNotifySetImportPid);
    ACL_LOG_INFO("start to execute aclrtNotifySetImportPid, num is [%zu]", num);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(notify);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(pid);

    const rtError_t rtErr = rtsNotifySetImportPid(notify, pid, static_cast<int32_t>(num));
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("call rtsNotifySetImportPid failed, runtime result = %d", rtErr);
        return ACL_GET_ERRCODE_RTS(rtErr);
    }

    ACL_LOG_INFO("successfully execute aclrtNotifySetImportPid");
    return ACL_SUCCESS;
}

aclError aclrtNotifySetImportPidInterServerImpl(aclrtNotify notify, aclrtServerPid *serverPids, size_t num)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtNotifySetImportPidInterServer);
    ACL_LOG_INFO("start to execute aclrtNotifySetImportPidInterServer, num is [%zu]", num);

    const rtError_t rtErr = rtNotifySetImportPidInterServer(notify, reinterpret_cast<const rtServerPid *>(serverPids), num);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("call rtNotifySetImportPidInterServer failed, runtime result = %d", rtErr);
        return ACL_GET_ERRCODE_RTS(rtErr);
    }

    ACL_LOG_INFO("successfully execute aclrtNotifySetImportPidInterServer");
    return ACL_SUCCESS;
}

aclError aclrtCntNotifyCreateImpl(aclrtCntNotify *cntNotify, uint64_t flag)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtCntNotifyCreate);
    ACL_LOG_INFO("start to execute aclrtCntNotifyCreate, flag is [%lu]", flag);

    const rtError_t rtErr = rtCntNotifyCreateServer(static_cast<rtCntNotify_t*>(cntNotify), flag);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("call aclrtCntNotifyCreate failed, runtime result = %d", rtErr);
        return ACL_GET_ERRCODE_RTS(rtErr);
    }

    ACL_LOG_INFO("successfully execute aclrtCntNotifyCreate");
    return ACL_SUCCESS;
}

aclError aclrtCntNotifyDestroyImpl(aclrtCntNotify cntNotify)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtCntNotifyDestroy);
    ACL_LOG_INFO("start to execute aclrtCntNotifyDestroy");

    const rtError_t rtErr = rtCntNotifyDestroy(static_cast<rtCntNotify_t>(cntNotify));
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("call aclrtCntNotifyDestroy failed, runtime result = %d", rtErr);
        return ACL_GET_ERRCODE_RTS(rtErr);
    }

    ACL_LOG_INFO("successfully execute aclrtCntNotifyDestroy");
    return ACL_SUCCESS;
}

aclError aclrtCntNotifyRecordImpl(aclrtCntNotify cntNotify, aclrtStream stream, aclrtCntNotifyRecordInfo *info)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtCntNotifyRecord);
    ACL_LOG_INFO("start to execute aclrtCntNotifyRecord");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(info);

    const rtError_t rtErr = rtsCntNotifyRecord(cntNotify, stream, reinterpret_cast<rtCntNotifyRecordInfo_t *>(info));
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("call rtsCntNotifyRecord failed, runtime result = %d", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }

    ACL_LOG_INFO("successfully execute aclrtCntNotifyRecord");
    return ACL_SUCCESS;
}

aclError aclrtCntNotifyWaitWithTimeoutImpl(aclrtCntNotify cntNotify, aclrtStream stream, aclrtCntNotifyWaitInfo *info)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtCntNotifyWaitWithTimeout);
    ACL_LOG_INFO("start to execute aclrtCntNotifyWaitWithTimeout");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(info);

    const rtError_t rtErr = rtsCntNotifyWaitWithTimeout(cntNotify, stream, reinterpret_cast<rtCntNotifyWaitInfo_t *>(info));
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("call rtsCntNotifyWaitWithTimeout failed, runtime result = %d", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }

    ACL_LOG_INFO("successfully execute aclrtCntNotifyWaitWithTimeout");
    return ACL_SUCCESS;
}

aclError aclrtCntNotifyResetImpl(aclrtCntNotify cntNotify, aclrtStream stream)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtCntNotifyReset);
    ACL_LOG_INFO("start to execute aclrtCntNotifyReset");

    const rtError_t rtErr = rtsCntNotifyReset(cntNotify, stream);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("call rtsCntNotifyReset failed, runtime result = %d", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }

    ACL_LOG_INFO("successfully execute aclrtCntNotifyReset");
    return ACL_SUCCESS;
}

aclError aclrtCntNotifyGetIdImpl(aclrtCntNotify cntNotify, uint32_t *notifyId)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtCntNotifyGetId);
    ACL_LOG_INFO("start to execute aclrCntNotifyGetId");

    const rtError_t rtErr = rtsCntNotifyGetId(cntNotify, notifyId);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("call rtsCntNotifyGetId failed, runtime result = %d", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }

    ACL_LOG_INFO("successfully execute aclrtCntNotifyGetId");
    return ACL_SUCCESS;
}
