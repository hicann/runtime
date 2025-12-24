/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef ANALYSIS_DVVP_ANALYZE_OP_DESC_PARSER_H
#define ANALYSIS_DVVP_ANALYZE_OP_DESC_PARSER_H

#include <cstdint>
#include <map>
#include "acl_prof.h"
#include "singleton/singleton.h"
#include "utils/utils.h"

namespace Analysis {
namespace Dvvp {
namespace Analyze {
using namespace analysis::dvvp::common::utils;
using CONST_VOID_PTR = const void *;
using UINT32_T_PTR = uint32_t *;
using CHAR_PTR = char *;
using CONST_CHAR_PTR = const char *;
class OpDescParser : public analysis::dvvp::common::singleton::Singleton<OpDescParser> {
public:
    OpDescParser();
    ~OpDescParser() override {}

public:
    static uint32_t GetOpDescSize();
    static int32_t GetOpNum(CONST_VOID_PTR data, uint32_t len, UINT32_T_PTR opNum);
    static int32_t GetModelId(CONST_VOID_PTR data, uint32_t len, uint32_t index, UINT32_T_PTR modelId);
    static int32_t GetThreadId(CONST_VOID_PTR data, uint32_t len, uint32_t index, UINT32_T_PTR threadId);
    static int32_t GetDeviceId(CONST_VOID_PTR data, uint32_t len, uint32_t index, UINT32_T_PTR devId);
    static uint64_t GetOpStart(CONST_VOID_PTR data, uint32_t len, uint32_t index);
    static uint64_t GetOpEnd(CONST_VOID_PTR data, uint32_t len, uint32_t index);
    static uint64_t GetOpDuration(CONST_VOID_PTR data, uint32_t len, uint32_t index);
    static uint64_t GetOpExecutionTime(CONST_VOID_PTR data, uint32_t len, uint32_t index);
    static uint64_t GetOpCubeFops(CONST_VOID_PTR data, uint32_t len, uint32_t index);
    static uint64_t GetOpVectorFops(CONST_VOID_PTR data, uint32_t len, uint32_t index);
    static uint32_t GetOpFlag(CONST_VOID_PTR data, uint32_t len, uint32_t index);
    static const char *GetOpAttriValue(CONST_VOID_PTR data, uint32_t len, uint32_t index,
                                       aclprofSubscribeOpAttri attri);
    uint64_t SetOpTypeAndOpName(const std::string &opType, const std::string &opName);
    int32_t GetOpTypeLen(CONST_VOID_PTR data, uint32_t len, SIZE_T_PTR opTypeLen, uint32_t index);
    int32_t GetOpType(CONST_VOID_PTR data, uint32_t len, CHAR_PTR opType, uint32_t opTypeLen, uint32_t index);
    int32_t GetOpNameLen(CONST_VOID_PTR data, uint32_t len, SIZE_T_PTR opNameLen, uint32_t index);
    int32_t GetOpName(CONST_VOID_PTR data, uint32_t len, CHAR_PTR opName, uint32_t opNameLen, uint32_t index);

private:
    static int32_t CheckData(CONST_VOID_PTR data, uint32_t len);

private:
    std::mutex mtx_;
    uint64_t opIndex_;
    std::map<uint64_t, std::string> opNames_;   // opIndex, opName
    std::map<uint64_t, std::string> opTypes_;   // opIndex, opType
};
}  // namespace Analyze
}  // namespace Dvvp
}  // namespace Analysis

#endif
