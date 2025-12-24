/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "msprof_stub.h"
#include "mockcpp/mockcpp.hpp"

#ifdef MSPROF_C
#include "prof_api.h"
#else
#include "prof_cann_plugin.h"
#include "prof_inner_api.h"
#include "errno/error_code.h"
#include "utils/utils.h"
#include "transport/transport.h"
#include "prof_acl_mgr.h"
#include "transport/hash_data.h"
#include "prof_manager.h"
#include "running_mode.h"

using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::utils;
using namespace analysis::dvvp::transport;
using namespace Collector::Dvvp::Msprofbin;
using namespace Analysis::Dvvp::Common::Config;
using namespace Analysis::Dvvp::Msprof;
using namespace Analysis::Dvvp::Common::Platform;
using namespace analysis::dvvp::host;
using namespace Msprofiler::Api;
using namespace ProfAPI;
#endif

void ClearSingleton()
{
#ifndef MSPROF_C
    ConfigManager::instance()->Uninit();
    ConfigManager::instance()->Init();
    Platform::instance()->Uninit();
    Platform::instance()->Init();
    HashData::instance()->Uninit();
    ProfAclMgr::instance()->UnInit();
    ProfManager::instance()->AclUinit();
    ProfCannPlugin::instance()->ProfUnInitReportBuf();
#endif
    return;
}

void MockPerfDir(std::string &dir)
{
#ifndef MSPROF_C
        std::string cmd = "mkdir " + dir;
        system(cmd.c_str());
        MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::GetPerfDataDir)
            .stubs()
            .will(returnValue(dir));
#endif
    return;
}

#ifdef MSPROF_C
// to be implement by c
int LltMain(int argc, const char **argv, const char **envp)
{
    return 0;
}

int LltAcpMain(int argc, const char **argv, const char **envp)
{
    return 0;
}

int32_t MsprofReportData(uint32_t moduleId, uint32_t type, VOID_PTR data, uint32_t len)
{
    return 0;
}

void *aclprofCreateStamp()
{
    return NULL;
}

int32_t MsprofSetDeviceIdByGeModelIdx(const uint32_t geModelIdx, const uint32_t deviceId)
{
    return 0;
}

#endif
