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
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(ptr, RT_ERROR_INVALID_VALUE, "Managing the policy attributes of the unified virtual memory (UVM)");
    ZERO_RETURN_AND_MSG_OUTER(size);
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM(advise > rtMemAdviseUnSetAccessedBy, RT_ERROR_INVALID_VALUE, advise, "[0, " + std::to_string(rtMemAdviseUnSetAccessedBy) + "]");
    if (location.type == rtMemLocationTypeDevice) {
        int32_t numDev = 0;
        const rtError_t ret = impl_->GetDeviceCount(&numDev);
        ERROR_RETURN(ret, "Get device count failed.");
        COND_RETURN_AND_MSG_OUTER_WITH_PARAM((location.id > (numDev - 1)) || (location.id < 0), RT_ERROR_INVALID_VALUE, 
                                            location.id, "[0, " + std::to_string(numDev - 1) + "]");
    }
    const rtError_t error = impl_->MemManagedAdvise(ptr, size, advise, location);
    COND_RETURN_ERROR((error != RT_ERROR_NONE) && (error != RT_ERROR_DRV_NOT_SUPPORT),
        error, "MemManaged advise failed, size=%" PRIu64 ", advise=%hu", size, advise);
    return error;
}

rtError_t ApiErrorDecorator::MemManagedGetAttr(rtMemManagedRangeAttribute attribute, const void *ptr, size_t size, void *data, size_t dataSize)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(data, RT_ERROR_INVALID_VALUE, "Querying a policy attribute value of the UVM of a specified size");
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(ptr, RT_ERROR_INVALID_VALUE, "Querying a policy attribute value of the UVM of a specified size");
    ZERO_RETURN_AND_MSG_OUTER(size);
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM(
        (attribute < rtMemRangeAttributeReadMostly) || (attribute > rtMemRangeAttributeLastPrefetchLocationId), 
        RT_ERROR_INVALID_VALUE, attribute, 
        "[" + std::to_string(rtMemRangeAttributeReadMostly) + ", " +
        std::to_string(rtMemRangeAttributeLastPrefetchLocationId) + "]");

    const rtError_t error = impl_->MemManagedGetAttr(attribute, ptr, size, data, dataSize);
    COND_RETURN_ERROR((error != RT_ERROR_NONE) && (error != RT_ERROR_DRV_NOT_SUPPORT), error, "Get mem attribute failed");
    return error;
}

rtError_t ApiErrorDecorator::MemManagedGetAttrs(rtMemManagedRangeAttribute *attributes, size_t numAttributes, const void *ptr, 
                                size_t size, void **data, size_t *dataSizes)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(data, RT_ERROR_INVALID_VALUE, "Querying multiple policy attribute values of the UVM of a specified size");
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(dataSizes, RT_ERROR_INVALID_VALUE, "Querying multiple policy attribute values of the UVM of a specified size");
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(attributes, RT_ERROR_INVALID_VALUE, "Querying multiple policy attribute values of the UVM of a specified size");
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(ptr, RT_ERROR_INVALID_VALUE, "Querying multiple policy attribute values of the UVM of a specified size");
    ZERO_RETURN_AND_MSG_OUTER(size);

    for (size_t i = 0U; i < numAttributes; i++) {
        COND_RETURN_AND_MSG_OUTER_WITH_PARAM((attributes[i] < rtMemRangeAttributeReadMostly) || 
                                            (attributes[i] > rtMemRangeAttributeLastPrefetchLocationId), 
                                            RT_ERROR_INVALID_VALUE, attributes[i], 
                                            "[" + std::to_string(rtMemRangeAttributeReadMostly) + ", " +
                                            std::to_string(rtMemRangeAttributeLastPrefetchLocationId) + "]");
    }

    const rtError_t error = impl_->MemManagedGetAttrs(attributes, numAttributes, ptr, size, data, dataSizes);
    COND_RETURN_ERROR((error != RT_ERROR_NONE) && (error != RT_ERROR_DRV_NOT_SUPPORT), error, "Get mem attributes failed");
    return error;
}

rtError_t ApiErrorDecorator::MemManagedPrefetchAsync(const void *ptr, size_t size, rtMemManagedLocation location,
    uint32_t flags, Stream* const stream)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(ptr, RT_ERROR_INVALID_VALUE, "Managing the prefetching of the unified virtual memory (UVM)");
    ZERO_RETURN_AND_MSG_OUTER(size);
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM((flags != 0), RT_ERROR_INVALID_VALUE, flags, "equal to 0");
    Stream *curStm = Runtime::Instance()->GetCurStream(stream);
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(curStm, RT_ERROR_STREAM_NULL, "Managing the prefetching of the unified virtual memory (UVM)");
    if (location.type == rtMemLocationTypeDevice) {
        int32_t numDev = 0;
        const rtError_t ret = impl_->GetDeviceCount(&numDev);
        ERROR_RETURN_MSG_CALL(ERR_MODULE_DRV, ret, "Get device cnt failed, retCode=%#x", static_cast<uint32_t>(ret));
        COND_RETURN_AND_MSG_OUTER_WITH_PARAM((location.id > (numDev - 1)) || (location.id < 0), RT_ERROR_INVALID_VALUE,
            location.id, "[0, " + std::to_string(numDev - 1) + "]");
    }

    const rtError_t error = impl_->MemManagedPrefetchAsync(ptr, size, location, flags, curStm);
    COND_RETURN_ERROR((error != RT_ERROR_NONE) && (error != RT_ERROR_DRV_NOT_SUPPORT), error,
        "Memory prefetch async failed, ret=%d, size=%u, loc_type=%u, loc_id=%d.",
        static_cast<int32_t>(error), size, static_cast<uint32_t>(location.type), location.id);
    return error;
}

