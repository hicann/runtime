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
#include "acl/acl.h"
#include "utils.h"

int main()
{
    const int32_t deviceId = 0; const uint32_t branchIndex = 1; aclrtContext context = nullptr; aclrtStream stream = nullptr; aclrtLabel labels[2] = {nullptr, nullptr}; aclrtLabelList labelList = nullptr; uint32_t *branchIndexDevice = nullptr;
    CHECK_ERROR(aclInit(nullptr)); CHECK_ERROR(aclrtSetDevice(deviceId)); CHECK_ERROR(aclrtCreateContext(&context, deviceId)); CHECK_ERROR(aclrtCreateStream(&stream)); CHECK_ERROR(aclrtMalloc(reinterpret_cast<void **>(&branchIndexDevice), sizeof(branchIndex), ACL_MEM_MALLOC_HUGE_FIRST)); CHECK_ERROR(aclrtMemcpy(branchIndexDevice, sizeof(branchIndex), &branchIndex, sizeof(branchIndex), ACL_MEMCPY_HOST_TO_DEVICE));
    CHECK_ERROR(aclrtCreateLabel(&labels[0])); CHECK_ERROR(aclrtCreateLabel(&labels[1])); CHECK_ERROR(aclrtCreateLabelList(labels, 2, &labelList)); CHECK_ERROR(aclrtSetLabel(labels[0], stream)); CHECK_ERROR(aclrtSetLabel(labels[1], stream)); CHECK_ERROR(aclrtSwitchLabelByIndex(branchIndexDevice, 2, labelList, stream)); CHECK_ERROR(aclrtSynchronizeStream(stream)); INFO_LOG("Switch label executed with branch index %u", branchIndex);
    CHECK_ERROR(aclrtDestroyLabelList(labelList)); CHECK_ERROR(aclrtDestroyLabel(labels[1])); CHECK_ERROR(aclrtDestroyLabel(labels[0])); CHECK_ERROR(aclrtFree(branchIndexDevice)); CHECK_ERROR(aclrtDestroyStream(stream)); CHECK_ERROR(aclrtDestroyContext(context)); CHECK_ERROR(aclrtResetDeviceForce(deviceId)); CHECK_ERROR(aclFinalize()); return 0;
}