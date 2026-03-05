/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef KERNEL_DFX_DUMPER_H
#define KERNEL_DFX_DUMPER_H
#include <string>
#include <vector>
#include "rt_inner_dfx.h"
#include "bound_queue_memory.h"
#include "common/singleton.h"
#include "dump_config_converter.h"

namespace Adx {
struct DumpDfxInfo {
    std::string path;
    std::shared_ptr<uint8_t> data;
    uint32_t length;
};

void DumpKernelDfxInfoCallback(rtKernelDfxInfoType dfxType, uint32_t coreType, uint32_t coreId,
                               const uint8_t *buffer, size_t length);

class KernelDfxDumper : public Adx::Common::Singleton::Singleton<KernelDfxDumper> {
public:
    KernelDfxDumper();
    ~KernelDfxDumper() override;
    int32_t InitTask();
    int32_t UnInitTask();
    void UnInit();
    void EnableDfxDumper();
    int32_t EnableDfxDumper(const DumpDfxConfig config);
    void RecordDfxInfo();
    int32_t DumpKernelDfxInfo(rtKernelDfxInfoType dfxType, uint32_t coreType, uint32_t coreId,
        const uint8_t *buffer, size_t length);
private:
    int32_t PushDfxInfoToQueue(DumpDfxInfo &dfxInfo);
    void RecordDfxInfoToDisk(DumpDfxInfo &dfxInfo);
    bool InitDumpPath(const std::string &dumpPath);
    std::string GetDfxTypeStr(const rtKernelDfxInfoType rtDfxType);
    std::string GetCoreTypeStr(uint32_t coreType);
    void GetRegisterDfxTypes(const std::vector<std::string> &cfgDfxTypes, std::set<rtKernelDfxInfoType> &rtDfxTypes);
    bool IsEnabled();
    bool IsEnabled(const rtKernelDfxInfoType dfxType);
    std::string GetDfxInfoFilePath(uint32_t coreId, std::string &coreType);
    std::set<rtKernelDfxInfoType> enabledDfxTypes_;
    std::string dumpPath_;
    bool taskInit_ = false;
    bool taskRunning_ = false;
    BoundQueueMemory<DumpDfxInfo> dumpDfxInfoQueue_;
};
} // namespace Adx
#endif // KERNEL_DFX_DUMPER_H