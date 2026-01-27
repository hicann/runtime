/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "ide_daemon_hdc.h"
#include <map>
#include <iostream>
#include <string>
#include "thread.h"
#include "securec.h"
#include "ascend_hal.h"
#include "adx_dsmi.h"
#include "adx_log.h"
#include "adx_config.h"
#include "msprof_dlog.h"
#include "extra_config.h"
#include "utils/utils.h"

using namespace IdeDaemon::Common::Config;
using namespace Adx;
using namespace Analysis::Dvvp::Adx;
using namespace analysis::dvvp::common::utils;

using DevInfoT = struct IdeDevInfo;
struct IdeGlobalCtrlInfo g_ideGlobalInfo;

#define IDE_CTRL_WAIT_FAILED(value, action, logText, ...) do {         \
    if (mmSemWait(value) != EN_OK && mmGetErrorCode() != EINTR) {      \
        MSPROF_LOGE(logText, ##__VA_ARGS__);                              \
        action;                                                        \
    }                                                                  \
} while (mmGetErrorCode() == EINTR)

STATIC void IdeInitGlobalCtrlInfoDev()
{
    if (!g_ideGlobalInfo.devMapInfoInitFlag) {
        MSPROF_LOGI("Init GlobalCtrlInfo");
        IDE_CTRL_VALUE_FAILED(mmMutexInit(&g_ideGlobalInfo.mtx) == EN_OK, return, "global info mutex init error");
        IDE_CTRL_VALUE_FAILED(mmSemInit(&g_ideGlobalInfo.devNotifySem, 0) == EN_OK, return,
            "device notify sem init error");
        g_ideGlobalInfo.devMapInfoInitFlag = true;
    }
}

/**
 * @brief Destroy device information related information
 *
 * @return none
 */
STATIC void IdeDestroyGlobalCtrlInfoDev()
{
    if (g_ideGlobalInfo.devMapInfoInitFlag) {
        MSPROF_LOGI("Destroy GlobalCtrlInfo");
        g_ideGlobalInfo.deviceNotifyCallbacks.upCallbacks.clear();
        IDE_CTRL_VALUE_FAILED(mmSemDestroy(&g_ideGlobalInfo.devNotifySem) == EN_OK, return,
            "device notify sem destroy error");
        IDE_CTRL_VALUE_FAILED(mmMutexDestroy(&g_ideGlobalInfo.mtx) == EN_OK, return,
            "global info mutex dertroy error");
        g_ideGlobalInfo.devMapInfoInitFlag = false;
    }
}

/**
 * @brief Initialize global control information
 *
 * @return none
 */
STATIC void IdeInitGlobalCtrlInfo()
{
    if (!g_ideGlobalInfo.initFlag) {
        MSPROF_LOGI("Init GlobalCtrlInfo");
        g_ideGlobalInfo.hdcClient = nullptr;
        IdeInitGlobalCtrlInfoDev();
        g_ideGlobalInfo.hdcServerProcFlag = true;
        g_ideGlobalInfo.hdcHandleEventFlag = true;
        g_ideGlobalInfo.initFlag = true;
    }
}

/**
 * @brief Destroy global control information
 *
 * @return none
 */
STATIC void IdeDestroyGlobalCtrlInfo()
{
    if (!g_ideGlobalInfo.initFlag) {
        return;
    }

    MSPROF_LOGI("Destroy GlobalCtrlInfo");
    hdcError_t err = DRV_ERROR_NONE;
    DevInfoT *pdevInfo = nullptr;

    // destroy hdc server for every device
    IDE_CTRL_MUTEX_LOCK(&g_ideGlobalInfo.mtx, return);
    while (g_ideGlobalInfo.mapDevInfo.size() > 0) {
        pdevInfo = &g_ideGlobalInfo.mapDevInfo.begin()->second;
        if (pdevInfo != nullptr && pdevInfo->createHdc == true) {
            err = drvHdcServerDestroy(pdevInfo->server);
            pdevInfo->server = nullptr;
            if (err != DRV_ERROR_NONE) {
                MSPROF_LOGI("Hdc Server Destroy Err Code: %d, dev Id: %u", err, pdevInfo->phyDevId);
            }
        }
        g_ideGlobalInfo.mapDevInfo.erase(g_ideGlobalInfo.mapDevInfo.begin());
    }
    IDE_CTRL_MUTEX_UNLOCK(&g_ideGlobalInfo.mtx, return);

    // destroy hdc client handle
    if (g_ideGlobalInfo.hdcClient != nullptr) {
        err = drvHdcClientDestroy(g_ideGlobalInfo.hdcClient);
        g_ideGlobalInfo.hdcClient = nullptr;
        if (err != DRV_ERROR_NONE) {
            MSPROF_LOGI("Hdc Client Destroy Err Code: %d", err);
        }
    }

    g_ideGlobalInfo.hdcServerProcFlag = false;
    g_ideGlobalInfo.hdcHandleEventFlag = false;
    IDE_CTRL_VALUE_FAILED(mmSemPost(&g_ideGlobalInfo.devNotifySem) == EN_OK, return,
        "notify sem post error");
    IdeDestroyGlobalCtrlInfoDev();
    g_ideGlobalInfo.initFlag = false;
}

