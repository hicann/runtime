/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <cstdint>
#include <vector>
#include "acl/acl.h"
#include "acl/acl_tdt.h"
#include "2_advanced_features/tdt_common_utils.h"
#include "utils.h"

namespace {
acltdtDataset *CreateDataset(std::vector<float> &values)
{
    int64_t dims[] = {1, static_cast<int64_t>(values.size())};
    acltdtDataItem *item = acltdtCreateDataItem(
        ACL_TENSOR_DATA_TENSOR,
        dims,
        sizeof(dims) / sizeof(dims[0]),
        ACL_FLOAT,
        values.data(),
        values.size() * sizeof(float));
    if (item == nullptr) {
        return nullptr;
    }

    acltdtDataset *dataset = acltdtCreateDataset();
    if (dataset == nullptr) {
        acltdtDestroyDataItem(item);
        return nullptr;
    }

    if (acltdtAddDataItem(dataset, item) != ACL_SUCCESS) {
        acltdtDestroyDataItem(item);
        acltdtDestroyDataset(dataset);
        return nullptr;
    }
    return dataset;
}

void DestroyDataset(acltdtDataset *dataset)
{
    if (dataset == nullptr) {
        return;
    }

    const size_t datasetSize = acltdtGetDatasetSize(dataset);
    for (size_t i = 0; i < datasetSize; ++i) {
        acltdtDataItem *item = acltdtGetDataItem(dataset, i);
        if (item != nullptr) {
            (void)acltdtDestroyDataItem(item);
        }
    }
    (void)acltdtDestroyDataset(dataset);
}

} // namespace

int main()
{
    const uint32_t deviceId = 0;
    std::vector<float> firstTensor = {10.0F, 20.0F};
    std::vector<float> secondTensor = {30.0F, 40.0F};
    acltdtDataset *firstDataset = nullptr;
    acltdtDataset *secondDataset = nullptr;
    acltdtChannelHandle *channel = nullptr;

    CHECK_ERROR(aclInit(nullptr));
    CHECK_ERROR(aclrtSetDevice(deviceId));

    channel = acltdtCreateChannelWithCapacity(deviceId, "capacity_tdt_channel", 1);
    if (!tdt::CheckNotNull(channel, "acltdtCreateChannelWithCapacity")) {
        return -1;
    }

    firstDataset = CreateDataset(firstTensor);
    secondDataset = CreateDataset(secondTensor);
    if (!tdt::CheckNotNull(firstDataset, "firstDataset")) {
        return -1;
    }
    if (!tdt::CheckNotNull(secondDataset, "secondDataset")) {
        return -1;
    }

    acltdtDataItem *firstItem = acltdtGetDataItem(firstDataset, 0);
    if (!tdt::CheckNotNull(firstItem, "acltdtGetDataItem")) {
        return -1;
    }

    size_t sliceNum = 0;
    size_t sliceId = 0;
    aclError sliceRet = acltdtGetSliceInfoFromItem(firstItem, &sliceNum, &sliceId);
    INFO_LOG(
        "Slice info ret=%d, sliceNum=%zu, sliceId=%zu, tensorType=%d, datasetName=%s",
        static_cast<int32_t>(sliceRet),
        sliceNum,
        sliceId,
        static_cast<int32_t>(acltdtGetTensorTypeFromItem(firstItem)),
        acltdtGetDatasetName(firstDataset) == nullptr ? "<null>" : acltdtGetDatasetName(firstDataset));

    CHECK_ERROR(acltdtSendTensor(channel, firstDataset, 1000));

    size_t channelSize = 0;
    CHECK_ERROR(acltdtQueryChannelSize(channel, &channelSize));
    INFO_LOG("Channel size after first send: %zu", channelSize);

    aclError secondSendRet = acltdtSendTensor(channel, secondDataset, 0);
    INFO_LOG("Second send ret under capacity pressure: %d", static_cast<int32_t>(secondSendRet));

    CHECK_ERROR(acltdtCleanChannel(channel));
    CHECK_ERROR(acltdtStopChannel(channel));
    CHECK_ERROR(acltdtDestroyChannel(channel));

    DestroyDataset(secondDataset);
    DestroyDataset(firstDataset);

    CHECK_ERROR(aclrtResetDeviceForce(static_cast<int32_t>(deviceId)));
    CHECK_ERROR(aclFinalize());
    return 0;
}
