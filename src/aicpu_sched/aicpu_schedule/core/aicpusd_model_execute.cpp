/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "aicpusd_model_execute.h"
#include <algorithm>
#include <stack>
#include <cstring>
#include "aicpusd_resource_manager.h"
#include "aicpusd_drv_manager.h"
#include "aicpusd_monitor.h"
#include "aicpusd_profiler.h"
#include "aicpusd_info.h"
#include "aicpu_event_struct.h"
#include "type_def.h"
#include "profiling_adp.h"
#include "aicpusd_event_process.h"
#include "aicpusd_context.h"

namespace {
    constexpr uint32_t TLV_WITH_SHAPE = 1000;
    constexpr uint32_t TLV_WITH_DTYPE = 1001;
    constexpr uint32_t HCCL_COMM_TIMEOUT_CURSOR = 4U;
}
namespace AicpuSchedule {
    AicpuModelManager &AicpuModelManager::GetInstance()
    {
        static AicpuModelManager instance;
        return instance;
    }

    int32_t AicpuModelManager::ModelLoad(const AicpuModelInfo * const modelInfo, const ModelCfgInfo * const cfgInfo)
    {
        if (modelInfo == nullptr) {
            aicpusd_err("ModelLoad failed, as param is null.");
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }
        const auto modelId = modelInfo->moduleID;
        if (modelId >= MAX_MODEL_COUNT) {
            aicpusd_err("ModelLoad failed, as modelId[%u] is invalid.", modelId);
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }

        auto initType = HcclInitType::INIT_TYPE_NUM;
        if (cfgInfo != nullptr) {
            const auto hcclInitRet = InitHccl(cfgInfo, initType);
            if (hcclInitRet != AICPU_SCHEDULE_OK) {
                aicpusd_err("InitHccl fail");
                return static_cast<int32_t>(hcclInitRet);
            }
        }
        const auto ret = allModel_[modelId].ModelLoad(modelInfo, cfgInfo);
        if ((cfgInfo != nullptr) && (ret != static_cast<int32_t>(AICPU_SCHEDULE_OK))) {
            GuardHccl(initType);
        }
        return ret;
    }

    StatusCode AicpuModelManager::InitHcclForEmbedding(const ModelCfgInfo * const cfgInfo)
    {
        if (hcclCommEmbRefs_ == 0U) {
            const HcclResult ret = StubHcclInitCsComm(PtrToPtr<void, char_t>(ValueToPtr(cfgInfo->rankTableAddr)),
                cfgInfo->rankId, PtrToPtr<void, char_t>(ValueToPtr(cfgInfo->roleTableAddr)), nullptr, &hcclComm_);
            if (ret != HCCL_SUCCESS) {
                aicpusd_err("InitHcclForEmbedding fail for %d", static_cast<int32_t>(ret));
                return AICPU_SCHEDULE_ERROR_CALL_HCCL;
            } else {
                aicpusd_info("InitHcclForEmbedding success.");
                hcclEmbInit_ = true;
            }
        }
        ++hcclCommEmbRefs_;
        return AICPU_SCHEDULE_OK;
    }

    StatusCode AicpuModelManager::InitHcclForSyncEvent(const ModelCfgInfo * const cfgInfo)
    {
        if (hcclCommSyncRefs_ == 0U) {
            HcclResult ret = HCCL_SUCCESS;
            char_t * const commName = PtrToPtr<void, char_t>(ValueToPtr(cfgInfo->hcclCommNameAddr));
            if (commName != nullptr) {
                std::unique_ptr<HcclCommConfig> commConfig(new (std::nothrow) HcclCommConfig());
                AICPUSD_CHECK((commConfig != nullptr), AICPU_SCHEDULE_ERROR_INNER_ERROR,
                              "Fail to alloc memory for commConfig");
                int32_t *timeout = PtrToPtr<char_t, int32_t>(
                    &(commConfig->reserved[HCCL_COMM_CONFIG_INFO_BYTES - HCCL_COMM_TIMEOUT_CURSOR]));
                *timeout = cfgInfo->hcclTimeOut;
                const errno_t retCpy = strncpy_s(&(commConfig->hcclCommName[0U]), COMM_NAME_MAX_LENGTH, commName,
                                                 COMM_NAME_MAX_LENGTH - 1);
                if (retCpy != EOK) {
                    aicpusd_err("copy hcclCommName failed, retCpy=%d.", retCpy);
                    return AICPU_SCHEDULE_ERROR_INNER_ERROR;
                }
                aicpusd_info("timeout[%ds], commName[%s].", *timeout, &(commConfig->hcclCommName[0U]));
                ret = StubHcclCpuCommInit(PtrToPtr<void, char_t>(ValueToPtr(cfgInfo->rankTableAddr)),
                    static_cast<uint32_t>(cfgInfo->rankId), commConfig.get());
            } else {
                ret = StubHcomInitByRankTable(PtrToPtr<void, char_t>(ValueToPtr(cfgInfo->rankTableAddr)),
                    static_cast<uint32_t>(cfgInfo->rankId));
            }

            if (ret != HCCL_SUCCESS) {
                aicpusd_err("InitHcclForSyncEvent fail for %d", static_cast<int32_t>(ret));
                return AICPU_SCHEDULE_ERROR_CALL_HCCL;
            } else {
                aicpusd_info("InitHcclForSyncEvent success.");
                hcclSyncInit_ = true;
            }
        }
        ++hcclCommSyncRefs_;
        return AICPU_SCHEDULE_OK;
    }