/**
 * @brief create new hdc server
 * @param args: hdc register arguments
 *
 * @return
 */
IdeThreadArg HdcCreateHdcServerProc(IdeThreadArg /* args */)
{
    int32_t err;
    MSPROF_LOGI("Hdc Create HdcServer Entry");

#ifndef IDE_DAEMON_DEVICE
    (void)mmSetCurrentThreadName(IDE_DEVICE_MONITOR_THREAD_NAME);
#endif

    while (g_ideGlobalInfo.hdcServerProcFlag) {
        IDE_CTRL_WAIT_FAILED(&g_ideGlobalInfo.devNotifySem, return nullptr, "dev sem wait error");
        if (!g_ideGlobalInfo.hdcServerProcFlag) {
            break;
        }
        std::map<int32_t, DevInfoT>::iterator it;
        DevInfoT *pDevInfo = nullptr;

        IDE_CTRL_MUTEX_LOCK(&g_ideGlobalInfo.mtx, return nullptr);
        for (it = g_ideGlobalInfo.mapDevInfo.begin(); it != g_ideGlobalInfo.mapDevInfo.end(); ++it) {
            pDevInfo = &it->second;
            // check if created hdc server already
            if (pDevInfo == nullptr || pDevInfo->createHdc == true) {
                continue;
            }
            MSPROF_LOGI("Create HdcServer");
            mmUserBlock_t funcBlock;
            funcBlock.procFunc = IdeDaemonHdcHandleEvent;
            funcBlock.pulArg = pDevInfo;
            mmThreadAttr threadAttr = IDE_DAEMON_DEFAULT_DETACH_THREAD_ATTR;
            err = mmCreateTaskWithThreadAttr(&pDevInfo->tid, &funcBlock, &threadAttr);
            if (err != EN_OK) {
                const int32_t MAX_ERRSTR_LEN  = 128;
                char errBuf[MAX_ERRSTR_LEN + 1] = {0};
                MSPROF_LOGE("Thread Create error: %s",
                            mmGetErrorFormatMessage(mmGetErrorCode(), errBuf, MAX_ERRSTR_LEN));
                IDE_CTRL_MUTEX_UNLOCK(&g_ideGlobalInfo.mtx, return nullptr);
                return nullptr;
            }
            pDevInfo->createHdc = true;
        }
        IDE_CTRL_MUTEX_UNLOCK(&g_ideGlobalInfo.mtx, return nullptr);
    }

    MSPROF_LOGI("Hdc Create HdcServer Exit");

    return nullptr;
}

STATIC int32_t GetDevCount(uint32_t &devCount, std::vector<uint32_t> &devs)
{
    int32_t err;
    // device no register callbacks get devices count
    const uint32_t waitDeviceTime = 1000;
    int32_t retryCheckDeviceTimes = 600; // 10min(600 * 1000ms)
    do {
        err = IdeGetPhyDevList(&devCount, devs, DEVICE_NUM_MAX);
        MSPROF_LOGI("Device Counts: %u", devCount);
        if (err != IDE_DAEMON_OK || devCount == 0) {
            (void)mmSleep(waitDeviceTime);
            retryCheckDeviceTimes--;
        }
    } while (((err != IDE_DAEMON_OK) || (devCount == 0)) && retryCheckDeviceTimes > 0);
    return err;
}

/**
 * @brief hdc init
 *
 * @return
 *        IDE_DAEMON_OK: succ
 *        IDE_DAEMON_ERROR: failed
 */
