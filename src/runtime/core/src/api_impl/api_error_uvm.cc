/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "api_error.hpp"
#include "osal.hpp"
#include "global_state_manager.hpp"

namespace cce {
namespace runtime {
rtError_t ApiErrorDecorator::MemManagedAdvise(const void *const ptr, uint64_t size, uint16_t advise, rtMemManagedLocation location)
{
    NULL_PTR_RETURN_MSG_OUTER(ptr, RT_ERROR_INVALID_VALUE);
    ZERO_RETURN_AND_MSG_OUTER(size);
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM(advise > rtMemAdviseUnSetAccessedBy, RT_ERROR_INVALID_VALUE, advise, "[0, " + std::to_string(rtMemAdviseUnSetAccessedBy) + "]");
    if (location.type == rtMemLocationTypeDevice) {
        int32_t numDev = 0;
        rtError_t ret = impl_->GetDeviceCount(&numDev);
        ERROR_RETURN(ret, "Get device count failed.");
        COND_RETURN_AND_MSG_OUTER_WITH_PARAM((location.id > (numDev - 1)) || (location.id < 0), RT_ERROR_INVALID_VALUE, 
                                            location.id, "[0, " + std::to_string(numDev - 1) + "]");
    }

    if (location.type == rtMemLocationTypeHostNuma) {
        location.id ++;
    }
    const rtError_t error = impl_->MemManagedAdvise(ptr, size, advise, location);
    COND_RETURN_ERROR((error != RT_ERROR_NONE) && (error != RT_ERROR_DRV_NOT_SUPPORT),
        error, "MemManaged advise failed, size=%" PRIu64 ", advise=%hu", size, advise);
    return error;
}

rtError_t ApiErrorDecorator::MemManagedGetAttr(rtMemManagedRangeAttribute attribute, const void *ptr, size_t size, void *data, size_t dataSize)
{
    NULL_PTR_RETURN_MSG_OUTER(data, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(ptr, RT_ERROR_INVALID_VALUE);
    ZERO_RETURN_MSG_OUTER(size);
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM(
        (attribute < rtMemRangeAttributeReadMostly) || (attribute > rtMemRangeAttributeLastPrefetchLocationId), 
        RT_ERROR_INVALID_VALUE, attribute, 
        "[" + std::to_string(rtMemRangeAttributeReadMostly) + ", " +
        std::to_string(rtMemRangeAttributeLastPrefetchLocationId) + "]");

    rtError_t error = impl_->MemManagedGetAttr(attribute, ptr, size, data, dataSize);
    COND_RETURN_ERROR((error != RT_ERROR_NONE) && (error != RT_ERROR_DRV_NOT_SUPPORT), error, "Get mem attribute failed");
    return error;
}

rtError_t ApiErrorDecorator::MemManagedGetAttrs(rtMemManagedRangeAttribute *attributes, size_t numAttributes, const void *ptr, 
                                size_t size, void **data, size_t *dataSizes)
{
    NULL_PTR_RETURN_MSG_OUTER(data, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(dataSizes, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(attributes, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(ptr, RT_ERROR_INVALID_VALUE);
    ZERO_RETURN_MSG_OUTER(size);

    for (size_t i = 0U; i < numAttributes; i++) {
        COND_RETURN_AND_MSG_OUTER_WITH_PARAM((attributes[i] < rtMemRangeAttributeReadMostly) || 
                                            (attributes[i] > rtMemRangeAttributeLastPrefetchLocationId), 
                                            RT_ERROR_INVALID_VALUE, attributes[i], 
                                            "[" + std::to_string(rtMemRangeAttributeReadMostly) + ", " +
                                            std::to_string(rtMemRangeAttributeLastPrefetchLocationId) + "]");
    }

    rtError_t error = impl_->MemManagedGetAttrs(attributes, numAttributes, ptr, size, data, dataSizes);
    COND_RETURN_ERROR((error != RT_ERROR_NONE) && (error != RT_ERROR_DRV_NOT_SUPPORT), error, "Get mem attributes failed");
    return error;
}
}
}