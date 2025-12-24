/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef ACL_RESOURCE_STATISTICS_H_
#define ACL_RESOURCE_STATISTICS_H_

#include <atomic>
#include <cstdint>

#include "acl/acl_base.h"

#define ACL_ADD_APPLY_TOTAL_COUNT(resourceType) \
    acl::ResourceStatistics::GetInstance().AddApplyTotalCount(resourceType)
#define ACL_ADD_APPLY_SUCCESS_COUNT(resourceType) \
    acl::ResourceStatistics::GetInstance().AddApplySuccCount(resourceType)
#define ACL_ADD_RELEASE_TOTAL_COUNT(resourceType) \
    acl::ResourceStatistics::GetInstance().AddReleaseTotalCount(resourceType)
#define ACL_ADD_RELEASE_SUCCESS_COUNT(resourceType) \
    acl::ResourceStatistics::GetInstance().AddReleaseSuccCount(resourceType)

namespace acl {
    enum ResourceType : int32_t {
        ACL_STATISTICS_MALLOC_FREE = 0,
        ACL_STATISTICS_MALLOC_FREE_HOST,
        ACL_STATISTICS_CREATE_DESTROY_CONTEXT,
        ACL_STATISTICS_SET_RESET_DEVICE,
        ACL_STATISTICS_CREATE_DESTROY_EVENT,
        ACL_STATISTICS_CREATE_DESTROY_STREAM,
        ACL_STATISTICS_DVPP_MALLOC_FREE,
        ACL_STATISTICS_RECORD_RESET_EVENT,
        ACL_STATISTICS_CREATE_DESTROY_DATA_BUFFER,
        ACL_STATISTICS_CREATE_DESTROY_TENSOR_DESC,
        ACL_STATISTICS_CREATE_DESTROY_DESC,
        ACL_STATISTICS_CREATE_DESTROY_DATASET,
        ACL_STATISTICS_CREATE_LOAD_UNLOAD_MODEL,
        ACL_STATISTICS_CREATE_DESTROY_AIPP,
        ACL_STATISTICS_CREATE_DESTROY_ATTR,
        ACL_STATISTICS_CREATE_DESTROY_HANDLE,
        ACL_STATISTICS_CREATE_DESTROY_DVPP_CHANNEL_DESC,
        ACL_STATISTICS_CREATE_DESTROY_DVPP_PIC_DESC,
        ACL_STATISTICS_CREATE_DESTROY_DVPP_ROI_CONFIG,
        ACL_STATISTICS_CREATE_DESTROY_DVPP_RESIZE_CONFIG,
        ACL_STATISTICS_CREATE_DESTROY_DVPP_JPEGE_CONFIG,
        ACL_STATISTICS_CREATE_DESTROY_VDEC_CHANNEL_DESC,
        ACL_STATISTICS_CREATE_DESTROY_VENC_CHANNEL_DESC,
        ACL_STATISTICS_CREATE_DESTROY_DVPP_STREAM_DESC,
        ACL_STATISTICS_CREATE_DESTROY_VDEC_FRAME_CONFIG,
        ACL_STATISTICS_CREATE_DESTROY_VENC_FRAME_CONFIG,
        ACL_STATISTICS_CREATE_DESTROY_DVPP_CHANNEL,
        ACL_STATISTICS_CREATE_DESTROY_VDEC_CHANNEL,
        ACL_STATISTICS_CREATE_DESTROY_VENC_CHANNEL,
        ACL_STATISTICS_CREATE_DESTROY_DVPP_BATCH_PIC_DESC,
        ACL_STATISTICS_CREATE_DESTROY_GROUP_INFO,
        ACL_STATISTICS_CREATE_DESTROY_PROF_CONFIG,
        ACL_STATISTICS_CREATE_DESTROY_PROF_SUB_CONFIG,
        ACL_STATISTICS_CREATE_DESTROY_MODEL_CONFIG,
        ACL_STATISTICS_CREATE_DESTROY_QUEUE_ID,
        ACL_STATISTICS_CREATE_DESTROY_QUEUE_ATTR,
        ACL_STATISTICS_CREATE_DESTROY_QUEUE_ROUTE,
        ACL_STATISTICS_CREATE_DESTROY_QUEUE_ROUTE_LIST,
        ACL_STATISTICS_CREATE_DESTROY_QUEUE_ROUTE_QUERY,
        ACL_STATISTICS_CREATE_DESTROY_MBUF,
        ACL_STATISTICS_CREATE_DESTROY_GRAPH_DUMP_OPTION,
        ACL_STATISTICS_CREATE_DESTROY_ALLOCATOR_DESC,
        ACL_STATISTICS_CREATE_DESTROY_ALLOCATOR_BINARY_DESC,
        ACL_STATISTICS_RESERVE_RELEASE_MEMORY_ADDRESS,
        ACL_STATISTICS_MALLOC_FREE_PHYSICAL_MEMORY,
        ACL_STATISTICS_MAP_UNMAP_MEMORY,
        ACL_STATISTICS_LOAD_UNLOAD_BINARY,
        // add enum before this comment, ACL_STATISTICS_RESOURCE_TYPE_SIZE is length of enum
        ACL_STATISTICS_RESOURCE_TYPE_SIZE,
    };

    enum ApplyReleaseType : int32_t {
        APPLY_TOTAL = 0,
        APPLY_SUCCESS,
        RELEASE_TOTAL,
        RELEASE_SUCCESS,
        APPLY_RELEASE_SIZE
    };

    class ResourceStatisticsValue {
    public:
        ResourceStatisticsValue()
        {
            Init();
        }

        void Init()
        {
            for (uint32_t i = 0U; i < static_cast<uint32_t>(APPLY_RELEASE_SIZE); ++i) {
                (void)appplyReleaseValue[i].exchange(0U);
            }
        }

        ~ResourceStatisticsValue() = default;
    private:
        friend class ResourceStatistics;
        std::atomic<uint64_t> appplyReleaseValue[APPLY_RELEASE_SIZE] {};
    };

    class ACL_FUNC_VISIBILITY ResourceStatistics {
    public:
        static ResourceStatistics &GetInstance();
        void AddApplyTotalCount(const ResourceType theResourceType);
        void AddApplySuccCount(const ResourceType theResourceType);
        void AddReleaseTotalCount(const ResourceType theResourceType);
        void AddReleaseSuccCount(const ResourceType theResourceType);
        void TraverseStatistics() const;
    private:
        ResourceStatistics() = default;
        ~ResourceStatistics() = default;
        ResourceStatisticsValue counter_[ACL_STATISTICS_RESOURCE_TYPE_SIZE];
    };
}

#endif // ACL_RESOURCE_STATISTICS_H_
