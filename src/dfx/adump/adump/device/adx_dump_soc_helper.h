/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ADX_DUMP_SOC_HELPER_H
#define ADX_DUMP_SOC_HELPER_H
#include <string>
#include <map>
#include <atomic>
#include "common/singleton.h"
#include "adump_device_pub.h"
namespace Adx {
const IDE_SESSION DEFAULT_SOC_SESSION = reinterpret_cast<IDE_SESSION>(0xFFFF0000);
class AdxDumpSocHelper : public Adx::Common::Singleton::Singleton<AdxDumpSocHelper> {
public:
    AdxDumpSocHelper();
    ~AdxDumpSocHelper() override;
    bool Init(const std::string &hostPid);
    void UnInit();
    IdeErrorT ParseConnectInfo(const std::string &connectInfo) const;
    IdeErrorT HandShake(const std::string &info, IDE_SESSION &session) const;
    IdeErrorT DataProcess(const IDE_SESSION &session, const IdeDumpChunk &dumpChunk) const;
    IdeErrorT Finish(IDE_SESSION &session) const;
private:
    std::atomic_flag init_ = ATOMIC_FLAG_INIT;
};
IDE_SESSION SocDumpStart(const char *connectInfo);
IdeErrorT SocDumpData(const IDE_SESSION session, const IdeDumpChunk *dumpChunk);
IdeErrorT SocDumpEnd(IDE_SESSION session);
}
#endif