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
constexpr size_t kChannelCapacity = 2;

} // namespace

int main()
{
    const uint32_t deviceId = 0;
    std::vector<float> firstTensor = {10.0F, 20.0F};
    std::vector<float> secondTensor = {30.0F, 40.0F};
    std::vector<float> thirdTensor = {50.0F, 60.0F};
    acltdtDataset* firstDataset = nullptr;
    acltdtDataset* secondDataset = nullptr;
    acltdtDataset* thirdDataset = nullptr;
    acltdtChannelHandle* channel = nullptr;
    bool aclInitialized = false;
    bool deviceSet = false;

    const int32_t result = [&]() -> int32_t {
        CHECK_ERROR(aclInit(nullptr));
        aclInitialized = true;
        CHECK_ERROR(aclrtSetDevice(deviceId));
        deviceSet = true;

        channel = acltdtCreateChannelWithCapacity(deviceId, "capacity_tdt_channel", kChannelCapacity);
        if (channel == nullptr) {
            WARN_LOG("acltdtCreateChannelWithCapacity returned nullptr: the current runtime likely does not enable "
                     "capacity-limited TDT channels on this product/build");
            return 0;
        }

        firstDataset = tdt::CreateFloatDataset(firstTensor);
        secondDataset = tdt::CreateFloatDataset(secondTensor);
        thirdDataset = tdt::CreateFloatDataset(thirdTensor);
        if (!tdt::CheckNotNull(firstDataset, "firstDataset")) {
            return -1;
        }
        if (!tdt::CheckNotNull(secondDataset, "secondDataset")) {
            return -1;
        }
        if (!tdt::CheckNotNull(thirdDataset, "thirdDataset")) {
            return -1;
        }

        acltdtDataItem* firstItem = acltdtGetDataItem(firstDataset, 0);
        if (!tdt::CheckNotNull(firstItem, "acltdtGetDataItem")) {
            return -1;
        }

        size_t sliceNum = 0;
        size_t sliceId = 0;
        aclError sliceRet = acltdtGetSliceInfoFromItem(firstItem, &sliceNum, &sliceId);
        INFO_LOG(
            "Slice info ret=%d, sliceNum=%zu, sliceId=%zu, tensorType=%d, datasetName=%s",
            static_cast<int32_t>(sliceRet), sliceNum, sliceId,
            static_cast<int32_t>(acltdtGetTensorTypeFromItem(firstItem)),
            acltdtGetDatasetName(firstDataset) == nullptr ? "<null>" : acltdtGetDatasetName(firstDataset));

        CHECK_ERROR(acltdtSendTensor(channel, firstDataset, 1000));

        size_t channelSize = 0;
        CHECK_ERROR(acltdtQueryChannelSize(channel, &channelSize));
        INFO_LOG("Channel size after first send: %zu", channelSize);

        aclError secondSendRet = acltdtSendTensor(channel, secondDataset, 0);
        if (secondSendRet == ACL_SUCCESS) {
            CHECK_ERROR(acltdtQueryChannelSize(channel, &channelSize));
            INFO_LOG("Channel size after second send: %zu", channelSize);

            aclError thirdSendRet = acltdtSendTensor(channel, thirdDataset, 0);
            INFO_LOG("Third send ret under capacity pressure: %d", static_cast<int32_t>(thirdSendRet));
        } else if (secondSendRet == ACL_ERROR_RT_QUEUE_FULL) {
            INFO_LOG(
                "Second send reached capacity pressure immediately: ret=%d, queried channel size=%zu, "
                "configured capacity=%zu",
                static_cast<int32_t>(secondSendRet), channelSize, kChannelCapacity);
        } else {
            ERROR_LOG(
                "Operation failed: acltdtSendTensor(channel, secondDataset, 0) returned error code %d",
                static_cast<int32_t>(secondSendRet));
            return -1;
        }
        return 0;
    }();

    int32_t finalResult = result;
    if (channel != nullptr) {
        const aclError cleanRet = acltdtCleanChannel(channel);
        if (cleanRet != ACL_SUCCESS) {
            ERROR_LOG(
                "Operation failed: acltdtCleanChannel(channel) returned error code %d", static_cast<int32_t>(cleanRet));
            finalResult = -1;
        }
        const aclError stopRet = acltdtStopChannel(channel);
        if (stopRet != ACL_SUCCESS) {
            ERROR_LOG(
                "Operation failed: acltdtStopChannel(channel) returned error code %d", static_cast<int32_t>(stopRet));
            finalResult = -1;
        }
        const aclError destroyRet = acltdtDestroyChannel(channel);
        if (destroyRet != ACL_SUCCESS) {
            ERROR_LOG(
                "Operation failed: acltdtDestroyChannel(channel) returned error code %d",
                static_cast<int32_t>(destroyRet));
            finalResult = -1;
        }
    }

    tdt::DestroyDatasetAndItems(thirdDataset);
    tdt::DestroyDatasetAndItems(secondDataset);
    tdt::DestroyDatasetAndItems(firstDataset);

    if (deviceSet) {
        const aclError resetRet = aclrtResetDeviceForce(static_cast<int32_t>(deviceId));
        if (resetRet != ACL_SUCCESS) {
            ERROR_LOG(
                "Operation failed: aclrtResetDeviceForce(static_cast<int32_t>(deviceId)) returned error code %d",
                static_cast<int32_t>(resetRet));
            finalResult = -1;
        }
    }
    if (aclInitialized) {
        const aclError finalizeRet = aclFinalize();
        if (finalizeRet != ACL_SUCCESS) {
            ERROR_LOG("Operation failed: aclFinalize() returned error code %d", static_cast<int32_t>(finalizeRet));
            finalResult = -1;
        }
    }
    if (finalResult == 0 && channel != nullptr) {
        INFO_LOG("Run the channel_capacity sample successfully.");
    }
    return finalResult;
}
