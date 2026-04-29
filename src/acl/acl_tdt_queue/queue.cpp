/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "queue.h"
#include <map>
#include "common/log_inner.h"
#include "toolchain/prof_api_reg.h"
#include "common/resource_statistics.h"
#include "queue_process.h"
#include "queue_manager.h"
#include "runtime/rt_mem_queue.h"
#include "utils/data_type_utils.h"

namespace {
    aclError CopyParam(const void *const src, const size_t srcLen, void *const dst, const size_t dstLen,
        size_t *const realCopySize = nullptr)
    {
        ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(src);
        ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(dst);
        ACL_CHECK_INVALID_PARAM_WITH_REASON(srcLen > dstLen, srcLen, "srcLen must not be larger than dstLen");
        const auto ret = memcpy_s(dst, dstLen, src, srcLen);
        if (ret != EOK) {
        const std::string retVal = std::to_string(ret);
        const std::string extendInfo = "src=" + std::to_string(reinterpret_cast<uintptr_t>(src)) + 
            ", dst=" + std::to_string(reinterpret_cast<uintptr_t>(dst)) +
            ", dstLen=" + std::to_string(dstLen) + ", srcLen=" + std::to_string(srcLen);
        acl::AclErrorLogManager::ReportInputError(acl::STANDARD_FUNC_FAILED_MSG,
            std::vector<const char *>({"func1", "func2", "ret_code", "reason", "extend_info"}),
            std::vector<const char *>({__func__, "memcpy_s", retVal.c_str(),
                strerror(ret), extendInfo.c_str()}));
        ACL_LOG_ERROR("[Call][MemCpy]call memcpy failed, result=%d, srcLen=%zu, dstLen=%zu",
            ret, srcLen, dstLen);
        return ACL_ERROR_FAILURE;
        }
        if (realCopySize != nullptr) {
            *realCopySize = srcLen;
        }
        return ACL_SUCCESS;
    }
}

