/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <iostream>
#include <string>
#include <fstream>
#include <cstring>
#include <nlohmann/json.hpp>
#include "acl/acl.h"
#include "acl/acl_prof.h"
#include "ge_stub.h"
#include "data_report_manager.h"
#include "prof_api.h"
#include "slog.h"
#include "data_manager.h"
#include "msprof_stub.h"
#include "runtime/stream.h"
#include "prof_dev_api.h"
#include "prof_data_config.h"
#include "osal.h"
#include "utils.h"

int32_t BitCallbackHandle(uint32_t dataType, void *data, uint32_t dataLen)
{
    MSPROF_LOGD("start to execute ProcessBitSwitch");
    if (dataType == PROF_CTRL_SWITCH) {
        DataReportMgr().ProcessBitSwitch(data, dataLen);
    } else {
        MSPROF_LOGI("ProcessBitSwitch get Unsupported dataType = %u", dataType);
    }
    return 0;
};

int32_t AclCallbackHandle(uint32_t dataType, void *data, uint32_t dataLen)
{
    MSPROF_LOGD("start to execute ProcessAclSwitch");
    if (dataType == PROF_CTRL_SWITCH) {
        int32_t ret = DataReportMgr().ProcessAclSwitch(data, dataLen);
        if (ret != 0) {
            MSPROF_LOGE("Failed to call ProcessAclSwitch, ret = %d", ret);
            return ret;
        }
    } else {
        MSPROF_LOGI("ProcessAclSwitch get Unsupported dataType = %u", dataType);
    }
    return 0;
};

int32_t GeCallbackHandle(uint32_t dataType, void *data, uint32_t dataLen)
{
    MSPROF_LOGD("start to execute ProcessGeSwitch");
    if (dataType == PROF_CTRL_SWITCH) {
        int32_t ret = DataReportMgr().ProcessGeSwitch(data, dataLen);
        if (ret != 0) {
            MSPROF_LOGE("Failed to call ProcessGeSwitch, ret = %d", ret);
            return ret;
        }
    } else {
        MSPROF_LOGI("ProcessGeSwitch get Unsupported dataType = %u", dataType);
    }
    return 0;
};

int32_t AicpuCallbackHandle(uint32_t dataType, void *data, uint32_t dataLen)
{
    MSPROF_LOGD("start to execute ProcessAicpuSwitch");
    if (dataType == PROF_CTRL_SWITCH) {
        int32_t ret = DataReportMgr().ProcessAicpuSwitch(data, dataLen);
        if (ret != 0) {
            MSPROF_LOGE("Failed to call ProcessAicpuSwitch, ret = %d", ret);
            return ret;
        }
    } else {
        MSPROF_LOGI("ProcessAicpuSwitch get Unsupported dataType = %u", dataType);
    }
    return 0;
};

int32_t HcclCallbackHandle(uint32_t dataType, void *data, uint32_t dataLen)
{
    MSPROF_LOGD("start to execute ProcessHcclSwitch");
    if (dataType == PROF_CTRL_SWITCH) {
        int32_t ret = DataReportMgr().ProcessHcclSwitch(data, dataLen);
        if (ret != 0) {
            MSPROF_LOGE("Failed to call ProcessHcclSwitch, ret = %d", ret);
            return ret;
        }
    } else {
        MSPROF_LOGI("ProcessHcclSwitch get Unsupported dataType = %u", dataType);
    }
    return 0;
};

#ifndef MSPROF_C
// devprof 注册完驱动通道后回调此函数，aicpu 开始上报数据
static int32_t AicpuCallbackFunc(uint32_t type, void *data, uint32_t len)
{
    (void)type;
    (void)data;
    (void)len;
    MSPROF_EVENT("aicpu start reporte data to devprof");
    uint32_t agingFlag = 1;
    struct MsprofAdditionalInfo additionalInfo;
    additionalInfo.level = MSPROF_REPORT_AICPU_LEVEL;
    additionalInfo.type = MSPROF_REPORT_AICPU_NODE_TYPE;
    additionalInfo.threadId = 123;
    additionalInfo.dataLen = 1;
    additionalInfo.timeStamp = 123;
    additionalInfo.data[0] = 32;
    uint32_t length = sizeof(MsprofAdditionalInfo);

    for (uint32_t i = 0; i < 100; i++) {
        AdprofReportAdditionalInfo(agingFlag, static_cast<void *>(&additionalInfo), length);
        additionalInfo.type = MSPROF_REPORT_AICPU_DP_TYPE;
        AdprofReportAdditionalInfo(agingFlag, static_cast<void *>(&additionalInfo), length);
        additionalInfo.type = MSPROF_REPORT_AICPU_MODEL_TYPE;
        AdprofReportAdditionalInfo(agingFlag, static_cast<void *>(&additionalInfo), length);
        additionalInfo.type = MSPROF_REPORT_AICPU_MI_TYPE;
        AdprofReportAdditionalInfo(agingFlag, static_cast<void *>(&additionalInfo), length);
    }
    return 0;
}

