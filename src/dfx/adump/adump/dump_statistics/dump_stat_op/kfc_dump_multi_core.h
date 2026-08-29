/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef __KFC_DUMP_MULTI_CORE_H__
#define __KFC_DUMP_MULTI_CORE_H__

#include "kfc_dump_op_base.h"

namespace KfcDumpStat {
using namespace AscendC;

// 多核模板：数据按核切分，每个核计算全部统计项后由 0 核汇总
template <typename T>
class KfcDumpStatMultiCore : public KfcDumpStatOpBase<T> {
public:
    // 模板基类成员在派生类中不可见，统一引入
    using KfcDumpStatOpBase<T>::pPipe_;
    using KfcDumpStatOpBase<T>::maskBuf_;
    using KfcDumpStatOpBase<T>::cacheBuf1_;
    using KfcDumpStatOpBase<T>::blockIdx_;
    using KfcDumpStatOpBase<T>::blockOffset_;
    using KfcDumpStatOpBase<T>::aiCoreNum_;
    using KfcDumpStatOpBase<T>::ubSize_;
    using KfcDumpStatOpBase<T>::xDtypeSize_;
    using KfcDumpStatOpBase<T>::totalCount_;
    using KfcDumpStatOpBase<T>::dumpStatClass_;
    using KfcDumpStatOpBase<T>::statNum_;
    using KfcDumpStatOpBase<T>::outputAddr_;
    using KfcDumpStatOpBase<T>::maxProcCount_;
    using KfcDumpStatOpBase<T>::perBlockCount_;
    using KfcDumpStatOpBase<T>::tileLengthMean_;
    using KfcDumpStatOpBase<T>::tileNumMean_;
    using KfcDumpStatOpBase<T>::tileLengthEnd_;
    using KfcDumpStatOpBase<T>::tileNumEnd_;
    using KfcDumpStatOpBase<T>::innerLoopTime_;
    using KfcDumpStatOpBase<T>::workspace_;
    using KfcDumpStatOpBase<T>::sMsg_;
    using KfcDumpStatOpBase<T>::rMsg_;
    using KfcDumpStatOpBase<T>::RunStatCompute;
    using KfcDumpStatOpBase<T>::CopyOutStatResult;
    using KfcDumpStatOpBase<T>::SyncAllCores;
    using KfcDumpStatOpBase<T>::InitCacheBuf;

    __aicore__ inline KfcDumpStatMultiCore(
        TPipe* pipe, __gm__ KfcDumpStatMsg* rMsg, __gm__ KfcDumpStatMsg* sMsg, KfcDumpContext* kfcDumpContext)
        : KfcDumpStatOpBase<T>(pipe, rMsg, sMsg, kfcDumpContext)
    {
        // Tiling 计算
        maxProcCount_ = CalculateMaxProcCountMulti(xDtypeSize_, ubSize_);
        perBlockCount_ = BLOCK_SIZE / xDtypeSize_;
        blockLengthMean_ = (totalCount_ + aiCoreNum_ - 1) / aiCoreNum_; // 向上取整
        // 实际需要参与的核数：元素数不满 aiCoreNum_ 整倍时，高编号核不承担数据，
        // 由最后一个参与核吸收差额，避免尾核长度为负或高编号核整块越界读 GM
        int64_t usedCoreCeil = (blockLengthMean_ == 0) ? 1 : CeilDiv(totalCount_, blockLengthMean_);
        usedCoreNum_ = (usedCoreCeil < aiCoreNum_) ? usedCoreCeil : aiCoreNum_;
        if (totalCount_ % usedCoreNum_ == 0) {
            blockLengthEnd_ = blockLengthMean_;
        } else {
            blockLengthEnd_ = totalCount_ - (usedCoreNum_ - 1) * blockLengthMean_;
        }

        tileLengthMean_ = maxProcCount_ / BUFFER_NUM;

        // 未参与数据搬运的核（blockIdx_ >= usedCoreNum_）在 Process 中直接跳过
        bool isLastUsedCore = blockIdx_ == usedCoreNum_ - 1; // 处理尾块数据的核
        if (isLastUsedCore) {
            tileNumMean_ = blockLengthEnd_ / tileLengthMean_;
            tileLengthEnd_ = blockLengthEnd_ % tileLengthMean_;
        } else {
            tileNumMean_ = blockLengthMean_ / tileLengthMean_;
            tileLengthEnd_ = blockLengthMean_ % tileLengthMean_;
        }
        tileNumEnd_ = tileLengthEnd_ == 0 ? 0 : 1;
        innerLoopTime_ = tileNumMean_;

        blockOffset_ = blockIdx_ * blockLengthMean_;
    }

    __aicore__ inline void Init()
    {
        KfcDumpStatOpBase<T>::Init();
        // 多核模板 mask 与输入数据等长
        pPipe_->InitBuffer(maskBuf_, tileLengthMean_ * xDtypeSize_);
        InitCacheBuf();
    }

