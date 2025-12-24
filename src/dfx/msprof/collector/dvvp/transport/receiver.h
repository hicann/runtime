/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ANALYSIS_DVVP_DEVICE_RECEIVER_H
#define ANALYSIS_DVVP_DEVICE_RECEIVER_H

#include "message/codec.h"
#include "message/dispatcher.h"
#include "prof_msg_handler.h"
#include "prof_job_handler.h"
#include "thread/thread.h"
#include "transport/hdc/adx_transport.h"

namespace analysis {
namespace dvvp {
namespace device {
class Receiver : public analysis::dvvp::common::thread::Thread {
public:
    explicit Receiver(SHARED_PTR_ALIA<analysis::dvvp::transport::AdxTransport> transport);
    virtual ~Receiver();

public:
    int32_t Init(int32_t devId);
    int32_t Uinit();
    const SHARED_PTR_ALIA<analysis::dvvp::transport::AdxTransport> GetTransport();
    int32_t SendMessage(SHARED_PTR_ALIA<google::protobuf::Message> message);
    void SetDevIdOnHost(int32_t devIdOnHost);
protected:
    void Run(const struct error_message::Context &errorContext);

private:
    SHARED_PTR_ALIA<analysis::dvvp::message::MsgDispatcher> dispatcher_;
    SHARED_PTR_ALIA<analysis::dvvp::transport::AdxTransport> transport_;
    int32_t devId_;
    int32_t devIdOnHost_;
    volatile bool inited_;
};
}  // namespace device
}  // namespace dvvp
}  // namespace analysis

#endif
