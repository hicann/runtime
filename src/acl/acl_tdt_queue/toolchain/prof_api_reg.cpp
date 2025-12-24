/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "prof_api_reg.h"
#include <mutex>
#include <unordered_set>
#include <map>
#include "mmpa/mmpa_api.h"
#include "runtime/base.h"
#include "common/log_inner.h"

namespace {
    static bool g_profRun = false;
    static std::mutex g_profMutex;
    static std::unordered_set<uint32_t> g_deviceList;
    constexpr uint64_t ACL_PROF_ACL_API = 0x0001U;
    constexpr uint32_t START_PROFILING = 1U;
    constexpr uint32_t STOP_PROFILING = 2U;

    static bool IsDumpToStdEnabled() {
        const char *profilingToStdOut = nullptr;
        MM_SYS_GET_ENV(MM_ENV_GE_PROFILING_TO_STD_OUT, profilingToStdOut);
        return profilingToStdOut != nullptr;
    }

    static const std::map<acl::AclTdtQueueProfType, std::string> TDT_QUEUE_PROF_TYPE_TO_NAMES = {
        {acl::AclTdtQueueProfType::AcltdtEnqueue,                            "acltdtEnqueue"},
        {acl::AclTdtQueueProfType::AcltdtDequeue,                            "acltdtDequeue"},
        {acl::AclTdtQueueProfType::AcltdtEnqueueData,                        "acltdtEnqueueData"},
        {acl::AclTdtQueueProfType::AcltdtDequeueData,                        "acltdtDequeueData"},
    };

    static aclError RegisterProfType() {
        for (auto &iter : TDT_QUEUE_PROF_TYPE_TO_NAMES) {
            uint32_t typeId = static_cast<uint32_t>(iter.first);
            const auto ret = MsprofRegTypeInfo(MSPROF_REPORT_ACL_LEVEL, typeId, iter.second.c_str());
            if (ret != MSPROF_ERROR_NONE) {
                ACL_LOG_CALL_ERROR("Registered api type [%u] failed = %d", typeId, ret);
                return ACL_ERROR_PROFILING_FAILURE;
            }
        }
        return ACL_SUCCESS;
    }

    static aclError AddDeviceList(const uint32_t *const deviceIdList, const uint32_t deviceNums)
    {
        ACL_REQUIRES_NOT_NULL(deviceIdList);
        for (size_t devId = 0U; devId < deviceNums; devId++) {
            if (g_deviceList.count(*(deviceIdList + devId)) == 0U) {
                (void)g_deviceList.insert(*(deviceIdList + devId));
                ACL_LOG_INFO("device id %u is successfully added in acl profiling", *(deviceIdList + devId));
            }
        }
        return ACL_SUCCESS;
    }

    static aclError RemoveDeviceList(const uint32_t *const deviceIdList, const uint32_t deviceNums)
    {
        ACL_REQUIRES_NOT_NULL(deviceIdList);
        for (size_t devId = 0U; devId < deviceNums; devId++) {
            const auto iter = g_deviceList.find(*(deviceIdList + devId));
            if (iter != g_deviceList.end()) {
                (void)g_deviceList.erase(iter);
                ACL_LOG_INFO("device id %u is successfully deleted from acl profiling", *(deviceIdList + devId));
            }
        }
        return ACL_SUCCESS;
    }

    static aclError ProfInnerStart(const rtProfCommandHandle_t *const profilerConfig)
    {
        ACL_LOG_INFO("start to execute ProfInnerStart");
        if (!g_profRun) {
            RegisterProfType();
            g_profRun = true;
        }
        (void)AddDeviceList(profilerConfig->devIdList, profilerConfig->devNums);
        ACL_LOG_INFO("successfully execute ProfInnerStart");
        return ACL_SUCCESS;
    }

    static aclError ProfInnerStop(const rtProfCommandHandle_t *const profilerConfig)
    {
        ACL_LOG_INFO("start to execute ProfInnerStop");
        (void)RemoveDeviceList(profilerConfig->devIdList, profilerConfig->devNums);

        if (g_deviceList.empty() && g_profRun) {
            g_profRun = false;
        }
        ACL_LOG_INFO("successfully execute ProfInnerStop");
        return ACL_SUCCESS;
    }

    static aclError ProcessProfData(void *const data, const uint32_t len)
    {
        ACL_LOG_INFO("start to execute ProcessProfData");
       const std::lock_guard<std::mutex> lk(g_profMutex);
        ACL_REQUIRES_NOT_NULL(data);
        constexpr size_t commandLen = sizeof(rtProfCommandHandle_t);
        if (len < commandLen) {
            ACL_LOG_INNER_ERROR("[Check][Len]len[%u] is invalid, it should not be smaller than %zu", len, commandLen);
            return ACL_ERROR_INVALID_PARAM;
        }
        rtProfCommandHandle_t *const profilerConfig = static_cast<rtProfCommandHandle_t *>(data);
        aclError ret = ACL_SUCCESS;
        const uint64_t profSwitch = profilerConfig->profSwitch;
        const uint32_t type = profilerConfig->type;
        if (((profSwitch & ACL_PROF_ACL_API) != 0U) && (type == START_PROFILING)) {
            ret = ProfInnerStart(profilerConfig);
        }
        if (((profSwitch & ACL_PROF_ACL_API) != 0U) && (type == STOP_PROFILING)) {
            ret = ProfInnerStop(profilerConfig);
        }

        return ret;
    }

    class AclRegProfCallback {
    public:
        AclRegProfCallback() {
            const auto profRet = MsprofRegisterCallback(ASCENDCL, &acl::AclTdtQueueProfCtrlHandle);
            if (profRet != 0) {
                ACL_LOG_ERROR("can not register Callback, prof result = %d", profRet);
            }
        }
        ~AclRegProfCallback() {}
    };
    static AclRegProfCallback g_profCbReg;
}

namespace acl {
    aclError AclTdtQueueProfCtrlHandle(uint32_t dataType, void *data, uint32_t dataLen)
    {
        ACL_REQUIRES_NOT_NULL(data);

        if (dataType == RT_PROF_CTRL_SWITCH) {
            const aclError ret = ProcessProfData(data, dataLen);
            if (ret != ACL_SUCCESS) {
                ACL_LOG_INNER_ERROR("[Process][ProfSwitch]failed to call ProcessProfData, result is %u", ret);
                return ret;
            }
            return ACL_SUCCESS;
        }
 
        ACL_LOG_INFO("get unsupported dataType %u while processing profiling data", dataType);
        return ACL_SUCCESS;
    }

    AclTdtQueueProfilingReporter::AclTdtQueueProfilingReporter(const AclTdtQueueProfType apiId) : aclApi_(apiId)
    {
        if (g_profRun && (!IsDumpToStdEnabled())) {
            startTime_ = MsprofSysCycleTime();
        }
    }

    AclTdtQueueProfilingReporter::~AclTdtQueueProfilingReporter() noexcept
    {
        if (g_profRun && (!IsDumpToStdEnabled()) && (startTime_ != 0UL)) {
            // 1000 ^ 3 converts second to nanosecond
            const uint64_t endTime = MsprofSysCycleTime();
            MsprofApi api{};
            api.beginTime = startTime_;
            api.endTime = endTime;
            thread_local static auto tid = mmGetTid();
            api.threadId = static_cast<uint32_t>(tid);
            api.level = MSPROF_REPORT_ACL_LEVEL;
            api.type = static_cast<uint32_t>(aclApi_);
            (void)MsprofReportApi(true, &api);
        }
    }
}  // namespace acl
