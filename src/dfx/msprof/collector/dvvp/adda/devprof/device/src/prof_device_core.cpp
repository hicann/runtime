/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "prof_device_core.h"
#include <memory>
#include "collection_entry.h"
#include "config/config.h"
#include "errno/error_code.h"
#include "msprof_dlog.h"
#include "param_validation.h"
#include "task_manager.h"
#include "utils/utils.h"
#include "adx_prof_api.h"

using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::config;
using namespace analysis::dvvp::common::validation;

int32_t IdeDeviceProfileInit()
{
    MSPROF_EVENT("Begin to init profiling");
    int32_t ret = PROFILING_FAILED;

    do {
        // try the block to catch the exceptions
        MSVP_TRY_BLOCK(ret = analysis::dvvp::device::CollectionEntry::instance()->Init(), break);
        if (ret != PROFILING_SUCCESS) {
            MSPROF_LOGE("CollectionEntry instance init failed");
            break;
        }
        // try the block to catch the exceptions
        MSVP_TRY_BLOCK(ret = analysis::dvvp::device::TaskManager::instance()->Init(), break);
    } while (0);
    MSPROF_EVENT("End to init profiling, ret:%d", ret);
    return ret;
}

int32_t IdeDeviceProfileProcess(HDC_SESSION session, CONST_TLV_REQ_PTR req)
{
    MSPROF_EVENT("Begin to process profiling");
    int32_t ret = PROFILING_FAILED;
    do {
        if (session == nullptr) {
            MSPROF_LOGE("HDC session is invalid");
            break;
        }

        if ((req == nullptr) || (req->len <= 0) || (req->len > PROFILING_PACKET_MAX_LEN)) {
            MSPROF_LOGE("HDC request is invalid");
            Analysis::Dvvp::Adx::AdxHdcSessionClose(session);
            session = nullptr;
            break;
        }

        int32_t devIndexId = 0;
        int32_t err = Analysis::Dvvp::Adx::AdxIdeGetDevIdBySession(session, &devIndexId);
        if (err != IDE_DAEMON_OK) {
            MSPROF_LOGE("IdeGetDevIdBySession failed, err: %d", err);
            Analysis::Dvvp::Adx::AdxHdcSessionClose(session);
            session = nullptr;
            break;
        }
        if (!ParamValidation::instance()->CheckDeviceIdIsValid(std::to_string(devIndexId))) {
            MSPROF_LOGE("[IdeDeviceProfileProcess]devIndexId is not valid! devIndexId: %d", devIndexId);
            Analysis::Dvvp::Adx::AdxHdcSessionClose(session);
            session = nullptr;
            break;
        }

        auto transport = analysis::dvvp::transport::HDCTransportFactory().CreateHdcTransport(session);
        if (transport == nullptr) {
            MSPROF_LOGE("create HDC transport failed");
            Analysis::Dvvp::Adx::AdxHdcSessionClose(session);
            session = nullptr;
            break;
        }

        int32_t vfId = 0;
        int32_t retVf = Analysis::Dvvp::Adx::AdxIdeGetVfIdBySession(session, vfId);
        if (retVf != IDE_DAEMON_OK) {
            MSPROF_LOGE("Ide get vfid by session failed, ret=%d.", retVf);
            break;
        }
        if (vfId != 0) {
            MSPROF_LOGW("Prohibit container operate profiling, vfId=%d.", vfId);
            if (transport->SendBuffer(CONTAINER_NO_SUPPORT_MESSAGE.c_str(),
                CONTAINER_NO_SUPPORT_MESSAGE.size()) == -1) {
                MSPROF_LOGE("Transport send buffer failed.");
                break;
            }
            ret = PROFILING_SUCCESS;
            break;
        }

        MSPROF_LOGI("device %d step handle function", devIndexId);

        // try the block to catch the exceptions
        MSVP_TRY_BLOCK(ret = analysis::dvvp::device::CollectionEntry::instance()->Handle(
                       transport, std::string(req->value, req->len), devIndexId), break);
    } while (0);
    MSPROF_EVENT("End to process profiling, ret:%d", ret);
    return ret;
}

int32_t IdeDeviceProfileCleanup()
{
    MSPROF_EVENT("Begin to cleanup profiling");
    int32_t ret = PROFILING_FAILED;

    do {
        // try the block to catch the exceptions
        MSVP_TRY_BLOCK(ret = analysis::dvvp::device::CollectionEntry::instance()->Uinit(), break);
        if (ret != PROFILING_SUCCESS) {
            MSPROF_LOGE("CollectionEntry instance unInit failed");
        }
        // try the block to catch the exceptions
        MSVP_TRY_BLOCK(ret = analysis::dvvp::device::TaskManager::instance()->Uninit(), break);
    } while (0);
    MSPROF_EVENT("End to cleanup profiling, ret:%d", ret);
    return ret;
}