    StatusCode AicpuModelManager::InitHccl(const ModelCfgInfo * const cfgInfo, HcclInitType &initType)
    {
        std::lock_guard<std::mutex> lockForComm(mutexForHcclComm_);
        if ((hcclCommEmbRefs_ == 0U) && (hcclCommSyncRefs_ == 0U)) {
            HcclSoManager::GetInstance()->LoadSo();
        }
        if (cfgInfo->modelType == static_cast<uint32_t>(kModelWithEmbedding)) {
            initType = HcclInitType::INIT_TYPE_FOR_EMBEDDING;
            return InitHcclForEmbedding(cfgInfo);
        } else if (cfgInfo->modelType == static_cast<uint32_t>(kModelWithSyncEvent)) {
            initType = HcclInitType::INIT_TYPE_FOR_SYNC_EVENT;
            return InitHcclForSyncEvent(cfgInfo);
        } else {
            aicpusd_err("Invalid model type: %u", cfgInfo->modelType);
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }
    }

    AicpuModel *AicpuModelManager::GetModel(const uint32_t modelId)
    {
        if (modelId >= MAX_MODEL_COUNT) {
            aicpusd_err("Get model failed, as modelId[%u] is invalid.", modelId);
            return nullptr;
        }
        auto &model = allModel_[modelId];
        if (!model.IsValid()) {
            aicpusd_err("Get model failed, as model[%u] is invalid.", modelId);
            return nullptr;
        }
        return &model;
    }

    AicpuModel *AicpuModelManager::GetModelByStreamId(const uint32_t streamId)
    {
        uint32_t modelId = 0U;
        const int32_t ret = ModelStreamManager::GetInstance().GetStreamModelId(streamId, modelId);
        if (ret != AICPU_SCHEDULE_OK) {
            aicpusd_err("can't find model by stream[%u].", streamId);
            return nullptr;
        }
        return GetModel(modelId);
    }

    AicpuModel *AicpuModelManager::GetModelByQueueId(const uint32_t queueId)
    {
        for (size_t i = 0U; i < static_cast<size_t>(MAX_MODEL_COUNT); ++i) {
            if (allModel_[i].IsValid() && (allModel_[i].HasQueue(queueId))) {
                return &allModel_[i];
            }
        }
        return nullptr;
    }

    std::vector<AicpuModel*> AicpuModelManager::GetModelsByTableId(const uint32_t tableId)
    {
        std::vector<AicpuModel*> models;
        for (size_t i = 0U; i < static_cast<size_t>(MAX_MODEL_COUNT); ++i) {
            if (allModel_[i].IsValid() && (allModel_[i].GetTableTryLock() == static_cast<int64_t>(tableId))) {
                models.emplace_back(&allModel_[i]);
            }
        }
        return models;
    }

    int32_t AicpuModelManager::Exit()
    {
        int32_t ret = AICPU_SCHEDULE_OK;
        int32_t tmpRet = AICPU_SCHEDULE_OK;
        for (auto &model : allModel_) {
            tmpRet = model.Exit();
            if ((tmpRet != AICPU_SCHEDULE_OK) && (ret == AICPU_SCHEDULE_OK)) {
                ret = AICPU_SCHEDULE_ERROR_MODEL_EXIT_ERR;
            }
        }
        FinalizeHccl();
        tensorDescMap_.clear();
        msgQMap_.clear();
        return ret;
    }

