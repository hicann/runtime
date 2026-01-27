/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "inc/aicpu_thread_mode_manager.h"

#include "inc/internal_api.h"

 namespace tsd {
    namespace {
        const std::string AICPU_THREAD_LOG_OFF_SWITCH = "AICPU_APP_LOG_SWITCH";
        const std::string AICPU_THREAD_LOG_OFF_SWITCH_VALUE = "0";

    }
    AicpuThreadModeManager::AicpuThreadModeManager(const uint32_t &deviceId, const uint32_t deviceMode)
        :ProcessModeManager(deviceId, deviceMode),
         threadInstance_(deviceId),
         deviceId_(deviceId),
         runningStat_(SUB_PROCESS_STATUS_MAX)
    {
        TSD_RUN_INFO("construct AicpuThreadModeManager finish deviceId:%u", deviceId_);
    }

    TSD_StatusT AicpuThreadModeManager::Open(const uint32_t rankSize)
    {
        TSD_RUN_INFO("[AicpuThreadMode] enter into open process deviceId[%u] rankSize[%u]", deviceId_, rankSize);
        int32_t envRet = 0;
        MM_SYS_SET_ENV(MM_ENV_AICPU_APP_LOG_SWITCH, AICPU_THREAD_LOG_OFF_SWITCH_VALUE.c_str(), 1, envRet);
        TSD_RUN_INFO("set env:%s,value:%s,ret:%d", AICPU_THREAD_LOG_OFF_SWITCH.c_str(),
                     AICPU_THREAD_LOG_OFF_SWITCH_VALUE.c_str(), envRet);
        SetAicpuHeterogeneousThreadMode(true);
        const auto ret = threadInstance_.Open(rankSize);
        TSD_RUN_INFO("[AicpuThreadMode] open process success deviceId[%u] rankSize[%u]", deviceId_, rankSize);
        if (ret == TSD_OK) {
            runningStat_ = SUB_PROCESS_STATUS_NORMAL;
        } else {
            runningStat_ = SUB_PROCESS_STATUS_EXITED;
        }
        return ret;
    }

    TSD_StatusT AicpuThreadModeManager::Close(const uint32_t flag)
    {
        TSD_RUN_INFO("[AicpuThreadMode] enter into close process deviceId[%u]", deviceId_);
        ProcessModeManager::Close(flag);
        const auto ret = threadInstance_.Close(flag);
        TSD_RUN_INFO("[AicpuThreadMode] close process success deviceId[%u] ", deviceId_);
        return ret;
    }

    TSD_StatusT AicpuThreadModeManager::GetHdcConctStatus(int32_t &hdcSessStat)
    {
        hdcSessStat = HDC_SESSION_STATUS_CONNECT;
        return TSD_OK;
    }

    AicpuThreadModeManager::~AicpuThreadModeManager()
    {
        TSD_RUN_INFO("[AicpuThreadMode] AicpuThreadMode deleted deviceId[%u]", deviceId_);
    }

    TSD_StatusT AicpuThreadModeManager::ProcessCloseSubProcList(const ProcStatusParam *closeList,
                                                                const uint32_t listSize)
    {
        TSD_RUN_INFO("[AicpuThreadMode] enter into ProcessCloseSubProcList deviceId[%u]", deviceId_);
        bool isNeedServerCheck = false;
        for (uint32_t index = 0; index < listSize; index++) {
            TSD_RUN_INFO("close process proctype:%u, pid:%d", closeList[index].procType, closeList[index].pid);
            if ((closeList[index].procType == TSD_SUB_PROC_COMPUTE) ||
                (closeList[index].procType == TSD_SUB_PROC_PROXY)) {
                runningStat_ = SUB_PROCESS_STATUS_EXITED;
            } else if (closeList[index].procType == TSD_SUB_PROC_QUEUE_SCHEDULE) {
                TSD_RUN_INFO("[AicpuThreadMode] current mode does not support pull/close qs deviceId[%u]", deviceId_);
            } else {
                isNeedServerCheck = true;
            }
        }

        if (isNeedServerCheck) {
            int32_t hdcSessStat = HDC_SESSION_STATUS_CONNECT;
            DetectAndReconnectToServer(hdcSessStat, false);
            if (hdcSessStat == HDC_SESSION_STATUS_CONNECT) {
                return ProcessModeManager::ProcessCloseSubProcList(closeList, listSize);
            }
        }
        TSD_RUN_INFO("[AicpuThreadMode] leave ProcessCloseSubProcList deviceId[%u]", deviceId_);
        return TSD_OK;
    }

    TSD_StatusT AicpuThreadModeManager::GetSubProcListStatus(ProcStatusParam *pidInfo, const uint32_t arrayLen)
    {
        if ((pidInfo == nullptr) || (arrayLen == 0U)) {
            TSD_ERROR("input param error");
            return TSD_INTERNAL_ERROR;
        }

        bool isNeedServerCheck = false;
        for (uint32_t index = 0; index < arrayLen; index++) {
            if ((pidInfo[index].procType == TSD_SUB_PROC_COMPUTE) || (pidInfo[index].procType == TSD_SUB_PROC_PROXY)) {
                pidInfo[index].curStat = runningStat_;
            } else if (pidInfo[index].procType == TSD_SUB_PROC_QUEUE_SCHEDULE) {
                pidInfo[index].curStat = SUB_PROCESS_STATUS_UNKNOW;
            } else {
                isNeedServerCheck = true;
            }
        }
        TSD_StatusT ret = TSD_OK;
        if (isNeedServerCheck) {
            int32_t hdcSessStat = HDC_SESSION_STATUS_CONNECT;
            DetectAndReconnectToServer(hdcSessStat, false);
            if (hdcSessStat == HDC_SESSION_STATUS_CONNECT) {
                ret = ProcessModeManager::GetSubProcListStatus(pidInfo, arrayLen);
            }
        }
        return ret;
    }
    TSD_StatusT AicpuThreadModeManager::UpdateProfilingConf(const uint32_t &flag)
    {
        TSD_RUN_INFO("[AicpuThreadMode] enter into UpdateProfilingConf deviceId[%u]", deviceId_);
        const auto ret = threadInstance_.UpdateProfilingConf(flag);
        TSD_RUN_INFO("[AicpuThreadMode] leave into UpdateProfilingConf deviceId[%u] ret[%d]", deviceId_, ret);
        return ret;
    }

    TSD_StatusT AicpuThreadModeManager::ProcessOpenSubProc(ProcOpenArgs *openArgs)
    {
        TSD_RUN_INFO("[AicpuThreadMode] enter into ProcessOpenSubProc deviceId[%u]", deviceId_);
        // 处理helper tsd 故障恢复场景
        int32_t hdcSessStat = HDC_SESSION_STATUS_CONNECT;
        DetectAndReconnectToServer(hdcSessStat, true);
        const TSD_StatusT ret = ProcessModeManager::ProcessOpenSubProc(openArgs);
        TSD_RUN_INFO("[AicpuThreadMode] leave into ProcessOpenSubProc deviceId[%u] ret[%d]", deviceId_, ret);
        return ret;
    }

    void AicpuThreadModeManager::DetectAndReconnectToServer(int32_t &hdcSessStat, const bool needConect)
    {
        const auto statRet = ProcessModeManager::GetHdcConctStatus(hdcSessStat);
        if ((statRet != TSD_OK) || (hdcSessStat != HDC_SESSION_STATUS_CONNECT)) {
            TSD_RUN_INFO("need init tsdclient again ret:%u, hdcSessStat:%d", statRet, hdcSessStat);
            if (needConect) {
                ProcessModeManager::DestroyHdcClientConnectChannel();
                ProcessModeManager::InitTsdClient();
            }
        } else {
            TSD_INFO("check tsdclient ok ret:%u, hdcSessStat:%d", statRet, hdcSessStat);
        }
    }
}