    __aicore__ inline void Process()
    {
        // 未参与数据搬运的核：不搬运不计算，workspace 槽保持 0，
        // 但必须镜像参与核的屏障到达次数（每使能统计项 1 次 + CoreReduce 后 1 次）：
        // 全核屏障（软同步传 aiCoreNum_/硬同步 SyncAll）要求各核每代都到达，
        // 到达次数不等会使参与核在后续代上永久等待空闲核
        if (blockIdx_ >= usedCoreNum_) {
            for (int64_t i = 0; i < statNum_; ++i) {
                SyncAllCores();
            }
            CoreReduce();
            SyncAllCores();
            return;
        }
        int64_t curCoreStart = 0;
        for (int64_t processStatIdx = 0; processStatIdx < MAX_STAT_NUM; ++processStatIdx) {
            if ((dumpStatClass_ & (1ULL << processStatIdx)) == 0) {
                continue;
            }
            RunStatCompute(processStatIdx);
            CopyOutStatResult(processStatIdx, curCoreStart);
            curCoreStart += 1;
            SyncAllCores();
        }

        CoreReduce();
        SyncAllCores();
    }

private:
    template <typename OutputT>
    __aicore__ inline OutputT StatReduce(StatClass curStatClass, int64_t statIdx)
    {
        OutputT finalResult;
        // 仅归并实际参与数据搬运的核：未参与核的 workspace 槽保持 0，
        // 参与 max/min 归并会把全负数据的 max / 全正数据的 min 错误统计为 0
        for (int64_t coreIdx = 0; coreIdx < usedCoreNum_; ++coreIdx) {
            uint64_t curWorkSpaceAddr =
                workspace_ + coreIdx * (statNum_ * MAX_WORKSPACE_BYTE_SIZE) + statIdx * MAX_WORKSPACE_BYTE_SIZE;

            auto curCoreOutputVal = GetCoreOutput<OutputT>(curWorkSpaceAddr);
            if (coreIdx == 0) {
                finalResult = curCoreOutputVal;
                continue;
            }
            finalResult = ReduceStatValue<OutputT>(curStatClass, finalResult, curCoreOutputVal);
        }

        if (curStatClass == StatClass::STAT_L2NORM) {
            finalResult = sqrt(finalResult);
        }

        return finalResult;
    }

    // 按统计项选择归并方式：max 取最大，min 取最小，其余累加
    template <typename OutputT>
    __aicore__ inline OutputT ReduceStatValue(StatClass curStatClass, OutputT finalResult, OutputT curValue)
    {
        if (curStatClass == StatClass::STAT_MAX) {
            return finalResult < curValue ? curValue : finalResult;
        }
        if (curStatClass == StatClass::STAT_MIN) {
            return finalResult > curValue ? curValue : finalResult;
        }
        // mean，nan inf l2norm 均是累加
        return finalResult + curValue;
    }

    // max/min 输出类型与输入数据类型相关：整型输出 int32，浮点输出 float
    __aicore__ inline void UpdateMaxOrMinOutput(int64_t statIdx, int64_t curCoreStart)
    {
        constexpr bool isIntType = std::is_same_v<T, uint8_t> || std::is_same_v<T, int8_t> ||
                                   std::is_same_v<T, int16_t> || std::is_same_v<T, int32_t>;
        uint64_t curStatOutputAddr = outputAddr_ + statIdx * MAX_OUTPUT_BYTE_SIZE;
        if constexpr (isIntType) {
            auto finalResult = StatReduce<int32_t>(static_cast<StatClass>(statIdx), curCoreStart);
            UpdateCoreOutput<int32_t>(curStatOutputAddr, finalResult);
        } else {
            auto finalResult = StatReduce<float>(static_cast<StatClass>(statIdx), curCoreStart);
            UpdateCoreOutput<float>(curStatOutputAddr, finalResult);
        }
    }

    // mean/l2norm 输出 float；nan/inf 输出 int32；均跨核归并
    __aicore__ inline void UpdateReduceOutput(int64_t statIdx, int64_t curCoreStart)
    {
        uint64_t curStatOutputAddr = outputAddr_ + statIdx * MAX_OUTPUT_BYTE_SIZE;
        if (statIdx == static_cast<int64_t>(StatClass::STAT_MEAN) ||
            statIdx == static_cast<int64_t>(StatClass::STAT_L2NORM)) {
            auto finalResult = StatReduce<float>(static_cast<StatClass>(statIdx), curCoreStart);
            UpdateCoreOutput<float>(curStatOutputAddr, finalResult);
        } else {
            auto finalResult = StatReduce<int32_t>(static_cast<StatClass>(statIdx), curCoreStart);
            UpdateCoreOutput<int32_t>(curStatOutputAddr, finalResult);
        }
    }

    // 当所有核将自己的多个统计结果更新到 workspace 的 GM 内存上后，需要进行 Reduce 操作
    __aicore__ inline void CoreReduce()
    {
        if (blockIdx_ != 0) {
            return;
        }
        int64_t curCoreStart = 0;
        for (int64_t processStatIdx = 0; processStatIdx < MAX_STAT_NUM; ++processStatIdx) {
            if ((dumpStatClass_ & (1ULL << processStatIdx)) == 0) {
                continue;
            }
            if (processStatIdx == static_cast<int64_t>(StatClass::STAT_MAX) ||
                processStatIdx == static_cast<int64_t>(StatClass::STAT_MIN)) {
                UpdateMaxOrMinOutput(processStatIdx, curCoreStart);
            } else {
                UpdateReduceOutput(processStatIdx, curCoreStart);
            }
            curCoreStart += 1;
        }

        UpdateMsg(sMsg_, rMsg_, true);
    }

private:
    int64_t blockLengthMean_ = 0; // 前 core - 1 个核处理的数据元素个数
    int64_t blockLengthEnd_ = 0;  // 最后一个参与核处理的数据元素个数
    int64_t usedCoreNum_ = 1;     // 实际参与数据搬运的核数（<= aiCoreNum_）
};

} // namespace KfcDumpStat

#endif // __KFC_DUMP_MULTI_CORE_H__