    void AicpuModelManager::ModelConfigClear(const uint32_t modelId)
    {
        const auto iter = tensorDescMap_.find(modelId);
        if (iter == tensorDescMap_.end()) {
            aicpusd_warn("modelId[%u] does not exist.", modelId);
            return;
        }
        (void)tensorDescMap_.erase(iter);

        const auto msqQIter = msgQMap_.find(modelId);
        if (msqQIter != msgQMap_.end()) {
            msgQMap_.erase(modelId);
        }
    }

    AicpuModelStatus AicpuModelManager::GetModelStatus(const uint32_t modelId) const
    {
        if (modelId >= MAX_MODEL_COUNT) {
            aicpusd_err("Get model status failed, as modelId[%u] is invalid.", modelId);
            return AicpuModelStatus::MODEL_STATUS_ERROR;
        }
        return allModel_[modelId].GetModelStatus();
    }

    StatusCode AicpuModelManager::TransModelInfo(const void * const ptr,
                                                 AicpuModelInfo &aicpuModelInfo,
                                                 std::vector<AicpuTaskInfo> &aicpuTaskInfos,
                                                 std::vector<StreamInfo> &streamInfos,
                                                 std::vector<QueInfo> &queInfos,
                                                 std::vector<ModelCfgInfo> *const modelcfgs)
    {
        const ModelInfo * const curModelInfo = PtrToPtr<const void, const ModelInfo>(ptr);
        aicpuModelInfo.moduleID = curModelInfo->modelId;
        aicpuModelInfo.tsId = 0U;
        // transform stream and task info
        const ModelStreamInfo * const streams = curModelInfo->streams;
        if (streams == nullptr) {
            aicpusd_err("Streams of model info is nullptr.");
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }
        for (size_t streamIndex = 0UL; streamIndex < curModelInfo->aicpuStreamNum; streamIndex++) {
            const auto &stream = streams[streamIndex];
            const StreamInfo stmInfo = {stream.streamId, stream.streamFlag};
            streamInfos.push_back(stmInfo);
            const uint16_t taskNum = stream.taskNum;
            const ModelTaskInfo * const tasks = stream.tasks;
            if ((taskNum > 0) && (tasks == nullptr)) {
                aicpusd_err("Tasks of stream info is nullptr.");
                return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
            }
            for (size_t taskIndex = 0UL; taskIndex < taskNum; taskIndex++) {
                const auto &taskInfo = tasks[taskIndex];
                const AicpuTaskInfo curAicpuTaskInfo = {
                    taskInfo.taskId, stream.streamId,
                    static_cast<uint32_t>(AicpuKernelType::CCE_KERNEL),
                    taskInfo.kernelName, 0U, taskInfo.paraBase, 0U
                };
                aicpuTaskInfos.push_back(curAicpuTaskInfo);
            }
        }
        if (aicpuTaskInfos.empty() || streamInfos.empty()) {
            aicpusd_err("one of tasks[%u], streams[%u] is zero.", aicpuTaskInfos.size(), streamInfos.size());
            return AICPU_SCHEDULE_ERROR_TRANS_MODELINFO_FAILED;
        }

        // transform queue info
        const ModelQueueInfo * const queues = curModelInfo->queues;
        if (queues != nullptr) {
            for (size_t queueIndex = 0UL; queueIndex < curModelInfo->queueNum; queueIndex++) {
                const ModelQueueInfo &queueInfo = queues[queueIndex];
                const QueInfo curModelQueue = {queueInfo.queueId, queueInfo.flag};
                queInfos.push_back(curModelQueue);
            }
        }

        // transform model cfg
        if ((curModelInfo->cfgInfoPtr != 0U) && (modelcfgs != nullptr)) {
            (void)modelcfgs->emplace_back(*(PtrToPtr<void, ModelCfgInfo>(ValueToPtr(curModelInfo->cfgInfoPtr))));
        }

        aicpuModelInfo.streamInfoNum = static_cast<uint16_t>(streamInfos.size());
        aicpuModelInfo.streamInfoPtr = PtrToValue(&streamInfos[0UL]);
        aicpuModelInfo.aicpuTaskNum = static_cast<uint16_t>(aicpuTaskInfos.size());
        aicpuModelInfo.aicpuTaskPtr = PtrToValue(&aicpuTaskInfos[0UL]);
        aicpuModelInfo.queueSize = static_cast<uint16_t>(queInfos.size());
        aicpuModelInfo.queueInfoPtr = queInfos.size() > 0U ? PtrToValue(&queInfos[0UL]) : 0U;
        abnormalBreaks_[aicpuModelInfo.moduleID] = curModelInfo->abnormalBreak;
        abnormalEnqueues_[aicpuModelInfo.moduleID] = curModelInfo->abnormalEnqueue;
        abnormalFlags_[aicpuModelInfo.moduleID] = curModelInfo->abnormalEnable;
        const auto ret = ProcessModelPriorityMsg(curModelInfo->aicpuPriInfo, false);
        if (ret != AICPU_SCHEDULE_OK) {
            aicpusd_err("set priority error ret[%d]", ret);
            return AICPU_SCHEDULE_ERROR_SET_PRIORITY_FAILED;
        }
        return AICPU_SCHEDULE_OK;
    }

