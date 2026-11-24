/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ADX_DUMP_HDC_HELPER_H
#define ADX_DUMP_HDC_HELPER_H
#include "common/singleton.h"
#include "adump_device_pub.h"
#include "commopts/adx_comm_opt_manager.h"
#include "adx_msg_proto.h"
namespace Adx {
class AdxDumpHdcHelper : public Adx::Common::Singleton::Singleton<AdxDumpHdcHelper> {
public:
    AdxDumpHdcHelper();
    ~AdxDumpHdcHelper() override;
    bool Init();
    void UnInit();
    IdeErrorT ParseConnectInfo(const std::string& connectInfo, std::map<std::string, std::string>& proto) const;
    IdeErrorT HandShake(const std::string& info, IDE_SESSION& session) const;
    IdeErrorT DataProcess(const IDE_SESSION& session, const IdeDumpChunk& dumpChunk);
    IdeErrorT Finish(IDE_SESSION& session);

private:
    IdeErrorT SessionIsConnected(const CommHandle handle) const;
    CommHandle MakeClientHandle(const IDE_SESSION& session) const;
    IdeErrorT SendPacket(const CommHandle& handle, const MsgProto& msg) const;
    IdeErrorT RecvDataResponse(const CommHandle& handle) const;
    // CHECKSUPPORT 应答收包与判定折叠（aicpu 只看 IdeDumpData 返回值，位图判定在此代做）
    IdeErrorT RecvCheckSupportResult(const CommHandle& handle, const IdeDumpChunk& dumpChunk);
    bool init_;
    CommHandle client_;
};
IDE_SESSION HdcDumpStart(const char* connectInfo);
IdeErrorT HdcDumpData(const IDE_SESSION session, const IdeDumpChunk* dumpChunk);
IdeErrorT HdcDumpEnd(IDE_SESSION session);
} // namespace Adx
#endif