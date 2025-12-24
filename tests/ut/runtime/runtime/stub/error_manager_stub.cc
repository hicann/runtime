/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "rt_utest_stub.h"
namespace {
    std::string STAGES_STR = "[TEST][TEST]";
}

ErrorManager &ErrorManager::GetInstance() {
  static ErrorManager instance;
  return instance;
}

void ErrorManager::SetStage(const std::string &firstStage, const std::string &secondStage)
{
    STAGES_STR = '[' + firstStage + "][" + secondStage + ']';
}

const std::string& ErrorManager::GetLogHeader()
{
    return STAGES_STR;
}

int ErrorManager::Init()
{
    return 0;
}

void ErrorManager::ATCReportErrMessage(std::string error_code, const std::vector<std::string> &key,
                                       const std::vector<std::string> &value)
{
    return;
}

std::string ErrorManager::GetErrorMessage()
{
    std::string message = "";
    return message;
}

int ErrorManager::ReportInterErrMessage(std::string error_code, const std::string &error_msg)
{
    return 0;
}

int error_message::FormatErrorMessage(char *str_dst, size_t dst_max, const char *format, ...)
{
    return 1;
}