int32_t HandleAicpu(void *data, uint32_t dataLen)
{
    (void)dataLen;
    constexpr uint32_t PROFILING_FEATURE_SWITCH = 0U;       // bit0 means profiling start or profiling stop
    constexpr uint32_t PROFILING_FEATURE_KERNEL_MODE = 1U;  // bit1 means profiling mode of kernel
    constexpr uint32_t PROFILING_FEATURE_MODEL_MODE = 2U;   // bit2 means profiling mode of model 
    constexpr uint32_t PROFILING_FEATURE_TIME = 3U;         // bit3 means l0
    constexpr uint32_t PROFILING_FEATURE_TIME_L1 = 4U;      // bit4 means l1
    constexpr uint32_t PROFILING_FEATURE_TIME_L2 = 5U;      // bit5 means l2

    constexpr uint64_t HIGH16_MASK = 0xFFFF000000000000U;

    MsprofCommandHandle *const profilerConfig = static_cast<MsprofCommandHandle *>(data);
    const uint64_t profConfig = profilerConfig->profSwitch;
    uint64_t profSwitchHi = profilerConfig->profSwitchHi & HIGH16_MASK;
    uint32_t high16 = (uint32_t)(profSwitchHi >> 32);
    const uint32_t type = profilerConfig->type;

    uint32_t profSwitch = 0U;
    if (type == PROF_COMMANDHANDLE_TYPE_START) {
        profSwitch |= (1U << PROFILING_FEATURE_SWITCH);
    }
    if ((profConfig & PROF_AICPU_TRACE_MASK) != 0UL) {
        profSwitch |= (1U << PROFILING_FEATURE_KERNEL_MODE);
    }
    if ((profConfig & PROF_AICPU_MODEL_MASK) != 0UL) {
        profSwitch |= (1U << PROFILING_FEATURE_MODEL_MODE);
    }
    if ((profConfig & PROF_TASK_TIME_MASK) != 0UL) {
        profSwitch |= (1U << PROFILING_FEATURE_TIME);
    }
    if ((profConfig & PROF_TASK_TIME_L1_MASK) != 0UL) {
        profSwitch |= (1U << PROFILING_FEATURE_TIME_L1);
    }
    if ((profConfig & PROF_TASK_TIME_L2_MASK) != 0UL) {
        profSwitch |= (1U << PROFILING_FEATURE_TIME_L2);
    }
    profSwitch |= high16;

    // runtime 触发 aicpu 向 devprof 注册 start，触发 devprof 调用驱动接口 prof_sample_register
    struct AicpuStartPara para = {0, (uint32_t)OsalGetPid(), 143, profSwitch}; // aicpu channel id:143
    (void)AdprofRegisterCallback(10086, &AicpuCallbackFunc);
    return AdprofInit(&para);
}
#endif

int32_t RuntimeCallbackHandle(uint32_t dataType, void *data, uint32_t dataLen)
{
    MSPROF_LOGD("start to execute ProcessRuntimeSwitch");
    if (dataType == PROF_CTRL_SWITCH) {
        int32_t ret = DataReportMgr().ProcessRuntimeSwitch(data, dataLen);
        if (ret != 0) {
            MSPROF_LOGE("Failed to call ProcessRuntimeSwitch, ret = %d", ret);
            return ret;
        }
        #ifndef MSPROF_C
        return HandleAicpu(data, dataLen);
        #endif
    } else {
        MSPROF_LOGI("ProcessRuntimeSwitch get Unsupported dataType = %u", dataType);
    }
    return 0;
};

#ifndef MSPROF_C
static int32_t MsprofStartByPureCpu(const MsprofConfig *cfg)
{
    int32_t ret = MsprofStart(MSPROF_CTRL_INIT_PURE_CPU, static_cast<const void *>(cfg), sizeof(MsprofConfig));
    if (ret != MSPROF_ERROR_NONE) {
        MSPROF_LOGE("Failed to MsprofStart by MSPROF_CTRL_INIT_PURE_CPU.");
        return -1;
    }
 
    MsprofRegisterCallback(GE, &GeCallbackHandle);
    MsprofCompactInfo data;
    data.type = MSPROF_REPORT_NODE_BASIC_INFO_TYPE;
    data.level = MSPROF_REPORT_NODE_LEVEL;
    MsprofRegTypeInfo(MSPROF_REPORT_NODE_LEVEL, data.type,  "node_basic_info");
    ret = MsprofReportCompactInfo(0, (void *)&data, sizeof(MsprofCompactInfo));
    if (ret != 0) {
        MSPROF_LOGE("Failed to report fake node_basic_info data.");
        return -1;
    }
 
    ret = MsprofStop(MSPROF_CTRL_INIT_PURE_CPU, static_cast<const void *>(cfg), sizeof(MsprofConfig));
    if (ret != MSPROF_ERROR_NONE) {
        MSPROF_LOGE("Failed to MsprofStop by MSPROF_CTRL_INIT_PURE_CPU.");
        return -1;
    }
    return 0;
}
#endif

