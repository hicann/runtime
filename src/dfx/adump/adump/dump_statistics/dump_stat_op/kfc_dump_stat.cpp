/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "kfc_dump_single_core.h"
#include "kfc_dump_multi_core.h"
#include "kfc_dump_param.h"
#include "kfc_dump_server.h"
#include "kernel_operator.h"

using namespace AscendC;
using namespace KfcDumpStat;

__aicore__ inline int64_t GetByteSizeByDataType(uint32_t xType)
{
    if (xType == static_cast<uint32_t>(OutputDataType::DUMP_DT_INT8) ||
        xType == static_cast<uint32_t>(OutputDataType::DUMP_DT_UINT8) ||
        xType == static_cast<uint32_t>(OutputDataType::DUMP_DT_HIFLOAT8) ||
        xType == static_cast<uint32_t>(OutputDataType::DUMP_DT_FLOAT8_E5M2) ||
        xType == static_cast<uint32_t>(OutputDataType::DUMP_DT_FLOAT8_E4M3FN)) {
        return DTYPE_BYTE_SIZE_b8;
    } else if (
        xType == static_cast<uint32_t>(OutputDataType::DUMP_DT_INT16) ||
        xType == static_cast<uint32_t>(OutputDataType::DUMP_DT_FLOAT16) ||
        xType == static_cast<uint32_t>(OutputDataType::DUMP_DT_BF16)) {
        return DTYPE_BYTE_SIZE_b16;
    } else if (
        xType == static_cast<uint32_t>(OutputDataType::DUMP_DT_INT32) ||
        xType == static_cast<uint32_t>(OutputDataType::DUMP_DT_FLOAT)) {
        return DTYPE_BYTE_SIZE_b32;
    } else { // 不支持的数据类型
        return -1;
    }
}

// 按数据类型分发到 OpT<int8_t/uint8_t/...>，返回是否命中支持的类型
template <template <typename> class OpT>
__aicore__ inline bool DispatchStatByDataType(
    uint32_t xType, TPipe* pipe, __gm__ KfcDumpStatMsg* rMsg, __gm__ KfcDumpStatMsg* sMsg, KfcDumpContext* ctx)
{
    if (xType == static_cast<uint32_t>(OutputDataType::DUMP_DT_INT8)) {
        OpT<int8_t> op(pipe, rMsg, sMsg, ctx);
        op.Init();
        op.Process();
    } else if (xType == static_cast<uint32_t>(OutputDataType::DUMP_DT_UINT8)) {
        OpT<uint8_t> op(pipe, rMsg, sMsg, ctx);
        op.Init();
        op.Process();
    } else if (xType == static_cast<uint32_t>(OutputDataType::DUMP_DT_INT16)) {
        OpT<int16_t> op(pipe, rMsg, sMsg, ctx);
        op.Init();
        op.Process();
    } else if (xType == static_cast<uint32_t>(OutputDataType::DUMP_DT_INT32)) {
        OpT<int32_t> op(pipe, rMsg, sMsg, ctx);
        op.Init();
        op.Process();
    } else if (xType == static_cast<uint32_t>(OutputDataType::DUMP_DT_FLOAT16)) {
        OpT<half> op(pipe, rMsg, sMsg, ctx);
        op.Init();
        op.Process();
    } else if (xType == static_cast<uint32_t>(OutputDataType::DUMP_DT_FLOAT)) {
        OpT<float> op(pipe, rMsg, sMsg, ctx);
        op.Init();
        op.Process();
    } else if (xType == static_cast<uint32_t>(OutputDataType::DUMP_DT_BF16)) {
        OpT<bfloat16_t> op(pipe, rMsg, sMsg, ctx);
        op.Init();
        op.Process();
#if KFC_DUMP_SUPPORT_FP8
    } else if (xType == static_cast<uint32_t>(OutputDataType::DUMP_DT_HIFLOAT8)) {
        OpT<hifloat8_t> op(pipe, rMsg, sMsg, ctx);
        op.Init();
        op.Process();
    } else if (xType == static_cast<uint32_t>(OutputDataType::DUMP_DT_FLOAT8_E5M2)) {
        OpT<fp8_e5m2_t> op(pipe, rMsg, sMsg, ctx);
        op.Init();
        op.Process();
    } else if (xType == static_cast<uint32_t>(OutputDataType::DUMP_DT_FLOAT8_E4M3FN)) {
        OpT<fp8_e4m3fn_t> op(pipe, rMsg, sMsg, ctx);
        op.Init();
        op.Process();
#endif
    } else {
        return false;
    }
    return true;
}

__aicore__ inline void ProcessMultiCore(
    TPipe* pipe, __gm__ KfcDumpStatMsg* rMsg, __gm__ KfcDumpStatMsg* sMsg, KfcDumpContext* kfcDumpContext)
{
    if (!DispatchStatByDataType<KfcDumpStatMultiCore>(rMsg->dataType, pipe, rMsg, sMsg, kfcDumpContext)) {
        if (GetBlockIdx() == 0) {
            UpdateMsg(sMsg, rMsg, false);
        }
    }
}

