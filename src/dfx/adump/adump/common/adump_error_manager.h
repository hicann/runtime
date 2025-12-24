/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ADUMP_ERROR_MANAGER_H
#define ADUMP_ERROR_MANAGER_H
#include "error_manager.h"
#include "log/adx_log.h"

#define ADUMP_INPUT_ERROR REPORT_INPUT_ERROR
#define ADUMP_INNER_ERROR REPORT_INNER_ERROR

namespace Adx {
constexpr const char *const INVALID_ARGUMENT = "EP0001";
constexpr const char *const FIELD_NOT_FOUND = "Field [%s] not found in config file [%s].";
constexpr const char *const FIELD_EMPTY = "Field [%s] in config file [%s] is empty.";
constexpr const char *const FIELD_TOO_LONG = "Field [%s] in config file [%s] exceeds the maximum length %d.";
constexpr const char *const FIELD_INVALID_VALUE = "Invalid value [%s] for field [%s] in config file [%s]. Only %s allowed.";
constexpr const char *const FIELD_PATH_INVALID = "Invalid path [%s] for field [%s] in config file [%s]: %s.";
constexpr const char *const FIELD_INVALID_CHARACTERS = "Value [%s] of field [%s] in config file [%s] contains invalid characters.";
constexpr const char *const FIELD_PATH_NO_PERMISSIONS = "Value [%s] of field [%s] in config file [%s] lacks read and write permissions.";

constexpr const char *const FILE_OPERATION_ERROR = "EP0002";
constexpr const char *const FILE_LENGTH_LT_0 = "File content length cannot be less than 0.";
constexpr const char *const FILE_LENGTH_GT_MAX = "File content length cannot exceed [%d].";
constexpr const char *const FILE_READ_FAILED = "Failed to read file.";
constexpr const char *const FILE_PATH_INVALID = "Invalid file path: %s";
constexpr const char *const FILE_STATUS_FAILED = "Failed to get the file status.";
constexpr const char *const FILE_TYPE_INCORRECT = "Incorrect file type.";
constexpr const char *const FILE_JSON_TOO_DEEP = "The levels of \"{\" and \"[\" in the JSON file cannot exceed 10.";
constexpr const char *const FILE_JSON_PARSE_FAILED = "Failed to parse JSON file: %s";
constexpr const char *const MEMORY_JSON_PARSE_FAILED = "Parse config from memory failed: %s";


void ReportInvalidArgumentError(const std::string param, const std::string value, const std::string reason);

void ReportFileOperationError(const std::string &path, const std::string &reason);
void ReportConfigParseError(const std::string &reason);
}
#endif