namespace acl {
    aclError CheckQueueRouteQueryInfo(const acltdtQueueRouteQueryInfo *const queryInfo)
    {
        if (!queryInfo->isConfigMode) {
            ACL_LOG_ERROR("mode must be set in acltdtQueueRouteQueryInfo, please use acltdtSetQueueRouteQueryInfo");
            acl::AclErrorLogManager::ReportInputError(acl::INVALID_PARAM_REASON_MSG,
                        std::vector<const char *>({"func", "value", "param", "reason"}),
                        std::vector<const char *>({__func__, "false", "queryInfo->isConfigMode",
                                "Currently, the query is configured based on queue. The queue must be configured through "
                                "acltdtSetQueueRouteQueryInfo"}));
            return ACL_ERROR_INVALID_PARAM;
        }
        switch (queryInfo->mode) {
            case ACL_TDT_QUEUE_ROUTE_QUERY_SRC: {
                if (!queryInfo->isConfigSrc) {
                    ACL_LOG_ERROR("src qid must be set in acltdtQueueRouteQueryInfo, "
                                "please use acltdtSetQueueRouteQueryInfo");
                    acl::AclErrorLogManager::ReportInputError(acl::INVALID_PARAM_REASON_MSG,
                        std::vector<const char *>({"func", "value", "param", "reason"}),
                        std::vector<const char *>({__func__, "false", "queryInfo->isConfigSrc",
                                "Currently, the query is configured based on the source queue. The source queue must be configured through "
                                "acltdtSetQueueRouteQueryInfo"}));
                    return ACL_ERROR_INVALID_PARAM;
                }
                break;
            }
            case ACL_TDT_QUEUE_ROUTE_QUERY_DST: {
                if (!queryInfo->isConfigDst) {
                    ACL_LOG_ERROR("dst qid must be set in acltdtQueueRouteQueryInfo, "
                                "please use acltdtSetQueueRouteQueryInfo");
                    acl::AclErrorLogManager::ReportInputError(acl::INVALID_PARAM_REASON_MSG,
                        std::vector<const char *>({"func", "value", "param", "reason"}),
                        std::vector<const char *>({__func__, "false", "queryInfo->isConfigDst",
                            "Currently, the query is configured based on the destination queue. The destination queue must be configured through "
                            "acltdtSetQueueRouteQueryInfo"}));
                    return ACL_ERROR_INVALID_PARAM;
                }
                break;
            }
            case ACL_TDT_QUEUE_ROUTE_QUERY_SRC_AND_DST: {
                if ((!queryInfo->isConfigSrc) || (!queryInfo->isConfigDst)) {
                    ACL_LOG_ERROR("src and dst qid must be set in acltdtQueueRouteQueryInfo, "
                                "please use acltdtSetQueueRouteQueryInfo");
                    const char_t *argList[] = {"func", "value", "param", "reason"};
                    std::string value = std::to_string(queryInfo->isConfigSrc) + '/' + std::to_string(queryInfo->isConfigDst);
                    const char_t *argVal[] = {__func__, value.c_str(), "queryInfo->isConfigSrc/isConfigDst", 
                        "Currently, the query is configured based on the source queue and the destination queue. The source queue and destination queue must be configured through "
                        "acltdtSetQueueRouteQueryInfo"};
                    acl::AclErrorLogManager::ReportInputErrorWithChar(acl::INVALID_PARAM_REASON_MSG, argList, argVal, 4UL);
                    return ACL_ERROR_INVALID_PARAM;
                }
                break;
            }
            case ACL_TDT_QUEUE_ROUTE_QUERY_ABNORMAL: {
                break;
            }
            default: {
                ACL_LOG_ERROR("[Check][Type]unknown mode %d.", queryInfo->mode);
                const char_t *argList[] = {"func", "value", "param", "expect"};
                const char_t *argVal[] = {__func__, acl::GetQueueRouteQueryModeDesc(static_cast<acltdtQueueRouteQueryMode>(queryInfo->mode)),
                        "queryInfo->mode", "ACL_TDT_QUEUE_ROUTE_QUERY_SRC or ACL_TDT_QUEUE_ROUTE_QUERY_DST or ACL_TDT_QUEUE_ROUTE_QUERY_SRC_AND_DST or ACL_TDT_QUEUE_ROUTE_QUERY_ABNORMAL"};
                acl::AclErrorLogManager::ReportInputErrorWithChar(acl::INVALID_VALUE_MSG, argList, argVal, 4UL);
                return ACL_ERROR_INVALID_PARAM;
            }
        }
        return ACL_SUCCESS;
    }
}

aclError acltdtCreateQueue(const acltdtQueueAttr *attr, uint32_t *qid)
{
    ACL_ADD_APPLY_TOTAL_COUNT(acl::ACL_STATISTICS_CREATE_DESTROY_QUEUE_ID);
    auto& qManager = acl::QueueManager::GetInstance();
    const auto processor = qManager.GetQueueProcessor();
    ACL_REQUIRES_NOT_NULL_WITH_INNER_REPORT(processor);
    ACL_REQUIRES_OK(processor->acltdtCreateQueue(attr, qid));
    ACL_ADD_APPLY_SUCCESS_COUNT(acl::ACL_STATISTICS_CREATE_DESTROY_QUEUE_ID);
    return ACL_SUCCESS;
}

aclError acltdtDestroyQueue(uint32_t qid)
{
    ACL_ADD_RELEASE_TOTAL_COUNT(acl::ACL_STATISTICS_CREATE_DESTROY_QUEUE_ID);
    auto& qManager = acl::QueueManager::GetInstance();
    const auto processor = qManager.GetQueueProcessor();
    ACL_REQUIRES_NOT_NULL_WITH_INNER_REPORT(processor);
    ACL_REQUIRES_OK(processor->acltdtDestroyQueue(qid));
    ACL_ADD_RELEASE_SUCCESS_COUNT(acl::ACL_STATISTICS_CREATE_DESTROY_QUEUE_ID);
    return ACL_SUCCESS;
}

