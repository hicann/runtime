/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "aicpu_cust_platform_info_process.h"

#include <dlfcn.h>
#include <semaphore.h>
#include "aicpusd_drv_manager.h"
#include "aicpusd_info.h"
#include "aicpusd_util.h"
#include "ProcMgrSysOperatorAgent.h"
#include "aicpusd_interface_process.h"
namespace AicpuSchedule {

    const std::string CUSTOM_EXTEND_SO_PLATFORM_FUNC_NAME = "AicpuCustExtendKernelsLoadPlatformInfo";
    AicpuPlatformFuncPtr AicpuCustomSdLoadPlatformInfoProcess::GetAicpuPlatformFuncPtr()
    { 
        const std::lock_guard<std::mutex> lk(mutexForPlatformPtr);
        if (platformFuncPtr != nullptr) {
            return platformFuncPtr;
        }
        platformFuncPtr = reinterpret_cast<AicpuPlatformFuncPtr>(dlsym(RTLD_DEFAULT,
            CUSTOM_EXTEND_SO_PLATFORM_FUNC_NAME.c_str()));
        if (platformFuncPtr == nullptr) {
            aicpusd_err("failed to find func:%s, err:%s", CUSTOM_EXTEND_SO_PLATFORM_FUNC_NAME.c_str(), dlerror());
        }
        return platformFuncPtr;
    }
    AicpuCustomSdLoadPlatformInfoProcess::AicpuCustomSdLoadPlatformInfoProcess():platformFuncPtr(nullptr)
    {
    }
    AicpuCustomSdLoadPlatformInfoProcess::~AicpuCustomSdLoadPlatformInfoProcess()
    {
    }
    AicpuCustomSdLoadPlatformInfoProcess &AicpuCustomSdLoadPlatformInfoProcess::GetInstance()
    {
        static AicpuCustomSdLoadPlatformInfoProcess instance;
        return instance;
    }
    int32_t AicpuCustomSdLoadPlatformInfoProcess::ProcessLoadPlatform(const uint8_t * const msgInfo, const uint32_t infoLen)
    {
        aicpusd_info("ProcessLoadPlatform begin.");
        int32_t ret = 0;
        uint32_t headLen = sizeof(struct event_sync_msg);
        uint8_t msg[EVENT_MAX_MSG_LEN] = {};
        int32_t len = sizeof(uint8_t) * EVENT_MAX_MSG_LEN - headLen;
        int32_t rLen = infoLen - headLen;
        ret = memcpy_s(msg, len, (msgInfo + headLen), rLen);
        if (ret != 0) {
            aicpusd_err("Memcpy failed. ret[%d] len[%d], rlen[%d]", ret, len, rLen);
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }
        const AICPULoadPlatformCustInfo * const info = PtrToPtr<const uint8_t, const AICPULoadPlatformCustInfo>(msg);

        AicpuPlatformFuncPtr funcPtr = GetAicpuPlatformFuncPtr();
        if (funcPtr == nullptr) {
            aicpusd_err("failed to find func:%s", CUSTOM_EXTEND_SO_PLATFORM_FUNC_NAME.c_str());
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }
        if (info->platformInfo == 0LU || info->length == 0LU) {
            aicpusd_err("info->platformInfo is nullptr or info->length is %llu", info->length);
        }
        aicpusd_info("func:%s procss, info[%llu], length[%llu], pid[%u]", CUSTOM_EXTEND_SO_PLATFORM_FUNC_NAME.c_str(), info->platformInfo, info->length, info->aicpuPid);
        ret = funcPtr(info->platformInfo, info->length);
        if (ret != AICPU_SCHEDULE_OK) {
            aicpusd_err("func:%s procss failed,ret:%u, info[%llu], length[%llu], pid[%u]",
                CUSTOM_EXTEND_SO_PLATFORM_FUNC_NAME.c_str(), ret, info->platformInfo, info->length, info->aicpuPid);
        }
        struct event_proc_result rsp = {};
        rsp.ret = ret;
        ret = DoSubmitEventSync(msg, len, rsp);
        if (ret != 0) {
            aicpusd_err("DoSubmitEventSync failed, ret[%d]", ret);
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }
        aicpusd_info("ProcessLoadPlatform finish.");
        return AICPU_SCHEDULE_OK;
    }
    int32_t AicpuCustomSdLoadPlatformInfoProcess::DoSubmitEventSync(const uint8_t * const msg,
        const uint32_t len, struct event_proc_result &rsp) const
    {
        uint32_t headLen = sizeof(struct event_sync_msg);
        if (len < headLen) {
            aicpusd_err("len[%u], headLen[%u].", len, headLen);
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }
        struct event_sync_msg msgHead = {};
        auto ret = memcpy_s(&msgHead, headLen, msg, headLen);
        if (ret != 0) {
            aicpusd_err("Memcpy failed. ret[%d], size[%u].", ret, headLen);
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }
        struct event_summary backEvent = {};

        backEvent.dst_engine = msgHead.dst_engine;
        backEvent.policy = ONLY;
        backEvent.pid = msgHead.pid;
        backEvent.grp_id = msgHead.gid;
        backEvent.event_id =  static_cast<EVENT_ID>(msgHead.event_id);
        backEvent.subevent_id = msgHead.subevent_id;
        backEvent.msg_len = sizeof(struct event_proc_result);
        backEvent.msg = PtrToPtr<struct event_proc_result, char_t>(&rsp);
        const uint32_t deviceId = AicpuDrvManager::GetInstance().GetDeviceId();
        ret = halEschedSubmitEvent(deviceId, &backEvent);
        aicpusd_info("backEvent dst[%d], pid[%d], grpId[%d],  eventId[%d], subeventId[%d], msgLen[%d], deviceId[%u]",
            backEvent.dst_engine, backEvent.pid, backEvent.grp_id, backEvent.event_id,
            backEvent.subevent_id, backEvent.msg_len, deviceId);
        if (ret != 0) {
            aicpusd_err("halEschedSubmitEvent, ret=%d. dst[%d],pid[%d],"
                " grpId[%d], eventId[%d], subeventId[%d], msgLen[%d], deviceId[%u]",
                ret, backEvent.dst_engine, backEvent.pid, backEvent.grp_id,
                backEvent.event_id, backEvent.subevent_id, backEvent.msg_len, deviceId);
                return ret;
        }
        return AICPU_SCHEDULE_OK;
    }
}
int32_t CustProcessLoadPlatform(const struct event_info * const msg)
{
    if (msg == nullptr) {
        aicpusd_err("msg is nullptr.");
        return AicpuSchedule::AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    uint8_t message[EVENT_MAX_MSG_LEN] = {};
    auto ret = memcpy_s(message, EVENT_MAX_MSG_LEN, msg->priv.msg, msg->priv.msg_len);
    if (ret != 0) {
        aicpusd_err("Memcpy failed. ret[%d], size[%u].", ret, msg->priv.msg_len);
        return AicpuSchedule::AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    return AicpuSchedule::AicpuCustomSdLoadPlatformInfoProcess::GetInstance().ProcessLoadPlatform(message,
        EVENT_MAX_MSG_LEN);
}