    uint32_t AicpuModelManager::GetExtModelId(const uint32_t modelId)
    {
        if (modelId >= MAX_MODEL_COUNT) {
            return INVALID_NUMBER;
        }
        return extModelIds_[modelId];
    }

    bool AicpuModelManager::AbnormalBreak(const uint32_t modelId)
    {
        if (modelId >= MAX_MODEL_COUNT) {
            return false;
        }
        return abnormalBreaks_[modelId] != 0;
    }

    bool AicpuModelManager::AbnormalEnqueue(const uint32_t modelId)
    {
        if (modelId >= MAX_MODEL_COUNT) {
            return false;
        }
        return abnormalEnqueues_[modelId] != 0;
    }

    bool AicpuModelManager::AbnormalEnabled(const uint32_t modelId)
    {
        if (modelId >= MAX_MODEL_COUNT) {
            return false;
        }
        return abnormalFlags_[modelId] != 0;
    }

    AicpuModelManager::AicpuModelManager()
    {
        for (uint32_t &extModelId : extModelIds_) {
            extModelId = INVALID_NUMBER;
        }
    }

    StatusCode AicpuModelManager::ProcessExtInfoCfgMsg(const aicpu::AicpuExtendInfo &cfgInfo)
    {
        const auto msgType = static_cast<aicpu::AicpuExtInfoMsgType>(cfgInfo.msgType);
        aicpusd_info("Begin to ProcessExtInfoCfgMsg, msgType[%u], version[%u], model_id[%u], extend_model_id[%u].",
                     msgType, cfgInfo.version, cfgInfo.modelIdMap.modelId, cfgInfo.modelIdMap.extendModelId);
        if (msgType != aicpu::AicpuExtInfoMsgType::EXT_MODEL_ID_MSG_TYPE) {
            aicpusd_err("Invalid msgType of ProcessExtInfoCfgMsg, msgType[%d].", msgType);
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }
        if (cfgInfo.modelIdMap.modelId >= MAX_MODEL_COUNT) {
            aicpusd_err("Invalid model id of ProcessExtInfoCfgMsg, model id[%d].", cfgInfo.modelIdMap.modelId);
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }
        extModelIds_[cfgInfo.modelIdMap.modelId] = cfgInfo.modelIdMap.extendModelId;
        return AICPU_SCHEDULE_OK;
    }

    StatusCode AicpuModelManager::CheckModelConfigShape(
        const uint32_t type, const uint32_t tlvLen, int32_t &unparseLen) const
    {
        if (type != TLV_WITH_SHAPE) {
            aicpusd_err("it is should be shape type, but not. type[%u]", type);
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }
        const int64_t shapeSize = static_cast<int64_t>(tlvLen) / static_cast<int64_t>(sizeof(int64_t));
        if ((tlvLen % sizeof(int64_t) != 0) || (shapeSize > MAX_DIM_SIZE)) {
            aicpusd_err("shape info is invalid, please check. tlv len[%u], shape size[%u]", tlvLen, shapeSize);
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }

        if (unparseLen < (static_cast<int32_t>(sizeof(TlvHead)) + static_cast<int32_t>(tlvLen))) {
            aicpusd_err("aicpu model config tensor length is error, please check.");
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }
        unparseLen = unparseLen - (static_cast<int32_t>(sizeof(TlvHead)) + static_cast<int32_t>(tlvLen));
        return AICPU_SCHEDULE_OK;
    }