aclError acltdtEnqueue(uint32_t qid, acltdtBuf buf, int32_t timeout)
{
    ACL_PROFILING_REG(acl::AclTdtQueueProfType::AcltdtEnqueue);
    auto& qManager = acl::QueueManager::GetInstance();
    const auto processor = qManager.GetQueueProcessor();
    ACL_REQUIRES_NOT_NULL_WITH_INNER_REPORT(processor);
    ACL_REQUIRES_OK(processor->acltdtEnqueue(qid, buf, timeout));
    return ACL_SUCCESS;
}

aclError acltdtDequeue(uint32_t qid, acltdtBuf *buf, int32_t timeout)
{
    ACL_PROFILING_REG(acl::AclTdtQueueProfType::AcltdtDequeue);
    auto& qManager = acl::QueueManager::GetInstance();
    const auto processor = qManager.GetQueueProcessor();
    ACL_REQUIRES_NOT_NULL_WITH_INNER_REPORT(processor);
    ACL_REQUIRES_OK(processor->acltdtDequeue(qid, buf, timeout));
    return ACL_SUCCESS;
}

aclError acltdtEnqueueData(uint32_t qid, const void *data, size_t dataSize,
    const void *userData, size_t userDataSize, int32_t timeout, uint32_t rsv)
{
    ACL_PROFILING_REG(acl::AclTdtQueueProfType::AcltdtEnqueueData);
    auto& qManager = acl::QueueManager::GetInstance();
    const auto processor = qManager.GetQueueProcessor();
    ACL_REQUIRES_NOT_NULL_WITH_INNER_REPORT(processor);
    ACL_REQUIRES_OK(processor->acltdtEnqueueData(qid, data, dataSize, userData, userDataSize, timeout, rsv));
    return ACL_SUCCESS;
}

aclError acltdtDequeueData(uint32_t qid, void *data, size_t dataSize, size_t *retDataSize,
    void *userData, size_t userDataSize, int32_t timeout)
{
    ACL_PROFILING_REG(acl::AclTdtQueueProfType::AcltdtDequeueData);
    auto& qManager = acl::QueueManager::GetInstance();
    const auto processor = qManager.GetQueueProcessor();
    ACL_REQUIRES_NOT_NULL_WITH_INNER_REPORT(processor);
    ACL_REQUIRES_OK(processor->acltdtDequeueData(qid, data, dataSize, retDataSize, userData, userDataSize, timeout));
    return ACL_SUCCESS;
}

aclError acltdtGrantQueue(uint32_t qid, int32_t pid, uint32_t permission, int32_t timeout)
{
    auto& qManager = acl::QueueManager::GetInstance();
    const auto processor = qManager.GetQueueProcessor();
    ACL_REQUIRES_NOT_NULL_WITH_INNER_REPORT(processor);
    ACL_REQUIRES_OK(processor->acltdtGrantQueue(qid, pid, permission, timeout));
    return ACL_SUCCESS;
}

aclError acltdtAttachQueue(uint32_t qid, int32_t timeout, uint32_t *permission)
{
    auto& qManager = acl::QueueManager::GetInstance();
    const auto processor = qManager.GetQueueProcessor();
    ACL_REQUIRES_NOT_NULL_WITH_INNER_REPORT(processor);
    ACL_REQUIRES_OK(processor->acltdtAttachQueue(qid, timeout, permission));
    return ACL_SUCCESS;
}

aclError acltdtBindQueueRoutes(acltdtQueueRouteList *qRouteList)
{
    auto& qManager = acl::QueueManager::GetInstance();
    const auto processor = qManager.GetQueueProcessor();
    ACL_REQUIRES_NOT_NULL_WITH_INNER_REPORT(processor);
    ACL_REQUIRES_OK(processor->acltdtBindQueueRoutes(qRouteList));
    return ACL_SUCCESS;
}

aclError acltdtUnbindQueueRoutes(acltdtQueueRouteList *qRouteList)
{
    auto& qManager = acl::QueueManager::GetInstance();
    const auto processor = qManager.GetQueueProcessor();
    ACL_REQUIRES_NOT_NULL_WITH_INNER_REPORT(processor);
    ACL_REQUIRES_OK(processor->acltdtUnbindQueueRoutes(qRouteList));
    return ACL_SUCCESS;
}

