/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "base/err_msg.h"
#include <map>
#include <mutex>
#include <iostream>
#include <string>
#include <vector>

namespace {
const char *const kErrorCodePath = "../conf/error_manager/error_code.json";
const char *const kErrorList = "error_info_list";
const char *const kErrCode = "ErrCode";
const char *const kErrMessage = "ErrMessage";
const char *const kArgList = "Arglist";
const uint64_t kLength = 2;

static std::string g_lastErrorCode;
static std::mutex g_errorMutex;
}  // namespace

std::string GetLastReportedErrorCode() {
    std::lock_guard<std::mutex> lock(g_errorMutex);
    return g_lastErrorCode;
}

void ClearLastReportedErrorCode() {
    std::lock_guard<std::mutex> lock(g_errorMutex);
    g_lastErrorCode.clear();
}

static std::string FormatErrorCode(const std::string &error_code,
                                   const std::vector<std::string> &key,
                                   const std::vector<std::string> &value) {
    static const std::map<std::string, std::string> errorTemplates = {
        {"EP0001", "The content of configuration item %s in configuration file %s is invalid. Reason: %s."},
        {"EP0002", "Value %s for configuration item %s in configuration file %s is invalid. Expected value: %s."},
        {"EP0003", "Value %s for configuration item %s in configuration file %s is invalid. Reason: %s."},
        {"EP0004", "Failed to parse file %s. Reason: %s."},
        {"EP0005", "Conflict of configuration items in configuration file %s. Reason: %s."},
        {"EP0006", "%s failed. Value %s for parameter %s is invalid. Reason: %s"},
        {"EP0007", "%s failed because %s cannot be a NULL pointer."},
        {"EP0008", "%s failed. Reason: %s."}
    };
    
    auto it = errorTemplates.find(error_code);
    if (it == errorTemplates.end()) {
        return error_code + ": Unknown error.";
    }
    
    std::string templateStr = it->second;
    if (key.size() != value.size()) {
        return error_code + ": " + templateStr;
    }
    
    // Replace placeholders with actual values using %s format
    size_t placeholderPos = 0;
    for (size_t i = 0; i < value.size(); ++i) {
        placeholderPos = templateStr.find("%s", placeholderPos);
        if (placeholderPos != std::string::npos) {
            templateStr.replace(placeholderPos, 2, value[i]);
            placeholderPos += value[i].length();
        }
    }
    
    return error_code + ": " + templateStr;
}

// Definitions for the WEAK_SYMBOL declarations in base/err_msg.h. Without these the weak symbols
// resolve to null and calling them segfaults at run time instead of failing to link.
namespace error_message {
int32_t ReportPredefinedErrMsg(const char *error_code, const std::vector<const char *> &key,
                               const std::vector<const char *> &value) {
    std::vector<std::string> keyStr;
    std::vector<std::string> valueStr;
    for (const auto *k : key) {
        keyStr.emplace_back((k == nullptr) ? "" : k);
    }
    for (const auto *v : value) {
        valueStr.emplace_back((v == nullptr) ? "" : v);
    }
    const std::string code = (error_code == nullptr) ? "" : error_code;

    std::lock_guard<std::mutex> lock(g_errorMutex);
    g_lastErrorCode = code;
    std::cout << "[ERROR] " << FormatErrorCode(code, keyStr, valueStr) << std::endl;
    return 0;
}

int32_t ReportPredefinedErrMsg(const char *error_code) {
    std::lock_guard<std::mutex> lock(g_errorMutex);
    g_lastErrorCode = (error_code == nullptr) ? "" : error_code;
    return 0;
}

int32_t ReportInnerErrMsg(const char *file_name, const char *func, uint32_t line, const char *error_code,
                          const char *format, ...) {
    (void)file_name;
    (void)func;
    (void)line;
    (void)error_code;
    (void)format;
    return 0;
}

int32_t ReportUserDefinedErrMsg(const char *error_code, const char *format, ...) {
    (void)error_code;
    (void)format;
    return 0;
}

int32_t RegisterFormatErrorMessage(const char *error_msg, size_t error_msg_len) {
    (void)error_msg;
    (void)error_msg_len;
    return 0;
}
}  // namespace error_message
