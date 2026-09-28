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
#include <mutex>
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
    std::unique_ptr<AdxComponent> cpn(new (std::nothrow) AdxDumpReceive());
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

static bool IsOnDeviceSide()
{
    uint32_t platformInfo = static_cast<uint32_t>(SysPlatformType::INVALID);
    bool ret = AdumpDsmi::DrvGetPlatformInfo(platformInfo);
    if (ret && (platformInfo == static_cast<uint32_t>(SysPlatformType::DEVICE))) {
        return true;
    }
    return false;
}

// 全局锁序约定：g_serverLifecycleMtx 始终作为最外层锁被获取；
// AdxDataDumpServerInit/UnInit 内部调用链不存在再次进入这两个接口的重入路径，
// 亦不会以相反顺序获取 DumpManager::resourceMtx_/resourceMtx2_，禁止在此锁内反向调用。
// 锁最长持有时间说明：
// - Init 首次调用：WaitServerInitted() 正常毫秒级返回（服务器线程启动即置位），
//   异常兜底最长约 60s（346 次递增等待，仅服务器线程启动失败时触达）。
// - UnInit：g_manager.Exit() 内部自旋等待服务器线程退出（500ms 粒度，正常毫秒级）、
//   WaitProcessDrained() 最长 5000ms，加上组件 UnInit/Terminate 循环，
//   最坏合计约 5s+ 量级（服务器正常运行时各步均毫秒级完成）。
// - RTS 快照 LOCK_PRE 回调（DumpSnapShotLockPreCallback → StopDataDumpServer → UnInit）
//   与本锁串行化，在 dumpNum > 0 时为 while 循环反复调用 UnInit；
//   快照本身为长时备份流程（秒~分钟级），可容忍 5s 级的单次 UnInit 等待。
std::mutex g_serverLifecycleMtx;
} // namespace

int32_t AdxDataDumpServerInit()
{
    const std::lock_guard<std::mutex> lock(g_serverLifecycleMtx);
    if (AdxDumpRecord::Instance().HasStartedServer()) {
        IDE_LOGI("the data dump server has been started, not need to start again");
        AdxDumpRecord::Instance().UpdateDumpInitNum(true);
        return IDE_DAEMON_OK;
    }
    IDE_LOGI("start to do dump init");
    mmUserBlock_t funcBlock;
    mmThread tid = 0;
    // non-soc case, no need to pass host pid
    int32_t ret = AdxDumpRecord::Instance().Init("");
    if (ret != IDE_DAEMON_OK) {
        IDE_LOGE("AdxDumpRecord init failed.");
        return IDE_DAEMON_ERROR;
    }
    ret = AdxDumpRecord::Instance().StartRecord();
    if (ret != IDE_DAEMON_OK) {
        IDE_LOGE("start dump record thread failed.");
        return IDE_DAEMON_ERROR;
    }

    std::string hostPid;
    ADX_GET_ENV(MM_ENV_ASCEND_HOSTPID, hostPid);
    if (IsOnDeviceSide() && !hostPid.empty()) {
        AdxDumpRecord::Instance().UpdateDumpInitNum(true);
        IDE_LOGI("dump server not start on helper device");
        return IDE_DAEMON_OK;
    }
    funcBlock.procFunc = AdxDataDumpServerProcess;
    funcBlock.pulArg = nullptr;
    ret = Thread::CreateDetachTaskWithDefaultAttr(tid, funcBlock);
    (void)g_manager.WaitServerInitted();
    if (ret == EN_OK) {
        AdxDumpRecord::Instance().UpdateDumpInitNum(true);
    }
    return (ret != EN_OK) ? IDE_DAEMON_ERROR : IDE_DAEMON_OK;
}

int32_t AdxDataDumpServerUnInit()
{
    const std::lock_guard<std::mutex> lock(g_serverLifecycleMtx);
    if (!AdxDumpRecord::Instance().CanShutdownServer()) {
        IDE_LOGI("still have init times, can not stop the data dump server");
        AdxDumpRecord::Instance().UpdateDumpInitNum(false);
        return IDE_DAEMON_OK;
    }

    IDE_LOGI("start to do dump uninit");
    std::string hostPid;
    ADX_GET_ENV(MM_ENV_ASCEND_HOSTPID, hostPid);
    int32_t ret = IDE_DAEMON_OK;
    bool isHelper = IsOnDeviceSide() && !hostPid.empty();
    if (!isHelper && g_manager.Exit() != IDE_DAEMON_OK) {
        IDE_LOGE("AdxServerManager Exit failed");
        ret = IDE_DAEMON_ERROR;
    }
    if (isHelper) {
        IDE_LOGI("dump server not start on helper device");
    }

    if (AdxDumpRecord::Instance().UnInit() != IDE_DAEMON_OK) {
        IDE_LOGE("dump record uninit failed");
        ret = IDE_DAEMON_ERROR;
    }

    if (ret == IDE_DAEMON_OK) {
        AdxDumpRecord::Instance().UpdateDumpInitNum(false);
    }
    return ret;
}
