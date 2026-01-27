/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ANALYSIS_DVVP_DEVICE_COLLECTION_ENGINE_H
#define ANALYSIS_DVVP_DEVICE_COLLECTION_ENGINE_H

#include <memory>
#include <string>
#include <vector>
#include "ai_drv_dev_api.h"
#include "ai_drv_prof_api.h"
#include "message/prof_params.h"
#include "prof_channel.h"
#include "prof_msg_handler.h"
#include "prof_timer.h"
#include "transport/transport.h"
#include "collection_register.h"

namespace analysis {
namespace dvvp {
namespace device {
class CollectEngine {
public:
    CollectEngine();
    virtual ~CollectEngine();
    int32_t Init(int32_t devId = -1);
    int32_t Uinit();
    void SetDevIdOnHost(int32_t devIdOnHost);

    int32_t CollectStart(const std::string &sampleConfig,
                     analysis::dvvp::message::StatusInfo &status);

    int32_t CollectStop(analysis::dvvp::message::StatusInfo &status);

    int32_t CollectStartReplay(SHARED_PTR_ALIA<std::vector<std::string> > ctrlCpuEvent,
                           analysis::dvvp::message::StatusInfo &status,
                           SHARED_PTR_ALIA<std::vector<std::string> > llcEvent);
    int32_t CollectRegister(analysis::dvvp::message::StatusInfo &status);
    int32_t CollectStopReplay(analysis::dvvp::message::StatusInfo &status);
    int32_t CollectStopJob(analysis::dvvp::message::StatusInfo &status);

private:
    int32_t CreateTmpDir(std::string &tmp);
    int32_t CleanupResults();
    std::string BindFileWithChannel(const std::string &fileName, uint32_t channelId);
    void CreateCollectionJobArray();
    int32_t InitBeforeCollectStart(const std::string &sampleConfig,
        analysis::dvvp::message::StatusInfo &status);

    int32_t CheckPmuEventIsValid(SHARED_PTR_ALIA<std::vector<std::string> > ctrlCpuEvent,
        SHARED_PTR_ALIA<std::vector<std::string> > llcEvent);

    SHARED_PTR_ALIA<analysis::dvvp::transport::ITransport> _transport;
    std::string _sample_config;
    SHARED_PTR_ALIA<Analysis::Dvvp::JobWrapper::CollectionJobCommonParams> collectionJobCommCfg_;
    std::array<Analysis::Dvvp::JobWrapper::CollectionJobT,
        Analysis::Dvvp::JobWrapper::NR_MAX_COLLECTION_JOB> collectionJobV_;
    volatile bool _is_stop;
    bool isInited_;
    std::string tmpResultDir_;
    volatile bool _is_started;
    static std::mutex staticMtx_;
};
}  // namespace device
}  // namespace dvvp
}  // namespace analysis

#endif
