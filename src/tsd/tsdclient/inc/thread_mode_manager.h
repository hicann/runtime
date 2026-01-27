/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef INNER_INC_THREAD_MODE_MANAGER_H
#define INNER_INC_THREAD_MODE_MANAGER_H

#include "inc/client_manager.h"
#include "prof_api.h"

namespace tsd {
using StartAICPU = int32_t (*)(uint32_t, int32_t, ProfilingMode);
using StopAICPU = int32_t (*)(uint32_t, int32_t);
using UpdateProfiling = int32_t (*)(uint32_t, int32_t, uint32_t);
using SetAICPUCallback = int32_t (*)(MsprofReporterCallback);
using StartQS = int32_t (*)(uint32_t, uint32_t);
using StartAdprof = int32_t (*)(int32_t argc, const char *argv);
using StopAdprof = int32_t (*)();
class ThreadModeManager : public ClientManager {
public:
    explicit ThreadModeManager(const uint32_t &deviceId);

    /**
     * @ingroup ClientManager
     * @brief start hccp and computer_process
     * @param [in] logicDeviceId : logicDeviceId
     * @param [in] rankSize : always be 0 in thread_mode
     * @return TSD_OK when SUCCESS
     */
    TSD_StatusT Open(const uint32_t rankSize) override;

    /**
     * @ingroup ClientManager
     * @brief start hccp and computer_process
     * @param [in] logicDeviceId : logicDeviceId
     * @return TSD_OK when SUCCESS
     */
    TSD_StatusT OpenAicpuSd() override;

    /**
     * @ingroup ThreadModeManager
     * @brief close hccp and computer_process
     * @param [in] flag : tsd close flag
     * @return TSD_OK when SUCCESS
     */
    TSD_StatusT Close(const uint32_t flag) override;

    /**
     * @ingroup ThreadModeManager
     * @brief used for profiling
     * @param flag : control number
     * @return TSD_OK when SUCCESS
     */
    TSD_StatusT UpdateProfilingConf(const uint32_t &flag) override;

    TSD_StatusT InitQs(const InitFlowGwInfo * const initInfo) override;
    
    ~ThreadModeManager() override;

    /**
     * @ingroup ThreadModeManager
     * @brief  used for release resource when error occured
     * @return TSD_OK when SUCCESS
     */
    void Destroy() override;
    /**
     * @ingroup ProcessModeManager
     * @brief tsd capablity apply
     * @return TSD_OK when success
     */
    TSD_StatusT CapabilityGet(const int32_t type, const uint64_t ptr) override;

    TSD_StatusT LoadFileToDevice(const char_t *const filePath, const uint64_t pathLen, const char_t *const fileName,
                                 const uint64_t fileNameLen) override;

    TSD_StatusT ProcessOpenSubProc(ProcOpenArgs *openArgs) override;

    TSD_StatusT ProcessCloseSubProc(const pid_t closePid) override;

    TSD_StatusT GetSubProcStatus(ProcStatusInfo *pidInfo, const uint32_t arrayLen) override;

    TSD_StatusT RemoveFileOnDevice(const char_t *const filePath, const uint64_t pathLen) override;

    TSD_StatusT NotifyPmToStartTsdaemon() override;

    TSD_StatusT ProcessCloseSubProcList(const ProcStatusParam *closeList, const uint32_t listSize) override;

    TSD_StatusT GetSubProcListStatus(ProcStatusParam *pidInfo, const uint32_t arrayLen) override;

    TSD_StatusT OpenNetService(const NetServiceOpenArgs *args) override;

    TSD_StatusT CloseNetService() override;
private:
    /**
     * @ingroup ThreadModeManager
     * @brief carry aicpu ops package to device
     * @return TSD_OK when SUCCESS
     */
    TSD_StatusT LoadSysOpKernel();

    /**
     * @ingroup ThreadModeManager
     * @brief run cp
     * @return TSD_OK when SUCCESS
     */
    TSD_StatusT StartCallAICPU();

    /**
     * @ingroup TsdClient
     * @brief set aicpu profiling callback
     * @return void
     */
    void SetAICPUProfilingCallback() const;

    /**
     * @ingroup TsdClient
     * @brief unzip aicpu kernel package
     * @return void
     */
    TSD_StatusT HandleAICPUPackage(const uint32_t packageType) const;

    TSD_StatusT StartCallQS(const uint32_t logicDeviceId);
    void OpenTfSo(const uint32_t vfId);
    StartAICPU startAicpu_;
    StopAICPU stopAicpu_;
    UpdateProfiling updateProfiling_;
    SetAICPUCallback setAicpuCallback_;
    void *handle_;
    int32_t vfId_;
    void *qsHandle_;
    void *tfSoHandle_;
    StartQS startQs_;
    void *adprofHandle_;
    StartAdprof startAdprof_;
    StopAdprof stopAdprof_;
};
}  // namespace tsd
#endif // INNER_INC_THREAD_MODE_MANAGER_H
