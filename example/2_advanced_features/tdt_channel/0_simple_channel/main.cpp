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

int DumpDataset(const acltdtDataset *dataset)
{
    const size_t datasetSize = acltdtGetDatasetSize(dataset);
    INFO_LOG("Dataset size: %zu", datasetSize);
    if (datasetSize == 0) {
        return 0;
    }

    acltdtDataItem *item = acltdtGetDataItem(dataset, 0);
    if (item == nullptr) {
        ERROR_LOG("acltdtGetDataItem returned nullptr");
        return -1;
    }

    const size_t dimNum = acltdtGetDimNumFromItem(item);
    std::vector<int64_t> dims(dimNum, 0);
    if (dimNum > 0) {
        CHECK_ERROR(acltdtGetDimsFromItem(item, dims.data(), dimNum));
    }

    float *tensorData = static_cast<float *>(acltdtGetDataAddrFromItem(item));
    INFO_LOG(
        "Tensor type=%d, data type=%d, bytes=%zu, dims=(%lld, %lld), firstValue=%.3f",
        static_cast<int32_t>(acltdtGetTensorTypeFromItem(item)),
        static_cast<int32_t>(acltdtGetDataTypeFromItem(item)),
        acltdtGetDataSizeFromItem(item),
        static_cast<long long>(dimNum > 0 ? dims[0] : 0),
        static_cast<long long>(dimNum > 1 ? dims[1] : 0),
        tensorData == nullptr ? 0.0F : tensorData[0]);
    return 0;
}

} // namespace

int main()
{
    const uint32_t deviceId = 0;
    std::vector<float> hostTensor = {1.0F, 2.0F, 3.0F, 4.0F};
    acltdtDataset *sendDataset = nullptr;
    acltdtDataset *recvDataset = nullptr;
    acltdtChannelHandle *channel = nullptr;

    CHECK_ERROR(aclInit(nullptr));
    CHECK_ERROR(aclrtSetDevice(deviceId));

    channel = acltdtCreateChannel(deviceId, "simple_tdt_channel");
    if (!tdt::CheckNotNull(channel, "acltdtCreateChannel")) {
        return -1;
    }

    sendDataset = CreateDataset(hostTensor);
    if (!tdt::CheckNotNull(sendDataset, "sendDataset")) {
        return -1;
    }

    recvDataset = acltdtCreateDataset();
    if (!tdt::CheckNotNull(recvDataset, "acltdtCreateDataset")) {
        return -1;
    }

    if (DumpDataset(sendDataset) != 0) {
        return -1;
    }

    CHECK_ERROR(acltdtSendTensor(channel, sendDataset, 1000));
    CHECK_ERROR(acltdtReceiveTensor(channel, recvDataset, 1000));

    if (DumpDataset(recvDataset) != 0) {
        return -1;
    }

    size_t channelSize = 0;
    CHECK_ERROR(acltdtQueryChannelSize(channel, &channelSize));
    INFO_LOG("Channel size after send/receive: %zu", channelSize);

    CHECK_ERROR(acltdtStopChannel(channel));
    CHECK_ERROR(acltdtCleanChannel(channel));
    CHECK_ERROR(acltdtDestroyChannel(channel));

    DestroyDataset(recvDataset);
    DestroyDataset(sendDataset);

    CHECK_ERROR(aclrtResetDeviceForce(static_cast<int32_t>(deviceId)));
    CHECK_ERROR(aclFinalize());
    return 0;
}