rtError_t ApiErrorDecorator::MemManagedPrefetchBatchAsync(const void** ptrs, size_t* sizes, size_t count,
    rtMemManagedLocation* prefetchLocs, size_t* prefetchLocIdxs, size_t numPrefetchLocs, uint64_t flags,
    Stream* const stream)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(ptrs, RT_ERROR_INVALID_VALUE, "Managing the batch prefetching of the unified virtual memory (UVM)");
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(sizes, RT_ERROR_INVALID_VALUE, "Managing the batch prefetching of the unified virtual memory (UVM)");
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(prefetchLocs, RT_ERROR_INVALID_VALUE, "Managing the batch prefetching of the unified virtual memory (UVM)");
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(prefetchLocIdxs, RT_ERROR_INVALID_VALUE, "Managing the batch prefetching of the unified virtual memory (UVM)");
    ZERO_RETURN_AND_MSG_OUTER(count);
    ZERO_RETURN_AND_MSG_OUTER(numPrefetchLocs);
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM((flags != 0), RT_ERROR_INVALID_VALUE, flags, "equal to 0");
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM((numPrefetchLocs > count), RT_ERROR_INVALID_VALUE,
        numPrefetchLocs, "less than or equal to count");
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM((prefetchLocIdxs[0] != 0), RT_ERROR_INVALID_VALUE,
        prefetchLocIdxs[0], "equal to 0");
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM((prefetchLocIdxs[0] >= count), RT_ERROR_INVALID_VALUE,
        prefetchLocIdxs[0], "less than count");

    for (size_t idx = 0; idx < count; idx++) {
        NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(ptrs[idx], RT_ERROR_INVALID_VALUE, "Managing the batch prefetching of the unified virtual memory (UVM)");
    }

    for (size_t idx = 0; idx < numPrefetchLocs; idx++) {
        COND_RETURN_AND_MSG_OUTER(prefetchLocIdxs[idx] >= count, RT_ERROR_INVALID_VALUE, ErrorCode::EE1017, "Managing the batch prefetching of the unified virtual memory (UVM)",
            RtFmtMsg("prefetchLocIdxs[%zu] or count", idx), RtFmtMsg("Elements in array prefetchLocIdxs should be less than count."
                " Parameter prefetchLocIdxs[%zu] is %zu, and count is %zu", idx, prefetchLocIdxs[idx], count));
        
        if (idx >= 1) {
            COND_RETURN_AND_MSG_OUTER((prefetchLocIdxs[idx] <= prefetchLocIdxs[idx - 1]), RT_ERROR_INVALID_VALUE, ErrorCode::EE1017,
                "Managing the batch prefetching of the unified virtual memory (UVM)", RtFmtMsg("prefetchLocIdxs[%zu] or prefetchLocIdxs[%zu]", idx, idx - 1),
                RtFmtMsg("Each element in prefetchLocIdxs must be greater than the previous element."
                    " Parameter prefetchLocIdxs[%zu] is %zu, and prefetchLocIdxs[%zu] is %zu",
                    idx, prefetchLocIdxs[idx], idx - 1, prefetchLocIdxs[idx - 1]));
        }
    }

    for (size_t idx = 0; idx < numPrefetchLocs; idx++) {
        if (prefetchLocs[idx].type == rtMemLocationTypeDevice) {
            int32_t numDev = 0;
            const rtError_t ret = impl_->GetDeviceCount(&numDev);
            ERROR_RETURN_MSG_CALL(ERR_MODULE_DRV, ret, "Get device cnt failed, retCode=%#x", static_cast<uint32_t>(ret));
            COND_RETURN_AND_MSG_OUTER_WITH_PARAM((prefetchLocs[idx].id > (numDev - 1)) || (prefetchLocs[idx].id < 0),
                RT_ERROR_INVALID_VALUE, prefetchLocs[idx].id, "[0, " + std::to_string(numDev - 1) + "]");
        }
    }

    Stream *curStm = Runtime::Instance()->GetCurStream(stream);
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(curStm, RT_ERROR_STREAM_NULL, "Managing the batch prefetching of the unified virtual memory (UVM)");

    const rtError_t error = impl_->MemManagedPrefetchBatchAsync(ptrs, sizes, count, prefetchLocs, prefetchLocIdxs,
        numPrefetchLocs, flags, curStm);
    COND_RETURN_ERROR((error != RT_ERROR_NONE) && (error != RT_ERROR_DRV_NOT_SUPPORT), error,
        "Memory prefetch batch async failed, ret=%d, sizes[0]=%u, loc[0].type=%u, loc[0].id=%d.",
        static_cast<int32_t>(error), sizes[0], static_cast<uint32_t>(prefetchLocs[0].type), prefetchLocs[0].id);
    return error;
}

}  // namespace runtime
}  // namespace cce
