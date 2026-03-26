/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <iostream>
#include <algorithm>
#include <iomanip>
#include <map>
#include <mutex>
#include <sstream>
#include <string>
#include <vector>
#include "acl/acl.h"
#include "acl/acl_dump.h"
#include "aclnnop/aclnn_add.h"
#include "utils.h"
#include "../adump_tensor_utils.h"

using namespace std;

namespace {
    std::mutex gCallbackMutex;
    std::map<std::string, int32_t> gChunkCountByFile;
    int32_t gTotalChunkCount = 0;
    int64_t gTotalBytes = 0;

    void LogDumpPath(acldumpType dumpType, const char *fallbackPath)
    {
        const char *dumpPath = acldumpGetPath(dumpType);
        if (dumpPath != nullptr) {
            INFO_LOG("acldumpGetPath returned dump path: %s", dumpPath);
            return;
        }
        WARN_LOG("acldumpGetPath returned null, fallback dump path is %s", fallbackPath);
    }

    std::string BuildChunkPreview(const acldumpChunk *data)
    {
        const uint32_t previewLen = std::min<uint32_t>(data->bufLen, 16U);
        std::ostringstream preview;
        preview << std::hex << std::setfill('0');
        for (uint32_t i = 0; i < previewLen; ++i) {
            if (i != 0) {
                preview << " ";
            }
            preview << std::setw(2) << static_cast<uint32_t>(data->dataBuf[i]);
        }
        if (data->bufLen > previewLen) {
            preview << " ...";
        }
        return preview.str();
    }

    void PrintCallbackSummary()
    {
        std::lock_guard<std::mutex> lock(gCallbackMutex);
        INFO_LOG("Dump callback summary: total chunks=%d, total bytes=%ld, total files=%d",
            gTotalChunkCount, gTotalBytes, static_cast<int32_t>(gChunkCountByFile.size()));
        for (const auto &entry : gChunkCountByFile) {
            INFO_LOG("  file=%s, chunks=%d", entry.first.c_str(), entry.second);
        }
    }

    int32_t DumpTensorCallback(const acldumpChunk *data, int32_t len)
    {
        if (data == nullptr) {
            ERROR_LOG("Callback data is null!");
            return -1;
        }
        if ((sizeof(acldumpChunk) + data->bufLen) != len) {
            ERROR_LOG("Callback data is invalid. bufLen: %d, callback len: %d", data->bufLen, len);
            return -1;
        }
        const std::string preview = BuildChunkPreview(data);
        {
            std::lock_guard<std::mutex> lock(gCallbackMutex);
            ++gTotalChunkCount;
            gTotalBytes += data->bufLen;
            ++gChunkCountByFile[data->fileName];
        }
        INFO_LOG("Receive dump tensor data success. file=%s, bufLen=%u, isLastChunk=%u, offset=%ld, flag=%d, preview=%s",
            data->fileName, data->bufLen, data->isLastChunk, data->offset, data->flag, preview.c_str());
        return 0;
    }
}

int main()
{
    // The device id
    int32_t deviceId = 0;
    // The dump configuration path
    const char* dumpCfgPath = "./acl.json";
    aclrtStream stream = nullptr;

    // 1. AscendCL Init
    CHECK_ERROR(adump::InitRuntime(deviceId, &stream, dumpCfgPath));
    // Register callback for dump tensor data
    CHECK_ERROR(acldumpRegCallback(DumpTensorCallback, 0));
    LogDumpPath(DATA_DUMP, "./");

    // 2. Create input and output(Custom Construction)
    std::vector<int64_t> selfShape{4, 2};
    std::vector<int64_t> otherShape{4, 2};
    std::vector<int64_t> outShape{4, 2};
    void *selfDeviceAddr = nullptr;
    void *otherDeviceAddr = nullptr;
    void *outDeviceAddr = nullptr;
    aclTensor *self = nullptr;
    aclTensor *out = nullptr;
    aclTensor *other = nullptr;
    aclScalar *alpha = nullptr;
    std::vector<float> selfHostData = {0, 1, 2, 3, 4, 5, 6, 7};
    std::vector<float> outHostData = {0, 0, 0, 0, 0, 0, 0, 0};
    std::vector<float> otherHostData = {1, 1, 1, 2, 2, 2, 3, 3};

    float alphaValue = 1.0f;
    // Create self aclTensor.
    CHECK_ERROR(adump::CreateAclTensor(selfHostData, selfShape, &selfDeviceAddr, aclDataType::ACL_FLOAT, &self));
    // Create other aclTensor.
    CHECK_ERROR(adump::CreateAclTensor(otherHostData, otherShape, &otherDeviceAddr, aclDataType::ACL_FLOAT, &other));
    // Create alpha aclScalar.
    alpha = aclCreateScalar(&alphaValue, aclDataType::ACL_FLOAT);
    if (alpha == nullptr) {
        ERROR_LOG("Create alpha Scalar failed ");
    }
    // Create out aclTensor.
    CHECK_ERROR(adump::CreateAclTensor(outHostData, outShape, &outDeviceAddr, aclDataType::ACL_FLOAT, &out));

    INFO_LOG("Get workspace size...");
    // 3. Call the CANN operator library API(Custom Implementation)
    uint64_t workspaceSize = 0;
    aclOpExecutor *executor;
    CHECK_ERROR(aclnnAddGetWorkspaceSize(self, other, alpha, out, &workspaceSize, &executor));

    // Allocate device memory based on the calculation results.
    void *workspaceAddr = nullptr;
    if (workspaceSize > 0lu) {
        CHECK_ERROR(aclrtMalloc(&workspaceAddr, workspaceSize, ACL_MEM_MALLOC_HUGE_FIRST));
    }
    INFO_LOG("Begin to add...");
    // Call the Add operator
    CHECK_ERROR(aclnnAdd(workspaceAddr, workspaceSize, executor, stream));

    // 4. Wait syschronously for the task execution to complete.
    CHECK_ERROR(aclrtSynchronizeStream(stream));

    // 5. Obtain the execution result of the operator and copy the result from the device memory to the host
    auto size = adump::GetShapeSize(outShape);
    std::vector<float> resultData(size, 0);
    CHECK_ERROR(aclrtMemcpy(resultData.data(), resultData.size() * sizeof(resultData[0]), outDeviceAddr,
        size * sizeof(float), ACL_MEMCPY_DEVICE_TO_HOST));

    for (int64_t i = 0; i < size; i++) {
      INFO_LOG("result[%ld] is: %f ", i, resultData[i]);
    }
    PrintCallbackSummary();

    // 6. Release the resources(Custom Destruction)
    // Release aclTensor and aclScalar
    adump::DestroyTensorResources(self, other, alpha, out);
    // Release the resources on the device
    CHECK_ERROR(aclrtFree(selfDeviceAddr));
    CHECK_ERROR(aclrtFree(outDeviceAddr));
    CHECK_ERROR(aclrtFree(otherDeviceAddr));
    if (workspaceSize > 0lu) {
      CHECK_ERROR(aclrtFree(workspaceAddr));
    }
    // 7. AsendCL Destroy.
    // Unregister callback for dump tensor data.
    acldumpUnregCallback();

    CHECK_ERROR(aclrtDestroyStream(stream));
    CHECK_ERROR(aclrtResetDeviceForce(deviceId));
    CHECK_ERROR(aclFinalize());
    INFO_LOG("Run the device_normal sample successfully.");
    return 0;
}
