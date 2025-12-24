/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "rpc_device_manager_stub.h"
#include "errno/error_code.h"
#include "msprof_stub.h"

namespace analysis {
namespace dvvp {
namespace transport {
using namespace analysis::dvvp::common::error;

int pfDevMgrInitStub(std::string /* jobId */, int /* devId */, std::string /* mode */, uint32_t /* timeout */)
{
    return PROFILING_SUCCESS;
}

int pfDevMgrUnInitStub()
{
    return PROFILING_SUCCESS;
}

int pfDevMgrCloseDevTransStub(std::string /* jobId */, int /* devId */)
{
    return PROFILING_SUCCESS;
}

std::shared_ptr<IDeviceTransport> pfDevMgrGetDevTransStub(std::string /* jobId */, int /* devId */)
{
    return nullptr;
}

void LoadDevMgrAPI(DevMgrAPI &devMgrAPI)
{
    MSPROF_LOGI("LoadDevMgrAPI init begin");
    devMgrAPI.pfDevMgrInit = &pfDevMgrInitStub;
    devMgrAPI.pfDevMgrUnInit = &pfDevMgrUnInitStub;
    devMgrAPI.pfDevMgrCloseDevTrans = &pfDevMgrCloseDevTransStub;
    devMgrAPI.pfDevMgrGetDevTrans = &pfDevMgrGetDevTransStub;
    MSPROF_LOGI("LoadDevMgrAPI init end");
}
}
}
}