int32_t HdcDaemonInit()
{
    hdcError_t error;
    const int32_t flag = 0;
    int32_t err;
    IdeInitGlobalCtrlInfo();

    // if in device or in minirc host
    uint32_t devCount = 0;
    std::vector<uint32_t> devs(DEVICE_NUM_MAX, 0);
    err = GetDevCount(devCount, devs);
    if (err != IDE_DAEMON_OK) {
        return err;
    }

    if (devCount > 0) {
        IDE_CTRL_VALUE_FAILED(devCount <= DEVICE_NUM_MAX, return IDE_DAEMON_ERROR, "device num %u", devCount);
        MSPROF_LOGI("device count: %u", devCount);
        // device register driver device callback for device id
        HdcDaemonServerRegister(devCount, devs);
    }

    error = drvHdcClientCreate(&g_ideGlobalInfo.hdcClient, MAX_SESSION_NUM, HDC_SERVICE_TYPE_IDE2, flag);
    IDE_CTRL_VALUE_FAILED((error == DRV_ERROR_NONE) && (g_ideGlobalInfo.hdcClient != nullptr),
        return IDE_DAEMON_ERROR, "Hdc Client Create, Max Session Num: %d", MAX_SESSION_NUM);

    return IDE_DAEMON_OK;
}

/**
 * @brief hdc init
 * @param num: device num
 * @param dev: device id list, devId is phyID
 *
 * @return
 *        IDE_DAEMON_OK: succ
 *        IDE_DAEMON_ERROR: failed
 */
int HdcDaemonServerRegister(uint32_t num, const std::vector<uint32_t> &dev)
{
    uint32_t i = 0;
    uint32_t count = 0;

    if (num == 0 || num > DEVICE_NUM_MAX) {
        MSPROF_LOGE("server register input error; device num is %u", num);
        return IDE_DAEMON_ERROR;
    }

    // minirc host can't callback_handle
    // notify device num to callbacks(bbox)
    IDE_CTRL_MUTEX_LOCK(&g_ideGlobalInfo.mtx, return IDE_DAEMON_ERROR);
    for (count = 0; count < g_ideGlobalInfo.deviceNotifyCallbacks.upCallbacks.size(); count++) {
        MSPROF_LOGI("register %u notify callbacks %u", count, num);
        g_ideGlobalInfo.deviceNotifyCallbacks.upCallbacks[count](num, const_cast<IdeU32Pt>(dev.data()));
    }
    for (i = 0; i < num; i++) {
        uint32_t phyDevId = dev[i];
        if (g_ideGlobalInfo.mapDevInfo.find(phyDevId) == g_ideGlobalInfo.mapDevInfo.end()) {
            DevInfoT devInfo;
            (void)memset_s(&devInfo, sizeof(devInfo), 0, sizeof(devInfo));
            devInfo.phyDevId = phyDevId;
            devInfo.server = nullptr;
            devInfo.createHdc = false;
            devInfo.devDisable = false;
            devInfo.serviceType = HDC_SERVICE_TYPE_IDE2;
            g_ideGlobalInfo.mapDevInfo.insert(std::pair<int32_t, DevInfoT>(phyDevId, devInfo));
        }
    }

    IDE_CTRL_MUTEX_UNLOCK(&g_ideGlobalInfo.mtx, return IDE_DAEMON_ERROR);
    mmSemPost(&g_ideGlobalInfo.devNotifySem);
    MSPROF_LOGI("notify %u device up", num);
    return IDE_DAEMON_OK;
}

/**
 * @brief hdc daemon destroy
 *
 * @return
 *        IDE_DAEMON_OK:    succ
 *        IDE_DAEMON_ERROR: failed
 */
int32_t HdcDaemonDestroy()
{
    IdeDestroyGlobalCtrlInfo();
    MSPROF_LOGI("Hdc Destroy Exit");
    return IDE_DAEMON_OK;
}

/**
 * @brief read request data
 *
 * @param [in] handle: socket handle or hdc session
 * @param [out] req: tlv result
 *
 * @return
 *        IDE_DAEMON_OK:    succ
 *        IDE_DAEMON_ERROR: failed
 */
