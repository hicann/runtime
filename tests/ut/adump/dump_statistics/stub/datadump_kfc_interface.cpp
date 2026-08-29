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
#include <string>
#include <vector>
// pkg_inc/dump/datadump_kfc_interface.h 为 AICPU 组件提供的临时拷贝，其内部使用
// std::vector / std::string / uint32_t 但未自行 include，需由使用侧先引入。
#include "datadump_kfc_interface.h"
#include "kfc_dump_stub_config.h"
#include "kfc_dump_data_stub.h"

KfcDumpInfo* g_kfcDumpInfo;

// 模拟 tensor 的 shape 维数，默认 3 维。用例可改写以构造超限场景。
static size_t g_stubShapeDims = STUB_DEFAULT_SHAPE_DIMS;

void SetStubShapeDims(size_t dims) { g_stubShapeDims = dims; }

// 失败注入开关，见 kfc_dump_stub_config.h
static bool g_getOpTaskInfoFail = false;
static bool g_getOpTaskInfoNull = false;
static bool g_dumpOpTaskDataFail = false;

void SetStubGetOpTaskInfoFail(bool fail) { g_getOpTaskInfoFail = fail; }

void SetStubGetOpTaskInfoNull(bool nullPtr) { g_getOpTaskInfoNull = nullPtr; }

void SetStubDumpOpTaskDataFail(bool fail) { g_dumpOpTaskDataFail = fail; }

void ResetKfcCallbackStub()
{
    g_stubShapeDims = STUB_DEFAULT_SHAPE_DIMS;
    g_getOpTaskInfoFail = false;
    g_getOpTaskInfoNull = false;
    g_dumpOpTaskDataFail = false;
}

int32_t AicpuGetOpTaskInfo(const KfcDumpTask& taskKey, KfcDumpInfo** ptr)
{
    // 迁移前 stub 判 streamId_ < 0，但正式头(pkg_inc/dump)中 streamId_ 为 uint32_t，
    // 该条件恒假、失败分支从未生效。改为按 KfcDump::INVALID 判非法，保持原意。
    if (taskKey.streamId_ == KfcDump::INVALID || g_getOpTaskInfoFail) {
        *ptr = nullptr;
        return 1;
    }
    // 注入"返回成功但回填空指针"：被测代码对此另有判空分支
    *ptr = g_getOpTaskInfoNull ? nullptr : g_kfcDumpInfo;
    return 0;
}

struct KfcDumpInfo GetDumpInfo(const KfcDumpTask& taskKey)
{
    struct KfcDumpInfo kfcDumpInfo;
    kfcDumpInfo.opName = "OP_" + std::to_string(taskKey.taskId_);
    kfcDumpInfo.opType = "AIV";
    for (uint64_t tensorId = 0; tensorId < STUB_TENSOR_COUNT_PER_TYPE; tensorId++) {
        InputOutputKfcDumpInfo dumpInfo;
        dumpInfo.index = tensorId;
        dumpInfo.format = 0;
        dumpInfo.address = 0;
        dumpInfo.size = tensorId * 1024;
        std::vector<uint64_t> shape(g_stubShapeDims, 8U);
        if (!shape.empty()) {
            shape[0] = tensorId;
        }
        dumpInfo.shape = shape;
        if (taskKey.taskId_ == 0) {
            dumpInfo.data_type = 1;
            kfcDumpInfo.outputDumpInfo.push_back(dumpInfo);
        } else if (taskKey.taskId_ == 1) {
            dumpInfo.data_type = 0;
            kfcDumpInfo.inputDumpInfo.push_back(dumpInfo);
        } else {
            dumpInfo.data_type = 1;
            kfcDumpInfo.outputDumpInfo.push_back(dumpInfo);
            dumpInfo.data_type = 0;
            kfcDumpInfo.inputDumpInfo.push_back(dumpInfo);
        }
    }
    return kfcDumpInfo;
}

int32_t AicpuDumpOpTaskData(const KfcDumpTask& taskKey, void* dumpPtr, uint32_t length)
{
    (void)taskKey;
    (void)dumpPtr;
    (void)length;
    return g_dumpOpTaskDataFail ? 1 : 0;
}