aclError aclInit(const char *configPath)
{
    if (configPath == nullptr) {
        uint32_t dataLen=0;
        if (MsprofInit(MSPROF_CTRL_INIT_DYNA, nullptr, dataLen) != 0) {
            (void)MsprofFinalize();
            return ACL_ERROR_INVALID_PARAM;
        }
    } else {
        std::ifstream in(configPath);
        nlohmann::json data;
        in >> data;
        in.close();
        if (data.find("training_trace") != data.end()) {
            std::string geOption = data.dump();
            MsprofGeOptions options;
            strcpy(options.jobId, "jobId");
            for (size_t i = 0; i < geOption.size(); i++) {
                options.options[i] = geOption.at(i);
            }
            auto jsonData = (void *)&options;
            if (MsprofInit(MSPROF_CTRL_INIT_GE_OPTIONS, jsonData, sizeof(options)) != 0) {
                (void)MsprofFinalize();
                return -1;
            }
        } else {
            std::string aclJson = data.dump();
            auto jsonData = (void *)(const_cast<char *>(aclJson.c_str()));
            if (MsprofInit(MSPROF_CTRL_INIT_ACL_JSON, jsonData, aclJson.size()) != 0) {
                (void)MsprofFinalize();
                return -1;
            }
        }
    }

    uint32_t BITSWITCH = 31; // use PROFILING in slog.h
    MsprofRegisterCallback(BITSWITCH, &BitCallbackHandle);
    MsprofRegisterCallback(ASCENDCL, &AclCallbackHandle);
    MsprofRegisterCallback(GE, &GeCallbackHandle);
    MsprofRegisterCallback(AICPU, &AicpuCallbackHandle);
    MsprofRegisterCallback(HCCL, &HcclCallbackHandle);
    MsprofRegisterCallback(RUNTIME, &RuntimeCallbackHandle);
#ifndef MSPROF_C
    if (DataReportMgr().GetMsprofTx()) {
        auto ret = aclprofCreateStamp();
        if (ret == nullptr) {
            (void)MsprofFinalize();
            return ACL_ERROR_INVALID_PARAM;
        }
        MSPROF_EVENT("Success to CreateStamp for msproftx");
    }
#endif
    return ACL_ERROR_NONE;
}

aclError aclrtSetDevice(int32_t deviceId)
{
    if (MsprofNotifySetDevice(0, deviceId, true) != 0){
        (void)MsprofFinalize();
        return ACL_ERROR_INVALID_PARAM;
    }
    return ACL_ERROR_NONE;
}

aclError aclrtResetDevice(int32_t deviceId)
{
    if (MsprofNotifySetDevice(0, deviceId, false) != 0){
        (void)MsprofFinalize();
        return ACL_ERROR_INVALID_PARAM;
    }
    return ACL_ERROR_NONE;
}

aclError aclmdlLoadFromFile(const char * /* modelPath */, uint32_t *modelId)
{
    *modelId = DataMgr().GetModelId();
    auto ret = ge::LoadModel(modelId);
    if (ret != 0) {   
        return ACL_ERROR_INVALID_PARAM;
    }
    return ACL_ERROR_NONE;
}

aclError aclmdlUnload(uint32_t modelId)
{
    auto ret = ge::UnloadModel(modelId);
    if (ret != 0) {
        return ACL_ERROR_INVALID_PARAM;
    }
    return ACL_ERROR_NONE;
}

aclError aclmdlExecute(uint32_t modelId, const aclmdlDataset * /* input */, aclmdlDataset * /* output */)
{
    return ge::ExecuteModel(modelId);
}

aclError aclnnGlu()
{
    return ge::ExecuteOp();
}

aclError aclFinalize()
{
    if (MsprofFinalize() != 0) {
        return ACL_ERROR_INVALID_PARAM;
    }
#ifndef MSPROF_C
    if (DataReportMgr().GetMsprofConfig() == StProfConfigType::PROF_CONFIG_PURE_CPU) {
        MSPROF_EVENT("Begin to start with msprof config.");
        ClearSingleton();
        MsprofConfig *cfg = DataReportMgr().GetMsprofConfigData();
        if (MsprofStartByPureCpu(cfg) != 0) {
            MSPROF_LOGE("Failed to MsprofStartByPureCpu.");
            return ACL_ERROR_INVALID_PARAM;
        }
    }
#endif
    return ACL_ERROR_NONE;
}