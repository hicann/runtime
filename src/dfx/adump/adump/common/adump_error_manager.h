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
#include <string>
#include <vector>
#include "base/err_msg.h"
#include "str_utils.h"
#include "log/adx_log.h"

namespace Adx {
// REPORT_PREDEFINED_ERR_MSG takes std::vector<const char *>, while the REPORT_EP000x_* macros below
// pass std::vector<std::string>. Converting here keeps those macros unchanged.
inline std::vector<const char *> ToCStrVec(const std::vector<std::string> &in)
{
    std::vector<const char *> out;
    out.reserve(in.size());
    for (const auto &s : in) {
        out.emplace_back(s.c_str());
    }
    return out;
}
}  // namespace Adx

// Named locals before c_str(): every caller builds the vectors inline as temporaries. Binding them
// to the do/while block makes the lifetime explicit rather than relying on full-expression scope.
#define ADUMP_INPUT_ERROR(error_code, key, value)                  \
    do {                                                           \
        const std::vector<std::string> adumpErrKeys__ = (key);      \
        const std::vector<std::string> adumpErrVals__ = (value);    \
        REPORT_PREDEFINED_ERR_MSG((error_code),                     \
            Adx::ToCStrVec(adumpErrKeys__),                         \
            Adx::ToCStrVec(adumpErrVals__));                        \
    } while (0)

