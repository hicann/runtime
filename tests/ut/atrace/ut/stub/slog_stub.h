/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef SLOG_STUB_H
#define SLOG_STUB_H
extern void RecordErrorLog(void);
static inline void EXPECT_CheckNoErrorLog()
{
    MOCKER(RecordErrorLog)
        .expects(never())
        .will(ignoreReturnValue());
}

static inline void EXPECT_CheckErrorLog()
{
    MOCKER(RecordErrorLog)
        .expects(atLeast(1))
        .will(ignoreReturnValue());
}
#endif