STATIC int32_t IdeDaemonReadReq(const struct IdeTransChannel &handle, IdeTlvReqAddr req)
{
    void *buf = nullptr;
    uint32_t recvlen = 0;

    IDE_CTRL_VALUE_FAILED(req != nullptr, return IDE_DAEMON_ERROR, "req is nullptr");
    // 1.read data
    int err = Adx::IdeRead(handle, &buf, reinterpret_cast<IdeI32Pt>(&recvlen), IDE_DAEMON_NOBLOCK);
    if (err != IDE_DAEMON_OK) {
        MSPROF_LOGW("Ide Read ret: %d", err);
        return err;
    }

    if (static_cast<uint64_t>(recvlen) + 1 > UINT32_MAX) {
        MSPROF_LOGE("too long recv_data: %u bytes", recvlen);
        IDE_XFREE_AND_SET_NULL(buf);
        return IDE_DAEMON_ERROR;
    }

    *req = (struct tlv_req *)IdeXmalloc(recvlen + 1);
    if (*req == nullptr) {
        MSPROF_LOGE("Ide Xmalloc failed");
        IDE_XFREE_AND_SET_NULL(buf);
        return IDE_DAEMON_ERROR;
    }

    err = memcpy_s(*req, recvlen + 1, buf, recvlen);
    if (err != EOK) {
        MSPROF_LOGE("memory copy_s failed");
        IDE_XFREE_AND_SET_NULL(buf);
        IDE_XFREE_AND_SET_NULL(*req);
        return IDE_DAEMON_ERROR;
    }

    if (static_cast<uint32_t>((*req)->len) != (recvlen - sizeof(TlvReqT))) {
        MSPROF_LOGE("recv len: %u bytes, req len %d bytes, size %zu bytes", recvlen, (*req)->len, sizeof(TlvReqT));
        IDE_XFREE_AND_SET_NULL(buf);
        IDE_XFREE_AND_SET_NULL(*req);
        return IDE_DAEMON_ERROR;
    }

    IDE_XFREE_AND_SET_NULL(buf);
    return IDE_DAEMON_OK;
}


/**
 * @brief Call the specified handler based on the data sent by the user
 *
 * @param [in] devSession: hdc data struct, Carry device id, hdc session
 *
 * @return
 *        IDE_DAEMON_OK:    succ
 *        IDE_DAEMON_ERROR: failed
 */
STATIC int32_t IdeDaemonHdcProcessEventOne(const struct DevSession &devSession)
{
    int32_t err;
    IdeTlvReq req = nullptr;
    HDC_SESSION session = devSession.session;
    struct IdeTransChannel handle = {IdeChannel::IDE_CHANNEL_HDC, session};
    err = IdeDaemonReadReq(handle, &req);
    if (err != IDE_DAEMON_OK) {
        MSPROF_LOGE("Ide Hdc Read Request failed, err: %d", err);
        HdcSessionClose(session);
        session = nullptr;
        return IDE_DAEMON_ERROR;
    }

    MSPROF_LOGI("received %s request, type %d, req->dev_id=%d, phyDevId=%u.",
                IdeGetCompontNameByReq(req->type), req->type, req->dev_id, devSession.phyDevId);
    req->dev_id = devSession.phyDevId;
    enum IdeComponentType type = IdeGetComponentType(req);
    if ((type != NR_IDE_COMPONENTS) && (g_ideComponentsFuncs.hdcProcess[type] != nullptr)) {
        std::string threadName = IDE_HDC_PROCESS_THREAD_NAME;
        threadName.append(IDE_UNDERLINE);
        threadName.append(IdeGetCompontNameByReq(req->type));
        (void)mmSetCurrentThreadName(threadName.c_str());
        err = g_ideComponentsFuncs.hdcProcess[type](session, req);
    } else {
        MSPROF_LOGE("req->type: %d, Invalid request or no hdc process func register", req->type);
        err = IDE_DAEMON_ERROR;
    }

    if (err != IDE_DAEMON_OK) {
        MSPROF_LOGE("req->type: %d, call %s process func failed, err: %d",
            req->type, IdeGetCompontNameByReq(req->type), err);
    }

    // profiling is aync, freed by its thread; bbox use the session send log data
    if (type != IDE_COMPONENT_PROFILING) {
        HdcSessionClose(session);
        session = nullptr;
    }
    IdeReqFree(req);
    req = nullptr;
    return err;
}

/**
 * @brief Call the specified handler based on the data sent by the user
 *
 * @param arg: hdc session argument
 *
 * @return
 */
