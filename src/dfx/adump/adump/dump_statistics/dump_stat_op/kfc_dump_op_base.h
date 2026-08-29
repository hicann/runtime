/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef __KFC_DUMP_OP_BASE_H__
#define __KFC_DUMP_OP_BASE_H__

#include "kfc_dump_stat_all.h"

namespace KfcDumpStat {
using namespace AscendC;

// 单核/多核模板公共基类：收敛 context 解析、buffer 初始化、统计项分发与多核同步
template <typename T>
class KfcDumpStatOpBase {
public:
    __aicore__ inline KfcDumpStatOpBase(
        TPipe* pipe, __gm__ KfcDumpStatMsg* rMsg, __gm__ KfcDumpStatMsg* sMsg, KfcDumpContext* kfcDumpContext)
    {
        pPipe_ = pipe;
        blockIdx_ = GetBlockIdx();

        workspace_ = kfcDumpContext->workspace;
        workspaceSize_ = kfcDumpContext->workspaceSize;
        aiCoreNum_ = kfcDumpContext->aiCoreNum;
        ubSize_ = kfcDumpContext->ubSize;
        syncspace_ = kfcDumpContext->syncspace;

        xDtypeSize_ = sizeof(T);
        totalCount_ = rMsg->dataCount / xDtypeSize_;
        dataAddr_ = rMsg->dataAddr;
        dumpStatClass_ = rMsg->dumpStatClass;
        outputAddr_ = rMsg->outputAddr;
        outputAddrSize_ = rMsg->outputAddrSize;
        statNum_ = ScalarGetCountOfValue<1>(dumpStatClass_);

        rMsg_ = rMsg;
        sMsg_ = sMsg;
    }

    __aicore__ inline void Init()
    {
        xGm_.SetGlobalBuffer((__gm__ T*)dataAddr_);
        pPipe_->InitBuffer(xQue_, BUFFER_NUM, tileLengthMean_ * xDtypeSize_);
        pPipe_->InitBuffer(calMiddleBuf_, MAX_STAT_NUM * BLOCK_SIZE);

        // cast buffer 内存申请
        if (xDtypeSize_ == sizeof(uint8_t)) {
            pPipe_->InitBuffer(castXBuf_, tileLengthMean_ * (sizeof(uint16_t) + sizeof(uint32_t)));
        } else if (xDtypeSize_ == sizeof(uint16_t)) {
            pPipe_->InitBuffer(castXBuf_, tileLengthMean_ * (sizeof(uint16_t) + sizeof(uint32_t)));
        } else if (xDtypeSize_ == sizeof(uint32_t)) {
            pPipe_->InitBuffer(castXBuf_, tileLengthMean_ * sizeof(uint32_t));
        }

        // reduce 操作需要存放中间值的内存申请
        pPipe_->InitBuffer(workQueue_, BUFFER_NUM, tileLengthMean_ * sizeof(uint32_t));
    }

protected:
    // nan inf 需要的 cache buf 内存申请（单核/多核模板一致）
    __aicore__ inline void InitCacheBuf()
    {
#if KFC_DUMP_ARCH_DAVID
        // David 架构下 b8 亦需 cache buf
        if (xDtypeSize_ == sizeof(uint8_t) || xDtypeSize_ == sizeof(uint16_t) || xDtypeSize_ == sizeof(uint32_t)) {
            pPipe_->InitBuffer(cacheBuf1_, tileLengthMean_ * sizeof(uint32_t));
        }
#else
        if (xDtypeSize_ == sizeof(uint16_t) || xDtypeSize_ == sizeof(uint32_t)) {
            pPipe_->InitBuffer(cacheBuf1_, tileLengthMean_ * sizeof(uint32_t));
        }
#endif
    }

