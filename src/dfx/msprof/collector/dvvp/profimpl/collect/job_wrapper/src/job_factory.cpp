/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "job_factory.h"
#include "job_device_soc.h"


namespace Analysis {
namespace Dvvp {
namespace JobWrapper {
using namespace Analysis::Dvvp::JobWrapper;

JobFactory::JobFactory()
{
}

JobFactory::~JobFactory()
{
}

JobSocFactory::JobSocFactory()
{}
JobSocFactory::~JobSocFactory()
{}

SHARED_PTR_ALIA<JobAdapter> JobSocFactory::CreateJobAdapter(int32_t devIndexId) const
{
    SHARED_PTR_ALIA<JobDeviceSoc> job = nullptr;
    MSVP_MAKE_SHARED1(job, JobDeviceSoc, devIndexId, return nullptr);
    return job;
}
}}}