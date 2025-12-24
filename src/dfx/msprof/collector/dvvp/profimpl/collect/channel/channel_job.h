/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef DVVP_COLLECT_JOB_WRAPPER_CHANNEL_JOB_H
#define DVVP_COLLECT_JOB_WRAPPER_CHANNEL_JOB_H
#include "collection_job.h"

namespace Dvvp {
namespace Collect {
namespace JobWrapper {
constexpr int32_t STRING_TO_LONG_WEIGHT = 16;
struct ProfChannelParam {
    ProfChannelParam() : userData(nullptr), dataSize(0), period(0) {}
    void *userData;
    uint32_t dataSize;
    uint32_t period;
};

class ChannelJob : public Analysis::Dvvp::JobWrapper::ICollectionJob {
public:
    ChannelJob();
    ChannelJob(int32_t collectionId, const std::string &name);
    ~ChannelJob() override;
protected:
    int32_t ChannelStart(int32_t devId, int32_t channelId, const ProfChannelParam &param) const;
    void AddReader(int32_t devId, int32_t channelId, const std::string &filePath);
    void RemoveReader(int32_t devId, int32_t channelId) const;

    SHARED_PTR_ALIA<Analysis::Dvvp::JobWrapper::CollectionJobCfg> cfg_;
};
}
}
}
#endif
