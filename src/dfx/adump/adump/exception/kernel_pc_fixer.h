/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef KERNEL_PC_FIXER_H
#define KERNEL_PC_FIXER_H

#include <cstdint>
#include <memory>
#include <string>
#include <vector>

namespace Adx {

struct PcFixEntry {
    uint32_t errInfoRegNum;
    uint64_t srcMask;
    uint64_t dstMask;
};

struct PcFixGroup {
    uint32_t moduleId;
    uint32_t aicErrMask;
    std::vector<PcFixEntry> entries;
};

class PcFixerInterface {
public:
    PcFixerInterface() = default;
    virtual ~PcFixerInterface() = default;

    uint64_t FixPc(uint64_t pc, const uint32_t errReg[], size_t errRegLen);
    virtual std::string GetErrorRegisters(const uint32_t errReg[], size_t errRegLen) const = 0;

protected:
    uint32_t errStartIdx_{0};
    uint32_t errCount_{0};
    std::vector<std::vector<PcFixGroup>> table_;

    static void ReplacePcBits(uint64_t& pc, uint32_t regValue, uint64_t srcMask, uint64_t dstMask);
    std::vector<const PcFixGroup*> GetMatchedGroups(const uint32_t errReg[], size_t errRegLen) const;
    virtual std::string GetModuleName(uint32_t moduleId) const = 0;
};

class CloudV2PcFixer : public PcFixerInterface {
public:
    CloudV2PcFixer();
    std::string GetErrorRegisters(const uint32_t errReg[], size_t errRegLen) const override;

private:
    std::string GetModuleName(uint32_t moduleId) const override;
};

class CloudV4PcFixer : public PcFixerInterface {
public:
    CloudV4PcFixer();
    std::string GetErrorRegisters(const uint32_t errReg[], size_t errRegLen) const override;

private:
    std::string GetModuleName(uint32_t moduleId) const override;
};

class CloudV5PcFixer : public PcFixerInterface {
public:
    CloudV5PcFixer();
    std::string GetErrorRegisters(const uint32_t errReg[], size_t errRegLen) const override;

private:
    std::string GetModuleName(uint32_t moduleId) const override;
};

class PcFixerFactory {
public:
    static PcFixerInterface* GetInstance();

private:
    static std::unique_ptr<PcFixerInterface> instance_;
};

} // namespace Adx

#endif // KERNEL_PC_FIXER_H
