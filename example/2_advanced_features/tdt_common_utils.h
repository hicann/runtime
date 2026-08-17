/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef TDT_COMMON_UTILS_H
#define TDT_COMMON_UTILS_H

#include <cstdint>
#include <vector>
#include "acl/acl.h"
#include "acl/acl_tdt.h"
#include "utils.h"

namespace tdt {
inline bool CheckNotNull(const void* ptr, const char* name)
{
    if (ptr == nullptr) {
        ERROR_LOG("%s is nullptr", name);
        return false;
    }
    return true;
}

inline acltdtDataset* CreateFloatDataset(std::vector<float>& values)
{
    int64_t dims[] = {1, static_cast<int64_t>(values.size())};
    acltdtDataItem* item = acltdtCreateDataItem(
        ACL_TENSOR_DATA_TENSOR, dims, sizeof(dims) / sizeof(dims[0]), ACL_FLOAT, values.data(),
        values.size() * sizeof(float));
    if (item == nullptr) {
        return nullptr;
    }

    acltdtDataset* dataset = acltdtCreateDataset();
    if (dataset == nullptr) {
        (void)acltdtDestroyDataItem(item);
        return nullptr;
    }

    if (acltdtAddDataItem(dataset, item) != ACL_SUCCESS) {
        (void)acltdtDestroyDataItem(item);
        (void)acltdtDestroyDataset(dataset);
        return nullptr;
    }
    return dataset;
}

inline void DestroyDatasetAndItems(acltdtDataset* dataset)
{
    if (dataset == nullptr) {
        return;
    }

    const size_t datasetSize = acltdtGetDatasetSize(dataset);
    for (size_t i = 0; i < datasetSize; ++i) {
        acltdtDataItem* item = acltdtGetDataItem(dataset, i);
        if (item != nullptr) {
            (void)acltdtDestroyDataItem(item);
        }
    }
    (void)acltdtDestroyDataset(dataset);
}

inline void DestroyDataset(acltdtDataset* dataset)
{
    if (dataset == nullptr) {
        return;
    }
    (void)acltdtDestroyDataset(dataset);
}

inline void UpdateFinalResultOnError(const char* apiName, aclError ret, int32_t& finalResult)
{
    if (ret == ACL_SUCCESS) {
        return;
    }
    ERROR_LOG("Operation failed: %s returned error code %d", apiName, static_cast<int32_t>(ret));
    finalResult = -1;
}
} // namespace tdt

#endif
