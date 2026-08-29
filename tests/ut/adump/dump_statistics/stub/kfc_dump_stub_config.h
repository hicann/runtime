/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef KFC_DUMP_SERVER_STUB_CONFIG_H
#define KFC_DUMP_SERVER_STUB_CONFIG_H

#include <cstddef>
#include <cstdint>

// 驱动打桩返回的默认 sq 深度
constexpr uint32_t STUB_DEFAULT_SQ_DEPTH = 2048U;
// 打桩 tensor 的默认 shape 维数
constexpr size_t STUB_DEFAULT_SHAPE_DIMS = 3U;

// 每类(input/output)打桩 tensor 个数。taskId=2 时 input/output 各取该值。
// 取 10 使合计 20 > DUMP_MSG_CNT(16)，令消息区环形绕回场景被覆盖到 ——
// 被测代码逐 tensor 发一条请求、等一条应答，绕回本身安全(同一时刻仅一条在途)。
constexpr uint64_t STUB_TENSOR_COUNT_PER_TYPE = 10U;

// ---------------------------------------------------------------------------
// 失败注入开关：被测代码的错误分支依赖外部接口返回失败, 无法靠正常输入触达,
// 故由桩按开关返回错误码。每个用例用完须复位(ResetSqCqStub/ResetKfcCallbackStub)。
// ---------------------------------------------------------------------------
// drvGetLocalDevIDByHostDevID 返回失败
void SetStubDevIdConvertFail(bool fail);
// halSqCqQuery 对指定 prop 返回失败; prop 传 -1 表示不注入
void SetStubSqQueryFailProp(int32_t prop);
// halSqCqConfig 返回失败
void SetStubSqConfigFail(bool fail);
// halSqCqQuery 查询 SQ_HEAD 时固定返回该值(不再自增), 用于构造 SQ 满与等待超时
// head 传 -1 表示恢复默认的自增行为
void SetStubFixedSqHead(int64_t head);
// AicpuGetOpTaskInfo 返回失败
void SetStubGetOpTaskInfoFail(bool fail);
// AicpuGetOpTaskInfo 成功但回填空指针
void SetStubGetOpTaskInfoNull(bool nullPtr);
// AicpuDumpOpTaskData 返回失败
void SetStubDumpOpTaskDataFail(bool fail);
// 复位 AICPU 回调桩的注入开关
void ResetKfcCallbackStub();

#endif // KFC_DUMP_SERVER_STUB_CONFIG_H
