/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <string>
#include <string.h>
#include "data_report.h"
#include "prof_api.h"
#include "msprof_stub.h"

namespace Cann {
namespace Dvvp {
namespace Test {
bool DataReport::CheckPoint(int32_t value)
{
    if (value == 0) {
        return true;
    }
    return false;
}

int32_t DataReport::InitReport()
{
    int32_t ret = MsprofReportData(moduleId_, MSPROF_REPORTER_INIT, nullptr, 0U);
    if (!CheckPoint(ret)) {
        MSPROF_LOGE("MSPROF_REPORTER_INIT Failed, ret = %d.", ret);
        return REPORT_FAILED;
    }

    return REPORT_SUCCESS;
}

int32_t DataReport::StartReport()
{
    const char* testStr[] = {"report","test"};
    std::string tagStr = "test";
    ReportDataTest reporterData{};
    reporterData.dataLen = sizeof(testStr) / sizeof(char *);
    reporterData.data = reinterpret_cast<uint8_t *>(const_cast<char **>(testStr));
    strcpy(reporterData.tag, tagStr.c_str());

    int32_t ret = MsprofReportData(moduleId_, MSPROF_REPORTER_REPORT, static_cast<void *>(&reporterData), static_cast<uint32_t>(sizeof(ReportDataTest)));
    if (!CheckPoint(ret)) {
        MSPROF_LOGE("MSPROF_REPORTER_REPORT Failed, ret = %d.", ret);
        return REPORT_FAILED;
    }

    return REPORT_SUCCESS;
}

int32_t DataReport::HashReport()
{
    const std::string &hashStr = std::to_string(moduleId_);
    HashDataTest hashData{};
    hashData.dataLen = hashStr.size();
    hashData.data = reinterpret_cast<uint8_t *>(const_cast<char *>(hashStr.c_str()));

    int32_t ret = MsprofReportData(moduleId_, MSPROF_REPORTER_HASH, static_cast<void *>(&hashData), static_cast<uint32_t>(sizeof(HashDataTest)));
    if (!CheckPoint(ret)) {
        MSPROF_LOGE("MSPROF_REPORTER_REPORT Failed, ret = %d.", ret);
        return REPORT_FAILED;
    }

    return REPORT_SUCCESS;
}

int32_t DataReport::MaxLenReport()
{
    uint32_t reporter_max_len_{1U};

    int32_t ret = MsprofReportData(moduleId_, MSPROF_REPORTER_DATA_MAX_LEN, &reporter_max_len_, static_cast<uint32_t>(sizeof(uint32_t)));
    if (!CheckPoint(ret)) {
        MSPROF_LOGE("MSPROF_REPORTER_DATA_MAX_LEN Failed, ret = %d.", ret);
        return REPORT_FAILED;
    }
    return REPORT_SUCCESS;
}

int32_t DataReport::StopReport()
{
    int32_t ret = MsprofReportData(moduleId_, MSPROF_REPORTER_UNINIT, nullptr, 0U);
    if (!CheckPoint(ret)) {
        MSPROF_LOGE("MSPROF_REPORTER_UNINIT Failed, ret = %d.", ret);
        return REPORT_FAILED;
    }
    return REPORT_SUCCESS;
}

}
}
}