    StatusCode AicpuModelManager::CheckModelConfigDtype(const TlvHead tlvHeadAddr, int32_t &unparseLen) const
    {
        if (unparseLen < static_cast<int32_t>(sizeof(TlvHead))) {
            aicpusd_err("aicpu model config tensor length is error, please check.");
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }

        const uint32_t type = tlvHeadAddr.type;
        const uint32_t len = tlvHeadAddr.len;
        if (type != TLV_WITH_DTYPE) {
            aicpusd_err("it is should be dtype type, but not. type[%u]", type);
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }
        // check unparse length
        if (unparseLen < (static_cast<int32_t>(sizeof(TlvHead)) + static_cast<int32_t>(len))) {
            aicpusd_err("aicpumodel config tensor length is error, please check.");
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }
        unparseLen = unparseLen - (static_cast<int32_t>(sizeof(TlvHead)) + static_cast<int32_t>(len));
        return AICPU_SCHEDULE_OK;
    }

    StatusCode AicpuModelManager::ParseModelConfigTensorDesc(const AicpuModelShapeConfig &cfg)
    {
        // parse tlv, get ModelConfigTensorDesc
        int32_t totalLen = static_cast<int32_t>(cfg.tensortlvLen);
        TlvHead *tlvHeadAddr = PtrToPtr<void, TlvHead>(ValueToPtr(cfg.tlvDataAddr));
        if (tlvHeadAddr == nullptr) {
            aicpusd_err("tlv data addr is invalid");
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }
        std::vector<ModelConfigTensorDesc> tensorInfo;

        while (totalLen > 0) {
            ModelConfigTensorDesc tensorDesc;
            if (totalLen < static_cast<int32_t>(sizeof(TlvHead))) {
                aicpusd_err("aicpu model config tensor length is error, please check.");
                return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
            }
            const uint32_t type = tlvHeadAddr->type;
            const uint32_t len = tlvHeadAddr->len;
            uint8_t *dataAddr = PtrToPtr<TlvHead, uint8_t>(tlvHeadAddr) + sizeof(TlvHead);
            tensorDesc.shape[0] = static_cast<int64_t>(len) / static_cast<int64_t>(sizeof(int64_t));
            StatusCode ret = CheckModelConfigShape(type, len, totalLen);
            if (ret != AICPU_SCHEDULE_OK) {
                aicpusd_err("CheckModelConfigShape failed");
                return ret;
            }
            for (int64_t j = 0; j < tensorDesc.shape[0]; j++) {
                int64_t *shapeValue = PtrToPtr<uint8_t, int64_t>(dataAddr + static_cast<int64_t>(j * sizeof(int64_t)));
                tensorDesc.shape[j + 1] = *shapeValue;
            }

            tlvHeadAddr = PtrToPtr<uint8_t, TlvHead>(dataAddr + len);
            ret = CheckModelConfigDtype(*tlvHeadAddr, totalLen);
            if (ret != AICPU_SCHEDULE_OK) {
                aicpusd_err("check model config dtype failed");
                return ret;
            }

            dataAddr = PtrToPtr<TlvHead, uint8_t>(tlvHeadAddr) + sizeof(TlvHead);
            uint32_t *dtypeVal = PtrToPtr<uint8_t, uint32_t>(dataAddr);
            tensorDesc.dtype = static_cast<int64_t>(*dtypeVal);
            tlvHeadAddr = PtrToPtr<uint8_t, TlvHead>(dataAddr + tlvHeadAddr->len);
            tensorInfo.push_back(tensorDesc);
        }

        tensorDescMap_[cfg.runtimeModelId] = tensorInfo;
        aicpusd_info("tensorInfo size = %d, cfg.runtimeModelId = %d", tensorInfo.size(), cfg.runtimeModelId);
        return AICPU_SCHEDULE_OK;
    }

    StatusCode AicpuModelManager::GetModelConfigShape(
        const uint32_t modelId, std::vector<ModelConfigTensorDesc> &tensorDescArr)
    {
        if (tensorDescMap_.find(modelId) == tensorDescMap_.end()) {
            aicpusd_warn("not find modelId[%u] aicpu model shape config", modelId);
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }
        tensorDescArr = tensorDescMap_[modelId];
        return AICPU_SCHEDULE_OK;
    }