aclError acltdtQueryQueueRoutes(const acltdtQueueRouteQueryInfo *queryInfo, acltdtQueueRouteList *qRouteList)
{
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(qRouteList);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(queryInfo);
    qRouteList->routeList.clear();
    ACL_REQUIRES_OK(acl::CheckQueueRouteQueryInfo(queryInfo));
    auto& qManager = acl::QueueManager::GetInstance();
    const auto processor = qManager.GetQueueProcessor();
    ACL_REQUIRES_NOT_NULL_WITH_INNER_REPORT(processor);
    ACL_REQUIRES_OK(processor->acltdtQueryQueueRoutes(queryInfo, qRouteList));
    return ACL_SUCCESS;
}

aclError acltdtAllocBuf(size_t size, uint32_t type, acltdtBuf *buf)
{
    if ((type != static_cast<uint32_t>(ACL_TDT_NORMAL_MEM)) &&
        (type != static_cast<uint32_t>(ACL_TDT_DVPP_MEM))) {
        const char_t *argList[] = {"func", "value", "param", "expect"};
            std::string expect = "[" + std::to_string(ACL_TDT_NORMAL_MEM) + ", " + std::to_string(ACL_TDT_DVPP_MEM) + "]";
            const std::string typeVal = std::to_string(type);
            const char_t *argVal[] = {__func__, typeVal.c_str(), "type", expect.c_str()};
            acl::AclErrorLogManager::ReportInputErrorWithChar(acl::INVALID_VALUE_MSG, argList, argVal, 4UL);
        ACL_LOG_ERROR("[Check][Param]param type must be equal to 0 or 1 currently");
        return ACL_ERROR_INVALID_PARAM;
    }
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(buf);
    ACL_ADD_APPLY_TOTAL_COUNT(acl::ACL_STATISTICS_CREATE_DESTROY_MBUF);
    auto& qManager = acl::QueueManager::GetInstance();
    const auto processor = qManager.GetQueueProcessor();
    ACL_REQUIRES_NOT_NULL_WITH_INNER_REPORT(processor);
    ACL_ADD_APPLY_SUCCESS_COUNT(acl::ACL_STATISTICS_CREATE_DESTROY_MBUF);
    return processor->acltdtAllocBuf(size, type, buf);
}

aclError acltdtFreeBuf(acltdtBuf buf)
{
    ACL_ADD_RELEASE_TOTAL_COUNT(acl::ACL_STATISTICS_CREATE_DESTROY_MBUF);
    auto& qManager = acl::QueueManager::GetInstance();
    const auto processor = qManager.GetQueueProcessor();
    ACL_REQUIRES_NOT_NULL_WITH_INNER_REPORT(processor);
    ACL_REQUIRES_OK(processor->acltdtFreeBuf(buf));
    ACL_ADD_RELEASE_SUCCESS_COUNT(acl::ACL_STATISTICS_CREATE_DESTROY_MBUF);
    return ACL_SUCCESS;
}

aclError acltdtGetBufData(const acltdtBuf buf, void **dataPtr, size_t *size)
{
    auto& qManager = acl::QueueManager::GetInstance();
    const auto processor = qManager.GetQueueProcessor();
    ACL_REQUIRES_NOT_NULL_WITH_INNER_REPORT(processor);
    ACL_REQUIRES_OK(processor->acltdtGetBufData(buf, dataPtr, size));
    return ACL_SUCCESS;
}

aclError acltdtSetBufDataLen(acltdtBuf buf, size_t len)
{
    auto& qManager = acl::QueueManager::GetInstance();
    const auto processor = qManager.GetQueueProcessor();
    ACL_REQUIRES_NOT_NULL_WITH_INNER_REPORT(processor);
    ACL_REQUIRES_OK(processor->acltdtSetBufDataLen(buf, len));
    return ACL_SUCCESS;
}

