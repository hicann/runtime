/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef __KFC_DUMP_SINGLE_CORE_H__
#define __KFC_DUMP_SINGLE_CORE_H__

#include "kfc_dump_op_base.h"

namespace KfcDumpStat {
using namespace AscendC;

// 单核模板：统计项按核均分，每个核独立完成分配到的整组统计
template <typename T>
class KfcDumpStatSingleCore : public KfcDumpStatOpBase<T> {
public:
    using KfcDumpStatOpBase<T>::KfcDumpStatOpBase;
    // 模板基类成员在派生类中不可见，统一引入
    using KfcDumpStatOpBase<T>::pPipe_;
    using KfcDumpStatOpBase<T>::maskBuf_;
    using KfcDumpStatOpBase<T>::cacheBuf1_;
    using KfcDumpStatOpBase<T>::blockIdx_;
    using KfcDumpStatOpBase<T>::blockOffset_;
    using KfcDumpStatOpBase<T>::aiCoreNum_;
    using KfcDumpStatOpBase<T>::xDtypeSize_;
    using KfcDumpStatOpBase<T>::dumpStatClass_;
    using KfcDumpStatOpBase<T>::statNum_;
    using KfcDumpStatOpBase<T>::workspace_;
    using KfcDumpStatOpBase<T>::sMsg_;
    using KfcDumpStatOpBase<T>::rMsg_;
    using KfcDumpStatOpBase<T>::RunStatCompute;
    using KfcDumpStatOpBase<T>::CopyOutStatResult;
    using KfcDumpStatOpBase<T>::SyncAllCores;
    using KfcDumpStatOpBase<T>::UpdateStatOutput;
    using KfcDumpStatOpBase<T>::InitCacheBuf;
    using KfcDumpStatOpBase<T>::ubSize_;
    using KfcDumpStatOpBase<T>::totalCount_;
    using KfcDumpStatOpBase<T>::maxProcCount_;
    using KfcDumpStatOpBase<T>::perBlockCount_;
    using KfcDumpStatOpBase<T>::tileNumMean_;
    using KfcDumpStatOpBase<T>::tileLengthMean_;
    using KfcDumpStatOpBase<T>::tileLengthEnd_;
    using KfcDumpStatOpBase<T>::tileNumEnd_;
    using KfcDumpStatOpBase<T>::innerLoopTime_;

    __aicore__ inline KfcDumpStatSingleCore(
        TPipe* pipe, __gm__ KfcDumpStatMsg* rMsg, __gm__ KfcDumpStatMsg* sMsg, KfcDumpContext* kfcDumpContext)
        : KfcDumpStatOpBase<T>(pipe, rMsg, sMsg, kfcDumpContext)
    {
        // Tiling 计算：单核模板每次都是计算所有数据
        blockOffset_ = 0;
        maxProcCount_ = CalculateMaxProcCount(xDtypeSize_, ubSize_);
        perBlockCount_ = BLOCK_SIZE / xDtypeSize_;
        tileLengthMean_ = maxProcCount_ / BUFFER_NUM;
        tileNumMean_ = totalCount_ / tileLengthMean_;
        tileLengthEnd_ = totalCount_ % tileLengthMean_;
        tileNumEnd_ = tileLengthEnd_ == 0 ? 0 : 1;
        innerLoopTime_ = tileNumMean_;
    }

    __aicore__ inline void Init()
    {
        KfcDumpStatOpBase<T>::Init();
        // 单核模板 mask 固定大小
        pPipe_->InitBuffer(maskBuf_, MAX_MASK_NUM * BLOCK_SIZE);
        InitCacheBuf();
    }

    __aicore__ inline void Process()
    {
        // 无使能统计项或核数为 0 时 eachCoreStatNum 为 0，直接回消息返回，避免除零
        int64_t eachCoreStatNum = (statNum_ == 0 || aiCoreNum_ == 0) ? 0 : CeilDiv(statNum_, aiCoreNum_);
        if (eachCoreStatNum == 0) {
            SyncAllCores();
            if (blockIdx_ == 0) {
                UpdateMsg(sMsg_, rMsg_, true);
            }
            SyncAllCores();
            return;
        }
        int64_t enabledStatNum = 0; // 已遍历的使能统计项个数
        for (int64_t processStatIdx = 0; processStatIdx < MAX_STAT_NUM && enabledStatNum < statNum_; ++processStatIdx) {
            if ((dumpStatClass_ & (1ULL << processStatIdx)) == 0) {
                continue;
            }
            // 单核模板按核序划分统计项：仅当该统计项落在当前核的分片内才执行
            if (IsStatOwner(enabledStatNum, eachCoreStatNum)) {
                RunStatCompute(processStatIdx);
                CopyOutStatResult(processStatIdx, enabledStatNum);
            }
            ++enabledStatNum;
        }

        SyncAllCores();
        CoreReduce(eachCoreStatNum);
        SyncAllCores();
    }

private:
    // 统计项使能序号 enabledStatIdx 是否属于当前核（每核承担 eachCoreStatNum 个统计项）
    __aicore__ inline bool IsStatOwner(int64_t enabledStatIdx, int64_t eachCoreStatNum) const
    {
        if (eachCoreStatNum == 0) { // 除零防护，正常流程不会为 0
            return false;
        }
        int64_t coreIdx = enabledStatIdx / eachCoreStatNum;
        return coreIdx == blockIdx_;
    }

    __aicore__ inline void CoreReduce(int64_t eachCoreStatNum)
    {
        if (blockIdx_ != 0 || eachCoreStatNum == 0) { // eachCoreStatNum 为 0 时无输出可汇总
            return;
        }
        int64_t curCoreStart = 0;
        for (int64_t processStatIdx = 0; processStatIdx < MAX_STAT_NUM; ++processStatIdx) {
            if ((dumpStatClass_ & (1ULL << processStatIdx)) != 0) {
                auto coreIdx = curCoreStart / eachCoreStatNum;
                uint64_t curWorkSpaceAddr = workspace_ + coreIdx * (statNum_ * MAX_WORKSPACE_BYTE_SIZE) +
                                            curCoreStart * MAX_WORKSPACE_BYTE_SIZE;
                UpdateStatOutput(processStatIdx, curWorkSpaceAddr);
                curCoreStart += 1;
            }
        }

        UpdateMsg(sMsg_, rMsg_, true);
    }
};

} // namespace KfcDumpStat

#endif // __KFC_DUMP_SINGLE_CORE_H__
