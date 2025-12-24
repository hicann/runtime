/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <sstream>
#include "data_buffer_internal.h"
#include "common/resource_statistics.h"
#include "common/log_inner.h"
#include "common/prof_reporter.h"
#include "acl/acl_rt_impl.h"

size_t aclDataTypeSizeImpl(aclDataType dataType)
{
    switch (dataType) {
        case ACL_STRING:
        case ACL_DT_UNDEFINED:
            return 0U;
        case ACL_UINT1:
        case ACL_INT4:
            return 1U;
        case ACL_BOOL:
        case ACL_INT8:
        case ACL_UINT8:
        case ACL_HIFLOAT8:
        case ACL_FLOAT8_E5M2:
        case ACL_FLOAT8_E4M3FN:
        case ACL_FLOAT8_E8M0:
            return sizeof(int8_t);
        case ACL_FLOAT16:
        case ACL_INT16:
        case ACL_UINT16:
        case ACL_BF16:
            return sizeof(int16_t);
        case ACL_FLOAT:
        case ACL_INT32:
        case ACL_UINT32:
        case ACL_COMPLEX32:
            return sizeof(int32_t);
        case ACL_COMPLEX128:
            return 2U * sizeof(int64_t);
        case ACL_INT64:
        case ACL_UINT64:
        case ACL_DOUBLE:
        case ACL_COMPLEX64:
        default:
            return sizeof(int64_t);
    }
}

aclDataBuffer *aclCreateDataBufferImpl(void *data, size_t size)
{
    ACL_PROFILING_REG(acl::AclProfType::AclCreateDataBuffer);
    ACL_ADD_APPLY_TOTAL_COUNT(acl::ACL_STATISTICS_CREATE_DESTROY_DATA_BUFFER);
    ACL_ADD_APPLY_SUCCESS_COUNT(acl::ACL_STATISTICS_CREATE_DESTROY_DATA_BUFFER);
    return new(std::nothrow) aclDataBuffer(data, size);
}

aclError aclDestroyDataBufferImpl(const aclDataBuffer *dataBuffer)
{
    ACL_ADD_RELEASE_TOTAL_COUNT(acl::ACL_STATISTICS_CREATE_DESTROY_DATA_BUFFER);
    if (dataBuffer == nullptr) {
        return ACL_ERROR_INVALID_PARAM;
    }

    ACL_DELETE_AND_SET_NULL(dataBuffer);
    ACL_ADD_RELEASE_SUCCESS_COUNT(acl::ACL_STATISTICS_CREATE_DESTROY_DATA_BUFFER);
    return ACL_SUCCESS;
}

aclError aclUpdateDataBufferImpl(aclDataBuffer *dataBuffer, void *data, size_t size)
{
    if (dataBuffer == nullptr) {
        ACL_LOG_ERROR("[Check][DataBuffer]invalid input pointer of dataBuffer, please use aclCreateDataBuffer "
            "interface to create.");
        acl::AclErrorLogManager::ReportInputError(acl::INVALID_NULL_POINTER_MSG,
            std::vector<const char *>({"param"}), std::vector<const char *>({"dataBuffer"}));
        return ACL_ERROR_INVALID_PARAM;
    }
    dataBuffer->data = data;
    dataBuffer->length = size;
    return ACL_SUCCESS;
}

void *aclGetDataBufferAddrImpl(const aclDataBuffer *dataBuffer)
{
    if (dataBuffer == nullptr) {
        return nullptr;
    }

    return dataBuffer->data;
}

uint32_t aclGetDataBufferSizeImpl(const aclDataBuffer *dataBuffer)
{
    if (dataBuffer == nullptr) {
        return 0U;
    }

    return static_cast<uint32_t>(dataBuffer->length);
}

size_t aclGetDataBufferSizeV2Impl(const aclDataBuffer *dataBuffer)
{
    if (dataBuffer == nullptr) {
        return 0U;
    }

    return static_cast<size_t>(dataBuffer->length);
}
