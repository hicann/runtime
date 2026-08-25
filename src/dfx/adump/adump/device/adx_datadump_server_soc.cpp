/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "adx_datadump_server_soc.h"
#include "adx_datadump_server.h"
#include "component/adx_server_manager.h"
#include "epoll/adx_sock_epoll.h"
#include "commopts/sock_comm_opt.h"
#include "log/adx_log.h"
#include "adx_dump_record.h"
namespace Adx {
int32_t AdxSocDataDumpInit(const std::string& hostPid)
{
    // soc case, pass host pid to record instance
    int ret = AdxDumpRecord::Instance().Init(hostPid);
    if (ret != IDE_DAEMON_OK) {
        IDE_LOGE("AdxDumpRecord init failed.");
        return IDE_DAEMON_ERROR;
    }
    ret = AdxDumpRecord::Instance().StartRecord();
    if (ret != IDE_DAEMON_OK) {
        IDE_LOGE("start dump record thread failed.");
        return IDE_DAEMON_ERROR;
    }
    IDE_LOGI("Adx soc dump thread has been started.");
    return IDE_DAEMON_OK;
}

int32_t AdxSocDataDumpUnInit()
{
    IDE_LOGI("start to do soc dump uninit");
    return AdxDumpRecord::Instance().UnInit();
}
} // namespace Adx

#if !defined(__IDE_UT) && !defined(__IDE_ST)
/**
 * @brief      stub for init in soc case, real init
 *             in constructor function
 *
 * @return
 *      IDE_DAEMON_OK: datadump server init success
 */
int32_t AdxDataDumpServerInit() { return IDE_DAEMON_OK; }

/**
 * @brief      stub for uninit in soc case, real uninit
 *             in destructor function
 *
 * @return
 *      IDE_DAEMON_OK: datadump server uninit success
 */
int32_t AdxDataDumpServerUnInit() { return IDE_DAEMON_OK; }
#endif
