/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef LOG_GET_FILE_COMPONENT_H
#define LOG_GET_FILE_COMPONENT_H
#include <vector>
#include <map>
#include "adx_component.h"
namespace Adx {
class LogGetFile : public AdxComponent {
public:
    ~LogGetFile() override {}
    int32_t Init() override;
    const std::string GetInfo() override
    {
        return "TransferFile";
    }
    ComponentType GetType() override
    {
        return ComponentType::COMPONENT_GETD_FILE;
    }
    int32_t Process(const CommHandle &handle, const std::shared_ptr<MsgProto> &proto) override;
    int32_t UnInit() override;
private:
    int32_t TransferProcess(const CommHandle &handle, const std::string &logType,
                            const std::string &src, const std::string &des) const;
    int32_t TransferFile(const CommHandle &handle, const std::string &logType,
                         const std::string &filePath, int32_t pid) const;
    int32_t ExportModuleInfo(const std::string &logType, int32_t pid) const;
    int32_t GetFileList(const std::string &path, std::vector<std::string> &list, int32_t pid);
    int32_t GetPathPrefix(const std::string &tmpFilePath, std::string &matchStr, int32_t pid) const;
    bool IsValidMessageFile(std::string &messagesFilePath) const;
    int32_t CopyFileToUserDir(std::string &messagesFilePath, int32_t pid) const;
    bool IsIntDigital(const std::string &digital) const;
    bool IsValidLogType(const std::string &logType) const;
    bool IsValidTmpFilePath(const std::string &tmpFilePath, std::string &matchStr, int32_t pid) const;
    int32_t GetMappingPid(int32_t pid) const;
    void ClearTmpDir(std::string &logType, int32_t pid);
private:
    int32_t mappingNum_;
    using intMap = std::map<int32_t, int32_t>;
    static intMap g_numToPid;
};
}
#endif