aclError acltdtGetBufDataLen(acltdtBuf buf, size_t *len)
{
    auto& qManager = acl::QueueManager::GetInstance();
    const auto processor = qManager.GetQueueProcessor();
    ACL_REQUIRES_NOT_NULL_WITH_INNER_REPORT(processor);
    ACL_REQUIRES_OK(processor->acltdtGetBufDataLen(buf, len));
    return ACL_SUCCESS;
}

aclError acltdtAppendBufChain(acltdtBuf headBuf, acltdtBuf buf)
{
    auto& qManager = acl::QueueManager::GetInstance();
    const auto processor = qManager.GetQueueProcessor();
    ACL_REQUIRES_NOT_NULL_WITH_INNER_REPORT(processor);
    ACL_REQUIRES_OK(processor->acltdtAppendBufChain(headBuf, buf));
    return ACL_SUCCESS;
}

aclError acltdtGetBufChainNum(acltdtBuf headBuf, uint32_t *num)
{
    auto& qManager = acl::QueueManager::GetInstance();
    const auto processor = qManager.GetQueueProcessor();
    ACL_REQUIRES_NOT_NULL_WITH_INNER_REPORT(processor);
    ACL_REQUIRES_OK(processor->acltdtGetBufChainNum(headBuf, num));
    return ACL_SUCCESS;
}

aclError acltdtGetBufFromChain(acltdtBuf headBuf, uint32_t index, acltdtBuf *buf)
{
    auto& qManager = acl::QueueManager::GetInstance();
    const auto processor = qManager.GetQueueProcessor();
    ACL_REQUIRES_NOT_NULL_WITH_INNER_REPORT(processor);
    ACL_REQUIRES_OK(processor->acltdtGetBufFromChain(headBuf, index, buf));
    return ACL_SUCCESS;
}

aclError acltdtGetBufUserData(const acltdtBuf buf, void *dataPtr, size_t size, size_t offset)
{
    auto& qManager = acl::QueueManager::GetInstance();
    const auto processor = qManager.GetQueueProcessor();
    ACL_REQUIRES_NOT_NULL_WITH_INNER_REPORT(processor);
    ACL_REQUIRES_OK(processor->acltdtGetBufUserData(buf, dataPtr, size, offset));
    return ACL_SUCCESS;
}

aclError acltdtSetBufUserData(acltdtBuf buf, const void *dataPtr, size_t size, size_t offset)
{
    auto& qManager = acl::QueueManager::GetInstance();
    const auto processor = qManager.GetQueueProcessor();
    ACL_REQUIRES_NOT_NULL_WITH_INNER_REPORT(processor);
    ACL_REQUIRES_OK(processor->acltdtSetBufUserData(buf, dataPtr, size, offset));
    return ACL_SUCCESS;
}

aclError acltdtCopyBufRef(const acltdtBuf buf, acltdtBuf *newBuf)
{
    auto& qManager = acl::QueueManager::GetInstance();
    const auto processor = qManager.GetQueueProcessor();
    ACL_REQUIRES_NOT_NULL_WITH_INNER_REPORT(processor);
    ACL_REQUIRES_OK(processor->acltdtCopyBufRef(buf, newBuf));
    return ACL_SUCCESS;
}

acltdtQueueAttr* acltdtCreateQueueAttr()
{
    ACL_ADD_APPLY_TOTAL_COUNT(acl::ACL_STATISTICS_CREATE_DESTROY_QUEUE_ATTR);
    acltdtQueueAttr *const attr = new(std::nothrow) acltdtQueueAttr();
    ACL_CHECK_MALLOC_RESULT_REPORT_RET(attr, sizeof(acltdtQueueAttr), nullptr);
    acl::QueueProcessor::acltdtSetDefaultQueueAttr(*attr);
    ACL_ADD_APPLY_SUCCESS_COUNT(acl::ACL_STATISTICS_CREATE_DESTROY_QUEUE_ATTR);
    return attr;
}

aclError acltdtDestroyQueueAttr(const acltdtQueueAttr *attr)
{
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(attr);
    ACL_ADD_RELEASE_TOTAL_COUNT(acl::ACL_STATISTICS_CREATE_DESTROY_QUEUE_ATTR);
    ACL_DELETE_AND_SET_NULL(attr);
    ACL_ADD_RELEASE_SUCCESS_COUNT(acl::ACL_STATISTICS_CREATE_DESTROY_QUEUE_ATTR);
    return ACL_SUCCESS;
}

