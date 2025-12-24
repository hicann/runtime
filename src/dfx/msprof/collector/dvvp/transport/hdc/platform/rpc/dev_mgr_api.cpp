/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "transport/hdc/dev_mgr_api.h"
#include "logger/msprof_dlog.h"
#include "transport/hdc/device_transport.h"
#include "utils/utils.h"

namespace analysis {
namespace dvvp {
namespace transport {
void LoadDevMgrAPI(DevMgrAPI &devMgrAPI)
{
    MSPROF_LOGI("LoadDevMgrAPI init begin");
    devMgrAPI.pfDevMgrInit = &DevTransMgr::InitDevTransMgr;
    devMgrAPI.pfDevMgrUnInit = &DevTransMgr::UnInitDevTransMgr;
    devMgrAPI.pfDevMgrCloseDevTrans = &DevTransMgr::CloseDevTrans;
    devMgrAPI.pfDevMgrGetDevTrans = &DevTransMgr::GetDevTrans;
    MSPROF_LOGI("LoadDevMgrAPI init end");
}
}}}