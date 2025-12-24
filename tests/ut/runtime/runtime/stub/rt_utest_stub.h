/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef RT_UTEST_STUB_H
#define RT_UTEST_STUB_H

#include <string>
#include <map>
#include <memory>
#include <string>
#include <utility>
#include <vector>
#include <list>
#include <deque>
#include "runtime/dev.h"
#include "rt_model.h"

namespace error_message {
std::string TrimPath(const std::string &str);
#ifdef __GNUC__
int FormatErrorMessage(char *str_dst, size_t dst_max, const char *format, ...) __attribute__((format(printf, 3, 4)));
#define TRIM_PATH(x) strrchr(x, '/') ? strrchr(x, '/') + 1 : (x)
#else
int FormatErrorMessage(char *str_dst, size_t dst_max, const char *format, ...);
#define TRIM_PATH(x) strrchr(x, '\\') ? strrchr(x, '\\') + 1 : (x)
#endif
}

class ErrorManager {
public:
   static ErrorManager &GetInstance();
   void SetStage(const std::string &firstStage, const std::string &secondStage);
   void ATCReportErrMessage(std::string error_code, const std::vector<std::string> &key = {},
                           const std::vector<std::string> &value = {});
   int Init();
   int ReportInterErrMessage(std::string error_code, const std::string &error_msg);
    std::string GetErrorMessage();
    const std::string &GetLogHeader();
};
#endif