IdeThreadArg IdeDaemonHdcProcessEvent(IdeThreadArg arg)
{
    IDE_CTRL_VALUE_FAILED(arg != nullptr, return nullptr, "invalid parameter");

    struct DevSession *devSession = static_cast<struct DevSession *>(arg);
    (void)mmSetCurrentThreadName(IDE_HDC_PROCESS_THREAD_NAME);

    int32_t err = IdeDaemonHdcProcessEventOne(*devSession);
    if (err != IDE_DAEMON_OK) {
        MSPROF_LOGE("Daemon Hdc Process Event Process Failed, err: %d", err);
    }

    IDE_XFREE_AND_SET_NULL(devSession);
    return nullptr;
}
/**
 * @brief create hdc server
 *
 * @param arg: not use
 *
 * @return
 */
STATIC void IdeDaemonCreateHdcServer(DevInfoT *devInfo)
{
    IDE_CTRL_VALUE_FAILED(devInfo != nullptr, return, "devInfo is nullptr");
    hdcError_t error = DRV_ERROR_NONE;

    while (g_ideGlobalInfo.hdcHandleEventFlag) {
        int32_t ret = IdeGetLogIdByPhyId(devInfo->phyDevId, &devInfo->logDevId);
        if (ret != IDE_DAEMON_OK) {
            MSPROF_LOGW("logDevId %u phyDevId %u not ready, sleep %d milliseconds and retry",
                devInfo->logDevId, devInfo->phyDevId, IDE_CREATE_SERVER_TIME);
            (void)mmSleep(IDE_CREATE_SERVER_TIME);
            continue;
        }
        error = drvHdcServerCreate (devInfo->logDevId, devInfo->serviceType, &devInfo->server);
        if (error == DRV_ERROR_DEVICE_NOT_READY) {
            MSPROF_LOGW("logDevId %u phyDevId %u hdc not ready, sleep %d milliseconds and retry",
                devInfo->logDevId, devInfo->phyDevId, IDE_CREATE_SERVER_TIME);
            (void)mmSleep(IDE_CREATE_SERVER_TIME);
        } else if (error != DRV_ERROR_NONE || devInfo->server == nullptr) {
            MSPROF_LOGW("Unable to create HDC with logDevId %u phyDevId %u, return value: %d, sleep %dms and retry",
                devInfo->logDevId, devInfo->phyDevId, error, IDE_CREATE_SERVER_TIME);
            (void)mmSleep(IDE_CREATE_SERVER_TIME);
        } else {
            MSPROF_LOGI("logDevId %u phyDevId:%u create HDC server successfully", devInfo->logDevId, devInfo->phyDevId);
            break;
        }
    }

    return;
}

/**
 * @brief Create Hdc Process Handle Thread
 * @param [in]session: hdc session
 * @param [in]devInfo: hdc device info
 * @return IDE_DAEMON_ERROR : success
 *         IDE_DAEMON_OK : failed
 */
STATIC int32_t IdeCreateHdcHandleThread(HDC_SESSION session, const DevInfoT &devInfo)
{
    struct DevSession *devSession = static_cast<struct DevSession*>(IdeXmalloc(sizeof(struct DevSession)));
    if (devSession == nullptr) {
        MSPROF_LOGE("Ide Xmalloc failed");
        return IDE_DAEMON_ERROR;
    }
    devSession->phyDevId = devInfo.phyDevId;
    devSession->logDevId = devInfo.logDevId;
    devSession->session = session;
    mmUserBlock_t funcBlock;
    funcBlock.procFunc = IdeDaemonHdcProcessEvent;
    funcBlock.pulArg = devSession;
    mmThreadAttr threadAttr = IDE_DAEMON_DEFAULT_DETACH_THREAD_ATTR;
    mmThread tid = (mmThread)0;
    INT32 err = mmCreateTaskWithThreadAttr(&tid, &funcBlock, &threadAttr);
    if (err != EN_OK) {
        MSPROF_LOGE("Thread Create Error: %d", err);
        IDE_XFREE_AND_SET_NULL(devSession);
        return IDE_DAEMON_ERROR;
    }

    return IDE_DAEMON_OK;
}

/**
 * @brief Check Client env
 * @param [in]session: hdc session
 * @return IDE_DAEMON_ERROR : success
 *         IDE_DAEMON_OK : failed
 */