    // 执行指定统计项并将结果写入 workspace
    __aicore__ inline void RunStatCompute(int64_t processStatIdx)
    {
        int64_t statIdx = static_cast<int64_t>(processStatIdx);
        switch (static_cast<StatClass>(processStatIdx)) {
            case StatClass::STAT_MAX:
                ProcessMaxOrMin<T, true>(
                    xQue_, calMiddleBuf_, castXBuf_, workQueue_, xGm_, innerLoopTime_, tileLengthMean_, tileLengthEnd_,
                    perBlockCount_, blockOffset_, tileNumEnd_);
                break;
            case StatClass::STAT_MIN:
                ProcessMaxOrMin<T, false>(
                    xQue_, calMiddleBuf_, castXBuf_, workQueue_, xGm_, innerLoopTime_, tileLengthMean_, tileLengthEnd_,
                    perBlockCount_, blockOffset_, tileNumEnd_);
                break;
            case StatClass::STAT_MEAN:
                ProcessMean<T>(
                    xQue_, calMiddleBuf_, castXBuf_, workQueue_, xGm_, innerLoopTime_, tileLengthMean_, tileLengthEnd_,
                    perBlockCount_, blockOffset_, tileNumEnd_, totalCount_);
                break;
            case StatClass::STAT_NAN:
                ProcessNan<T>(
                    xQue_, calMiddleBuf_, castXBuf_, workQueue_, xGm_, maskBuf_, cacheBuf1_, innerLoopTime_,
                    tileLengthMean_, tileLengthEnd_, perBlockCount_, blockOffset_, tileNumEnd_, xDtypeSize_);
                break;
            case StatClass::STAT_NEG_INF:
                ProcessInf<T, false>(
                    xQue_, calMiddleBuf_, castXBuf_, workQueue_, xGm_, maskBuf_, cacheBuf1_, innerLoopTime_,
                    tileLengthMean_, tileLengthEnd_, perBlockCount_, blockOffset_, tileNumEnd_, xDtypeSize_);
                break;
            case StatClass::STAT_POS_INF:
                ProcessInf<T, true>(
                    xQue_, calMiddleBuf_, castXBuf_, workQueue_, xGm_, maskBuf_, cacheBuf1_, innerLoopTime_,
                    tileLengthMean_, tileLengthEnd_, perBlockCount_, blockOffset_, tileNumEnd_, xDtypeSize_);
                break;
            case StatClass::STAT_L2NORM:
                ProcessL2Norm<T>(
                    xQue_, calMiddleBuf_, castXBuf_, workQueue_, xGm_, innerLoopTime_, tileLengthMean_, tileLengthEnd_,
                    perBlockCount_, blockOffset_, tileNumEnd_, totalCount_);
                break;
            default:
                break;
        }
    }

    // 将统计结果写入 workspace 对应 slot，供 CoreReduce 汇总。
    // statSlot 为统计项位索引（calMiddleBuf 读取位置）， statIdx 为使能序号（workspace 写入位置）
    __aicore__ inline void CopyOutStatResult(int64_t statSlot, int64_t statIdx)
    {
        LocalTensor<uint8_t> calMidAddr = calMiddleBuf_.Get<uint8_t>()[statSlot * BLOCK_SIZE];
        LocalTensor<uint64_t> coreOutput = calMidAddr.ReinterpretCast<uint64_t>();
        CopyOutToWorkspace(coreOutput, statIdx, workspace_, blockIdx_, statNum_);
    }

    // David 架构支持硬同步指令；其余架构该调用方式不支持硬同步，需走软同步
    __aicore__ inline void SyncAllCores()
    {
#if KFC_DUMP_ARCH_DAVID
        SyncAll<true>();
#else
        SyncAllCore(workQueue_, syncspace_, aiCoreNum_);
#endif
    }

    // 输出类型选择：max/min 整型输出 int32，其余整型统计输出 int32，浮点输出 float
    __aicore__ inline void UpdateStatOutput(int64_t processStatIdx, uint64_t curWorkSpaceAddr)
    {
        int64_t statIdx = static_cast<int64_t>(processStatIdx);
        if (statIdx == static_cast<int64_t>(StatClass::STAT_L2NORM)) {
            auto curCoreOutputVal = GetCoreOutput<float>(curWorkSpaceAddr);
            curCoreOutputVal = sqrt(curCoreOutputVal);
            UpdateCoreOutput<float>(outputAddr_ + statIdx * MAX_OUTPUT_BYTE_SIZE, curCoreOutputVal);
        } else if (statIdx == static_cast<int64_t>(StatClass::STAT_MEAN)) {
            auto curCoreOutputVal = GetCoreOutput<float>(curWorkSpaceAddr);
            UpdateCoreOutput<float>(outputAddr_ + statIdx * MAX_OUTPUT_BYTE_SIZE, curCoreOutputVal);
        } else if (
            statIdx == static_cast<int64_t>(StatClass::STAT_NAN) ||
            statIdx == static_cast<int64_t>(StatClass::STAT_NEG_INF) ||
            statIdx == static_cast<int64_t>(StatClass::STAT_POS_INF)) {
            auto curCoreOutputVal = GetCoreOutput<int32_t>(curWorkSpaceAddr);
            UpdateCoreOutput<int32_t>(outputAddr_ + statIdx * MAX_OUTPUT_BYTE_SIZE, curCoreOutputVal);
        } else if (
            statIdx == static_cast<int64_t>(StatClass::STAT_MAX) ||
            statIdx == static_cast<int64_t>(StatClass::STAT_MIN)) {
            UpdateMaxOrMinOutput(statIdx, curWorkSpaceAddr);
        }
    }

