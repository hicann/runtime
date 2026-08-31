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

#include "common/singleton.h"
#include "rt_inner_dfx.h"
#include "profiling/prof_common.h"

namespace Adx {

class DfxInfoParser : public Common::Singleton::Singleton<DfxInfoParser> {
public:
    DfxInfoParser();
    ~DfxInfoParser() override;
    int32_t Init();
    void UnInit();
    void ParseDfxInfo(const rtDfxParseParam* param, uint64_t* consumedLen);

private:
    bool registered_;
    bool profRegistered_;
};

} // namespace Adx

#endif // DFX_INFO_PARSER_H
