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

#ifdef __cplusplus
extern "C" {
#endif

aclError aclrtCreateNotifyImpl(aclrtNotify* notify, uint64_t flag)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtCreateNotify);
    ACL_LOG_INFO("start to execute aclrtCreateNotify, flag is [%lu]", flag);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(notify);

    ACL_REQUIRES_RTS_OK(rtsNotifyCreate(static_cast<rtNotify_t*>(notify), flag));

    ACL_LOG_INFO("successfully execute aclrtCreateNotify");
    return ACL_SUCCESS;
}

aclError aclrtDestroyNotifyImpl(aclrtNotify notify)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtDestroyNotify);
    ACL_LOG_INFO("start to execute aclrtDestroyNotify");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(notify);

    ACL_REQUIRES_RTS_OK(rtsNotifyDestroy(static_cast<rtNotify_t>(notify)));

    ACL_LOG_INFO("successfully execute aclrtDestroyNotify");
    return ACL_SUCCESS;
}

aclError aclrtRecordNotifyImpl(aclrtNotify notify, aclrtStream stream)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtRecordNotify);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(notify);

    ACL_REQUIRES_RTS_OK(rtsNotifyRecord(static_cast<rtNotify_t>(notify), static_cast<rtStream_t>(stream)));

    return ACL_SUCCESS;
}

aclError aclrtWaitAndResetNotifyImpl(aclrtNotify notify, aclrtStream stream, uint32_t timeout)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtWaitAndResetNotify);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(notify);

    ACL_REQUIRES_RTS_OK(
        rtsNotifyWaitAndReset(static_cast<rtNotify_t>(notify), static_cast<rtStream_t>(stream), timeout));

    return ACL_SUCCESS;
}

aclError aclrtGetNotifyIdImpl(aclrtNotify notify, uint32_t* notifyId)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtGetNotifyId);
    ACL_LOG_INFO("start to execute aclrtGetNotifyId");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(notify);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(notifyId);

    ACL_REQUIRES_RTS_OK(rtsNotifyGetId(static_cast<rtNotify_t>(notify), notifyId));

    ACL_LOG_INFO("successfully execute aclrtGetNotifyId");
    return ACL_SUCCESS;
}

aclError aclrtNotifyBatchResetImpl(aclrtNotify* notifies, size_t num)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtNotifyBatchReset);
    ACL_LOG_INFO("start to execute aclrtNotifyBatchReset, num is [%zu]", num);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(notifies);
    ACL_REQUIRES_RTS_OK(rtsNotifyBatchReset(notifies, static_cast<uint32_t>(num)));

    ACL_LOG_INFO("successfully execute aclrtNotifyBatchReset");
    return ACL_SUCCESS;
}

aclError aclrtNotifyGetExportKeyImpl(aclrtNotify notify, char* key, size_t len, uint64_t flags)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtNotifyGetExportKey);
    ACL_LOG_INFO("start to execute aclrtNotifyGetExportKey, len is [%zu], flags is [%lu]", len, flags);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(notify);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(key);

    ACL_REQUIRES_RTS_OK(rtsNotifyGetExportKey(notify, key, static_cast<uint32_t>(len), flags));

    ACL_LOG_INFO("successfully execute aclrtNotifyGetExportKey");
    return ACL_SUCCESS;
}

aclError aclrtNotifyImportByKeyImpl(aclrtNotify* notify, const char* key, uint64_t flags)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtNotifyImportByKey);
    ACL_LOG_INFO("start to execute aclrtNotifyImportByKey, flags is [%lu]", flags);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(notify);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(key);

    ACL_REQUIRES_RTS_OK(rtsNotifyImportByKey(notify, key, flags));

    ACL_LOG_INFO("successfully execute aclrtNotifyImportByKey");
    return ACL_SUCCESS;
}

aclError aclrtNotifySetImportPidImpl(aclrtNotify notify, int32_t* pid, size_t num)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtNotifySetImportPid);
    ACL_LOG_INFO("start to execute aclrtNotifySetImportPid, num is [%zu]", num);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(notify);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(pid);

    ACL_REQUIRES_RTS_OK(rtsNotifySetImportPid(notify, pid, static_cast<int32_t>(num)));

    ACL_LOG_INFO("successfully execute aclrtNotifySetImportPid");
    return ACL_SUCCESS;
}