    StatusCode AicpuModelManager::ProcessModelConfigMsg(const AicpuModelConfig &cfg)
    {
        aicpusd_info("Begin to process model config, version[%d], model_id[%u], extend_model_id[%u], "
                     "abnormal_break[%d], abnormal_enqueue[%d], inputMsgQueue[%d], outputMsgQueue[%d].",
                     cfg.version, cfg.runtimeModelId, cfg.geModelId, cfg.abnormalBreak, cfg.abnormalEnqueue,
                     cfg.inputMsgQueue, cfg.outputMsgQueue);
        if (cfg.runtimeModelId >= MAX_MODEL_COUNT) {
            aicpusd_err("Invalid model id[%u] of model config, must < [%u].", cfg.runtimeModelId, MAX_MODEL_COUNT);
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }
        extModelIds_[cfg.runtimeModelId] = cfg.geModelId;
        abnormalBreaks_[cfg.runtimeModelId] = cfg.abnormalBreak;
        abnormalEnqueues_[cfg.runtimeModelId] = cfg.abnormalEnqueue;
        abnormalFlags_[cfg.runtimeModelId] = true;

        if ((cfg.inputMsgQueue <= 0) && (cfg.outputMsgQueue <= 0)) {
            return AICPU_SCHEDULE_OK;
        }

        if (cfg.inputMsgQueue >= 0) {
            QueueSetInputPara inPutParam = {};
            QueueSetInput inPut = {};
            inPut.queSetWorkMode.qid = cfg.inputMsgQueue;
            inPut.queSetWorkMode.workMode = QUEUE_MODE_PULL;
            inPutParam.inBuff = static_cast<void *>(&inPut);
            inPutParam.inLen = static_cast<uint32_t>(sizeof(QueueSetInput));
            const auto ret = halQueueSet(0U, QUEUE_SET_WORK_MODE, &inPutParam);
            if (ret != DRV_ERROR_NONE) {
                aicpusd_err("Fail to set work mode for queue[%d], ret is %d.", cfg.inputMsgQueue,
                    static_cast<int32_t>(ret));
                return AICPU_SCHEDULE_ERROR_FROM_DRV;
            }
            const auto subscribeRet =
                AicpuDrvManager::GetInstance().SubscribeQueueNotEmptyEvent(static_cast<uint32_t>(cfg.inputMsgQueue));
            if (subscribeRet != AICPU_SCHEDULE_OK) {
                aicpusd_err("Fail to subscribe queue[%d] not empty event.", cfg.inputMsgQueue);
                return subscribeRet;
            }
            aicpusd_info("SubscribeQueueNotEmptyEvent for queue[%d]", cfg.inputMsgQueue);
        }

        if (cfg.outputMsgQueue >= 0) {
            const auto subscribeRet =
                AicpuDrvManager::GetInstance().SubscribeQueueNotFullEvent(static_cast<uint32_t>(cfg.outputMsgQueue));
            if (subscribeRet != AICPU_SCHEDULE_OK) {
                aicpusd_err("Fail to subscribe queue[%d] not full event.", cfg.outputMsgQueue);
                return subscribeRet;
            }
            aicpusd_info("SubscribeQueueNotFullEvent for queue[%d]", cfg.outputMsgQueue);
        }
        msgQMap_[cfg.runtimeModelId] = std::make_pair(cfg.inputMsgQueue, cfg.outputMsgQueue);
        return AICPU_SCHEDULE_OK;
    }

    StatusCode AicpuModelManager::ProcessModelShapeConfigMsg(const AicpuModelShapeConfig &cfg)
    {
        aicpusd_info("Begin to process model config, version[%d], model_id[%u], extend_model_id[%u], "
                     "tensor info length[%u]",
                     cfg.version, cfg.runtimeModelId, cfg.geModelId, cfg.tensortlvLen);
        if (cfg.runtimeModelId >= MAX_MODEL_COUNT) {
            aicpusd_err("Invalid model id[%u] of model config, must < [%u].", cfg.runtimeModelId, MAX_MODEL_COUNT);
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }

        if (cfg.tensortlvLen != 0) {
            const StatusCode ret = ParseModelConfigTensorDesc(cfg);
            if (ret != AICPU_SCHEDULE_OK) {
                aicpusd_err("Save Model Config TensorDesc failed");
                return ret;
            }
        }
        return AICPU_SCHEDULE_OK;
    }

