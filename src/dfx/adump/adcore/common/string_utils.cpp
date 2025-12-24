/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <cctype>
#include "log/adx_log.h"
#include "string_utils.h"
namespace Adx {
/**
 * @brief Check if is digital
 * @param [in] digital: digital
 * @return
 *        true:   string all digital
 *        false:  string have other char
 */
bool StringUtils::IsIntDigital(const std::string &digital)
{
    if (digital.empty()) {
        return false;
    }

    size_t len = digital.length();
    for (size_t i = 0; i < len; i++) {
        if (!isdigit(digital[i])) {
            return false;
        }
    }
    return true;
}

bool StringUtils::IpValid(const std::string &ipStr)
{
    if (ipStr.empty()) {
        return false;
    }

    std::string checkStr = ipStr;
    size_t num;
    size_t j = 0;
    for (size_t i = 0; i < IP_VALID_PART_NUM; ++i) {
        size_t index = checkStr.find('.', j);
        if (index == std::string::npos) {
            return false;
        }
        try {
            num = std::stoi(checkStr.substr(j, index - j));
        } catch (...) {
            return false;
        }

        if (num > IP_MAX_NUM) {
            return false;
        }
        j = index + 1;
    }
    std::string end = checkStr.substr(j);
    for (size_t i = 0; i < end.length(); ++i) {
        if (end[i] < '0' || end[i] > '9') {
            return false;
        }
    }
    try {
        num = stoi(end);
    } catch (...) {
        return false;
    }
    if (num > IP_MAX_NUM) {
        return false;
    }
    return true;
}

bool StringUtils::ParseConnectInfo(const std::string &connectInfo, std::string &hostId, std::string &hostPid)
{
    std::string connectInfoStr;
    std::string::size_type idx;

    connectInfoStr = connectInfo;

    idx = connectInfoStr.find(";");
    if (idx == std::string::npos) {
        IDE_LOGE("invalid private info %s format, valid format like \"host:port;host_id;host_pid\"", connectInfo.c_str());
        return false;
    }
    IDE_LOGD("info str check host:port;host_id success");

    std::string hostIdHostPidStr = connectInfoStr.substr(idx + 1);
    idx = hostIdHostPidStr.find(";");
    if (idx == std::string::npos) {
        IDE_LOGE("invalid private info %s format, valid format like \"host:port;host_id;host_pid\"", connectInfo.c_str());
        return false;
    }
    IDE_LOGD("info str check host_id;host_pid success");

    hostId = hostIdHostPidStr.substr(0, idx);
    hostPid = hostIdHostPidStr.substr(idx + 1);

    if (!IsIntDigital(hostId)) {
        IDE_LOGE("hostId is not a number, %s", hostId.c_str());
        return false;
    }

    if (!IsIntDigital(hostPid)) {
        IDE_LOGE("hostPid is not a number, %s", hostPid.c_str());
        return false;
    }

    IDE_LOGI("hostId: %s, hostPid: %s", hostId.c_str(), hostPid.c_str());
    IDE_LOGD("info str check host_id and host_pid number format success");
    return true;
}
}
