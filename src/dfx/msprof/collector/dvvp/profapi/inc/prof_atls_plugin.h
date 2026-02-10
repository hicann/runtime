/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef PROF_ATLS_PLUGIN_H
#define PROF_ATLS_PLUGIN_H
#include <map>
#include "prof_plugin.h"
#include "singleton/singleton.h"
#include "prof_runtime_plugin.h"
namespace ProfAPI {
using ProfCommand = MsprofCommandHandle;
class ProfAtlsPlugin : public ProfPlugin, public analysis::dvvp::common::singleton::Singleton<ProfAtlsPlugin> {
    friend analysis::dvvp::common::singleton::Singleton<ProfAtlsPlugin>;
public:
    int32_t ProfInit(uint32_t type, void *data, uint32_t dataLen) override;
    int32_t ProfStart(uint32_t dataType, const void *data, uint32_t length) override;
    int32_t ProfStop(uint32_t dataType, const void *data, uint32_t length) override;
    int32_t ProfSetConfig(uint32_t configType, const char *config, size_t configLength) override;
    int32_t ProfRegisterCallback(uint32_t moduleId, ProfCommandHandle handle) override;
    int32_t ProfReportData(uint32_t moduleId, uint32_t type, void* data, uint32_t len) override;
    int32_t ProfReportApi(uint32_t agingFlag, const MsprofApi* api) override;
    int32_t ProfReportEvent(uint32_t agingFlag, const MsprofEvent* event) override;
    int32_t ProfReportCompactInfo(uint32_t agingFlag, const VOID_PTR data, uint32_t len) override;
    int32_t ProfReportAdditionalInfo(uint32_t agingFlag, const VOID_PTR data, uint32_t len) override;
    int32_t ProfReportBatchAdditionalInfo(uint32_t agingFlag, const VOID_PTR data, uint32_t len) override;
    size_t ProfGetBatchReportMaxSize(uint32_t type) override;
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

    int32_t ProfRegisterReporter(MsprofReportHandle reporter);
    int32_t ProfRegisterCtrl(MsprofCtrlHandle handle);
    int32_t ProfRegisterDeviceNotify(MsprofSetDeviceHandle handle);
    int32_t ProfSetProfCommand(VOID_PTR command, uint32_t len);
    int32_t ProfGetDeviceIdByGeModelIdx(const uint32_t geModelIdx, uint32_t *deviceId);
    int32_t RegisterProfileCallback(int32_t callbackType, VOID_PTR callback, uint32_t len);
protected:
    ProfAtlsPlugin();
private:
    void ProfNotifyCacheDevice(MsprofSetDeviceHandle handle);
    int32_t RegisterProfileCallbackC(int32_t callbackType, VOID_PTR callback);
private:
    MsprofReportHandle reporter_{nullptr};
    MsprofCtrlHandle profCtrl_{nullptr};
    MsprofSetDeviceHandle profSetDevice_{nullptr};
    MsprofSetDeviceHandle profSetDeviceC_{nullptr};
    ProfReportApiFunc profReportApi_{nullptr};
    ProfReportEventFunc profReportEvent_{nullptr};
    ProfReportCompactInfoFunc profReportCompactInfo_{nullptr};
    ProfReportAdditionalInfoFunc profReportAdditionalInfo_{nullptr};
    ProfReportRegTypeInfoFunc profReportRegTypeInfo_{nullptr};
    ProfReportRegDataFormatFunc profReportRegDataFormat_{nullptr};
    ProfReportGetHashIdFunc profReportGetHashId_{nullptr};
    ProfHostFreqIsEnableFunc profHostFreqIsEnable_{nullptr};
    ProfReportApiCFunc profReportApiC_{nullptr};
    ProfReportEventCFunc profReportEventC_{nullptr};
    ProfReportRegTypeInfoCFunc profReportRegTypeInfoC_{nullptr};
    ProfReportRegDataFormatCFunc profReportRegDataFormatC_{nullptr};
    ProfReportGetHashIdCFunc profReportGetHashIdC_{nullptr};
    ProfHostFreqIsEnableCFunc profHostFreqIsEnableC_{nullptr};
    std::map<uint32_t, uint32_t> deviceIdMaps_;  // (moduleId, deviceId)
    std::mutex atlasDeviceMapsMutex_;
    std::map<uint64_t, bool> deviceStateMaps_;
    std::mutex atlasDeviceStateMutex_;
    ProfCommand command_;
};
}
#endif