aclError aclrtNotifySetImportPidInterServerImpl(aclrtNotify notify, aclrtServerPid* serverPids, size_t num)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtNotifySetImportPidInterServer);
    ACL_LOG_INFO("start to execute aclrtNotifySetImportPidInterServer, num is [%zu]", num);

    ACL_REQUIRES_RTS_OK(rtNotifySetImportPidInterServer(notify, reinterpret_cast<const rtServerPid*>(serverPids), num));

    ACL_LOG_INFO("successfully execute aclrtNotifySetImportPidInterServer");
    return ACL_SUCCESS;
}

aclError aclrtCntNotifyCreateImpl(aclrtCntNotify* cntNotify, uint64_t flag)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtCntNotifyCreate);
    ACL_LOG_INFO("start to execute aclrtCntNotifyCreate, flag is [%lu]", flag);

    ACL_REQUIRES_RTS_OK(rtCntNotifyCreateServer(static_cast<rtCntNotify_t*>(cntNotify), flag));

    ACL_LOG_INFO("successfully execute aclrtCntNotifyCreate");
    return ACL_SUCCESS;
}

aclError aclrtCntNotifyDestroyImpl(aclrtCntNotify cntNotify)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtCntNotifyDestroy);
    ACL_LOG_INFO("start to execute aclrtCntNotifyDestroy");

    ACL_REQUIRES_RTS_OK(rtCntNotifyDestroy(static_cast<rtCntNotify_t>(cntNotify)));

    ACL_LOG_INFO("successfully execute aclrtCntNotifyDestroy");
    return ACL_SUCCESS;
}

aclError aclrtCntNotifyRecordImpl(aclrtCntNotify cntNotify, aclrtStream stream, aclrtCntNotifyRecordInfo* info)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtCntNotifyRecord);
    ACL_LOG_INFO("start to execute aclrtCntNotifyRecord");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(info);

    ACL_REQUIRES_RTS_OK(rtsCntNotifyRecord(cntNotify, stream, reinterpret_cast<rtCntNotifyRecordInfo_t*>(info)));

    ACL_LOG_INFO("successfully execute aclrtCntNotifyRecord");
    return ACL_SUCCESS;
}

aclError aclrtCntNotifyWaitWithTimeoutImpl(aclrtCntNotify cntNotify, aclrtStream stream, aclrtCntNotifyWaitInfo* info)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtCntNotifyWaitWithTimeout);
    ACL_LOG_INFO("start to execute aclrtCntNotifyWaitWithTimeout");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(info);
    ACL_REQUIRES_RTS_OK(rtsCntNotifyWaitWithTimeout(cntNotify, stream, reinterpret_cast<rtCntNotifyWaitInfo_t*>(info)));

    ACL_LOG_INFO("successfully execute aclrtCntNotifyWaitWithTimeout");
    return ACL_SUCCESS;
}

aclError aclrtCntNotifyResetImpl(aclrtCntNotify cntNotify, aclrtStream stream)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtCntNotifyReset);
    ACL_LOG_INFO("start to execute aclrtCntNotifyReset");

    ACL_REQUIRES_RTS_OK(rtsCntNotifyReset(cntNotify, stream));

    ACL_LOG_INFO("successfully execute aclrtCntNotifyReset");
    return ACL_SUCCESS;
}

aclError aclrtCntNotifyGetIdImpl(aclrtCntNotify cntNotify, uint32_t* notifyId)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtCntNotifyGetId);
    ACL_LOG_INFO("start to execute aclrCntNotifyGetId");

    ACL_REQUIRES_RTS_OK(rtsCntNotifyGetId(cntNotify, notifyId));

    ACL_LOG_INFO("successfully execute aclrtCntNotifyGetId");
    return ACL_SUCCESS;
}
#ifdef __cplusplus
}
#endif