__aicore__ inline void ProcessSingleCore(
    TPipe* pipe, __gm__ KfcDumpStatMsg* rMsg, __gm__ KfcDumpStatMsg* sMsg, KfcDumpContext* kfcDumpContext)
{
    if (!DispatchStatByDataType<KfcDumpStatSingleCore>(rMsg->dataType, pipe, rMsg, sMsg, kfcDumpContext)) {
        if (GetBlockIdx() == 0) {
            UpdateMsg(sMsg, rMsg, false);
        }
    }
}

__aicore__ inline void SyncAllCoreG(uint64_t syncspace, uint64_t aiCoreNum)
{
    TPipe pipe;
    GlobalTensor<int32_t> syncGlobal;
    TQue<QuePosition::VECOUT, 1> workQueue;

    pipe.InitBuffer(workQueue, 1, aiCoreNum * BLOCK_SIZE);

    syncGlobal.SetGlobalBuffer((__gm__ int32_t*)syncspace, aiCoreNum * (BLOCK_SIZE / sizeof(int32_t)));
    LocalTensor<int32_t> workLocal = workQueue.AllocTensor<int32_t>();

    SyncAll<true>(syncGlobal, workLocal, aiCoreNum);

    workQueue.FreeTensor(workLocal);
    pipe.Destroy();
}

__aicore__ inline void SyncAllBlock(const KfcDumpContext& context)
{
#if KFC_DUMP_ARCH_DAVID
    SyncAll<true>();
#else
    SyncAllCoreG(context.syncspace, context.aiCoreNum);
#endif
}

// 不支持的请求（类型不支持或数据量为空）：同步后由 0 核回消息
__aicore__ inline void HandleInvalidMsg(
    const KfcDumpContext& context, __gm__ KfcDumpStatMsg* rMsg, __gm__ KfcDumpStatMsg* sMsg)
{
    // 需要同步，防止block0执行过快，后面kernel的rMsg->valid被修改
    SyncAllBlock(context);
    if (GetBlockIdx() == 0) {
        if (rMsg->dataCount <= 0) {
            UpdateMsg(sMsg, rMsg, true);
        } else {
            UpdateMsg(sMsg, rMsg, false);
        }
    }
}

// context 中 aiCoreNum/ubSize 来自 host 侧平台查询透传，为 0 时多核切分与 UB 规划的
// tiling 计算会除零挂死 AICore，此处先同步再由 0 核回失败应答，不进入 tiling 计算
__aicore__ inline void HandleInvalidContext(
    const KfcDumpContext& context, __gm__ KfcDumpStatMsg* rMsg, __gm__ KfcDumpStatMsg* sMsg)
{
    SyncAllBlock(context);
    if (GetBlockIdx() == 0) {
        UpdateMsg(sMsg, rMsg, false);
    }
}

__aicore__ inline bool IsValidDumpContext(const KfcDumpContext& context)
{
    return context.aiCoreNum != 0U && context.ubSize != 0U;
}

__aicore__ inline void ProcessStatMsg(__gm__ KfcDumpStatMsg* rMsg, __gm__ KfcDumpStatMsg* sMsg, KfcDumpContext* ctx)
{
    if (!IsValidDumpContext(*ctx)) {
        HandleInvalidContext(*ctx, rMsg, sMsg);
        return;
    }
    auto xDtypeSize = GetByteSizeByDataType(rMsg->dataType);
    if (xDtypeSize == -1 || rMsg->dataCount <= 0) {
        HandleInvalidMsg(*ctx, rMsg, sMsg);
        return;
    }

    TPipe pipe;
    if (rMsg->dataCount > MULTI_CORE_BYTES_NUM) {
        ProcessMultiCore(&pipe, rMsg, sMsg, ctx);
    } else {
        ProcessSingleCore(&pipe, rMsg, sMsg, ctx);
    }
    pipe.Destroy();
}

extern "C" __global__ __aicore__ void kfc_dump_stat(
    GM_ADDR msgqAddr, GM_ADDR wkspaceAddr, GM_ADDR wkspaceSize, GM_ADDR coreNum, GM_ADDR ubSize, GM_ADDR syncSpace)
{
    KfcDumpContext context;
    context.msgQ = reinterpret_cast<uint64_t>(msgqAddr);
    context.workspace = reinterpret_cast<uint64_t>(wkspaceAddr);
    context.workspaceSize = *((__gm__ uint64_t*)(wkspaceSize));
    context.aiCoreNum = *((__gm__ uint64_t*)(coreNum));
    context.ubSize = *((__gm__ uint64_t*)(ubSize));
    context.syncspace = reinterpret_cast<uint64_t>(syncSpace);

    KfcDumpServer dump;
    dump.Init(context.msgQ);

    for (;;) {
        auto rMsg = dump.GetRcvMsg();
        auto sMsg = dump.GetSndMsg();
        if (static_cast<DumpStatMsgType>(rMsg->msgType) == DumpStatMsgType::KFC_DUMP_MSG_REQUEST &&
            rMsg->valid == DUMP_MSG_VALID_MASK) {
            ProcessStatMsg(rMsg, sMsg, &context);
            dump.IncreaseSnd();
            dump.IncreaseRcv();
            // 每个msg执行完后同步一次，防止0核执行太慢，其他核异常执行下一个msg
            SyncAllBlock(context);
        }
        if (static_cast<DumpStatMsgType>(rMsg->msgType) == DumpStatMsgType::KFC_DUMP_MSG_FINISHED) {
            break;
        }
    }
}
