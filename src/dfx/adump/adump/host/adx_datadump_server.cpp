/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "adx_datadump_server.h"
#include "component/adx_server_manager.h"
#include "ascend_hal.h"
#include "adx_dump_receive.h"
#include "log/adx_log.h"
#include "adx_dump_record.h"
#include "create_func.h"
#include "sys_utils.h"
#include "adump_dsmi.h"
#include "config.h"
using namespace Adx;
namespace {
AdxServerManager g_manager;
IdeThreadArg AdxDataDumpServerProcess(const IdeThreadArg arg)
{
    UNUSED(arg);
    std::unique_ptr<AdxEpoll> epoll(CreateAdxEpoll(EpollType::EPOLL_HDC));
    IDE_CTRL_VALUE_FAILED(epoll != nullptr, return nullptr, "create epoll error");
    std::unique_ptr<AdxComponent> cpn(new (std::nothrow)AdxDumpReceive());
    IDE_CTRL_VALUE_FAILED(cpn != nullptr, return nullptr, "create component error");
    std::unique_ptr<AdxCommOpt> opt(CreateAdxCommOpt(OptType::COMM_HDC));
    IDE_CTRL_VALUE_FAILED(opt != nullptr, return nullptr, "create commopt error");
    bool ret = g_manager.RegisterEpoll(epoll);
    IDE_CTRL_VALUE_FAILED(ret, return nullptr, "register epoll error");
    ret = g_manager.RegisterCommOpt(opt, std::to_string(HDC_SERVICE_TYPE_DUMP));
    IDE_CTRL_VALUE_FAILED(ret, return nullptr, "register commopt error");
    ret = g_manager.ComponentAdd(cpn);
    IDE_CTRL_VALUE_FAILED(ret, return nullptr, "component add error");
    ret = g_manager.ComponentInit();
    IDE_CTRL_VALUE_FAILED(ret, return nullptr, "component Init error");
    g_manager.SetThreadName(std::string("adx_data_dump_thread"));
    g_manager.Start();
    (void)g_manager.Join();
    return nullptr;
}

IdeThreadArg AdxDumpRecordProcess(const IdeThreadArg arg)
{
    UNUSED(arg);
    AdxDumpRecord::Instance().RecordDumpInfo();
    return nullptr;
}

static bool IsOnDeviceSide()
{
    uint32_t platformInfo = static_cast<uint32_t>(SysPlatformType::INVALID);
    bool ret = AdumpDsmi::DrvGetPlatformInfo(platformInfo);
    if (ret && (platformInfo == static_cast<uint32_t>(SysPlatformType::DEVICE))) {
        return true;
    }
    return false;
}
}

int32_t AdxDataDumpServerInit()
{
    std::string hostPid;
    ADX_GET_ENV(MM_ENV_ASCEND_HOSTPID, hostPid);
    if (IsOnDeviceSide() && !hostPid.empty()) {
        IDE_LOGI("dump server not start on helper device");
        return IDE_DAEMON_OK;
    }
    int32_t dumpNum = AdxDumpRecord::Instance().GetDumpInitNum();
    if (dumpNum > 0) {
        AdxDumpRecord::Instance().UpdateDumpInitNum(true);
        IDE_LOGI("dump init process has already been called, dumpNum : %d", dumpNum);
        return IDE_DAEMON_OK;
    }
    IDE_LOGI("start to do dump init");
    AdxDumpRecord::Instance().UpdateDumpInitNum(true);
    mmUserBlock_t funcBlock;
    funcBlock.procFunc = AdxDataDumpServerProcess;
    funcBlock.pulArg = nullptr;
    mmThread tid = 0;
    // non-soc case, no need to pass host pid
    int32_t ret = AdxDumpRecord::Instance().Init("");
    if (ret != IDE_DAEMON_OK) {
        IDE_LOGE("AdxDumpRecord init failed.");
        return IDE_DAEMON_ERROR;
    }
    ret = Thread::CreateDetachTaskWithDefaultAttr(tid, funcBlock);
    if (ret != EN_OK) {
        return IDE_DAEMON_ERROR;
    }
    funcBlock.procFunc = AdxDumpRecordProcess;
    funcBlock.pulArg = nullptr;
    ret = Thread::CreateDetachTaskWithDefaultAttr(tid, funcBlock);
    (void)g_manager.WaitServerInitted();
    return (ret != EN_OK) ? IDE_DAEMON_ERROR : IDE_DAEMON_OK;
}

int32_t AdxDataDumpServerUnInit()
{
    std::string hostPid;
    ADX_GET_ENV(MM_ENV_ASCEND_HOSTPID, hostPid);
    if (IsOnDeviceSide() && !hostPid.empty()) {
        IDE_LOGI("dump server not start on helper device");
        return IDE_DAEMON_OK;
    }
    AdxDumpRecord::Instance().UpdateDumpInitNum(false);
    int32_t dumpNum = AdxDumpRecord::Instance().GetDumpInitNum();
    if (dumpNum > 0) {
        IDE_LOGI("still have %d dump init times, return", dumpNum);
        return IDE_DAEMON_OK;
    }
    IDE_LOGI("start to do dump uninit");
    if (g_manager.Exit() != IDE_DAEMON_OK) {
        IDE_LOGE("AdxServerManager Exit failed");
        return IDE_DAEMON_ERROR;
    }
    return AdxDumpRecord::Instance().UnInit();
}
