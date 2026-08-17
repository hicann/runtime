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
int DumpDataset(const acltdtDataset* dataset)
{
    const size_t datasetSize = acltdtGetDatasetSize(dataset);
    INFO_LOG("Dataset size: %zu", datasetSize);
    if (datasetSize == 0) {
        return 0;
    }

    acltdtDataItem* item = acltdtGetDataItem(dataset, 0);
    if (item == nullptr) {
        ERROR_LOG("acltdtGetDataItem returned nullptr");
        return -1;
    }

    const size_t dimNum = acltdtGetDimNumFromItem(item);
    std::vector<int64_t> dims(dimNum, 0);
    if (dimNum > 0) {
        CHECK_ERROR(acltdtGetDimsFromItem(item, dims.data(), dimNum));
    }

    float* tensorData = static_cast<float*>(acltdtGetDataAddrFromItem(item));
    INFO_LOG(
        "Tensor type=%d, data type=%d, bytes=%zu, dims=(%lld, %lld), firstValue=%.3f",
        static_cast<int32_t>(acltdtGetTensorTypeFromItem(item)), static_cast<int32_t>(acltdtGetDataTypeFromItem(item)),
        acltdtGetDataSizeFromItem(item), static_cast<long long>(dimNum > 0 ? dims[0] : 0),
        static_cast<long long>(dimNum > 1 ? dims[1] : 0), tensorData == nullptr ? 0.0F : tensorData[0]);
    return 0;
}

} // namespace

int main()
{
    const uint32_t deviceId = 0;
    constexpr size_t kChannelCapacity = 2;
    constexpr int32_t kTimeoutMs = 1000;
    std::vector<float> hostTensor = {1.0F, 2.0F, 3.0F, 4.0F};
    acltdtDataset* sendDataset = nullptr;
    acltdtDataset* recvDataset = nullptr;
    acltdtChannelHandle* channel = nullptr;
    bool aclInitialized = false;
    bool deviceSet = false;

    const int32_t result = [&]() -> int32_t {
        CHECK_ERROR(aclInit(nullptr));
        aclInitialized = true;
        CHECK_ERROR(aclrtSetDevice(deviceId));
        deviceSet = true;

        channel = acltdtCreateChannelWithCapacity(deviceId, "simple_tdt_channel", kChannelCapacity);
        if (channel == nullptr) {
            WARN_LOG("acltdtCreateChannelWithCapacity returned nullptr: this sample needs a queue-backed TDT channel "
                     "so it can send and receive within one host process");
            return 0;
        }

        sendDataset = tdt::CreateFloatDataset(hostTensor);
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

        CHECK_ERROR(acltdtSendTensor(channel, sendDataset, kTimeoutMs));

        size_t channelSize = 0;
        CHECK_ERROR(acltdtQueryChannelSize(channel, &channelSize));
        INFO_LOG("Channel size after send: %zu", channelSize);

        CHECK_ERROR(acltdtReceiveTensor(channel, recvDataset, kTimeoutMs));

        if (DumpDataset(recvDataset) != 0) {
            return -1;
        }

        CHECK_ERROR(acltdtQueryChannelSize(channel, &channelSize));
        INFO_LOG("Channel size after receive: %zu", channelSize);
        return 0;
    }();

    int32_t finalResult = result;
    if (channel != nullptr) {
        tdt::UpdateFinalResultOnError("acltdtCleanChannel(channel)", acltdtCleanChannel(channel), finalResult);
        tdt::UpdateFinalResultOnError("acltdtStopChannel(channel)", acltdtStopChannel(channel), finalResult);
        tdt::UpdateFinalResultOnError("acltdtDestroyChannel(channel)", acltdtDestroyChannel(channel), finalResult);
    }

    tdt::DestroyDataset(recvDataset);
    tdt::DestroyDatasetAndItems(sendDataset);

    if (deviceSet) {
        tdt::UpdateFinalResultOnError(
            "aclrtResetDeviceForce(static_cast<int32_t>(deviceId))",
            aclrtResetDeviceForce(static_cast<int32_t>(deviceId)), finalResult);
    }
    if (aclInitialized) {
        tdt::UpdateFinalResultOnError("aclFinalize()", aclFinalize(), finalResult);
    }
    if (finalResult == 0 && channel != nullptr) {
        INFO_LOG("Run the simple_channel sample successfully.");
    }
    return finalResult;
}
