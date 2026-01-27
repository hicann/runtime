/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ANALYSIS_DVVP_DEVICE_COLLECTION_ENTRY_H
#define ANALYSIS_DVVP_DEVICE_COLLECTION_ENTRY_H

#include <memory>
#include <mutex>
#include "collect_engine.h"
#include "message/prof_params.h"
#include "receiver.h"
#include "singleton/singleton.h"
#include "transport/hdc/hdc_transport.h"
#include "uploader.h"

namespace analysis {
namespace dvvp {
namespace device {
class CollectionEntry : public analysis::dvvp::common::singleton::Singleton<CollectionEntry> {
    friend analysis::dvvp::common::singleton::Singleton<CollectionEntry>;

public:
    int32_t Init();
    int32_t Uinit();

    int32_t Handle(SHARED_PTR_ALIA<analysis::dvvp::transport::AdxTransport> transport,
               const std::string &req, int32_t devIndexId);
    int32_t FinishCollection(uint32_t devIdFlush, const std::string &jobId);
    void AddReceiver(const std::string &mode, const std::string &jobId,
                     uint32_t devIndexId, SHARED_PTR_ALIA<Receiver> receiver);
    SHARED_PTR_ALIA<Receiver> GetReceiver(const std::string &jobId, uint32_t devIndexId);
    void DeleteReceiver(const std::string &jobId, uint32_t devIndexId);
    int32_t SendMsgByDevId(const std::string &jobId, uint32_t devIndexId,
        SHARED_PTR_ALIA<google::protobuf::Message> message);

protected:
    CollectionEntry();
    virtual ~CollectionEntry();

private:
    int32_t HandleCtrlSession(SHARED_PTR_ALIA<Receiver> receiver,
                          SHARED_PTR_ALIA<analysis::dvvp::proto::CtrlChannelHandshake> handshake,
                          analysis::dvvp::message::StatusInfo &statusInfo,
                          int32_t devIndexId);
    int32_t HandleDataSession(SHARED_PTR_ALIA<analysis::dvvp::transport::Uploader> uploader,
                          SHARED_PTR_ALIA<analysis::dvvp::proto::DataChannelHandshake> handshake,
                          int32_t devIndexId);

    void AddModeJobIdRelation(uint32_t devId, const std::string &mode, const std::string &jobId);
    std::string GetModeJobIdRelation(uint32_t devId, const std::string &mode);
    std::string DeleteModeJobIdRelation(uint32_t devId, const std::string &mode);

private:
    bool isInited_;
    std::map<std::string, std::map<int32_t, SHARED_PTR_ALIA<Receiver>>> receiverMap_;   // <jobId, <devId, Receiver> >
    std::map<std::string, std::string> modeJobIdRelations_;                         // <devId_mode, jobId>
    std::map<int32_t, int32_t> hostIdMap_;
    std::mutex receiverMtx_;
    std::mutex relatiionMtx_;
};
}  // namespace device
}  // namespace dvvp
}  // namespace analysis

#endif
