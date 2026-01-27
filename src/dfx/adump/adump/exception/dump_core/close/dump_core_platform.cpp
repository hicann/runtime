/**

 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "dump_core.h"
#include "log/adx_log.h"
#include "adump_dsmi.h"

namespace Adx {
void DumpCore::DumpRegister(uint8_t coreType, uint16_t coreId)
{
    uint32_t platform = 0;
    IDE_CTRL_VALUE_FAILED(AdumpDsmi::DrvGetPlatformType(platform), return, "Get platform type failed");
    switch (static_cast<PlatformType>(platform)) {
        case PlatformType::CHIP_CLOUD_V2:
            DumpV2Register(coreType, coreId);
            break;
        case PlatformType::CHIP_CLOUD_V4:
            DumpV4Register(coreType, coreId);
            break;
        default:
            break;
    }
}

void DumpCore::DumpV4Register(uint8_t coreType, uint16_t coreId)
{
    std::vector<RegInfoWide> regData;
    std::string sectionName = ASCEND_SHNAME_REGS + "." + std::to_string(ConvertCoreId(coreType, coreId));
    std::shared_ptr<RegisterInterface> reg = RegisterManager::GetInstance().GetRegister();
    IDE_CTRL_VALUE_FAILED(reg != nullptr, return, "Get register failed, null register.");
    for (const auto &regType: reg->GetRegisterTypes(coreType)) {
        DumpV4DebugRegister(coreType, coreId, reg->GetRegisterTable(regType), regData);
    }

    size_t totalSize = regData.size() * sizeof(RegInfoWide);
    std::string data(reinterpret_cast<const char *>(regData.data()), totalSize);
    ELF::SectionPtr registerSection = coreFile_.AddSection(ASCEND_SHTYPE_REGS, sectionName);
    IDE_CTRL_VALUE_FAILED(registerSection != nullptr, return, "Create %s section failed.", sectionName.c_str());
    registerSection->SetData(data);
    registerSection->SetEntSize(sizeof(RegInfoWide));
}

void DumpCore::DumpV4DebugRegister(uint8_t coreType, uint16_t coreId, const std::vector<RegisterTable> &tables,
    std::vector<RegInfoWide> &regData) const
{
    std::string data;
    std::stringstream ss;
    ss << "v4 Debug register data. coreType:" << static_cast<int32_t>(coreType) << ", coreId:" << coreId << ".";
    bool dataValid = true;
    for (const RegisterTable &table : tables) {
        dataValid = DumpReadDebugAICoreRegister(coreType, coreId, table, data);
        errno_t err = EOK;
        const char *dataPtr = data.data();
        for (uint32_t i = 0; i < table.num; ++i) {
            RegInfoWide regInfo{table.startAddr + i, REG_DATA_VALID, {0}, table.byteWith, {0}};
            if (dataValid) {
                err = memcpy_s(&regInfo.value, sizeof(regInfo.value), dataPtr, table.byteWith);
                if (err != EOK) {
                    IDE_LOGE("Failed to copy v4 debug register data from cache buffer. "
                        "coreType: %hhu, coreId: %hu, addr: 0x%llx, ret: %d",
                        coreType, coreId, regInfo.addr, err);
                    regInfo.validFlag = REG_DATA_INVALID;
                } else {
                    std::string value = FormatRegisterData(regInfo.value, regInfo.regSize);
                    ss << " 0x" << std::hex << regInfo.addr << ": " << value << ",";
                }
            } else {
                regInfo.validFlag = REG_DATA_INVALID;
            }
            dataPtr += table.byteWith;
            regData.emplace_back(regInfo);
        }
    }
    IDE_LOGI("%s", ss.str().c_str());
}

uint16_t DumpCore::ConvertCoreId(uint8_t coreType, uint16_t coreId) const
{
    uint32_t platform = 0;
    (void)AdumpDsmi::DrvGetPlatformType(platform);
    switch (static_cast<PlatformType>(platform)) {
        case PlatformType::CHIP_CLOUD_V2:
            return (coreType == CORE_TYPE_AIC) ? coreId : static_cast<uint16_t>(CORE_SIZE_AIC + coreId);
        case PlatformType::CHIP_CLOUD_V4:
            return (coreType == CORE_TYPE_AIC) ? coreId : static_cast<uint16_t>(CORE_SIZE_AIC_DAVID + coreId);
        default:
            break;
    }
    return coreId;
}
}  // namespace Adx
