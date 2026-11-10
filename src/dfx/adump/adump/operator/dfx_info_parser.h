/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef DFX_INFO_PARSER_H
#define DFX_INFO_PARSER_H

#include <atomic>
#include <map>
#include <mutex>
#include <tuple>
#include <vector>

#include "common/singleton.h"
#include "rt_inner_dfx.h"
#include "base/log_types.h"
#include "dfx_struct.h"
#include "profiling/prof_common.h"

namespace Adx {

// 超大 Tensor 打印上下文：仅存元信息与偏移，不持数据，跨解析回调驻留；按流各持一份
struct SuperTensorPrintCtx {
    bool valid = false;    // 是否有打开的 super tensor
    uint32_t dataType = 0; // 数据类型，body 续打用
    uint32_t desc = 0;
    uint32_t addr = 0;
    uint16_t position = 0;
    uint16_t blockIdx = 0;
    uint32_t dim = 0;
    uint32_t shape[cce::runtime::RT_DUMP_SHAPE_MAX_SIZE] = {0U};
    uint64_t length = 0; // body 归属匹配与完成判定用
    uint64_t printedOffset = 0; // 已消费偏移（tensor 级绝对偏移，= 下一 body 的 offset），截断忽略同样计入
    bool printTruncated = false; // 超规格打屏上限已忽略，后续分片只推进偏移不打数据
};

// 超大 Tensor 分片打屏的段信息：全局下标续算 + 括号对齐 + 收尾控制
struct SuperTensorSegInfo {
    std::vector<size_t> tmpShape; // 后缀累积 shape，空表示平铺
    size_t elemBase = 0;          // 本段首元素的全局下标
    size_t totalElemNum = 0;      // 整 tensor 元素数
    bool finishAtEnd = false;     // 本段末元素是否收尾（"]" + 换行）
};

using DfxStreamKey = std::tuple<uint32_t, uint32_t, uint32_t>;

class DfxInfoParser : public Common::Singleton::Singleton<DfxInfoParser> {
public:
    DfxInfoParser();
    ~DfxInfoParser() override;
    int32_t Init();
    void UnInit();
    void ParseDfxInfo(const rtDfxParseParam* param, uint64_t* consumedLen);

private:
    bool registered_;
    std::mutex lifecycleMutex_;
    std::mutex tlvCntMutex_;
    std::map<DfxStreamKey, uint64_t> tlvCntMap_;
    std::map<DfxStreamKey, SuperTensorPrintCtx> superTensorCtxMap_;
    static std::atomic<bool> profCtrlRegistered_;
    static void RegisterProfCtrlCallbackOnce();
    void AddTlvCnt(const rtDfxParseParam* param, uint64_t consumedTlvCnt);
    uint64_t GetTlvCnt(const rtDfxParseParam* param, uint64_t packIdx);
    void ClearTlvCntState();
};

} // namespace Adx

#endif // DFX_INFO_PARSER_H