namespace Adx {

#define ADUMP_TO_CSTR(s) (std::string(s).c_str())

// EP0004 Parse Error Report Macro - Inline for performance
#define REPORT_EP0004_PARSE_ERROR(moduleName, reason, configPath) \
    do { \
        IDE_LOGE("[%s] Parse failed: %s", moduleName, ADUMP_TO_CSTR(reason)); \
        ADUMP_INPUT_ERROR("EP0004", std::vector<std::string>({"path", "reason"}), \
            std::vector<std::string>({configPath, reason})); \
    } while (0)

// EP0001 Configuration Item Error Report Macro - Inline for performance
#define REPORT_EP0001_ITEM_ERROR(moduleName, item, reason, configPath) \
    do { \
        IDE_LOGE("[%s] The content of configuration item %s in config file %s is invalid. Reason: %s", \
                 moduleName, ADUMP_TO_CSTR(item), configPath, ADUMP_TO_CSTR(reason)); \
        ADUMP_INPUT_ERROR("EP0001", std::vector<std::string>({"item", "path", "reason"}), \
            std::vector<std::string>({item, configPath, reason})); \
    } while (0)

// EP0002 Enum Value Invalid Report Macro - Inline for performance
#define REPORT_EP0002_ENUM_VALUE_INVALID(moduleName, value, item, expectedValue, configPath) \
    do { \
        IDE_LOGE("[%s] Value %s for configuration item %s in file %s is invalid, must be selected from [%s].", \
                 moduleName, ADUMP_TO_CSTR(value), ADUMP_TO_CSTR(item), configPath, ADUMP_TO_CSTR(expectedValue)); \
        ADUMP_INPUT_ERROR("EP0002", std::vector<std::string>({"value", "item", "path", "expected_value"}), \
            std::vector<std::string>({value, item, configPath, expectedValue})); \
    } while (0)

// EP0003 Value Invalid Report Macro - Inline for performance
#define REPORT_EP0003_INVALID_VALUE(moduleName, value, item, reason, configPath) \
    do { \
        IDE_LOGE("[%s] Value %s for parameter %s in config file %s is invalid. Reason: %s", \
                 moduleName, ADUMP_TO_CSTR(value), ADUMP_TO_CSTR(item), configPath, ADUMP_TO_CSTR(reason)); \
        ADUMP_INPUT_ERROR("EP0003", std::vector<std::string>({"value", "item", "path", "reason"}), \
            std::vector<std::string>({value, item, configPath, reason})); \
    } while (0)

// EP0005 Conflict Report Macros - Inline for performance
#define REPORT_EP0005_ITEM_CANNOT_SET_WHEN_ITEM_SET(moduleName, errorItem, conditionItem, configPath) \
    do { \
        std::string reason = StrUtils::Format( \
            ADUMP_REASON_FMT_ITEM_CANNOT_SET_WHEN_ITEM_SET, \
            ADUMP_TO_CSTR(errorItem), ADUMP_TO_CSTR(conditionItem)); \
        IDE_LOGE("[%s] %s", moduleName, reason.c_str()); \
        ADUMP_INPUT_ERROR("EP0005", std::vector<std::string>({"path", "reason"}), \
            std::vector<std::string>({configPath, reason})); \
    } while (0)

#define REPORT_EP0005_ITEM_CANNOT_SET_WHEN_ITEM_VALUE(moduleName, errorItem, conditionItem, conditionValue, configPath) \
    do { \
        std::string reason = StrUtils::Format( \
            ADUMP_REASON_FMT_ITEM_CANNOT_SET_WHEN_ITEM_VALUE, \
            ADUMP_TO_CSTR(conditionItem), ADUMP_TO_CSTR(conditionValue), ADUMP_TO_CSTR(errorItem)); \
        IDE_LOGE("[%s] %s", moduleName, reason.c_str()); \
        ADUMP_INPUT_ERROR("EP0005", std::vector<std::string>({"path", "reason"}), \
            std::vector<std::string>({configPath, reason})); \
    } while (0)

#define REPORT_EP0005_ITEM_CANNOT_SET_WHEN_ITEM_NOT_VALUE(moduleName, errorItem, conditionItem, conditionValue, configPath) \
    do { \
        std::string reason = StrUtils::Format( \
            ADUMP_REASON_FMT_ITEM_CANNOT_SET_WHEN_ITEM_NOT_VALUE, \
            ADUMP_TO_CSTR(conditionItem), ADUMP_TO_CSTR(conditionValue), ADUMP_TO_CSTR(errorItem)); \
        IDE_LOGE("[%s] %s", moduleName, reason.c_str()); \
        ADUMP_INPUT_ERROR("EP0005", std::vector<std::string>({"path", "reason"}), \
            std::vector<std::string>({configPath, reason})); \
    } while (0)

#define REPORT_EP0005_ITEM_VALUE_CANNOT_SET_WHEN_ITEM_VALUE(moduleName, errorItem, errorValue, conditionItem, conditionValue, configPath) \
    do { \
        std::string reason = StrUtils::Format( \
            ADUMP_REASON_FMT_ITEM_VALUE_CANNOT_SET_WHEN_ITEM_VALUE, \
            ADUMP_TO_CSTR(conditionItem), ADUMP_TO_CSTR(conditionValue), ADUMP_TO_CSTR(errorItem), ADUMP_TO_CSTR(errorValue)); \
        IDE_LOGE("[%s] %s", moduleName, reason.c_str()); \
        ADUMP_INPUT_ERROR("EP0005", std::vector<std::string>({"path", "reason"}), \
            std::vector<std::string>({configPath, reason})); \
    } while (0)

#define REPORT_EP0006_INVALID_ARGUMENT(funcName, value, param, reason) \
    do { \
        IDE_LOGE("[%s] %s failed. Value %s for parameter %s is invalid. Reason: %s", \
                 ADUMP_TO_CSTR(funcName), ADUMP_TO_CSTR(funcName), ADUMP_TO_CSTR(value), ADUMP_TO_CSTR(param), ADUMP_TO_CSTR(reason)); \
        ADUMP_INPUT_ERROR("EP0006", std::vector<std::string>({"func", "value", "param", "reason"}), \
            std::vector<std::string>({funcName, value, param, reason})); \
    } while (0)

#define REPORT_EP0007_NULL_POINTER(funcName, param) \
    do { \
        IDE_LOGE("[%s] %s failed because %s cannot be a NULL pointer.", \
                 ADUMP_TO_CSTR(funcName), ADUMP_TO_CSTR(funcName), ADUMP_TO_CSTR(param)); \
        ADUMP_INPUT_ERROR("EP0007", std::vector<std::string>({"func", "param"}), \
            std::vector<std::string>({funcName, param})); \
    } while (0)

#define REPORT_EP0008_API_CALL_SEQUENCE(funcName, reason) \
    do { \
        IDE_LOGE("[%s] %s failed. Reason: %s.", ADUMP_TO_CSTR(funcName), ADUMP_TO_CSTR(funcName), ADUMP_TO_CSTR(reason)); \
        ADUMP_INPUT_ERROR("EP0008", std::vector<std::string>({"func", "reason"}), \
            std::vector<std::string>({std::string(funcName), std::string(reason)})); \
    } while (0)

// EP0001 Reasons - Configuration item problems
constexpr const char* ADUMP_REASON_ITEM_NOT_FOUND = "The configuration item is not found";
constexpr const char* ADUMP_REASON_ITEM_VALUE_EMPTY = "The configuration item value is empty";
constexpr const char* ADUMP_REASON_ITEM_MUST_BE_STRING = "This configuration item must be of the string type";
constexpr const char* ADUMP_REASON_ITEM_MUST_BE_ARRAY = "This configuration item must be of the array type";
constexpr const char* ADUMP_REASON_ITEM_MUST_BE_OBJECT = "This configuration item must be of the object type";
constexpr const char* ADUMP_REASON_MEMBER_MUST_BE_STRING = "The member type of this configuration item must be string";
constexpr const char* ADUMP_REASON_MEMBER_MUST_BE_OBJECT = "The member type of this configuration item must be object";

// EP0003 Reasons - Value validity problems
constexpr const char* ADUMP_REASON_VALUE_INVALID_CHARS = "The value contains invalid characters";
constexpr const char* ADUMP_REASON_PATH_NOT_EXIST = "The path does not exist";
constexpr const char* ADUMP_REASON_PATH_NO_PERMISSION = "The value is a path without read and write permissions";
constexpr const char* ADUMP_REASON_PATH_INVALID = "The value is an invalid path";
constexpr const char* ADUMP_REASON_PATH_NOT_DIRECTORY = "The path is not a directory path";
constexpr const char* ADUMP_REASON_PATH_LENGTH_EXCEED_LIMIT = 
    "The path length exceeds the maximum limit of 512 characters";
constexpr const char* ADUMP_REASON_DUMP_STEP_EXCEED_LIMIT = 
    "The value exceeds the maximum limit of 100 intervals";
constexpr const char* ADUMP_REASON_DUMP_STEP_INVALID_FORMAT = 
    "The value has invalid format, expected format: 5-10";
constexpr const char* ADUMP_REASON_DUMP_STEP_NOT_DIGIT = 
    "The value contains non-digit characters,  expected format: 1 or 5-10";
constexpr const char* ADUMP_REASON_DUMP_STEP_INVALID_RANGE = 
    "The value has invalid format, start step must not exceed end step, expected format: 5-10";
constexpr const char* ADUMP_REASON_BLACKLIST_SIZE_EXCEED_LIMIT = 
    "The value size exceeds the maximum limit of 100";
constexpr const char* ADUMP_REASON_BLACKLIST_POS_INVALID_FORMAT = 
    "The value has invalid format, the prefix must be input or output, expected format: inputn or outputn";
constexpr const char* ADUMP_REASON_BLACKLIST_POS_INDEX_NOT_DIGIT = 
    "The value has invalid format, the index must be a digit, expected format: input1 or output1";
constexpr const char* ADUMP_REASON_OPNAME_RANGE_INCOMPLETE = 
    "The item is incomplete, begin and end must be configured together and non-empty";

// EP0005 Reason Templates - Configuration conflict
constexpr const char* ADUMP_REASON_FMT_ITEM_CANNOT_SET_WHEN_ITEM_SET =
    "Configuration items %s and %s cannot be configured";
constexpr const char* ADUMP_REASON_FMT_ITEM_CANNOT_SET_WHEN_ITEM_VALUE =
    "When configuration item %s is set to %s, configuration item %s cannot be configured";
constexpr const char* ADUMP_REASON_FMT_ITEM_CANNOT_SET_WHEN_ITEM_NOT_VALUE =
    "When configuration item %s is not set to %s, configuration item %s cannot be configured";
constexpr const char* ADUMP_REASON_FMT_ITEM_VALUE_CANNOT_SET_WHEN_ITEM_VALUE =
    "When configuration item %s is set to %s, configuration item %s cannot be set to %s";

// EP0006 Reasons - Invalid argument problems
constexpr const char* ADUMP_REASON_RESERVED_PARAM_MUST_EQUAL = "The parameter is reserved and can only be %s";
constexpr const char* ADUMP_REASON_PARAM_PATH_EMPTY = "The parameter is a path and cannot be empty";
constexpr const char* ADUMP_REASON_PARAM_PATH_HAS_PARENT_DIR =
    "The parameter is a relative path and cannot contain '..' segment";
constexpr const char* ADUMP_REASON_PARAM_PATH_CREATE_DIR_ERROR = 
    "The parameter is a path and the path fails to be created. Error: %s";
constexpr const char* ADUMP_REASON_PARAM_PATH_NOT_DIRECTORY =
    "The parameter is not a directory path";
constexpr const char* ADUMP_REASON_PARAM_MUST_BE_GREATER_THAN = "The parameter must be greater than %s";
constexpr const char* ADUMP_REASON_BUFFER_SIZE_NOT_ENOUGH = "The buffer size %s is not enough for the result size %s";
constexpr const char* ADUMP_REASON_PARAM_VALUE_EXCEED_LIMIT = "The value %s exceeds the maximum limit of %s";
constexpr const char* ADUMP_REASON_PARAM_VALUE_NOT_SUPPORTED = "The value %s is not supported, it must be %s";

// EP0008 Reasons - Call API sequence
constexpr const char* ADUMP_REASON_API_CALLED_REPEATEDLY = "This API cannot be called repeatedly";
constexpr const char* ADUMP_REASON_EXCEPTION_DUMP_NOT_ENABLED = "Exception Dump must be enabled before %s is called";

constexpr const char* FUNC_NAME_ACL_OP_START_DUMP_ARGS = "aclopStartDumpArgs";
constexpr const char* FUNC_ACL_OP_START_DUMP_ARGS_PARAM_PATH = "path";
constexpr const char* FUNC_ACL_OP_START_DUMP_ARGS_PARAM_DUMPTYPE = "dumpType";
constexpr const char* FUNC_NAME_ACL_DUMP_REG_CALLBACK = "acldumpRegCallback";
constexpr const char* FUNC_ACL_DUMP_REG_CALLBACK_PARAM_CLBK = "messageCallback";
constexpr const char* FUNC_ACL_DUMP_REG_CALLBACK_PARAM_FLAG = "flag";
constexpr const char* FUNC_NAME_ACL_DUMP_SAVE_EXCEPTION_INFO = "acldumpSaveExceptionInfo";
constexpr const char* FUNC_ACL_DUMP_SAVE_EXCEPTION_INFO_PARAM_FILENAME = "fileName";
constexpr const char* FUNC_ACL_DUMP_SAVE_EXCEPTION_INFO_PARAM_TENSORS = "tensors";
constexpr const char* FUNC_ACL_DUMP_SAVE_EXCEPTION_INFO_PARAM_TENSORCOUNT = "tensorCount";
constexpr const char* FUNC_NAME_ACL_DUMP_GET_EXCEPTION_INFO_PATH = "acldumpGetExceptionInfoPath";
constexpr const char* FUNC_ACL_DUMP_GET_EXCEPTION_INFO_PATH_PARAM_PATH = "path";
constexpr const char* FUNC_ACL_DUMP_GET_EXCEPTION_INFO_PATH_PARAM_MAXLEN = "maxLen";
} // namespace Adx

#endif
