/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "msprof_manager.h"

#include <memory>
#include <unordered_map>
#include "securec.h"

namespace bqs {
namespace {
const std::string PROFILING_RESULT_DIR = "/var/log/npu/profiling/";
}

BqsMsprofManager &BqsMsprofManager::GetInstance()
{
    static BqsMsprofManager instance;
    return instance;
}

void BqsMsprofManager::InitBqsMsprofManager(const bool initFlag, const std::string &cfgData)
{
    if (!initFlag) {
        DGW_LOG_RUN_INFO("[Prof]Profiling flag set to false, will not start.");
        return;
    }

    if (!BqsMsprofApiAdapter::GetInstance().IsSoLoad()) {
        DGW_LOG_ERROR("[Prof]Profiling flag set to true but so load failed.");
        return;
    }

    ProfStatus ret = RegProfCallback();
    if (ret != ProfStatus::PROF_SUCCESS) {
        DGW_LOG_ERROR("[Prof]Regist profiling callback failed, ret=%d", static_cast<int32_t>(ret));
        return;
    }

    ret = InitProf(cfgData);
    if (ret != ProfStatus::PROF_SUCCESS) {
        DGW_LOG_ERROR("[Prof]Init msprof failed, ret=%d, cfgData=%s.", static_cast<int32_t>(ret), cfgData.c_str());
        return;
    }

    ret = RegProfType();
    if (ret != ProfStatus::PROF_SUCCESS) {
        DGW_LOG_ERROR("[Prof]Regist profiling type failed, ret=%d", static_cast<int32_t>(ret));
        return;
    }

    DGW_LOG_RUN_INFO("[Prof]Queue schedule profiling init success, cfgData=%s.", cfgData.c_str());

    return;
}

ProfStatus BqsMsprofManager::RegProfCallback() const
{
    const ProfStatus ret = BqsMsprofApiAdapter::GetInstance().MsprofRegisterCallback(AICPU, &ProfCallback);
    if (ret != ProfStatus::PROF_SUCCESS) {
        DGW_LOG_ERROR("[Prof]Regist profiling callback failed, ret=%d.", static_cast<int32_t>(ret));
        return ret;
    }

    DGW_LOG_RUN_INFO("[Prof]Regist profiling callback success.");

    return ret;
}

ProfStatus BqsMsprofManager::InitProf(const std::string &cfgData)
{
    std::shared_ptr<MsprofCommandHandleParams> profCfg = std::make_shared<MsprofCommandHandleParams>();
    if (profCfg == nullptr) {
        DGW_LOG_ERROR("[Prof]Malloc profiling config struct failed.");
        return ProfStatus::PROF_FAIL;
    }

    int32_t ret = memset_s(profCfg.get(), sizeof(*profCfg), 0, sizeof(*profCfg));
    if (ret != EOK) {
        DGW_LOG_ERROR("[Prof]Memset profiling config struct failed, ret=%d.", ret);
        return ProfStatus::PROF_FAIL;
    }

    const uint32_t cfgDataLen = cfgData.length();
    const uint32_t pathLen = PROFILING_RESULT_DIR.length();
    ret = strncpy_s(profCfg->profData, sizeof(profCfg->profData), cfgData.c_str(), cfgDataLen);
    ret |= strncpy_s(profCfg->path, sizeof(profCfg->path), PROFILING_RESULT_DIR.c_str(), pathLen);
    if (ret != EOK) {
        DGW_LOG_ERROR("[Prof]Copy data to profiling config failed, cfgDataLen=%u, pathLen=%u.", cfgDataLen, pathLen);
        return ProfStatus::PROF_FAIL;
    }

    profCfg->profDataLen = cfgDataLen;
    profCfg->pathLen = pathLen;
    profCfg->storageLimit = UINT32_MAX;

    ProfStatus profRet = BqsMsprofApiAdapter::GetInstance().MsprofInit(
        static_cast<uint32_t>(MSPROF_CTRL_INIT_PURE_CPU),
        profCfg.get(), sizeof(*profCfg));
    if (profRet != ProfStatus::PROF_SUCCESS) {
        DGW_LOG_ERROR("[Prof]Init msprof failed, ret=%d, profData=%s, profPath=%s, storageLimit=%u.",
                      static_cast<int32_t>(profRet), profCfg->profData, profCfg->path, profCfg->storageLimit);
        return profRet;
    }

    isInitMsprof_ = true;

    DGW_LOG_RUN_INFO("[Prof]Init msprof success, profData=%s, profPath=%s, storageLimit=%u.",
                  profCfg->profData, profCfg->path, profCfg->storageLimit);

    return ProfStatus::PROF_SUCCESS;
}

ProfStatus BqsMsprofManager::RegProfType() const
{
    const std::unordered_map<std::string, DgwProfInfoType> namesToProfTypes = {
        {"FlowGwHcclTransData", DgwProfInfoType::HCCL_TRANS_DATA},
        {"FlowGwAlloMbuf", DgwProfInfoType::ALLOC_MBUF},
        {"FlowGwEnqueueData", DgwProfInfoType::ENQUEUE_DATA},
    };

    for (const auto &name_pair : namesToProfTypes) {
        const ProfStatus ret = BqsMsprofApiAdapter::GetInstance().MsprofRegTypeInfo(
            static_cast<uint16_t>(MSPROF_REPORT_MODEL_LEVEL),
            static_cast<int32_t>(name_pair.second),
            name_pair.first.c_str());
        if (ret != ProfStatus::PROF_SUCCESS) {
            DGW_LOG_ERROR("[Prof]Regist profiling type failed, ret=%d, typeId=%d, typeName=%s.",
                          static_cast<int32_t>(ret), name_pair.second, name_pair.first.c_str());
            return ProfStatus::PROF_FAIL;
        }
    }

    DGW_LOG_RUN_INFO("[Prof]Regist profiling type success.");

    return ProfStatus::PROF_SUCCESS;
}

int32_t BqsMsprofManager::ProfCallback(uint32_t type, void *data, uint32_t dataLen)
{
    DGW_LOG_RUN_INFO("[Prof]Queue schedule start process profiling callback, type=%u.", type);

    if ((data == nullptr) || (dataLen < sizeof(MsprofCommandHandle))) {
        DGW_LOG_ERROR("[Prof]Prorfiling callback data is nullptr or dataLen is invalid, dataLen=%u.", dataLen);
        return static_cast<int32_t>(ProfStatus::PROF_INVALID_PARA);
    }

    const MsprofCommandHandle *const profCmdHandle = static_cast<MsprofCommandHandle *>(data);
    ProfStatus ret = ProfStatus::PROF_SUCCESS;
    switch (type) {
        case static_cast<uint32_t>(PROF_CTRL_SWITCH):
            ret = BqsMsprofManager::GetInstance().HandleCtrlSwitch(*profCmdHandle);
            break;
        case static_cast<uint32_t>(PROF_CTRL_REPORTER):
            ret = BqsMsprofManager::GetInstance().HandelCtrlReporter(*profCmdHandle);
            break;
        case static_cast<uint32_t>(PROF_CTRL_STEPINFO):
            ret = BqsMsprofManager::GetInstance().HandleCtrlStepInfo(*profCmdHandle);
            break;
        default:
            DGW_LOG_INFO("[Prof]Get unknown ctrl type, type=%u.", type);
            break;
    }

    return static_cast<int32_t>(ret);
}

ProfStatus BqsMsprofManager::HandleCtrlSwitch(const MsprofCommandHandle &profCmdHandle)
{
    const uint32_t type = profCmdHandle.type;
    DGW_LOG_INFO("[Prof]Start process prof ctrl switch, type=%u.", type);
    switch (type) {
        case static_cast<uint32_t>(PROF_COMMANDHANDLE_TYPE_START):
            isRun_ = true;
            DGW_LOG_RUN_INFO("[Prof]Start queue schedule profiling.");
            break;

        case static_cast<uint32_t>(PROF_COMMANDHANDLE_TYPE_STOP):
        case static_cast<uint32_t>(PROF_COMMANDHANDLE_TYPE_FINALIZE):
            isRun_ = false;
            DGW_LOG_RUN_INFO("[Prof]Stop queue schedule profiling.");
            break;

        case static_cast<uint32_t>(PROF_COMMANDHANDLE_TYPE_INIT):
        case static_cast<uint32_t>(PROF_COMMANDHANDLE_TYPE_MODEL_SUBSCRIBE):
        case static_cast<uint32_t>(PROF_COMMANDHANDLE_TYPE_MODEL_UNSUBSCRIBE):
        default:
            break;
    }

    return ProfStatus::PROF_SUCCESS;
}

ProfStatus BqsMsprofManager::HandelCtrlReporter(const MsprofCommandHandle &profCmdHandle) const
{
    (void)profCmdHandle;
    DGW_LOG_INFO("[Prof]Start process prof ctrl reporter.");
    return ProfStatus::PROF_SUCCESS;
}

ProfStatus BqsMsprofManager::HandleCtrlStepInfo(const MsprofCommandHandle &profCmdHandle) const
{
    (void)profCmdHandle;
    DGW_LOG_INFO("[Prof]Start process prof ctrl step info.");
    return ProfStatus::PROF_SUCCESS;
}

void BqsMsprofManager::ReportApiPerf(const ProfInfo &profData) const
{
    if (!isRun_) {
        return;
    }

    MsprofApi reportData;
    reportData.level = static_cast<uint16_t>(MSPROF_REPORT_MODEL_LEVEL);
    reportData.type = profData.type;
    reportData.threadId = GetTid();
    reportData.reserve = 0UL;
    reportData.beginTime = profData.timeStamp;
    reportData.endTime = GetTimeStamp();
    reportData.itemId = profData.itemId;

    const ProfStatus ret = BqsMsprofApiAdapter::GetInstance().MsprofReportApi(agingFlag_, &reportData);
    if (ret != ProfStatus::PROF_SUCCESS) {
        DGW_LOG_ERROR("[Prof]Report api failed, ret=%d, itemId=%lu", static_cast<int32_t>(ret), profData.itemId);
    }

    DGW_LOG_INFO("[Prof]Send api perf success, itemId=%lu, beginTime=%lu.", reportData.itemId, reportData.beginTime);

    return;
}

void BqsMsprofManager::ReportEventPerf(const ProfInfo &profData)
{
    if (!isRun_) {
        return;
    }

    ++requestId_;
    MsprofEvent reportData;
    reportData.level = static_cast<uint16_t>(MSPROF_REPORT_MODEL_LEVEL);
    reportData.type = profData.type;
    reportData.threadId = GetTid();
    reportData.requestId = requestId_.load();
    reportData.timeStamp = profData.timeStamp;
    reportData.itemId = profData.itemId;

    const ProfStatus ret = BqsMsprofApiAdapter::GetInstance().MsprofReportEvent(agingFlag_, &reportData);
    if (ret != ProfStatus::PROF_SUCCESS) {
        DGW_LOG_ERROR("[Prof]Report event failed, ret=%d, requestId=%u, itemId=%lu.",
                      static_cast<int32_t>(ret), reportData.requestId, reportData.itemId);
    }

    DGW_LOG_INFO("[Prof]Send event perf success, requestId=%u, itemId=%lu, timeStamp=%lu.",
                 reportData.requestId, reportData.itemId, reportData.timeStamp);

    return;
}

} // namespace bqs
