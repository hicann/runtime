/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef TOOLS_DUMP_CORE_CHECKER_H
#define TOOLS_DUMP_CORE_CHECKER_H

#include <string>
#include <vector>
#include <fstream>
#include <elf.h>
#include "dump_common.h"

namespace Adx {

class DumpCoreChecker {
public:
    DumpCoreChecker() = default;
    ~DumpCoreChecker() = default;

    bool Load(const std::string& path);
    bool CheckElfHeader();
    bool CheckDevTbl(DevInfo &devInfo);
    bool CheckGlobalMem(const std::vector<std::string>& globalMem, const std::vector<GlobalMemInfo> &globalMemInfo);
    bool CheckGlobalMem(std::string &globalAuxInfo, uint32_t globalAuxInfoindex,
        const std::vector<std::string>& globalMem, const std::vector<GlobalMemInfo> &globalMemInfo);
    bool CheckLocalMem(uint16_t coreId, const std::vector<std::string> &localMemList, const std::vector<LocalMemInfo>& localMemInfo);
    bool CheckLocalMem(uint16_t coreId, std::string &localAuxInfo, uint32_t localAuxInfoIndex,
        const std::vector<std::string> &localMemList, const std::vector<LocalMemInfo>& localMemInfoList);
    template<typename T>
    bool CheckRegisters(uint16_t coreId, uint8_t validFlag);
    template<typename T>
    bool CheckRegisters(std::string &regData, uint32_t size, uint8_t validFlag);

private:
    std::ifstream fileStream_;
    Elf64_Ehdr header_;
    std::vector<Elf64_Shdr> sections_;
    std::string shstrtab_;

};

}
#endif // TOOLS_DUMP_CORE_CHECKER_H