/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ANALYSIS_DVVP_HOST_DEVICE_TRANSPORT_H
#define ANALYSIS_DVVP_HOST_DEVICE_TRANSPORT_H

#include <memory>
#include "dev_mgr_api.h"
#include "hdc_transport.h"
#include "message/codec.h"
#include "message/prof_params.h"
#include "singleton/singleton.h"
#include "thread/thread.h"

namespace analysis {
namespace dvvp {
namespace transport {
class DeviceTransport : public IDeviceTransport, public analysis::dvvp::common::thread::Thread {
public:
    DeviceTransport(HDC_CLIENT client,
        const std::string &devId, const std::string &jobId, const std::string &mode);
    ~DeviceTransport() override;

    int32_t Init();
    void CloseConn();
    bool IsInitialized();
    int32_t SendMsgAndRecvResponse(const std::string &msg, TLV_REQ_2PTR packet) override;
    int32_t HandlePacket(TLV_REQ_PTR packet, analysis::dvvp::message::StatusInfo &status) override;
    void SetTimeOut(uint32_t timeout);

protected:
    void Run(const struct error_message::Context &errorContext) override;

private:
    void Uinit();
    SHARED_PTR_ALIA<analysis::dvvp::transport::AdxTransport> CreateConn() const;
    int32_t RecvDataPacket(TLV_REQ_2PTR packet);
    int32_t HandleShake(SHARED_PTR_ALIA<google::protobuf::Message> message, bool ctrlShake);

private:
    HDC_CLIENT client_;
    int32_t devIndexId_;                // for HdcSessionConnect
    std::string devIndexIdStr_;     // for management and log
    std::string jobId_;
    std::string mode_;
    uint32_t timeout_;
    bool dataInitialized_;
    bool ctrlInitialized_;
    bool isClosed_;
    SHARED_PTR_ALIA<analysis::dvvp::transport::AdxTransport> dataTran_;
    SHARED_PTR_ALIA<analysis::dvvp::transport::AdxTransport> ctrlTran_;
    std::mutex ctrlTransMtx_;
};

class DevTransMgr : public analysis::dvvp::common::singleton::Singleton<DevTransMgr> {
    friend analysis::dvvp::common::singleton::Singleton<DevTransMgr>;
public:
    int32_t Init(std::string jobId, int32_t devId, std::string mode, uint32_t timeout);
    int32_t UnInit();
    SHARED_PTR_ALIA<DeviceTransport> GetDevTransport(std::string jobId, int32_t devId);
    int32_t CloseDevTransport(std::string jobId, int32_t devId);

public:
    static int32_t InitDevTransMgr(std::string jobId, int32_t devId, std::string mode, uint32_t timeout)
    {
        return DevTransMgr::instance()->Init(jobId, devId, mode, timeout);
    }
    static int32_t UnInitDevTransMgr()
    {
        return DevTransMgr::instance()->UnInit();
    }
    static int32_t CloseDevTrans(std::string jobId, int32_t devId)
    {
        return DevTransMgr::instance()->CloseDevTransport(jobId, devId);
    }
    static SHARED_PTR_ALIA<IDeviceTransport> GetDevTrans(std::string jobId, int32_t devId)
    {
        return DevTransMgr::instance()->GetDevTransport(jobId, devId);
    }

protected:
    DevTransMgr() {}
    ~DevTransMgr() override
    {
    }

private:
    int32_t DoInit(const std::vector<int32_t> &devIds);

private:
    std::mutex devTarnsMtx_;
    std::map<std::string, std::map<int32_t, SHARED_PTR_ALIA<DeviceTransport> > > devTransMap_;
};
}}}

#endif