aclError acltdtSetQueueAttr(acltdtQueueAttr *attr,
                            acltdtQueueAttrType type,
                            size_t len,
                            const void *param)
{
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(attr);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(param);
    switch (type) {
        case ACL_TDT_QUEUE_NAME_PTR: {
                char_t *tmp = nullptr;
                ACL_REQUIRES_OK(CopyParam(param, len, static_cast<void *>(&tmp), sizeof(size_t)));
                ACL_REQUIRES_NOT_NULL(tmp);
                const size_t tmpLen = strnlen(tmp, static_cast<size_t>(RT_MQ_MAX_NAME_LEN));
                if ((tmpLen + 1U) > static_cast<size_t>(RT_MQ_MAX_NAME_LEN)) {
                    ACL_LOG_ERROR("queue name len [%zu] can not be larger than %d",
                                  tmpLen + 1U, RT_MQ_MAX_NAME_LEN);
                    return ACL_ERROR_INVALID_PARAM;
                }
                return CopyParam(tmp, tmpLen + 1U, static_cast<void *>(attr->name),
                    static_cast<size_t>(RT_MQ_MAX_NAME_LEN));
            }
        case ACL_TDT_QUEUE_DEPTH_UINT32:
            return CopyParam(param, len, static_cast<void *>(&attr->depth), sizeof(uint32_t));
        default: {
            ACL_LOG_ERROR("[Check][Type]unknown acltdtQueueAttrType %d.", type);
            acl::AclErrorLogManager::ReportInputError(acl::INVALID_VALUE_MSG,
            std::vector<const char *>({"func", "value", "param", "expect"}),
            std::vector<const char *>({__func__, acl::GetQueueAttrTypeDesc(type), "type", "[ACL_TDT_QUEUE_NAME_PTR, ACL_TDT_QUEUE_DEPTH_UINT32]"}));
            return ACL_ERROR_INVALID_PARAM;
        }
    }
}

aclError acltdtGetQueueAttr(const acltdtQueueAttr *attr,
                            acltdtQueueAttrType type,
                            size_t len,
                            size_t *paramRetSize,
                            void *param)
{
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(attr);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(param);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(paramRetSize);
    ACL_LOG_INFO("start to get queue attr, type is %d, len is %zu", type, len);
    switch (type) {
        case ACL_TDT_QUEUE_NAME_PTR: {
                const char_t *tmp = &attr->name[0];
                return CopyParam(static_cast<const void *>(&tmp), sizeof(size_t), param, len, paramRetSize);
            }
        case ACL_TDT_QUEUE_DEPTH_UINT32:
            return CopyParam(static_cast<const void *>(&attr->depth), sizeof(uint32_t), param, len, paramRetSize);
        default: {
            ACL_LOG_ERROR("[Check][Type]unknown acltdtQueueAttrType %d.", type);
            acl::AclErrorLogManager::ReportInputError(acl::INVALID_VALUE_MSG,
                std::vector<const char *>({"func", "value", "param", "expect"}),
                std::vector<const char *>({__func__, acl::GetQueueAttrTypeDesc(type), "type", "[ACL_TDT_QUEUE_NAME_PTR, ACL_TDT_QUEUE_DEPTH_UINT32]"}));
            return ACL_ERROR_INVALID_PARAM;
        }
    }
}

acltdtQueueRoute* acltdtCreateQueueRoute(uint32_t srcId, uint32_t dstId)
{
    ACL_ADD_APPLY_TOTAL_COUNT(acl::ACL_STATISTICS_CREATE_DESTROY_QUEUE_ROUTE);
    acltdtQueueRoute *const route = new(std::nothrow) acltdtQueueRoute();
    ACL_CHECK_MALLOC_RESULT_REPORT_RET(route, sizeof(acltdtQueueRoute), nullptr);
    route->srcId = srcId;
    route->dstId = dstId;
    route->status = 0;
    ACL_ADD_APPLY_SUCCESS_COUNT(acl::ACL_STATISTICS_CREATE_DESTROY_QUEUE_ROUTE);
    return route;
}

