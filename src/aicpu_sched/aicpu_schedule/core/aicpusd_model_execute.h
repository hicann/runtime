/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef AICPUSD_MODEL_EXECUTE_H
#define AICPUSD_MODEL_EXECUTE_H

#include <atomic>
#include <cstdint>
#include <unordered_map>
#include <vector>
#include <unordered_set>
#include <thread>
#include <list>
#include "aicpusd_status.h"
#include "aicpusd_common.h"
#include "aicpusd_info.h"
#include "aicpu_task_struct.h"
#include "aicpusd_util.h"
#include "aicpusd_hccl_api.h"
#include "aicpusd_model.h"

namespace AicpuSchedule {
    struct AicpuModelConfig {
        int32_t version;
        uint32_t geModelId;
        uint32_t runtimeModelId;
        int32_t abnormalBreak;
        int32_t abnormalEnqueue;
        int32_t outputMsgQueue;
        int32_t inputMsgQueue;
        int8_t rsv[36];
    };

    struct AicpuModelShapeConfig {
        int32_t version;
        uint32_t geModelId;
        uint32_t runtimeModelId;
        uint32_t tensortlvLen;
        uint64_t tlvDataAddr;
        int8_t rsv[40];
    };

    // tlv struct
    struct TlvHead {
        uint32_t type;
        uint32_t len;
        uint8_t data[0];
    };

    class AicpuModelManager {
    public:
        static AicpuModelManager &GetInstance();

        int32_t ModelLoad(const AicpuModelInfo * const modelInfo,  const ModelCfgInfo * const cfgInfo = nullptr);

        AicpuModel *GetModel(const uint32_t modelId);

        AicpuModel *GetModelByStreamId(const uint32_t streamId);

        AicpuModel *GetModelByQueueId(const uint32_t queueId);

        std::vector<AicpuModel*> GetModelsByTableId(const uint32_t tableId);

        StatusCode ParseModelConfigTensorDesc(const AicpuModelShapeConfig &cfg);

        StatusCode GetModelConfigShape(const uint32_t modelId, std::vector<ModelConfigTensorDesc> &tensorDescArr);

        void ModelConfigClear(const uint32_t modelId);

        /**
         * @brief call it when process exit.
         * @return AICPU_SCHEDULE_OK:success, other failed.
         */
        int32_t Exit();

        AicpuModelStatus GetModelStatus(const uint32_t modelId) const;

        StatusCode TransModelInfo(const void * const ptr,
                                  AicpuModelInfo &aicpuModelInfo,
                                  std::vector<AicpuTaskInfo> &aicpuTaskInfos,
                                  std::vector<StreamInfo> &streamInfos,
                                  std::vector<QueInfo> &queInfos,
                                  std::vector<ModelCfgInfo> *const modelcfgs = nullptr);
        /**
        * @ingroup ProcessExtInfoCfgMsg
        * @brief it is used to process the config of ge model id or other extension info.
        * @param [in] cfgInfo : the config info of extension info.
        */
        StatusCode ProcessExtInfoCfgMsg(const aicpu::AicpuExtendInfo &cfgInfo);

        /**
        * @ingroup ProcessModelConfigMsg
        * @brief it is used to process the config of ge model.
        * @param [in] cfg : the config of model.
        */
        StatusCode ProcessModelConfigMsg(const AicpuModelConfig &cfg);

        /**
        * @ingroup ProcessModelShapeConfigMsg
        * @brief it is used to process the shape config of ge model.
        * @param [in] cfg : the shape config of model.
        */
        StatusCode ProcessModelShapeConfigMsg(const AicpuModelShapeConfig &cfg);

        ~AicpuModelManager() = default;

        // not allow copy constructor and assignment operators
        AicpuModelManager(const AicpuModelManager &) = delete;

        AicpuModelManager &operator=(const AicpuModelManager &) = delete;

        AicpuModelManager(AicpuModelManager &&) = delete;

        AicpuModelManager &&operator=(AicpuModelManager &&) = delete;

        uint32_t GetExtModelId(const uint32_t modelId);

        bool AbnormalBreak(const uint32_t modelId);

        bool AbnormalEnqueue(const uint32_t modelId);

        bool AbnormalEnabled(const uint32_t modelId);

        StatusCode ProcessModelPriorityMsg(const AicpuPriInfo &cfg, const bool isProcessMode);

        StatusCode SetPidPriority(const AicpuPriInfo &cfg, const std::vector<uint32_t> &deviceVec);

        StatusCode SetEventPriority(const AicpuPriInfo &cfg, const std::vector<uint32_t> &deviceVec);

        HcclComm *GetHcclComm();

        void GuardHccl(const HcclInitType initType);

        StatusCode GetModelMsgQueues(const uint32_t modelId, const bool isInput, int32_t &queueId) const;

        static bool IsUsed();

    private:
        AicpuModelManager();

        StatusCode InitHccl(const ModelCfgInfo * const cfgInfo, HcclInitType &initType);
        StatusCode InitHcclForEmbedding(const ModelCfgInfo * const cfgInfo);
        StatusCode InitHcclForSyncEvent(const ModelCfgInfo * const cfgInfo);
        void FinalizeHccl();
        void FinalizeHcclForEmbedding();
        void FinalizeHcclForSyncEvent();
        StatusCode CheckModelConfigShape(const uint32_t type, const uint32_t tlvLen, int32_t &unparseLen) const;
        StatusCode CheckModelConfigDtype(const TlvHead tlvHeadAddr, int32_t &unparseLen) const;

        AicpuModel allModel_[MAX_MODEL_COUNT];
        uint32_t extModelIds_[MAX_MODEL_COUNT]{};
        int32_t abnormalBreaks_[MAX_MODEL_COUNT]{};
        int32_t abnormalEnqueues_[MAX_MODEL_COUNT]{};
        int32_t abnormalFlags_[MAX_MODEL_COUNT]{};
        std::unordered_map<uint32_t, std::vector<ModelConfigTensorDesc>> tensorDescMap_;
        std::unordered_map<uint32_t, std::pair<int32_t, int32_t>> msgQMap_;
        int32_t curPidPri_ = INVALID_ESCAPE_PRI_VALUE;
        int32_t curEventPri_ = INVALID_ESCAPE_PRI_VALUE;
        std::mutex mutexForSetPidPri_;
        std::mutex mutexForSetEvnPri_;
        HcclComm hcclComm_;
        bool hcclEmbInit_{false};
        bool hcclSyncInit_{false};
        std::mutex mutexForHcclComm_;
        uint32_t hcclCommEmbRefs_{0U};
        uint32_t hcclCommSyncRefs_{0U};
        std::vector<uint64_t> registerMemory_;
        static bool isUsed_;
    };
}
#endif // MAIN_AICPUSD_MODEL_EXECUTE_H