STATIC int32_t IdeHdcCheckRunEnv(HDC_SESSION session)
{
#if (defined IDE_DAEMON_DEVICE) && (defined PLATFORM_CLOUD) && (!defined IDE_DAEMON_RC)
    int32_t runEnv = RUN_ENV_UNKNOW;
    hdcError_t error = halHdcGetServerAttr(session, HDC_SESSION_ATTR_RUN_ENV, &runEnv);
    MSPROF_LOGD("Hdc Session Recv Env err no %d, runEnv %d", error, runEnv);
    if (error != DRV_ERROR_NONE) {
        MSPROF_LOGW("Hdc Session Recv Env err no %d, runEnv %d", error, runEnv);
        return IDE_DAEMON_ERROR;
    }
#else
    UNUSED(session);
#endif
    return IDE_DAEMON_OK;
}

/**
 * @brief Destroy hdc device
 * @param [in]devInfo: hdc device info
 * @return IDE_DAEMON_ERROR : success
 *         IDE_DAEMON_OK : failed
 */
STATIC int32_t IdeHdcDistroyDevice(const DevInfoT &devInfo)
{
    if (devInfo.devDisable) {
        IDE_CTRL_MUTEX_LOCK(&g_ideGlobalInfo.mtx, return IDE_DAEMON_ERROR);
        std::map<int32_t, DevInfoT>::iterator it = g_ideGlobalInfo.mapDevInfo.find(devInfo.phyDevId);
        if (it != g_ideGlobalInfo.mapDevInfo.end()) {
            g_ideGlobalInfo.mapDevInfo.erase(it);
        }
        IDE_CTRL_MUTEX_UNLOCK(&g_ideGlobalInfo.mtx, return IDE_DAEMON_ERROR);
        return IDE_DAEMON_ERROR;
    }
    return IDE_DAEMON_OK;
}

/**
 * @brief Destroy hdc server
 * @param [in]devInfo: hdc device info
 * @return void
 */
STATIC void IdeHdcDistroyServer(DevInfoT *devInfoPtr)
{
    if (devInfoPtr->server != nullptr) {
        hdcError_t err = drvHdcServerDestroy(devInfoPtr->server);
        if (err != DRV_ERROR_NONE) {
            MSPROF_LOGE("Hdc Server Destroy Error : %d", err);
        }
        devInfoPtr->server = nullptr;
    }
}

/**
 * @brief Monitor one hdc server, if a new request is coming, create a new thread
 *
 * @param arg: not use
 *
 * @return
 */
IdeThreadArg IdeDaemonHdcHandleEvent(IdeThreadArg args)
{
    MSPROF_EVENT("<START thread> IdeDaemonHdcHandleEvent start");
    IDE_CTRL_VALUE_FAILED(args != nullptr, return nullptr, "invalid parameter");
    (void)mmSetCurrentThreadName(IDE_HDC_SERVER_THREAD_NAME);

    DevInfoT *devInfo = reinterpret_cast<DevInfoT *>(args);
    IdeDaemonCreateHdcServer(devInfo);
    while (g_ideGlobalInfo.hdcHandleEventFlag) {
        HDC_SESSION session = nullptr;
        hdcError_t error = drvHdcSessionAccept(devInfo->server, &session);
        if (error != DRV_ERROR_NONE || session == nullptr) {
            if (mmGetErrorCode() == EINTR) {
                MSPROF_LOGW("Hdc Session Accept Break By EINTR");
                continue;
            }

            MSPROF_LOGE("Hdc Session Accept Error: %d", error);
            IdeHdcDistroyServer(devInfo);

            if (IdeHdcDistroyDevice(*devInfo) != IDE_DAEMON_OK) {
                break;
            }
            IdeDaemonCreateHdcServer(devInfo);
            continue;
        }

        if (drvHdcSetSessionReference(session) != DRV_ERROR_NONE &&
            IdeHdcCheckRunEnv(session) != IDE_DAEMON_OK) {
            HdcSessionClose(session);
            session = nullptr;
            continue;
        }

        if (IdeCreateHdcHandleThread(session, *devInfo) != IDE_DAEMON_OK) {
            HdcSessionClose(session);
            session = nullptr;
            break;
        }
    }

    MSPROF_EVENT("<EXIT thread> IdeDaemonHdcHandleEvent");
    return nullptr;
}
