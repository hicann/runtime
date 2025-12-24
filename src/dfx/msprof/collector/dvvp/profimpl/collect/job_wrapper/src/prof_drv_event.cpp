/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "prof_drv_event.h"
#include "errno/error_code.h"
#include "ai_drv_prof_api.h"
#include "platform/platform.h"

namespace Analysis {
namespace Dvvp {
namespace JobWrapper {
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::driver;
using namespace Analysis::Dvvp::Common::Platform;

const int32_t DRV_EVENT_TIMEOUT = 100;

ProfDrvEvent::ProfDrvEvent() {}

ProfDrvEvent::~ProfDrvEvent() {}

int32_t ProfDrvEvent::SubscribeEventThreadInit(struct TaskEventAttr *eventAttr) const
{
    OsalUserBlock userBlock;
    OsalThreadAttr threadAttr = {0, 0, 0, 0, 0, 0, 0};
    userBlock.procFunc = ProfDrvEvent::EventThreadHandle;
    userBlock.pulArg = eventAttr;
    int32_t ret = OsalCreateTaskWithThreadAttr(&eventAttr->handle, &userBlock, &threadAttr);
    if (ret != OSAL_EN_OK) {
        MSPROF_LOGE("Start task wait event thread for device %u failed, strerr : %s",
            eventAttr->deviceId, strerror(OsalGetErrorCode()));
        return PROFILING_FAILED;
    }
    eventAttr->isThreadStart = true;

    return PROFILING_SUCCESS;
}

void *ProfDrvEvent::EventThreadHandle(void *attr)
{
    if (attr == nullptr) {
        MSPROF_LOGE("attr is nullptr");
        return nullptr;
    }
    struct TaskEventAttr *eventAttr = static_cast<struct TaskEventAttr *>(attr);
    MSPROF_EVENT("Start drv event thread, device id:%u, channel id:%d", eventAttr->deviceId, eventAttr->channelId);

    if (QueryDevPid(eventAttr) != PROFILING_SUCCESS) {    // make sure aicpu bind pid before attach
        MSPROF_LOGW("Unable to query device pid");
        return nullptr;
    }
    drvError_t ret = halEschedAttachDevice(eventAttr->deviceId);              // attach process to device
    if (ret != DRV_ERROR_NONE) {
        MSPROF_LOGE("Call halEschedAttachDevice failed, devId=%u, ret=%d", eventAttr->deviceId, ret);
        return nullptr;
    }
    eventAttr->isAttachDevice = true;

    uint32_t grpId = 0;
    if (QueryGroupId(eventAttr->deviceId, grpId, eventAttr->grpName) != PROFILING_SUCCESS) {
        /* multiple start and stop profiling, create grpId and subscribe event only need once */
        struct esched_grp_para grpPara = {GRP_TYPE_BIND_CP_CPU, 1, {0}, {0}};
        if (strcpy_s(grpPara.grp_name, EVENT_MAX_GRP_NAME_LEN, eventAttr->grpName) != EOK) {
            MSPROF_LOGE("Call strcpy for grp name: %s failed", eventAttr->grpName);
            return nullptr;
        }
        int32_t err = Platform::instance()->HalEschedCreateGrpEx(eventAttr->deviceId, &grpPara, &grpId);
        if (err != DRV_ERROR_NONE) {
            (void)halEschedDettachDevice(eventAttr->deviceId);                    // dettach process from device
            MSPROF_LOGW("Called halEschedCreateGrpEx unsuccessfully. (devId=%u, ret=%d)\n", eventAttr->deviceId, err);
            return nullptr;
        }
        MSPROF_LOGI("create grp id:%u by name '%s'", grpId, eventAttr->grpName);

        uint64_t eventBitmap = (1ULL << static_cast<uint64_t>(EVENT_USR_START));
        ret = halEschedSubscribeEvent(eventAttr->deviceId, grpId, 0, eventBitmap);
        if (ret != DRV_ERROR_NONE) {
            (void)halEschedDettachDevice(eventAttr->deviceId);
            MSPROF_LOGE("Call halEschedSubscribeEvent failed, devId=%u, ret=%d", eventAttr->deviceId, ret);
            return nullptr;
        }
    }

    WaitEvent(eventAttr, grpId);

    MSPROF_LOGI("Event thread exit, device id:%u, channel id:%d", eventAttr->deviceId, eventAttr->channelId);
    return nullptr;
}

int32_t ProfDrvEvent::QueryGroupId(uint32_t devId, uint32_t &grpId, const char *grpName)
{
    struct esched_query_gid_output gidOut = {0};
    struct esched_query_gid_input gidIn = {0, {0}};
    struct esched_output_info outPut = {&gidOut, sizeof(struct esched_query_gid_output)};
    struct esched_input_info inPut = {&gidIn, sizeof(struct esched_query_gid_input)};

    gidIn.pid = OsalGetPid();
    if (strcpy_s(gidIn.grp_name, EVENT_MAX_GRP_NAME_LEN, grpName) != EOK) {
        MSPROF_LOGE("strcpy failed for drv event grp name");
        return PROFILING_FAILED;
    }
    int32_t ret = Platform::instance()->HalEschedQueryInfo(devId, QUERY_TYPE_LOCAL_GRP_ID, &inPut, &outPut);
    if (ret == DRV_ERROR_NONE) {
        grpId = gidOut.grp_id;
        MSPROF_LOGI("query group id %u by name '%s'", grpId, grpName);
        return PROFILING_SUCCESS;
    }

    return PROFILING_FAILED;
}

int32_t ProfDrvEvent::QueryDevPid(const struct TaskEventAttr *eventAttr)
{
    enum devdrv_process_type procType = DEVDRV_PROCESS_CPTYPE_MAX;
    if (eventAttr->channelId == PROF_CHANNEL_AICPU || eventAttr->channelId == PROF_CHANNEL_CUS_AICPU) {
        procType = DEVDRV_PROCESS_CP1;
    } else {
        return PROFILING_SUCCESS;
    }
    const uint32_t waitTime = 20;
    const int32_t waitCount = 80;
    pid_t devPid = 0;
    int32_t hostPid = OsalGetPid();
    struct halQueryDevpidInfo hostpidinfo = {static_cast<pid_t>(hostPid), eventAttr->deviceId, 0, procType, {0}};
    drvError_t ret = DRV_ERROR_NOT_SUPPORT;
    int32_t i = 0;
    while (((i < waitCount) && (!eventAttr->isExit)) || eventAttr->isWaitDevPid) {
        ret = halQueryDevpid(hostpidinfo, &devPid);
        if (ret == DRV_ERROR_NONE) {
            MSPROF_LOGI("Query devPid succ, devId:%u, hostPid:%d, devPid:%d, isWaitDevPid:%d", eventAttr->deviceId,
                hostPid, devPid, eventAttr->isWaitDevPid);
            return PROFILING_SUCCESS;
        }
        MSPROF_LOGD("Query devPid failed, devId:%u, hostPid:%d, ret:%d.", eventAttr->deviceId, hostPid, ret);
        OsalSleep(waitTime);
        i++;     
    }
    return PROFILING_FAILED;
}

void ProfDrvEvent::WaitEvent(struct TaskEventAttr *eventAttr, uint32_t grpId)
{
    MSPROF_LOGI("Start wait drv event, device id:%u, channel id:%d", eventAttr->deviceId, eventAttr->channelId);
    event_info event{{EVENT_MAX_NUM, 0, 0, 0, 0, 0, 0}, {0, {0}}};
    bool onceFlag = true;
    int32_t timeout = 1;  // first timeout need to check channel is valid
    while (!eventAttr->isExit) {
        drvError_t err = halEschedWaitEvent(eventAttr->deviceId, grpId, 0, timeout, &event);
        timeout = DRV_EVENT_TIMEOUT;

        if (err == DRV_ERROR_NONE) {
            MSPROF_LOGI("Receive event, devId:%u, channelId:%d, eventId:%d",
                eventAttr->deviceId, eventAttr->channelId, event.comm.event_id);
            if (event.comm.event_id != EVENT_USR_START) {
                MSPROF_LOGE("Receive unexpected event, devId:%u, channelId:%d, eventId:%d",
                    eventAttr->deviceId, eventAttr->channelId, event.comm.event_id);
                return;
            }
            if (DrvChannelsMgr::instance()->GetAllChannels(eventAttr->deviceId) == PROFILING_SUCCESS &&
                DrvChannelsMgr::instance()->ChannelIsValid(eventAttr->deviceId, eventAttr->channelId)) {
                MSPROF_LOGI("Channel is valid, devId:%u, channelId:%d",
                    eventAttr->deviceId, static_cast<int32_t>(eventAttr->channelId));
                eventAttr->isChannelValid = true;
                (void)CollectionRegisterMgr::instance()->CollectionJobRun(eventAttr->deviceId, eventAttr->jobTag);
            } else {
                MSPROF_LOGE("Receive event but channel is invalid, devId:%u, channel id:%d",
                    eventAttr->deviceId, static_cast<int32_t>(eventAttr->channelId));
            }
            return;
        } else if ((err == DRV_ERROR_SCHED_WAIT_TIMEOUT) || (err == DRV_ERROR_NO_EVENT)) {
            MSPROF_LOGD("Wait event time out or no event, devId=%u, onceFlag=%d", eventAttr->deviceId, onceFlag);
            if (!onceFlag) {
                continue;
            }
            onceFlag = false;

            if (DrvChannelsMgr::instance()->GetAllChannels(eventAttr->deviceId) == PROFILING_SUCCESS &&
                DrvChannelsMgr::instance()->ChannelIsValid(eventAttr->deviceId, eventAttr->channelId)) {
                MSPROF_LOGI("Channel is valid, channelId=%d", static_cast<int32_t>(eventAttr->channelId));
                eventAttr->isChannelValid = true;
                (void)CollectionRegisterMgr::instance()->CollectionJobRun(eventAttr->deviceId, eventAttr->jobTag);
                return;
            }
            continue;
        }

        MSPROF_LOGE("Wait event failed, device id:%u, channel id:%d, return:%d",
            eventAttr->deviceId, eventAttr->channelId, err);
        return;
    }
}

void ProfDrvEvent::SubscribeEventThreadUninit(uint32_t devId) const
{
    // dettach process from device
    drvError_t ret = halEschedDettachDevice(devId);
    if (ret != DRV_ERROR_NONE) {
        MSPROF_LOGW("call halEschedDettachDevice ret: %d", ret);
    }
}
}
}
}