aclError acltdtDestroyQueueRoute(const acltdtQueueRoute *route)
{
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(route);
    ACL_ADD_RELEASE_TOTAL_COUNT(acl::ACL_STATISTICS_CREATE_DESTROY_QUEUE_ROUTE);
    ACL_DELETE_AND_SET_NULL(route);
    ACL_ADD_RELEASE_SUCCESS_COUNT(acl::ACL_STATISTICS_CREATE_DESTROY_QUEUE_ROUTE);
    return ACL_SUCCESS;
}

aclError acltdtGetQueueRouteParam(const acltdtQueueRoute *route,
                                  acltdtQueueRouteParamType type,
                                  size_t len,
                                  size_t *paramRetSize,
                                  void *param)
{
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(route);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(param);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(paramRetSize);
    ACL_LOG_INFO("get route type %d, len is %zu", type, len);
    switch (type) {
        case ACL_TDT_QUEUE_ROUTE_SRC_UINT32:
            return CopyParam(static_cast<const void *>(&route->srcId), sizeof(uint32_t), param, len, paramRetSize);
        case ACL_TDT_QUEUE_ROUTE_DST_UINT32:
            return CopyParam(static_cast<const void *>(&route->dstId), sizeof(uint32_t), param, len, paramRetSize);
        case ACL_TDT_QUEUE_ROUTE_STATUS_INT32:
            return CopyParam(static_cast<const void *>(&route->status), sizeof(int32_t), param, len, paramRetSize);
        default: {
            ACL_LOG_ERROR("[Check][Type]unknown acltdtQueueRouteParamType %d.", type);
            acl::AclErrorLogManager::ReportInputError(acl::INVALID_VALUE_MSG,
                std::vector<const char *>({"func", "value", "param", "expect"}),
                std::vector<const char *>({__func__, acl::GetQueueRouteParamTypeDesc(type), "type",
                "[ACL_TDT_QUEUE_ROUTE_SRC_UINT32, ACL_TDT_QUEUE_ROUTE_STATUS_INT32]"}));
            return ACL_ERROR_INVALID_PARAM;
        }
    }
}

acltdtQueueRouteList* acltdtCreateQueueRouteList()
{
    ACL_ADD_APPLY_TOTAL_COUNT(acl::ACL_STATISTICS_CREATE_DESTROY_QUEUE_ROUTE_LIST);
    ACL_ADD_APPLY_SUCCESS_COUNT(acl::ACL_STATISTICS_CREATE_DESTROY_QUEUE_ROUTE_LIST);
    return new(std::nothrow) acltdtQueueRouteList();
}

aclError acltdtDestroyQueueRouteList(const acltdtQueueRouteList *routeList)
{
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(routeList);
    ACL_ADD_RELEASE_TOTAL_COUNT(acl::ACL_STATISTICS_CREATE_DESTROY_QUEUE_ROUTE_LIST);
    ACL_DELETE_AND_SET_NULL(routeList);
    ACL_ADD_RELEASE_SUCCESS_COUNT(acl::ACL_STATISTICS_CREATE_DESTROY_QUEUE_ROUTE_LIST);
    return ACL_SUCCESS;
}

aclError acltdtAddQueueRoute(acltdtQueueRouteList *routeList, const acltdtQueueRoute *route)
{
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(routeList);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(route);
    routeList->routeList.emplace_back(*route);
    return ACL_SUCCESS;
}

aclError acltdtGetQueueRoute(const acltdtQueueRouteList *routeList,
                             size_t index,
                             acltdtQueueRoute *route)
{
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(routeList);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(route);
    if (index >= routeList->routeList.size()) {
        ACL_LOG_ERROR("[Check][index] index [%zu] must be smaller than [%zu]", index, routeList->routeList.size());
        const char_t *argList[] = {"func", "value", "param", "reason"};
            std::string reason = "must be less than routeList size " + std::to_string(routeList->routeList.size());
            const std::string indexVal = std::to_string(index);
            const char_t *argVal[] = {__func__, indexVal.c_str(), "index", reason.c_str()};
            acl::AclErrorLogManager::ReportInputErrorWithChar(acl::INVALID_PARAM_REASON_MSG, argList, argVal, 4UL);
        return ACL_ERROR_INVALID_PARAM;
    }
    *route = routeList->routeList[index];
    return ACL_SUCCESS;
}

