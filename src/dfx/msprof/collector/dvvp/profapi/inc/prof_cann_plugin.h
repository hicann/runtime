/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef PROF_CANN_PLUGIN_H
#define PROF_CANN_PLUGIN_H
#include <vector>
#include <map>
#include <functional>
#include "singleton/singleton.h"
#include "prof_plugin.h"
#include "prof_utils.h"
#include "queue/report_buffer.h"
#include "queue/block_buffer.h"
#include "queue/variable_block_buffer.h"
#include "prof_report_api.h"
#include "prof_runtime_plugin.h"
#include "prof_common.h"

namespace ProfAPI {
using namespace analysis::dvvp::common::queue;
constexpr char MS_PROF_API_INIT_PROF[] = "msProfInit";
constexpr int ADDITIONAL_INFO_BODY_LENGTH = 232;
constexpr int STANDARD_ADDITIONAL_INFO_LENGTH = 256;
constexpr int MAX_VARIABLE_DATA_LENGTH = 65536;

using ProfInitFunc = int32_t (*) (uint32_t type, void *data, uint32_t dataLen);
using ProfStartFunc = int32_t (*) (uint32_t dataType, const void *data, uint32_t length);
using ProfStopFunc = int32_t (*) (uint32_t dataType, const void *data, uint32_t length);
using ProfSetConfigFunc = int32_t (*) (uint32_t configType, const char *config, size_t configLength);
using ProfRegisterCallbackFunc = int32_t (*) (uint32_t moduleId, ProfCommandHandle handle);
using ProfReportDataFunc = int32_t (*) (uint32_t moduleId, uint32_t type, void* data, uint32_t len);
using ProfSetDeviceIdFunc = int32_t (*) (const uint32_t geModelIdx, const uint32_t deviceId);
using ProfNotifySetDeviceFunc = int32_t (*) (uint32_t chipId, uint32_t deviceId, bool isOpen);
using ProfFinalizeFunc = int32_t (*) ();
using ProfGetImplInfoFunc = void (*) (ProfImplInfo& info);
using ProfApiBufPopFunc = void (*) (const ProfApiBufPopCallback func);
using ProfCompactBufPopFunc = void (*) (const ProfCompactBufPopCallback func);
using ProfAdditionalBufPopFunc = void (*) (const ProfAdditionalBufPopCallback func);
using ProfReportBufEmptyFunc = void (*) (const ProfReportBufEmptyCallback func);
using ProfAdditionalBufPushFunc = void (*) (const ProfAdditionalBufPushCallback func);
using ProfMarkExFunc = void (*) (const ProfMarkExCallback func);
using ProfBatchAddBufPopFunc = void* (*) (const ProfBatchAddBufPopCallback func);
using ProfBatchAddBufIndexShiftFunc = void (*) (const ProfBatchAddBufIndexShiftCallBack func);
using ProfGetFeatureIsOnFunc = int32_t (*) (uint64_t feature);
using ProfImplInitMstxInjectionFunc = void(*)(const ProfRegisterMstxFuncCallback func);
using ProfSubscribeRawDataFunc = int32_t (*) (MsprofRawDataCallback callback);
using ProfUnSubscribeRawDataFunc = int32_t (*) ();

using ProfVarAddBlockBufPopFunc = void* (*) (const ProfVarAddBlockBufPopCallback func);
using ProfVarAddBufIndexShiftFunc = void* (*) (const ProfVarAddBufIndexShiftCallBack func);

class ProfCannPlugin : public ProfPlugin, public analysis::dvvp::common::singleton::Singleton<ProfCannPlugin> {
public:
    void ProfApiInit();

    int32_t ProfInit(uint32_t type, void *data, uint32_t dataLen) override;
    int32_t ProfStart(uint32_t dataType, const void *data, uint32_t length) override;
    int32_t ProfStop(uint32_t dataType, const void *data, uint32_t length) override;
    int32_t ProfSetConfig(uint32_t configType, const char *config, size_t configLength) override;
    int32_t ProfRegisterCallback(uint32_t moduleId, ProfCommandHandle handle) override;
    int32_t ProfReportData(uint32_t moduleId, uint32_t type, void* data, uint32_t len) override;
    int32_t ProfReportApi(uint32_t agingFlag, const MsprofApi* api) override;
    int32_t ProfReportEvent(uint32_t agingFlag, const MsprofEvent* event) override;
    int32_t ProfReportCompactInfo(uint32_t agingFlag, const VOID_PTR data, uint32_t len) override;
    int32_t ProfReportAdditionalInfo(uint32_t agingFlag, const VOID_PTR data, uint32_t length) override;
    int32_t ProfReportRegTypeInfo(uint16_t level, uint32_t typeId, const char* typeName, size_t len) override;
    int32_t ProfReportRegDataFormat(uint16_t level, uint32_t typeId, const char* dataFormat, size_t len) override;
    uint64_t ProfReportGetHashId(const char* info, size_t len) override;
    int32_t ProfSetDeviceIdByGeModelIdx(const uint32_t geModelIdx, const uint32_t deviceId) override;
    int32_t ProfUnSetDeviceIdByGeModelIdx(const uint32_t geModelIdx, const uint32_t deviceId) override;
    int32_t ProfNotifySetDevice(uint32_t chipId, uint32_t deviceId, bool isOpen) override;
    int32_t ProfSetStepInfo(const uint64_t indexId, const uint16_t tagId, void* const stream) override;
    int32_t ReportApiInfo(const uint64_t beginTime, const uint64_t endTime, const uint64_t itemId, const uint32_t apiType);
    void BuildApiInfo(const std::pair<uint64_t, uint64_t> &profTime, const uint32_t apiType, const uint64_t itemId, MsprofApi &api);
    int32_t ProfFinalize() override;
    bool ProfHostFreqIsEnable() override;
    void ProfGetImplInfo(ProfImplInfo& info);
    size_t ProfInitReportBufSize(uint32_t type);
    void ProfInitReportBuf(uint32_t type = 0);
    void ProfUnInitReportBuf();
    bool ProfIfReportBufEmpty();
    bool ProfReportBufPop(uint32_t &aging, MsprofApi& data);
    bool ProfReportBufPop(uint32_t &aging, MsprofCompactInfo& data);
    bool ProfReportBufPop(uint32_t &aging, MsprofAdditionalInfo& data);
    void ProfTxInit();
    bool ProfCheckCommandLine();

