/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "logic_sq.hpp"
#include "capture_model.hpp"
#include "context.hpp"
#include "stream.hpp"
#include "stream_sqcq_manage.hpp"
#include "task.hpp"
#include "stars_david.hpp"
#include "runtime.hpp"
#include "npu_driver.hpp"
#include "drv/driver.hpp"
#include "device.hpp"
#include "logic_sq_manage.hpp"
#include "sq_addr_memory_pool.hpp"
#include "securec.h"
#include "rt_log.h"
#include <algorithm>

namespace cce {
namespace runtime {
/**
 * @brief 计算 curLogicSq 还能容纳多少个 sqe
 * @param logicSq    当前 logicSq
 * @param curHwPos   当前已排布的 sqe 数（已占用 hwPos）
 * @return 剩余可拷贝 sqe 数（0 表示已满，需级联）
 */
uint32_t CalcLogicSqRemainNum(const LogicSq* const logicSq, const uint32_t curHwPos)
{
    const uint32_t depth = logicSq->GetLogicSqDepth();
    if (curHwPos == 0U) {
        // 第一次进来，返回最大深度，因为stream的最后可能是multi task + stream active task
        // 一次性把当前流里面的task拷贝全
        return depth;
    }

    // 超过预留的最大深度，要级联
    const uint32_t reserve = logicSq->GetReserveSqeNum(); // 包含32个预留 + expandStreamRsvTaskNum
    if ((curHwPos + reserve) >= depth) {
        return 0U;
    }

    // 这个分支是给下个版本的条件任务合并需求预留的
    return depth - reserve - curHwPos;
}

/**
 * @brief 将一段 sqe 从源 stream 的 sqeBuffer_ 批量拷贝到 logicSq 的 hostSqeAddr_
 *        按 sqe 段批量 memcpy（一段一段拷贝），不逐 task 遍历
 * @param logicSq        目标 logicSq
 * @param hwPos          目标 logicSq 中的起始 hwPos
 * @param srcStm         源 stream（持有 sqeBuffer_，capture 阶段填入的 sqe 内容）
 * @param streamPosStart 源 stream sqeBuffer_ 中的起始 pos（logicPos，capture 阶段 pos=logicPos）
 * @param copyNum        本次拷贝的 sqe 数
 */
rtError_t AssembleHostSqe(
    LogicSq* const logicSq, const uint32_t hwPos, Stream* const srcStm, const uint32_t streamPosStart,
    const uint32_t copyNum)
{
    RT_LOG(
        RT_LOG_DEBUG,
        "Assemble sqe, device_id=%u, stream_id=%d, logic_sq_id=%u, copyNum=%u, hwPos=%u, streamPosStart=%u",
        srcStm->Device_()->Id_(), srcStm->Id_(), logicSq->Id_(), copyNum, hwPos, streamPosStart);
    const uint8_t* src = srcStm->GetSqeBuffer() + streamPosStart * SQE_SIZE_UNIT;
    uint8_t* dst = RtPtrToPtr<uint8_t*>(logicSq->GetHostSqeAddr()) + hwPos * SQE_SIZE_UNIT;
    const errno_t ret = memcpy_s(dst, copyNum * SQE_SIZE_UNIT, src, copyNum * SQE_SIZE_UNIT);
    COND_RETURN_ERROR(
        ret != EOK, RT_ERROR_SEC_HANDLE,
        "memcpy_s failed, device_id=%u, stream_id=%d, logic_sq_id=%u, hwPos=%u, copyNum=%u, ret=%d.",
        srcStm->Device_()->Id_(), srcStm->Id_(), logicSq->Id_(), hwPos, copyNum, ret);
    return RT_ERROR_NONE;
}

/**
 * @brief 按 sqe 位置批量填双向 map（不逐 task 遍历）
 *        hwPosToTask_：logicSq 中每个 hwPos → (streamId, logicPos)，供异常 CQE 反查
 *        logicPosToHwPos_：stream 中每个 logicPos → (logicSqId, hwPos)，供 task update 定位
 * @param logicSq        目标 logicSq
 * @param stm             源 stream（持有 posToTaskIdMap_，按 sqe 位置查 taskId）
 * @param hwPosStart      目标 logicSq 中的起始 hwPos
 * @param streamPosStart  源 stream 中的起始 pos
 * @param sqeNum          本次填充的 sqe 数
 * @param dev             Device（用于 TaskFactory::GetTask）
 * @note  logicPos = taskInfo->pos（权威来源，永不修改）
 *        多 sqe task 的每个 sqe 都填 hwPosToTask_，但 logicPosToHwPos_ 只记 task 首个 sqe 位置
 */
void FillHwPosMapping(
    LogicSq* const logicSq, Stream* const stm, const uint32_t hwPosStart, const uint32_t streamPosStart,
    const uint32_t sqeNum)
{
    for (uint32_t i = 0U; i < sqeNum; ++i) {
        // 经 posToTaskIdMap_ 按 sqe 位置查 taskId
        uint32_t taskId = 0U;
        const rtError_t ret = stm->GetTaskIdByPos(static_cast<uint16_t>(streamPosStart + i), taskId);
        if (ret != RT_ERROR_NONE) {
            RT_LOG(
                RT_LOG_WARNING, "get task id by pos failed, device_id=%u, pos=%u.", stm->Device_()->Id_(),
                streamPosStart + i);
            continue;
        }
        // 经 TaskFactory 取 TaskInfo，logicPos = taskInfo->pos
        TaskInfo* taskInfo = stm->Device_()->GetTaskFactory()->GetTask(stm->Id_(), static_cast<uint16_t>(taskId));
        if (taskInfo == nullptr) {
            RT_LOG(
                RT_LOG_WARNING, "get task failed, device_id=%u, stream_id=%d, taskId=%u.", stm->Device_()->Id_(),
                stm->Id_(), taskId);
            continue;
        }
        const uint32_t pos = taskInfo->pos;

        RT_LOG(
            RT_LOG_DEBUG,
            "fill hwpos mapping, device_id=%u, stream_id=%d, taskId=%u, pos=%u, hwPos=%u, logicSqId=%u, SqeNum=%u, "
            "streamPosStart + i=%u.",
            stm->Device_()->Id_(), stm->Id_(), taskId, pos, hwPosStart + i, logicSq->Id_(), GetSendSqeNum(taskInfo),
            streamPosStart + i);
        // hwPosToTask_：logicSq 的每个 hwPos 都映射到 (stm->Id_(), pos)
        logicSq->SetHwPosMapping(hwPosStart + i, static_cast<uint32_t>(stm->Id_()), pos);

        // logicPosToHwPos_：只记 task 起始 hwPos（多 sqe task 的首个 sqe 位置）
        if ((GetSendSqeNum(taskInfo) != 1U) && ((streamPosStart + i) != taskInfo->pos)) {
            continue;
        }

        stm->SetPosToHwPos(pos, logicSq->Id_(), hwPosStart + i);
    }
}

/**
 * @brief 拷贝一段 sqe 到 logicSq 的 hostSqeAddr_ + 填双向 map
 */
rtError_t CopySqeSegment(
    LogicSq* const logicSq, const uint32_t hwPos, Stream* const stm, const uint32_t streamPosStart,
    const uint32_t copyNum)
{
    const rtError_t ret = AssembleHostSqe(logicSq, hwPos, stm, streamPosStart, copyNum);
    COND_RETURN_ERROR(
        ret != RT_ERROR_NONE, ret,
        "assemble host sqe failed, device_id=%u, logic_sq_id=%u, hwPos=%u, stream_id=%d, streamPosStart=%u, "
        "copyNum=%u, retCode=%#x.",
        stm->Device_()->Id_(), logicSq->Id_(), hwPos, stm->Id_(), streamPosStart, copyNum, static_cast<uint32_t>(ret));
    FillHwPosMapping(logicSq, stm, hwPos, streamPosStart, copyNum);
    return RT_ERROR_NONE;
}

/**
 * @brief 收尾 logicSq：设置 sqeNum + push 到 targetModel->logicSqs_
 *        不在此处注册 LogicSqManage——endcap 时 rtsqId_ 尚为 UINT32_MAX（stream 未分配 sqId），
 *        注册推迟到模型执行时 BindSqCq（此时 stream 已 UpdateSqCq 分配真实 sqId）
 * @param logicSq     待收尾的 logicSq
 * @param sqeNum      该 logicSq 的合法 sqe 数（含 active sqe 若有）
 * @param targetModel logicSqs_ 归属 model
 */
void BuildOneLogicSqEndProc(LogicSq* const logicSq, const uint32_t sqeNum, CaptureModel* const targetModel)
{
    logicSq->SetSqeNum(sqeNum);
    targetModel->GetLogicSqs().push_back(logicSq);
}

/**
 * @brief 多 sqe 边界检查：检查本次拷贝末尾 sqe 是否落在多 sqe task 中间
 *        若是，截断 copyNum 到该 task 开始前（整个多 sqe task 移到下一 logicSq）
 * @param stm             源 stream
 * @param streamPosStart  本次拷贝在源 stream 中的起始位置
 * @param copyNum         本次计划拷贝的 sqe 数
 * @param dev             Device
 * @return  调整后的 copyNum, 若末尾 sqe 不是该 task 的最后一个 sqe（边界落在多 sqe task 中间）, 整个多 sqe task
 * 放到当前logicSq
 * @note    仅当 copyNum == logicSqRemaining（logicSq 快满）时调用此函数
 *          copyNum < logicSqRemaining 时 stream 剩余 sqe 全部能放下，末尾必是 task 最后一个 sqe，无需检查
 */
uint32_t AdjustCopyNumForMultiSqe(Stream* const stm, const uint32_t streamPosStart, const uint32_t copyNum)
{
    RT_LOG(
        RT_LOG_DEBUG, "device_id=%u, stream_id=%d, streamPosStart=%u, copyNum=%u.", stm->Device_()->Id_(), stm->Id_(),
        streamPosStart, copyNum);

    if (copyNum == 0U) {
        return 0U;
    }

    // 查末尾 sqe 对应的 taskId（经 posToTaskIdMap_）
    const uint32_t boundaryPos = streamPosStart + copyNum - 1U;
    uint32_t boundaryTaskId = 0U;
    const rtError_t ret = stm->GetTaskIdByPos(static_cast<uint16_t>(boundaryPos), boundaryTaskId);
    COND_RETURN_ERROR(
        ret != RT_ERROR_NONE, 0U, "Get task id failed, device_id=%u, stream_id=%d, task_pos=%u.", stm->Device_()->Id_(),
        stm->Id_(), boundaryPos);

    TaskInfo* boundaryTask =
        stm->Device_()->GetTaskFactory()->GetTask(stm->Id_(), static_cast<uint16_t>(boundaryTaskId));
    COND_RETURN_ERROR(
        boundaryTask == nullptr, 0U, "Get task info failed, device_id=%u, stream_id=%d, task_id=%u, task_pos=%u.",
        stm->Device_()->Id_(), stm->Id_(), boundaryTaskId, boundaryPos);

    // 该 task 占用的 sqe 总数
    const uint32_t boundaryTaskSqeNum = GetSendSqeNum(boundaryTask);

    // 若末尾 sqe 不是该 task 的最后一个 sqe（边界落在多 sqe task 中间）, 整个多 sqe task 放到当前logicSq
    return boundaryTaskSqeNum + boundaryTask->pos - streamPosStart;
}

/**
 * @brief 深度超限处理：当前 logicSq 末尾已包含级联 active sqe，收尾当前 logicSq 并创建下一级 logicSq
 */
rtError_t HandleDepthOverflow(
    LogicSq* const curLogicSq, const uint32_t hwPosTail, CaptureModel* const targetModel, Stream* const nextStream,
    LogicSq*& newLogicSq)
{
    COND_RETURN_ERROR(
        hwPosTail == 0U, RT_ERROR_INVALID_VALUE, "Invalid logic sq active hw pos, device_id=%u, nextStreamId=%d.",
        nextStream->Device_()->Id_(), nextStream->Id_());

    LogicSq* newSq = nullptr;
    rtError_t error = nextStream->Device_()->GetLogicSqManage()->CreateLogicSq(newSq);
    COND_RETURN_ERROR(
        error != RT_ERROR_NONE, error, "create logic sq failed, device_id=%u, retCode=%#x.",
        nextStream->Device_()->Id_(), static_cast<uint32_t>(error));
    newSq->SetStreamId(static_cast<uint32_t>(nextStream->Id_()));

    curLogicSq->SetNextLogicSqId(newSq->Id_());
    BuildOneLogicSqEndProc(curLogicSq, hwPosTail, targetModel);
    newLogicSq = newSq;
    return RT_ERROR_NONE;
}

/**
 * @brief 顶层入口：遍历一次级联涉及的所有流，按 sqe 段批量拷贝到 logicSq
 *        级联 active sqe 已在 capture 下发切分时写入父 stream，Build 阶段只识别并串联已有 active
 * @param streamRanges  本次级联涉及的流区间，每个区间由 {streamId, beginPos, num} 描述
 * @param targetModel   logicSqs_ 归属 model
 * @param dev           Device
 * @return RT_ERROR_NONE 或错误码
 * @note  生成的所有 logicSq 统一 push 到 targetModel->logicSqs_
 */
rtError_t BuildOneLogicSq(
    const std::vector<StreamRange>& streamRanges, CaptureModel* const targetModel, Device* const dev)
{
    COND_PROC(streamRanges.empty(), return RT_ERROR_NONE);
    LogicSq* curLogicSq = nullptr;
    rtError_t error = dev->GetLogicSqManage()->CreateLogicSq(curLogicSq);
    COND_RETURN_ERROR(
        error != RT_ERROR_NONE, error, "create logic sq failed, device_id=%u, retCode=%#x.", dev->Id_(),
        static_cast<uint32_t>(error));
    curLogicSq->SetStreamId(streamRanges[0].streamId); // 用首条流的 streamId（供 SendSqe 的 StreamTaskFill 使用）
    uint32_t curHwPos = 0U; // 当前 logicSq 中已排布的 sqe 数（即下一个可写 hwPos）
    for (const auto& range : streamRanges) {
        Stream* stm = nullptr;
        (void)dev->GetStreamSqCqManage()->GetStreamById(range.streamId, &stm);
        COND_PROC(
            stm == nullptr,
            RT_LOG(RT_LOG_WARNING, "get stream by id failed, device_id=%u, streamId=%u.", dev->Id_(), range.streamId);
            continue);

        // sqIdMemAddr 所有权转移：LogicSq 首次关联 stream 时从该 stream 转移,
        // capture 阶段 stream 在 SetupWithoutBindSq 中分配 sqIdMemAddr，endcap 时转移给 LogicSq,
        // SQE 中固化的 sqIdMemAddr 地址不变（硬件运行时 load 行为不变，无需刷新 SQE）
        if ((curLogicSq->GetSqIdMemAddr() == 0UL) && (stm->GetSqIdMemAddr() != 0UL)) {
            curLogicSq->SetSqIdMemAddr(stm->GetSqIdMemAddr());
            stm->SetSqIdMemAddr(0UL);              // stream 不再持有（析构时跳过释放）
        }
        const uint32_t streamSqeTotal = range.num; // 该区间参与排布的 sqe 总数
        uint32_t streamSqeCopied = 0U;             // 该区间已拷贝到 logicSq 的 sqe 数量
        while (streamSqeCopied < streamSqeTotal) {
            // 计算 curLogicSq 还能放多少个 sqe
            const uint32_t logicSqRemaining = CalcLogicSqRemainNum(curLogicSq, curHwPos);
            if (logicSqRemaining == 0) {
                // active 任务已在 capture 下发级联切分时写入父 stream，Build 阶段只设置 logicSq 串联信息。
                LogicSq* newSq = nullptr;
                const rtError_t ret = HandleDepthOverflow(curLogicSq, curHwPos, targetModel, stm, newSq);
                COND_PROC_RETURN_ERROR(
                    ret != RT_ERROR_NONE, ret, dev->GetLogicSqManage()->FreeLogicSq(curLogicSq->Id_()),
                    "handle depth overflow failed, device_id=%u, retCode=%#x.", dev->Id_(), static_cast<uint32_t>(ret));
                curLogicSq = newSq;
                curHwPos = 0U;
                if ((curLogicSq->GetSqIdMemAddr() == 0UL) && (stm->GetSqIdMemAddr() != 0UL)) {
                    curLogicSq->SetSqIdMemAddr(stm->GetSqIdMemAddr());
                    stm->SetSqIdMemAddr(0UL); // stream 不再持有（析构时跳过释放）
                }
                continue;                     // 不推进 streamSqeCopied，重新计算 logicSqRemaining
            }
            // 本次拷贝 sqe 数 = min(logicSq 剩余容量, stream 剩余未拷贝 sqe 数)
            uint32_t copyNum = std::min(logicSqRemaining, streamSqeTotal - streamSqeCopied);
            // 多 sqe 边界检查：仅当 copyNum == logicSqRemaining（logicSq 快满）时才需要检查
            const uint32_t streamPosStart = range.beginPos + streamSqeCopied;
            if (copyNum == logicSqRemaining) {
                copyNum = AdjustCopyNumForMultiSqe(stm, streamPosStart, copyNum);
            }

            // 拷贝一段 sqe（批量 memcpy）+ 填 hwPosToTask_/logicPosToHwPos_ map
            const rtError_t ret = CopySqeSegment(curLogicSq, curHwPos, stm, streamPosStart, copyNum);
            COND_PROC_RETURN_ERROR(
                ret != RT_ERROR_NONE, ret, dev->GetLogicSqManage()->FreeLogicSq(curLogicSq->Id_()),
                "copy sqe failed, device_id=%u, retCode=%#x.", dev->Id_(), static_cast<uint32_t>(ret));
            curHwPos += copyNum;        // logicSq 写指针前移
            streamSqeCopied += copyNum; // stream 读指针前移
        }
    }
    // 收尾最后一个 logicSq
    BuildOneLogicSqEndProc(curLogicSq, curHwPos, targetModel);
    return RT_ERROR_NONE;
}

} // namespace runtime
} // namespace cce