size_t acltdtGetQueueRouteNum(const acltdtQueueRouteList *routeList)
{
    ACL_REQUIRES_NOT_NULL_RET_INPUT_REPORT(routeList, 0U);
    return routeList->routeList.size();
}

acltdtQueueRouteQueryInfo* acltdtCreateQueueRouteQueryInfo()
{
    ACL_ADD_APPLY_TOTAL_COUNT(acl::ACL_STATISTICS_CREATE_DESTROY_QUEUE_ROUTE_QUERY);
    acltdtQueueRouteQueryInfo *const info = new(std::nothrow) acltdtQueueRouteQueryInfo();
    ACL_CHECK_MALLOC_RESULT_REPORT_RET(info, sizeof(acltdtQueueRouteQueryInfo), nullptr);
    ACL_ADD_APPLY_SUCCESS_COUNT(acl::ACL_STATISTICS_CREATE_DESTROY_QUEUE_ROUTE_QUERY);
    info->isConfigDst = false;
    info->isConfigSrc = false;
    info->isConfigMode = false;
    return info;
}

aclError acltdtDestroyQueueRouteQueryInfo(const acltdtQueueRouteQueryInfo *info)
{
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(info);
    ACL_ADD_RELEASE_TOTAL_COUNT(acl::ACL_STATISTICS_CREATE_DESTROY_QUEUE_ROUTE_QUERY);
    ACL_DELETE_AND_SET_NULL(info);
    ACL_ADD_RELEASE_SUCCESS_COUNT(acl::ACL_STATISTICS_CREATE_DESTROY_QUEUE_ROUTE_QUERY);
    return ACL_SUCCESS;
}

aclError acltdtSetQueueRouteQueryInfo(acltdtQueueRouteQueryInfo *param,
                                      acltdtQueueRouteQueryInfoParamType type,
                                      size_t len,
                                      const void *value)
{
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(param);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(value);
    switch (type) {
        case ACL_TDT_QUEUE_ROUTE_QUERY_MODE_ENUM: {
            const auto ret = CopyParam(value, len, static_cast<void *>(&param->mode),
                sizeof(acltdtQueueRouteQueryMode));
            if (ret == ACL_SUCCESS) {
                param->isConfigMode = true;
            }
            return ret;
            }
        case ACL_TDT_QUEUE_ROUTE_QUERY_SRC_ID_UINT32: {
            const auto ret = CopyParam(value, len, static_cast<void *>(&param->srcId), sizeof(uint32_t));
            if (ret == ACL_SUCCESS) {
                param->isConfigSrc = true;
            }
            return ret;
            }
        case ACL_TDT_QUEUE_ROUTE_QUERY_DST_ID_UINT32: {
            const auto ret = CopyParam(value, len, static_cast<void *>(&param->dstId), sizeof(uint32_t));
            if (ret == ACL_SUCCESS) {
                param->isConfigDst = true;
            }
            return ret;
        }
        default: {
            ACL_LOG_ERROR("[Check][Type]unknown acltdtQueueRouteQueryInfoParamType %d.", type);
            acl::AclErrorLogManager::ReportInputError(acl::INVALID_VALUE_MSG,
                std::vector<const char *>({"func", "value", "param", "expect"}),
                std::vector<const char *>({__func__, acl::GetQueueRouteQueryInfoParamTypeDesc(type), "type",
                    "[ACL_TDT_QUEUE_ROUTE_QUERY_MODE_ENUM, ACL_TDT_QUEUE_ROUTE_QUERY_DST_ID_UINT32]"}));
            return ACL_ERROR_INVALID_PARAM;
        }
    }
}