    void *ProfVarBlockBufBatchPop(size_t &popSize);
    void ProfVarAddBufIndexShift(void *popPtr, const size_t popSize);

    // devprof
    int32_t ProfReportBatchAdditionalInfo(uint32_t agingFlag, const VOID_PTR data, uint32_t len) override;
    size_t ProfGetBatchReportMaxSize(uint32_t type) override;
    void *ProfBatchAddBufPop(size_t &popSize, bool popForce);
    void ProfBatchAddBufIndexShift(void *popPtr, const size_t popSize);
    void ProfInitDevReportBuf();
    int32_t ProfAdprofCheckFeatureIsOn(uint64_t feature) const;
    int32_t ProfSubscribeRawData(MsprofRawDataCallback callback) const;
    int32_t ProfUnSubscribeRawData() const;
    ~ProfCannPlugin() override;

private:
    void ProfRegisterFunc(uint32_t type, void* func);
    void LoadProfInfo();
    void *msProfLibHandle_;
    std::map<uint32_t, uint32_t> deviceIdMaps_;  // (moduleId, deviceId)
    std::mutex deviceMapsMutex_;
    std::map<uint64_t, bool> deviceStates_; // id is deviceid << 32 | chipid;
    std::mutex deviceStateMutex_;
    std::mutex envMutex_;

    void LoadProfApi();

    PTHREAD_ONCE_T profApiLoadFlag_;
    ProfInitFunc profInit_{nullptr};
    ProfStartFunc profStart_{nullptr};
    ProfStopFunc profStop_{nullptr};
    ProfSetConfigFunc profSetConfig_{nullptr};
    ProfRegisterCallbackFunc profRegisterCallback_{nullptr};
    ProfReportDataFunc profReportData_{nullptr};
    ProfReportRegTypeInfoFunc profReportRegTypeInfo_{nullptr};
    ProfReportRegDataFormatFunc profReportRegDataFormat_{nullptr};
    ProfReportGetHashIdFunc profReportGetHashId_{nullptr};
    ProfSetDeviceIdFunc profSetDeviceId_{nullptr};
    ProfSetDeviceIdFunc profUnSetDeviceId_{nullptr};
    ProfNotifySetDeviceFunc profNotifySetDevice_{nullptr};
    ProfFinalizeFunc profFinalize_{nullptr};
    ProfHostFreqIsEnableFunc profHostFreqIsEnable_{nullptr};
    ReportBuffer<MsprofApi> apiBuffer_{MsprofApi{}};
    ReportBuffer<MsprofCompactInfo> compactBuffer_{MsprofCompactInfo{}};
    ReportBuffer<MsprofAdditionalInfo> additionalBuffer_{MsprofAdditionalInfo{}};
    ProfGetImplInfoFunc profGetImplInfo_{nullptr};
    ProfApiBufPopFunc profApiBufPop_{nullptr};
    ProfCompactBufPopFunc profCompactBufPop_{nullptr};
    ProfAdditionalBufPopFunc profAdditionalBufPop_{nullptr};
    ProfReportBufEmptyFunc profReportBufEmpty_{nullptr};
    ProfAdditionalBufPushFunc profAdditionalBufPush_{nullptr};
    ProfMarkExFunc profMarkEx_{nullptr};

    BlockBuffer<MsprofAdditionalInfo> batchAdditionalBuffer_{};
    ProfBatchAddBufPopFunc profBatchAddBufPop_{nullptr};
    ProfBatchAddBufIndexShiftFunc profBatchAddBufIndexShift_{nullptr};
    ProfGetFeatureIsOnFunc profGetFeatureIsOn_{nullptr};
    ProfImplInitMstxInjectionFunc profImplInitMstxInjection_{nullptr};
    ProfSubscribeRawDataFunc profSubscribeRawData_{nullptr};
    ProfUnSubscribeRawDataFunc profUnSubscribeRawData_{nullptr};

    VariableBlockBuffer variableAdditionalBuffer_{};
    ProfVarAddBlockBufPopFunc profVarAddBlockBufPop_{nullptr};
    ProfVarAddBufIndexShiftFunc profVarAddBlockBufIndexShift_{nullptr};
};

bool TryPopApiBuf(uint32_t &aging, MsprofApi& data);
bool TryPopCompactBuf(uint32_t &aging, MsprofCompactInfo& data);
bool TryPopAdditionalBuf(uint32_t &aging, MsprofAdditionalInfo& data);
bool IsReportBufEmpty();
int32_t TryPushAdditionalBuf(uint32_t aging, const VOID_PTR data, uint32_t len);
int32_t TryMarkEx(uint64_t indexId, uint64_t modelId, uint16_t tagId, void *stm);
void *TryPopAdprofBuf(size_t &popSize, bool popForce);
void TryIndexShiftAdprofBuf(void *popPtr, const size_t popSize);

void *TryPopVariableAdditionalBuf(size_t &popSize);
void TryIndexShiftVariableAddBuf(void *popPtr, const size_t popSize);
}
#endif
