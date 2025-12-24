/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef ANALYSIS_DVVP_HOST_DEV_MGR_API_H
#define ANALYSIS_DVVP_HOST_DEV_MGR_API_H
#include <string>
#include "hdc_transport.h"
#include "message/prof_params.h"

namespace analysis {
namespace dvvp {
namespace transport {
class IDeviceTransport;

using PFDevMgrInit = int32_t (*)(const std::string jobId, int32_t devId, const std::string mode, uint32_t timeout);
using PFDevMgrUnInit = int32_t (*)();
using PFDevMgrCloseDevTrans = int32_t (*)(const std::string jobId, int32_t devId);
using PFDevMgrGetDevTrans = SHARED_PTR_ALIA<IDeviceTransport> (*)(const std::string jobId, int32_t devId);

class DevMgrAPI {
public:
    DevMgrAPI()
        : pfDevMgrInit(nullptr),
          pfDevMgrUnInit(nullptr),
          pfDevMgrCloseDevTrans(nullptr),
          pfDevMgrGetDevTrans(nullptr) {}
    virtual ~DevMgrAPI() {}
public:
    PFDevMgrInit pfDevMgrInit;
    PFDevMgrUnInit pfDevMgrUnInit;
    PFDevMgrCloseDevTrans pfDevMgrCloseDevTrans;
    PFDevMgrGetDevTrans pfDevMgrGetDevTrans;
};

extern void LoadDevMgrAPI(DevMgrAPI &devMgrAPI);

class IDeviceTransport {
public:
    virtual ~IDeviceTransport() {}
public:
    virtual int32_t SendMsgAndRecvResponse(const std::string &msg, TLV_REQ_2PTR packet) = 0;
    virtual int32_t HandlePacket(TLV_REQ_PTR packet, analysis::dvvp::message::StatusInfo &status) = 0;
};
}}}

#endif
