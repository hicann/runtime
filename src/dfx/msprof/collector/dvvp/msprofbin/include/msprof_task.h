/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef ANALYSIS_DVVP_MSPROFBIN_MSPROF_PROFTASK_H
#define ANALYSIS_DVVP_MSPROFBIN_MSPROF_PROFTASK_H
#include <condition_variable>
#include <memory>
#include <mutex>
#include "thread/thread.h"
#include "message/prof_params.h"
#include "utils/utils.h"
#include "job_adapter.h"
#include "transport/transport.h"
#include "transport/hdc/dev_mgr_api.h"
#include "prof_task.h"
namespace Analysis {
namespace Dvvp {
namespace Msprof {
class MsprofTask : public analysis::dvvp::common::thread::Thread {
public:
    MsprofTask(const int32_t devId,
             SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> param);
    ~MsprofTask() override;

    virtual int32_t Init() = 0;
    virtual int32_t UnInit() = 0;
    virtual void WaitStopReplay();
    virtual void PostStopReplay();
    virtual void PostSyncDataCtrl();
    void Run(const struct error_message::Context &errorContext) override;
    int32_t Stop() override;
    virtual int32_t Wait();
protected:
    void WriteDone();

protected:
    bool isInit_;
    int32_t deviceId_;
    bool isQuited_;
    bool isExited_;
    // stop
    std::mutex mtx_;
    bool isStopReplayReady;
    std::condition_variable cvSyncStopReplay;

    SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params_;
    SHARED_PTR_ALIA<Analysis::Dvvp::JobWrapper::JobAdapter> jobAdapter_;

private:
    int32_t GetHostAndDeviceInfo();
    std::string GetHostTime() const;
    void GenerateFileName(bool isStartTime, std::string &filename);
    int32_t CreateCollectionTimeInfo(std::string collectionTime, bool isStartTime);
    std::string EncodeTimeInfoJson(SHARED_PTR_ALIA<analysis::dvvp::host::CollectionStartEndTime> timeInfo) const;
};

class ProfSocTask : public MsprofTask {
public:
    ProfSocTask(const int32_t deviceId,
             SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> param);
    ~ProfSocTask() override;

public:
    int32_t Init() override;
    int32_t UnInit() override;
};

class ProfRpcTask : public MsprofTask {
public:
    ProfRpcTask(const int32_t deviceId,
             SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> param);
    ~ProfRpcTask() override;

public:
    int32_t Init() override;
    int32_t UnInit() override;
    int32_t Stop() override;
private:
    void PostSyncDataCtrl() override;
    void WaitSyncDataCtrl();

private:
    // data sync
    std::mutex dataSyncMtx_;
    bool isDataChannelEnd_;
    std::condition_variable cvSyncDataCtrl_;
    analysis::dvvp::transport::DevMgrAPI devMgrAPI_;
};
}
}
}
#endif
