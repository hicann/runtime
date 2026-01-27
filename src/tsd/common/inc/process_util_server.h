/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef TDT_COMMON_COMMON_INC_PROCESS_UTIL_SERVER_H
#define TDT_COMMON_COMMON_INC_PROCESS_UTIL_SERVER_H
#include <map>
#include <functional>
#include "tsd/status.h"
#include "inc/tsd_event_interface.h"
#include "inc/internal_api.h"
#include "driver/ascend_hal_define.h"

namespace tsd {
    using SetSecCtx = int (*)(const char *);

    enum class AICPUSDPlat {
        AICPUSD_ONLINE_PLAT = 0,
        AICPUSD_OFFLINE_PLAT,
        AICPUSD_MAX_PLAT,
    };
    class ProcessUtilServer {
    public:
        static TSD_StatusT BindHostPidAndSubProcess(const TsdSubProcessType procType, const uint32_t devId,
                                                    const int32_t vfId, const uint32_t hostpid,
                                                    const int32_t subProcId);

        static TSD_StatusT ReconnectedToDatamster(const int32_t dmPid);

        static void SetSubProcessMemPolicy(uint32_t devId);

        static TSD_StatusT UnBindHostPid(const TsdSubProcessType procType, const uint32_t devId,
            const int32_t vfId, const uint32_t hostpid, const int32_t subProcId);

        static bool IsNeedSetMemPolicy();

        static void SetMempolicy(int32_t mode, const unsigned long *nodemask, unsigned long maxnode);

        static TSD_StatusT WaitPidForSubProcess(const uint32_t subProcPid, const bool isNeedReport);

        static TSD_StatusT WaitSubProcPid(const uint32_t subProcPid, const uint32_t waitCnt);

        static void KillProcessByTerm(const std::vector<uint32_t> &pidVec, const uint32_t termWaitCnt,
                                      const uint32_t sigKillWaitCnt);

        static bool WaitPidOnce(const pid_t pid);

        static TSD_StatusT GetNumNodeMemInfo(const std::string &numaFileName, const std::string &infoPreFix,
                                             uint64_t &infoValue);

        static TSD_StatusT AddSubProcessToGroups(const int32_t &pid,
                                                 const std::map<std::string, GroupShareAttr> &groups);

        static TSD_StatusT SetCustAicpuSecurityCtx();

        static bool IsHeterogeneousRemote();

        static bool Is310P();

        static devdrv_process_type ParseSubProcTypeToDrvType(const TsdSubProcessType procType);

        static TSD_StatusT BuildBindParaInfo(struct drvBindHostpidInfo &para, const TsdSubProcessType procType,
                                             const uint32_t devId, const int32_t vfId, const uint32_t hostpid,
                                             const int32_t subProcId);

        static void GetProcessRunningStat(std::string &statusFile);

        static void AddToFrameWorkGroup();

        static void LoadFileAndSetEnv(const std::string &fileName);

        static bool IsSupportAicpuCustSafeStart();

        static bool IsSupportAicpuCustVfMode();

        static bool IsSupportAicpuCustVDeviceMode();

        static TSD_StatusT GetHostGrpName(std::map<std::string, GroupShareAttr> &appGroupNameList,
                                          std::string &appGroupNameStr, const uint32_t fmkPid);
        static bool IsValidEventType(const uint32_t eventType, const bool isCust);

        static bool SetShedPolicyFIFO(std::vector<pid_t> threadIdList);

        static bool IsSupportSetFIFOMode();

        static bool CheckSubProcValid(const int32_t *subProcId, const int32_t basePid);
    };
} // namespace tsd
#endif // TDT_COMMON_COMMON_INC_PROCESS_UTIL_SERVER_H
