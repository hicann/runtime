/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <sstream>
#include <iomanip>
#include "log/adx_log.h"
#include "runtime/mem.h"
#include "adump_dsmi.h"
#include "register_config.h"
#include "exception_info_common.h"
#include "dump_core.h"

namespace Adx {
constexpr int32_t REG_FIELD_WIDTH  = 2;

std::string DumpCore::FormatRegisterData(const uint8_t *valAddr, uint8_t valSize) const
{
    std::stringstream ss;
    ss << std::hex << std::setfill('0');
    for (uint8_t i = 0; i < valSize; ++i) {
        ss << " " << std::setw(REG_FIELD_WIDTH) << static_cast<uint32_t>(valAddr[i]);
    }
    return ss.str();
}

bool DumpCore::DumpReadDebugAICoreRegister(uint8_t coreType, uint16_t coreId, const RegisterTable &table,
    std::string &data) const
{
    data.clear();
    data.reserve(table.num * table.byteWith);
    rtDebugMemoryParam_t param = {coreType, 0, coreId, RT_MEM_TYPE_REGISTER, 0, 0, 0, 0, 0};
    param.srcAddr = table.startAddr;
    param.dstAddr = reinterpret_cast<uint64_t>(data.data());
    param.memLen = table.num * table.byteWith;
    param.elementSize = table.byteWith;
    rtError_t ret = rtDebugReadAICore(&param);
    if (ret != RT_ERROR_NONE) {
        IDE_LOGE("Failed to read debug register data. coreType: %hhu, coreId: %hu, start addr: 0x%llx, "
            "num: %u, byteWith: %hhu, ret: %d",
            coreType, coreId, param.srcAddr, table.num, table.byteWith, static_cast<int32_t>(ret));
        return false;
    }
    return true;
}

void DumpCore::DumpV2Register(uint8_t coreType, uint16_t coreId)
{
    std::vector<RegInfo> regData;
    std::string sectionName = ASCEND_SHNAME_REGS + "." + std::to_string(ConvertCoreId(coreType, coreId));
    std::shared_ptr<RegisterInterface> reg = RegisterManager::GetInstance().GetRegister();
    IDE_CTRL_VALUE_FAILED(reg != nullptr, return, "Get register failed, null register.");
    for (const auto &regType : reg->GetRegisterTypes(coreType)) {
        DumpV2DebugRegister(coreType, coreId, reg->GetRegisterTable(regType), regData);
    }
    DumpV2ErrorRegister(coreType, coreId, reg->GetErrorRegisterTable(), regData);

    size_t totalSize = regData.size() * sizeof(RegInfo);
    std::string data(reinterpret_cast<const char *>(regData.data()), totalSize);
    ELF::SectionPtr registerSection = coreFile_.AddSection(ASCEND_SHTYPE_REGS, sectionName);
    IDE_CTRL_VALUE_FAILED(registerSection != nullptr, return, "Create %s section failed.", sectionName.c_str());
    registerSection->SetData(data);
    registerSection->SetEntSize(sizeof(RegInfo));
}

void DumpCore::DumpV2DebugRegister(uint8_t coreType, uint16_t coreId, const std::vector<RegisterTable> &tables,
    std::vector<RegInfo> &regData) const
{
    std::string data;
    std::stringstream ss;
    ss << "Debug register data. coreType:" << static_cast<int32_t>(coreType) << ", coreId:" << coreId << ".";
    bool dataValid = true;
    for (const RegisterTable &table : tables) {
        dataValid = DumpReadDebugAICoreRegister(coreType, coreId, table, data);
        errno_t err = EOK;
        const char *dataPtr = data.data();
        for (uint32_t i = 0; i < table.num; ++i) {
            RegInfo regInfo{table.startAddr + i, REG_DATA_VALID, {0}, table.byteWith, {0}};
            if (dataValid) {
                err = memcpy_s(&regInfo.value, sizeof(regInfo.value), dataPtr, table.byteWith);
                if (err != EOK) {
                    IDE_LOGE("Failed to copy debug register data from cache buffer. "
                        "coreType: %hhu, coreId: %hu, addr: 0x%llx, ret: %d",
                        coreType, coreId, regInfo.addr, err);
                    regInfo.validFlag = REG_DATA_INVALID;
                } else {
                    std::string value = FormatRegisterData(regInfo.value, regInfo.regSize);
                    ss << " 0x" << std::hex << regInfo.addr << ":" << value << ",";
                }
            } else {
                regInfo.validFlag = REG_DATA_INVALID;
            }
            regData.emplace_back(regInfo);
            dataPtr += table.byteWith;
        }
    }
    IDE_LOGI("%s", ss.str().c_str());
}

void DumpCore::DumpV2ErrorRegister(uint8_t coreType, uint16_t coreId, const std::vector<ErrorRegisterTable> &tables,
    std::vector<RegInfo> &regData) const
{
    errno_t err = EOK;
    std::stringstream ss;
    ss << "Error register data. coreType=" << static_cast<int32_t>(coreType) << ", coreId=" << coreId << ".";
    for (uint32_t i = 0; i < exceptionRegInfo_.coreNum; i++) {
        rtExceptionErrRegInfo_t coreErrRegInfo = exceptionRegInfo_.errRegInfo[i];
        if (coreId != coreErrRegInfo.coreId || coreType != coreErrRegInfo.coreType) {
            continue;
        }
        for (const ErrorRegisterTable &table: tables) {
            RegInfo regInfo{table.offsetAddr, REG_DATA_VALID, {0}, table.byteWidth, {0}};
            err = memcpy_s(&regInfo.value, sizeof(regInfo.value), coreErrRegInfo.errReg + table.errIndex,
                table.byteWidth);
            if (err != EOK) {
                IDE_LOGE("Failed to copy error register data from exception args. "
                    "coreType: %hhu, coreId: %hu, addr: 0x%llx, ret: %d",
                    coreType, coreId, regInfo.addr, err);
                regInfo.validFlag = REG_DATA_INVALID;
            } else {
                std::string value = FormatRegisterData(regInfo.value, regInfo.regSize);
                ss << " " << table.name << "[0x" << std::hex << regInfo.addr << "]: " << value << ",";
            }
            regData.emplace_back(regInfo);
        }
    }
    IDE_LOGI("%s", ss.str().c_str());
}
}  // namespace Adx