    StatusCode AicpuModelManager::SetPidPriority(const AicpuPriInfo &cfg, const std::vector<uint32_t> &deviceVec)
    {
        if ((cfg.pidPriority == INVALID_ESCAPE_PRI_VALUE) ||
            ((cfg.pidPriority > curPidPri_) && (curPidPri_ != INVALID_ESCAPE_PRI_VALUE))) {
            aicpusd_info("[AicpuModelEschedPriority] the new pid priority[%d] is lower than the current[%d]",
                         cfg.pidPriority, curPidPri_);
            return AICPU_SCHEDULE_OK;
        }

        const std::lock_guard<std::mutex> lockForSetPidPri(mutexForSetPidPri_);
        aicpusd_info("[AicpuModelEschedPriority] Begin to set pid priority vect size[%u], pidPriority[%d], input[%d]",
                     deviceVec.size(), curPidPri_, cfg.pidPriority);
        for (size_t i = 0U; i < deviceVec.size(); i++) {
            if (cfg.pidPriority < curPidPri_ || curPidPri_ == INVALID_ESCAPE_PRI_VALUE) {
                const auto ret = halEschedSetPidPriority(deviceVec[i], static_cast<SCHEDULE_PRIORITY>(cfg.pidPriority));
                if (ret != DRV_ERROR_NONE) {
                    aicpusd_err("[AicpuModelEschedPriority]Failed to set priority [%d], deviceid[%u], result[%d].",
                                cfg.pidPriority, deviceVec[i], ret);
                    return AICPU_SCHEDULE_ERROR_DRV_ERR;
                }
                aicpusd_info("[AicpuModelEschedPriority] set pid priority success Index[%u], deviceid[%u]",
                             i, deviceVec[i]);
                curPidPri_ = cfg.pidPriority;
            }
        }
        aicpusd_info("[AicpuModelEschedPriority] end to set pid priority pidPriority[%d]", curPidPri_);
        return AICPU_SCHEDULE_OK;
    }

    StatusCode AicpuModelManager::SetEventPriority(const AicpuPriInfo &cfg, const std::vector<uint32_t> &deviceVec)
    {
        if ((cfg.eventPriority == INVALID_ESCAPE_PRI_VALUE) ||
            ((cfg.eventPriority > curEventPri_) && (curEventPri_ != INVALID_ESCAPE_PRI_VALUE))) {
            aicpusd_info("[AicpuModelEschedPriority] the new event priority[%d] is lower than the current[%d]",
                         cfg.eventPriority, curEventPri_);
            return AICPU_SCHEDULE_OK;
        }

        const std::lock_guard<std::mutex> lockForSetEvnPri(mutexForSetEvnPri_);
        aicpusd_info("[AicpuModelEschedPriority] Begin to set event priority vecSize[%u], eventPri[%d], input[%d]",
                     deviceVec.size(), curEventPri_, cfg.eventPriority);
        for (size_t i = 0U; i < deviceVec.size(); i++) {
            auto ret = halEschedSetEventPriority(deviceVec[i], EVENT_QUEUE_EMPTY_TO_NOT_EMPTY,
                                                 static_cast<SCHEDULE_PRIORITY>(cfg.eventPriority));
            if (ret != DRV_ERROR_NONE) {
                aicpusd_err("[AicpuModelEschedPriority] failed set EVENT_QUEUE_EMPTY_TO_NOT_EMPTY ret[%d].", ret);
                return AICPU_SCHEDULE_ERROR_DRV_ERR;
            }
            aicpusd_info("[AicpuModelEschedPriority] set EVENT_QUEUE_EMPTY_TO_NOT_EMPTY priority success Index[%u],"
                         "deviceid[%u]", i, deviceVec[i]);
            ret = halEschedSetEventPriority(deviceVec[i], EVENT_QUEUE_FULL_TO_NOT_FULL,
                                            static_cast<SCHEDULE_PRIORITY>(cfg.eventPriority));
            if (ret != DRV_ERROR_NONE) {
                aicpusd_err("[AicpuModelEschedPriority] failed set EVENT_QUEUE_FULL_TO_NOT_FULL ret[%d].", ret);
                return AICPU_SCHEDULE_ERROR_DRV_ERR;
            }
            aicpusd_info("[AicpuModelEschedPriority] set EVENT_QUEUE_FULL_TO_NOT_FULL priority success Index[%u],"
                         "deviceid[%u]", i, deviceVec[i]);
        }
        curEventPri_ = cfg.eventPriority;
        aicpusd_info("[AicpuModelEschedPriority] end to set event priority eventPri[%d]", curEventPri_);
        return AICPU_SCHEDULE_OK;
    }