    // context info
    uint64_t workspace_ = 0; // 中间结果保存的地址
    uint64_t syncspace_ = 0; // 多核同步需要的 gm 起始地址
    uint64_t workspaceSize_ = 0;
    uint64_t aiCoreNum_ = 0;
    uint64_t ubSize_ = 0;

    // tiling params
    uint64_t xDtypeSize_ = 0;     // 输入数据类型所占字节数
    uint64_t totalCount_ = 0;     // 需要处理的总元素个数
    uint64_t dataAddr_ = 0;       // 输入数据的起始地址
    uint64_t dumpStatClass_ = 0;  // 需要进行统计项的标识
    uint64_t statNum_ = 0;        // 需要进行统计项的个数
    uint64_t outputAddr_ = 0;     // 输出地址
    uint64_t outputAddrSize_ = 0; // 输出数据长度

    int64_t blockIdx_ = 0;
    int64_t blockOffset_ = 0;
    int64_t maxProcCount_ = 0;   // 一次 UB 搬运的最大元素个数
    int64_t perBlockCount_ = 0;  // 每个 32B 数据块能放入的最大元素个数
    int64_t tileNumMean_ = 0;    // 对于 blockLengthMean_，需要以 maxProcCount_ 和 BUFFER_NUM 搬运多少次
    int64_t tileNumEnd_ = 0;     // 0 表示没有尾块数据，1 表示有尾块数据
    int64_t tileLengthMean_ = 0; // maxProcCount / BUFFER_NUM
    int64_t tileLengthEnd_ = 0;  // 尾块数据长度
    int64_t innerLoopTime_ = 0;
    __gm__ KfcDumpStatMsg* sMsg_;
    __gm__ KfcDumpStatMsg* rMsg_;

    TPipe* pPipe_ = nullptr;

    TQue<QuePosition::VECIN, BUFFER_NUM> xQue_;
    TQue<QuePosition::VECOUT, BUFFER_NUM> workQueue_;

    TBuf<TPosition::VECCALC> castXBuf_;
    TBuf<TPosition::VECCALC> calMiddleBuf_;
    TBuf<TPosition::VECCALC> maskBuf_;
    TBuf<TPosition::VECCALC> cacheBuf1_;

    GlobalTensor<T> xGm_;

private:
    // max/min 输出类型与输入数据类型相关：整型输出 int32，浮点输出 float
    __aicore__ inline void UpdateMaxOrMinOutput(int64_t statIdx, uint64_t curWorkSpaceAddr)
    {
        constexpr bool isIntType = std::is_same_v<T, uint8_t> || std::is_same_v<T, int8_t> ||
                                   std::is_same_v<T, int16_t> || std::is_same_v<T, int32_t>;
        uint64_t curOutputAddr = outputAddr_ + statIdx * MAX_OUTPUT_BYTE_SIZE;
        if constexpr (isIntType) {
            auto curCoreOutputVal = GetCoreOutput<int32_t>(curWorkSpaceAddr);
            UpdateCoreOutput<int32_t>(curOutputAddr, curCoreOutputVal);
        } else {
            auto curCoreOutputVal = GetCoreOutput<float>(curWorkSpaceAddr);
            UpdateCoreOutput<float>(curOutputAddr, curCoreOutputVal);
        }
    }
};

} // namespace KfcDumpStat

#endif // __KFC_DUMP_OP_BASE_H__
