/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef ACL_TENSOR_DATA_TRANSFER_H
#define ACL_TENSOR_DATA_TRANSFER_H
#include <string.h>
#include <string>
#include <vector>
#include<memory>

#include "acl/acl_base.h"
#include "acl/acl_tdt.h"

enum datasetMemType {
    MEM_UNKNOWN = 0,
    MEM_HOST,
    MEM_DEVICE
};

struct acltdtDataItem {
    acltdtDataItem(acltdtTensorType tdtType,
        const int64_t *dims, size_t dimNum, const std::string &dimsStr,
        aclDataType type, const std::string &typeStr,
        std::shared_ptr<void> tensorData, size_t size)
    {
        this->tdtType = tdtType;
        for (size_t i = 0; i < dimNum; ++i) {
            this->dims.push_back(dims[i]);
        }
        this->dimsStr = dimsStr;
        this->dataType = type;
        this->dataTypeStr = typeStr;
        this->dataLen = size;
        this->dataPtr = tensorData;
        this->priorityData_ = nullptr;
        this->sliceNum = 0;
        this->sliceId = 0;
    }
    acltdtDataItem() = default;
    ~acltdtDataItem() = default;
    acltdtTensorType tdtType;
    std::vector<int64_t> dims;
    std::string dimsStr;
    aclDataType dataType;
    std::string dataTypeStr;
    size_t dataLen;
    std::shared_ptr<void> dataPtr;
    void *priorityData_; // this addr can not be free because it is passed by outside
    uint16_t sliceNum;
    uint16_t sliceId;
};

struct acltdtDataset {
    acltdtDataset()  : freeSelf(false) {};
    ~acltdtDataset()
    {
        if (freeSelf) {
            for (auto iter = blobs.begin(); iter != blobs.end(); ++iter) {
                (void)acltdtDestroyDataItem(*iter);
            }
        }
    }
    std::string name;
    std::vector<acltdtDataItem *> blobs;
    datasetMemType memType = MEM_UNKNOWN;
    bool freeSelf;
    // mem reuse for performance optimization, used in acltdtReceiveTensor process
    size_t sharedMemSize_ = 0U;
    std::shared_ptr<void> sharedMem_;
};

struct acltdtChannelHandle {
    acltdtChannelHandle(uint32_t deviceId, const char *channelName)
    {
        devId = deviceId;
        isTdtProcess = true;
        qid = 0;
        if (channelName != nullptr) {
            name = channelName;
            size_t prefixLen = sizeof("TF_RECEIVE_") - 1;
            if (strncmp(channelName, "TF_RECEIVE_", prefixLen) == 0) {
                recvName = channelName + prefixLen;
            }
        }
    }
    acltdtChannelHandle() = default;
    ~acltdtChannelHandle() = default;
    std::string name;
    std::string recvName;
    uint32_t devId;
    uint32_t qid;
    bool isTdtProcess;
    std::shared_ptr<void> ctx_;
};

namespace acl {
    constexpr size_t RESERVED_SIZE = 24U;
    aclError acltdtSendTensorV2(const acltdtChannelHandle *handle, const acltdtDataset *dataset, int32_t timeout);

    aclError acltdtReceiveTensorV2(const acltdtChannelHandle *handle, acltdtDataset *dataset, int32_t timeout);

    aclError GetOrMallocHostMem(const acltdtChannelHandle *handle, acltdtDataset *dataset,
        size_t bufLen, void *&hostPtr);

#pragma pack(push, 1)
struct ItemInfo {
    int32_t version = 0;
    int32_t dataType = 0;
    uint32_t curCnt = 0U;
    uint32_t cnt = 0U;
    int32_t tensorType = 0;
    uint32_t dimNum = 0U;
    uint32_t dynamicBitSize = 0U;
    uint16_t sliceNum = 0;
    uint16_t sliceId = 0;
    char reserved[RESERVED_SIZE] = {0};
    uint64_t dataLen = 0LU;
};
#pragma pack(pop)

struct aclTdtDataItemInfo {
    ItemInfo ctrlInfo;
    std::vector<int64_t> dims;
    std::shared_ptr<void> dataPtr;
    void *priorityDataPtr_ = nullptr;
};
}
#endif // ACL_TENSOR_DATA_TRANSFER_H