    StatusCode AicpuModelManager::ProcessModelPriorityMsg(const AicpuPriInfo &cfg, const bool isProcessMode)
    {
        aicpusd_info("[AicpuModelEschedPriority] Begin to process AicpuModelEschedPriority");
        if (cfg.checkHead != PRIORITY_MSG_CHECKCODE) {
            // checkcode error in process mode is msg error return fail
            if (isProcessMode) {
                aicpusd_err("[AicpuModelEschedPriority] the msg checkcode is error [%x]", cfg.checkHead);
                return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
            } else {
                return AICPU_SCHEDULE_OK;
            }
        }
        // get device list to set priority
        const std::vector<uint32_t> deviceVec = AicpuDrvManager::GetInstance().GetDeviceList();
        if (deviceVec.empty()) {
            aicpusd_err("[AicpuModelEschedPriority] the device vector is empty");
            return AICPU_SCHEDULE_ERROR_DRV_ERR;
        }
        // set pid priority
        auto ret = SetPidPriority(cfg, deviceVec);
        if (ret != AICPU_SCHEDULE_OK) {
            aicpusd_err("[AicpuModelEschedPriority] set pid priority error ret[%d]", ret);
            return AICPU_SCHEDULE_ERROR_DRV_ERR;
        }
        // set event priority
        ret = SetEventPriority(cfg, deviceVec);
        if (ret != AICPU_SCHEDULE_OK) {
            aicpusd_err("[AicpuModelEschedPriority] set event priority error ret[%d]", ret);
            return AICPU_SCHEDULE_ERROR_DRV_ERR;
        }
        return AICPU_SCHEDULE_OK;
    }

    void AicpuModelManager::GuardHccl(const HcclInitType initType)
    {
        if (!hcclEmbInit_ && !hcclSyncInit_) {
            return;
        }

        std::lock_guard<std::mutex> lockForComm(mutexForHcclComm_);
        if ((initType == HcclInitType::INIT_TYPE_FOR_EMBEDDING) && hcclEmbInit_ && (--hcclCommEmbRefs_ == 0U)) {
            FinalizeHcclForEmbedding();
        } else if ((initType == HcclInitType::INIT_TYPE_FOR_SYNC_EVENT) &&
            hcclSyncInit_ && (--hcclCommSyncRefs_ == 0U)) {
            FinalizeHcclForSyncEvent();
        } else {
            aicpusd_info("No need to finalize hccl, hcclCommEmbRefs[%u], hcclCommSyncRefs[%u]",
                hcclCommEmbRefs_, hcclCommSyncRefs_);
        }
        if (!hcclEmbInit_ && !hcclSyncInit_) {
            HcclSoManager::GetInstance()->UnloadSo();
        }
    }

    void AicpuModelManager::FinalizeHcclForEmbedding()
    {
        if (!hcclEmbInit_) {
            return;
        }
        const auto ret = StubHcclFinalizeComm(hcclComm_);
        if (ret != HCCL_SUCCESS) {
            aicpusd_err("FinalizeHcclForEmbedding fail, ret: %d", static_cast<int32_t>(ret));
        }
        hcclEmbInit_ = false;
        aicpusd_info("FinalizeHcclForEmbedding success.");
    }

    void AicpuModelManager::FinalizeHcclForSyncEvent()
    {
        if (!hcclSyncInit_) {
            return;
        }
        const auto ret = StubHcomDestroy();
        if (ret != HCCL_SUCCESS) {
            aicpusd_err("FinalizeHcclForSyncEvent fail, ret: %d", static_cast<int32_t>(ret));
        }
        hcclSyncInit_ = false;
        aicpusd_info("FinalizeHcclForSyncEvent success.");
    }

    void AicpuModelManager::FinalizeHccl()
    {
        const bool needUnload = (!hcclEmbInit_ || !hcclSyncInit_);
        FinalizeHcclForEmbedding();
        FinalizeHcclForSyncEvent();
        if (needUnload) {
            HcclSoManager::GetInstance()->UnloadSo();
        }
    }

    HcclComm *AicpuModelManager::GetHcclComm()
    {
        if (hcclEmbInit_) {
            return &hcclComm_;
        } else {
            aicpusd_warn("HcclComm has not been inited");
            return nullptr;
        }
    }

    StatusCode AicpuModelManager::GetModelMsgQueues(const uint32_t modelId, const bool isInput, int32_t &queueId) const
    {
        const auto iter = msgQMap_.find(modelId);
        if (iter == msgQMap_.end()) {
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }
        queueId = isInput ? iter->second.first : iter->second.second;
        if (queueId < 0) {
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }
        return AICPU_SCHEDULE_OK;
    }
}
