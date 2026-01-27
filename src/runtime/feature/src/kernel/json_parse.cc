/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "json_parse.hpp"
#include "utils.h"
#include <fstream>
#include <string>

namespace cce {
namespace runtime {

rtError_t GetJsonObj(const std::string &path, std::string &jsonFileRealPath, 
                            nlohmann::json &kernelJsonObj)
{
    // json file have the same name with binary file. binary file suffix is .o, json file suffix is .json
    std::string jsonFilePath;
    const auto dotPos = path.find_last_of(".");
    if (dotPos != std::string::npos) {
        jsonFilePath = path.substr(0, dotPos);
    }
    jsonFilePath = jsonFilePath + ".json";

    jsonFileRealPath = RealPath(jsonFilePath);
    if (jsonFileRealPath.empty()) {
        return RT_ERROR_INVALID_VALUE;
    }

    std::ifstream f(jsonFileRealPath);
    try {
        kernelJsonObj = nlohmann::json::parse(f);
    } catch (nlohmann::json::exception &e) {
        RT_LOG(RT_LOG_ERROR, "Parse kenerl json file=[%s] failed, because %s.", jsonFileRealPath.c_str(), e.what());
        return RT_ERROR_INVALID_VALUE;
    }

    return RT_ERROR_NONE;
}

void GetCpuKernelFromJson(const nlohmann::json &jsonObj, std::vector<CpuKernelInfo> &kernelInfos)
{
    CpuKernelInfo kernelInfo{};
    for (auto &op : jsonObj.items()) {
        auto value = op.value();
        if (!value.contains("opInfo")) {
            RT_LOG(RT_LOG_WARNING, "opInfo does not exist, continue");
            continue;
        }

        kernelInfo.key = op.key();
        kernelInfo.funcName = "";
        kernelInfo.kernelSo = "";
        kernelInfo.opKernelLib = "";
        kernelInfo.isUserDefined = false;
        kernelInfo.hasOpKernelLib = false;

        auto opInfo = value["opInfo"];
        if (opInfo.contains("functionName")) {
            kernelInfo.funcName = opInfo["functionName"].get<std::string>();
        } else {
            // 当前识别TF算子可以没有functionName
            RT_LOG(RT_LOG_WARNING, "functionName does not exist, key=%s.");
        }
        if (opInfo.contains("kernelSo")) {
            kernelInfo.kernelSo = opInfo["kernelSo"].get<std::string>();
        } else {
            RT_LOG(RT_LOG_WARNING, "kernelSo does not exist.");
        }

        if (opInfo.contains("opKernelLib")) {
            kernelInfo.hasOpKernelLib = true;
            kernelInfo.opKernelLib = opInfo["opKernelLib"].get<std::string>();
        }
        if (opInfo.contains("userDefined") && (opInfo["userDefined"].get<std::string>() == "True")) {
            kernelInfo.isUserDefined = true;
        }

        kernelInfos.push_back(kernelInfo);
    }
    return;
}

}
}