/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef TESTS_DEPENDS_SLOG_STUB_LOG_CAPTURE_H_
#define TESTS_DEPENDS_SLOG_STUB_LOG_CAPTURE_H_

// slog stub 捕获最近一次 DlogRecord 落盘的日志内容，供单测断言使用。
// 通过头文件声明的函数接口访问，避免在测试源文件中以 extern 声明引用外部变量（G.EXP.05-CPP）。
const char* DlogStubGetLastLogMsg();

#endif // TESTS_DEPENDS_SLOG_STUB_LOG_CAPTURE_H_
